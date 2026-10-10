SECTION "Bank 37", ROMX[$4000], BANK[$37]
    db $37

; ld de, this bank's string table / BeginStringDisplay
; 17 call sites from 4 routines (e.g. GameMode0_Update, Func_003_5253, Func_003_5E68, Func_003_74E2)
BeginStringDisplay_Bank37::
Func_037_4001:: ; address name
    ld de, Data_037_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_037_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DC016, $B0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ", $F9, "W", $F1
    db "shattered!", $F7
    db $F0, $F9, "0 tried using", $F1
    db "the ", $F9, "W.", $F7
    db $F0, "But nothing", $F1
    db "happened!", $F7
    db $F0, $F9, "0 used the", $F1
    db $F9, "W on", $F7
    db $F2, $F9, "G!", $F7
    db $F0, $F9, "G's wounds", $F1
    db "were healed!", $F7
    db $F0, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0, $F9, "0 scattered", $F1
    db "the ", $F9, "W!", $F7
    db $F0, $F9, "G", $F1
    db "regained MP.", $F7
    db $F0, $F9, "G was cured of", $F1
    db "poison.", $F7
    db $F0, $F9, "G was cured of", $F1
    db "paralysis.", $F7
    db $F0, $F9, "G snapped", $F1
    db "out of confusion.", $F7
    db $F0, $F9, "G was", $F1
    db "uncursed.", $F7
    db $F0, $F9, "G woke up.", $F7
    db $F0, $F9, "G came", $F1
    db "back to life.", $F7
    db $F0, $F9, "G's max.HP", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "G's max.MP", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "G's ATK", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "G's DEF", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "G's AGL", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "G's INT", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0, $F9, "0 gave ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0, $F9, "G happily ate", $F1
    db "the treat.", $F7
    db $F2, $F9, "G's affection", $F1
    db "for "
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " rose!", $F7
    db $F0, $F9, "G fearfully", $F1
    db "ate the foul mess.", $F7
    db $F2, $F9, "G glared with", $F1
    db "a sour expression.", $F7
    db $F2, $F9, "G became", $F1
    db "poisoned.", $F7
    db $F0, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0, $F9, "0 tossed the", $F1
    db $F9, "W up.", $F7
    db $F0, $F9, "0 used the", $F1
    db $F9, "W!", $F7
    db $F0, $F9, "0 read ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0, "A stirring tale of", $F1
    db "honor, sacrifice", $F7
    db $F2, "and heroism made", $F1
    db $F9, "G brave.", $F7
    db $F0, "A bloodcurdling", $F1
    db "tale of horror", $F7
    db $F2, "turned ", $F9, "G", $F1
    db "cowardly.", $F7
    db $F0, "A heartwarming", $F1
    db "tale of selfless", $F7
    db $F2, "compassion made", $F1
    db $F9, "G kind.", $F7
    db $F0, "A shameless tale", $F1
    db "of greed, lies and", $F7
    db $F2, "deception made", $F1
    db $F9, "G sly.", $F7
    db $F0, "A practical guide", $F1
    db "on thinking in a", $F7
    db $F2, "rational manner", $F1
    db "made ", $F9, "G smart.", $F7
    db $F0, "A hilarious tale", $F1
    db "made ", $F9, "G simple.", $F7
    db $F0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0, "The Orb glowed", $F1
    db "with a warm light.", $F7
    db $F0, "The presence of", $F1
    db "monsters faded.", $F7
    db $F0, $F9, "0 strummed", $F1
    db "the ", $F9, "W!", $F7
    db $F0, "Want to record", $F1
    db "your journey?", $F0, "Your progress has", $F1
    db "been recorded.", $F7
    db $F0, $F9, "G equipped", $F1
    db "the ", $F9, "W.", $F7
    db $F0, $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F0, $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9, "'r's wounds", $F1
    db "were healed.", $F7
    db $F0, $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9, "'r's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9
    db $50
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "'s wounds", $F1
    db "were healed.", $F7
    db $F0, $F9, "0 gripped", $F1
    db "the ", $F9, "W.", $F7
    db $F0, "The MarkStaff", $F1
    db "was sensed at", $F7
    db $F2, $F9, "0", $A3, " ", $F9, "G and", $F1
    db $F9, "W", $A3, " ", $F9, "m.", $F7
    db $F0, "The MarkStaff was", $F1
    db "not sensed.", $F7
    db $F2, "It doesn't appear", $F1
    db "to have been used.", $F7
    db $F0, $F9, "0 put down", $F1
    db "the ", $F9, "W.", $F7
    db $F0, "The Guide Bell's", $F1
    db "clear note echoed!", $F7
    db $F0, $F9, "0 gave ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0, $F9, "G switched its", $F1
    db $F9, "m with the", $F7
    db $F2, $F9, "W.", $F7
    db $F0, $A4, "But that monster", $F1
    db "is dead", $A4, $F7
    db $F0, $F9, "m was", $F1
    db "uncursed.", $F7
    db $F0, $F9, "m was", $F1
    db "uncursed.", $F7
    db $F2, $F9, "'r was", $F1
    db "uncursed.", $F7
    db $F0, $F9, "m was", $F1
    db "uncursed.", $F7
    db $F2, $F9, "'r was", $F1
    db "uncursed.", $F7
    db $F2, $F9
    db $50
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " was", $F1
    db "uncursed.", $F7
    db $F0, $F9, "0 cast", $F1
    db $F9, "W!", $F7
    db $F0, $F9, "0 whistled!", $F7
    db $F0, $F9, "0 released its", $F1
    db "Pheromone.", $F7
    db $F0, $F9, "0 scanned the", $F1
    db "surroundings.", $FA, $F7
    db $F0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " asked ", $F9, "0", $F1
    db "to run an errand.", $F7
    db $F0, $F9, "0 scanned the", $F1
    db "area sharply.", $F7
    db $F0, $F9, "G's wounds", $F1
    db "were healed!", $F7
    db $F0, $F9, "G regained MP!", $F7
    db $F0, $F9, "G came back to", $F1
    db "life!", $F7
    db $F0, $F9, "G was cured of", $F1
    db "poison.", $F7
    db $F0, $F9, "G was", $F1
    db "uncursed.", $F7
    db $F0, $F9, "0 whispered in", $F1
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "'s ear.", $FA, $F7
    db $F0, $F9, "0", $A3, " There are", $F1
    db $F9, "m around.", $FA, $F7
    db $F0, $F9, "0 finished", $F1
    db "talking.", $F7
    db $F0, $F9, "0 ran off with", $F1
    db "100G.", $FA, $F7
    db $F2, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $F1
    db $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $FA, $F7
    db $F0, $F9, "0 returned", $F1
    db "with an item.", $FA, $F7
    db $F2
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " obtained one", $F1
    db $F9, "m.", $F7
    db $F0, $F9, "0 came back", $F1
    db "with nothing", $A4, $F7
    db $F0, $F9, "0 sensed a", $F1
    db "treasure nearby.", $FA, $F7
    db $F2, "It appears to be", $F1
    db "very close.", $F7
    db $F0, "But nothing", $F1
    db "happened.", $F7
    db $F0, $F9, "G did not come", $F1
    db "back to life", $A4, $F7
    db $F0, "But it couldn't be", $F1
    db "used here.", $F7
    db $F0, "But there were no", $F1
    db "monsters nearby.", $F7
    db $F0, "But there is no", $F1
    db "room for it", $A4, $F7
    db $F0, "But there wasn't", $F1
    db "enough money.", $F7
    db $F0, "There are no", $F1
    db "treasures nearby.", $F7
    db $F0, "Not enough MP!", $F1
    db $F7
    db $F0, "A dead monster", $F1
    db "can't use a skill.", $F7
    db $F0, "That can't be used", $F1
    db "in the field.", $F7
    db $F0, "The surroundings", $F1
    db "became clear.", $F7
    db $F0

