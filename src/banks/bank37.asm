SECTION "Bank 37", ROMX[$4000], BANK[$37]
    db $37

; ld de, this bank's string table / BeginStringDisplay
; 17 call sites from 17 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank37, PauseMenu_Items_UseItem_BeginStringDisplay_Bank37, PauseMenu_Items_UseItem_BeginStringDisplay_Bank37_Case09, PauseMenu_Items_UseItem_ApplyItemEffect, ...)
BeginStringDisplay_Bank37::
Func_037_4001:: ; address name
    ld de, StringCategories_37_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_37_4016::
Data_037_4016:: ; address name
    dw StringList_37_401A ; id 0
    dw StringList_37_4086 ; id 1

; E-0217 (derived: category list of StringCategories_37_4016; one pointer per wStringIndex)
; record: string
StringList_37_401A::
Data_037_401A:: ; address name
    dw String_37_00_00 ; id 0
    dw String_37_00_01 ; id 1
    dw String_37_00_02 ; id 2
    dw String_37_00_03 ; id 3
    dw String_37_00_04 ; id 4
    dw String_37_00_05 ; id 5
    dw String_37_00_06 ; id 6
    dw String_37_00_07 ; id 7
    dw String_37_00_08 ; id 8
    dw String_37_00_09 ; id 9
    dw String_37_00_0A ; id 10
    dw String_37_00_0B ; id 11
    dw String_37_00_0C ; id 12
    dw String_37_00_0D ; id 13
    dw String_37_00_0E ; id 14
    dw String_37_00_0F ; id 15
    dw String_37_00_10 ; id 16
    dw String_37_00_11 ; id 17
    dw String_37_00_12 ; id 18
    dw String_37_00_13 ; id 19
    dw String_37_00_14 ; id 20
    dw String_37_00_15 ; id 21
    dw String_37_00_16 ; id 22
    dw String_37_00_17 ; id 23
    dw String_37_00_18 ; id 24
    dw String_37_00_19 ; id 25
    dw String_37_00_1A ; id 26
    dw String_37_00_1B ; id 27
    dw String_37_00_1C ; id 28
    dw String_37_00_1D ; id 29
    dw String_37_00_1E ; id 30
    dw String_37_00_1F ; id 31
    dw String_37_00_20 ; id 32
    dw String_37_00_21 ; id 33
    dw String_37_00_22 ; id 34
    dw String_37_00_23 ; id 35
    dw String_37_00_24 ; id 36
    dw String_37_00_25 ; id 37
    dw String_37_00_26 ; id 38
    dw String_37_00_27 ; id 39
    dw String_37_00_28 ; id 40
    dw String_37_00_29 ; id 41
    dw String_37_00_2A ; id 42
    dw String_37_00_2B ; id 43
    dw String_37_00_2C ; id 44
    dw String_37_00_2D ; id 45
    dw String_37_00_2E ; id 46
    dw String_37_00_2F ; id 47
    dw String_37_00_30 ; id 48
    dw String_37_00_31 ; id 49
    dw String_37_00_32 ; id 50
    dw String_37_00_33 ; id 51
    dw String_37_00_34 ; id 52
    dw String_37_00_35 ; id 53

; E-0217 (derived: category list of StringCategories_37_4016; one pointer per wStringIndex)
; record: string
StringList_37_4086::
Data_037_4086:: ; address name
    dw String_37_01_00 ; id 0
    dw String_37_01_01 ; id 1
    dw String_37_01_02 ; id 2
    dw String_37_01_03 ; id 3
    dw String_37_01_04 ; id 4
    dw String_37_01_05 ; id 5
    dw String_37_01_06 ; id 6
    dw String_37_01_07 ; id 7
    dw String_37_01_08 ; id 8
    dw String_37_01_09 ; id 9
    dw String_37_01_0A ; id 10
    dw String_37_01_0B ; id 11
    dw String_37_01_0C ; id 12
    dw String_37_01_0D ; id 13
    dw String_37_01_0E ; id 14
    dw String_37_01_0F ; id 15
    dw String_37_01_10 ; id 16
    dw String_37_01_11 ; id 17
    dw String_37_01_12 ; id 18
    dw String_37_01_13 ; id 19
    dw String_37_01_14 ; id 20
    dw String_37_01_15 ; id 21
    dw String_37_01_16 ; id 22
    dw String_37_01_17 ; id 23
    dw String_37_01_18 ; id 24
    dw String_37_01_19 ; id 25
    dw String_37_01_1A ; id 26
    dw String_37_01_1B ; id 27
    dw String_37_01_1C ; id 28
    dw RunLinkSession5Exchange_Case01_WaitFadeState ; id 29
    dw RunLinkSession5Exchange_Case01_WaitFadeState ; id 30
    dw RunLinkSession5Exchange_Case01_WaitFadeState ; id 31

String_37_00_00:: ; heuristic: string; C0
Data_037_40C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ", $F9, "W", $F1
    db "shattered!", $F7
    db $F0

String_37_00_01:: ; heuristic: string; C0
Data_037_40D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried using", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_02:: ; heuristic: string; C0
Data_037_40F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But nothing", $F1
    db "happened!", $F7
    db $F0

String_37_00_03:: ; heuristic: string; C0
Data_037_4108:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 used the", $F1
    db $F9, "W on", $F7
    db $F2, $F9, "G!", $F7
    db $F0

String_37_00_04:: ; heuristic: string; C0
Data_037_4120:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's wounds", $F1
    db "were healed!", $F7
    db $F0

String_37_00_05:: ; heuristic: string; C0
Data_037_4139:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0

String_37_00_06:: ; heuristic: string; C0
Data_037_4150:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 scattered", $F1
    db "the ", $F9, "W!", $F7
    db $F0

String_37_00_07:: ; heuristic: string; C0
Data_037_4166:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G", $F1
    db "regained MP.", $F7
    db $F0

String_37_00_08:: ; heuristic: string; C0
Data_037_4177:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was cured of", $F1
    db "poison.", $F7
    db $F0

String_37_00_09:: ; heuristic: string; C0
Data_037_4190:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was cured of", $F1
    db "paralysis.", $F7
    db $F0

String_37_00_0A:: ; heuristic: string; C0
Data_037_41AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G snapped", $F1
    db "out of confusion.", $F7
    db $F0

String_37_00_0B:: ; heuristic: string; C0
Data_037_41CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was", $F1
    db "uncursed.", $F7
    db $F0

String_37_00_0C:: ; heuristic: string; C0
Data_037_41DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G woke up.", $F7
    db $F0

String_37_00_0D:: ; heuristic: string; C0
Data_037_41E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G came", $F1
    db "back to life.", $F7
    db $F0

String_37_00_0E:: ; heuristic: string; C0
Data_037_4200:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's max.HP", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_0F:: ; heuristic: string; C0
Data_037_4218:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's max.MP", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_10:: ; heuristic: string; C0
Data_037_4230:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's ATK", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_11:: ; heuristic: string; C0
Data_037_4245:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's DEF", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_12:: ; heuristic: string; C0
Data_037_425A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's AGL", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_13:: ; heuristic: string; C0
Data_037_426F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's INT", $F1
    db "rose by ", $F9, "m!", $F7
    db $F0

String_37_00_14:: ; heuristic: string; C0
Data_037_4284:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 gave ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_15:: ; heuristic: string; C0
Data_037_4298:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G happily ate", $F1
    db "the treat.", $F7
    db $F2, $F9, "G's affection", $F1
    db "for ", $F6, " rose!", $F7
    db $F0

String_37_00_16:: ; heuristic: string; C0
Data_037_42CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G fearfully", $F1
    db "ate the foul mess.", $F7
    db $F2, $F9, "G glared with", $F1
    db "a sour expression.", $F7
    db $F2, $F9, "G became", $F1
    db "poisoned.", $F7
    db $F0

String_37_00_17:: ; heuristic: string; C0
Data_037_4327:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0

String_37_00_18:: ; heuristic: string; C0
Data_037_433E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tossed the", $F1
    db $F9, "W up.", $F7
    db $F0

String_37_00_19:: ; heuristic: string; C0
Data_037_4354:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 used the", $F1
    db $F9, "W!", $F7
    db $F0

String_37_00_1A:: ; heuristic: string; C0
Data_037_4365:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_1B:: ; heuristic: string; C0
Data_037_4379:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A stirring tale of", $F1
    db "honor, sacrifice", $F7
    db $F2, "and heroism made", $F1
    db $F9, "G brave.", $F7
    db $F0

String_37_00_1C:: ; heuristic: string; C0
Data_037_43BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A bloodcurdling", $F1
    db "tale of horror", $F7
    db $F2, "turned ", $F9, "G", $F1
    db "cowardly.", $F7
    db $F0

String_37_00_1D:: ; heuristic: string; C0
Data_037_43EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A heartwarming", $F1
    db "tale of selfless", $F7
    db $F2, "compassion made", $F1
    db $F9, "G kind.", $F7
    db $F0

String_37_00_1E:: ; heuristic: string; C0
Data_037_442A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A shameless tale", $F1
    db "of greed, lies and", $F7
    db $F2, "deception made", $F1
    db $F9, "G sly.", $F7
    db $F0

String_37_00_1F:: ; heuristic: string; C0
Data_037_4467:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A practical guide", $F1
    db "on thinking in a", $F7
    db $F2, "rational manner", $F1
    db "made ", $F9, "G smart.", $F7
    db $F0

String_37_00_20:: ; heuristic: string; C0
Data_037_44AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A hilarious tale", $F1
    db "made ", $F9, "G simple.", $F7
    db $F0

String_37_00_21:: ; heuristic: string; C0
Data_037_44CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " held aloft", $F1
    db "the ", $F9, "W!", $F7
    db $F0

String_37_00_22:: ; heuristic: string; C0
Data_037_44E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Orb glowed", $F1
    db "with a warm light.", $F7
    db $F0

String_37_00_23:: ; heuristic: string; C0
Data_037_4506:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The presence of", $F1
    db "monsters faded.", $F7
    db $F0

String_37_00_24:: ; heuristic: string; C0
Data_037_4527:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 strummed", $F1
    db "the ", $F9, "W!", $F7
    db $F0

String_37_00_25:: ; heuristic: string; C0
Data_037_453C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Want to record", $F1
    db "your journey?", $F0

String_37_00_26:: ; heuristic: string; C0
Data_037_4559:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your progress has", $F1
    db "been recorded.", $F7
    db $F0

String_37_00_27:: ; heuristic: string; C0
Data_037_457B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G equipped", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_28:: ; heuristic: string; C0
Data_037_4590:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F0

String_37_00_29:: ; heuristic: string; C0
Data_037_45A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9, "'r's wounds", $F1
    db "were healed.", $F7
    db $F0

String_37_00_2A:: ; heuristic: string; C0
Data_037_45DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9, "'r's wounds", $F1
    db "were healed.", $F7
    db $F2, $F9, $50, "'s wounds", $F1
    db "were healed.", $F7
    db $F0

String_37_00_2B:: ; heuristic: string; C0
Data_037_4626:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 gripped", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_2C:: ; heuristic: string; C0
Data_037_463A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The MarkStaff", $F1
    db "was sensed at", $F7
    db $F2, $F9, "0", $A3, " ", $F9, "G and", $F1
    db $F9, "W", $A3, " ", $F9, "m.", $F7
    db $F0

String_37_00_2D:: ; heuristic: string; C0
Data_037_466B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The MarkStaff was", $F1
    db "not sensed.", $F7
    db $F2, "It doesn't appear", $F1
    db "to have been used.", $F7
    db $F0

String_37_00_2E:: ; heuristic: string; C0
Data_037_46AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 put down", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_2F:: ; heuristic: string; C0
Data_037_46C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Guide Bell's", $F1
    db "clear note echoed!", $F7
    db $F0

String_37_00_30:: ; heuristic: string; C0
Data_037_46E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 gave ", $F9, "G", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_37_00_31:: ; heuristic: string; C0
Data_037_46FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G switched its", $F1
    db $F9, "m with the", $F7
    db $F2, $F9, "W.", $F7
    db $F0

String_37_00_32:: ; heuristic: string; C0
Data_037_471E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $A4, "But that monster", $F1
    db "is dead", $A4, $F7
    db $F0

String_37_00_33:: ; heuristic: string; C0
Data_037_473A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m was", $F1
    db "uncursed.", $F7
    db $F0

String_37_00_34:: ; heuristic: string; C0
Data_037_474C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m was", $F1
    db "uncursed.", $F7
    db $F2, $F9, "'r was", $F1
    db "uncursed.", $F7
    db $F0

