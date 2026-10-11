SECTION "Bank 43", ROMX[$4000], BANK[$43]
    db $43

; E-0018. Sound ids 168-222: the array ends at $40DD and track streams follow; the bank table nominally covers ids up to 254, but no records exist for 223-254.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified); track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank43::
Data_043_4001:: ; address name
    db $00, $03 ; id 168
    dw Data_043_40DD
    db $00, $03 ; id 169
    dw Data_043_40F9
    db $00, $03 ; id 170
    dw Data_043_411D
    db $00, $03 ; id 171
    dw Data_043_413F
    db $00, $00 ; id 172
    dw Data_043_416B
    db $20, $03 ; id 173
    dw Data_043_41A9
    db $00, $00 ; id 174
    dw Data_043_41BF
    db $20, $03 ; id 175
    dw Data_043_4235
    db $00, $03 ; id 176
    dw Data_043_4253
    db $00, $03 ; id 177
    dw Data_043_426B
    db $00, $00 ; id 178
    dw Data_043_429D
    db $20, $03 ; id 179
    dw Data_043_42CB
    db $00, $03 ; id 180
    dw Data_043_42E1
    db $20, $00 ; id 181
    dw Data_043_4301
    db $00, $00 ; id 182
    dw Data_043_4307
    db $20, $03 ; id 183
    dw Data_043_4359
    db $00, $00 ; id 184
    dw Data_043_4379
    db $20, $03 ; id 185
    dw Data_043_438F
    db $00, $00 ; id 186
    dw Data_043_43CF
    db $20, $03 ; id 187
    dw Data_043_4431
    db $00, $03 ; id 188
    dw Data_043_4449
    db $00, $00 ; id 189
    dw Data_043_447B
    db $20, $03 ; id 190
    dw Data_043_4509
    db $00, $00 ; id 191
    dw Data_043_4521
    db $20, $03 ; id 192
    dw Data_043_4559
    db $00, $00 ; id 193
    dw Data_043_457B
    db $20, $03 ; id 194
    dw Data_043_4591
    db $00, $00 ; id 195
    dw Data_043_45AD
    db $20, $03 ; id 196
    dw Data_043_45E1
    db $00, $00 ; id 197
    dw Data_043_4611
    db $20, $03 ; id 198
    dw Data_043_4641
    db $00, $00 ; id 199
    dw Data_043_465F
    db $20, $03 ; id 200
    dw Data_043_469F
    db $00, $00 ; id 201
    dw Data_043_46C1
    db $20, $03 ; id 202
    dw Data_043_471F
    db $00, $03 ; id 203
    dw Data_043_4731
    db $40, $00 ; id 204
    dw Data_043_4769
    db $60, $01 ; id 205
    dw Data_043_4F29
    db $80, $02 ; id 206
    dw Data_043_5849
    db $40, $00 ; id 207
    dw Data_043_59B7
    db $60, $01 ; id 208
    dw Data_043_5C95
    db $80, $02 ; id 209
    dw Data_043_5EB3
    db $00, $00 ; id 210
    dw Data_043_61F5
    db $20, $01 ; id 211
    dw Data_043_622F
    db $00, $00 ; id 212
    dw Data_043_6271
    db $20, $01 ; id 213
    dw Data_043_6299
    db $40, $00 ; id 214
    dw Data_043_62C1
    db $60, $01 ; id 215
    dw Data_043_6305
    db $80, $02 ; id 216
    dw Data_043_6341
    db $00, $03 ; id 217
    dw Data_043_6373
    db $00, $00 ; id 218
    dw Data_043_63AB
    db $20, $03 ; id 219
    dw Data_043_63EB
    db $00, $03 ; id 220
    dw Data_043_6409
    db $40, $00 ; id 221
    dw Data_043_641D
    db $60, $01 ; id 222
    dw Data_043_650D

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_043_40DD:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $23, $02 ; note D#2 dur 2
    db $31, $04 ; note C#3 dur 4
    db $12, $05 ; note D1 dur 5
    db $13, $05 ; note D#1 dur 5
    db $C7, $20 ; env $20
    db $30, $05 ; note C3 dur 5
    db $C0, $FE ; env $FE
    db $10, $10 ; note C1 dur 16
    db $A0, $05 ; volume $05
    db $C7, $20 ; env $20
    db $20, $18 ; note C2 dur 24
    db $FF, $FF ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
Data_043_40F9:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $A0, $06 ; volume $06
    db $C7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $A0, $0F ; volume $0F
    db $1F, $03 ; rest-note $1F dur 3
    db $C3, $30 ; env $30
    db $70, $20 ; note C7 dur 32
    db $C7, $30 ; env $30
    db $70, $30 ; note C7 dur 48
    db $FF, $FF ; end
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_043_411D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C7, $20 ; env $20
    db $50, $01 ; note C5 dur 1
    db $40, $08 ; note C4 dur 8
    db $21, $08 ; note C#2 dur 8
    db $A0, $08 ; volume $08
    db $21, $10 ; note C#2 dur 16
    db $A0, $0F ; volume $0F
    db $53, $05 ; note D#5 dur 5
    db $46, $06 ; note F#4 dur 6
    db $50, $03 ; note C5 dur 3
    db $30, $03 ; note C3 dur 3
    db $42, $08 ; note D4 dur 8
    db $C7, $20 ; env $20
    db $42, $20 ; note D4 dur 32
    db $FF, $FF ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
Data_043_413F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $60, $04 ; note C6 dur 4
    db $30, $02 ; note C3 dur 2
    db $50, $02 ; note C5 dur 2
    db $20, $02 ; note C2 dur 2
    db $40, $02 ; note C4 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $02 ; note C5 dur 2
    db $60, $04 ; note C6 dur 4
    db $30, $02 ; note C3 dur 2
    db $50, $02 ; note C5 dur 2
    db $20, $02 ; note C2 dur 2
    db $40, $02 ; note C4 dur 2
    db $60, $02 ; note C6 dur 2
    db $40, $05 ; note C4 dur 5
    db $22, $07 ; note D2 dur 7
    db $C1, $20 ; env $20
    db $40, $08 ; note C4 dur 8
    db $A0, $05 ; volume $05
    db $40, $10 ; note C4 dur 16
    db $FF, $FF ; end

; sound track, 29 events after the header (E-0019: grammar C2, meaning C0)
Data_043_416B:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $25 ; header: param=0 byte1=$02 volume=$0F byte3=$25
    db $12, $06 ; note D1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $06 ; note D1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $06 ; note D1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $AE, $10 ; tuning $10
    db $12, $06 ; note D1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $AE, $00 ; tuning $00
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $AE, $10 ; tuning $10
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $08 ; volume $08
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $06 ; note F1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $09 ; note D1 dur 9
    db $1F, $01 ; rest-note $1F dur 1
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_043_41A9:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1F, $55 ; rest-note $1F dur 85
    db $40, $03 ; note C4 dur 3
    db $41, $06 ; note C#4 dur 6
    db $70, $05 ; note C7 dur 5
    db $60, $22 ; note C6 dur 34
    db $C1, $50 ; env $50
    db $A0, $07 ; volume $07
    db $60, $10 ; note C6 dur 16
    db $FF, $FF ; end

; sound track, 57 events after the header (E-0019: grammar C2, meaning C0)
Data_043_41BF:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $26 ; header: param=0 byte1=$00 volume=$0F byte3=$26
    db $A0, $0A ; volume $0A
    db $26, $03 ; note F#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $A0, $0F ; volume $0F
    db $28, $03 ; note G#2 dur 3
    db $29, $03 ; note A2 dur 3
    db $30, $03 ; note C3 dur 3
    db $31, $03 ; note C#3 dur 3
    db $A0, $0C ; volume $0C
    db $32, $03 ; note D3 dur 3
    db $33, $03 ; note D#3 dur 3
    db $A0, $0A ; volume $0A
    db $36, $03 ; note F#3 dur 3
    db $37, $02 ; note G3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $A0, $07 ; volume $07
    db $38, $02 ; note G#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $A0, $05 ; volume $05
    db $39, $02 ; note A3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $39, $02 ; note A3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $0F ; volume $0F
    db $A1, $17 ; duty $17
    db $13, $03 ; note D#1 dur 3
    db $12, $04 ; note D1 dur 4
    db $A1, $14 ; duty $14
    db $11, $03 ; note C#1 dur 3
    db $10, $04 ; note C1 dur 4
    db $A0, $0A ; volume $0A
    db $10, $04 ; note C1 dur 4
    db $A0, $0F ; volume $0F
    db $0B, $03 ; note B0 dur 3
    db $A0, $09 ; volume $09
    db $0B, $03 ; note B0 dur 3
    db $A0, $0F ; volume $0F
    db $A1, $15 ; duty $15
    db $0A, $03 ; note A#0 dur 3
    db $A0, $0B ; volume $0B
    db $0A, $03 ; note A#0 dur 3
    db $A0, $0F ; volume $0F
    db $09, $03 ; note A0 dur 3
    db $A0, $0B ; volume $0B
    db $09, $03 ; note A0 dur 3
    db $A0, $0F ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $08, $06 ; note G#0 dur 6
    db $A0, $06 ; volume $06
    db $08, $06 ; note G#0 dur 6
    db $A0, $04 ; volume $04
    db $08, $06 ; note G#0 dur 6
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4235:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C3, $7F ; env $7F
    db $11, $20 ; note C#1 dur 32
    db $C1, $40 ; env $40
    db $11, $20 ; note C#1 dur 32
    db $1F, $02 ; rest-note $1F dur 2
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $51, $10 ; note C#5 dur 16
    db $51, $10 ; note C#5 dur 16
    db $A0, $05 ; volume $05
    db $C1, $50 ; env $50
    db $51, $30 ; note C#5 dur 48
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4253:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C3, $0A ; env $0A
    db $21, $03 ; note C#2 dur 3
    db $13, $02 ; note D#1 dur 2
    db $A0, $0F ; volume $0F
    db $20, $09 ; note C2 dur 9
    db $12, $10 ; note D1 dur 16
    db $C7, $20 ; env $20
    db $A0, $08 ; volume $08
    db $12, $20 ; note D1 dur 32
    db $FF, $FF ; end

; sound track, 23 events after the header (E-0019: grammar C2, meaning C0)
Data_043_426B:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $02 ; note C5 dur 2
    db $42, $02 ; note D4 dur 2
    db $A0, $0A ; volume $0A
    db $50, $01 ; note C5 dur 1
    db $A0, $0C ; volume $0C
    db $40, $02 ; note C4 dur 2
    db $42, $02 ; note D4 dur 2
    db $A0, $07 ; volume $07
    db $40, $01 ; note C4 dur 1
    db $A0, $0A ; volume $0A
    db $40, $02 ; note C4 dur 2
    db $42, $02 ; note D4 dur 2
    db $A0, $05 ; volume $05
    db $40, $01 ; note C4 dur 1
    db $40, $02 ; note C4 dur 2
    db $42, $02 ; note D4 dur 2
    db $40, $01 ; note C4 dur 1
    db $A0, $03 ; volume $03
    db $40, $01 ; note C4 dur 1
    db $40, $02 ; note C4 dur 2
    db $42, $02 ; note D4 dur 2
    db $40, $01 ; note C4 dur 1
    db $FF, $FF ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
Data_043_429D:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $09, $16 ; header: param=0 byte1=$02 volume=$09 byte3=$16
    db $A0, $06 ; volume $06
    db $1F, $26 ; rest-note $1F dur 38
    db $41, $04 ; note C#4 dur 4
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0F ; volume $0F
    db $41, $04 ; note C#4 dur 4
    db $1F, $01 ; rest-note $1F dur 1
    db $A1, $16 ; duty $16
    db $30, $02 ; note C3 dur 2
    db $A0, $0D ; volume $0D
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $08 ; volume $08
    db $30, $03 ; note C3 dur 3
    db $A0, $05 ; volume $05
    db $30, $02 ; note C3 dur 2
    db $A0, $02 ; volume $02
    db $30, $03 ; note C3 dur 3
    db $A0, $01 ; volume $01
    db $30, $02 ; note C3 dur 2
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_043_42CB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0D, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $1F, $03 ; rest-note $1F dur 3
    db $CC, $2E ; env $2E
    db $12, $35 ; note D1 dur 53
    db $A0, $06 ; volume $06
    db $C1, $1F ; env $1F
    db $11, $06 ; note C#1 dur 6
    db $A0, $03 ; volume $03
    db $11, $06 ; note C#1 dur 6
    db $FF, $FF ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
