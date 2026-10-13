SECTION "Bank 40", ROMX[$4000], BANK[$40]
    db $40

; E-0018 (C2 for the fields, C0 for the meaning of the second byte and of the streams). Sound ids
; 0-27.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified);
; track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank40::
    db $00 ; id 0: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $20 ; id 1: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 2: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 3: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 4: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $a0 ; id 5: channel-state slot offset (added to $DC00)
    db $03 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 6: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_06 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 7: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_07 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 8: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_08 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 9: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_09 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 10: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0A ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 11: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0B ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 12: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0C ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 13: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0D ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 14: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0E ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 15: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_0F ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 16: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_10 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 17: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_11 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $a0 ; id 18: channel-state slot offset (added to $DC00)
    db $03 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_12 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 19: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_13 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 20: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_14 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 21: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_15 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 22: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_16 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 23: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_17 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 24: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_18 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 25: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_19 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 26: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_1A ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 27: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_40_1B ; track stream (stored at slot +3/+4, with this bank at +5)

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_00::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 316 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_06::
    db $06, $00, $0d, $00 ; header: param=6 byte1=$00 volume=$0D byte3=$00
    db $af, $04 ; param $04
    db $a0, $0c ; volume $0C
    db $a2, $00 ; duty2 $00
    db $a3, $1b ; mod $1B
    db $a3, $fe ; mod $FE
    db $c1, $35 ; env $35
    db $2a, $12 ; note A#2 dur 18
    db $2a, $06 ; note A#2 dur 6
    db $c1, $5f ; env $5F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $35, $18 ; note F3 dur 24
    db $35, $18 ; note F3 dur 24
    db $c0, $ff ; env $FF
    db $35, $18 ; note F3 dur 24
    db $c1, $60 ; env $60
    db $35, $18 ; note F3 dur 24
    db $c0, $fe ; env $FE
    db $35, $18 ; note F3 dur 24
    db $c1, $60 ; env $60
    db $35, $18 ; note F3 dur 24
    db $c0, $fe ; env $FE
    db $2a, $1e ; note A#2 dur 30
    db $a0, $07 ; volume $07
    db $c1, $7f ; env $7F
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0c ; volume $0C
    db $c1, $20 ; env $20
    db $29, $0c ; note A2 dur 12
    db $a0, $05 ; volume $05
    db $29, $0c ; note A2 dur 12
    db $a0, $0c ; volume $0C
    db $c1, $30 ; env $30
    db $28, $0c ; note G#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $c1, $4a ; env $4A
    db $29, $18 ; note A2 dur 24
    db $c0, $fe ; env $FE
    db $25, $24 ; note F2 dur 36
    db $a0, $05 ; volume $05
    db $c1, $50 ; env $50
    db $25, $0c ; note F2 dur 12
    db $a0, $0c ; volume $0C
    db $c1, $40 ; env $40
    db $20, $12 ; note C2 dur 18
    db $20, $06 ; note C2 dur 6
    db $c1, $5f ; env $5F
    db $21, $18 ; note C#2 dur 24
    db $c1, $60 ; env $60
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $24, $18 ; note E2 dur 24
    db $c0, $fe ; env $FE
    db $25, $30 ; note F2 dur 48
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $25, $0c ; note F2 dur 12
    db $a0, $0c ; volume $0C
    db $c1, $30 ; env $30
    db $25, $0c ; note F2 dur 12
    db $27, $0c ; note G2 dur 12
    db $29, $0c ; note A2 dur 12
    db $c0, $fe ; env $FE
    db $32, $30 ; note D3 dur 48
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $32, $0c ; note D3 dur 12
    db $a0, $0c ; volume $0C
    db $c1, $30 ; env $30
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $c1, $4a ; env $4A
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $a2, $00 ; duty2 $00
    db $a3, $06 ; mod $06
    db $c3, $30 ; env $30
    db $31, $18 ; note C#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $31, $24 ; note C#3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $31, $0c ; note C#3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $c4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $29, $18 ; note A2 dur 24
    db $29, $18 ; note A2 dur 24
    db $c3, $30 ; env $30
    db $32, $18 ; note D3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $32, $24 ; note D3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $c0, $fe ; env $FE
    db $2a, $30 ; note A#2 dur 48
    db $a0, $06 ; volume $06
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $2a, $18 ; note A#2 dur 24
    db $a0, $0c ; volume $0C
    db $c4, $30 ; env $30
    db $a3, $06 ; mod $06
    db $2a, $18 ; note A#2 dur 24
    db $c3, $30 ; env $30
    db $36, $18 ; note F#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $36, $24 ; note F#3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $36, $0c ; note F#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $c3, $30 ; env $30
    db $3a, $18 ; note A#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $3a, $24 ; note A#3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $c4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $34, $30 ; note E3 dur 48
    db $29, $48 ; note A2 dur 72
    db $a0, $0c ; volume $0C
    db $a3, $fe ; mod $FE
    db $c1, $35 ; env $35
    db $2a, $12 ; note A#2 dur 18
    db $2a, $06 ; note A#2 dur 6
    db $c1, $5f ; env $5F
    db $a0, $0b ; volume $0B
    db $29, $18 ; note A2 dur 24
    db $a0, $0c ; volume $0C
    db $30, $18 ; note C3 dur 24
    db $30, $18 ; note C3 dur 24
    db $35, $18 ; note F3 dur 24
    db $35, $18 ; note F3 dur 24
    db $39, $18 ; note A3 dur 24
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $c0, $ff ; env $FF
    db $28, $18 ; note G#2 dur 24
    db $c1, $60 ; env $60
    db $28, $18 ; note G#2 dur 24
    db $c1, $4a ; env $4A
    db $29, $18 ; note A2 dur 24
    db $c0, $ff ; env $FF
    db $25, $18 ; note F2 dur 24
    db $c1, $60 ; env $60
    db $25, $18 ; note F2 dur 24
    db $c1, $5f ; env $5F
    db $20, $12 ; note C2 dur 18
    db $20, $06 ; note C2 dur 6
    db $c1, $60 ; env $60
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $24, $18 ; note E2 dur 24
    db $c0, $fe ; env $FE
    db $25, $30 ; note F2 dur 48
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $25, $0c ; note F2 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $25, $0c ; note F2 dur 12
    db $27, $0c ; note G2 dur 12
    db $29, $0c ; note A2 dur 12
    db $c0, $fe ; env $FE
    db $2b, $30 ; note B2 dur 48
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $2b, $0c ; note B2 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $c1, $5f ; env $5F
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $a2, $00 ; duty2 $00
    db $a3, $06 ; mod $06
    db $c3, $30 ; env $30
    db $31, $18 ; note C#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $31, $24 ; note C#3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $31, $0c ; note C#3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $c4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $29, $18 ; note A2 dur 24
    db $32, $18 ; note D3 dur 24
    db $c4, $40 ; env $40
    db $27, $18 ; note G2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $32, $18 ; note D3 dur 24
    db $2b, $18 ; note B2 dur 24
    db $c0, $fe ; env $FE
    db $2a, $30 ; note A#2 dur 48
    db $a0, $06 ; volume $06
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $2a, $18 ; note A#2 dur 24
    db $a0, $0c ; volume $0C
    db $a3, $06 ; mod $06
    db $c4, $68 ; env $68
    db $2a, $18 ; note A#2 dur 24
    db $36, $18 ; note F#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $c3, $20 ; env $20
    db $29, $0c ; note A2 dur 12
    db $36, $0c ; note F#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $c3, $30 ; env $30
    db $3a, $18 ; note A#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $3a, $24 ; note A#3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $c4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $34, $30 ; note E3 dur 48
    db $29, $4f ; note A2 dur 79
    db $1f, $02 ; rest-note $1F dur 2
    db $af, $07 ; param $07
    db $a0, $0a ; volume $0A
    db $1f, $19 ; rest-note $1F dur 25
    db $36, $0c ; note F#3 dur 12
    db $29, $0c ; note A2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $30 ; note D3 dur 48
    db $c3, $30 ; env $30
    db $2a, $31 ; note A#2 dur 49
    db $a3, $00 ; mod $00
    db $c1, $20 ; env $20
    db $2a, $19 ; note A#2 dur 25
    db $a0, $0f ; volume $0F
    db $a3, $06 ; mod $06
    db $c4, $2f ; env $2F
    db $25, $1a ; note F2 dur 26
    db $c4, $30 ; env $30
    db $27, $1a ; note G2 dur 26
    db $c4, $34 ; env $34
    db $30, $1b ; note C3 dur 27
    db $c1, $30 ; env $30
    db $32, $0c ; note D3 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $1a, $0c ; note A#1 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $22, $0c ; note D2 dur 12
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $25, $0c ; note F2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $20, $0c ; note C2 dur 12
    db $20, $0c ; note C2 dur 12
    db $24, $0c ; note E2 dur 12
    db $24, $0d ; note E2 dur 13
    db $27, $0d ; note G2 dur 13
    db $27, $0d ; note G2 dur 13
    db $2a, $0d ; note A#2 dur 13
    db $29, $0e ; note A2 dur 14
    db $19, $0d ; note A1 dur 13
    db $19, $0d ; note A1 dur 13
    db $20, $0d ; note C2 dur 13
    db $20, $0e ; note C2 dur 14
    db $25, $0e ; note F2 dur 14
    db $25, $0e ; note F2 dur 14
    db $29, $0f ; note A2 dur 15
    db $c1, $7f ; env $7F
    db $19, $21 ; note A1 dur 33
    db $a7, $03 ; wait $03
    db $c1, $30 ; env $30
    db $19, $03 ; note A1 dur 3
    db $1a, $03 ; note A#1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $c1, $7f ; env $7F
    db $29, $19 ; note A2 dur 25
    db $1f, $18 ; rest-note $1F dur 24
    db $1f, $5a ; rest-note $1F dur 90
    db $ff, $ff ; end

; sound track, 329 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_07::
    db $06, $00, $0f, $00 ; header: param=6 byte1=$00 volume=$0F byte3=$00
    db $af, $04 ; param $04
    db $a0, $0d ; volume $0D
    db $a2, $00 ; duty2 $00
    db $a3, $1b ; mod $1B
    db $c1, $35 ; env $35
    db $30, $12 ; note C3 dur 18
    db $30, $06 ; note C3 dur 6
    db $c1, $5f ; env $5F
    db $a0, $0c ; volume $0C
    db $35, $18 ; note F3 dur 24
    db $37, $18 ; note G3 dur 24
    db $a0, $0d ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $3a, $18 ; note A#3 dur 24
    db $c2, $7f ; env $7F
    db $40, $18 ; note C4 dur 24
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $45, $24 ; note F4 dur 36
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $45, $0c ; note F4 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $35 ; env $35
    db $44, $12 ; note E4 dur 18
    db $c1, $2f ; env $2F
    db $42, $06 ; note D4 dur 6
    db $c0, $fe ; env $FE
    db $42, $1e ; note D4 dur 30
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $42, $06 ; note D4 dur 6
    db $a0, $0d ; volume $0D
    db $a3, $09 ; mod $09
    db $c1, $20 ; env $20
    db $40, $0c ; note C4 dur 12
    db $a0, $05 ; volume $05
    db $40, $0c ; note C4 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $3b, $0c ; note B3 dur 12
    db $3b, $0c ; note B3 dur 12
    db $42, $0c ; note D4 dur 12
    db $c1, $4a ; env $4A
    db $a3, $0c ; mod $0C
    db $40, $18 ; note C4 dur 24
    db $c0, $fe ; env $FE
    db $39, $24 ; note A3 dur 36
    db $a0, $05 ; volume $05
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $39, $0c ; note A3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $40 ; env $40
    db $a3, $09 ; mod $09
    db $29, $12 ; note A2 dur 18
    db $c1, $2f ; env $2F
    db $29, $06 ; note A2 dur 6
    db $c1, $5f ; env $5F
    db $29, $18 ; note A2 dur 24
    db $c1, $60 ; env $60
    db $29, $18 ; note A2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $c0, $fe ; env $FE
    db $a3, $0c ; mod $0C
    db $32, $30 ; note D3 dur 48
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $32, $0c ; note D3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c0, $fe ; env $FE
    db $37, $30 ; note G3 dur 48
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $37, $0c ; note G3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a3, $08 ; mod $08
    db $c1, $4a ; env $4A
    db $35, $18 ; note F3 dur 24
    db $34, $18 ; note E3 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $a2, $00 ; duty2 $00
    db $a3, $06 ; mod $06
    db $c3, $30 ; env $30
    db $39, $18 ; note A3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $39, $24 ; note A3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $3a, $0c ; note A#3 dur 12
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $c3, $30 ; env $30
    db $37, $18 ; note G3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $37, $24 ; note G3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $a0, $09 ; volume $09
    db $c4, $7f ; env $7F
    db $34, $18 ; note E3 dur 24
    db $a0, $0d ; volume $0D
    db $c4, $48 ; env $48
    db $30, $18 ; note C3 dur 24
    db $c3, $30 ; env $30
    db $40, $18 ; note C4 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $40, $24 ; note C4 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $c3, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $42, $24 ; note D4 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c4, $68 ; env $68
    db $3a, $30 ; note A#3 dur 48
    db $39, $30 ; note A3 dur 48
    db $35, $48 ; note F3 dur 72
    db $a3, $fe ; mod $FE
    db $a0, $0d ; volume $0D
    db $c1, $35 ; env $35
    db $30, $12 ; note C3 dur 18
    db $30, $06 ; note C3 dur 6
    db $c1, $5f ; env $5F
    db $a0, $0c ; volume $0C
    db $35, $18 ; note F3 dur 24
    db $a0, $0d ; volume $0D
    db $37, $18 ; note G3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3a, $18 ; note A#3 dur 24
    db $c2, $7f ; env $7F
    db $40, $18 ; note C4 dur 24
    db $c0, $fe ; env $FE
    db $45, $24 ; note F4 dur 36
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $45, $0c ; note F4 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $40 ; env $40
    db $44, $12 ; note E4 dur 18
    db $c1, $2f ; env $2F
    db $42, $06 ; note D4 dur 6
    db $c0, $fe ; env $FE
    db $42, $1e ; note D4 dur 30
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $42, $06 ; note D4 dur 6
    db $a0, $0d ; volume $0D
    db $c1, $20 ; env $20
    db $40, $0c ; note C4 dur 12
    db $a0, $05 ; volume $05
    db $40, $0c ; note C4 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $3b, $0c ; note B3 dur 12
    db $3b, $0c ; note B3 dur 12
    db $42, $0c ; note D4 dur 12
    db $c1, $4a ; env $4A
    db $40, $18 ; note C4 dur 24
    db $c0, $fe ; env $FE
    db $39, $24 ; note A3 dur 36
    db $a0, $05 ; volume $05
    db $c1, $50 ; env $50
    db $39, $0c ; note A3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $40 ; env $40
    db $29, $12 ; note A2 dur 18
    db $c1, $2f ; env $2F
    db $29, $06 ; note A2 dur 6
    db $c1, $5f ; env $5F
    db $29, $18 ; note A2 dur 24
    db $c1, $60 ; env $60
    db $29, $18 ; note A2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $c0, $fe ; env $FE
    db $32, $30 ; note D3 dur 48
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $32, $0c ; note D3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c0, $fe ; env $FE
    db $37, $30 ; note G3 dur 48
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $37, $0c ; note G3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c1, $4a ; env $4A
    db $35, $18 ; note F3 dur 24
    db $34, $18 ; note E3 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $a2, $00 ; duty2 $00
    db $a3, $06 ; mod $06
    db $c3, $30 ; env $30
    db $39, $18 ; note A3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $39, $24 ; note A3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $3a, $0c ; note A#3 dur 12
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $c3, $30 ; env $30
    db $37, $18 ; note G3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $37, $24 ; note G3 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $a0, $0b ; volume $0B
    db $c4, $7f ; env $7F
    db $34, $18 ; note E3 dur 24
    db $a0, $0d ; volume $0D
    db $c4, $48 ; env $48
    db $30, $18 ; note C3 dur 24
    db $c3, $30 ; env $30
    db $40, $18 ; note C4 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $40, $24 ; note C4 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $c3, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $a3, $00 ; mod $00
    db $c1, $70 ; env $70
    db $42, $24 ; note D4 dur 36
    db $a3, $06 ; mod $06
    db $c3, $20 ; env $20
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c4, $68 ; env $68
    db $3a, $30 ; note A#3 dur 48
    db $39, $30 ; note A3 dur 48
    db $35, $4f ; note F3 dur 79
    db $1f, $02 ; rest-note $1F dur 2
    db $af, $07 ; param $07
    db $a0, $0a ; volume $0A
    db $c4, $78 ; env $78
    db $30, $19 ; note C3 dur 25
    db $40, $0c ; note C4 dur 12
    db $36, $0c ; note F#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $c3, $30 ; env $30
    db $42, $32 ; note D4 dur 50
    db $a3, $00 ; mod $00
    db $c1, $20 ; env $20
    db $42, $18 ; note D4 dur 24
    db $a0, $0d ; volume $0D
    db $a3, $04 ; mod $04
    db $c4, $3c ; env $3C
    db $32, $1a ; note D3 dur 26
    db $34, $1a ; note E3 dur 26
    db $35, $1b ; note F3 dur 27
    db $a3, $06 ; mod $06
    db $c3, $30 ; env $30
    db $3a, $30 ; note A#3 dur 48
    db $c1, $78 ; env $78
    db $a3, $00 ; mod $00
    db $3a, $30 ; note A#3 dur 48
    db $c4, $78 ; env $78
    db $a3, $06 ; mod $06
    db $39, $30 ; note A3 dur 48
    db $39, $34 ; note A3 dur 52
    db $c3, $30 ; env $30
    db $35, $a7 ; note F3 dur 167
    db $c1, $80 ; env $80
    db $35, $31 ; note F3 dur 49
    db $1f, $5a ; rest-note $1F dur 90
    db $ff, $ff ; end

; sound track, 328 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_08::
    db $06, $0f, $06, $03 ; header: param=6 byte1=$0F volume=$06 byte3=$03
    db $af, $04 ; param $04
    db $a2, $48 ; duty2 $48
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a3, $1f ; mod $1F
    db $1f, $18 ; rest-note $1F dur 24
    db $25, $18 ; note F2 dur 24
    db $24, $18 ; note E2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $a2, $ff ; duty2 $FF
    db $19, $24 ; note A1 dur 36
    db $a0, $04 ; volume $04
    db $19, $0c ; note A1 dur 12
    db $a0, $02 ; volume $02
    db $1a, $24 ; note A#1 dur 36
    db $a0, $04 ; volume $04
    db $1a, $0c ; note A#1 dur 12
    db $a0, $02 ; volume $02
    db $a2, $48 ; duty2 $48
    db $25, $18 ; note F2 dur 24
    db $20, $18 ; note C2 dur 24
    db $15, $18 ; note F1 dur 24
    db $25, $18 ; note F2 dur 24
    db $15, $18 ; note F1 dur 24
    db $19, $18 ; note A1 dur 24
    db $20, $18 ; note C2 dur 24
    db $25, $18 ; note F2 dur 24
    db $a2, $ff ; duty2 $FF
    db $19, $24 ; note A1 dur 36
    db $a0, $04 ; volume $04
    db $19, $0c ; note A1 dur 12
    db $a0, $02 ; volume $02
    db $19, $24 ; note A1 dur 36
    db $a0, $04 ; volume $04
    db $19, $0c ; note A1 dur 12
    db $a0, $02 ; volume $02
    db $a2, $48 ; duty2 $48
    db $22, $18 ; note D2 dur 24
    db $19, $18 ; note A1 dur 24
    db $15, $18 ; note F1 dur 24
    db $12, $18 ; note D1 dur 24
    db $1b, $18 ; note B1 dur 24
    db $22, $18 ; note D2 dur 24
    db $27, $18 ; note G2 dur 24
    db $17, $18 ; note G1 dur 24
    db $a2, $ff ; duty2 $FF
    db $20, $24 ; note C2 dur 36
    db $a0, $04 ; volume $04
    db $20, $0c ; note C2 dur 12
    db $a0, $02 ; volume $02
    db $a2, $48 ; duty2 $48
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
    db $1b, $18 ; note B1 dur 24
    db $22, $18 ; note D2 dur 24
    db $27, $18 ; note G2 dur 24
    db $17, $18 ; note G1 dur 24
    db $20, $18 ; note C2 dur 24
    db $20, $18 ; note C2 dur 24
    db $27, $18 ; note G2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $12, $18 ; note D1 dur 24
    db $17, $18 ; note G1 dur 24
    db $19, $18 ; note A1 dur 24
    db $1a, $18 ; note A#1 dur 24
    db $17, $18 ; note G1 dur 24
    db $27, $18 ; note G2 dur 24
    db $20, $18 ; note C2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $20, $18 ; note C2 dur 24
    db $25, $18 ; note F2 dur 24
    db $20, $18 ; note C2 dur 24
    db $15, $18 ; note F1 dur 24
    db $a2, $12 ; duty2 $12
    db $1f, $18 ; rest-note $1F dur 24
    db $fd, $f0 ; label 0
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $b2, $f0 ; repeat $F0
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
    db $1a, $08 ; note A#1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $fd, $f0 ; label 0
    db $15, $08 ; note F1 dur 8
    db $14, $08 ; note E1 dur 8
    db $b5, $f0 ; repeat $F0
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $1b, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $20, $08 ; note C2 dur 8
    db $19, $08 ; note A1 dur 8
    db $fd, $f0 ; label 0
    db $19, $08 ; note A1 dur 8
    db $17, $08 ; note G1 dur 8
    db $b5, $f0 ; repeat $F0
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
    db $1b, $08 ; note B1 dur 8
    db $1b, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $25, $08 ; note F2 dur 8
    db $27, $08 ; note G2 dur 8
    db $22, $08 ; note D2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $17, $08 ; note G1 dur 8
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1a, $08 ; note A#1 dur 8
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
    db $1b, $08 ; note B1 dur 8
    db $17, $08 ; note G1 dur 8
    db $1b, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $27, $08 ; note G2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $25, $08 ; note F2 dur 8
    db $22, $08 ; note D2 dur 8
    db $17, $08 ; note G1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
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
    db $1a, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $a2, $70 ; duty2 $70
    db $27, $18 ; note G2 dur 24
    db $20, $18 ; note C2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $20, $18 ; note C2 dur 24
    db $a2, $08 ; duty2 $08
    db $25, $08 ; note F2 dur 8
    db $a2, $10 ; duty2 $10
    db $25, $08 ; note F2 dur 8
    db $20, $08 ; note C2 dur 8
    db $15, $08 ; note F1 dur 8
    db $19, $08 ; note A1 dur 8
    db $20, $08 ; note C2 dur 8
    db $a2, $70 ; duty2 $70
    db $25, $0c ; note F2 dur 12
    db $a0, $06 ; volume $06
    db $25, $13 ; note F2 dur 19
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $02 ; volume $02
    db $a1, $03 ; duty $03
    db $af, $07 ; param $07
    db $1f, $19 ; rest-note $1F dur 25
    db $a2, $a0 ; duty2 $A0
    db $a0, $04 ; volume $04
    db $32, $30 ; note D3 dur 48
    db $37, $18 ; note G3 dur 24
    db $35, $18 ; note F3 dur 24
    db $a2, $70 ; duty2 $70
    db $34, $4a ; note E3 dur 74
    db $a0, $02 ; volume $02
    db $a2, $5f ; duty2 $5F
    db $a1, $0a ; duty $0A
    db $1a, $1a ; note A#1 dur 26
    db $1a, $1a ; note A#1 dur 26
    db $19, $1b ; note A1 dur 27
    db $a2, $50 ; duty2 $50
    db $17, $0c ; note G1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $24 ; duty2 $24
    db $27, $0c ; note G2 dur 12
    db $27, $0c ; note G2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a2, $38 ; duty2 $38
    db $a1, $0b ; duty $0B
    db $17, $0c ; note G1 dur 12
    db $a2, $40 ; duty2 $40
    db $20, $0c ; note C2 dur 12
    db $a1, $03 ; duty $03
    db $a2, $24 ; duty2 $24
    db $24, $0c ; note E2 dur 12
    db $24, $0c ; note E2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $2a, $0d ; note A#2 dur 13
    db $34, $0d ; note E3 dur 13
    db $34, $0d ; note E3 dur 13
    db $a2, $38 ; duty2 $38
    db $a1, $0b ; duty $0B
    db $20, $0d ; note C2 dur 13
    db $a2, $40 ; duty2 $40
    db $15, $0e ; note F1 dur 14
    db $a1, $03 ; duty $03
    db $a2, $24 ; duty2 $24
    db $25, $0d ; note F2 dur 13
    db $25, $0d ; note F2 dur 13
    db $29, $0d ; note A2 dur 13
    db $29, $0e ; note A2 dur 14
    db $30, $0e ; note C3 dur 14
    db $30, $0e ; note C3 dur 14
    db $a1, $0b ; duty $0B
    db $a2, $40 ; duty2 $40
    db $15, $0f ; note F1 dur 15
    db $a1, $03 ; duty $03
    db $a2, $ff ; duty2 $FF
    db $15, $21 ; note F1 dur 33
    db $a0, $04 ; volume $04
    db $15, $03 ; note F1 dur 3
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2a, $03 ; note A#2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $35, $19 ; note F3 dur 25
    db $1f, $18 ; rest-note $1F dur 24
    db $1f, $5a ; rest-note $1F dur 90
    db $ff, $ff ; end

