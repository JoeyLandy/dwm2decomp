SECTION "Bank 07", ROMX[$4000], BANK[$07]
    db $07

; ld de, this bank's string table / BeginStringDisplay
; 20 call sites from 11 routines (e.g. ShowString_Bank07, GameMode0_Update, Func_007_512B, Func_007_60E9, ...)
BeginStringDisplay_Bank07::
Func_007_4001:: ; address name
    ld de, $4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_007_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 11 call sites from 8 routines (e.g. Func_003_74E2, GameMode5_Init, Func_007_513A, Func_007_6213, ...)
ShowString_Bank07::
Func_007_400F:: ; address name
    call BeginStringDisplay_Bank07
    call RunStringDisplayToEnd
    ret
    dw Data_007_4024
    dw Data_007_4034
    dw Data_007_4040
    dw Data_007_4042
    dw Data_007_4050
    dw Data_007_4056
    dw Data_007_408C

Data_007_4024:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_409E
    dw Data_007_40A3
    dw Data_007_40C1
    dw Data_007_4101
    dw Data_007_411C
    dw Data_007_4123
    dw Data_007_415A
    dw Data_007_4164

Data_007_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_4195
    dw Data_007_419F
    dw Data_007_41A3
    dw Data_007_41B4
    dw Data_007_41DF
    dw Data_007_41E8

Data_007_4040:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_41F1

Data_007_4042:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_41FD
    dw Data_007_422D
    dw Data_007_4252
    dw Data_007_4269
    dw Data_007_4284
    dw Data_007_42A1
    dw Data_007_42BF

Data_007_4050:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_42DE
    dw Data_007_42F8
    dw Data_007_430F

Data_007_4056:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_4327
    dw Data_007_4346
    dw Data_007_438E
    dw Data_007_43AC
    dw Data_007_43CB
    dw Data_007_43EC
    dw Data_007_441E
    dw Data_007_4450
    dw Data_007_4492
    dw Data_007_44B6
    dw Data_007_44D1
    dw Data_007_44F1
    dw Data_007_4510
    dw Data_007_451D
    dw Data_007_4532
    dw Data_007_4566
    dw Data_007_4589
    dw Data_007_45A8
    dw Data_007_45C9
    dw Data_007_45E9
    dw Data_007_4604
    dw Data_007_4619
    dw Data_007_462E
    dw Data_007_463E
    dw Data_007_4685
    dw Data_007_46BA
    dw Data_007_46F5

Data_007_408C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_007_470A
    dw Data_007_4724
    dw Data_007_473E
    dw Data_007_4758
    dw Data_007_4773
    dw Data_007_478F
    dw Data_007_47AA
    dw Data_007_47E7
    dw Data_007_482A

Data_007_409E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ENIX", $F0

Data_007_40A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DRAGON WARRIOR", $F1
    db "   MONSTERS 2 ", $F0

Data_007_40C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CONTINUE NEW GAME BREEDING KEY TRADEVS MODE  TEAM MODETERRY "
    db "   ", $F0

Data_007_4101:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saved data has", $F1
    db "been lost.", $F7
    db $F0

Data_007_411C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Master", $F0

Data_007_4123:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Game Link", $F1
    db "is not ready.", $FA, $F7
    db $F2, "Please check", $F1
    db "and try again.", $F7
    db $F0

Data_007_415A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DREAM EGG", $F0

Data_007_4164:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Game Link cannot", $F1
    db "be used with", $FA, $F7
    db $F2, "Super Game Boy.", $F7
    db $F0

Data_007_4195:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DuoOwnWL", $A3, $F0

Data_007_419F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yes", $F0

Data_007_41A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kill A", $F1
    db $E8, $07, $01, $17, $28, $3B, $37, $90, $0B, $F0

Data_007_41B4:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $0E, $1C, $1E, $15, $1D, $1C, $0D, $38, $32, $20, $A2, $15, $28, $39, $28
    db $2F, $1D, $38, $35, $31, $36, $20, $2C, $31, $92
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RankOwnWDuoLOwnL", $F0

Data_007_41DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GFDEBCAS", $F0

Data_007_41E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GFEDCBAS", $F0

Data_007_41F1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Trade keys.", $F0

Data_007_41FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FREE BATTLE", $F1
    db "ENIX RULES ", $F1
    db "LOCAL RULES", $F1
    db "EXIT       ", $F0

Data_007_422D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ABEFILNORSTXYaceghiklmnrtuvxyKMDposb", $F0

Data_007_4252:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Refused the VS", $F1
    db "battle.", $F0

Data_007_4269:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The VS battle was", $F1
    db "refused.", $F0

Data_007_4284:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choosing rules.", $F1
    db "Please wait.", $F0

Data_007_42A1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Receiving rules.", $F1
    db "Please wait.", $F0

Data_007_42BF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confirming rules.", $F1
    db "Please wait.", $F0

Data_007_42DE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Play the boy's", $F1
    db "adventure?"
    db $FF, $F0

Data_007_42F8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enter the boy's", $F1
    db "name.", $FA, $F7
    db $F0

Data_007_430F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enter the girl's", $F1
    db "name.", $FA, $F7
    db $F0

Data_007_4327:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not enough money.", $F1
    db "Please wait.", $F0

Data_007_4346:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal doesn't", $F1
    db "have enough gold.", $FA, $F7
    db $F2, "Will you pay the", $F1
    db "1000G battle fee?"
    db $FF, $F0

Data_007_438E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You paid for both", $F1
    db "combatants.", $F0

Data_007_43AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal paid your", $F1
    db "battle fee.", $F0

Data_007_43CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Insufficient gold", $F1
    db "for Team Mode.", $F0

Data_007_43EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to pay", $F1
    db "the battle fee for", $FA, $F7
    db $F2, "your pal.", $F0

Data_007_441E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to pay the battle", $FA, $F7
    db $F2, "fee for you.", $F0

Data_007_4450:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You paid the 1000G", $F1
    db "battle fee.", $FA, $F7
    db $F2, "You can now battle", $F1
    db "in Team Mode.", $F0

Data_007_4492:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose a monster", $F1
    db "for the Team Mode.", $F0

Data_007_44B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused the", $F1
    db "Team Mode.", $F0

Data_007_44D1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "the Team Mode.", $F0

Data_007_44F1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Send your monster", $F1
    db "into battle?", $F0

Data_007_4510:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

Data_007_451D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battle in Team", $F1
    db "Mode?", $F0

Data_007_4532:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The battle results", $F1
    db "will be recorded.", $FA, $F7
    db $F2, "Is that OK?"
    db $FF, $F0

Data_007_4566:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "both have won.", $FA, $F7
    db $F0

Data_007_4589:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "alone won.", $FA, $F7
    db $F0

Data_007_45A8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "both lost."
    db $E5
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $42, $FA, $F7
    db $F0

Data_007_45C9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "alone lost.", $FA, $F7
    db $F0

Data_007_45E9:: ; heuristic: target of a monotone pointer table; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " obtained an", $F1
    db "egg of ", $F9, "0.", $FA, $F7
    db $F0

Data_007_4604:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's ", $F9, "G", $F1
    db "rose by ", $F9, "W.", $FA, $F7
    db $F0

Data_007_4619:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's ", $F9, "G", $F1
    db "fell by ", $F9, "W.", $FA, $F7
    db $F0

Data_007_462E:: ; heuristic: target of a monotone pointer table; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " received", $F1
    db $F9, "WG.", $F0

Data_007_463E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no room", $F1
    db "for more monsters.", $FA, $F7
    db $F2, "Switch it with", $F1
    db "another monster?"
    db $FF, $F0

Data_007_4685:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "With no room for", $F1
    db "it , ", $F9, "0 was", $FA, $F7
    db $F2, "released in the", $F1
    db "wild.", $F0

Data_007_46BA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "For Team Mode,", $F1
    db "1000G is charged.", $FA, $F7
    db $F2, "Will you pay this", $F1
    db "fee?"
    db $FF, $F0

Data_007_46F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saving", $A4, $F1
    db "Please wait.", $F0

Data_007_470A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode battle", $F1
    db "No. 1!", $FA, $F7
    db $F0

Data_007_4724:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode battle", $F1
    db "No. 2!", $FA, $F7
    db $F0

Data_007_473E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode final", $F1
    db "battle!", $FA, $F7
    db $F0

Data_007_4758:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The first monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

Data_007_4773:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The second monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

Data_007_478F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The third monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

Data_007_47AA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "You", $42, "e cleared", $F1
    db "Round 1!", $FA, $F7
    db $F0

Data_007_47E7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "There's just one", $F1
    db "round to go!", $FA, $F7
    db $F0

Data_007_482A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "You", $42, "e won the", $F1
    db "tournament!"
    db $E5, $00, $E4, $7E, $FA, $F7, $F0

; start-up for wGameMode = 5; forcing this mode on the emulator shows: title screen; also sparkles and a victory screen when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit)
; reads: wModeState
; writes: wC554, wC555, wC58C
; points at: wC46B, wC52D, wD06A
GameMode5_Init::
Func_007_486E:: ; address name
    xor a, a
    ld hl, wC46B
    ld bc, $0008
    call FillBytes
    xor a, a
    ld hl, wC52D
    ld bc, $0012
    call FillBytes
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    xor a, a
    ld hl, wD06A
    ld bc, $0008
    call FillBytes
    call Func_000_08A6
    xor a, a
    ld [wC58C], a
    ld a, [wModeState]
    rst $00
    dw Jump_007_48B2
    dw Jump_007_4952
    dw Jump_007_4B45
    dw Jump_007_4C24
    dw Jump_007_4CFF
    dw Jump_007_4E20
    dw Jump_007_4E37
    dw Jump_007_4E20

Jump_007_48B2::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_48C8
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_421A
    jr Jump_007_48F3

Jump_007_48C8::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_48F3
    ld b, $40
    ld hl, wC49F

Jump_007_48D3::
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    dec b
    jr nz, Jump_007_48D3
    ld a, $7F
    ld [wC526], a
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a, a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

Jump_007_48F3::
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    xor a, a
    ld hl, wC5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, $C3
    ld hl, vBGMap0
    ld bc, $0800
    call FillBytes
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $00
    ldh [hScrollY], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC581], a
    ld [wC582], a
    xor a, a
    ld [wC58A], a
    xor a, a
    ld [wC58B], a
    xor a, a
    ld [wC57F], a
    ld [wC580], a
    ld a, $03
    ld [wC5EC], a
    ld a, $01
    jp Jump_000_077A

Jump_007_4952::
    call InitSoundHardware
    xor a, a
    ld hl, wD09D
    ld bc, $0210
    call FillBytes
    xor a, a
    ld hl, wC57F
    ld bc, $0058
    call FillBytes
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4985
    ld a, $02
    call Func_000_13E5
    call SpinDelay
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_41CF

Jump_007_4985::
    ld a, $FC
    call StartPaletteFade
    ld hl, hFF8A
    ld bc, $000E
    xor a, a
    call FillBytes
    ld hl, wC60C
    ld bc, $0291
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sBD97]
    or a, a
    jr z, Jump_007_49B3
    cp a, $01
    jr z, Jump_007_49B3
    xor a, a

Jump_007_49B3::
    ld [wC894], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ld hl, wCBD7
    ld bc, $006B
    xor a, a
    call FillBytes
    ld hl, wCC42
    ld bc, $00B5
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $006F
    xor a, a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    xor a, a
    ld [rRAMG], a
    ld a, $04
    ld [wC834], a
    ld a, $01
    ld [wC964], a
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vTiles2
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld hl, vTiles2 + $700
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4A68
    ld a, $01
    ldh [rVBK], a
    ld d, $00
    call Func_007_4AE4
    call Func_007_4B1E
    xor a, a
    ldh [rVBK], a

Jump_007_4A68::
    ld d, $C3
    call Func_007_4AE4
    call Func_007_4B1E
    farcall Func_002_706E
    ldh a, [hFFC6]
    ld [wD06A], a
    or a, a
    jr z, Jump_007_4A9B
    ld hl, $5149
    add a, a
    add_a_to_hl
    deref_hl
    call Func_007_4AFE
    call Func_007_4B1E
    ld a, [wD06A]
    cp a, $01
    jr z, Jump_007_4A9B
    ld a, $02
    jr Jump_007_4A9D

Jump_007_4A9B::
    ld a, $09