String_37_00_35:: ; heuristic: string; C0
Data_037_4770:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "m was", $F1
    db "uncursed.", $F7
    db $F2, $F9, "'r was", $F1
    db "uncursed.", $F7
    db $F2, $F9, $50, " was", $F1
    db "uncursed.", $F7
    db $F0

String_37_01_00:: ; heuristic: string; C0
Data_037_47A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 cast", $F1
    db $F9, "W!", $F7
    db $F0

String_37_01_01:: ; heuristic: string; C0
Data_037_47B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 whistled!", $F7
    db $F0

String_37_01_02:: ; heuristic: string; C0
Data_037_47C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 released its", $F1
    db "Pheromone.", $F7
    db $F0

String_37_01_03:: ; heuristic: string; C0
Data_037_47DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 scanned the", $F1
    db "surroundings.", $FA, $F7
    db $F0

String_37_01_04:: ; heuristic: string; C0
Data_037_47FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " asked ", $F9, "0", $F1
    db "to run an errand.", $F7
    db $F0

String_37_01_05:: ; heuristic: string; C0
Data_037_481A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 scanned the", $F1
    db "area sharply.", $F7
    db $F0

String_37_01_06:: ; heuristic: string; C0
Data_037_4838:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G's wounds", $F1
    db "were healed!", $F7
    db $F0

String_37_01_07:: ; heuristic: string; C0
Data_037_4851:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G regained MP!", $F7
    db $F0

String_37_01_08:: ; heuristic: string; C0
Data_037_4862:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G came back to", $F1
    db "life!", $F7
    db $F0

String_37_01_09:: ; heuristic: string; C0
Data_037_4879:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was cured of", $F1
    db "poison.", $F7
    db $F0

String_37_01_0A:: ; heuristic: string; C0
Data_037_4892:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G was", $F1
    db "uncursed.", $F7
    db $F0

String_37_01_0B:: ; heuristic: string; C0
Data_037_48A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 whispered in", $F1
    db $F6, "'s ear.", $FA, $F7
    db $F0

String_37_01_0C:: ; heuristic: string; C0
Data_037_48BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0", $A3, " There are", $F1
    db $F9, "m around.", $FA, $F7
    db $F0

String_37_01_0D:: ; heuristic: string; C0
Data_037_48D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 finished", $F1
    db "talking.", $F7
    db $F0

String_37_01_0E:: ; heuristic: string; C0
Data_037_48EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 ran off with", $F1
    db "100G.", $FA, $F7
    db $F2, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $F1
    db $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $A4, $FA, $F7
    db $F0

String_37_01_0F:: ; heuristic: string; C0
Data_037_492B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 returned", $F1
    db "with an item.", $FA, $F7
    db $F2, $F6, " obtained one", $F1
    db $F9, "m.", $F7
    db $F0

String_37_01_10:: ; heuristic: string; C0
Data_037_495B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 came back", $F1
    db "with nothing", $A4, $F7
    db $F0

String_37_01_11:: ; heuristic: string; C0
Data_037_4977:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 sensed a", $F1
    db "treasure nearby.", $FA, $F7
    db $F2, "It appears to be", $F1
    db "very close.", $F7
    db $F0

String_37_01_12:: ; heuristic: string; C0
Data_037_49B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But nothing", $F1
    db "happened.", $F7
    db $F0

String_37_01_13:: ; heuristic: string; C0
Data_037_49CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "G did not come", $F1
    db "back to life", $A4, $F7
    db $F0

String_37_01_14:: ; heuristic: string; C0
Data_037_49EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But it couldn't be", $F1
    db "used here.", $F7
    db $F0

String_37_01_15:: ; heuristic: string; C0
Data_037_4A08:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But there were no", $F1
    db "monsters nearby.", $F7
    db $F0

String_37_01_16:: ; heuristic: string; C0
Data_037_4A2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But there is no", $F1
    db "room for it", $A4, $F7
    db $F0

String_37_01_17:: ; heuristic: string; C0
Data_037_4A4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But there wasn't", $F1
    db "enough money.", $F7
    db $F0

String_37_01_18:: ; heuristic: string; C0
Data_037_4A69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There are no", $F1
    db "treasures nearby.", $F7
    db $F0

String_37_01_19:: ; heuristic: string; C0
Data_037_4A89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not enough MP!", $F1
    db $F7
    db $F0

String_37_01_1A:: ; heuristic: string; C0
Data_037_4A9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dead monster", $F1
    db "can't use a skill.", $F7
    db $F0

String_37_01_1B:: ; heuristic: string; C0
Data_037_4ABC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That can't be used", $F1
    db "in the field.", $F7
    db $F0

String_37_01_1C:: ; heuristic: string; C0
Data_037_4ADD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The surroundings", $F1
    db "became clear.", $F7
    db $F0

; only called from RunLinkSession5Exchange_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkReceiveStepWithBuffer)
; reads: wFadeState, wScreenState
RunLinkSession5Exchange_Case01_WaitFadeState::
Func_037_4AFD:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenState]
    rst $00
    dw RunLinkSession5Exchange_Case01_Sub01_ToSwapMonstersMenuAndStep
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_SetScreenState
    dw RunLinkSession5Exchange_ShowMessages
    dw RunLinkSession5Exchange_LinkBreed
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags_Case05
    dw RunLinkSession5Exchange_Case01_Sub01_WaitLinkMessage
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_SwapMonstersMenu
    dw RunLinkSession5Exchange_ShowRecordStats
    dw RunLinkSession5Exchange_ResetListAndShowString
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags
    dw RunLinkSession5Exchange_ShowChosenRecord

; entry 0 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunLinkSession5Exchange_Case01_Sub01_ToSwapMonstersMenuAndStep::
Jump_037_4B2A:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags::
Jump_037_4B38:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 5 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wScreenState
RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags_Case05::
Jump_037_4B5B:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $03
    ld [wLinkSendByte], a
    ld hl, wScreenState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wScreenState
RunLinkSession5Exchange_Case01_Sub01_WaitLinkMessage::
Jump_037_4B6A:: ; address name
    ld a, [wLinkMessage]
    cp a, $03
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wLinkSendByte
; points at: wLinkScreenState
RunLinkSession5Exchange_Case01_Sub01_SetScreenState::
Jump_037_4B7A:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wLinkScreenState
    inc [hl]
    ret

; text waits around two strings (ShowStringIndexA_Bank37)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession5Exchange_ShowMessages::
Jump_037_4B8B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession5Exchange_ShowMessages_WaitTextFlags
    dw RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37_Case01
    dw RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37
    dw RunLinkSession5Exchange_ShowMessages_WaitTextFlags_Case03

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_ShowMessages
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowMessages_WaitTextFlags::
Jump_037_4B97:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession5Exchange_ShowMessages
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wScreenStep
; writes: wScreenState, wScreenStep
RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37_Case01::
Jump_037_4BA4:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    or a, a
    jr z, .check_screen_step
    cp a, $02
    ret nz
    ld a, $05
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld a, $15
    call ShowStringIndexA_Bank37
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession5Exchange_ShowMessages
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37::
Jump_037_4BC9:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession5Exchange_ShowMessages
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenState
; writes: wScreenStep, wScreenState
RunLinkSession5Exchange_ShowMessages_WaitTextFlags_Case03::
Jump_037_4BDA:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: BreedMenu list steps, unpacks the partner's record from the link (UnpackLinkRecordToRecordBufB), ComputeBreedingChild and StoreReceivedRecordIntoSRAM
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession5Exchange_LinkBreed::
Jump_037_4BEB:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37
    dw RunLinkSession5Exchange_LinkBreed_WaitLinkMessage
    dw RunLinkSession5Exchange_LinkBreed_WaitTextFlags
    dw RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0C
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0E
    dw RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case0F
    dw RunLinkSession5Exchange_LinkBreed_BreedMenu_Case10
    dw RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5_Case11
    dw RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf
    dw RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case13
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case14
    dw RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToRecordBufB
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case16
    dw RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37
    dw RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox
    dw RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM
    dw RunLinkSession5Exchange_LinkBreed_UpdateTwoChoiceCursor_Bank1D
    dw RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case13
    dw RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case1C
    dw RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild
    dw StoreReceivedRecordIntoSRAM
    dw RunLinkSession5Exchange_LinkBreed_WriteLinkBufferCountLoAndLinkBufferCountHiEtc
    dw RunLinkSession5Exchange_LinkBreed_WriteLinkSendByteAndLinkSceneByte4BEtc
    dw RunLinkSession5Exchange_LinkBreed_WaitLinkMessage_Case21

; entry 14 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage
; writes: wScreenStep, wLinkSendByte, wAIFlag
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0E::
Jump_037_4C33:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FD
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $FD
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ret

; entry 8 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wMenuInputResult
; writes: wScreenStep, wLinkSendByte, wAIFlag
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37::
Jump_037_4C5B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FD
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $FD
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld a, [wMenuInputResult]
    cp a, $FE
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $13
    call ShowStringIndexA_Bank37
    ld a, $FD
    ld [wLinkSendByte], a
    ld a, $00
    ld [wAIFlag], a
    ret

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
RunLinkSession5Exchange_LinkBreed_BreedMenu::
Jump_037_4C9D:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ret

; entry 16 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wTextFlags, wScreenSubStep
RunLinkSession5Exchange_LinkBreed_BreedMenu_Case10::
Jump_037_4CA9:: ; address name
    ld a, [wSelectedRecord]
    cp a, $FF
    jr z, .read_screen_sub_step
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ld a, $09
    call ShowStringIndexA_Bank37
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case00
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case01
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case02
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case03
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case00
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case01
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case02
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case03
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case00
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case09
    dw RunLinkSession5Exchange_Case01_Sub01_Table2_Case03

; entry 0 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunLinkSession5Exchange_Case01_Sub01_Table2_Case00::
Jump_037_4CDB:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $07
    call ShowStringIndexA_Bank37
    ret

; entry 1 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep, wLinkSendByte
RunLinkSession5Exchange_Case01_Sub01_Table2_Case01::
Jump_037_4CF1:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunLinkSession5Exchange_Case01_Sub01_Table2_Case02::
Jump_037_4D03:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wSelectedRecord, wScreenSubStep
RunLinkSession5Exchange_Case01_Sub01_Table2_Case03::
Jump_037_4D1A:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    xor a, a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

; entry 9 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunLinkSession5Exchange_Case01_Sub01_Table2_Case09::
Jump_037_4D2D:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 12 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0C::
Jump_037_4D43:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .call_breed_menu
    ld a, $04
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld de, Tiles1Plus6E0Tiles_1F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5::
Jump_037_4D80:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank37
    ld de, TileRect_37_647D
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C05
    call CopyRectToScreenBufferAndClearAttributes_37
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $86
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    farcall DrawRecordField0EMarkAndField56Digits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wArg1, wArg2, wScreenStep, wSelectedRecord
RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case0F::
Jump_037_4DC2:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz

; runs Func_037_5A5D (C = 5, HL = $0278, DE = $00AC, wD7F1/2 = 0/8), wD781 += 1 and clears wD7B4 (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep, wSelectedRecord
RunFunc5A5DAt0278AndStep::
Func_037_4DC7:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wSelectedRecord], a
    ret

; entry 17 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wArg5, wArg6, hTemp0, wScreenStep, wPartyCount, wListCursor, wListPageIndex
; writes: rRAMG2, rRAMB, wScreenStep, wSelectedRecord, wItemGridX, wItemGridY
; points at: wPartyList
RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5_Case11::
Jump_037_4DE9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, .restore
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $05
    call ShowStringIndexA_Bank37
    ret

.restore:
    pop hl
    ld a, [hl]
    ld c, a
    ld a, [wPartyCount]
    ld b, a
    ld de, wPartyList

.loop:
    ld a, [de]
    cp a, c
    jr z, .check_screen_step
    inc de
    dec b
    jr nz, .loop
    jr .call_set_arg5_to_list_entries_cell5

.check_screen_step:
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $06
    call ShowStringIndexA_Bank37
    ret

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSelectedRecord
; writes: rRAMG2, rRAMB
; points at: sRecords, wRecordBufA
RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf::
Jump_037_4E75:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    call UnpackLinkRecordToWorkBuf
    ld a, $07
    call ShowStringIndexA_Bank37
    call RunFunc5A5DAt0278AndStep
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_37
    ret

