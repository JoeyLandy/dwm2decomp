SECTION "Bank 1D", ROMX[$4000], BANK[$1D]
    db $1D

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1D)
BeginStringDisplay_Bank1D::
Func_01D_4001:: ; address name
    ld de, StringCategories_1D_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD

; address loaded by DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01
Data_01D_4010:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_1D_4016::
Data_01D_4016:: ; address name
    dw StringList_1D_4018 ; id 0

; E-0217 (derived: category list of StringCategories_1D_4016; one pointer per wStringIndex)
; record: string
StringList_1D_4018::
Data_01D_4018:: ; address name
    dw String_1D_00_00 ; id 0
    dw String_1D_00_00 ; id 1
    dw String_1D_00_02 ; id 2
    dw String_1D_00_03 ; id 3
    dw String_1D_00_04 ; id 4
    dw String_1D_00_05 ; id 5
    dw String_1D_00_06 ; id 6
    dw String_1D_00_07 ; id 7
    dw String_1D_00_08 ; id 8
    dw String_1D_00_09 ; id 9
    dw String_1D_00_0A ; id 10
    dw String_1D_00_0B ; id 11
    dw String_1D_00_0C ; id 12
    dw String_1D_00_0D ; id 13
    dw String_1D_00_0E ; id 14
    dw String_1D_00_0F ; id 15
    dw String_1D_00_10 ; id 16
    dw String_1D_00_11 ; id 17
    dw String_1D_00_12 ; id 18
    dw String_1D_00_13 ; id 19
    dw String_1D_00_14 ; id 20
    dw String_1D_00_15 ; id 21
    dw String_1D_00_16 ; id 22
    dw String_1D_00_16 ; id 23

String_1D_00_00:: ; heuristic: string; C0
Data_01D_4048:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which monster", $F1
    db "will hibernate?", $F0

String_1D_00_02:: ; heuristic: string; C0
Data_01D_4069:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you need me", $F1
    db "for anything else?", $F0

String_1D_00_03:: ; heuristic: string; C0
Data_01D_408E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So this one", $F1
    db "should hibernate?", $F0

String_1D_00_04:: ; heuristic: string; C0
Data_01D_40AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " OK my friend,", $F1
    db "time to sleep!", $F7
    db $F0

String_1D_00_05:: ; heuristic: string; C0
Data_01D_40D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? There's no", $F1
    db "one on the farm.", $F7
    db $F0

String_1D_00_06:: ; heuristic: string; C0
Data_01D_40F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Uh-oh, the", $F1
    db "stable is full!", $F7
    db $F0

String_1D_00_07:: ; heuristic: string; C0
Data_01D_4113:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Want to switch", $F1
    db "with someone?", $F0

String_1D_00_08:: ; heuristic: string; C0
Data_01D_4133:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who should I", $F1
    db "wake up?", $F0

String_1D_00_09:: ; heuristic: string; C0
Data_01D_414C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wake this", $F1
    db "monster up?", $F0

String_1D_00_0A:: ; heuristic: string; C0
Data_01D_4165:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which one should", $F1
    db "hibernate?", $F0

String_1D_00_0B:: ; heuristic: string; C0
Data_01D_4184:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So switch ", $F9, "0", $F1
    db "and ", $F9, "G, huh?", $FA, $F7
    db $F2, "OK, I'll do that", $F1
    db "for you.", $F7
    db $F0

String_1D_00_0C:: ; heuristic: string; C0
Data_01D_41BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who should I", $F1
    db "wake up?", $F0

String_1D_00_0D:: ; heuristic: string; C0
Data_01D_41D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll send ", $F9, "G", $F1
    db "to the farm.", $F7
    db $F0

String_1D_00_0E:: ; heuristic: string; C0
Data_01D_41F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? No one's", $F1
    db "sleeping now.", $F7
    db $F0

String_1D_00_0F:: ; heuristic: string; C0
Data_01D_4212:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? There's no", $F1
    db "room on the farm.", $F7
    db $F0

String_1D_00_10:: ; heuristic: string; C0
Data_01D_4237:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Should someone", $F1
    db "else hibernate?", $F0

String_1D_00_11:: ; heuristic: string; C0
Data_01D_4259:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who do you want", $F1
    db "to check?", $F0

String_1D_00_12:: ; heuristic: string; C0
Data_01D_4276:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who do you want", $F1
    db "to release?", $F0

String_1D_00_13:: ; heuristic: string; C0
Data_01D_4295:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It'll disappear.", $F1
    db "Is that OK?", $F0

String_1D_00_14:: ; heuristic: string; C0
Data_01D_42B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was released", $F1
    db "in the wild.", $F7
    db $F0

String_1D_00_15:: ; heuristic: string; C0
Data_01D_42D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Come see me if", $F1
    db "you get more", $FA, $F7
    db $EF, $EE, "monsters.", $EF, $EE, "I'll be waiting.", $F7
    db $F0

String_1D_00_16:: ; heuristic: string; C0
Data_01D_4310:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No one else can", $F1
    db "hibernate,I see.", $F7
    db $F0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1D_4335:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
Script_1D_4336:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_434B, Script_1D_4348, Script_1D_4342, Script_1D_433C
Script_1D_433C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE_CLOSE
    script_message $8015 ; 'Come see me if you get'
    script_command SCRIPT_HIBERNATE_CLOSE
    script_end
Script_1D_4342:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_448B
    db $07, $6D, $44

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1D_4348:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_43D9
Script_1D_434B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_435C, Script_1D_4353, Script_1D_4350
Script_1D_4350:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_435F
Script_1D_4353:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Huh? There's no one on the'
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_435C:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4389
Script_1D_435F:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'Which monster will hibernate?'
Script_1D_4362:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_436C, Script_1D_4366
Script_1D_4366:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_436C:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'So this one should hibernate?'
Script_1D_436F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_437B, Script_1D_437F, Script_1D_4374
Script_1D_4374:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'Which monster will hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_4362
Script_1D_437B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_436F
Script_1D_437F:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'OK my friend, time to sleep!'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_4389:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'Uh-oh, the stable is full!'
    script_message $C007 ; 'Want to switch with someone?'
Script_1D_438F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4399, Script_1D_4393
Script_1D_4393:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_4399:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43A7, Script_1D_43A0
Script_1D_43A0:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C007 ; 'Want to switch with someone?'
    script_jump Script_1D_438F
Script_1D_43A7:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43B1, Script_1D_43AE
Script_1D_43AE:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4399
Script_1D_43B1:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C00A ; 'Which one should hibernate?'
Script_1D_43B5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43BC, Script_1D_43B9
Script_1D_43B9:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4399
Script_1D_43BC:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'So this one should hibernate?'
Script_1D_43BF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43CB, Script_1D_43CF, Script_1D_43C4
Script_1D_43C4:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_43B5
Script_1D_43CB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_43BF
Script_1D_43CF:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'So switch 0 and G, huh?'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_43D9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43F8, Script_1D_43EF, Script_1D_43F2, Script_1D_43E6, Script_1D_43E0
Script_1D_43E0:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'No one else can hibernate,I see.'
    script_jump Script_1D_43E9
Script_1D_43E6:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'Huh? No one's sleeping now.'
Script_1D_43E9:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_43EF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_441B
Script_1D_43F2:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Huh? There's no room on the'
    script_jump Script_1D_43E9
Script_1D_43F8:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4406, Script_1D_43FF
Script_1D_43FF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_4406:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4410, Script_1D_440D
Script_1D_440D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_43F8
Script_1D_4410:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'I'll send G to the farm.'
    script_command SCRIPT_HIBERNATE
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_441B:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Huh? There's no room on the'
    script_message $C010 ; 'Should someone else hibernate?'
Script_1D_4421:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_442B, Script_1D_4425
Script_1D_4425:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_442B:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'Which one should hibernate?'
Script_1D_442E:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4438, Script_1D_4432
Script_1D_4432:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; 'Should someone else hibernate?'
    script_jump Script_1D_4421
Script_1D_4438:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'So this one should hibernate?'
Script_1D_443B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4447, Script_1D_444B, Script_1D_4440
Script_1D_4440:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_442E
Script_1D_4447:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_443B
Script_1D_444B:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4459, Script_1D_4452
Script_1D_4452:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_442E
Script_1D_4459:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4463, Script_1D_4460
Script_1D_4460:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_444B
Script_1D_4463:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'So switch 0 and G, huh?'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
    db $EB, $E4, $0A, $00, $00, $05, $C0, $00, $02, $C0, $07, $36, $43, $00, $11, $C0
    db $EB, $E4, $07, $00, $00, $02, $C0, $07, $36, $43, $EB, $07, $7D, $44

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1D_448B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4498, Script_1D_448F
Script_1D_448F:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'Huh? No one's sleeping now.'
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_4498:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; 'Who do you want to release?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_44A6, Script_1D_449F
Script_1D_449F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336
Script_1D_44A6:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; 'It'll disappear. Is that OK?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_44B0, Script_1D_44AD
Script_1D_44AD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4498
Script_1D_44B0:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'G was released in the wild.'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; 'Do you need me for anything'
    script_jump Script_1D_4336

; only called from VaultMenu_Store_Case00 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case00)
; reads: wScreenState, wScreenStep
; writes: wScreenStep
VaultMenu_Store_Case00_Sub01::
Func_01D_44BA:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01D_44C6
    ld hl, BGMap1TileRun_1D_4547
    jr Jump_01D_44C9

Jump_01D_44C6::
    ld hl, BGMap1TileRun_1D_44E3

Jump_01D_44C9::
    ld de, vBGMap1 + $300

Jump_01D_44CC::
    ld a, [hl]
    cp a, $7F
    jr z, Jump_01D_44DB
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    jr Jump_01D_44CC

Jump_01D_44DB::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0226 (C1: VaultMenu_Case03_Case00_Sub01 copies bytes from $44E3 to vBGMap1 + $300 until $7F (wScreenState = 3)).
; record: 99 tiles written in a run from vBGMap1 + $300 (32 per BG map row), then $7F
BGMap1TileRun_1D_44E3::
Data_01D_44E3:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A6, $CF, $A5, $A7, $DF, $EB, $AD, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9 ; entry 0
    db $BA, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B4, $B4, $B5
    db $7F ; end

; E-0226 (C1: VaultMenu_Case03_Case00_Sub01 copies bytes from $4547 to vBGMap1 + $300 until $7F (any other wScreenState)).
; record: 99 tiles written in a run from vBGMap1 + $300 (32 per BG map row), then $7F
BGMap1TileRun_1D_4547::
Data_01D_4547:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $EA, $EB, $AD, $ED, $EE, $EF, $AB, $AC, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9 ; entry 0
    db $BA, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B4, $B4, $B5
    db $7F ; end

; copies three tiles from bank $1F to vTiles2 + $7A0-$7C0, then draws the 4 x 1 rows Data_01D_4603, 4607 and 460B at scroll + $62, $A2 and $E2 (E-0121)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case02)
LoadThreeTilesAndDrawRows4603To460B::
Func_01D_45AB:: ; address name
    ld hl, vTiles2 + $7A0
    ld de, Tiles2Plus210Tiles_1F_4130
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7B0
    ld de, Tiles2Plus7B0Tiles_1F_4310
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7C0
    ld de, Tiles1Plus7C0Tiles_1F_4300
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank1D
    ld de, $0062
    add hl, de
    ld bc, $0401
    ld de, TileRect_1D_4603
    call DrawRectSetTextCursorLoPlus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00A2
    add hl, de
    ld bc, $0401
    ld de, TileRect_1D_4607
    call DrawRectSetTextCursorLoPlus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00E2
    add hl, de
    ld bc, $0401
    ld de, TileRect_1D_460B
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 1 tiles, one row per line
TileRect_1D_4603::
Data_01D_4603:: ; address name
    db $7A, $AD, $CF, $7B ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 1 tiles, one row per line
TileRect_1D_4607::
Data_01D_4607:: ; address name
    db $BF, $A7, $7C, $EE ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 1 tiles, one row per line
TileRect_1D_460B::
Data_01D_460B:: ; address name
    db $A9, $A4, $EB, $AD ; id 0

; only called from VaultMenu_TakeOut_Case03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_TakeOut_Case03)
; reads: wScreenStep, wScreenByteED, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, wGoldHi, wGoldMid, wGoldLo, ...
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_TakeOut_Case03_Sub01::
Func_01D_460F:: ; address name
    call Func_01D_47AF
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_462C
    cp a, $02
    jr z, Jump_01D_461D
    ret

Jump_01D_461D::
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_462C::
    ld a, [wScreenByteED]
    and a, a
    jr z, Jump_01D_464C
    cp a, $01
    jr z, Jump_01D_4689
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

Jump_01D_4642::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_464C::
    call Func_01D_4A62
    ld a, [wSavedSpriteClipMode]
    and a, a
    jr z, Jump_01D_466C
    ld a, [wListPages]
    cp a, $18
    jr z, Jump_01D_467A
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_466C::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_467A::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_4689::
    ld a, [wBankedGoldHi]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, [wBankedGoldMid]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, [wBankedGoldLo]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_46AA::
    ld a, [wGoldHi]
    cp a, $01
    jr c, Jump_01D_46D4
    jr nz, Jump_01D_46C5
    ld a, [wGoldMid]
    cp a, $86
    jr c, Jump_01D_46D4
    jr nz, Jump_01D_46C5
    ld a, [wGoldLo]
    cp a, $3B
    jr c, Jump_01D_46D4
    jr z, Jump_01D_46D4

Jump_01D_46C5::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4642

Jump_01D_46D4::
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp Jump_01D_4642

; only called from VaultMenu_Store_Case03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case03)
; reads: wScreenStep, wScreenByteED, wGoldHi, wGoldMid, wGoldLo, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, ...
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Store_Case03_Sub01::
Func_01D_46E1:: ; address name
    call Func_01D_47AF
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_46FE
    cp a, $02
    jr z, Jump_01D_46EF
    ret

Jump_01D_46EF::
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_46FE::
    ld a, [wScreenByteED]
    and a, a
    jr z, Jump_01D_471E
    cp a, $01
    jr z, Jump_01D_4758
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

Jump_01D_4714::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_471E::
    ld a, [wListPages]
    and a, a
    jr z, Jump_01D_473B
    call VaultMenu_Store_Case03_Sub01_Sub01
    cp a, $FF
    jr z, Jump_01D_4749
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_473B::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_4749::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_4758::
    ld a, [wGoldHi]
    and a, a
    jr nz, Jump_01D_477A
    ld a, [wGoldMid]
    and a, a
    jr nz, Jump_01D_477A
    ld a, [wGoldLo]
    cp a, $64
    jr nc, Jump_01D_477A
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_477A::
    ld a, [wBankedGoldHi]
    cp a, $0F
    jr c, Jump_01D_47A2
    jr nz, Jump_01D_4793
    ld a, [wBankedGoldMid]
    cp a, $41
    jr c, Jump_01D_47A2
    jr nz, Jump_01D_4793
    ld a, [wBankedGoldLo]
    cp a, $DC
    jr c, Jump_01D_47A2

Jump_01D_4793::
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp Jump_01D_4714

Jump_01D_47A2::
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp Jump_01D_4714

; 2 call sites from 2 routines (e.g. VaultMenu_TakeOut_Case03_Sub01, VaultMenu_Store_Case03_Sub01)
; reads: wJoypadPressedRepeat, wScreenByteED
; writes: wScreenByteED
Func_01D_47AF::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_47C8
    bit 7, a
    jr nz, Jump_01D_47E3
    bit 0, a
    jr nz, Jump_01D_47F3
    bit 1, a
    jp nz, Jump_01D_47FE
    call BlinkCursorBlinkEF_Bank1D_4801
    xor a, a
    ret

Jump_01D_47C8::
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wScreenByteED]
    and a, a
    jr nz, Jump_01D_47D5
    ld a, $02
    jr Jump_01D_47D6

Jump_01D_47D5::
    dec a

Jump_01D_47D6::
    ld [wScreenByteED], a
    call DrawCursorTileBB_481B_Bank1D
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ret

Jump_01D_47E3::
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wScreenByteED]
    cp a, $02
    jr c, Jump_01D_47F0
    xor a, a
    jr Jump_01D_47D6

Jump_01D_47F0::
    inc a
    jr Jump_01D_47D6

Jump_01D_47F3::
    call Func_01D_4823
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

Jump_01D_47FE::
    ld a, $02
    ret

; cycles wD7EF through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. Func_01D_47AF)
; reads: wJoypadRepeatTimer, wCursorBlinkEF, wScreenByteED
; writes: wCursorBlinkEF
BlinkCursorBlinkEF_Bank1D_4801::
Func_01D_4801:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_481B_Bank1D
    ld a, [wCursorBlinkEF]
    inc a
    ld [wCursorBlinkEF], a
    cp a, $10
    jr c, DrawCursorTileBB_481B_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_481F_Bank1D
    xor a, a
    ld [wCursorBlinkEF], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. Func_01D_47AF)
; reads: wScreenByteED
DrawCursorTileBB_481B_Bank1D::
Func_01D_481B:: ; address name
    ld b, $BB
    jr Jump_01D_4825

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. Func_01D_47AF)
; reads: wScreenByteED
DrawBlankTileC3_481F_Bank1D::
Func_01D_481F:: ; address name
    ld b, $C3
    jr Jump_01D_4825

; 1 call site from 1 routine (e.g. Func_01D_47AF)
; reads: wScreenByteED
Func_01D_4823::
    ld b, $BC

Jump_01D_4825::
    ld a, [wScreenByteED]
    add a, a
    ld hl, Data_01D_4842
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by Func_01D_4823
Data_01D_4842:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $00, $A1, $00, $E1, $00

