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

; address loaded by DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4010:: ; address name
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
    db $EA, "*: Which monster", $F1
    db "will hibernate?", $F0

String_1D_00_02:: ; heuristic: string; C0
Data_01D_4069:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Do you need me", $F1
    db "for anything else?", $F0

String_1D_00_03:: ; heuristic: string; C0
Data_01D_408E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: So this one", $F1
    db "should hibernate?", $F0

String_1D_00_04:: ; heuristic: string; C0
Data_01D_40AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: OK my friend,", $F1
    db "time to sleep!", $F7
    db $F0

String_1D_00_05:: ; heuristic: string; C0
Data_01D_40D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Huh? There's no", $F1
    db "one on the farm.", $F7
    db $F0

String_1D_00_06:: ; heuristic: string; C0
Data_01D_40F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Uh-oh, the", $F1
    db "stable is full!", $F7
    db $F0

String_1D_00_07:: ; heuristic: string; C0
Data_01D_4113:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Want to switch", $F1
    db "with someone?", $F0

String_1D_00_08:: ; heuristic: string; C0
Data_01D_4133:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who should I", $F1
    db "wake up?", $F0

String_1D_00_09:: ; heuristic: string; C0
Data_01D_414C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Wake this", $F1
    db "monster up?", $F0

String_1D_00_0A:: ; heuristic: string; C0
Data_01D_4165:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Which one should", $F1
    db "hibernate?", $F0

String_1D_00_0B:: ; heuristic: string; C0
Data_01D_4184:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: So switch ", $F9, "0", $F1
    db "and ", $F9, "G, huh?", $FA, $F7
    db $F2, "OK, I'll do that", $F1
    db "for you.", $F7
    db $F0

String_1D_00_0C:: ; heuristic: string; C0
Data_01D_41BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who should I", $F1
    db "wake up?", $F0

String_1D_00_0D:: ; heuristic: string; C0
Data_01D_41D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'll send ", $F9, "G", $F1
    db "to the farm.", $F7
    db $F0

String_1D_00_0E:: ; heuristic: string; C0
Data_01D_41F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Huh? No one's", $F1
    db "sleeping now.", $F7
    db $F0

String_1D_00_0F:: ; heuristic: string; C0
Data_01D_4212:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Huh? There's no", $F1
    db "room on the farm.", $F7
    db $F0

String_1D_00_10:: ; heuristic: string; C0
Data_01D_4237:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Should someone", $F1
    db "else hibernate?", $F0

String_1D_00_11:: ; heuristic: string; C0
Data_01D_4259:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who do you want", $F1
    db "to check?", $F0

String_1D_00_12:: ; heuristic: string; C0
Data_01D_4276:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who do you want", $F1
    db "to release?", $F0

String_1D_00_13:: ; heuristic: string; C0
Data_01D_4295:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: It'll disappear.", $F1
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
    db $EA, "*: Come see me if", $F1
    db "you get more", $FA, $F7
    db $EF, $EE, "monsters.", $EF, $EE, "I'll be waiting.", $F7
    db $F0

String_1D_00_16:: ; heuristic: string; C0
Data_01D_4310:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: No one else can", $F1
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
    script_message $8015 ; '*: Come see me if you'
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
    script_message $C005 ; '*: Huh? There's no one on'
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_435C:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4389
Script_1D_435F:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; '*: Which monster will hibernate?'
Script_1D_4362:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_436C, Script_1D_4366
Script_1D_4366:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_436C:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; '*: So this one should hibernate?'
Script_1D_436F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_437B, Script_1D_437F, Script_1D_4374
Script_1D_4374:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; '*: Which monster will hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_4362
Script_1D_437B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_436F
Script_1D_437F:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; '*: OK my friend, time to'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_4389:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; '*: Uh-oh, the stable is full!'
    script_message $C007 ; '*: Want to switch with someone?'
Script_1D_438F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4399, Script_1D_4393
Script_1D_4393:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_4399:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43A7, Script_1D_43A0
Script_1D_43A0:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C007 ; '*: Want to switch with someone?'
    script_jump Script_1D_438F
Script_1D_43A7:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43B1, Script_1D_43AE
Script_1D_43AE:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4399
Script_1D_43B1:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C00A ; '*: Which one should hibernate?'
Script_1D_43B5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43BC, Script_1D_43B9
Script_1D_43B9:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4399
Script_1D_43BC:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; '*: So this one should hibernate?'
Script_1D_43BF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43CB, Script_1D_43CF, Script_1D_43C4
Script_1D_43C4:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_43B5
Script_1D_43CB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_43BF
Script_1D_43CF:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; '*: So switch 0 and G,'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_43D9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_43F8, Script_1D_43EF, Script_1D_43F2, Script_1D_43E6, Script_1D_43E0
Script_1D_43E0:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; '*: No one else can hibernate,I'
    script_jump Script_1D_43E9
Script_1D_43E6:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; '*: Huh? No one's sleeping now.'
Script_1D_43E9:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_43EF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_441B
Script_1D_43F2:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; '*: Huh? There's no room on'
    script_jump Script_1D_43E9
Script_1D_43F8:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4406, Script_1D_43FF
Script_1D_43FF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_4406:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4410, Script_1D_440D
Script_1D_440D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_43F8
Script_1D_4410:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; '*: I'll send G to the'
    script_command SCRIPT_HIBERNATE
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_441B:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; '*: Huh? There's no room on'
    script_message $C010 ; '*: Should someone else hibernate?'
Script_1D_4421:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_442B, Script_1D_4425
Script_1D_4425:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_442B:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; '*: Which one should hibernate?'
Script_1D_442E:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4438, Script_1D_4432
Script_1D_4432:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '*: Should someone else hibernate?'
    script_jump Script_1D_4421
Script_1D_4438:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; '*: So this one should hibernate?'
Script_1D_443B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4447, Script_1D_444B, Script_1D_4440
Script_1D_4440:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_442E
Script_1D_4447:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_443B
Script_1D_444B:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4459, Script_1D_4452
Script_1D_4452:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_1D_442E
Script_1D_4459:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4463, Script_1D_4460
Script_1D_4460:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_444B
Script_1D_4463:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; '*: So switch 0 and G,'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
    db $EB, $E4, $0A, $00, $00, $05, $C0, $00, $02, $C0, $07, $36, $43, $00, $11, $C0
    db $EB, $E4, $07, $00, $00, $02, $C0, $07, $36, $43, $EB, $07, $7D, $44

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1D_448B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_4498, Script_1D_448F
Script_1D_448F:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; '*: Huh? No one's sleeping now.'
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_4498:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; '*: Who do you want to'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_44A6, Script_1D_449F
Script_1D_449F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336
Script_1D_44A6:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; '*: It'll disappear. Is that OK?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_1D_44B0, Script_1D_44AD
Script_1D_44AD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1D_4498
Script_1D_44B0:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'G was released in the wild.'
    script_command SCRIPT_HIBERNATE
    script_message $C002 ; '*: Do you need me for'
    script_jump Script_1D_4336

; only called from VaultMenu_Store_Case00 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case00_WaitForVRAMAccess)
; reads: wScreenState, wScreenStep
; writes: wScreenStep
VaultMenu_Store_Case00_WaitForVRAMAccess::
Func_01D_44BA:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, .skip
    ld hl, BGMap1TileRun_1D_4547
    jr .skip2

.skip:
    ld hl, BGMap1TileRun_1D_44E3

.skip2:
    ld de, vBGMap1 + $300

.skip3:
    ld a, [hl]
    cp a, $7F
    jr z, .check_screen_step
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    jr .skip3

.check_screen_step:
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
; 1 call site from 1 routine (e.g. VaultMenu_Store_LoadThreeTilesAndDrawRows4603To460B)
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
; 1 call site from 1 routine (e.g. VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc_Case03)
; reads: wScreenStep, wScreenByteED, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, wGoldHi, wGoldMid, wGoldLo, ...
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc::
Func_01D_460F:: ; address name
    call VaultMenu_BlinkCursorBlinkEF_Bank1D_4801
    and a, a
    ret z
    cp a, $01
    jr z, .check_screen_byte_ed
    cp a, $02
    jr z, .set_two_choice_cursor_to_06
    ret

.set_two_choice_cursor_to_06:
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_screen_byte_ed:
    ld a, [wScreenByteED]
    and a, a
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    cp a, $01
    jr z, .check_banked_gold_hi
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wSavedSpriteClipMode]
    and a, a
    jr z, .clear_two_choice_cursor
    ld a, [wListPages]
    cp a, $18
    jr z, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    and a, a
    jr nz, .check_gold_hi
    ld a, [wBankedGoldMid]
    and a, a
    jr nz, .check_gold_hi
    ld a, [wBankedGoldLo]
    and a, a
    jr nz, .check_gold_hi
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_gold_hi:
    ld a, [wGoldHi]
    cp a, $01
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wGoldMid]
    cp a, $86
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wGoldLo]
    cp a, $3B
    jr c, .set_two_choice_cursor_to_05
    jr z, .set_two_choice_cursor_to_05

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_05:
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp .clear_script_command_type

; only called from VaultMenu_Store_Case03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc)
; reads: wScreenStep, wScreenByteED, wGoldHi, wGoldMid, wGoldLo, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, ...
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc::
Func_01D_46E1:: ; address name
    call VaultMenu_BlinkCursorBlinkEF_Bank1D_4801
    and a, a
    ret z
    cp a, $01
    jr z, .check_screen_byte_ed
    cp a, $02
    jr z, .set_two_choice_cursor_to_06
    ret

.set_two_choice_cursor_to_06:
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_screen_byte_ed:
    ld a, [wScreenByteED]
    and a, a
    jr z, .check_list_pages
    cp a, $01
    jr z, .check_gold_hi
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_pages:
    ld a, [wListPages]
    and a, a
    jr z, .clear_two_choice_cursor
    call VaultMenu_Store_FindStorageSlots
    cp a, $FF
    jr z, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_gold_hi:
    ld a, [wGoldHi]
    and a, a
    jr nz, .check_banked_gold_hi
    ld a, [wGoldMid]
    and a, a
    jr nz, .check_banked_gold_hi
    ld a, [wGoldLo]
    cp a, $64
    jr nc, .check_banked_gold_hi
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    cp a, $0F
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_03
    ld a, [wBankedGoldMid]
    cp a, $41
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_03
    ld a, [wBankedGoldLo]
    cp a, $DC
    jr c, .set_two_choice_cursor_to_05

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_05:
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp .clear_script_command_type

; only called from routines of VaultMenu (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc, VaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc)
; reads: wJoypadPressedRepeat, wScreenByteED
; writes: wScreenByteED
VaultMenu_BlinkCursorBlinkEF_Bank1D_4801::
Func_01D_47AF:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_481_f_bank1_d
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_481_f_bank1_d2
    bit 0, a
    jr nz, .call_vault_menu_shared01_bg_map_address_at
    bit 1, a
    jp nz, .return_02
    call BlinkCursorBlinkEF_Bank1D_4801
    xor a, a
    ret

.call_draw_blank_tile_c3_481_f_bank1_d:
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wScreenByteED]
    and a, a
    jr nz, .set_screen_byte_ed
    ld a, $02
    jr .set_screen_byte_ed2

.set_screen_byte_ed:
    dec a

.set_screen_byte_ed2:
    ld [wScreenByteED], a
    call DrawCursorTileBB_481B_Bank1D
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ret

.call_draw_blank_tile_c3_481_f_bank1_d2:
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wScreenByteED]
    cp a, $02
    jr c, .skip
    xor a, a
    jr .set_screen_byte_ed2

.skip:
    inc a
    jr .set_screen_byte_ed2

.call_vault_menu_shared01_bg_map_address_at:
    call VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

.return_02:
    ld a, $02
    ret

; cycles wCursorBlinkEF through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_BlinkCursorBlinkEF_Bank1D_4801)
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
; 1 call site from 1 routine (e.g. VaultMenu_BlinkCursorBlinkEF_Bank1D_4801)
; reads: wScreenByteED
DrawCursorTileBB_481B_Bank1D::
Func_01D_481B:: ; address name
    ld b, $BB
    jr VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D_ReadScreenByteED

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_BlinkCursorBlinkEF_Bank1D_4801)
; reads: wScreenByteED
DrawBlankTileC3_481F_Bank1D::
Func_01D_481F:: ; address name
    ld b, $C3
    jr VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D_ReadScreenByteED