Jump_007_4A9D::
    call QueueMusic
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $07
    ldh [hFF9F], a
    ld a, $00
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC581], a
    ld [wC582], a
    xor a, a
    ld [wC58A], a
    xor a, a
    ld [wC58B], a
    xor a, a
    ld [wC57F], a
    ld [wC580], a
    ld a, $03
    ld [wC5EC], a
    ld a, $09
    jp Jump_000_077A

; 5 call sites from 4 routines (e.g. GameMode5_Init, Func_007_6DE3, Func_007_7807, Func_007_7C5F)
; points at: wScreenTileBuffer
Func_007_4AE4::
    ld hl, wScreenTileBuffer
    ld bc, $1412
    ld a, d

Jump_007_4AEB::
    ld [hl+], a
    dec b
    jr nz, Jump_007_4AEB
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    ld b, $14
    dec c
    jr nz, Jump_007_4AEB
    ret

; 19 call sites from 12 routines (e.g. Func_007_4B27, GameMode5_Init, Func_007_65F1, Func_007_60E9, ...)
; points at: wScreenTileBuffer
Func_007_4AFE::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de

Jump_007_4B0C::
    push bc
    push hl

Jump_007_4B0E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_007_4B0E
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_007_4B0C
    ret

; 12 call sites from 9 routines (e.g. Func_007_4B27, GameMode5_Init, Func_007_7807, Func_007_60E9, ...)
; points at: wScreenTileBuffer
Func_007_4B1E::
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

; 10 call sites from 8 routines (e.g. Func_007_65F1, Func_007_60E9, Func_007_6DE3, Func_007_7724, ...)
Func_007_4B27::
    push bc
    push de
    push hl

Jump_007_4B2A::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_4B2A
    pop hl
    ld bc, $0020
    add hl, bc
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Func_007_4B27
    ret

Jump_007_4B45::
    ld hl, wD780
    ld bc, $006F

Jump_007_4B4B::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4B4B
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4B6F
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_41CF
    jr Jump_007_4B7B

Jump_007_4B6F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4B7B
    farcall Func_001_4AA4

Jump_007_4B7B::
    farcall Func_002_717D
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_007_4B7B
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_007_4B95
    farcall Func_060_6CD1

Jump_007_4B95::
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall Func_0F1_4AA8
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a

Jump_007_4BC4::
    farcall Func_002_69D0
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_007_4BC4
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wD06A
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $02
    ldh [hFFB9], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ld a, $03
    ld [wC5EC], a
    ld a, $09
    jp Jump_000_077A

Jump_007_4C24::
    ld hl, wD780
    ld bc, $006F

Jump_007_4C2A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4C2A
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4C4E
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_41CF
    jr Jump_007_4C5A

Jump_007_4C4E::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4C5A
    farcall Func_001_4AA4

Jump_007_4C5A::
    farcall Func_002_717D
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_007_4C5A
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_007_4C74
    farcall Func_060_6CD1

Jump_007_4C74::
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall Func_0F1_4AA8
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a

Jump_007_4CA3::
    farcall Func_002_69D0
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_007_4CA3
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wD06A
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ld a, $03
    ld [wC5EC], a
    ld a, $09
    jp Jump_000_077A

Jump_007_4CFF::
    call Func_007_4DEC
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4D1F
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_41CF
    jr Jump_007_4D2B

Jump_007_4D1F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4D2B
    farcall Func_001_4AA4

Jump_007_4D2B::
    farcall Func_002_717D
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_007_4D2B
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_007_4D45
    farcall Func_060_6CD1

Jump_007_4D45::
    ld a, $FC
    call StartPaletteFade
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    ld hl, vTiles2 + $400
    ld de, $0B04
    call FillTilesRequest
    ld hl, $0300
    call Func_007_513A
    ld a, $00
    ld [wD09E], a
    farcall Func_016_7A5B
    ld hl, vTiles2 + $B0
    ld de, $2501
    call FillTilesRequest
    ld hl, $0301
    call Func_007_513A
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, $5447
    call Func_007_4AFE
    call Func_007_4B1E
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wD06A
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ld a, $03
    ld [wC5EC], a
    ld a, $09
    jp Jump_000_077A

; 1 call site from 1 routine (e.g. Func_007_4B27)
; reads: wD059
; points at: wD043, wD04D
Func_007_4DEC::
    ld a, [wD059]
    cp a, $02
    jr z, Jump_007_4DF8
    ld hl, $4E07
    jr Jump_007_4DFB

Jump_007_4DF8::
    ld hl, wD04D

Jump_007_4DFB::
    ld de, wD043
    ld b, $0A

Jump_007_4E00::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E00
    ret
    db $01, $00, $00, $63, $29, $01, $00, $00, $63, $80

; 2 call sites from 2 routines (e.g. Func_007_6DE3, Func_007_7807)
; points at: wD043, wD04D
Func_007_4E11::
    ld hl, wD043
    ld de, wD04D
    ld b, $0A

Jump_007_4E19::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E19
    ret

Jump_007_4E20::
    ld hl, vTiles0
    ld bc, $0C00
    xor a, a

Jump_007_4E27::
    di

Jump_007_4E28::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_4E28
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4E27

Jump_007_4E37::
    ld hl, wD780
    ld bc, $006F

Jump_007_4E3D::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_4E3D
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4E5F
    ld hl, wC51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall Func_017_41CF
    jr Jump_007_4E6B

Jump_007_4E5F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4E6B
    farcall Func_001_4AA4

Jump_007_4E6B::
    farcall Func_002_717D
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_007_4E6B
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_007_4E85
    farcall Func_060_6CD1

Jump_007_4E85::
    ld hl, vBGMap0
    ld bc, $1412

Jump_007_4E8B::
    ld a, $C3

Jump_007_4E8D::
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_4E8D
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, Jump_007_4E8B
    call Func_007_4F29
    farcall Func_012_64F8
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall Func_0F1_4AA8
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a

Jump_007_4ED6::
    farcall Func_002_69D0
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_007_4ED6
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wD06A
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wC5E1], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ld a, $03
    ld [wC5EC], a
    ld a, $09
    jp Jump_000_077A

; 1 call site from 1 routine (e.g. Func_007_4E11)
; reads: wC6FD, hFFC6, hFFC7
; writes: rRAMG
; points at: wC6FE, wC972
Func_007_4F29::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, wC972

Jump_007_4F38::
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [de], a
    inc de
    ldh a, [hFFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [de], a
    inc de
    ldh a, [hFFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_4F38
    xor a, a
    ld [rRAMG], a
    ld a, [wC6FD]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

; per-frame routine for wGameMode = 5
; 1 call site from 1 routine (e.g. RunGameModeUpdate)
; reads: wModeState
GameMode5_Update::
Func_007_4F7B:: ; address name
    ld a, [wModeState]
    rst $00
    dw Jump_007_5902
    dw Jump_007_6090
    dw Jump_007_6AEE
    dw Jump_007_6BB7
    dw Jump_007_6BC3
    dw Jump_007_4F8F
    dw Jump_007_4F8F
    dw Jump_007_4F96

Jump_007_4F8F::
    farcall Func_033_51C6
    ret

Jump_007_4F96::
    farcall Func_0F1_5AD5
    ret

; 6 call sites from 5 routines (e.g. Func_007_65A7, Func_007_6C59, Func_007_60E9, Func_007_7270, ...)
; reads: wFrameCounterLo, wC46F, wJoypadPressedRepeat
; writes: wFrameCounterLo
Func_007_4F9D::
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_007_4FB3
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_4FB0
    call Func_007_5066
    jr Jump_007_4FB3

Jump_007_4FB0::
    call Func_007_5046

Jump_007_4FB3::
    ld a, [wC46F]
    cp a, $01
    jr z, Jump_007_4FE4
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_007_4FD0
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_4FE5
    ld a, [wC46F]
    dec a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FD0::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_007_4FE4
    ld a, [wC46F]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_4FE5
    xor a, a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FE4::
    ret

Jump_007_4FE5::
    xor a, a
    ld [wFrameCounterLo], a
    call Func_007_5067
    ld a, $69
    call QueueSoundEffect
    call Func_007_5046
    ret

; 15 call sites from 7 routines (e.g. Func_007_7807, Func_007_7724, Func_007_7594, Func_007_7270, ...)
; reads: wFrameCounterLo, wJoypadPressedRepeat, wC470
; writes: wFrameCounterLo
Func_007_4FF5::
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_007_500B
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_5008
    call Func_007_5066
    jr Jump_007_500B

Jump_007_5008::
    call Func_007_5046

Jump_007_500B::
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_5021
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_5036
    ld a, [wC470]
    dec a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5021::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_007_5035
    ld a, [wC470]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_5036
    xor a, a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5035::
    ret

Jump_007_5036::
    xor a, a
    ld [wFrameCounterLo], a
    call Func_007_5067
    ld a, $69
    call QueueSoundEffect
    call Func_007_5046
    ret

; 6 call sites from 3 routines (e.g. Func_007_4F9D, Func_007_4FF5, Func_007_7690)
; reads: rSTAT
Func_007_5046::
    ld c, [hl]
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    deref_hl
    ld a, $BB
    push af

Jump_007_5056::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_5056

Jump_007_505C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_505C
    pop af
    ld [hl], a
    pop hl
    ret

; 5 call sites from 5 routines (e.g. Func_007_65F1, Func_007_4F9D, Func_007_60E9, Func_007_4FF5, ...)
; reads: rSTAT
Func_007_5066::
    ld c, [hl]

; 3 call sites from 3 routines (e.g. Func_007_4F9D, Func_007_4FF5, Func_007_7690)
; reads: rSTAT
Func_007_5067::
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    deref_hl
    ld a, $C3
    push af

Jump_007_5076::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_5076

Jump_007_507C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_507C
    pop af
    ld [hl], a
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $01D086, $78

; 10 call sites from 3 routines (e.g. Func_007_60E9, Func_007_7270, Func_007_6DE3)
Func_007_50FE::
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ret

; no direct call (reached through a table, a jump or a vector)
Func_007_510D:: ; heuristic: follows a terminator; C0
    ld hl, vBGMap0
    ld bc, $1412
    ld a, $C3

Jump_007_5115::
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_5115
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, $C3
    ld b, $14
    dec c
    jr nz, Jump_007_5115
    ret

; 4 call sites from 3 routines (e.g. Func_007_6DE3, Func_007_70E9, Func_007_7807)
; writes: wStringCategory, wStringIndex
Func_007_512B::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ret

; 2 call sites from 1 routine (e.g. Func_007_4B27)
; writes: wStringCategory, wStringIndex
Func_007_513A::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; no direct call (reached through a table, a jump or a vector)
Func_007_5149:: ; heuristic: follows a terminator; C0
    ld c, a
    ld d, c
    rst $10
    ld d, d
    rst $38
    ld d, d
    nop
    nop
    inc c
    rrca
    or a, b
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Func_000_0100
    INCBIN "dwm2-cobi-us.gbc", $01D163, $1A1
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5, $60, $00, $14, $0B, $B0
    ds $12, $B1
    db $B2, $B6, $68, $69, $6A, $6B, $6C, $6D, $ED, $40, $41, $42, $43, $44, $C3, $C3
    db $C3, $ED, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $45, $46, $47, $48, $49, $4A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $57, $58, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $59, $5A, $C3, $C3, $B7, $B6, $4B, $4C, $4D, $4E, $4F, $50
    db $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $51, $52, $53, $54, $55, $56, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $01D446, $9A
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0C, $0B, $15, $15, $10, $0D, $C3, $14, $15, $0B, $13, $15, $C3
    db $0D, $16, $0F, $15, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $14, $1E, $1D, $1F, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $10, $1A, $25, $1A, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0E, $18, $20, $1D, $1F, $27, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0D, $26, $19, $1C, $18, $21, $1B, $1A, $C3, $C3, $C3, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5, $00, $00, $14, $12, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $14, $28, $0F, $10, $10, $C3, $10, $0F, $29, $0F, $15
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $10, $0F
    db $29, $0F, $15, $C3, $B7, $B6, $C3, $0B, $23, $1E, $C3, $29, $18, $1B, $1D, $19
    db $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $14, $24, $2B, $2B, $2C, $22, $23, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $13, $1A, $19, $2C, $25, $1A, $22, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0C, $22, $1A, $18, $23, $1C, $C3, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $2A, $18, $21, $19, $1A, $C3, $C3, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0B, $23, $1E, $C3, $14, $1E, $1D, $1F, $1F, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $29, $1A, $1B, $18, $20, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B3
    ds $12, $B4
    db $B5, $E0, $00, $14, $05, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $15, $2C, $23, $18, $1F, $C3, $10, $1A, $25, $1A, $1F, $2D, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $29, $18, $26, $C3, $10, $1A, $25, $1A, $1F, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $01D7F2, $AF
    ds $10, $B1
    db $B2, $B6
    ds $10, $C3
    db $B7, $B6, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C5, $C3
    db $C3, $C6, $B7, $B6
    ds $10, $C3
    db $B7, $B3
    ds $10, $B4
    db $B5, $DE, $67, $1F, $33, $3C, $12, $00, $00

Jump_007_5902::
    ld a, [wD06A]
    rst $00
    dw Jump_007_5910
    dw Jump_007_59B6
    dw Jump_007_5A5C
    dw Jump_007_5AFB
    dw Jump_007_5EFF

Jump_007_5910::
    ld a, [wD06B]
    rst $00
    dw Jump_007_591A
    dw Jump_007_591A
    dw Jump_007_5976

Jump_007_591A::
    ld a, [wD06B]
    or a, a
    jr z, Jump_007_596A
    ld b, $E1
    ld de, Data_0E1_4001
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_40D6
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_595C
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_40FB
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_410E
    ld hl, wC49F
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_595C::
    ld hl, vBGMap0
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade

Jump_007_596A::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ret

Jump_007_5976::
    ld a, [wD09D]
    inc a
    ld [wD09D], a
    cp a, $3C
    jr c, Jump_007_5993
    xor a, a
    ld [wD09D], a
    ld a, [wD09E]
    inc a
    ld [wD09E], a
    cp a, $03
    jr nc, Jump_007_59A8
    cp a, $02
    ret c

Jump_007_5993::
    ld a, [wJoypadPressed]
    and a, $0B
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD06B, wD06A
Func_007_5999:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [wD06B], a
    ld a, $01
    ld [wD06A], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_59A8::
    ld hl, wD06A
    inc [hl]
    xor a, a
    ld [wD06B], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_59B6::
    ld a, [wD06B]
    rst $00
    dw Jump_007_59C0
    dw Jump_007_59C0
    dw Jump_007_5A1C

Jump_007_59C0::
    ld a, [wD06B]
    or a, a
    jr z, Jump_007_5A10
    ld b, $E1
    ld de, Data_0E1_4116
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_45A7
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5A02
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_45FC
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_460F
    ld hl, wC49F
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5A02::
    ld hl, vBGMap0
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade

Jump_007_5A10::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ret

Jump_007_5A1C::
    ld a, [wD09D]
    inc a
    ld [wD09D], a
    cp a, $3C
    jr c, Jump_007_5A39
    xor a, a
    ld [wD09D], a
    ld a, [wD09E]
    inc a
    ld [wD09E], a
    cp a, $03
    jr nc, Jump_007_5A4E
    cp a, $02
    ret c

Jump_007_5A39::
    ld a, [wJoypadPressed]
    and a, $0B
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD06B, wD06A
Func_007_5A3F:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD06A], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5A4E::
    ld hl, wD06A
    inc [hl]
    xor a, a
    ld [wD06B], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5A5C::
    ld a, [wD06B]
    rst $00
    dw Jump_007_5A66
    dw Jump_007_5A66
    dw Jump_007_5AC2

Jump_007_5A66::
    ld a, [wD06B]
    or a, a
    jr z, Jump_007_5AB6
    ld b, $E1
    ld de, Data_0E1_4617
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4946
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5AA8
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_49BE
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_49D2
    ld hl, wC49F
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5AA8::
    ld hl, vBGMap0
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade

Jump_007_5AB6::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ret

Jump_007_5AC2::
    ld a, [wD09D]
    inc a
    ld [wD09D], a
    cp a, $5A
    jr nc, Jump_007_5AE9
    cp a, $3C
    ret c
    ld a, [wJoypadPressed]
    and a, $0B
    ret z
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD06B], a
    ld a, $03
    ld [wD06A], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5AE9::
    xor a, a
    ld [wD09D], a
    ld hl, wD06A
    inc [hl]
    xor a, a
    ld [wD06B], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5AFB::
    ld a, [wJoypadPressed]
    and a, $0B
    jr z, Func_007_5B14
    call Func_007_5B14
    ld a, $04
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $04
    call StartPaletteFade
    ret