; draws rect $0088 (9 x 12) at vBGMap1 + $370 (Func_01D_5917) and wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToDrawRect0088AtBGMap1370AndStep)
; reads: wScreenStep
; writes: wScreenStep
DrawRect0088AtBGMap1370AndStep::
Func_01D_4848:: ; address name
    ld hl, $0088
    ld de, vBGMap1 + $370
    ld bc, $090C
    call SaveBGMapRectWithAttrs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws rect $0140 (3 x 7) at vBGMap1 + $3E0; in state 3 also runs Func_01C_689A and Func_0F2_6449; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case06)
; reads: wScreenState, wScreenStep
; writes: wScreenStep
DrawRect0140AtBGMap13E0AndStep::
Func_01D_485C:: ; address name
    ld hl, $0140
    ld de, vBGMap1 + $3E0
    ld bc, $0307
    call SaveBGMapRectWithAttrs
    ld a, [wScreenState]
    cp a, $03
    jr nz, Jump_01D_487B
    farcall ListDistinctInventoryItemsToItemGrid
    farcall Run64C7UnlessScreenStateIs3

Jump_01D_487B::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; only called from VaultMenu_Store_Case07 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case07)
; reads: wSavedSpriteSlotCount, wIsCGB, wScreenStep
; writes: wArg1, wScreenStep
VaultMenu_Store_Case07_Sub01::
Func_01D_4883:: ; address name
    ld a, $01
    ld [wArg1], a
    call VaultMenu_Store_Shared03
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01D_48A5
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, TileRect_1D_48FC
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D
    jr Jump_01D_48B6

Jump_01D_48A5::
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, TileRect_1D_4968
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D

Jump_01D_48B6::
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_48C5
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01D_48C5::
    ld bc, $0000

Jump_01D_48C8::
    push hl

Jump_01D_48C9::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $0C
    jr c, Jump_01D_48C9
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $09
    jr c, Jump_01D_48C8
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_1D_48FC::
Data_01D_48FC:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C7, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF, $C8, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $C9, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $AA, $CA, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $C5, $C3, $C3, $BE, $C3, $C3, $C6, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_1D_4968::
Data_01D_4968:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C7, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF, $C8, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $C9, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $AA, $CA, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; only called from VaultMenu_Store_Case08 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case08)
; reads: wDigits, wSavedSpriteSlotCount, wItemGridY, wScreenStep
; writes: wArg1, wDigits, wScreenStep, wScreenCounter, wGlyphListPos
VaultMenu_Store_Case08_Sub01::
Func_01D_49D4:: ; address name
    xor a, a
    ld [wArg1], a
    call VaultMenu_Store_Shared03
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_01D_49E9
    ld a, $E3
    ld [wDigits + $1], a

Jump_01D_49E9::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01D_4A3F
    call BGMapAddressAtScroll_Bank1D
    ld de, $0190
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    inc hl
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_01D_4A22
    ld a, $E3
    ld [wDigits + $1], a

Jump_01D_4A22::
    call BGMapAddressAtScroll_Bank1D
    ld de, $018D
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei

Jump_01D_4A3F::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; C = the number of non-zero bytes among the $18 bytes at wD7D5 (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Shared03)
; points at: wItemGrid
CountNonZeroItemGridBytes::
Func_01D_4A4E:: ; address name
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

Jump_01D_4A55::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A5A
    inc c

Jump_01D_4A5A::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_4A55
    ret

; 5 call sites from 4 routines (e.g. VaultMenu_TakeOut_Case03_Sub01, VaultMenu_Store_Shared03, VaultMenu_Store_Case0E_Sub01, VaultMenu_Setup_Case02)
; writes: wSavedSpriteClipMode, wListPages
; points at: wItemStorage, wInventory
Func_01D_4A62::
    ld hl, wItemStorage
    ld c, $00
    ld b, $00

Jump_01D_4A69::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A72
    cp a, $FF
    jr z, Jump_01D_4A72
    inc c

Jump_01D_4A72::
    inc hl
    inc hl
    inc b
    ld a, b
    cp a, $64
    jr c, Jump_01D_4A69
    ld a, c
    ld [wSavedSpriteClipMode], a
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01D_4A85::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A8E
    cp a, $FF
    jr z, Jump_01D_4A8E
    inc c

Jump_01D_4A8E::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_4A85
    ld a, c
    ld [wListPages], a
    ret

; cycles wD7B4 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wItemGridX
; writes: wSelectedRecord
BlinkCursorSelectedRecord_Bank1D_4A9A:: ; heuristic: follows a terminator; C0
Func_01D_4A9A:: ; address name
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp a, $10
    jr c, Jump_01D_4AAD
    cp a, $18
    jr c, VaultMenu_Store_Shared03_Sub01
    xor a, a
    ld [wSelectedRecord], a

Jump_01D_4AAD::
    ld b, $BB
    jr Jump_01D_4AB7

; only called from VaultMenu_Store_Shared03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Shared03)
; reads: wItemGridX
VaultMenu_Store_Shared03_Sub01::
Func_01D_4AB1:: ; address name
    ld b, $C3
    jr Jump_01D_4AB7
    db $06, $BC

Jump_01D_4AB7::
    ld a, [wItemGridX]
    add a, a
    ld hl, Data_01D_4AD4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by VaultMenu_Store_Shared03_Sub01
Data_01D_4AD4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from VaultMenu_Store_Case0A (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0A)
; reads: wScreenState, wItemGridY, wItemGridX, wDigits, wIsCGB, wScreenStep
; writes: wDigits, wScreenByte93, wScreenByte94, wScreenStep
; points at: wScreenList, wItemStorage, wItemGrid, wInventory
VaultMenu_Store_Case0A_Sub01::
Func_01D_4ADC:: ; address name
    ld hl, Data_01D_4BE4
    ld de, wScreenList
    ld c, $00

Jump_01D_4AE4::
    ld a, [hl+]
    ld [de], a
    inc c
    inc de
    ld a, c
    cp a, $15
    jr c, Jump_01D_4AE4
    ld a, [wScreenState]
    cp a, $03
    jp z, Jump_01D_4B32
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a, a
    add_a_to_hl
    ld e, [hl]
    ld hl, wItemStorage
    ld bc, $0000

Jump_01D_4B1B::
    ld a, [hl]
    cp a, e
    jr nz, Jump_01D_4B26
    and a, a
    jr z, Jump_01D_4B26
    inc hl
    ld c, [hl]
    jr Jump_01D_4B66

Jump_01D_4B26::
    inc b
    inc hl
    inc hl
    ld a, b
    cp a, $64
    jr c, Jump_01D_4B1B
    ld c, $00
    jr Jump_01D_4B66

Jump_01D_4B32::
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld e, [hl]
    ld hl, wInventory
    ld bc, $0000

Jump_01D_4B53::
    ld a, [hl]
    cp a, e
    jr nz, Jump_01D_4B5F
    and a, a
    jr z, Jump_01D_4B5F
    cp a, $FF
    jr z, Jump_01D_4B5F
    inc c

Jump_01D_4B5F::
    inc b
    inc hl
    ld a, b
    cp a, $18
    jr c, Jump_01D_4B53

Jump_01D_4B66::
    ld a, c
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_01D_4B78
    ld a, $E3
    ld [wDigits + $1], a

Jump_01D_4B78::
    ld a, [wDigits + $1]
    add a, $E0
    ld [wScreenByte93], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [wScreenByte94], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, wScreenList
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_4BA6
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01D_4BA6::
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0000

Jump_01D_4BB0::
    push hl

Jump_01D_4BB1::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $07
    jr c, Jump_01D_4BB1
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $03
    jr c, Jump_01D_4BB0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by VaultMenu_Store_Case0A_Sub01
Data_01D_4BE4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $BE, $C3, $C3, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case0B (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B)
; reads: wJoypadPressedRepeat, wScreenStep, wScreenState, wChoiceCursorF0, wItemGridX, wSavedSpriteSlotCount, wItemGridY
; writes: wScreenStep, wItemGridX, wItemGridY, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, ...
VaultMenu_Store_Case0B_Sub01::
Func_01D_4BF9:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, Jump_01D_4C3D
    bit 4, a
    jr nz, Jump_01D_4C50
    bit 5, a
    jr nz, Jump_01D_4C75
    bit 6, a
    jp nz, Jump_01D_4C8D
    bit 7, a
    jp nz, Jump_01D_4CAF
    bit 0, a
    jp nz, Jump_01D_4CD3
    call BlinkCursorSelectedRecord_Bank1D_4D41
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4C3D::
    farcall Run64C7UnlessScreenStateIs3
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_01D_4C4C::
    call BlinkCursorSelectedRecord_Bank1D_4D41
    ret

Jump_01D_4C50::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01D_4C4C
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, Jump_01D_4C63
    xor a, a

Jump_01D_4C63::
    ld [wItemGridY], a
    ld a, [wScreenStep]
    dec a
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4C75::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01D_4C4C
    ld a, [wItemGridY]
    and a, a
    jr nz, Jump_01D_4C89
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp Jump_01D_4C63

Jump_01D_4C89::
    dec a
    jp Jump_01D_4C63

Jump_01D_4C8D::
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wItemGridX]
    and a, a
    jr nz, Jump_01D_4C9B
    ld a, [wChoiceCursorF0]
    jr Jump_01D_4C9C

Jump_01D_4C9B::
    dec a

Jump_01D_4C9C::
    ld [wItemGridX], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4CAF::
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01D_4CBF
    xor a, a
    jr Jump_01D_4CC0

Jump_01D_4CBF::
    inc a

Jump_01D_4CC0::
    ld [wItemGridX], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4CD3::
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_Store_Case0B_Sub01_Sub01
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_01D_4D0A
    call VaultMenu_Store_Case0B_Sub01_Sub02
    and a, a
    jr z, Jump_01D_4D0A
    cp a, $FE
    jr z, Jump_01D_4CFB
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4CFB::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4D0A::
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_01D_4D2D
    farcall CountItemInInventoryToDigits
    jr Jump_01D_4D30

Jump_01D_4D2D::
    call SplitItemStorageEntryIntoDigits

Jump_01D_4D30::
    call DrawNumberTensNumberOnesDigitsAtScroll161
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7B4 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wJoypadRepeatTimer, wSelectedRecord, wItemGridX
; writes: wSelectedRecord
BlinkCursorSelectedRecord_Bank1D_4D41::
Func_01D_4D41:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_4D5B_Bank1D
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp a, $10
    jr c, DrawCursorTileBB_4D5B_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_4D5F_Bank1D
    xor a, a
    ld [wSelectedRecord], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wItemGridX
DrawCursorTileBB_4D5B_Bank1D::
Func_01D_4D5B:: ; address name
    ld b, $BB
    jr Jump_01D_4D65

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wItemGridX
DrawBlankTileC3_4D5F_Bank1D::
Func_01D_4D5F:: ; address name
    ld b, $C3
    jr Jump_01D_4D65

; only called from VaultMenu_Store_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wItemGridX
VaultMenu_Store_Case0B_Sub01_Sub01::
Func_01D_4D63:: ; address name
    ld b, $BC

Jump_01D_4D65::
    ld a, [wItemGridX]
    add a, a
    ld hl, Data_01D_4D82
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by VaultMenu_Store_Case0B_Sub01_Sub01
Data_01D_4D82:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from VaultMenu_Store_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wItemGridY, wItemGridX
; points at: wItemGrid, wItemStorage
VaultMenu_Store_Case0B_Sub01_Sub02::
Func_01D_4D8A:: ; address name
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld b, [hl]
    ld hl, wItemStorage
    ld c, $00

Jump_01D_4DAA::
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_4DBC
    and a, a
    jr z, Jump_01D_4DC5
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_4DAA
    ld a, $FF
    ret

Jump_01D_4DBC::
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_4DC5
    ld a, $FE
    ret

Jump_01D_4DC5::
    xor a, a
    ret

; only called from VaultMenu_Store_Case0D (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0D)
; reads: wJoypadPressedRepeat, wNumberTens, wNumberOnes, wScreenState, wScreenStep, wNumberEditPos, wCountOnes, wCountTens
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wNumberTens, wNumberOnes, wNumberEditPos
VaultMenu_Store_Case0D_Sub01::
Func_01D_4DC7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01D_4DE9
    bit 4, a
    jr nz, Jump_01D_4E0D
    bit 5, a
    jr nz, Jump_01D_4E27
    bit 6, a
    jp nz, Jump_01D_4E37
    bit 7, a
    jp nz, Jump_01D_4EC0
    bit 0, a
    jp nz, Jump_01D_4F4D
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4DE9::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $0B
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl+], a
    ld [hl], a
    ei
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4E0D::
    call VaultMenu_Store_Case0D_Sub01_Sub01
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, Jump_01D_4E1A
    xor a, a
    jr Jump_01D_4E1B

Jump_01D_4E1A::
    inc a

Jump_01D_4E1B::
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4E27::
    call VaultMenu_Store_Case0D_Sub01_Sub01
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01D_4E34
    ld a, $01
    jr Jump_01D_4E1B

Jump_01D_4E34::
    dec a
    jr Jump_01D_4E1B

Jump_01D_4E37::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01D_4E84
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01D_4E72
    ld a, b
    ld [wNumberTens], a
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

Jump_01D_4E60::
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01D_4E6E
    ld a, b
    ld [wNumberOnes], a

Jump_01D_4E6E::
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

Jump_01D_4E72::
    inc a
    ld [wNumberTens], a
    push af
    ld a, [wCountTens]
    ld b, a
    pop af
    cp a, b
    jp nc, Jump_01D_4E60
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4E84::
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01D_4E94
    ld a, [wCountOnes]
    ld b, a
    jr Jump_01D_4E96

Jump_01D_4E94::
    ld b, $09

Jump_01D_4E96::
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01D_4EB8
    ld a, [wCountOnes]
    cp a, b
    jr nz, Jump_01D_4EA6
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4EA6::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01D_4EB0
    ld a, $01
    jr Jump_01D_4EB1

Jump_01D_4EB0::
    xor a, a

Jump_01D_4EB1::
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4EB8::
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4EC0::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01D_4F0D
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01D_4EF5
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01D_4EEB
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

Jump_01D_4EEB::
    ld a, [wCountTens]
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4EF5::
    dec a
    ld [wNumberTens], a
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, Jump_01D_4F09
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

Jump_01D_4F09::
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4F0D::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01D_4F1C
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, Jump_01D_4F45
    jr Jump_01D_4F22

Jump_01D_4F1C::
    ld a, [wNumberOnes]
    and a, a
    jr nz, Jump_01D_4F45

Jump_01D_4F22::
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01D_4F3C
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

Jump_01D_4F3C::
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4F45::
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

Jump_01D_4F4D::
    call VaultMenu_Store_Case0D_Sub01_Sub01
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01D_4F5B
    ld a, [wNumberOnes]
    and a, a
    ret z

Jump_01D_4F5B::
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01D_4F6F
    call CheckListPagesPlusNumberAtMost18
    and a, a
    jr z, Jump_01D_4F84
    jr Jump_01D_4F75

Jump_01D_4F6F::
    call VaultMenu_Store_Case0D_Sub01_Sub02
    and a, a
    jr z, Jump_01D_4F84

Jump_01D_4F75::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4F84::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7CD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 10 call sites from 1 routine (e.g. VaultMenu_Store_Case0D_Sub01)
; reads: wJoypadRepeatTimer, wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1D_4F99::
Func_01D_4F99:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, VaultMenu_Store_Case0D_Sub01_Sub01
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, VaultMenu_Store_Case0D_Sub01_Sub01
    cp a, $18
    jr c, Jump_01D_4FC6
    xor a, a
    ld [wCursorBlinkCD], a

; only called from VaultMenu_Store_Case0D_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. VaultMenu_Store_Case0D_Sub01)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
VaultMenu_Store_Case0D_Sub01_Sub01::
Func_01D_4FB3:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01D_4FBE
    ld a, [wNumberTens]
    jr Jump_01D_4FC1

Jump_01D_4FBE::
    ld a, [wNumberOnes]

Jump_01D_4FC1::
    add a, $E0
    ld b, a
    jr Jump_01D_4FC8

Jump_01D_4FC6::
    ld b, $CB

Jump_01D_4FC8::
    ld a, [wNumberEditPos]
    add a, a
    ld hl, Data_01D_4FE5
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by VaultMenu_Store_Case0D_Sub01_Sub01
Data_01D_4FE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $01, $62, $01

; writes wD7CA and wD7CB as digit tiles ($E0 + n) at BGMapAddressAtScroll + $161 and + $162 (E-0120)
; 6 call sites from 2 routines (e.g. VaultMenu_Store_Case0B_Sub01, VaultMenu_Store_Case0D_Sub01)
; reads: wNumberTens, wNumberOnes
DrawNumberTensNumberOnesDigitsAtScroll161::
Func_01D_4FE9:: ; address name
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    ld a, [wNumberTens]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    call BGMapAddressAtScroll_Bank1D
    ld de, $0162
    add hl, de
    ld a, [wNumberOnes]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; A = $FF when wD7B0 + TenTimesNumberTensPlusNumberOnes exceeds $18, else 0 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0D_Sub01)
; reads: wListPages
CheckListPagesPlusNumberAtMost18::
Func_01D_5012:: ; address name
    call TenTimesNumberTensPlusNumberOnes
    ld a, [wListPages]
    add a, l
    cp a, $18
    jr c, Jump_01D_5022
    jr z, Jump_01D_5022
    ld a, $FF
    ret

Jump_01D_5022::
    xor a, a
    ret

; only called from VaultMenu_Store_Case0D_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0D_Sub01)
; reads: wItemGridY, wItemGridX, wTextCounter1
; writes: wTextCounter1, wTextCounter3
; points at: wItemGrid, wItemStorage
VaultMenu_Store_Case0D_Sub01_Sub02::
Func_01D_5024:: ; address name
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld b, [hl]
    ld hl, wItemStorage
    xor a, a
    ld [wTextCounter1], a
    ld c, $00