Data_043_42E1:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0E, $00 ; header: param=0 byte1=$00 volume=$0E byte3=$00
    db $53, $06 ; note D#5 dur 6
    db $43, $02 ; note D#4 dur 2
    db $41, $10 ; note C#4 dur 16
    db $A0, $0C ; volume $0C
    db $40, $10 ; note C4 dur 16
    db $C1, $70 ; env $70
    db $42, $03 ; note D4 dur 3
    db $A0, $0B ; volume $0B
    db $51, $14 ; note C#5 dur 20
    db $A0, $06 ; volume $06
    db $51, $10 ; note C#5 dur 16
    db $A0, $04 ; volume $04
    db $51, $30 ; note C#5 dur 48
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4301:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 39 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4307:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0C, $1D ; header: param=0 byte1=$00 volume=$0C byte3=$1D
    db $1F, $10 ; rest-note $1F dur 16
    db $30, $03 ; note C3 dur 3
    db $32, $02 ; note D3 dur 2
    db $31, $03 ; note C#3 dur 3
    db $31, $02 ; note C#3 dur 2
    db $2A, $03 ; note A#2 dur 3
    db $32, $03 ; note D3 dur 3
    db $32, $02 ; note D3 dur 2
    db $34, $03 ; note E3 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $31, $03 ; note C#3 dur 3
    db $31, $02 ; note C#3 dur 2
    db $2A, $03 ; note A#2 dur 3
    db $32, $03 ; note D3 dur 3
    db $32, $02 ; note D3 dur 2
    db $34, $03 ; note E3 dur 3
    db $A0, $0A ; volume $0A
    db $30, $03 ; note C3 dur 3
    db $32, $02 ; note D3 dur 2
    db $31, $03 ; note C#3 dur 3
    db $31, $02 ; note C#3 dur 2
    db $A0, $08 ; volume $08
    db $30, $03 ; note C3 dur 3
    db $32, $02 ; note D3 dur 2
    db $31, $03 ; note C#3 dur 3
    db $31, $02 ; note C#3 dur 2
    db $A0, $05 ; volume $05
    db $2A, $03 ; note A#2 dur 3
    db $32, $03 ; note D3 dur 3
    db $32, $02 ; note D3 dur 2
    db $34, $03 ; note E3 dur 3
    db $A0, $02 ; volume $02
    db $2A, $03 ; note A#2 dur 3
    db $32, $03 ; note D3 dur 3
    db $32, $02 ; note D3 dur 2
    db $34, $03 ; note E3 dur 3
    db $FF, $FF ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4359:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C3, $10 ; env $10
    db $1D, $01 ; rest-note $1D dur 1
    db $42, $19 ; note D4 dur 25
    db $12, $09 ; note D1 dur 9
    db $C1, $70 ; env $70
    db $3D, $02 ; rest-note $3D dur 2
    db $2C, $01 ; rest-note $2C dur 1
    db $31, $20 ; note C#3 dur 32
    db $A0, $0A ; volume $0A
    db $C1, $50 ; env $50
    db $31, $10 ; note C#3 dur 16
    db $A0, $04 ; volume $04
    db $32, $14 ; note D3 dur 20
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4379:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C1, $50 ; env $50
    db $58, $02 ; note G#5 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $58, $03 ; note G#5 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $5B, $10 ; note B5 dur 16
    db $A0, $08 ; volume $08
    db $5B, $10 ; note B5 dur 16
    db $FF, $FF ; end

; sound track, 30 events after the header (E-0019: grammar C2, meaning C0)
Data_043_438F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C1, $50 ; env $50
    db $12, $20 ; note D1 dur 32
    db $A0, $05 ; volume $05
    db $12, $13 ; note D1 dur 19
    db $A0, $0F ; volume $0F
    db $CC, $10 ; env $10
    db $12, $13 ; note D1 dur 19
    db $C1, $5F ; env $5F
    db $12, $0C ; note D1 dur 12
    db $13, $0B ; note D#1 dur 11
    db $13, $0A ; note D#1 dur 10
    db $13, $08 ; note D#1 dur 8
    db $13, $07 ; note D#1 dur 7
    db $13, $06 ; note D#1 dur 6
    db $13, $05 ; note D#1 dur 5
    db $13, $04 ; note D#1 dur 4
    db $13, $03 ; note D#1 dur 3
    db $13, $02 ; note D#1 dur 2
    db $A0, $08 ; volume $08
    db $12, $03 ; note D1 dur 3
    db $12, $02 ; note D1 dur 2
    db $12, $02 ; note D1 dur 2
    db $A0, $03 ; volume $03
    db $11, $02 ; note C#1 dur 2
    db $11, $02 ; note C#1 dur 2
    db $A0, $02 ; volume $02
    db $10, $02 ; note C1 dur 2
    db $10, $02 ; note C1 dur 2
    db $FF, $FF ; end
    db $FF, $FF ; end

; sound track, 47 events after the header (E-0019: grammar C2, meaning C0)
Data_043_43CF:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $63, $02 ; note D#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $66, $02 ; note F#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $70, $02 ; note C7 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $60, $02 ; note C6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $66, $02 ; note F#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $60, $02 ; note C6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $63, $02 ; note D#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $61, $02 ; note C#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $66, $02 ; note F#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $60, $02 ; note C6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $63, $02 ; note D#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $08 ; volume $08
    db $61, $02 ; note C#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $66, $02 ; note F#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $05 ; volume $05
    db $64, $02 ; note E6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $02 ; volume $02
    db $60, $02 ; note C6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $63, $02 ; note D#6 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $68, $02 ; note G#6 dur 2
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4431:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0A, $00 ; header: param=0 byte1=$00 volume=$0A byte3=$00
    db $23, $02 ; note D#2 dur 2
    db $21, $10 ; note C#2 dur 16
    db $A0, $0C ; volume $0C
    db $21, $18 ; note C#2 dur 24
    db $C1, $60 ; env $60
    db $A0, $0B ; volume $0B
    db $21, $10 ; note C#2 dur 16
    db $A0, $07 ; volume $07
    db $21, $28 ; note C#2 dur 40
    db $FF, $FF ; end

; sound track, 23 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4449:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1C, $01 ; rest-note $1C dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $02 ; env $02
    db $1D, $02 ; rest-note $1D dur 2
    db $44, $16 ; note E4 dur 22
    db $4D, $03 ; rest-note $4D dur 3
    db $45, $05 ; note F4 dur 5
    db $2E, $01 ; rest-note $2E dur 1
    db $11, $02 ; note C#1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $C3, $20 ; env $20
    db $3C, $03 ; rest-note $3C dur 3
    db $4F, $02 ; rest-note $4F dur 2
    db $46, $0B ; note F#4 dur 11
    db $C7, $75 ; env $75
    db $50, $0B ; note C5 dur 11
    db $43, $0D ; note D#4 dur 13
    db $60, $20 ; note C6 dur 32
    db $A0, $05 ; volume $05
    db $60, $14 ; note C6 dur 20
    db $A0, $02 ; volume $02
    db $60, $10 ; note C6 dur 16
    db $FF, $FF ; end

; sound track, 69 events after the header (E-0019: grammar C2, meaning C0)
Data_043_447B:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $63, $02 ; note D#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $62, $02 ; note D6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $65, $02 ; note F6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $63, $02 ; note D#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $61, $02 ; note C#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $63, $02 ; note D#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0A ; volume $0A
    db $63, $02 ; note D#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $61, $02 ; note C#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $63, $02 ; note D#6 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0F ; volume $0F
    db $A1, $17 ; duty $17
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $0C ; volume $0C
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $08 ; volume $08
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A1, $1F ; duty $1F
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $0C ; volume $0C
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $0A ; volume $0A
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $04 ; volume $04
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $03 ; volume $03
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $02 ; volume $02
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $01 ; volume $01
    db $50, $05 ; note C5 dur 5
    db $40, $05 ; note C4 dur 5
    db $41, $05 ; note C#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4509:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1F, $4B ; rest-note $1F dur 75
    db $A0, $08 ; volume $08
    db $20, $10 ; note C2 dur 16
    db $A0, $0F ; volume $0F
    db $1D, $04 ; rest-note $1D dur 4
    db $C1, $7F ; env $7F
    db $46, $20 ; note F#4 dur 32
    db $A0, $08 ; volume $08
    db $46, $25 ; note F#4 dur 37
    db $FF, $FF ; end

; sound track, 26 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4521:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $1F ; header: param=0 byte1=$00 volume=$0F byte3=$1F
    db $1F, $44 ; rest-note $1F dur 68
    db $40, $02 ; note C4 dur 2
    db $42, $02 ; note D4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $A0, $0D ; volume $0D
    db $40, $02 ; note C4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $42, $02 ; note D4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $A0, $0B ; volume $0B
    db $40, $02 ; note C4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $40, $02 ; note C4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $A0, $08 ; volume $08
    db $42, $02 ; note D4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $42, $02 ; note D4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $A0, $05 ; volume $05
    db $42, $02 ; note D4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $40, $02 ; note C4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4559:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $CC, $20 ; env $20
    db $50, $1E ; note C5 dur 30
    db $C3, $40 ; env $40
    db $50, $20 ; note C5 dur 32
    db $A0, $0C ; volume $0C
    db $C1, $70 ; env $70
    db $50, $08 ; note C5 dur 8
    db $C3, $40 ; env $40
    db $A0, $0F ; volume $0F
    db $3D, $02 ; rest-note $3D dur 2
    db $60, $25 ; note C6 dur 37
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $60, $40 ; note C6 dur 64
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_043_457B:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C1, $40 ; env $40
    db $70, $06 ; note C7 dur 6
    db $1F, $26 ; rest-note $1F dur 38
    db $59, $01 ; note A5 dur 1
    db $C1, $70 ; env $70
    db $5B, $15 ; note B5 dur 21
    db $A0, $08 ; volume $08
    db $5B, $18 ; note B5 dur 24
    db $FF, $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4591:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $20, $05 ; note C2 dur 5
    db $C1, $30 ; env $30
    db $42, $10 ; note D4 dur 16
    db $A0, $06 ; volume $06
    db $42, $10 ; note D4 dur 16
    db $A0, $0E ; volume $0E
    db $C1, $7F ; env $7F
    db $13, $25 ; note D#1 dur 37
    db $43, $12 ; note D#4 dur 18
    db $A0, $06 ; volume $06
    db $43, $20 ; note D#4 dur 32
    db $FF, $FF ; end

; sound track, 24 events after the header (E-0019: grammar C2, meaning C0)
Data_043_45AD:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $1C ; header: param=0 byte1=$00 volume=$0F byte3=$1C
    db $1F, $16 ; rest-note $1F dur 22
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $40, $05 ; note C4 dur 5
    db $39, $05 ; note A3 dur 5
    db $A0, $0C ; volume $0C
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $A0, $06 ; volume $06
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $A0, $03 ; volume $03
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $A0, $01 ; volume $01
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $FF, $FF ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
Data_043_45E1:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $58, $02 ; note G#5 dur 2
    db $50, $07 ; note C5 dur 7
    db $20, $07 ; note C2 dur 7
    db $A0, $07 ; volume $07
    db $20, $0A ; note C2 dur 10
    db $1F, $06 ; rest-note $1F dur 6
    db $A0, $0F ; volume $0F
    db $60, $0C ; note C6 dur 12
    db $63, $0C ; note D#6 dur 12
    db $54, $0A ; note E5 dur 10
    db $65, $04 ; note F6 dur 4
    db $A0, $08 ; volume $08
    db $63, $0C ; note D#6 dur 12
    db $54, $0A ; note E5 dur 10
    db $65, $04 ; note F6 dur 4
    db $A0, $03 ; volume $03
    db $63, $0C ; note D#6 dur 12
    db $A0, $02 ; volume $02
    db $54, $0A ; note E5 dur 10
    db $A0, $01 ; volume $01
    db $65, $04 ; note F6 dur 4
    db $FF, $FF ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4611:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $1E ; header: param=0 byte1=$00 volume=$0F byte3=$1E
    db $1F, $46 ; rest-note $1F dur 70
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $40, $05 ; note C4 dur 5
    db $39, $05 ; note A3 dur 5
    db $A0, $0C ; volume $0C
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $A0, $06 ; volume $06
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $A0, $03 ; volume $03
    db $39, $05 ; note A3 dur 5
    db $42, $05 ; note D4 dur 5
    db $A0, $01 ; volume $01
    db $40, $05 ; note C4 dur 5
    db $48, $05 ; note G#4 dur 5
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4641:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $59, $02 ; note A5 dur 2
    db $50, $07 ; note C5 dur 7
    db $30, $0B ; note C3 dur 11
    db $20, $07 ; note C2 dur 7
    db $A0, $07 ; volume $07
    db $20, $04 ; note C2 dur 4
    db $A0, $0E ; volume $0E
    db $60, $20 ; note C6 dur 32
    db $80, $30 ; note C8 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $50 ; env $50
    db $80, $18 ; note C8 dur 24
    db $FF, $FF ; end

; sound track, 30 events after the header (E-0019: grammar C2, meaning C0)
Data_043_465F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $27 ; header: param=0 byte1=$00 volume=$0F byte3=$27
    db $20, $05 ; note C2 dur 5
    db $26, $05 ; note F#2 dur 5
    db $25, $05 ; note F2 dur 5
    db $2B, $05 ; note B2 dur 5
    db $30, $05 ; note C3 dur 5
    db $36, $05 ; note F#3 dur 5
    db $35, $05 ; note F3 dur 5
    db $3B, $05 ; note B3 dur 5
    db $40, $05 ; note C4 dur 5
    db $46, $05 ; note F#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $4B, $05 ; note B4 dur 5
    db $50, $05 ; note C5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $A0, $04 ; volume $04
    db $40, $05 ; note C4 dur 5
    db $46, $05 ; note F#4 dur 5
    db $45, $05 ; note F4 dur 5
    db $4B, $05 ; note B4 dur 5
    db $A0, $02 ; volume $02
    db $50, $05 ; note C5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $45, $05 ; note F4 dur 5
    db $4B, $05 ; note B4 dur 5
    db $A0, $01 ; volume $01
    db $50, $05 ; note C5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $45, $05 ; note F4 dur 5
    db $4B, $05 ; note B4 dur 5
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_043_469F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $5B, $08 ; note B5 dur 8
    db $50, $04 ; note C5 dur 4
    db $5A, $07 ; note A#5 dur 7
    db $40, $04 ; note C4 dur 4
    db $59, $06 ; note A5 dur 6
    db $30, $03 ; note C3 dur 3
    db $58, $05 ; note G#5 dur 5
    db $3B, $04 ; note B3 dur 4
    db $3C, $03 ; rest-note $3C dur 3
    db $5C, $03 ; rest-note $5C dur 3
    db $54, $15 ; note E5 dur 21
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $54, $20 ; note E5 dur 32
    db $FF, $FF ; end

; sound track, 45 events after the header (E-0019: grammar C2, meaning C0)
Data_043_46C1:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $A0, $0F ; volume $0F
    db $A1, $17 ; duty $17
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $0C ; volume $0C
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $08 ; volume $08
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $0C ; volume $0C
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $08 ; volume $08
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $0C ; volume $0C
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $A0, $08 ; volume $08
    db $23, $03 ; note D#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $FF, $FF ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
Data_043_471F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C1, $7F ; env $7F
    db $46, $20 ; note F#4 dur 32
    db $46, $20 ; note F#4 dur 32
    db $46, $20 ; note F#4 dur 32
    db $A0, $08 ; volume $08
    db $46, $25 ; note F#4 dur 37
    db $FF, $FF ; end

