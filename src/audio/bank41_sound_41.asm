; ROM bank $41: sound tracks
; The annotated listing of this bank is build/listing/bank41.asm.

SECTION "Bank 41", ROMX
    db $41

; E-0018. Sound ids 28-48.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified);
; track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank41::
    db $40 ; id 28: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_00 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 29: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_01 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 30: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_02 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 31: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_03 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 32: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_04 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 33: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_05 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 34: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_06 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 35: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_07 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 36: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_08 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 37: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_09 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 38: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0A ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 39: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0B ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 40: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0C ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 41: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0D ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 42: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0E ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 43: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_0F ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 44: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_10 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 45: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_11 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $40 ; id 46: channel-state slot offset (added to $DC00)
    db $00 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_12 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $60 ; id 47: channel-state slot offset (added to $DC00)
    db $01 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_13 ; track stream (stored at slot +3/+4, with this bank at +5)
    db $80 ; id 48: channel-state slot offset (added to $DC00)
    db $02 ; copied to slot byte +2 (meaning unverified)
    dw SoundTrack_41_14 ; track stream (stored at slot +3/+4, with this bank at +5)

; sound track, 264 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_00::
    db $02, $02, $09, $00 ; header: param=2 byte1=$02 volume=$09 byte3=$00
    db $a3, $26 ; mod $26
    db $c1, $50 ; env $50
    db $1f, $07 ; rest-note $1F dur 7
    db $a2, $02 ; duty2 $02
    db $a0, $03 ; volume $03
    db $35, $07 ; note F3 dur 7
    db $fd, $f3 ; label 3
    db $c1, $50 ; env $50
    db $a2, $02 ; duty2 $02
    db $a0, $03 ; volume $03
    db $37, $07 ; note G3 dur 7
    db $1f, $07 ; rest-note $1F dur 7
    db $a2, $01 ; duty2 $01
    db $a0, $0b ; volume $0B
    db $22, $07 ; note D2 dur 7
    db $a0, $03 ; volume $03
    db $22, $07 ; note D2 dur 7
    db $a0, $09 ; volume $09
    db $22, $1c ; note D2 dur 28
    db $a0, $03 ; volume $03
    db $22, $0e ; note D2 dur 14
    db $a0, $0b ; volume $0B
    db $20, $07 ; note C2 dur 7
    db $a0, $03 ; volume $03
    db $20, $07 ; note C2 dur 7
    db $a0, $09 ; volume $09
    db $20, $1c ; note C2 dur 28
    db $a0, $03 ; volume $03
    db $20, $0e ; note C2 dur 14
    db $a0, $0b ; volume $0B
    db $1a, $07 ; note A#1 dur 7
    db $a0, $03 ; volume $03
    db $1a, $07 ; note A#1 dur 7
    db $a0, $09 ; volume $09
    db $1a, $0e ; note A#1 dur 14
    db $a0, $03 ; volume $03
    db $1a, $0e ; note A#1 dur 14
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $25, $0e ; note F2 dur 14
    db $23, $0e ; note D#2 dur 14
    db $22, $0e ; note D2 dur 14
    db $20, $0e ; note C2 dur 14
    db $1a, $0e ; note A#1 dur 14
    db $20, $0e ; note C2 dur 14
    db $21, $0e ; note C#2 dur 14
    db $22, $0e ; note D2 dur 14
    db $a0, $0c ; volume $0C
    db $23, $1c ; note D#2 dur 28
    db $20, $1c ; note C2 dur 28
    db $a0, $0b ; volume $0B
    db $19, $07 ; note A1 dur 7
    db $c1, $70 ; env $70
    db $a0, $04 ; volume $04
    db $19, $07 ; note A1 dur 7
    db $a2, $01 ; duty2 $01
    db $c1, $10 ; env $10
    db $fd, $f0 ; label 0
    db $a0, $09 ; volume $09
    db $19, $02 ; note A1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $19, $04 ; note A1 dur 4
    db $b1, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $1a, $04 ; note A#1 dur 4
    db $a0, $03 ; volume $03
    db $19, $03 ; note A1 dur 3
    db $1a, $07 ; note A#1 dur 7
    db $a0, $0a ; volume $0A
    db $1a, $02 ; note A#1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1a, $04 ; note A#1 dur 4
    db $a0, $0b ; volume $0B
    db $1a, $02 ; note A#1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1a, $04 ; note A#1 dur 4
    db $a0, $0c ; volume $0C
    db $1b, $04 ; note B1 dur 4
    db $a0, $03 ; volume $03
    db $1a, $03 ; note A#1 dur 3
    db $1b, $07 ; note B1 dur 7
    db $a0, $0b ; volume $0B
    db $1b, $02 ; note B1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $a0, $0a ; volume $0A
    db $1b, $02 ; note B1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $c1, $30 ; env $30
    db $a0, $0c ; volume $0C
    db $20, $07 ; note C2 dur 7
    db $a0, $03 ; volume $03
    db $1b, $07 ; note B1 dur 7
    db $a0, $05 ; volume $05
    db $20, $0e ; note C2 dur 14
    db $a2, $02 ; duty2 $02
    db $a0, $06 ; volume $06
    db $35, $07 ; note F3 dur 7
    db $1f, $07 ; rest-note $1F dur 7
    db $a2, $00 ; duty2 $00
    db $c1, $50 ; env $50
    db $a0, $0b ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a0, $09 ; volume $09
    db $23, $1c ; note D#2 dur 28
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $1f, $07 ; rest-note $1F dur 7
    db $a0, $0b ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a0, $09 ; volume $09
    db $23, $1c ; note D#2 dur 28
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $1f, $07 ; rest-note $1F dur 7
    db $a0, $0b ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a0, $09 ; volume $09
    db $23, $15 ; note D#2 dur 21
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a2, $01 ; duty2 $01
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $23, $0e ; note D#2 dur 14
    db $22, $0e ; note D2 dur 14
    db $a0, $0e ; volume $0E
    db $21, $0e ; note C#2 dur 14
    db $20, $0e ; note C2 dur 14
    db $c3, $58 ; env $58
    db $a0, $0e ; volume $0E
    db $19, $0e ; note A1 dur 14
    db $1a, $0e ; note A#1 dur 14
    db $20, $0e ; note C2 dur 14
    db $23, $0e ; note D#2 dur 14
    db $a0, $03 ; volume $03
    db $23, $0e ; note D#2 dur 14
    db $a2, $01 ; duty2 $01
    db $c1, $50 ; env $50
    db $a0, $08 ; volume $08
    db $23, $07 ; note D#2 dur 7
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a0, $08 ; volume $08
    db $23, $15 ; note D#2 dur 21
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $c0, $fe ; env $FE
    db $a2, $02 ; duty2 $02
    db $a0, $08 ; volume $08
    db $22, $0c ; note D2 dur 12
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $22, $10 ; note D2 dur 16
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $23, $0c ; note D#2 dur 12
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $23, $0e ; note D#2 dur 14
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $24, $0c ; note E2 dur 12
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $23, $02 ; note D#2 dur 2
    db $24, $0e ; note E2 dur 14
    db $a2, $01 ; duty2 $01
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $25, $0e ; note F2 dur 14
    db $28, $0e ; note G#2 dur 14
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $27, $07 ; note G2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $30, $07 ; note C3 dur 7
    db $29, $07 ; note A2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $b1, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $fd, $f0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $25, $07 ; note F2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $25, $07 ; note F2 dur 7
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $b1, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $23, $07 ; note D#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $b1, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $2a, $07 ; note A#2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $b2, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $20, $0a ; note C2 dur 10
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 261 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_01::
    db $02, $00, $09, $00 ; header: param=2 byte1=$00 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $a0, $0e ; volume $0E
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a2, $02 ; duty2 $02
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $42, $1c ; note D4 dur 28
    db $c1, $3f ; env $3F
    db $a3, $01 ; mod $01
    db $a0, $08 ; volume $08
    db $42, $0e ; note D4 dur 14
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $40, $1c ; note C4 dur 28
    db $c1, $3f ; env $3F
    db $a3, $01 ; mod $01
    db $a0, $08 ; volume $08
    db $40, $0e ; note C4 dur 14
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $3a, $1c ; note A#3 dur 28
    db $c1, $3f ; env $3F
    db $a3, $01 ; mod $01
    db $a0, $08 ; volume $08
    db $3a, $0e ; note A#3 dur 14
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $39, $07 ; note A3 dur 7
    db $3a, $07 ; note A#3 dur 7
    db $39, $0e ; note A3 dur 14
    db $37, $0e ; note G3 dur 14
    db $35, $0e ; note F3 dur 14
    db $33, $0e ; note D#3 dur 14
    db $32, $0e ; note D3 dur 14
    db $33, $0e ; note D#3 dur 14
    db $a0, $0f ; volume $0F
    db $34, $0e ; note E3 dur 14
    db $35, $0e ; note F3 dur 14
    db $a0, $0d ; volume $0D
    db $c3, $68 ; env $68
    db $37, $2a ; note G3 dur 42
    db $a0, $0c ; volume $0C
    db $35, $07 ; note F3 dur 7
    db $33, $07 ; note D#3 dur 7
    db $a0, $0b ; volume $0B
    db $30, $07 ; note C3 dur 7
    db $c1, $70 ; env $70
    db $a0, $03 ; volume $03
    db $30, $07 ; note C3 dur 7
    db $a2, $01 ; duty2 $01
    db $c1, $10 ; env $10
    db $a0, $08 ; volume $08
    db $20, $02 ; note C2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $a0, $09 ; volume $09
    db $20, $02 ; note C2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $a0, $0a ; volume $0A
    db $21, $04 ; note C#2 dur 4
    db $a0, $03 ; volume $03
    db $20, $03 ; note C2 dur 3
    db $21, $07 ; note C#2 dur 7
    db $fd, $f0 ; label 0
    db $a0, $0b ; volume $0B
    db $21, $02 ; note C#2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $b1, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $22, $04 ; note D2 dur 4
    db $a0, $03 ; volume $03
    db $21, $03 ; note C#2 dur 3
    db $22, $07 ; note D2 dur 7
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $22, $02 ; note D2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $22, $04 ; note D2 dur 4
    db $b1, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $23, $07 ; note D#2 dur 7
    db $a0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $a2, $02 ; duty2 $02
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $c3, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $40, $1c ; note C4 dur 28
    db $c1, $3f ; env $3F
    db $a3, $08 ; mod $08
    db $a0, $06 ; volume $06
    db $40, $0e ; note C4 dur 14
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $a3, $fe ; mod $FE
    db $3a, $1c ; note A#3 dur 28
    db $c1, $3f ; env $3F
    db $a3, $08 ; mod $08
    db $a3, $01 ; mod $01
    db $a0, $08 ; volume $08
    db $3a, $0e ; note A#3 dur 14
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $c3, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $39, $1c ; note A3 dur 28
    db $c1, $3f ; env $3F
    db $a3, $01 ; mod $01
    db $a0, $08 ; volume $08
    db $39, $0e ; note A3 dur 14
    db $a3, $08 ; mod $08
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $37, $0e ; note G3 dur 14
    db $36, $0e ; note F#3 dur 14
    db $35, $0e ; note F3 dur 14
    db $33, $0e ; note D#3 dur 14
    db $30, $0e ; note C3 dur 14
    db $32, $0e ; note D3 dur 14
    db $33, $0e ; note D#3 dur 14
    db $37, $0e ; note G3 dur 14
    db $35, $23 ; note F3 dur 35
    db $33, $07 ; note D#3 dur 7
    db $32, $07 ; note D3 dur 7
    db $30, $07 ; note C3 dur 7
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $2a, $0c ; note A#2 dur 12
    db $c1, $30 ; env $30
    db $a0, $03 ; volume $03
    db $2a, $10 ; note A#2 dur 16
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $30, $0c ; note C3 dur 12
    db $c1, $30 ; env $30
    db $a0, $03 ; volume $03
    db $2a, $02 ; note A#2 dur 2
    db $30, $0e ; note C3 dur 14
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $31, $0c ; note C#3 dur 12
    db $c1, $30 ; env $30
    db $a0, $03 ; volume $03
    db $30, $02 ; note C3 dur 2
    db $31, $0e ; note C#3 dur 14
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $32, $0c ; note D3 dur 12
    db $c1, $30 ; env $30
    db $a0, $03 ; volume $03
    db $31, $02 ; note C#3 dur 2
    db $32, $0e ; note D3 dur 14
    db $a2, $00 ; duty2 $00
    db $c3, $78 ; env $78
    db $a3, $0a ; mod $0A
    db $a0, $0f ; volume $0F
    db $37, $46 ; note G3 dur 70
    db $c3, $68 ; env $68
    db $33, $0e ; note D#3 dur 14
    db $37, $0e ; note G3 dur 14
    db $3a, $0e ; note A#3 dur 14
    db $a3, $fe ; mod $FE
    db $39, $1c ; note A3 dur 28
    db $42, $1c ; note D4 dur 28
    db $40, $1c ; note C4 dur 28
    db $39, $15 ; note A3 dur 21
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $39, $07 ; note A3 dur 7
    db $a3, $0a ; mod $0A
    db $c4, $58 ; env $58
    db $a0, $0f ; volume $0F
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $c3, $48 ; env $48
    db $3a, $07 ; note A#3 dur 7
    db $a0, $05 ; volume $05
    db $39, $07 ; note A3 dur 7
    db $3a, $0e ; note A#3 dur 14
    db $a0, $0f ; volume $0F
    db $37, $0e ; note G3 dur 14
    db $c3, $78 ; env $78
    db $a3, $fe ; mod $FE
    db $42, $2a ; note D4 dur 42
    db $a3, $0a ; mod $0A
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $42, $0e ; note D4 dur 14
    db $c4, $68 ; env $68
    db $a0, $0f ; volume $0F
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $c4, $48 ; env $48
    db $3a, $07 ; note A#3 dur 7
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $39, $07 ; note A3 dur 7
    db $3a, $0e ; note A#3 dur 14
    db $c3, $38 ; env $38
    db $a0, $0f ; volume $0F
    db $37, $0e ; note G3 dur 14
    db $c3, $78 ; env $78
    db $a3, $fe ; mod $FE
    db $47, $2a ; note G4 dur 42
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $47, $2a ; note G4 dur 42
    db $a3, $0a ; mod $0A
    db $a2, $00 ; duty2 $00
    db $c3, $78 ; env $78
    db $a0, $0f ; volume $0F
    db $27, $1c ; note G2 dur 28
    db $29, $1c ; note A2 dur 28
    db $2a, $1c ; note A#2 dur 28
    db $32, $1c ; note D3 dur 28
    db $30, $1c ; note C3 dur 28
    db $27, $1c ; note G2 dur 28
    db $29, $1c ; note A2 dur 28
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $a3, $00 ; mod $00
    db $2a, $70 ; note A#2 dur 112
    db $29, $46 ; note A2 dur 70
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $29, $1c ; note A2 dur 28
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 254 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_02::
    db $02, $70, $02, $08 ; header: param=2 byte1=$70 volume=$02 byte3=$08
    db $1f, $0e ; rest-note $1F dur 14
    db $fd, $f3 ; label 3
    db $a1, $08 ; duty $08
    db $a2, $70 ; duty2 $70
    db $a0, $02 ; volume $02
    db $1a, $0e ; note A#1 dur 14
    db $25, $0e ; note F2 dur 14
    db $2a, $15 ; note A#2 dur 21
    db $a0, $04 ; volume $04
    db $2a, $07 ; note A#2 dur 7
    db $a0, $02 ; volume $02
    db $19, $0e ; note A1 dur 14
    db $25, $0e ; note F2 dur 14
    db $29, $15 ; note A2 dur 21
    db $a0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $a0, $02 ; volume $02
    db $17, $0e ; note G1 dur 14
    db $22, $0e ; note D2 dur 14
    db $27, $15 ; note G2 dur 21
    db $a0, $04 ; volume $04
    db $27, $07 ; note G2 dur 7
    db $a0, $02 ; volume $02
    db $15, $0e ; note F1 dur 14
    db $25, $0e ; note F2 dur 14
    db $29, $15 ; note A2 dur 21
    db $a0, $04 ; volume $04
    db $29, $0e ; note A2 dur 14
    db $a1, $02 ; duty $02
    db $a0, $06 ; volume $06
    db $42, $0e ; note D4 dur 14
    db $43, $07 ; note D#4 dur 7
    db $a2, $40 ; duty2 $40
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $1a, $15 ; note A#1 dur 21
    db $a0, $04 ; volume $04
    db $1a, $07 ; note A#1 dur 7
    db $a0, $02 ; volume $02
    db $1a, $15 ; note A#1 dur 21
    db $a0, $04 ; volume $04
    db $1a, $07 ; note A#1 dur 7
    db $a0, $02 ; volume $02
    db $1a, $15 ; note A#1 dur 21
    db $a0, $04 ; volume $04
    db $1a, $07 ; note A#1 dur 7
    db $a1, $0a ; duty $0A
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $15, $07 ; note F1 dur 7
    db $a0, $04 ; volume $04
    db $15, $07 ; note F1 dur 7
    db $a1, $08 ; duty $08
    db $a2, $10 ; duty2 $10
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $15 ; note F2 dur 21
    db $a1, $08 ; duty $08
    db $a2, $70 ; duty2 $70
    db $a0, $02 ; volume $02
    db $20, $0e ; note C2 dur 14
    db $27, $0e ; note G2 dur 14
    db $30, $15 ; note C3 dur 21
    db $a0, $04 ; volume $04
    db $30, $07 ; note C3 dur 7
    db $a0, $02 ; volume $02
    db $20, $0e ; note C2 dur 14
    db $27, $0e ; note G2 dur 14
    db $30, $15 ; note C3 dur 21
    db $a0, $04 ; volume $04
    db $30, $07 ; note C3 dur 7
    db $a0, $02 ; volume $02
    db $15, $0e ; note F1 dur 14
    db $20, $0e ; note C2 dur 14
    db $25, $15 ; note F2 dur 21
    db $a0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $a0, $02 ; volume $02
    db $15, $0e ; note F1 dur 14
    db $20, $0e ; note C2 dur 14
    db $29, $15 ; note A2 dur 21
    db $a0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $a0, $02 ; volume $02
    db $20, $0e ; note C2 dur 14
    db $27, $0e ; note G2 dur 14
    db $2a, $15 ; note A#2 dur 21
    db $a0, $04 ; volume $04
    db $2a, $07 ; note A#2 dur 7
    db $a0, $02 ; volume $02
    db $15, $0e ; note F1 dur 14
    db $20, $0e ; note C2 dur 14
    db $29, $15 ; note A2 dur 21
    db $a0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $a2, $18 ; duty2 $18
    db $a1, $0b ; duty $0B
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $07 ; note A#1 dur 7
    db $a0, $02 ; volume $02
    db $15, $07 ; note F1 dur 7
    db $a0, $04 ; volume $04
    db $15, $07 ; note F1 dur 7
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $13, $07 ; note D#1 dur 7
    db $a0, $04 ; volume $04
    db $13, $07 ; note D#1 dur 7
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $07 ; note A#1 dur 7
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $12, $07 ; note D1 dur 7
    db $a0, $04 ; volume $04
    db $12, $07 ; note D1 dur 7
    db $a0, $02 ; volume $02
    db $19, $07 ; note A1 dur 7
    db $a0, $04 ; volume $04
    db $19, $07 ; note A1 dur 7
    db $b3, $f0 ; repeat $F0
    db $a2, $60 ; duty2 $60
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $17, $0e ; note G1 dur 14
    db $a1, $03 ; duty $03
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $0e ; note G2 dur 14
    db $a0, $02 ; volume $02
    db $27, $0e ; note G2 dur 14
    db $a1, $0a ; duty $0A
    db $16, $0e ; note F#1 dur 14
    db $a1, $03 ; duty $03
    db $26, $0e ; note F#2 dur 14
    db $a0, $04 ; volume $04
    db $26, $0e ; note F#2 dur 14
    db $a0, $02 ; volume $02
    db $26, $0e ; note F#2 dur 14
    db $a1, $0a ; duty $0A
    db $15, $0e ; note F1 dur 14
    db $a1, $03 ; duty $03
    db $25, $0e ; note F2 dur 14
    db $a0, $04 ; volume $04
    db $25, $0e ; note F2 dur 14
    db $a0, $02 ; volume $02
    db $25, $0e ; note F2 dur 14
    db $a1, $0a ; duty $0A
    db $14, $0e ; note E1 dur 14
    db $a1, $03 ; duty $03
    db $24, $0e ; note E2 dur 14
    db $a0, $04 ; volume $04
    db $24, $0e ; note E2 dur 14
    db $a0, $02 ; volume $02
    db $24, $0e ; note E2 dur 14
    db $a1, $0b ; duty $0B
    db $13, $0e ; note D#1 dur 14
    db $a1, $03 ; duty $03
    db $23, $0e ; note D#2 dur 14
    db $a0, $04 ; volume $04
    db $23, $0e ; note D#2 dur 14
    db $a0, $02 ; volume $02
    db $23, $0e ; note D#2 dur 14
    db $a1, $0b ; duty $0B
    db $10, $0e ; note C1 dur 14
    db $a1, $03 ; duty $03
    db $20, $0e ; note C2 dur 14
    db $a0, $04 ; volume $04
    db $20, $0e ; note C2 dur 14
    db $a0, $02 ; volume $02
    db $20, $0e ; note C2 dur 14
    db $a1, $0b ; duty $0B
    db $fd, $f0 ; label 0
    db $19, $0c ; note A1 dur 12
    db $a0, $04 ; volume $04
    db $19, $02 ; note A1 dur 2
    db $a0, $02 ; volume $02
    db $19, $0e ; note A1 dur 14
    db $a0, $04 ; volume $04
    db $19, $0e ; note A1 dur 14
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a0, $04 ; volume $04
    db $19, $02 ; note A1 dur 2
    db $a0, $02 ; volume $02
    db $b1, $f0 ; repeat $F0
    db $12, $0e ; note D1 dur 14
    db $22, $0e ; note D2 dur 14
    db $a0, $04 ; volume $04
    db $22, $0e ; note D2 dur 14
    db $a0, $02 ; volume $02
    db $22, $0e ; note D2 dur 14
    db $12, $0e ; note D1 dur 14
    db $22, $0e ; note D2 dur 14
    db $a0, $04 ; volume $04
    db $22, $0e ; note D2 dur 14
    db $a0, $02 ; volume $02
    db $22, $0e ; note D2 dur 14
    db $15, $0e ; note F1 dur 14
    db $25, $0e ; note F2 dur 14
    db $a0, $04 ; volume $04
    db $25, $0e ; note F2 dur 14
    db $a0, $02 ; volume $02
    db $25, $0e ; note F2 dur 14
    db $15, $0e ; note F1 dur 14
    db $a2, $40 ; duty2 $40
    db $25, $0a ; note F2 dur 10
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $10 ; note F2 dur 16
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 155 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_03::
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $af, $07 ; param $07
    db $a3, $08 ; mod $08
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $26, $5e ; note F#2 dur 94
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $26, $02 ; note F#2 dur 2
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $27, $40 ; note G2 dur 64
    db $28, $1e ; note G#2 dur 30
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $30, $40 ; note C3 dur 64
    db $2a, $20 ; note A#2 dur 32
    db $c3, $7f ; env $7F
    db $29, $20 ; note A2 dur 32
    db $28, $38 ; note G#2 dur 56
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $28, $08 ; note G#2 dur 8
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $27, $5c ; note G2 dur 92
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $26, $58 ; note F#2 dur 88
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $26, $08 ; note F#2 dur 8
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $25, $5c ; note F2 dur 92
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $24, $18 ; note E2 dur 24
    db $a0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $a0, $0a ; volume $0A
    db $23, $18 ; note D#2 dur 24
    db $a0, $04 ; volume $04
    db $23, $08 ; note D#2 dur 8
    db $a0, $0a ; volume $0A
    db $22, $18 ; note D2 dur 24
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $0a ; volume $0A
    db $1b, $a7 ; note B1 dur 167
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $1b, $37 ; note B1 dur 55
    db $a3, $08 ; mod $08
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $30, $5c ; note C3 dur 92
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $30, $04 ; note C3 dur 4
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2a, $5c ; note A#2 dur 92
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $2a, $04 ; note A#2 dur 4
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2a, $5c ; note A#2 dur 92
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2a, $04 ; note A#2 dur 4
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2b, $40 ; note B2 dur 64
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2b, $20 ; note B2 dur 32
    db $a3, $08 ; mod $08
    db $c3, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $24, $5c ; note E2 dur 92
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $24, $04 ; note E2 dur 4
    db $c3, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $22, $40 ; note D2 dur 64
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $22, $20 ; note D2 dur 32
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $36, $20 ; note F#3 dur 32
    db $34, $22 ; note E3 dur 34
    db $33, $24 ; note D#3 dur 36
    db $31, $25 ; note C#3 dur 37
    db $30, $26 ; note C3 dur 38
    db $2a, $20 ; note A#2 dur 32
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2a, $08 ; note A#2 dur 8
    db $af, $01 ; param $01
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $2a, $37 ; note A#2 dur 55
    db $a0, $01 ; volume $01
    db $33, $6e ; note D#3 dur 110
    db $a3, $03 ; mod $03
    db $c3, $78 ; env $78
    db $a0, $08 ; volume $08
    db $32, $a2 ; note D3 dur 162
    db $a0, $0b ; volume $0B
    db $31, $94 ; note C#3 dur 148
    db $30, $89 ; note C3 dur 137
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $30, $0b ; note C3 dur 11
    db $c3, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $2b, $19 ; note B2 dur 25
    db $31, $1b ; note C#3 dur 27
    db $2b, $1a ; note B2 dur 26
    db $31, $1b ; note C#3 dur 27
    db $2b, $1a ; note B2 dur 26
    db $31, $1b ; note C#3 dur 27
    db $2a, $1c ; note A#2 dur 28
    db $30, $1c ; note C3 dur 28
    db $2a, $1c ; note A#2 dur 28
    db $30, $1c ; note C3 dur 28
    db $2a, $1c ; note A#2 dur 28
    db $30, $1c ; note C3 dur 28
    db $a0, $0a ; volume $0A
    db $c3, $75 ; env $75
    db $31, $a0 ; note C#3 dur 160
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $31, $ba ; note C#3 dur 186
    db $1f, $0c ; rest-note $1F dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 162 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_04::
    db $07, $01, $09, $00 ; header: param=7 byte1=$01 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $af, $07 ; param $07
    db $a3, $0a ; mod $0A
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $32, $20 ; note D3 dur 32
    db $30, $30 ; note C3 dur 48
    db $c5, $78 ; env $78
    db $a0, $08 ; volume $08
    db $2b, $10 ; note B2 dur 16
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2b, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $34, $10 ; note E3 dur 16
    db $c5, $70 ; env $70
    db $a0, $08 ; volume $08
    db $32, $10 ; note D3 dur 16
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $37, $10 ; note G3 dur 16
    db $35, $0b ; note F3 dur 11
    db $a0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $a0, $0c ; volume $0C
    db $35, $10 ; note F3 dur 16
    db $34, $0b ; note E3 dur 11
    db $a0, $06 ; volume $06
    db $34, $05 ; note E3 dur 5
    db $a0, $0c ; volume $0C
    db $34, $10 ; note E3 dur 16
    db $32, $0a ; note D3 dur 10
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $34, $40 ; note E3 dur 64
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $32, $18 ; note D3 dur 24
    db $c1, $6f ; env $6F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $c3, $7f ; env $7F
    db $a3, $0a ; mod $0A
    db $a0, $0c ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2b, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $a0, $0a ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $a0, $0c ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2b, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $a0, $0a ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $a0, $0c ; volume $0C
    db $2b, $10 ; note B2 dur 16
    db $29, $10 ; note A2 dur 16
    db $28, $10 ; note G#2 dur 16
    db $29, $10 ; note A2 dur 16
    db $2b, $10 ; note B2 dur 16
    db $a0, $0a ; volume $0A
    db $29, $10 ; note A2 dur 16
    db $a0, $0c ; volume $0C
    db $2b, $10 ; note B2 dur 16
    db $29, $0b ; note A2 dur 11
    db $a0, $06 ; volume $06
    db $29, $05 ; note A2 dur 5
    db $a0, $0c ; volume $0C
    db $29, $10 ; note A2 dur 16
    db $27, $0b ; note G2 dur 11
    db $a0, $06 ; volume $06
    db $27, $05 ; note G2 dur 5
    db $c3, $58 ; env $58
    db $a0, $0c ; volume $0C
    db $27, $10 ; note G2 dur 16
    db $25, $10 ; note F2 dur 16
    db $a0, $08 ; volume $08
    db $c0, $fe ; env $FE
    db $a3, $00 ; mod $00
    db $24, $a7 ; note E2 dur 167
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $24, $37 ; note E2 dur 55
    db $a3, $0b ; mod $0B
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $34, $20 ; note E3 dur 32
    db $3a, $20 ; note A#3 dur 32
    db $38, $20 ; note G#3 dur 32
    db $a3, $fe ; mod $FE
    db $42, $50 ; note D4 dur 80
    db $c1, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $42, $10 ; note D4 dur 16
    db $c3, $7f ; env $7F
    db $a3, $0b ; mod $0B
    db $a0, $0c ; volume $0C
    db $31, $60 ; note C#3 dur 96
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $32, $50 ; note D3 dur 80
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $32, $10 ; note D3 dur 16
    db $a3, $0d ; mod $0D
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $2a, $20 ; note A#2 dur 32
    db $34, $20 ; note E3 dur 32
    db $32, $20 ; note D3 dur 32
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $38, $50 ; note G#3 dur 80
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $38, $10 ; note G#3 dur 16
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $39, $20 ; note A3 dur 32
    db $37, $22 ; note G3 dur 34
    db $36, $24 ; note F#3 dur 36
    db $34, $25 ; note E3 dur 37
    db $33, $26 ; note D#3 dur 38
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $31, $20 ; note C#3 dur 32
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $31, $08 ; note C#3 dur 8
    db $af, $01 ; param $01
    db $a0, $08 ; volume $08
    db $c0, $fe ; env $FE
    db $a3, $05 ; mod $05
    db $33, $a5 ; note D#3 dur 165
    db $34, $a2 ; note E3 dur 162
    db $35, $94 ; note F3 dur 148
    db $36, $94 ; note F#3 dur 148
    db $37, $9e ; note G3 dur 158
    db $38, $a7 ; note G#3 dur 167
    db $a3, $00 ; mod $00
    db $39, $a0 ; note A3 dur 160
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $39, $ba ; note A3 dur 186
    db $1f, $0d ; rest-note $1F dur 13
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 179 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_05::
    db $07, $ff, $02, $0f ; header: param=7 byte1=$FF volume=$02 byte3=$0F
    db $fd, $f3 ; label 3
    db $af, $07 ; param $07
    db $a3, $0c ; mod $0C
    db $a0, $02 ; volume $02
    db $33, $5e ; note D#3 dur 94
    db $a0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $a0, $02 ; volume $02
    db $34, $40 ; note E3 dur 64
    db $35, $1e ; note F3 dur 30
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $38, $40 ; note G#3 dur 64
    db $37, $20 ; note G3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $a0, $02 ; volume $02
    db $35, $30 ; note F3 dur 48
    db $a0, $04 ; volume $04
    db $35, $10 ; note F3 dur 16
    db $a0, $02 ; volume $02
    db $34, $50 ; note E3 dur 80
    db $a0, $04 ; volume $04
    db $34, $10 ; note E3 dur 16
    db $a0, $02 ; volume $02
    db $33, $50 ; note D#3 dur 80
    db $a0, $04 ; volume $04
    db $33, $10 ; note D#3 dur 16
    db $a0, $02 ; volume $02
    db $32, $50 ; note D3 dur 80
    db $a0, $04 ; volume $04
    db $32, $10 ; note D3 dur 16
    db $a0, $02 ; volume $02
    db $31, $18 ; note C#3 dur 24
    db $a0, $04 ; volume $04
    db $31, $08 ; note C#3 dur 8
    db $a0, $02 ; volume $02
    db $30, $18 ; note C3 dur 24
    db $a0, $04 ; volume $04
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $2b, $18 ; note B2 dur 24
    db $a0, $04 ; volume $04
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $29, $22 ; note A2 dur 34
    db $26, $24 ; note F#2 dur 36
    db $27, $25 ; note G2 dur 37
    db $a0, $02 ; volume $02
    db $28, $46 ; note G#2 dur 70
    db $a0, $04 ; volume $04
    db $28, $16 ; note G#2 dur 22
    db $a2, $20 ; duty2 $20
    db $a0, $06 ; volume $06
    db $28, $17 ; note G#2 dur 23
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $36, $50 ; note F#3 dur 80
    db $a0, $04 ; volume $04
    db $36, $10 ; note F#3 dur 16
    db $a0, $02 ; volume $02
    db $34, $20 ; note E3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $a0, $02 ; volume $02
    db $37, $18 ; note G3 dur 24
    db $a0, $04 ; volume $04
    db $37, $08 ; note G3 dur 8
    db $a0, $02 ; volume $02
    db $38, $20 ; note G#3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $35, $20 ; note F3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $38, $20 ; note G#3 dur 32
    db $a0, $02 ; volume $02
    db $39, $18 ; note A3 dur 24
    db $a0, $04 ; volume $04
    db $39, $08 ; note A3 dur 8
    db $a0, $02 ; volume $02
    db $30, $50 ; note C3 dur 80
    db $a0, $04 ; volume $04
    db $30, $10 ; note C3 dur 16
    db $a0, $02 ; volume $02
    db $2a, $20 ; note A#2 dur 32
    db $30, $20 ; note C3 dur 32
    db $a0, $02 ; volume $02
    db $32, $1c ; note D3 dur 28
    db $a0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $a0, $02 ; volume $02
    db $33, $20 ; note D#3 dur 32
    db $34, $22 ; note E3 dur 34
    db $36, $24 ; note F#3 dur 36
    db $37, $25 ; note G3 dur 37
    db $38, $46 ; note G#3 dur 70
    db $a0, $04 ; volume $04
    db $38, $08 ; note G#3 dur 8
    db $af, $01 ; param $01
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1b ; note A3 dur 27
    db $b2, $f0 ; repeat $F0
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1b ; note A3 dur 27
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1a ; note A3 dur 26
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $19 ; note A3 dur 25
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $17 ; note A3 dur 23
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $17 ; note A3 dur 23
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $19 ; note A3 dur 25
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $1a ; note A3 dur 26
    db $a0, $02 ; volume $02
    db $39, $1b ; note A3 dur 27
    db $a0, $04 ; volume $04
    db $39, $1a ; note A3 dur 26
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1b ; note A3 dur 27
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1c ; note A3 dur 28
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1c ; note A3 dur 28
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a0, $04 ; volume $04
    db $39, $1e ; note A3 dur 30
    db $a2, $ff ; duty2 $FF
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $30, $3b ; note C3 dur 59
    db $31, $3b ; note C#3 dur 59
    db $32, $3b ; note D3 dur 59
    db $33, $40 ; note D#3 dur 64
    db $34, $2c ; note E3 dur 44
    db $a0, $04 ; volume $04
    db $34, $10 ; note E3 dur 16
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 603 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_06::
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $c3, $38 ; env $38
    db $a3, $09 ; mod $09
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $26, $06 ; note F#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $bb, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $2a, $06 ; note A#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $bb, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $2b, $06 ; note B2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $2a, $06 ; note A#2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $bb, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $b3, $f0 ; repeat $F0
    db $a0, $0a ; volume $0A
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $b1, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $fd, $f0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $b1, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $06 ; note A#2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $2b, $06 ; note B2 dur 6
    db $a0, $03 ; volume $03
    db $2b, $12 ; note B2 dur 18
    db $1f, $06 ; rest-note $1F dur 6
    db $a2, $02 ; duty2 $02
    db $c1, $7f ; env $7F
    db $a0, $02 ; volume $02
    db $1f, $12 ; rest-note $1F dur 18
    db $39, $0c ; note A3 dur 12
    db $a2, $00 ; duty2 $00
    db $c3, $48 ; env $48
    db $a0, $09 ; volume $09
    db $2b, $0c ; note B2 dur 12
    db $a0, $05 ; volume $05
    db $2b, $0c ; note B2 dur 12
    db $c3, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $a0, $09 ; volume $09
    db $35, $2c ; note F3 dur 44
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $35, $4c ; note F3 dur 76
    db $a3, $09 ; mod $09
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $c3, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $2b, $30 ; note B2 dur 48
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $2b, $48 ; note B2 dur 72
    db $a3, $09 ; mod $09
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $26, $24 ; note F#2 dur 36
    db $c1, $4f ; env $4F
    db $a0, $05 ; volume $05
    db $26, $0c ; note F#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $26, $24 ; note F#2 dur 36
    db $c1, $4f ; env $4F
    db $a0, $05 ; volume $05
    db $26, $0c ; note F#2 dur 12
    db $c3, $58 ; env $58
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $25, $78 ; note F2 dur 120
    db $a3, $09 ; mod $09
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $25, $18 ; note F2 dur 24
    db $c3, $58 ; env $58
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $24, $0c ; note E2 dur 12
    db $a0, $05 ; volume $05
    db $24, $0c ; note E2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $23, $0c ; note D#2 dur 12
    db $a0, $05 ; volume $05
    db $23, $0c ; note D#2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $22, $0c ; note D2 dur 12
    db $a0, $05 ; volume $05
    db $22, $0c ; note D2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $21, $0c ; note C#2 dur 12
    db $a0, $05 ; volume $05
    db $21, $0c ; note C#2 dur 12
    db $b5, $f0 ; repeat $F0
    db $1f, $0c ; rest-note $1F dur 12
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $1b, $18 ; note B1 dur 24
    db $a0, $05 ; volume $05
    db $15, $0c ; note F1 dur 12
    db $c3, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $2a, $0c ; note A#2 dur 12
    db $a0, $05 ; volume $05
    db $2a, $0c ; note A#2 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $08 ; volume $08
    db $24, $2c ; note E2 dur 44
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $24, $4c ; note E2 dur 76
    db $c0, $fe ; env $FE
    db $a3, $09 ; mod $09
    db $a0, $07 ; volume $07
    db $24, $24 ; note E2 dur 36
    db $a0, $05 ; volume $05
    db $24, $0c ; note E2 dur 12
    db $a0, $07 ; volume $07
    db $24, $24 ; note E2 dur 36
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $24, $18 ; note E2 dur 24
    db $22, $18 ; note D2 dur 24
    db $18, $0c ; note G#1 dur 12
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $31, $0c ; note C#3 dur 12
    db $a0, $05 ; volume $05
    db $31, $0c ; note C#3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $08 ; volume $08
    db $27, $2c ; note G2 dur 44
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $27, $4c ; note G2 dur 76
    db $a3, $09 ; mod $09
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $27, $24 ; note G2 dur 36
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $a0, $07 ; volume $07
    db $27, $24 ; note G2 dur 36
    db $a0, $05 ; volume $05
    db $27, $18 ; note G2 dur 24
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $25, $0c ; note F2 dur 12
    db $25, $0c ; note F2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $25, $0c ; note F2 dur 12
    db $25, $0c ; note F2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $c4, $28 ; env $28
    db $a0, $0c ; volume $0C
    db $10, $05 ; note C1 dur 5
    db $12, $05 ; note D1 dur 5
    db $10, $05 ; note C1 dur 5
    db $12, $05 ; note D1 dur 5
    db $a0, $0e ; volume $0E
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $a0, $0f ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $a0, $0f ; volume $0F
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
    db $a0, $0e ; volume $0E
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0a ; volume $0A
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $a0, $0a ; volume $0A
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $a0, $06 ; volume $06
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $a0, $04 ; volume $04
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $24, $0c ; note E2 dur 12
    db $24, $0c ; note E2 dur 12
    db $29, $0c ; note A2 dur 12
    db $29, $0c ; note A2 dur 12
    db $24, $0c ; note E2 dur 12
    db $24, $0c ; note E2 dur 12
    db $29, $0c ; note A2 dur 12
    db $a0, $0d ; volume $0D
    db $c4, $28 ; env $28
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0e ; volume $0E
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0f ; volume $0F
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0f ; volume $0F
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0e ; volume $0E
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $a0, $0a ; volume $0A
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $a0, $08 ; volume $08
    db $10, $04 ; note C1 dur 4
    db $0b, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $c3, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $24, $0b ; note E2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $0c ; note E2 dur 12
    db $a0, $0a ; volume $0A
    db $27, $0b ; note G2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $0c ; note G2 dur 12
    db $a0, $0a ; volume $0A
    db $2a, $0b ; note A#2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $0c ; note A#2 dur 12
    db $a0, $0a ; volume $0A
    db $31, $0b ; note C#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $31, $0c ; note C#3 dur 12
    db $a0, $0a ; volume $0A
    db $34, $0b ; note E3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $34, $0c ; note E3 dur 12
    db $a0, $0a ; volume $0A
    db $37, $0b ; note G3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $0c ; note G3 dur 12
    db $a0, $0a ; volume $0A
    db $36, $0b ; note F#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $0c ; note F#3 dur 12
    db $a0, $0a ; volume $0A
    db $31, $0b ; note C#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $31, $0c ; note C#3 dur 12
    db $a0, $0a ; volume $0A
    db $28, $0b ; note G#2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $28, $0c ; note G#2 dur 12
    db $a0, $0a ; volume $0A
    db $23, $0b ; note D#2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $23, $0c ; note D#2 dur 12
    db $a0, $0a ; volume $0A
    db $1a, $0b ; note A#1 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1a, $0c ; note A#1 dur 12
    db $a0, $0a ; volume $0A
    db $15, $0b ; note F1 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $16, $0c ; note F#1 dur 12
    db $a0, $0a ; volume $0A
    db $c3, $48 ; env $48
    db $1a, $18 ; note A#1 dur 24
    db $1b, $18 ; note B1 dur 24
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
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 584 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_07::
    db $03, $02, $09, $00 ; header: param=3 byte1=$02 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $c3, $78 ; env $78
    db $a2, $02 ; duty2 $02
    db $a3, $09 ; mod $09
    db $a0, $0e ; volume $0E
    db $32, $30 ; note D3 dur 48
    db $a3, $fe ; mod $FE
    db $39, $3c ; note A3 dur 60
    db $a3, $00 ; mod $00
    db $c1, $5f ; env $5F
    db $a0, $08 ; volume $08
    db $39, $0c ; note A3 dur 12
    db $a3, $09 ; mod $09
    db $c3, $58 ; env $58
    db $a0, $0e ; volume $0E
    db $a3, $fe ; mod $FE
    db $39, $18 ; note A3 dur 24
    db $3a, $18 ; note A#3 dur 24
    db $39, $18 ; note A3 dur 24
    db $c3, $78 ; env $78
    db $38, $30 ; note G#3 dur 48
    db $34, $30 ; note E3 dur 48
    db $2a, $18 ; note A#2 dur 24
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $2a, $18 ; note A#2 dur 24
    db $a3, $09 ; mod $09
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $29, $30 ; note A2 dur 48
    db $a3, $fe ; mod $FE
    db $34, $3c ; note E3 dur 60
    db $a3, $00 ; mod $00
    db $c1, $5f ; env $5F
    db $a0, $08 ; volume $08
    db $34, $0c ; note E3 dur 12
    db $a3, $0e ; mod $0E
    db $c3, $58 ; env $58
    db $a0, $0e ; volume $0E
    db $34, $18 ; note E3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $34, $18 ; note E3 dur 24
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $35, $30 ; note F3 dur 48
    db $36, $30 ; note F#3 dur 48
    db $a0, $09 ; volume $09
    db $40, $24 ; note C4 dur 36
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $40, $0c ; note C4 dur 12
    db $a3, $0e ; mod $0E
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $3b, $12 ; note B3 dur 18
    db $a0, $0f ; volume $0F
    db $40, $0f ; note C4 dur 15
    db $3b, $0f ; note B3 dur 15
    db $3a, $12 ; note A#3 dur 18
    db $39, $0f ; note A3 dur 15
    db $35, $0f ; note F3 dur 15
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $2b, $30 ; note B2 dur 48
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2b, $18 ; note B2 dur 24
    db $a3, $0e ; mod $0E
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $2a, $0c ; note A#2 dur 12
    db $29, $0c ; note A2 dur 12
    db $34, $12 ; note E3 dur 18
    db $35, $0f ; note F3 dur 15
    db $34, $0f ; note E3 dur 15
    db $33, $12 ; note D#3 dur 18
    db $32, $0f ; note D3 dur 15
    db $2a, $0f ; note A#2 dur 15
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $24, $30 ; note E2 dur 48
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $24, $18 ; note E2 dur 24
    db $a3, $0e ; mod $0E
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $25, $0c ; note F2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $27, $90 ; note G2 dur 144
    db $26, $30 ; note F#2 dur 48
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $33, $78 ; note D#3 dur 120
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $33, $18 ; note D#3 dur 24
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $32, $48 ; note D3 dur 72
    db $a3, $0e ; mod $0E
    db $c3, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $33, $18 ; note D#3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3a, $18 ; note A#3 dur 24
    db $41, $18 ; note C#4 dur 24
    db $42, $18 ; note D4 dur 24
    db $43, $18 ; note D#4 dur 24
    db $42, $18 ; note D4 dur 24
    db $41, $18 ; note C#4 dur 24
    db $39, $18 ; note A3 dur 24
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $40, $48 ; note C4 dur 72
    db $a3, $0e ; mod $0E
    db $41, $18 ; note C#4 dur 24
    db $40, $18 ; note C4 dur 24
    db $3b, $18 ; note B3 dur 24
    db $3a, $18 ; note A#3 dur 24
    db $35, $18 ; note F3 dur 24
    db $2b, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $a3, $fe ; mod $FE
    db $33, $0c ; note D#3 dur 12
    db $a0, $05 ; volume $05
    db $33, $0c ; note D#3 dur 12
    db $c3, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $39, $48 ; note A3 dur 72
    db $a3, $06 ; mod $06
    db $c1, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $39, $30 ; note A3 dur 48
    db $a3, $fe ; mod $FE
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $c3, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $33, $48 ; note D#3 dur 72
    db $c1, $7f ; env $7F
    db $a3, $06 ; mod $06
    db $a0, $09 ; volume $09
    db $33, $30 ; note D#3 dur 48
    db $1f, $30 ; rest-note $1F dur 48
    db $a2, $01 ; duty2 $01
    db $a3, $0a ; mod $0A
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $2a, $24 ; note A#2 dur 36
    db $c1, $30 ; env $30
    db $a0, $08 ; volume $08
    db $2a, $0c ; note A#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $2a, $24 ; note A#2 dur 36
    db $c1, $3f ; env $3F
    db $a0, $08 ; volume $08
    db $2a, $0c ; note A#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $a3, $fe ; mod $FE
    db $29, $78 ; note A2 dur 120
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $29, $18 ; note A2 dur 24
    db $a3, $0e ; mod $0E
    db $c3, $78 ; env $78
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $28, $0c ; note G#2 dur 12
    db $a0, $06 ; volume $06
    db $28, $0c ; note G#2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $0c ; note G2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $26, $0c ; note F#2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $26, $0c ; note F#2 dur 12
    db $a0, $06 ; volume $06
    db $26, $0c ; note F#2 dur 12
    db $b4, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $26, $0c ; note F#2 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $26, $48 ; note F#2 dur 72
    db $a0, $05 ; volume $05
    db $2a, $18 ; note A#2 dur 24
    db $24, $0c ; note E2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $39, $0c ; note A3 dur 12
    db $a0, $06 ; volume $06
    db $39, $0c ; note A3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $33, $30 ; note D#3 dur 48
    db $c1, $7f ; env $7F
    db $a3, $0f ; mod $0F
    db $a0, $07 ; volume $07
    db $33, $18 ; note D#3 dur 24
    db $a3, $0e ; mod $0E
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $25, $24 ; note F2 dur 36
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a3, $0e ; mod $0E
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $25, $24 ; note F2 dur 36
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $25, $48 ; note F2 dur 72
    db $a3, $0e ; mod $0E
    db $a0, $05 ; volume $05
    db $31, $18 ; note C#3 dur 24
    db $27, $0c ; note G2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $40, $0c ; note C4 dur 12
    db $a0, $06 ; volume $06
    db $40, $0c ; note C4 dur 12
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $36, $30 ; note F#3 dur 48
    db $c1, $7f ; env $7F
    db $a3, $0f ; mod $0F
    db $a0, $07 ; volume $07
    db $36, $18 ; note F#3 dur 24
    db $a3, $0e ; mod $0E
    db $c0, $fe ; env $FE
    db $fd, $f0 ; label 0
    db $a0, $0b ; volume $0B
    db $28, $24 ; note G#2 dur 36
    db $a0, $06 ; volume $06
    db $28, $0c ; note G#2 dur 12
    db $b1, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0e ; volume $0E
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $0e ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0e ; volume $0E
    db $28, $0b ; note G#2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $28, $0c ; note G#2 dur 12
    db $a0, $0e ; volume $0E
    db $2b, $0b ; note B2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $28, $0c ; note G#2 dur 12
    db $a0, $0e ; volume $0E
    db $32, $0b ; note D3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $2b, $0c ; note B2 dur 12
    db $a0, $0e ; volume $0E
    db $35, $0b ; note F3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $32, $0c ; note D3 dur 12
    db $a0, $0e ; volume $0E
    db $38, $0b ; note G#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $35, $0c ; note F3 dur 12
    db $a0, $0e ; volume $0E
    db $3b, $0b ; note B3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $38, $0c ; note G#3 dur 12
    db $a0, $0e ; volume $0E
    db $3a, $0b ; note A#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $3b, $0c ; note B3 dur 12
    db $a0, $0e ; volume $0E
    db $35, $0b ; note F3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $3a, $0c ; note A#3 dur 12
    db $a0, $0e ; volume $0E
    db $30, $0b ; note C3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $35, $0c ; note F3 dur 12
    db $a0, $0e ; volume $0E
    db $27, $0b ; note G2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $30, $0c ; note C3 dur 12
    db $a0, $0e ; volume $0E
    db $22, $0b ; note D2 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $27, $0c ; note G2 dur 12
    db $a0, $0e ; volume $0E
    db $19, $0b ; note A1 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $01 ; volume $01
    db $22, $0c ; note D2 dur 12
    db $a0, $0e ; volume $0E
    db $22, $18 ; note D2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $18 ; note F2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 799 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_08::
    db $03, $40, $02, $03 ; header: param=3 byte1=$40 volume=$02 byte3=$03
    db $fd, $f3 ; label 3
    db $a2, $40 ; duty2 $40
    db $a1, $03 ; duty $03
    db $a3, $0c ; mod $0C
    db $a0, $04 ; volume $04
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
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3a, $06 ; note A#3 dur 6
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
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
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
    db $1f, $06 ; rest-note $1F dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $32, $06 ; note D3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $27, $24 ; note G2 dur 36
    db $a0, $04 ; volume $04
    db $27, $0c ; note G2 dur 12
    db $a0, $02 ; volume $02
    db $22, $24 ; note D2 dur 36
    db $a0, $04 ; volume $04
    db $22, $0c ; note D2 dur 12
    db $a0, $02 ; volume $02
    db $17, $24 ; note G1 dur 36
    db $a0, $04 ; volume $04
    db $17, $0c ; note G1 dur 12
    db $a2, $30 ; duty2 $30
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $a0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $a0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $a0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $1f, $3c ; rest-note $1F dur 60
    db $3b, $18 ; note B3 dur 24
    db $45, $0c ; note F4 dur 12
    db $a1, $03 ; duty $03
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $37, $0b ; note G3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $37, $0c ; note G3 dur 12
    db $a3, $fe ; mod $FE
    db $a0, $02 ; volume $02
    db $41, $60 ; note C#4 dur 96
    db $a3, $08 ; mod $08
    db $a0, $04 ; volume $04
    db $41, $18 ; note C#4 dur 24
    db $a3, $0c ; mod $0C
    db $a0, $02 ; volume $02
    db $31, $0b ; note C#3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $a0, $02 ; volume $02
    db $37, $0b ; note G3 dur 11
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $37, $0c ; note G3 dur 12
    db $a0, $02 ; volume $02
    db $30, $a8 ; note C3 dur 168
    db $a0, $02 ; volume $02
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2b, $18 ; note B2 dur 24
    db $2a, $48 ; note A#2 dur 72
    db $33, $18 ; note D#3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $27, $18 ; note G2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $1b, $18 ; note B1 dur 24
    db $20, $18 ; note C2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2a, $18 ; note A#2 dur 24
    db $2b, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $25, $78 ; note F2 dur 120
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $25, $30 ; note F2 dur 48
    db $a3, $0c ; mod $0C
    db $a0, $02 ; volume $02
    db $33, $24 ; note D#3 dur 36
    db $a0, $04 ; volume $04
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $33, $24 ; note D#3 dur 36
    db $a0, $04 ; volume $04
    db $33, $0c ; note D#3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0c ; note D3 dur 12
    db $a0, $06 ; volume $06
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $28, $90 ; note G#2 dur 144
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $28, $18 ; note G#2 dur 24
    db $a3, $0c ; mod $0C
    db $a0, $02 ; volume $02
    db $36, $24 ; note F#3 dur 36
    db $a0, $04 ; volume $04
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $36, $24 ; note F#3 dur 36
    db $a0, $04 ; volume $04
    db $36, $0c ; note F#3 dur 12
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a1, $03 ; duty $03
    db $a0, $06 ; volume $06
    db $39, $0c ; note A3 dur 12
    db $38, $18 ; note G#3 dur 24
    db $3b, $18 ; note B3 dur 24
    db $42, $18 ; note D4 dur 24
    db $45, $0c ; note F4 dur 12
    db $a1, $0b ; duty $0B
    db $a2, $50 ; duty2 $50
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a0, $04 ; volume $04
    db $1a, $24 ; note A#1 dur 36
    db $a0, $02 ; volume $02
    db $17, $18 ; note G1 dur 24
    db $a0, $04 ; volume $04
    db $17, $0c ; note G1 dur 12
    db $a0, $06 ; volume $06
    db $17, $30 ; note G1 dur 48
    db $a1, $03 ; duty $03
    db $a0, $06 ; volume $06
    db $37, $18 ; note G3 dur 24
    db $32, $18 ; note D3 dur 24
    db $29, $24 ; note A2 dur 36
    db $a0, $06 ; volume $06
    db $32, $18 ; note D3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $34, $18 ; note E3 dur 24
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a0, $04 ; volume $04
    db $17, $24 ; note G1 dur 36
    db $a0, $02 ; volume $02
    db $14, $18 ; note E1 dur 24
    db $a0, $04 ; volume $04
    db $14, $0c ; note E1 dur 12
    db $a0, $06 ; volume $06
    db $14, $3c ; note E1 dur 60
    db $a1, $03 ; duty $03
    db $a0, $06 ; volume $06
    db $3b, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 582 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_09::
    db $03, $01, $09, $00 ; header: param=3 byte1=$01 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $c3, $5f ; env $5F
    db $a3, $0a ; mod $0A
    db $a0, $0d ; volume $0D
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
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
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1b, $06 ; note B1 dur 6
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
    db $c3, $78 ; env $78
    db $a0, $0b ; volume $0B
    db $34, $60 ; note E3 dur 96
    db $33, $60 ; note D#3 dur 96
    db $34, $60 ; note E3 dur 96
    db $33, $48 ; note D#3 dur 72
    db $c1, $70 ; env $70
    db $a0, $07 ; volume $07
    db $33, $18 ; note D#3 dur 24
    db $c3, $68 ; env $68
    db $a2, $00 ; duty2 $00
    db $a0, $0b ; volume $0B
    db $34, $18 ; note E3 dur 24
    db $32, $30 ; note D3 dur 48
    db $30, $07 ; note C3 dur 7
    db $a0, $08 ; volume $08
    db $30, $11 ; note C3 dur 17
    db $a0, $0d ; volume $0D
    db $24, $18 ; note E2 dur 24
    db $a0, $0b ; volume $0B
    db $22, $11 ; note D2 dur 17
    db $a0, $08 ; volume $08
    db $22, $07 ; note D2 dur 7
    db $a0, $0d ; volume $0D
    db $27, $18 ; note G2 dur 24
    db $a0, $0b ; volume $0B
    db $25, $11 ; note F2 dur 17
    db $a0, $08 ; volume $08
    db $25, $07 ; note F2 dur 7
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $a0, $04 ; volume $04
    db $24, $0c ; note E2 dur 12
    db $a0, $09 ; volume $09
    db $24, $24 ; note E2 dur 36
    db $a0, $05 ; volume $05
    db $24, $0c ; note E2 dur 12
    db $a0, $09 ; volume $09
    db $24, $0c ; note E2 dur 12
    db $a0, $04 ; volume $04
    db $24, $0c ; note E2 dur 12
    db $a0, $09 ; volume $09
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $09 ; volume $09
    db $23, $24 ; note D#2 dur 36
    db $a0, $05 ; volume $05
    db $23, $0c ; note D#2 dur 12
    db $a0, $09 ; volume $09
    db $23, $0c ; note D#2 dur 12
    db $a0, $04 ; volume $04
    db $23, $0c ; note D#2 dur 12
    db $a0, $09 ; volume $09
    db $c3, $78 ; env $78
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0d ; volume $0D
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
    db $a0, $0b ; volume $0B
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
    db $a0, $0c ; volume $0C
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
    db $a0, $0a ; volume $0A
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
    db $a0, $0c ; volume $0C
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
    db $a0, $0a ; volume $0A
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $a0, $0c ; volume $0C
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
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
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2b, $06 ; note B2 dur 6
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
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
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
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2b, $06 ; note B2 dur 6
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
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 193 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0A::
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $a3, $fe ; mod $FE
    db $c3, $48 ; env $48
    db $a2, $02 ; duty2 $02
    db $1f, $18 ; rest-note $1F dur 24
    db $a0, $0b ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $a0, $09 ; volume $09
    db $c0, $fe ; env $FE
    db $3b, $5a ; note B3 dur 90
    db $c1, $5f ; env $5F
    db $a0, $05 ; volume $05
    db $3b, $1e ; note B3 dur 30
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $c3, $78 ; env $78
    db $46, $5a ; note F#4 dur 90
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $46, $1e ; note F#4 dur 30
    db $c1, $7f ; env $7F
    db $a3, $0a ; mod $0A
    db $a0, $0b ; volume $0B
    db $3b, $06 ; note B3 dur 6
    db $40, $06 ; note C4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $c1, $1f ; env $1F
    db $3b, $05 ; note B3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3b, $06 ; note B3 dur 6
    db $a0, $0b ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3b, $06 ; note B3 dur 6
    db $a0, $0b ; volume $0B
    db $3b, $05 ; note B3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $a0, $02 ; volume $02
    db $3b, $24 ; note B3 dur 36
    db $c3, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $3a, $06 ; note A#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $c1, $1f ; env $1F
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0b ; volume $0B
    db $41, $05 ; note C#4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0b ; volume $0B
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $41, $06 ; note C#4 dur 6
    db $a0, $02 ; volume $02
    db $3a, $24 ; note A#3 dur 36
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $3b, $06 ; note B3 dur 6
    db $40, $06 ; note C4 dur 6
    db $3b, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $c1, $1f ; env $1F
    db $3b, $05 ; note B3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3b, $06 ; note B3 dur 6
    db $a0, $0b ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3b, $06 ; note B3 dur 6
    db $a0, $0b ; volume $0B
    db $3b, $05 ; note B3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $a0, $02 ; volume $02
    db $3b, $24 ; note B3 dur 36
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $3a, $06 ; note A#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $c1, $1f ; env $1F
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0b ; volume $0B
    db $41, $05 ; note C#4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0b ; volume $0B
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $41, $06 ; note C#4 dur 6
    db $a0, $02 ; volume $02
    db $3a, $0c ; note A#3 dur 12
    db $a2, $01 ; duty2 $01
    db $c3, $78 ; env $78
    db $a0, $0b ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $37, $30 ; note G3 dur 48
    db $35, $18 ; note F3 dur 24
    db $32, $30 ; note D3 dur 48
    db $35, $2c ; note F3 dur 44
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $36, $60 ; note F#3 dur 96
    db $37, $48 ; note G3 dur 72
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $37, $18 ; note G3 dur 24
    db $fd, $f0 ; label 0
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $2b, $c0 ; note B2 dur 192
    db $32, $90 ; note D3 dur 144
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $32, $30 ; note D3 dur 48
    db $b1, $f0 ; repeat $F0
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $35, $a8 ; note F3 dur 168
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $35, $a8 ; note F3 dur 168
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $35, $30 ; note F3 dur 48
    db $c0, $fe ; env $FE
    db $a3, $0c ; mod $0C
    db $a0, $0a ; volume $0A
    db $32, $60 ; note D3 dur 96
    db $35, $60 ; note F3 dur 96
    db $a3, $0f ; mod $0F
    db $38, $60 ; note G#3 dur 96
    db $a3, $0c ; mod $0C
    db $3b, $30 ; note B3 dur 48
    db $2b, $30 ; note B2 dur 48
    db $fd, $f0 ; label 0
    db $a0, $09 ; volume $09
    db $c0, $fe ; env $FE
    db $31, $54 ; note C#3 dur 84
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $31, $0c ; note C#3 dur 12
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $34, $60 ; note E3 dur 96
    db $31, $48 ; note C#3 dur 72
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $31, $18 ; note C#3 dur 24
    db $b1, $f0 ; repeat $F0
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $2a, $a8 ; note A#2 dur 168
    db $a3, $00 ; mod $00
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $2a, $a8 ; note A#2 dur 168
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $2a, $30 ; note A#2 dur 48
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 408 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0B::
    db $03, $ff, $02, $0e ; header: param=3 byte1=$FF volume=$02 byte3=$0E
    db $fd, $f3 ; label 3
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $04 ; volume $04
    db $34, $60 ; note E3 dur 96
    db $36, $60 ; note F#3 dur 96
    db $34, $60 ; note E3 dur 96
    db $29, $54 ; note A2 dur 84
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a7, $18 ; wait $18
    db $a1, $0f ; duty $0F
    db $a2, $15 ; duty2 $15
    db $a0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $49, $06 ; note A4 dur 6
    db $47, $06 ; note G4 dur 6
    db $45, $06 ; note F4 dur 6
    db $a2, $0f ; duty2 $0F
    db $47, $06 ; note G4 dur 6
    db $a0, $06 ; volume $06
    db $47, $06 ; note G4 dur 6
    db $a0, $02 ; volume $02
    db $4b, $06 ; note B4 dur 6
    db $a0, $06 ; volume $06
    db $4b, $06 ; note B4 dur 6
    db $a0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $a0, $06 ; volume $06
    db $47, $2a ; note G4 dur 42
    db $a2, $15 ; duty2 $15
    db $a0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $48, $06 ; note G#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $a2, $0f ; duty2 $0F
    db $46, $06 ; note F#4 dur 6
    db $a0, $06 ; volume $06
    db $46, $06 ; note F#4 dur 6
    db $a0, $02 ; volume $02
    db $4a, $06 ; note A#4 dur 6
    db $a0, $06 ; volume $06
    db $4a, $06 ; note A#4 dur 6
    db $a0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $a0, $06 ; volume $06
    db $46, $2a ; note F#4 dur 42
    db $a2, $15 ; duty2 $15
    db $a0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $49, $06 ; note A4 dur 6
    db $47, $06 ; note G4 dur 6
    db $45, $06 ; note F4 dur 6
    db $a2, $0f ; duty2 $0F
    db $47, $06 ; note G4 dur 6
    db $a0, $06 ; volume $06
    db $47, $06 ; note G4 dur 6
    db $a0, $02 ; volume $02
    db $4b, $06 ; note B4 dur 6
    db $a0, $06 ; volume $06
    db $4b, $06 ; note B4 dur 6
    db $a0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $a0, $06 ; volume $06
    db $47, $2a ; note G4 dur 42
    db $a2, $15 ; duty2 $15
    db $a0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $48, $06 ; note G#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $a2, $0f ; duty2 $0F
    db $46, $06 ; note F#4 dur 6
    db $a0, $06 ; volume $06
    db $46, $06 ; note F#4 dur 6
    db $a0, $02 ; volume $02
    db $4a, $06 ; note A#4 dur 6
    db $a0, $06 ; volume $06
    db $4a, $06 ; note A#4 dur 6
    db $a0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $a0, $06 ; volume $06
    db $46, $12 ; note F#4 dur 18
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $04 ; volume $04
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3b, $06 ; note B3 dur 6
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
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3a, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $1f, $30 ; rest-note $1F dur 48
    db $a2, $ff ; duty2 $FF
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $2a, $30 ; note A#2 dur 48
    db $28, $30 ; note G#2 dur 48
    db $26, $24 ; note F#2 dur 36
    db $a0, $04 ; volume $04
    db $26, $1c ; note F#2 dur 28
    db $a2, $50 ; duty2 $50
    db $a0, $06 ; volume $06
    db $26, $20 ; note F#2 dur 32
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $31, $30 ; note C#3 dur 48
    db $2b, $30 ; note B2 dur 48
    db $29, $24 ; note A2 dur 36
    db $a0, $04 ; volume $04
    db $29, $1c ; note A2 dur 28
    db $a2, $50 ; duty2 $50
    db $a0, $06 ; volume $06
    db $29, $20 ; note A2 dur 32
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $2a, $0c ; note A#2 dur 12
    db $2b, $0c ; note B2 dur 12
    db $31, $0c ; note C#3 dur 12
    db $2b, $0c ; note B2 dur 12
    db $2a, $13 ; note A#2 dur 19
    db $a0, $04 ; volume $04
    db $2a, $0d ; note A#2 dur 13
    db $a0, $02 ; volume $02
    db $28, $13 ; note G#2 dur 19
    db $a0, $04 ; volume $04
    db $28, $0d ; note G#2 dur 13
    db $a0, $02 ; volume $02
    db $26, $13 ; note F#2 dur 19
    db $a0, $04 ; volume $04
    db $26, $1d ; note F#2 dur 29
    db $a2, $30 ; duty2 $30
    db $a0, $06 ; volume $06
    db $26, $20 ; note F#2 dur 32
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $31, $0c ; note C#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $13 ; note C#3 dur 19
    db $a0, $04 ; volume $04
    db $31, $0d ; note C#3 dur 13
    db $a0, $02 ; volume $02
    db $2b, $13 ; note B2 dur 19
    db $a0, $04 ; volume $04
    db $2b, $0d ; note B2 dur 13
    db $a0, $02 ; volume $02
    db $29, $13 ; note A2 dur 19
    db $a0, $04 ; volume $04
    db $29, $1d ; note A2 dur 29
    db $a2, $30 ; duty2 $30
    db $a0, $06 ; volume $06
    db $29, $20 ; note A2 dur 32
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $37, $29 ; note G3 dur 41
    db $a0, $04 ; volume $04
    db $37, $07 ; note G3 dur 7
    db $a0, $02 ; volume $02
    db $35, $29 ; note F3 dur 41
    db $a0, $04 ; volume $04
    db $35, $07 ; note F3 dur 7
    db $a0, $02 ; volume $02
    db $33, $29 ; note D#3 dur 41
    db $a0, $04 ; volume $04
    db $33, $07 ; note D#3 dur 7
    db $a0, $02 ; volume $02
    db $34, $18 ; note E3 dur 24
    db $35, $18 ; note F3 dur 24
    db $37, $18 ; note G3 dur 24
    db $35, $18 ; note F3 dur 24
    db $34, $13 ; note E3 dur 19
    db $a0, $04 ; volume $04
    db $34, $0d ; note E3 dur 13
    db $a0, $02 ; volume $02
    db $32, $13 ; note D3 dur 19
    db $a0, $04 ; volume $04
    db $32, $0d ; note D3 dur 13
    db $a0, $02 ; volume $02
    db $30, $13 ; note C3 dur 19
    db $a0, $04 ; volume $04
    db $30, $0d ; note C3 dur 13
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $2b, $11 ; note B2 dur 17
    db $a0, $04 ; volume $04
    db $2b, $07 ; note B2 dur 7
    db $a0, $02 ; volume $02
    db $2b, $24 ; note B2 dur 36
    db $a0, $04 ; volume $04
    db $2b, $0c ; note B2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $11 ; note B2 dur 17
    db $a0, $04 ; volume $04
    db $2b, $07 ; note B2 dur 7
    db $b3, $f0 ; repeat $F0
    db $a2, $20 ; duty2 $20
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $2b, $07 ; note B2 dur 7
    db $a0, $04 ; volume $04
    db $2b, $11 ; note B2 dur 17
    db $a0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $a0, $04 ; volume $04
    db $24, $29 ; note E2 dur 41
    db $a0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $a0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $2b, $07 ; note B2 dur 7
    db $a0, $04 ; volume $04
    db $2b, $11 ; note B2 dur 17
    db $a0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $a0, $04 ; volume $04
    db $24, $29 ; note E2 dur 41
    db $a0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $a0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $a0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $a0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $a0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $a0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $29 ; note A#1 dur 41
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $11 ; note A#1 dur 17
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $29 ; note A#1 dur 41
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $29 ; note A#1 dur 41
    db $a0, $02 ; volume $02
    db $19, $07 ; note A1 dur 7
    db $a0, $04 ; volume $04
    db $19, $11 ; note A1 dur 17
    db $a0, $02 ; volume $02
    db $1a, $07 ; note A#1 dur 7
    db $a0, $04 ; volume $04
    db $1a, $11 ; note A#1 dur 17
    db $a0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $a0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $a0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $a0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $a0, $02 ; volume $02
    db $29, $07 ; note A2 dur 7
    db $a0, $04 ; volume $04
    db $29, $11 ; note A2 dur 17
    db $a0, $02 ; volume $02
    db $2a, $07 ; note A#2 dur 7
    db $a0, $04 ; volume $04
    db $2a, $11 ; note A#2 dur 17
    db $a0, $02 ; volume $02
    db $31, $07 ; note C#3 dur 7
    db $a0, $04 ; volume $04
    db $31, $11 ; note C#3 dur 17
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 435 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0C::
    db $03, $01, $09, $00 ; header: param=3 byte1=$01 volume=$09 byte3=$00
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $1f, $80 ; rest-note $1F dur 128
    db $c1, $7f ; env $7F
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $15 ; env $15
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $c1, $7f ; env $7F
    db $36, $18 ; note F#3 dur 24
    db $a0, $05 ; volume $05
    db $36, $08 ; note F#3 dur 8
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $c2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $c1, $7f ; env $7F
    db $37, $18 ; note G3 dur 24
    db $a0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $a0, $09 ; volume $09
    db $c2, $15 ; env $15
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $c1, $7f ; env $7F
    db $27, $18 ; note G2 dur 24
    db $a0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $a0, $09 ; volume $09
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $c2, $15 ; env $15
    db $3a, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $c1, $7f ; env $7F
    db $2b, $18 ; note B2 dur 24
    db $a0, $05 ; volume $05
    db $2b, $08 ; note B2 dur 8
    db $a0, $08 ; volume $08
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $2b, $20 ; note B2 dur 32
    db $b4, $f0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2b, $20 ; note B2 dur 32
    db $2b, $20 ; note B2 dur 32
    db $fd, $f0 ; label 0
    db $30, $20 ; note C3 dur 32
    db $b3, $f0 ; repeat $F0
    db $29, $20 ; note A2 dur 32
    db $27, $20 ; note G2 dur 32
    db $26, $20 ; note F#2 dur 32
    db $26, $20 ; note F#2 dur 32
    db $a0, $06 ; volume $06
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $23, $10 ; note D#2 dur 16
    db $20, $10 ; note C2 dur 16
    db $c0, $fe ; env $FE
    db $18, $30 ; note G#1 dur 48
    db $c1, $7f ; env $7F
    db $18, $10 ; note G#1 dur 16
    db $a0, $0f ; volume $0F
    db $c2, $18 ; env $18
    db $32, $10 ; note D3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $25, $10 ; note F2 dur 16
    db $22, $10 ; note D2 dur 16
    db $c0, $fe ; env $FE
    db $1a, $30 ; note A#1 dur 48
    db $c1, $7f ; env $7F
    db $1a, $10 ; note A#1 dur 16
    db $a0, $0a ; volume $0A
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $2b, $20 ; note B2 dur 32
    db $b4, $f0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2b, $20 ; note B2 dur 32
    db $2b, $20 ; note B2 dur 32
    db $fd, $f3 ; label 3
    db $1f, $c0 ; rest-note $1F dur 192
    db $a2, $02 ; duty2 $02
    db $a3, $05 ; mod $05
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2a, $30 ; note A#2 dur 48
    db $26, $20 ; note F#2 dur 32
    db $27, $10 ; note G2 dur 16
    db $29, $30 ; note A2 dur 48
    db $c0, $fe ; env $FE
    db $a0, $06 ; volume $06
    db $28, $20 ; note G#2 dur 32
    db $a3, $00 ; mod $00
    db $c1, $48 ; env $48
    db $a0, $04 ; volume $04
    db $28, $20 ; note G#2 dur 32
    db $c3, $7f ; env $7F
    db $a3, $05 ; mod $05
    db $a0, $09 ; volume $09
    db $29, $10 ; note A2 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $29, $10 ; note A2 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $20 ; note G2 dur 32
    db $27, $10 ; note G2 dur 16
    db $c0, $fe ; env $FE
    db $a0, $06 ; volume $06
    db $25, $20 ; note F2 dur 32
    db $c1, $48 ; env $48
    db $a0, $04 ; volume $04
    db $25, $20 ; note F2 dur 32
    db $c3, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $33, $08 ; note D#3 dur 8
    db $34, $08 ; note E3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $34, $08 ; note E3 dur 8
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $0f ; note C3 dur 15
    db $a0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $a0, $09 ; volume $09
    db $30, $28 ; note C3 dur 40
    db $31, $08 ; note C#3 dur 8
    db $32, $20 ; note D3 dur 32
    db $c1, $48 ; env $48
    db $a0, $06 ; volume $06
    db $32, $20 ; note D3 dur 32
    db $c3, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $2a, $08 ; note A#2 dur 8
    db $29, $08 ; note A2 dur 8
    db $2a, $08 ; note A#2 dur 8
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $20, $08 ; note C2 dur 8
    db $c1, $48 ; env $48
    db $a0, $03 ; volume $03
    db $20, $08 ; note C2 dur 8
    db $c3, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $a0, $05 ; volume $05
    db $c0, $fe ; env $FE
    db $26, $28 ; note F#2 dur 40
    db $c7, $28 ; env $28
    db $a0, $03 ; volume $03
    db $26, $90 ; note F#2 dur 144
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $c1, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $15 ; env $15
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $a2, $01 ; duty2 $01
    db $c1, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $29, $08 ; note A2 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $c2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $a2, $01 ; duty2 $01
    db $c1, $7f ; env $7F
    db $a0, $09 ; volume $09
    db $2a, $08 ; note A#2 dur 8
    db $2b, $08 ; note B2 dur 8
    db $2a, $08 ; note A#2 dur 8
    db $2b, $08 ; note B2 dur 8
    db $27, $08 ; note G2 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $c2, $15 ; env $15
    db $40, $08 ; note C4 dur 8
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $c1, $7f ; env $7F
    db $27, $18 ; note G2 dur 24
    db $a0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $a0, $09 ; volume $09
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $c2, $15 ; env $15
    db $3a, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $a2, $01 ; duty2 $01
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $c2, $60 ; env $60
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $a0, $07 ; volume $07
    db $a2, $01 ; duty2 $01
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $a0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $36, $08 ; note F#3 dur 8
    db $a0, $03 ; volume $03
    db $36, $08 ; note F#3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $a0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $29, $08 ; note A2 dur 8
    db $a0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $27, $08 ; note G2 dur 8
    db $a0, $02 ; volume $02
    db $27, $08 ; note G2 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $40 ; env $40
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $a0, $03 ; volume $03
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $a2, $01 ; duty2 $01
    db $a0, $07 ; volume $07
    db $26, $08 ; note F#2 dur 8
    db $a0, $02 ; volume $02
    db $26, $08 ; note F#2 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $36, $08 ; note F#3 dur 8
    db $a0, $05 ; volume $05
    db $36, $08 ; note F#3 dur 8
    db $a0, $0a ; volume $0A
    db $35, $08 ; note F3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $35, $08 ; note F3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $c2, $18 ; env $18
    db $a0, $06 ; volume $06
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $23, $10 ; note D#2 dur 16
    db $20, $10 ; note C2 dur 16
    db $c1, $7f ; env $7F
    db $18, $10 ; note G#1 dur 16
    db $a0, $08 ; volume $08
    db $a2, $00 ; duty2 $00
    db $23, $08 ; note D#2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $30, $08 ; note C3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $40, $08 ; note C4 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0b ; volume $0B
    db $c2, $18 ; env $18
    db $32, $10 ; note D3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $25, $10 ; note F2 dur 16
    db $22, $10 ; note D2 dur 16
    db $c1, $7f ; env $7F
    db $1a, $10 ; note A#1 dur 16
    db $a0, $0c ; volume $0C
    db $a2, $00 ; duty2 $00
    db $25, $08 ; note F2 dur 8
    db $2a, $08 ; note A#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $42, $08 ; note D4 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $2b, $20 ; note B2 dur 32
    db $b4, $f0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2b, $20 ; note B2 dur 32
    db $2b, $20 ; note B2 dur 32
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 430 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0D::
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $a2, $02 ; duty2 $02
    db $a0, $0b ; volume $0B
    db $1f, $80 ; rest-note $1F dur 128
    db $a3, $06 ; mod $06
    db $c1, $7f ; env $7F
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $c2, $15 ; env $15
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $c1, $7f ; env $7F
    db $39, $18 ; note A3 dur 24
    db $a0, $06 ; volume $06
    db $39, $08 ; note A3 dur 8
    db $a0, $0b ; volume $0B
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $c2, $15 ; env $15
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $c1, $7f ; env $7F
    db $3b, $18 ; note B3 dur 24
    db $a0, $06 ; volume $06
    db $3b, $08 ; note B3 dur 8
    db $a0, $0b ; volume $0B
    db $c2, $15 ; env $15
    db $44, $08 ; note E4 dur 8
    db $44, $08 ; note E4 dur 8
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $c1, $7f ; env $7F
    db $2b, $18 ; note B2 dur 24
    db $a0, $08 ; volume $08
    db $2b, $08 ; note B2 dur 8
    db $a0, $0b ; volume $0B
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $c2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $3a, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $c1, $7f ; env $7F
    db $37, $18 ; note G3 dur 24
    db $a0, $06 ; volume $06
    db $37, $08 ; note G3 dur 8
    db $a0, $0c ; volume $0C
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $34, $20 ; note E3 dur 32
    db $b3, $f0 ; repeat $F0
    db $31, $20 ; note C#3 dur 32
    db $31, $20 ; note C#3 dur 32
    db $30, $20 ; note C3 dur 32
    db $30, $20 ; note C3 dur 32
    db $a0, $09 ; volume $09
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $c0, $fe ; env $FE
    db $20, $30 ; note C2 dur 48
    db $c1, $7f ; env $7F
    db $20, $10 ; note C2 dur 16
    db $a0, $0f ; volume $0F
    db $c2, $18 ; env $18
    db $36, $10 ; note F#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $c0, $fe ; env $FE
    db $22, $30 ; note D2 dur 48
    db $c1, $7f ; env $7F
    db $22, $10 ; note D2 dur 16
    db $a0, $0c ; volume $0C
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $b7, $f0 ; repeat $F0
    db $fd, $f3 ; label 3
    db $a2, $02 ; duty2 $02
    db $1f, $05 ; rest-note $1F dur 5
    db $a3, $02 ; mod $02
    db $a0, $04 ; volume $04
    db $c1, $78 ; env $78
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
    db $22, $0b ; note D2 dur 11
    db $a3, $09 ; mod $09
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $37, $30 ; note G3 dur 48
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $32, $20 ; note D3 dur 32
    db $33, $10 ; note D#3 dur 16
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $a3, $03 ; mod $03
    db $30, $20 ; note C3 dur 32
    db $c1, $48 ; env $48
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $30, $20 ; note C3 dur 32
    db $a3, $09 ; mod $09
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $31, $10 ; note C#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $31, $10 ; note C#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $37, $10 ; note G3 dur 16
    db $35, $20 ; note F3 dur 32
    db $33, $10 ; note D#3 dur 16
    db $a0, $0c ; volume $0C
    db $a3, $00 ; mod $00
    db $2a, $20 ; note A#2 dur 32
    db $c1, $48 ; env $48
    db $a0, $09 ; volume $09
    db $2a, $20 ; note A#2 dur 32
    db $a3, $09 ; mod $09
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $43, $10 ; note D#4 dur 16
    db $40, $10 ; note C4 dur 16
    db $37, $10 ; note G3 dur 16
    db $a3, $00 ; mod $00
    db $a0, $0c ; volume $0C
    db $33, $28 ; note D#3 dur 40
    db $a0, $0d ; volume $0D
    db $a3, $09 ; mod $09
    db $34, $08 ; note E3 dur 8
    db $a0, $0a ; volume $0A
    db $a3, $03 ; mod $03
    db $c0, $fe ; env $FE
    db $35, $20 ; note F3 dur 32
    db $c1, $48 ; env $48
    db $a0, $09 ; volume $09
    db $35, $20 ; note F3 dur 32
    db $a3, $09 ; mod $09
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $3a, $10 ; note A#3 dur 16
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $32, $40 ; note D3 dur 64
    db $c1, $48 ; env $48
    db $a0, $08 ; volume $08
    db $a3, $00 ; mod $00
    db $32, $28 ; note D3 dur 40
    db $a0, $05 ; volume $05
    db $1f, $04 ; rest-note $1F dur 4
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $0c ; note D2 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $0c ; volume $0C
    db $c1, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $c2, $15 ; env $15
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3b, $10 ; note B3 dur 16
    db $c1, $7f ; env $7F
    db $39, $18 ; note A3 dur 24
    db $a0, $06 ; volume $06
    db $39, $08 ; note A3 dur 8
    db $a0, $0d ; volume $0D
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $c2, $15 ; env $15
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $c1, $7f ; env $7F
    db $3b, $18 ; note B3 dur 24
    db $a0, $06 ; volume $06
    db $3b, $08 ; note B3 dur 8
    db $a0, $0d ; volume $0D
    db $c2, $15 ; env $15
    db $44, $08 ; note E4 dur 8
    db $44, $08 ; note E4 dur 8
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $c1, $7f ; env $7F
    db $2b, $18 ; note B2 dur 24
    db $a0, $08 ; volume $08
    db $2b, $08 ; note B2 dur 8
    db $a0, $0d ; volume $0D
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $c2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $3a, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $c1, $7f ; env $7F
    db $37, $18 ; note G3 dur 24
    db $a0, $06 ; volume $06
    db $37, $08 ; note G3 dur 8
    db $c2, $60 ; env $60
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $60 ; env $60
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $60 ; env $60
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $a0, $04 ; volume $04
    db $3b, $08 ; note B3 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $60 ; env $60
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $08 ; volume $08
    db $40, $08 ; note C4 dur 8
    db $a0, $03 ; volume $03
    db $40, $08 ; note C4 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $3b, $08 ; note B3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $c2, $60 ; env $60
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $a0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $c2, $60 ; env $60
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $a0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $a2, $00 ; duty2 $00
    db $c2, $60 ; env $60
    db $a0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $a0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $a0, $04 ; volume $04
    db $40, $08 ; note C4 dur 8
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $31, $08 ; note C#3 dur 8
    db $a0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $39, $08 ; note A3 dur 8
    db $c2, $60 ; env $60
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $31, $08 ; note C#3 dur 8
    db $a0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $a2, $02 ; duty2 $02
    db $c2, $40 ; env $40
    db $a0, $08 ; volume $08
    db $39, $08 ; note A3 dur 8
    db $a0, $03 ; volume $03
    db $39, $08 ; note A3 dur 8
    db $c2, $60 ; env $60
    db $a2, $00 ; duty2 $00
    db $a0, $08 ; volume $08
    db $30, $08 ; note C3 dur 8
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $a0, $03 ; volume $03
    db $39, $08 ; note A3 dur 8
    db $a0, $0a ; volume $0A
    db $38, $08 ; note G#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $c2, $18 ; env $18
    db $a0, $09 ; volume $09
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $c0, $fe ; env $FE
    db $20, $30 ; note C2 dur 48
    db $c1, $7f ; env $7F
    db $20, $10 ; note C2 dur 16
    db $a0, $0d ; volume $0D
    db $c2, $18 ; env $18
    db $36, $10 ; note F#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $c0, $fe ; env $FE
    db $22, $30 ; note D2 dur 48
    db $c1, $7f ; env $7F
    db $22, $10 ; note D2 dur 16
    db $a0, $0c ; volume $0C
    db $c2, $18 ; env $18
    db $fd, $f0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $b7, $f0 ; repeat $F0
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 529 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0E::
    db $03, $40, $02, $02 ; header: param=3 byte1=$40 volume=$02 byte3=$02
    db $a2, $16 ; duty2 $16
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $fd, $f0 ; label 0
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $b5, $f0 ; repeat $F0
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
    db $2a, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $a1, $0a ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $ff ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $a0, $06 ; volume $06
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $a2, $20 ; duty2 $20
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $ff ; duty2 $FF
    db $27, $18 ; note G2 dur 24
    db $a0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $a2, $20 ; duty2 $20
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $24, $10 ; note E2 dur 16
    db $a2, $ff ; duty2 $FF
    db $24, $18 ; note E2 dur 24
    db $a0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $a0, $02 ; volume $02
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
    db $a2, $20 ; duty2 $20
    db $22, $10 ; note D2 dur 16
    db $19, $10 ; note A1 dur 16
    db $a2, $ff ; duty2 $FF
    db $12, $18 ; note D1 dur 24
    db $a0, $04 ; volume $04
    db $12, $08 ; note D1 dur 8
    db $a1, $08 ; duty $08
    db $a0, $02 ; volume $02
    db $a2, $20 ; duty2 $20
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $18, $10 ; note G#1 dur 16
    db $a0, $06 ; volume $06
    db $18, $10 ; note G#1 dur 16
    db $a0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $39, $10 ; note A3 dur 16
    db $35, $10 ; note F3 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $25, $10 ; note F2 dur 16
    db $1a, $10 ; note A#1 dur 16
    db $a0, $06 ; volume $06
    db $1a, $10 ; note A#1 dur 16
    db $a0, $02 ; volume $02
    db $1a, $10 ; note A#1 dur 16
    db $a1, $0a ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $ff ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $a2, $20 ; duty2 $20
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $ff ; duty2 $FF
    db $27, $18 ; note G2 dur 24
    db $a0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $fd, $f3 ; label 3
    db $a1, $07 ; duty $07
    db $a2, $50 ; duty2 $50
    db $a0, $02 ; volume $02
    db $27, $10 ; note G2 dur 16
    db $a2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a2, $50 ; duty2 $50
    db $a0, $02 ; volume $02
    db $22, $10 ; note D2 dur 16
    db $a2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a2, $50 ; duty2 $50
    db $a0, $02 ; volume $02
    db $27, $10 ; note G2 dur 16
    db $a2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a2, $50 ; duty2 $50
    db $a0, $02 ; volume $02
    db $22, $10 ; note D2 dur 16
    db $a2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $13, $10 ; note D#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $1a, $0e ; note A#1 dur 14
    db $a0, $04 ; volume $04
    db $1a, $02 ; note A#1 dur 2
    db $a0, $02 ; volume $02
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $1a, $0e ; note A#1 dur 14
    db $a0, $04 ; volume $04
    db $1a, $02 ; note A#1 dur 2
    db $a0, $02 ; volume $02
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $20, $0e ; note C2 dur 14
    db $a0, $04 ; volume $04
    db $20, $02 ; note C2 dur 2
    db $a0, $02 ; volume $02
    db $29, $0e ; note A2 dur 14
    db $a0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $20, $0e ; note C2 dur 14
    db $a0, $04 ; volume $04
    db $20, $02 ; note C2 dur 2
    db $a0, $02 ; volume $02
    db $28, $0e ; note G#2 dur 14
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $12, $10 ; note D1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $1a, $0e ; note A#1 dur 14
    db $a0, $04 ; volume $04
    db $1a, $02 ; note A#1 dur 2
    db $a0, $02 ; volume $02
    db $25, $0e ; note F2 dur 14
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $0a, $10 ; note A#0 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $22, $0e ; note D2 dur 14
    db $a0, $04 ; volume $04
    db $22, $02 ; note D2 dur 2
    db $a0, $02 ; volume $02
    db $28, $0e ; note G#2 dur 14
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $13, $10 ; note D#1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $1a, $0e ; note A#1 dur 14
    db $a0, $04 ; volume $04
    db $1a, $02 ; note A#1 dur 2
    db $a0, $02 ; volume $02
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $17, $10 ; note G1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $22, $0e ; note D2 dur 14
    db $a0, $04 ; volume $04
    db $22, $02 ; note D2 dur 2
    db $a0, $02 ; volume $02
    db $2a, $0e ; note A#2 dur 14
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $20, $10 ; note C2 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $34, $0e ; note E3 dur 14
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $15, $10 ; note F1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $28, $0e ; note G#2 dur 14
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $33, $0e ; note D#3 dur 14
    db $a0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $1a, $10 ; note A#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $2a, $0e ; note A#2 dur 14
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $2a, $0e ; note A#2 dur 14
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $1a, $10 ; note A#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $2a, $0e ; note A#2 dur 14
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $2a, $0e ; note A#2 dur 14
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $1a, $0e ; note A#1 dur 14
    db $a0, $04 ; volume $04
    db $1a, $02 ; note A#1 dur 2
    db $a0, $02 ; volume $02
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $18, $10 ; note G#1 dur 16
    db $a1, $03 ; duty $03
    db $a2, $7f ; duty2 $7F
    db $23, $0e ; note D#2 dur 14
    db $a0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $a0, $02 ; volume $02
    db $28, $0e ; note G#2 dur 14
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $12, $10 ; note D1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $19, $10 ; note A1 dur 16
    db $22, $10 ; note D2 dur 16
    db $29, $11 ; note A2 dur 17
    db $22, $13 ; note D2 dur 19
    db $a0, $02 ; volume $02
    db $12, $14 ; note D1 dur 20
    db $a0, $02 ; volume $02
    db $a2, $16 ; duty2 $16
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $fd, $f0 ; label 0
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $b5, $f0 ; repeat $F0
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
    db $2a, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $a1, $0a ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $7f ; duty2 $7F
    db $22, $18 ; note D2 dur 24
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $a0, $06 ; volume $06
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $a2, $12 ; duty2 $12
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $7f ; duty2 $7F
    db $27, $18 ; note G2 dur 24
    db $a0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $a2, $12 ; duty2 $12
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $24, $10 ; note E2 dur 16
    db $a2, $7f ; duty2 $7F
    db $24, $18 ; note E2 dur 24
    db $a0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $a0, $02 ; volume $02
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
    db $a2, $12 ; duty2 $12
    db $22, $10 ; note D2 dur 16
    db $19, $10 ; note A1 dur 16
    db $a2, $7f ; duty2 $7F
    db $12, $18 ; note D1 dur 24
    db $a0, $04 ; volume $04
    db $12, $08 ; note D1 dur 8
    db $a1, $08 ; duty $08
    db $a0, $02 ; volume $02
    db $a2, $12 ; duty2 $12
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $2a, $10 ; note A#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $18, $10 ; note G#1 dur 16
    db $a0, $06 ; volume $06
    db $18, $10 ; note G#1 dur 16
    db $a0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $39, $10 ; note A3 dur 16
    db $35, $10 ; note F3 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $25, $10 ; note F2 dur 16
    db $1a, $10 ; note A#1 dur 16
    db $a0, $06 ; volume $06
    db $1a, $10 ; note A#1 dur 16
    db $a0, $02 ; volume $02
    db $1a, $10 ; note A#1 dur 16
    db $a1, $0a ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $7f ; duty2 $7F
    db $22, $18 ; note D2 dur 24
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $a2, $12 ; duty2 $12
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $a2, $7f ; duty2 $7F
    db $27, $18 ; note G2 dur 24
    db $a0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 539 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_0F::
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $a3, $08 ; mod $08
    db $c1, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $29, $03 ; note A2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $25, $24 ; note F2 dur 36
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a7, $18 ; wait $18
    db $fd, $f3 ; label 3
    db $a7, $0c ; wait $0C
    db $a2, $01 ; duty2 $01
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $2a, $04 ; note A#2 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $32, $18 ; note D3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $32, $24 ; note D3 dur 36
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $25, $04 ; note F2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $35, $18 ; note F3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $35, $24 ; note F3 dur 36
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $27, $04 ; note G2 dur 4
    db $2a, $04 ; note A#2 dur 4
    db $32, $04 ; note D3 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $37, $18 ; note G3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $37, $24 ; note G3 dur 36
    db $c3, $58 ; env $58
    db $a0, $0b ; volume $0B
    db $25, $04 ; note F2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $09 ; volume $09
    db $c3, $68 ; env $68
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $c3, $58 ; env $58
    db $a0, $0b ; volume $0B
    db $1a, $04 ; note A#1 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $a0, $09 ; volume $09
    db $c3, $68 ; env $68
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $30, $04 ; note C3 dur 4
    db $c3, $68 ; env $68
    db $a0, $08 ; volume $08
    db $33, $18 ; note D#3 dur 24
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $c3, $48 ; env $48
    db $a2, $02 ; duty2 $02
    db $a0, $0a ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $0a ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $0a ; volume $0A
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $39, $06 ; note A3 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0a ; volume $0A
    db $2b, $05 ; note B2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0a ; volume $0A
    db $3b, $05 ; note B3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $0a ; volume $0A
    db $40, $05 ; note C4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $3b, $03 ; note B3 dur 3
    db $c1, $2f ; env $2F
    db $a0, $03 ; volume $03
    db $40, $15 ; note C4 dur 21
    db $a2, $00 ; duty2 $00
    db $33, $0c ; note D#3 dur 12
    db $35, $12 ; note F3 dur 18
    db $a2, $01 ; duty2 $01
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2a, $04 ; note A#2 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $33, $10 ; note D#3 dur 16
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $a7, $08 ; wait $08
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2a, $04 ; note A#2 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $33, $18 ; note D#3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $08 ; volume $08
    db $c3, $78 ; env $78
    db $33, $18 ; note D#3 dur 24
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $c3, $58 ; env $58
    db $a0, $0c ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $08 ; volume $08
    db $c3, $68 ; env $68
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $a0, $09 ; volume $09
    db $c3, $68 ; env $68
    db $29, $0c ; note A2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $30, $0c ; note C3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $04 ; volume $04
    db $33, $0c ; note D#3 dur 12
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $33, $04 ; note D#3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $07 ; volume $07
    db $39, $1c ; note A3 dur 28
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $39, $14 ; note A3 dur 20
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $22, $24 ; note D2 dur 36
    db $a0, $05 ; volume $05
    db $22, $0c ; note D2 dur 12
    db $a0, $0a ; volume $0A
    db $23, $24 ; note D#2 dur 36
    db $c1, $4f ; env $4F
    db $a0, $05 ; volume $05
    db $23, $0c ; note D#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $a0, $05 ; volume $05
    db $24, $06 ; note E2 dur 6
    db $c3, $78 ; env $78
    db $a0, $0b ; volume $0B
    db $25, $0c ; note F2 dur 12
    db $28, $0c ; note G#2 dur 12
    db $a0, $03 ; volume $03
    db $28, $18 ; note G#2 dur 24
    db $c2, $38 ; env $38
    db $a2, $02 ; duty2 $02
    db $a0, $0c ; volume $0C
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $0a ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0a ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0d ; volume $0D
    db $20, $05 ; note C2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $a0, $0a ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0a ; volume $0A
    db $37, $05 ; note G3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $0d ; volume $0D
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0a ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $0d ; volume $0D
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0d ; volume $0D
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $a0, $0a ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $26, $05 ; note F#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $a0, $09 ; volume $09
    db $20, $05 ; note C2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $08 ; volume $08
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $a2, $01 ; duty2 $01
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $1f, $0c ; rest-note $1F dur 12
    db $a2, $00 ; duty2 $00
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $32, $0c ; note D3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $33, $0c ; note D#3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $20, $05 ; note C2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $a0, $08 ; volume $08
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $37, $0c ; note G3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $37, $0c ; note G3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $a0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $39, $0c ; note A3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $33, $0c ; note D#3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $23, $05 ; note D#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $a0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $33, $0c ; note D#3 dur 12
    db $c2, $48 ; env $48
    db $a0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $c3, $40 ; env $40
    db $a0, $0b ; volume $0B
    db $36, $0c ; note F#3 dur 12
    db $c1, $30 ; env $30
    db $a0, $05 ; volume $05
    db $36, $0c ; note F#3 dur 12
    db $a2, $00 ; duty2 $00
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $19, $0c ; note A1 dur 12
    db $19, $0c ; note A1 dur 12
    db $20, $0c ; note C2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $c3, $68 ; env $68
    db $a0, $0b ; volume $0B
    db $36, $0c ; note F#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $22, $0c ; note D2 dur 12
    db $20, $0c ; note C2 dur 12
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $25, $0c ; note F2 dur 12
    db $23, $0c ; note D#2 dur 12
    db $19, $0c ; note A1 dur 12
    db $a0, $05 ; volume $05
    db $19, $18 ; note A1 dur 24
    db $a2, $02 ; duty2 $02
    db $c1, $7f ; env $7F
    db $a0, $03 ; volume $03
    db $35, $18 ; note F3 dur 24
    db $37, $0c ; note G3 dur 12
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 493 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_10::
    db $01, $00, $09, $00 ; header: param=1 byte1=$00 volume=$09 byte3=$00
    db $a2, $01 ; duty2 $01
    db $1f, $03 ; rest-note $1F dur 3
    db $a0, $03 ; volume $03
    db $25, $03 ; note F2 dur 3
    db $a0, $06 ; volume $06
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $29, $03 ; note A2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $1f, $18 ; rest-note $1F dur 24
    db $c3, $68 ; env $68
    db $a3, $0e ; mod $0E
    db $a2, $02 ; duty2 $02
    db $a0, $0e ; volume $0E
    db $35, $12 ; note F3 dur 18
    db $a0, $07 ; volume $07
    db $35, $06 ; note F3 dur 6
    db $a0, $0e ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $a0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $fd, $f3 ; label 3
    db $a3, $00 ; mod $00
    db $c3, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $42, $22 ; note D4 dur 34
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $42, $0e ; note D4 dur 14
    db $c3, $68 ; env $68
    db $a3, $0f ; mod $0F
    db $a0, $0e ; volume $0E
    db $35, $0c ; note F3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a3, $00 ; mod $00
    db $c3, $7f ; env $7F
    db $40, $22 ; note C4 dur 34
    db $c1, $78 ; env $78
    db $a0, $06 ; volume $06
    db $40, $0e ; note C4 dur 14
    db $c3, $68 ; env $68
    db $a3, $0f ; mod $0F
    db $a0, $0e ; volume $0E
    db $35, $0c ; note F3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c3, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $3a, $22 ; note A#3 dur 34
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $3a, $0e ; note A#3 dur 14
    db $c3, $58 ; env $58
    db $a3, $0e ; mod $0E
    db $a0, $0e ; volume $0E
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $39, $24 ; note A3 dur 36
    db $a0, $0e ; volume $0E
    db $c3, $58 ; env $58
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $32, $24 ; note D3 dur 36
    db $a0, $0e ; volume $0E
    db $c3, $78 ; env $78
    db $33, $0c ; note D#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $37, $30 ; note G3 dur 48
    db $c3, $78 ; env $78
    db $a0, $0e ; volume $0E
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $a0, $0b ; volume $0B
    db $30, $0c ; note C3 dur 12
    db $a0, $06 ; volume $06
    db $30, $0c ; note C3 dur 12
    db $c3, $38 ; env $38
    db $a2, $02 ; duty2 $02
    db $a0, $0e ; volume $0E
    db $30, $06 ; note C3 dur 6
    db $a0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $a0, $0e ; volume $0E
    db $40, $06 ; note C4 dur 6
    db $a0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $a0, $0e ; volume $0E
    db $41, $06 ; note C#4 dur 6
    db $a0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $a0, $0e ; volume $0E
    db $31, $06 ; note C#3 dur 6
    db $a0, $05 ; volume $05
    db $41, $06 ; note C#4 dur 6
    db $a0, $0e ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $a0, $05 ; volume $05
    db $31, $06 ; note C#3 dur 6
    db $a0, $0e ; volume $0E
    db $42, $06 ; note D4 dur 6
    db $a0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $a0, $0e ; volume $0E
    db $43, $06 ; note D#4 dur 6
    db $c1, $2f ; env $2F
    db $a0, $03 ; volume $03
    db $43, $12 ; note D#4 dur 18
    db $c3, $68 ; env $68
    db $a3, $09 ; mod $09
    db $a2, $00 ; duty2 $00
    db $a0, $0e ; volume $0E
    db $33, $0c ; note D#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a3, $fe ; mod $FE
    db $40, $24 ; note C4 dur 36
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $40, $0c ; note C4 dur 12
    db $c3, $68 ; env $68
    db $a3, $fe ; mod $FE
    db $a0, $0e ; volume $0E
    db $33, $0c ; note D#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $3a, $20 ; note A#3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $3a, $10 ; note A#3 dur 16
    db $c3, $68 ; env $68
    db $a3, $fe ; mod $FE
    db $a0, $0e ; volume $0E
    db $33, $0c ; note D#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $39, $20 ; note A3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $39, $10 ; note A3 dur 16
    db $c3, $68 ; env $68
    db $a3, $fe ; mod $FE
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $37, $24 ; note G3 dur 36
    db $c3, $68 ; env $68
    db $a0, $0e ; volume $0E
    db $36, $0c ; note F#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $30, $24 ; note C3 dur 36
    db $c3, $68 ; env $68
    db $a0, $0e ; volume $0E
    db $32, $0c ; note D3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $35, $24 ; note F3 dur 36
    db $a0, $0e ; volume $0E
    db $c3, $68 ; env $68
    db $33, $0c ; note D#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $2a, $24 ; note A#2 dur 36
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $2a, $0c ; note A#2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $02 ; mod $02
    db $30, $24 ; note C3 dur 36
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $30, $0c ; note C3 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $a3, $09 ; mod $09
    db $31, $12 ; note C#3 dur 18
    db $a0, $05 ; volume $05
    db $31, $06 ; note C#3 dur 6
    db $a0, $0e ; volume $0E
    db $32, $12 ; note D3 dur 18
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $32, $1e ; note D3 dur 30
    db $a2, $02 ; duty2 $02
    db $c2, $38 ; env $38
    db $a0, $0d ; volume $0D
    db $37, $05 ; note G3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $a0, $0b ; volume $0B
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $0b ; volume $0B
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0d ; volume $0D
    db $23, $05 ; note D#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $a0, $0b ; volume $0B
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0b ; volume $0B
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0b ; volume $0B
    db $37, $05 ; note G3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $a0, $0b ; volume $0B
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $a0, $0d ; volume $0D
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3a, $06 ; note A#3 dur 6
    db $a0, $0b ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $a0, $0b ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0b ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $a0, $0d ; volume $0D
    db $42, $05 ; note D4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0b ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $a0, $0d ; volume $0D
    db $40, $05 ; note C4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0b ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $a0, $0b ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $a0, $0b ; volume $0B
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $a0, $0a ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $a0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $39, $06 ; note A3 dur 6
    db $22, $06 ; note D2 dur 6
    db $a2, $00 ; duty2 $00
    db $c3, $48 ; env $48
    db $27, $06 ; note G2 dur 6
    db $2a, $06 ; note A#2 dur 6
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0b ; volume $0B
    db $42, $48 ; note D4 dur 72
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $42, $18 ; note D4 dur 24
    db $c3, $48 ; env $48
    db $a3, $09 ; mod $09
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $47, $48 ; note G4 dur 72
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $47, $18 ; note G4 dur 24
    db $a2, $02 ; duty2 $02
    db $a3, $09 ; mod $09
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $32, $05 ; note D3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $37, $06 ; note G3 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $a0, $0a ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $2a, $06 ; note A#2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $39, $0c ; note A3 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $23, $06 ; note D#2 dur 6
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $2a, $06 ; note A#2 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $3a, $0c ; note A#3 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $3a, $06 ; note A#3 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $42, $0c ; note D4 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $42, $06 ; note D4 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $33, $06 ; note D#3 dur 6
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $40, $0c ; note C4 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $37, $0c ; note G3 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $37, $06 ; note G3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $c3, $38 ; env $38
    db $a0, $0e ; volume $0E
    db $39, $0c ; note A3 dur 12
    db $c2, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $c3, $40 ; env $40
    db $a0, $0e ; volume $0E
    db $3a, $0c ; note A#3 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $3a, $0c ; note A#3 dur 12
    db $c3, $68 ; env $68
    db $a2, $01 ; duty2 $01
    db $a0, $0e ; volume $0E
    db $20, $0c ; note C2 dur 12
    db $22, $0c ; note D2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $0c ; note C3 dur 12
    db $2a, $0c ; note A#2 dur 12
    db $26, $0c ; note F#2 dur 12
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $30, $0c ; note C3 dur 12
    db $29, $0c ; note A2 dur 12
    db $27, $0c ; note G2 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $0e ; volume $0E
    db $35, $12 ; note F3 dur 18
    db $a0, $07 ; volume $07
    db $35, $06 ; note F3 dur 6
    db $a0, $0e ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $a0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 289 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_11::
    db $01, $70, $02, $02 ; header: param=1 byte1=$70 volume=$02 byte3=$02
    db $a3, $07 ; mod $07
    db $a2, $50 ; duty2 $50
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $2a, $03 ; note A#2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $31, $03 ; note C#3 dur 3
    db $30, $03 ; note C3 dur 3
    db $2b, $03 ; note B2 dur 3
    db $2a, $03 ; note A#2 dur 3
    db $29, $24 ; note A2 dur 36
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $18 ; note A2 dur 24
    db $fd, $f3 ; label 3
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $25, $0c ; note F2 dur 12
    db $2a, $12 ; note A#2 dur 18
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $25, $0c ; note F2 dur 12
    db $29, $12 ; note A2 dur 18
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $22, $0c ; note D2 dur 12
    db $27, $12 ; note G2 dur 18
    db $a0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $15, $0c ; note F1 dur 12
    db $25, $0c ; note F2 dur 12
    db $30, $12 ; note C3 dur 18
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $29, $12 ; note A2 dur 18
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $25, $0c ; note F2 dur 12
    db $2a, $12 ; note A#2 dur 18
    db $a0, $04 ; volume $04
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $23, $0c ; note D#2 dur 12
    db $30, $12 ; note C3 dur 18
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $27, $12 ; note G2 dur 18
    db $a0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $a2, $28 ; duty2 $28
    db $a0, $02 ; volume $02
    db $15, $12 ; note F1 dur 18
    db $a0, $04 ; volume $04
    db $15, $06 ; note F1 dur 6
    db $a0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $15, $12 ; note F1 dur 18
    db $a0, $04 ; volume $04
    db $15, $06 ; note F1 dur 6
    db $a0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $a0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $a0, $02 ; volume $02
    db $15, $0c ; note F1 dur 12
    db $a0, $04 ; volume $04
    db $15, $0c ; note F1 dur 12
    db $1f, $18 ; rest-note $1F dur 24
    db $a2, $70 ; duty2 $70
    db $a0, $02 ; volume $02
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $0c ; note C2 dur 12
    db $a2, $40 ; duty2 $40
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a2, $70 ; duty2 $70
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $0c ; note C2 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $a0, $06 ; volume $06
    db $15, $0c ; note F1 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $a0, $06 ; volume $06
    db $15, $0c ; note F1 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a2, $70 ; duty2 $70
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $0c ; note C2 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a0, $04 ; volume $04
    db $30, $0c ; note C3 dur 12
    db $a0, $02 ; volume $02
    db $30, $0c ; note C3 dur 12
    db $a2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $a0, $06 ; volume $06
    db $15, $0c ; note F1 dur 12
    db $a2, $30 ; duty2 $30
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $a2, $70 ; duty2 $70
    db $1a, $0c ; note A#1 dur 12
    db $15, $0c ; note F1 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $25, $0c ; note F2 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $15, $0c ; note F1 dur 12
    db $1a, $0c ; note A#1 dur 12
    db $25, $0c ; note F2 dur 12
    db $a0, $04 ; volume $04
    db $25, $0c ; note F2 dur 12
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a2, $40 ; duty2 $40
    db $a1, $0b ; duty $0B
    db $13, $18 ; note D#1 dur 24
    db $a0, $04 ; volume $04
    db $13, $18 ; note D#1 dur 24
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $23, $18 ; note D#2 dur 24
    db $a1, $0b ; duty $0B
    db $13, $18 ; note D#1 dur 24
    db $a0, $04 ; volume $04
    db $13, $18 ; note D#1 dur 24
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $23, $18 ; note D#2 dur 24
    db $a1, $0b ; duty $0B
    db $12, $18 ; note D1 dur 24
    db $a0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $a1, $0b ; duty $0B
    db $12, $18 ; note D1 dur 24
    db $a0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $17, $3c ; note G1 dur 60
    db $a0, $04 ; volume $04
    db $17, $0c ; note G1 dur 12
    db $a0, $02 ; volume $02
    db $16, $3c ; note F#1 dur 60
    db $a0, $04 ; volume $04
    db $16, $0c ; note F#1 dur 12
    db $a0, $02 ; volume $02
    db $15, $3c ; note F1 dur 60
    db $a0, $04 ; volume $04
    db $15, $0c ; note F1 dur 12
    db $a0, $02 ; volume $02
    db $14, $3c ; note E1 dur 60
    db $a0, $04 ; volume $04
    db $14, $0c ; note E1 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $13, $18 ; note D#1 dur 24
    db $a1, $03 ; duty $03
    db $23, $24 ; note D#2 dur 36
    db $a0, $06 ; volume $06
    db $23, $0c ; note D#2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $10, $18 ; note C1 dur 24
    db $a1, $03 ; duty $03
    db $20, $24 ; note C2 dur 36
    db $a0, $06 ; volume $06
    db $20, $0c ; note C2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $19, $18 ; note A1 dur 24
    db $a1, $03 ; duty $03
    db $29, $24 ; note A2 dur 36
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $19, $18 ; note A1 dur 24
    db $a1, $03 ; duty $03
    db $29, $24 ; note A2 dur 36
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $12, $18 ; note D1 dur 24
    db $a1, $03 ; duty $03
    db $22, $24 ; note D2 dur 36
    db $a0, $06 ; volume $06
    db $22, $0c ; note D2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $12, $18 ; note D1 dur 24
    db $a1, $03 ; duty $03
    db $22, $24 ; note D2 dur 36
    db $a0, $06 ; volume $06
    db $22, $0c ; note D2 dur 12
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $15, $18 ; note F1 dur 24
    db $a1, $03 ; duty $03
    db $25, $24 ; note F2 dur 36
    db $a0, $06 ; volume $06
    db $25, $0c ; note F2 dur 12
    db $a1, $09 ; duty $09
    db $a2, $60 ; duty2 $60
    db $a0, $02 ; volume $02
    db $15, $0c ; note F1 dur 12
    db $a0, $04 ; volume $04
    db $15, $24 ; note F1 dur 36
    db $1f, $18 ; rest-note $1F dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 491 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_12::
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $a2, $00 ; duty2 $00
    db $a3, $08 ; mod $08
    db $c1, $70 ; env $70
    db $1f, $04 ; rest-note $1F dur 4
    db $a0, $03 ; volume $03
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $c2, $4f ; env $4F
    db $a0, $07 ; volume $07
    db $24, $04 ; note E2 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $fd, $f3 ; label 3
    db $c2, $4f ; env $4F
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $a0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $a0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $a0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $24, $04 ; note E2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $a0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $a0, $09 ; volume $09
    db $12, $04 ; note D1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $09 ; volume $09
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $a0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $09 ; volume $09
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $24, $04 ; note E2 dur 4
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $a0, $09 ; volume $09
    db $15, $04 ; note F1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $08 ; volume $08
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $05 ; volume $05
    db $33, $04 ; note D#3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $a0, $08 ; volume $08
    db $27, $04 ; note G2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $20, $04 ; note C2 dur 4
    db $a0, $09 ; volume $09
    db $1b, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $a0, $08 ; volume $08
    db $29, $04 ; note A2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $a0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $08 ; volume $08
    db $29, $04 ; note A2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $18, $04 ; note G#1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1b, $05 ; note B1 dur 5
    db $18, $05 ; note G#1 dur 5
    db $a2, $01 ; duty2 $01
    db $c3, $68 ; env $68
    db $a0, $0b ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $20, $06 ; note C2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $1b, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $a0, $0c ; volume $0C
    db $1b, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $a0, $0c ; volume $0C
    db $1b, $06 ; note B1 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0d ; volume $0D
    db $1b, $06 ; note B1 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $a0, $0a ; volume $0A
    db $2b, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $a0, $0b ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0b ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0a ; volume $0A
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a3, $0c ; mod $0C
    db $a0, $0b ; volume $0B
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $a0, $0c ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $21, $06 ; note C#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $0b ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $07 ; volume $07
    db $2b, $06 ; note B2 dur 6
    db $a0, $0c ; volume $0C
    db $26, $06 ; note F#2 dur 6
    db $a0, $0b ; volume $0B
    db $1b, $06 ; note B1 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $a0, $09 ; volume $09
    db $1b, $06 ; note B1 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0d ; volume $0D
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0d ; volume $0D
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $0c ; volume $0C
    db $34, $06 ; note E3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $a0, $0c ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $0d ; volume $0D
    db $33, $06 ; note D#3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $23, $10 ; note D#2 dur 16
    db $c1, $5f ; env $5F
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $23, $20 ; note D#2 dur 32
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 279 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_13::
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $a2, $00 ; duty2 $00
    db $a3, $28 ; mod $28
    db $c2, $3f ; env $3F
    db $a0, $0c ; volume $0C
    db $aa, $2a ; slide $2A
    db $a0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $1b, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1b, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $fd, $f3 ; label 3
    db $aa, $00 ; slide $00
    db $a2, $02 ; duty2 $02
    db $c3, $25 ; env $25
    db $a3, $28 ; mod $28
    db $a0, $0e ; volume $0E
    db $2b, $0d ; note B2 dur 13
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $34, $23 ; note E3 dur 35
    db $a3, $08 ; mod $08
    db $3b, $0b ; note B3 dur 11
    db $a0, $09 ; volume $09
    db $3b, $01 ; note B3 dur 1
    db $a3, $fe ; mod $FE
    db $a0, $0d ; volume $0D
    db $3b, $24 ; note B3 dur 36
    db $a0, $09 ; volume $09
    db $39, $06 ; note A3 dur 6
    db $3b, $06 ; note B3 dur 6
    db $a3, $0f ; mod $0F
    db $a0, $08 ; volume $08
    db $36, $24 ; note F#3 dur 36
    db $a0, $09 ; volume $09
    db $34, $06 ; note E3 dur 6
    db $a0, $0a ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $a0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $c1, $68 ; env $68
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $34, $0c ; note E3 dur 12
    db $c3, $25 ; env $25
    db $a3, $08 ; mod $08
    db $a0, $0d ; volume $0D
    db $2b, $0d ; note B2 dur 13
    db $c0, $fe ; env $FE
    db $a0, $0c ; volume $0C
    db $a3, $fe ; mod $FE
    db $30, $23 ; note C3 dur 35
    db $39, $0b ; note A3 dur 11
    db $a0, $09 ; volume $09
    db $39, $01 ; note A3 dur 1
    db $a0, $0e ; volume $0E
    db $39, $24 ; note A3 dur 36
    db $a0, $08 ; volume $08
    db $34, $06 ; note E3 dur 6
    db $a0, $09 ; volume $09
    db $36, $06 ; note F#3 dur 6
    db $a0, $09 ; volume $09
    db $32, $23 ; note D3 dur 35
    db $2b, $07 ; note B2 dur 7
    db $32, $06 ; note D3 dur 6
    db $a0, $07 ; volume $07
    db $34, $30 ; note E3 dur 48
    db $c1, $4f ; env $4F
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $34, $0c ; note E3 dur 12
    db $a3, $0c ; mod $0C
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $30, $0c ; note C3 dur 12
    db $a0, $0b ; volume $0B
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a3, $fe ; mod $FE
    db $39, $2a ; note A3 dur 42
    db $c1, $7f ; env $7F
    db $a3, $04 ; mod $04
    db $a0, $08 ; volume $08
    db $39, $07 ; note A3 dur 7
    db $a3, $08 ; mod $08
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $36, $0e ; note F#3 dur 14
    db $a0, $06 ; volume $06
    db $36, $02 ; note F#3 dur 2
    db $a0, $0b ; volume $0B
    db $37, $0e ; note G3 dur 14
    db $a0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $a0, $0b ; volume $0B
    db $36, $0e ; note F#3 dur 14
    db $a0, $06 ; volume $06
    db $36, $01 ; note F#3 dur 1
    db $a3, $fe ; mod $FE
    db $a0, $09 ; volume $09
    db $34, $24 ; note E3 dur 36
    db $a0, $07 ; volume $07
    db $2b, $0c ; note B2 dur 12
    db $c1, $40 ; env $40
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $2b, $0c ; note B2 dur 12
    db $a3, $08 ; mod $08
    db $c3, $65 ; env $65
    db $a0, $0c ; volume $0C
    db $29, $0c ; note A2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $2b, $0c ; note B2 dur 12
    db $30, $0c ; note C3 dur 12
    db $a0, $09 ; volume $09
    db $a3, $fe ; mod $FE
    db $33, $2c ; note D#3 dur 44
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $33, $04 ; note D#3 dur 4
    db $c0, $fe ; env $FE
    db $a3, $08 ; mod $08
    db $a0, $0b ; volume $0B
    db $32, $0e ; note D3 dur 14
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $0b ; volume $0B
    db $2b, $0e ; note B2 dur 14
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $0b ; volume $0B
    db $32, $0e ; note D3 dur 14
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $c0, $fe ; env $FE
    db $a0, $09 ; volume $09
    db $34, $2c ; note E3 dur 44
    db $c1, $6f ; env $6F
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $34, $1e ; note E3 dur 30
    db $a2, $01 ; duty2 $01
    db $c3, $78 ; env $78
    db $a3, $09 ; mod $09
    db $a0, $0f ; volume $0F
    db $35, $0c ; note F3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a3, $fe ; mod $FE
    db $39, $18 ; note A3 dur 24
    db $a3, $07 ; mod $07
    db $37, $0c ; note G3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c3, $68 ; env $68
    db $34, $07 ; note E3 dur 7
    db $35, $05 ; note F3 dur 5
    db $34, $06 ; note E3 dur 6
    db $35, $06 ; note F3 dur 6
    db $a0, $09 ; volume $09
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $37, $20 ; note G3 dur 32
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $a3, $08 ; mod $08
    db $37, $10 ; note G3 dur 16
    db $a0, $0c ; volume $0C
    db $a3, $09 ; mod $09
    db $c3, $7f ; env $7F
    db $34, $0c ; note E3 dur 12
    db $c3, $68 ; env $68
    db $a0, $0b ; volume $0B
    db $30, $0c ; note C3 dur 12
    db $c1, $70 ; env $70
    db $a3, $08 ; mod $08
    db $a0, $05 ; volume $05
    db $30, $18 ; note C3 dur 24
    db $c3, $68 ; env $68
    db $a3, $09 ; mod $09
    db $a0, $0f ; volume $0F
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $a3, $fe ; mod $FE
    db $c3, $78 ; env $78
    db $35, $18 ; note F3 dur 24
    db $a3, $07 ; mod $07
    db $c3, $68 ; env $68
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $30, $06 ; note C3 dur 6
    db $2b, $06 ; note B2 dur 6
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $a0, $0b ; volume $0B
    db $a3, $fe ; mod $FE
    db $c3, $7f ; env $7F
    db $34, $18 ; note E3 dur 24
    db $c1, $78 ; env $78
    db $a0, $06 ; volume $06
    db $a3, $08 ; mod $08
    db $34, $18 ; note E3 dur 24
    db $c3, $78 ; env $78
    db $a3, $08 ; mod $08
    db $a0, $0f ; volume $0F
    db $36, $0c ; note F#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $a3, $fe ; mod $FE
    db $a0, $0a ; volume $0A
    db $c0, $fe ; env $FE
    db $39, $24 ; note A3 dur 36
    db $38, $06 ; note G#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $38, $24 ; note G#3 dur 36
    db $36, $06 ; note F#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $36, $0c ; note F#3 dur 12
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $31, $0b ; note C#3 dur 11
    db $a0, $06 ; volume $06
    db $31, $01 ; note C#3 dur 1
    db $a0, $0a ; volume $0A
    db $31, $0c ; note C#3 dur 12
    db $a0, $0b ; volume $0B
    db $26, $0c ; note F#2 dur 12
    db $a0, $0c ; volume $0C
    db $28, $0c ; note G#2 dur 12
    db $a0, $0b ; volume $0B
    db $29, $0c ; note A2 dur 12
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $2b, $24 ; note B2 dur 36
    db $a0, $0c ; volume $0C
    db $2a, $06 ; note A#2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $a0, $0b ; volume $0B
    db $31, $24 ; note C#3 dur 36
    db $a0, $0c ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $32, $0c ; note D3 dur 12
    db $31, $0c ; note C#3 dur 12
    db $32, $0c ; note D3 dur 12
    db $34, $0c ; note E3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $39, $0c ; note A3 dur 12
    db $36, $0c ; note F#3 dur 12
    db $a0, $0a ; volume $0A
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $3b, $44 ; note B3 dur 68
    db $a0, $08 ; volume $08
    db $c0, $fe ; env $FE
    db $3b, $44 ; note B3 dur 68
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $3b, $2c ; note B3 dur 44
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 174 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_41_14::
    db $07, $ff, $02, $0f ; header: param=7 byte1=$FF volume=$02 byte3=$0F
    db $a1, $0b ; duty $0B
    db $a3, $09 ; mod $09
    db $a0, $02 ; volume $02
    db $24, $2a ; note E2 dur 42
    db $a0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $1b, $2a ; note B1 dur 42
    db $a0, $04 ; volume $04
    db $1b, $06 ; note B1 dur 6
    db $fd, $f3 ; label 3
    db $a0, $02 ; volume $02
    db $14, $2a ; note E1 dur 42
    db $a0, $04 ; volume $04
    db $14, $06 ; note E1 dur 6
    db $a0, $02 ; volume $02
    db $19, $2a ; note A1 dur 42
    db $a0, $04 ; volume $04
    db $19, $06 ; note A1 dur 6
    db $a0, $02 ; volume $02
    db $1b, $2a ; note B1 dur 42
    db $a0, $04 ; volume $04
    db $1b, $06 ; note B1 dur 6
    db $a0, $02 ; volume $02
    db $14, $2a ; note E1 dur 42
    db $a0, $04 ; volume $04
    db $14, $06 ; note E1 dur 6
    db $a0, $02 ; volume $02
    db $19, $2a ; note A1 dur 42
    db $a0, $04 ; volume $04
    db $19, $06 ; note A1 dur 6
    db $a0, $02 ; volume $02
    db $16, $2a ; note F#1 dur 42
    db $a0, $04 ; volume $04
    db $16, $06 ; note F#1 dur 6
    db $a0, $02 ; volume $02
    db $1b, $2a ; note B1 dur 42
    db $a0, $04 ; volume $04
    db $1b, $06 ; note B1 dur 6
    db $a0, $02 ; volume $02
    db $14, $20 ; note E1 dur 32
    db $a0, $04 ; volume $04
    db $14, $10 ; note E1 dur 16
    db $a0, $02 ; volume $02
    db $19, $2a ; note A1 dur 42
    db $a0, $04 ; volume $04
    db $19, $06 ; note A1 dur 6
    db $a0, $02 ; volume $02
    db $22, $2a ; note D2 dur 42
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $17, $2a ; note G1 dur 42
    db $a0, $04 ; volume $04
    db $17, $06 ; note G1 dur 6
    db $a0, $02 ; volume $02
    db $20, $2a ; note C2 dur 42
    db $a0, $04 ; volume $04
    db $20, $06 ; note C2 dur 6
    db $a0, $02 ; volume $02
    db $16, $2a ; note F#1 dur 42
    db $a0, $04 ; volume $04
    db $16, $06 ; note F#1 dur 6
    db $a0, $02 ; volume $02
    db $15, $2a ; note F1 dur 42
    db $a0, $04 ; volume $04
    db $15, $06 ; note F1 dur 6
    db $a0, $02 ; volume $02
    db $1b, $2a ; note B1 dur 42
    db $a0, $04 ; volume $04
    db $1b, $06 ; note B1 dur 6
    db $a0, $02 ; volume $02
    db $14, $20 ; note E1 dur 32
    db $a0, $04 ; volume $04
    db $14, $12 ; note E1 dur 18
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $10 ; note D2 dur 16
    db $a0, $04 ; volume $04
    db $22, $20 ; note D2 dur 32
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a0, $04 ; volume $04
    db $17, $20 ; note G1 dur 32
    db $a0, $02 ; volume $02
    db $20, $10 ; note C2 dur 16
    db $a0, $04 ; volume $04
    db $20, $20 ; note C2 dur 32
    db $a0, $02 ; volume $02
    db $15, $10 ; note F1 dur 16
    db $a0, $04 ; volume $04
    db $15, $20 ; note F1 dur 32
    db $a0, $02 ; volume $02
    db $1b, $10 ; note B1 dur 16
    db $a0, $04 ; volume $04
    db $1b, $20 ; note B1 dur 32
    db $a0, $02 ; volume $02
    db $14, $10 ; note E1 dur 16
    db $a0, $04 ; volume $04
    db $14, $20 ; note E1 dur 32
    db $a0, $02 ; volume $02
    db $19, $10 ; note A1 dur 16
    db $a0, $04 ; volume $04
    db $19, $20 ; note A1 dur 32
    db $a0, $02 ; volume $02
    db $16, $10 ; note F#1 dur 16
    db $a0, $04 ; volume $04
    db $16, $20 ; note F#1 dur 32
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $1b, $1c ; note B1 dur 28
    db $a0, $04 ; volume $04
    db $1b, $08 ; note B1 dur 8
    db $a0, $02 ; volume $02
    db $1b, $0c ; note B1 dur 12
    db $a0, $02 ; volume $02
    db $14, $2a ; note E1 dur 42
    db $a0, $04 ; volume $04
    db $14, $06 ; note E1 dur 6
    db $a0, $02 ; volume $02
    db $19, $1c ; note A1 dur 28
    db $a0, $04 ; volume $04
    db $19, $08 ; note A1 dur 8
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a0, $02 ; volume $02
    db $22, $2a ; note D2 dur 42
    db $a0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $a0, $02 ; volume $02
    db $18, $1c ; note G#1 dur 28
    db $a0, $04 ; volume $04
    db $18, $08 ; note G#1 dur 8
    db $a0, $02 ; volume $02
    db $18, $0c ; note G#1 dur 12
    db $a0, $02 ; volume $02
    db $21, $2a ; note C#2 dur 42
    db $a0, $04 ; volume $04
    db $21, $06 ; note C#2 dur 6
    db $a0, $02 ; volume $02
    db $1b, $1c ; note B1 dur 28
    db $a0, $04 ; volume $04
    db $1b, $08 ; note B1 dur 8
    db $a0, $02 ; volume $02
    db $1b, $0c ; note B1 dur 12
    db $a0, $02 ; volume $02
    db $20, $2a ; note C2 dur 42
    db $a0, $04 ; volume $04
    db $20, $06 ; note C2 dur 6
    db $a0, $02 ; volume $02
    db $1b, $1c ; note B1 dur 28
    db $a0, $04 ; volume $04
    db $1b, $08 ; note B1 dur 8
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $a0, $02 ; volume $02
    db $2b, $1c ; note B2 dur 28
    db $a0, $04 ; volume $04
    db $2b, $08 ; note B2 dur 8
    db $a0, $02 ; volume $02
    db $26, $0c ; note F#2 dur 12
    db $1b, $14 ; note B1 dur 20
    db $a0, $04 ; volume $04
    db $1b, $10 ; note B1 dur 16
    db $a0, $02 ; volume $02
    db $1b, $0a ; note B1 dur 10
    db $a0, $04 ; volume $04
    db $1b, $02 ; note B1 dur 2
    db $a0, $02 ; volume $02
    db $1b, $18 ; note B1 dur 24
    db $a0, $06 ; volume $06
    db $1b, $18 ; note B1 dur 24
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end
    db $00, $00, $00, $00, $00, $00, $00, $00, $00