Jump_01D_5048::
    ld a, [hl+]
    cp a, b
    jr z, Jump_01D_506B
    and a, a
    jr z, Jump_01D_5056
    ld a, [wTextCounter1]
    inc a
    ld [wTextCounter1], a

Jump_01D_5056::
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_5048
    ld hl, wItemStorage
    ld a, [wTextCounter1]
    add a, a
    add_a_to_hl
    ld a, b
    ld [hl+], a

Jump_01D_506B::
    ld a, [hl]
    push hl
    ld b, a
    call TenTimesNumberTensPlusNumberOnes
    ld a, l
    add a, b
    cp a, $64
    jr nc, Jump_01D_5083
    pop hl
    ld [hl], a
    dec hl
    ld a, [hl]
    ld [wTextCounter3], a
    xor a, a
    ld [wTextCounter1], a
    ret

Jump_01D_5083::
    pop hl
    xor a, a
    ld [wTextCounter1], a
    ld a, $FF
    ret

; only called from VaultMenu_Store_Case0E (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0E)
; reads: wItemGridY, wItemGridX, wListPages, wCounterPtr0Lo, wScreenStep, wSavedSpriteClipMode
; writes: wTwoChoiceCursor, wTextCounter1, wTextCounter3, wCounterPtr0Lo, wScreenStep
; points at: wItemStorage, wInventory
VaultMenu_Store_Case0E_Sub01::
Func_01D_508B:: ; address name
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    push hl
    call TenTimesNumberTensPlusNumberOnes
    ld e, l
    pop hl
    push de
    ld a, [hl]
    sub a, e
    ld [hl], a
    pop de
    and a, a
    jr nz, Jump_01D_50BD
    dec hl
    xor a, a
    ld [hl], a

Jump_01D_50BD::
    ld hl, wInventory
    ld c, $00

Jump_01D_50C2::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_50CC
    cp a, $FF
    jr z, Jump_01D_50CC
    jr Jump_01D_50CF

Jump_01D_50CC::
    ld a, b
    ld [hl], a
    dec e

Jump_01D_50CF::
    inc hl
    inc c
    ld a, e
    and a, a
    jr z, Jump_01D_50DA
    ld a, c
    cp a, $18
    jr c, Jump_01D_50C2

Jump_01D_50DA::
    call Func_01D_4A62
    ld a, [wListPages]
    cp a, $18
    jr c, Jump_01D_50EB
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_50EB::
    ld a, [wSavedSpriteClipMode]
    and a, a
    jr nz, Jump_01D_50F9
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_50F9::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

; only called from VaultMenu_Store_Case0E (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0E)
; reads: wCounterPtr0Lo, wScreenStep, wTextCounter3
; writes: wTwoChoiceCursor, wTextCounter1, wTextCounter3, wCounterPtr0Lo, wScreenStep
; points at: wInventory, wItemStorage
VaultMenu_Store_Case0E_Sub02::
Func_01D_5101:: ; address name
    ld hl, wInventory
    ld c, $00

Jump_01D_5106::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_5110
    cp a, $FF
    jr z, Jump_01D_5110
    jr Jump_01D_511E

Jump_01D_5110::
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01D_5106
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_511E::
    ld hl, wItemStorage
    ld de, $0000
    ld c, $00

Jump_01D_5126::
    inc hl
    ld a, [hl]
    add a, e
    ld e, a
    jr nc, Jump_01D_512D
    inc d

Jump_01D_512D::
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_5126
    ld a, d
    cp a, $26
    jr c, Jump_01D_5145
    ld a, e
    cp a, $AC
    jr c, Jump_01D_5145
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_01D_5168

Jump_01D_5145::
    ld hl, wItemStorage
    ld c, $00

Jump_01D_514A::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_5163
    ld b, a
    ld a, [wTextCounter3]
    cp a, b
    jr nz, Jump_01D_515B
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_5163

Jump_01D_515B::
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_514A

Jump_01D_5163::
    ld a, $02
    ld [wTwoChoiceCursor], a

Jump_01D_5168::
    xor a, a
    ld [wTextCounter1], a
    ld [wTextCounter3], a
    ld a, [wCounterPtr0Lo]
    inc a
    and a, $01
    ld [wCounterPtr0Lo], a
    farcall Run64C7UnlessScreenStateIs3
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0227 (C1: two $FF-terminated lists holding the numbers $01-$62 in two different orders; no reader was found, directly or by a computed base).
; record: 95 numbers, then $FF
OrderList_1D_5186::
Data_01D_5186:: ; address name
    db $21, $28, $29, $2A, $2E, $1F, $20, $2B, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $19, $1A, $1B, $1C, $1D, $1E, $13, $14, $15, $16, $17, $18, $0D, $0E, $0F, $10, $11, $12, $2C, $2D, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $22, $23, $24, $25, $26, $27, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D ; entry 0
    db $FF ; end

; E-0227 (C1: two $FF-terminated lists holding the numbers $01-$62 in two different orders; no reader was found, directly or by a computed base).
; record: 95 numbers, then $FF
OrderList_1D_51E6::
Data_01D_51E6:: ; address name
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $22, $23, $24, $25, $26, $27, $19, $1A, $1B, $1C, $1D, $1E, $13, $14, $15, $16, $17, $18, $0D, $0E, $0F, $10, $11, $12, $2C, $2D, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $21, $28, $29, $2A, $2E, $1F, $20, $2B, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D ; entry 0
    db $FF ; end

; writes $80 zero bytes from $9700 with interrupts off around each VRAM wait (Func_000_120A); no caller found (E-0227)
; no direct call (reached through a table, a jump or a vector)
ClearVRAM9700Block_Unreferenced:: ; configured code entry (E-0227); C0
Func_01D_5246:: ; address name
    ld hl, vTiles2 + $700
    ld bc, $0080

Jump_01D_524C::
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01D_524C
    ret

; only called from VaultMenu_Store_Case0F (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0F)
; reads: wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY
VaultMenu_Store_Case0F_Sub01::
Func_01D_5259:: ; address name
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr z, Jump_01D_5271
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5271::
    ld a, $07
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl+], a
    ld [hl], a
    ei
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws rect $0147 (3 x 13) at vBGMap1 + $370, wD781 += 1, clears wD7CD-wD7D0 and sets wD7CC = 2 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToDrawRect0147AndResetNumberEditPos)
; reads: wScreenStep
; writes: wScreenStep, wCursorBlinkCD, wThreeDigits, wNumberEditPos
DrawRect0147AndResetNumberEditPos::
Func_01D_5297:: ; address name
    ld hl, $0147
    ld de, vBGMap1 + $370
    ld bc, $030D
    call SaveBGMapRectWithAttrs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wCursorBlinkCD], a
    ld [wThreeDigits], a
    ld [wThreeDigits + $1], a
    ld [wThreeDigits + $2], a
    ld a, $02
    ld [wNumberEditPos], a
    ret

; only called from routines of VaultMenu_Store (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_Store_Case13, VaultMenu_Store_Case17)
; reads: hTemp2, hTemp1, hTemp0, wIsCGB, wScreenStep
; writes: wDigits, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wTextCounter0, wScreenStep
; points at: wScreenList, wBankedGoldLo, wScreenByteBD, wScreenByte93
VaultMenu_Store_Shared02::
Func_01D_52BD:: ; address name
    ld hl, wScreenList
    ld de, Data_01D_53A2
    ld c, $00

Jump_01D_52C5::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $27
    jr c, Jump_01D_52C5
    ld hl, wBankedGoldLo
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and a, $F0
    swap a
    ld [wScreenByteBD], a
    ldh a, [hTemp2]
    and a, $0F
    ld [wListEntries2], a
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wScreenByteBF], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wScreenByteC0], a
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld [wScreenByteC1], a
    ldh a, [hTemp0]
    and a, $0F
    ld [wTextCounter0], a
    ld hl, wScreenByteBD
    ld c, $00

Jump_01D_5315::
    ld a, [hl]
    and a, a
    jr nz, Jump_01D_5323
    add a, $E3
    ld [hl], a
    inc c
    inc hl
    ld a, c
    cp a, $05
    jr c, Jump_01D_5315

Jump_01D_5323::
    ld hl, wScreenByteBD
    ld de, wScreenByte93
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $014B
    add hl, de
    ld de, wScreenList
    ld bc, $0903
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_5364
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01D_5364::
    call BGMapAddressAtScroll_Bank1D
    ld de, $014B
    add hl, de
    ld bc, $0000

Jump_01D_536E::
    push hl

Jump_01D_536F::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_01D_536F
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $03
    jr c, Jump_01D_536E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by VaultMenu_Store_Shared02
Data_01D_53A2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case14 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case14)
; reads: wThreeDigits, wScreenState, hTemp2, hTemp1, wScreenStep, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo
; writes: wGrid2CursorX, wGrid2CursorY, wScreenArea, wDigits, wCountTens, wCountOnes, wItemGrid, wScreenStep, ...
; points at: wScreenList, wGoldLo, wBankedGoldLo
VaultMenu_Store_Case14_Sub01::
Func_01D_53BD:: ; address name
    ld hl, wScreenList
    ld de, Data_01D_548D
    ld c, $00

Jump_01D_53C5::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_01D_53C5
    ld a, [wThreeDigits]
    add a, $E0
    ld [wGrid2CursorX], a
    ld a, [wThreeDigits + $1]
    add a, $E0
    ld [wGrid2CursorY], a
    ld a, [wThreeDigits + $2]
    add a, $E0
    ld [wScreenArea], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $006C
    add hl, de
    ld de, wScreenList
    ld bc, $0802
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wScreenState]
    cp a, $03
    jp nz, Jump_01D_5438
    ld hl, wGoldLo
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and a, $0F
    ld [wCountTens], a
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wCountOnes], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wItemGrid], a

Jump_01D_5427::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5438::
    ld a, [wBankedGoldHi]
    cp a, $01
    jr c, Jump_01D_5461
    jr nz, Jump_01D_5453
    ld a, [wBankedGoldMid]
    cp a, $86
    jr c, Jump_01D_5461
    jr nz, Jump_01D_5453
    ld a, [wBankedGoldLo]
    cp a, $3C
    jr c, Jump_01D_5461
    jr z, Jump_01D_5461

Jump_01D_5453::
    ld a, $09
    ld [wCountTens], a
    ld [wCountOnes], a
    ld [wItemGrid], a
    jp Jump_01D_5427

Jump_01D_5461::
    ld hl, wBankedGoldLo
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and a, $0F
    ld [wCountTens], a
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wCountOnes], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wItemGrid], a
    jp Jump_01D_5427

; address loaded by VaultMenu_Store_Case14_Sub01
Data_01D_548D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $BF, $C3, $C3, $C3, $E0, $E0, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case15 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case15)
; reads: wScreenStep, wThreeDigits, wBankedGoldLo, wBankedGoldMid, wBankedGoldHi, wGoldLo, wGoldMid, wGoldHi
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, wGoldHi, ...
VaultMenu_Store_Case15_Sub01::
Func_01D_549D:: ; address name
    call Func_01D_564B
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_54B3
    cp a, $02
    jr z, Jump_01D_54AB
    ret

Jump_01D_54AB::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01D_54B3::
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a, a
    jr nz, Jump_01D_54C9
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, Jump_01D_54C9
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, Jump_01D_54C9
    ret

Jump_01D_54C9::
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03E8
    call Multiply8By16

Jump_01D_54DF::
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add a, l
    ld l, a
    ld a, h
    adc a, c
    ld h, a
    ld a, b
    adc a, e
    ld e, a
    inc d
    ld a, d
    cp a, $02
    jr nc, Jump_01D_5501
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr Jump_01D_54DF

Jump_01D_5501::
    push de
    push hl
    ld a, [wBankedGoldLo]
    add a, l
    ld l, a
    ld a, [wBankedGoldMid]
    adc a, h
    ld h, a
    ld a, [wBankedGoldHi]
    adc a, e
    ld e, a
    ld a, e
    cp a, $0F
    jr c, Jump_01D_5536
    jr nz, Jump_01D_5525
    ld a, h
    cp a, $41
    jr c, Jump_01D_5536
    jr nz, Jump_01D_5525
    ld a, l
    cp a, $DD
    jr c, Jump_01D_5536

Jump_01D_5525::
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5536::
    ld a, e
    ld [wBankedGoldHi], a
    ld a, h
    ld [wBankedGoldMid], a
    ld a, l
    ld [wBankedGoldLo], a
    pop hl
    pop de
    ld a, [wGoldLo]
    sub a, l
    ld l, a
    ld a, [wGoldMid]
    sbc a, h
    ld h, a
    ld a, [wGoldHi]
    sbc a, e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from VaultMenu_TakeOut_Case15 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_TakeOut_Case15)
; reads: wScreenStep, wThreeDigits, wGoldLo, wGoldMid, wGoldHi, wBankedGoldLo, wBankedGoldMid, wBankedGoldHi
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wGoldHi, wGoldMid, wGoldLo, wBankedGoldHi, ...
VaultMenu_TakeOut_Case15_Sub01::
Func_01D_5573:: ; address name
    call Func_01D_564B
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_5589
    cp a, $02
    jr z, Jump_01D_5581
    ret

Jump_01D_5581::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01D_5589::
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a, a
    jr nz, Jump_01D_559F
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, Jump_01D_559F
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, Jump_01D_559F
    ret

Jump_01D_559F::
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03E8
    call Multiply8By16

Jump_01D_55B5::
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add a, l
    ld l, a
    ld a, h
    adc a, c
    ld h, a
    ld a, b
    adc a, e
    ld e, a
    inc d
    ld a, d
    cp a, $02
    jr nc, Jump_01D_55D7
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr Jump_01D_55B5

Jump_01D_55D7::
    push de
    push hl
    ld a, [wGoldLo]
    add a, l
    ld l, a
    ld a, [wGoldMid]
    adc a, h
    ld h, a
    ld a, [wGoldHi]
    adc a, e
    ld e, a
    ld a, e
    cp a, $01
    jr c, Jump_01D_560E
    jr nz, Jump_01D_55FD
    ld a, h
    cp a, $86
    jr c, Jump_01D_560E
    jr nz, Jump_01D_55FD
    ld a, l
    cp a, $9F
    jr c, Jump_01D_560E
    jr z, Jump_01D_560E

Jump_01D_55FD::
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_560E::
    ld a, e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    pop hl
    pop de
    ld a, [wBankedGoldLo]
    sub a, l
    ld l, a
    ld a, [wBankedGoldMid]
    sbc a, h
    ld h, a
    ld a, [wBankedGoldHi]
    sbc a, e
    ld [wBankedGoldHi], a
    ld a, h
    ld [wBankedGoldMid], a
    ld a, l
    ld [wBankedGoldLo], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 2 call sites from 2 routines (e.g. VaultMenu_TakeOut_Case15_Sub01, VaultMenu_Store_Case15_Sub01)
; reads: wJoypadPressed, wJoypadPressedRepeat, wNumberEditPos, wCountTens, wThreeDigits, wCountOnes, wItemGrid
; writes: wNumberEditPos, wThreeDigits, wCountOnes
Func_01D_564B::
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_5671
    bit 1, a
    jr nz, Jump_01D_5679
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, Jump_01D_567C
    bit 7, a
    jp nz, Jump_01D_5765
    bit 4, a
    jp nz, Jump_01D_5822
    bit 5, a
    jp nz, Jump_01D_5834
    call Func_01D_5878
    ret

Jump_01D_5671::
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

Jump_01D_5679::
    ld a, $02
    ret

Jump_01D_567C::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, Jump_01D_568F
    cp a, $01
    jp z, Jump_01D_56E4
    jp Jump_01D_5725

Jump_01D_568F::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_56D8
    jr z, Jump_01D_56C0
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wThreeDigits + $1]
    ld b, a
    ld a, [wCountOnes]
    cp a, b
    jr nc, Jump_01D_56BB
    ld [wThreeDigits + $1], a
    ld a, [wThreeDigits + $2]
    ld b, a
    ld a, [wItemGrid]
    cp a, b
    jr nc, Jump_01D_56BB
    ld [wThreeDigits + $2], a

Jump_01D_56BB::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_56C0::
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr nc, Jump_01D_56CA

Jump_01D_56CA::
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    jr Jump_01D_56BB

Jump_01D_56D8::
    inc a
    ld [wThreeDigits], a
    call Func_01D_5AA3
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_56E4::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr nc, Jump_01D_570A
    ld a, [wThreeDigits + $1]
    cp a, $09
    jr c, Jump_01D_56FE
    xor a, a
    ld [wThreeDigits + $1], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_56FE::
    inc a
    ld [wThreeDigits + $1], a
    call Func_01D_5AA3
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_570A::
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, Jump_01D_56FE
    ld [wCountOnes], a
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_5725::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_574C
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, Jump_01D_574C
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, Jump_01D_575C
    ld a, b
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_574C::
    ld a, [wThreeDigits + $2]
    cp a, $09
    jr c, Jump_01D_575C
    xor a, a
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_575C::
    inc a
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_5765::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, Jump_01D_5778
    cp a, $01
    jp z, Jump_01D_579E
    jp Jump_01D_57E4

Jump_01D_5778::
    ld a, [wThreeDigits]
    and a, a
    jr nz, Jump_01D_5795
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_5795::
    dec a
    ld [wThreeDigits], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_579E::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_57CB
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, Jump_01D_57DB
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, Jump_01D_57C6
    jr z, Jump_01D_57C6
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