; 1 call site from 1 routine (e.g. Func_007_5A3F)
; reads: wD06B
Func_007_5B14::
    ld a, [wD06B]
    rst $00
    dw Jump_007_5B2A
    dw Jump_007_5BDC
    dw Jump_007_5C14
    dw Jump_007_5C40
    dw Jump_007_5C5F
    dw Jump_007_5CC1
    dw Jump_007_5CD8
    dw Jump_007_5D56
    dw Jump_007_5DB6

Jump_007_5B2A::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $7E
    ld de, Data_07E_4CED
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7E
    ld de, Data_07E_5706
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $10
    ld hl, vTiles2

Jump_007_5B4A::
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec b
    jr nz, Jump_007_5B4A
    ld hl, vBGMap0
    ld bc, $0400

Jump_007_5B5A::
    di
    ld a, $00
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B5A
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5BAA
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400

Jump_007_5B76::
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B76
    ld a, $00
    ldh [rVBK], a
    xor a, a
    ld hl, wC49F
    ld bc, $0040
    call FillBytes
    ld b, $7E
    ld de, Data_07E_4BBD
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4CAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5BAA::
    xor a, a
    ld hl, wD09D
    ld bc, $004C
    call FillBytes
    ld hl, $E000
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld a, $01
    ld [wD0E7], a
    ld hl, wD09F
    call Func_007_5EA2
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade
    ld a, $DD
    call QueueSoundEffect
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5BDC::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    call Func_007_5DF5
    ld a, [wD0E8]
    inc a
    ld [wD0E8], a
    and a, $07
    ret nz
    ld a, [wD0E7]
    ld hl, $5EE3
    call Func_000_0B0D
    call Func_007_5EA2
    ld a, [wD0E7]
    inc a
    ld [wD0E7], a
    cp a, $0A
    ret c
    xor a, a
    ld [wD0E8], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5C14::
    ld a, [wD09D]
    ld l, a
    ld a, [wD09E]
    ld h, a
    ld de, $0040
    add hl, de
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    call Func_007_5DD6
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    call Func_007_5DF5
    ld a, [wD09E]
    cp a, $50
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5C40::
    call Func_007_5DD6
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    call Func_007_5DF5
    ld a, [wD0E8]
    dec a
    ld [wD0E8], a
    ret nz
    ld hl, wD06B
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5C5F::
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    ld a, [wFadeState]
    or a, a
    jp nz, Func_007_5DF5
    ld b, $E1
    ld de, Data_0E1_5405
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_590F
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5CA9
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5974
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5A67
    ld hl, wC49F
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5CA9::
    ld hl, vBGMap0
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade
    ld hl, wD06B
    inc [hl]
    ld a, $5A
    ld [wD09D], a
    ret

Jump_007_5CC1::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wD09D]
    dec a
    ld [wD09D], a
    ret nz
    ld hl, wD06B
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_5CD8::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Data_0E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_5987
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5D24
    ld a, $01
    ldh [rVBK], a
    ld b, $E1
    ld de, Data_0E1_59F7
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, $00
    ldh [rVBK], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM

Jump_007_5D24::
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade
    xor a, a
    ld hl, wD09D
    ld bc, $004C
    call FillBytes
    ld a, $01
    ld [wD0E7], a
    ld hl, $6800
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld hl, wD09F
    call Func_007_5EA2
    call Func_007_5DEF
    ldh [rSCY], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5D56::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    call Func_007_5DF5
    ld a, [wD0E7]
    cp a, $0A
    jr nc, Jump_007_5D8B
    ld a, [wD0E8]
    inc a
    ld [wD0E8], a
    and a, $07
    jr nz, Jump_007_5D8B
    ld a, [wD0E7]
    ld hl, $5EE3
    call Func_000_0B0D
    call Func_007_5EA2
    ld a, [wD0E7]
    inc a
    ld [wD0E7], a
    ret

Jump_007_5D8B::
    ld a, [wD09D]
    ld l, a
    ld a, [wD09E]
    ld h, a
    ld de, $0080
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    call Func_007_5DEF
    ld a, [wD09E]
    or a, a
    ret nz
    ld a, $3C
    ld [wD09D], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5DB6::
    ld a, [wD0E7]
    ld b, a
    ld hl, wD09F
    call Func_007_5DF5
    ld a, [wD09D]
    dec a
    ld [wD09D], a
    ret nz
    ld hl, wD06A
    inc [hl]
    xor a, a
    ld [wD06B], a
    ld a, $04
    call StartPaletteFade
    ret

; 2 call sites from 1 routine (e.g. Func_007_5B14)
; reads: wD09E
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor
Func_007_5DD6::
    ld a, $50
    ldh [hSpriteOriginX], a
    ld a, [wD09E]
    ldh [hSpriteOriginY], a
    xor a, a
    ldh [hSpriteSetIndex], a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    farcall DrawMetaSprite
    ret

; 2 call sites from 1 routine (e.g. Func_007_5B14)
; reads: wD09E
; writes: hScrollY
Func_007_5DEF::
    ld a, [wD09E]
    ldh [hScrollY], a
    ret

; 5 call sites from 1 routine (e.g. Func_007_5B14)
; reads: wD09E, wD06B
Func_007_5DF5::
    push bc
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    pop hl
    or a, a
    jr nz, Jump_007_5E11
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wD09E]
    add a, $50
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, c
    pop hl
    jr Jump_007_5E56

Jump_007_5E11::
    dec a
    jr nz, Jump_007_5E22
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $30
    pop hl
    jr Jump_007_5E56

Jump_007_5E22::
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    add a, $40
    ld [hl], a
    pop hl
    jr nz, Jump_007_5E56
    ld a, [wD06B]
    cp a, $08
    jr nc, Jump_007_5E47
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wD09E]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $28
    cp a, c
    pop hl
    jr Jump_007_5E56

Jump_007_5E47::
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wD09E]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $18
    cp a, c
    pop hl

Jump_007_5E56::
    push hl
    call z, Func_007_5EA2
    pop hl
    ld a, [hl]
    inc a
    ld [hl+], a
    ld c, a
    ld a, [hl]
    and a, $03
    push de
    ld de, $5EFB
    add a, e
    ld e, a
    jr nc, Jump_007_5E6B
    inc d

Jump_007_5E6B::
    ld a, [de]
    pop de
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_007_5E77
    ld a, [hl]
    inc a
    ld [hl-], a
    xor a, a
    ld [hl+], a

Jump_007_5E77::
    call Func_007_5E80
    pop bc
    dec b
    jp nz, Func_007_5DF5
    ret

; 1 call site from 1 routine (e.g. Func_007_5DF5)
; writes: hSpriteSubIndex, hSpriteOriginX, hSpriteOriginY, hSpriteSetIndex, hSpriteTileOffset, hSpriteAttrXor
Func_007_5E80::
    ld a, [hl+]
    and a, $03
    ldh [hSpriteSubIndex], a
    ld a, [hl+]
    ldh [hSpriteOriginX], a
    ld a, [hl+]
    ldh [hSpriteOriginY], a
    ld a, $1E
    ldh [hSpriteSetIndex], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    inc hl
    inc hl
    push hl
    farcall DrawMetaSprite
    pop hl
    ret

; 5 call sites from 2 routines (e.g. Func_007_5DF5, Func_007_5B14)
; reads: wD06B, wD09E
Func_007_5EA2::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    push hl
    call NextTableByte
    pop hl
    and a, $3F
    add a, $30
    ld [hl+], a
    ld a, [wD06B]
    cp a, $03
    jr nc, Jump_007_5EBE
    ld a, [wD09E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ret

Jump_007_5EBE::
    cp a, $05
    jr nc, Jump_007_5ED7
    push hl
    call NextTableByte
    pop hl
    and a, $3F
    ld e, a
    ld a, [wD09E]
    sub a, $20
    add a, e
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

Jump_007_5ED7::
    ld a, [wD09E]
    sub a, $20
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret
    db $9F, $D0, $A5, $D0, $AB, $D0, $B1, $D0, $B7, $D0, $BD, $D0, $C3, $D0, $C9, $D0
    db $CF, $D0, $D5, $D0, $DB, $D0, $E1, $D0, $04, $07, $07, $04

Jump_007_5EFF::
    ld a, [wD06B]
    rst $00
    dw Jump_007_5F09
    dw Jump_007_5F89
    dw Jump_007_5F9D

Jump_007_5F09::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Data_0E1_577C
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_582B
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5F6D
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_58C3
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $E1
    ld de, Data_0E1_5AA7
    ld hl, wC4DF
    ld c, $10
    call CopyFromBankWaitVRAM

Jump_007_5F6D::
    ld hl, vBGMap0
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call StartPaletteFade
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ldh [hScrollY], a
    ret

Jump_007_5F89::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $B4
    ld [wD09D], a
    ld a, $06
    call QueueMusic
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_5F9D::
    ld a, [wJoypadPressed]
    and a, $0B
    jr nz, Jump_007_5FCF
    ld a, [wDC40]
    ld hl, wDC60
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wD09D]
    dec a
    ld [wD09D], a
    jr z, Jump_007_5FC0
    ret