; entry 19 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case13::
Jump_037_4EB6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 31 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, wLinkReady, ...
; points at: wWorkBuf
RunLinkSession5Exchange_LinkBreed_WriteLinkBufferCountLoAndLinkBufferCountHiEtc::
Jump_037_4EC8:: ; address name
    ld a, $64
    ld [wLinkBufferCountLo], a
    xor a, a
    ld [wLinkBufferCountHi], a
    ld hl, wWorkBuf
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wWorkBuf
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wLinkSendByte, wAIFlag, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, ...
; points at: wWorkBuf
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case14::
Jump_037_4EF9:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, .check_screen_step
    cp a, $FD
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $FD
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $95
    ld [wLinkBufferCountLo], a
    xor a, a
    ld [wLinkBufferCountHi], a
    ld hl, wWorkBuf
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wBattlerRecordSlot1 + BATTLER_SKILLS + 1
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 21 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkReady, wScreenStep
RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToRecordBufB::
Jump_037_4F49:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkReady], a
    call UnpackLinkRecordToRecordBufB
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wRecordBufA, wRecordBufB, wScreenStep
; writes: wScreenStep, wScreenSubStep, wSelectedRecord, wLinkSendByte, wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, ...
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case16::
Jump_037_4F5E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wRecordBufA + MON_SEX
    ld a, [wRecordBufA + MON_SEX]
    and a, $01
    ld b, a
    ld a, [wRecordBufB + MON_SEX]
    and a, $01
    cp a, b
    jr nz, .clear_link_send_byte
    ld a, $08
    call ShowStringIndexA_Bank37
    ld a, $10
    ld [wScreenStep], a
    ld a, $08
    ld [wScreenSubStep], a
    ld a, $FF
    ld [wSelectedRecord], a
    ret

.clear_link_send_byte:
    xor a, a
    ld [wLinkSendByte], a
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0D01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0E
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $0B
    call ShowStringIndexA_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 29 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wScreenStep
; writes: wArg1, wScreenStep, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, ...
; points at: wWorkBuf
RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild::
Jump_037_4FD5:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_screen_step
    ld a, $02
    ld [wArg1], a
    farcall ComputeBreedingChild

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld b, a

.loop:
    push bc
    call StoreReceivedRecordIntoSRAM
    pop bc
    ld a, [wScreenStep]
    cp a, b
    jr z, .loop
    jp RunLinkSession5Exchange_LinkBreed_WriteLinkBufferCountLoAndLinkBufferCountHiEtc

; entry 23 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTwoChoiceCursor, wScreenStep
RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37::
Jump_037_4FFD:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_37_64D7
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wTwoChoiceCursor, wScreenStep, wScreenState, wListCursor, wListPageIndex
; writes: wScreenStep, wLinkSendByte, wAIFlag, wScreenByteB2, wScreenByteB3, wItemGridX, wItemGridY, wScreenSubStep, ...
RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox::
Jump_037_5041:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .call_handle_three_choice_cursor_input_37
    call RunFunc5A5DAt024FAndDrawBox
    ld a, $21
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_handle_three_choice_cursor_input_37:
    call HandleThreeChoiceCursorInput_37
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    call RunFunc5A5DAt024FAndDrawBox
    ld a, $21
    ld [wScreenStep], a
    ld a, $13
    call ShowStringIndexA_Bank37
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $00
    ld [wAIFlag], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr z, .loop
    cp a, $01
    jr z, .read_screen_state
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox_Data
    call StoreBAtWordTableEntry_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $0C
    call ShowStringIndexA_Bank37
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $0D
    ld [wScreenState], a
    ret

; entry 25 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM::
Jump_037_50D9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles2 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wTwoChoiceCursor], a
    ld de, TileRect_37_64B9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep
RunLinkSession5Exchange_LinkBreed_UpdateTwoChoiceCursor_Bank1D::
Jump_037_5136:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    ld a, $0B
    call ShowStringIndexA_Bank37
    ld a, $17
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $07
    call ShowStringIndexA_Bank37
    ret

; when text is idle and not linking: copies the $A5-byte received record at wCAD0 into the record slot at WD789 cell 5 and resets the save counters (E-0128)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild)
; reads: wTextFlags, wScreenSubStep, wScreenStep, wLinkRole, wItemGridX, wItemGridY, wArg5, wArg6, ...
; writes: wScreenSubStep, wScreenStep, wListCursor, wListPageIndex, wArg1, wArg2, rRAMG2, rRAMB, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
StoreReceivedRecordIntoSRAM::
Func_037_5172:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr z, .check_link_role
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .read_item_grid_x
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.read_item_grid_x:
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wChildRecord
    ld b, $A5

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall SetBitInFieldAtArg3
    ld hl, wPackWork
    ld b, $07

.loop2:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop2
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 28 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep, wLinkRole
; writes: wScreenStep, wLinkSendByte, wAIFlag, wArg1, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, ...
; points at: wWorkBuf
RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case1C::
Jump_037_5216:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, .check_screen_step
    cp a, $FE
    ret nz
    ld a, $21
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild

; entry 9 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep, wTextFlags, wScreenSubStep
; writes: wScreenStep, wScreenSubStep
RunLinkSession5Exchange_LinkBreed_WaitLinkMessage::
Jump_037_523F:: ; address name
    ld a, [wLinkMessage]
    cp a, $FD
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jr RunLinkSession5Exchange_LinkBreed_WaitTextFlags

; entry 33 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wTextFlags, wScreenStep, wScreenSubStep
; writes: wLinkSendByte, wScreenStep, wScreenSubStep
RunLinkSession5Exchange_LinkBreed_WaitLinkMessage_Case21::
Jump_037_524E:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $0A
    ld [wScreenStep], a
    jr RunLinkSession5Exchange_LinkBreed_WaitTextFlags

; entry 10 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep, wScreenSubStep
; writes: wScreenStep, wScreenSubStep
RunLinkSession5Exchange_LinkBreed_WaitTextFlags::
Jump_037_525F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a

; waits for the text, then for the partner's link message
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner::
Jump_037_526F:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitTextFlags
    dw RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitLinkMessage

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep, wLinkRole, wAIFlag
; writes: wScreenSubStep, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wWorkBuf
RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitTextFlags::
Jump_037_5277:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld b, $64
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_link_buffer_count_lo
    ld b, $48
    ld a, [wAIFlag]
    or a, a
    jr z, .set_link_buffer_count_lo
    ld b, $45

.set_link_buffer_count_lo:
    ld a, b
    ld [wLinkBufferCountLo], a
    xor a, a
    ld [wLinkBufferCountHi], a
    ld hl, wWorkBuf
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wWorkBuf
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkReady, wGameMode, wModeState, wModeChangeRequest, wLinkSendByte
; points at: wScreenState
RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitLinkMessage::
Jump_037_52BF:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkReady], a
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 32 of the `rst $00` table in RunLinkSession5Exchange_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkSceneByte4B, wLinkByteEB
RunLinkSession5Exchange_LinkBreed_WriteLinkSendByteAndLinkSceneByte4BEtc::
Jump_037_52EA:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    jr z, .clear_link_send_byte
    ret

.clear_link_send_byte:
    xor a, a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkSceneByte4B], a
    ld a, $01
    ld [wLinkByteEB], a
    ret

; entry 12 of the `rst $00` table in Func_037_4AFD
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
RunLinkSession5Exchange_Case01_Sub01_SwapMonstersMenu::
Jump_037_5301:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $05
    ld [wScreenState], a
    ret

; as RunScreenStateWhenNotFading_F1_ShowChosenRecord
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession5Exchange_ShowChosenRecord::
Jump_037_531D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession5Exchange_ShowChosenRecord_AdvanceScreenStep
    dw ShowString0EAndStep_Bank37
    dw RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu
    dw RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu
    dw RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu
    dw RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ShowChosenRecord_FillTilesFromRequest
    dw RunLinkSession5Exchange_ShowChosenRecord_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu
    dw RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu

; entry 2 of the `rst $00` table in RunLinkSession5Exchange_ShowChosenRecord
; no direct call (reached through a table, a jump or a vector)
RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu::
Jump_037_5335:: ; address name
    farcall BreedMenu
    ret

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_ShowChosenRecord
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowChosenRecord_AdvanceScreenStep::
Jump_037_533C:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ShowString0EBank0EAtTiles2700AndLoadTiles, then wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_ShowRecordStats_DrawRects5E13And66DF)
; reads: wScreenStep
; writes: wScreenStep
ShowString0EAndStep_Bank37::
Func_037_5344:: ; address name
    farcall ShowString0EBank0EAtTiles2700AndLoadTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in RunLinkSession5Exchange_ShowChosenRecord
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wScreenStep
RunLinkSession5Exchange_ShowChosenRecord_FillTilesFromRequest::
Jump_037_5352:: ; address name
    ld hl, vTiles1 + $270
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $780
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession5Exchange_ShowChosenRecord
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
RunLinkSession5Exchange_ShowChosenRecord_SetArg5ToListEntriesCell5::
Jump_037_539F:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; by wScreenStep: the stats screens of record buffer B, as RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession5Exchange_ShowRecordStats::
Jump_037_53C0:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession5Exchange_ShowRecordStats_ToClearBGMapAndLoadFrameTilesAndStep
    dw RunLinkSession5Exchange_ShowRecordStats_ShowString10Bank0EAtTiles2020ThenDefault
    dw RunLinkSession5Exchange_ShowRecordStats_AdvanceScreenStep
    dw RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37
    dw RunLinkSession5Exchange_ShowRecordStats_ToDrawRecordBufBStatsScreenAndStep
    dw RunLinkSession5Exchange_ShowRecordStats_ToDrawWCA36MonsterPictureInTwoSteps
    dw RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor
    dw RunLinkSession5Exchange_ShowRecordStats_FillTileRectWithArg1Tile
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_Return
    dw RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest
    dw RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest_Case0F
    dw RunLinkSession5Exchange_ShowRecordStats_DrawWCA2CNameAndWCA36String_Bank37
    dw RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case11
    dw RunLinkSession5Exchange_ShowRecordStats_ShowPersonalityNameAndWCA3AName
    dw RunLinkSession5Exchange_ShowRecordStats_DrawFamilyIconAndCountForWCA38
    dw RunLinkSession5Exchange_ShowRecordStats_DecompressGraphicsArg1ToArg4
    dw RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case15
    dw RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81
    dw RunLinkSession5Exchange_ShowRecordStats_ToDrawRects6B4FAnd6C27AndStep
    dw RunLinkSession5Exchange_ShowRecordStats_ClearTilesAndDrawRects6C5FAnd6D37
    dw RunLinkSession5Exchange_ShowRecordStats_ShowRecordBufBSkillNamesOrNone
    dw RunLinkSession5Exchange_ShowRecordStats_ShowSpeciesCategory13StringAtTiles2680
    dw RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case1B
    dw RunLinkSession5Exchange_ShowRecordStats_DrawRects5E13And66DF
    dw RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D
    dw RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case1E
    dw RunLinkSession5Exchange_ShowRecordStats_RunF24C3DAnd4D72
    dw RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case20

; entry 8 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
RunLinkSession5Exchange_ShowRecordStats_Return::
Jump_037_5406:: ; address name
    ret

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ToClearBGMapAndLoadFrameTilesAndStep::
Jump_037_5407:: ; address name
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ShowString10Bank0EAtTiles2020ThenDefault::
Jump_037_5415:: ; address name
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    farcall LoadSixteenGlyphTilesFromTable73BC
    call DrawWCA2CNameAtTiles1500

; entry 2 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_AdvanceScreenStep::
Jump_037_5424:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears 5 tiles at vTiles1 + $500 and draws the name at wCA2C there (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_ShowRecordStats_ShowString10Bank0EAtTiles2020ThenDefault)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
DrawWCA2CNameAtTiles1500::
Func_037_542C:: ; address name
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, wRecordBufB + MON_NAME
    call CopyF0NameToNameGlyphBuf
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ret

; entry 3 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37::
Jump_037_5452:: ; address name
    call BGMapAddressAtScroll_Bank37
    ld de, TileRect_1F_687F
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ToDrawRecordBufBStatsScreenAndStep::
Jump_037_5471:: ; address name
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
RunLinkSession5Exchange_ShowRecordStats_ToDrawWCA36MonsterPictureInTwoSteps::
Jump_037_547F:: ; address name
    farcall DrawWCA36MonsterPictureInTwoSteps
    ret

; entry 6 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor::
Jump_037_5486:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .call_bg_map_address_at_scroll_bank37
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank37:
    call BGMapAddressAtScroll_Bank37
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, $0E
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenStep, ...
RunLinkSession5Exchange_ShowRecordStats_FillTileRectWithArg1Tile::
Jump_037_54D1:: ; address name
    call BGMapAddressAtScroll_Bank37
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BGFillTile
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 14 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest::
Jump_037_550A:: ; address name
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0F02
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest_Case0F::
Jump_037_552B:: ; address name
    ld hl, vTiles1 + $270
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $780
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawWCA2CNameAndWCA36String_Bank37::
Jump_037_5565:: ; address name
    call DrawWCA2CNameAndWCA36String_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case11::