; only called from VaultMenu_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_BlinkCursorBlinkEF_Bank1D_4801)
; reads: wScreenByteED
VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D::
Func_01D_4823:: ; address name
    ld b, $BC

VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D_ReadScreenByteED::
Jump_01D_4825:: ; address name
    ld a, [wScreenByteED]
    add a, a
    ld hl, VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D_Data
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

; address loaded by VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D
VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4842:: ; address name
    db $61, $00, $A1, $00, $E1, $00

; draws rect $0088 (9 x 12) at vBGMap1 + $370 (Func_01D_5917) and wScreenStep += 1 (E-0122)
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

; draws rect $0140 (3 x 7) at vBGMap1 + $3E0; in state 3 also runs Func_01C_689A and Func_0F2_6449; wScreenStep += 1 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep)
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
    jr nz, .check_screen_step
    farcall ListDistinctInventoryItemsToItemGrid
    farcall Run64C7UnlessScreenStateIs3

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; only called from VaultMenu_Store_Case07 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D)
; reads: wSavedSpriteSlotCount, wIsCGB, wScreenStep
; writes: wArg1, wScreenStep
VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D::
Func_01D_4883:: ; address name
    ld a, $01
    ld [wArg1], a
    call VaultMenu_Store_CountNonZeroItemGridBytes
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .call_bg_map_address_at_scroll_bank1_d
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, TileRect_1D_48FC
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D
    jr .check_is_cgb

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, TileRect_1D_4968
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D

.check_is_cgb:
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr nz, .skip
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld bc, $0000

.loop:
    push hl

.loop2:
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
    jr c, .loop2
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
    jr c, .loop
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
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case08_HLToDecimalDigits)
; reads: wDigits, wSavedSpriteSlotCount, wItemGridY, wScreenStep
; writes: wArg1, wDigits, wScreenStep, wScreenCounter, wGlyphListPos
VaultMenu_Store_Case08_HLToDecimalDigits::
Func_01D_49D4:: ; address name
    xor a, a
    ld [wArg1], a
    call VaultMenu_Store_CountNonZeroItemGridBytes
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, .check_saved_sprite_slot_count
    ld a, $E3
    ld [wDigits + $1], a

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .check_screen_step
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
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, $E3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank1_d:
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

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; C = the number of non-zero bytes among the $18 bytes at wItemGrid (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_CountNonZeroItemGridBytes)
; points at: wItemGrid
CountNonZeroItemGridBytes::
Func_01D_4A4E:: ; address name
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, .loop
    ret

; only called from routines of VaultMenu (E-0098)
; 5 call sites from 4 routines (e.g. VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc, VaultMenu_Store_CountNonZeroItemGridBytes, VaultMenu_Store_Case0E_TenTimesNumberTensPlusNumberOnes, VaultMenu_Setup_ToVaultMenu_WriteSavedSpriteClipModeAndListPagesAndStep)
; writes: wSavedSpriteClipMode, wListPages
; points at: wItemStorage, wInventory
VaultMenu_WriteSavedSpriteClipModeAndListPages::
Func_01D_4A62:: ; address name
    ld hl, wItemStorage
    ld c, $00
    ld b, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc c

.next:
    inc hl
    inc hl
    inc b
    ld a, b
    cp a, $64
    jr c, .loop
    ld a, c
    ld [wSavedSpriteClipMode], a
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop2:
    ld a, [hl]
    and a, a
    jr z, .next2
    cp a, $FF
    jr z, .next2
    inc c

.next2:
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, .loop2
    ld a, c
    ld [wListPages], a
    ret

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wItemGridX
; writes: wSelectedRecord
BlinkCursorSelectedRecord_Bank1D_4A9A:: ; heuristic: follows a terminator; C0
Func_01D_4A9A:: ; address name
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, VaultMenu_Store_Shared03_ReadItemGridX
    xor a, a
    ld [wSelectedRecord], a

.skip:
    ld b, $BB
    jr VaultMenu_Store_Shared03_ReadItemGridX_ReadItemGridX

; only called from VaultMenu_Store_Shared03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_CountNonZeroItemGridBytes)
; reads: wItemGridX
VaultMenu_Store_Shared03_ReadItemGridX::
Func_01D_4AB1:: ; address name
    ld b, $C3
    jr VaultMenu_Store_Shared03_ReadItemGridX_ReadItemGridX
    db $06, $BC

VaultMenu_Store_Shared03_ReadItemGridX_ReadItemGridX::
Jump_01D_4AB7:: ; address name
    ld a, [wItemGridX]
    add a, a
    ld hl, VaultMenu_Store_Shared03_ReadItemGridX_Data
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

; address loaded by VaultMenu_Store_Shared03_ReadItemGridX
VaultMenu_Store_Shared03_ReadItemGridX_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4AD4:: ; address name
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from VaultMenu_Store_Case0A (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc)
; reads: wScreenState, wItemGridY, wItemGridX, wDigits, wIsCGB, wScreenStep
; writes: wDigits, wScreenByte93, wScreenByte94, wScreenStep
; points at: wScreenList, wItemStorage, wItemGrid, wInventory
VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc::
Func_01D_4ADC:: ; address name
    ld hl, VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc_Data
    ld de, wScreenList
    ld c, $00

.loop:
    ld a, [hl+]
    ld [de], a
    inc c
    inc de
    ld a, c
    cp a, $15
    jr c, .loop
    ld a, [wScreenState]
    cp a, $03
    jp z, .read_item_grid_y
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

.loop2:
    ld a, [hl]
    cp a, e
    jr nz, .next
    and a, a
    jr z, .next
    inc hl
    ld c, [hl]
    jr .skip

.next:
    inc b
    inc hl
    inc hl
    ld a, b
    cp a, $64
    jr c, .loop2
    ld c, $00
    jr .skip

.read_item_grid_y:
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

.loop3:
    ld a, [hl]
    cp a, e
    jr nz, .next2
    and a, a
    jr z, .next2
    cp a, $FF
    jr z, .next2
    inc c

.next2:
    inc b
    inc hl
    ld a, b
    cp a, $18
    jr c, .loop3

.skip:
    ld a, c
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, .read_digits
    ld a, $E3
    ld [wDigits + $1], a

.read_digits:
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
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0000

.loop4:
    push hl

.loop5:
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
    jr c, .loop5
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
    jr c, .loop4
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc
VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4BE4:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $BE, $C3, $C3, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case0B (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
; reads: wJoypadPressedRepeat, wScreenStep, wScreenState, wChoiceCursorF0, wItemGridX, wSavedSpriteSlotCount, wItemGridY
; writes: wScreenStep, wItemGridX, wItemGridY, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, ...
VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41::
Func_01D_4BF9:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_run64_c7_unless_screen_state_is3
    bit 4, a
    jr nz, .check_saved_sprite_slot_count
    bit 5, a
    jr nz, .check_saved_sprite_slot_count2
    bit 6, a
    jp nz, .call_draw_blank_tile_c3_4_d5_f_bank1_d
    bit 7, a
    jp nz, .call_draw_blank_tile_c3_4_d5_f_bank1_d2
    bit 0, a
    jp nz, .call_queue_sound_effect
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

.call_run64_c7_unless_screen_state_is3:
    farcall Run64C7UnlessScreenStateIs3
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.loop:
    call BlinkCursorSelectedRecord_Bank1D_4D41
    ret

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .loop
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, .set_item_grid_y
    xor a, a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, [wScreenStep]
    dec a
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_sprite_slot_count2:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .loop
    ld a, [wItemGridY]
    and a, a
    jr nz, .skip
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.call_draw_blank_tile_c3_4_d5_f_bank1_d:
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wItemGridX]
    and a, a
    jr nz, .set_item_grid_x
    ld a, [wChoiceCursorF0]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_4_d5_f_bank1_d2:
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .set_item_grid_x3
    xor a, a
    jr .set_item_grid_x4

.set_item_grid_x3:
    inc a

.set_item_grid_x4:
    ld [wItemGridX], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D
    ld a, [wScreenState]
    cp a, $04
    jr z, .check_screen_step
    call VaultMenu_Store_Case0B_Sub01_ReadItemGridYAndItemGridX
    and a, a
    jr z, .check_screen_step
    cp a, $FE
    jr z, .set_two_choice_cursor_to_03
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step:
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
    jr z, .call_split_item_storage_entry_into_digits
    farcall CountItemInInventoryToDigits
    jr .call_draw_number_tens_number_ones_digits_at

.call_split_item_storage_entry_into_digits:
    call SplitItemStorageEntryIntoDigits

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtScroll161
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
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
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
; reads: wItemGridX
DrawCursorTileBB_4D5B_Bank1D::
Func_01D_4D5B:: ; address name
    ld b, $BB
    jr VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D_ReadItemGridX

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
; reads: wItemGridX
DrawBlankTileC3_4D5F_Bank1D::
Func_01D_4D5F:: ; address name
    ld b, $C3
    jr VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D_ReadItemGridX

; only called from VaultMenu_Store_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
; reads: wItemGridX
VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D::
Func_01D_4D63:: ; address name
    ld b, $BC

VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D_ReadItemGridX::
Jump_01D_4D65:: ; address name
    ld a, [wItemGridX]
    add a, a
    ld hl, VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D_Data
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

; address loaded by VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D
VaultMenu_Store_Case0B_Sub01_BGMapAddressAtScroll_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4D82:: ; address name
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from VaultMenu_Store_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
; reads: wItemGridY, wItemGridX
; points at: wItemGrid, wItemStorage
VaultMenu_Store_Case0B_Sub01_ReadItemGridYAndItemGridX::
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

.loop:
    ld a, [hl]
    cp a, b
    jr z, .next
    and a, a
    jr z, .return_0
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop
    ld a, $FF
    ret

.next:
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, .return_0
    ld a, $FE
    ret

.return_0:
    xor a, a
    ret