Jump_007_5FC0::
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD06A], a
    ret

Jump_007_5FCF::
    ld a, $04
    call StartPaletteFade
    ld a, $01
    ld [wModeState], a
    ld a, $00
    ld [wC5DD], a
    ld a, $00
    ld [wC5DE], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginXHi, hSpriteOriginYHi, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginY
Func_007_5FE8:: ; heuristic: follows a terminator; C0
    ld a, [wIsCGB]
    or a, a
    ret z
    xor a, a
    ldh [hSpriteSetIndex], a
    ld a, $01
    xor a, $01
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    ldh [hSpriteAttrXor], a
    ld a, $38
    ldh [hSpriteOriginX], a
    ld a, $30
    ldh [hSpriteOriginY], a
    farcall Func_0E1_5AB7
    ret

; 7 call sites from 5 routines (e.g. Func_007_5149, Func_007_5999, Func_007_5A3F, Func_007_5B14, ...)
; reads: wC5E9, wC5EA, wC5EB, wSGBActive, wC51F, wC520
; writes: rBGP, rOBP0, rOBP1, wC577, wC578, wC579, wC57A, wC57B, ...
; points at: wC5E9, wD040, wC4FF
Func_007_600E::
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wD040
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    call Func_000_0DCA
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_608F
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wC51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wC577], a
    ld a, h
    ld [wC578], a
    inc hl
    ld a, l
    ld [wC579], a
    ld a, h
    ld [wC57A], a
    inc hl
    ld a, l
    ld [wC57B], a
    ld a, h
    ld [wC57C], a
    inc hl
    ld a, l
    ld [wC57D], a
    ld a, h
    ld [wC57E], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wC520]
    ld [wC480], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall Func_017_421A
    ld hl, $58FA
    ld de, wC4FF
    ld bc, $0008
    call CopyBytes

Jump_007_608F::
    ret

Jump_007_6090::
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, $02
    ld [wD781], a
    ld a, [wD06A]
    rst $00
    dw Jump_007_60B0
    dw Jump_007_65C5
    dw Jump_007_65FC
    dw Jump_007_66A2
    dw Jump_007_67DB
    dw Jump_007_681C
    dw Jump_007_683A
    dw Jump_007_66E0
    dw Jump_007_6759

Jump_007_60B0::
    call Func_007_60E9
    ld a, [wC58B]
    or a, a
    jr z, Jump_007_60E8
    ld a, [wC58B]
    ld b, a
    xor a, a
    ld [wC58B], a
    ld a, [wModeChangeRequest]
    or a, a
    jr nz, Jump_007_60E8
    ld a, $0F
    ld [wD786], a
    ld a, b
    ld [wC588], a
    call Func_000_08AD
    ld a, $01
    ld [wD786], a

Jump_007_60D8::
    ld a, [wC580]
    and a, $03
    cp a, $03
    jr nz, Jump_007_60D8
    ld a, [wModeChangeRequest]
    and a, a
    jr nz, Jump_007_60E7

Jump_007_60E7::
    ret

Jump_007_60E8::
    ret

; 1 call site from 1 routine (e.g. Func_007_600E)
; reads: wD06B
Func_007_60E9::
    ld a, [wD06B]
    rst $00
    dw Jump_007_60F3
    dw Jump_007_6145
    dw Jump_007_6231

Jump_007_60F3::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, $514F
    ld a, [wC894]
    or a, a
    jr z, Jump_007_611B
    ld hl, $5207

Jump_007_611B::
    call Func_007_4AFE
    call Func_007_4B1E
    ld a, [wC894]
    and a, $01
    ld a, $07
    jr z, Jump_007_612C
    ld a, $08

Jump_007_612C::
    ld [wC46F], a
    xor a, a
    ld [wC470], a
    ld a, [wC46B]
    ld [wC471], a
    xor a, a
    ld [wC58B], a
    ld [wC588], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6145::
    ld a, [wFadeState]
    and a, a
    jr z, Jump_007_615D
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ret

Jump_007_615D::
    ld a, [wC52B]
    bit 0, a
    jr z, Jump_007_6176
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ret

Jump_007_6176::
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_007_6182
    call Func_007_6213
    jr Jump_007_6187

Jump_007_6182::
    ld a, $C0
    call SerialSendByte

Jump_007_6187::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_007_61F8
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_61CE
    ld a, [wC46B]
    and a, $0F
    cp a, $02
    jr c, Jump_007_61CE
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_61CE::
    ld a, [wC46B]
    and a, $0F
    ld b, $02
    ld c, $08
    cp a, c
    jr nc, Jump_007_61DC
    cp a, b
    ccf

Jump_007_61DC::
    jr c, Jump_007_61EE
    ld a, [wC46B]
    ld hl, $5086
    and a, $07
    call Func_007_50FE
    ld a, $69
    call QueueSoundEffect

Jump_007_61EE::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    jr Jump_007_6212

Jump_007_61F8::
    ld de, $5086
    ld hl, wC46B
    ld a, [wC471]
    cp a, [hl]
    call nz, Func_007_5066
    ld a, [wC471]
    ld [hl], a
    call Func_007_4F9D
    ld a, [wC46B]
    ld [wC471], a

Jump_007_6212::
    ret

; 1 call site from 1 routine (e.g. Func_007_60E9)
; reads: wC471
; writes: wD781, wD782
Func_007_6213::
    ld a, [wC471]
    ld de, $65BD
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_007_6220
    inc d

Jump_007_6220::
    xor a, a
    ld [wD781], a
    ld a, [de]
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ret

Jump_007_6231::
    ld a, [wC46B]
    and a, $0F
    rst $00
    dw Jump_007_6247
    dw Jump_007_63A5
    dw Jump_007_63B7
    dw Jump_007_641C
    dw Jump_007_646B
    dw Jump_007_6558
    dw Jump_007_64BA
    dw Jump_007_6509

Jump_007_6247::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld a, [wD06C]
    rst $00
    dw Jump_007_6262
    dw Jump_007_62BA
    dw Jump_007_62ED

Jump_007_6262::
    ld hl, vTiles2 + $680
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0401
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall ShowString_Bank07
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
    ld hl, $5367
    call Func_007_4AFE
    farcall Func_016_777B
    ld a, $BC
    ld [wC1B9], a
    call Func_007_4B1E
    call Func_007_635A
    ld hl, wD06C
    inc [hl]
    ret

Jump_007_62BA::
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_62CE
    ld hl, wD06C
    inc [hl]
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    jr Jump_007_62E9

Jump_007_62CE::
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_62E9
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    xor a, a
    ld [wD06C], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_62E9::
    call Func_007_635A
    ret

Jump_007_62ED::
    call Func_007_635A
    farcall Func_002_717D
    ld a, [wC8C3]
    bit 7, a
    ret z
    farcall Func_060_6CD1
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_007_6319
    cp a, $80
    jr nz, Jump_007_6319
    ld a, [wCD0D]
    ld [wMapWidthScreens], a
    ld a, [wCD0E]
    ld [wMapHeightScreens], a

Jump_007_6319::
    xor a, a
    ld [wC8C7], a
    xor a, a
    ld [wD069], a
    ld [wD091], a
    farcall Func_004_449F
    ldh a, [hPlayerFacing]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    call Func_007_63AC
    farcall Func_00A_476E
    ld a, $03
    ld [wD06A], a
    ret

; 3 call sites from 1 routine (e.g. Func_007_6213)
; reads: wD0D5, wD10A
; writes: rRAMG, rRAMB, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, ...
Func_007_635A::
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wD0D5]
    or a, a
    jr z, Jump_007_639C
    ld a, [wD10A]
    or a, a
    jr z, Jump_007_639C
    ld a, $29
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    ld hl, $0080
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ld hl, $0040
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    farcall DrawMetaSprite
    ret

Jump_007_639C::
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_007_63A5::
    call Func_007_63AC
    call Func_007_65F1
    ret

; 3 call sites from 3 routines (e.g. Func_007_65F1, Func_007_635A, Func_007_6213)
; points at: wD780
Func_007_63AC::
    ld hl, wD780
    ld b, $80

Jump_007_63B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_63B1
    ret

Jump_007_63B7::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_63CD
    cp a, $FE
    jr z, Jump_007_63E7
    ld a, $00
    ld [wC55D], a
    ld a, $F5
    ld [wC58B], a
    ret

Jump_007_63CD::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $A1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_63E7::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $A1
    ld a, $BC
    call Func_007_6406
    ret

; 6 call sites from 2 routines (e.g. Func_007_6406, Func_007_63AC)
; writes: wC58B, wD06A, wC470
Func_007_6406::
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wC58B], a
    ld a, $07
    ld [wD06A], a
    xor a, a
    ld [wC470], a
    ret

Jump_007_641C::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_6432
    cp a, $FE
    jr z, Jump_007_644C
    ld a, $00
    ld [wC55D], a
    ld a, $F6
    ld [wC58B], a
    ret

Jump_007_6432::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $E1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_644C::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $E1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_646B::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_6481
    cp a, $FE
    jr z, Jump_007_649B
    ld a, $00
    ld [wC55D], a
    ld a, $B7
    ld [wC58B], a
    ret

Jump_007_6481::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $121
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_649B::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $121
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_64BA::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_64D0
    cp a, $FE
    jr z, Jump_007_64EA
    ld a, $00
    ld [wC55D], a
    ld a, $E0
    ld [wC58B], a
    ret

Jump_007_64D0::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $1A1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_64EA::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $1A1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_6509::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_651F
    cp a, $FE
    jr z, Jump_007_6539
    ld a, $00
    ld [wC55D], a
    ld a, $F1
    ld [wC58B], a
    ret

Jump_007_651F::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $1E1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_6539::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $1E1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_6558::
    ld a, [wC470]
    cp a, $FF
    jr z, Jump_007_656E
    cp a, $FE
    jr z, Jump_007_6588
    ld a, $00
    ld [wC55D], a
    ld a, $DC
    ld [wC58B], a
    ret

Jump_007_656E::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $161
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_6588::
    ld a, $02
    ld [wD786], a
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vBGMap0 + $161
    ld a, $BC
    call Func_007_6406
    ret

; 6 call sites from 2 routines (e.g. Func_007_6406, Func_007_63AC)
; writes: wC58B, wD06A, wC470
Func_007_65A7::
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wC58B], a
    ld a, $04
    ld [wD06A], a
    xor a, a
    ld [wC470], a
    ret
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

Jump_007_65C5::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld a, $01
    ld [wC46B], a
    ld a, $01
    ld [wC46F], a
    ld hl, wD09D
    ld [hl], $00
    ld de, $5086
    call Func_007_4F9D
    ld a, [wJoypadPressed]
    and a, $01
    ret z

; 1 call site from 1 routine (e.g. Func_007_635A)
; points at: wD06A
Func_007_65F1::
    ld hl, wD06A
    ld a, $06
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

Jump_007_65FC::
    ld a, [wD06B]
    rst $00
    dw Jump_007_6606
    dw Jump_007_6624
    dw Jump_007_6633

Jump_007_6606::
    ld a, [wFadeState]
    or a, a
    ret nz
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld a, $52
    call QueueMusic
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6624::
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6633::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $01
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    xor a, a
    call FillBytes
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, $52D7
    call Func_007_4AFE
    call Func_007_4B1E
    xor a, a
    ld [wD06B], a
    ld hl, wD06A
    dec [hl]
    ld a, $09
    call QueueMusic
    ret

Jump_007_66A2::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld a, $04
    call StartPaletteFade
    ld hl, wGameMode
    ld a, $01
    ld [hl+], a
    ld a, [wScriptRunning]
    bit 0, a
    ld a, $01
    jr nz, Jump_007_66D2
    ld a, [wCC44]
    bit 7, a
    ld a, $05
    jr nz, Jump_007_66D2
    ld a, $00