Jump_01D_57C6::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_57CB::
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, Jump_01D_57DB
    ld a, $09
    ld [wThreeDigits + $1], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_57DB::
    dec a
    ld [wThreeDigits + $1], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_57E4::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_5809
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, Jump_01D_5809
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, Jump_01D_5819
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_5809::
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, Jump_01D_5819
    ld a, $09
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_5819::
    dec a
    ld [wThreeDigits + $2], a
    call Func_01D_5878
    xor a, a
    ret

Jump_01D_5822::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    cp a, $02
    jr nc, Jump_01D_5843
    inc a
    ld [wNumberEditPos], a
    jr Jump_01D_5843

Jump_01D_5834::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, Jump_01D_5843
    dec a
    ld [wNumberEditPos], a

Jump_01D_5843::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

Jump_01D_5873::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

; 13 call sites from 1 routine (e.g. Func_01D_564B)
; reads: wJoypadRepeatTimer, wCursorBlinkCD, wNumberEditPos
; writes: wCursorBlinkCD
; points at: wThreeDigits
Func_01D_5878::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01D_5892
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, Jump_01D_5892
    cp a, $18
    jr c, Jump_01D_58A3
    xor a, a
    ld [wCursorBlinkCD], a

Jump_01D_5892::
    ld hl, wThreeDigits
    ld a, [wNumberEditPos]
    add_a_to_hl
    ld a, [hl]
    add a, $E0
    ld b, a
    jr Jump_01D_58A5

Jump_01D_58A3::
    ld b, $CB

Jump_01D_58A5::
    ld a, [wNumberEditPos]
    add a, a
    ld hl, Data_01D_58C2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by Func_01D_5878
Data_01D_58C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6E, $00, $6F, $00, $70, $00

; writes the three bytes at wD7CE as digit tiles ($E0 + digit) at the BG map entry BGMapAddressAtScroll + $6E (row 3, column 14 of the view), one per byte with WaitForVRAMAccess (E-0104)
; 8 call sites from 4 routines (e.g. VaultMenu_TakeOut_Case15_Sub01, Func_01D_564B, Func_01D_5AA3, VaultMenu_Store_Case15_Sub01)
; points at: wThreeDigits
DrawThreeDigitsAtScrollOffset6E::
Func_01D_58C8:: ; address name
    call BGMapAddressAtScroll_Bank1D
    ld de, $006E
    add hl, de
    ld de, wThreeDigits
    ld c, $00

Jump_01D_58D4::
    ld a, [de]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_01D_58D4
    ret

; takes the byte at wC635 + 8 * wD7B6 + 2 * wD7B5 + 1 and stores its value / 10 in wD7D3 and value mod 10 in wD7D4 (E-0120)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_Sub01)
; reads: wItemGridY, wItemGridX
; writes: wCountOnes, wCountTens
; points at: wItemStorage
SplitItemStorageEntryIntoDigits::
Func_01D_58E7:: ; address name
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a, a
    add_a_to_hl
    inc hl
    ld l, [hl]
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld [wCountOnes], a
    ld a, l
    ld [wCountTens], a
    ret

; copies a B x C rectangle of the BG map at scroll + HL (and its CGB attributes) to DE (E-0127)
; 3 call sites from 3 routines (e.g. DrawRect0088AtBGMap1370AndStep, DrawRect0140AtBGMap13E0AndStep, DrawRect0147AndResetNumberEditPos)
; reads: wIsCGB, wCursorBlinkB8
; writes: wCursorBlinkB8
SaveBGMapRectWithAttrs::
Func_01D_5917:: ; address name
    push bc
    push de
    push hl
    call BGMapAddressAtScroll_Bank1D
    ld e, l
    ld d, h
    pop hl
    add hl, de
    pop de
    pop bc
    ld a, c
    ld [wCursorBlinkB8], a
    push hl
    push hl

Jump_01D_5929::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01D_594A
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc

Jump_01D_594A::
    inc hl
    inc de
    dec c
    jp nz, Jump_01D_5929
    ld a, [wCursorBlinkB8]
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    dec b
    jp nz, Jump_01D_5929
    pop hl
    pop hl
    ret

; only called from VaultMenu_Store_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case03_Sub01)
; points at: wItemStorage, wInventory
VaultMenu_Store_Case03_Sub01_Sub01::
Func_01D_5965:: ; address name
    ld hl, wItemStorage
    ld de, wInventory
    ld bc, $0000

Jump_01D_596E::
    ld a, [de]
    and a, a
    jr z, Jump_01D_598E
    cp a, $FF
    jr z, Jump_01D_598E
    push bc
    ld b, a
    ld c, $00
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_599A
    and a, a
    jp z, Jump_01D_59B6
    pop bc
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_596E
    ld hl, wItemStorage

Jump_01D_598E::
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_596E

Jump_01D_5997::
    ld a, $FF
    ret

Jump_01D_599A::
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_59B6
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_596E
    ld hl, wItemStorage
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_596E
    jr Jump_01D_5997

Jump_01D_59B6::
    pop bc
    xor a, a
    ret

; A = 0 when one of the 100 two-byte entries at wC635 has a non-zero first byte, else $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wItemStorage
ItemStorageHasNonZeroEntry:: ; heuristic: follows a terminator; C0
Func_01D_59B9:: ; address name
    ld hl, wItemStorage
    ld c, $00

Jump_01D_59BE::
    ld a, [hl]
    and a, a
    jr nz, Jump_01D_59CD
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_59BE
    ld a, $FF
    ret

Jump_01D_59CD::
    xor a, a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 23 call sites from 16 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, Func_01D_4823, SaveBGMapRectWithAttrs, VaultMenu_Store_Case07_Sub01, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1D::
Func_01D_59CF:: ; address name
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

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets wC554 = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2 switched in (E-0121; a copy, not a clear: E-0226)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
DrawRectBothBanksSetTextCursorLoPlus1C1_Bank1D:: ; heuristic: follows a terminator; C0
Func_01D_59F0:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
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
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets wC554 = HL + $21 (E-0124; a copy, not a clear: E-0226)
; 8 call sites from 5 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, VaultMenu_Store_Case07_Sub01, VaultMenu_Store_Case0A_Sub01, VaultMenu_Store_Case14_Sub01, ...)
; writes: wTextCursorLo, wTextCursorHi
DrawRectSetTextCursorLoPlus21_Bank1D::
Func_01D_5A32:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    pop hl
    push hl
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ret

; copies a B x C rectangle from DE to the BG map at HL, wrapping at the row and map edges (E-0125)
; 3 call sites from 2 routines (e.g. DrawRectSetTextCursorLoPlus21_Bank1D, DrawRectBothBanksSetTextCursorLoPlus1C1_Bank1D)
CopyRectToBGMapWrapped_Bank1D::
Func_01D_5A4F:: ; address name
    push hl
    push bc

Jump_01D_5A51::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    ld a, l
    and a, $1F
    jp nz, Jump_01D_5A68
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01D_5A68::
    inc de
    dec b
    jr nz, Jump_01D_5A51
    pop bc
    pop hl
    dec c
    jr z, Jump_01D_5A7F
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr CopyRectToBGMapWrapped_Bank1D

Jump_01D_5A7F::
    ret

; HL = 10 * wD7CA + wD7CB (E-0120)
; 3 call sites from 3 routines (e.g. CheckListPagesPlusNumberAtMost18, VaultMenu_Store_Case0D_Sub01_Sub02, VaultMenu_Store_Case0E_Sub01)
; reads: wNumberTens, wNumberOnes
TenTimesNumberTensPlusNumberOnes::
Func_01D_5A80:: ; address name
    ld a, [wNumberTens]
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wNumberOnes]
    add_a_to_hl
    ret

; 2 call sites from 1 routine (e.g. Func_01D_564B)
; reads: wCountTens, wThreeDigits, wCountOnes, wItemGrid
; writes: wThreeDigits
Func_01D_5AA3::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    jr Jump_01D_5ADE

Jump_01D_5AC9::
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E

Jump_01D_5ADE::
    ret

; only called from routines of VaultMenu_Store (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_Store_Case07_Sub01, VaultMenu_Store_Case08_Sub01)
; reads: wScreenState, wSavedSpriteClipMode, wItemGridY, wItemGridX, wArg1
; writes: wSavedSpriteSlotCount, wItemGridY, wChoiceCursorF0, wItemGridX
VaultMenu_Store_Shared03::
Func_01D_5ADF:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01D_5AF1
    call Func_01D_4A62
    call CountNonZeroItemGridBytes
    ld a, [wSavedSpriteClipMode]
    jr Jump_01D_5AF8

Jump_01D_5AF1::
    call Func_01D_4A62
    call CountNonZeroItemGridBytes
    ld a, c

Jump_01D_5AF8::
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01D_5B05
    inc l

Jump_01D_5B05::
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, Jump_01D_5B46
    pop af
    push af
    and a, a
    jr nz, Jump_01D_5B25
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, Jump_01D_5B46
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr Jump_01D_5B46

Jump_01D_5B25::
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01D_5B4C
    jr z, Jump_01D_5B4C
    push bc
    push hl
    ld a, [wArg1]
    and a, a
    jr nz, Jump_01D_5B3E
    call VaultMenu_Store_Shared03_Sub01

Jump_01D_5B3E::
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr Jump_01D_5B4C

Jump_01D_5B46::
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

Jump_01D_5B4C::
    ret

; record wD7F1 (bank 1): writes its mark (field $0E), level (field $56) and four stat words (fields from Data_01D_5BE6) into the screen buffer (E-0128)
; 4 call sites from 4 routines (e.g. HibernateMenu_Case05_Case21, HibernateMenu_Case06_Case04, BreedMenu_Case07_Case0F, CallFunc5B4DInBank1D)
; reads: wArg1, hTemp0, wDigits, hTemp1
; writes: rRAMG2, rRAMB, wWindowTileBuffer
DrawRecordStatsBoxForArg1::
Func_01D_5B4D:: ; address name
    ld a, [wArg1]
    ld b, a
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    ld [wWindowTileBuffer + $86], a
    pop bc
    push bc
    ld a, b
    ld c, $56
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    ld a, [wDigits + $1]
    add a, $E0
    ld [wWindowTileBuffer + $89], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [wWindowTileBuffer + $8A], a
    pop bc
    push bc
    ld c, $00

Jump_01D_5B98::
    push bc
    ld a, c
    ld hl, Data_01D_5BE6
    add_a_to_hl
    ld c, [hl]
    ld a, b
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a, a
    ld hl, Data_01D_5BEA
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wDigits]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01D_5B98
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawRecordStatsBoxForArg1
Data_01D_5BE6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

; address loaded by DrawRecordStatsBoxForArg1
Data_01D_5BEA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; saves wD7F1-wD7F9 and hFFC6-hFFD2, runs Func_01D_6899 for the record at WD789 cell 5, then restores them (E-0125)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunLinkSession4ScreenState_Case08_Case04, SwapMonstersMenu_Case09_Case20_Case00, ...)
; writes: wArg1, wArg2
; points at: wRecordBuffer, wArg1, hTemp0
CallDrawPartySpeciesSpritesPreservingArg1AndTemp0::
Func_01D_5BF2:: ; address name
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

Jump_01D_5BFA::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5BFA
    ld de, hTemp0
    ld b, $0D

Jump_01D_5C05::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C05
    call SetArg5ToListEntriesCell5
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    call DrawPartySpeciesSprites
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

Jump_01D_5C23::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C23
    ld de, hTemp0
    ld b, $0D

Jump_01D_5C2E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C2E
    ret

; saves wD7F1-wD7F9 and hFFC6-hFFD2, draws the species sprite of the record at WD789 cell 5 at ($90, $40) (Func_01D_69DA), then restores them (E-0127)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunLinkSession4ScreenState_Case08_Case04, SwapMonstersMenu_Case09_Case15_Case00, ...)
; reads: hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wArg1, wArg2
; points at: wRecordBuffer, wArg1, hTemp0
DrawListEntriesCell5SpeciesSprite::
Func_01D_5C35:: ; address name
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

Jump_01D_5C3D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C3D
    ld de, hTemp0
    ld b, $0D

Jump_01D_5C48::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C48
    call SetArg5ToListEntriesCell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a, a
    ld h, a
    ld e, a
    ld l, $90
    ld d, $40
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

Jump_01D_5C82::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C82
    ld de, hTemp0
    ld b, $0D

Jump_01D_5C8D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C8D
    ret

; with SRAM bank 0 enabled reads the record at WD789 cell 5 and continues at Jump_01D_5CAF (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
LoadListEntriesCell5RecordAndContinue5CAF:: ; heuristic: follows a terminator; C0
Func_01D_5C94:: ; address name
    call SetArg5ToListEntriesCell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    jr Jump_01D_5CAF

; only called from HibernateMenu_Case05_Case3E (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_Case3E)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
HibernateMenu_Case05_Case3E_Sub01::
Func_01D_5CA3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]

Jump_01D_5CAF::
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

Jump_01D_5CC5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01D_5CD3
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01D_5CC5

Jump_01D_5CD3::
    ld a, $F0
    ld [de], a
    ret

; record wD7F1: draws its name at vTiles1 + $780 and the name of its species (field $0B) at vTiles1 + $270 (E-0127)
; 11 call sites from 11 routines (e.g. NpcBreedMenu_Case11_Case07, HibernateMenu_Case05_Case23, BreedMenu_Case04_Case06, BreedMenu_Case07_Case11, ...)
; reads: wArg1, hTemp0, hTemp1, wDataBank
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wDataBank
; points at: wNameGlyphBuf
DrawRecordNameAndSpeciesNameTiles::
Func_01D_5CD7:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop bc
    push bc
    ld a, b
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, vTiles1 + $270
    call CopyGlyphTilesToVRAM
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; entry wD7FC (3 bytes per entry): decompresses the tiles named at Data_01D_5D78 to vTiles2 and copies the $40-byte palette named at Data_01D_5D7E into wBGPaletteBuffer (E-0120)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case08)
; reads: wAreaGraphicsIndex
; points at: wBGPaletteBuffer
LoadAreaGraphicsForAreaGraphicsIndex::
Func_01D_5D47:: ; address name
    ld a, [wAreaGraphicsIndex]
    ld c, a
    add a, a
    add a, c
    push af
    ld hl, AreaTilesetTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, AreaPaletteTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ret

; E-0145 (C1: LoadAreaGraphicsForAreaGraphicsIndex decompresses the far pointer at $5D78 + 3 * wAreaGraphicsIndex to vTiles2; two entries decode, the bytes after them are AreaPaletteTable).
; record: compressed BG tiles (vTiles2); its ROM bank
AreaTilesetTable::
Data_01D_5D78:: ; address name
    dfar AreaTileset0 ; id 0
    dfar AreaTileset1 ; id 1

; E-0145 (C1: LoadAreaGraphicsForAreaGraphicsIndex copies $40 bytes from the far pointer at $5D7E + 3 * wAreaGraphicsIndex to wBGPaletteBuffer).
; record: $40-byte BG palette set; its ROM bank
AreaPaletteTable::
Data_01D_5D7E:: ; address name
    dfar AreaPalettes0 ; id 0
    dfar AreaPalettes1 ; id 1

; wD7F5/wD7F6 (big-endian pointer) = wD789 + 5 * wD7AF + wD7AB
; 67 call sites from 58 routines (e.g. CallDrawPartySpeciesSpritesPreservingArg1AndTemp0, DrawListEntriesCell5SpeciesSprite, ShowCategory11StringOfListEntriesCell5Record, ShowSpeciesCategory13StringOfListEntriesCell5Record, ...)
; reads: wListPageIndex, wListCursor
; writes: wArg5, wArg6
; points at: wListEntries
SetArg5ToListEntriesCell5::
Func_01D_5D84:: ; address name
    ld a, [wListPageIndex]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ret

; wD7F5/wD7F6 (big-endian pointer) = wD789 + 4 * wD7AF + wD7AB
; 28 call sites from 28 routines (e.g. EggServiceMenu_Case05_Case0F, EggServiceMenu_Case05_Case12_Case06, GetListEntriesCell4AddressWithSRAM, EggServiceMenu_Shared01, ...)
; reads: wListPageIndex, wListCursor
; writes: wArg5, wArg6
; points at: wListEntries
SetArg5ToListEntriesCell4::
Func_01D_5DA1:: ; address name
    ld a, [wListPageIndex]
    add a, a
    add a, a
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ret

; shows string (field $A4 of the record at WD789 cell 5) of category $0B at $9320 with size $0602 (E-0121)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case14)
; reads: wArg5, wArg6, hTemp0
; writes: rRAMG2, rRAMB, wStringIndex, wStringCategory
; points at: wTextWindowTileLo
ShowCategory11StringOfListEntriesCell5Record::
Func_01D_5DBC:: ; address name
    call SetArg5ToListEntriesCell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, $A4
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [wStringIndex], a
    ld a, $0B
    ld [wStringCategory], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    ld a, $20
    ld [hl+], a
    ld a, $93
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; loads the species of the record at WD789 cell 5 (field $0B) and shows string [wD013] of category $0D at $9680 with size $0602 (E-0121)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case1A)
; reads: hTemp0, hTemp1, wSpeciesRecord
; writes: rRAMG2, rRAMB, wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory
; points at: wTextWindowTileLo
ShowSpeciesCategory13StringOfListEntriesCell5Record::
Func_01D_5DF9:: ; address name
    call SetArg5ToListEntriesCell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wSpeciesIdLo], a
    ldh a, [hTemp1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $B]
    ld [wStringIndex], a
    ld a, $0D
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    ld a, $80
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadRecordCapacityFromFarmLevelTable): wD7AA = how many have byte 0 equal to 1 or 2 (in use) (E-0104)
; 13 call sites from 13 routines (e.g. HibernateMenu_Case01_Case03, HibernateMenu_Case05_Case2C, HibernateMenu_Case05_Case0F, HibernateMenu_Case04_Case2F, ...)
; reads: wRecordsInUse
; writes: wRecordsInUse, rRAMG2, rRAMB
; points at: sRecords
CountRecordsInUse::
Func_01D_5E3F:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld d, c
    xor a, a
    ld [wRecordsInUse], a
    ld hl, sRecords
    ld b, $00
    ld c, $A5