; sound track, 234 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_09::
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $c2, $06 ; env $06
    db $1f, $30 ; rest-note $1F dur 48
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $0c ; volume $0C
    db $32, $0c ; note D3 dur 12
    db $a0, $0d ; volume $0D
    db $32, $0c ; note D3 dur 12
    db $a0, $0b ; volume $0B
    db $29, $0c ; note A2 dur 12
    db $a0, $09 ; volume $09
    db $26, $0c ; note F#2 dur 12
    db $22, $18 ; note D2 dur 24
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $0c ; volume $0C
    db $31, $0c ; note C#3 dur 12
    db $a0, $0d ; volume $0D
    db $31, $0c ; note C#3 dur 12
    db $a0, $0b ; volume $0B
    db $29, $0c ; note A2 dur 12
    db $a0, $09 ; volume $09
    db $26, $0c ; note F#2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $a0, $0f ; volume $0F
    db $22, $0c ; note D2 dur 12
    db $a0, $07 ; volume $07
    db $26, $0c ; note F#2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $17, $0c ; note G1 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $0a ; volume $0A
    db $22, $0c ; note D2 dur 12
    db $27, $0c ; note G2 dur 12
    db $22, $0c ; note D2 dur 12
    db $a0, $0c ; volume $0C
    db $27, $0c ; note G2 dur 12
    db $a0, $0d ; volume $0D
    db $2b, $0c ; note B2 dur 12
    db $a0, $0f ; volume $0F
    db $32, $0c ; note D3 dur 12
    db $ca, $12 ; env $12
    db $31, $06 ; note C#3 dur 6
    db $c1, $1f ; env $1F
    db $a0, $04 ; volume $04
    db $31, $36 ; note C#3 dur 54
    db $a0, $09 ; volume $09
    db $c2, $06 ; env $06
    db $1b, $0c ; note B1 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $0c ; volume $0C
    db $27, $0c ; note G2 dur 12
    db $a0, $0d ; volume $0D
    db $2b, $0c ; note B2 dur 12
    db $a0, $0b ; volume $0B
    db $27, $0c ; note G2 dur 12
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $27, $18 ; note G2 dur 24
    db $1b, $0c ; note B1 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $0c ; volume $0C
    db $27, $0c ; note G2 dur 12
    db $a0, $0d ; volume $0D
    db $2b, $0c ; note B2 dur 12
    db $a0, $0b ; volume $0B
    db $27, $0c ; note G2 dur 12
    db $a0, $09 ; volume $09
    db $23, $0c ; note D#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $22, $0c ; note D2 dur 12
    db $a0, $0f ; volume $0F
    db $1b, $0c ; note B1 dur 12
    db $a0, $07 ; volume $07
    db $22, $0c ; note D2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $0a ; volume $0A
    db $21, $0c ; note C#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $07 ; volume $07
    db $22, $0c ; note D2 dur 12
    db $a0, $0a ; volume $0A
    db $26, $0c ; note F#2 dur 12
    db $a0, $0c ; volume $0C
    db $26, $0c ; note F#2 dur 12
    db $a0, $0e ; volume $0E
    db $29, $0c ; note A2 dur 12
    db $a0, $0f ; volume $0F
    db $30, $0c ; note C3 dur 12
    db $a0, $09 ; volume $09
    db $29, $0c ; note A2 dur 12
    db $a0, $07 ; volume $07
    db $26, $0c ; note F#2 dur 12
    db $20, $0c ; note C2 dur 12
    db $af, $01 ; param $01
    db $a2, $01 ; duty2 $01
    db $a0, $0c ; volume $0C
    db $a1, $00 ; duty $00
    db $c2, $06 ; env $06
    db $17, $0c ; note G1 dur 12
    db $a0, $0f ; volume $0F
    db $26, $0c ; note F#2 dur 12
    db $a0, $08 ; volume $08
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a0, $07 ; volume $07
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a0, $0f ; volume $0F
    db $29, $0c ; note A2 dur 12
    db $a0, $07 ; volume $07
    db $26, $0c ; note F#2 dur 12
    db $a0, $0f ; volume $0F
    db $24, $0c ; note E2 dur 12
    db $a0, $07 ; volume $07
    db $23, $0c ; note D#2 dur 12
    db $a0, $0f ; volume $0F
    db $23, $0c ; note D#2 dur 12
    db $a0, $07 ; volume $07
    db $26, $0c ; note F#2 dur 12
    db $a0, $0f ; volume $0F
    db $29, $0c ; note A2 dur 12
    db $a0, $0c ; volume $0C
    db $24, $0c ; note E2 dur 12
    db $a0, $0f ; volume $0F
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $36, $0c ; note F#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a0, $07 ; volume $07
    db $34, $0c ; note E3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $0f ; volume $0F
    db $29, $0c ; note A2 dur 12
    db $a0, $07 ; volume $07
    db $28, $0c ; note G#2 dur 12
    db $a0, $0f ; volume $0F
    db $ca, $08 ; env $08
    db $24, $18 ; note E2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $ca, $12 ; env $12
    db $a0, $0e ; volume $0E
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $c1, $2f ; env $2F
    db $34, $1e ; note E3 dur 30
    db $c2, $06 ; env $06
    db $a0, $0c ; volume $0C
    db $36, $0c ; note F#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $0b ; volume $0B
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $0a ; volume $0A
    db $29, $0c ; note A2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $26, $0c ; note F#2 dur 12
    db $24, $0c ; note E2 dur 12
    db $22, $0c ; note D2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $fd, $f0 ; label 0
    db $a0, $0c ; volume $0C
    db $1f, $0c ; rest-note $1F dur 12
    db $ca, $0f ; env $0F
    db $26, $18 ; note F#2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $ca, $0f ; env $0F
    db $29, $18 ; note A2 dur 24
    db $c2, $08 ; env $08
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $22, $0c ; note D2 dur 12
    db $cb, $0b ; env $0B
    db $a0, $0a ; volume $0A
    db $27, $0c ; note G2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a0, $03 ; volume $03
    db $27, $0c ; note G2 dur 12
    db $a0, $0c ; volume $0C
    db $cb, $0b ; env $0B
    db $26, $18 ; note F#2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $ca, $0f ; env $0F
    db $a0, $0e ; volume $0E
    db $29, $18 ; note A2 dur 24
    db $c2, $08 ; env $08
    db $a0, $0c ; volume $0C
    db $24, $0c ; note E2 dur 12
    db $24, $0c ; note E2 dur 12
    db $2a, $18 ; note A#2 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $ca, $12 ; env $12
    db $a0, $0e ; volume $0E
    db $26, $06 ; note F#2 dur 6
    db $a0, $04 ; volume $04
    db $c1, $2f ; env $2F
    db $26, $12 ; note F#2 dur 18
    db $c2, $06 ; env $06
    db $a0, $0c ; volume $0C
    db $18, $0c ; note G#1 dur 12
    db $24, $0c ; note E2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $cb, $0b ; env $0B
    db $2b, $18 ; note B2 dur 24
    db $a0, $0f ; volume $0F
    db $c2, $06 ; env $06
    db $27, $0c ; note G2 dur 12
    db $a0, $09 ; volume $09
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $08 ; volume $08
    db $21, $0c ; note C#2 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 235 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0A::
    db $01, $01, $0e, $00 ; header: param=1 byte1=$01 volume=$0E byte3=$00
    db $fd, $f3 ; label 3
    db $a0, $0e ; volume $0E
    db $a3, $05 ; mod $05
    db $ca, $0f ; env $0F
    db $36, $18 ; note F#3 dur 24
    db $37, $0c ; note G3 dur 12
    db $ca, $12 ; env $12
    db $a0, $0f ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $c1, $2f ; env $2F
    db $a0, $04 ; volume $04
    db $39, $36 ; note A3 dur 54
    db $a0, $0e ; volume $0E
    db $c2, $08 ; env $08
    db $36, $0c ; note F#3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $ca, $12 ; env $12
    db $a0, $0f ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $c1, $2f ; env $2F
    db $a0, $04 ; volume $04
    db $39, $36 ; note A3 dur 54
    db $ca, $0f ; env $0F
    db $a0, $0e ; volume $0E
    db $36, $18 ; note F#3 dur 24
    db $ca, $10 ; env $10
    db $37, $18 ; note G3 dur 24
    db $ca, $0a ; env $0A
    db $a0, $0f ; volume $0F
    db $39, $0c ; note A3 dur 12
    db $c2, $08 ; env $08
    db $a0, $0a ; volume $0A
    db $36, $0c ; note F#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $cb, $0b ; env $0B
    db $2b, $18 ; note B2 dur 24
    db $ca, $12 ; env $12
    db $34, $06 ; note E3 dur 6
    db $c1, $2c ; env $2C
    db $a0, $03 ; volume $03
    db $34, $36 ; note E3 dur 54
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $0e ; volume $0E
    db $ca, $0f ; env $0F
    db $37, $18 ; note G3 dur 24
    db $39, $0c ; note A3 dur 12
    db $ca, $12 ; env $12
    db $a0, $0f ; volume $0F
    db $3b, $06 ; note B3 dur 6
    db $c1, $2f ; env $2F
    db $a0, $04 ; volume $04
    db $3b, $36 ; note B3 dur 54
    db $a0, $0e ; volume $0E
    db $c2, $08 ; env $08
    db $37, $0c ; note G3 dur 12
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $ca, $12 ; env $12
    db $a0, $0f ; volume $0F
    db $3b, $06 ; note B3 dur 6
    db $c1, $2f ; env $2F
    db $a0, $04 ; volume $04
    db $3b, $36 ; note B3 dur 54
    db $a0, $0d ; volume $0D
    db $c2, $08 ; env $08
    db $ca, $0f ; env $0F
    db $37, $18 ; note G3 dur 24
    db $ca, $10 ; env $10
    db $a0, $0c ; volume $0C
    db $39, $18 ; note A3 dur 24
    db $c2, $08 ; env $08
    db $a0, $0f ; volume $0F
    db $3b, $0c ; note B3 dur 12
    db $a0, $09 ; volume $09
    db $41, $0c ; note C#4 dur 12
    db $42, $0c ; note D4 dur 12
    db $a0, $0b ; volume $0B
    db $41, $0c ; note C#4 dur 12
    db $3b, $0c ; note B3 dur 12
    db $a0, $0d ; volume $0D
    db $39, $0c ; note A3 dur 12
    db $3b, $0c ; note B3 dur 12
    db $ca, $12 ; env $12
    db $36, $06 ; note F#3 dur 6
    db $c1, $2c ; env $2C
    db $a0, $03 ; volume $03
    db $36, $36 ; note F#3 dur 54
    db $c2, $08 ; env $08
    db $a0, $0f ; volume $0F
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $36, $0c ; note F#3 dur 12
    db $af, $01 ; param $01
    db $a2, $01 ; duty2 $01
    db $a0, $0f ; volume $0F
    db $a1, $00 ; duty $00
    db $c2, $08 ; env $08
    db $1f, $0c ; rest-note $1F dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $0a ; volume $0A
    db $36, $0c ; note F#3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $08 ; volume $08
    db $36, $0c ; note F#3 dur 12
    db $a0, $0a ; volume $0A
    db $36, $0c ; note F#3 dur 12
    db $a0, $09 ; volume $09
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $0a ; volume $0A
    db $2b, $0c ; note B2 dur 12
    db $a0, $0e ; volume $0E
    db $31, $0c ; note C#3 dur 12
    db $a0, $08 ; volume $08
    db $29, $0c ; note A2 dur 12
    db $a0, $0f ; volume $0F
    db $2b, $18 ; note B2 dur 24
    db $ca, $0a ; env $0A
    db $26, $18 ; note F#2 dur 24
    db $ca, $0f ; env $0F
    db $a0, $0e ; volume $0E
    db $2b, $18 ; note B2 dur 24
    db $a0, $0f ; volume $0F
    db $c2, $08 ; env $08
    db $37, $0c ; note G3 dur 12
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a0, $08 ; volume $08
    db $37, $0c ; note G3 dur 12
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $a0, $09 ; volume $09
    db $36, $0c ; note F#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a0, $0a ; volume $0A
    db $32, $0c ; note D3 dur 12
    db $a0, $0f ; volume $0F
    db $31, $0c ; note C#3 dur 12
    db $a0, $0a ; volume $0A
    db $2b, $0c ; note B2 dur 12
    db $a0, $0e ; volume $0E
    db $ca, $0a ; env $0A
    db $29, $0c ; note A2 dur 12
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $ca, $0d ; env $0D
    db $29, $18 ; note A2 dur 24
    db $a0, $0c ; volume $0C
    db $29, $18 ; note A2 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $0f ; volume $0F
    db $ca, $12 ; env $12
    db $39, $06 ; note A3 dur 6
    db $a0, $04 ; volume $04
    db $c1, $2f ; env $2F
    db $39, $1e ; note A3 dur 30
    db $a0, $0f ; volume $0F
    db $c2, $08 ; env $08
    db $39, $0c ; note A3 dur 12
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $0c ; volume $0C
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $0b ; volume $0B
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $09 ; volume $09
    db $29, $0c ; note A2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $26, $0c ; note F#2 dur 12
    db $24, $0c ; note E2 dur 12
    db $c2, $06 ; env $06
    db $fd, $f0 ; label 0
    db $a0, $0f ; volume $0F
    db $1f, $0c ; rest-note $1F dur 12
    db $36, $0c ; note F#3 dur 12
    db $ca, $0f ; env $0F
    db $3b, $18 ; note B3 dur 24
    db $c2, $08 ; env $08
    db $34, $0c ; note E3 dur 12
    db $ca, $0f ; env $0F
    db $39, $18 ; note A3 dur 24
    db $c2, $08 ; env $08
    db $32, $0c ; note D3 dur 12
    db $ca, $0f ; env $0F
    db $37, $18 ; note G3 dur 24
    db $c2, $08 ; env $08
    db $31, $0c ; note C#3 dur 12
    db $ca, $0f ; env $0F
    db $36, $12 ; note F#3 dur 18
    db $1f, $06 ; rest-note $1F dur 6
    db $a0, $0b ; volume $0B
    db $c2, $08 ; env $08
    db $2b, $0c ; note B2 dur 12
    db $a0, $08 ; volume $08
    db $2b, $0c ; note B2 dur 12
    db $a0, $0b ; volume $0B
    db $31, $0c ; note C#3 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $03 ; volume $03
    db $31, $0c ; note C#3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $ca, $12 ; env $12
    db $a0, $0f ; volume $0F
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $c1, $2f ; env $2F
    db $32, $1e ; note D3 dur 30
    db $c2, $08 ; env $08
    db $a0, $0f ; volume $0F
    db $34, $0c ; note E3 dur 12
    db $a0, $0c ; volume $0C
    db $36, $0c ; note F#3 dur 12
    db $a0, $0f ; volume $0F
    db $ca, $0a ; env $0A
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $c2, $08 ; env $08
    db $a0, $0f ; volume $0F
    db $34, $0c ; note E3 dur 12
    db $a0, $09 ; volume $09
    db $2a, $0c ; note A#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 288 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0B::
    db $01, $08, $02, $0a ; header: param=1 byte1=$08 volume=$02 byte3=$0A
    db $fd, $f3 ; label 3
    db $1f, $24 ; rest-note $1F dur 36
    db $22, $0c ; note D2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $39, $0c ; note A3 dur 12
    db $39, $0c ; note A3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $29, $0c ; note A2 dur 12
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $21, $0c ; note C#2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $39, $0c ; note A3 dur 12
    db $39, $0c ; note A3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a1, $0a ; duty $0A
    db $14, $0c ; note E1 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $32, $0c ; note D3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a1, $0a ; duty $0A
    db $a0, $04 ; volume $04
    db $39, $18 ; note A3 dur 24
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $02 ; volume $02
    db $24, $0c ; note E2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $34, $0c ; note E3 dur 12
    db $37, $0c ; note G3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $23, $0c ; note D#2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $33, $0c ; note D#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $0a ; duty $0A
    db $22, $0c ; note D2 dur 12
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $21, $0c ; note C#2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $29, $0c ; note A2 dur 12
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $12, $0c ; note D1 dur 12
    db $a1, $03 ; duty $03
    db $22, $0c ; note D2 dur 12
    db $29, $0c ; note A2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a1, $0a ; duty $0A
    db $36, $0c ; note F#3 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $22, $0c ; note D2 dur 12
    db $af, $01 ; param $01
    db $a2, $08 ; duty2 $08
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $a1, $0a ; duty $0A
    db $17, $0c ; note G1 dur 12
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $21, $0c ; note C#2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $2b, $0c ; note B2 dur 12
    db $34, $0c ; note E3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a1, $0a ; duty $0A
    db $16, $0c ; note F#1 dur 12
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $31, $0c ; note C#3 dur 12
    db $a0, $04 ; volume $04
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a0, $02 ; volume $02
    db $29, $0c ; note A2 dur 12
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $36, $0c ; note F#3 dur 12
    db $a0, $04 ; volume $04
    db $a1, $0a ; duty $0A
    db $14, $0c ; note E1 dur 12
    db $a0, $02 ; volume $02
    db $24, $0c ; note E2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a1, $0a ; duty $0A
    db $25, $0c ; note F2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $a0, $04 ; volume $04
    db $a2, $06 ; duty2 $06
    db $16, $0c ; note F#1 dur 12
    db $a0, $02 ; volume $02
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $a0, $04 ; volume $04
    db $16, $0c ; note F#1 dur 12
    db $a0, $04 ; volume $04
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a2, $08 ; duty2 $08
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $20, $18 ; note C2 dur 24
    db $30, $18 ; note C3 dur 24
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $33, $0c ; note D#3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $2b, $0c ; note B2 dur 12
    db $a1, $0a ; duty $0A
    db $18, $0c ; note G#1 dur 12
    db $a1, $03 ; duty $03
    db $28, $0c ; note G#2 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $fd, $f0 ; label 0
    db $a1, $0a ; duty $0A
    db $22, $0c ; note D2 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $a1, $0a ; duty $0A
    db $22, $0c ; note D2 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $a1, $0a ; duty $0A
    db $21, $0c ; note C#2 dur 12
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $1f, $0c ; rest-note $1F dur 12
    db $27, $0c ; note G2 dur 12
    db $17, $0c ; note G1 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0a ; duty $0A
    db $22, $0c ; note D2 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $a1, $0a ; duty $0A
    db $22, $0c ; note D2 dur 12
    db $a1, $03 ; duty $03
    db $29, $0c ; note A2 dur 12
    db $a1, $0a ; duty $0A
    db $21, $0c ; note C#2 dur 12
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $17, $0c ; note G1 dur 12
    db $a1, $0a ; duty $0A
    db $27, $0c ; note G2 dur 12
    db $a1, $03 ; duty $03
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $18 ; note B1 dur 24
    db $2b, $18 ; note B2 dur 24
    db $18, $0c ; note G#1 dur 12
    db $28, $0c ; note G#2 dur 12
    db $a1, $03 ; duty $03
    db $2b, $0c ; note B2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a1, $0a ; duty $0A
    db $20, $0c ; note C2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $29, $0c ; note A2 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 273 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0C::
    db $08, $01, $0c, $00 ; header: param=8 byte1=$01 volume=$0C byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $01 ; duty2 $01
    db $a0, $0c ; volume $0C
    db $c1, $40 ; env $40
    db $29, $05 ; note A2 dur 5
    db $a0, $06 ; volume $06
    db $29, $0a ; note A2 dur 10
    db $a0, $0b ; volume $0B
    db $29, $05 ; note A2 dur 5
    db $a0, $06 ; volume $06
    db $29, $0a ; note A2 dur 10
    db $a0, $0d ; volume $0D
    db $24, $05 ; note E2 dur 5
    db $a0, $06 ; volume $06
    db $c7, $1f ; env $1F
    db $24, $0f ; note E2 dur 15
    db $1f, $1e ; rest-note $1F dur 30
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $30, $05 ; note C3 dur 5
    db $c1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $32, $05 ; note D3 dur 5
    db $a0, $0b ; volume $0B
    db $c1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $22, $05 ; note D2 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $34, $05 ; note E3 dur 5
    db $a0, $0b ; volume $0B
    db $c1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $24, $05 ; note E2 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $33, $05 ; note D#3 dur 5
    db $a0, $0b ; volume $0B
    db $c1, $50 ; env $50
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
    db $a0, $08 ; volume $08
    db $25, $05 ; note F2 dur 5
    db $a0, $0b ; volume $0B
    db $1a, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $2a, $05 ; note A#2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $1a, $05 ; note A#1 dur 5
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
    db $1a, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $a0, $08 ; volume $08
    db $22, $0a ; note D2 dur 10
    db $a0, $0b ; volume $0B
    db $c2, $15 ; env $15
    db $22, $0a ; note D2 dur 10
    db $c1, $50 ; env $50
    db $24, $14 ; note E2 dur 20
    db $c1, $1f ; env $1F
    db $22, $05 ; note D2 dur 5
    db $22, $05 ; note D2 dur 5
    db $a0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $a0, $0b ; volume $0B
    db $c1, $60 ; env $60
    db $24, $19 ; note E2 dur 25
    db $a2, $01 ; duty2 $01
    db $a0, $0a ; volume $0A
    db $c1, $30 ; env $30
    db $1f, $0a ; rest-note $1F dur 10
    db $29, $0a ; note A2 dur 10
    db $a0, $0c ; volume $0C
    db $28, $0a ; note G#2 dur 10
    db $a0, $0f ; volume $0F
    db $27, $0a ; note G2 dur 10
    db $26, $05 ; note F#2 dur 5
    db $c1, $7f ; env $7F
    db $26, $05 ; note F#2 dur 5
    db $a0, $08 ; volume $08
    db $26, $05 ; note F#2 dur 5
    db $a0, $0c ; volume $0C
    db $25, $0f ; note F2 dur 15
    db $a0, $08 ; volume $08
    db $25, $0a ; note F2 dur 10
    db $c1, $30 ; env $30
    db $a0, $0a ; volume $0A
    db $1f, $0a ; rest-note $1F dur 10
    db $25, $0a ; note F2 dur 10
    db $a0, $0c ; volume $0C
    db $24, $0a ; note E2 dur 10
    db $a0, $0f ; volume $0F
    db $23, $0a ; note D#2 dur 10
    db $22, $05 ; note D2 dur 5
    db $c1, $7f ; env $7F
    db $22, $05 ; note D2 dur 5
    db $a0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $a0, $0c ; volume $0C
    db $1b, $0f ; note B1 dur 15
    db $a0, $08 ; volume $08
    db $1b, $0a ; note B1 dur 10
    db $a0, $0b ; volume $0B
    db $1f, $0a ; rest-note $1F dur 10
    db $2a, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $2a, $05 ; note A#2 dur 5
    db $32, $0a ; note D3 dur 10
    db $31, $0a ; note C#3 dur 10
    db $30, $05 ; note C3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $c0, $fe ; env $FE
    db $21, $19 ; note C#2 dur 25
    db $a0, $08 ; volume $08
    db $c1, $30 ; env $30
    db $21, $0a ; note C#2 dur 10
    db $a0, $0b ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $32, $05 ; note D3 dur 5
    db $35, $0a ; note F3 dur 10
    db $34, $0a ; note E3 dur 10
    db $33, $05 ; note D#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $c0, $fe ; env $FE
    db $35, $19 ; note F3 dur 25
    db $c1, $30 ; env $30
    db $a0, $08 ; volume $08
    db $35, $0a ; note F3 dur 10
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $35, $0a ; note F3 dur 10
    db $37, $0a ; note G3 dur 10
    db $35, $0a ; note F3 dur 10
    db $34, $0a ; note E3 dur 10
    db $a0, $08 ; volume $08
    db $34, $0a ; note E3 dur 10
    db $a0, $0c ; volume $0C
    db $24, $05 ; note E2 dur 5
    db $2a, $0a ; note A#2 dur 10
    db $29, $0f ; note A2 dur 15
    db $2a, $0a ; note A#2 dur 10
    db $a0, $0a ; volume $0A
    db $c1, $20 ; env $20
    db $2a, $05 ; note A#2 dur 5
    db $c1, $50 ; env $50
    db $2a, $0a ; note A#2 dur 10
    db $c1, $30 ; env $30
    db $29, $05 ; note A2 dur 5
    db $a0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $a0, $0c ; volume $0C
    db $c1, $50 ; env $50
    db $1a, $05 ; note A#1 dur 5
    db $a0, $0a ; volume $0A
    db $19, $05 ; note A1 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $a0, $0b ; volume $0B
    db $19, $05 ; note A1 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $a0, $0d ; volume $0D
    db $19, $05 ; note A1 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $a0, $08 ; volume $08
    db $1a, $0a ; note A#1 dur 10
    db $a0, $0c ; volume $0C
    db $22, $0a ; note D2 dur 10
    db $c1, $20 ; env $20
    db $a0, $0a ; volume $0A
    db $21, $05 ; note C#2 dur 5
    db $c1, $50 ; env $50
    db $21, $0a ; note C#2 dur 10
    db $c1, $30 ; env $30
    db $20, $05 ; note C2 dur 5
    db $a0, $08 ; volume $08
    db $20, $0a ; note C2 dur 10
    db $1f, $1e ; rest-note $1F dur 30
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 259 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0D::
    db $08, $02, $0f, $00 ; header: param=8 byte1=$02 volume=$0F byte3=$00
    db $fd, $f3 ; label 3
    db $a0, $0f ; volume $0F
    db $a2, $02 ; duty2 $02
    db $a3, $06 ; mod $06
    db $c1, $40 ; env $40
    db $30, $05 ; note C3 dur 5
    db $a0, $06 ; volume $06
    db $30, $0a ; note C3 dur 10
    db $a0, $0f ; volume $0F
    db $30, $05 ; note C3 dur 5
    db $a0, $06 ; volume $06
    db $30, $0a ; note C3 dur 10
    db $a0, $0f ; volume $0F
    db $30, $05 ; note C3 dur 5
    db $a0, $06 ; volume $06
    db $c7, $2f ; env $2F
    db $30, $0f ; note C3 dur 15
    db $c1, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $30, $0a ; note C3 dur 10
    db $32, $0a ; note D3 dur 10
    db $35, $05 ; note F3 dur 5
    db $c1, $50 ; env $50
    db $39, $0a ; note A3 dur 10
    db $c1, $1f ; env $1F
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $c1, $7f ; env $7F
    db $3a, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $a0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $a0, $0d ; volume $0D
    db $c1, $50 ; env $50
    db $40, $05 ; note C4 dur 5
    db $a0, $06 ; volume $06
    db $40, $23 ; note C4 dur 35
    db $a0, $0d ; volume $0D
    db $c1, $50 ; env $50
    db $39, $0a ; note A3 dur 10
    db $c1, $1f ; env $1F
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $c1, $7f ; env $7F
    db $3a, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $a0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $a0, $0d ; volume $0D
    db $35, $0f ; note F3 dur 15
    db $30, $0a ; note C3 dur 10
    db $a0, $06 ; volume $06
    db $30, $0f ; note C3 dur 15
    db $a0, $0e ; volume $0E
    db $c1, $50 ; env $50
    db $32, $0a ; note D3 dur 10
    db $c1, $1f ; env $1F
    db $35, $05 ; note F3 dur 5
    db $c1, $20 ; env $20
    db $35, $05 ; note F3 dur 5
    db $32, $05 ; note D3 dur 5
    db $c1, $7f ; env $7F
    db $35, $05 ; note F3 dur 5
    db $32, $05 ; note D3 dur 5
    db $a0, $06 ; volume $06
    db $32, $05 ; note D3 dur 5
    db $a0, $0d ; volume $0D
    db $42, $0f ; note D4 dur 15
    db $40, $0a ; note C4 dur 10
    db $38, $05 ; note G#3 dur 5
    db $37, $05 ; note G3 dur 5
    db $35, $05 ; note F3 dur 5
    db $c0, $fe ; env $FE
    db $a3, $09 ; mod $09
    db $37, $19 ; note G3 dur 25
    db $a0, $08 ; volume $08
    db $c1, $60 ; env $60
    db $37, $1e ; note G3 dur 30
    db $a0, $0e ; volume $0E
    db $a3, $06 ; mod $06
    db $37, $0a ; note G3 dur 10
    db $39, $0a ; note A3 dur 10
    db $40, $0a ; note C4 dur 10
    db $c0, $fe ; env $FE
    db $41, $1e ; note C#4 dur 30
    db $c1, $60 ; env $60
    db $39, $0a ; note A3 dur 10
    db $c0, $fe ; env $FE
    db $44, $14 ; note E4 dur 20
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $44, $14 ; note E4 dur 20
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $44, $19 ; note E4 dur 25
    db $c1, $60 ; env $60
    db $45, $05 ; note F4 dur 5
    db $44, $05 ; note E4 dur 5
    db $42, $14 ; note D4 dur 20
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $42, $1e ; note D4 dur 30
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $0d ; volume $0D
    db $32, $05 ; note D3 dur 5
    db $a0, $0c ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $a0, $0d ; volume $0D
    db $c1, $7f ; env $7F
    db $32, $05 ; note D3 dur 5
    db $a0, $0c ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $a0, $0d ; volume $0D
    db $31, $05 ; note C#3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $31, $05 ; note C#3 dur 5
    db $a0, $0d ; volume $0D
    db $39, $0a ; note A3 dur 10
    db $37, $05 ; note G3 dur 5
    db $35, $05 ; note F3 dur 5
    db $c0, $fe ; env $FE
    db $a3, $0d ; mod $0D
    db $37, $2d ; note G3 dur 45
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $37, $28 ; note G3 dur 40
    db $a2, $01 ; duty2 $01
    db $a0, $0d ; volume $0D
    db $a3, $08 ; mod $08
    db $c1, $30 ; env $30
    db $1f, $0a ; rest-note $1F dur 10
    db $30, $0a ; note C3 dur 10
    db $a0, $0e ; volume $0E
    db $30, $0a ; note C3 dur 10
    db $a0, $0f ; volume $0F
    db $30, $0a ; note C3 dur 10
    db $a0, $0d ; volume $0D
    db $c1, $7f ; env $7F
    db $30, $05 ; note C3 dur 5
    db $32, $05 ; note D3 dur 5
    db $a0, $06 ; volume $06
    db $32, $05 ; note D3 dur 5
    db $a0, $0e ; volume $0E
    db $29, $0f ; note A2 dur 15
    db $a0, $08 ; volume $08
    db $29, $0a ; note A2 dur 10
    db $a0, $0e ; volume $0E
    db $c1, $30 ; env $30
    db $1f, $0a ; rest-note $1F dur 10
    db $29, $0a ; note A2 dur 10
    db $a0, $0f ; volume $0F
    db $29, $0a ; note A2 dur 10
    db $29, $0a ; note A2 dur 10
    db $c1, $7f ; env $7F
    db $27, $05 ; note G2 dur 5
    db $29, $05 ; note A2 dur 5
    db $a0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $a0, $0e ; volume $0E
    db $22, $0f ; note D2 dur 15
    db $a0, $08 ; volume $08
    db $22, $0a ; note D2 dur 10
    db $a0, $0e ; volume $0E
    db $1f, $0a ; rest-note $1F dur 10
    db $32, $05 ; note D3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $32, $05 ; note D3 dur 5
    db $c0, $fe ; env $FE
    db $35, $05 ; note F3 dur 5
    db $a0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $c1, $30 ; env $30
    db $a0, $0e ; volume $0E
    db $34, $0a ; note E3 dur 10
    db $33, $05 ; note D#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $c0, $fe ; env $FE
    db $29, $19 ; note A2 dur 25
    db $a0, $08 ; volume $08
    db $c1, $50 ; env $50
    db $29, $0a ; note A2 dur 10
    db $c1, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $35, $05 ; note F3 dur 5
    db $34, $05 ; note E3 dur 5
    db $35, $05 ; note F3 dur 5
    db $c0, $fe ; env $FE
    db $39, $05 ; note A3 dur 5
    db $a0, $0a ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $a0, $0e ; volume $0E
    db $c1, $40 ; env $40
    db $37, $0a ; note G3 dur 10
    db $36, $05 ; note F#3 dur 5
    db $37, $05 ; note G3 dur 5
    db $c0, $fe ; env $FE
    db $42, $19 ; note D4 dur 25
    db $a0, $08 ; volume $08
    db $c1, $50 ; env $50
    db $42, $0a ; note D4 dur 10
    db $c1, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $42, $0a ; note D4 dur 10
    db $44, $0a ; note E4 dur 10
    db $42, $0a ; note D4 dur 10
    db $40, $0a ; note C4 dur 10
    db $a0, $08 ; volume $08
    db $40, $0a ; note C4 dur 10
    db $a0, $0e ; volume $0E
    db $30, $05 ; note C3 dur 5
    db $32, $0a ; note D3 dur 10
    db $35, $0f ; note F3 dur 15
    db $35, $0a ; note F3 dur 10
    db $c1, $20 ; env $20
    db $a0, $0c ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $c1, $50 ; env $50
    db $35, $0a ; note F3 dur 10
    db $c1, $30 ; env $30
    db $35, $05 ; note F3 dur 5
    db $a0, $08 ; volume $08
    db $35, $05 ; note F3 dur 5
    db $a0, $0e ; volume $0E
    db $c1, $50 ; env $50
    db $24, $05 ; note E2 dur 5
    db $a0, $0a ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $a0, $0c ; volume $0C
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $a0, $0e ; volume $0E
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $a0, $08 ; volume $08
    db $24, $0a ; note E2 dur 10
    db $a0, $0c ; volume $0C
    db $25, $0a ; note F2 dur 10
    db $c1, $20 ; env $20
    db $25, $05 ; note F2 dur 5
    db $c1, $50 ; env $50
    db $25, $0a ; note F2 dur 10
    db $c1, $30 ; env $30
    db $25, $05 ; note F2 dur 5
    db $a0, $08 ; volume $08
    db $25, $0a ; note F2 dur 10
    db $1f, $1e ; rest-note $1F dur 30
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 260 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0E::
    db $08, $40, $02, $0b ; header: param=8 byte1=$40 volume=$02 byte3=$0B
    db $fd, $f3 ; label 3
    db $34, $05 ; note E3 dur 5
    db $a2, $12 ; duty2 $12
    db $20, $05 ; note C2 dur 5
    db $20, $05 ; note C2 dur 5
    db $a2, $40 ; duty2 $40
    db $34, $05 ; note E3 dur 5
    db $a2, $18 ; duty2 $18
    db $20, $0a ; note C2 dur 10
    db $a2, $20 ; duty2 $20
    db $2a, $0a ; note A#2 dur 10
    db $1f, $28 ; rest-note $1F dur 40
    db $a2, $18 ; duty2 $18
    db $15, $05 ; note F1 dur 5
    db $15, $05 ; note F1 dur 5
    db $a0, $04 ; volume $04
    db $a2, $40 ; duty2 $40
    db $15, $0a ; note F1 dur 10
    db $a2, $40 ; duty2 $40
    db $1f, $0a ; rest-note $1F dur 10
    db $a0, $02 ; volume $02
    db $25, $0a ; note F2 dur 10
    db $a0, $04 ; volume $04
    db $25, $0a ; note F2 dur 10
    db $a0, $02 ; volume $02
    db $20, $0a ; note C2 dur 10
    db $18, $05 ; note G#1 dur 5
    db $19, $05 ; note A1 dur 5
    db $15, $0a ; note F1 dur 10
    db $a2, $18 ; duty2 $18
    db $15, $05 ; note F1 dur 5
    db $15, $05 ; note F1 dur 5
    db $a0, $04 ; volume $04
    db $15, $0a ; note F1 dur 10
    db $1f, $0a ; rest-note $1F dur 10
    db $a2, $40 ; duty2 $40
    db $a0, $02 ; volume $02
    db $20, $0a ; note C2 dur 10
    db $a0, $04 ; volume $04
    db $20, $0a ; note C2 dur 10
    db $a0, $02 ; volume $02
    db $25, $0a ; note F2 dur 10
    db $20, $0a ; note C2 dur 10
    db $15, $0a ; note F1 dur 10
    db $a2, $18 ; duty2 $18
    db $1a, $05 ; note A#1 dur 5
    db $1a, $05 ; note A#1 dur 5
    db $a0, $04 ; volume $04
    db $1a, $0a ; note A#1 dur 10
    db $1f, $0a ; rest-note $1F dur 10
    db $a2, $40 ; duty2 $40
    db $a0, $02 ; volume $02
    db $20, $0a ; note C2 dur 10
    db $a0, $04 ; volume $04
    db $20, $0a ; note C2 dur 10
    db $a0, $02 ; volume $02
    db $22, $0a ; note D2 dur 10
    db $a0, $04 ; volume $04
    db $22, $0a ; note D2 dur 10
    db $a0, $02 ; volume $02
    db $2a, $0a ; note A#2 dur 10
    db $a2, $20 ; duty2 $20
    db $fd, $f0 ; label 0
    db $20, $0a ; note C2 dur 10
    db $b7, $f0 ; repeat $F0
    db $a2, $18 ; duty2 $18
    db $19, $05 ; note A1 dur 5
    db $19, $05 ; note A1 dur 5
    db $a0, $04 ; volume $04
    db $19, $0a ; note A1 dur 10
    db $1f, $0a ; rest-note $1F dur 10
    db $a0, $02 ; volume $02
    db $a2, $40 ; duty2 $40
    db $24, $0a ; note E2 dur 10
    db $29, $05 ; note A2 dur 5
    db $27, $05 ; note G2 dur 5
    db $a0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $a0, $02 ; volume $02
    db $24, $05 ; note E2 dur 5
    db $a0, $04 ; volume $04
    db $24, $05 ; note E2 dur 5
    db $a0, $02 ; volume $02
    db $24, $05 ; note E2 dur 5
    db $19, $0a ; note A1 dur 10
    db $a0, $04 ; volume $04
    db $19, $0a ; note A1 dur 10
    db $a0, $02 ; volume $02
    db $12, $0f ; note D1 dur 15
    db $a0, $04 ; volume $04
    db $12, $05 ; note D1 dur 5
    db $a0, $02 ; volume $02
    db $14, $0f ; note E1 dur 15
    db $a0, $04 ; volume $04
    db $14, $05 ; note E1 dur 5
    db $a0, $02 ; volume $02
    db $15, $0f ; note F1 dur 15
    db $a0, $04 ; volume $04
    db $15, $05 ; note F1 dur 5
    db $a0, $02 ; volume $02
    db $12, $0a ; note D1 dur 10
    db $17, $0a ; note G1 dur 10
    db $17, $0a ; note G1 dur 10
    db $a0, $04 ; volume $04
    db $17, $0a ; note G1 dur 10
    db $a0, $02 ; volume $02
    db $27, $0f ; note G2 dur 15
    db $a0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $a0, $02 ; volume $02
    db $25, $0f ; note F2 dur 15
    db $a0, $04 ; volume $04
    db $25, $05 ; note F2 dur 5
    db $a0, $02 ; volume $02
    db $17, $0a ; note G1 dur 10
    db $20, $0a ; note C2 dur 10
    db $a2, $12 ; duty2 $12
    db $2a, $0a ; note A#2 dur 10
    db $a2, $40 ; duty2 $40
    db $30, $0a ; note C3 dur 10
    db $a2, $12 ; duty2 $12
    db $20, $0a ; note C2 dur 10
    db $a2, $18 ; duty2 $18
    db $2a, $05 ; note A#2 dur 5
    db $2a, $05 ; note A#2 dur 5
    db $a2, $02 ; duty2 $02
    db $20, $05 ; note C2 dur 5
    db $a2, $40 ; duty2 $40
    db $30, $0a ; note C3 dur 10
    db $a2, $12 ; duty2 $12
    db $30, $05 ; note C3 dur 5
    db $a2, $40 ; duty2 $40
    db $20, $0a ; note C2 dur 10
    db $a2, $48 ; duty2 $48
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a1, $0a ; duty $0A
    db $15, $0a ; note F1 dur 10
    db $a1, $0b ; duty $0B
    db $35, $0a ; note F3 dur 10
    db $34, $0a ; note E3 dur 10
    db $33, $0a ; note D#3 dur 10
    db $32, $05 ; note D3 dur 5
    db $30, $05 ; note C3 dur 5
    db $a0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $a0, $02 ; volume $02
    db $2b, $05 ; note B2 dur 5
    db $a0, $04 ; volume $04
    db $2b, $05 ; note B2 dur 5
    db $a0, $02 ; volume $02
    db $a2, $10 ; duty2 $10
    db $2b, $05 ; note B2 dur 5
    db $a2, $48 ; duty2 $48
    db $a1, $0a ; duty $0A
    db $17, $0a ; note G1 dur 10
    db $1a, $0a ; note A#1 dur 10
    db $a1, $0b ; duty $0B
    db $32, $0a ; note D3 dur 10
    db $31, $0a ; note C#3 dur 10
    db $30, $0a ; note C3 dur 10
    db $a2, $20 ; duty2 $20
    db $2b, $05 ; note B2 dur 5
    db $a2, $48 ; duty2 $48
    db $2b, $05 ; note B2 dur 5
    db $a0, $04 ; volume $04
    db $2b, $05 ; note B2 dur 5
    db $a0, $02 ; volume $02
    db $25, $0a ; note F2 dur 10
    db $a2, $10 ; duty2 $10
    db $a1, $0a ; duty $0A
    db $22, $05 ; note D2 dur 5
    db $a2, $48 ; duty2 $48
    db $17, $0a ; note G1 dur 10
    db $1a, $0a ; note A#1 dur 10
    db $a1, $0b ; duty $0B
    db $35, $05 ; note F3 dur 5
    db $34, $05 ; note E3 dur 5
    db $35, $05 ; note F3 dur 5
    db $2a, $0a ; note A#2 dur 10
    db $29, $05 ; note A2 dur 5
    db $a1, $0a ; duty $0A
    db $19, $0a ; note A1 dur 10
    db $a2, $10 ; duty2 $10
    db $a1, $0b ; duty $0B
    db $29, $0a ; note A2 dur 10
    db $a2, $40 ; duty2 $40
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $19, $0a ; note A1 dur 10
    db $a1, $0a ; duty $0A
    db $12, $0a ; note D1 dur 10
    db $a1, $0b ; duty $0B
    db $29, $05 ; note A2 dur 5
    db $28, $05 ; note G#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $22, $0a ; note D2 dur 10
    db $20, $05 ; note C2 dur 5
    db $a2, $70 ; duty2 $70
    db $1b, $0a ; note B1 dur 10
    db $29, $0a ; note A2 dur 10
    db $a2, $40 ; duty2 $40
    db $32, $05 ; note D3 dur 5
    db $29, $05 ; note A2 dur 5
    db $a1, $0a ; duty $0A
    db $1b, $0a ; note B1 dur 10
    db $1a, $0a ; note A#1 dur 10
    db $a1, $0b ; duty $0B
    db $a2, $70 ; duty2 $70
    db $2a, $0a ; note A#2 dur 10
    db $a0, $04 ; volume $04
    db $2a, $0a ; note A#2 dur 10
    db $a2, $40 ; duty2 $40
    db $a0, $02 ; volume $02
    db $2a, $0a ; note A#2 dur 10
    db $30, $0a ; note C3 dur 10
    db $a1, $0a ; duty $0A
    db $20, $0a ; note C2 dur 10
    db $a2, $15 ; duty2 $15
    db $20, $05 ; note C2 dur 5
    db $a2, $48 ; duty2 $48
    db $20, $0a ; note C2 dur 10
    db $15, $0a ; note F1 dur 10
    db $a0, $04 ; volume $04
    db $15, $05 ; note F1 dur 5
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $32, $0a ; note D3 dur 10
    db $a2, $15 ; duty2 $15
    db $31, $05 ; note C#3 dur 5
    db $a2, $30 ; duty2 $30
    db $31, $0a ; note C#3 dur 10
    db $30, $05 ; note C3 dur 5
    db $a0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $a0, $02 ; volume $02
    db $20, $05 ; note C2 dur 5
    db $fd, $f0 ; label 0
    db $1b, $05 ; note B1 dur 5
    db $20, $05 ; note C2 dur 5
    db $b2, $f0 ; repeat $F0
    db $a1, $0a ; duty $0A
    db $15, $0a ; note F1 dur 10
    db $a1, $0b ; duty $0B
    db $2a, $0a ; note A#2 dur 10
    db $a2, $15 ; duty2 $15
    db $2a, $05 ; note A#2 dur 5
    db $a2, $30 ; duty2 $30
    db $2a, $0a ; note A#2 dur 10
    db $29, $05 ; note A2 dur 5
    db $a0, $04 ; volume $04
    db $29, $0a ; note A2 dur 10
    db $a0, $02 ; volume $02
    db $20, $0a ; note C2 dur 10
    db $a0, $04 ; volume $04
    db $20, $0a ; note C2 dur 10
    db $a0, $02 ; volume $02
    db $20, $0a ; note C2 dur 10
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 319 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_0F::
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $01 ; duty2 $01
    db $a3, $02 ; mod $02
    db $c4, $0f ; env $0F
    db $a0, $07 ; volume $07
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $09 ; volume $09
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $37, $06 ; note G3 dur 6
    db $a0, $07 ; volume $07
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $a0, $09 ; volume $09
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $a0, $07 ; volume $07
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $09 ; volume $09
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $07 ; volume $07
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $20, $06 ; note C2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $a0, $09 ; volume $09
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $a0, $07 ; volume $07
    db $26, $06 ; note F#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $a0, $0a ; volume $0A
    db $c4, $15 ; env $15
    db $17, $0c ; note G1 dur 12
    db $c2, $10 ; env $10
    db $a0, $07 ; volume $07
    db $26, $0c ; note F#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $09 ; volume $09
    db $23, $0c ; note D#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a0, $0b ; volume $0B
    db $1b, $0c ; note B1 dur 12
    db $a0, $08 ; volume $08
    db $1a, $0c ; note A#1 dur 12
    db $19, $0c ; note A1 dur 12
    db $18, $0c ; note G#1 dur 12
    db $17, $0c ; note G1 dur 12
    db $1f, $24 ; rest-note $1F dur 36
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $1f, $0c ; rest-note $1F dur 12
    db $27, $0c ; note G2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $fd, $f0 ; label 0
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $0a ; volume $0A
    db $27, $0c ; note G2 dur 12
    db $b7, $f0 ; repeat $F0
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $0b ; volume $0B
    db $26, $0c ; note F#2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $24, $0c ; note E2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $1f, $0c ; rest-note $1F dur 12
    db $23, $0c ; note D#2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $fd, $f0 ; label 0
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $0a ; volume $0A
    db $23, $0c ; note D#2 dur 12
    db $b7, $f0 ; repeat $F0
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $0a ; volume $0A
    db $22, $0c ; note D2 dur 12
    db $22, $0c ; note D2 dur 12
    db $22, $0c ; note D2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $20, $0c ; note C2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $a2, $01 ; duty2 $01
    db $a0, $09 ; volume $09
    db $a3, $02 ; mod $02
    db $c4, $12 ; env $12
    db $fd, $f1 ; label 1
    db $1a, $06 ; note A#1 dur 6
    db $25, $06 ; note F2 dur 6
    db $fd, $f0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f1 ; label 1
    db $19, $06 ; note A1 dur 6
    db $24, $06 ; note E2 dur 6
    db $fd, $f0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f1 ; label 1
    db $22, $06 ; note D2 dur 6
    db $29, $06 ; note A2 dur 6
    db $fd, $f0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f0 ; label 0
    db $1b, $06 ; note B1 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $b1, $f0 ; repeat $F0
    db $fd, $f1 ; label 1
    db $22, $06 ; note D2 dur 6
    db $29, $06 ; note A2 dur 6
    db $fd, $f0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f1 ; label 1
    db $21, $06 ; note C#2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $fd, $f0 ; label 0
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f1 ; label 1
    db $26, $06 ; note F#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $fd, $f0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $b2, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $b3, $f0 ; repeat $F0
    db $29, $06 ; note A2 dur 6
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $fd, $f0 ; label 0
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $b1, $f0 ; repeat $F0
    db $29, $06 ; note A2 dur 6
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $fd, $f0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $b3, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $a3, $fe ; mod $FE
    db $a2, $02 ; duty2 $02
    db $1f, $0c ; rest-note $1F dur 12
    db $c1, $70 ; env $70
    db $33, $0c ; note D#3 dur 12
    db $43, $0c ; note D#4 dur 12
    db $c2, $15 ; env $15
    db $a2, $00 ; duty2 $00
    db $30, $0c ; note C3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $70 ; env $70
    db $25, $0c ; note F2 dur 12
    db $a0, $0b ; volume $0B
    db $a2, $02 ; duty2 $02
    db $35, $0c ; note F3 dur 12
    db $45, $0c ; note F4 dur 12
    db $c2, $15 ; env $15
    db $a2, $00 ; duty2 $00
    db $35, $0c ; note F3 dur 12
    db $a0, $0d ; volume $0D
    db $c1, $70 ; env $70
    db $2a, $0c ; note A#2 dur 12
    db $a0, $0b ; volume $0B
    db $a2, $02 ; duty2 $02
    db $31, $0c ; note C#3 dur 12
    db $41, $0c ; note C#4 dur 12
    db $c2, $15 ; env $15
    db $a2, $00 ; duty2 $00
    db $33, $0c ; note D#3 dur 12
    db $c1, $70 ; env $70
    db $a0, $0d ; volume $0D
    db $26, $0c ; note F#2 dur 12
    db $a0, $0a ; volume $0A
    db $a2, $02 ; duty2 $02
    db $30, $0c ; note C3 dur 12
    db $a0, $0b ; volume $0B
    db $40, $0c ; note C4 dur 12
    db $c2, $15 ; env $15
    db $a2, $00 ; duty2 $00
    db $2a, $0c ; note A#2 dur 12
    db $a2, $00 ; duty2 $00
    db $c1, $50 ; env $50
    db $a0, $09 ; volume $09
    db $28, $0c ; note G#2 dur 12
    db $c2, $15 ; env $15
    db $30, $0c ; note C3 dur 12
    db $c1, $50 ; env $50
    db $a0, $09 ; volume $09
    db $25, $0c ; note F2 dur 12
    db $c2, $15 ; env $15
    db $2a, $0c ; note A#2 dur 12
    db $c1, $50 ; env $50
    db $a0, $09 ; volume $09
    db $27, $0c ; note G2 dur 12
    db $c2, $15 ; env $15
    db $2a, $0c ; note A#2 dur 12
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $23, $0c ; note D#2 dur 12
    db $c2, $15 ; env $15
    db $28, $0c ; note G#2 dur 12
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $25, $0c ; note F2 dur 12
    db $c2, $15 ; env $15
    db $28, $0c ; note G#2 dur 12
    db $c1, $50 ; env $50
    db $a0, $0b ; volume $0B
    db $25, $0c ; note F2 dur 12
    db $c2, $15 ; env $15
    db $31, $0c ; note C#3 dur 12
    db $c1, $50 ; env $50
    db $a0, $0b ; volume $0B
    db $23, $0c ; note D#2 dur 12
    db $c2, $15 ; env $15
    db $27, $0c ; note G2 dur 12
    db $c1, $50 ; env $50
    db $a0, $0b ; volume $0B
    db $23, $0c ; note D#2 dur 12
    db $c2, $15 ; env $15
    db $30, $0c ; note C3 dur 12
    db $c1, $30 ; env $30
    db $1b, $0c ; note B1 dur 12
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $29, $0c ; note A2 dur 12
    db $22, $0c ; note D2 dur 12
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $29, $0c ; note A2 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $28, $0c ; note G#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $38, $0c ; note G#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $28, $0c ; note G#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $1f, $60 ; rest-note $1F dur 96
    db $a0, $0b ; volume $0B
    db $a1, $00 ; duty $00
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $23, $30 ; note D#2 dur 48
    db $a0, $04 ; volume $04
    db $c1, $50 ; env $50
    db $23, $18 ; note D#2 dur 24
    db $a0, $0b ; volume $0B
    db $25, $06 ; note F2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 379 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_10::
    db $01, $01, $0c, $00 ; header: param=1 byte1=$01 volume=$0C byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $01 ; duty2 $01
    db $a3, $02 ; mod $02
    db $c4, $10 ; env $10
    db $a0, $08 ; volume $08
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $a0, $0a ; volume $0A
    db $37, $06 ; note G3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $a0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $37, $06 ; note G3 dur 6
    db $a0, $08 ; volume $08
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $a0, $0a ; volume $0A
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $a0, $08 ; volume $08
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $08 ; volume $08
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $c4, $15 ; env $15
    db $27, $0c ; note G2 dur 12
    db $a0, $09 ; volume $09
    db $c2, $15 ; env $15
    db $fd, $f0 ; label 0
    db $27, $0c ; note G2 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $fd, $f0 ; label 0
    db $27, $0c ; note G2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $27, $0c ; note G2 dur 12
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $27, $0c ; note G2 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $27, $0c ; note G2 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0b ; volume $0B
    db $c1, $70 ; env $70
    db $a2, $00 ; duty2 $00
    db $a3, $fe ; mod $FE
    db $29, $06 ; note A2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $c1, $20 ; env $20
    db $30, $12 ; note C3 dur 18
    db $a0, $03 ; volume $03
    db $c1, $70 ; env $70
    db $30, $12 ; note C3 dur 18
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $c1, $20 ; env $20
    db $33, $12 ; note D#3 dur 18
    db $a0, $02 ; volume $02
    db $c1, $70 ; env $70
    db $33, $12 ; note D#3 dur 18
    db $a0, $0b ; volume $0B
    db $c1, $70 ; env $70
    db $33, $06 ; note D#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $c1, $20 ; env $20
    db $36, $09 ; note F#3 dur 9
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $0b ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $38, $04 ; note G#3 dur 4
    db $39, $09 ; note A3 dur 9
    db $a0, $04 ; volume $04
    db $39, $06 ; note A3 dur 6
    db $a0, $0b ; volume $0B
    db $39, $05 ; note A3 dur 5
    db $3b, $04 ; note B3 dur 4
    db $40, $09 ; note C4 dur 9
    db $a0, $04 ; volume $04
    db $40, $06 ; note C4 dur 6
    db $a0, $0b ; volume $0B
    db $40, $05 ; note C4 dur 5
    db $42, $04 ; note D4 dur 4
    db $43, $09 ; note D#4 dur 9
    db $a0, $04 ; volume $04
    db $43, $06 ; note D#4 dur 6
    db $a0, $0b ; volume $0B
    db $43, $05 ; note D#4 dur 5
    db $45, $04 ; note F4 dur 4
    db $c0, $fe ; env $FE
    db $46, $30 ; note F#4 dur 48
    db $c1, $70 ; env $70
    db $46, $18 ; note F#4 dur 24
    db $47, $06 ; note G4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $39, $06 ; note A3 dur 6
    db $c0, $fe ; env $FE
    db $36, $18 ; note F#3 dur 24
    db $a0, $06 ; volume $06
    db $c1, $60 ; env $60
    db $36, $30 ; note F#3 dur 48
    db $1f, $0c ; rest-note $1F dur 12
    db $c1, $70 ; env $70
    db $a0, $0b ; volume $0B
    db $25, $06 ; note F2 dur 6
    db $27, $06 ; note G2 dur 6
    db $c1, $20 ; env $20
    db $28, $12 ; note G#2 dur 18
    db $a0, $03 ; volume $03
    db $c1, $70 ; env $70
    db $28, $12 ; note G#2 dur 18
    db $a0, $0b ; volume $0B
    db $c1, $70 ; env $70
    db $28, $06 ; note G#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $c1, $20 ; env $20
    db $2b, $12 ; note B2 dur 18
    db $a0, $03 ; volume $03
    db $c1, $70 ; env $70
    db $2b, $12 ; note B2 dur 18
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $c1, $20 ; env $20
    db $32, $09 ; note D3 dur 9
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $0b ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $34, $04 ; note E3 dur 4
    db $35, $09 ; note F3 dur 9
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $0b ; volume $0B
    db $35, $05 ; note F3 dur 5
    db $37, $04 ; note G3 dur 4
    db $38, $09 ; note G#3 dur 9
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $0b ; volume $0B
    db $38, $05 ; note G#3 dur 5
    db $3a, $04 ; note A#3 dur 4
    db $3b, $09 ; note B3 dur 9
    db $a0, $04 ; volume $04
    db $3b, $06 ; note B3 dur 6
    db $a0, $0b ; volume $0B
    db $3b, $05 ; note B3 dur 5
    db $41, $04 ; note C#4 dur 4
    db $c0, $fe ; env $FE
    db $42, $30 ; note D4 dur 48
    db $c1, $70 ; env $70
    db $42, $18 ; note D4 dur 24
    db $43, $06 ; note D#4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $c1, $7f ; env $7F
    db $32, $30 ; note D3 dur 48
    db $a0, $06 ; volume $06
    db $32, $30 ; note D3 dur 48
    db $a2, $02 ; duty2 $02
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $1f, $18 ; rest-note $1F dur 24
    db $34, $24 ; note E3 dur 36
    db $a0, $06 ; volume $06
    db $c1, $50 ; env $50
    db $34, $0c ; note E3 dur 12
    db $a0, $0b ; volume $0B
    db $35, $18 ; note F3 dur 24
    db $c1, $7f ; env $7F
    db $2b, $24 ; note B2 dur 36
    db $30, $0c ; note C3 dur 12
    db $33, $24 ; note D#3 dur 36
    db $34, $0c ; note E3 dur 12
    db $38, $24 ; note G#3 dur 36
    db $39, $0c ; note A3 dur 12
    db $3b, $24 ; note B3 dur 36
    db $40, $0c ; note C4 dur 12
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $36, $30 ; note F#3 dur 48
    db $a0, $06 ; volume $06
    db $c1, $70 ; env $70
    db $36, $18 ; note F#3 dur 24
    db $a0, $09 ; volume $09
    db $37, $18 ; note G3 dur 24
    db $a0, $03 ; volume $03
    db $c1, $20 ; env $20
    db $37, $18 ; note G3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $38, $24 ; note G#3 dur 36
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $38, $0c ; note G#3 dur 12
    db $a0, $0b ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $c1, $7f ; env $7F
    db $33, $24 ; note D#3 dur 36
    db $34, $0c ; note E3 dur 12
    db $37, $24 ; note G3 dur 36
    db $38, $0c ; note G#3 dur 12
    db $40, $24 ; note C4 dur 36
    db $41, $0c ; note C#4 dur 12
    db $43, $24 ; note D#4 dur 36
    db $44, $0c ; note E4 dur 12
    db $45, $24 ; note F4 dur 36
    db $46, $0c ; note F#4 dur 12
    db $47, $24 ; note G4 dur 36
    db $48, $0c ; note G#4 dur 12
    db $a3, $08 ; mod $08
    db $c1, $3f ; env $3F
    db $a2, $00 ; duty2 $00
    db $39, $0c ; note A3 dur 12
    db $c2, $20 ; env $20
    db $34, $0c ; note E3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $c1, $7f ; env $7F
    db $29, $18 ; note A2 dur 24
    db $c1, $3f ; env $3F
    db $31, $0c ; note C#3 dur 12
    db $c2, $20 ; env $20
    db $34, $0c ; note E3 dur 12
    db $39, $0c ; note A3 dur 12
    db $c1, $3f ; env $3F
    db $37, $0c ; note G3 dur 12
    db $c2, $20 ; env $20
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $c1, $7f ; env $7F
    db $2b, $18 ; note B2 dur 24
    db $c1, $3f ; env $3F
    db $30, $0c ; note C3 dur 12
    db $c2, $20 ; env $20
    db $34, $0c ; note E3 dur 12
    db $37, $0c ; note G3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a3, $fe ; mod $FE
    db $a0, $0c ; volume $0C
    db $36, $0c ; note F#3 dur 12
    db $c1, $30 ; env $30
    db $46, $0c ; note F#4 dur 12
    db $a0, $05 ; volume $05
    db $c1, $60 ; env $60
    db $46, $18 ; note F#4 dur 24
    db $a0, $0b ; volume $0B
    db $c2, $20 ; env $20
    db $38, $0c ; note G#3 dur 12
    db $c1, $30 ; env $30
    db $48, $0c ; note G#4 dur 12
    db $a0, $05 ; volume $05
    db $c1, $60 ; env $60
    db $48, $18 ; note G#4 dur 24
    db $a0, $0b ; volume $0B
    db $c2, $20 ; env $20
    db $35, $0c ; note F3 dur 12
    db $c1, $30 ; env $30
    db $45, $0c ; note F4 dur 12
    db $c1, $60 ; env $60
    db $a0, $05 ; volume $05
    db $45, $18 ; note F4 dur 24
    db $a0, $0b ; volume $0B
    db $c2, $20 ; env $20
    db $33, $0c ; note D#3 dur 12
    db $c1, $40 ; env $40
    db $43, $18 ; note D#4 dur 24
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $33, $0c ; note D#3 dur 12
    db $c2, $15 ; env $15
    db $a0, $08 ; volume $08
    db $43, $0c ; note D#4 dur 12
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $31, $0c ; note C#3 dur 12
    db $c2, $15 ; env $15
    db $a0, $08 ; volume $08
    db $41, $0c ; note C#4 dur 12
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $31, $0c ; note C#3 dur 12
    db $c2, $15 ; env $15
    db $a0, $09 ; volume $09
    db $41, $0c ; note C#4 dur 12
    db $c1, $50 ; env $50
    db $a0, $0b ; volume $0B
    db $2b, $0c ; note B2 dur 12
    db $c2, $15 ; env $15
    db $a0, $0a ; volume $0A
    db $3b, $0c ; note B3 dur 12
    db $c1, $50 ; env $50
    db $a0, $0c ; volume $0C
    db $2b, $0c ; note B2 dur 12
    db $c2, $15 ; env $15
    db $a0, $0b ; volume $0B
    db $3b, $0c ; note B3 dur 12
    db $c1, $50 ; env $50
    db $a0, $0d ; volume $0D
    db $2a, $0c ; note A#2 dur 12
    db $c2, $15 ; env $15
    db $3a, $0c ; note A#3 dur 12
    db $c1, $50 ; env $50
    db $2a, $0c ; note A#2 dur 12
    db $c2, $15 ; env $15
    db $3a, $0c ; note A#3 dur 12
    db $c1, $50 ; env $50
    db $28, $0c ; note G#2 dur 12
    db $c2, $15 ; env $15
    db $38, $0c ; note G#3 dur 12
    db $a0, $03 ; volume $03
    db $c1, $20 ; env $20
    db $38, $0c ; note G#3 dur 12
    db $c1, $7f ; env $7F
    db $fd, $f0 ; label 0
    db $a0, $0b ; volume $0B
    db $c2, $20 ; env $20
    db $35, $0c ; note F3 dur 12
    db $c1, $40 ; env $40
    db $45, $0c ; note F4 dur 12
    db $a0, $03 ; volume $03
    db $c1, $60 ; env $60
    db $45, $18 ; note F4 dur 24
    db $b1, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $c1, $2f ; env $2F
    db $34, $0c ; note E3 dur 12
    db $34, $0c ; note E3 dur 12
    db $44, $0c ; note E4 dur 12
    db $44, $0c ; note E4 dur 12
    db $34, $0c ; note E3 dur 12
    db $34, $0c ; note E3 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $07 ; volume $07
    db $c0, $fe ; env $FE
    db $19, $48 ; note A1 dur 72
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $19, $18 ; note A1 dur 24
    db $a3, $0f ; mod $0F
    db $c0, $fe ; env $FE
    db $27, $30 ; note G2 dur 48
    db $a0, $06 ; volume $06
    db $c1, $50 ; env $50
    db $27, $18 ; note G2 dur 24
    db $a0, $0c ; volume $0C
    db $28, $06 ; note G#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 343 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_11::
    db $01, $ff, $02, $0a ; header: param=1 byte1=$FF volume=$02 byte3=$0A
    db $fd, $f3 ; label 3
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $20, $30 ; note C2 dur 48
    db $a0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $0c ; note C2 dur 12
    db $a0, $02 ; volume $02
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $10, $48 ; note C1 dur 72
    db $a0, $04 ; volume $04
    db $10, $18 ; note C1 dur 24
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a2, $15 ; duty2 $15
    db $a1, $03 ; duty $03
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $a1, $08 ; duty $08
    db $27, $0c ; note G2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $24, $0c ; note E2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $17, $0c ; note G1 dur 12
    db $a0, $06 ; volume $06
    db $17, $0c ; note G1 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $20, $0c ; note C2 dur 12
    db $a1, $08 ; duty $08
    db $33, $0c ; note D#3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $06 ; volume $06
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $08 ; duty $08
    db $33, $0c ; note D#3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $06 ; volume $06
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $a2, $30 ; duty2 $30
    db $fd, $f0 ; label 0
    db $a1, $0a ; duty $0A
    db $20, $0c ; note C2 dur 12
    db $a1, $08 ; duty $08
    db $33, $0c ; note D#3 dur 12
    db $a1, $0a ; duty $0A
    db $20, $0c ; note C2 dur 12
    db $a1, $08 ; duty $08
    db $33, $0c ; note D#3 dur 12
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $08 ; duty $08
    db $33, $0c ; note D#3 dur 12
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $08 ; duty $08
    db $30, $0c ; note C3 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $10, $0c ; note C1 dur 12
    db $a1, $08 ; duty $08
    db $a2, $15 ; duty2 $15
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $18, $0c ; note G#1 dur 12
    db $a1, $08 ; duty $08
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $15, $0c ; note F1 dur 12
    db $a1, $08 ; duty $08
    db $2b, $0c ; note B2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $fd, $f0 ; label 0
    db $a1, $0a ; duty $0A
    db $18, $0c ; note G#1 dur 12
    db $a1, $08 ; duty $08
    db $2b, $0c ; note B2 dur 12
    db $a1, $0a ; duty $0A
    db $18, $0c ; note G#1 dur 12
    db $a1, $08 ; duty $08
    db $2b, $0c ; note B2 dur 12
    db $a1, $0a ; duty $0A
    db $15, $0c ; note F1 dur 12
    db $a1, $08 ; duty $08
    db $2b, $0c ; note B2 dur 12
    db $a1, $0a ; duty $0A
    db $15, $0c ; note F1 dur 12
    db $a1, $08 ; duty $08
    db $29, $0c ; note A2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $0a, $0c ; note A#0 dur 12
    db $a2, $15 ; duty2 $15
    db $a1, $08 ; duty $08
    db $31, $0c ; note C#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $0a, $0c ; note A#0 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $20 ; duty2 $20
    db $1a, $0c ; note A#1 dur 12
    db $a0, $06 ; volume $06
    db $1a, $0c ; note A#1 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a0, $06 ; volume $06
    db $1a, $0c ; note A#1 dur 12
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $0a, $0c ; note A#0 dur 12
    db $19, $18 ; note A1 dur 24
    db $19, $18 ; note A1 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $24, $0c ; note E2 dur 12
    db $20, $0c ; note C2 dur 12
    db $19, $0c ; note A1 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $12, $0c ; note D1 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $20 ; duty2 $20
    db $22, $0c ; note D2 dur 12
    db $a0, $06 ; volume $06
    db $22, $0c ; note D2 dur 12
    db $a0, $02 ; volume $02
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0a ; duty $0A
    db $17, $18 ; note G1 dur 24
    db $17, $18 ; note G1 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $22, $0c ; note D2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $17, $0c ; note G1 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $12, $0c ; note D1 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $20 ; duty2 $20
    db $22, $0c ; note D2 dur 12
    db $a0, $06 ; volume $06
    db $22, $0c ; note D2 dur 12
    db $a0, $02 ; volume $02
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a0, $06 ; volume $06
    db $22, $0c ; note D2 dur 12
    db $a0, $02 ; volume $02
    db $12, $0c ; note D1 dur 12
    db $a1, $0a ; duty $0A
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $28, $0c ; note G#2 dur 12
    db $24, $0c ; note E2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $16, $0c ; note F#1 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $20 ; duty2 $20
    db $26, $0c ; note F#2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $31, $0c ; note C#3 dur 12
    db $a0, $06 ; volume $06
    db $31, $0c ; note C#3 dur 12
    db $a0, $02 ; volume $02
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $1b, $18 ; note B1 dur 24
    db $1b, $18 ; note B1 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $26, $0c ; note F#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $a2, $30 ; duty2 $30
    db $fd, $f0 ; label 0
    db $a1, $0a ; duty $0A
    db $16, $0c ; note F#1 dur 12
    db $a1, $0b ; duty $0B
    db $26, $0c ; note F#2 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a1, $0a ; duty $0A
    db $19, $0c ; note A1 dur 12
    db $a1, $0b ; duty $0B
    db $29, $0c ; note A2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a1, $0a ; duty $0A
    db $18, $0c ; note G#1 dur 12
    db $a1, $0b ; duty $0B
    db $30, $0c ; note C3 dur 12
    db $a0, $06 ; volume $06
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $a2, $25 ; duty2 $25
    db $38, $0c ; note G#3 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $30 ; duty2 $30
    db $21, $0c ; note C#2 dur 12
    db $a1, $0b ; duty $0B
    db $32, $0c ; note D3 dur 12
    db $a0, $06 ; volume $06
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $a2, $25 ; duty2 $25
    db $38, $0c ; note G#3 dur 12
    db $a2, $30 ; duty2 $30
    db $a1, $0a ; duty $0A
    db $16, $0c ; note F#1 dur 12
    db $a1, $0b ; duty $0B
    db $26, $0c ; note F#2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $a2, $25 ; duty2 $25
    db $26, $0c ; note F#2 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $30 ; duty2 $30
    db $20, $0c ; note C2 dur 12
    db $a1, $0b ; duty $0B
    db $30, $0c ; note C3 dur 12
    db $a0, $06 ; volume $06
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $a2, $25 ; duty2 $25
    db $36, $0c ; note F#3 dur 12
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $15, $0c ; note F1 dur 12
    db $a0, $04 ; volume $04
    db $15, $0c ; note F1 dur 12
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a0, $04 ; volume $04
    db $1a, $0c ; note A#1 dur 12
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $28, $0c ; note G#2 dur 12
    db $a0, $04 ; volume $04
    db $28, $0c ; note G#2 dur 12
    db $a0, $02 ; volume $02
    db $21, $0c ; note C#2 dur 12
    db $a0, $04 ; volume $04
    db $21, $0c ; note C#2 dur 12
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $a0, $04 ; volume $04
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $20, $0c ; note C2 dur 12
    db $a0, $04 ; volume $04
    db $20, $0c ; note C2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $1b, $30 ; note B1 dur 48
    db $a0, $04 ; volume $04
    db $1b, $18 ; note B1 dur 24
    db $a0, $02 ; volume $02
    db $1b, $18 ; note B1 dur 24
    db $1a, $30 ; note A#1 dur 48
    db $a0, $04 ; volume $04
    db $1a, $18 ; note A#1 dur 24
    db $a0, $02 ; volume $02
    db $1a, $18 ; note A#1 dur 24
    db $19, $48 ; note A1 dur 72
    db $a0, $04 ; volume $04
    db $19, $18 ; note A1 dur 24
    db $a0, $02 ; volume $02
    db $20, $48 ; note C2 dur 72
    db $a0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 50 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_12::
    db $01, $00, $0f, $00 ; header: param=1 byte1=$00 volume=$0F byte3=$00
    db $fd, $f3 ; label 3
    db $fd, $f0 ; label 0
    db $1f, $60 ; rest-note $1F dur 96
    db $bb, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $1f, $c0 ; rest-note $1F dur 192
    db $b7, $f0 ; repeat $F0
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0a ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1f, $17 ; rest-note $1F dur 23
    db $a0, $0a ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1f, $17 ; rest-note $1F dur 23
    db $a0, $0a ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1f, $17 ; rest-note $1F dur 23
    db $a0, $0f ; volume $0F
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $07 ; volume $07
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $0b ; volume $0B
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $05 ; volume $05
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $0f ; volume $0F
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $07 ; volume $07
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $0d ; volume $0D
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $05 ; volume $05
    db $41, $01 ; note C#4 dur 1
    db $1f, $05 ; rest-note $1F dur 5
    db $a0, $0f ; volume $0F
    db $51, $02 ; note C#5 dur 2
    db $53, $02 ; note D#5 dur 2
    db $a0, $04 ; volume $04
    db $56, $04 ; note F#5 dur 4
    db $1f, $10 ; rest-note $1F dur 16
    db $1f, $18 ; rest-note $1F dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 533 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_13::
    db $01, $01, $0b, $00 ; header: param=1 byte1=$01 volume=$0B byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $00 ; duty2 $00
    db $a0, $0b ; volume $0B
    db $c2, $15 ; env $15
    db $2b, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $c1, $30 ; env $30
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $1f, $48 ; rest-note $1F dur 72
    db $a0, $0d ; volume $0D
    db $c2, $15 ; env $15
    db $a0, $0f ; volume $0F
    db $15, $0c ; note F1 dur 12
    db $15, $06 ; note F1 dur 6
    db $15, $06 ; note F1 dur 6
    db $c1, $30 ; env $30
    db $15, $0c ; note F1 dur 12
    db $a0, $06 ; volume $06
    db $15, $0c ; note F1 dur 12
    db $1f, $24 ; rest-note $1F dur 36
    db $c1, $30 ; env $30
    db $a2, $02 ; duty2 $02
    db $a0, $05 ; volume $05
    db $1f, $06 ; rest-note $1F dur 6
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
    db $a0, $0e ; volume $0E
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $0c ; volume $0C
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $a0, $05 ; volume $05
    db $3b, $06 ; note B3 dur 6
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
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4a, $06 ; note A#4 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $fd, $f0 ; label 0
    db $a0, $0d ; volume $0D
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $b1, $f0 ; repeat $F0
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $a0, $0b ; volume $0B
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $a0, $0d ; volume $0D
    db $fd, $f0 ; label 0
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $b4, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $14, $06 ; note E1 dur 6
    db $1f, $06 ; rest-note $1F dur 6
    db $a0, $0a ; volume $0A
    db $c2, $15 ; env $15
    db $20, $0c ; note C2 dur 12
    db $20, $0c ; note C2 dur 12
    db $c1, $30 ; env $30
    db $21, $12 ; note C#2 dur 18
    db $a0, $05 ; volume $05
    db $21, $06 ; note C#2 dur 6
    db $a0, $0b ; volume $0B
    db $c1, $50 ; env $50
    db $20, $0c ; note C2 dur 12
    db $c2, $15 ; env $15
    db $21, $0c ; note C#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $23, $06 ; note D#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $a0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $a0, $0b ; volume $0B
    db $23, $06 ; note D#2 dur 6
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $a0, $0d ; volume $0D
    db $25, $06 ; note F2 dur 6
    db $25, $06 ; note F2 dur 6
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $0d ; volume $0D
    db $a0, $0f ; volume $0F
    db $25, $06 ; note F2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $05 ; volume $05
    db $26, $06 ; note F#2 dur 6
    db $a0, $0f ; volume $0F
    db $26, $06 ; note F#2 dur 6
    db $27, $0c ; note G2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $06 ; volume $06
    db $23, $0c ; note D#2 dur 12
    db $a0, $0d ; volume $0D
    db $24, $0c ; note E2 dur 12
    db $a0, $06 ; volume $06
    db $24, $0c ; note E2 dur 12
    db $a0, $0c ; volume $0C
    db $c1, $7f ; env $7F
    db $25, $0c ; note F2 dur 12
    db $31, $24 ; note C#3 dur 36
    db $a0, $06 ; volume $06
    db $31, $0c ; note C#3 dur 12
    db $a0, $0c ; volume $0C
    db $fd, $f0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $b5, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $18, $0c ; note G#1 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $18, $0c ; note G#1 dur 12
    db $a0, $0a ; volume $0A
    db $22, $0c ; note D2 dur 12
    db $22, $0c ; note D2 dur 12
    db $22, $0c ; note D2 dur 12
    db $fd, $f0 ; label 0
    db $28, $0c ; note G#2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $28, $0c ; note G#2 dur 12
    db $a0, $0a ; volume $0A
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $32, $0c ; note D3 dur 12
    db $af, $01 ; param $01
    db $a2, $01 ; duty2 $01
    db $a0, $0f ; volume $0F
    db $a1, $00 ; duty $00
    db $c0, $fe ; env $FE
    db $14, $24 ; note E1 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $14, $0c ; note E1 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $17, $24 ; note G1 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $17, $0c ; note G1 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $1a, $24 ; note A#1 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $1a, $0c ; note A#1 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $21, $24 ; note C#2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $21, $0c ; note C#2 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $20, $24 ; note C2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $20, $0c ; note C2 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $25, $24 ; note F2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $25, $0c ; note F2 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $24, $24 ; note E2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $2a, $24 ; note A#2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $2a, $0c ; note A#2 dur 12
    db $c1, $30 ; env $30
    db $a0, $09 ; volume $09
    db $fd, $f0 ; label 0
    db $26, $0c ; note F#2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $05 ; volume $05
    db $26, $0c ; note F#2 dur 12
    db $a0, $0a ; volume $0A
    db $26, $0c ; note F#2 dur 12
    db $a0, $0c ; volume $0C
    db $26, $0c ; note F#2 dur 12
    db $a0, $0d ; volume $0D
    db $26, $0c ; note F#2 dur 12
    db $fd, $f0 ; label 0
    db $29, $0c ; note A2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $29, $0c ; note A2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $0f ; volume $0F
    db $29, $0c ; note A2 dur 12
    db $c1, $3f ; env $3F
    db $a0, $0f ; volume $0F
    db $38, $18 ; note G#3 dur 24
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $37, $06 ; note G3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $32, $06 ; note D3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $2a, $06 ; note A#2 dur 6
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
    db $1b, $06 ; note B1 dur 6
    db $1a, $06 ; note A#1 dur 6
    db $19, $06 ; note A1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $16, $06 ; note F#1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $a0, $0c ; volume $0C
    db $c1, $50 ; env $50
    db $1f, $0c ; rest-note $1F dur 12
    db $16, $0c ; note F#1 dur 12
    db $fd, $f0 ; label 0
    db $a0, $08 ; volume $08
    db $16, $0c ; note F#1 dur 12
    db $a0, $0c ; volume $0C
    db $16, $0c ; note F#1 dur 12
    db $b6, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $16, $0c ; note F#1 dur 12
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $fd, $f0 ; label 0
    db $a0, $08 ; volume $08
    db $19, $0c ; note A1 dur 12
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $19, $0c ; note A1 dur 12
    db $a0, $0c ; volume $0C
    db $1b, $0c ; note B1 dur 12
    db $fd, $f0 ; label 0
    db $a0, $08 ; volume $08
    db $1b, $0c ; note B1 dur 12
    db $a0, $0c ; volume $0C
    db $1b, $0c ; note B1 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $1b, $0c ; note B1 dur 12
    db $a0, $0c ; volume $0C
    db $20, $0c ; note C2 dur 12
    db $fd, $f0 ; label 0
    db $a0, $08 ; volume $08
    db $20, $0c ; note C2 dur 12
    db $a0, $0c ; volume $0C
    db $20, $0c ; note C2 dur 12
    db $b2, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $20, $0c ; note C2 dur 12
    db $a0, $0c ; volume $0C
    db $23, $0c ; note D#2 dur 12
    db $a0, $08 ; volume $08
    db $23, $0c ; note D#2 dur 12
    db $a0, $0c ; volume $0C
    db $23, $0c ; note D#2 dur 12
    db $a0, $0e ; volume $0E
    db $20, $06 ; note C2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $a0, $0c ; volume $0C
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $a0, $08 ; volume $08
    db $21, $06 ; note C#2 dur 6
    db $a0, $0c ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $20, $06 ; note C2 dur 6
    db $a0, $08 ; volume $08
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $1b, $06 ; note B1 dur 6
    db $1b, $06 ; note B1 dur 6
    db $a0, $08 ; volume $08
    db $1b, $06 ; note B1 dur 6
    db $a0, $0c ; volume $0C
    db $1b, $06 ; note B1 dur 6
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $1a, $06 ; note A#1 dur 6
    db $1a, $06 ; note A#1 dur 6
    db $a0, $08 ; volume $08
    db $1a, $06 ; note A#1 dur 6
    db $a0, $0c ; volume $0C
    db $1a, $06 ; note A#1 dur 6
    db $b1, $f0 ; repeat $F0
    db $19, $06 ; note A1 dur 6
    db $19, $06 ; note A1 dur 6
    db $a0, $08 ; volume $08
    db $19, $06 ; note A1 dur 6
    db $a0, $0c ; volume $0C
    db $19, $06 ; note A1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $a0, $08 ; volume $08
    db $18, $06 ; note G#1 dur 6
    db $a0, $0c ; volume $0C
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $1b, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $af, $01 ; param $01
    db $a2, $01 ; duty2 $01
    db $a0, $0a ; volume $0A
    db $a1, $00 ; duty $00
    db $c1, $50 ; env $50
    db $fd, $f0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $bf, $f0 ; repeat $F0
    db $c1, $20 ; env $20
    db $23, $06 ; note D#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $a0, $08 ; volume $08
    db $23, $06 ; note D#2 dur 6
    db $a0, $0c ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $22, $06 ; note D2 dur 6
    db $a0, $08 ; volume $08
    db $22, $06 ; note D2 dur 6
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $a0, $08 ; volume $08
    db $21, $06 ; note C#2 dur 6
    db $a0, $0c ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $20, $06 ; note C2 dur 6
    db $20, $06 ; note C2 dur 6
    db $a0, $08 ; volume $08
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $c0, $fe ; env $FE
    db $1b, $48 ; note B1 dur 72
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $1b, $18 ; note B1 dur 24
    db $a0, $0c ; volume $0C
    db $c2, $15 ; env $15
    db $fd, $f0 ; label 0
    db $19, $0c ; note A1 dur 12
    db $27, $0c ; note G2 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $17, $0c ; note G1 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $19, $0c ; note A1 dur 12
    db $27, $0c ; note G2 dur 12
    db $b3, $f0 ; repeat $F0
    db $c1, $30 ; env $30
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3b, $06 ; note B3 dur 6
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
    db $c0, $fe ; env $FE
    db $12, $24 ; note D1 dur 36
    db $a0, $08 ; volume $08
    db $12, $0c ; note D1 dur 12
    db $a0, $0c ; volume $0C
    db $15, $24 ; note F1 dur 36
    db $a0, $08 ; volume $08
    db $15, $0c ; note F1 dur 12
    db $a0, $0c ; volume $0C
    db $18, $24 ; note G#1 dur 36
    db $a0, $08 ; volume $08
    db $18, $0c ; note G#1 dur 12
    db $a0, $0c ; volume $0C
    db $17, $24 ; note G1 dur 36
    db $a0, $08 ; volume $08
    db $17, $0c ; note G1 dur 12
    db $a0, $0c ; volume $0C
    db $15, $24 ; note F1 dur 36
    db $a0, $08 ; volume $08
    db $15, $0c ; note F1 dur 12
    db $a0, $0c ; volume $0C
    db $13, $24 ; note D#1 dur 36
    db $a0, $08 ; volume $08
    db $13, $0c ; note D#1 dur 12
    db $a0, $0c ; volume $0C
    db $12, $24 ; note D1 dur 36
    db $a0, $08 ; volume $08
    db $12, $0c ; note D1 dur 12
    db $a0, $0c ; volume $0C
    db $11, $24 ; note C#1 dur 36
    db $a0, $08 ; volume $08
    db $11, $0c ; note C#1 dur 12
    db $a0, $0c ; volume $0C
    db $12, $a8 ; note D1 dur 168
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $12, $18 ; note D1 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 461 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_14::
    db $01, $01, $0c, $00 ; header: param=1 byte1=$01 volume=$0C byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $00 ; duty2 $00
    db $a0, $0c ; volume $0C
    db $c2, $15 ; env $15
    db $34, $06 ; note E3 dur 6
    db $34, $06 ; note E3 dur 6
    db $c1, $30 ; env $30
    db $34, $0c ; note E3 dur 12
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a2, $02 ; duty2 $02
    db $a0, $05 ; volume $05
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
    db $a2, $01 ; duty2 $01
    db $c2, $15 ; env $15
    db $a0, $0f ; volume $0F
    db $1b, $0c ; note B1 dur 12
    db $1b, $06 ; note B1 dur 6
    db $1b, $06 ; note B1 dur 6
    db $c1, $30 ; env $30
    db $1b, $0c ; note B1 dur 12
    db $a0, $06 ; volume $06
    db $1b, $06 ; note B1 dur 6
    db $a2, $02 ; duty2 $02
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $a2, $00 ; duty2 $00
    db $32, $06 ; note D3 dur 6
    db $39, $06 ; note A3 dur 6
    db $c0, $fe ; env $FE
    db $38, $90 ; note G#3 dur 144
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $a3, $08 ; mod $08
    db $38, $18 ; note G#3 dur 24
    db $a0, $0f ; volume $0F
    db $c1, $30 ; env $30
    db $37, $06 ; note G3 dur 6
    db $35, $06 ; note F3 dur 6
    db $c1, $7f ; env $7F
    db $32, $18 ; note D3 dur 24
    db $a0, $06 ; volume $06
    db $32, $18 ; note D3 dur 24
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0d ; volume $0D
    db $a2, $02 ; duty2 $02
    db $c1, $20 ; env $20
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
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4a, $06 ; note A#4 dur 6
    db $1f, $18 ; rest-note $1F dur 24
    db $c1, $30 ; env $30
    db $a2, $00 ; duty2 $00
    db $32, $06 ; note D3 dur 6
    db $39, $06 ; note A3 dur 6
    db $c0, $fe ; env $FE
    db $38, $54 ; note G#3 dur 84
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $38, $18 ; note G#3 dur 24
    db $a2, $02 ; duty2 $02
    db $a0, $0f ; volume $0F
    db $c1, $25 ; env $25
    db $a2, $02 ; duty2 $02
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $08 ; volume $08
    db $2b, $06 ; note B2 dur 6
    db $1f, $1e ; rest-note $1F dur 30
    db $a2, $00 ; duty2 $00
    db $a0, $0d ; volume $0D
    db $c1, $30 ; env $30
    db $39, $06 ; note A3 dur 6
    db $40, $06 ; note C4 dur 6
    db $c1, $7f ; env $7F
    db $42, $18 ; note D4 dur 24
    db $a0, $08 ; volume $08
    db $42, $18 ; note D4 dur 24
    db $1f, $18 ; rest-note $1F dur 24
    db $a2, $02 ; duty2 $02
    db $a0, $0d ; volume $0D
    db $c1, $1f ; env $1F
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
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4a, $06 ; note A#4 dur 6
    db $a0, $08 ; volume $08
    db $4a, $0c ; note A#4 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0a ; volume $0A
    db $c2, $15 ; env $15
    db $27, $0c ; note G2 dur 12
    db $27, $0c ; note G2 dur 12
    db $c1, $30 ; env $30
    db $29, $12 ; note A2 dur 18
    db $a0, $05 ; volume $05
    db $29, $06 ; note A2 dur 6
    db $a0, $0a ; volume $0A
    db $c1, $50 ; env $50
    db $27, $0c ; note G2 dur 12
    db $c2, $15 ; env $15
    db $29, $0c ; note A2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $c1, $2f ; env $2F
    db $2b, $06 ; note B2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $0a ; volume $0A
    db $2b, $06 ; note B2 dur 6
    db $a0, $0c ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $0c ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $a0, $0d ; volume $0D
    db $31, $06 ; note C#3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $0d ; volume $0D
    db $31, $06 ; note C#3 dur 6
    db $a0, $0e ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $0e ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $c1, $5f ; env $5F
    db $33, $0c ; note D#3 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $a0, $0e ; volume $0E
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $0c ; note G2 dur 12
    db $a0, $0e ; volume $0E
    db $28, $0c ; note G#2 dur 12
    db $c1, $7f ; env $7F
    db $34, $24 ; note E3 dur 36
    db $a0, $06 ; volume $06
    db $34, $0c ; note E3 dur 12
    db $a0, $0e ; volume $0E
    db $fd, $f0 ; label 0
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $b5, $f0 ; repeat $F0
    db $c2, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $fd, $f0 ; label 0
    db $1b, $0c ; note B1 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $1b, $0c ; note B1 dur 12
    db $a0, $0a ; volume $0A
    db $25, $0c ; note F2 dur 12
    db $25, $0c ; note F2 dur 12
    db $25, $0c ; note F2 dur 12
    db $fd, $f0 ; label 0
    db $2b, $0c ; note B2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $a0, $0a ; volume $0A
    db $35, $0c ; note F3 dur 12
    db $35, $0c ; note F3 dur 12
    db $35, $0c ; note F3 dur 12
    db $af, $01 ; param $01
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $a1, $00 ; duty $00
    db $c1, $20 ; env $20
    db $fd, $f0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $39, $06 ; note A3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $37, $06 ; note G3 dur 6
    db $39, $06 ; note A3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $b7, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $29, $0c ; note A2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $05 ; volume $05
    db $29, $0c ; note A2 dur 12
    db $a0, $0a ; volume $0A
    db $29, $0c ; note A2 dur 12
    db $a0, $0d ; volume $0D
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $29, $0c ; note A2 dur 12
    db $fd, $f0 ; label 0
    db $30, $0c ; note C3 dur 12
    db $b3, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $30, $0c ; note C3 dur 12
    db $a0, $0e ; volume $0E
    db $30, $0c ; note C3 dur 12
    db $30, $0c ; note C3 dur 12
    db $a0, $0f ; volume $0F
    db $30, $0c ; note C3 dur 12
    db $a0, $06 ; volume $06
    db $c0, $fe ; env $FE
    db $38, $90 ; note G#3 dur 144
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $38, $30 ; note G#3 dur 48
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $0c ; volume $0C
    db $c1, $30 ; env $30
    db $19, $0c ; note A1 dur 12
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $19, $0c ; note A1 dur 12
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $b5, $f0 ; repeat $F0
    db $a0, $06 ; volume $06
    db $19, $0c ; note A1 dur 12
    db $a0, $0d ; volume $0D
    db $a2, $02 ; duty2 $02
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $c1, $60 ; env $60
    db $31, $24 ; note C#3 dur 36
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $30, $06 ; note C3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $c2, $15 ; env $15
    db $2a, $0c ; note A#2 dur 12
    db $37, $0c ; note G3 dur 12
    db $c1, $7f ; env $7F
    db $36, $0c ; note F#3 dur 12
    db $c2, $15 ; env $15
    db $35, $0c ; note F3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $0a ; mod $0A
    db $44, $30 ; note E4 dur 48
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $44, $0c ; note E4 dur 12
    db $a3, $0a ; mod $0A
    db $a0, $0e ; volume $0E
    db $43, $06 ; note D#4 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $30 ; note F3 dur 48
    db $a0, $08 ; volume $08
    db $a3, $00 ; mod $00
    db $35, $0c ; note F3 dur 12
    db $a0, $0e ; volume $0E
    db $a3, $0a ; mod $0A
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $32, $0c ; note D3 dur 12
    db $c2, $15 ; env $15
    db $40, $0c ; note C4 dur 12
    db $c0, $fe ; env $FE
    db $37, $3c ; note G3 dur 60
    db $a0, $08 ; volume $08
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $37, $0c ; note G3 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0e ; volume $0E
    db $a3, $0a ; mod $0A
    db $c0, $fe ; env $FE
    db $39, $18 ; note A3 dur 24
    db $a0, $08 ; volume $08
    db $c1, $fe ; env $FE
    db $a3, $00 ; mod $00
    db $39, $18 ; note A3 dur 24
    db $a0, $0e ; volume $0E
    db $a3, $0a ; mod $0A
    db $43, $12 ; note D#4 dur 18
    db $a0, $08 ; volume $08
    db $43, $06 ; note D#4 dur 6
    db $a0, $0e ; volume $0E
    db $42, $12 ; note D4 dur 18
    db $a0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $a0, $0e ; volume $0E
    db $41, $0c ; note C#4 dur 12
    db $38, $0c ; note G#3 dur 12
    db $37, $12 ; note G3 dur 18
    db $a0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $a0, $0e ; volume $0E
    db $36, $12 ; note F#3 dur 18
    db $a0, $08 ; volume $08
    db $36, $06 ; note F#3 dur 6
    db $a0, $0e ; volume $0E
    db $35, $06 ; note F3 dur 6
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $29, $2a ; note A2 dur 42
    db $a0, $08 ; volume $08
    db $29, $06 ; note A2 dur 6
    db $a3, $00 ; mod $00
    db $a0, $0e ; volume $0E
    db $a3, $0a ; mod $0A
    db $2a, $12 ; note A#2 dur 18
    db $a0, $08 ; volume $08
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $2b, $48 ; note B2 dur 72
    db $a0, $08 ; volume $08
    db $a3, $00 ; mod $00
    db $2b, $18 ; note B2 dur 24
    db $af, $01 ; param $01
    db $a2, $01 ; duty2 $01
    db $a0, $0e ; volume $0E
    db $a1, $00 ; duty $00
    db $c0, $fe ; env $FE
    db $1f, $18 ; rest-note $1F dur 24
    db $29, $0c ; note A2 dur 12
    db $a0, $08 ; volume $08
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $c1, $30 ; env $30
    db $29, $10 ; note A2 dur 16
    db $29, $10 ; note A2 dur 16
    db $27, $10 ; note G2 dur 16
    db $c0, $fe ; env $FE
    db $30, $18 ; note C3 dur 24
    db $a0, $08 ; volume $08
    db $30, $0c ; note C3 dur 12
    db $a0, $0e ; volume $0E
    db $2a, $0c ; note A#2 dur 12
    db $29, $18 ; note A2 dur 24
    db $a0, $08 ; volume $08
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $27, $0c ; note G2 dur 12
    db $26, $06 ; note F#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $29, $48 ; note A2 dur 72
    db $a0, $08 ; volume $08
    db $29, $18 ; note A2 dur 24
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $0f ; volume $0F
    db $27, $06 ; note G2 dur 6
    db $a0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $a0, $0f ; volume $0F
    db $25, $06 ; note F2 dur 6
    db $a0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $a0, $0f ; volume $0F
    db $23, $06 ; note D#2 dur 6
    db $a0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $a0, $0d ; volume $0D
    db $22, $a8 ; note D2 dur 168
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $22, $18 ; note D2 dur 24
    db $a0, $0e ; volume $0E
    db $c0, $fe ; env $FE
    db $21, $48 ; note C#2 dur 72
    db $a0, $08 ; volume $08
    db $a0, $08 ; volume $08
    db $21, $18 ; note C#2 dur 24
    db $a0, $0e ; volume $0E
    db $c0, $fe ; env $FE
    db $1b, $24 ; note B1 dur 36
    db $a0, $08 ; volume $08
    db $1b, $0c ; note B1 dur 12
    db $a0, $0e ; volume $0E
    db $21, $24 ; note C#2 dur 36
    db $a0, $08 ; volume $08
    db $21, $0c ; note C#2 dur 12
    db $a0, $0a ; volume $0A
    db $a2, $02 ; duty2 $02
    db $c1, $1f ; env $1F
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $32, $06 ; note D3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $b5, $f0 ; repeat $F0
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 413 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_15::
    db $01, $30, $02, $02 ; header: param=1 byte1=$30 volume=$02 byte3=$02
    db $fd, $f3 ; label 3
    db $fd, $f1 ; label 1
    db $a0, $02 ; volume $02
    db $a1, $02 ; duty $02
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $25, $06 ; note F2 dur 6
    db $24, $06 ; note E2 dur 6
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $b1, $f0 ; repeat $F0
    db $b9, $f1 ; repeat $F1
    db $a2, $28 ; duty2 $28
    db $22, $0c ; note D2 dur 12
    db $a2, $15 ; duty2 $15
    db $28, $0c ; note G#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $a2, $30 ; duty2 $30
    db $27, $12 ; note G2 dur 18
    db $a0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $a2, $50 ; duty2 $50
    db $28, $0c ; note G#2 dur 12
    db $a2, $15 ; duty2 $15
    db $27, $0c ; note G2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a0, $04 ; volume $04
    db $a2, $ff ; duty2 $FF
    db $25, $12 ; note F2 dur 18
    db $a0, $06 ; volume $06
    db $25, $06 ; note F2 dur 6
    db $a0, $04 ; volume $04
    db $24, $12 ; note E2 dur 18
    db $a0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $a0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $a0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $21, $0c ; note C#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $26, $18 ; note F#2 dur 24
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $02 ; volume $02
    db $30, $12 ; note C3 dur 18
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $29, $12 ; note A2 dur 18
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $2a, $12 ; note A#2 dur 18
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a2, $20 ; duty2 $20
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $27, $0c ; note G2 dur 12
    db $27, $0c ; note G2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $31, $0c ; note C#3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $37, $0c ; note G3 dur 12
    db $37, $0c ; note G3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a0, $06 ; volume $06
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $41, $0c ; note C#4 dur 12
    db $41, $0c ; note C#4 dur 12
    db $3b, $0c ; note B3 dur 12
    db $af, $01 ; param $01
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $a1, $0a ; duty $0A
    db $19, $24 ; note A1 dur 36
    db $a0, $04 ; volume $04
    db $19, $0c ; note A1 dur 12
    db $a0, $02 ; volume $02
    db $20, $24 ; note C2 dur 36
    db $a0, $04 ; volume $04
    db $20, $0c ; note C2 dur 12
    db $a0, $02 ; volume $02
    db $23, $24 ; note D#2 dur 36
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $26, $24 ; note F#2 dur 36
    db $a0, $04 ; volume $04
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $29, $24 ; note A2 dur 36
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $26, $24 ; note F#2 dur 36
    db $a0, $04 ; volume $04
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $31, $24 ; note C#3 dur 36
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $a0, $02 ; volume $02
    db $2b, $24 ; note B2 dur 36
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $a1, $09 ; duty $09
    db $a2, $20 ; duty2 $20
    db $a0, $02 ; volume $02
    db $35, $0c ; note F3 dur 12
    db $35, $0c ; note F3 dur 12
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $04 ; volume $04
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $38, $0c ; note G#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $04 ; volume $04
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $06 ; volume $06
    db $33, $0c ; note D#3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a0, $02 ; volume $02
    db $a1, $02 ; duty $02
    db $44, $06 ; note E4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $3a, $06 ; note A#3 dur 6
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
    db $2b, $06 ; note B2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $24, $06 ; note E2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $a1, $09 ; duty $09
    db $a2, $ff ; duty2 $FF
    db $fd, $f0 ; label 0
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $22, $0c ; note D2 dur 12
    db $b3, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $23, $0c ; note D#2 dur 12
    db $a1, $09 ; duty $09
    db $26, $0c ; note F#2 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $0c ; note A#1 dur 12
    db $a1, $09 ; duty $09
    db $26, $0c ; note F#2 dur 12
    db $a1, $0b ; duty $0B
    db $13, $0c ; note D#1 dur 12
    db $a1, $09 ; duty $09
    db $26, $0c ; note F#2 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $0c ; note A#1 dur 12
    db $a1, $09 ; duty $09
    db $26, $0c ; note F#2 dur 12
    db $fd, $f0 ; label 0
    db $a1, $0b ; duty $0B
    db $15, $0c ; note F1 dur 12
    db $a1, $09 ; duty $09
    db $28, $0c ; note G#2 dur 12
    db $a1, $0b ; duty $0B
    db $20, $0c ; note C2 dur 12
    db $a1, $09 ; duty $09
    db $28, $0c ; note G#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a1, $0b ; duty $0B
    db $16, $0c ; note F#1 dur 12
    db $a1, $09 ; duty $09
    db $29, $0c ; note A2 dur 12
    db $a1, $0b ; duty $0B
    db $21, $0c ; note C#2 dur 12
    db $a1, $09 ; duty $09
    db $29, $0c ; note A2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $19, $0c ; note A1 dur 12
    db $a1, $09 ; duty $09
    db $30, $0c ; note C3 dur 12
    db $a1, $0b ; duty $0B
    db $24, $0c ; note E2 dur 12
    db $a1, $09 ; duty $09
    db $30, $0c ; note C3 dur 12
    db $a1, $02 ; duty $02
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4a, $06 ; note A#4 dur 6
    db $a1, $09 ; duty $09
    db $a2, $10 ; duty2 $10
    db $fd, $f0 ; label 0
    db $2a, $06 ; note A#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $29, $06 ; note A2 dur 6
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $a0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $a0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $27, $06 ; note G2 dur 6
    db $27, $06 ; note G2 dur 6
    db $a0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $b1, $f0 ; repeat $F0
    db $26, $06 ; note F#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $04 ; volume $04
    db $26, $06 ; note F#2 dur 6
    db $a0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $25, $06 ; note F2 dur 6
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a1, $02 ; duty $02
    db $a2, $20 ; duty2 $20
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $af, $01 ; param $01
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $a1, $02 ; duty $02
    db $fd, $f0 ; label 0
    db $2a, $06 ; note A#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $bf, $f0 ; repeat $F0
    db $a2, $10 ; duty2 $10
    db $30, $06 ; note C3 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $02 ; volume $02
    db $2b, $06 ; note B2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $29, $06 ; note A2 dur 6
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a2, $ff ; duty2 $FF
    db $28, $48 ; note G#2 dur 72
    db $a0, $04 ; volume $04
    db $28, $18 ; note G#2 dur 24
    db $a2, $10 ; duty2 $10
    db $a0, $02 ; volume $02
    db $fd, $f0 ; label 0
    db $27, $0c ; note G2 dur 12
    db $33, $0c ; note D#3 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $24, $0c ; note E2 dur 12
    db $37, $0c ; note G3 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $23, $0c ; note D#2 dur 12
    db $34, $0c ; note E3 dur 12
    db $b3, $f0 ; repeat $F0
    db $a2, $30 ; duty2 $30
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
    db $a2, $ff ; duty2 $FF
    db $12, $24 ; note D1 dur 36
    db $a0, $04 ; volume $04
    db $12, $0c ; note D1 dur 12
    db $a0, $02 ; volume $02
    db $15, $24 ; note F1 dur 36
    db $a0, $04 ; volume $04
    db $15, $0c ; note F1 dur 12
    db $a0, $02 ; volume $02
    db $18, $24 ; note G#1 dur 36
    db $a0, $04 ; volume $04
    db $18, $0c ; note G#1 dur 12
    db $a0, $02 ; volume $02
    db $17, $24 ; note G1 dur 36
    db $a0, $04 ; volume $04
    db $17, $0c ; note G1 dur 12
    db $a0, $02 ; volume $02
    db $15, $24 ; note F1 dur 36
    db $a0, $04 ; volume $04
    db $15, $0c ; note F1 dur 12
    db $a0, $02 ; volume $02
    db $13, $24 ; note D#1 dur 36
    db $a0, $04 ; volume $04
    db $13, $0c ; note D#1 dur 12
    db $a0, $02 ; volume $02
    db $12, $24 ; note D1 dur 36
    db $a0, $04 ; volume $04
    db $12, $0c ; note D1 dur 12
    db $a0, $02 ; volume $02
    db $11, $24 ; note C#1 dur 36
    db $a0, $04 ; volume $04
    db $11, $0c ; note C#1 dur 12
    db $a0, $02 ; volume $02
    db $12, $a8 ; note D1 dur 168
    db $a0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 562 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_16::
    db $07, $01, $09, $00 ; header: param=7 byte1=$01 volume=$09 byte3=$00
    db $c2, $3f ; env $3F
    db $a3, $08 ; mod $08
    db $a0, $0a ; volume $0A
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $0c ; note F3 dur 12
    db $a0, $0a ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $32, $0c ; note D3 dur 12
    db $a0, $0a ; volume $0A
    db $2b, $06 ; note B2 dur 6
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $25, $06 ; note F2 dur 6
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $0e ; volume $0E
    db $22, $06 ; note D2 dur 6
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a0, $0e ; volume $0E
    db $25, $06 ; note F2 dur 6
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a2, $02 ; duty2 $02
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $37, $0c ; note G3 dur 12
    db $fd, $f3 ; label 3
    db $ac, $01 ; call x1
    dw $02b4 ; byte offset of the called section from the track start
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $24, $0c ; note E2 dur 12
    db $a0, $0a ; volume $0A
    db $c3, $60 ; env $60
    db $29, $0c ; note A2 dur 12
    db $25, $0c ; note F2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $07 ; volume $07
    db $c0, $fe ; env $FE
    db $24, $0c ; note E2 dur 12
    db $a0, $04 ; volume $04
    db $c1, $7f ; env $7F
    db $24, $24 ; note E2 dur 36
    db $a2, $00 ; duty2 $00
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $07 ; volume $07
    db $29, $20 ; note A2 dur 32
    db $c1, $5f ; env $5F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $29, $10 ; note A2 dur 16
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $28, $18 ; note G#2 dur 24
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a3, $fe ; mod $FE
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $34, $18 ; note E3 dur 24
    db $30, $18 ; note C3 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $24 ; note F2 dur 36
    db $c1, $5f ; env $5F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $28, $18 ; note G#2 dur 24
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $34, $20 ; note E3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $34, $10 ; note E3 dur 16
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $32, $1c ; note D3 dur 28
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $32, $14 ; note D3 dur 20
    db $a0, $08 ; volume $08
    db $a3, $0c ; mod $0C
    db $c0, $fe ; env $FE
    db $a3, $08 ; mod $08
    db $32, $18 ; note D3 dur 24
    db $34, $0c ; note E3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $08 ; volume $08
    db $a3, $0c ; mod $0C
    db $c0, $fe ; env $FE
    db $37, $18 ; note G3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3b, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $a3, $08 ; mod $08
    db $a0, $0b ; volume $0B
    db $c3, $68 ; env $68
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a3, $fe ; mod $FE
    db $a0, $09 ; volume $09
    db $c0, $fe ; env $FE
    db $27, $30 ; note G2 dur 48
    db $a3, $08 ; mod $08
    db $25, $0c ; note F2 dur 12
    db $c1, $5f ; env $5F
    db $a0, $06 ; volume $06
    db $25, $18 ; note F2 dur 24
    db $a2, $02 ; duty2 $02
    db $37, $0c ; note G3 dur 12
    db $ac, $01 ; call x1
    dw $02b4 ; byte offset of the called section from the track start
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $24, $0c ; note E2 dur 12
    db $a0, $0a ; volume $0A
    db $c3, $60 ; env $60
    db $29, $0c ; note A2 dur 12
    db $25, $0c ; note F2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $07 ; volume $07
    db $c0, $fe ; env $FE
    db $24, $0c ; note E2 dur 12
    db $c1, $5f ; env $5F
    db $a0, $04 ; volume $04
    db $24, $18 ; note E2 dur 24
    db $a2, $02 ; duty2 $02
    db $a3, $06 ; mod $06
    db $a0, $04 ; volume $04
    db $1a, $0c ; note A#1 dur 12
    db $a0, $06 ; volume $06
    db $a2, $01 ; duty2 $01
    db $c1, $7f ; env $7F
    db $fd, $f0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $fd, $f0 ; label 0
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $44, $06 ; note E4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
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
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $a0, $07 ; volume $07
    db $23, $06 ; note D#2 dur 6
    db $1a, $06 ; note A#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $ac, $01 ; call x1
    dw $0340 ; byte offset of the called section from the track start
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $a0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $a0, $08 ; volume $08
    db $23, $06 ; note D#2 dur 6
    db $1a, $06 ; note A#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $ac, $01 ; call x1
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
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $a0, $05 ; volume $05
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $0c ; note B2 dur 12
    db $c1, $4f ; env $4F
    db $a0, $06 ; volume $06
    db $2b, $18 ; note B2 dur 24
    db $a2, $02 ; duty2 $02
    db $a0, $05 ; volume $05
    db $37, $0c ; note G3 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end
    db $a3, $08 ; mod $08
    db $39, $0c ; note A3 dur 12
    db $a2, $00 ; duty2 $00
    db $c1, $7f ; env $7F
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $a0, $05 ; volume $05
    db $24, $06 ; note E2 dur 6
    db $a0, $0a ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $a0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $29, $12 ; note A2 dur 18
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $b2, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $20, $12 ; note C2 dur 18
    db $a0, $04 ; volume $04
    db $20, $06 ; note C2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $12 ; note G2 dur 18
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $12 ; note G2 dur 18
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $12 ; note G2 dur 18
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $a0, $09 ; volume $09
    db $21, $12 ; note C#2 dur 18
    db $a0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $fd, $f0 ; label 0
    db $a0, $0b ; volume $0B
    db $28, $12 ; note G#2 dur 18
    db $a0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $28, $12 ; note G#2 dur 18
    db $a0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $b1, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $27, $18 ; note G2 dur 24
    db $a0, $0a ; volume $0A
    db $29, $0c ; note A2 dur 12
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $25, $20 ; note F2 dur 32
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $25, $10 ; note F2 dur 16
    db $c1, $70 ; env $70
    db $a0, $0a ; volume $0A
    db $29, $18 ; note A2 dur 24
    db $a0, $0b ; volume $0B
    db $2b, $18 ; note B2 dur 24
    db $ad, $00 ; return $00
    db $fd, $f1 ; label 1
    db $fd, $f0 ; label 0
    db $a0, $0c ; volume $0C
    db $c1, $40 ; env $40
    db $18, $0c ; note G#1 dur 12
    db $c1, $4f ; env $4F
    db $18, $24 ; note G#1 dur 36
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $09 ; volume $09
    db $c1, $40 ; env $40
    db $23, $0c ; note D#2 dur 12
    db $c1, $4f ; env $4F
    db $23, $24 ; note D#2 dur 36
    db $b1, $f0 ; repeat $F0
    db $b1, $f1 ; repeat $F1
    db $fd, $f0 ; label 0
    db $a0, $09 ; volume $09
    db $c1, $40 ; env $40
    db $23, $0c ; note D#2 dur 12
    db $c1, $4f ; env $4F
    db $23, $24 ; note D#2 dur 36
    db $b1, $f0 ; repeat $F0
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $1a, $18 ; note A#1 dur 24
    db $20, $18 ; note C2 dur 24
    db $22, $18 ; note D2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $30, $0c ; note C3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $25, $0c ; note F2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a0, $0f ; volume $0F
    db $1a, $12 ; note A#1 dur 18
    db $20, $0f ; note C2 dur 15
    db $a0, $0c ; volume $0C
    db $21, $0f ; note C#2 dur 15
    db $a0, $0a ; volume $0A
    db $22, $0c ; note D2 dur 12
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $22, $18 ; note D2 dur 24
    db $a2, $01 ; duty2 $01
    db $c0, $fe ; env $FE
    db $a0, $03 ; volume $03
    db $2a, $0c ; note A#2 dur 12
    db $a2, $01 ; duty2 $01
    db $c1, $7f ; env $7F
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $fd, $f0 ; label 0
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $b1, $f0 ; repeat $F0
    db $1f, $06 ; rest-note $1F dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $44, $06 ; note E4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $ad, $00 ; return $00