Jump_007_66D2::
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl], $00
    call Func_007_63AC
    ld hl, wModeChangeRequest
    inc [hl]
    ret

Jump_007_66E0::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wC588]
    ld b, a
    and a, $F0
    swap a
    ld [wC130], a
    ld a, b
    and a, $0F
    ld [wC131], a
    ld a, $F0
    ld [wC132], a
    ld a, [wD787]
    ld [wC134], a
    ld a, $F0
    ld [wC135], a
    ld a, [wD780]
    ld b, a
    and a, $F0
    swap a
    ld [wC138], a
    ld a, b
    and a, $0F
    ld [wC139], a
    ld a, $F0
    ld [wC13A], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_6759::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    call Func_007_5066
    ld a, [wC471]
    ld [wC46B], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wD783]
    ld b, a
    and a, $F0
    swap a
    ld [wC130], a
    ld a, b
    and a, $0F
    ld [wC131], a
    ld a, $F0
    ld [wC132], a
    ld a, [wD784]
    ld [wC134], a
    ld a, $F0
    ld [wC135], a
    ld a, [wD785]
    ld b, a
    and a, $F0
    swap a
    ld [wC138], a
    ld a, b
    and a, $0F
    ld [wC139], a
    ld a, $F0
    ld [wC13A], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_67DB::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld hl, wD06A
    inc [hl]
    ret

Jump_007_681C::
    xor a, a
    ld [wD781], a
    ld a, $F4
    ld [wD782], a
    call SerialSendByte
    ld a, $01
    ld [wD781], a
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wD06A], a
    ld [wD06B], a
    ret

Jump_007_683A::
    ld a, [wD06B]
    rst $00
    dw Jump_007_684C
    dw Jump_007_6856
    dw Jump_007_68B7
    dw Jump_007_68C1
    dw Jump_007_68DE
    dw Jump_007_68E3
    dw Jump_007_6919

Jump_007_684C::
    ld a, $04
    call StartPaletteFade
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6856::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $C3
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_687D
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld hl, wD000
    ld bc, $02D0
    call FillBytes
    xor a, a
    ldh [rSVBK], a

Jump_007_687D::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_6897
    ld hl, wC4DF
    ld de, wC4FF
    ld b, $20

Jump_007_6891::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_6891

Jump_007_6897::
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
    ld a, $FC
    call StartPaletteFade
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_68B7::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_68C1::
    ld e, $01
    ld d, $00
    call SetFlagBit
    ld a, $01
    ld [wD09D], a
    ld de, $0000
    call TestFlagBit
    jr c, Jump_007_68D9
    xor a, a
    ld [wD09D], a

Jump_007_68D9::
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_68DE::
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_68E3::
    ld hl, wD7F1
    ld a, $00
    ld [hl+], a
    ld a, [wD09D]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall Func_014_5CA8
    call NextTableByte
    ld a, [wC5E7]
    ld [wC616], a
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld de, wC8CF
    ld hl, wC60C
    ld b, $0A

Jump_007_690E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_690E
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6919::
    ld a, $38
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ldh [hPlayerX], a
    ld [wC8F0], a
    xor a, a
    ldh [hPlayerY], a
    ld [wC8F1], a
    xor a, a
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld a, $00
    ld [wC6FD], a
    ld a, $00
    ld [wC6FE], a
    call Func_007_695A
    call Func_007_6975
    ld hl, wC707
    ld bc, $0080
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wC8C7], a
    ld a, $03
    ld [wD06A], a
    ret

; 1 call site from 1 routine (e.g. Func_007_65F1)
; writes: wC617, wC618, wC619
; points at: wInventory
Func_007_695A::
    ld a, $64
    ld [wC617], a
    ld a, $00
    ld [wC618], a
    ld a, $00
    ld [wC619], a
    ld hl, wInventory
    ld bc, $0018
    ld a, $00
    call FillBytes
    ret

; 1 call site from 1 routine (e.g. Func_007_65F1)
; reads: wRecordBuffer, wCFED, wRecordBufferData, wCFEF, wCFF0, wCFF1, wCFF5, wCFF6, ...
; writes: rRAMG, rRAMB, wMonsterId, wCFE7, wD006, wD007
; points at: sA000, wC60C, sA00D, wD01A, sA08E, sA099, sA01E, sA029
Func_007_6975::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, $0001
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld hl, sA000
    ld a, $02
    ld [hl+], a
    ld a, $1C
    ld [hl+], a
    ld a, $2F
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $2B
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wRecordBuffer]
    ld [hl+], a
    ld a, [wCFED]
    ld [hl+], a
    inc hl
    xor a, a
    ld [hl+], a
    ld de, wC60C
    ld b, $0B
    call Func_007_6AD5
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wRecordBufferData]
    ld [hl+], a
    ld a, [wCFEF]
    ld [hl+], a
    ld a, [wCFF0]
    ld [hl+], a
    ld a, [wCFF1]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    xor a, a
    ld [hl+], a
    ld a, [wCFF5]
    ld [hl+], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
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
    ld [hl+], a
    ld [hl+], a
    ld a, [wD002]
    ld [hl+], a
    ld a, [wD003]
    ld [hl+], a
    ld a, [wD004]
    ld [hl+], a
    ld a, [wD005]
    ld [hl+], a
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_035_4001
    ld hl, sA00D
    ld a, [wD008]
    ld [hl], a
    ld a, l
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld b, $16
    ld a, $FF
    call Func_007_6AD0
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD00E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $18
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, wD01A
    ld b, $1B
    call Func_007_6AD5
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld [hl], $00
    ld hl, sA08E
    call Func_007_6ADC
    ld hl, sA099
    call Func_007_6ADC
    ld hl, sA01E
    call Func_007_6ADC
    ld hl, sA029
    call Func_007_6ADC
    farcall Func_016_5AAF
    ret

; 1 call site from 1 routine (e.g. Func_007_6975)
Func_007_6AD0::
    ld [hl+], a
    dec b
    jr nz, Func_007_6AD0
    ret

; 2 call sites from 1 routine (e.g. Func_007_6975)
Func_007_6AD5::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_007_6AD5
    ret

; 4 call sites from 1 routine (e.g. Func_007_6975)
Func_007_6ADC::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

Jump_007_6AE9::
    ld [hl+], a
    dec b
    jr nz, Jump_007_6AE9
    ret

Jump_007_6AEE::
    ld a, [wC581]
    cp a, $05
    jp z, Jump_007_7D38
    call Func_000_0535
    ld a, [wD06A]
    cp a, $01
    jr z, Jump_007_6B01
    ret

Jump_007_6B01::
    ld a, [wD780]
    cp a, $0C
    jr z, Jump_007_6B7D
    cp a, $0D
    jp z, Jump_007_6B9C
    ld a, [wD7EE]
    and a, a
    jr z, Jump_007_6B23
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    ret z
    xor a, a
    ld [wD7EE], a

Jump_007_6B23::
    ld a, [wC94B]
    or a, a
    ret z
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wCC44], a
    xor a, a
    ld [wC917], a
    ld a, $21
    ld [wC916], a
    farcall Func_013_405C
    farcall FetchScriptCommand
    ld a, $E0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hFF8C], a
    ld [wC6FD], a
    xor a, a
    ld [wC8C7], a
    ld a, [wC88D]
    ld [wC965], a
    xor a, a
    ld [wC88D], a
    xor a, a
    ld [wC58A], a
    ld [wC94B], a
    ld [wScriptInDataBank], a
    ld [wD7F0], a
    ret

Jump_007_6B7D::
    ld a, [wD782]
    and a, a
    ret nz
    ld a, [wD781]
    cp a, $15
    jr z, Jump_007_6B8E
    cp a, $20
    jr z, Jump_007_6B95
    ret

Jump_007_6B8E::
    farcall Func_01D_5C35
    ret

Jump_007_6B95::
    farcall Func_01D_5BF2
    ret

Jump_007_6B9C::
    ld a, [wD781]
    cp a, $15
    jr z, Jump_007_6BA8
    cp a, $20
    jr z, Jump_007_6BAF
    ret

Jump_007_6BA8::
    farcall Func_0F1_5719
    ret

Jump_007_6BAF::
    farcall Func_0F2_4EDD
    ret
    db $C9

Jump_007_6BB7::
    call Func_000_0535
    ld a, [wD06A]
    cp a, $01
    jr z, Jump_007_6BC2
    ret

Jump_007_6BC2::
    ret

Jump_007_6BC3::
    call Func_000_0535
    ld a, [wD06A]
    or a, a
    jr nz, Jump_007_6BCD
    ret

Jump_007_6BCD::
    ld a, [wD780]
    cp a, $0C
    jr z, Jump_007_6BD9
    cp a, $0D
    jr z, Jump_007_6BF8
    ret

Jump_007_6BD9::
    ld a, [wD782]
    and a, a
    ret nz
    ld a, [wD781]
    cp a, $20
    jr z, Jump_007_6BF1
    cp a, $15
    jr z, Jump_007_6BEA
    ret

Jump_007_6BEA::
    farcall Func_01D_5C35
    ret

Jump_007_6BF1::
    farcall Func_01D_5BF2
    ret

Jump_007_6BF8::
    ld a, [wD781]
    cp a, $15
    jr z, Jump_007_6C04
    cp a, $20
    jr z, Jump_007_6C0B
    ret

Jump_007_6C04::
    farcall Func_0F1_5719
    ret

Jump_007_6C0B::
    farcall Func_0F2_4EDD
    ret

; 1 call site from 1 routine (e.g. Func_01B_449F)
; reads: wD06A
Func_007_6C12::
    ld a, [wD06A]
    rst $00
    dw Jump_007_6C28
    dw Jump_007_6CCD
    dw Jump_007_6E16
    dw Jump_007_6F34
    dw Jump_007_7864
    dw Jump_007_79FC
    dw Jump_007_7AC2
    dw Jump_007_7ACD
    dw Jump_007_7C7E

Jump_007_6C28::
    ld a, [wD06B]
    rst $00
    dw Jump_007_6C32
    dw Jump_007_6CAB
    dw Jump_007_6CB8

Jump_007_6C32::
    ld a, [wFadeState]
    or a, a
    ret nz
    di
    farcall Func_002_717D
    ei
    call Func_007_6C59
    farcall Func_012_64F8
    ld a, $04
    ld [wC46F], a
    xor a, a
    ld [wC594], a
    ld a, [wD06B]
    inc a
    ld [wD06B], a
    ret

; 1 call site from 1 routine (e.g. Func_007_6C12)
; reads: wC6FD, hFFC6, hFFC7
; writes: rRAMG
; points at: wC6FE, wC972
Func_007_6C59::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, wC972