; only called from VaultMenu_Store_Case0D (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
; reads: wJoypadPressedRepeat, wNumberTens, wNumberOnes, wScreenState, wScreenStep, wNumberEditPos, wCountOnes, wCountTens
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wNumberTens, wNumberOnes, wNumberEditPos
VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99::
Func_01D_4DC7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_02
    bit 4, a
    jr nz, .call_vault_menu_store_case0_d_sub01_bg_map
    bit 5, a
    jr nz, .call_vault_menu_store_case0_d_sub01_bg_map2
    bit 6, a
    jp nz, .call_queue_sound_effect
    bit 7, a
    jp nz, .call_queue_sound_effect2
    bit 0, a
    jp nz, .call_vault_menu_store_case0_d_sub01_bg_map3
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.set_two_choice_cursor_to_02:
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

.call_vault_menu_store_case0_d_sub01_bg_map:
    call VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, .set_number_edit_pos
    xor a, a
    jr .set_number_edit_pos2

.set_number_edit_pos:
    inc a

.set_number_edit_pos2:
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ld a, $69
    call QueueSoundEffect
    ret

.call_vault_menu_store_case0_d_sub01_bg_map2:
    call VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_number_edit_pos2

.skip:
    dec a
    jr .set_number_edit_pos2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .read_count_tens
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .set_number_tens
    ld a, b
    ld [wNumberTens], a
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.loop:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, .call_draw_number_tens_number_ones_digits_at
    ld a, b
    ld [wNumberOnes], a

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.set_number_tens:
    inc a
    ld [wNumberTens], a
    push af
    ld a, [wCountTens]
    ld b, a
    pop af
    cp a, b
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .check_number_ones
    ld a, [wCountOnes]
    ld b, a
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp a, b
    jr c, .set_number_ones2
    ld a, [wCountOnes]
    cp a, b
    jr nz, .check_number_tens
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.check_number_tens:
    ld a, [wNumberTens]
    and a, a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a, a

.set_number_ones:
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.set_number_ones2:
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .check_number_tens2
    ld a, [wNumberTens]
    and a, a
    jr nz, .set_number_tens2
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, .read_count_tens2
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.read_count_tens2:
    ld a, [wCountTens]
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.set_number_tens2:
    dec a
    ld [wNumberTens], a
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, .call_blink_cursor_blink_cd_bank1_d_4_f99
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.call_blink_cursor_blink_cd_bank1_d_4_f99:
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.check_number_tens2:
    ld a, [wNumberTens]
    and a, a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, .set_number_ones3
    jr .read_count_tens3

.check_number_ones3:
    ld a, [wNumberOnes]
    and a, a
    jr nz, .set_number_ones3

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .set_number_ones_to_09
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.set_number_ones_to_09:
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.set_number_ones3:
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D_4F99
    ret

.call_vault_menu_store_case0_d_sub01_bg_map3:
    call VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
    ld a, [wNumberTens]
    and a, a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a, a
    ret z

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    cp a, $03
    jr z, .call_vault_menu_store_case0_d_sub01_write
    call CheckListPagesPlusNumberAtMost18
    and a, a
    jr z, .clear_two_choice_cursor
    jr .set_two_choice_cursor_to_01

.call_vault_menu_store_case0_d_sub01_write:
    call VaultMenu_Store_Case0D_Sub01_WriteTextCounter1AndTextCounter3
    and a, a
    jr z, .clear_two_choice_cursor

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
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

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 10 call sites from 1 routine (e.g. VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
; reads: wJoypadRepeatTimer, wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1D_4F99::
Func_01D_4F99:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
    cp a, $18
    jr c, VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_Skip
    xor a, a
    ld [wCursorBlinkCD], a

; only called from VaultMenu_Store_Case0D_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D::
Func_01D_4FB3:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add a, $E0
    ld b, a
    jr VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_ReadNumberEditPos

VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_Skip::
Jump_01D_4FC6:: ; address name
    ld b, $CB

VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_ReadNumberEditPos::
Jump_01D_4FC8:: ; address name
    ld a, [wNumberEditPos]
    add a, a
    ld hl, VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_Data
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

; address loaded by VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D
VaultMenu_Store_Case0D_Sub01_BGMapAddressAtScroll_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_4FE5:: ; address name
    db $61, $01, $62, $01

; writes wNumberTens and wNumberOnes as digit tiles ($E0 + n) at BGMapAddressAtScroll + $161 and + $162 (E-0120)
; 6 call sites from 2 routines (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41, VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
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

; A = $FF when wListPages + TenTimesNumberTensPlusNumberOnes exceeds $18, else 0 (E-0122)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
; reads: wListPages
CheckListPagesPlusNumberAtMost18::
Func_01D_5012:: ; address name
    call TenTimesNumberTensPlusNumberOnes
    ld a, [wListPages]
    add a, l
    cp a, $18
    jr c, .return_0
    jr z, .return_0
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; only called from VaultMenu_Store_Case0D_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99)
; reads: wItemGridY, wItemGridX, wTextCounter1
; writes: wTextCounter1, wTextCounter3
; points at: wItemGrid, wItemStorage
VaultMenu_Store_Case0D_Sub01_WriteTextCounter1AndTextCounter3::
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

.loop:
    ld a, [hl+]
    cp a, b
    jr z, .skip
    and a, a
    jr z, .next
    ld a, [wTextCounter1]
    inc a
    ld [wTextCounter1], a

.next:
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop
    ld hl, wItemStorage
    ld a, [wTextCounter1]
    add a, a
    add_a_to_hl
    ld a, b
    ld [hl+], a

.skip:
    ld a, [hl]
    push hl
    ld b, a
    call TenTimesNumberTensPlusNumberOnes
    ld a, l
    add a, b
    cp a, $64
    jr nc, .clear_text_counter1
    pop hl
    ld [hl], a
    dec hl
    ld a, [hl]
    ld [wTextCounter3], a
    xor a, a
    ld [wTextCounter1], a
    ret

.clear_text_counter1:
    pop hl
    xor a, a
    ld [wTextCounter1], a
    ld a, $FF
    ret

; only called from VaultMenu_Store_Case0E (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ReadScreenState)
; reads: wItemGridY, wItemGridX, wListPages, wCounterPtr0Lo, wScreenStep, wSavedSpriteClipMode
; writes: wTwoChoiceCursor, wTextCounter1, wTextCounter3, wCounterPtr0Lo, wScreenStep
; points at: wItemStorage, wInventory
VaultMenu_Store_Case0E_TenTimesNumberTensPlusNumberOnes::
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
    jr nz, .skip
    dec hl
    xor a, a
    ld [hl], a

.skip:
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .skip2
    cp a, $FF
    jr z, .skip2
    jr .next

.skip2:
    ld a, b
    ld [hl], a
    dec e

.next:
    inc hl
    inc c
    ld a, e
    and a, a
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    ld a, c
    cp a, $18
    jr c, .loop

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wListPages]
    cp a, $18
    jr c, .check_saved_sprite_clip_mode
    xor a, a
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1

.check_saved_sprite_clip_mode:
    ld a, [wSavedSpriteClipMode]
    and a, a
    jr nz, .set_two_choice_cursor_to_02
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1

; only called from VaultMenu_Store_Case0E (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ReadScreenState)
; reads: wCounterPtr0Lo, wScreenStep, wTextCounter3
; writes: wTwoChoiceCursor, wTextCounter1, wTextCounter3, wCounterPtr0Lo, wScreenStep
; points at: wInventory, wItemStorage
VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc::
Func_01D_5101:: ; address name
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    jr .skip

.next:
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, .loop
    xor a, a
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1

.skip:
    ld hl, wItemStorage
    ld de, $0000
    ld c, $00

.loop2:
    inc hl
    ld a, [hl]
    add a, e
    ld e, a
    jr nc, .next2
    inc d

.next2:
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop2
    ld a, d
    cp a, $26
    jr c, .skip2
    ld a, e
    cp a, $AC
    jr c, .skip2
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1

.skip2:
    ld hl, wItemStorage
    ld c, $00

.loop3:
    ld a, [hl]
    and a, a
    jr z, .set_two_choice_cursor_to_02
    ld b, a
    ld a, [wTextCounter3]
    cp a, b
    jr nz, .next3
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, .set_two_choice_cursor_to_02

.next3:
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop3

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a

VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc_ClearTextCounter1::
Jump_01D_5168:: ; address name
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

.loop:
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; only called from VaultMenu_Store_Case0F (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_InitItemListScreenListAndDraw)
; reads: wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY
VaultMenu_Store_Case0F_WriteScreenStepAndScriptCommandTypeEtc::
Func_01D_5259:: ; address name
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr z, .set_screen_step_to_07
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_07:
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

; draws rect $0147 (3 x 13) at vBGMap1 + $370, wScreenStep += 1, clears wCursorBlinkCD-wThreeDigits + $2 and sets wNumberEditPos = 2 (E-0122)
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
; 2 call sites from 2 routines (e.g. VaultMenu_Store_ToVaultMenu_Store_Number24ToPackedBCD, VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C)
; reads: hTemp2, hTemp1, hTemp0, wIsCGB, wScreenStep
; writes: wDigits, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wTextCounter0, wScreenStep
; points at: wScreenList, wBankedGoldLo, wScreenByteBD, wScreenByte93
VaultMenu_Store_Number24ToPackedBCD::
Func_01D_52BD:: ; address name
    ld hl, wScreenList
    ld de, VaultMenu_Store_Number24ToPackedBCD_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $27
    jr c, .loop
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

.loop2:
    ld a, [hl]
    and a, a
    jr nz, .skip
    add a, $E3
    ld [hl], a
    inc c
    inc hl
    ld a, c
    cp a, $05
    jr c, .loop2

.skip:
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
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $014B
    add hl, de
    ld bc, $0000

.loop3:
    push hl

.loop4:
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
    jr c, .loop4
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
    jr c, .loop3
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by VaultMenu_Store_Number24ToPackedBCD
VaultMenu_Store_Number24ToPackedBCD_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_53A2:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case14 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D)
; reads: wThreeDigits, wScreenState, hTemp2, hTemp1, wScreenStep, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo
; writes: wGrid2CursorX, wGrid2CursorY, wScreenArea, wDigits, wCountTens, wCountOnes, wItemGrid, wScreenStep, ...
; points at: wScreenList, wGoldLo, wBankedGoldLo
VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D::
Func_01D_53BD:: ; address name
    ld hl, wScreenList
    ld de, VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $10
    jr c, .loop
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
    jp nz, .check_banked_gold_hi
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

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    cp a, $01
    jr c, .set_digits
    jr nz, .set_count_tens_to_09
    ld a, [wBankedGoldMid]
    cp a, $86
    jr c, .set_digits
    jr nz, .set_count_tens_to_09
    ld a, [wBankedGoldLo]
    cp a, $3C
    jr c, .set_digits
    jr z, .set_digits

.set_count_tens_to_09:
    ld a, $09
    ld [wCountTens], a
    ld [wCountOnes], a
    ld [wItemGrid], a
    jp .check_screen_step

.set_digits:
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
    jp .check_screen_step

; address loaded by VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D
VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_548D:: ; address name
    db $B6, $BF, $C3, $C3, $C3, $E0, $E0, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from VaultMenu_Store_Case15 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ToVaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc)
; reads: wScreenStep, wThreeDigits, wBankedGoldLo, wBankedGoldMid, wBankedGoldHi, wGoldLo, wGoldMid, wGoldHi
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wBankedGoldHi, wBankedGoldMid, wBankedGoldLo, wGoldHi, ...
VaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc::
Func_01D_549D:: ; address name
    call VaultMenu_WriteNumberEditPosAndThreeDigitsEtc
    and a, a
    ret z
    cp a, $01
    jr z, .call_draw_three_digits_at_scroll_offset6_e
    cp a, $02
    jr z, .check_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a, a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, .read_three_digits
    ret

.read_three_digits:
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03E8
    call Multiply8By16

.skip:
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
    jr nc, .read_banked_gold_lo
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr .skip

.read_banked_gold_lo:
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
    jr c, .set_banked_gold_hi
    jr nz, .restore
    ld a, h
    cp a, $41
    jr c, .set_banked_gold_hi
    jr nz, .restore
    ld a, l
    cp a, $DD
    jr c, .set_banked_gold_hi

.restore:
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_banked_gold_hi:
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
; 1 call site from 1 routine (e.g. VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc_Case15)
; reads: wScreenStep, wThreeDigits, wGoldLo, wGoldMid, wGoldHi, wBankedGoldLo, wBankedGoldMid, wBankedGoldHi
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wGoldHi, wGoldMid, wGoldLo, wBankedGoldHi, ...
VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc::
Func_01D_5573:: ; address name
    call VaultMenu_WriteNumberEditPosAndThreeDigitsEtc
    and a, a
    ret z
    cp a, $01
    jr z, .call_draw_three_digits_at_scroll_offset6_e
    cp a, $02
    jr z, .check_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a, a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, .read_three_digits
    ret

.read_three_digits:
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03E8
    call Multiply8By16

.skip:
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
    jr nc, .read_gold_lo
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr .skip

.read_gold_lo:
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
    jr c, .set_gold_hi
    jr nz, .restore
    ld a, h
    cp a, $86
    jr c, .set_gold_hi
    jr nz, .restore
    ld a, l
    cp a, $9F
    jr c, .set_gold_hi
    jr z, .set_gold_hi

.restore:
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_gold_hi:
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

; only called from routines of VaultMenu (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc, VaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc)
; reads: wJoypadPressed, wJoypadPressedRepeat, wNumberEditPos, wCountTens, wThreeDigits, wCountOnes, wItemGrid
; writes: wNumberEditPos, wThreeDigits, wCountOnes
VaultMenu_WriteNumberEditPosAndThreeDigitsEtc::
Func_01D_564B:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .return_02
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_queue_sound_effect2
    bit 7, a
    jp nz, .call_queue_sound_effect3
    bit 4, a
    jp nz, .call_queue_sound_effect4
    bit 5, a
    jp nz, .call_queue_sound_effect5
    call VaultMenu_Shared02_WriteCursorBlinkCD
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

.return_02:
    ld a, $02
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, .read_count_tens
    cp a, $01
    jp z, .read_count_tens2
    jp .read_count_tens3

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .set_three_digits
    jr z, .read_count_ones
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wThreeDigits + $1]
    ld b, a
    ld a, [wCountOnes]
    cp a, b
    jr nc, .call_draw_three_digits_at_scroll_offset6_e
    ld [wThreeDigits + $1], a
    ld a, [wThreeDigits + $2]
    ld b, a
    ld a, [wItemGrid]
    cp a, b
    jr nc, .call_draw_three_digits_at_scroll_offset6_e
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

.read_count_ones:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr nc, .read_count_ones2

.read_count_ones2:
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    jr .call_draw_three_digits_at_scroll_offset6_e