; sound track, 554 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_17::
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $a3, $0e ; mod $0E
    db $c2, $3f ; env $3F
    db $a0, $0d ; volume $0D
    db $40, $06 ; note C4 dur 6
    db $a0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $a0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $a0, $01 ; volume $01
    db $40, $06 ; note C4 dur 6
    db $a0, $0d ; volume $0D
    db $39, $06 ; note A3 dur 6
    db $a0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $a0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $a0, $01 ; volume $01
    db $39, $06 ; note A3 dur 6
    db $a0, $0d ; volume $0D
    db $35, $06 ; note F3 dur 6
    db $a0, $05 ; volume $05
    db $35, $06 ; note F3 dur 6
    db $a0, $03 ; volume $03
    db $35, $06 ; note F3 dur 6
    db $a0, $01 ; volume $01
    db $35, $06 ; note F3 dur 6
    db $a0, $0d ; volume $0D
    db $32, $06 ; note D3 dur 6
    db $a0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $a0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $a0, $01 ; volume $01
    db $32, $06 ; note D3 dur 6
    db $a0, $0d ; volume $0D
    db $2b, $06 ; note B2 dur 6
    db $a0, $05 ; volume $05
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $01 ; volume $01
    db $2b, $06 ; note B2 dur 6
    db $a0, $0d ; volume $0D
    db $29, $06 ; note A2 dur 6
    db $a0, $05 ; volume $05
    db $29, $06 ; note A2 dur 6
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $01 ; volume $01
    db $29, $06 ; note A2 dur 6
    db $a0, $0d ; volume $0D
    db $27, $06 ; note G2 dur 6
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $01 ; volume $01
    db $27, $06 ; note G2 dur 6
    db $a2, $02 ; duty2 $02
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $fd, $f3 ; label 3
    db $a3, $0e ; mod $0E
    db $ac, $01 ; call x1
    dw $0242 ; byte offset of the called section from the track start
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $30, $30 ; note C3 dur 48
    db $c1, $7f ; env $7F
    db $a3, $08 ; mod $08
    db $a0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $a3, $0c ; mod $0C
    db $a2, $01 ; duty2 $01
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $30, $18 ; note C3 dur 24
    db $a3, $fe ; mod $FE
    db $32, $20 ; note D3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $08 ; mod $08
    db $a0, $07 ; volume $07
    db $32, $10 ; note D3 dur 16
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $32, $18 ; note D3 dur 24
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a3, $fe ; mod $FE
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $37, $18 ; note G3 dur 24
    db $34, $18 ; note E3 dur 24
    db $30, $18 ; note C3 dur 24
    db $a3, $08 ; mod $08
    db $32, $24 ; note D3 dur 36
    db $c1, $5f ; env $5F
    db $a3, $08 ; mod $08
    db $a0, $08 ; volume $08
    db $32, $0c ; note D3 dur 12
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $32, $18 ; note D3 dur 24
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $a3, $fe ; mod $FE
    db $37, $20 ; note G3 dur 32
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $a3, $08 ; mod $08
    db $37, $10 ; note G3 dur 16
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $37, $18 ; note G3 dur 24
    db $a3, $fe ; mod $FE
    db $36, $1c ; note F#3 dur 28
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $a3, $08 ; mod $08
    db $36, $14 ; note F#3 dur 20
    db $a3, $08 ; mod $08
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $36, $18 ; note F#3 dur 24
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $a3, $0f ; mod $0F
    db $3b, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $42, $18 ; note D4 dur 24
    db $44, $18 ; note E4 dur 24
    db $45, $0c ; note F4 dur 12
    db $44, $0c ; note E4 dur 12
    db $42, $0c ; note D4 dur 12
    db $40, $0c ; note C4 dur 12
    db $3b, $0c ; note B3 dur 12
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a3, $08 ; mod $08
    db $34, $30 ; note E3 dur 48
    db $32, $0c ; note D3 dur 12
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $32, $0c ; note D3 dur 12
    db $c0, $fe ; env $FE
    db $a2, $02 ; duty2 $02
    db $a3, $0c ; mod $0C
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $ac, $01 ; call x1
    dw $0242 ; byte offset of the called section from the track start
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $30, $30 ; note C3 dur 48
    db $c1, $7f ; env $7F
    db $a3, $08 ; mod $08
    db $a0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $c3, $02 ; env $02
    db $1a, $0c ; note A#1 dur 12
    db $20, $0c ; note C2 dur 12
    db $27, $18 ; note G2 dur 24
    db $25, $0c ; note F2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $27, $18 ; note G2 dur 24
    db $25, $0c ; note F2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $22, $40 ; note D2 dur 64
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $22, $08 ; note D2 dur 8
    db $c3, $02 ; env $02
    db $a3, $26 ; mod $26
    db $a0, $0d ; volume $0D
    db $23, $0c ; note D#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $20, $18 ; note C2 dur 24
    db $22, $0c ; note D2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $18, $18 ; note G#1 dur 24
    db $1a, $0c ; note A#1 dur 12
    db $20, $0c ; note C2 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $20, $0c ; note C2 dur 12
    db $17, $28 ; note G1 dur 40
    db $c1, $5f ; env $5F
    db $a3, $20 ; mod $20
    db $a0, $0a ; volume $0A
    db $17, $14 ; note G1 dur 20
    db $a3, $26 ; mod $26
    db $c3, $02 ; env $02
    db $a0, $0c ; volume $0C
    db $17, $0a ; note G1 dur 10
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $17, $02 ; note G1 dur 2
    db $c3, $12 ; env $12
    db $a0, $0d ; volume $0D
    db $17, $0c ; note G1 dur 12
    db $15, $0c ; note F1 dur 12
    db $23, $28 ; note D#2 dur 40
    db $a0, $0a ; volume $0A
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $23, $08 ; note D#2 dur 8
    db $a3, $26 ; mod $26
    db $c3, $48 ; env $48
    db $a0, $0f ; volume $0F
    db $21, $0c ; note C#2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $20, $0c ; note C2 dur 12
    db $22, $0c ; note D2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $37, $0a ; note G3 dur 10
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $37, $02 ; note G3 dur 2
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $a3, $06 ; mod $06
    db $37, $0c ; note G3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $30, $18 ; note C3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $35, $18 ; note F3 dur 24
    db $33, $38 ; note D#3 dur 56
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $33, $10 ; note D#3 dur 16
    db $a2, $02 ; duty2 $02
    db $a0, $0f ; volume $0F
    db $a3, $09 ; mod $09
    db $c3, $58 ; env $58
    db $23, $18 ; note D#2 dur 24
    db $ac, $01 ; call x1
    dw $02ee ; byte offset of the called section from the track start
    db $c3, $7f ; env $7F
    db $23, $3c ; note D#2 dur 60
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $23, $0c ; note D#2 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $0f ; volume $0F
    db $a3, $09 ; mod $09
    db $c3, $58 ; env $58
    db $23, $18 ; note D#2 dur 24
    db $ac, $01 ; call x1
    dw $02ee ; byte offset of the called section from the track start
    db $a3, $fe ; mod $FE
    db $c3, $78 ; env $78
    db $a0, $0d ; volume $0D
    db $27, $90 ; note G2 dur 144
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $27, $18 ; note G2 dur 24
    db $a2, $02 ; duty2 $02
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end
    db $a0, $0d ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $a0, $0c ; volume $0C
    db $42, $0c ; note D4 dur 12
    db $40, $0c ; note C4 dur 12
    db $44, $18 ; note E4 dur 24
    db $42, $0c ; note D4 dur 12
    db $40, $0c ; note C4 dur 12
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $3b, $40 ; note B3 dur 64
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $3b, $08 ; note B3 dur 8
    db $c0, $fe ; env $FE
    db $a3, $0f ; mod $0F
    db $a0, $0c ; volume $0C
    db $40, $0c ; note C4 dur 12
    db $3b, $0c ; note B3 dur 12
    db $a0, $0b ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $a0, $0a ; volume $0A
    db $3b, $0c ; note B3 dur 12
    db $40, $0c ; note C4 dur 12
    db $a0, $09 ; volume $09
    db $35, $18 ; note F3 dur 24
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $34, $30 ; note E3 dur 48
    db $a3, $00 ; mod $00
    db $c1, $5f ; env $5F
    db $a0, $05 ; volume $05
    db $34, $0c ; note E3 dur 12
    db $a3, $00 ; mod $00
    db $c1, $50 ; env $50
    db $a0, $0a ; volume $0A
    db $34, $0c ; note E3 dur 12
    db $a3, $0c ; mod $0C
    db $c1, $7f ; env $7F
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $40, $24 ; note C4 dur 36
    db $a3, $02 ; mod $02
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $40, $0c ; note C4 dur 12
    db $c0, $fe ; env $FE
    db $a3, $0f ; mod $0F
    db $a0, $0a ; volume $0A
    db $3a, $0c ; note A#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $a0, $0b ; volume $0B
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $a0, $0c ; volume $0C
    db $3b, $0c ; note B3 dur 12
    db $40, $0c ; note C4 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $44, $18 ; note E4 dur 24
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $44, $0c ; note E4 dur 12
    db $a3, $0f ; mod $0F
    db $c1, $6f ; env $6F
    db $a0, $09 ; volume $09
    db $34, $0c ; note E3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $32, $18 ; note D3 dur 24
    db $ad, $00 ; return $00
    db $a2, $02 ; duty2 $02
    db $a3, $09 ; mod $09
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $25, $28 ; note F2 dur 40
    db $c1, $40 ; env $40
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $25, $08 ; note F2 dur 8
    db $a3, $09 ; mod $09
    db $c3, $68 ; env $68
    db $a0, $0f ; volume $0F
    db $25, $18 ; note F2 dur 24
    db $27, $0c ; note G2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $a3, $0f ; mod $0F
    db $2a, $18 ; note A#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $a3, $0b ; mod $0B
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $25, $26 ; note F2 dur 38
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $25, $0a ; note F2 dur 10
    db $a3, $09 ; mod $09
    db $c3, $68 ; env $68
    db $a0, $0f ; volume $0F
    db $25, $18 ; note F2 dur 24
    db $27, $0c ; note G2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $2a, $24 ; note A#2 dur 36
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $2a, $0c ; note A#2 dur 12
    db $c3, $58 ; env $58
    db $a3, $09 ; mod $09
    db $a0, $0f ; volume $0F
    db $2a, $18 ; note A#2 dur 24
    db $a3, $0b ; mod $0B
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $29, $26 ; note A2 dur 38
    db $c1, $70 ; env $70
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $29, $0a ; note A2 dur 10
    db $c3, $60 ; env $60
    db $a3, $09 ; mod $09
    db $a0, $0f ; volume $0F
    db $29, $18 ; note A2 dur 24
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $c4, $50 ; env $50
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
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $c3, $68 ; env $68
    db $38, $0c ; note G#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $27, $30 ; note G2 dur 48
    db $a0, $0b ; volume $0B
    db $25, $0c ; note F2 dur 12
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a3, $09 ; mod $09
    db $c3, $78 ; env $78
    db $a2, $00 ; duty2 $00
    db $a0, $0f ; volume $0F
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $37, $18 ; note G3 dur 24
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $37, $18 ; note G3 dur 24
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $0b ; volume $0B
    db $32, $30 ; note D3 dur 48
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $32, $18 ; note D3 dur 24
    db $a3, $09 ; mod $09
    db $c3, $78 ; env $78
    db $a0, $0f ; volume $0F
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $18 ; note C3 dur 24
    db $32, $0c ; note D3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $28, $18 ; note G#2 dur 24
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $27, $20 ; note G2 dur 32
    db $c1, $5f ; env $5F
    db $a3, $09 ; mod $09
    db $a0, $08 ; volume $08
    db $27, $10 ; note G2 dur 16
    db $c3, $78 ; env $78
    db $a0, $0f ; volume $0F
    db $27, $16 ; note G2 dur 22
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $c3, $58 ; env $58
    db $a0, $0f ; volume $0F
    db $27, $0c ; note G2 dur 12
    db $c3, $68 ; env $68
    db $25, $0c ; note F2 dur 12
    db $a3, $fe ; mod $FE
    db $a0, $0c ; volume $0C
    db $c0, $fe ; env $FE
    db $33, $20 ; note D#3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $33, $10 ; note D#3 dur 16
    db $a3, $09 ; mod $09
    db $a0, $0d ; volume $0D
    db $c3, $78 ; env $78
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $37, $1c ; note G3 dur 28
    db $c1, $7f ; env $7F
    db $a3, $09 ; mod $09
    db $a0, $08 ; volume $08
    db $37, $08 ; note G3 dur 8
    db $c4, $2f ; env $2F
    db $a0, $0b ; volume $0B
    db $27, $0c ; note G2 dur 12
    db $a0, $0f ; volume $0F
    db $c3, $68 ; env $68
    db $27, $0c ; note G2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $20, $18 ; note C2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $25, $18 ; note F2 dur 24
    db $ad, $00 ; return $00