Jump_01D_5E4E::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $01
    jr z, Jump_01D_5E62
    cp a, $02
    jr z, Jump_01D_5E62
    jr Jump_01D_5E69

Jump_01D_5E62::
    ld a, [wRecordsInUse]
    inc a
    ld [wRecordsInUse], a

Jump_01D_5E69::
    inc b
    ld a, c
    add_a_to_hl
    ld a, b
    cp a, d
    jr c, Jump_01D_5E4E
    xor a, a
    ld [rRAMG2], a
    ret

; clears the wD789 list, then lists the party records whose SRAM record byte 0 is 2 and counts them in wD7A9 (E-0127)
; 19 call sites from 19 routines (e.g. SwapMonstersMenu_Case03_Sub01, HibernateMenu_Case01_ToListPartyRecordsWithState2ToListEntriesAndStep, HibernateMenu_Case05_Case40, HibernateMenu_Case05_Case0E, ...)
; reads: wListCount, wPartyCount
; writes: wListCount, rRAMG2, rRAMB
; points at: wListEntries, wPartyList, sRecords
ListPartyRecordsWithState2ToListEntries::
Func_01D_5E79:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld b, c
    ld hl, wListEntries

Jump_01D_5E80::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5E80
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wPartyList
    ld b, $00

Jump_01D_5E97::
    ld a, [de]
    ld c, a
    ld a, $A5
    push bc
    push de
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, [hl]
    cp a, $02
    jr nz, Jump_01D_5EC0
    pop de
    pop bc
    ld hl, wListEntries
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    inc b
    ld a, [wListCount]
    inc a
    ld [wListCount], a
    jr Jump_01D_5EC2

Jump_01D_5EC0::
    pop de
    pop bc

Jump_01D_5EC2::
    inc de
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_01D_5E97
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadRecordCapacityFromFarmLevelTable): clears the 30-byte list wD789, then appends the number of every record whose byte 0 is 1 and byte $6E is 0; wD7A9 = the list length, wD7B9 = how many state-1 records had byte $6E set (E-0104)
; 12 call sites from 11 routines (e.g. HibernateMenu_Case03, StartRecordListOrNoneMessage, HibernateMenu_Case05_Case32, HibernateMenu_Case05_Case3C, ...)
; reads: wRecordCapacity, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, sRecords
ListRecordsState1WithByte6EClear::
Func_01D_5ECE:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

Jump_01D_5ED6::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5ED6
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_01D_5EF5::
    ld a, [de]
    cp a, $01
    jr nz, Jump_01D_5F14
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_5F02
    inc d

Jump_01D_5F02::
    ld a, [de]
    and a, a
    jr nz, Jump_01D_5F0C
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_5F14

Jump_01D_5F0C::
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

Jump_01D_5F14::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_5F1B
    inc d

Jump_01D_5F1B::
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, Jump_01D_5EF5
    jr c, Jump_01D_5EF5
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadRecordCapacityFromFarmLevelTable): clears wD789 and wD7BE (30 bytes each), then appends every record whose byte 0 is 1 or 2 and byte $6E is 0; wD7A9 = the list length, wD7B9 = how many in-use records had byte $6E set (E-0104)
; 13 call sites from 13 routines (e.g. HibernateMenu_Case03, BreedMenu_Case04_Case02, BreedMenu_Case11_Case02, BattleEnd_Step5_Case01_Case01_Sub01_Case10, ...)
; reads: wRecordCapacity, wListCount, wPartyCount, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wPartyList
ListRecordsInUseWithByte6EClear::
Func_01D_5F2D:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

Jump_01D_5F35::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5F35
    ld hl, wListEntries2
    ld b, $1E

Jump_01D_5F3F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5F3F
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_01D_5F5E::
    ld a, [de]
    and a, a
    jr z, Jump_01D_5F86
    cp a, $01
    jr z, Jump_01D_5F6C
    cp a, $02
    jr z, Jump_01D_5F6C
    jr Jump_01D_5F86

Jump_01D_5F6C::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_5F74
    inc d

Jump_01D_5F74::
    ld a, [de]
    and a, a
    jr nz, Jump_01D_5F7E
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_5F86

Jump_01D_5F7E::
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

Jump_01D_5F86::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_5F8D
    inc d

Jump_01D_5F8D::
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, Jump_01D_5F5E
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a

; moves the party records found in the record list wD789 to its front and pads the list to $1E entries with $FF (E-0129)
; 3 call sites from 3 routines (e.g. BreedMenu_Shared05, ListAvailableRecordsForSelection, ListAvailableRecordsForSelection_Bank33)
; reads: wListCount, wPartyCount
; points at: wListEntries, wPartyList, wListEntries2
MovePartyRecordsToFrontOfList::
Func_01D_5F9C:: ; address name
    ld a, [wListCount]
    and a, a
    ret z
    ld hl, wListEntries
    ld de, wPartyList
    ld bc, $0000

Jump_01D_5FAA::
    push hl
    push de
    push bc
    ld b, $00

Jump_01D_5FAF::
    ld a, [de]
    ld c, a
    ld a, [hl]
    cp a, c
    jr z, Jump_01D_5FC4
    inc b
    inc hl
    ld a, [wListCount]
    ld c, a
    ld a, b
    cp a, c
    jr c, Jump_01D_5FAF
    pop bc
    pop de
    pop hl
    jr Jump_01D_5FD6

Jump_01D_5FC4::
    ld a, $FF
    ld [hl], a
    pop bc
    ld hl, wListEntries2
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    pop de
    pop hl
    inc b

Jump_01D_5FD6::
    inc c
    inc de
    ld a, [wPartyCount]
    cp a, c
    jr nz, Jump_01D_5FAA
    ld hl, wListEntries2
    ld a, b
    add_a_to_hl
    ld de, wListEntries
    ld a, [wListCount]
    ld c, a

Jump_01D_5FEE::
    ld a, [de]
    cp a, $FF
    jr z, Jump_01D_5FF4
    ld [hl+], a

Jump_01D_5FF4::
    inc de
    dec c
    jr nz, Jump_01D_5FEE
    ld hl, wListEntries2
    ld de, wListEntries
    ld a, [wListCount]
    ld b, a

Jump_01D_6002::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_6002
    ld a, [wListCount]
    cp a, $1E
    jr nc, Jump_01D_6025
    ld hl, wListEntries
    add_a_to_hl
    ld a, [wListCount]
    ld b, a
    ld a, $1E
    sub a, b
    ld b, a

Jump_01D_601F::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_01D_601F

Jump_01D_6025::
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadRecordCapacityFromFarmLevelTable): clears wD789, then appends every record whose byte 0 is 1 or 2 and byte $6E is non-zero; wD7A9 = the list length (E-0104)
; 10 call sites from 10 routines (e.g. EggServiceMenu_Case03, BreedMenu_Case03, BreedMenu_Case04_Case41, BreedMenu_Case05_Case01, ...)
; reads: wRecordCapacity
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, sRecords
ListRecordsInUseWithByte6ESet::
Func_01D_6026:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

Jump_01D_602E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_602E
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_01D_604D::
    ld a, [de]
    and a, a
    jr z, Jump_01D_606E
    cp a, $01
    jr z, Jump_01D_605B
    cp a, $02
    jr z, Jump_01D_605B
    jr Jump_01D_606E

Jump_01D_605B::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_6063
    inc d

Jump_01D_6063::
    ld a, [de]
    and a, a
    jr z, Jump_01D_606D
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_606E

Jump_01D_606D::
    pop de

Jump_01D_606E::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_6075
    inc d

Jump_01D_6075::
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, Jump_01D_604D
    ld a, c
    ld [wListCount], a
    ld [wRecordsFlagged], a
    xor a, a
    ld [rRAMG2], a
    ret

; for the visible entries of page wD7AF draws the species name (field $0B, category 2 of the bank-08 database) of each listed record (E-0129)
; 8 call sites from 8 routines (e.g. EggServiceMenu_Case0F_Case04, BreedMenu_Case05_Case04, BreedMenu_Case0F_Case04, SwapMonstersMenu_Case06_Case19, ...)
; reads: wListPageIndex, wListLastRow, wListCount, hTemp0, hTemp1, wDataBank, wListPages
; writes: rRAMG2, rRAMB, wDataBank, wNameGlyphBuf
; points at: wListEntries, wNameGlyphBuf
DrawRecordListPageSpeciesNames::
Func_01D_6088:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add_a_to_hl
    ld c, $00

Jump_01D_60A0::
    ld a, [wListLastRow]
    cp a, $03
    jr c, Jump_01D_60AC
    ld a, [wListCount]
    jr Jump_01D_60BB

Jump_01D_60AC::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01D_60B8
    ld a, [wListCount]
    jr Jump_01D_60BB

Jump_01D_60B8::
    ld a, [wListCount]

Jump_01D_60BB::
    ld b, a
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add a, c
    cp a, b
    jr nc, Jump_01D_6124
    push hl
    push bc
    ld a, [hl]
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $F0
    ld [wNameGlyphBuf + $F], a
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_01D_6124
    ld a, c
    cp a, $04
    jp c, Jump_01D_60A0

Jump_01D_6124::
    xor a, a
    ld [rRAMG2], a
    ret

; draws the $F0-terminated text at wC8CF glyph by glyph; marks $8D and $8E are ORed onto the previous tile (E-0125)
; 4 call sites from 3 routines (e.g. DrawRecordListPageSpeciesNames, BreedMenu_Case04_Case1C, DrawRecordNameAndSpeciesName)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D::
Func_01D_6129:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

Jump_01D_6133::
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01D_6176
    cp a, $8D
    jr z, Jump_01D_6154
    cp a, $8E
    jr z, Jump_01D_6154
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01
    call CopyFromBankWaitVRAM
    pop bc
    jr Jump_01D_6165

Jump_01D_6154::
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01
    call OrFromBankWaitVRAM
    pop bc

Jump_01D_6165::
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr Jump_01D_6133

Jump_01D_6176::
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; only called from DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D (E-0047)
; 2 call sites from 1 routine (e.g. DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D)
; reads: wArg5, wGlyphListStart
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01::
Func_01D_617F:: ; address name
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, Data_01D_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wArg5]
    and a, a
    jr z, Jump_01D_61B6
    cp a, $01
    jr z, Jump_01D_61B1
    cp a, $02
    jr z, Jump_01D_61AC
    cp a, $03
    jr z, Jump_01D_61A7
    ld de, GlyphTileDestTable_1D_4
    jr Jump_01D_61B9

Jump_01D_61A7::
    ld de, GlyphTileDestTable_1D_3
    jr Jump_01D_61B9

Jump_01D_61AC::
    ld de, GlyphTileDestTable_1D_2
    jr Jump_01D_61B9

Jump_01D_61B1::
    ld de, GlyphTileDestTable_1D_1
    jr Jump_01D_61B9

Jump_01D_61B6::
    ld de, GlyphTileDestTable_1D_0

Jump_01D_61B9::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_61C0
    inc d

Jump_01D_61C0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

; E-0239 (C1: DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01 picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy (E-0235)).
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_0::
Data_01D_61D9:: ; address name
    dw GlyphTileDests_1D_0_0 ; id 0
    dw GlyphTileDests_1D_0_1 ; id 1
    dw GlyphTileDests_1D_0_2 ; id 2
    dw GlyphTileDests_1D_0_3 ; id 3