; sound track, 26 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4731:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $2C, $03 ; rest-note $2C dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $1C, $02 ; rest-note $1C dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $67, $03 ; note G6 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $2C, $03 ; rest-note $2C dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $1C, $02 ; rest-note $1C dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $08 ; volume $08
    db $67, $03 ; note G6 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2C, $03 ; rest-note $2C dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0F ; volume $0F
    db $50, $0C ; note C5 dur 12
    db $C7, $20 ; env $20
    db $A0, $07 ; volume $07
    db $50, $20 ; note C5 dur 32
    db $FF, $FF ; end

; sound track, 990 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4769:: ; heuristic: track stream of a sound record; C0
    db $08, $00, $09, $00 ; header: param=8 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $AF, $08 ; param $08
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0E ; volume $0E
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0C ; volume $0C
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0B ; volume $0B
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0A ; volume $0A
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $09 ; volume $09
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $08 ; volume $08
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $07 ; volume $07
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $02 ; note F#3 dur 2
    db $A0, $05 ; volume $05
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $02 ; note F#3 dur 2
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $02 ; note F#3 dur 2
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $01 ; volume $01
    db $36, $02 ; note F#3 dur 2
    db $A0, $0F ; volume $0F
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0E ; volume $0E
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0C ; volume $0C
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0B ; volume $0B
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0A ; volume $0A
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $09 ; volume $09
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $0D ; volume $0D
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $0B ; volume $0B
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $08 ; volume $08
    db $38, $06 ; note G#3 dur 6
    db $A0, $03 ; volume $03
    db $38, $02 ; note G#3 dur 2
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $02 ; volume $02
    db $38, $02 ; note G#3 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0E ; volume $0E
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0C ; volume $0C
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0B ; volume $0B
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0A ; volume $0A
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $09 ; volume $09
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $07 ; volume $07
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $0D ; volume $0D
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0B ; volume $0B
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $06 ; note A#3 dur 6
    db $A0, $03 ; volume $03
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $06 ; note A#3 dur 6
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $A0, $0B ; volume $0B
    db $39, $06 ; note A3 dur 6
    db $A0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $04 ; volume $04
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0D ; volume $0D
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $0C ; volume $0C
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $0A ; volume $0A
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $09 ; volume $09
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $07 ; volume $07
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $02 ; note G#3 dur 2
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $03 ; volume $03
    db $38, $02 ; note G#3 dur 2
    db $A0, $05 ; volume $05
    db $38, $06 ; note G#3 dur 6
    db $A0, $02 ; volume $02
    db $38, $02 ; note G#3 dur 2
    db $A0, $03 ; volume $03
    db $38, $06 ; note G#3 dur 6
    db $A0, $01 ; volume $01
    db $38, $02 ; note G#3 dur 2
    db $A0, $0F ; volume $0F
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0E ; volume $0E
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0C ; volume $0C
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0B ; volume $0B
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $0A ; volume $0A
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $09 ; volume $09
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $05 ; volume $05
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $01 ; volume $01
    db $37, $02 ; note G3 dur 2
    db $A0, $0F ; volume $0F
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0E ; volume $0E
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0C ; volume $0C
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0B ; volume $0B
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $0A ; volume $0A
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $09 ; volume $09
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $02 ; note F#3 dur 2
    db $A0, $08 ; volume $08
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $07 ; volume $07
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $03 ; volume $03
    db $36, $02 ; note F#3 dur 2
    db $A0, $05 ; volume $05
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $02 ; note F#3 dur 2
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $01 ; volume $01
    db $36, $02 ; note F#3 dur 2
    db $A0, $02 ; volume $02
    db $36, $06 ; note F#3 dur 6
    db $A0, $01 ; volume $01
    db $36, $02 ; note F#3 dur 2
    db $A0, $0F ; volume $0F
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $0E ; volume $0E
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $0B ; volume $0B
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $0A ; volume $0A
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $09 ; volume $09
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $07 ; volume $07
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $03 ; volume $03
    db $35, $02 ; note F3 dur 2
    db $A0, $05 ; volume $05
    db $35, $06 ; note F3 dur 6
    db $A0, $03 ; volume $03
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $03 ; volume $03
    db $35, $06 ; note F3 dur 6
    db $A0, $01 ; volume $01
    db $35, $02 ; note F3 dur 2
    db $A0, $0F ; volume $0F
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0A ; volume $0A
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $0F ; volume $0F
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $A0, $0A ; volume $0A
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $03 ; volume $03
    db $33, $02 ; note D#3 dur 2
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $02 ; volume $02
    db $33, $02 ; note D#3 dur 2
    db $A0, $0F ; volume $0F
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0A ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0F ; volume $0F
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0E ; volume $0E
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0E ; volume $0E
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0D ; volume $0D
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0D ; volume $0D
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0B ; volume $0B
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0B ; volume $0B
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0A ; volume $0A
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0A ; volume $0A
    db $2B, $08 ; note B2 dur 8
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $09 ; volume $09
    db $2B, $07 ; note B2 dur 7
    db $A0, $03 ; volume $03
    db $2B, $02 ; note B2 dur 2
    db $A0, $09 ; volume $09
    db $2B, $07 ; note B2 dur 7
    db $A0, $03 ; volume $03
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $07 ; note B2 dur 7
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $07 ; note B2 dur 7
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $07 ; volume $07
    db $2B, $07 ; note B2 dur 7
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $05 ; volume $05
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $03 ; volume $03
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $2B, $0A ; note B2 dur 10
    db $A0, $01 ; volume $01
    db $2B, $0A ; note B2 dur 10
    db $A0, $01 ; volume $01
    db $2B, $0A ; note B2 dur 10
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0E ; volume $0E
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0C ; volume $0C
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0B ; volume $0B
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $0A ; volume $0A
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $09 ; volume $09
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $07 ; volume $07
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $06 ; volume $06
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $04 ; volume $04
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $A0, $01 ; volume $01
    db $40, $02 ; note C4 dur 2
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0E ; volume $0E
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0C ; volume $0C
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0B ; volume $0B
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0A ; volume $0A
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $09 ; volume $09
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $07 ; volume $07
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $06 ; volume $06
    db $3A, $06 ; note A#3 dur 6
    db $A0, $03 ; volume $03
    db $3A, $02 ; note A#3 dur 2
    db $A0, $05 ; volume $05
    db $3A, $06 ; note A#3 dur 6
    db $A0, $03 ; volume $03
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $06 ; note A#3 dur 6
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $01 ; volume $01
    db $3A, $02 ; note A#3 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $0E ; volume $0E
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $0C ; volume $0C
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $0B ; volume $0B
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $0A ; volume $0A
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $09 ; volume $09
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $07 ; volume $07
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $02 ; note B3 dur 2
    db $A0, $06 ; volume $06
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $05 ; volume $05
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $04 ; volume $04
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $03 ; volume $03
    db $3B, $06 ; note B3 dur 6
    db $A0, $01 ; volume $01
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0E ; volume $0E
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0C ; volume $0C
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0B ; volume $0B
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0A ; volume $0A
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $09 ; volume $09
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $08 ; volume $08
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $07 ; volume $07
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $05 ; volume $05
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $03 ; volume $03
    db $34, $06 ; note E3 dur 6
    db $A0, $01 ; volume $01
    db $34, $02 ; note E3 dur 2
    db $A0, $0F ; volume $0F
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0E ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0B ; volume $0B
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0A ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $A0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $A0, $09 ; volume $09
    db $32, $06 ; note D3 dur 6
    db $A0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $06 ; note D3 dur 6
    db $A0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $A0, $07 ; volume $07
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $A0, $01 ; volume $01
    db $32, $02 ; note D3 dur 2
    db $A0, $0F ; volume $0F
    db $46, $06 ; note F#4 dur 6
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $08 ; volume $08
    db $46, $06 ; note F#4 dur 6
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $06 ; volume $06
    db $46, $06 ; note F#4 dur 6
    db $A0, $02 ; volume $02
    db $46, $02 ; note F#4 dur 2
    db $A0, $03 ; volume $03
    db $46, $06 ; note F#4 dur 6
    db $A0, $01 ; volume $01
    db $46, $02 ; note F#4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $07 ; note E4 dur 7
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $07 ; note E4 dur 7
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $43, $07 ; note D#4 dur 7
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $08 ; volume $08
    db $43, $07 ; note D#4 dur 7
    db $A0, $02 ; volume $02
    db $43, $02 ; note D#4 dur 2
    db $A0, $06 ; volume $06
    db $43, $07 ; note D#4 dur 7
    db $A0, $02 ; volume $02
    db $43, $02 ; note D#4 dur 2
    db $A0, $03 ; volume $03
    db $43, $07 ; note D#4 dur 7
    db $A0, $01 ; volume $01
    db $43, $02 ; note D#4 dur 2
    db $A0, $0F ; volume $0F
    db $41, $07 ; note C#4 dur 7
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $08 ; volume $08
    db $41, $07 ; note C#4 dur 7
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $06 ; volume $06
    db $41, $07 ; note C#4 dur 7
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $03 ; volume $03
    db $41, $07 ; note C#4 dur 7
    db $A0, $01 ; volume $01
    db $41, $02 ; note C#4 dur 2
    db $A0, $0F ; volume $0F
    db $40, $07 ; note C4 dur 7
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $08 ; note C4 dur 8
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $06 ; volume $06
    db $40, $08 ; note C4 dur 8
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $03 ; volume $03
    db $40, $08 ; note C4 dur 8
    db $A0, $01 ; volume $01
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $3A, $08 ; note A#3 dur 8
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $08 ; note A#3 dur 8
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $06 ; volume $06
    db $3A, $08 ; note A#3 dur 8
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $03 ; volume $03
    db $3A, $08 ; note A#3 dur 8
    db $A0, $01 ; volume $01
    db $3A, $02 ; note A#3 dur 2
    db $AF, $02 ; param $02
    db $1F, $A8 ; rest-note $1F dur 168
    db $A0, $0F ; volume $0F
    db $42, $0E ; note D4 dur 14
    db $A0, $0C ; volume $0C
    db $42, $0E ; note D4 dur 14
    db $A0, $0B ; volume $0B
    db $42, $0E ; note D4 dur 14
    db $A0, $0A ; volume $0A
    db $42, $0E ; note D4 dur 14
    db $A0, $08 ; volume $08
    db $42, $0E ; note D4 dur 14
    db $A0, $06 ; volume $06
    db $42, $0E ; note D4 dur 14
    db $A0, $05 ; volume $05
    db $42, $0E ; note D4 dur 14
    db $A0, $04 ; volume $04
    db $42, $0D ; note D4 dur 13
    db $A0, $03 ; volume $03
    db $42, $0E ; note D4 dur 14
    db $A0, $02 ; volume $02
    db $42, $0E ; note D4 dur 14
    db $A0, $01 ; volume $01
    db $42, $0E ; note D4 dur 14
    db $A0, $01 ; volume $01
    db $42, $0C ; note D4 dur 12
    db $A0, $0F ; volume $0F
    db $41, $0E ; note C#4 dur 14
    db $A0, $0C ; volume $0C
    db $41, $0E ; note C#4 dur 14
    db $A0, $0B ; volume $0B
    db $41, $0D ; note C#4 dur 13
    db $A0, $0A ; volume $0A
    db $41, $0D ; note C#4 dur 13
    db $A0, $08 ; volume $08
    db $41, $0D ; note C#4 dur 13
    db $A0, $06 ; volume $06
    db $41, $0D ; note C#4 dur 13
    db $A0, $05 ; volume $05
    db $41, $0D ; note C#4 dur 13
    db $A0, $04 ; volume $04
    db $41, $0D ; note C#4 dur 13
    db $A0, $03 ; volume $03
    db $41, $0D ; note C#4 dur 13
    db $A0, $02 ; volume $02
    db $41, $0D ; note C#4 dur 13
    db $A0, $01 ; volume $01
    db $41, $0D ; note C#4 dur 13
    db $A0, $01 ; volume $01
    db $41, $0D ; note C#4 dur 13
    db $A0, $0F ; volume $0F
    db $40, $0D ; note C4 dur 13
    db $A0, $0C ; volume $0C
    db $40, $0D ; note C4 dur 13
    db $A0, $0B ; volume $0B
    db $40, $0D ; note C4 dur 13
    db $A0, $0A ; volume $0A
    db $40, $0D ; note C4 dur 13
    db $A0, $08 ; volume $08
    db $40, $0D ; note C4 dur 13
    db $A0, $06 ; volume $06
    db $40, $0D ; note C4 dur 13
    db $A0, $05 ; volume $05
    db $40, $0D ; note C4 dur 13
    db $A0, $04 ; volume $04
    db $40, $0D ; note C4 dur 13
    db $A0, $03 ; volume $03
    db $40, $0D ; note C4 dur 13
    db $A0, $02 ; volume $02
    db $40, $0D ; note C4 dur 13
    db $A0, $01 ; volume $01
    db $40, $0E ; note C4 dur 14
    db $A0, $01 ; volume $01
    db $40, $0E ; note C4 dur 14
    db $C1, $1F ; env $1F
    db $A0, $0C ; volume $0C
    db $3B, $0E ; note B3 dur 14
    db $A0, $05 ; volume $05
    db $3B, $0D ; note B3 dur 13
    db $A0, $0A ; volume $0A
    db $41, $0E ; note C#4 dur 14
    db $A0, $05 ; volume $05
    db $41, $0D ; note C#4 dur 13
    db $A0, $08 ; volume $08
    db $3B, $0E ; note B3 dur 14
    db $A0, $04 ; volume $04
    db $3B, $0D ; note B3 dur 13
    db $A0, $07 ; volume $07
    db $41, $0E ; note C#4 dur 14
    db $A0, $05 ; volume $05
    db $41, $0E ; note C#4 dur 14
    db $A0, $06 ; volume $06
    db $3B, $0E ; note B3 dur 14
    db $A0, $03 ; volume $03
    db $3B, $0D ; note B3 dur 13
    db $A0, $05 ; volume $05
    db $41, $0E ; note C#4 dur 14
    db $A0, $02 ; volume $02
    db $41, $0E ; note C#4 dur 14
    db $A0, $0C ; volume $0C
    db $3A, $0E ; note A#3 dur 14
    db $A0, $05 ; volume $05
    db $3A, $0D ; note A#3 dur 13
    db $A0, $0A ; volume $0A
    db $40, $0E ; note C4 dur 14
    db $A0, $05 ; volume $05
    db $40, $0E ; note C4 dur 14
    db $A0, $08 ; volume $08
    db $3A, $0E ; note A#3 dur 14
    db $A0, $04 ; volume $04
    db $3A, $0E ; note A#3 dur 14
    db $A0, $07 ; volume $07
    db $40, $0E ; note C4 dur 14
    db $A0, $05 ; volume $05
    db $40, $0E ; note C4 dur 14
    db $A0, $06 ; volume $06
    db $3A, $0E ; note A#3 dur 14
    db $A0, $03 ; volume $03
    db $3A, $0E ; note A#3 dur 14
    db $A0, $05 ; volume $05
    db $40, $0E ; note C4 dur 14
    db $A0, $02 ; volume $02
    db $40, $0E ; note C4 dur 14
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $41, $0E ; note C#4 dur 14
    db $A0, $0F ; volume $0F
    db $41, $0E ; note C#4 dur 14
    db $A0, $0E ; volume $0E
    db $41, $0E ; note C#4 dur 14
    db $A0, $0E ; volume $0E
    db $41, $0E ; note C#4 dur 14
    db $A0, $0D ; volume $0D
    db $41, $0E ; note C#4 dur 14
    db $A0, $0D ; volume $0D
    db $41, $0E ; note C#4 dur 14
    db $A0, $0C ; volume $0C
    db $41, $0E ; note C#4 dur 14
    db $A0, $0C ; volume $0C
    db $41, $0E ; note C#4 dur 14
    db $A0, $0B ; volume $0B
    db $41, $0F ; note C#4 dur 15
    db $A0, $0B ; volume $0B
    db $41, $0F ; note C#4 dur 15
    db $A0, $0A ; volume $0A
    db $41, $0F ; note C#4 dur 15
    db $A0, $0A ; volume $0A
    db $41, $0F ; note C#4 dur 15
    db $A0, $09 ; volume $09
    db $41, $0F ; note C#4 dur 15
    db $A0, $09 ; volume $09
    db $41, $0F ; note C#4 dur 15
    db $A0, $08 ; volume $08
    db $41, $0F ; note C#4 dur 15
    db $A0, $08 ; volume $08
    db $41, $0F ; note C#4 dur 15
    db $A0, $07 ; volume $07
    db $41, $0F ; note C#4 dur 15
    db $A0, $06 ; volume $06
    db $41, $0F ; note C#4 dur 15
    db $A0, $05 ; volume $05
    db $41, $0F ; note C#4 dur 15
    db $A0, $04 ; volume $04
    db $41, $0F ; note C#4 dur 15
    db $A0, $03 ; volume $03
    db $41, $10 ; note C#4 dur 16
    db $A0, $02 ; volume $02
    db $41, $12 ; note C#4 dur 18
    db $A0, $01 ; volume $01
    db $41, $14 ; note C#4 dur 20
    db $A0, $01 ; volume $01
    db $41, $17 ; note C#4 dur 23
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 1166 events after the header (E-0019: grammar C2, meaning C0)
Data_043_4F29:: ; heuristic: track stream of a sound record; C0
    db $08, $02, $09, $00 ; header: param=8 byte1=$02 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $AF, $08 ; param $08
    db $C1, $20 ; env $20
    db $A3, $0F ; mod $0F
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $04 ; volume $04
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $02 ; volume $02
    db $42, $06 ; note D4 dur 6
    db $A0, $01 ; volume $01
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $04 ; volume $04
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $A0, $01 ; volume $01
    db $40, $02 ; note C4 dur 2
    db $A0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $A0, $01 ; volume $01
    db $40, $02 ; note C4 dur 2
    db $A0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $A0, $01 ; volume $01
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $47, $06 ; note G4 dur 6
    db $A0, $03 ; volume $03
    db $47, $02 ; note G4 dur 2
    db $A0, $08 ; volume $08
    db $47, $06 ; note G4 dur 6
    db $A0, $02 ; volume $02
    db $47, $02 ; note G4 dur 2
    db $A0, $0F ; volume $0F
    db $45, $06 ; note F4 dur 6
    db $A0, $03 ; volume $03
    db $45, $02 ; note F4 dur 2
    db $A0, $08 ; volume $08
    db $45, $06 ; note F4 dur 6
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $0F ; volume $0F
    db $45, $06 ; note F4 dur 6
    db $A0, $03 ; volume $03
    db $45, $02 ; note F4 dur 2
    db $A0, $08 ; volume $08
    db $45, $06 ; note F4 dur 6
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $0C ; volume $0C
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $0B ; volume $0B
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $09 ; volume $09
    db $44, $06 ; note E4 dur 6
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $07 ; volume $07
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $05 ; volume $05
    db $44, $06 ; note E4 dur 6
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $06 ; note E4 dur 6
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $0C ; volume $0C
    db $42, $06 ; note D4 dur 6
    db $A0, $05 ; volume $05
    db $42, $02 ; note D4 dur 2
    db $A0, $09 ; volume $09
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $06 ; volume $06
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $01 ; volume $01
    db $42, $02 ; note D4 dur 2
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $02 ; volume $02
    db $40, $02 ; note C4 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0F ; volume $0F
    db $38, $06 ; note G#3 dur 6
    db $A0, $03 ; volume $03
    db $38, $02 ; note G#3 dur 2
    db $A0, $08 ; volume $08
    db $38, $06 ; note G#3 dur 6
    db $A0, $02 ; volume $02
    db $38, $02 ; note G#3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $A0, $03 ; volume $03
    db $3B, $02 ; note B3 dur 2
    db $A0, $08 ; volume $08
    db $3B, $06 ; note B3 dur 6
    db $A0, $02 ; volume $02
    db $3B, $02 ; note B3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $02 ; note A3 dur 2
    db $A0, $08 ; volume $08
    db $39, $06 ; note A3 dur 6
    db $A0, $02 ; volume $02
    db $39, $02 ; note A3 dur 2
    db $A0, $0F ; volume $0F
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $A0, $0F ; volume $0F
    db $37, $06 ; note G3 dur 6
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $A0, $0F ; volume $0F
    db $35, $06 ; note F3 dur 6
    db $A0, $03 ; volume $03
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0F ; volume $0F
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0E ; volume $0E
    db $34, $07 ; note E3 dur 7
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0E ; volume $0E
    db $34, $07 ; note E3 dur 7
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0D ; volume $0D
    db $34, $07 ; note E3 dur 7
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0D ; volume $0D
    db $34, $07 ; note E3 dur 7
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $0C ; volume $0C
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0C ; volume $0C
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0B ; volume $0B
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0B ; volume $0B
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0A ; volume $0A
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $0A ; volume $0A
    db $34, $08 ; note E3 dur 8
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $09 ; volume $09
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $09 ; volume $09
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $08 ; volume $08
    db $34, $07 ; note E3 dur 7
    db $A0, $03 ; volume $03
    db $34, $02 ; note E3 dur 2
    db $A0, $08 ; volume $08
    db $34, $07 ; note E3 dur 7
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $07 ; volume $07
    db $34, $07 ; note E3 dur 7
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $06 ; volume $06
    db $34, $08 ; note E3 dur 8
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $05 ; volume $05
    db $34, $08 ; note E3 dur 8
    db $A0, $02 ; volume $02
    db $34, $02 ; note E3 dur 2
    db $A0, $04 ; volume $04
    db $34, $08 ; note E3 dur 8
    db $A0, $01 ; volume $01
    db $34, $02 ; note E3 dur 2
    db $A0, $03 ; volume $03
    db $34, $08 ; note E3 dur 8
    db $A0, $01 ; volume $01
    db $34, $02 ; note E3 dur 2
    db $A0, $02 ; volume $02
    db $34, $0A ; note E3 dur 10
    db $A0, $01 ; volume $01
    db $34, $0A ; note E3 dur 10
    db $A0, $01 ; volume $01
    db $34, $0A ; note E3 dur 10
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $06 ; note E4 dur 6
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $4A, $06 ; note A#4 dur 6
    db $A0, $04 ; volume $04
    db $4A, $02 ; note A#4 dur 2
    db $A0, $08 ; volume $08
    db $4A, $06 ; note A#4 dur 6
    db $A0, $02 ; volume $02
    db $4A, $02 ; note A#4 dur 2
    db $A0, $06 ; volume $06
    db $4A, $06 ; note A#4 dur 6
    db $A0, $02 ; volume $02
    db $4A, $02 ; note A#4 dur 2
    db $A0, $03 ; volume $03
    db $4A, $06 ; note A#4 dur 6
    db $A0, $01 ; volume $01
    db $4A, $02 ; note A#4 dur 2
    db $A0, $0F ; volume $0F
    db $48, $06 ; note G#4 dur 6
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $08 ; volume $08
    db $48, $06 ; note G#4 dur 6
    db $A0, $03 ; volume $03
    db $48, $02 ; note G#4 dur 2
    db $A0, $06 ; volume $06
    db $48, $06 ; note G#4 dur 6
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $03 ; volume $03
    db $48, $06 ; note G#4 dur 6
    db $A0, $01 ; volume $01
    db $48, $02 ; note G#4 dur 2
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $52, $06 ; note D5 dur 6
    db $A0, $04 ; volume $04
    db $52, $02 ; note D5 dur 2
    db $A0, $0E ; volume $0E
    db $52, $06 ; note D5 dur 6
    db $A0, $04 ; volume $04
    db $52, $02 ; note D5 dur 2
    db $A0, $0C ; volume $0C
    db $52, $06 ; note D5 dur 6
    db $A0, $04 ; volume $04
    db $52, $02 ; note D5 dur 2
    db $A0, $0B ; volume $0B
    db $52, $06 ; note D5 dur 6
    db $A0, $04 ; volume $04
    db $52, $02 ; note D5 dur 2
    db $A0, $0A ; volume $0A
    db $52, $06 ; note D5 dur 6
    db $A0, $04 ; volume $04
    db $52, $02 ; note D5 dur 2
    db $A0, $09 ; volume $09
    db $52, $06 ; note D5 dur 6
    db $A0, $03 ; volume $03
    db $52, $02 ; note D5 dur 2
    db $A0, $08 ; volume $08
    db $52, $06 ; note D5 dur 6
    db $A0, $03 ; volume $03
    db $52, $02 ; note D5 dur 2
    db $A0, $07 ; volume $07
    db $52, $06 ; note D5 dur 6
    db $A0, $03 ; volume $03
    db $52, $02 ; note D5 dur 2
    db $A0, $06 ; volume $06
    db $52, $06 ; note D5 dur 6
    db $A0, $02 ; volume $02
    db $52, $02 ; note D5 dur 2
    db $A0, $05 ; volume $05
    db $52, $06 ; note D5 dur 6
    db $A0, $02 ; volume $02
    db $52, $02 ; note D5 dur 2
    db $A0, $04 ; volume $04
    db $52, $06 ; note D5 dur 6
    db $A0, $02 ; volume $02
    db $52, $02 ; note D5 dur 2
    db $A0, $03 ; volume $03
    db $52, $06 ; note D5 dur 6
    db $A0, $01 ; volume $01
    db $52, $02 ; note D5 dur 2
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $41, $06 ; note C#4 dur 6
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $0E ; volume $0E
    db $41, $06 ; note C#4 dur 6
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $0C ; volume $0C
    db $41, $06 ; note C#4 dur 6
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $0B ; volume $0B
    db $41, $06 ; note C#4 dur 6
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $0A ; volume $0A
    db $41, $06 ; note C#4 dur 6
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $09 ; volume $09
    db $41, $06 ; note C#4 dur 6
    db $A0, $03 ; volume $03
    db $41, $02 ; note C#4 dur 2
    db $A0, $08 ; volume $08
    db $41, $06 ; note C#4 dur 6
    db $A0, $03 ; volume $03
    db $41, $02 ; note C#4 dur 2
    db $A0, $07 ; volume $07
    db $41, $06 ; note C#4 dur 6
    db $A0, $03 ; volume $03
    db $41, $02 ; note C#4 dur 2
    db $A0, $06 ; volume $06
    db $41, $06 ; note C#4 dur 6
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $05 ; volume $05
    db $41, $06 ; note C#4 dur 6
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $04 ; volume $04
    db $41, $06 ; note C#4 dur 6
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $03 ; volume $03
    db $41, $06 ; note C#4 dur 6
    db $A0, $01 ; volume $01
    db $41, $02 ; note C#4 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $0E ; volume $0E
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $0C ; volume $0C
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $0B ; volume $0B
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $0A ; volume $0A
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $09 ; volume $09
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $07 ; volume $07
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $06 ; volume $06
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $05 ; volume $05
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $04 ; volume $04
    db $42, $06 ; note D4 dur 6
    db $A0, $01 ; volume $01
    db $42, $02 ; note D4 dur 2
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $01 ; volume $01
    db $42, $02 ; note D4 dur 2
    db $A0, $0F ; volume $0F
    db $3A, $06 ; note A#3 dur 6
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $06 ; note A#3 dur 6
    db $A0, $03 ; volume $03
    db $3A, $02 ; note A#3 dur 2
    db $A0, $06 ; volume $06
    db $3A, $06 ; note A#3 dur 6
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $01 ; volume $01
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0F ; volume $0F
    db $44, $06 ; note E4 dur 6
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $06 ; note E4 dur 6
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $06 ; note E4 dur 6
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $06 ; note E4 dur 6
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $03 ; volume $03
    db $42, $02 ; note D4 dur 2
    db $A0, $06 ; volume $06
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $01 ; volume $01
    db $42, $02 ; note D4 dur 2
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $48, $06 ; note G#4 dur 6
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0E ; volume $0E
    db $48, $06 ; note G#4 dur 6
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0C ; volume $0C
    db $48, $06 ; note G#4 dur 6
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0B ; volume $0B
    db $48, $06 ; note G#4 dur 6
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0A ; volume $0A
    db $48, $06 ; note G#4 dur 6
    db $A0, $03 ; volume $03
    db $48, $02 ; note G#4 dur 2
    db $A0, $09 ; volume $09
    db $48, $06 ; note G#4 dur 6
    db $A0, $03 ; volume $03
    db $48, $02 ; note G#4 dur 2
    db $A0, $08 ; volume $08
    db $48, $06 ; note G#4 dur 6
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $07 ; volume $07
    db $48, $06 ; note G#4 dur 6
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $06 ; volume $06
    db $48, $06 ; note G#4 dur 6
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $05 ; volume $05
    db $48, $06 ; note G#4 dur 6
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $04 ; volume $04
    db $48, $06 ; note G#4 dur 6
    db $A0, $01 ; volume $01
    db $48, $02 ; note G#4 dur 2
    db $A0, $03 ; volume $03
    db $48, $06 ; note G#4 dur 6
    db $A0, $01 ; volume $01
    db $48, $02 ; note G#4 dur 2
    db $A0, $0F ; volume $0F
    db $49, $06 ; note A4 dur 6
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $08 ; volume $08
    db $49, $06 ; note A4 dur 6
    db $A0, $02 ; volume $02
    db $49, $02 ; note A4 dur 2
    db $A0, $06 ; volume $06
    db $49, $06 ; note A4 dur 6
    db $A0, $01 ; volume $01
    db $49, $02 ; note A4 dur 2
    db $A0, $03 ; volume $03
    db $49, $06 ; note A4 dur 6
    db $A0, $01 ; volume $01
    db $49, $02 ; note A4 dur 2
    db $A0, $0F ; volume $0F
    db $47, $06 ; note G4 dur 6
    db $A0, $04 ; volume $04
    db $47, $02 ; note G4 dur 2
    db $A0, $08 ; volume $08
    db $47, $06 ; note G4 dur 6
    db $A0, $02 ; volume $02
    db $47, $02 ; note G4 dur 2
    db $A0, $06 ; volume $06
    db $47, $07 ; note G4 dur 7
    db $A0, $01 ; volume $01
    db $47, $02 ; note G4 dur 2
    db $A0, $03 ; volume $03
    db $47, $07 ; note G4 dur 7
    db $A0, $01 ; volume $01
    db $47, $02 ; note G4 dur 2
    db $A0, $0F ; volume $0F
    db $46, $07 ; note F#4 dur 7
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $08 ; volume $08
    db $46, $07 ; note F#4 dur 7
    db $A0, $02 ; volume $02
    db $46, $02 ; note F#4 dur 2
    db $A0, $06 ; volume $06
    db $46, $07 ; note F#4 dur 7
    db $A0, $01 ; volume $01
    db $46, $02 ; note F#4 dur 2
    db $A0, $03 ; volume $03
    db $46, $07 ; note F#4 dur 7
    db $A0, $01 ; volume $01
    db $46, $02 ; note F#4 dur 2
    db $A0, $0F ; volume $0F
    db $44, $07 ; note E4 dur 7
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $07 ; note E4 dur 7
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $07 ; note E4 dur 7
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $07 ; note E4 dur 7
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $0F ; volume $0F
    db $43, $07 ; note D#4 dur 7
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $08 ; volume $08
    db $43, $08 ; note D#4 dur 8
    db $A0, $02 ; volume $02
    db $43, $02 ; note D#4 dur 2
    db $A0, $06 ; volume $06
    db $43, $08 ; note D#4 dur 8
    db $A0, $01 ; volume $01
    db $43, $02 ; note D#4 dur 2
    db $A0, $03 ; volume $03
    db $43, $08 ; note D#4 dur 8
    db $A0, $01 ; volume $01
    db $43, $02 ; note D#4 dur 2
    db $A0, $0F ; volume $0F
    db $41, $08 ; note C#4 dur 8
    db $A0, $04 ; volume $04
    db $41, $02 ; note C#4 dur 2
    db $A0, $08 ; volume $08
    db $41, $08 ; note C#4 dur 8
    db $A0, $02 ; volume $02
    db $41, $02 ; note C#4 dur 2
    db $A0, $06 ; volume $06
    db $41, $08 ; note C#4 dur 8
    db $A0, $01 ; volume $01
    db $41, $02 ; note C#4 dur 2
    db $A0, $03 ; volume $03
    db $41, $08 ; note C#4 dur 8
    db $A0, $01 ; volume $01
    db $41, $02 ; note C#4 dur 2
    db $AF, $02 ; param $02
    db $A0, $0F ; volume $0F
    db $43, $0C ; note D#4 dur 12
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $0C ; volume $0C
    db $43, $0C ; note D#4 dur 12
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $0C ; volume $0C
    db $43, $0C ; note D#4 dur 12
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $0B ; volume $0B
    db $43, $0C ; note D#4 dur 12
    db $A0, $04 ; volume $04
    db $43, $02 ; note D#4 dur 2
    db $A0, $09 ; volume $09
    db $43, $0C ; note D#4 dur 12
    db $A0, $03 ; volume $03
    db $43, $02 ; note D#4 dur 2
    db $A0, $08 ; volume $08
    db $43, $0C ; note D#4 dur 12
    db $A0, $03 ; volume $03
    db $43, $02 ; note D#4 dur 2
    db $A0, $07 ; volume $07
    db $43, $0C ; note D#4 dur 12
    db $A0, $02 ; volume $02
    db $43, $02 ; note D#4 dur 2
    db $A0, $05 ; volume $05
    db $43, $0C ; note D#4 dur 12
    db $A0, $02 ; volume $02
    db $43, $02 ; note D#4 dur 2
    db $A0, $04 ; volume $04
    db $43, $0C ; note D#4 dur 12
    db $A0, $01 ; volume $01
    db $43, $02 ; note D#4 dur 2
    db $A0, $03 ; volume $03
    db $43, $0E ; note D#4 dur 14
    db $A0, $02 ; volume $02
    db $43, $0E ; note D#4 dur 14
    db $A0, $01 ; volume $01
    db $43, $0E ; note D#4 dur 14
    db $A0, $0F ; volume $0F
    db $44, $0C ; note E4 dur 12
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $0C ; volume $0C
    db $44, $0C ; note E4 dur 12
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $0B ; volume $0B
    db $44, $0C ; note E4 dur 12
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $0A ; volume $0A
    db $44, $0C ; note E4 dur 12
    db $A0, $04 ; volume $04
    db $44, $02 ; note E4 dur 2
    db $A0, $08 ; volume $08
    db $44, $0C ; note E4 dur 12
    db $A0, $03 ; volume $03
    db $44, $02 ; note E4 dur 2
    db $A0, $06 ; volume $06
    db $44, $0C ; note E4 dur 12
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $05 ; volume $05
    db $44, $0C ; note E4 dur 12
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $04 ; volume $04
    db $44, $0B ; note E4 dur 11
    db $A0, $02 ; volume $02
    db $44, $02 ; note E4 dur 2
    db $A0, $03 ; volume $03
    db $44, $0C ; note E4 dur 12
    db $A0, $01 ; volume $01
    db $44, $02 ; note E4 dur 2
    db $A0, $02 ; volume $02
    db $44, $0E ; note E4 dur 14
    db $A0, $01 ; volume $01
    db $44, $0E ; note E4 dur 14
    db $A0, $01 ; volume $01
    db $44, $0C ; note E4 dur 12
    db $A0, $0F ; volume $0F
    db $45, $0C ; note F4 dur 12
    db $A0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $A0, $0C ; volume $0C
    db $45, $0C ; note F4 dur 12
    db $A0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $A0, $0B ; volume $0B
    db $45, $0B ; note F4 dur 11
    db $A0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $A0, $0A ; volume $0A
    db $45, $0B ; note F4 dur 11
    db $A0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $A0, $08 ; volume $08
    db $45, $0B ; note F4 dur 11
    db $A0, $03 ; volume $03
    db $45, $02 ; note F4 dur 2
    db $A0, $06 ; volume $06
    db $45, $0B ; note F4 dur 11
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $05 ; volume $05
    db $45, $0B ; note F4 dur 11
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $04 ; volume $04
    db $45, $0B ; note F4 dur 11
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $03 ; volume $03
    db $45, $0B ; note F4 dur 11
    db $A0, $01 ; volume $01
    db $45, $02 ; note F4 dur 2
    db $A0, $02 ; volume $02
    db $45, $0D ; note F4 dur 13
    db $A0, $01 ; volume $01
    db $45, $0D ; note F4 dur 13
    db $A0, $01 ; volume $01
    db $45, $0D ; note F4 dur 13
    db $A0, $0F ; volume $0F
    db $46, $0B ; note F#4 dur 11
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $0C ; volume $0C
    db $46, $0B ; note F#4 dur 11
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $0B ; volume $0B
    db $46, $0B ; note F#4 dur 11
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $0A ; volume $0A
    db $46, $0B ; note F#4 dur 11
    db $A0, $04 ; volume $04
    db $46, $02 ; note F#4 dur 2
    db $A0, $08 ; volume $08
    db $46, $0B ; note F#4 dur 11
    db $A0, $03 ; volume $03
    db $46, $02 ; note F#4 dur 2
    db $A0, $06 ; volume $06
    db $46, $0B ; note F#4 dur 11
    db $A0, $03 ; volume $03
    db $46, $02 ; note F#4 dur 2
    db $A0, $05 ; volume $05
    db $46, $0B ; note F#4 dur 11
    db $A0, $02 ; volume $02
    db $46, $02 ; note F#4 dur 2
    db $A0, $04 ; volume $04
    db $46, $0B ; note F#4 dur 11
    db $A0, $02 ; volume $02
    db $46, $02 ; note F#4 dur 2
    db $A0, $03 ; volume $03
    db $46, $0B ; note F#4 dur 11
    db $A0, $01 ; volume $01
    db $46, $02 ; note F#4 dur 2
    db $A0, $02 ; volume $02
    db $46, $0D ; note F#4 dur 13
    db $A0, $01 ; volume $01
    db $46, $0E ; note F#4 dur 14
    db $A0, $01 ; volume $01
    db $46, $0E ; note F#4 dur 14
    db $A0, $0F ; volume $0F
    db $47, $0B ; note G4 dur 11
    db $A0, $04 ; volume $04
    db $47, $02 ; note G4 dur 2
    db $A0, $0C ; volume $0C
    db $47, $0B ; note G4 dur 11
    db $A0, $04 ; volume $04
    db $47, $02 ; note G4 dur 2
    db $A0, $0B ; volume $0B
    db $47, $0B ; note G4 dur 11
    db $A0, $04 ; volume $04
    db $47, $02 ; note G4 dur 2
    db $A0, $0A ; volume $0A
    db $47, $0B ; note G4 dur 11
    db $A0, $04 ; volume $04
    db $47, $02 ; note G4 dur 2
    db $A0, $08 ; volume $08
    db $47, $0B ; note G4 dur 11
    db $A0, $03 ; volume $03
    db $47, $02 ; note G4 dur 2
    db $A0, $06 ; volume $06
    db $47, $0C ; note G4 dur 12
    db $A0, $03 ; volume $03
    db $47, $02 ; note G4 dur 2
    db $A0, $05 ; volume $05
    db $47, $0C ; note G4 dur 12
    db $A0, $02 ; volume $02
    db $47, $02 ; note G4 dur 2
    db $A0, $04 ; volume $04
    db $47, $0C ; note G4 dur 12
    db $A0, $02 ; volume $02
    db $47, $02 ; note G4 dur 2
    db $A0, $03 ; volume $03
    db $47, $0C ; note G4 dur 12
    db $A0, $02 ; volume $02
    db $47, $02 ; note G4 dur 2
    db $A0, $02 ; volume $02
    db $47, $0E ; note G4 dur 14
    db $A0, $02 ; volume $02
    db $47, $0E ; note G4 dur 14
    db $A0, $01 ; volume $01
    db $47, $0E ; note G4 dur 14
    db $A0, $0F ; volume $0F
    db $48, $0C ; note G#4 dur 12
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0C ; volume $0C
    db $48, $0C ; note G#4 dur 12
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0B ; volume $0B
    db $48, $0C ; note G#4 dur 12
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $0A ; volume $0A
    db $48, $0C ; note G#4 dur 12
    db $A0, $04 ; volume $04
    db $48, $02 ; note G#4 dur 2
    db $A0, $08 ; volume $08
    db $48, $0C ; note G#4 dur 12
    db $A0, $03 ; volume $03
    db $48, $02 ; note G#4 dur 2
    db $A0, $06 ; volume $06
    db $48, $0C ; note G#4 dur 12
    db $A0, $03 ; volume $03
    db $48, $02 ; note G#4 dur 2
    db $A0, $05 ; volume $05
    db $48, $0C ; note G#4 dur 12
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $04 ; volume $04
    db $48, $0C ; note G#4 dur 12
    db $A0, $02 ; volume $02
    db $48, $02 ; note G#4 dur 2
    db $A0, $03 ; volume $03
    db $48, $0C ; note G#4 dur 12
    db $A0, $01 ; volume $01
    db $48, $02 ; note G#4 dur 2
    db $A0, $02 ; volume $02
    db $48, $0E ; note G#4 dur 14
    db $A0, $01 ; volume $01
    db $48, $0E ; note G#4 dur 14
    db $A0, $01 ; volume $01
    db $48, $0E ; note G#4 dur 14
    db $C1, $20 ; env $20
    db $A0, $0F ; volume $0F
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0F ; volume $0F
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0E ; volume $0E
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0E ; volume $0E
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0D ; volume $0D
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0D ; volume $0D
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0C ; volume $0C
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0C ; volume $0C
    db $49, $0C ; note A4 dur 12
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0B ; volume $0B
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0B ; volume $0B
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0A ; volume $0A
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $0A ; volume $0A
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $09 ; volume $09
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $09 ; volume $09
    db $49, $0D ; note A4 dur 13
    db $A0, $04 ; volume $04
    db $49, $02 ; note A4 dur 2
    db $A0, $08 ; volume $08
    db $49, $0D ; note A4 dur 13
    db $A0, $03 ; volume $03
    db $49, $02 ; note A4 dur 2
    db $A0, $08 ; volume $08
    db $49, $0D ; note A4 dur 13
    db $A0, $03 ; volume $03
    db $49, $02 ; note A4 dur 2
    db $A0, $07 ; volume $07
    db $49, $0D ; note A4 dur 13
    db $A0, $03 ; volume $03
    db $49, $02 ; note A4 dur 2
    db $A0, $06 ; volume $06
    db $49, $0D ; note A4 dur 13
    db $A0, $03 ; volume $03
    db $49, $02 ; note A4 dur 2
    db $A0, $05 ; volume $05
    db $49, $0D ; note A4 dur 13
    db $A0, $02 ; volume $02
    db $49, $02 ; note A4 dur 2
    db $A0, $04 ; volume $04
    db $49, $0D ; note A4 dur 13
    db $A0, $02 ; volume $02
    db $49, $02 ; note A4 dur 2
    db $A0, $03 ; volume $03
    db $49, $0E ; note A4 dur 14
    db $A0, $02 ; volume $02
    db $49, $02 ; note A4 dur 2
    db $A0, $02 ; volume $02
    db $49, $12 ; note A4 dur 18
    db $A0, $01 ; volume $01
    db $49, $14 ; note A4 dur 20
    db $A0, $01 ; volume $01
    db $49, $17 ; note A4 dur 23
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 181 events after the header (E-0019: grammar C2, meaning C0)
Data_043_5849:: ; heuristic: track stream of a sound record; C0
    db $08, $FF, $02, $0F ; header: param=8 byte1=$FF volume=$02 byte3=$0F
    db $FD, $F3 ; label 3
    db $AF, $08 ; param $08
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
    db $A1, $02 ; duty $02
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
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $30, $50 ; note C3 dur 80
    db $A0, $04 ; volume $04
    db $30, $10 ; note C3 dur 16
    db $A1, $02 ; duty $02
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
    db $AF, $02 ; param $02
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1C ; note A4 dur 28
    db $B2, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1C ; note A4 dur 28
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1B ; note A4 dur 27
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1A ; note A4 dur 26
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $19 ; note A4 dur 25
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $19 ; note A4 dur 25
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $18 ; note A4 dur 24
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $18 ; note A4 dur 24
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $19 ; note A4 dur 25
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $19 ; note A4 dur 25
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1A ; note A4 dur 26
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1B ; note A4 dur 27
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1B ; note A4 dur 27
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1B ; note A4 dur 27
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1C ; note A4 dur 28
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1C ; note A4 dur 28
    db $A0, $02 ; volume $02
    db $49, $1C ; note A4 dur 28
    db $A0, $06 ; volume $06
    db $49, $1E ; note A4 dur 30
    db $A2, $FF ; duty2 $FF
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $40, $3B ; note C4 dur 59
    db $41, $3B ; note C#4 dur 59
    db $42, $3C ; note D4 dur 60
    db $43, $44 ; note D#4 dur 68
    db $44, $2F ; note E4 dur 47
    db $A0, $04 ; volume $04
    db $44, $12 ; note E4 dur 18
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 365 events after the header (E-0019: grammar C2, meaning C0)
Data_043_59B7:: ; heuristic: track stream of a sound record; C0
    db $02, $02, $09, $00 ; header: param=2 byte1=$02 volume=$09 byte3=$00
    db $FD, $F2 ; label 2
    db $A2, $01 ; duty2 $01
    db $A3, $14 ; mod $14
    db $C1, $32 ; env $32
    db $1F, $20 ; rest-note $1F dur 32
    db $FD, $F0 ; label 0
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $17, $0F ; note G1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $16, $0F ; note F#1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $B1, $F0 ; repeat $F0
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $14, $0F ; note E1 dur 15
    db $A0, $0C ; volume $0C
    db $1B, $20 ; note B1 dur 32
    db $A0, $09 ; volume $09
    db $1B, $10 ; note B1 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $09, $0F ; note A0 dur 15
    db $A0, $0C ; volume $0C
    db $20, $20 ; note C2 dur 32
    db $A0, $09 ; volume $09
    db $20, $10 ; note C2 dur 16
    db $FD, $F0 ; label 0
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $0F ; note D1 dur 15
    db $A0, $0C ; volume $0C
    db $20, $20 ; note C2 dur 32
    db $A0, $09 ; volume $09
    db $20, $10 ; note C2 dur 16
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $19, $0F ; note A1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $18, $0F ; note G#1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $B1, $F0 ; repeat $F0
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $17, $0F ; note G1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $16, $0F ; note F#1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $17, $0F ; note G1 dur 15
    db $A0, $0C ; volume $0C
    db $26, $20 ; note F#2 dur 32
    db $A0, $08 ; volume $08
    db $26, $10 ; note F#2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $17, $0F ; note G1 dur 15
    db $A0, $0C ; volume $0C
    db $25, $20 ; note F2 dur 32
    db $A0, $08 ; volume $08
    db $25, $10 ; note F2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $10, $0F ; note C1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $16, $0F ; note F#1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $0B, $0F ; note B0 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $14, $0F ; note E1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $09, $0F ; note A0 dur 15
    db $A0, $0C ; volume $0C
    db $20, $20 ; note C2 dur 32
    db $A0, $09 ; volume $09
    db $20, $10 ; note C2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $09, $0F ; note A0 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $0A, $0F ; note A#0 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $0B, $0F ; note B0 dur 15
    db $A0, $0C ; volume $0C
    db $26, $20 ; note F#2 dur 32
    db $A0, $09 ; volume $09
    db $26, $10 ; note F#2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $0F ; note F1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $14, $0F ; note E1 dur 15
    db $A0, $0C ; volume $0C
    db $22, $20 ; note D2 dur 32
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $11, $0F ; note C#1 dur 15
    db $A0, $0C ; volume $0C
    db $24, $20 ; note E2 dur 32
    db $A0, $09 ; volume $09
    db $24, $10 ; note E2 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $0F ; note D1 dur 15
    db $A0, $0C ; volume $0C
    db $26, $20 ; note F#2 dur 32
    db $A0, $09 ; volume $09
    db $26, $10 ; note F#2 dur 16
    db $A0, $0C ; volume $0C
    db $C1, $4F ; env $4F
    db $22, $20 ; note D2 dur 32
    db $22, $20 ; note D2 dur 32
    db $22, $20 ; note D2 dur 32
    db $20, $20 ; note C2 dur 32
    db $1B, $20 ; note B1 dur 32
    db $1B, $20 ; note B1 dur 32
    db $19, $20 ; note A1 dur 32
    db $23, $20 ; note D#2 dur 32
    db $C1, $32 ; env $32
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $14, $0F ; note E1 dur 15
    db $A0, $0C ; volume $0C
    db $1B, $20 ; note B1 dur 32
    db $A0, $09 ; volume $09
    db $1B, $10 ; note B1 dur 16
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $11, $0F ; note C#1 dur 15
    db $A0, $0C ; volume $0C
    db $19, $20 ; note A1 dur 32
    db $A0, $09 ; volume $09
    db $19, $10 ; note A1 dur 16
    db $FD, $F0 ; label 0
    db $A0, $05 ; volume $05
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $0F ; note D1 dur 15
    db $A0, $0C ; volume $0C
    db $19, $20 ; note A1 dur 32
    db $A0, $09 ; volume $09
    db $19, $10 ; note A1 dur 16
    db $B1, $F0 ; repeat $F0
    db $A2, $02 ; duty2 $02
    db $A0, $05 ; volume $05
    db $A3, $60 ; mod $60
    db $C1, $0F ; env $0F
    db $1F, $18 ; rest-note $1F dur 24
    db $32, $10 ; note D3 dur 16
    db $32, $10 ; note D3 dur 16
    db $32, $10 ; note D3 dur 16
    db $FD, $F0 ; label 0
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $32, $10 ; note D3 dur 16
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $C2, $0F ; env $0F
    db $2B, $08 ; note B2 dur 8
    db $A0, $0B ; volume $0B
    db $A4, $FE ; skip $FE
    db $C2, $10 ; env $10
    db $27, $10 ; note G2 dur 16
    db $27, $10 ; note G2 dur 16
    db $27, $10 ; note G2 dur 16
    db $C1, $60 ; env $60
    db $26, $10 ; note F#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $C1, $80 ; env $80
    db $22, $40 ; note D2 dur 64
    db $A3, $70 ; mod $70
    db $A7, $08 ; wait $08
    db $B1, $F0 ; repeat $F0
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $34, $10 ; note E3 dur 16
    db $36, $10 ; note F#3 dur 16
    db $C1, $10 ; env $10
    db $37, $08 ; note G3 dur 8
    db $A0, $0B ; volume $0B
    db $A4, $FE ; skip $FE
    db $C2, $10 ; env $10
    db $22, $10 ; note D2 dur 16
    db $22, $10 ; note D2 dur 16
    db $22, $10 ; note D2 dur 16
    db $C1, $60 ; env $60
    db $24, $10 ; note E2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $29, $10 ; note A2 dur 16
    db $C1, $80 ; env $80
    db $2B, $40 ; note B2 dur 64
    db $A3, $70 ; mod $70
    db $A7, $08 ; wait $08
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $36, $10 ; note F#3 dur 16
    db $34, $10 ; note E3 dur 16
    db $C1, $10 ; env $10
    db $32, $08 ; note D3 dur 8
    db $A0, $0B ; volume $0B
    db $A4, $FE ; skip $FE
    db $C2, $10 ; env $10
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $C1, $60 ; env $60
    db $29, $10 ; note A2 dur 16
    db $27, $10 ; note G2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $24, $10 ; note E2 dur 16
    db $C1, $80 ; env $80
    db $22, $40 ; note D2 dur 64
    db $A3, $70 ; mod $70
    db $A7, $08 ; wait $08
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $42, $10 ; note D4 dur 16
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $42, $10 ; note D4 dur 16
    db $C1, $10 ; env $10
    db $3B, $08 ; note B3 dur 8
    db $A0, $0B ; volume $0B
    db $A4, $FE ; skip $FE
    db $C2, $10 ; env $10
    db $37, $10 ; note G3 dur 16
    db $37, $10 ; note G3 dur 16
    db $37, $10 ; note G3 dur 16
    db $C1, $60 ; env $60
    db $36, $10 ; note F#3 dur 16
    db $37, $10 ; note G3 dur 16
    db $34, $10 ; note E3 dur 16
    db $36, $10 ; note F#3 dur 16
    db $C1, $80 ; env $80
    db $32, $40 ; note D3 dur 64
    db $A3, $70 ; mod $70
    db $A7, $08 ; wait $08
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $35, $10 ; note F3 dur 16
    db $39, $10 ; note A3 dur 16
    db $C1, $10 ; env $10
    db $37, $08 ; note G3 dur 8
    db $A0, $0B ; volume $0B
    db $A4, $FE ; skip $FE
    db $C2, $10 ; env $10
    db $27, $10 ; note G2 dur 16
    db $27, $10 ; note G2 dur 16
    db $27, $10 ; note G2 dur 16
    db $C1, $60 ; env $60
    db $25, $10 ; note F2 dur 16
    db $29, $10 ; note A2 dur 16
    db $20, $10 ; note C2 dur 16
    db $25, $10 ; note F2 dur 16
    db $C1, $80 ; env $80
    db $22, $40 ; note D2 dur 64
    db $A3, $70 ; mod $70
    db $A2, $01 ; duty2 $01
    db $A0, $03 ; volume $03
    db $A4, $FE ; skip $FE
    db $FD, $F1 ; label 1
    db $C1, $08 ; env $08
    db $A7, $10 ; wait $10
    db $C1, $10 ; env $10
    db $FD, $F0 ; label 0
    db $32, $08 ; note D3 dur 8
    db $34, $08 ; note E3 dur 8
    db $B2, $F0 ; repeat $F0
    db $B2, $F1 ; repeat $F1
    db $A7, $10 ; wait $10
    db $A0, $09 ; volume $09
    db $C1, $30 ; env $30
    db $FD, $F1 ; label 1
    db $FD, $F0 ; label 0
    db $2B, $08 ; note B2 dur 8
    db $30, $08 ; note C3 dur 8
    db $B2, $F0 ; repeat $F0
    db $C1, $30 ; env $30
    db $A7, $10 ; wait $10
    db $B1, $F1 ; repeat $F1
    db $FD, $F0 ; label 0
    db $2B, $08 ; note B2 dur 8
    db $30, $08 ; note C3 dur 8
    db $B2, $F0 ; repeat $F0
    db $2B, $10 ; note B2 dur 16
    db $1F, $10 ; rest-note $1F dur 16
    db $B0, $F2 ; jump $F2
    db $FF, $FF ; end