.set_three_digits:
    inc a
    ld [wThreeDigits], a
    call VaultMenu_Shared02_WriteThreeDigits
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.read_count_tens2:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr nc, .read_count_ones3
    ld a, [wThreeDigits + $1]
    cp a, $09
    jr c, .loop
    xor a, a
    ld [wThreeDigits + $1], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.loop:
    inc a
    ld [wThreeDigits + $1], a
    call VaultMenu_Shared02_WriteThreeDigits
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.read_count_ones3:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, .loop
    ld [wCountOnes], a
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .check_three_digits
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, .check_three_digits
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, .set_three_digits2
    ld a, b
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.check_three_digits:
    ld a, [wThreeDigits + $2]
    cp a, $09
    jr c, .set_three_digits2
    xor a, a
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.set_three_digits2:
    inc a
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, .check_three_digits2
    cp a, $01
    jp z, .read_count_tens4
    jp .read_count_tens5

.check_three_digits2:
    ld a, [wThreeDigits]
    and a, a
    jr nz, .set_three_digits3
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

.set_three_digits3:
    dec a
    ld [wThreeDigits], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.read_count_tens4:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .check_three_digits3
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, .set_three_digits4
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, .call_draw_three_digits_at_scroll_offset6_e2
    jr z, .call_draw_three_digits_at_scroll_offset6_e2
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e2:
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

.check_three_digits3:
    ld a, [wThreeDigits + $1]
    and a, a
    jr nz, .set_three_digits4
    ld a, $09
    ld [wThreeDigits + $1], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.set_three_digits4:
    dec a
    ld [wThreeDigits + $1], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.read_count_tens5:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .check_three_digits4
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, .check_three_digits4
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, .set_three_digits5
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.check_three_digits4:
    ld a, [wThreeDigits + $2]
    and a, a
    jr nz, .set_three_digits5
    ld a, $09
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.set_three_digits5:
    dec a
    ld [wThreeDigits + $2], a
    call VaultMenu_Shared02_WriteCursorBlinkCD
    xor a, a
    ret

.call_queue_sound_effect4:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    cp a, $02
    jr nc, .read_count_tens6
    inc a
    ld [wNumberEditPos], a
    jr .read_count_tens6

.call_queue_sound_effect5:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr z, .read_count_tens6
    dec a
    ld [wNumberEditPos], a

.read_count_tens6:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e3:
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

; only called from VaultMenu_Shared02 (E-0047)
; 13 call sites from 1 routine (e.g. VaultMenu_WriteNumberEditPosAndThreeDigitsEtc)
; reads: wJoypadRepeatTimer, wCursorBlinkCD, wNumberEditPos
; writes: wCursorBlinkCD
; points at: wThreeDigits
VaultMenu_Shared02_WriteCursorBlinkCD::
Func_01D_5878:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .read_number_edit_pos
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, .read_number_edit_pos
    cp a, $18
    jr c, .read_number_edit_pos2
    xor a, a
    ld [wCursorBlinkCD], a

.read_number_edit_pos:
    ld hl, wThreeDigits
    ld a, [wNumberEditPos]
    add_a_to_hl
    ld a, [hl]
    add a, $E0
    ld b, a
    jr .read_number_edit_pos3

.read_number_edit_pos2:
    ld b, $CB

.read_number_edit_pos3:
    ld a, [wNumberEditPos]
    add a, a
    ld hl, VaultMenu_Shared02_WriteCursorBlinkCD_Data
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

; address loaded by VaultMenu_Shared02_WriteCursorBlinkCD
VaultMenu_Shared02_WriteCursorBlinkCD_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_58C2:: ; address name
    db $6E, $00, $6F, $00, $70, $00

; writes the three bytes at wThreeDigits as digit tiles ($E0 + digit) at the BG map entry BGMapAddressAtScroll + $6E (row 3, column 14 of the view), one per byte with WaitForVRAMAccess (E-0104)
; 8 call sites from 4 routines (e.g. VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc, VaultMenu_WriteNumberEditPosAndThreeDigitsEtc, VaultMenu_Shared02_WriteThreeDigits, VaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc)
; points at: wThreeDigits
DrawThreeDigitsAtScrollOffset6E::
Func_01D_58C8:: ; address name
    call BGMapAddressAtScroll_Bank1D
    ld de, $006E
    add hl, de
    ld de, wThreeDigits
    ld c, $00

.loop:
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
    jr c, .loop
    ret

; takes the byte at wItemStorage + 8 * wItemGridY + 2 * wItemGridX + 1 and stores its value / 10 in wCountTens and value mod 10 in wCountOnes (E-0120)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
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

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, .next
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

.next:
    inc hl
    inc de
    dec c
    jp nz, .loop
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
    jp nz, .loop
    pop hl
    pop hl
    ret

; for each inventory item finds a matching or free wItemStorage slot (100 two-byte slots)
; 1 call site from 1 routine (e.g. VaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc)
; points at: wItemStorage, wInventory
VaultMenu_Store_FindStorageSlots::
Func_01D_5965:: ; address name
    ld hl, wItemStorage
    ld de, wInventory
    ld bc, $0000

.loop:
    ld a, [de]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    push bc
    ld b, a
    ld c, $00
    ld a, [hl]
    cp a, b
    jr z, .next2
    and a, a
    jp z, .done
    pop bc
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop
    ld hl, wItemStorage

.next:
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, .loop

.return_FF:
    ld a, $FF
    ret

.next2:
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, .done
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop
    ld hl, wItemStorage
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, .loop
    jr .return_FF

.done:
    pop bc
    xor a, a
    ret

; A = 0 when one of the 100 two-byte entries at wItemStorage has a non-zero first byte, else $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wItemStorage
ItemStorageHasNonZeroEntry:: ; heuristic: follows a terminator; C0
Func_01D_59B9:: ; address name
    ld hl, wItemStorage
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr nz, .return_0
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, .loop
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 23 call sites from 16 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, VaultMenu_Shared01_BGMapAddressAtScroll_Bank1D, SaveBGMapRectWithAttrs, VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D, ...)
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

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets wTextCursorLo = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2 switched in (E-0121; a copy, not a clear: E-0226)
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

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets wTextCursorLo = HL + $21 (E-0124; a copy, not a clear: E-0226)
; 8 call sites from 5 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D, VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc, VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D, ...)
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

.loop:
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    ld a, l
    and a, $1F
    jp nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .return
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

.return:
    ret

; HL = 10 * wNumberTens + wNumberOnes (E-0120)
; 3 call sites from 3 routines (e.g. CheckListPagesPlusNumberAtMost18, VaultMenu_Store_Case0D_Sub01_WriteTextCounter1AndTextCounter3, VaultMenu_Store_Case0E_TenTimesNumberTensPlusNumberOnes)
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

; only called from VaultMenu_Shared02 (E-0047)
; 2 call sites from 1 routine (e.g. VaultMenu_WriteNumberEditPosAndThreeDigitsEtc)
; reads: wCountTens, wThreeDigits, wCountOnes, wItemGrid
; writes: wThreeDigits
VaultMenu_Shared02_WriteThreeDigits::
Func_01D_5AA3:: ; address name
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp a, b
    jr c, .return
    jr nz, .read_count_tens
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp a, b
    jr c, .return
    jr nz, .read_count_tens
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp a, b
    jr c, .return
    jr nz, .read_count_tens
    jr .return

.read_count_tens:
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E

.return:
    ret

; only called from routines of VaultMenu_Store (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D, VaultMenu_Store_Case08_HLToDecimalDigits)
; reads: wScreenState, wSavedSpriteClipMode, wItemGridY, wItemGridX, wArg1
; writes: wSavedSpriteSlotCount, wItemGridY, wChoiceCursorF0, wItemGridX
VaultMenu_Store_CountNonZeroItemGridBytes::
Func_01D_5ADF:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    call CountNonZeroItemGridBytes
    ld a, [wSavedSpriteClipMode]
    jr .skip

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    call CountNonZeroItemGridBytes
    ld a, c

.skip:
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, .set_saved_sprite_slot_count
    inc l

.set_saved_sprite_slot_count:
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, .set_choice_cursor_f0_to_03
    pop af
    push af
    and a, a
    jr nz, .set_choice_cursor_f0
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, .set_choice_cursor_f0_to_03
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr .set_choice_cursor_f0_to_03

.set_choice_cursor_f0:
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .return
    jr z, .return
    push bc
    push hl
    ld a, [wArg1]
    and a, a
    jr nz, .restore
    call VaultMenu_Store_Shared03_ReadItemGridX

.restore:
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr .return

.set_choice_cursor_f0_to_03:
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

.return:
    ret

; record wArg1 (bank 1): writes its mark (field $0E), level (field $56) and four stat words (fields from Data_01D_5BE6) into the screen buffer (E-0128)
; 4 call sites from 4 routines (e.g. HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21, HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5, BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5, CallFunc5B4DInBank1D)
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
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    ld [wWindowTileBuffer + $86], a
    pop bc
    push bc
    ld a, b
    ld c, MON_LEVEL
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

.loop:
    push bc
    ld a, c
    ld hl, DrawRecordStatsBoxForArg1_Data_5BE6
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
    ld hl, DrawRecordStatsBoxForArg1_Data_5BEA
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
    jr c, .loop
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawRecordStatsBoxForArg1
DrawRecordStatsBoxForArg1_Data_5BE6:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_5BE6:: ; address name
    db $5B, $5D, $5F, $61

; address loaded by DrawRecordStatsBoxForArg1
DrawRecordStatsBoxForArg1_Data_5BEA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_5BEA:: ; address name
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; saves wArg1-wMenuInputResult and hTemp0-hSpriteScrollXLo, runs Func_01D_6899 for the record at WD789 cell 5, then restores them (E-0125)
; 6 call sites from 6 routines (e.g. GameMode5_Update_LinkExchangeJoypadPerFrame, GameMode5_Update_LinkExchangeJoypadPerFrame_Case04, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor, ...)
; writes: wArg1, wArg2
; points at: wRecordBuffer, wArg1, hTemp0
CallDrawPartySpeciesSpritesPreservingArg1AndTemp0::
Func_01D_5BF2:: ; address name
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld de, hTemp0
    ld b, $0D

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
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

.loop3:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld de, hTemp0
    ld b, $0D

.loop4:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ret

; saves wArg1-wMenuInputResult and hTemp0-hSpriteScrollXLo, draws the species sprite of the record at WD789 cell 5 at ($90, $40) (Func_01D_69DA), then restores them (E-0127)
; 6 call sites from 6 routines (e.g. GameMode5_Update_LinkExchangeJoypadPerFrame, GameMode5_Update_LinkExchangeJoypadPerFrame_Case04, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode, ...)
; reads: hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wArg1, wArg2
; points at: wRecordBuffer, wArg1, hTemp0
DrawListEntriesCell5SpeciesSprite::
Func_01D_5C35:: ; address name
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld de, hTemp0
    ld b, $0D

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
    call SetArg5ToListEntriesCell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
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

.loop3:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld de, hTemp0
    ld b, $0D

.loop4:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ret

; with SRAM bank 0 enabled reads the record at WD789 cell 5 and continues at HibernateMenu_ChooseRecords_Case3E_CopyRecordNameToNameGlyphBuf_CallCopyRecordNameToNameGlyphBuf (E-0126)
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
    jr HibernateMenu_ChooseRecords_Case3E_CopyRecordNameToNameGlyphBuf_CallCopyRecordNameToNameGlyphBuf

; only called from HibernateMenu_ChooseRecords_Case3E (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
HibernateMenu_ChooseRecords_Case3E_CopyRecordNameToNameGlyphBuf::
Func_01D_5CA3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]

HibernateMenu_ChooseRecords_Case3E_CopyRecordNameToNameGlyphBuf_CallCopyRecordNameToNameGlyphBuf::
Jump_01D_5CAF:: ; address name
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; record wArg1: draws its name at vTiles1 + $780 and the name of its species (field $0B) at vTiles1 + $270 (E-0127)
; 11 call sites from 11 routines (e.g. NpcBreedMenu_RedrawListScreen_SetArg5ToListEntriesCell5, HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23, BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06, BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11, ...)
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
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop bc
    push bc
    ld a, b
    ld c, MON_SPECIES
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

; entry wAreaGraphicsIndex (3 bytes per entry): decompresses the tiles named at Data_01D_5D78 to vTiles2 and copies the $40-byte palette named at Data_01D_5D7E into wBGPaletteBuffer (E-0120)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex)
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