Jump_037_5570:: ; address name
    call BGMapAddressAtScroll_Bank37
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_6577
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wRecordBufB
; writes: wScreenStep, wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, wArg7
RunLinkSession5Exchange_ShowRecordStats_ShowPersonalityNameAndWCA3AName::
Jump_037_5593:: ; address name
    farcall ShowPersonalityNameAndWCA3AName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 19 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wRecordBufB
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep, wArg5, hSpriteHideTile, wArg7
RunLinkSession5Exchange_ShowRecordStats_DrawFamilyIconAndCountForWCA38::
Jump_037_55A0:: ; address name
    ld a, $6D
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld a, $EA
    ld [wArg3], a
    ld a, $C7
    ld [wArg4], a
    farcall DrawFamilyIconAndCountForWCA38
    farcall DrawWCA83ExpAndToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 20 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, wArg7, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DecompressGraphicsArg1ToArg4::
Jump_037_55C6:: ; address name
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $F0
    ldh [hSpriteHideTile], a
    farcall ShowWCACFCategory11StringAtTiles2320
    call BGMapAddressAtScroll_Bank37
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_66DF
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 21 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, hSpriteHideTile, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case15::
Jump_037_5611:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .clear_sprite_hide_tile2
    cp a, $FF
    jr z, .clear_sprite_hide_tile
    ret

.clear_sprite_hide_tile:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a, a
    ldh [hSpriteHideTile], a
    farcall DrawRects662BAnd653F
    ld a, $04
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81::
Jump_037_564E:: ; address name
    farcall DrawLevelAndStatusRowForWCA81
    ld a, $0F
    ld [wScreenStep], a
    ret

; entry 23 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ToDrawRects6B4FAnd6C27AndStep::
Jump_037_565A:: ; address name
    farcall DrawRects6B4FAnd6C27
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ClearTilesAndDrawRects6C5FAnd6D37::
Jump_037_5668:: ; address name
    farcall ClearTilesAndDrawRects6C5FAnd6D37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ShowRecordBufBSkillNamesOrNone::
Jump_037_5676:: ; address name
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 26 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession5Exchange_ShowRecordStats_ShowSpeciesCategory13StringAtTiles2680::
Jump_037_5683:: ; address name
    farcall ShowSpeciesCategory13StringAtTiles2680
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case1B::
Jump_037_5691:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .set_text_window_tile_lo
    cp a, $FF
    jr z, .skip
    ret

.set_text_window_tile_lo:
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld hl, vTiles2 + $730
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call UploadTilesFromData58AE
    farcall DrawSummaryFrames6E47And6D6F
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    ret

; entry 28 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
RunLinkSession5Exchange_ShowRecordStats_DrawRects5E13And66DF::
Jump_037_56F3:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .call_show_string10_bank0_e_at_tiles2020_then
    farcall DrawRects5E13And66DF
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_string10_bank0_e_at_tiles2020_then:
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    call ShowString0EAndStep_Bank37
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 29 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D::
Jump_037_5715:: ; address name
    farcall DrawLevelAndStatusRowForWCA81
    ld hl, vTiles1 + $270
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call DrawWCA2CNameAndWCA36String_Bank37
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $11
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case1E::
Jump_037_5760:: ; address name
    call BGMapAddressAtScroll_Bank37
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_63D7
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    farcall DecompressRecordBufBSpeciesGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hSpriteHideTile, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_RunF24C3DAnd4D72::
Jump_037_5789:: ; address name
    farcall RunF24C3DAnd4D72
    ld a, $F0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in RunLinkSession5Exchange_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult
; writes: wJoypadPressedRepeat, wMenuInputResult, hSpriteHideTile, wScreenStep
RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case20::
Jump_037_579B:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    jr z, .return
    cp a, $FE
    jr z, .clear_sprite_hide_tile
    cp a, $FF
    jr z, .clear_sprite_hide_tile2

.return:
    ret

.clear_sprite_hide_tile:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; as RunScreenStateWhenNotFading_F1_ResetListAndShowString
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession5Exchange_ResetListAndShowString::
Jump_037_57D0:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession5Exchange_ResetListAndShowString_SetListCursor
    dw ShowString0EAndStep_Bank37
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ShowChosenRecord_FillTilesFromRequest
    dw RunLinkSession5Exchange_ShowChosenRecord_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ResetListAndShowString_Case08
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu_Case09

; entry 0 of the `rst $00` table in RunLinkSession5Exchange_ResetListAndShowString
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wItemGridY, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
RunLinkSession5Exchange_ResetListAndShowString_SetListCursor::
Jump_037_57E8:: ; address name
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in RunLinkSession5Exchange_ResetListAndShowString
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunLinkSession5Exchange_ResetListAndShowString_BreedMenu_Case09::
Jump_037_57FC:: ; address name
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

; entry 2 of the `rst $00` table in RunLinkSession5Exchange_ResetListAndShowString
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunLinkSession5Exchange_ResetListAndShowString_BreedMenu::
Jump_037_580D:: ; address name
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

; entry 8 of the `rst $00` table in RunLinkSession5Exchange_ResetListAndShowString
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunLinkSession5Exchange_ResetListAndShowString_Case08::
Jump_037_5821:: ; address name
    ld de, TileRect_37_64D7
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectToScreenBufferAndClearAttributes_37
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0D01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0E
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; wD7F1/2 = the species wCA36/7, wD7F3-6 = $00, $90, $40, $00, then far-calls DrawMetaSpritePartC0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
DrawWCA36SpritePart:: ; heuristic: follows a terminator; C0
Func_037_5870:: ; address name
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    farcall DrawMetaSpritePartC0
    ret

; copies tiles from Data_037_58AE: two to vTiles2 + $6E0 and three to vTiles2 + $7C0 (CopyTileBytesToVRAM_Bank37) (E-0118)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case1B)
UploadTilesFromData58AE::
Func_037_5895:: ; address name
    ld hl, Tiles_37_58AE
    ld de, vTiles2 + $6E0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ld de, vTiles2 + $7C0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ret

; E-0238 (derived: HL = $58AE and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_37_58AE::
Data_037_58AE:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $FF ; entry 0
    db $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 1
    db $FF, $FF, $FF, $FF, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 2
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $FF, $FF, $FF ; entry 3
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 4

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
; 5 call sites from 1 routine (e.g. UploadTilesFromData58AE)
; reads: rSTAT
CopyTileBytesToVRAM_Bank37::
Func_037_58FE:: ; address name
    xor a, a

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, .loop
    ret

; copies up to 10 bytes from HL to wC8CF, stopping at $F0, and appends $F0 (E-0124)
; 2 call sites from 2 routines (e.g. DrawWCA2CNameAndWCA36String_Bank37, DrawWCA2CNameAtTiles1500)
; points at: wNameGlyphBuf
CopyF0NameToNameGlyphBuf::
Func_037_5912:: ; address name
    ld de, wNameGlyphBuf
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

; draws the name at wCA2C at vTiles1 + $780 and shows string [wCA36] of category [wCA37] + 2 at vTiles1 + $270 with size $0109 (E-0124)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D, RunLinkSession5Exchange_ShowRecordStats_DrawWCA2CNameAndWCA36String_Bank37)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
DrawWCA2CNameAndWCA36String_Bank37::
Func_037_5929:: ; address name
    ld hl, wRecordBufB + MON_NAME
    call CopyF0NameToNameGlyphBuf
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wRecordBufB + MON_SPECIES
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld hl, vTiles1 + $270
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ret

; wD7F5/wD7F6 = HL (destination), wD7F1/wD7F2 = DE (source), then far-calls DrawTileRectFromArg1Params (width and rows already in wD7F3/wD7F4) (E-0093) (the same 23 bytes appear in 4 banks)
; 5 call sites from 5 routines (e.g. RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case1E, RunLinkSession5Exchange_ShowRecordStats_DecompressGraphicsArg1ToArg4, RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case11, RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor, ...)
; writes: wArg5, wArg6, wArg1, wArg2
DrawTileRectAtHLFromDE_Bank37::
Func_037_595F:: ; address name
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawTileRectFromArg1Params
    ret

; runs Func_037_5A5D (C = 7, HL = $024F, DE = $0083, wD7F1/2 = 0/9), then draws the box at scroll + $1CC (E-0122)
; 2 call sites from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox)
; writes: wArg1, wArg2
RunFunc5A5DAt024FAndDrawBox::
Func_037_5976:: ; address name
    ld b, $00
    ld c, $07
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_37
    call BGMapAddressAtScroll_Bank37
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_37
    ret

; wStringIndex = A (wStringCategory unchanged), then far-calls BeginStringDisplay_Bank0E (E-0066)
; 22 call sites from 16 routines (e.g. RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37, RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37_Case01, RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case1C, RunLinkSession5Exchange_LinkBreed_UpdateTwoChoiceCursor_Bank1D, ...)
; writes: wStringIndex
ShowStringIndexA_Bank37::
Func_037_5999:: ; address name
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0E
    ret

; up/down moves wTwoChoiceCursor over three entries (wMenuInputResult = $FD), A and B select or cancel; otherwise blinks the cursor (E-0127)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
HandleThreeChoiceCursorInput_37::
Func_037_59A3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank37
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank372
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_draw_arrow_tile_bc_at_two_choice_entry
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkCursorScreenCounter_Bank37
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank37:
    call DrawBlankTileC3_Bank37
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .set_two_choice_cursor
    ld a, $02
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor:
    dec a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.call_draw_blank_tile_c3_bank372:
    call DrawBlankTileC3_Bank37
    ld a, [wTwoChoiceCursor]
    cp a, $02
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
    call DrawCursorTileBB_Bank37
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_two_choice_entry:
    call DrawArrowTileBCAtTwoChoiceEntry_Bank37
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wD783 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_37)
; reads: wJoypadRepeatTimer, wScreenCounter, wTwoChoiceCursor
; writes: wScreenCounter
BlinkCursorScreenCounter_Bank37::
Func_037_5A11:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_Bank37
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    jr c, DrawCursorTileBB_Bank37
    cp a, $18
    jr c, DrawBlankTileC3_Bank37
    xor a, a
    ld [wScreenCounter], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_37)
; reads: wTwoChoiceCursor
DrawCursorTileBB_Bank37::
Func_037_5A2B:: ; address name
    ld b, $BB
    jr DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleThreeChoiceCursorInput_37)
; reads: wTwoChoiceCursor
DrawBlankTileC3_Bank37::
Func_037_5A2F:: ; address name
    ld b, $C3
    jr DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor

; B = $BC, then writes B at the scroll position + Data_037_5A57[wTwoChoiceCursor] (E-0124)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_37)
; reads: wTwoChoiceCursor
DrawArrowTileBCAtTwoChoiceEntry_Bank37::
Func_037_5A33:: ; address name
    ld b, $BC

DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor::
Jump_037_5A35:: ; address name
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, DrawArrowTileBCAtTwoChoiceEntry_Bank37_Data
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank37
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawArrowTileBCAtTwoChoiceEntry_Bank37
DrawArrowTileBCAtTwoChoiceEntry_Bank37_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_037_5A57:: ; address name
    db $EC, $00, $2C, $01, $6C, $01

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL for rows B to C, with CGB attributes (E-0128)
; 2 call sites from 2 routines (e.g. RunFunc5A5DAt024FAndDrawBox, RunFunc5A5DAt0278AndStep)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_37::
Func_037_5A5D:: ; address name
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
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank37
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, .restore
    push hl
    push de
    ld de, wScreenAttrBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank37
    pop de
    pop hl