; 1 call site from 1 routine (e.g. Func_01B_44D6)
; reads: wFadeState, wD780
Func_037_4AFD::
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wD780]
    rst $00
    dw Jump_037_4B2A
    dw Jump_037_4B38
    dw Jump_037_4B7A
    dw Jump_037_4B8B
    dw Jump_037_4BEB
    dw Jump_037_4B5B
    dw Jump_037_4B6A
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_5301
    dw Jump_037_53C0
    dw Jump_037_57D0
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_531D

Jump_037_4B2A::
    farcall ScriptCommandE8_Run
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_037_4B38::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_037_4B44::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_4B44
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

Jump_037_4B5B::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $03
    ld [wC594], a
    ld hl, wD780
    inc [hl]
    ret

Jump_037_4B6A::
    ld a, [wC58F]
    cp a, $03
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $01
    ld [wD780], a
    ret

Jump_037_4B7A::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $02
    ld [wC594], a
    ld hl, wD06A
    inc [hl]
    ret

Jump_037_4B8B::
    ld a, [wD781]
    rst $00
    dw Jump_037_4B97
    dw Jump_037_4BA4
    dw Jump_037_4BC9
    dw Jump_037_4BDA

Jump_037_4B97::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4BA4::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    or a, a
    jr z, Jump_037_4BC1
    cp a, $02
    ret nz
    ld a, $05
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld a, $15
    call Func_037_5999
    ret

Jump_037_4BC1::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4BC9::
    xor a, a
    ld [wC594], a
    ld a, $09
    call Func_037_5999
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4BDA::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_037_4BEB::
    ld a, [wD781]
    rst $00
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4D80
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C5B
    dw Jump_037_523F
    dw Jump_037_525F
    dw Jump_037_526F
    dw Jump_037_4D43
    dw Jump_037_4C9D
    dw Jump_037_4C33
    dw Jump_037_4DC2
    dw Jump_037_4CA9
    dw Jump_037_4DE9
    dw Jump_037_4E75
    dw Jump_037_4EB6
    dw Jump_037_4EF9
    dw Jump_037_4F49
    dw Jump_037_4F5E
    dw Jump_037_4FFD
    dw Jump_037_5041
    dw Jump_037_50D9
    dw Jump_037_5136
    dw Jump_037_4EB6
    dw Jump_037_5216
    dw Jump_037_4FD5
    dw Func_037_5172
    dw Jump_037_4EC8
    dw Jump_037_52EA
    dw Jump_037_524E

Jump_037_4C33::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FD
    jr nz, Jump_037_4C54
    ld a, $09
    ld [wD781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [wC594], a
    ld a, $01
    ld [wD2CC], a
    ret

Jump_037_4C54::
    farcall ScriptCommandED_Run
    ret

Jump_037_4C5B::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FD
    jr nz, Jump_037_4C7C
    ld a, $09
    ld [wD781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [wC594], a
    ld a, $01
    ld [wD2CC], a
    ret

Jump_037_4C7C::
    farcall ScriptCommandED_Run
    ld a, [wD7F9]
    cp a, $FE
    ret nz
    ld a, $09
    ld [wD781], a
    ld a, $13
    call Func_037_5999
    ld a, $FD
    ld [wC594], a
    ld a, $00
    ld [wD2CC], a
    ret

Jump_037_4C9D::
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ret

Jump_037_4CA9::
    ld a, [wD7B4]
    cp a, $FF
    jr z, Jump_037_4CC1
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ld a, $09
    call Func_037_5999
    ret

Jump_037_4CC1::
    ld a, [wD782]
    rst $00
    dw Jump_037_4CDB
    dw Jump_037_4CF1
    dw Jump_037_4D03
    dw Jump_037_4D1A
    dw Jump_037_4CDB
    dw Jump_037_4CF1
    dw Jump_037_4D03
    dw Jump_037_4D1A
    dw Jump_037_4CDB
    dw Jump_037_4D2D
    dw Jump_037_4D1A

Jump_037_4CDB::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld a, $07
    call Func_037_5999
    ret

Jump_037_4CF1::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld a, $01
    ld [wC594], a
    ret

Jump_037_4D03::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $09
    call Func_037_5999
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_4D1A::
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    xor a, a
    ld [wD7B4], a
    ld [wD782], a
    ret

Jump_037_4D2D::
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $09
    call Func_037_5999
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_4D43::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr nz, Jump_037_4D5B
    ld a, $04
    call Func_037_5999
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_4D5B::
    farcall ScriptCommandED_Run
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
    xor a, a
    ld [wD782], a
    ret

Jump_037_4D80::
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
    call Func_037_5AD3
    ld de, Data_037_647D
    ld hl, wC36C
    ld bc, $0C05
    call Func_037_5AFA
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

Jump_037_4DC2::
    ld a, [wC52B]
    and a, a
    ret nz

; 1 call site from 1 routine (e.g. Func_037_4DC7)
; reads: wD781
; writes: wD7F1, wD7F2, wD781, wD7B4
Func_037_4DC7::
    ld b, $00
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_037_5A5D
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7B4], a
    ret

Jump_037_4DE9::
    ld a, [wC52B]
    and a, a
    ret nz
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
    jr nc, Jump_037_4E25
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld a, $05
    call Func_037_5999
    ret

Jump_037_4E25::
    pop hl
    ld a, [hl]
    ld c, a
    ld a, [wC6FD]
    ld b, a
    ld de, wC6FE

Jump_037_4E2F::
    ld a, [de]
    cp a, c
    jr z, Jump_037_4E39
    inc de
    dec b
    jr nz, Jump_037_4E2F
    jr Jump_037_4E4B

Jump_037_4E39::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld a, $06
    call Func_037_5999
    ret

Jump_037_4E4B::
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4E75::
    ld a, [wC52B]
    and a, a
    ret nz
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

Jump_037_4E94::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_4E94
    xor a, a
    ld [rRAMG2], a
    call Func_037_5BC6
    ld a, $07
    call Func_037_5999
    call Func_037_4DC7
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ret

Jump_037_4EB6::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wC594], a
    ret