; E-0239 (C1: list 0 of GlyphTileDestTable_1D_0; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_0_0::
Data_01D_61E1:: ; address name
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; E-0239 (C1: list 1 of GlyphTileDestTable_1D_0; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_0_1::
Data_01D_61F3:: ; address name
    dw vTiles1 + $590, vTiles1 + $5A0, vTiles1 + $5B0, vTiles1 + $5C0, vTiles1 + $5D0, vTiles1 + $5E0 ; entry 0
    dw vTiles1 + $400, vTiles1 + $410, vTiles1 + $420

; E-0239 (C1: list 2 of GlyphTileDestTable_1D_0; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_0_2::
Data_01D_6205:: ; address name
    dw vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790, vTiles1 + $7A0 ; entry 0
    dw vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $3F0

; E-0239 (C1: list 3 of GlyphTileDestTable_1D_0; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_0_3::
Data_01D_6217:: ; address name
    dw vTiles1 + $470, vTiles1 + $480, vTiles1 + $490, vTiles1 + $4A0, vTiles1 + $4B0, vTiles1 + $6A0 ; entry 0
    dw vTiles1 + $6B0, vTiles1 + $6C0, vTiles1 + $6D0

; E-0239 (C1: DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01 picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy (E-0235)).
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_1::
Data_01D_6229:: ; address name
    dw GlyphTileDests_1D_1_0 ; id 0
    dw GlyphTileDests_1D_1_1 ; id 1
    dw GlyphTileDests_1D_1_2 ; id 2
    dw GlyphTileDests_1D_1_3 ; id 3

; E-0239 (C1: list 0 of GlyphTileDestTable_1D_1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_1_0::
Data_01D_6231:: ; address name
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; E-0239 (C1: list 1 of GlyphTileDestTable_1D_1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_1_1::
Data_01D_6243:: ; address name
    dw vTiles1 + $590, vTiles1 + $5A0, vTiles1 + $5B0, vTiles1 + $5C0, vTiles1 + $5D0, vTiles1 + $5E0 ; entry 0
    dw vTiles1 + $790, vTiles1 + $7A0, vTiles1 + $7B0

; E-0239 (C1: list 2 of GlyphTileDestTable_1D_1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_1_2::
Data_01D_6255:: ; address name
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780

; E-0239 (C1: list 3 of GlyphTileDestTable_1D_1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_1_3::
Data_01D_6267:: ; address name
    dw vTiles1 + $400, vTiles1 + $410, vTiles1 + $420, vTiles1 + $470, vTiles1 + $480, vTiles1 + $490 ; entry 0
    dw vTiles1 + $4A0, vTiles1 + $4B0, vTiles1 + $7C0

; E-0239 (C1: DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01 picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy (E-0235)).
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_2::
Data_01D_6279:: ; address name
    dw GlyphTileDests_1D_2_0 ; id 0

; E-0239 (C1: list 0 of GlyphTileDestTable_1D_2; 5 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_2_0::
Data_01D_627B:: ; address name
    dw vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $7D0, vTiles1 + $7E0 ; entry 0

; E-0239 (C1: DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01 picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy (E-0235)).
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_3::
Data_01D_6285:: ; address name
    dw GlyphTileDests_1D_3_0 ; id 0

; E-0239 (C1: list 0 of GlyphTileDestTable_1D_3; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_3_0::
Data_01D_6287:: ; address name
    dw vTiles2 + $770, vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730 ; entry 0
    dw vTiles2 + $740, vTiles2 + $750, vTiles2 + $760

; E-0239 (C1: DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Sub01 picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy (E-0235)).
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_4::
Data_01D_6299:: ; address name
    dw GlyphTileDests_1D_4_0 ; id 0

; E-0239 (C1: list 0 of GlyphTileDestTable_1D_4; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_4_0::
Data_01D_629B:: ; address name
    dw vTiles2 + $7C0, vTiles2 + $7D0, vTiles2 + $7E0, vTiles2 + $7F0, vTiles1 + $400, vTiles1 + $410 ; entry 0
    dw vTiles1 + $420, vTiles1 + $4A0, vTiles1 + $4B0

; with SRAM enabled, for each of the wC6FD record numbers in wC6FE copies the record's name (CopyRecordNameToNameGlyphBuf, C = 1) and draws it as glyph tiles at the VRAM address from Data_01D_62F9 (CopyGlyphTilesToVRAM); then disables SRAM (E-0106)
; 6 call sites from 6 routines (e.g. LibraryMenu_Case08, CloseHibernateMenu_Case03, HibernateMenu_Case05_Case0E, CloseBreedMenu_Case03, ...)
; reads: wPartyCount
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wPartyList, wTextWindowTileLo
DrawRecordListNameTiles_Bank1D::
Func_01D_62AD:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $00

Jump_01D_62B8::
    push bc
    ld hl, wPartyList
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, Data_01D_62F9
    pop bc
    push bc
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    ld a, [wPartyCount]
    cp a, c
    jr nz, Jump_01D_62B8
    xor a, a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

; address loaded by DrawRecordListNameTiles_Bank1D
Data_01D_62F9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 6 call sites from 6 routines (e.g. DrawRecordListPageMarks, MarkPartyMembersInRecordListPage, UpdatePagedListCursor_Sub04, DrawTwoChoiceCursorConfirmed, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1D_62FF::
Func_01D_62FF:: ; address name
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

; for the visible entries of page wD7AF draws each record's mark ($CC/$CD from field $0E, or $CE for state 2) beside it (E-0130)
; 10 call sites from 10 routines (e.g. EggServiceMenu_Case05_Case11, EggServiceMenu_Case0F_Case05, BreedMenu_Case05_Case05, LoadTile4990AndRun6320, ...)
; reads: wListPageIndex, wListLastRow, wListCount, hTemp0, wArg2, wArg1, wListPages
; writes: rRAMG2, rRAMB
; points at: wListEntries
DrawRecordListPageMarks::
Func_01D_6320:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add_a_to_hl
    ld c, $00

Jump_01D_6338::
    ld a, [wListLastRow]
    cp a, $03
    jr c, Jump_01D_6344
    ld a, [wListCount]
    jr Jump_01D_6353

Jump_01D_6344::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01D_6350
    ld a, [wListCount]
    jr Jump_01D_6353

Jump_01D_6350::
    ld a, [wListCount]

Jump_01D_6353::
    ld b, a
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add a, c
    cp a, b
    jp nc, Jump_01D_63F5
    push hl
    push bc
    ld a, [hl]
    ld c, $6E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $02
    jr nz, Jump_01D_637F
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    ld e, a
    jr Jump_01D_6381

Jump_01D_637F::
    ld e, $CE

Jump_01D_6381::
    pop bc
    push bc
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    push hl
    ld a, [wArg2]
    and a, a
    jr z, Jump_01D_639C
    cp a, $01
    jr z, Jump_01D_6397
    ld hl, Data_01D_640A
    jr Jump_01D_639F

Jump_01D_6397::
    ld hl, Data_01D_6402
    jr Jump_01D_639F

Jump_01D_639C::
    ld hl, Data_01D_63FA

Jump_01D_639F::
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    pop de
    ld a, [wArg1]
    and a, a
    jr nz, Jump_01D_63BC
    di
    call WaitForVRAMAccess
    ld a, e
    ld [hl], a
    ei

Jump_01D_63BC::
    pop bc
    push bc
    push de
    ld a, [wArg2]
    and a, a
    jr z, Jump_01D_63D3
    cp a, $01
    jr z, Jump_01D_63CE
    ld de, Data_01D_6422
    jr Jump_01D_63D6

Jump_01D_63CE::
    ld de, Data_01D_641A
    jr Jump_01D_63D6

Jump_01D_63D3::
    ld de, Data_01D_6412

Jump_01D_63D6::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_63DD
    inc d

Jump_01D_63DD::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, e
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_01D_63F5
    ld a, c
    cp a, $04
    jp c, Jump_01D_6338

Jump_01D_63F5::
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawRecordListPageMarks
Data_01D_63FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $32, $00, $72, $00, $B2, $00, $F2, $00

; address loaded by DrawRecordListPageMarks
Data_01D_6402:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B2, $00, $F2, $00, $32, $01, $72, $01

; address loaded by DrawRecordListPageMarks
Data_01D_640A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $00, $6B, $00, $AB, $00, $EB, $00

; address loaded by DrawRecordListPageMarks
Data_01D_6412:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $C3, $B2, $C3, $DA, $C3, $02, $C4

; address loaded by DrawRecordListPageMarks
Data_01D_641A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DA, $C3, $02, $C4, $2A, $C4, $52, $C4

; address loaded by DrawRecordListPageMarks
Data_01D_6422:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $83, $C3, $AB, $C3, $D3, $C3, $FB, $C3

; only called from routines of SwapMonstersMenu (E-0098)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case06_Case02, SwapMonstersMenu_Case07_Case02)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursorF0
; writes: wMenuInputResult, wChoiceCursorF0
SwapMonstersMenu_Shared01::
Func_01D_642A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_645F
    bit 7, a
    jr nz, Jump_01D_646F
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_6448
    bit 1, a
    jr nz, Jump_01D_6456
    call BlinkCursorBlinkB8_Bank1D_648E
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6448::
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_Shared01_Sub01
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6456::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, $FE
    ld [wMenuInputResult], a
    ret

Jump_01D_645F::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_01D_646C
    ld a, $01
    jr Jump_01D_647D

Jump_01D_646C::
    dec a
    jr Jump_01D_647D

Jump_01D_646F::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wChoiceCursorF0]
    cp a, $01
    jr c, Jump_01D_647C
    xor a, a
    jr Jump_01D_647D

Jump_01D_647C::
    inc a

Jump_01D_647D::
    ld [wChoiceCursorF0], a
    call DrawCursorTileBB_64A8_Bank1D
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; cycles wD7B8 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Shared01)
; reads: wJoypadRepeatTimer, wCursorBlinkB8, wChoiceCursorF0
; writes: wCursorBlinkB8
BlinkCursorBlinkB8_Bank1D_648E::
Func_01D_648E:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_64A8_Bank1D
    ld a, [wCursorBlinkB8]
    inc a
    ld [wCursorBlinkB8], a
    cp a, $10
    jr c, DrawCursorTileBB_64A8_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_64AC_Bank1D
    xor a, a
    ld [wCursorBlinkB8], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Shared01)
; reads: wChoiceCursorF0
DrawCursorTileBB_64A8_Bank1D::
Func_01D_64A8:: ; address name
    ld b, $BB
    jr Jump_01D_64B2

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 3 call sites from 1 routine (e.g. SwapMonstersMenu_Shared01)
; reads: wChoiceCursorF0
DrawBlankTileC3_64AC_Bank1D::
Func_01D_64AC:: ; address name
    ld b, $C3
    jr Jump_01D_64B2

; only called from SwapMonstersMenu_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Shared01)
; reads: wChoiceCursorF0
SwapMonstersMenu_Shared01_Sub01::
Func_01D_64B0:: ; address name
    ld b, $BC

Jump_01D_64B2::
    ld a, [wChoiceCursorF0]
    add a, a
    ld hl, Data_01D_64D2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by SwapMonstersMenu_Shared01_Sub01
Data_01D_64D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $28, $01, $68, $01

; up/down moves wD7AB over wD7A9 entries ($FD), A selects ($FF, sound $69), B cancels ($FE); wD7AF = 0 (E-0128)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case0D_Case07, RunLinkSession8Case03Steps_Case07)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListCount, wListCursor
; writes: wListPageIndex, wMenuInputResult, wListCursor
HandleListCursorInput_1D::
Func_01D_64D6:: ; address name
    xor a, a
    ld [wListPageIndex], a
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_6506
    bit 7, a
    jr nz, Jump_01D_651B
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_01D_64F5
    bit 0, a
    jr nz, Jump_01D_64FB
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_64F5::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

Jump_01D_64FB::
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6506::
    ld a, [wListCursor]
    and a, a
    jr nz, Jump_01D_6518
    ld a, [wListCount]
    dec a
    jr nz, Jump_01D_6532
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6518::
    dec a
    jr Jump_01D_6532

Jump_01D_651B::
    ld a, [wListCount]
    dec a
    jr nz, Jump_01D_6527
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6527::
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_01D_6531
    xor a, a
    jr Jump_01D_6532

Jump_01D_6531::
    inc a

Jump_01D_6532::
    ld [wListCursor], a
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks (wD783 counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Cursor positions are BG map offsets $012F and $016F from the scroll origin (E-0068)
; 27 call sites from 27 routines (e.g. ArenaMenu_Case26, ArenaMenu_Case04, ArenaMenu_Case0C, ArenaMenu_Case17, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
UpdateTwoChoiceCursor_Bank1D::
Func_01D_6540:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_655E
    bit 7, a
    jr nz, Jump_01D_6574
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_659A
    bit 1, a
    jr nz, Jump_01D_65A8
    call BlinkTwoChoiceCursor
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_655E::
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01D_656E
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_656E::
    dec a
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_6574::
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr c, Jump_01D_6584
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_6584::
    inc a
    ld [wTwoChoiceCursor], a

Jump_01D_6588::
    xor a, a
    ld [wScreenCounter], a
    call DrawTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_659A::
    call DrawTwoChoiceCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_65A8::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; once wJoypadRepeatTimer >= $14, counts wD783 up: frames 0-$0F draw the cursor, $10-$17 erase it, then the count restarts (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wJoypadRepeatTimer, wScreenCounter, wTwoChoiceCursor
; writes: wScreenCounter
BlinkTwoChoiceCursor::
Func_01D_65AE:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    jr c, DrawTwoChoiceCursor
    cp a, $18
    jr c, EraseTwoChoiceCursor
    xor a, a
    ld [wScreenCounter], a

; writes tile $BB at the position of wTwoChoiceCursor (Data_01D_65F2 offset from BGMapAddressAtScroll, StepBGMapAddressBackOnScrollWrap) (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
DrawTwoChoiceCursor::
Func_01D_65C8:: ; address name
    ld b, $BB
    jr Jump_01D_65D2

; writes tile $C3 at the position of wTwoChoiceCursor (E-0068)
; 2 call sites from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
EraseTwoChoiceCursor::
Func_01D_65CC:: ; address name
    ld b, $C3
    jr Jump_01D_65D2

; writes tile $BC at the position of wTwoChoiceCursor (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
DrawTwoChoiceCursorConfirmed::
Func_01D_65D0:: ; address name
    ld b, $BC

Jump_01D_65D2::
    ld a, [wTwoChoiceCursor]
    add a, a
    ld hl, Data_01D_65F2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawTwoChoiceCursorConfirmed
Data_01D_65F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; list cursor over wD7A9 entries: Up/Down move wD7AB with wrap, erase and redraw the cursor, play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor, plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks and the result is 0 (the codes of UpdatePagedListCursor) (E-0106)
; 7 call sites from 7 routines (e.g. SwapMonstersMenu_Case04_Case05, SwapMonstersMenu_Case05_Case25, SwapMonstersMenu_Case08_Case06, SwapMonstersMenu_Case08_Case15, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListCount, wListCursor
; writes: wMenuInputResult, wListCursor, wListCursorAux
UpdateListCursorListCursor::
Func_01D_65F6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_6614
    bit 7, a
    jr nz, Jump_01D_662C
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_6656
    bit 1, a
    jr nz, Jump_01D_6664
    call UpdateListCursorListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6614::
    call UpdateListCursorListCursor_Sub03
    ld a, [wListCursor]
    and a, a
    jr nz, Jump_01D_6626
    ld a, [wListCount]
    dec a
    ld [wListCursor], a
    jr Jump_01D_6644

Jump_01D_6626::
    dec a
    ld [wListCursor], a
    jr Jump_01D_6644

Jump_01D_662C::
    call UpdateListCursorListCursor_Sub03
    ld a, [wListCount]
    dec a
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_01D_6640
    xor a, a
    ld [wListCursor], a
    jr Jump_01D_6644

Jump_01D_6640::
    inc a
    ld [wListCursor], a

Jump_01D_6644::
    xor a, a
    ld [wListCursorAux], a
    call UpdateListCursorListCursor_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6656::
    ld a, $69
    call QueueSoundEffect
    call UpdateListCursorListCursor_Sub04
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6664::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wJoypadRepeatTimer, wListCursorAux, wListCursor
; writes: wListCursorAux
UpdateListCursorListCursor_Sub01::
Func_01D_666A:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdateListCursorListCursor_Sub02
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp a, $10
    jr c, UpdateListCursorListCursor_Sub02
    cp a, $18
    jr c, UpdateListCursorListCursor_Sub03
    xor a, a
    ld [wListCursorAux], a

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_Sub02::
Func_01D_6684:: ; address name
    ld b, $BB
    jr Jump_01D_668E

; only called from UpdateListCursorListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_Sub03::
Func_01D_6688:: ; address name
    ld b, $C3
    jr Jump_01D_668E

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_Sub04::
Func_01D_668C:: ; address name
    ld b, $BC

Jump_01D_668E::
    ld a, [wListCursor]
    add a, a
    ld hl, Data_01D_66AE
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by UpdateListCursorListCursor_Sub04
Data_01D_66AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00

; row wD7AB runs 0..wD7B1 and page wD7AF runs 0..wD7B0 - 1, both wrapping; Up/Down move the row (wMenuInputResult = $FD), Left/Right move the page ($FB); a move erases the old cursor (tile $C3) and draws the new one (tile $BB) with sound $69; A draws tile $BC, plays sound $69 and sets $FF; B sets $FE. When the range is a single entry the press only blinks the cursor and the result is 0, as with no input (E-0068)
; 34 call sites from 34 routines (e.g. EggServiceMenu_Case05_Case06, KeyAppraisalMenu_Case03_Case05, MedalPrizeMenu_Case05_Case07, HibernateMenu_Case05_Case25, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListLastRow, wListCursor, wListPageIndex, wListPages
; writes: wMenuInputResult, wListCursor, wListCursorAux, wListPageIndex
UpdatePagedListCursor::
Func_01D_66B6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01D_66E3
    bit 5, a
    jr nz, Jump_01D_6713
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, Jump_01D_6730
    bit 7, a
    jp nz, Jump_01D_6752
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01D_6789
    bit 1, a
    jp nz, Jump_01D_6797
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_66E3::
    ld a, [wListPages]
    ld b, a
    ld a, [wListPageIndex]
    inc a
    cp a, b
    jr c, Jump_01D_66FE
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01D_66FD
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_66FD::
    xor a, a

Jump_01D_66FE::
    ld [wListPageIndex], a
    xor a, a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FB
    ld [wMenuInputResult], a
    ret

Jump_01D_6713::
    ld a, [wListPageIndex]
    and a, a
    jr nz, Jump_01D_672C
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01D_6728
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6728::
    dec a
    jp Jump_01D_66FE

Jump_01D_672C::
    dec a
    jp Jump_01D_66FE

Jump_01D_6730::
    call UpdatePagedListCursor_Sub03
    ld a, [wListCursor]
    and a, a
    jr nz, Jump_01D_674C
    ld a, [wListLastRow]
    and a, a
    jr nz, Jump_01D_6747
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6747::
    ld [wListCursor], a
    jr Jump_01D_6777

Jump_01D_674C::
    dec a
    ld [wListCursor], a
    jr Jump_01D_6777

Jump_01D_6752::
    call UpdatePagedListCursor_Sub03
    ld a, [wListLastRow]
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_01D_6773
    ld a, [wListLastRow]
    and a, a
    jr nz, Jump_01D_676D
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_676D::
    xor a, a
    ld [wListCursor], a
    jr Jump_01D_6777

Jump_01D_6773::
    inc a
    ld [wListCursor], a

Jump_01D_6777::
    xor a, a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6789::
    call UpdatePagedListCursor_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6797::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdatePagedListCursor (E-0047)
; 5 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wJoypadRepeatTimer, wListCursorAux, wMenuInputResult, wListCursor
; writes: wListCursorAux
UpdatePagedListCursor_Sub01::
Func_01D_679D:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdatePagedListCursor_Sub02
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp a, $10
    jr c, UpdatePagedListCursor_Sub02
    cp a, $18
    jr c, UpdatePagedListCursor_Sub03
    xor a, a
    ld [wListCursorAux], a

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_Sub02::
Func_01D_67B7:: ; address name
    ld b, $BB
    jr Jump_01D_67C1

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_Sub03::
Func_01D_67BB:: ; address name
    ld b, $C3
    jr Jump_01D_67C1

; only called from UpdatePagedListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_Sub04::
Func_01D_67BF:: ; address name
    ld b, $BC

Jump_01D_67C1::
    ld a, [wMenuInputResult]
    ld c, a
    add a, a
    add a, a
    add a, c
    add a, a
    ld hl, Data_01D_67EE
    add_a_to_hl
    ld a, [wListCursor]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by UpdatePagedListCursor_Sub04
Data_01D_67EE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $28, $00, $68, $00, $A8, $00
    db $E8, $00, $28, $01, $A8, $00, $E8, $00, $28, $01, $68, $01, $A8, $01, $A6, $00
    db $E6, $00, $26, $01, $66, $01, $A6, $01, $A4, $00, $E4, $00, $24, $01, $64, $01
    db $A4, $01, $A2, $00, $E2, $00, $22, $01, $62, $01, $A2, $01

; for the three records listed at wD7F1 loads each species' sprite graphics and palette to the slots in Data_01D_6890 (E-0128)
; 4 call sites from 4 routines (e.g. PauseMenu_Main_Case03_Case01_Sub01, SwapMonstersMenu_Case0D_Case04, SwapMonstersMenu_Case09_Case1E, RunLinkSession8Case03Steps_Case04)
; reads: wArg1, wArg2, hTemp0, hTemp1
; writes: rRAMG2, rRAMB, rRAMG
; points at: wArg3
LoadPartySpeciesSpriteGraphics::
Func_01D_682A:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    ld bc, $0300

Jump_01D_683E::
    push hl
    push bc
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    jr nz, Jump_01D_6851
    ld de, Data_01D_6DE0
    jr Jump_01D_6854

Jump_01D_6851::
    ld de, Data_01D_6DE3

Jump_01D_6854::
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_01D_685E
    inc d

Jump_01D_685E::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp a, $FF
    jr z, Jump_01D_6885
    pop bc
    push bc
    ld a, c
    add a, a
    add a, c
    ld de, Data_01D_6890
    add a, e
    ld e, a
    jr nc, Jump_01D_6877
    inc d

Jump_01D_6877::
    ld hl, wArg3
    ld c, $03

Jump_01D_687C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_01D_687C
    call LoadSpeciesSpriteGraphicsAndPalette

Jump_01D_6885::
    pop bc
    pop hl
    inc c
    dec b
    jr nz, Jump_01D_683E
    xor a, a
    ld [rRAMG], a
    ret

; address loaded by LoadPartySpeciesSpriteGraphics
Data_01D_6890:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; for the three records listed at wD7F1 draws each species sprite at the positions in Data_01D_6909 (E-0128)
; 5 call sites from 5 routines (e.g. CallDrawPartySpeciesSpritesPreservingArg1AndTemp0, PauseMenu_Main_Case03_Case02, SwapMonstersMenu_Case0D_Case07, SwapMonstersMenu_Case08_Case20, ...)
; reads: wArg1, wArg2, hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wArg1, wArg2
DrawPartySpeciesSprites::
Func_01D_6899:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    ld bc, $0300

Jump_01D_68AD::
    push hl
    push bc
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    jr nz, Jump_01D_68C0
    ld de, Data_01D_6DE0
    jr Jump_01D_68C3

Jump_01D_68C0::
    ld de, Data_01D_6DE3

Jump_01D_68C3::
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_01D_68CD
    inc d

Jump_01D_68CD::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp a, $FF
    jr z, Jump_01D_68FE
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    add a, a
    add a, a
    ld hl, Data_01D_6909
    add_a_to_hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld l, c
    ld h, b
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset

Jump_01D_68FE::
    pop bc
    pop hl
    inc c
    dec b
    jr nz, Jump_01D_68AD
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawPartySpeciesSprites
Data_01D_6909:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; decompresses the sprite graphics of species hFFC6/7 (far pointer Data_004_4EAA + 3 * id) to the VRAM address in wD7F4/5; on CGB copies its 8-byte palette from bank $27 into wOBJPaletteBuffer + wD7F3 (E-0127)
; 1 call site from 1 routine (e.g. LoadPartySpeciesSpriteGraphics)
; reads: hTemp0, hTemp1, wArg4, wArg5, wIsCGB, wArg3, rSTAT
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
LoadSpeciesSpriteGraphicsAndPalette::
Func_01D_6915:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ld e, a
    ldh a, [hTemp1]
    ld h, a
    ld d, a
    push hl
    add hl, hl
    add hl, de
    ld de, MonsterSpriteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wArg4]
    ld l, a
    ld a, [wArg5]
    ld h, a
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wOBJPaletteBuffer
    ld a, [wArg3]
    add_a_to_hl
    ld c, $08

Jump_01D_695A::
    push bc
    call ReadByteInBank
    di

Jump_01D_695F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_695F
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, Jump_01D_695A
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; graphics number = the word wD7F1/wD7F2: reads its far pointer (3 bytes per entry) from Data_004_4EAA in bank $04 (ReadFarPointerAtDEInBankB) and DecompressToVRAM to the address in wD7F4/wD7F5; on CGB it continues with the palette (not read) (E-0104)
; 8 call sites from 8 routines (e.g. DecompressRecordSpeciesGraphicsToTiles0, LibraryMenu_Case10_Case03, RunNameEntryStateWhenNotFading_Case00_Case03, DecompressGraphicsA4ToTiles0, ...)
; reads: wArg1, wArg2, wArg4, wArg5, wIsCGB, wArg3, rSTAT
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
DecompressGraphicsArg1ToArg4::
Func_01D_6973:: ; address name
    ld a, [wArg1]
    ld l, a
    ld e, a
    ld a, [wArg2]
    ld h, a
    ld d, a
    add hl, hl
    add hl, de
    ld de, MonsterSpriteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wArg4]
    ld l, a
    ld a, [wArg5]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01D_69D9
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wOBJPaletteBuffer
    ld a, [wArg3]
    add_a_to_hl
    ld c, $08

Jump_01D_69C1::
    push bc
    call ReadByteInBank
    di

Jump_01D_69C6::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_69C6
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, Jump_01D_69C1
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

Jump_01D_69D9::
    ret

; draws sprite set wD7F1 & $7F (from bank $25, $26 or $27 by wD7F2 and bit 7 of wD7F1) at the scroll position + (L, D), tile offset H, attribute E, alternating two frames (E-0127)
; 2 call sites from 2 routines (e.g. DrawPartySpeciesSprites, DrawListEntriesCell5SpeciesSprite)
; reads: wFrameCounterLo, hScrollX, hScrollXHi, hScrollY, hScrollYHi, wArg1, wArg2
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawSpeciesMetaSpriteAtScrollOffset::
Func_01D_69DA:: ; address name
    ld c, $00
    ld a, e
    ldh [hSpriteAttrXor], a
    ld a, c
    and a, a
    jr nz, Jump_01D_69F1
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr Jump_01D_69F4

Jump_01D_69F1::
    xor a, a
    ldh [hSpriteSubIndex], a

Jump_01D_69F4::
    ld a, h
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    add a, l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    add a, d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    ld a, [wArg1]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wArg2]
    or a, a
    jr nz, Jump_01D_6A2F
    ld a, [wArg1]
    bit 7, a
    jr nz, Jump_01D_6A28
    farcall DrawMetaSpriteSet_Bank25
    ret

Jump_01D_6A28::
    farcall DrawMetaSpriteSet_Bank26
    ret

Jump_01D_6A2F::
    farcall DrawMetaSpriteSet_Bank27
    ret

; only called from DrawThreeMetaSpritePartsFor5050 (E-0047)
; 3 call sites from 1 routine (e.g. DrawThreeMetaSpritePartsFor5050)
; reads: wArg6, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, hScrollYHi, ...
; writes: hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawThreeMetaSpritePartsFor5050_Sub01::
Func_01D_6A36:: ; address name
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    jr Jump_01D_6A59

; C = 0, then falls into the sprite part draw (Func_01D_6A36 body) (E-0122)
; 6 call sites from 6 routines (e.g. PauseMenu_Main_Case01_Case02, RunNameEntryStateWhenNotFading_Shared01, SwapMonstersMenu_Case08_Case15, DrawWCA36SpritePart, ...)
; reads: wArg6, wFrameCounterLo, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawMetaSpritePartC0::
Func_01D_6A3D:: ; address name
    ld c, $00

; only called from DrawSpritePart9000At88_28 (E-0047)
; 1 call site from 1 routine (e.g. DrawSpritePart9000At88_28)
; reads: wArg6, wFrameCounterLo, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawSpritePart9000At88_28_Sub01::
Func_01D_6A3F:: ; address name
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    ld a, c
    and a, a
    jr nz, Jump_01D_6A56
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr Jump_01D_6A59

Jump_01D_6A56::
    xor a, a
    ldh [hSpriteSubIndex], a

Jump_01D_6A59::
    ld a, [wArg3]
    ldh [hSpriteTileOffset], a
    ld a, [wArg4]
    ld b, a
    ldh a, [hScrollX]
    add a, b
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ld a, [wArg5]
    ld b, a
    ldh a, [hScrollY]
    add a, b
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    ld a, [wArg1]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wArg2]
    or a, a
    jr nz, Jump_01D_6A9E
    ld a, [wArg1]
    bit 7, a
    jr nz, Jump_01D_6A97
    farcall DrawMetaSpriteSet_Bank25
    ret

Jump_01D_6A97::
    farcall DrawMetaSpriteSet_Bank26
    ret

Jump_01D_6A9E::
    farcall DrawMetaSpriteSet_Bank27
    ret

; for each party record found on the current list page (wD789 page wD7AF) draws a party mark at its row (scroll offsets Data_01D_6B28 when wD7F1 is set, else screen-buffer offsets Data_01D_6B1E) (E-0128)
; 14 call sites from 10 routines (e.g. HibernateMenu_Case06_Case04, BreedMenu_Case04_Case03, EggServiceMenu_Bank1B_Case0E_Case02, SwapMonstersMenu_Case06_Case08, ...)
; reads: wListPageIndex, wListLastRow, wPartyCount, wArg1
; writes: rRAMG2, rRAMB
; points at: wPartyList, wListEntries
MarkPartyMembersInRecordListPage::
Func_01D_6AA5:: ; address name
    ld hl, wPartyList
    ld bc, $0000
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a

Jump_01D_6AB4::
    push bc
    push hl
    ld b, [hl]
    ld a, [wListPageIndex]
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wListEntries
    add_a_to_hl
    ld c, $00

Jump_01D_6AC8::
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_6AE3
    inc hl
    inc c
    ld a, [wListLastRow]
    cp a, c
    jr nc, Jump_01D_6AC8
    pop hl
    pop bc

Jump_01D_6AD6::
    inc hl
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_01D_6AB4
    xor a, a
    ld [rRAMG2], a
    ret

Jump_01D_6AE3::
    ld a, [wArg1]
    and a, a
    jr z, Jump_01D_6B03
    ld hl, Data_01D_6B28
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld e, l
    ld d, h
    jr Jump_01D_6B10

Jump_01D_6B03::
    ld a, c
    add a, a
    ld hl, Data_01D_6B1E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01D_6B10::
    pop hl
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E1
    ld [de], a
    ei
    jp Jump_01D_6AD6

; address loaded by MarkPartyMembersInRecordListPage
Data_01D_6B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $78, $C3, $A0, $C3, $C8, $C3, $F0, $C3, $18, $C4

; address loaded by MarkPartyMembersInRecordListPage
Data_01D_6B28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $00, $60, $00, $A0, $00, $E0, $00, $20, $01

; only called from SwapMonstersMenu_Case03 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case03)
; reads: wGridCursorX, wScreenState, wListCount, wPartyCount
; writes: wScreenState, wScreenStep, wTwoChoiceCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest, wScreenSubStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case03_Sub01::
Func_01D_6B32:: ; address name
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wGridCursorX]
    and a, a
    jr z, Jump_01D_6B54
    cp a, $01
    jp z, Jump_01D_6B93
    cp a, $02
    jp z, Jump_01D_6BF0
    cp a, $03
    jp z, Jump_01D_6C02

Jump_01D_6B54::
    call ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    cp a, $02
    jr c, Jump_01D_6B7C
    xor a, a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6B7C::
    ld a, $10
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6B93::
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a, a
    jr nz, Jump_01D_6BBA
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BBA::
    ld a, [wScreenState]
    add a, $02
    ld [wScreenState], a
    ld a, [wPartyCount]
    cp a, $03
    jr c, Jump_01D_6BDD
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $1E
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BDD::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BF0::
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6C02::
    ld a, [wScreenState]
    add a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; copies tiles listed at the address in wD7F3/4 to wD7F1/2 + 16 * n, six per call; wD7F5 = $FF when the $FF end is reached, else 0 (E-0128)
; 7 call sites from 7 routines (e.g. CloseHibernateMenu_Case01, BreedMenu_Case04_Case20, BreedMenu_Case04_Case32, BreedMenu_Case05_Case08, ...)
; reads: wArg3, wArg4, wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wGlyphListPos, wGlyphListStart, wArg5
LoadTileListSixPerCall::
Func_01D_6C14:: ; address name
    ld a, [wArg3]
    ld d, a
    ld a, [wArg4]
    ld e, a
    xor a, a
    ld [wGlyphListPos], a

Jump_01D_6C20::
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_6C2B
    inc d

Jump_01D_6C2B::
    ld a, [de]
    cp a, $FF
    jr z, Jump_01D_6C6A
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    push de
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    add hl, de
    pop de
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $06
    jr c, Jump_01D_6C20
    xor a, a
    ld [wArg5], a
    ret

Jump_01D_6C6A::
    pop de
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ld a, $FF
    ld [wArg5], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 7 call sites from 3 routines (e.g. LoadTileListSixPerCall, LoadTileList6DC4SixPerFrame, UploadTilesFromData6D20)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1D::
Func_01D_6C79:: ; address name
    ld c, $10

Jump_01D_6C7B::
    di

Jump_01D_6C7C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_6C7C
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01D_6C7B
    ret

; HL = Data_01D_6D84, wD7F1/2 = $9C/0, DE = vBGMap1, wD784 = 0, then continues at Jump_01D_6CB2 (E-0126)
; 2 call sites from 2 routines (e.g. HibernateMenu_Case01_ToSetupTileMap6D84AtBGMap1, SwapMonstersMenu_Case01_ToSetupTileMap6D84AtBGMap1)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
SetupTileMap6D84AtBGMap1::
Func_01D_6C8A:: ; address name
    ld hl, Data_01D_6D84
    ld a, $9C
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, vBGMap1
    xor a, a
    ld [wGlyphListPos], a
    jr Jump_01D_6CB2

; copies tiles listed in Data_01D_6DC4 to vBGMap1 + $200 onward six per call; at the $FF end resets the counters and wD781 += 1 (E-0127)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case06_ToLoadTileList6DC4SixPerFrame, RunLinkSession8Case01Steps_ToLoadTileList6DC4SixPerFrame)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
LoadTileList6DC4SixPerFrame::
Func_01D_6C9F:: ; address name
    ld hl, Data_01D_6DC4
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, vBGMap1 + $200
    xor a, a
    ld [wGlyphListPos], a

Jump_01D_6CB2::
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01D_6CF9
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e
    push hl
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $06
    jr c, Jump_01D_6CB2
    ret

Jump_01D_6CF9::
    pop de
    pop hl
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies tiles from Data_01D_6D20: two to vTiles2 + $6E0 and three to vTiles2 + $7C0 (CopyTileBytesToVRAM_Bank1D) (E-0118)
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_Case09_Case1B_Case00, SwapMonstersMenu_Case0D_Case04, SwapMonstersMenu_Case08_Case1B, RunLinkSession8Case03Steps_Case04)
UploadTilesFromData6D20::
Func_01D_6D07:: ; address name
    ld hl, Tiles_1D_6D20
    ld de, vTiles2 + $6E0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ld de, vTiles2 + $7C0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ret

; E-0238 (derived: HL = $6D20 and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_1D_6D20::
Data_01D_6D20:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $FF ; entry 0
    db $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 1
    db $FF, $FF, $FF, $FF, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 2
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $FF, $FF, $FF ; entry 3
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 4

; C = wD7FF = Data_01D_6D81[wC7C7] (E-0073)
; 10 call sites from 9 routines (e.g. ListRecordsInUseWithByte6ESet, ListRecordsState1WithByte6EClear, ListRecordsInUseWithByte6EClear, ListPartyRecordsWithState2ToListEntries, ...)
; reads: wFarmLevel
; writes: wRecordCapacity
LoadRecordCapacityFromFarmLevelTable::
Func_01D_6D70:: ; address name
    ld a, [wFarmLevel]
    ld de, Data_01D_6D81
    add a, e
    ld e, a
    jr nc, Jump_01D_6D7B
    inc d

Jump_01D_6D7B::
    ld a, [de]
    ld c, a
    ld [wRecordCapacity], a
    ret

; address loaded by LoadRecordCapacityFromFarmLevelTable
Data_01D_6D81:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

; address loaded by SetupTileMap6D84AtBGMap1
Data_01D_6D84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $F0, $8A, $E0, $8E, $F0, $8E, $00, $8F, $10, $8F
    db $20, $8F, $30, $8F, $40, $8F, $50, $8F, $60, $8F, $70, $8F, $80, $8F, $90, $8F
    db $A0, $8F, $B0, $8F, $C0, $8F, $D0, $8F, $E0, $8F, $F0, $8F, $B0, $8E, $FF, $FF

; address loaded by LoadTileList6DC4SixPerFrame
Data_01D_6DC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $F0, $8B, $A0, $8E, $B0, $8E, $C0, $8E, $D0, $8E, $FF, $FF

; address loaded by LoadPartySpeciesSpriteGraphics, DrawPartySpeciesSprites
Data_01D_6DE0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1A, $1C

; address loaded by LoadPartySpeciesSpriteGraphics, DrawPartySpeciesSprites
Data_01D_6DE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1C, $1A, $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0
    db $8C, $B0, $8C, $FF, $FF

; wD7F5 = the number of SRAM records (29 in bank 0 from sB356 plus one in bank 1) with bit 7 of byte 0 set (E-0125)
; 4 call sites from 3 routines (e.g. PauseMenu_State3_Case05_Case00, HibernateMenu_Case03, StartRecordListOrNoneMessage)
; writes: rRAMG2, rRAMB, wArg5
; points at: sCompactRecords, sRecords
CountFlaggedSRAMRecords::
Func_01D_6DF8:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wArg5], a
    ld hl, sCompactRecords
    ld c, $00
    ld b, $00

Jump_01D_6E0C::
    ld a, [hl]
    bit 7, a
    jr z, Jump_01D_6E12
    inc c

Jump_01D_6E12::
    inc b
    ld a, $6F
    add_a_to_hl
    ld a, b
    cp a, $1D
    jr c, Jump_01D_6E0C
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, Jump_01D_6E2D
    inc c

Jump_01D_6E2D::
    ld a, c
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; packs SRAM record wD7F1's family, state, mark and other fields into the compact form in SRAM bank wD7F2 (wD7E0 workspace) (E-0131)
; 4 call sites from 4 routines (e.g. SaveStepCopyBank1RecordSaveRecordIndex, HibernateMenu_Case05_Case3F, HibernateMenu_Case04_Case16, HibernateMenu_Case04_Case42)
; reads: wArg2, wPackByteE1, wPackByteE6
; writes: rRAMB, rRAMG2, wPackByteE1, wPackFields, wPackWork, wArg5
; points at: wPackWork, wPackFields
PackRecordFieldsToBank1Slot::
Func_01D_6E39:: ; address name
    ld bc, $0007
    ld hl, wPackWork

Jump_01D_6E3F::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01D_6E3F
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push de
    ld a, [de]
    and a, $03
    swap a
    sla a
    set 7, a
    ld c, a
    pop de
    push de
    ld a, $0D
    add a, e
    ld e, a
    jr nc, Jump_01D_6E61
    inc d

Jump_01D_6E61::
    ld a, [de]
    and a, $1F
    or a, c
    pop de
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    push hl
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_01D_6E7F
    inc d

Jump_01D_6E7F::
    ld a, [de]
    and a, $01
    sla a
    sla a
    sla a
    ld c, a
    ld a, [de]
    and a, $F0
    or a, c
    ld c, a
    pop de
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_6E97
    inc d

Jump_01D_6E97::
    ld a, [de]
    and a, $03
    sla a
    or a, c
    ld c, a
    pop de
    push de
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_6EA7
    inc d

Jump_01D_6EA7::
    inc de
    ld a, [de]
    and a, $01
    or a, c
    ld c, a
    dec de
    ld a, [de]
    pop de
    pop hl
    ld b, a
    ld a, c
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    ld a, b
    ld [hl+], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a

Jump_01D_6EC5::
    ld hl, wPackFields
    ld c, $00

Jump_01D_6ECA::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01D_6ECA
    call SRAMRecordAddressOfArg1
    ld a, $03
    add_a_to_hl
    ld a, [wPackByteE1]
    ld b, a
    sla a
    sla a
    add a, b
    add_a_to_hl
    ld bc, $0000
    call EnableSRAMBank0
    push hl
    ld a, [wPackByteE1]
    ld hl, Data_01D_6F9A
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, e
    ld e, a
    jr nc, Jump_01D_6F03
    inc d

Jump_01D_6F03::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    push de
    push hl
    push bc
    ld a, [de]
    cp a, $8D
    jr z, Jump_01D_6F36
    cp a, $8E
    jr z, Jump_01D_6F36
    cp a, $F0
    jr z, Jump_01D_6F69
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    push bc
    ld a, c
    ld hl, wPackFields
    add_a_to_hl
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    inc b
    jr Jump_01D_6F5B

Jump_01D_6F36::
    pop bc
    dec c
    push bc
    ld b, a
    ld a, c
    ld hl, wPackFields
    add_a_to_hl
    ld a, b
    cp a, $8D
    jr z, Jump_01D_6F4C
    ld a, $02
    jr Jump_01D_6F4E

Jump_01D_6F4C::
    ld a, $01

Jump_01D_6F4E::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    inc b
    inc c
    pop hl

Jump_01D_6F5B::
    pop de
    inc de
    ld a, c
    cp a, $05
    jr c, Jump_01D_6F03
    ld a, b
    cp a, $0A
    jr c, Jump_01D_6F03
    jr Jump_01D_6F7C

Jump_01D_6F69::
    pop bc
    pop hl
    pop de
    ld a, c
    cp a, $05
    jr nc, Jump_01D_6F7C
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $F0
    ld [hl], a

Jump_01D_6F7C::
    ld a, [wPackByteE1]
    and a, a
    jp z, Jump_01D_6FA0
    cp a, $01
    jp z, Jump_01D_6FDD
    cp a, $02
    jp z, Jump_01D_7019
    cp a, $03
    jp z, Jump_01D_7057
    cp a, $04
    jp z, Jump_01D_708D
    jp Jump_01D_70C6

; address loaded by PackRecordFieldsToBank1Slot
Data_01D_6F9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $0F, $1E, $29, $8E, $99

Jump_01D_6FA0::
    call SRAMRecordAddressOfArg1
    ld a, $21
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $06
    add_a_to_hl
    ld a, [wPackByteE6]
    and a, $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackByteE1]
    inc a
    ld [wPackByteE1], a
    jp Jump_01D_6EC5

Jump_01D_6FDD::
    call SRAMRecordAddressOfArg1
    ld a, $22
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $05
    add_a_to_hl
    ld a, [wPackByteE6]
    and a, $03
    swap a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackByteE1]
    inc a
    ld [wPackByteE1], a
    jp Jump_01D_6EC5

Jump_01D_7019::
    call SRAMRecordAddressOfArg1
    ld a, $23
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, [wPackByteE6]
    and a, $03
    sla a
    sla a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackByteE1]
    inc a
    ld [wPackByteE1], a
    jp Jump_01D_6EC5

Jump_01D_7057::
    call SRAMRecordAddressOfArg1
    ld a, $24
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wPackByteE6]
    and a, $03
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackByteE1]
    inc a
    ld [wPackByteE1], a
    jp Jump_01D_6EC5