; wArg5/wArg6 (big-endian pointer) = wListEntries + 5 * wListPageIndex + wListCursor
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

; wArg5/wArg6 (big-endian pointer) = wListEntries + 4 * wListPageIndex + wListCursor
; 28 call sites from 28 routines (e.g. EggServiceMenu_ChooseAndPay_IsAmountInArg1AboveGold, EggServiceMenu_ChooseAndPay_CheckAndPay_SubtractArg1AmountFromGold, GetListEntriesCell4AddressWithSRAM, EggServiceMenu_SetArg5ToListEntriesCell4, ...)
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
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4)
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
    ld c, MON_ITEM
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

; loads the species of the record at WD789 cell 5 (field $0B) and shows string [wSpeciesRecord + $B] of category $0D at $9680 with size $0602 (E-0121)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep)
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
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wSpeciesIdLo], a
    ldh a, [hTemp1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_FIELD_ABILITY]
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

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set by LoadRecordCapacityFromFarmLevelTable): wRecordsInUse = how many have byte 0 equal to 1 or 2 (in use) (E-0104)
; 13 call sites from 13 routines (e.g. HibernateMenu_SetupPartyList_RunFunc5925At0280, HibernateMenu_ChooseRecords_RunFunc5925At0280_Case2C, HibernateMenu_ChooseRecords_RunFunc5925At0280, HibernateMenu_ChooseToHibernate_RunFunc5925At0280, ...)
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

.loop:
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $01
    jr z, .check_records_in_use
    cp a, $02
    jr z, .check_records_in_use
    jr .next

.check_records_in_use:
    ld a, [wRecordsInUse]
    inc a
    ld [wRecordsInUse], a

.next:
    inc b
    ld a, c
    add_a_to_hl
    ld a, b
    cp a, d
    jr c, .loop
    xor a, a
    ld [rRAMG2], a
    ret

; clears the wListEntries list, then lists the party records whose SRAM record byte 0 is 2 and counts them in wListCount (E-0127)
; 19 call sites from 19 routines (e.g. SwapMonstersMenu_Case03_ListPartyRecordsWithState2ToListEntries, HibernateMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep, HibernateMenu_ChooseRecords_Multiply8, HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D, ...)
; reads: wListCount, wPartyCount
; writes: wListCount, rRAMG2, rRAMB
; points at: wListEntries, wPartyList, sRecords
ListPartyRecordsWithState2ToListEntries::
Func_01D_5E79:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld b, c
    ld hl, wListEntries

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wPartyList
    ld b, $00

.loop2:
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
    jr nz, .restore
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
    jr .check_party_count

.restore:
    pop de
    pop bc

.check_party_count:
    inc de
    ld a, [wPartyCount]
    cp a, b
    jr nz, .loop2
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set by LoadRecordCapacityFromFarmLevelTable): clears the 30-byte list wListEntries, then appends the number of every record whose byte 0 is 1 and byte $6E is 0; wListCount = the list length, wRecordsFlagged = how many state-1 records had byte $6E set (E-0104)
; 12 call sites from 11 routines (e.g. HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc, StartRecordListOrNoneMessage, HibernateMenu_ChooseRecords_DrawBox4965AndMenuAndStep, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C, ...)
; reads: wRecordCapacity, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, sRecords
ListRecordsState1WithByte6EClear::
Func_01D_5ECE:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
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

.loop2:
    ld a, [de]
    cp a, $01
    jr nz, .skip2
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    and a, a
    jr nz, .check_records_flagged
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr .skip2

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip2:
    ld a, $A5
    add a, e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, .loop2
    jr c, .loop2
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set by LoadRecordCapacityFromFarmLevelTable): clears wListEntries and wListEntries2 (30 bytes each), then appends every record whose byte 0 is 1 or 2 and byte $6E is 0; wListCount = the list length, wRecordsFlagged = how many in-use records had byte $6E set (E-0104)
; 13 call sites from 13 routines (e.g. HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc, BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear, BreedMenu_ListMonsters_ListRecordsInUseWithByte6EClear, BattleEnd_AskToJoin_ClampRecordListPageCursor5, ...)
; reads: wRecordCapacity, wListCount, wPartyCount, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wPartyList
ListRecordsInUseWithByte6EClear::
Func_01D_5F2D:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1E

.loop2:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop2
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

.loop3:
    ld a, [de]
    and a, a
    jr z, .skip3
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a, a
    jr nz, .check_records_flagged
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr .skip3

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip3:
    ld a, $A5
    add a, e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, .loop3
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a

; moves the party records found in the record list wListEntries to its front and pads the list to $1E entries with $FF (E-0129)
; 3 call sites from 3 routines (e.g. BreedMenu_WriteListCountAndRAMG2Etc, ListAvailableRecordsForSelection, ListAvailableRecordsForSelection_Bank33)
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

.loop:
    push hl
    push de
    push bc
    ld b, $00

.loop2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    cp a, c
    jr z, .skip
    inc b
    inc hl
    ld a, [wListCount]
    ld c, a
    ld a, b
    cp a, c
    jr c, .loop2
    pop bc
    pop de
    pop hl
    jr .check_party_count

.skip:
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

.check_party_count:
    inc c
    inc de
    ld a, [wPartyCount]
    cp a, c
    jr nz, .loop
    ld hl, wListEntries2
    ld a, b
    add_a_to_hl
    ld de, wListEntries
    ld a, [wListCount]
    ld c, a

.loop3:
    ld a, [de]
    cp a, $FF
    jr z, .next
    ld [hl+], a

.next:
    inc de
    dec c
    jr nz, .loop3
    ld hl, wListEntries2
    ld de, wListEntries
    ld a, [wListCount]
    ld b, a

.loop4:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ld a, [wListCount]
    cp a, $1E
    jr nc, .return
    ld hl, wListEntries
    add_a_to_hl
    ld a, [wListCount]
    ld b, a
    ld a, $1E
    sub a, b
    ld b, a

.loop5:
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, .loop5

.return:
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set by LoadRecordCapacityFromFarmLevelTable): clears wListEntries, then appends every record whose byte 0 is 1 or 2 and byte $6E is non-zero; wListCount = the list length (E-0104)
; 10 call sites from 10 routines (e.g. EggServiceMenu_ListRecordsInUseWithByte6ESet, BreedMenu_WriteTwoChoiceCursorAndScreenStateEtc, BreedMenu_ChooseParents_TenTimesTemp0PlusTen, BreedMenu_ChooseEgg_ListRecordsInUseWithByte6ESet, ...)
; reads: wRecordCapacity
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, sRecords
ListRecordsInUseWithByte6ESet::
Func_01D_6026:: ; address name
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1E

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
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

.loop2:
    ld a, [de]
    and a, a
    jr z, .skip3
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a, a
    jr z, .restore
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr .skip3

.restore:
    pop de

.skip3:
    ld a, $A5
    add a, e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp a, b
    jr nz, .loop2
    ld a, c
    ld [wListCount], a
    ld [wRecordsFlagged], a
    xor a, a
    ld [rRAMG2], a
    ret

; for the visible entries of page wListPageIndex draws the species name (field $0B, category 2 of the bank-08 database) of each listed record (E-0129)
; 8 call sites from 8 routines (e.g. EggServiceMenu_DrawListAndPrice_DrawRecordListPageSpeciesNames, BreedMenu_ChooseEgg_DrawRecordListPageSpeciesNames, BreedMenu_RedrawListScreen_DrawRecordListPageSpeciesNames, SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames, ...)
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

.loop:
    ld a, [wListLastRow]
    cp a, $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add a, c
    cp a, b
    jr nc, .done
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SPECIES
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
    jr z, .done
    ld a, c
    cp a, $04
    jp c, .loop

.done:
    xor a, a
    ld [rRAMG2], a
    ret

; draws the $F0-terminated text at wNameGlyphBuf glyph by glyph; marks $8D and $8E are ORed onto the previous tile (E-0125)
; 4 call sites from 3 routines (e.g. DrawRecordListPageSpeciesNames, BreedMenu_ChooseParents_ComputeBreedingChild, DrawRecordNameAndSpeciesName)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D::
Func_01D_6129:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_start
    cp a, $8D
    jr z, .check_glyph_list_start
    cp a, $8E
    jr z, .check_glyph_list_start
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart
    call CopyFromBankWaitVRAM
    pop bc
    jr .check_glyph_list_start2

.check_glyph_list_start:
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart
    call OrFromBankWaitVRAM
    pop bc

.check_glyph_list_start2:
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr .read_glyph_list_pos

.clear_glyph_list_start:
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; only called from DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D (E-0047)
; 2 call sites from 1 routine (e.g. DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D)
; reads: wArg5, wGlyphListStart
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart::
Func_01D_617F:: ; address name
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart_Data
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wArg5]
    and a, a
    jr z, .skip4
    cp a, $01
    jr z, .skip3
    cp a, $02
    jr z, .skip2
    cp a, $03
    jr z, .skip
    ld de, GlyphTileDestTable_1D_4
    jr .skip5

.skip:
    ld de, GlyphTileDestTable_1D_3
    jr .skip5

.skip2:
    ld de, GlyphTileDestTable_1D_2
    jr .skip5

.skip3:
    ld de, GlyphTileDestTable_1D_1
    jr .skip5

.skip4:
    ld de, GlyphTileDestTable_1D_0

.skip5:
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
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

; with SRAM enabled, for each of the wPartyCount record numbers in wPartyList copies the record's name (CopyRecordNameToNameGlyphBuf, C = 1) and draws it as glyph tiles at the VRAM address from Data_01D_62F9 (CopyGlyphTilesToVRAM); then disables SRAM (E-0106)
; 6 call sites from 6 routines (e.g. LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C_Case08, CloseHibernateMenu_DrawRecordListNameTiles_Bank1D, HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D, CloseBreedMenu_DrawRecordListNameTiles_Bank1D, ...)
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

.loop:
    push bc
    ld hl, wPartyList
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, DrawRecordListNameTiles_Bank1D_Data
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
    jr nz, .loop
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
DrawRecordListNameTiles_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_62F9:: ; address name
    db $00, $8D, $50, $8D, $A0, $8D

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 6 call sites from 6 routines (e.g. DrawRecordListPageMarks, MarkPartyMembersInRecordListPage, UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF, DrawTwoChoiceCursorConfirmed, ...)
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

; for the visible entries of page wListPageIndex draws each record's mark ($CC/$CD from field $0E, or $CE for state 2) beside it (E-0130)
; 10 call sites from 10 routines (e.g. EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks, EggServiceMenu_DrawListAndPrice_DrawRecordListPageMarks, BreedMenu_ChooseEgg_DrawRecordListPageMarks, LoadTile4990AndRun6320, ...)
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

.loop:
    ld a, [wListLastRow]
    cp a, $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add a, c
    cp a, b
    jp nc, .done
    push hl
    push bc
    ld a, [hl]
    ld c, MON_EGG
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $02
    jr nz, .skip
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    ld e, a
    jr .restore

.skip:
    ld e, $CE

.restore:
    pop bc
    push bc
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    push hl
    ld a, [wArg2]
    and a, a
    jr z, .skip3
    cp a, $01
    jr z, .skip2
    ld hl, DrawRecordListPageMarks_Data_640A
    jr .skip4

.skip2:
    ld hl, DrawRecordListPageMarks_Data_6402
    jr .skip4

.skip3:
    ld hl, DrawRecordListPageMarks_Data_63FA

.skip4:
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
    jr nz, .restore2
    di
    call WaitForVRAMAccess
    ld a, e
    ld [hl], a
    ei

.restore2:
    pop bc
    push bc
    push de
    ld a, [wArg2]
    and a, a
    jr z, .skip6
    cp a, $01
    jr z, .skip5
    ld de, DrawRecordListPageMarks_Data_6422
    jr .skip7

.skip5:
    ld de, DrawRecordListPageMarks_Data_641A
    jr .skip7

.skip6:
    ld de, DrawRecordListPageMarks_Data_6412

.skip7:
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
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
    jr z, .done
    ld a, c
    cp a, $04
    jp c, .loop