Jump_037_4EC8::
    ld a, $64
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld hl, wD09D
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD09D
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4EF9::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_037_4F18
    cp a, $FD
    ret nz
    ld a, $09
    ld [wD781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [wC594], a
    ld a, $01
    ld [wD2CC], a
    ret

Jump_037_4F18::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $95
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld hl, wD09D
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD132
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_037_4F49::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC58C], a
    call Func_037_5C4E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4F5E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wC994
    ld a, [wC994]
    and a, $01
    ld b, a
    ld a, [wCA39]
    and a, $01
    cp a, b
    jr nz, Jump_037_4F89
    ld a, $08
    call Func_037_5999
    ld a, $10
    ld [wD781], a
    ld a, $08
    ld [wD782], a
    ld a, $FF
    ld [wD7B4], a
    ret

Jump_037_4F89::
    xor a, a
    ld [wC594], a
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0D01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0E
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
    ld a, $0B
    call Func_037_5999
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_4FD5::
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_037_4FE7
    ld a, $02
    ld [wD7F1], a
    farcall Func_00E_5688

Jump_037_4FE7::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld b, a

Jump_037_4FEF::
    push bc
    call Func_037_5172
    pop bc
    ld a, [wD781]
    cp a, b
    jr z, Jump_037_4FEF
    jp Jump_037_4EC8

Jump_037_4FFD::
    ld a, [wC52B]
    and a, a
    ret nz
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
    ld [wD7FA], a
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_037_64D7
    ld hl, wC3E7
    ld bc, $0907
    call Func_037_5AFA
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5041::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_037_5065
    call Func_037_5976
    ld a, $21
    ld [wD781], a
    ld a, $14
    call Func_037_5999
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD2CC], a
    ret

Jump_037_5065::
    call Func_037_59A3
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_5073
    cp a, $FF
    jr z, Jump_037_508B
    ret

Jump_037_5073::
    call Func_037_5976
    ld a, $21
    ld [wD781], a
    ld a, $13
    call Func_037_5999
    ld a, $FE
    ld [wC594], a
    ld a, $00
    ld [wD2CC], a
    ret

Jump_037_508B::
    ld a, [wD7FA]
    cp a, $02
    jr z, Jump_037_5073
    cp a, $01
    jr z, Jump_037_50AE
    ld a, [wD7FA]
    ld b, $BC
    ld hl, Data_037_6516
    call StoreBAtWordTableEntry_Bank37
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $0C
    call Func_037_5999
    ret

Jump_037_50AE::
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, $0D
    ld [wD780], a
    ret

Jump_037_50D9::
    ld a, [wC52B]
    and a, a
    ret nz
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
    ld de, Data_037_64B9
    ld hl, wC412
    ld bc, $0605
    call Func_037_5AFA
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5136::
    ld a, [wC52B]
    and a, a
    ret nz
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_514F
    cp a, $FF
    jr z, Jump_037_515A
    ret

Jump_037_514F::
    ld a, $0B
    call Func_037_5999
    ld a, $17
    ld [wD781], a
    ret

Jump_037_515A::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_037_514F
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $07
    call Func_037_5999
    ret

; 1 call site from 1 routine (e.g. Func_037_4DC7)
; reads: wC52B, wD782, wD781, wC57F, wD7B5, wD7B6, wD7F5, wD7F6, ...
; writes: wD782, wD781, wD7AB, wD7AF, wD7F1, wD7F2, rRAMG2, rRAMB, ...
; points at: wCAD0, wCADB, wC7FC, wD7E0
Func_037_5172::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr z, Jump_037_5189
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5189::
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_037_5198
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_5198::
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

Jump_037_51D7::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_51D7
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

Jump_037_5209::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_037_5209
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_5216::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_037_5235
    cp a, $FE
    ret nz
    ld a, $21
    ld [wD781], a
    ld a, $14
    call Func_037_5999
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD2CC], a
    ret

Jump_037_5235::
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_037_4FD5

Jump_037_523F::
    ld a, [wC58F]
    cp a, $FD
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    jr Jump_037_525F

Jump_037_524E::
    ld a, [wC58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $0A
    ld [wD781], a
    jr Jump_037_525F

Jump_037_525F::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a

Jump_037_526F::
    ld a, [wD782]
    rst $00
    dw Jump_037_5277
    dw Jump_037_52BF

Jump_037_5277::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld b, $64
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_037_5296
    ld b, $48
    ld a, [wD2CC]
    or a, a
    jr z, Jump_037_5296
    ld b, $45

Jump_037_5296::
    ld a, b
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld hl, wD09D
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD09D
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_037_52BF::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC58C], a
    ld hl, wD780
    ld bc, $006F