.restore:
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp a, c
    jr c, CopyScreenBufferRectWithAttrs_37
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_37)
CopyBytesDEToHL_Bank37::
Func_037_5AB7:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank37
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_37)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank37::
Func_037_5AC0:: ; address name
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $00
    ldh [rSVBK], a
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWorkBuf (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank37::
Func_037_5AD3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows in WRAM bank 2 (E-0127)
; 4 call sites from 4 routines (e.g. RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM, RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37, RunLinkSession5Exchange_ResetListAndShowString_Case08, RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5)
; reads: wIsCGB
; writes: rSVBK
CopyRectToScreenBufferAndClearAttributes_37::
Func_037_5AFA:: ; address name
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop
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

.loop3:
    push hl
    push bc

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wC554 = HL + $1C1, and on CGB copies its attributes (E-0127)
; 4 call sites from 4 routines (e.g. RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM, RunFunc5A5DAt024FAndDrawBox, RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37, RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRectToBGMap_37::
Func_037_5B3F:: ; address name
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
    call CopyRectFromBankToBGMapWrapped
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
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 11 call sites from 11 routines (e.g. RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM, RunFunc5A5DAt024FAndDrawBox, DrawArrowTileBCAtTwoChoiceEntry_Bank37, RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37, ...)
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
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox)
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

; unpacks the received partner record at wC986 into wD09D: names, species, family, parents, skills and scaled stats (E-0129)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf)
; reads: wLinkRules
; writes: wLinkRules
; points at: wWorkBuf, wRecordBufA
UnpackLinkRecordToWorkBuf::
Func_037_5BC6:: ; address name
    ld hl, wWorkBuf
    ld de, wRecordBufA
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertNameBytesFromLinkFormat
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call FamilyNibbleOrSpeciesFamily
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    dec de
    and a, c
    ld [wLinkRules], a
    cp a, $FF
    jr nz, .call_append_species_to_link_code_byte_for
    call WriteFFPairAndUnknownName
    jr .call_map_and_compact_skill_list_link_skill

.call_append_species_to_link_code_byte_for:
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl+], a
    inc de

.call_map_and_compact_skill_list_link_skill:
    call MapAndCompactSkillListLinkSkillMapTable_A
    ld b, $12
    call CopyBBytesHLToDE_Bank37
    call ScaleStatWordsToLinkFormat
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
    call CopyBBytesHLToDE_Bank37
    ld a, $00
    ld [hl+], a
    inc de
    ld a, [wLinkRules]
    cp a, $FF
    jr nz, .call_convert_name_bytes_from_link_format
    call WriteUnknownNameEntry_5CC8
    jr .call_load_table555_d_entry_for_wd0_a6_to_link

.call_convert_name_bytes_from_link_format:
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl], a

.call_load_table555_d_entry_for_wd0_a6_to_link:
    farcall LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes
    ret

; unpacks the received record at wD132 into wCA2B: names, species ids from Data_037_5FC7, family, parents, skills and scaled stats (E-0127)
; 1 call site from 1 routine (e.g. RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToRecordBufB)
; writes: wSpeciesIdLo, wSpeciesIdHi, wLinkRules
; points at: wRecordBufB
UnpackLinkRecordToRecordBufB::
Func_037_5C4E:: ; address name
    ld hl, wRecordBufB
    ld de, wBattlerRecordSlot1 + BATTLER_SKILLS + 1
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertEightBytesAndPadF0
    call AppendLinkCodeToSpeciesWordForByteAtDE
    ld a, c
    ld [wSpeciesIdLo], a
    ld a, b
    ld [wSpeciesIdHi], a
    call StoreSpeciesFamilyAtHL
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [wLinkRules], a
    cp a, $FF
    jr nz, .call_append_link_code_to_species_word_for
    call WriteFFQuadAndBlankName
    jr .call_map_and_compact_skill_list_link_skill

.call_append_link_code_to_species_word_for:
    call AppendLinkCodeToSpeciesWordForByteAtDE
    call AppendLinkCodeToSpeciesWordForByteAtDE
    call CallFunc4001InBank81KeepRegs
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hl+], a
    inc de

.call_map_and_compact_skill_list_link_skill:
    call MapAndCompactSkillListLinkSkillMapTable_B
    ld b, $12
    call CopyBBytesHLToDE_Bank37
    call ScaleStatWordsForDisplay_5F4A
    ld b, $06
    call CopyBBytesHLToDE_Bank37
    call Copy26BytesThenWD034
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hl+], a
    inc de
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hl+], a
    ld [hl], $00
    farcall LoadTable4E60EntryForWCA36ToWCA83
    ret

; DE += 4, writes two $FF bytes and falls into the '???' name entry (E-0126)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
WriteFFPairAndUnknownName::
Func_037_5CBC:: ; address name
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a

; calls WriteUnknownNamePlaceholder_Bank37 and falls into it again (E-0126)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
WriteUnknownNameEntry_5CC8::
Func_037_5CC8:: ; address name
    call WriteUnknownNamePlaceholder_Bank37

; DE += $0B; writes '???' ($98 x 3), five $F0 bytes and a 0 at HL (E-0120)
; 1 call site from 1 routine (e.g. WriteUnknownNameEntry_5CC8)
WriteUnknownNamePlaceholder_Bank37::
Func_037_5CCB:: ; address name
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

; DE += 2, writes four $FF bytes, then WriteBlankName10_Bank37 (and falls into it) (E-0126)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
WriteFFQuadAndBlankName::
Func_037_5CE6:: ; address name
    inc de
    inc de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call WriteBlankName10_Bank37

; DE += 9; writes ten $F0 (blank) bytes and a terminating 0 at HL (E-0121)
; 1 call site from 1 routine (e.g. WriteFFQuadAndBlankName)
WriteBlankName10_Bank37::
Func_037_5CF1:: ; address name
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

; copies B bytes from HL to DE; HL and DE advance, B = 0 (E-0115)
; 5 call sites from 3 routines (e.g. UnpackLinkRecordToRecordBufB, Copy26BytesThenWD034, UnpackLinkRecordToWorkBuf)
CopyBBytesHLToDE_Bank37::
Func_037_5D08:: ; address name
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, CopyBBytesHLToDE_Bank37
    ret

; only called from ConvertEightBytesAndPadF0 (E-0047)
; 1 call site from 1 routine (e.g. ConvertEightBytesAndPadF0)
ConvertEightBytesAndPadF0_Sub01::
Func_037_5D0F:: ; address name
    cp a, $5C
    jr z, .skip
    cp a, $5E
    jr z, .skip2
    cp a, $5F
    jr z, .skip3
    cp a, $60
    jr z, .skip4
    cp a, $61
    jr z, .skip5
    cp a, $63
    jr z, .skip6
    cp a, $64
    jr z, .return_98
    cp a, $0E
    jr nc, .cp_58
    cp a, $0A
    jr c, .cp_58
    sub a, $0A
    jr .return

.cp_58:
    cp a, $58
    jr nc, .return
    cp a, $24
    jr c, .return
    sub a, $1A
    jr .return

.skip:
    ld a, $95
    jr .return

.skip2:
    ld a, $AB
    jr .return

.skip3:
    ld a, $B5
    jr .return

.skip4:
    ld a, $94
    jr .return

.skip5:
    ld a, $93
    jr .return

.skip6:
    ld a, $99
    jr .return

.return_98:
    ld a, $98

.return:
    ret

; converts 8 name bytes at DE to the game's glyphs ($0A-$3D + $1A, special marks $93-$95, $AB, $B5), padding after the fourth with $F0 (E-0127)
; 6 call sites from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
ConvertNameBytesFromLinkFormat::
Func_037_5D5E:: ; address name
    ld c, $00
    ld b, $08

.loop:
    ld a, [de]
    cp a, $95
    jr z, .skip
    cp a, $AB
    jr z, .skip2
    cp a, $B5
    jr z, .skip3
    cp a, $94
    jr z, .skip4
    cp a, $93
    jr z, .skip5
    cp a, $0A
    jr c, .next
    cp a, $3E
    jr nc, .next
    add a, $1A
    jr .next

.skip:
    ld a, $5C
    jr .next

.skip2:
    ld a, $5E
    jr .next

.skip3:
    ld a, $5F
    jr .next

.skip4:
    ld a, $60
    jr .next

.skip5:
    ld a, $61

.next:
    inc c
    bit 2, c
    jr z, .skip6
    bit 0, c
    jr z, .skip6
    dec c
    ld a, $F0

.skip6:
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    inc de
    inc de
    ret

; reads a word index at DE (DE += 2) and appends the byte at $6175 + index to [HL+] (E-0121)
; 3 call sites from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
AppendSpeciesToLinkCodeByteForWordAtDE::
Func_037_5DA9:: ; address name
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

; A = [DE] & $0F (DE += 1); for 9 looks up the species at Data_037_5FC7[[HL - 1]] and uses its family; 10 becomes 9; stores it at [HL+] (E-0124)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
FamilyNibbleOrSpeciesFamily::
Func_037_5DBC:: ; address name
    ld a, [de]
    and a, $0F
    inc de
    cp a, $09
    jr nz, .cp_0A
    push hl
    dec hl
    ld a, [hl]
    ld hl, LinkCodeToSpeciesTable
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesFamily
    pop de
    pop hl
    ld a, [wSpeciesRecord]

.cp_0A:
    cp a, $0A
    jr nz, .done
    ld a, $09

.done:
    ld [hl+], a
    ret

; maps $21 bytes through Data_037_63D3 and compacts the 8- and $19-entry lists, dropping $FE/$FF entries (E-0127)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
MapAndCompactSkillListLinkSkillMapTable_A::
Func_037_5DEB:: ; address name
    ld b, $21
    push hl

.loop:
    ld a, [de]
    inc de
    cp a, $FF
    jr z, .skip
    push hl
    ld hl, LinkSkillMapTable_A
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip:
    ld [hl+], a
    dec b
    jr nz, .loop
    pop hl
    push de
    push hl
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2
    ld b, $21
    ld a, $FF

.loop2:
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld b, $08
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop3:
    ld a, [hl+]
    cp a, $FE
    jr nc, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop3
    ld b, $19
    ld de, wBattlerRecordSlot5 + BATTLER_EXP

.loop4:
    ld a, [hl+]
    cp a, $FE
    jr nc, .next2
    ld [de], a
    inc de

.next2:
    dec b
    jr nz, .loop4
    pop hl
    ld b, $21
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop5:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop5
    pop de
    ret

; converts three stat words at DE: 999 becomes $01FF/$00FF, otherwise word * $33 or $19 / 100 rounded up; stores them at HL (E-0129)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
ScaleStatWordsToLinkFormat::
Func_037_5E3E:: ; address name
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call CompareHLToBC
    jr nz, .call_multiply8_by16
    ld bc, $01FF
    jr .restore

.call_multiply8_by16:
    push de
    ld a, $33
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, .skip
    inc hl

.skip:
    ld b, h
    ld c, l
    pop de

.restore:
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
    jr nz, .call_multiply8_by162
    ld bc, $00FF
    jr .restore2

.call_multiply8_by162:
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, .skip2
    inc hl

.skip2:
    ld b, h
    ld c, l
    pop de

.restore2:
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
    jr nz, .call_multiply8_by163
    ld bc, $00FF
    jr .restore3

.call_multiply8_by163:
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, .skip3
    inc hl

.skip3:
    ld b, h
    ld c, l
    pop de

.restore3:
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

; converts 8 bytes from DE through Func_037_5D0F into HL, then appends two $F0 bytes (E-0122)
; 6 call sites from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
ConvertEightBytesAndPadF0::
Func_037_5EC0:: ; address name
    ld b, $08

.loop:
    ld a, [de]
    call ConvertEightBytesAndPadF0_Sub01
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ret

; reads a byte index at DE (DE += 1) and appends the word at $5FC7 + 2 * index to [HL]; HL ends after the word, C = low byte (E-0121)
; 3 call sites from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
AppendLinkCodeToSpeciesWordForByteAtDE::
Func_037_5ED0:: ; address name
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

; LoadSpeciesRecord (id already in wSpeciesIdLo/Hi), then stores its family at HL; HL += 1, DE += 1 (E-0118)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
; reads: wSpeciesRecord
StoreSpeciesFamilyAtHL::
Func_037_5EE7:: ; address name
    push hl
    push de
    farcall LoadSpeciesRecord
    pop de
    pop hl
    ld a, [wSpeciesRecord]
    ld [hl+], a
    inc de
    ret

; maps $21 bytes through Data_037_62F5 and compacts the 8- and $19-entry lists, dropping $FF entries (E-0127)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
MapAndCompactSkillListLinkSkillMapTable_B::
Func_037_5EF7:: ; address name
    ld b, $21
    push hl

.loop:
    ld a, [de]
    inc de
    cp a, $FF
    jr z, .skip
    push hl
    ld hl, LinkSkillMapTable_B
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip:
    ld [hl+], a
    dec b
    jr nz, .loop
    pop hl
    push de
    push hl
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2
    ld b, $21
    ld a, $FF

.loop2:
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld b, $08
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop3:
    ld a, [hl+]
    cp a, $FF
    jr z, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop3
    ld b, $19
    ld de, wBattlerRecordSlot5 + BATTLER_EXP

.loop4:
    ld a, [hl+]
    cp a, $FF
    jr z, .next2
    ld [de], a
    inc de