; sound track, 572 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_18::
    db $07, $20, $02, $08 ; header: param=7 byte1=$20 volume=$02 byte3=$08
    db $a3, $0c ; mod $0C
    db $a0, $02 ; volume $02
    db $42, $06 ; note D4 dur 6
    db $a0, $04 ; volume $04
    db $42, $06 ; note D4 dur 6
    db $a0, $06 ; volume $06
    db $42, $0c ; note D4 dur 12
    db $a0, $02 ; volume $02
    db $3b, $06 ; note B3 dur 6
    db $a0, $04 ; volume $04
    db $3b, $06 ; note B3 dur 6
    db $a0, $06 ; volume $06
    db $3b, $0c ; note B3 dur 12
    db $a0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $0c ; note G3 dur 12
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $0c ; note F3 dur 12
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $2b, $06 ; note B2 dur 6
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $06 ; note B2 dur 6
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $fd, $f3 ; label 3
    db $ac, $01 ; call x1
    dw $01ec ; byte offset of the called section from the track start
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $10, $0c ; note C1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $20, $0c ; note C2 dur 12
    db $a0, $04 ; volume $04
    db $20, $0c ; note C2 dur 12
    db $a0, $02 ; volume $02
    db $20, $0c ; note C2 dur 12
    db $b9, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a0, $0b ; volume $0B
    db $a1, $09 ; duty $09
    db $17, $0c ; note G1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $b4, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $17, $18 ; note G1 dur 24
    db $a0, $06 ; volume $06
    db $17, $18 ; note G1 dur 24
    db $ac, $01 ; call x1
    dw $01ec ; byte offset of the called section from the track start
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $13, $0c ; note D#1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $0c ; note G1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $10, $0c ; note C1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $15, $0c ; note F1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $17, $0c ; note G1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $20, $0c ; note C2 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $18, $0c ; note G#1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2b, $0c ; note B2 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $13, $0c ; note D#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $50 ; duty2 $50
    db $27, $0c ; note G2 dur 12
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $10, $0c ; note C1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $34, $0c ; note E3 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $15, $0c ; note F1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $28, $0c ; note G#2 dur 12
    db $a0, $04 ; volume $04
    db $28, $0c ; note G#2 dur 12
    db $a0, $02 ; volume $02
    db $28, $0c ; note G#2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $1a, $0c ; note A#1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0c ; note D3 dur 12
    db $a2, $60 ; duty2 $60
    db $a1, $0b ; duty $0B
    db $13, $12 ; note D#1 dur 18
    db $a0, $04 ; volume $04
    db $13, $06 ; note D#1 dur 6
    db $a0, $02 ; volume $02
    db $1a, $12 ; note A#1 dur 18
    db $a0, $04 ; volume $04
    db $1a, $06 ; note A#1 dur 6
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $a0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $1f, $18 ; rest-note $1F dur 24
    db $ac, $01 ; call x1
    dw $0296 ; byte offset of the called section from the track start
    db $a1, $0b ; duty $0B
    db $13, $12 ; note D#1 dur 18
    db $a0, $06 ; volume $06
    db $13, $06 ; note D#1 dur 6
    db $a0, $02 ; volume $02
    db $1a, $12 ; note A#1 dur 18
    db $a0, $06 ; volume $06
    db $1a, $06 ; note A#1 dur 6
    db $a0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $a0, $06 ; volume $06
    db $23, $06 ; note D#2 dur 6
    db $1f, $18 ; rest-note $1F dur 24
    db $ac, $01 ; call x1
    dw $0296 ; byte offset of the called section from the track start
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $17, $12 ; note G1 dur 18
    db $a0, $04 ; volume $04
    db $17, $06 ; note G1 dur 6
    db $a0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $27, $18 ; note G2 dur 24
    db $a0, $06 ; volume $06
    db $27, $18 ; note G2 dur 24
    db $b1, $f0 ; repeat $F0
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end
    db $a0, $02 ; volume $02
    db $a2, $60 ; duty2 $60
    db $fd, $f0 ; label 0
    db $a1, $03 ; duty $03
    db $20, $0c ; note C2 dur 12
    db $a1, $0f ; duty $0F
    db $27, $0c ; note G2 dur 12
    db $30, $0c ; note C3 dur 12
    db $27, $0c ; note G2 dur 12
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a1, $03 ; duty $03
    db $24, $0c ; note E2 dur 12
    db $a1, $0f ; duty $0F
    db $27, $0c ; note G2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $27, $0c ; note G2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $03 ; duty $03
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $20, $0c ; note C2 dur 12
    db $24, $0c ; note E2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a1, $03 ; duty $03
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $25, $0c ; note F2 dur 12
    db $29, $0c ; note A2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a1, $03 ; duty $03
    db $14, $0c ; note E1 dur 12
    db $a1, $0f ; duty $0F
    db $1b, $0c ; note B1 dur 12
    db $24, $0c ; note E2 dur 12
    db $1b, $0c ; note B1 dur 12
    db $a1, $03 ; duty $03
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $21, $0c ; note C#2 dur 12
    db $24, $0c ; note E2 dur 12
    db $19, $0c ; note A1 dur 12
    db $a1, $03 ; duty $03
    db $15, $0c ; note F1 dur 12
    db $a1, $0f ; duty $0F
    db $20, $0c ; note C2 dur 12
    db $25, $0c ; note F2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a1, $03 ; duty $03
    db $25, $0c ; note F2 dur 12
    db $a1, $0f ; duty $0F
    db $20, $0c ; note C2 dur 12
    db $18, $0c ; note G#1 dur 12
    db $15, $0c ; note F1 dur 12
    db $a1, $03 ; duty $03
    db $20, $0c ; note C2 dur 12
    db $a1, $0f ; duty $0F
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a1, $03 ; duty $03
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $21, $0c ; note C#2 dur 12
    db $24, $0c ; note E2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $22, $30 ; note D2 dur 48
    db $a0, $02 ; volume $02
    db $17, $2c ; note G1 dur 44
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $a2, $60 ; duty2 $60
    db $a0, $02 ; volume $02
    db $20, $0c ; note C2 dur 12
    db $a1, $03 ; duty $03
    db $35, $0c ; note F3 dur 12
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a2, $50 ; duty2 $50
    db $30, $18 ; note C3 dur 24
    db $a0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $ad, $00 ; return $00
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2b, $0c ; note B2 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a2, $40 ; duty2 $40
    db $a1, $03 ; duty $03
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a2, $40 ; duty2 $40
    db $a1, $03 ; duty $03
    db $2b, $0c ; note B2 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $06 ; volume $06
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $40 ; duty2 $40
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a1, $03 ; duty $03
    db $a0, $06 ; volume $06
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $a1, $0b ; duty $0B
    db $2a, $0c ; note A#2 dur 12
    db $a1, $03 ; duty $03
    db $1a, $0c ; note A#1 dur 12
    db $28, $0c ; note G#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $30 ; note A#1 dur 48
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $18 ; note A#2 dur 24
    db $a0, $06 ; volume $06
    db $2a, $18 ; note A#2 dur 24
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $13, $0c ; note D#1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $17, $0c ; note G1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $10, $0c ; note C1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $50 ; duty2 $50
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $15, $0c ; note F1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $50 ; duty2 $50
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $0c ; note G1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $20, $0c ; note C2 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $18, $0c ; note G#1 dur 12
    db $a1, $03 ; duty $03
    db $a2, $50 ; duty2 $50
    db $2b, $0c ; note B2 dur 12
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $13, $0c ; note D#1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $27, $0c ; note G2 dur 12
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $10, $0c ; note C1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $34, $0c ; note E3 dur 12
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $15, $0c ; note F1 dur 12
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $28, $0c ; note G#2 dur 12
    db $a0, $04 ; volume $04
    db $28, $0c ; note G#2 dur 12
    db $a0, $02 ; volume $02
    db $28, $0c ; note G#2 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $0c ; note A#1 dur 12
    db $a1, $03 ; duty $03
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0c ; note D3 dur 12
    db $ad, $00 ; return $00