.done:
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_63FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_63FA:: ; address name
    db $32, $00, $72, $00, $B2, $00, $F2, $00

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_6402:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6402:: ; address name
    db $B2, $00, $F2, $00, $32, $01, $72, $01

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_640A:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_640A:: ; address name
    db $2B, $00, $6B, $00, $AB, $00, $EB, $00

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_6412:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6412:: ; address name
    db $8A, $C3, $B2, $C3, $DA, $C3, $02, $C4

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_641A:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_641A:: ; address name
    db $DA, $C3, $02, $C4, $2A, $C4, $52, $C4

; address loaded by DrawRecordListPageMarks
DrawRecordListPageMarks_Data_6422:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6422:: ; address name
    db $83, $C3, $AB, $C3, $D3, $C3, $FB, $C3

; only called from routines of SwapMonstersMenu_ChooseToView (E-0098)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E_Case02, SwapMonstersMenu_ChooseToView2_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursorF0
; writes: wMenuInputResult, wChoiceCursorF0
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E::
Func_01D_642A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_64_ac_bank1_d2
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_64_ac_bank1_d3
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .call_draw_blank_tile_c3_64_ac_bank1_d
    call BlinkCursorBlinkB8_Bank1D_648E
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_64_ac_bank1_d:
    call DrawBlankTileC3_64AC_Bank1D
    ld a, $FE
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_64_ac_bank1_d2:
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_choice_cursor_f02

.skip:
    dec a
    jr .set_choice_cursor_f02

.call_draw_blank_tile_c3_64_ac_bank1_d3:
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wChoiceCursorF0]
    cp a, $01
    jr c, .set_choice_cursor_f0
    xor a, a
    jr .set_choice_cursor_f02

.set_choice_cursor_f0:
    inc a

.set_choice_cursor_f02:
    ld [wChoiceCursorF0], a
    call DrawCursorTileBB_64A8_Bank1D
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; cycles wCursorBlinkB8 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E)
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
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E)
; reads: wChoiceCursorF0
DrawCursorTileBB_64A8_Bank1D::
Func_01D_64A8:: ; address name
    ld b, $BB
    jr SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursorF0

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 3 call sites from 1 routine (e.g. SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E)
; reads: wChoiceCursorF0
DrawBlankTileC3_64AC_Bank1D::
Func_01D_64AC:: ; address name
    ld b, $C3
    jr SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursorF0

; only called from SwapMonstersMenu_ChooseToView_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_648E)
; reads: wChoiceCursorF0
SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap::
Func_01D_64B0:: ; address name
    ld b, $BC

SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursorF0::
Jump_01D_64B2:: ; address name
    ld a, [wChoiceCursorF0]
    add a, a
    ld hl, SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap_Data
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

; address loaded by SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap
SwapMonstersMenu_ChooseToView_Shared01_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_64D2:: ; address name
    db $28, $01, $68, $01

; up/down moves wListCursor over wListCount entries ($FD), A selects ($FF, sound $69), B cancels ($FE); wListPageIndex = 0 (E-0128)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_ShowParents2_HandleListCursorInput_1D, RunLinkSession8Case03Steps_HandleListCursorInput_1D)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListCount, wListCursor
; writes: wListPageIndex, wMenuInputResult, wListCursor
HandleListCursorInput_1D::
Func_01D_64D6:: ; address name
    xor a, a
    ld [wListPageIndex], a
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .check_list_cursor
    bit 7, a
    jr nz, .check_list_count
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    bit 0, a
    jr nz, .call_queue_sound_effect
    xor a, a
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a, a
    jr nz, .skip
    ld a, [wListCount]
    dec a
    jr nz, .set_list_cursor2
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.skip:
    dec a
    jr .set_list_cursor2

.check_list_count:
    ld a, [wListCount]
    dec a
    jr nz, .check_list_cursor2
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.check_list_cursor2:
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, .set_list_cursor
    xor a, a
    jr .set_list_cursor2

.set_list_cursor:
    inc a