Jump_037_52CF::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_52CF
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wC594], a
    ret

Jump_037_52EA::
    ld a, [wC58F]
    cp a, $F0
    jr z, Jump_037_52F2
    ret

Jump_037_52F2::
    xor a, a
    ld [wC594], a
    ld a, $01
    ld [wC94B], a
    ld a, $01
    ld [wD7EB], a
    ret

Jump_037_5301::
    farcall ScriptCommandE8_Run
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

Jump_037_531D::
    ld a, [wD781]
    rst $00
    dw Jump_037_533C
    dw Func_037_5344
    dw Jump_037_5335
    dw Jump_037_5335
    dw Jump_037_5335
    dw Jump_037_4D80
    dw Jump_037_5352
    dw Jump_037_539F
    dw Jump_037_5335
    dw Jump_037_5335

Jump_037_5335::
    farcall ScriptCommandED_Run
    ret

Jump_037_533C::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_037_542C)
; reads: wD781
; writes: wD781
Func_037_5344::
    farcall Func_0F2_4A0B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5352::
    ld hl, vTiles1 + $270
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
    ld hl, vTiles1 + $780
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
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
    ld hl, wD781
    inc [hl]
    ret

Jump_037_539F::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_53C0::
    ld a, [wD781]
    rst $00
    dw Jump_037_5407
    dw Jump_037_5415
    dw Jump_037_5424
    dw Jump_037_5452
    dw Jump_037_5471
    dw Jump_037_547F
    dw Jump_037_5486
    dw Jump_037_54D1
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_550A
    dw Jump_037_552B
    dw Jump_037_5565
    dw Jump_037_5570
    dw Jump_037_5593
    dw Jump_037_55A0
    dw Jump_037_55C6
    dw Jump_037_5611
    dw Jump_037_564E
    dw Jump_037_565A
    dw Jump_037_5668
    dw Jump_037_5676
    dw Jump_037_5683
    dw Jump_037_5691
    dw Jump_037_56F3
    dw Jump_037_5715
    dw Jump_037_5760
    dw Jump_037_5789
    dw Jump_037_579B

Jump_037_5406::
    ret

Jump_037_5407::
    farcall Func_01F_7494
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5415::
    farcall Func_0F2_49CF
    farcall Func_01F_7375
    call Func_037_542C

Jump_037_5424::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_037_5344)
; writes: wC52D, wC52E, wC52F, wC530
; points at: wCA2C
Func_037_542C::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, wCA2C
    call Func_037_5912
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ret

Jump_037_5452::
    call BGMapAddressAtScroll_Bank37
    ld de, Data_037_687F
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_037_595F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5471::
    farcall Func_0F2_5002
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_547F::
    farcall Func_01F_73EC
    ret

Jump_037_5486::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_54A8
    cp a, $FF
    jr z, Jump_037_54B0
    ret

Jump_037_54A8::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_54B0::
    call BGMapAddressAtScroll_Bank37
    ld de, $0161
    add hl, de
    ld de, Data_037_651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_037_595F
    ld a, $0E
    ld [wD781], a
    ret

Jump_037_54D1::
    call BGMapAddressAtScroll_Bank37
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, $5E12
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
    farcall Func_01F_5D9A
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_037_550A::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F02
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_552B::
    ld hl, vTiles1 + $270
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
    ld hl, vTiles1 + $780
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5565::
    call Func_037_5929
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5570::
    call BGMapAddressAtScroll_Bank37
    ld de, $0068
    add hl, de
    ld de, Data_037_6577
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_037_595F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5593::
    farcall Func_0F2_4AFE
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_037_55A0::
    ld a, $6D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld a, $EA
    ld [wD7F3], a
    ld a, $C7
    ld [wD7F4], a
    farcall Func_0F2_50E2
    farcall Func_0F2_4B05
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_037_55C6::
    ld a, [wCA36]
    ld [wD7F1], a
    ld a, [wCA37]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973
    ld a, $F0
    ldh [hFFBA], a
    farcall Func_0F2_4BD0
    call BGMapAddressAtScroll_Bank37
    ld de, $0160
    add hl, de
    ld de, Data_037_66DF
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_037_595F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5611::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_563F
    cp a, $FF
    jr z, Jump_037_5633
    ret

Jump_037_5633::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_037_563F::
    xor a, a
    ldh [hFFBA], a
    farcall Func_01F_74E3
    ld a, $04
    ld [wD781], a
    ret

Jump_037_564E::
    farcall Func_0F2_4F47
    ld a, $0F
    ld [wD781], a
    ret

Jump_037_565A::
    farcall Func_01F_753A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5668::
    farcall Func_01F_7591
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5676::
    farcall Func_01F_7601
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_037_5683::
    farcall Func_0F2_4BFC
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5691::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_56B3
    cp a, $FF
    jr z, Jump_037_56D4
    ret

Jump_037_56B3::
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_56D4::
    ld hl, vTiles2 + $730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call Func_037_5895
    farcall Func_01F_76B5
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ret

Jump_037_56F3::
    ld a, [wD782]
    and a, a
    jr nz, Jump_037_5707
    farcall Func_01F_7754
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_037_5707::
    farcall Func_0F2_49CF
    call Func_037_5344
    xor a, a
    ld [wD782], a
    ret

Jump_037_5715::
    farcall Func_0F2_4F47
    ld hl, vTiles1 + $270
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
    call Func_037_5929
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
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
    ld a, $11
    ld [wD781], a
    ret

Jump_037_5760::
    call BGMapAddressAtScroll_Bank37
    ld de, $0008
    add hl, de
    ld de, Data_037_63D7
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_037_595F
    farcall Func_0F2_4E76
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_5789::
    farcall Func_0F2_4C36
    ld a, $F0
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_579B::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    jr z, Jump_037_57BD
    cp a, $FE
    jr z, Jump_037_57BE
    cp a, $FF
    jr z, Jump_037_57C7

Jump_037_57BD::
    ret