; sound track, 269 events after the header (E-0019: grammar C2, meaning C0)
Data_043_5C95:: ; heuristic: track stream of a sound record; C0
    db $02, $02, $0F, $00 ; header: param=2 byte1=$02 volume=$0F byte3=$00
    db $FD, $F2 ; label 2
    db $A2, $02 ; duty2 $02
    db $A3, $22 ; mod $22
    db $C1, $2F ; env $2F
    db $1F, $20 ; rest-note $1F dur 32
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $17, $10 ; note G1 dur 16
    db $A0, $07 ; volume $07
    db $1B, $20 ; note B1 dur 32
    db $1B, $10 ; note B1 dur 16
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $16, $10 ; note F#1 dur 16
    db $A0, $07 ; volume $07
    db $1B, $20 ; note B1 dur 32
    db $1B, $10 ; note B1 dur 16
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $14, $10 ; note E1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $09, $10 ; note A0 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $12, $10 ; note D1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $12, $10 ; note D1 dur 16
    db $A0, $07 ; volume $07
    db $16, $20 ; note F#1 dur 32
    db $16, $10 ; note F#1 dur 16
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $19, $10 ; note A1 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $18, $10 ; note G#1 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $17, $10 ; note G1 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $A0, $0E ; volume $0E
    db $16, $10 ; note F#1 dur 16
    db $A0, $0E ; volume $0E
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $1B, $20 ; note B1 dur 32
    db $1B, $10 ; note B1 dur 16
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $10, $10 ; note C1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $16, $10 ; note F#1 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $A0, $0E ; volume $0E
    db $0B, $10 ; note B0 dur 16
    db $A0, $07 ; volume $07
    db $19, $20 ; note A1 dur 32
    db $19, $10 ; note A1 dur 16
    db $A0, $0E ; volume $0E
    db $14, $10 ; note E1 dur 16
    db $A0, $07 ; volume $07
    db $18, $20 ; note G#1 dur 32
    db $18, $10 ; note G#1 dur 16
    db $A0, $0E ; volume $0E
    db $09, $10 ; note A0 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $09, $10 ; note A0 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $A0, $0E ; volume $0E
    db $0A, $10 ; note A#0 dur 16
    db $A0, $07 ; volume $07
    db $21, $20 ; note C#2 dur 32
    db $21, $10 ; note C#2 dur 16
    db $A0, $0E ; volume $0E
    db $0B, $10 ; note B0 dur 16
    db $A0, $07 ; volume $07
    db $19, $20 ; note A1 dur 32
    db $19, $10 ; note A1 dur 16
    db $A0, $0E ; volume $0E
    db $15, $10 ; note F1 dur 16
    db $A0, $07 ; volume $07
    db $19, $20 ; note A1 dur 32
    db $19, $10 ; note A1 dur 16
    db $A0, $0E ; volume $0E
    db $14, $10 ; note E1 dur 16
    db $A0, $07 ; volume $07
    db $18, $20 ; note G#1 dur 32
    db $18, $10 ; note G#1 dur 16
    db $A0, $0E ; volume $0E
    db $11, $10 ; note C#1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $12, $10 ; note D1 dur 16
    db $A0, $07 ; volume $07
    db $20, $20 ; note C2 dur 32
    db $20, $10 ; note C2 dur 16
    db $C1, $4F ; env $4F
    db $A0, $0B ; volume $0B
    db $17, $20 ; note G1 dur 32
    db $16, $20 ; note F#1 dur 32
    db $16, $20 ; note F#1 dur 32
    db $14, $20 ; note E1 dur 32
    db $12, $20 ; note D1 dur 32
    db $12, $20 ; note D1 dur 32
    db $10, $20 ; note C1 dur 32
    db $0B, $20 ; note B0 dur 32
    db $C1, $2F ; env $2F
    db $A0, $0E ; volume $0E
    db $04, $10 ; note E0 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $11, $10 ; note C#1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $12, $10 ; note D1 dur 16
    db $A0, $07 ; volume $07
    db $17, $20 ; note G1 dur 32
    db $17, $10 ; note G1 dur 16
    db $A0, $0E ; volume $0E
    db $12, $10 ; note D1 dur 16
    db $A0, $07 ; volume $07
    db $16, $20 ; note F#1 dur 32
    db $16, $10 ; note F#1 dur 16
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $A0, $0C ; volume $0C
    db $A3, $08 ; mod $08
    db $C2, $10 ; env $10
    db $1F, $10 ; rest-note $1F dur 16
    db $32, $10 ; note D3 dur 16
    db $32, $10 ; note D3 dur 16
    db $32, $10 ; note D3 dur 16
    db $C1, $70 ; env $70
    db $32, $10 ; note D3 dur 16
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $2B, $40 ; note B2 dur 64
    db $C1, $80 ; env $80
    db $A3, $20 ; mod $20
    db $2B, $40 ; note B2 dur 64
    db $B1, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $A3, $08 ; mod $08
    db $C2, $10 ; env $10
    db $1F, $10 ; rest-note $1F dur 16
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $C1, $70 ; env $70
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $34, $10 ; note E3 dur 16
    db $36, $10 ; note F#3 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $37, $40 ; note G3 dur 64
    db $C1, $80 ; env $80
    db $A3, $20 ; mod $20
    db $37, $40 ; note G3 dur 64
    db $A0, $0C ; volume $0C
    db $A3, $08 ; mod $08
    db $C2, $10 ; env $10
    db $1F, $10 ; rest-note $1F dur 16
    db $3B, $10 ; note B3 dur 16
    db $3B, $10 ; note B3 dur 16
    db $3B, $10 ; note B3 dur 16
    db $C1, $70 ; env $70
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $36, $10 ; note F#3 dur 16
    db $34, $10 ; note E3 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $32, $40 ; note D3 dur 64
    db $C1, $80 ; env $80
    db $A3, $20 ; mod $20
    db $32, $40 ; note D3 dur 64
    db $A0, $0C ; volume $0C
    db $A3, $08 ; mod $08
    db $C2, $10 ; env $10
    db $1F, $10 ; rest-note $1F dur 16
    db $42, $10 ; note D4 dur 16
    db $42, $10 ; note D4 dur 16
    db $42, $10 ; note D4 dur 16
    db $C1, $70 ; env $70
    db $42, $10 ; note D4 dur 16
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $42, $10 ; note D4 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $3B, $40 ; note B3 dur 64
    db $C1, $80 ; env $80
    db $A3, $20 ; mod $20
    db $3B, $40 ; note B3 dur 64
    db $A0, $0C ; volume $0C
    db $A3, $08 ; mod $08
    db $C2, $10 ; env $10
    db $1F, $10 ; rest-note $1F dur 16
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $C1, $70 ; env $70
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $35, $10 ; note F3 dur 16
    db $39, $10 ; note A3 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $37, $40 ; note G3 dur 64
    db $C1, $80 ; env $80
    db $A3, $20 ; mod $20
    db $37, $40 ; note G3 dur 64
    db $A2, $01 ; duty2 $01
    db $A3, $FE ; mod $FE
    db $FD, $F1 ; label 1
    db $C2, $10 ; env $10
    db $A7, $10 ; wait $10
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $32, $08 ; note D3 dur 8
    db $34, $08 ; note E3 dur 8
    db $B2, $F0 ; repeat $F0
    db $B6, $F1 ; repeat $F1
    db $32, $20 ; note D3 dur 32
    db $B0, $F2 ; jump $F2
    db $FF, $FF ; end