.next2:
    dec b
    jr nz, .loop4
    pop hl
    ld b, $21
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop5:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop5
    pop de
    ret

; reads a word at DE: $01FF becomes 999, otherwise word * $C3 / 100 rounded up; stores it at HL and continues with the next word (ScaleStatWordsForDisplay_5F78) (E-0125)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
ScaleStatWordsForDisplay_5F4A::
Func_037_5F4A:: ; address name
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $01FF
    call CompareHLToBC
    jr nz, .call_multiply8_by16
    ld bc, $03E7
    jr .restore

.call_multiply8_by16:
    push de
    ld a, $C3
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, .skip
    inc hl

.skip:
    ld b, h
    ld c, l
    pop de

.restore:
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    call ScaleStatWordsForDisplay_5F78

; reads a word at DE: $00FF becomes 999, otherwise word * $5B / 100 rounded up plus 3 * word; stores it at HL (E-0125)
; 1 call site from 1 routine (e.g. ScaleStatWordsForDisplay_5F4A)
ScaleStatWordsForDisplay_5F78::
Func_037_5F78:: ; address name
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $00FF
    call CompareHLToBC
    jr nz, .skip
    ld bc, $03E7
    jr .restore

.skip:
    push de
    push bc
    ld a, $5B
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a, a
    jr z, .skip2
    inc hl

.skip2:
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

.restore:
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

; copies $1A bytes (CopyBBytesHLToDE_Bank37), then appends wD034 as the 27th byte (E-0115)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
; reads: wSpeciesRecord
Copy26BytesThenWD034::
Func_037_5FAD:: ; address name
    ld b, $1A
    call CopyBBytesHLToDE_Bank37
    ld a, [wSpeciesRecord + SPECIES_RESISTANCES + 26]
    ld [hl+], a
    inc de
    ret

; far-calls Func_081_4001, preserving all registers (E-0122)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
CallFunc4001InBank81KeepRegs::
Func_037_5FB8:: ; address name
    push af
    push bc
    push de
    push hl
    farcall CallFunc4001InBank81KeepRegs_WriteAIWeightsAndSpeciesIdLoEtc
    pop hl
    pop de
    pop bc
    pop af
    ret