Jump_037_57BE::
    xor a, a
    ldh [hFFBA], a
    ld a, $17
    ld [wD781], a
    ret

Jump_037_57C7::
    xor a, a
    ldh [hFFBA], a
    ld a, $07
    ld [wD781], a
    ret

Jump_037_57D0::
    ld a, [wD781]
    rst $00
    dw Jump_037_57E8
    dw Func_037_5344
    dw Jump_037_580D
    dw Jump_037_580D
    dw Jump_037_580D
    dw Jump_037_4D80
    dw Jump_037_5352
    dw Jump_037_539F
    dw Jump_037_5821
    dw Jump_037_57FC

Jump_037_57E8::
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_037_57FC::
    ld a, [wD780]
    push af
    ld a, $11
    ld [wD780], a
    farcall ScriptCommandED_Run
    pop af
    ret

Jump_037_580D::
    ld a, [wD780]
    push af
    ld a, $11
    ld [wD780], a
    farcall ScriptCommandED_Run
    pop af
    ld [wD780], a
    ret

Jump_037_5821::
    ld de, Data_037_64D7
    ld hl, wC3E7
    ld bc, $0907
    call Func_037_5AFA
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0D01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0E
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
; reads: wCA36, wCA37
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
Func_037_5870:: ; heuristic: follows a terminator; C0
    ld a, [wCA36]
    ld [wD7F1], a
    ld a, [wCA37]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $90
    ld [wD7F4], a
    ld a, $40
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    farcall Func_01D_6A3D
    ret

; 1 call site from 1 routine (e.g. Func_037_542C)
Func_037_5895::
    ld hl, Data_037_58AE
    ld de, vTiles2 + $6E0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ld de, vTiles2 + $7C0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ret

Data_037_58AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DD8AE, $50

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
; 5 call sites from 1 routine (e.g. Func_037_5895)
; reads: rSTAT
CopyTileBytesToVRAM_Bank37::
Func_037_58FE:: ; address name
    xor a, a

Jump_037_58FF::
    push af
    di

Jump_037_5901::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_037_5901
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_037_58FF
    ret

; 2 call sites from 2 routines (e.g. Func_037_5929, Func_037_542C)
; points at: wC8CF
Func_037_5912::
    ld de, wC8CF
    ld c, $00

Jump_037_5917::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_037_5925
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_037_5917

Jump_037_5925::
    ld a, $F0
    ld [de], a
    ret

; 2 call sites from 1 routine (e.g. Func_037_542C)
; writes: wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530
; points at: wCA2C, wCA36
Func_037_5929::
    ld hl, wCA2C
    call Func_037_5912
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wCA36
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld hl, vTiles1 + $270
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    ret

; 5 call sites from 1 routine (e.g. Func_037_542C)
; writes: wD7F5, wD7F6, wD7F1, wD7F2
Func_037_595F::
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01F_5D2A
    ret

; 2 call sites from 1 routine (e.g. Func_037_4DC7)
; writes: wD7F1, wD7F2
Func_037_5976::
    ld b, $00
    ld c, $07
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [wD7F1], a
    ld a, $09
    ld [wD7F2], a
    call Func_037_5A5D
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ret

; 22 call sites from 3 routines (e.g. Func_037_4AFD, Func_037_5172, Func_037_4DC7)
; writes: wStringIndex
Func_037_5999::
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0E
    ret

; 1 call site from 1 routine (e.g. Func_037_4DC7)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7FA
; writes: wD7F9, wD7FA, wD783
Func_037_59A3::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_037_59C1
    bit 7, a
    jr nz, Jump_037_59D7
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_037_59FD
    bit 1, a
    jr nz, Jump_037_5A0B
    call Func_037_5A11
    xor a, a
    ld [wD7F9], a
    ret

Jump_037_59C1::
    call Func_037_5A2F
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_037_59D1
    ld a, $02
    ld [wD7FA], a
    jr Jump_037_59EB

Jump_037_59D1::
    dec a
    ld [wD7FA], a
    jr Jump_037_59EB

Jump_037_59D7::
    call Func_037_5A2F
    ld a, [wD7FA]
    cp a, $02
    jr c, Jump_037_59E7
    xor a, a
    ld [wD7FA], a
    jr Jump_037_59EB

Jump_037_59E7::
    inc a
    ld [wD7FA], a

Jump_037_59EB::
    xor a, a
    ld [wD783], a
    call Func_037_5A2B
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wD7F9], a
    ret

Jump_037_59FD::
    call Func_037_5A33
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wD7F9], a
    ret

Jump_037_5A0B::
    ld a, $FE
    ld [wD7F9], a
    ret

; 1 call site from 1 routine (e.g. Func_037_59A3)
; reads: wJoypadRepeatTimer, wD783, wD7FA
; writes: wD783
Func_037_5A11::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_037_5A2B
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, Func_037_5A2B
    cp a, $18
    jr c, Func_037_5A2F
    xor a, a
    ld [wD783], a

; 1 call site from 1 routine (e.g. Func_037_59A3)
; reads: wD7FA
Func_037_5A2B::
    ld b, $BB
    jr Jump_037_5A35

; 2 call sites from 1 routine (e.g. Func_037_59A3)
; reads: wD7FA
Func_037_5A2F::
    ld b, $C3
    jr Jump_037_5A35

; 1 call site from 1 routine (e.g. Func_037_59A3)
; reads: wD7FA
Func_037_5A33::
    ld b, $BC

Jump_037_5A35::
    ld a, [wD7FA]
    sla a
    ld hl, Data_037_5A57
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank37
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_037_5A57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $00, $2C, $01, $6C, $01

; 2 call sites from 2 routines (e.g. Func_037_5976, Func_037_4DC7)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_037_5A5D::
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_037_5AB7
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_037_5AA2
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank37
    pop de
    pop hl

Jump_037_5AA2::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_037_5AB1
    inc d

Jump_037_5AB1::
    inc b
    ld a, b
    cp a, c
    jr c, Func_037_5A5D
    ret