; sound track, 415 events after the header (E-0019: grammar C2, meaning C0)
Data_043_5EB3:: ; heuristic: track stream of a sound record; C0
    db $02, $00, $02, $0F ; header: param=2 byte1=$00 volume=$02 byte3=$0F
    db $FD, $F2 ; label 2
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $A3, $1F ; mod $1F
    db $A2, $75 ; duty2 $75
    db $3B, $11 ; note B3 dur 17
    db $40, $10 ; note C4 dur 16
    db $A2, $48 ; duty2 $48
    db $42, $5F ; note D4 dur 95
    db $B1, $F0 ; repeat $F0
    db $A2, $75 ; duty2 $75
    db $3B, $10 ; note B3 dur 16
    db $40, $10 ; note C4 dur 16
    db $A2, $A0 ; duty2 $A0
    db $42, $20 ; note D4 dur 32
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $A2, $8F ; duty2 $8F
    db $37, $20 ; note G3 dur 32
    db $A2, $A0 ; duty2 $A0
    db $34, $20 ; note E3 dur 32
    db $A2, $FF ; duty2 $FF
    db $A3, $1B ; mod $1B
    db $39, $20 ; note A3 dur 32
    db $A0, $04 ; volume $04
    db $A3, $10 ; mod $10
    db $39, $20 ; note A3 dur 32
    db $A0, $06 ; volume $06
    db $39, $1E ; note A3 dur 30
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $A3, $1F ; mod $1F
    db $A2, $75 ; duty2 $75
    db $40, $10 ; note C4 dur 16
    db $42, $10 ; note D4 dur 16
    db $A2, $48 ; duty2 $48
    db $44, $60 ; note E4 dur 96
    db $B1, $F0 ; repeat $F0
    db $A2, $A0 ; duty2 $A0
    db $40, $10 ; note C4 dur 16
    db $42, $10 ; note D4 dur 16
    db $44, $20 ; note E4 dur 32
    db $46, $10 ; note F#4 dur 16
    db $47, $10 ; note G4 dur 16
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $44, $10 ; note E4 dur 16
    db $A3, $1F ; mod $1F
    db $A2, $FF ; duty2 $FF
    db $3B, $40 ; note B3 dur 64
    db $A3, $10 ; mod $10
    db $A0, $04 ; volume $04
    db $3B, $1E ; note B3 dur 30
    db $1F, $02 ; rest-note $1F dur 2
    db $A2, $75 ; duty2 $75
    db $A0, $02 ; volume $02
    db $A3, $1F ; mod $1F
    db $3B, $20 ; note B3 dur 32
    db $A3, $FE ; mod $FE
    db $A2, $FF ; duty2 $FF
    db $4B, $3B ; note B4 dur 59
    db $A0, $04 ; volume $04
    db $A3, $15 ; mod $15
    db $4B, $25 ; note B4 dur 37
    db $A0, $02 ; volume $02
    db $A3, $1F ; mod $1F
    db $A2, $80 ; duty2 $80
    db $49, $10 ; note A4 dur 16
    db $47, $10 ; note G4 dur 16
    db $44, $10 ; note E4 dur 16
    db $46, $10 ; note F#4 dur 16
    db $42, $10 ; note D4 dur 16
    db $44, $10 ; note E4 dur 16
    db $A3, $19 ; mod $19
    db $A2, $30 ; duty2 $30
    db $3B, $20 ; note B3 dur 32
    db $1F, $01 ; rest-note $1F dur 1
    db $A2, $80 ; duty2 $80
    db $44, $20 ; note E4 dur 32
    db $A3, $FE ; mod $FE
    db $A2, $FF ; duty2 $FF
    db $50, $3B ; note C5 dur 59
    db $A0, $04 ; volume $04
    db $A3, $1A ; mod $1A
    db $50, $24 ; note C5 dur 36
    db $A0, $02 ; volume $02
    db $A3, $1F ; mod $1F
    db $A2, $80 ; duty2 $80
    db $4B, $10 ; note B4 dur 16
    db $49, $10 ; note A4 dur 16
    db $A2, $8F ; duty2 $8F
    db $47, $20 ; note G4 dur 32
    db $A2, $80 ; duty2 $80
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $A2, $30 ; duty2 $30
    db $42, $1F ; note D4 dur 31
    db $1F, $01 ; rest-note $1F dur 1
    db $A2, $80 ; duty2 $80
    db $42, $20 ; note D4 dur 32
    db $A3, $FE ; mod $FE
    db $A2, $FF ; duty2 $FF
    db $52, $40 ; note D5 dur 64
    db $A0, $04 ; volume $04
    db $A3, $18 ; mod $18
    db $52, $20 ; note D5 dur 32
    db $A2, $80 ; duty2 $80
    db $A0, $02 ; volume $02
    db $A3, $FE ; mod $FE
    db $50, $10 ; note C5 dur 16
    db $4B, $10 ; note B4 dur 16
    db $49, $10 ; note A4 dur 16
    db $47, $10 ; note G4 dur 16
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $A3, $19 ; mod $19
    db $A2, $38 ; duty2 $38
    db $3B, $11 ; note B3 dur 17
    db $A2, $28 ; duty2 $28
    db $44, $1F ; note E4 dur 31
    db $A2, $38 ; duty2 $38
    db $39, $10 ; note A3 dur 16
    db $A2, $28 ; duty2 $28
    db $42, $20 ; note D4 dur 32
    db $A2, $38 ; duty2 $38
    db $37, $10 ; note G3 dur 16
    db $A2, $28 ; duty2 $28
    db $40, $20 ; note C4 dur 32
    db $A2, $38 ; duty2 $38
    db $36, $10 ; note F#3 dur 16
    db $A2, $28 ; duty2 $28
    db $3B, $20 ; note B3 dur 32
    db $A2, $80 ; duty2 $80
    db $34, $20 ; note E3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $A2, $FF ; duty2 $FF
    db $37, $41 ; note G3 dur 65
    db $A0, $04 ; volume $04
    db $A3, $13 ; mod $13
    db $37, $20 ; note G3 dur 32
    db $A2, $80 ; duty2 $80
    db $A0, $02 ; volume $02
    db $A3, $19 ; mod $19
    db $39, $10 ; note A3 dur 16
    db $3B, $10 ; note B3 dur 16
    db $A2, $FF ; duty2 $FF
    db $39, $40 ; note A3 dur 64
    db $A0, $04 ; volume $04
    db $A3, $13 ; mod $13
    db $39, $20 ; note A3 dur 32
    db $A0, $06 ; volume $06
    db $39, $1F ; note A3 dur 31
    db $A2, $04 ; duty2 $04
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $B9, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $15, $08 ; note F1 dur 8
    db $A0, $04 ; volume $04
    db $15, $08 ; note F1 dur 8
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $15, $08 ; note F1 dur 8
    db $A0, $04 ; volume $04
    db $15, $08 ; note F1 dur 8
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $15, $08 ; note F1 dur 8
    db $A0, $04 ; volume $04
    db $15, $08 ; note F1 dur 8
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $12, $08 ; note D1 dur 8
    db $A0, $04 ; volume $04
    db $12, $08 ; note D1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $26, $08 ; note F#2 dur 8
    db $A0, $06 ; volume $06
    db $26, $08 ; note F#2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $26, $08 ; note F#2 dur 8
    db $A0, $06 ; volume $06
    db $26, $08 ; note F#2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $15, $08 ; note F1 dur 8
    db $A0, $04 ; volume $04
    db $15, $08 ; note F1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $06 ; volume $06
    db $2B, $08 ; note B2 dur 8
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $A1, $02 ; duty $02
    db $A2, $04 ; duty2 $04
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $B1, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $18 ; duty2 $18
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $1F, $10 ; rest-note $1F dur 16
    db $B0, $F2 ; jump $F2
    db $FF, $FF ; end