; E-0217 (C1: FamilyNibbleOrSpeciesFamily reads the word at $5FC7 + 2 * code to look up a species' family while UnpackLinkRecordToWorkBuf unpacks a record; for all 215 codes, SpeciesToLinkCodeTable[species] gives the code back (C2 for the pairing)).
; record: species for this link code
LinkCodeToSpeciesTable::
Data_037_5FC7:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0002 ; id 1 SpotSlime
    dw $0003 ; id 2 WingSlime
    dw $0004 ; id 3 TreeSlime
    dw $0005 ; id 4 Snaily
    dw $0006 ; id 5 SlimeNite
    dw $0007 ; id 6 Babble
    dw $0008 ; id 7 BoxSlime
    dw $000A ; id 8 Slime
    dw $000B ; id 9 Healer
    dw $000C ; id 10 FangSlime
    dw $000D ; id 11 RockSlime
    dw $000E ; id 12 SlimeBorg
    dw $000F ; id 13 Slabbit
    dw $0013 ; id 14 SpotKing
    dw $0010 ; id 15 KingSlime
    dw $0011 ; id 16 Metaly
    dw $0012 ; id 17 Metabble
    dw $0017 ; id 18 MetalKing
    dw $0018 ; id 19 GoldSlime
    dw $0024 ; id 20 DragonKid
    dw $0025 ; id 21 Tortragon
    dw $0026 ; id 22 Pteranod
    dw $0027 ; id 23 Gasgon
    dw $0028 ; id 24 FairyDrak
    dw $0029 ; id 25 LizardMan
    dw $002A ; id 26 Poisongon
    dw $002B ; id 27 Swordgon
    dw $002D ; id 28 Dragon
    dw $002E ; id 29 MiniDrak
    dw $002F ; id 30 MadDragon
    dw $0030 ; id 31 Rayburn
    dw $0031 ; id 32 Chamelgon
    dw $0032 ; id 33 LizardFly
    dw $0033 ; id 34 Andreal
    dw $0034 ; id 35 KingCobra
    dw $0037 ; id 36 Spikerous
    dw $0038 ; id 37 GreatDrak
    dw $0039 ; id 38 Crestpent
    dw $003A ; id 39 WingSnake
    dw $003B ; id 40 Coatol
    dw $003C ; id 41 Orochi
    dw $003D ; id 42 BattleRex
    dw $003E ; id 43 SkyDragon
    dw $0040 ; id 44 Divinegon
    dw $0047 ; id 45 Tonguella
    dw $0048 ; id 46 Almiraj
    dw $0049 ; id 47 CatFly
    dw $004A ; id 48 PillowRat
    dw $004B ; id 49 Saccer
    dw $004C ; id 50 GulpBeast
    dw $004D ; id 51 Skullroo
    dw $004E ; id 52 WindBeast
    dw $0050 ; id 53 Antbear
    dw $0051 ; id 54 SuperTen
    dw $0052 ; id 55 IronTurt
    dw $0053 ; id 56 Mommonja
    dw $0054 ; id 57 HammerMan
    dw $0055 ; id 58 Grizzly
    dw $0056 ; id 59 Yeti
    dw $005A ; id 60 MadGopher
    dw $005B ; id 61 FairyRat
    dw $005C ; id 62 Unicorn
    dw $005D ; id 63 Goategon
    dw $005E ; id 64 WildApe
    dw $005F ; id 65 Trumpeter
    dw $0060 ; id 66 KingLeo
    dw $0061 ; id 67 DarkHorn
    dw $0062 ; id 68 MadCat
    dw $0063 ; id 69 BigEye
    dw $006A ; id 70 Picky
    dw $006B ; id 71 Wyvern
    dw $006C ; id 72 BullBird
    dw $006D ; id 73 Florajay
    dw $006E ; id 74 DuckKite
    dw $006F ; id 75 MadPecker
    dw $0070 ; id 76 MadRaven
    dw $0071 ; id 77 MistyWing
    dw $0073 ; id 78 Dracky
    dw $0075 ; id 79 BigRoost
    dw $0076 ; id 80 StubBird
    dw $0077 ; id 81 LandOwl
    dw $0078 ; id 82 MadGoose
    dw $0079 ; id 83 MadCondor
    dw $007B ; id 84 Blizzardy
    dw $007C ; id 85 Phoenix
    dw $007D ; id 86 ZapBird
    dw $007F ; id 87 WhipBird
    dw $0080 ; id 88 FunkyBird
    dw $0081 ; id 89 RainHawk
    dw $008D ; id 90 MadPlant
    dw $008E ; id 91 FireWeed
    dw $008F ; id 92 FloraMan
    dw $0090 ; id 93 WingTree
    dw $0091 ; id 94 CactiBall
    dw $0092 ; id 95 Gulpple
    dw $0093 ; id 96 Toadstool
    dw $0094 ; id 97 AmberWeed
    dw $0096 ; id 98 Stubsuck
    dw $0097 ; id 99 Oniono
    dw $0098 ; id 100 DanceVegi
    dw $0099 ; id 101 TreeBoy
    dw $009B ; id 102 FaceTree
    dw $009C ; id 103 HerbMan
    dw $009D ; id 104 BeanMan
    dw $009E ; id 105 EvilSeed
    dw $009F ; id 106 ManEater
    dw $00A0 ; id 107 Snapper
    dw $00A2 ; id 108 Rosevine
    dw $00A5 ; id 109 Watabou
    dw $00B0 ; id 110 GiantSlug
    dw $00B1 ; id 111 Catapila
    dw $00B2 ; id 112 Gophecada
    dw $00B3 ; id 113 Butterfly
    dw $00B4 ; id 114 WeedBug
    dw $00B5 ; id 115 GiantWorm
    dw $00B6 ; id 116 Lipsy
    dw $00B7 ; id 117 StagBug
    dw $00B9 ; id 118 ArmyAnt
    dw $00BA ; id 119 GoHopper
    dw $00BB ; id 120 TailEater
    dw $00BC ; id 121 ArmorPede
    dw $00BD ; id 122 Eyeder
    dw $00BE ; id 123 GiantMoth
    dw $00BF ; id 124 Droll
    dw $00C0 ; id 125 ArmyCrab
    dw $00C1 ; id 126 MadHornet
    dw $00C4 ; id 127 HornBeet
    dw $00C6 ; id 128 Armorpion
    dw $00C7 ; id 129 Digster
    dw $00D3 ; id 130 Pixy
    dw $00DE ; id 131 ArcDemon
    dw $00D5 ; id 132 AgDevil
    dw $00D6 ; id 133 Demonite
    dw $00D7 ; id 134 DarkEye
    dw $00D8 ; id 135 EyeBall
    dw $00D9 ; id 136 SkulRider
    dw $00DA ; id 137 EvilBeast
    dw $00DC ; id 138 1EyeClown
    dw $00DD ; id 139 Gremlin
    dw $00D4 ; id 140 MedusaEye
    dw $00DF ; id 141 Lionex
    dw $00E0 ; id 142 GoatHorn
    dw $00E1 ; id 143 Orc
    dw $00E2 ; id 144 Ogre
    dw $00E3 ; id 145 GateGuard
    dw $00E4 ; id 146 ChopClown
    dw $00E6 ; id 147 Grendal
    dw $00E7 ; id 148 Akubar
    dw $00E8 ; id 149 MadKnight
    dw $00EA ; id 150 Gigantes
    dw $00EB ; id 151 Centasaur
    dw $00EC ; id 152 EvilArmor
    dw $00ED ; id 153 Jamirus
    dw $00EE ; id 154 Durran
    dw $00F6 ; id 155 Spooky
    dw $00F7 ; id 156 Skullgon
    dw $00F8 ; id 157 PutrePup
    dw $00F9 ; id 158 RotRaven
    dw $00FA ; id 159 Mummy
    dw $00FB ; id 160 DarkCrab
    dw $00FC ; id 161 DeadNite
    dw $00FD ; id 162 Shadow
    dw $00FF ; id 163 Hork
    dw $0100 ; id 164 Mudron
    dw $0101 ; id 165 NiteWhip
    dw $010E ; id 166 MadSpirit
    dw $0102 ; id 167 WindMerge
    dw $0103 ; id 168 Reaper
    dw $0107 ; id 169 DeadNoble
    dw $0108 ; id 170 WhiteKing
    dw $0109 ; id 171 BoneSlave
    dw $010A ; id 172 Skeletor
    dw $010B ; id 173 Servant
    dw $010D ; id 174 Copycat
    dw $0119 ; id 175 JewelBag
    dw $011A ; id 176 EvilWand
    dw $011B ; id 177 MadCandle
    dw $011C ; id 178 CoilBird
    dw $011D ; id 179 Facer
    dw $011E ; id 180 SpikyBoy
    dw $011F ; id 181 MadMirror
    dw $0120 ; id 182 RogueNite
    dw $0122 ; id 183 Goopi
    dw $0123 ; id 184 Voodoll
    dw $0124 ; id 185 MetalDrak
    dw $0125 ; id 186 Balzak
    dw $0126 ; id 187 SabreMan
    dw $0127 ; id 188 CurseLamp
    dw $0129 ; id 189 Roboster
    dw $012B ; id 190 EvilPot
    dw $012C ; id 191 Gismo
    dw $012D ; id 192 LavaMan
    dw $012E ; id 193 IceMan
    dw $012F ; id 194 Mimic
    dw $0131 ; id 195 MudDoll
    dw $0132 ; id 196 Golem
    dw $0133 ; id 197 StoneMan
    dw $0134 ; id 198 BombCrag
    dw $0135 ; id 199 GoldGolem
    dw $015F ; id 200 DracoLord
    dw $0160 ; id 201 DracoLord
    dw $0162 ; id 202 Hargon
    dw $0163 ; id 203 Sidoh
    dw $0165 ; id 204 Baramos
    dw $0166 ; id 205 Zoma
    dw $0168 ; id 206 Pizzaro
    dw $016A ; id 207 Esterk
    dw $016B ; id 208 Mirudraas
    dw $016C ; id 209 Mirudraas
    dw $016D ; id 210 Mudou
    dw $016E ; id 211 DeathMore
    dw $016F ; id 212 DeathMore
    dw $0170 ; id 213 DeathMore
    dw $0171 ; id 214 Darkdrium

; E-0217 (C1: AppendSpeciesToLinkCodeByteForWordAtDE appends the byte at $6175 + species word; 384 bytes end at LinkSkillMapTable_B; the first two bytes are also the last word of LinkCodeToSpeciesTable's range end).
; record: link code for this species (0 = none)
SpeciesToLinkCodeTable::
Data_037_6175:: ; address name
    db $00 ; id 0
    db $00 ; id 1 DrakSlime
    db $01 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $03 ; id 4 TreeSlime
    db $04 ; id 5 Snaily
    db $05 ; id 6 SlimeNite
    db $06 ; id 7 Babble
    db $07 ; id 8 BoxSlime
    db $04 ; id 9 PearlGel
    db $08 ; id 10 Slime
    db $09 ; id 11 Healer
    db $0A ; id 12 FangSlime
    db $0B ; id 13 RockSlime
    db $0C ; id 14 SlimeBorg
    db $0D ; id 15 Slabbit
    db $0F ; id 16 KingSlime
    db $10 ; id 17 Metaly
    db $11 ; id 18 Metabble
    db $0E ; id 19 SpotKing
    db $03 ; id 20 TropicGel
    db $0D ; id 21 MimeSlime
    db $12 ; id 22 HaloSlime
    db $12 ; id 23 MetalKing
    db $13 ; id 24 GoldSlime
    db $13 ; id 25 GranSlime
    db $12 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $14 ; id 36 DragonKid
    db $15 ; id 37 Tortragon
    db $16 ; id 38 Pteranod
    db $17 ; id 39 Gasgon
    db $18 ; id 40 FairyDrak
    db $19 ; id 41 LizardMan
    db $1A ; id 42 Poisongon
    db $1B ; id 43 Swordgon
    db $1E ; id 44 Drygon
    db $1C ; id 45 Dragon
    db $1D ; id 46 MiniDrak
    db $1E ; id 47 MadDragon
    db $1F ; id 48 Rayburn
    db $20 ; id 49 Chamelgon
    db $21 ; id 50 LizardFly
    db $22 ; id 51 Andreal
    db $23 ; id 52 KingCobra
    db $1F ; id 53 Vampirus
    db $16 ; id 54 SnakeBat
    db $24 ; id 55 Spikerous
    db $25 ; id 56 GreatDrak
    db $26 ; id 57 Crestpent
    db $27 ; id 58 WingSnake
    db $28 ; id 59 Coatol
    db $29 ; id 60 Orochi
    db $2A ; id 61 BattleRex
    db $2B ; id 62 SkyDragon
    db $29 ; id 63 Serpentia
    db $2C ; id 64 Divinegon
    db $2A ; id 65 Orligon
    db $2A ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $2D ; id 71 Tonguella
    db $2E ; id 72 Almiraj
    db $2F ; id 73 CatFly
    db $30 ; id 74 PillowRat
    db $31 ; id 75 Saccer
    db $32 ; id 76 GulpBeast
    db $33 ; id 77 Skullroo
    db $34 ; id 78 WindBeast
    db $34 ; id 79 Beavern
    db $35 ; id 80 Antbear
    db $36 ; id 81 SuperTen
    db $37 ; id 82 IronTurt
    db $38 ; id 83 Mommonja
    db $39 ; id 84 HammerMan
    db $3A ; id 85 Grizzly
    db $3B ; id 86 Yeti
    db $2F ; id 87 ArrowDog
    db $2D ; id 88 NoctoKing
    db $39 ; id 89 BeastNite
    db $3C ; id 90 MadGopher
    db $3D ; id 91 FairyRat
    db $3E ; id 92 Unicorn
    db $3F ; id 93 Goategon
    db $40 ; id 94 WildApe
    db $41 ; id 95 Trumpeter
    db $42 ; id 96 KingLeo
    db $43 ; id 97 DarkHorn
    db $44 ; id 98 MadCat
    db $45 ; id 99 BigEye
    db $44 ; id 100 Gorago
    db $2F ; id 101 CatMage
    db $2D ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $46 ; id 106 Picky
    db $47 ; id 107 Wyvern
    db $48 ; id 108 BullBird
    db $49 ; id 109 Florajay
    db $4A ; id 110 DuckKite
    db $4B ; id 111 MadPecker
    db $4C ; id 112 MadRaven
    db $4D ; id 113 MistyWing
    db $47 ; id 114 AquaHawk
    db $4E ; id 115 Dracky
    db $4A ; id 116 KiteHawk
    db $4F ; id 117 BigRoost
    db $50 ; id 118 StubBird
    db $51 ; id 119 LandOwl
    db $52 ; id 120 MadGoose
    db $53 ; id 121 MadCondor
    db $52 ; id 122 Emyu
    db $54 ; id 123 Blizzardy
    db $55 ; id 124 Phoenix
    db $56 ; id 125 ZapBird
    db $53 ; id 126 Garudian
    db $57 ; id 127 WhipBird
    db $58 ; id 128 FunkyBird
    db $59 ; id 129 RainHawk
    db $59 ; id 130 Azurile
    db $56 ; id 131 Shantak
    db $52 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $5A ; id 141 MadPlant
    db $5B ; id 142 FireWeed
    db $5C ; id 143 FloraMan
    db $5D ; id 144 WingTree
    db $5E ; id 145 CactiBall
    db $5F ; id 146 Gulpple
    db $60 ; id 147 Toadstool
    db $61 ; id 148 AmberWeed
    db $6A ; id 149 Slurperon
    db $62 ; id 150 Stubsuck
    db $63 ; id 151 Oniono
    db $64 ; id 152 DanceVegi
    db $65 ; id 153 TreeBoy
    db $5F ; id 154 Devipine
    db $66 ; id 155 FaceTree
    db $67 ; id 156 HerbMan
    db $68 ; id 157 BeanMan
    db $69 ; id 158 EvilSeed
    db $6A ; id 159 ManEater
    db $6B ; id 160 Snapper
    db $67 ; id 161 GhosTree
    db $6C ; id 162 Rosevine
    db $6C ; id 163 Egdracil
    db $6D ; id 164 Warubou
    db $6D ; id 165 Watabou
    db $63 ; id 166 Eggplaton
    db $65 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $6E ; id 176 GiantSlug
    db $6F ; id 177 Catapila
    db $70 ; id 178 Gophecada
    db $71 ; id 179 Butterfly
    db $72 ; id 180 WeedBug
    db $73 ; id 181 GiantWorm
    db $74 ; id 182 Lipsy
    db $75 ; id 183 StagBug
    db $78 ; id 184 Pyuro
    db $76 ; id 185 ArmyAnt
    db $77 ; id 186 GoHopper
    db $78 ; id 187 TailEater
    db $79 ; id 188 ArmorPede
    db $7A ; id 189 Eyeder
    db $7B ; id 190 GiantMoth
    db $7C ; id 191 Droll
    db $7D ; id 192 ArmyCrab
    db $7E ; id 193 MadHornet
    db $7B ; id 194 Belzebub
    db $7D ; id 195 WarMantis
    db $7F ; id 196 HornBeet
    db $75 ; id 197 Sickler
    db $80 ; id 198 Armorpion
    db $81 ; id 199 Digster
    db $80 ; id 200 Skularach
    db $7C ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $82 ; id 211 Pixy
    db $8C ; id 212 MedusaEye
    db $84 ; id 213 AgDevil
    db $85 ; id 214 Demonite
    db $86 ; id 215 DarkEye
    db $87 ; id 216 EyeBall
    db $88 ; id 217 SkulRider
    db $89 ; id 218 EvilBeast
    db $8F ; id 219 Bubblemon
    db $8A ; id 220 1EyeClown
    db $8B ; id 221 Gremlin
    db $83 ; id 222 ArcDemon
    db $8D ; id 223 Lionex
    db $8E ; id 224 GoatHorn
    db $8F ; id 225 Orc
    db $90 ; id 226 Ogre
    db $91 ; id 227 GateGuard
    db $92 ; id 228 ChopClown
    db $96 ; id 229 BossTroll
    db $93 ; id 230 Grendal
    db $94 ; id 231 Akubar
    db $95 ; id 232 MadKnight
    db $93 ; id 233 EvilWell
    db $96 ; id 234 Gigantes
    db $97 ; id 235 Centasaur
    db $98 ; id 236 EvilArmor
    db $99 ; id 237 Jamirus
    db $9A ; id 238 Durran
    db $99 ; id 239 Titanis
    db $97 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $9B ; id 246 Spooky
    db $9C ; id 247 Skullgon
    db $9D ; id 248 PutrePup
    db $9E ; id 249 RotRaven
    db $9F ; id 250 Mummy
    db $A0 ; id 251 DarkCrab
    db $A1 ; id 252 DeadNite
    db $A2 ; id 253 Shadow
    db $9C ; id 254 Skulpent
    db $A3 ; id 255 Hork
    db $A4 ; id 256 Mudron
    db $A5 ; id 257 NiteWhip
    db $A7 ; id 258 WindMerge
    db $A8 ; id 259 Reaper
    db $A3 ; id 260 Inverzon
    db $AE ; id 261 FoxFire
    db $A1 ; id 262 CaptDead
    db $A9 ; id 263 DeadNoble
    db $AA ; id 264 WhiteKing
    db $AB ; id 265 BoneSlave
    db $AC ; id 266 Skeletor
    db $AD ; id 267 Servant
    db $AA ; id 268 Lazamanus
    db $AE ; id 269 Copycat
    db $A6 ; id 270 MadSpirit
    db $AE ; id 271 PomPomBom
    db $A9 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $AF ; id 281 JewelBag
    db $B0 ; id 282 EvilWand
    db $B1 ; id 283 MadCandle
    db $B2 ; id 284 CoilBird
    db $B3 ; id 285 Facer
    db $B4 ; id 286 SpikyBoy
    db $B5 ; id 287 MadMirror
    db $B6 ; id 288 RogueNite
    db $C3 ; id 289 Puppetor
    db $B7 ; id 290 Goopi
    db $B8 ; id 291 Voodoll
    db $B9 ; id 292 MetalDrak
    db $BA ; id 293 Balzak
    db $BB ; id 294 SabreMan
    db $BC ; id 295 CurseLamp
    db $B1 ; id 296 Brushead
    db $BD ; id 297 Roboster
    db $BD ; id 298 Roboster2
    db $BE ; id 299 EvilPot
    db $BF ; id 300 Gismo
    db $C0 ; id 301 LavaMan
    db $C1 ; id 302 IceMan
    db $C2 ; id 303 Mimic
    db $B5 ; id 304 Exaucers
    db $C3 ; id 305 MudDoll
    db $C4 ; id 306 Golem
    db $C5 ; id 307 StoneMan
    db $C6 ; id 308 BombCrag
    db $C7 ; id 309 GoldGolem
    db $C7 ; id 310 DarkMate
    db $BD ; id 311 ProtoMech
    db $BF ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $08 ; id 316 Petiteel
    db $26 ; id 317 Moray
    db $3A ; id 318 WalrusMan
    db $4A ; id 319 RayGigas
    db $5A ; id 320 Anemon
    db $78 ; id 321 Aquarella
    db $89 ; id 322 Merman
    db $BE ; id 323 Octokid
    db $9C ; id 324 PutreFish
    db $06 ; id 325 Octoreach
    db $1A ; id 326 Angleron
    db $88 ; id 327 FishRider
    db $3F ; id 328 RushFish
    db $74 ; id 329 Gamanian
    db $A0 ; id 330 Clawster
    db $81 ; id 331 CancerMan
    db $BF ; id 332 RogueWave
    db $C2 ; id 333 Scallopa
    db $85 ; id 334 SeaHorse
    db $84 ; id 335 HoodSquid
    db $41 ; id 336 MerTiger
    db $2A ; id 337 AxeShark
    db $AC ; id 338 Octogon
    db $AD ; id 339 KingSquid
    db $57 ; id 340 Digong
    db $AA ; id 341 WhaleMage
    db $2B ; id 342 Aquadon
    db $98 ; id 343 Octoraid
    db $83 ; id 344 Grakos
    db $42 ; id 345 Poseidon
    db $5E ; id 346 Pumpoise
    db $84 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $C8 ; id 351 DracoLord
    db $C9 ; id 352 DracoLord
    db $C9 ; id 353 LordDraco
    db $CA ; id 354 Hargon
    db $CB ; id 355 Sidoh
    db $CB ; id 356 Genosidoh
    db $CC ; id 357 Baramos
    db $CD ; id 358 Zoma
    db $CD ; id 359 AsuraZoma
    db $CE ; id 360 Pizzaro
    db $CE ; id 361 PsychoPiz
    db $CF ; id 362 Esterk
    db $D0 ; id 363 Mirudraas
    db $D1 ; id 364 Mirudraas
    db $D2 ; id 365 Mudou
    db $D3 ; id 366 DeathMore
    db $D4 ; id 367 DeathMore
    db $D5 ; id 368 DeathMore
    db $D6 ; id 369 Darkdrium
    db $D6 ; id 370 Orgodemir
    db $D4 ; id 371 Orgodemir
    db $D2 ; id 372 Darck
    db $00 ; id 373 Tatsu
    db $00 ; id 374 Diago
    db $00 ; id 375 Samsi
    db $00 ; id 376 Bazoo
    db $00 ; id 377 ?
    db $00 ; id 378 ?
    db $00 ; id 379 ?
    db $59 ; id 380 Lamia
    db $2C ; id 381 Dimensaur
    db $6D ; id 382 Kagebou
    db $00 ; id 383 ?

; E-0217 (C1: MapAndCompactSkillListLinkSkillMapTable_B, from UnpackLinkRecordToRecordBufB, maps $21 skill bytes through $62F5 + byte (except $FF) and compacts the lists, dropping $FE/$FF; 222 entries end at LinkSkillMapTable_A).
; record: mapped skill ($FE/$FF = dropped)
LinkSkillMapTable_B::
Data_037_62F5:: ; address name
    db $01 ; id 0
    db $02 ; id 1
    db $03 ; id 2
    db $04 ; id 3
    db $05 ; id 4
    db $06 ; id 5
    db $07 ; id 6
    db $08 ; id 7
    db $09 ; id 8
    db $0A ; id 9
    db $0B ; id 10
    db $0C ; id 11
    db $10 ; id 12
    db $11 ; id 13
    db $12 ; id 14
    db $0D ; id 15
    db $0E ; id 16
    db $0F ; id 17
    db $13 ; id 18
    db $14 ; id 19
    db $15 ; id 20
    db $2F ; id 21
    db $30 ; id 22
    db $33 ; id 23
    db $2E ; id 24
    db $34 ; id 25
    db $32 ; id 26
    db $31 ; id 27
    db $27 ; id 28
    db $28 ; id 29
    db $25 ; id 30
    db $26 ; id 31
    db $2B ; id 32
    db $2C ; id 33
    db $29 ; id 34
    db $2A ; id 35
    db $38 ; id 36
    db $2D ; id 37
    db $39 ; id 38
    db $36 ; id 39
    db $37 ; id 40
    db $3A ; id 41
    db $35 ; id 42
    db $16 ; id 43
    db $17 ; id 44
    db $18 ; id 45
    db $19 ; id 46
    db $1A ; id 47
    db $1E ; id 48
    db $1F ; id 49
    db $20 ; id 50
    db $21 ; id 51
    db $23 ; id 52
    db $22 ; id 53
    db $24 ; id 54
    db $A4 ; id 55
    db $A9 ; id 56
    db $3C ; id 57
    db $00 ; id 58
    db $6D ; id 59
    db $6F ; id 60
    db $6E ; id 61
    db $70 ; id 62
    db $6C ; id 63
    db $6B ; id 64
    db $68 ; id 65
    db $6A ; id 66
    db $89 ; id 67
    db $50 ; id 68
    db $52 ; id 69
    db $51 ; id 70
    db $53 ; id 71
    db $5E ; id 72
    db $55 ; id 73
    db $56 ; id 74
    db $57 ; id 75
    db $5A ; id 76
    db $5B ; id 77
    db $5C ; id 78
    db $66 ; id 79
    db $63 ; id 80
    db $64 ; id 81
    db $4E ; id 82
    db $4F ; id 83
    db $8A ; id 84
    db $62 ; id 85
    db $69 ; id 86
    db $65 ; id 87
    db $48 ; id 88
    db $49 ; id 89
    db $4A ; id 90
    db $4B ; id 91
    db $40 ; id 92
    db $41 ; id 93
    db $42 ; id 94
    db $43 ; id 95
    db $44 ; id 96
    db $45 ; id 97
    db $46 ; id 98
    db $47 ; id 99
    db $3F ; id 100
    db $3E ; id 101
    db $3D ; id 102
    db $5F ; id 103
    db $61 ; id 104
    db $60 ; id 105
    db $71 ; id 106
    db $72 ; id 107
    db $73 ; id 108
    db $74 ; id 109
    db $78 ; id 110
    db $75 ; id 111
    db $8F ; id 112
    db $79 ; id 113
    db $7E ; id 114
    db $7F ; id 115
    db $80 ; id 116
    db $76 ; id 117
    db $77 ; id 118
    db $7D ; id 119
    db $7A ; id 120
    db $8B ; id 121
    db $8C ; id 122
    db $8D ; id 123
    db $8E ; id 124
    db $90 ; id 125
    db $A2 ; id 126
    db $9E ; id 127
    db $83 ; id 128
    db $81 ; id 129
    db $82 ; id 130
    db $84 ; id 131
    db $85 ; id 132
    db $86 ; id 133
    db $87 ; id 134
    db $88 ; id 135
    db $97 ; id 136
    db $98 ; id 137
    db $99 ; id 138
    db $9A ; id 139
    db $95 ; id 140
    db $95 ; id 141
    db $94 ; id 142
    db $9D ; id 143
    db $96 ; id 144
    db $92 ; id 145
    db $93 ; id 146
    db $9F ; id 147
    db $7C ; id 148
    db $A0 ; id 149
    db $7B ; id 150
    db $C8 ; id 151
    db $AB ; id 152
    db $C0 ; id 153
    db $C1 ; id 154
    db $C2 ; id 155
    db $C3 ; id 156
    db $C4 ; id 157
    db $C5 ; id 158
    db $C6 ; id 159
    db $C7 ; id 160
    db $C8 ; id 161
    db $B0 ; id 162
    db $B1 ; id 163
    db $B2 ; id 164
    db $B3 ; id 165
    db $B4 ; id 166
    db $B5 ; id 167
    db $B6 ; id 168
    db $B7 ; id 169
    db $B8 ; id 170
    db $B9 ; id 171
    db $BA ; id 172
    db $BB ; id 173
    db $BC ; id 174
    db $BD ; id 175
    db $FF ; id 176
    db $FF ; id 177
    db $FF ; id 178
    db $FF ; id 179
    db $FF ; id 180
    db $FF ; id 181
    db $FF ; id 182
    db $FF ; id 183
    db $FF ; id 184
    db $FF ; id 185
    db $FF ; id 186
    db $FF ; id 187
    db $FF ; id 188
    db $FF ; id 189
    db $FF ; id 190
    db $FF ; id 191
    db $FF ; id 192
    db $FF ; id 193
    db $FF ; id 194
    db $FF ; id 195
    db $FF ; id 196
    db $FF ; id 197
    db $FF ; id 198
    db $FF ; id 199
    db $FF ; id 200
    db $FF ; id 201
    db $FF ; id 202
    db $FF ; id 203
    db $FF ; id 204
    db $FF ; id 205
    db $FF ; id 206
    db $FF ; id 207
    db $FF ; id 208
    db $FF ; id 209
    db $FF ; id 210
    db $FF ; id 211
    db $FF ; id 212
    db $3B ; id 213
    db $54 ; id 214
    db $58 ; id 215
    db $59 ; id 216
    db $67 ; id 217
    db $34 ; id 218
    db $C8 ; id 219
    db $35 ; id 220
    db $8F ; id 221

; E-0217 (C1: MapAndCompactSkillListLinkSkillMapTable_A, from UnpackLinkRecordToWorkBuf, maps $21 skill bytes through $63D3 + byte and compacts the lists; 170 entries end at TileRect_37_647D; for 155 of them LinkSkillMapTable_B maps the result back).
; record: mapped skill ($FE = dropped)
LinkSkillMapTable_A::
Data_037_63D3:: ; address name
    db $3A ; id 0
    db $00 ; id 1
    db $01 ; id 2
    db $02 ; id 3
    db $03 ; id 4
    db $04 ; id 5
    db $05 ; id 6
    db $06 ; id 7
    db $07 ; id 8
    db $08 ; id 9
    db $09 ; id 10
    db $0A ; id 11
    db $0B ; id 12
    db $0F ; id 13
    db $10 ; id 14
    db $11 ; id 15
    db $0C ; id 16
    db $0D ; id 17
    db $0E ; id 18
    db $12 ; id 19
    db $13 ; id 20
    db $14 ; id 21
    db $2B ; id 22
    db $2C ; id 23
    db $2D ; id 24
    db $2E ; id 25
    db $2F ; id 26
    db $FE ; id 27
    db $FE ; id 28
    db $FE ; id 29
    db $30 ; id 30
    db $31 ; id 31
    db $32 ; id 32
    db $33 ; id 33
    db $35 ; id 34
    db $34 ; id 35
    db $36 ; id 36
    db $1E ; id 37
    db $1F ; id 38
    db $1C ; id 39
    db $1D ; id 40
    db $22 ; id 41
    db $23 ; id 42
    db $20 ; id 43
    db $21 ; id 44
    db $25 ; id 45
    db $18 ; id 46
    db $15 ; id 47
    db $16 ; id 48
    db $1B ; id 49
    db $1A ; id 50
    db $17 ; id 51
    db $19 ; id 52
    db $2A ; id 53
    db $27 ; id 54
    db $28 ; id 55
    db $24 ; id 56
    db $26 ; id 57
    db $29 ; id 58
    db $D5 ; id 59
    db $39 ; id 60
    db $66 ; id 61
    db $65 ; id 62
    db $64 ; id 63
    db $5C ; id 64
    db $5D ; id 65
    db $5E ; id 66
    db $5F ; id 67
    db $60 ; id 68
    db $61 ; id 69
    db $62 ; id 70
    db $63 ; id 71
    db $58 ; id 72
    db $59 ; id 73
    db $5A ; id 74
    db $5B ; id 75
    db $FE ; id 76
    db $FE ; id 77
    db $52 ; id 78
    db $53 ; id 79
    db $44 ; id 80
    db $46 ; id 81
    db $45 ; id 82
    db $47 ; id 83
    db $D6 ; id 84
    db $49 ; id 85
    db $4A ; id 86
    db $4B ; id 87
    db $D7 ; id 88
    db $D8 ; id 89
    db $4C ; id 90
    db $4D ; id 91
    db $4E ; id 92
    db $FE ; id 93
    db $48 ; id 94
    db $67 ; id 95
    db $69 ; id 96
    db $68 ; id 97
    db $55 ; id 98
    db $50 ; id 99
    db $51 ; id 100
    db $57 ; id 101
    db $4F ; id 102
    db $D9 ; id 103
    db $41 ; id 104
    db $56 ; id 105
    db $42 ; id 106
    db $40 ; id 107
    db $3F ; id 108
    db $3B ; id 109
    db $3D ; id 110
    db $3C ; id 111
    db $3E ; id 112
    db $6A ; id 113
    db $6B ; id 114
    db $6C ; id 115
    db $6D ; id 116
    db $6F ; id 117
    db $75 ; id 118
    db $76 ; id 119
    db $6E ; id 120
    db $71 ; id 121
    db $78 ; id 122
    db $96 ; id 123
    db $94 ; id 124
    db $77 ; id 125
    db $72 ; id 126
    db $73 ; id 127
    db $74 ; id 128
    db $81 ; id 129
    db $82 ; id 130
    db $80 ; id 131
    db $83 ; id 132
    db $84 ; id 133
    db $85 ; id 134
    db $86 ; id 135
    db $87 ; id 136
    db $43 ; id 137
    db $54 ; id 138
    db $79 ; id 139
    db $7A ; id 140
    db $7B ; id 141
    db $7C ; id 142
    db $70 ; id 143
    db $7D ; id 144
    db $FE ; id 145
    db $91 ; id 146
    db $92 ; id 147
    db $8E ; id 148
    db $8C ; id 149
    db $90 ; id 150
    db $88 ; id 151
    db $89 ; id 152
    db $8A ; id 153
    db $8B ; id 154
    db $FE ; id 155
    db $FE ; id 156
    db $8F ; id 157
    db $7F ; id 158
    db $93 ; id 159
    db $95 ; id 160
    db $FE ; id 161
    db $7E ; id 162
    db $FE ; id 163
    db $37 ; id 164
    db $FE ; id 165
    db $FE ; id 166
    db $FE ; id 167
    db $FE ; id 168
    db $38 ; id 169

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 5 tiles, one row per line
TileRect_37_647D::
Data_037_647D:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_37_64B9::
Data_037_64B9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 7 tiles, one row per line
TileRect_37_64D7::
Data_037_64D7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $60, $61, $62, $62, $63, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $64, $65, $66, $67, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $68, $69, $6A, $6B, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; address loaded by RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox
RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_037_6516:: ; address name
    db $FC, $C3, $24, $C4, $4C, $C4
    ds $1AE4, $00