; 1 call site from 1 routine (e.g. Func_037_5A5D)
Func_037_5AB7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_037_5AB7
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. Func_037_5A5D)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank37::
Func_037_5AC0:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_037_5AC4::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_5AC4
    ld a, $00
    ldh [rSVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_037_4AFD)
; reads: hFFC6, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_037_5AD3::
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

; 4 call sites from 3 routines (e.g. Func_037_4DC7, Func_037_542C, Func_037_4AFD)
; reads: wIsCGB
; writes: rSVBK
Func_037_5AFA::
    push hl
    push bc

Jump_037_5AFC::
    push hl
    push bc

Jump_037_5AFE::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5AFE
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_037_5AFC
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_037_5B25::
    push hl
    push bc

Jump_037_5B27::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_037_5B27
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_037_5B25
    ld a, $00
    ldh [rSVBK], a
    ret

; 4 call sites from 2 routines (e.g. Func_037_4DC7, Func_037_5976)
; reads: wIsCGB
; writes: wC554, wC555, rSVBK
; points at: wScreenTileBuffer, wD000
Func_037_5B3F::
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    xor a, a
    call Func_000_160B
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    pop de
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    xor a, a
    call Func_000_160B
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 11 call sites from 4 routines (e.g. Func_037_4DC7, Func_037_5976, Func_037_5A33, Func_037_542C)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank37::
Func_037_5B95:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. Func_037_4DC7)
StoreBAtWordTableEntry_Bank37::
Func_037_5BB6:: ; address name
    push bc
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; 1 call site from 1 routine (e.g. Func_037_4DC7)
; reads: wD043
; writes: wD043
; points at: wD09D, wC986
Func_037_5BC6::
    ld hl, wD09D
    ld de, wC986
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    call Func_037_5DA9
    call Func_037_5DBC
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    dec de
    and a, c
    ld [wD043], a
    cp a, $FF
    jr nz, Jump_037_5BF5
    call Func_037_5CBC
    jr Jump_037_5C07

Jump_037_5BF5::
    call Func_037_5DA9
    call Func_037_5DA9
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de

Jump_037_5C07::
    call Func_037_5DEB
    ld b, $12
    call Func_037_5D08
    call Func_037_5E3E
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, $28
    ld [hl+], a
    inc de
    ld a, $E6
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, $E6
    ld [hl+], a
    inc de
    ld b, $1A
    call Func_037_5D08
    ld a, $00
    ld [hl+], a
    inc de
    ld a, [wD043]
    cp a, $FF
    jr nz, Jump_037_5C3C
    call Func_037_5CC8
    jr Jump_037_5C47

Jump_037_5C3C::
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl], a

Jump_037_5C47::
    farcall Func_081_5453
    ret

; 1 call site from 1 routine (e.g. Func_037_4DC7)
; writes: wD006, wD007, wD043
; points at: wCA2B, wD132
Func_037_5C4E::
    ld hl, wCA2B
    ld de, wD132
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    call Func_037_5ED0
    ld a, c
    ld [wD006], a
    ld a, b
    ld [wD007], a
    call Func_037_5EE7
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [wD043], a
    cp a, $FF
    jr nz, Jump_037_5C80
    call Func_037_5CE6
    jr Jump_037_5C95

Jump_037_5C80::
    call Func_037_5ED0
    call Func_037_5ED0
    call Func_037_5FB8
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de

Jump_037_5C95::
    call Func_037_5EF7
    ld b, $12
    call Func_037_5D08
    call Func_037_5F4A
    ld b, $06
    call Func_037_5D08
    call Func_037_5FAD
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    ld [hl], $00
    farcall Func_019_73DF
    ret

; 1 call site from 1 routine (e.g. Func_037_5BC6)
Func_037_5CBC::
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a

; 1 call site from 1 routine (e.g. Func_037_5BC6)
Func_037_5CC8::
    call Func_037_5CCB

; 1 call site from 1 routine (e.g. Func_037_5CC8)
Func_037_5CCB::
    ld a, e
    add a, $0B
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
Func_037_5CE6::
    inc de
    inc de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_037_5CF1

; 1 call site from 1 routine (e.g. Func_037_5CE6)
Func_037_5CF1::
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

; 5 call sites from 3 routines (e.g. Func_037_5C4E, Func_037_5FAD, Func_037_5BC6)
Func_037_5D08::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Func_037_5D08
    ret

; 1 call site from 1 routine (e.g. Func_037_5EC0)
Func_037_5D0F::
    cp a, $5C
    jr z, Jump_037_5D43
    cp a, $5E
    jr z, Jump_037_5D47
    cp a, $5F
    jr z, Jump_037_5D4B
    cp a, $60
    jr z, Jump_037_5D4F
    cp a, $61
    jr z, Jump_037_5D53
    cp a, $63
    jr z, Jump_037_5D57
    cp a, $64
    jr z, Jump_037_5D5B
    cp a, $0E
    jr nc, Jump_037_5D37
    cp a, $0A
    jr c, Jump_037_5D37
    sub a, $0A
    jr Jump_037_5D5D

Jump_037_5D37::
    cp a, $58
    jr nc, Jump_037_5D5D
    cp a, $24
    jr c, Jump_037_5D5D
    sub a, $1A
    jr Jump_037_5D5D

Jump_037_5D43::
    ld a, $95
    jr Jump_037_5D5D

Jump_037_5D47::
    ld a, $AB
    jr Jump_037_5D5D

Jump_037_5D4B::
    ld a, $B5
    jr Jump_037_5D5D

Jump_037_5D4F::
    ld a, $94
    jr Jump_037_5D5D

Jump_037_5D53::
    ld a, $93
    jr Jump_037_5D5D

Jump_037_5D57::
    ld a, $99
    jr Jump_037_5D5D

Jump_037_5D5B::
    ld a, $98

Jump_037_5D5D::
    ret

; 6 call sites from 1 routine (e.g. Func_037_5BC6)
Func_037_5D5E::
    ld c, $00
    ld b, $08

Jump_037_5D62::
    ld a, [de]
    cp a, $95
    jr z, Jump_037_5D83
    cp a, $AB
    jr z, Jump_037_5D87
    cp a, $B5
    jr z, Jump_037_5D8B
    cp a, $94
    jr z, Jump_037_5D8F
    cp a, $93
    jr z, Jump_037_5D93
    cp a, $0A
    jr c, Jump_037_5D95
    cp a, $3E
    jr nc, Jump_037_5D95
    add a, $1A
    jr Jump_037_5D95