Jump_007_6C68::
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [de], a
    inc de
    ldh a, [hFFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [de], a
    inc de
    ldh a, [hFFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_6C68
    xor a, a
    ld [rRAMG], a
    ld a, [wC6FD]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

Jump_007_6CAB::
    ld a, [wD06B]
    inc a
    ld [wD06B], a
    ld a, $D3
    ld [wC594], a
    ret

Jump_007_6CB8::
    ld a, [wC58F]
    cp a, $D3
    ret nz
    xor a, a
    ld [wC594], a
    ld [wD06B], a
    ld a, [wD06A]
    inc a
    ld [wD06A], a
    ret

Jump_007_6CCD::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_007_6CEA
    ld a, $01
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ld a, $01
    ld [wC594], a
    ld hl, wD06A
    inc [hl]
    jp Jump_007_6DA8

Jump_007_6CEA::
    cp a, $FD
    jr nz, Jump_007_6D06
    ld a, $08
    ld [wCFC5], a
    ld hl, wD06A
    inc [hl]
    ld hl, wD06A
    inc [hl]
    ld hl, wD06A
    inc [hl]
    xor a, a
    ld [wC594], a
    jp Jump_007_6DA8

Jump_007_6D06::
    cp a, $FC
    jr nz, Jump_007_6D19
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    jr Jump_007_6D2A

Jump_007_6D19::
    cp a, $FB
    jr nz, Jump_007_6D32
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a

Jump_007_6D2A::
    ld a, $08
    ld [wD06A], a
    jp Jump_007_6DA8

Jump_007_6D32::
    ld de, $5096
    ld hl, wC46B
    call Func_007_4F9D
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_6D90
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46B]
    and a, $03
    cp a, $03
    jr z, Jump_007_6D97
    or a, a
    jr z, Jump_007_6D64
    cp a, $01
    jr z, Jump_007_6D76
    call Func_007_6DE3
    ld a, $08
    ld [wCFC5], a
    ld de, $FD03
    jr Jump_007_6D86

Jump_007_6D64::
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a
    ld de, $FB05
    jr Jump_007_6D86

Jump_007_6D76::
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    ld de, $FC05

Jump_007_6D86::
    ld a, e
    ld [wD06A], a
    ld a, d
    ld [wC594], a
    jr Jump_007_6DA8

Jump_007_6D90::
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_6DA8

Jump_007_6D97::
    ld a, $FE
    ld [wC594], a
    xor a, a
    ld [wD06C], a
    xor a, a
    ld [wD06B], a
    ld hl, wD06A
    inc [hl]

Jump_007_6DA8::
    ret

; 6 call sites from 3 routines (e.g. Func_007_7807, Func_007_6C59, Func_007_6DE3)
; points at: wD043
Func_007_6DA9::
    ld hl, wD043
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld [hl], $80
    ret

; 6 call sites from 3 routines (e.g. Func_007_7807, Func_007_6C59, Func_007_6DE3)
; points at: wD043
Func_007_6DC2::
    ld hl, wD043
    ld a, $01
    ld [hl+], a
    ld a, $81
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $80
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $9E
    ld [hl+], a
    ld [hl], $00
    ret

; 3 call sites from 3 routines (e.g. Func_007_6C59, Func_007_7807, Func_007_7C5F)
; reads: wD044, wD048, wD049, wD04B, wD04C
; points at: wD09D
Func_007_6DE3::
    ld hl, wD09D
    xor a, a
    ld [hl+], a
    ld a, [wD044]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wD048]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wD049]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wD04B]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wD04C]
    rlca
    and a, $01
    xor a, $01
    ld [hl], a
    ret

Jump_007_6E16::
    ld a, [wD06B]
    rst $00
    dw Jump_007_6E2A
    dw Jump_007_6E9A
    dw Jump_007_6EA4
    dw Jump_007_6EC5
    dw Jump_007_6ECF
    dw Jump_007_6EE1
    dw Jump_007_6EF0
    dw Jump_007_6EFB

Jump_007_6E2A::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_007_6E8C
    cp a, $FE
    jr z, Jump_007_6E8C
    cp a, $FB
    jr z, Jump_007_6E42
    cp a, $FC
    jr z, Jump_007_6E5C
    cp a, $FD
    jr z, Jump_007_6E76
    ret

Jump_007_6E42::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6E8C
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_6E5C::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6E8C
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_6E76::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6E8C
    ld a, $08
    ld [wCFC5], a
    ld a, $04
    ld [wD06A], a
    xor a, a
    ld [wC594], a
    ret

Jump_007_6E8C::
    xor a, a
    ld [wC594], a
    ld a, $01
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6E9A::
    ld hl, wD06B
    inc [hl]
    ld a, $02
    ld [wC594], a
    ret

Jump_007_6EA4::
    ld a, [wC58F]
    cp a, $02
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6EC5::
    ld a, [wC58F]
    or a, a
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6ECF::
    ld hl, $0302
    ld a, [wD06C]
    or a, a
    jr z, Jump_007_6ED9
    inc l

Jump_007_6ED9::
    call Func_007_512B
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6EE1::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6EF0::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_6EFB::
    xor a, a
    ld [wC581], a
    ld [wC582], a
    ld [wC57F], a
    ld [wC580], a
    ld [wC58A], a
    ld [wC58F], a
    ld [wC594], a
    ld [wC58B], a
    ld hl, wD09D
    ld bc, $001E
    xor a, a
    call FillBytes
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, $04
    call StartPaletteFade
    ret

Jump_007_6F34::
    ld a, [wD06B]
    rst $00
    dw Jump_007_6F76
    dw Jump_007_7010
    dw Jump_007_7069
    dw Jump_007_707C
    dw Jump_007_70F3
    dw Jump_007_7103
    dw Jump_007_712D
    dw Jump_007_713C
    dw Jump_007_7153
    dw Jump_007_715E
    dw Jump_007_7168
    dw Jump_007_719B
    dw Jump_007_71D8
    dw Jump_007_7284
    dw Jump_007_732C
    dw Jump_007_7351
    dw Jump_007_7376
    dw Jump_007_739B
    dw Jump_007_73C0
    dw Jump_007_73E5
    dw Jump_007_740A
    dw Jump_007_742F
    dw Jump_007_746C
    dw Jump_007_7498
    dw Jump_007_75D8
    dw Jump_007_7615
    dw Jump_007_762F
    dw Jump_007_7763
    dw Jump_007_77A0
    dw Jump_007_77BA
    dw Jump_007_7845

Jump_007_6F76::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_007_6F8B
    cp a, $FD
    jr z, Jump_007_6FA7
    cp a, $FB
    jr z, Jump_007_6FBD
    cp a, $FC
    jr z, Jump_007_6FD7
    jr Jump_007_6FF1

Jump_007_6F8B::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $01
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ld a, $01
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    ret

Jump_007_6FA7::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $08
    ld [wCFC5], a
    ld a, $04
    ld [wD06A], a
    xor a, a
    ld [wC594], a
    ret

Jump_007_6FBD::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6FF1
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_6FD7::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_6FF1
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_6FF1::
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $06
    ld [wC46F], a
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

Jump_007_7010::
    ld hl, wC46C
    ld de, $509E
    call Func_007_4F9D
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7021
    ret

Jump_007_7021::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46C]
    ld hl, $509E
    and a, $07
    call Func_007_50FE
    ld a, $02
    ld [wC470], a
    ld a, [wC46C]
    and a, $07
    ld hl, wD09D
    add_a_to_hl
    ld a, [hl]
    ld [wC46D], a
    ld a, [wC46C]
    and a, $07
    ld hl, $7063
    add_a_to_hl
    ld a, [hl]
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ret
    db $03, $0B, $15, $18, $1B, $1E

Jump_007_7069::
    ld a, $FE
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ret

Jump_007_707C::
    ld hl, wC46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7097
    ld a, [wC46D]
    ld [wD09D], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_7097::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    and a, $01
    jr z, Jump_007_70AF
    ld a, $02
    ld [wD06B], a
    ret

Jump_007_70AF::
    ld hl, wD043
    ld a, $01
    ld [hl+], a
    ld a, [wD09E]
    call Func_007_70E9
    inc hl
    inc hl
    inc hl
    ld a, [wD09F]
    call Func_007_70E9
    ld a, [wD0A0]
    call Func_007_70E9
    inc hl
    ld a, [wD0A1]
    call Func_007_70E9
    ld a, [wD0A2]
    call Func_007_70E9
    ld a, $02
    ld [wD059], a
    call Func_007_4E11
    ld a, $01
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

; 5 call sites from 1 routine (e.g. Func_007_6DE3)
Func_007_70E9::
    rrca
    and a, $80
    xor a, $80
    res 7, [hl]
    or a, [hl]
    ld [hl+], a
    ret

Jump_007_70F3::
    ld a, [wC58F]
    cp a, $02
    ret nz
    ld a, $02
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7103::
    ld a, $0A
    ld [wC592], a
    ld hl, wD043
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $01
    ld [wC58C], a
    ld a, $FF
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_712D::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_713C::
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7153::
    ld hl, $0306
    call Func_007_512B
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_715E::
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7168::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_007_7183
    ld a, $02
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ld a, $01
    ld [wC594], a
    ret

Jump_007_7183::
    cp a, $01
    ret nz
    ld a, $01
    ld [wC594], a
    ld a, $05
    ld [wD06A], a
    ld a, $01
    ld [wD06B], a
    ld a, $00
    ld [wD06C], a
    ret

Jump_007_719B::
    ld hl, wC46D
    ld de, $50AE
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_71B6
    ld a, [wC46D]
    ld [wD09E], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_71B6::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    ld [wD09E], a
    or a, a
    jr z, Jump_007_71CF
    xor a, a
    ld [wD06B], a
    ret

Jump_007_71CF::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

Jump_007_71D8::
    ld hl, $561F
    call Func_007_4AFE
    call Func_007_4B1E
    ld de, wD0A3
    ld hl, vBGMap0 + $8C
    ld a, [wD044]
    ld c, a
    ld a, [wD045]
    ld b, a
    ld a, $02
    bit 6, c
    jr z, Jump_007_71FA
    ld a, b
    rlca
    rlca
    and a, $01

Jump_007_71FA::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 5, c
    jr z, Jump_007_720B
    ld a, b
    rrca
    swap a
    and a, $01

Jump_007_720B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 4, c
    jr z, Jump_007_721B
    ld a, b
    swap a
    and a, $01

Jump_007_721B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 3, c
    jr z, Jump_007_722C
    ld a, b
    rrca
    rrca
    rrca
    and a, $01

Jump_007_722C::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 2, c
    jr z, Jump_007_723C
    ld a, b
    rrca
    rrca
    and a, $01

Jump_007_723C::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 1, c
    jr z, Jump_007_724B
    ld a, b
    rrca
    and a, $01

Jump_007_724B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 0, c
    jr z, Jump_007_7259
    ld a, b
    and a, $01

Jump_007_7259::
    ld [de], a
    call Func_007_7270
    xor a, a
    ld [wC46E], a
    ld a, $07
    ld [wC46F], a
    ld a, $03
    ld [wC470], a
    ld hl, wD06B
    inc [hl]
    ret

; 7 call sites from 1 routine (e.g. Func_007_70E9)
Func_007_7270::
    push bc
    push hl
    add a, a
    add_a_to_hl
    ld a, $BC
    call WriteVRAMByte
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    ret

Jump_007_7284::
    ld hl, wC46E
    ld de, $50C2
    call Func_007_4F9D
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_72AE
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46E]
    ld hl, $50C2
    call Func_007_50FE
    ld a, [wC46E]
    and a, $07
    inc a
    ld hl, wD06B
    add a, [hl]
    ld [hl], a
    ret

Jump_007_72AE::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld bc, $0000
    ld a, [wD0A3]
    cp a, $02
    jr z, Jump_007_72C6
    rrca
    rrca
    and a, $40
    or a, b
    ld b, a
    set 6, c

Jump_007_72C6::
    ld a, [wD0A4]
    cp a, $02
    jr z, Jump_007_72D6
    swap a
    rlca
    and a, $20
    or a, b
    ld b, a
    set 5, c

Jump_007_72D6::
    ld a, [wD0A5]
    cp a, $02
    jr z, Jump_007_72E5
    swap a
    and a, $10
    or a, b
    ld b, a
    set 4, c

Jump_007_72E5::
    ld a, [wD0A6]
    cp a, $02
    jr z, Jump_007_72F5
    swap a
    rrca
    and a, $08
    or a, b
    ld b, a
    set 3, c

Jump_007_72F5::
    ld a, [wD0A7]
    cp a, $02
    jr z, Jump_007_7304
    rlca
    rlca
    and a, $04
    or a, b
    ld b, a
    set 2, c

Jump_007_7304::
    ld a, [wD0A8]
    cp a, $02
    jr z, Jump_007_7312
    rlca
    and a, $02
    or a, b
    ld b, a
    set 1, c

Jump_007_7312::
    ld a, [wD0A9]
    cp a, $02
    jr z, Jump_007_731F
    and a, $01
    or a, b
    ld b, a
    set 0, c

Jump_007_731F::
    ld a, c
    ld [wD044], a
    ld a, b
    ld [wD045], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_732C::
    ld hl, wD0A3
    ld de, $50D0
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A3]
    and a, $03
    ld hl, $50D0
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_7351::
    ld hl, wD0A4
    ld de, $50D6
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A4]
    and a, $03
    ld hl, $50D6
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_7376::
    ld hl, wD0A5
    ld de, $50DC
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A5]
    and a, $03
    ld hl, $50DC
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_739B::
    ld hl, wD0A6
    ld de, $50E2
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A6]
    and a, $03
    ld hl, $50E2
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_73C0::
    ld hl, wD0A7
    ld de, $50E8
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A7]
    and a, $03
    ld hl, $50E8
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_73E5::
    ld hl, wD0A8
    ld de, $50EE
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A8]
    and a, $03
    ld hl, $50EE
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_740A::
    ld hl, wD0A9
    ld de, $50F4
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wD0A9]
    and a, $03
    ld hl, $50F4
    call Func_007_50FE
    ld a, $0D
    ld [wD06B], a
    ret