Jump_01D_708D::
    call SRAMRecordAddressOfArg1
    ld a, $25
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wPackByteE6]
    and a, $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackByteE1]
    inc a
    ld [wPackByteE1], a
    jp Jump_01D_6EC5

Jump_01D_70C6::
    call SRAMRecordAddressOfArg1
    ld a, $26
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    ld a, [wPackByteE6]
    and a, $03
    swap a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackByteE1], a
    jp Jump_01D_7121

; B = (wD7E2 & 3) << 6 | (wD7E3 & 3) << 4 | (wD7E4 & 3) << 2 | (wD7E5 & 3), the opposite of unpacking a byte into four 2-bit fields (E-0104)
; 7 call sites from 2 routines (e.g. PackRecordFieldsToBank1Slot, Pack2BitFieldsFromPackFields)
; reads: wPackFields
Pack2BitFieldsFromPackFields::
Func_01D_70F9:: ; address name
    ld a, [wPackFields]
    and a, $03
    swap a
    sla a
    sla a
    ld b, a
    ld a, [wPackFields + $1]
    and a, $03
    swap a
    or a, b
    ld b, a
    ld a, [wPackFields + $2]
    and a, $03
    sla a
    sla a
    or a, b
    ld b, a
    ld a, [wPackFields + $3]
    and a, $03
    or a, b
    ld b, a
    ret