Jump_037_5D83::
    ld a, $5C
    jr Jump_037_5D95

Jump_037_5D87::
    ld a, $5E
    jr Jump_037_5D95

Jump_037_5D8B::
    ld a, $5F
    jr Jump_037_5D95

Jump_037_5D8F::
    ld a, $60
    jr Jump_037_5D95

Jump_037_5D93::
    ld a, $61

Jump_037_5D95::
    inc c
    bit 2, c
    jr z, Jump_037_5DA1
    bit 0, c
    jr z, Jump_037_5DA1
    dec c
    ld a, $F0

Jump_037_5DA1::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_5D62
    inc de
    inc de
    ret

; 3 call sites from 1 routine (e.g. Func_037_5BC6)
Func_037_5DA9::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $61
    ld h, a
    ld a, [hl]
    pop hl
    ld [hl+], a
    ret

; 1 call site from 1 routine (e.g. Func_037_5BC6)
; reads: wD008
; writes: wD006, wD007
Func_037_5DBC::
    ld a, [de]
    and a, $0F
    inc de
    cp a, $09
    jr nz, Jump_037_5DE3
    push hl
    dec hl
    ld a, [hl]
    ld hl, Data_037_5FC7
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    push de
    farcall Func_035_400A
    pop de
    pop hl
    ld a, [wD008]

Jump_037_5DE3::
    cp a, $0A
    jr nz, Jump_037_5DE9
    ld a, $09

Jump_037_5DE9::
    ld [hl+], a
    ret

; 1 call site from 1 routine (e.g. Func_037_5BC6)
; points at: wD21D, wD225
Func_037_5DEB::
    ld b, $21
    push hl

Jump_037_5DEE::
    ld a, [de]
    inc de
    cp a, $FF
    jr z, Jump_037_5DFF
    push hl
    ld hl, Data_037_63D3
    add_a_to_hl
    ld a, [hl]
    pop hl

Jump_037_5DFF::
    ld [hl+], a
    dec b
    jr nz, Jump_037_5DEE
    pop hl
    push de
    push hl
    ld de, wD21D
    ld b, $21
    ld a, $FF

Jump_037_5E0D::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_5E0D
    ld b, $08
    ld de, wD21D

Jump_037_5E17::
    ld a, [hl+]
    cp a, $FE
    jr nc, Jump_037_5E1E
    ld [de], a
    inc de

Jump_037_5E1E::
    dec b
    jr nz, Jump_037_5E17
    ld b, $19
    ld de, wD225

Jump_037_5E26::
    ld a, [hl+]
    cp a, $FE
    jr nc, Jump_037_5E2D
    ld [de], a
    inc de

Jump_037_5E2D::
    dec b
    jr nz, Jump_037_5E26
    pop hl
    ld b, $21
    ld de, wD21D

Jump_037_5E36::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5E36
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_037_5BC6)
Func_037_5E3E::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call CompareHLToBC
    jr nz, Jump_037_5E52
    ld bc, $01FF
    jr Jump_037_5E64

Jump_037_5E52::
    push de
    ld a, $33
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, Jump_037_5E61
    inc hl

Jump_037_5E61::
    ld b, h
    ld c, l
    pop de

Jump_037_5E64::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call CompareHLToBC
    jr nz, Jump_037_5E7D
    ld bc, $00FF
    jr Jump_037_5E8F

Jump_037_5E7D::
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, Jump_037_5E8C
    inc hl

Jump_037_5E8C::
    ld b, h
    ld c, l
    pop de

Jump_037_5E8F::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call CompareHLToBC
    jr nz, Jump_037_5EA8
    ld bc, $00FF
    jr Jump_037_5EBA

Jump_037_5EA8::
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, Jump_037_5EB7
    inc hl

Jump_037_5EB7::
    ld b, h
    ld c, l
    pop de

Jump_037_5EBA::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

; 6 call sites from 1 routine (e.g. Func_037_5C4E)
Func_037_5EC0::
    ld b, $08

Jump_037_5EC2::
    ld a, [de]
    call Func_037_5D0F
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_5EC2
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ret

; 3 call sites from 1 routine (e.g. Func_037_5C4E)
Func_037_5ED0::
    ld a, [de]
    inc de
    push hl
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $C7
    ld l, a
    ld a, h
    adc a, $5F
    ld h, a
    ld a, [hl+]
    ld b, [hl]
    pop hl
    ld [hl+], a
    ld [hl], b
    ld c, a
    inc hl
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
; reads: wD008
Func_037_5EE7::
    push hl
    push de
    farcall Func_035_4001
    pop de
    pop hl
    ld a, [wD008]
    ld [hl+], a
    inc de
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
; points at: wD21D, wD225
Func_037_5EF7::
    ld b, $21
    push hl

Jump_037_5EFA::
    ld a, [de]
    inc de
    cp a, $FF
    jr z, Jump_037_5F0B
    push hl
    ld hl, Data_037_62F5
    add_a_to_hl
    ld a, [hl]
    pop hl

Jump_037_5F0B::
    ld [hl+], a
    dec b
    jr nz, Jump_037_5EFA
    pop hl
    push de
    push hl
    ld de, wD21D
    ld b, $21
    ld a, $FF

Jump_037_5F19::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_5F19
    ld b, $08
    ld de, wD21D

Jump_037_5F23::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_037_5F2A
    ld [de], a
    inc de

Jump_037_5F2A::
    dec b
    jr nz, Jump_037_5F23
    ld b, $19
    ld de, wD225

Jump_037_5F32::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_037_5F39
    ld [de], a
    inc de

Jump_037_5F39::
    dec b
    jr nz, Jump_037_5F32
    pop hl
    ld b, $21
    ld de, wD21D

Jump_037_5F42::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5F42
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
Func_037_5F4A::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $01FF
    call CompareHLToBC
    jr nz, Jump_037_5F5E
    ld bc, $03E7
    jr Jump_037_5F70