; sound track, 27 events after the header (E-0019: grammar C2, meaning C0)
Data_043_61F5:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $63, $04 ; note D#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $70, $04 ; note C7 dur 4
    db $60, $04 ; note C6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $60, $04 ; note C6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $61, $04 ; note C#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $60, $04 ; note C6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $A0, $08 ; volume $08
    db $61, $04 ; note C#6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $A0, $05 ; volume $05
    db $64, $04 ; note E6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $A0, $02 ; volume $02
    db $60, $04 ; note C6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $68, $02 ; note G#6 dur 2
    db $1F, $18 ; rest-note $1F dur 24
    db $FF, $FF ; end

; sound track, 31 events after the header (E-0019: grammar C2, meaning C0)
Data_043_622F:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $08, $00 ; header: param=0 byte1=$01 volume=$08 byte3=$00
    db $1F, $07 ; rest-note $1F dur 7
    db $63, $04 ; note D#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $70, $04 ; note C7 dur 4
    db $60, $04 ; note C6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $60, $04 ; note C6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $61, $04 ; note C#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $60, $04 ; note C6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $A0, $08 ; volume $08
    db $61, $04 ; note C#6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $66, $04 ; note F#6 dur 4
    db $A0, $05 ; volume $05
    db $64, $04 ; note E6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $A0, $02 ; volume $02
    db $60, $04 ; note C6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $63, $04 ; note D#6 dur 4
    db $A0, $01 ; volume $01
    db $68, $04 ; note G#6 dur 4
    db $60, $04 ; note C6 dur 4
    db $68, $04 ; note G#6 dur 4
    db $1F, $07 ; rest-note $1F dur 7
    db $FF, $FF ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6271:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $36 ; header: param=0 byte1=$02 volume=$0F byte3=$36
    db $13, $06 ; note D#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $18, $06 ; note G#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $1A, $06 ; note A#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $22, $06 ; note D2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $27, $06 ; note G2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $34, $06 ; note E3 dur 6
    db $A0, $08 ; volume $08
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $05 ; note E3 dur 5
    db $FF, $FF ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6299:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $09, $00 ; header: param=0 byte1=$02 volume=$09 byte3=$00
    db $13, $06 ; note D#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $18, $06 ; note G#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $1A, $06 ; note A#1 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $22, $06 ; note D2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $27, $06 ; note G2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $03 ; volume $03
    db $34, $06 ; note E3 dur 6
    db $A0, $02 ; volume $02
    db $34, $05 ; note E3 dur 5
    db $FF, $FF ; end