Jump_007_742F::
    ld hl, wC46D
    ld de, $50B2
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_744A
    ld a, [wC46D]
    ld [wD09F], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_744A::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    ld [wD09F], a
    or a, a
    jr z, Jump_007_7463
    xor a, a
    ld [wD06B], a
    ret

Jump_007_7463::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

Jump_007_746C::
    ld hl, $578B
    call Func_007_4AFE
    ld hl, vBGMap0 + $E0
    ld de, wC278
    ld bc, $1405
    call Func_007_4B27
    call Func_007_7535
    call Func_007_7594
    ld a, [wD047]
    rlca
    rlca
    and a, $01
    ld [wC46E], a
    ld a, $02
    ld [wC46F], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7498::
    ld hl, wC46E
    ld de, $50FA
    call Func_007_4F9D
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_007_7514
    ld a, [wC46E]
    and a, $01
    jr nz, Jump_007_74EF
    ld a, [wD047]
    ld l, a
    ld a, [wD048]
    and a, $C0
    push af
    ld a, [wD048]
    and a, $3F
    ld h, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_74D5
    dec hl
    ld a, h
    or a, a
    jr nz, Jump_007_74E1
    ld a, l
    cp a, $03
    jr nc, Jump_007_74E1
    ld hl, $0003
    jr Jump_007_74E1

Jump_007_74D5::
    inc hl
    ld a, l
    sub a, $29
    ld a, h
    sbc a, $01
    jr c, Jump_007_74E1
    ld hl, $0129

Jump_007_74E1::
    pop af
    or a, h
    ld [wD048], a
    ld a, l
    ld [wD047], a
    call Func_007_7535
    jr Jump_007_7514

Jump_007_74EF::
    ld a, [wD046]
    ld l, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_7504
    dec hl
    ld a, l
    or a, a
    jr nz, Jump_007_750D
    ld hl, $0001
    jr Jump_007_750D

Jump_007_7504::
    inc l
    ld a, l
    cp a, $64
    jr c, Jump_007_750D
    ld hl, $0063

Jump_007_750D::
    ld a, l
    ld [wD046], a
    call Func_007_7594

Jump_007_7514::
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46E]
    rrca
    rrca
    and a, $40
    ld h, a
    ld a, [wD048]
    and a, $BF
    or a, h
    ld [wD048], a
    xor a, a
    ld [wD06B], a
    ret

; 2 call sites from 1 routine (e.g. Func_007_7270)
; reads: wD047, wD048, wC8C0, wC8C1, wC8C2
Func_007_7535::
    ld a, [wD047]
    ld l, a
    ld a, [wD048]
    and a, $3F
    ld h, a
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $C5
    ld a, e
    sub a, $04
    ld a, d
    sbc a, $00
    jr nc, Jump_007_7550
    ld b, $C3

Jump_007_7550::
    ld hl, vBGMap0 + $10E
    ld a, b
    call WriteVRAMByteInc
    ld c, $01
    ld a, [wC8C0]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7566
    ld c, $00
    ld a, $C3