Jump_01D_7121::
    call SRAMRecordAddressOfArg1
    ld a, $28
    add_a_to_hl
    ld a, $73
    add a, e
    ld e, a
    jr nc, Jump_01D_7132
    inc d

Jump_01D_7132::
    call EnableSRAMBank0
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    or a, b
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    ld c, $00

Jump_01D_7157::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    swap a
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    swap a
    or a, b
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    sla a
    sla a
    or a, b
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    or a, b
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01D_7157
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    swap a
    sla a
    sla a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    push hl
    call SRAMRecordAddressOfArg1
    pop hl
    ld a, $1A
    add a, e
    ld e, a
    jr nc, Jump_01D_71B2
    inc d

Jump_01D_71B2::
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $01
    sla a
    ld b, a
    inc de
    inc de
    ld a, [de]
    and a, $01
    or a, b
    ld b, a
    dec de
    dec de
    dec de
    ld a, [de]
    ld c, a
    inc de
    inc de
    ld a, [de]
    ld e, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    ld a, c
    ld [hl+], a
    ld a, e
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackByteE1], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push de
    ld a, $19
    add a, e
    ld e, a
    jr nc, Jump_01D_71F7
    inc d

Jump_01D_71F7::
    ld a, $32
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop de
    pop hl
    ld a, $28
    add a, e
    ld e, a
    jr nc, Jump_01D_7217
    inc d

Jump_01D_7217::
    ld a, $33
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_7235
    inc d

Jump_01D_7235::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    ld c, $00

Jump_01D_7248::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $22
    jr c, Jump_01D_7248
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    ld a, $5B
    add a, e
    ld e, a
    jr nc, Jump_01D_7270
    inc d

Jump_01D_7270::
    ld a, $57
    add_a_to_hl
    call EnableSRAMBank0
    ld c, $00

Jump_01D_727C::
    push bc
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wPackFields], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wPackFields + $1], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wPackFields + $2], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wPackFields + $3], a
    inc de
    call Pack2BitFieldsFromPackFields
    ld a, b
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop bc
    inc c
    ld a, c
    cp a, $02
    jr c, Jump_01D_727C
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    ld a, $6B
    add a, e
    ld e, a
    jr nc, Jump_01D_730C
    inc d

Jump_01D_730C::
    ld a, $61
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $02
    sla a
    sla a
    swap a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $01
    swap a
    sla a
    sla a
    sla a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl-], a
    pop de
    ld a, $56
    add a, e
    ld e, a
    jr nc, Jump_01D_735E
    inc d

Jump_01D_735E::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $7F
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $7F
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_01D_73D2
    inc d

Jump_01D_73D2::
    ld a, $67
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $6D
    add a, e
    ld e, a
    jr nc, Jump_01D_7425
    inc d

Jump_01D_7425::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $98
    add a, e
    ld e, a
    jr nc, Jump_01D_743E
    inc d

Jump_01D_743E::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $A3
    add a, e
    ld e, a
    jr nc, Jump_01D_7457
    inc d

Jump_01D_7457::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $A4
    add a, e
    ld e, a
    jr nc, Jump_01D_7470
    inc d

Jump_01D_7470::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    xor a, a
    ld [wPackWork], a
    ld a, $FF
    ld [wArg5], a
    ret

; unpacks the compact record in SRAM bank wD7F2 back into the record fields (family, state, mark ...) (E-0131)
; 4 call sites from 4 routines (e.g. ScanBank1RecordStepSaveRecordIndex, HibernateMenu_Case05_Case3F, HibernateMenu_Case05_Case13, HibernateMenu_Case04_Case42)
; reads: wArg2, wArg5, wArg6, wArg7, wArg8
; writes: rRAMB, rRAMG2, wPackWork, wArg5
; points at: wNameGlyphBuf
UnpackRecordFromBank1Slot::
Func_01D_7492:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $60
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0D
    add a, e
    ld e, a
    jr nc, Jump_01D_74B6
    inc d

Jump_01D_74B6::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $1F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    inc hl
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_01D_74D2
    inc d

Jump_01D_74D2::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $08
    srl a
    srl a
    srl a
    ld b, a
    ld a, [hl]
    and a, $F0
    or a, b
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_74F8
    inc d

Jump_01D_74F8::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $06
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_7514
    inc d

Jump_01D_7514::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $01
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    call LoadRecordNameEntry0
    pop de
    push de
    ld a, $01
    add a, e
    ld e, a
    jr nc, Jump_01D_7552
    inc d

Jump_01D_7552::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry1
    pop de
    push de
    ld a, $0F
    add a, e
    ld e, a
    jr nc, Jump_01D_7566
    inc d

Jump_01D_7566::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry2
    pop de
    push de
    ld a, $1E
    add a, e
    ld e, a
    jr nc, Jump_01D_757A
    inc d

Jump_01D_757A::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry3
    pop de
    push de
    ld a, $29
    add a, e
    ld e, a
    jr nc, Jump_01D_758E
    inc d

Jump_01D_758E::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry4
    pop de
    push de
    ld a, $8E
    add a, e
    ld e, a
    jr nc, Jump_01D_75A2
    inc d

Jump_01D_75A2::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry5
    pop de
    push de
    ld a, $99
    add a, e
    ld e, a
    jr nc, Jump_01D_75B6
    inc d

Jump_01D_75B6::
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    jp Jump_01D_75DA

; copies 10 bytes from HL to DE, selecting SRAM bank 0 (rRAMB = 0) after each byte is read; HL and DE advance (E-0106)
; 6 call sites from 1 routine (e.g. UnpackRecordFromBank1Slot)
; writes: rRAMB
CopyTenBytesThenSelectSRAMBank0::
Func_01D_75C7:: ; address name
    ld c, $00

Jump_01D_75C9::
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01D_75C9
    ret

Jump_01D_75DA::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $28
    add_a_to_hl
    push de
    ld a, $73
    add a, e
    ld e, a
    jr nc, Jump_01D_75EF
    inc d

Jump_01D_75EF::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $03
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld c, $00

Jump_01D_761B::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $30
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $03
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01D_761B
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $1A
    add a, e
    ld e, a
    jr nc, Jump_01D_7699
    inc d

Jump_01D_7699::
    inc hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    dec hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $02
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp a, $01
    jr nz, Jump_01D_76CE
    dec de
    ld a, [de]
    inc de
    cp a, $FF
    jr nz, Jump_01D_76CE
    ld a, $FF
    ld [de], a

Jump_01D_76CE::
    inc de
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $01
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    inc hl
    inc hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp a, $FF
    jr nz, Jump_01D_7702
    inc de
    ld a, [de]
    cp a, $01
    jr nz, Jump_01D_7702
    ld a, $FF
    ld [de], a

Jump_01D_7702::
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $32
    add_a_to_hl
    push de
    ld a, $19
    add a, e
    ld e, a
    jr nc, Jump_01D_771E
    inc d

Jump_01D_771E::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $28
    add a, e
    ld e, a
    jr nc, Jump_01D_7737
    inc d

Jump_01D_7737::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_774E
    inc d

Jump_01D_774E::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $34
    add a, e
    ld e, a
    jr nc, Jump_01D_7766
    inc d

Jump_01D_7766::
    ld c, $00

Jump_01D_7768::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $22
    jr c, Jump_01D_7768
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $57
    add_a_to_hl
    push de
    ld a, $5B
    add a, e
    ld e, a
    jr nc, Jump_01D_779B
    inc d

Jump_01D_779B::
    ld c, $00

Jump_01D_779D::
    push de
    push hl
    ld a, $04
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    pop hl
    pop de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg5]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg6]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg7]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg8]
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $02
    jr c, Jump_01D_779D
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $61
    add_a_to_hl
    push de
    ld a, $6B
    add a, e
    ld e, a
    jr nc, Jump_01D_7827
    inc d

Jump_01D_7827::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    and a, $80
    srl a
    srl a
    swap a
    ld b, a
    ld a, [hl-]
    and a, $80
    srl a
    srl a
    srl a
    swap a
    or a, b
    ld b, a
    ld a, c
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de
    ld a, $56
    add a, e
    ld e, a
    jr nc, Jump_01D_785B
    inc d

Jump_01D_785B::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $7F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $7F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $67
    add_a_to_hl
    push de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_01D_78CF
    inc d

Jump_01D_78CF::
    ld c, $00

Jump_01D_78D1::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01D_78D1
    pop de
    push de
    ld a, $6D
    add a, e
    ld e, a
    jr nc, Jump_01D_78F1
    inc d

Jump_01D_78F1::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $98
    add a, e
    ld e, a
    jr nc, Jump_01D_790A
    inc d

Jump_01D_790A::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $A3
    add a, e
    ld e, a
    jr nc, Jump_01D_7923
    inc d

Jump_01D_7923::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $A4
    add a, e
    ld e, a
    jr nc, Jump_01D_793C
    inc d

Jump_01D_793C::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackWork], a
    ld a, $FF
    ld [wArg5], a
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $21 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 7-6 of byte $27, and copies the 5-glyph name entry at offset 3 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 6 call sites from 6 routines (e.g. UnpackRecordFromBank1Slot, HibernateMenu_Shared03, HibernateMenu_Case05_Case2F_Sub03, ShowSaveFileInfoWindow, ...)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry0::
Func_01D_795D:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $21
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    inc hl
    inc hl
    inc hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $22 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 5-4 of byte $27, and copies the 5-glyph name entry at offset 8 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. UnpackRecordFromBank1Slot)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry1::
Func_01D_7991:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $22
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and a, $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $08
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $23 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 3-2 of byte $27, and copies the 5-glyph name entry at offset $0D (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. UnpackRecordFromBank1Slot)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry2::
Func_01D_79C5:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $23
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wMenuInputResult], a
    pop hl
    ld a, $0D
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $24 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 1-0 of byte $27, and copies the 5-glyph name entry at offset $12 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. UnpackRecordFromBank1Slot)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry3::
Func_01D_79FB:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $24
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $03
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuInputResult], a
    pop hl
    ld a, $12
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $25 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 7-6 of byte $28, and copies the 5-glyph name entry at offset $17 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. UnpackRecordFromBank1Slot)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry4::
Func_01D_7A2D:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $25
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $17
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $26 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 5-4 of byte $28, and copies the 5-glyph name entry at offset $1C (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. UnpackRecordFromBank1Slot)
; reads: wArg2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry5::
Func_01D_7A61:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $26
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    inc hl
    inc hl
    ld a, [hl]
    and a, $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $1C
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; fills wC8CF with $F0 and copies up to five glyphs from HL, adding mark $8D or $8E after each glyph whose wD7F5 field is 1 or 2 (E-0127)
; 6 call sites from 6 routines (e.g. LoadRecordNameEntry5, LoadRecordNameEntry4, LoadRecordNameEntry3, LoadRecordNameEntry2, ...)
; points at: wNameGlyphBuf, wArg5
BuildFiveGlyphNameWithMarksToNameGlyphBuf::
Func_01D_7A90:: ; address name
    ld de, wNameGlyphBuf
    ld c, $00

Jump_01D_7A95::
    ld a, $F0
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_01D_7A95
    ld bc, $0000
    ld de, wNameGlyphBuf

Jump_01D_7AA5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01D_7AD6
    ld [de], a
    inc de
    push hl
    ld a, c
    ld hl, wArg5
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_01D_7ACC
    cp a, $01
    jr z, Jump_01D_7AC8
    cp a, $02
    jr z, Jump_01D_7AC4
    jr Jump_01D_7ACC

Jump_01D_7AC4::
    ld a, $8E
    jr Jump_01D_7ACA

Jump_01D_7AC8::
    ld a, $8D

Jump_01D_7ACA::
    ld [de], a
    inc de

Jump_01D_7ACC::
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01D_7AA5
    ld a, $F0

Jump_01D_7AD6::
    ld [de], a
    ret

; with SRAM bank wD7F2 selected, splits the byte at HL into four 2-bit fields: wD7F5 = bits 7-6, wD7F6 = bits 5-4, wD7F7 = bits 3-2, wD7F8 = bits 1-0 (E-0104)
; 7 call sites from 7 routines (e.g. CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, LoadRecordNameEntry3, ...)
; reads: wArg2
; writes: rRAMB, wArg5, wArg6, wArg7, wArg8
UnpackByteAtHLTo2BitFieldsArg5::
Func_01D_7AD8:: ; address name
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wArg5], a
    ld a, [hl]
    and a, $30
    swap a
    ld [wArg6], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wArg7], a
    ld a, [hl]
    and a, $03
    ld [wArg8], a
    ret

; writes $0A to the RAM-enable register (rRAMG2 alias) and selects SRAM bank 0 (rRAMB = 0); clobbers A (E-0066)
; 20 call sites from 10 routines (e.g. UnpackRecordFromBank1Slot, CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, ...)
; writes: rRAMG2, rRAMB
EnableSRAMBank0::
Func_01D_7B05:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ret

; HL = the word at wD7F3/wD7F4; DE = sA000 + $A5 * wD7F1, the start of SRAM record wD7F1 (records are $A5 bytes, as in SRAMRecordAddress); clobbers A, BC (E-0063)
; 27 call sites from 10 routines (e.g. UnpackRecordFromBank1Slot, CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, ...)
; reads: wArg3, wArg4, wArg1
; points at: sRecords
SRAMRecordAddressOfArg1::
Func_01D_7B0F:: ; address name
    ld a, [wArg3]
    ld l, a
    ld a, [wArg4]
    ld h, a
    push hl
    ld a, [wArg1]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret
    ds $4D8, $00