; sound track, 32 events after the header (E-0019: grammar C2, meaning C0)
Data_043_62C1:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C2, $40 ; env $40
    db $A0, $0D ; volume $0D
    db $15, $0A ; note F1 dur 10
    db $C1, $28 ; env $28
    db $A0, $0C ; volume $0C
    db $29, $0A ; note A2 dur 10
    db $A0, $0A ; volume $0A
    db $29, $0A ; note A2 dur 10
    db $30, $0A ; note C3 dur 10
    db $A0, $08 ; volume $08
    db $30, $0A ; note C3 dur 10
    db $2A, $0A ; note A#2 dur 10
    db $2A, $0A ; note A#2 dur 10
    db $29, $0A ; note A2 dur 10
    db $C1, $14 ; env $14
    db $A0, $0F ; volume $0F
    db $29, $09 ; note A2 dur 9
    db $A0, $0B ; volume $0B
    db $29, $09 ; note A2 dur 9
    db $A0, $07 ; volume $07
    db $29, $09 ; note A2 dur 9
    db $A0, $05 ; volume $05
    db $29, $09 ; note A2 dur 9
    db $A0, $03 ; volume $03
    db $29, $09 ; note A2 dur 9
    db $A0, $02 ; volume $02
    db $29, $0A ; note A2 dur 10
    db $A0, $01 ; volume $01
    db $29, $0A ; note A2 dur 10
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end
    db $FF, $FF ; end