Jump_037_5F5E::
    push de
    ld a, $C3
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, Jump_037_5F6D
    inc hl

Jump_037_5F6D::
    ld b, h
    ld c, l
    pop de

Jump_037_5F70::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    call Func_037_5F78

; 1 call site from 1 routine (e.g. Func_037_5F4A)
Func_037_5F78::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $00FF
    call CompareHLToBC
    jr nz, Jump_037_5F8C
    ld bc, $03E7
    jr Jump_037_5FA7

Jump_037_5F8C::
    push de
    push bc
    ld a, $5B
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, Jump_037_5F9C
    inc hl

Jump_037_5F9C::
    ld b, h
    ld c, l
    pop hl
    ld d, h
    ld e, l
    add hl, hl
    add hl, de
    add hl, bc
    ld b, h
    ld c, l
    pop de

Jump_037_5FA7::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
; reads: wD034
Func_037_5FAD::
    ld b, $1A
    call Func_037_5D08
    ld a, [wD034]
    ld [hl+], a
    inc de
    ret

; 1 call site from 1 routine (e.g. Func_037_5C4E)
Func_037_5FB8::
    push af
    push bc
    push de
    push hl
    farcall Func_081_4001
    pop hl
    pop de
    pop bc
    pop af
    ret

Data_037_5FC7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DDFC7, $85
    dw Data_037_6100
    dw Data_037_6200
    dw Data_037_6300
    dw Data_037_6A00
    dw Data_037_6B00
    dw Data_037_6C00
    dw Data_037_6D00
    dw Data_037_6E00
    dw Data_037_6F00
    dw Data_037_7000
    dw Data_037_7100
    dw Data_037_7300
    dw Data_037_7500
    dw Data_037_7600
    dw Data_037_7700
    dw Data_037_7800
    dw Data_037_7900
    dw Data_037_7B00
    dw Data_037_7C00
    dw Data_037_7D00
    dw Data_037_7F00
    INCBIN "dwm2-cobi-us.gbc", $0DE076, $8A

Data_037_6100:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DE100, $5A
    dw Data_037_6201
    dw Data_037_6301
    dw Data_037_6501
    dw Data_037_6601
    dw Data_037_6801
    dw Data_037_6A01
    dw Data_037_6B01
    dw Data_037_6C01
    dw Data_037_6D01
    dw Data_037_6E01
    dw Data_037_6F01
    dw Data_037_7001
    dw Data_037_7101
    INCBIN "dwm2-cobi-us.gbc", $0DE174, $8C

Data_037_6200:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6201:: ; heuristic: target of a monotone pointer table; C0
    db $00, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $6A, $62, $63, $64, $65, $5F, $66
    db $67, $68, $69, $6A, $6B, $67, $6C, $6C, $6D, $6D, $63, $65, $00, $00, $00, $00
    db $00, $00, $00, $00
    dw Data_037_6F6E
    dw Data_037_7170
    dw Data_037_7372
    dw Data_037_7574
    dw Data_037_7678
    dw Data_037_7877
    dw Data_037_7A79
    dw Data_037_7C7B
    dw Data_037_7E7D
    INCBIN "dwm2-cobi-us.gbc", $0DE237, $BE

Data_037_62F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B

Data_037_6300:: ; heuristic: target of a monotone pointer table; C0
    db $0C

Data_037_6301:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DE301, $A4
    ds $25, $FF
    db $3B, $54, $58, $59, $67, $34, $C8, $35, $8F

Data_037_63D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $00, $01, $02

Data_037_63D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DE3D7, $A6

Data_037_647D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_037_64B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_037_64D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $60, $61, $62, $62
    db $63, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $64, $65
    db $66, $67, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3

Data_037_6501:: ; heuristic: target of a monotone pointer table; C0
    db $C3, $C3, $B7, $B6, $C3, $C3, $68, $69, $6A, $6B, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B4, $B4, $B4, $B5

Data_037_6516:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FC, $C3, $24, $C4, $4C

Data_037_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C4
    ds $5B, $00

Data_037_6577:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $8A, $00

Data_037_6601:: ; heuristic: target of a monotone pointer table; C0
    ds $DE, $00

Data_037_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $122, $00

Data_037_6801:: ; heuristic: target of a monotone pointer table; C0
    ds $7E, $00

Data_037_687F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $181, $00

Data_037_6A00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6A01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6B00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6B01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6C00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6C01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6D00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6D01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6E00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6E01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6F00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6F01:: ; heuristic: target of a monotone pointer table; C0
    ds $6D, $00

Data_037_6F6E:: ; heuristic: target of a monotone pointer table; C0
    ds $92, $00

Data_037_7000:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_7001:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_7100:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_7101:: ; heuristic: target of a monotone pointer table; C0
    ds $6F, $00

Data_037_7170:: ; heuristic: target of a monotone pointer table; C0
    ds $190, $00

Data_037_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $72, $00

Data_037_7372:: ; heuristic: target of a monotone pointer table; C0
    ds $18E, $00

Data_037_7500:: ; heuristic: target of a monotone pointer table; C0
    ds $74, $00

Data_037_7574:: ; heuristic: target of a monotone pointer table; C0
    ds $8C, $00

Data_037_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $78, $00

Data_037_7678:: ; heuristic: target of a monotone pointer table; C0
    ds $88, $00

Data_037_7700:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_037_7800:: ; heuristic: target of a monotone pointer table; C0
    ds $77, $00

Data_037_7877:: ; heuristic: target of a monotone pointer table; C0
    ds $89, $00

Data_037_7900:: ; heuristic: target of a monotone pointer table; C0
    ds $179, $00

Data_037_7A79:: ; heuristic: target of a monotone pointer table; C0
    ds $87, $00

Data_037_7B00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_037_7C00:: ; heuristic: target of a monotone pointer table; C0
    ds $7B, $00

Data_037_7C7B:: ; heuristic: target of a monotone pointer table; C0
    ds $85, $00

Data_037_7D00:: ; heuristic: target of a monotone pointer table; C0
    ds $17D, $00

Data_037_7E7D:: ; heuristic: target of a monotone pointer table; C0
    ds $83, $00

Data_037_7F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00