.set_list_cursor2:
    ld [wListCursor], a
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks (wScreenCounter counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Cursor positions are BG map offsets $012F and $016F from the scroll origin (E-0068)
; 27 call sites from 27 routines (e.g. ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26, ArenaMenu_UpdateTwoChoiceCursor_Bank1D, ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case0C, ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case17, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
UpdateTwoChoiceCursor_Bank1D::
Func_01D_6540:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_erase_two_choice_cursor
    bit 7, a
    jr nz, .call_erase_two_choice_cursor2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_draw_two_choice_cursor_confirmed
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkTwoChoiceCursor
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_erase_two_choice_cursor:
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .set_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor:
    dec a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.call_erase_two_choice_cursor2:
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr c, .set_two_choice_cursor2
    xor a, a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a, a
    ld [wScreenCounter], a
    call DrawTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_draw_two_choice_cursor_confirmed:
    call DrawTwoChoiceCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; once wJoypadRepeatTimer >= $14, counts wScreenCounter up: frames 0-$0F draw the cursor, $10-$17 erase it, then the count restarts (E-0068)
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
    jr DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor

; writes tile $C3 at the position of wTwoChoiceCursor (E-0068)
; 2 call sites from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
EraseTwoChoiceCursor::
Func_01D_65CC:: ; address name
    ld b, $C3
    jr DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor

; writes tile $BC at the position of wTwoChoiceCursor (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
DrawTwoChoiceCursorConfirmed::
Func_01D_65D0:: ; address name
    ld b, $BC

DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor::
Jump_01D_65D2:: ; address name
    ld a, [wTwoChoiceCursor]
    add a, a
    ld hl, DrawTwoChoiceCursorConfirmed_Data
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
DrawTwoChoiceCursorConfirmed_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_65F2:: ; address name
    db $2F, $01, $6F, $01

; list cursor over wListCount entries: Up/Down move wListCursor with wrap, erase and redraw the cursor, play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor, plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks and the result is 0 (the codes of UpdatePagedListCursor) (E-0106)
; 7 call sites from 7 routines (e.g. SwapMonstersMenu_MoveRecords_UpdateListCursorListCursor, SwapMonstersMenu_ChooseFromFarm_UpdateListCursorListCursor, SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor, SwapMonstersMenu_ShowPartyMemberDetails_GetListEntriesCell5Address, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListCount, wListCursor
; writes: wMenuInputResult, wListCursor, wListCursorAux
UpdateListCursorListCursor::
Func_01D_65F6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_update_list_cursor_list_cursor_read_list
    bit 7, a
    jr nz, .call_update_list_cursor_list_cursor_read_list2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call UpdateListCursorListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_update_list_cursor_list_cursor_read_list:
    call UpdateListCursorListCursor_ReadListCursor_Sub03
    ld a, [wListCursor]
    and a, a
    jr nz, .set_list_cursor
    ld a, [wListCount]
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor:
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.call_update_list_cursor_list_cursor_read_list2:
    call UpdateListCursorListCursor_ReadListCursor_Sub03
    ld a, [wListCount]
    dec a
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, .set_list_cursor2
    xor a, a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor2:
    inc a
    ld [wListCursor], a

.clear_list_cursor_aux:
    xor a, a
    ld [wListCursorAux], a
    call UpdateListCursorListCursor_ReadListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wJoypadRepeatTimer, wListCursorAux, wListCursor
; writes: wListCursorAux
UpdateListCursorListCursor_WriteListCursorAux::
Func_01D_666A:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdateListCursorListCursor_ReadListCursor
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp a, $10
    jr c, UpdateListCursorListCursor_ReadListCursor
    cp a, $18
    jr c, UpdateListCursorListCursor_ReadListCursor_Sub03
    xor a, a
    ld [wListCursorAux], a

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_ReadListCursor::
Func_01D_6684:: ; address name
    ld b, $BB
    jr UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor

; only called from UpdateListCursorListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_ReadListCursor_Sub03::
Func_01D_6688:: ; address name
    ld b, $C3
    jr UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor

; only called from UpdateListCursorListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorListCursor)
; reads: wListCursor
UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap::
Func_01D_668C:: ; address name
    ld b, $BC

UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor::
Jump_01D_668E:: ; address name
    ld a, [wListCursor]
    add a, a
    ld hl, UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_Data
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

; address loaded by UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap
UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_66AE:: ; address name
    db $21, $00, $61, $00, $A1, $00, $E1, $00

; row wListCursor runs 0..wListLastRow and page wListPageIndex runs 0..wListPages - 1, both wrapping; Up/Down move the row (wMenuInputResult = $FD), Left/Right move the page ($FB); a move erases the old cursor (tile $C3) and draws the new one (tile $BB) with sound $69; A draws tile $BC, plays sound $69 and sets $FF; B sets $FE. When the range is a single entry the press only blinks the cursor and the result is 0, as with no input (E-0068)
; 34 call sites from 34 routines (e.g. EggServiceMenu_ChooseAndPay_UpdatePagedListCursor, KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc, HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case25, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListLastRow, wListCursor, wListPageIndex, wListPages
; writes: wMenuInputResult, wListCursor, wListCursorAux, wListPageIndex
UpdatePagedListCursor::
Func_01D_66B6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .read_list_pages
    bit 5, a
    jr nz, .check_list_page_index
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_update_paged_list_cursor_read_menu_input
    bit 7, a
    jp nz, .call_update_paged_list_cursor_read_menu_input2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_update_paged_list_cursor_bg_map_address
    bit 1, a
    jp nz, .set_menu_input_result_to_FE
    call UpdatePagedListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.read_list_pages:
    ld a, [wListPages]
    ld b, a
    ld a, [wListPageIndex]
    inc a
    cp a, b
    jr c, .set_list_page_index
    ld a, [wListPages]
    cp a, $01
    jr nz, .clear_list_page_index
    call UpdatePagedListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.clear_list_page_index:
    xor a, a

.set_list_page_index:
    ld [wListPageIndex], a
    xor a, a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FB
    ld [wMenuInputResult], a
    ret

.check_list_page_index:
    ld a, [wListPageIndex]
    and a, a
    jr nz, .skip2
    ld a, [wListPages]
    cp a, $01
    jr nz, .skip
    call UpdatePagedListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.skip:
    dec a
    jp .set_list_page_index

.skip2:
    dec a
    jp .set_list_page_index

.call_update_paged_list_cursor_read_menu_input:
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor_Sub03
    ld a, [wListCursor]
    and a, a
    jr nz, .set_list_cursor2
    ld a, [wListLastRow]
    and a, a
    jr nz, .set_list_cursor
    call UpdatePagedListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.set_list_cursor:
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor2:
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.call_update_paged_list_cursor_read_menu_input2:
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor_Sub03
    ld a, [wListLastRow]
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, .set_list_cursor3
    ld a, [wListLastRow]
    and a, a
    jr nz, .clear_list_cursor
    call UpdatePagedListCursor_WriteListCursorAux
    xor a, a
    ld [wMenuInputResult], a
    ret

.clear_list_cursor:
    xor a, a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor3:
    inc a
    ld [wListCursor], a

.clear_list_cursor_aux:
    xor a, a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_update_paged_list_cursor_bg_map_address:
    call UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdatePagedListCursor (E-0047)
; 5 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wJoypadRepeatTimer, wListCursorAux, wMenuInputResult, wListCursor
; writes: wListCursorAux
UpdatePagedListCursor_WriteListCursorAux::
Func_01D_679D:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp a, $10
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    cp a, $18
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor_Sub03
    xor a, a
    ld [wListCursorAux], a

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_ReadMenuInputResultAndListCursor::
Func_01D_67B7:: ; address name
    ld b, $BB
    jr UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF_ReadMenuInputResult

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_ReadMenuInputResultAndListCursor_Sub03::
Func_01D_67BB:: ; address name
    ld b, $C3
    jr UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF_ReadMenuInputResult

; only called from UpdatePagedListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wListCursor
UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF::
Func_01D_67BF:: ; address name
    ld b, $BC

UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF_ReadMenuInputResult::
Jump_01D_67C1:: ; address name
    ld a, [wMenuInputResult]
    ld c, a
    add a, a
    add a, a
    add a, c
    add a, a
    ld hl, UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF_Data
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

; address loaded by UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF
UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_62FF_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_67EE:: ; address name
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $28, $00, $68, $00, $A8, $00
    db $E8, $00, $28, $01, $A8, $00, $E8, $00, $28, $01, $68, $01, $A8, $01, $A6, $00
    db $E6, $00, $26, $01, $66, $01, $A6, $01, $A4, $00, $E4, $00, $24, $01, $64, $01
    db $A4, $01, $A2, $00, $E2, $00, $22, $01, $62, $01, $A2, $01

; for the three records listed at wArg1 loads each species' sprite graphics and palette to the slots in Data_01D_6890 (E-0128)
; 4 call sites from 4 routines (e.g. PauseMenu_Info_Blocks09And0A_Case01_LoadPartySpeciesSpriteGraphics, SwapMonstersMenu_ShowParents2_UploadTilesFromData6D20, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_Case1E, RunLinkSession8Case03Steps_UploadTilesFromData6D20)
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

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    jr nz, .skip
    ld de, LoadPartySpeciesSpriteGraphics_Data_6DE0
    jr .restore

.skip:
    ld de, LoadPartySpeciesSpriteGraphics_Data_6DE3

.restore:
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp a, $FF
    jr z, .restore2
    pop bc
    push bc
    ld a, c
    add a, a
    add a, c
    ld de, LoadPartySpeciesSpriteGraphics_Data_6890
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld hl, wArg3
    ld c, $03

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop2
    call LoadSpeciesSpriteGraphicsAndPalette

.restore2:
    pop bc
    pop hl
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ret

; address loaded by LoadPartySpeciesSpriteGraphics
LoadPartySpeciesSpriteGraphics_Data_6890:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6890:: ; address name
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; for the three records listed at wArg1 draws each species sprite at the positions in Data_01D_6909 (E-0128)
; 5 call sites from 5 routines (e.g. CallDrawPartySpeciesSpritesPreservingArg1AndTemp0, PauseMenu_Info_Blocks09And0A_UpdateMenuCursor, SwapMonstersMenu_ShowParents2_HandleListCursorInput_1D, SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_Case20, ...)
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

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    jr nz, .skip
    ld de, LoadPartySpeciesSpriteGraphics_Data_6DE0
    jr .restore

.skip:
    ld de, LoadPartySpeciesSpriteGraphics_Data_6DE3

.restore:
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp a, $FF
    jr z, .restore2
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    add a, a
    add a, a
    ld hl, DrawPartySpeciesSprites_Data
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

.restore2:
    pop bc
    pop hl
    inc c
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by DrawPartySpeciesSprites
DrawPartySpeciesSprites_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6909:: ; address name
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; decompresses the sprite graphics of species hTemp0/7 (far pointer Data_004_4EAA + 3 * id) to the VRAM address in wArg4/5; on CGB copies its 8-byte palette from bank $27 into wOBJPaletteBuffer + wArg3 (E-0127)
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

.loop:
    push bc
    call ReadByteInBank
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; graphics number = the word wArg1/wArg2: reads its far pointer (3 bytes per entry) from Data_004_4EAA in bank $04 (ReadFarPointerAtDEInBankB) and DecompressToVRAM to the address in wArg4/wArg5; on CGB it continues with the palette (not read) (E-0104)
; 8 call sites from 8 routines (e.g. DecompressRecordSpeciesGraphicsToTiles0, LibraryMenu_ShowMonsterEntry_GridCellAddressFromGridCursorXAndGrid2CursorX, RunNameEntryStateWhenNotFading_Setup_CopyArgs, DecompressGraphicsA4ToTiles0, ...)
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
    jr z, .return
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

.loop:
    push bc
    call ReadByteInBank
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; draws sprite set wArg1 & $7F (from bank $25, $26 or $27 by wArg2 and bit 7 of wArg1) at the scroll position + (L, D), tile offset H, attribute E, alternating two frames (E-0127)
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
    jr nz, .clear_sprite_sub_index
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr .set_sprite_tile_offset

.clear_sprite_sub_index:
    xor a, a
    ldh [hSpriteSubIndex], a

.set_sprite_tile_offset:
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
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [wArg1]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; only called from DrawThreeMetaSpritePartsFor5050 (E-0047)
; 3 call sites from 1 routine (e.g. DrawThreeMetaSpritePartsFor5050)
; reads: wArg6, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, hScrollYHi, ...
; writes: hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawThreeMetaSpritePartsFor5050_WriteSpriteAttrXorAndSpriteTileOffsetEtc::
Func_01D_6A36:: ; address name
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    jr DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc_ReadArg3

; C = 0, then falls into the sprite part draw (Func_01D_6A36 body) (E-0122)
; 6 call sites from 6 routines (e.g. PauseMenu_Info_Blocks04To06_DrawMetaSpritePartC0, RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc, SwapMonstersMenu_ShowPartyMemberDetails_GetListEntriesCell5Address, DrawWCA36SpritePart, ...)
; reads: wArg6, wFrameCounterLo, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawMetaSpritePartC0::
Func_01D_6A3D:: ; address name
    ld c, $00

; only called from DrawSpritePart9000At88_28 (E-0047)
; 1 call site from 1 routine (e.g. DrawSpritePart9000At88_28)
; reads: wArg6, wFrameCounterLo, wArg3, wArg4, hScrollX, hScrollXHi, wArg5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc::
Func_01D_6A3F:: ; address name
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    ld a, c
    and a, a
    jr nz, .clear_sprite_sub_index
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc_ReadArg3

.clear_sprite_sub_index:
    xor a, a
    ldh [hSpriteSubIndex], a

DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc_ReadArg3::
Jump_01D_6A59:: ; address name
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
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [wArg1]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; for each party record found on the current list page (wListEntries page wListPageIndex) draws a party mark at its row (scroll offsets Data_01D_6B28 when wArg1 is set, else screen-buffer offsets Data_01D_6B1E) (E-0128)
; 14 call sites from 10 routines (e.g. HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5, BreedMenu_ChooseParents_DrawRecordListPageNames, EggServiceMenu_Bank1B_ListAvailableRecords_DrawRecordListPageNames, SwapMonstersMenu_ChooseToView_LoadFamilyIconTileForRecordB_Bank1E, ...)
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

.loop:
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

.loop2:
    ld a, [hl]
    cp a, b
    jr z, .check_arg1
    inc hl
    inc c
    ld a, [wListLastRow]
    cp a, c
    jr nc, .loop2
    pop hl
    pop bc

.check_party_count:
    inc hl
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    ret

.check_arg1:
    ld a, [wArg1]
    and a, a
    jr z, .skip
    ld hl, MarkPartyMembersInRecordListPage_Data_6B28
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
    jr .restore

.skip:
    ld a, c
    add a, a
    ld hl, MarkPartyMembersInRecordListPage_Data_6B1E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.restore:
    pop hl
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E1
    ld [de], a
    ei
    jp .check_party_count

; address loaded by MarkPartyMembersInRecordListPage
MarkPartyMembersInRecordListPage_Data_6B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6B1E:: ; address name
    db $78, $C3, $A0, $C3, $C8, $C3, $F0, $C3, $18, $C4

; address loaded by MarkPartyMembersInRecordListPage
MarkPartyMembersInRecordListPage_Data_6B28:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6B28:: ; address name
    db $20, $00, $60, $00, $A0, $00, $E0, $00, $20, $01

; only called from SwapMonstersMenu_Case03 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case03_ListPartyRecordsWithState2ToListEntries_Case03)
; reads: wGridCursorX, wScreenState, wListCount, wPartyCount
; writes: wScreenState, wScreenStep, wTwoChoiceCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest, wScreenSubStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case03_ListPartyRecordsWithState2ToListEntries::
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
    jr z, .call_list_party_records_with_state2_to_list
    cp a, $01
    jp z, .call_list_records_state1_with_byte6_e_clear
    cp a, $02
    jp z, .read_screen_state2
    cp a, $03
    jp z, .read_screen_state3

.call_list_party_records_with_state2_to_list:
    call ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    cp a, $02
    jr c, .set_screen_step_to_10
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

.set_screen_step_to_10:
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

.call_list_records_state1_with_byte6_e_clear:
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a, a
    jr nz, .read_screen_state
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

.read_screen_state:
    ld a, [wScreenState]
    add a, $02
    ld [wScreenState], a
    ld a, [wPartyCount]
    cp a, $03
    jr c, .set_two_choice_cursor_to_02
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $1E
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_state2:
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_state3:
    ld a, [wScreenState]
    add a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; copies tiles listed at the address in wArg3/4 to wArg1/2 + 16 * n, six per call; wArg5 = $FF when the $FF end is reached, else 0 (E-0128)
; 7 call sites from 7 routines (e.g. CloseHibernateMenu_LoadTileListSixPerCall, BreedMenu_ChooseParents_LoadTileListSixPerCall, BreedMenu_ChooseParents_LoadTileListSixPerCall_Case32, BreedMenu_ChooseEgg_DrawGoldBoxAndStep_Bank15, ...)
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

.loop:
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $FF
    jr z, .restore
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
    jr c, .loop
    xor a, a
    ld [wArg5], a
    ret

.restore:
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

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; HL = Data_01D_6D84, wArg1/2 = $9C/0, DE = vBGMap1, wGlyphListPos = 0, then continues at LoadTileList6DC4SixPerFrame_Loop (E-0126)
; 2 call sites from 2 routines (e.g. HibernateMenu_SetupPartyList_ToSetupTileMap6D84AtBGMap1, SwapMonstersMenu_SetupPartyList_ToSetupTileMap6D84AtBGMap1)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
SetupTileMap6D84AtBGMap1::
Func_01D_6C8A:: ; address name
    ld hl, SetupTileMap6D84AtBGMap1_Data
    ld a, $9C
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, vBGMap1
    xor a, a
    ld [wGlyphListPos], a
    jr LoadTileList6DC4SixPerFrame_Loop

; copies tiles listed in Data_01D_6DC4 to vBGMap1 + $200 onward six per call; at the $FF end resets the counters and wScreenStep += 1 (E-0127)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_ChooseToView_ToLoadTileList6DC4SixPerFrame, RunLinkSession8Case01Steps_ToLoadTileList6DC4SixPerFrame)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
LoadTileList6DC4SixPerFrame::
Func_01D_6C9F:: ; address name
    ld hl, LoadTileList6DC4SixPerFrame_Data
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, vBGMap1 + $200
    xor a, a
    ld [wGlyphListPos], a

LoadTileList6DC4SixPerFrame_Loop::
Jump_01D_6CB2:: ; address name
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, .restore
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
    jr c, LoadTileList6DC4SixPerFrame_Loop
    ret

.restore:
    pop de
    pop hl
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies tiles from Data_01D_6D20: two to vTiles2 + $6E0 and three to vTiles2 + $7C0 (CopyTileBytesToVRAM_Bank1D) (E-0118)
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor, SwapMonstersMenu_ShowParents2_UploadTilesFromData6D20, SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_Case1B, RunLinkSession8Case03Steps_UploadTilesFromData6D20)
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

; C = wRecordCapacity = Data_01D_6D81[wFarmLevel] (E-0073)
; 10 call sites from 9 routines (e.g. ListRecordsInUseWithByte6ESet, ListRecordsState1WithByte6EClear, ListRecordsInUseWithByte6EClear, ListPartyRecordsWithState2ToListEntries, ...)
; reads: wFarmLevel
; writes: wRecordCapacity
LoadRecordCapacityFromFarmLevelTable::
Func_01D_6D70:: ; address name
    ld a, [wFarmLevel]
    ld de, LoadRecordCapacityFromFarmLevelTable_Data
    add a, e
    ld e, a
    jr nc, .set_record_capacity
    inc d

.set_record_capacity:
    ld a, [de]
    ld c, a
    ld [wRecordCapacity], a
    ret

; address loaded by LoadRecordCapacityFromFarmLevelTable
LoadRecordCapacityFromFarmLevelTable_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6D81:: ; address name
    db $0A, $14, $1E

; address loaded by SetupTileMap6D84AtBGMap1
SetupTileMap6D84AtBGMap1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6D84:: ; address name
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $F0, $8A, $E0, $8E, $F0, $8E, $00, $8F, $10, $8F
    db $20, $8F, $30, $8F, $40, $8F, $50, $8F, $60, $8F, $70, $8F, $80, $8F, $90, $8F
    db $A0, $8F, $B0, $8F, $C0, $8F, $D0, $8F, $E0, $8F, $F0, $8F, $B0, $8E, $FF, $FF

; address loaded by LoadTileList6DC4SixPerFrame
LoadTileList6DC4SixPerFrame_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6DC4:: ; address name
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $F0, $8B, $A0, $8E, $B0, $8E, $C0, $8E, $D0, $8E, $FF, $FF

; address loaded by LoadPartySpeciesSpriteGraphics, DrawPartySpeciesSprites
LoadPartySpeciesSpriteGraphics_Data_6DE0:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6DE0:: ; address name
    db $0B, $1A, $1C

; address loaded by LoadPartySpeciesSpriteGraphics, DrawPartySpeciesSprites
LoadPartySpeciesSpriteGraphics_Data_6DE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6DE3:: ; address name
    db $0B, $1C, $1A, $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0
    db $8C, $B0, $8C, $FF, $FF

; wArg5 = the number of SRAM records (29 in bank 0 from sCompactRecords plus one in bank 1) with bit 7 of byte 0 set (E-0125)
; 4 call sites from 3 routines (e.g. PauseMenu_Plan_Block2DNumber_LoadScreenBlock2D, HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc, StartRecordListOrNoneMessage)
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

.loop:
    ld a, [hl]
    bit 7, a
    jr z, .next
    inc c

.next:
    inc b
    ld a, $6F
    add_a_to_hl
    ld a, b
    cp a, $1D
    jr c, .loop
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, .set_arg5
    inc c

.set_arg5:
    ld a, c
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; packs SRAM record wArg1's family, state, mark and other fields into the compact form in SRAM bank wArg2 (wPackWork workspace) (E-0131)
; 4 call sites from 4 routines (e.g. SaveStepCopyBank1RecordSaveRecordIndex, HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case42)
; reads: wArg2, wPackByteE1, wPackByteE6
; writes: rRAMB, rRAMG2, wPackByteE1, wPackFields, wPackWork, wArg5
; points at: wPackWork, wPackFields
PackRecordFieldsToBank1Slot::
Func_01D_6E39:: ; address name
    ld bc, $0007
    ld hl, wPackWork

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
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
    jr nc, .skip
    inc d

.skip:
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
    jr nc, .skip2
    inc d

.skip2:
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
    jr nc, .skip3
    inc d

.skip3:
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
    jr nc, .next
    inc d

.next:
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

PackRecordFieldsToBank1Slot_Skip::
Jump_01D_6EC5:: ; address name
    ld hl, wPackFields
    ld c, $00

.loop:
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
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
    ld hl, PackRecordFieldsToBank1Slot_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, e
    ld e, a
    jr nc, .loop2
    inc d

.loop2:
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    push de
    push hl
    push bc
    ld a, [de]
    cp a, $8D
    jr z, .restore
    cp a, $8E
    jr z, .restore
    cp a, $F0
    jr z, .restore3
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
    jr .restore2

.restore:
    pop bc
    dec c
    push bc
    ld b, a
    ld a, c
    ld hl, wPackFields
    add_a_to_hl
    ld a, b
    cp a, $8D
    jr z, .read_arg2
    ld a, $02
    jr .read_arg22

.read_arg2:
    ld a, $01

.read_arg22:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    inc b
    inc c
    pop hl

.restore2:
    pop de
    inc de
    ld a, c
    cp a, $05
    jr c, .loop2
    ld a, b
    cp a, $0A
    jr c, .loop2
    jr .check_pack_byte_e1

.restore3:
    pop bc
    pop hl
    pop de
    ld a, c
    cp a, $05
    jr nc, .check_pack_byte_e1
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $F0
    ld [hl], a

.check_pack_byte_e1:
    ld a, [wPackByteE1]
    and a, a
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg1
    cp a, $01
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg12
    cp a, $02
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg13
    cp a, $03
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg14
    cp a, $04
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg15
    jp PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg16

; address loaded by PackRecordFieldsToBank1Slot
PackRecordFieldsToBank1Slot_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01D_6F9A:: ; address name
    db $01, $0F, $1E, $29, $8E, $99

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg1::
Jump_01D_6FA0:: ; address name
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
    jp PackRecordFieldsToBank1Slot_Skip

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg12::
Jump_01D_6FDD:: ; address name
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
    jp PackRecordFieldsToBank1Slot_Skip

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg13::
Jump_01D_7019:: ; address name
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
    jp PackRecordFieldsToBank1Slot_Skip

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg14::
Jump_01D_7057:: ; address name
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
    jp PackRecordFieldsToBank1Slot_Skip

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg15::
Jump_01D_708D:: ; address name
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
    jp PackRecordFieldsToBank1Slot_Skip

PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg16::
Jump_01D_70C6:: ; address name
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
    jp Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1

; B = (wPackFields & 3) << 6 | (wPackFields + $1 & 3) << 4 | (wPackFields + $2 & 3) << 2 | (wPackFields + $3 & 3), the opposite of unpacking a byte into four 2-bit fields (E-0104)
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

Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1::
Jump_01D_7121:: ; address name
    call SRAMRecordAddressOfArg1
    ld a, $28
    add_a_to_hl
    ld a, $73
    add a, e
    ld e, a
    jr nc, .call_enable_sram_bank0
    inc d

.call_enable_sram_bank0:
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

.loop:
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
    jr c, .loop
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
    jr nc, .next
    inc d

.next:
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
    jr nc, .skip
    inc d

.skip:
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
    jr nc, .skip2
    inc d

.skip2:
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
    jr nc, .skip3
    inc d

.skip3:
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

.loop2:
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
    jr c, .loop2
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    ld a, $5B
    add a, e
    ld e, a
    jr nc, .call_enable_sram_bank02
    inc d

.call_enable_sram_bank02:
    ld a, $57
    add_a_to_hl
    call EnableSRAMBank0
    ld c, $00

.loop3:
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
    jr c, .loop3
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    ld a, $6B
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
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
    jr nc, .skip5
    inc d

.skip5:
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
    jr nc, .skip6
    inc d

.skip6:
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
    jr nc, .skip7
    inc d

.skip7:
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
    jr nc, .skip8
    inc d

.skip8:
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
    jr nc, .skip9
    inc d

.skip9:
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
    jr nc, .skip10
    inc d

.skip10:
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

; unpacks the compact record in SRAM bank wArg2 back into the record fields (family, state, mark ...) (E-0131)
; 4 call sites from 4 routines (e.g. ScanBank1RecordStepSaveRecordIndex, HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot, HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case42)
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
    jr nc, .read_arg2
    inc d

.read_arg2:
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
    jr nc, .read_arg22
    inc d

.read_arg22:
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
    jr nc, .read_arg23
    inc d

.read_arg23:
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
    jr nc, .read_arg24
    inc d

.read_arg24:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank0
    inc d

.call_copy_ten_bytes_then_select_sram_bank0:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank02
    inc d

.call_copy_ten_bytes_then_select_sram_bank02:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank03
    inc d

.call_copy_ten_bytes_then_select_sram_bank03:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank04
    inc d

.call_copy_ten_bytes_then_select_sram_bank04:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank05
    inc d

.call_copy_ten_bytes_then_select_sram_bank05:
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
    jr nc, .call_copy_ten_bytes_then_select_sram_bank06
    inc d

.call_copy_ten_bytes_then_select_sram_bank06:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    jp CopyTenBytesThenSelectSRAMBank0_CallSRAMRecordAddressOfArg1

; copies 10 bytes from HL to DE, selecting SRAM bank 0 (rRAMB = 0) after each byte is read; HL and DE advance (E-0106)
; 6 call sites from 1 routine (e.g. UnpackRecordFromBank1Slot)
; writes: rRAMB
CopyTenBytesThenSelectSRAMBank0::
Func_01D_75C7:: ; address name
    ld c, $00

.loop:
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
    jr c, .loop
    ret

CopyTenBytesThenSelectSRAMBank0_CallSRAMRecordAddressOfArg1::
Jump_01D_75DA:: ; address name
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $28
    add_a_to_hl
    push de
    ld a, $73
    add a, e
    ld e, a
    jr nc, .read_arg2
    inc d

.read_arg2:
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

.loop:
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
    jr c, .loop
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
    jr nc, .read_arg22
    inc d

.read_arg22:
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
    jr nz, .next
    dec de
    ld a, [de]
    inc de
    cp a, $FF
    jr nz, .next
    ld a, $FF
    ld [de], a

.next:
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
    jr nz, .skip
    inc de
    ld a, [de]
    cp a, $01
    jr nz, .skip
    ld a, $FF
    ld [de], a

.skip:
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
    jr nc, .read_arg23
    inc d

.read_arg23:
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
    jr nc, .read_arg24
    inc d

.read_arg24:
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
    jr nc, .read_arg25
    inc d

.read_arg25:
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
    jr nc, .read_arg26
    inc d

.read_arg26:
    ld c, $00

.loop2:
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
    jr c, .loop2
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
    jr nc, .skip2
    inc d

.skip2:
    ld c, $00

.loop3:
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
    jr c, .loop3
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
    jr nc, .read_arg27
    inc d

.read_arg27:
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
    jr nc, .read_arg28
    inc d

.read_arg28:
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
    jr nc, .read_arg29
    inc d

.read_arg29:
    ld c, $00

.loop4:
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
    jr c, .loop4
    pop de
    push de
    ld a, $6D
    add a, e
    ld e, a
    jr nc, .read_arg210
    inc d

.read_arg210:
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
    jr nc, .read_arg211
    inc d

.read_arg211:
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
    jr nc, .read_arg212
    inc d

.read_arg212:
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
    jr nc, .read_arg213
    inc d

.read_arg213:
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

; record wArg1 (SRAM bank wArg2): unpacks byte $21 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 7-6 of byte $27, and copies the 5-glyph name entry at offset 3 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 6 call sites from 6 routines (e.g. UnpackRecordFromBank1Slot, HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Shared01, HibernateMenu_ChooseRecords_Case2F_LoadRecordNameEntry0, ShowSaveFileInfoWindow, ...)
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

; record wArg1 (SRAM bank wArg2): unpacks byte $22 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 5-4 of byte $27, and copies the 5-glyph name entry at offset 8 (Func_01D_7A90); one of six name entries in the record (E-0120)
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

; record wArg1 (SRAM bank wArg2): unpacks byte $23 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 3-2 of byte $27, and copies the 5-glyph name entry at offset $0D (Func_01D_7A90); one of six name entries in the record (E-0120)
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

; record wArg1 (SRAM bank wArg2): unpacks byte $24 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 1-0 of byte $27, and copies the 5-glyph name entry at offset $12 (Func_01D_7A90); one of six name entries in the record (E-0120)
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

; record wArg1 (SRAM bank wArg2): unpacks byte $25 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 7-6 of byte $28, and copies the 5-glyph name entry at offset $17 (Func_01D_7A90); one of six name entries in the record (E-0120)
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

; record wArg1 (SRAM bank wArg2): unpacks byte $26 into the four 2-bit fields wArg5-wArg8, sets wMenuInputResult = bits 5-4 of byte $28, and copies the 5-glyph name entry at offset $1C (Func_01D_7A90); one of six name entries in the record (E-0120)
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

; fills wNameGlyphBuf with $F0 and copies up to five glyphs from HL, adding mark $8D or $8E after each glyph whose wArg5 field is 1 or 2 (E-0127)
; 6 call sites from 6 routines (e.g. LoadRecordNameEntry5, LoadRecordNameEntry4, LoadRecordNameEntry3, LoadRecordNameEntry2, ...)
; points at: wNameGlyphBuf, wArg5
BuildFiveGlyphNameWithMarksToNameGlyphBuf::
Func_01D_7A90:: ; address name
    ld de, wNameGlyphBuf
    ld c, $00

.loop:
    ld a, $F0
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $0B
    jr c, .loop
    ld bc, $0000
    ld de, wNameGlyphBuf

.loop2:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc de
    push hl
    ld a, c
    ld hl, wArg5
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, .restore
    cp a, $01
    jr z, .skip2
    cp a, $02
    jr z, .skip
    jr .restore

.skip:
    ld a, $8E
    jr .skip3

.skip2:
    ld a, $8D

.skip3:
    ld [de], a
    inc de

.restore:
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $05
    jr c, .loop2
    ld a, $F0

.done:
    ld [de], a
    ret

; with SRAM bank wArg2 selected, splits the byte at HL into four 2-bit fields: wArg5 = bits 7-6, wArg6 = bits 5-4, wArg7 = bits 3-2, wArg8 = bits 1-0 (E-0104)
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

; HL = the word at wArg3/wArg4; DE = sRecords + $A5 * wArg1, the start of SRAM record wArg1 (records are $A5 bytes, as in SRAMRecordAddress); clobbers A, BC (E-0063)
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