Jump_007_7566::
    call WriteVRAMByteInc
    ld a, [wC8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7578
    bit 0, c
    jr nz, Jump_007_7578
    ld a, $C3

Jump_007_7578::
    call WriteVRAMByteInc
    ld a, [wC8C2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    sub a, $29
    ld a, d
    sbc a, $01
    jr c, Jump_007_758F
    ld b, $C3

Jump_007_758F::
    ld a, b
    call WriteVRAMByte
    ret

; 2 call sites from 1 routine (e.g. Func_007_7270)
; reads: wD046, wC8C1, wC8C2
Func_007_7594::
    ld a, [wD046]
    ld l, a
    ld h, $00
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $C5
    ld a, e
    cp a, $02
    jr nc, Jump_007_75A8
    ld b, $C3

Jump_007_75A8::
    ld hl, vBGMap0 + $14E
    ld a, b
    call WriteVRAMByteInc
    ld a, $C3
    call WriteVRAMByteInc
    ld a, [wC8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_75BF
    ld a, $C3

Jump_007_75BF::
    call WriteVRAMByteInc
    ld a, [wC8C2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    cp a, $63
    jr c, Jump_007_75D3
    ld b, $C3

Jump_007_75D3::
    ld a, b
    call WriteVRAMByte
    ret

Jump_007_75D8::
    ld hl, wC46D
    ld de, $50B6
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_75F3
    ld a, [wC46D]
    ld [wD0A0], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_75F3::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    ld [wD0A0], a
    or a, a
    jr z, Jump_007_760C
    xor a, a
    ld [wD06B], a
    ret

Jump_007_760C::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

Jump_007_7615::
    ld hl, $57F3
    call Func_007_4AFE
    ld hl, vBGMap0 + $62
    ld de, wC1FA
    ld bc, $0F0B
    call Func_007_4B27
    call Func_007_7716
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_762F::
    call Func_007_7690
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7656
    ld a, [wD049]
    and a, $7F
    cp a, $7F
    jr nz, Jump_007_7651
    ld a, [wD04A]
    and a, $F0
    cp a, $F0
    jr nz, Jump_007_7651
    ld a, $84
    call QueueSoundEffect
    ret

Jump_007_7651::
    xor a, a
    ld [wD06B], a
    ret

Jump_007_7656::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    call Func_007_766B
    ld a, [wC46E]
    call Func_007_7724
    ret

; 1 call site from 1 routine (e.g. Func_007_7594)
; reads: wC46E
; points at: wD049
Func_007_766B::
    ld a, [wC46E]
    ld hl, $774D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld hl, wD049
    add_a_to_hl
    ld a, d
    cpl
    ld e, a
    ld a, [hl]
    and a, d
    jr z, Jump_007_768C
    ld a, [hl]
    and a, e
    jr Jump_007_768E

Jump_007_768C::
    ld a, [hl]
    or a, d

Jump_007_768E::
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_007_7594)
; reads: wFrameCounterLo, wJoypadPressedRepeat
; writes: wFrameCounterLo
; points at: wC46E
Func_007_7690::
    ld hl, wC46E
    ld de, $7700
    ld a, [wFrameCounterLo]
    and a, $07
    jr z, Jump_007_76AC
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_76A9
    call Func_007_5066
    jr Jump_007_76AC

Jump_007_76A9::
    call Func_007_5046

Jump_007_76AC::
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_007_76C3
    ld a, [hl]
    cp a, $05
    jr c, Jump_007_76BF
    jr z, Jump_007_76F4
    sub a, $06
    jr Jump_007_76F4

Jump_007_76BF::
    add a, $06
    jr Jump_007_76F4

Jump_007_76C3::
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_76DD
    ld a, [hl]
    or a, a
    jr z, Jump_007_76D5
    cp a, $06
    jr z, Jump_007_76D9
    dec a
    jr Jump_007_76F4

Jump_007_76D5::
    ld a, $05
    jr Jump_007_76F4

Jump_007_76D9::
    ld a, $0A
    jr Jump_007_76F4

Jump_007_76DD::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    ret z
    ld a, [hl]
    cp a, $05
    jr z, Jump_007_76EF
    cp a, $0A
    jr z, Jump_007_76F2
    inc a
    jr Jump_007_76F4

Jump_007_76EF::
    xor a, a
    jr Jump_007_76F4

Jump_007_76F2::
    ld a, $06

Jump_007_76F4::
    ld [hl], a
    xor a, a
    ld [wFrameCounterLo], a
    call Func_007_5067
    call Func_007_5046
    ret
    db $43, $99, $45, $99, $47, $99, $49, $99, $4B, $99, $4D, $99, $83, $99, $85, $99
    db $87, $99, $89, $99, $8B, $99

; 1 call site from 1 routine (e.g. Func_007_7594)
Func_007_7716::
    ld bc, $0B00

Jump_007_7719::
    push bc
    ld a, c
    call Func_007_7724
    pop bc
    inc c
    dec b
    jr nz, Jump_007_7719
    ret

; 2 call sites from 2 routines (e.g. Func_007_7594, Func_007_7716)
; points at: wD049
Func_007_7724::
    ld c, a
    ld hl, $774D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld hl, wD049
    add_a_to_hl
    ld e, [hl]
    ld a, c
    ld hl, vBGMap0 + $E4
    add_a_to_hl
    ld a, e
    and a, d
    ld a, $C3
    jr nz, Jump_007_7749
    ld a, c

Jump_007_7749::
    call WriteVRAMByte
    ret
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $01, $80
    db $01, $40, $01, $20, $01, $10

Jump_007_7763::
    ld hl, wC46D
    ld de, $50BA
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_777E
    ld a, [wC46D]
    ld [wD0A1], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_777E::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    ld [wD0A1], a
    or a, a
    jr z, Jump_007_7797
    xor a, a
    ld [wD06B], a
    ret

Jump_007_7797::
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

Jump_007_77A0::
    ld hl, $589C
    call Func_007_4AFE
    ld hl, vBGMap0 + $E1
    ld de, wC279
    ld bc, $1205
    call Func_007_4B27
    call Func_007_7807
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_77BA::
    ld a, [wJoypadPressed]
    and a, $03
    jr z, Jump_007_77CB
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wD06B], a
    ret

Jump_007_77CB::
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_77E8
    ld a, [wD04B]
    and a, $80
    ld d, a
    ld a, [wD04B]
    and a, $7F
    cp a, $0B
    jr c, Jump_007_7806
    dec a
    or a, d
    ld [wD04B], a
    jr Jump_007_7803

Jump_007_77E8::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_007_7806
    ld a, [wD04B]
    and a, $80
    ld d, a
    ld a, [wD04B]
    and a, $7F
    cp a, $63
    jr nc, Jump_007_7806
    inc a
    or a, d
    ld [wD04B], a

Jump_007_7803::
    call Func_007_7807

Jump_007_7806::
    ret

; 2 call sites from 1 routine (e.g. Func_007_7724)
; reads: wD04B, wC8C1, wC8C2
; points at: wC5C6
Func_007_7807::
    ld a, [wD04B]
    and a, $7F
    push af
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld bc, wC5C6
    pop af
    cp a, $0B
    jr nc, Jump_007_781D
    ld b, $C3

Jump_007_781D::
    cp a, $63
    jr c, Jump_007_7823
    ld c, $C3

Jump_007_7823::
    ld hl, vBGMap0 + $12E
    ld a, b
    call WriteVRAMByteInc
    ld a, [wC8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7835
    ld a, $C3

Jump_007_7835::
    call WriteVRAMByteInc
    ld a, [wC8C2]
    add a, $E0
    call WriteVRAMByteInc
    ld a, c
    call WriteVRAMByte
    ret

Jump_007_7845::
    ld hl, wC46D
    ld de, $50BE
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    ld [wD0A2], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_7864::
    ld a, [wD06B]
    rst $00
    dw Jump_007_7880
    dw Jump_007_78D9
    dw Jump_007_78E8
    dw Jump_007_78F2
    dw Jump_007_791C
    dw Jump_007_792B
    dw Jump_007_795B
    dw Jump_007_796A
    dw Jump_007_7990
    dw Jump_007_79CF
    dw Jump_007_79E4
    dw Jump_007_79E9

Jump_007_7880::
    ld a, [wC58F]
    cp a, $FB
    jr z, Jump_007_7891
    cp a, $FC
    jr z, Jump_007_78A4
    cp a, $FD
    jr z, Jump_007_78B7
    jr Jump_007_78C2

Jump_007_7891::
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_78A4::
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    ret

Jump_007_78B7::
    ld a, $08
    ld [wCFC5], a
    ld a, $04
    ld [wD06A], a
    ret

Jump_007_78C2::
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call Func_007_4B27
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_78D9::
    ld hl, $0304
    call Func_007_512B
    xor a, a
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_78E8::
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_78F2::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_007_790E
    ld a, $02
    ld [wD06A], a
    ld a, $00
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ld a, $01
    ld [wC594], a
    ret

Jump_007_790E::
    cp a, $01
    ret nz
    ld hl, $0305
    call Func_007_512B
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_791C::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $02
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_792B::
    ld a, [wC58F]
    cp a, $02
    ret nz
    ld a, $0A
    ld [wC592], a
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD043
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $01
    ld [wC58C], a
    ld a, $FF
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_795B::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_796A::
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_6DE3
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $02
    ld [wC470], a
    ld a, $00
    ld [wC46D], a
    ld hl, wD06B
    inc [hl]
    call Func_007_4E11
    ret

Jump_007_7990::
    ld hl, wC46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_79BB
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    and a, $01
    jr nz, Jump_007_79C1
    ld a, $02
    ld [wD059], a
    ld a, $01
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_79BB::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_007_79C1::
    ld a, $FE
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_79CF::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, $05
    ld [wD06A], a
    ld a, $01
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ret

Jump_007_79E4::
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_79E9::
    ld a, $01
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    xor a, a
    ld [wD06C], a
    xor a, a
    ld [wD06B], a
    ret

Jump_007_79FC::
    ld a, [wD06B]
    and a, a
    jr z, Jump_007_7A05
    jp Jump_007_7AA7

Jump_007_7A05::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_007_7A12
    cp a, $FD
    jr z, Jump_007_7A2F
    jr Jump_007_7A45

Jump_007_7A12::
    ld a, [wC57F]
    bit 1, a
    jp z, Jump_007_7A9C
    ld a, $01
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ld a, $01
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    ret

Jump_007_7A2F::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_7A9C
    ld a, $08
    ld [wCFC5], a
    ld a, $04
    ld [wD06A], a
    xor a, a
    ld [wC594], a
    ret

Jump_007_7A45::
    ld a, [wC58F]
    cp a, $FC
    jr z, Jump_007_7A52
    cp a, $FB
    jr z, Jump_007_7A52
    jr Jump_007_7A9C

Jump_007_7A52::
    ld a, [wC46B]
    and a, a
    jr z, Jump_007_7A7A
    ld a, [wC58F]
    cp a, $FC
    jr z, Jump_007_7A9C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_7A9C
    call Func_007_6DA9
    ld a, $08
    ld [wCFC5], a
    ld a, $00
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    jr Jump_007_7A9C

Jump_007_7A7A::
    ld a, [wC58F]
    cp a, $FB
    jr z, Jump_007_7A9C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_007_7A9C
    call Func_007_6DC2
    ld a, $09
    ld [wCFC5], a
    ld a, $01
    ld [wD059], a
    ld a, $05
    ld [wD06A], a
    jr Jump_007_7A9C

Jump_007_7A9C::
    ld a, $08
    ld [wD06A], a
    ld a, $00
    ld [wD06B], a
    ret

Jump_007_7AA7::
    ld hl, wScreenTileBuffer
    ld bc, $0280
    ld a, $C3
    call FillBytes
    call Func_007_4B1E
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld hl, wD06A
    inc [hl]
    ret

Jump_007_7AC2::
    farcall Func_01B_660D
    ld hl, wD06A
    inc [hl]
    ret

Jump_007_7ACD::
    farcall Func_01B_665E
    ret

; 3 call sites from 3 routines (e.g. Func_007_6DE3, Func_007_7807, Func_007_7C5F)
; reads: wD09D, wD09E, wD09F, wD0A0, wD0A1, wD0A2
; points at: wC200, wC266, wC2A6, wC2E6, wC326, wC366
Func_007_7AD4::
    ld a, [wD09D]
    ld hl, wC200
    ld bc, $0006
    call Func_007_7B29
    ld a, [wD09E]
    ld hl, wC266
    ld bc, $0003
    call Func_007_7B29
    ld a, [wD09F]
    ld hl, wC2A6
    ld bc, $0003
    call Func_007_7B29
    ld a, [wD0A0]
    ld hl, wC2E6
    ld bc, $0003
    call Func_007_7B29
    ld a, [wD0A1]
    ld hl, wC326
    ld bc, $0003
    call Func_007_7B29
    ld a, [wD0A2]
    ld hl, wC366
    ld bc, $0003
    call Func_007_7B29
    call Func_007_7B30
    call Func_007_7B9D
    call Func_007_7C07
    call Func_007_7C5F
    ret

; 6 call sites from 1 routine (e.g. Func_007_7AD4)
Func_007_7B29::
    or a, a
    jr z, Jump_007_7B2D
    add hl, bc

Jump_007_7B2D::
    ld [hl], $BC
    ret

; 1 call site from 1 routine (e.g. Func_007_7AD4)
; reads: wD044, wD045
; points at: wC27F
Func_007_7B30::
    ld a, [wD044]
    ld c, a
    ld a, [wD045]
    ld b, a
    ld hl, wC27F
    ld a, $16
    bit 6, c
    jr z, Jump_007_7B48
    ld a, b
    rlca
    rlca
    and a, $01
    add a, $E0

Jump_007_7B48::
    ld [hl+], a
    ld a, $16
    bit 5, c
    jr z, Jump_007_7B57
    ld a, b
    rrca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B57::
    ld [hl+], a
    ld a, $16
    bit 4, c
    jr z, Jump_007_7B65
    ld a, b
    swap a
    and a, $01
    add a, $E0

Jump_007_7B65::
    ld [hl+], a
    ld a, $16
    bit 3, c
    jr z, Jump_007_7B74
    ld a, b
    rlca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B74::
    ld [hl+], a
    ld a, $16
    bit 2, c
    jr z, Jump_007_7B82
    ld a, b
    rrca
    rrca
    and a, $01
    add a, $E0

Jump_007_7B82::
    ld [hl+], a
    ld a, $16
    bit 1, c
    jr z, Jump_007_7B8F
    ld a, b
    rrca
    and a, $01
    add a, $E0

Jump_007_7B8F::
    ld [hl+], a
    ld a, $16
    bit 0, c
    jr z, Jump_007_7B9B
    ld a, b
    and a, $01
    add a, $E0

Jump_007_7B9B::
    ld [hl+], a
    ret

; 1 call site from 1 routine (e.g. Func_007_7AD4)
; reads: wD048, wD046, wC8C0, wC8C1, wC8C2, wD047
; points at: wC2BE, wC2C4
Func_007_7B9D::
    ld de, $7BFD
    ld a, [wD048]
    bit 6, a
    jr z, Jump_007_7BB2
    ld de, $7C02
    ld a, [wD046]
    ld c, a
    ld b, $00
    jr Jump_007_7BBC

Jump_007_7BB2::
    ld a, [wD047]
    ld c, a
    ld a, [wD048]
    and a, $01
    ld b, a

Jump_007_7BBC::
    push bc
    ld hl, wC2BE
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    pop hl
    call HLToDecimalDigits
    ld c, $01
    ld hl, wC2C4
    ld a, [wC8C0]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7BE5
    ld c, $00
    ld a, $C3

Jump_007_7BE5::
    ld [hl+], a
    ld a, [wC8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7BF5
    bit 0, c
    jr nz, Jump_007_7BF5
    ld a, $C3

Jump_007_7BF5::
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ret
    db $15, $12, $15, $0B, $10, $29, $0B, $16, $C3, $C3

; 1 call site from 1 routine (e.g. Func_007_7AD4)
; reads: wD049, wD04A
; points at: wC2FB
Func_007_7C07::
    ld a, [wD049]
    ld e, a
    ld a, [wD04A]
    ld d, a
    ld hl, wC2FB
    xor a, a
    bit 6, e
    jr nz, Jump_007_7C18
    ld [hl], a

Jump_007_7C18::
    inc a
    inc hl
    bit 5, e
    jr nz, Jump_007_7C1F
    ld [hl], a

Jump_007_7C1F::
    inc a
    inc hl
    bit 4, e
    jr nz, Jump_007_7C26
    ld [hl], a

Jump_007_7C26::
    inc a
    inc hl
    bit 3, e
    jr nz, Jump_007_7C2D
    ld [hl], a

Jump_007_7C2D::
    inc a
    inc hl
    bit 2, e
    jr nz, Jump_007_7C34
    ld [hl], a

Jump_007_7C34::
    inc a
    inc hl
    bit 1, e
    jr nz, Jump_007_7C3B
    ld [hl], a

Jump_007_7C3B::
    inc a
    inc hl
    bit 0, e
    jr nz, Jump_007_7C42
    ld [hl], a

Jump_007_7C42::
    inc a
    inc hl
    bit 7, d
    jr nz, Jump_007_7C49
    ld [hl], a

Jump_007_7C49::
    inc a
    inc hl
    bit 6, d
    jr nz, Jump_007_7C50
    ld [hl], a

Jump_007_7C50::
    inc a
    inc hl
    bit 5, d
    jr nz, Jump_007_7C57
    ld [hl], a

Jump_007_7C57::
    inc a
    inc hl
    bit 4, d
    jr nz, Jump_007_7C5E
    ld [hl], a

Jump_007_7C5E::
    ret

; 1 call site from 1 routine (e.g. Func_007_7AD4)
; reads: wD04B, wC8C1, wC8C2
; points at: wC346
Func_007_7C5F::
    ld a, [wD04B]
    ld l, a
    res 7, l
    ld h, $00
    call HLToDecimalDigits
    ld hl, wC346
    ld a, [wC8C1]
    or a, a
    jr z, Jump_007_7C76
    add a, $E0
    ld [hl], a

Jump_007_7C76::
    inc hl
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ret

Jump_007_7C7E::
    ld a, [wD06B]
    rst $00
    dw Jump_007_7C8C
    dw Jump_007_7CB7
    dw Jump_007_7CF8
    dw Jump_007_7D11
    dw Jump_007_7D24

Jump_007_7C8C::
    ld a, [wC58F]
    cp a, $FE
    jp z, Jump_007_7D24
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_6DE3
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $02
    ld [wC470], a
    ld a, $00
    ld [wC46D], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7CB7::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_007_7D24
    ld hl, wC46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_7CE4
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    and a, $01
    jr nz, Jump_007_7CEA
    ld a, $01
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7CE4::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_007_7CEA::
    ld a, $FE
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_007_7CF8::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_007_7D24
    cp a, $01
    ret nz
    ld a, $05
    ld [wD06A], a
    ld a, $01
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ret

Jump_007_7D11::
    ld a, $01
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ret

Jump_007_7D24::
    ld a, $01
    ld [wC594], a
    ld a, $02
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $01
    ld [wD06C], a
    ret

Jump_007_7D38::
    call Func_000_0535
    ld a, [wD06A]
    cp a, $01
    jr z, Jump_007_7D43
    ret

Jump_007_7D43::
    ld a, [wD780]
    cp a, $0C
    jr z, Jump_007_7DAB
    cp a, $0D
    jr z, Jump_007_7DCA
    ld a, [wC94B]
    or a, a
    ret z
    call Func_007_7DE5
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wCC44], a
    xor a, a
    ld [wC917], a
    ld a, $21
    ld [wC916], a
    farcall Func_013_405C
    farcall FetchScriptCommand
    ld a, $E0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hFF8C], a
    ld [wC6FD], a
    xor a, a
    ld [wC8C7], a
    ld a, [wC88D]
    ld [wC965], a
    xor a, a
    ld [wC88D], a
    xor a, a
    ld [wC58A], a
    ld [wC94B], a
    ld [wScriptInDataBank], a
    ld [wD7F0], a
    ret

Jump_007_7DAB::
    ld a, [wD782]
    and a, a
    ret nz
    ld a, [wD781]
    cp a, $15
    jr z, Jump_007_7DBC
    cp a, $20
    jr z, Jump_007_7DC3
    ret

Jump_007_7DBC::
    farcall Func_01D_5C35
    ret

Jump_007_7DC3::
    farcall Func_01D_5BF2
    ret

Jump_007_7DCA::
    ld a, [wD781]
    cp a, $15
    jr z, Jump_007_7DD6
    cp a, $20
    jr z, Jump_007_7DDD
    ret

Jump_007_7DD6::
    farcall Func_0F1_5719
    ret

Jump_007_7DDD::
    farcall Func_0F2_4EDD
    ret
    db $C9

; 1 call site from 1 routine (e.g. Func_007_7C5F)
; reads: wC57F, wD7B5, wD7B6, wD7F5, wD7F6, wD7F7, wC8C3
; writes: wD7F1, wD7AB, wD7AF, wD7F2, rRAMG2, rRAMB, wC8C3, wC8C4, ...
; points at: wCAD0, wCADB, wC7FC, wD7E0, wD780
Func_007_7DE5::
    ld a, [wC57F]
    bit 1, a
    jp z, Jump_007_7E6E
    ld a, $02
    ld [wD7F1], a
    farcall Func_00E_5688
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    ld a, $01
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

Jump_007_7E37::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_7E37
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
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

Jump_007_7E69::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_7E69

Jump_007_7E6E::
    xor a, a
    ld [wD7EB], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a

Jump_007_7E79::
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_007_7E79
    ld hl, wD780
    ld bc, $006F

Jump_007_7E8C::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_7E8C
    ret
    ds $16C, $00