; sound track, 28 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6305:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0D, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $C2, $40 ; env $40
    db $1F, $0A ; rest-note $1F dur 10
    db $35, $0A ; note F3 dur 10
    db $A0, $0B ; volume $0B
    db $35, $0A ; note F3 dur 10
    db $34, $0A ; note E3 dur 10
    db $A0, $0A ; volume $0A
    db $34, $0A ; note E3 dur 10
    db $32, $0A ; note D3 dur 10
    db $32, $0A ; note D3 dur 10
    db $30, $0A ; note C3 dur 10
    db $C1, $14 ; env $14
    db $A0, $0F ; volume $0F
    db $32, $09 ; note D3 dur 9
    db $A0, $0B ; volume $0B
    db $32, $09 ; note D3 dur 9
    db $A0, $08 ; volume $08
    db $32, $09 ; note D3 dur 9
    db $A0, $05 ; volume $05
    db $32, $09 ; note D3 dur 9
    db $A0, $03 ; volume $03
    db $32, $09 ; note D3 dur 9
    db $A0, $02 ; volume $02
    db $32, $0A ; note D3 dur 10
    db $A0, $01 ; volume $01
    db $32, $0A ; note D3 dur 10
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end

; sound track, 23 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6341:: ; heuristic: track stream of a sound record; C0
    db $00, $30, $02, $02 ; header: param=0 byte1=$30 volume=$02 byte3=$02
    db $A2, $70 ; duty2 $70
    db $A1, $09 ; duty $09
    db $15, $0A ; note F1 dur 10
    db $A1, $02 ; duty $02
    db $A2, $1F ; duty2 $1F
    db $30, $0A ; note C3 dur 10
    db $30, $0A ; note C3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $A2, $0A ; duty2 $0A
    db $A0, $02 ; volume $02
    db $36, $09 ; note F#3 dur 9
    db $A0, $04 ; volume $04
    db $36, $09 ; note F#3 dur 9
    db $A0, $06 ; volume $06
    db $36, $09 ; note F#3 dur 9
    db $A0, $06 ; volume $06
    db $36, $05 ; note F#3 dur 5
    db $1F, $35 ; rest-note $1F dur 53
    db $FF, $FF ; end

; sound track, 26 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6373:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $60, $0E ; note C6 dur 14
    db $A0, $06 ; volume $06
    db $60, $0B ; note C6 dur 11
    db $A0, $0F ; volume $0F
    db $11, $02 ; note C#1 dur 2
    db $45, $03 ; note F4 dur 3
    db $15, $01 ; note F1 dur 1
    db $50, $03 ; note C5 dur 3
    db $45, $03 ; note F4 dur 3
    db $16, $01 ; note F#1 dur 1
    db $45, $02 ; note F4 dur 2
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $45, $03 ; note F4 dur 3
    db $46, $04 ; note F#4 dur 4
    db $45, $06 ; note F4 dur 6
    db $A0, $06 ; volume $06
    db $45, $05 ; note F4 dur 5
    db $A0, $04 ; volume $04
    db $45, $05 ; note F4 dur 5
    db $45, $03 ; note F4 dur 3
    db $A0, $03 ; volume $03
    db $45, $03 ; note F4 dur 3
    db $FF, $FF ; end

; sound track, 30 events after the header (E-0019: grammar C2, meaning C0)
Data_043_63AB:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $3D ; header: param=0 byte1=$02 volume=$0F byte3=$3D
    db $AE, $10 ; tuning $10
    db $C2, $09 ; env $09
    db $A0, $05 ; volume $05
    db $54, $05 ; note E5 dur 5
    db $54, $05 ; note E5 dur 5
    db $A0, $08 ; volume $08
    db $55, $05 ; note F5 dur 5
    db $55, $05 ; note F5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $A0, $0C ; volume $0C
    db $56, $05 ; note F#5 dur 5
    db $A0, $0F ; volume $0F
    db $53, $05 ; note D#5 dur 5
    db $43, $05 ; note D#4 dur 5
    db $A0, $0A ; volume $0A
    db $53, $05 ; note D#5 dur 5
    db $54, $05 ; note E5 dur 5
    db $54, $05 ; note E5 dur 5
    db $55, $05 ; note F5 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $04 ; volume $04
    db $55, $05 ; note F5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $A0, $02 ; volume $02
    db $46, $05 ; note F#4 dur 5
    db $56, $05 ; note F#5 dur 5
    db $A0, $01 ; volume $01
    db $56, $05 ; note F#5 dur 5
    db $56, $05 ; note F#5 dur 5
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_043_63EB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1E, $02 ; rest-note $1E dur 2
    db $23, $02 ; note D#2 dur 2
    db $31, $04 ; note C#3 dur 4
    db $12, $05 ; note D1 dur 5
    db $13, $05 ; note D#1 dur 5
    db $C7, $20 ; env $20
    db $30, $10 ; note C3 dur 16
    db $C0, $FE ; env $FE
    db $10, $10 ; note C1 dur 16
    db $A0, $05 ; volume $05
    db $C7, $30 ; env $30
    db $20, $20 ; note C2 dur 32
    db $FF, $FF ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
Data_043_6409:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $CC, $02 ; env $02
    db $40, $10 ; note C4 dur 16
    db $C1, $50 ; env $50
    db $50, $23 ; note C5 dur 35
    db $32, $02 ; note D3 dur 2
    db $A0, $06 ; volume $06
    db $40, $15 ; note C4 dur 21
    db $FF, $FF ; end

; sound track, 118 events after the header (E-0019: grammar C2, meaning C0)
Data_043_641D:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $1F, $24 ; rest-note $1F dur 36
    db $A5, $0F ; pan $0F
    db $FD, $F0 ; label 0
    db $C2, $68 ; env $68
    db $A0, $08 ; volume $08
    db $65, $05 ; note F6 dur 5
    db $76, $05 ; note F#7 dur 5
    db $69, $05 ; note A6 dur 5
    db $67, $05 ; note G6 dur 5
    db $A0, $0A ; volume $0A
    db $68, $05 ; note G#6 dur 5
    db $76, $05 ; note F#7 dur 5
    db $65, $05 ; note F6 dur 5
    db $75, $05 ; note F7 dur 5
    db $69, $05 ; note A6 dur 5
    db $67, $05 ; note G6 dur 5
    db $A0, $0C ; volume $0C
    db $65, $05 ; note F6 dur 5
    db $75, $05 ; note F7 dur 5
    db $69, $05 ; note A6 dur 5
    db $67, $05 ; note G6 dur 5
    db $A0, $08 ; volume $08
    db $68, $05 ; note G#6 dur 5
    db $76, $05 ; note F#7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $68, $05 ; note G#6 dur 5
    db $75, $05 ; note F7 dur 5
    db $A0, $0E ; volume $0E
    db $68, $05 ; note G#6 dur 5
    db $76, $05 ; note F#7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $68, $05 ; note G#6 dur 5
    db $B2, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $69, $05 ; note A6 dur 5
    db $77, $05 ; note G7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $A0, $0F ; volume $0F
    db $68, $05 ; note G#6 dur 5
    db $75, $05 ; note F7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $A0, $07 ; volume $07
    db $68, $05 ; note G#6 dur 5
    db $75, $05 ; note F7 dur 5
    db $69, $05 ; note A6 dur 5
    db $77, $05 ; note G7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $A0, $04 ; volume $04
    db $68, $05 ; note G#6 dur 5
    db $75, $05 ; note F7 dur 5
    db $69, $05 ; note A6 dur 5
    db $77, $05 ; note G7 dur 5
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $A0, $03 ; volume $03
    db $68, $05 ; note G#6 dur 5
    db $75, $05 ; note F7 dur 5
    db $69, $05 ; note A6 dur 5
    db $77, $05 ; note G7 dur 5
    db $A0, $02 ; volume $02
    db $65, $05 ; note F6 dur 5
    db $78, $05 ; note G#7 dur 5
    db $1F, $10 ; rest-note $1F dur 16
    db $1F, $87 ; rest-note $1F dur 135
    db $AF, $03 ; param $03
    db $A5, $FF ; pan $FF
    db $C2, $1F ; env $1F
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $66, $05 ; note F#6 dur 5
    db $64, $05 ; note E6 dur 5
    db $65, $05 ; note F6 dur 5
    db $73, $05 ; note D#7 dur 5
    db $62, $05 ; note D6 dur 5
    db $72, $05 ; note D7 dur 5
    db $66, $05 ; note F#6 dur 5
    db $64, $05 ; note E6 dur 5
    db $A0, $0E ; volume $0E
    db $65, $05 ; note F6 dur 5
    db $73, $05 ; note D#7 dur 5
    db $62, $05 ; note D6 dur 5
    db $75, $05 ; note F7 dur 5
    db $65, $05 ; note F6 dur 5
    db $72, $05 ; note D7 dur 5
    db $A0, $0F ; volume $0F
    db $65, $05 ; note F6 dur 5
    db $72, $05 ; note D7 dur 5
    db $66, $05 ; note F#6 dur 5
    db $74, $05 ; note E7 dur 5
    db $A0, $08 ; volume $08
    db $62, $05 ; note D6 dur 5
    db $75, $05 ; note F7 dur 5
    db $A0, $07 ; volume $07
    db $65, $05 ; note F6 dur 5
    db $72, $05 ; note D7 dur 5
    db $66, $05 ; note F#6 dur 5
    db $74, $05 ; note E7 dur 5
    db $62, $05 ; note D6 dur 5
    db $75, $05 ; note F7 dur 5
    db $A0, $03 ; volume $03
    db $65, $05 ; note F6 dur 5
    db $72, $05 ; note D7 dur 5
    db $66, $05 ; note F#6 dur 5
    db $74, $05 ; note E7 dur 5
    db $A0, $02 ; volume $02
    db $65, $05 ; note F6 dur 5
    db $72, $05 ; note D7 dur 5
    db $66, $05 ; note F#6 dur 5
    db $74, $05 ; note E7 dur 5
    db $A0, $01 ; volume $01
    db $62, $05 ; note D6 dur 5
    db $75, $05 ; note F7 dur 5
    db $FF, $FF ; end

Data_043_650D:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10E50D, $102
    ds $19F1, $00