; sound track, 480 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_19::
    db $00, $01, $09, $00 ; header: param=0 byte1=$01 volume=$09 byte3=$00
    db $1f, $18 ; rest-note $1F dur 24
    db $fd, $f3 ; label 3
    db $a3, $26 ; mod $26
    db $a2, $01 ; duty2 $01
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $1f, $18 ; rest-note $1F dur 24
    db $22, $18 ; note D2 dur 24
    db $25, $18 ; note F2 dur 24
    db $c5, $60 ; env $60
    db $a0, $08 ; volume $08
    db $2a, $16 ; note A#2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2a, $1a ; note A#2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $1a, $18 ; note A#1 dur 24
    db $24, $18 ; note E2 dur 24
    db $a0, $08 ; volume $08
    db $c5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $27, $1a ; note G2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $a0, $08 ; volume $08
    db $c5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $1a ; note A2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $a0, $08 ; volume $08
    db $c5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $1a ; note A2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $25, $18 ; note F2 dur 24
    db $22, $18 ; note D2 dur 24
    db $a0, $09 ; volume $09
    db $c5, $60 ; env $60
    db $29, $17 ; note A2 dur 23
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $29, $19 ; note A2 dur 25
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $a0, $08 ; volume $08
    db $c5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $27, $1a ; note G2 dur 26
    db $c3, $48 ; env $48
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $29, $18 ; note A2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $29, $18 ; note A2 dur 24
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $29, $18 ; note A2 dur 24
    db $a3, $26 ; mod $26
    db $c3, $52 ; env $52
    db $a0, $0c ; volume $0C
    db $1a, $18 ; note A#1 dur 24
    db $22, $18 ; note D2 dur 24
    db $a0, $09 ; volume $09
    db $c5, $60 ; env $60
    db $25, $16 ; note F2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $25, $1a ; note F2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $25, $18 ; note F2 dur 24
    db $c5, $60 ; env $60
    db $a0, $09 ; volume $09
    db $29, $16 ; note A2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $1a ; note A2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $a0, $09 ; volume $09
    db $c5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $27, $1a ; note G2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $a0, $09 ; volume $09
    db $c5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $1a ; note A2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $22, $18 ; note D2 dur 24
    db $25, $18 ; note F2 dur 24
    db $c5, $60 ; env $60
    db $a0, $09 ; volume $09
    db $29, $16 ; note A2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $1a ; note A2 dur 26
    db $c3, $52 ; env $52
    db $a0, $0b ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $c5, $60 ; env $60
    db $a0, $09 ; volume $09
    db $2a, $16 ; note A#2 dur 22
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2a, $1a ; note A#2 dur 26
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $27, $18 ; note G2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $c3, $52 ; env $52
    db $24, $18 ; note E2 dur 24
    db $c1, $70 ; env $70
    db $a0, $04 ; volume $04
    db $24, $18 ; note E2 dur 24
    db $a2, $02 ; duty2 $02
    db $a0, $03 ; volume $03
    db $39, $0c ; note A3 dur 12
    db $1f, $0c ; rest-note $1F dur 12
    db $a2, $02 ; duty2 $02
    db $c1, $7f ; env $7F
    db $aa, $4b ; slide $4B
    db $a0, $09 ; volume $09
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $08 ; volume $08
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $a0, $09 ; volume $09
    db $20, $0c ; note C2 dur 12
    db $24, $0c ; note E2 dur 12
    db $20, $0c ; note C2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $08 ; volume $08
    db $20, $0c ; note C2 dur 12
    db $24, $0c ; note E2 dur 12
    db $a0, $03 ; volume $03
    db $24, $0c ; note E2 dur 12
    db $aa, $00 ; slide $00
    db $a2, $02 ; duty2 $02
    db $a0, $04 ; volume $04
    db $42, $0c ; note D4 dur 12
    db $aa, $4b ; slide $4B
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $20, $0c ; note C2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $20, $0c ; note C2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $08 ; volume $08
    db $20, $0c ; note C2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $a0, $03 ; volume $03
    db $23, $18 ; note D#2 dur 24
    db $a0, $09 ; volume $09
    db $25, $0c ; note F2 dur 12
    db $29, $0c ; note A2 dur 12
    db $25, $0c ; note F2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $08 ; volume $08
    db $25, $0c ; note F2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $03 ; volume $03
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $aa, $00 ; slide $00
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $20, $0c ; note C2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $09 ; volume $09
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $0e ; volume $0E
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $a0, $09 ; volume $09
    db $29, $0c ; note A2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $20, $0c ; note C2 dur 12
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $16, $0c ; note F#1 dur 12
    db $aa, $00 ; slide $00
    db $a0, $08 ; volume $08
    db $16, $0c ; note F#1 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $04 ; volume $04
    db $2a, $0c ; note A#2 dur 12
    db $a2, $02 ; duty2 $02
    db $aa, $4b ; slide $4B
    db $a0, $09 ; volume $09
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $08 ; volume $08
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $a2, $02 ; duty2 $02
    db $aa, $4b ; slide $4B
    db $a0, $09 ; volume $09
    db $21, $0c ; note C#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $a0, $08 ; volume $08
    db $25, $0c ; note F2 dur 12
    db $21, $0c ; note C#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $03 ; volume $03
    db $25, $0c ; note F2 dur 12
    db $a2, $02 ; duty2 $02
    db $aa, $00 ; slide $00
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a2, $02 ; duty2 $02
    db $aa, $4b ; slide $4B
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $08 ; volume $08
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $a0, $09 ; volume $09
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $08 ; volume $08
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $02 ; volume $02
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $08 ; volume $08
    db $22, $0c ; note D2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $a0, $09 ; volume $09
    db $27, $0c ; note G2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $27, $0c ; note G2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $a0, $08 ; volume $08
    db $27, $0c ; note G2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $a0, $03 ; volume $03
    db $2a, $18 ; note A#2 dur 24
    db $aa, $00 ; slide $00
    db $a0, $0a ; volume $0A
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $a0, $0c ; volume $0C
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $a0, $0a ; volume $0A
    db $aa, $2b ; slide $2B
    db $c1, $50 ; env $50
    db $30, $0e ; note C3 dur 14
    db $a0, $03 ; volume $03
    db $30, $0a ; note C3 dur 10
    db $a0, $0b ; volume $0B
    db $2a, $0e ; note A#2 dur 14
    db $a0, $03 ; volume $03
    db $30, $0a ; note C3 dur 10
    db $a0, $0b ; volume $0B
    db $27, $0e ; note G2 dur 14
    db $a0, $03 ; volume $03
    db $2a, $0a ; note A#2 dur 10
    db $aa, $00 ; slide $00
    db $a0, $08 ; volume $08
    db $24, $0e ; note E2 dur 14
    db $a0, $03 ; volume $03
    db $24, $0a ; note E2 dur 10
    db $a2, $02 ; duty2 $02
    db $a0, $06 ; volume $06
    db $39, $18 ; note A3 dur 24
    db $a2, $02 ; duty2 $02
    db $aa, $4b ; slide $4B
    db $a0, $0b ; volume $0B
    db $31, $0e ; note C#3 dur 14
    db $a0, $02 ; volume $02
    db $31, $0a ; note C#3 dur 10
    db $a0, $0b ; volume $0B
    db $28, $0e ; note G#2 dur 14
    db $a0, $02 ; volume $02
    db $31, $0a ; note C#3 dur 10
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $a0, $02 ; volume $02
    db $28, $0a ; note G#2 dur 10
    db $a0, $0b ; volume $0B
    db $21, $0e ; note C#2 dur 14
    db $a0, $02 ; volume $02
    db $25, $0a ; note F2 dur 10
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $a0, $02 ; volume $02
    db $21, $0a ; note C#2 dur 10
    db $a0, $0a ; volume $0A
    db $28, $0e ; note G#2 dur 14
    db $a0, $02 ; volume $02
    db $25, $0a ; note F2 dur 10
    db $aa, $00 ; slide $00
    db $a0, $08 ; volume $08
    db $31, $0e ; note C#3 dur 14
    db $a0, $02 ; volume $02
    db $31, $22 ; note C#3 dur 34
    db $aa, $4b ; slide $4B
    db $a0, $0b ; volume $0B
    db $31, $0e ; note C#3 dur 14
    db $a0, $03 ; volume $03
    db $31, $0a ; note C#3 dur 10
    db $a0, $0b ; volume $0B
    db $2a, $0e ; note A#2 dur 14
    db $a0, $03 ; volume $03
    db $31, $0a ; note C#3 dur 10
    db $a0, $0b ; volume $0B
    db $26, $0e ; note F#2 dur 14
    db $a0, $03 ; volume $03
    db $2a, $0a ; note A#2 dur 10
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $a0, $03 ; volume $03
    db $26, $0a ; note F#2 dur 10
    db $a0, $0b ; volume $0B
    db $21, $0e ; note C#2 dur 14
    db $a0, $03 ; volume $03
    db $26, $0a ; note F#2 dur 10
    db $a0, $0b ; volume $0B
    db $26, $0e ; note F#2 dur 14
    db $a0, $03 ; volume $03
    db $21, $0a ; note C#2 dur 10
    db $aa, $00 ; slide $00
    db $a0, $07 ; volume $07
    db $2a, $0e ; note A#2 dur 14
    db $a0, $03 ; volume $03
    db $2a, $0a ; note A#2 dur 10
    db $1f, $18 ; rest-note $1F dur 24
    db $aa, $4b ; slide $4B
    db $a0, $0b ; volume $0B
    db $2b, $0e ; note B2 dur 14
    db $a0, $03 ; volume $03
    db $2b, $0a ; note B2 dur 10
    db $a0, $0b ; volume $0B
    db $29, $0e ; note A2 dur 14
    db $a0, $03 ; volume $03
    db $2b, $0a ; note B2 dur 10
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $a0, $03 ; volume $03
    db $29, $0a ; note A2 dur 10
    db $a0, $0b ; volume $0B
    db $23, $0f ; note D#2 dur 15
    db $a0, $03 ; volume $03
    db $25, $0a ; note F2 dur 10
    db $a0, $0b ; volume $0B
    db $1b, $0f ; note B1 dur 15
    db $a0, $03 ; volume $03
    db $23, $0a ; note D#2 dur 10
    db $a0, $0b ; volume $0B
    db $23, $0f ; note D#2 dur 15
    db $a0, $03 ; volume $03
    db $1b, $0a ; note B1 dur 10
    db $aa, $00 ; slide $00
    db $a0, $07 ; volume $07
    db $25, $0e ; note F2 dur 14
    db $a0, $03 ; volume $03
    db $25, $0c ; note F2 dur 12
    db $1f, $1a ; rest-note $1F dur 26
    db $aa, $4b ; slide $4B
    db $a0, $0b ; volume $0B
    db $30, $10 ; note C3 dur 16
    db $a0, $03 ; volume $03
    db $30, $0a ; note C3 dur 10
    db $a0, $0b ; volume $0B
    db $2a, $10 ; note A#2 dur 16
    db $a0, $03 ; volume $03
    db $30, $0a ; note C3 dur 10
    db $a0, $0b ; volume $0B
    db $27, $11 ; note G2 dur 17
    db $a0, $03 ; volume $03
    db $2a, $0a ; note A#2 dur 10
    db $a0, $0b ; volume $0B
    db $30, $11 ; note C3 dur 17
    db $a0, $03 ; volume $03
    db $27, $0a ; note G2 dur 10
    db $a0, $0a ; volume $0A
    db $2a, $11 ; note A#2 dur 17
    db $a0, $03 ; volume $03
    db $30, $0a ; note C3 dur 10
    db $a0, $0a ; volume $0A
    db $27, $12 ; note G2 dur 18
    db $a0, $03 ; volume $03
    db $2a, $0a ; note A#2 dur 10
    db $a0, $0a ; volume $0A
    db $24, $0e ; note E2 dur 14
    db $a0, $03 ; volume $03
    db $24, $0d ; note E2 dur 13
    db $aa, $00 ; slide $00
    db $1f, $02 ; rest-note $1F dur 2
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 328 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_1A::
    db $00, $02, $09, $00 ; header: param=0 byte1=$02 volume=$09 byte3=$00
    db $c1, $40 ; env $40
    db $a2, $02 ; duty2 $02
    db $a0, $0d ; volume $0D
    db $a3, $0b ; mod $0B
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $fd, $f3 ; label 3
    db $c1, $6f ; env $6F
    db $a3, $0b ; mod $0B
    db $a0, $0c ; volume $0C
    db $3a, $30 ; note A#3 dur 48
    db $a0, $04 ; volume $04
    db $3a, $18 ; note A#3 dur 24
    db $c1, $4f ; env $4F
    db $a3, $0d ; mod $0D
    db $a0, $0c ; volume $0C
    db $42, $14 ; note D4 dur 20
    db $a0, $08 ; volume $08
    db $42, $04 ; note D4 dur 4
    db $c1, $40 ; env $40
    db $a0, $0d ; volume $0D
    db $49, $18 ; note A4 dur 24
    db $47, $18 ; note G4 dur 24
    db $a0, $0c ; volume $0C
    db $44, $18 ; note E4 dur 24
    db $42, $18 ; note D4 dur 24
    db $a0, $0b ; volume $0B
    db $c1, $6f ; env $6F
    db $40, $18 ; note C4 dur 24
    db $a0, $06 ; volume $06
    db $40, $30 ; note C4 dur 48
    db $c1, $40 ; env $40
    db $a3, $0a ; mod $0A
    db $a0, $0e ; volume $0E
    db $44, $18 ; note E4 dur 24
    db $42, $0c ; note D4 dur 12
    db $40, $0c ; note C4 dur 12
    db $a3, $0d ; mod $0D
    db $c1, $7f ; env $7F
    db $39, $18 ; note A3 dur 24
    db $a0, $06 ; volume $06
    db $39, $18 ; note A3 dur 24
    db $c1, $40 ; env $40
    db $a3, $0a ; mod $0A
    db $a0, $0d ; volume $0D
    db $37, $18 ; note G3 dur 24
    db $a0, $0d ; volume $0D
    db $34, $18 ; note E3 dur 24
    db $35, $17 ; note F3 dur 23
    db $a0, $0e ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $39, $10 ; note A3 dur 16
    db $3a, $0f ; note A#3 dur 15
    db $a3, $0d ; mod $0D
    db $40, $18 ; note C4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $c1, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $a0, $0e ; volume $0E
    db $39, $1c ; note A3 dur 28
    db $c0, $fe ; env $FE
    db $a0, $05 ; volume $05
    db $39, $30 ; note A3 dur 48
    db $a0, $03 ; volume $03
    db $c1, $7f ; env $7F
    db $39, $5c ; note A3 dur 92
    db $c1, $30 ; env $30
    db $a3, $0d ; mod $0D
    db $a0, $0c ; volume $0C
    db $39, $14 ; note A3 dur 20
    db $a0, $07 ; volume $07
    db $39, $04 ; note A3 dur 4
    db $a0, $0e ; volume $0E
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $a3, $0d ; mod $0D
    db $c1, $7f ; env $7F
    db $42, $18 ; note D4 dur 24
    db $a0, $08 ; volume $08
    db $42, $18 ; note D4 dur 24
    db $c1, $40 ; env $40
    db $a0, $0e ; volume $0E
    db $3a, $18 ; note A#3 dur 24
    db $c1, $70 ; env $70
    db $a3, $fe ; mod $FE
    db $37, $28 ; note G3 dur 40
    db $a0, $06 ; volume $06
    db $c1, $7f ; env $7F
    db $37, $20 ; note G3 dur 32
    db $a3, $0a ; mod $0A
    db $c1, $40 ; env $40
    db $a0, $0e ; volume $0E
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $42, $0c ; note D4 dur 12
    db $a3, $0d ; mod $0D
    db $c1, $7f ; env $7F
    db $44, $18 ; note E4 dur 24
    db $a0, $08 ; volume $08
    db $44, $18 ; note E4 dur 24
    db $c1, $40 ; env $40
    db $a0, $0d ; volume $0D
    db $40, $18 ; note C4 dur 24
    db $a3, $0a ; mod $0A
    db $a0, $0c ; volume $0C
    db $c1, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $39, $28 ; note A3 dur 40
    db $a0, $07 ; volume $07
    db $39, $20 ; note A3 dur 32
    db $c1, $40 ; env $40
    db $a3, $0c ; mod $0C
    db $a0, $0d ; volume $0D
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $a3, $0f ; mod $0F
    db $c1, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $42, $1c ; note D4 dur 28
    db $a0, $06 ; volume $06
    db $42, $14 ; note D4 dur 20
    db $a0, $0c ; volume $0C
    db $c1, $7f ; env $7F
    db $45, $1c ; note F4 dur 28
    db $a0, $06 ; volume $06
    db $45, $14 ; note F4 dur 20
    db $a3, $fe ; mod $FE
    db $a0, $0f ; volume $0F
    db $4a, $1c ; note A#4 dur 28
    db $a0, $08 ; volume $08
    db $4a, $2c ; note A#4 dur 44
    db $c1, $40 ; env $40
    db $a0, $0b ; volume $0B
    db $49, $17 ; note A4 dur 23
    db $a0, $04 ; volume $04
    db $49, $01 ; note A4 dur 1
    db $a0, $0f ; volume $0F
    db $a3, $fe ; mod $FE
    db $c1, $7f ; env $7F
    db $49, $1c ; note A4 dur 28
    db $a0, $07 ; volume $07
    db $49, $44 ; note A4 dur 68
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $47, $2c ; note G4 dur 44
    db $a0, $03 ; volume $03
    db $47, $1c ; note G4 dur 28
    db $a2, $02 ; duty2 $02
    db $a3, $0c ; mod $0C
    db $c3, $58 ; env $58
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $3a, $2c ; note A#3 dur 44
    db $c1, $50 ; env $50
    db $a3, $01 ; mod $01
    db $a0, $09 ; volume $09
    db $3a, $1c ; note A#3 dur 28
    db $c3, $58 ; env $58
    db $a3, $0c ; mod $0C
    db $a0, $0e ; volume $0E
    db $42, $18 ; note D4 dur 24
    db $c3, $7f ; env $7F
    db $49, $18 ; note A4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $42, $18 ; note D4 dur 24
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $40, $2c ; note C4 dur 44
    db $c1, $60 ; env $60
    db $a3, $0f ; mod $0F
    db $a0, $08 ; volume $08
    db $40, $1c ; note C4 dur 28
    db $a3, $0c ; mod $0C
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $44, $18 ; note E4 dur 24
    db $42, $0c ; note D4 dur 12
    db $40, $0c ; note C4 dur 12
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $39, $30 ; note A3 dur 48
    db $37, $18 ; note G3 dur 24
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $34, $18 ; note E3 dur 24
    db $35, $17 ; note F3 dur 23
    db $c3, $6f ; env $6F
    db $37, $12 ; note G3 dur 18
    db $39, $10 ; note A3 dur 16
    db $3a, $0f ; note A#3 dur 15
    db $c3, $78 ; env $78
    db $40, $18 ; note C4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $39, $80 ; note A3 dur 128
    db $a3, $02 ; mod $02
    db $c1, $70 ; env $70
    db $a0, $09 ; volume $09
    db $39, $28 ; note A3 dur 40
    db $a3, $2d ; mod $2D
    db $c4, $60 ; env $60
    db $a0, $0f ; volume $0F
    db $29, $18 ; note A2 dur 24
    db $c4, $50 ; env $50
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $0d ; mod $0D
    db $a0, $0c ; volume $0C
    db $32, $30 ; note D3 dur 48
    db $2a, $18 ; note A#2 dur 24
    db $27, $30 ; note G2 dur 48
    db $c1, $50 ; env $50
    db $a3, $02 ; mod $02
    db $a0, $07 ; volume $07
    db $27, $18 ; note G2 dur 24
    db $c3, $48 ; env $48
    db $a3, $0d ; mod $0D
    db $a0, $0f ; volume $0F
    db $29, $0c ; note A2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $32, $0c ; note D3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $34, $30 ; note E3 dur 48
    db $30, $18 ; note C3 dur 24
    db $29, $20 ; note A2 dur 32
    db $c1, $40 ; env $40
    db $a3, $02 ; mod $02
    db $a0, $06 ; volume $06
    db $29, $28 ; note A2 dur 40
    db $c3, $48 ; env $48
    db $a3, $0d ; mod $0D
    db $a0, $0f ; volume $0F
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $0f ; mod $0F
    db $a0, $0a ; volume $0A
    db $32, $30 ; note D3 dur 48
    db $35, $30 ; note F3 dur 48
    db $a3, $fe ; mod $FE
    db $3a, $48 ; note A#3 dur 72
    db $a3, $0e ; mod $0E
    db $c4, $2f ; env $2F
    db $a0, $0a ; volume $0A
    db $39, $18 ; note A3 dur 24
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $39, $60 ; note A3 dur 96
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $37, $14 ; note G3 dur 20
    db $a0, $05 ; volume $05
    db $c1, $70 ; env $70
    db $37, $1c ; note G3 dur 28
    db $a0, $0f ; volume $0F
    db $c3, $68 ; env $68
    db $39, $30 ; note A3 dur 48
    db $a3, $00 ; mod $00
    db $35, $78 ; note F3 dur 120
    db $c1, $5f ; env $5F
    db $a0, $0a ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $a3, $0e ; mod $0E
    db $c3, $48 ; env $48
    db $a0, $0f ; volume $0F
    db $35, $14 ; note F3 dur 20
    db $a0, $05 ; volume $05
    db $35, $04 ; note F3 dur 4
    db $c0, $fe ; env $FE
    db $a3, $00 ; mod $00
    db $a0, $0b ; volume $0B
    db $35, $78 ; note F3 dur 120
    db $c1, $5f ; env $5F
    db $a0, $0a ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $a3, $0e ; mod $0E
    db $c3, $48 ; env $48
    db $a0, $0f ; volume $0F
    db $35, $14 ; note F3 dur 20
    db $a0, $05 ; volume $05
    db $35, $04 ; note F3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $a3, $00 ; mod $00
    db $35, $7b ; note F3 dur 123
    db $c1, $5f ; env $5F
    db $a0, $0a ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $a3, $0e ; mod $0E
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $35, $17 ; note F3 dur 23
    db $a0, $05 ; volume $05
    db $35, $03 ; note F3 dur 3
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $a3, $00 ; mod $00
    db $35, $69 ; note F3 dur 105
    db $a0, $0a ; volume $0A
    db $34, $3a ; note E3 dur 58
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $c1, $40 ; env $40
    db $a2, $02 ; duty2 $02
    db $a0, $0c ; volume $0C
    db $a3, $0b ; mod $0B
    db $37, $0f ; note G3 dur 15
    db $39, $0e ; note A3 dur 14
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 423 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_40_1B::
    db $00, $59, $02, $08 ; header: param=0 byte1=$59 volume=$02 byte3=$08
    db $1f, $18 ; rest-note $1F dur 24
    db $fd, $f3 ; label 3
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $18 ; note A#2 dur 24
    db $32, $18 ; note D3 dur 24
    db $35, $16 ; note F3 dur 22
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $20, $18 ; note C2 dur 24
    db $a1, $0f ; duty $0F
    db $27, $18 ; note G2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $34, $16 ; note E3 dur 22
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $15, $18 ; note F1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $34, $16 ; note E3 dur 22
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $15, $18 ; note F1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $33, $16 ; note D#3 dur 22
    db $a0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $1a, $18 ; note A#1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $32, $17 ; note D3 dur 23
    db $a0, $04 ; volume $04
    db $32, $01 ; note D3 dur 1
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $19, $18 ; note A1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $34, $16 ; note E3 dur 22
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $36, $18 ; note F#3 dur 24
    db $39, $18 ; note A3 dur 24
    db $36, $18 ; note F#3 dur 24
    db $30, $18 ; note C3 dur 24
    db $22, $16 ; note D2 dur 22
    db $a0, $04 ; volume $04
    db $22, $02 ; note D2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $25, $18 ; note F2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $32, $16 ; note D3 dur 22
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $1a, $18 ; note A#1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $18 ; note A#2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $35, $16 ; note F3 dur 22
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $19, $18 ; note A1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $34, $16 ; note E3 dur 22
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $a1, $0f ; duty $0F
    db $29, $18 ; note A2 dur 24
    db $32, $18 ; note D3 dur 24
    db $36, $16 ; note F#3 dur 22
    db $a0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $18 ; note A#2 dur 24
    db $32, $18 ; note D3 dur 24
    db $35, $16 ; note F3 dur 22
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $23, $18 ; note D#2 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $18 ; note A#2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $37, $16 ; note G3 dur 22
    db $a0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $20, $18 ; note C2 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $18 ; note A#2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $34, $18 ; note E3 dur 24
    db $37, $18 ; note G3 dur 24
    db $34, $18 ; note E3 dur 24
    db $20, $10 ; note C2 dur 16
    db $a0, $04 ; volume $04
    db $20, $20 ; note C2 dur 32
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a1, $0b ; duty $0B
    db $20, $18 ; note C2 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $34, $0c ; note E3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $34, $0c ; note E3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $34, $0c ; note E3 dur 12
    db $a1, $0b ; duty $0B
    db $15, $18 ; note F1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $a1, $0b ; duty $0B
    db $15, $18 ; note F1 dur 24
    db $a1, $0f ; duty $0F
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $18 ; note A#1 dur 24
    db $a1, $0f ; duty $0F
    db $32, $0c ; note D3 dur 12
    db $35, $0c ; note F3 dur 12
    db $32, $0c ; note D3 dur 12
    db $35, $0c ; note F3 dur 12
    db $32, $0c ; note D3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a1, $0b ; duty $0B
    db $19, $18 ; note A1 dur 24
    db $a1, $0f ; duty $0F
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a1, $0b ; duty $0B
    db $12, $0c ; note D1 dur 12
    db $a1, $0f ; duty $0F
    db $22, $0c ; note D2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $39, $0c ; note A3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $39, $0c ; note A3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $a1, $0b ; duty $0B
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a1, $0b ; duty $0B
    db $1a, $18 ; note A#1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $a1, $0b ; duty $0B
    db $19, $18 ; note A1 dur 24
    db $a1, $0f ; duty $0F
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a1, $0b ; duty $0B
    db $22, $18 ; note D2 dur 24
    db $a1, $0f ; duty $0F
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a1, $0b ; duty $0B
    db $17, $18 ; note G1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $32, $0c ; note D3 dur 12
    db $a1, $0b ; duty $0B
    db $13, $18 ; note D#1 dur 24
    db $a1, $0f ; duty $0F
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $a1, $0b ; duty $0B
    db $20, $18 ; note C2 dur 24
    db $a1, $0f ; duty $0F
    db $31, $0c ; note C#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $37, $0c ; note G3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $41, $0c ; note C#4 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $34, $14 ; note E3 dur 20
    db $a0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $a0, $02 ; volume $02
    db $37, $14 ; note G3 dur 20
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $a0, $02 ; volume $02
    db $34, $14 ; note E3 dur 20
    db $a0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $a0, $02 ; volume $02
    db $30, $14 ; note C3 dur 20
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $06 ; volume $06
    db $30, $10 ; note C3 dur 16
    db $a0, $02 ; volume $02
    db $38, $14 ; note G#3 dur 20
    db $a0, $04 ; volume $04
    db $38, $04 ; note G#3 dur 4
    db $a0, $02 ; volume $02
    db $35, $14 ; note F3 dur 20
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $31, $14 ; note C#3 dur 20
    db $a0, $04 ; volume $04
    db $31, $04 ; note C#3 dur 4
    db $a0, $02 ; volume $02
    db $28, $14 ; note G#2 dur 20
    db $a0, $04 ; volume $04
    db $28, $04 ; note G#2 dur 4
    db $a0, $02 ; volume $02
    db $31, $14 ; note C#3 dur 20
    db $a0, $04 ; volume $04
    db $31, $04 ; note C#3 dur 4
    db $a0, $02 ; volume $02
    db $35, $14 ; note F3 dur 20
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $38, $18 ; note G#3 dur 24
    db $a0, $04 ; volume $04
    db $38, $0c ; note G#3 dur 12
    db $a0, $06 ; volume $06
    db $38, $0c ; note G#3 dur 12
    db $a0, $02 ; volume $02
    db $3a, $14 ; note A#3 dur 20
    db $a0, $04 ; volume $04
    db $3a, $04 ; note A#3 dur 4
    db $a0, $02 ; volume $02
    db $36, $14 ; note F#3 dur 20
    db $a0, $04 ; volume $04
    db $36, $04 ; note F#3 dur 4
    db $a0, $02 ; volume $02
    db $2a, $14 ; note A#2 dur 20
    db $a0, $04 ; volume $04
    db $2a, $04 ; note A#2 dur 4
    db $a0, $02 ; volume $02
    db $31, $14 ; note C#3 dur 20
    db $a0, $04 ; volume $04
    db $31, $04 ; note C#3 dur 4
    db $a0, $02 ; volume $02
    db $2a, $14 ; note A#2 dur 20
    db $a0, $04 ; volume $04
    db $2a, $04 ; note A#2 dur 4
    db $a0, $02 ; volume $02
    db $31, $14 ; note C#3 dur 20
    db $a0, $04 ; volume $04
    db $31, $04 ; note C#3 dur 4
    db $a0, $02 ; volume $02
    db $35, $18 ; note F3 dur 24
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $06 ; volume $06
    db $35, $0c ; note F3 dur 12
    db $a0, $02 ; volume $02
    db $33, $14 ; note D#3 dur 20
    db $a0, $04 ; volume $04
    db $33, $04 ; note D#3 dur 4
    db $a0, $02 ; volume $02
    db $35, $14 ; note F3 dur 20
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $29, $14 ; note A2 dur 20
    db $a0, $04 ; volume $04
    db $29, $04 ; note A2 dur 4
    db $a0, $02 ; volume $02
    db $2b, $15 ; note B2 dur 21
    db $a0, $04 ; volume $04
    db $2b, $04 ; note B2 dur 4
    db $a0, $02 ; volume $02
    db $25, $15 ; note F2 dur 21
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $2b, $15 ; note B2 dur 21
    db $a0, $04 ; volume $04
    db $2b, $04 ; note B2 dur 4
    db $a0, $02 ; volume $02
    db $29, $1c ; note A2 dur 28
    db $a0, $04 ; volume $04
    db $29, $0e ; note A2 dur 14
    db $a0, $06 ; volume $06
    db $29, $0a ; note A2 dur 10
    db $a0, $02 ; volume $02
    db $35, $16 ; note F3 dur 22
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $37, $16 ; note G3 dur 22
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $a0, $02 ; volume $02
    db $35, $17 ; note F3 dur 23
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $34, $17 ; note E3 dur 23
    db $a0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $a0, $02 ; volume $02
    db $37, $17 ; note G3 dur 23
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $a0, $02 ; volume $02
    db $34, $18 ; note E3 dur 24
    db $a0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $a0, $02 ; volume $02
    db $30, $17 ; note C3 dur 23
    db $a0, $04 ; volume $04
    db $30, $04 ; note C3 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end
    ds $113, $00
