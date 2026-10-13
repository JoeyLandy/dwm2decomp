SECTION "Bank F0", ROMX[$4000], BANK[$F0]
    db $F0

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_BankF0_4001)
BeginStringDisplay_BankF0_4001::
Func_0F0_4001:: ; address name
    ld de, StringCategories_F0_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_F0_4016::
Data_0F0_4016:: ; address name
    dw StringList_F0_4018 ; id 0

; E-0217 (derived: category list of StringCategories_F0_4016; one pointer per wStringIndex)
; record: string
StringList_F0_4018::
Data_0F0_4018:: ; address name
    dw String_F0_4016_00_00 ; id 0
    dw String_F0_4016_00_01 ; id 1
    dw String_F0_4016_00_02 ; id 2
    dw String_F0_4016_00_03 ; id 3
    dw String_F0_4016_00_04 ; id 4
    dw String_F0_4016_00_05 ; id 5
    dw String_F0_4016_00_06 ; id 6
    dw String_F0_4016_00_07 ; id 7
    dw String_F0_4016_00_08 ; id 8
    dw String_F0_4016_00_09 ; id 9
    dw String_F0_4016_00_0A ; id 10
    dw String_F0_4016_00_0B ; id 11
    dw String_F0_4016_00_0C ; id 12
    dw String_F0_4016_00_0D ; id 13
    dw String_F0_4016_00_0E ; id 14
CopyNameStringFromBank08Database_Data_4036:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_4036:: ; address name
    dw String_F0_4016_00_0F ; id 15
    dw String_F0_4016_00_10 ; id 16
    dw String_F0_4016_00_11 ; id 17
    dw String_F0_4016_00_12 ; id 18
    dw String_F0_4016_00_13 ; id 19
    dw String_F0_4016_00_14 ; id 20
    dw String_F0_4016_00_15 ; id 21
    dw String_F0_4016_00_16 ; id 22
    dw String_F0_4016_00_17 ; id 23
    dw String_F0_4016_00_18 ; id 24
    dw String_F0_4016_00_19 ; id 25
    dw String_F0_4016_00_1A ; id 26
    dw String_F0_4016_00_1B ; id 27
    dw String_F0_4016_00_1C ; id 28
    dw String_F0_4016_00_1D ; id 29
    dw String_F0_4016_00_1E ; id 30
    dw String_F0_4016_00_1F ; id 31
    dw String_F0_4016_00_20 ; id 32
    dw String_F0_4016_00_21 ; id 33
    dw String_F0_4016_00_22 ; id 34
    dw String_F0_4016_00_23 ; id 35
    dw String_F0_4016_00_24 ; id 36
    dw String_F0_4016_00_25 ; id 37
    dw String_F0_4016_00_26 ; id 38
    dw String_F0_4016_00_27 ; id 39
    dw String_F0_4016_00_28 ; id 40
    dw String_F0_4016_00_29 ; id 41
    dw String_F0_4016_00_29 ; id 42
    dw String_F0_4016_00_29 ; id 43
    dw String_F0_4016_00_29 ; id 44
    dw String_F0_4016_00_2D ; id 45
    dw String_F0_4016_00_2E ; id 46
    dw String_F0_4016_00_2F ; id 47
    dw String_F0_4016_00_30 ; id 48
    dw String_F0_4016_00_31 ; id 49
    dw String_F0_4016_00_32 ; id 50
    dw String_F0_4016_00_33 ; id 51
    dw String_F0_4016_00_34 ; id 52
    dw String_F0_4016_00_35 ; id 53
    dw String_F0_4016_00_36 ; id 54
    dw String_F0_4016_00_37 ; id 55
    dw String_F0_4016_00_38 ; id 56
    dw String_F0_4016_00_39 ; id 57
    dw String_F0_4016_00_3A ; id 58
    dw String_F0_4016_00_3B ; id 59
    dw String_F0_4016_00_3C ; id 60
    dw String_F0_4016_00_3D ; id 61
    dw String_F0_4016_00_3E ; id 62
    dw String_F0_4016_00_3F ; id 63
    dw String_F0_4016_00_40 ; id 64
    dw BeginStringDisplay_BankF0_48A0 ; id 65
    dw BeginStringDisplay_BankF0_48A0 ; id 66
    dw BeginStringDisplay_BankF0_48A0 ; id 67
    dw BeginStringDisplay_BankF0_48A0 ; id 68

String_F0_4016_00_00:: ; heuristic: string; C0
Data_0F0_40A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: It's ", $F9, "0G a", $F1
    db "night.", $FA, $F7
    db $EF, $EE, "Will you stay with", $EF, $EE, "us tonight?", $FF, $F0

String_F0_4016_00_01:: ; heuristic: string; C0
Data_0F0_40DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Well then, have", $F1
    db "a good rest.", $F7
    db $F0

String_F0_4016_00_02:: ; heuristic: string; C0
Data_0F0_40FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Please come stay", $F1
    db "another time.", $F7
    db $F0

String_F0_4016_00_03:: ; heuristic: string; C0
Data_0F0_411E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Sorry, but you", $F1
    db "lack the money.", $FA, $F7
    db $EF, $EE, "I hope you'll stay", $EF, $EE, "another time.", $F7
    db $F0

String_F0_4016_00_04:: ; heuristic: string; C0
Data_0F0_4165:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Good morning", $F1
    db "and farewell!", $F7
    db $F0

String_F0_4016_00_05:: ; heuristic: string; C0
Data_0F0_4184:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Welcome to my", $F1
    db "shop.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F0

String_F0_4016_00_06:: ; heuristic: string; C0
Data_0F0_41BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What would you", $F1
    db "like to buy?", $F0

String_F0_4016_00_07:: ; heuristic: string; C0
Data_0F0_41D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have no more", $F1
    db "room for items.", $F7
    db $F0

String_F0_4016_00_08:: ; heuristic: string; C0
Data_0F0_41FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Is there", $F1
    db "anything else?", $F0

String_F0_4016_00_09:: ; heuristic: string; C0
Data_0F0_4219:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many would", $F1
    db "you like to buy?", $F0

String_F0_4016_00_0A:: ; heuristic: string; C0
Data_0F0_423C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ", $F9, "0?", $FF, $F0

String_F0_4016_00_0B:: ; heuristic: string; C0
Data_0F0_4244:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Thank you!", $F7
    db $F0

String_F0_4016_00_0C:: ; heuristic: string; C0
Data_0F0_4253:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh? You're short", $F1
    db "some gold.", $F7
    db $F0

String_F0_4016_00_0D:: ; heuristic: string; C0
Data_0F0_4272:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "any more items.", $F7
    db $F0

String_F0_4016_00_0E:: ; heuristic: string; C0
Data_0F0_4295:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What would you", $F1
    db "like to sell?", $F0

String_F0_4016_00_0F:: ; heuristic: string; C0
Data_0F0_42B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have no", $F1
    db "items to sell.", $F7
    db $F0

String_F0_4016_00_10:: ; heuristic: string; C0
Data_0F0_42D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Sorry, but I", $F1
    db "can't price that.", $F7
    db $F0

String_F0_4016_00_11:: ; heuristic: string; C0
Data_0F0_42F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many will", $F1
    db "you sell?", $F0

String_F0_4016_00_12:: ; heuristic: string; C0
Data_0F0_4311:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Thank you!", $F1
    db "Please come again.", $F7
    db $F0

String_F0_4016_00_13:: ; heuristic: string; C0
Data_0F0_4333:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "any more items.", $F7
    db $F0

String_F0_4016_00_14:: ; heuristic: string; C0
Data_0F0_4356:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That comes to", $F1
    db $F9, "0G. OK?", $F0

String_F0_4016_00_15:: ; heuristic: string; C0
Data_0F0_4370:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: This is the", $F1
    db "Vault.", $FA, $F7
    db $EF, $EE, "What can I do for", $EF, $EE, "you today?", $F0

String_F0_4016_00_16:: ; heuristic: string; C0
Data_0F0_43A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What should we", $F1
    db "store for you?", $F0

String_F0_4016_00_17:: ; heuristic: string; C0
Data_0F0_43C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You don't have", $F1
    db "any items.", $F7
    db $F0

String_F0_4016_00_18:: ; heuristic: string; C0
Data_0F0_43E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Is there", $F1
    db "anything else?", $F0

String_F0_4016_00_19:: ; heuristic: string; C0
Data_0F0_4400:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Sorry, but you", $F1
    db "filled the Vault.", $F7
    db $F0

String_F0_4016_00_1A:: ; heuristic: string; C0
Data_0F0_4425:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What item should", $F1
    db "I store for you?", $F0

String_F0_4016_00_1B:: ; heuristic: string; C0
Data_0F0_444A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many should", $F1
    db "I store?", $F0

String_F0_4016_00_1C:: ; heuristic: string; C0
Data_0F0_4466:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: OK, I'll put", $F1
    db "that away for you.", $F7
    db $F0

String_F0_4016_00_1D:: ; heuristic: string; C0
Data_0F0_4489:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I can't store", $F1
    db "that much.", $F7
    db $F0

String_F0_4016_00_1E:: ; heuristic: string; C0
Data_0F0_44A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You don't have", $F1
    db "enough to store.", $F7
    db $F0

String_F0_4016_00_1F:: ; heuristic: string; C0
Data_0F0_44C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How much do you", $F1
    db "want to deposit?", $F0

String_F0_4016_00_20:: ; heuristic: string; C0
Data_0F0_44EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What will you be", $F1
    db "taking out?", $F0

String_F0_4016_00_21:: ; heuristic: string; C0
Data_0F0_450C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I don't have any", $F1
    db "of your items.", $F7
    db $F0

String_F0_4016_00_22:: ; heuristic: string; C0
Data_0F0_452F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "any more items.", $F7
    db $F0

String_F0_4016_00_23:: ; heuristic: string; C0
Data_0F0_4552:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What do you want", $F1
    db "back?", $F0

String_F0_4016_00_24:: ; heuristic: string; C0
Data_0F0_456C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many do you", $F1
    db "want back?", $F0

String_F0_4016_00_25:: ; heuristic: string; C0
Data_0F0_458A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Here you go.", $F7
    db $F0

String_F0_4016_00_26:: ; heuristic: string; C0
Data_0F0_459B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "that much.", $F7
    db $F0

String_F0_4016_00_27:: ; heuristic: string; C0
Data_0F0_45B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I don't have any", $F1
    db "of your money.", $F7
    db $F0

String_F0_4016_00_28:: ; heuristic: string; C0
Data_0F0_45DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How much gold", $F1
    db "will you withdraw?", $F0

String_F0_4016_00_29:: ; heuristic: string; C0
Data_0F0_4600:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Sorry, but I", $F1
    db "can't take another", $FA, $F7
    db $EF, $EE, "kind of item.", $EF, $EE, "There's no room.", $F7
    db $F0

String_F0_4016_00_2D:: ; heuristic: string; C0
Data_0F0_4645:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Come again", $F1
    db "anytime!", $F7
    db $F0

String_F0_4016_00_2E:: ; heuristic: string; C0
Data_0F0_465D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I don't have any", $F1
    db "more items.", $F7
    db $F0

String_F0_4016_00_2F:: ; heuristic: string; C0
Data_0F0_467D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I can't store", $F1
    db "that many.", $F7
    db $F0

String_F0_4016_00_30:: ; heuristic: string; C0
Data_0F0_4699:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I can't take any", $F1
    db "more of that item.", $F7
    db $F0

String_F0_4016_00_31:: ; heuristic: string; C0
Data_0F0_46C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: This is the", $F1
    db "Vault.", $FA, $F7
    db $EF, $EE, "How may I help you", $EF, $EE, "today?", $F0

String_F0_4016_00_32:: ; heuristic: string; C0
Data_0F0_46F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What would you", $F1
    db "like to buy?", $F0

String_F0_4016_00_33:: ; heuristic: string; C0
Data_0F0_4713:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "any more items.", $F7
    db $F0

String_F0_4016_00_34:: ; heuristic: string; C0
Data_0F0_4736:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Is there", $F1
    db "anything else?", $F0

String_F0_4016_00_35:: ; heuristic: string; C0
Data_0F0_4751:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many would", $F1
    db "you like?", $F0

String_F0_4016_00_36:: ; heuristic: string; C0
Data_0F0_476D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ", $F9, "0?", $FF, $F0

String_F0_4016_00_37:: ; heuristic: string; C0
Data_0F0_4775:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Thank you!", $F7
    db $F0

String_F0_4016_00_38:: ; heuristic: string; C0
Data_0F0_4784:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You don't have", $F1
    db "enough gold.", $F7
    db $F0

String_F0_4016_00_39:: ; heuristic: string; C0
Data_0F0_47A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't hold", $F1
    db "that many items.", $F7
    db $F0

String_F0_4016_00_3A:: ; heuristic: string; C0
Data_0F0_47C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: What would you", $F1
    db "like to sell?", $F0

String_F0_4016_00_3B:: ; heuristic: string; C0
Data_0F0_47E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have nothing", $F1
    db "to sell me.", $F7
    db $F0

String_F0_4016_00_3C:: ; heuristic: string; C0
Data_0F0_4807:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I can't put a", $F1
    db "price on that.", $F7
    db $F0

String_F0_4016_00_3D:: ; heuristic: string; C0
Data_0F0_4827:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: How many will", $F1
    db "you sell?", $F0

String_F0_4016_00_3E:: ; heuristic: string; C0
Data_0F0_4842:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Thank you!", $F1
    db "Please come again!", $F7
    db $F0

String_F0_4016_00_3F:: ; heuristic: string; C0
Data_0F0_4864:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't carry", $F1
    db "any more items.", $F7
    db $F0

String_F0_4016_00_40:: ; heuristic: string; C0
Data_0F0_4887:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That will be", $F1
    db $F9, "0G. OK?", $F0

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. BeginString_BankF0_Cat0, ShowString_BankF0, DebugMessageTest_Update_ToBeginStringDisplay_BankF0_48A0, PauseMenu_State4_GiftMenu_GiveGift_BeginStringDisplay_BankF0_48A0AndStep, ...)
BeginStringDisplay_BankF0_48A0::
Func_0F0_48A0:: ; address name
    ld de, StringCategories_F0_48B5
    call BeginStringDisplay
    ret
    db $11, $B5, $48, $CD, $FE, $25, $C9

; Func_0F0_48A0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 6 call sites from 6 routines (e.g. RunLinkSession8Exchange_Case01_Sub01_Table2_Case05, RunLinkSession8Exchange_Case01_Sub01_Table3_Case04, RunLinkSession8Exchange_Case01_Sub01_Table3_Case01, RunLinkSession8Case03Steps_ShowString_BankF0, ...)
ShowString_BankF0::
Func_0F0_48AE:: ; address name
    call BeginStringDisplay_BankF0_48A0
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_F0_48B5::
Data_0F0_48B5:: ; address name
    dw StringList_F0_48B7 ; id 0

; E-0217 (derived: category list of StringCategories_F0_48B5; one pointer per wStringIndex)
; record: string
StringList_F0_48B7::
Data_0F0_48B7:: ; address name
    dw String_F0_48B5_00_00 ; id 0
    dw String_F0_48B5_00_01 ; id 1
    dw String_F0_48B5_00_02 ; id 2
    dw String_F0_48B5_00_03 ; id 3
    dw String_F0_48B5_00_04 ; id 4
    dw String_F0_48B5_00_05 ; id 5
    dw String_F0_48B5_00_06 ; id 6
    dw String_F0_48B5_00_07 ; id 7
    dw String_F0_48B5_00_08 ; id 8
    dw String_F0_48B5_00_09 ; id 9
    dw String_F0_48B5_00_0A ; id 10
    dw String_F0_48B5_00_0B ; id 11
    dw String_F0_48B5_00_0C ; id 12
    dw String_F0_48B5_00_0D ; id 13
    dw String_F0_48B5_00_0E ; id 14
    dw String_F0_48B5_00_0F ; id 15
    dw String_F0_48B5_00_0F ; id 16
    dw String_F0_48B5_00_0F ; id 17
    dw String_F0_48B5_00_12 ; id 18
    dw String_F0_48B5_00_13 ; id 19
    dw String_F0_48B5_00_14 ; id 20
    dw String_F0_48B5_00_15 ; id 21
    dw String_F0_48B5_00_16 ; id 22
    dw String_F0_48B5_00_17 ; id 23
    dw String_F0_48B5_00_17 ; id 24
    dw String_F0_48B5_00_17 ; id 25
    dw String_F0_48B5_00_17 ; id 26
    dw String_F0_48B5_00_17 ; id 27
    dw String_F0_48B5_00_1C ; id 28
    dw String_F0_48B5_00_1D ; id 29
    dw String_F0_48B5_00_1E ; id 30
    dw String_F0_48B5_00_1F ; id 31
    dw String_F0_48B5_00_20 ; id 32
    dw String_F0_48B5_00_21 ; id 33
    dw String_F0_48B5_00_22 ; id 34

String_F0_48B5_00_00:: ; heuristic: string; C0
Data_0F0_48FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Obtain a Dream Egg", $F1
    db "from ", $F9, "m?", $F0

String_F0_48B5_00_01:: ; heuristic: string; C0
Data_0F0_491A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Give a Dream Egg", $F1
    db "to ", $F9, "m?", $F0

String_F0_48B5_00_02:: ; heuristic: string; C0
Data_0F0_4933:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Refused to accept", $F1
    db "a Dream Egg.", $F7
    db $F0

String_F0_48B5_00_03:: ; heuristic: string; C0
Data_0F0_4954:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Your Dream Egg was", $F1
    db "rejected.", $F7
    db $F0

String_F0_48B5_00_04:: ; heuristic: string; C0
Data_0F0_4973:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Choose the kind of", $F1
    db "egg to transfer.", $F0

String_F0_48B5_00_05:: ; heuristic: string; C0
Data_0F0_4998:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Choose the egg to", $F1
    db "be transferred.", $F0

String_F0_48B5_00_06:: ; heuristic: string; C0
Data_0F0_49BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Is it OK to", $F1
    db "transfer the egg?", $F0

String_F0_48B5_00_07:: ; heuristic: string; C0
Data_0F0_49DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "OK to save the egg", $F1
    db "trade results?", $F0

String_F0_48B5_00_08:: ; heuristic: string; C0
Data_0F0_49FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Please wait", $A4, $F0

String_F0_48B5_00_09:: ; heuristic: string; C0
Data_0F0_4A0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 received", $F1
    db "your egg.", $F7
    db $F0

String_F0_48B5_00_0A:: ; heuristic: string; C0
Data_0F0_4A23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Obtained an egg", $F1
    db "from ", $F9, "0.", $F7
    db $F0

String_F0_48B5_00_0B:: ; heuristic: string; C0
Data_0F0_4A3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Eggs were traded", $F1
    db "with ", $F9, "0.", $F7
    db $F0

String_F0_48B5_00_0C:: ; heuristic: string; C0
Data_0F0_4A5A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "G hatched", $F1
    db "from the egg that", $FA, $F7
    db $EF, $EE, "you put up for", $EF, $EE, "transfer.", $FA, $F7
    db $EF, $EE, "Please name your", $EF, $EE, $F9, "G.", $F7
    db $F0

String_F0_48B5_00_0D:: ; heuristic: string; C0
Data_0F0_4AAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "G hatched", $F1
    db "from the egg that", $FA, $F7
    db $EF, $EE, "you were about to", $EF, $EE, "receive.", $FA, $F7
    db $EF, $EE, $F9, "G went", $EF, $EE, "back to ", $F9, "0.", $F7
    db $F0

String_F0_48B5_00_0E:: ; heuristic: string; C0
Data_0F0_4B05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 received", $F1
    db $F9, "G", $95, "s egg.", $FA, $F7
    db $EF, $EE, "Please raise it", $EF, $EE, "with loving care.", $F7
    db $F0

String_F0_48B5_00_0F:: ; heuristic: string; C0
Data_0F0_4B43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "You have no eggs.", $F7
    db $F0

String_F0_48B5_00_12:: ; heuristic: string; C0
Data_0F0_4B57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Please wait", $A4, $F0

String_F0_48B5_00_13:: ; heuristic: string; C0
Data_0F0_4B65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "m has no Dream", $F1
    db "Egg to trade you.", $F7
    db $F0

String_F0_48B5_00_14:: ; heuristic: string; C0
Data_0F0_4B89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "There is no more", $F1
    db "room for eggs.", $FA, $F7
    db $EF, $EE, "Trading is not", $EF, $EE, "possible.", $F7
    db $F0

String_F0_48B5_00_15:: ; heuristic: string; C0
Data_0F0_4BC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "You have an egg", $F1
    db "already.", $FA, $F7
    db $EF, $EE, "Trading is not", $EF, $EE, "possible.", $F7
    db $F0

String_F0_48B5_00_16:: ; heuristic: string; C0
Data_0F0_4C00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "m already has", $F1
    db "a Dream Egg.", $F7
    db $F0

String_F0_48B5_00_17:: ; heuristic: string; C0
Data_0F0_4C1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiftExit", $F0

String_F0_48B5_00_1C:: ; heuristic: string; C0
Data_0F0_4C27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Store  Get", $F0

String_F0_48B5_00_1D:: ; heuristic: string; C0
Data_0F0_4C32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ally Store", $F0

String_F0_48B5_00_1E:: ; heuristic: string; C0
Data_0F0_4C3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOK", $F0

String_F0_48B5_00_1F:: ; heuristic: string; C0
Data_0F0_4C44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YesNo", $F0

String_F0_48B5_00_20:: ; heuristic: string; C0
Data_0F0_4C4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose what to", $F1
    db "give the egg.", $F0

String_F0_48B5_00_21:: ; heuristic: string; C0
Data_0F0_4C67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "W is in", $F1
    db "front of the egg.", $F7
    db $F0

String_F0_48B5_00_22:: ; heuristic: string; C0
Data_0F0_4C83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "W can't be", $F1
    db "given to an egg.", $F7
    db $F0

; only called from RunLinkSession8Exchange_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_LinkReceiveStepWithBuffer)
; reads: wFadeState, wScreenState, wTextFlags
; writes: wTitleScreenState
RunLinkSession8Exchange_Case01_WriteTitleScreenState::
Func_0F0_4CA0:: ; address name
    ld a, $01
    ld [wTitleScreenState], a
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenState]
    cp a, $04
    jr z, .read_screen_state
    ld a, [wTextFlags]
    bit 0, a
    ret nz

.read_screen_state:
    ld a, [wScreenState]
    rst $00
    dw RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc
    dw RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_ToRunLinkSession8Case03Steps
    dw RunLinkSession8Exchange_ShowMessage
    dw RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case05
    dw RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case06
    dw RunLinkSession8Exchange_ObjectSceneThenSave
    dw RunLinkSession8Exchange_ObtainedEgg
    dw RunLinkSession8Exchange_EggsTraded
    dw RunLinkSession8Exchange_ObjectScene
    dw RunLinkSession8Exchange_EggHatched
    dw RunLinkSession8Exchange_WaitForPartner

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc::
Jump_0F0_4CD5:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, .read_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case00
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case03
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case05
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession8Exchange_Case01_Sub01_Table2_Case07

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table2_Case00::
Jump_0F0_4D02:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $BA
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table2_Case01::
Jump_0F0_4D0F:: ; address name
    ld a, [wLinkMessage]
    cp a, $BA
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wPlayerId
; writes: wScreenStep, wBankF0ByteA3, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, ...
; points at: wPlayerName, wLinkRecvBuffer, wLinkPartnerName
RunLinkSession8Exchange_Case01_Sub01_Table2_Case02::
Jump_0F0_4D21:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wPlayerName
    ld de, wLinkRecvBuffer
    ld c, $0A

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .read_player_id
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.read_player_id:
    ld a, $F0
    ld [de], a
    ld a, [wPlayerId]
    ld [wBankF0ByteA3], a
    ld hl, $000C
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wLinkReady, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table2_Case03::
Jump_0F0_4D70:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wLinkPartnerName, wTextBuf3
RunLinkSession8Exchange_Case01_Sub01_Table2_Case04::
Jump_0F0_4D86:: ; address name
    ld hl, wLinkPartnerName
    ld de, wTextBuf3
    ld c, $0A

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .check_screen_step
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, .loop

.check_screen_step:
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wGiftRecord
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wFamilyRankTaken, wTextWindowTileLo, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table2_Case05::
Jump_0F0_4DA4:: ; address name
    ld hl, wFamilyRankTaken
    ld b, $35

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call ShowString_BankF0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wGiftRecord]
    and a, a
    jr z, .call_begin_string_bank_f0_cat0
    ld a, $01
    jr .call_begin_string_bank_f0_cat02

.call_begin_string_bank_f0_cat0:
    xor a, a

.call_begin_string_bank_f0_cat02:
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wChoiceCursorF0
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table2_Case06::
Jump_0F0_4DF0:: ; address name
    ld de, TileRect_F0_663F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wChoiceCursorF0], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wChoiceCursorF0
; writes: wArg2, wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table2_Case07::
Jump_0F0_4E11:: ; address name
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, .check_choice_cursor_f0
    cp a, $FE
    jr z, .clear_screen_step
    ret

.check_choice_cursor_f0:
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, .clear_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $05
    ld [wScreenState], a
    ld a, $07 ; 'OK to save the egg trade'
    call BeginString_BankF0_Cat0
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08 ; 'Please wait'
    call BeginString_BankF0_Cat0
    ld a, $BD
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case01::
Jump_0F0_4E54:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, .call_run_link_session8_case01_steps
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

.call_run_link_session8_case01_steps:
    call RunLinkSession8Case01Steps
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case02::
Jump_0F0_4E71:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, .read_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case00
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case03
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table3_Case05

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table3_Case00::
Jump_0F0_4E9A:: ; address name
    ld a, $06 ; 'Is it OK to transfer the'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
; points at: wTextWindowTileLo
RunLinkSession8Exchange_Case01_Sub01_Table3_Case01::
Jump_0F0_4EA4:: ; address name
    ld de, TileRect_F0_665D
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $BC
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case01_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call ShowString_BankF0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wChoiceCursorF0, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table3_Case02::
Jump_0F0_4EFE:: ; address name
    ld de, TileRect_F0_6617
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wChoiceCursorF0], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wChoiceCursorF0
; writes: wArg2, wScreenStep, wScreenSubStep, wScreenState, wF0ScreenKind
; points at: wScreenStep, wScreenState
RunLinkSession8Exchange_Case01_Sub01_Table3_Case03::
Jump_0F0_4F22:: ; address name
    xor a, a
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, .check_choice_cursor_f0
    cp a, $FE
    jr z, .call_begin_string_bank_f0_cat02
    ret

.check_choice_cursor_f0:
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, .call_begin_string_bank_f0_cat0
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld hl, wScreenState
    inc [hl]
    ret

.call_begin_string_bank_f0_cat0:
    ld a, $07 ; 'OK to save the egg trade'
    call BeginString_BankF0_Cat0
    xor a, a
    ld [wScreenStep], a
    ld a, $05
    ld [wScreenState], a
    xor a, a
    ld [wF0ScreenKind], a
    ret

.call_begin_string_bank_f0_cat02:
    ld a, $05 ; 'Choose the egg to be transferred.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wTextWindowTileLo, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table3_Case04::
Jump_0F0_4F64:: ; address name
    ld de, TileRect_F0_6685
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $C3
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case01_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wStringCategory], a
    ld a, $1D
    ld [wStringIndex], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call ShowString_BankF0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursorF0
; writes: wScreenSubStep, wScreenState, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table3_Case05::
Jump_0F0_4FBB:: ; address name
    ld de, TileRect_F0_65FB
    ld hl, wWindowTileBuffer + $125
    ld bc, $0704
    call CopyRectTo20ByteRows_BankF0
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case05_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenState], a
    ld a, $06
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
RunLinkSession8Exchange_Case01_Sub01_ToRunLinkSession8Case03Steps::
Jump_0F0_4FED:: ; address name
    call RunLinkSession8Case03Steps
    ret

; shows a category-0 string, then text waits
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession8Exchange_ShowMessage::
Jump_0F0_4FF1:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_ShowMessage_BeginString_BankF0_Cat0
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags_Case01
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags_Case02
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags

; entry 1 of the `rst $00` table in RunLinkSession8Exchange_ShowMessage
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_ShowMessage_WaitTextFlags_Case01::
Jump_0F0_4FFD:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession8Exchange_ShowMessage
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_ShowMessage_WaitTextFlags_Case02::
Jump_0F0_5010:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 0 of the `rst $00` table in RunLinkSession8Exchange_ShowMessage
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkSendByte, wLinkRole
; writes: wLinkSendByte
; points at: wScreenStep
RunLinkSession8Exchange_ShowMessage_BeginString_BankF0_Cat0::
Jump_0F0_5028:: ; address name
    ld a, [wLinkMessage]
    cp a, $BB
    jr z, .clear_link_send_byte
    cp a, $BD
    ret nz
    ld a, [wLinkSendByte]
    cp a, $BB
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .skip
    jr .clear_link_send_byte

.skip:
    ld b, $03
    jr .clear_link_send_byte2

.clear_link_send_byte:
    ld b, $02

.clear_link_send_byte2:
    xor a, a
    ld [wLinkSendByte], a
    ld a, b
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkSession8Exchange_ShowMessage; also entry 3 of the table in RunLinkSession8Exchange_WaitForPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rSVBK, wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
RunLinkSession8Exchange_ShowMessage_WaitTextFlags::
Jump_0F0_5055:: ; address name
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
    xor a, a
    ldh [rSVBK], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case05::
Jump_0F0_507B:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, .read_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case00
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case03
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table4_Case05

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table4_Case01::
Jump_0F0_50A4:: ; address name
    farcall CopyRect70C5ToWC364AndDraw
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wPickCount
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table4_Case02::
Jump_0F0_50AF:: ; address name
    farcall ShowSaveFileInfoWindow
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wPickCount], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table4_Case03::
Jump_0F0_50BF:: ; address name
    farcall DrawBottomBoxForLinkAndSetScreenSubStep
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wTextWindowTileLo, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table4_Case00::
Jump_0F0_50D7:: ; address name
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, Tiles1Plus6A0Tiles_1F_4A60
    ld hl, vTiles1 + $6A0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7D0Tiles_1F_4A40
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, TileRect_F0_66AD
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call ShowString_BankF0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wChoiceCursorF0], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wChoiceCursorF0
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table4_Case04::
Jump_0F0_5155:: ; address name
    ld de, TileRect_F0_663F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    xor a, a
    ld [wChoiceCursorF0], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wChoiceCursorF0
; writes: wArg2, wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
; points at: wScreenState
RunLinkSession8Exchange_Case01_Sub01_Table4_Case05::
Jump_0F0_5176:: ; address name
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, .check_choice_cursor_f0
    cp a, $FE
    jr z, .clear_screen_step
    ret

.check_choice_cursor_f0:
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, .clear_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $08 ; 'Please wait'
    call BeginString_BankF0_Cat0
    ld hl, wScreenState
    inc [hl]
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08 ; 'Please wait'
    call BeginString_BankF0_Cat0
    ld a, $BD
    ld [wLinkSendByte], a
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case06::
Jump_0F0_51B8:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, .read_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case00
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case03
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case05
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case06
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case09
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case0D
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case01
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case02
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case11
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case04
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case13
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case14
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case15
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case16
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case17
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case18
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case19
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case1A
    dw RunLinkSession8Exchange_Case01_Sub01_Table5_Case1B

; entry 21 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table5_Case15::
Jump_0F0_520D:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $B3
    ld [wLinkSendByte], a
    ret

; entry 24 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteEE, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table5_Case18::
Jump_0F0_521A:: ; address name
    ld a, [wScreenByteEE]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $A8
    ld [wLinkSendByte], a
    ret

; entry 22 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case16::
Jump_0F0_522C:: ; address name
    ld a, [wLinkMessage]
    cp a, $B3
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case19::
Jump_0F0_523E:: ; address name
    ld a, [wLinkMessage]
    cp a, $A8
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table5_Case1A::
Jump_0F0_5250:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $B6
    ld [wLinkSendByte], a
    ret

; entry 27 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wF0ScreenKind, wScreenState
; writes: wLinkSendByte, wScreenState, wScreenStep, wScreenSubStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case1B::
Jump_0F0_525D:: ; address name
    ld a, [wLinkMessage]
    cp a, $B6
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wF0ScreenKind]
    ld b, a
    ld a, [wScreenState]
    add a, b
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; entry 9 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wGiftRecord, wScreenStep
; writes: wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wRecordBufA, wGiftRecord
RunLinkSession8Exchange_Case01_Sub01_Table5_Case09::
Jump_0F0_527B:: ; address name
    ld a, [wGiftRecord]
    and a, a
    jr nz, .check_screen_step
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table5_Case09_Data
    jr .check_screen_step2

.check_screen_step:
    ld hl, wGiftRecord

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $00A5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufA
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 13 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wGM2TimerFrames, wRecordBufB
RunLinkSession8Exchange_Case01_Sub01_Table5_Case0D::
Jump_0F0_52B9:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wGM2TimerFrames
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $00D8
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufB
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 17 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wBankF0Byte99, wFamilyBitCount, wRankBand, wGiftRecord, wScreenStep
; writes: wBankF0BlockA7, wFamilyBitCount, wBankF0ByteA8, wBankF0ByteA9, wBankF0ByteAA, wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, ...
; points at: wPlayerName, wBankF0BlockAB, wBankF0BlockA7, wBankF0BlockC7
RunLinkSession8Exchange_Case01_Sub01_Table5_Case11::
Jump_0F0_52EC:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, .set_bank_f0_block_a7_to_01
    xor a, a
    jr .set_bank_f0_block_a7

.set_bank_f0_block_a7_to_01:
    ld a, $01

.set_bank_f0_block_a7:
    ld [wBankF0BlockA7], a
    ld a, [wBankF0Byte99]
    and a, a
    jp z, .read_gift_record
    call RankFamilyScoresIntoFamilyRanking
    call LoadTopSpeciesLoSpeciesStatsToTopSpeciesGrowth
    ld a, [wFamilyBitCount]
    ld c, a
    ld a, [wRankBand]
    ld b, a
    ld a, $08
    sub a, b
    call Multiply8
    ld a, $05
    call DivideHLByA
    ld a, l
    ld [wFamilyBitCount], a
    call RaiseRandomLowestResistance

.read_gift_record:
    ld a, [wGiftRecord + MON_SPECIES]
    ld [wBankF0ByteA8], a
    ld a, [wGiftRecord + MON_SPECIES + 1]
    ld [wBankF0ByteA9], a
    ld a, [wGiftRecord + MON_FAMILY]
    ld [wBankF0ByteAA], a
    ld hl, wPlayerName
    ld de, wBankF0BlockAB
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wBankF0BlockA7
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $0010
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wBankF0BlockC7
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $00
    ld [wLinkReady], a
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0; also entries 7, 11, 15 of the table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_Case01_Sub01_Table5_Case01::
Jump_0F0_5379:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $BA
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0; also entries 8, 12, 16 of the table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case02::
Jump_0F0_5386:: ; address name
    ld a, [wLinkMessage]
    cp a, $BA
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wF0ScreenKind, wGiftRecord, wBankF0ByteA3, wScreenStep
; writes: wLinkRecvBuffer, wBattleSetupByte98, wBankF0Byte99, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case00::
Jump_0F0_5398:: ; address name
    ld a, [wF0ScreenKind]
    ld [wLinkRecvBuffer], a
    ld a, [wGiftRecord]
    ld [wBattleSetupByte98], a
    ld a, [wBankF0ByteA3]
    ld b, a
    call MarkBitBInFamilyBitsAndCount
    call RollMarkChangeCountChance
    ld [wBankF0Byte99], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wLinkRecvBuffer, wLinkPartnerName
RunLinkSession8Exchange_Case01_Sub01_Table5_Case03::
Jump_0F0_53B9:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, $0003
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0; also entries 10, 14, 18 of the table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wLinkReady, wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case04::
Jump_0F0_53EC:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wGiftRecord, wLinkPartnerByte1, wScreenStep
; writes: wScreenStep
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case05::
Jump_0F0_5402:: ; address name
    ld a, [wGiftRecord]
    and a, a
    jr nz, .check_link_partner_byte1
    ld a, [wLinkPartnerByte1]
    and a, a
    jr z, .call_begin_string_bank_f0_cat02
    jr .read_screen_step

.check_link_partner_byte1:
    ld a, [wLinkPartnerByte1]
    and a, a
    jr nz, .call_begin_string_bank_f0_cat0

.read_screen_step:
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

.call_begin_string_bank_f0_cat0:
    ld a, $16 ; 'm already has a Dream Egg.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

.call_begin_string_bank_f0_cat02:
    ld a, $13 ; 'm has no Dream Egg to'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep, wScreenStep, wScreenState
RunLinkSession8Exchange_Case01_Sub01_Table5_Case06::
Jump_0F0_5433:: ; address name
    ld a, $12 ; 'Please wait'
    call BeginString_BankF0_Cat0
    xor a, a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $04
    ld [wScreenState], a
    ret

; entry 19 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wBankF0Byte99, wLinkPartnerByte2, wGiftRecord
; writes: wF0ScreenKind
; points at: wScreenStep
RunLinkSession8Exchange_Case01_Sub01_Table5_Case13::
Jump_0F0_5447:: ; address name
    ld a, [wBankF0Byte99]
    and a, a
    jr nz, .skip
    ld a, [wLinkPartnerByte2]
    and a, a
    jr nz, .skip2
    ld a, [wGiftRecord]
    and a, a
    jr nz, .clear_f0_screen_kind
    ld a, $01
    jr .set_f0_screen_kind

.skip:
    ld a, $03
    jr .set_f0_screen_kind

.skip2:
    ld a, $04
    jr .set_f0_screen_kind

.clear_f0_screen_kind:
    xor a, a

.set_f0_screen_kind:
    ld [wF0ScreenKind], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wF0ScreenKind
; writes: wPickCount
; points at: wScreenStep, wRecordBufA, wGiftRecord, wRecordBufB, wGM2TimerFrames
RunLinkSession8Exchange_Case01_Sub01_Table5_Case14::
Jump_0F0_546E:: ; address name
    ld a, [wF0ScreenKind]
    and a, a
    jr z, .skip
    cp a, $01
    jr z, .skip2
    cp a, $02
    jr z, .skip2
    cp a, $03
    jp z, .skip3
    jr .skip3

.skip:
    ld hl, wGM2TimerFrames
    ld b, $D8

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    jr .skip3

.skip2:
    ld hl, wRecordBufA
    ld a, $01
    ld [hl], a
    ld de, wGiftRecord
    ld b, $A5

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld hl, wRecordBufB
    ld de, wGM2TimerFrames
    ld b, $33

.loop3:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    jr .skip3

.skip3:
    ld hl, wScreenStep
    inc [hl]
    xor a, a
    ld [wPickCount], a
    ret

; entry 23 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wSGBActive
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hSpriteWindowClipMode, ...
RunLinkSession8Exchange_Case01_Sub01_Table5_Case17::
Jump_0F0_54B9:: ; address name
    call BGMapAddressAtScroll_BankF0
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
    call Run67EEWithArg1ForF0ScreenKind
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wSGBActive]
    and a, a
    jr z, .return
    ld a, $02
    ret

.return:
    ret

; by wScreenSubStep: timed waits and moves of field objects 1 and 5, then RunSaveGameSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave::
Jump_0F0_54FA:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5_Case07
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep_Case0A
    dw RunLinkSession8Exchange_ObjectSceneThenSave_ShowHeroReceivedYourEgg
    dw RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps

; entry 12 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entry 12 of the table in RunLinkSession8Exchange_ObtainedEgg; entry 16 of the table in RunLinkSession8Exchange_EggsTraded; entry 34 of the table in RunLinkSession8Exchange_ObjectScene; entry 31 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSaveStep
; writes: wScreenStep, wScreenSubStep, wScreenState
RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps::
Jump_0F0_5518:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0C
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entry 4 of the table in RunLinkSession8Exchange_ObtainedEgg; entry 1 of the table in RunLinkSession8Exchange_EggsTraded; entry 1 of the table in RunLinkSession8Exchange_ObjectScene; entry 5 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep::
Jump_0F0_5537:: ; address name
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $38
    ret nz
    ld a, [wSpriteSlots + $D]
    set 1, a
    ld [wSpriteSlots + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entry 1 of the table in RunLinkSession8Exchange_ObtainedEgg; entry 4 of the table in RunLinkSession8Exchange_EggsTraded; entry 5 of the table in RunLinkSession8Exchange_ObjectScene; entry 1 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep::
Jump_0F0_5558:: ; address name
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wObject1 + OBJ_X], a
    ld a, [wObject1 + OBJ_FLAGS]
    set 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 0 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entries 2, 5, 6, 8, 9 of the table in RunLinkSession8Exchange_ObjectSceneThenSave; entries 0, 2, 5, 6, 8, 9 of the table in RunLinkSession8Exchange_ObtainedEgg; entries 0, 2, 5, 6, 8, 9, 11, 12 of the table in RunLinkSession8Exchange_EggsTraded; entries 0, 2, 4, 6, 7, 12, 13, 14, 16, 18, 20, 22, 24, 25, 27, 29 of the table in RunLinkSession8Exchange_ObjectScene; entries 0, 2, 4, 6, 7, 12, 13, 14, 16, 18, 20, 22, 24, 25, 27, 29 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep::
Jump_0F0_557E:: ; address name
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    ret c
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entry 3 of the table in RunLinkSession8Exchange_ObtainedEgg; entries 3, 10 of the table in RunLinkSession8Exchange_EggsTraded; entry 3 of the table in RunLinkSession8Exchange_ObjectScene; entry 3 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5::
Jump_0F0_5594:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 7 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave; also entry 7 of the table in RunLinkSession8Exchange_ObtainedEgg; entries 7, 13 of the table in RunLinkSession8Exchange_EggsTraded
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5_Case07::
Jump_0F0_55A6:: ; address name
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep_Case0A::
Jump_0F0_55B6:: ; address name
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession8Exchange_ObjectSceneThenSave
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
RunLinkSession8Exchange_ObjectSceneThenSave_ShowHeroReceivedYourEgg::
Jump_0F0_55DC:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $09 ; '0 received your egg.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; by wScreenSubStep: an object animation, then 'Obtained an egg from 0.'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession8Exchange_ObtainedEgg::
Jump_0F0_55FB:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5_Case07
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObtainedEgg_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObtainedEgg_ShowObtainedAnEggFrom
    dw RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps

; entry 10 of the `rst $00` table in RunLinkSession8Exchange_ObtainedEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
RunLinkSession8Exchange_ObtainedEgg_WriteSpriteSlotsAndScreenSubStep::
Jump_0F0_5619:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession8Exchange_ObtainedEgg
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
RunLinkSession8Exchange_ObtainedEgg_ShowObtainedAnEggFrom::
Jump_0F0_563F:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $0A ; 'Obtained an egg from 0.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; by wScreenSubStep: an object animation, then 'Eggs were traded with 0.'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession8Exchange_EggsTraded::
Jump_0F0_565E:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5_Case07
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5_Case07
    dw RunLinkSession8Exchange_EggsTraded_StepObjectCB9AUpToE0
    dw RunLinkSession8Exchange_EggsTraded_ShowEggsWereTradedWith
    dw RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps

; entry 14 of the `rst $00` table in RunLinkSession8Exchange_EggsTraded
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject1, wScreenSubStep
; writes: wSpriteSlots, wObject1, wScreenSubStep
RunLinkSession8Exchange_EggsTraded_StepObjectCB9AUpToE0::
Jump_0F0_5684:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    call StepObjectCB9AUpToE0
    call StepObjectCB8ADownToE0
    cp a, $FF
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; wSpriteSlots + $7 = 3; while wSpriteSlots + $9 & 3 is set, wSpriteSlots + $B -= 1 and A = $FF once it reaches $E0; otherwise A = 0 (E-0126)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_EggsTraded_StepObjectCB9AUpToE0)
; reads: wSpriteSlots
; writes: wSpriteSlots
StepObjectCB8ADownToE0::
Func_0F0_56A5:: ; address name
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    jr z, .return_0
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    jr nz, .return_0
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; wObject1 + $7 = 1; while wObject1 + $9 & 3 is set, wObject1 + $B += 1 up to $E0 (E-0126)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_EggsTraded_StepObjectCB9AUpToE0)
; reads: wObject1
; writes: wObject1
StepObjectCB9AUpToE0::
Func_0F0_56C2:: ; address name
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $E0
    ret nz
    ret

; entry 15 of the `rst $00` table in RunLinkSession8Exchange_EggsTraded
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
RunLinkSession8Exchange_EggsTraded_ShowEggsWereTradedWith::
Jump_0F0_56D9:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $0B ; 'Eggs were traded with 0.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; by wScreenSubStep: the steps of RunLinkSession8Exchange_ObjectSceneThenSave in another order
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession8Exchange_ObjectScene::
Jump_0F0_56F8:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_RunFieldCommandTemp0
    dw RunLinkSession8Exchange_ObjectScene_SetSpriteSlotsPlus7
    dw RunLinkSession8Exchange_ObjectScene_QueueSoundEffect
    dw RunLinkSession8Exchange_ObjectScene_StepScreenStepOffsetTableEvery4Frames
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_WriteObject2AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_WriteObject2AndSpriteSlotsEtc
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_ShowGHatchedFromThe
    dw RunLinkSession8Exchange_ObjectScene_CopyRectTo20ByteRows_BankF0
    dw RunLinkSession8Exchange_ObjectScene_RunTextUntilTextWindowStateDone_BankF0
    dw RunLinkSession8Exchange_ObjectScene_GameMode6_Update
    dw RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps

; entry 32 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteEE, wScreenSubStep
; writes: wScreenSubStep
RunLinkSession8Exchange_ObjectScene_RunTextUntilTextWindowStateDone_BankF0::
Jump_0F0_5742:: ; address name
    ld a, [wScreenByteEE]
    and a, a
    ret nz
    call RunTextUntilTextWindowStateDone_BankF0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 31 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep, wBattleScene, wSpriteSlotCount, wNameEntryState, wNameEntrySubState, wScreenByteEE
RunLinkSession8Exchange_ObjectScene_CopyRectTo20ByteRows_BankF0::
Jump_0F0_5752:: ; address name
    ld de, TileRect_F0_68E6
    ld hl, wWindowTileBuffer + $64
    ld bc, $140D
    call CopyRectTo20ByteRows_BankF0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wBattleScene], a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, $01
    ld [wScreenByteEE], a
    ret

; entry 33 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wScreenStep, wScreenSubStep, wLinkByteE8, wLinkByteE9, wLinkByteEA, wModeChangeRequest
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkByteE8, wLinkByteE9, wLinkByteEA, wModeChangeRequest, wGameMode, ...
; points at: wGM2TimerFrames
RunLinkSession8Exchange_ObjectScene_GameMode6_Update::
Jump_0F0_5779:: ; address name
    ld a, [wScreenState]
    ld l, a
    ld a, [wScreenStep]
    ld h, a
    ld a, [wScreenSubStep]
    ld e, a
    push hl
    push de
    ld a, [wLinkByteE8]
    ld [wScreenState], a
    ld a, [wLinkByteE9]
    ld [wScreenStep], a
    ld a, [wLinkByteEA]
    ld [wScreenSubStep], a
    farcall GameMode6_Update
    ld a, [wScreenState]
    ld [wLinkByteE8], a
    ld a, [wScreenStep]
    ld [wLinkByteE9], a
    ld a, [wScreenSubStep]
    ld [wLinkByteEA], a
    pop de
    pop hl
    ld a, l
    ld [wScreenState], a
    ld a, h
    ld [wScreenStep], a
    ld a, e
    ld [wScreenSubStep], a
    ld a, [wModeChangeRequest]
    and a, a
    ret z
    xor a, a
    ld [wModeChangeRequest], a
    ld a, $07
    ld [wGameMode], a
    ld a, $0A
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld a, $22
    ld [wScreenSubStep], a
    ld hl, wGM2TimerFrames
    ld bc, $00D8

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 8 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, hTemp0, wObject5, wScreenCounter, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_RunFieldCommandTemp0::
Jump_0F0_57F0:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $20
    ret nz
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a, a
    ld [wScreenCounter], a
    ld a, [wSpriteSlots + $D]
    set 1, a
    ld [wSpriteSlots + $D], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 9 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_SetSpriteSlotsPlus7::
Jump_0F0_583B:: ; address name
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 15 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene; also entries 19, 23 of the table in RunLinkSession8Exchange_ObjectScene; entries 17, 21 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject2, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F::
Jump_0F0_5848:: ; address name
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 17 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene; also entry 21 of the table in RunLinkSession8Exchange_ObjectScene; entries 15, 19, 23 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject2, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_SetObject2Plus7::
Jump_0F0_5855:: ; address name
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 26 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_WriteObject2AndScreenSubStep::
Jump_0F0_5862:: ; address name
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    cp a, $30
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; while wObject1 + $9 & 3 is set: wObject1 + $B -= 1; at $60 runs field command $0E and sets wObject5 + $4/4; at $58 sets bit 1 of wObject1 + $D and wScreenSubStep += 1 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, hTemp0, wObject5, wScreenCounter, wScreenSubStep
StepObjectCB9AAndTriggerAt60:: ; heuristic: follows a terminator; C0
Func_0F0_5888:: ; address name
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $60
    jr nz, .check_object1
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a, a
    ld [wScreenCounter], a

.check_object1:
    ld a, [wObject1 + OBJ_X]
    cp a, $59
    ret nc
    ld a, $58
    ld [wObject1 + OBJ_X], a
    ld a, [wObject1 + OBJ_FLAGS]
    set 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene; also entry 10 of the table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wSpriteSlotCount, wScreenSubStep
; writes: wScreenCounter, wObject5, wSpriteSlotCount, wScreenSubStep, wScreenStep
RunLinkSession8Exchange_ObjectScene_QueueSoundEffect::
Jump_0F0_58CD:: ; address name
    ld a, [wScreenCounter]
    cp a, $BA
    jr nz, .check_screen_counter
    ld a, $74
    call QueueSoundEffect

.check_screen_counter:
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $D9
    ret c
    xor a, a
    ld [wScreenCounter], a
    xor a, a
    ld [wObject5], a
    ld a, [wSpriteSlotCount]
    inc a
    ld [wSpriteSlotCount], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
RunLinkSession8Exchange_ObjectScene_StepScreenStepOffsetTableEvery4Frames::
Jump_0F0_58FE:: ; address name
    ld de, wObject1 + OBJ_Y
    call StepScreenStepOffsetTableEvery4Frames
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

; entry 28 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wSpriteSlots, wScreenSubStep
; writes: wObject2, wSpriteSlots, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_WriteObject2AndSpriteSlotsEtc::
Jump_0F0_590A:: ; address name
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld [wObject2 + OBJ_STATE], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 30 of the `rst $00` table in RunLinkSession8Exchange_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wLinkByteE8, wLinkByteE9, wLinkByteEA, wLinkByteEB
; points at: wBankF0ByteA8, wTextBuf1, wScreenSubStep
RunLinkSession8Exchange_ObjectScene_ShowGHatchedFromThe::
Jump_0F0_593A:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0ByteA8
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0C ; 'G hatched from the egg that'
    call BeginString_BankF0_Cat0
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld hl, wScreenSubStep
    inc [hl]
    ld a, $02
    ld [wLinkByteE8], a
    ld a, $00
    ld [wLinkByteE9], a
    ld a, $01
    ld [wLinkByteEA], a
    ld a, $01
    ld [wLinkByteEB], a
    ret

; by wScreenSubStep: an object animation, then 'G hatched from the egg that ...'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunLinkSession8Exchange_EggHatched::
Jump_0F0_5967:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteObject1AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_SetObject5
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteSpriteSlotsAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_EggHatched_RunFieldCommandTemp0
    dw RunLinkSession8Exchange_EggHatched_SetObject1Plus7
    dw RunLinkSession8Exchange_ObjectScene_QueueSoundEffect
    dw RunLinkSession8Exchange_EggHatched_ToStepScreenStepOffsetTableEvery4Frames
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7_Case0F
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectScene_SetObject2Plus7
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_EggHatched_WriteObject2AndScreenSubStep
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_EggHatched_WriteSpriteSlotsAndObject1Etc
    dw RunLinkSession8Exchange_ObjectSceneThenSave_WriteScreenCounterAndScreenSubStep
    dw RunLinkSession8Exchange_EggHatched_ShowGHatchedFromThe
    dw RunLinkSession8Exchange_ObjectSceneThenSave_RunSaveGameSteps

; entry 8 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, hTemp0, wObject5, wScreenCounter, wScreenSubStep
RunLinkSession8Exchange_EggHatched_RunFieldCommandTemp0::
Jump_0F0_59AB:: ; address name
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $70
    ret nz
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a, a
    ld [wScreenCounter], a
    ld a, [wObject1 + OBJ_FLAGS]
    set 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, $00
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 9 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject1, wScreenSubStep
RunLinkSession8Exchange_EggHatched_SetObject1Plus7::
Jump_0F0_59F6:: ; address name
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 26 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
RunLinkSession8Exchange_EggHatched_WriteObject2AndScreenSubStep::
Jump_0F0_5A03:: ; address name
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp a, $60
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; while wSpriteSlots + $9 & 3 is set: wSpriteSlots + $B += 1; at $30 runs field command $0E and sets wObject5 + $4/4; at $38 sets bit 1 of wSpriteSlots + $D and wScreenSubStep += 1 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, hTemp0, wObject5, wScreenCounter, wScreenSubStep
StepObjectCB8AAndTriggerAt30:: ; heuristic: follows a terminator; C0
Func_0F0_5A29:: ; address name
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $30
    jr nz, .check_sprite_slots
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a, a
    ld [wScreenCounter], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $B]
    cp a, $38
    ret nz
    ld [wSpriteSlots + $B], a
    ld a, [wSpriteSlots + $D]
    set 1, a
    ld [wSpriteSlots + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
RunLinkSession8Exchange_EggHatched_ToStepScreenStepOffsetTableEvery4Frames::
Jump_0F0_5A6C:: ; address name
    ld de, wSpriteSlots + $C
    call StepScreenStepOffsetTableEvery4Frames
    ret

; entry 28 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject1, wObject2, wScreenSubStep
; writes: wSpriteSlots, wObject1, wObject2, wScreenSubStep
RunLinkSession8Exchange_EggHatched_WriteSpriteSlotsAndObject1Etc::
Jump_0F0_5A73:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 30 of the `rst $00` table in RunLinkSession8Exchange_EggHatched
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wBankF0ByteC8, wTextBuf1, wScreenSubStep
RunLinkSession8Exchange_EggHatched_ShowGHatchedFromThe::
Jump_0F0_5AA3:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld hl, wBankF0ByteC8
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0D ; 'G hatched from the egg that'
    call BeginString_BankF0_Cat0
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; by wScreenStep: 'Please wait', then a link message wait
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkSession8Exchange_WaitForPartner::
Jump_0F0_5ACE:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Exchange_WaitForPartner_ToBeginString_BankF0_Cat0AndStep
    dw RunLinkSession8Exchange_WaitForPartner_SetScreenStep
    dw RunLinkSession8Exchange_WaitForPartner_WaitLinkMessage
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags

; entry 0 of the `rst $00` table in RunLinkSession8Exchange_WaitForPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Exchange_WaitForPartner_ToBeginString_BankF0_Cat0AndStep::
Jump_0F0_5ADA:: ; address name
    ld a, $08 ; 'Please wait'
    call BeginString_BankF0_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession8Exchange_WaitForPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkSession8Exchange_WaitForPartner_SetScreenStep::
Jump_0F0_5AE7:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $BA
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession8Exchange_WaitForPartner
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkSession8Exchange_WaitForPartner_WaitLinkMessage::
Jump_0F0_5AF4:: ; address name
    ld a, [wLinkMessage]
    cp a, $BA
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; every fourth frame adds Data_0F0_5B39[wScreenStep] to [DE] and advances wScreenStep; the $80 end mark advances wScreenSubStep and resets (E-0124)
; 2 call sites from 2 routines (e.g. RunLinkSession8Exchange_ObjectScene_StepScreenStepOffsetTableEvery4Frames, RunLinkSession8Exchange_EggHatched_ToStepScreenStepOffsetTableEvery4Frames)
; reads: wScreenCounter, wScreenStep, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep, wScreenStep
; points at: wScreenStep
StepScreenStepOffsetTableEvery4Frames::
Func_0F0_5B06:: ; address name
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    and a, $03
    and a, a
    ret nz
    ld a, [wScreenStep]
    ld hl, StepScreenStepOffsetTableEvery4Frames_Data
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    jr z, .check_screen_sub_step
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    ld hl, wScreenStep
    inc [hl]
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenCounter], a
    ret

; address loaded by StepScreenStepOffsetTableEvery4Frames
StepScreenStepOffsetTableEvery4Frames_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_5B39:: ; address name
    db $FD, $FD, $FE, $00, $01, $01, $03, $03, $80

; copies bytes from HL to DE until a $F0 or B bytes, then writes $F0; HL and DE advance (E-0078)
; 4 call sites from 4 routines (e.g. RunLinkSession8Exchange_ObjectSceneThenSave_ShowHeroReceivedYourEgg, RunLinkSession8Exchange_ObtainedEgg_ShowObtainedAnEggFrom, RunLinkSession8Exchange_EggsTraded_ShowEggsWereTradedWith, RunLinkSession8Exchange_EggHatched_ShowGHatchedFromThe)
CopyStringMaxBToDE::
Func_0F0_5B42:: ; address name
    ld a, [hl+]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc de
    dec b
    jr nz, CopyStringMaxBToDE

.done:
    ld a, $F0
    ld [de], a
    ret

; runs the routine for wScreenStep (jump table of ten) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_WriteScreenStepAndScreenSubStepEtc_Case01)
; reads: wScreenStep
RunLinkSession8Case01Steps::
Func_0F0_5B50:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Case01Steps_ToLoadTileList6DC4SixPerFrame
    dw RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet
    dw RunLinkSession8Case01Steps_FillTilesBxC
    dw RunLinkSession8Case01Steps_ClampRecordListPageCursor4
    dw RunLinkSession8Case01Steps_DrawRecordListPageSpeciesNames
    dw RunLinkSession8Case01Steps_DrawRecordListPageMarks
    dw RunLinkSession8Case01Steps_UpdatePagedListCursor
    dw RunLinkSession8Case01Steps_CopyScreenBufferRectWithAttrs_F0
    dw RunLinkSession8Case01Steps_BGMapAddressAtScroll_BankF0
    dw RunLinkSession8Case01Steps_ShowChooseTheKindOf

; entry 0 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
RunLinkSession8Case01Steps_ToLoadTileList6DC4SixPerFrame::
Jump_0F0_5B68:: ; address name
    farcall LoadTileList6DC4SixPerFrame
    ret

; entry 1 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursorF0, wScreenStep
; writes: wScreenStep
RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet::
Jump_0F0_5B6F:: ; address name
    ld de, TileRect_F0_5BA0
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case05_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_F0_5BA0::
Data_0F0_5BA0:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; entry 2 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
RunLinkSession8Case01Steps_FillTilesBxC::
Jump_0F0_5C15:: ; address name
    ld hl, vTiles1 + $3F0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $6A0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunLinkSession8Case01Steps_ClampRecordListPageCursor4::
Jump_0F0_5C57:: ; address name
    ld de, TileRect_F0_6530
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, .call_bg_map_address_at_scroll_bank_f0
    ld de, $010E
    call DrawC5BEC6AtScrollOffsetDE_BankF0
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_BankF0
    ld de, $010F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset_BankF0
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_BankF0

.call_bg_map_address_at_scroll_bank_f0:
    call BGMapAddressAtScroll_BankF0
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
RunLinkSession8Case01Steps_DrawRecordListPageSpeciesNames::
Jump_0F0_5CAC:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunLinkSession8Case01Steps_DrawRecordListPageMarks::
Jump_0F0_5CBE:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenState, wScreenStep
; writes: wMenuInputResult, wScreenStep, wScreenSubStep, wScreenState
RunLinkSession8Case01Steps_UpdatePagedListCursor::
Jump_0F0_5CE0:: ; address name
    ld a, $01
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .return
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .clear_screen_step
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.return:
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    call SaveAndHideSpriteState_BankF0
    ret

; entry 7 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunLinkSession8Case01Steps_CopyScreenBufferRectWithAttrs_F0::
Jump_0F0_5D29:: ; address name
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, TileRect_F0_5D51
    ld hl, wWindowTileBuffer + $111
    ld bc, $0701
    call CopyRectTo20ByteRows_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 7 x 1 tiles, one row per line
TileRect_F0_5D51::
Data_0F0_5D51:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 8 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case01Steps_BGMapAddressAtScroll_BankF0::
Jump_0F0_5D58:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    ld de, Tiles1Plus4F0Tiles_1F_4260
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles_1F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles_1F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles_1F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in RunLinkSession8Case01Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursorF0
; writes: wArg1, wArg2, wArg3, wArg4, wScreenState, wScreenSubStep, wScreenStep
RunLinkSession8Case01Steps_ShowChooseTheKindOf::
Jump_0F0_5DA0:: ; address name
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, $6DC4
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wChoiceCursorF0]
    ld b, $C3
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case05_Data
    call StoreBAtWordTableEntry_BankF0
    xor a, a
    ld [wScreenState], a
    ld [wScreenSubStep], a
    ld a, $04 ; 'Choose the kind of egg to'
    call BeginString_BankF0_Cat0
    ld a, $07
    ld [wScreenStep], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_BankF0_48A0
; 19 call sites from 15 routines (e.g. RunLinkSession8Exchange_Case01_Sub01_Table2_Case07, RunLinkSession8Exchange_Case01_Sub01_Table2_Case05, RunLinkSession8Case01Steps_ShowChooseTheKindOf, RunLinkSession8Exchange_Case01_Sub01_Table3_Case03, ...)
; writes: wStringIndex, wStringCategory
BeginString_BankF0_Cat0::
Func_0F0_5DDD:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    call BeginStringDisplay_BankF0_48A0
    ret

; runs the routine for wScreenStep (jump table of seventeen) (E-0124)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_ToRunLinkSession8Case03Steps)
; reads: wScreenStep
RunLinkSession8Case03Steps::
Func_0F0_5DE8:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkSession8Case03Steps_ClearBGMapAtScrollAndResetScroll_BankF0
    dw RunLinkSession8Case03Steps_WriteScreenStep
    dw RunLinkSession8Case03Steps_OrFromBankWaitVRAM
    dw RunLinkSession8Case03Steps_FillTilesBxC_Case03
    dw RunLinkSession8Case03Steps_UploadTilesFromData6D20
    dw RunLinkSession8Case03Steps_Case05_DrawRecordParentNames_Case05
    dw RunLinkSession8Case03Steps_DrawRect6x6From651BAtScroll41_BankF0
    dw RunLinkSession8Case03Steps_HandleListCursorInput_1D
    dw RunLinkSession8Case03Steps_FillTilesBxC
    dw ClearBGMapAtScrollAndResetScroll_BankF0
    dw RunLinkSession8Case03Steps_WriteScreenStep_Case0A
    dw RunLinkSession8Case03Steps_ShowString_BankF0
    dw RunLinkSession8Case03Steps_FillTilesBxC_Case0C
    dw RunLinkSession8Case03Steps_ClampRecordListPageCursor4
    dw RunLinkSession8Case03Steps_DrawRecordListPageSpeciesNames
    dw RunLinkSession8Case03Steps_DrawRecordListPageMarks
    dw RunLinkSession8Case03Steps_RestoreSpriteStateClearCount_BankF0

; entry 0 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
RunLinkSession8Case03Steps_ClearBGMapAtScrollAndResetScroll_BankF0::
Jump_0F0_5E0E:: ; address name
    call ClearBGMapAtScrollAndResetScroll_BankF0
    ld de, Tiles1Plus2F0Tiles_1F_4250
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_1F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3) through FillTileRectWithArg1Tile with wArg7 = 0, then hScrollX = hScrollY = 0 and wScreenStep += 1 (E-0121; fill, not a tile map: E-0186)
; 1 call site from 1 routine (e.g. RunLinkSession8Case03Steps_ClearBGMapAtScrollAndResetScroll_BankF0)
; reads: wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hScrollX, ...
ClearBGMapAtScrollAndResetScroll_BankF0::
Func_0F0_5E2C:: ; address name
    call BGMapAddressAtScroll_BankF0
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
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case03Steps_WriteScreenStep::
Jump_0F0_5E63:: ; address name
    ld hl, TileCopyDestList_F0_6442
    ld de, TileCopySrcList_F0_6482
    call RunLinkSession8Case03Steps_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case03Steps_OrFromBankWaitVRAM::
Jump_0F0_5E74:: ; address name
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $60
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $90
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $140
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $170
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $1A0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageIndex, wListCursor, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
RunLinkSession8Case03Steps_FillTilesBxC_Case03::
Jump_0F0_5ECA:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Tiles1Plus7D0Tiles_1F_4A40
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wListPageIndex]
    add a, a
    add a, a
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld [wListCursor], a
    xor a, a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wArg1, wArg2, wScreenStep
RunLinkSession8Case03Steps_UploadTilesFromData6D20::
Jump_0F0_5EF9:: ; address name
    farcall UploadTilesFromData6D20
    call BGMapAddressAtScroll_BankF0
    ld de, TileRect_1F_6E7F
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    call GetListEntriesCell4Address_BankF0
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadPartySpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenStep
; writes: hSpriteHideTile, wScreenStep
RunLinkSession8Case03Steps_Case05_DrawRecordParentNames_Case05::
Jump_0F0_5F2F:: ; address name
    call GetListEntriesCell4Address_BankF0
    ld a, [hl]
    ld e, a
    farcall RunLinkSession8Case03Steps_Case05_DrawRecordParentNames
    ld a, $F0
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0069
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $6C
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $6D
    ld [hl], a
    ei
    ld a, [wListCount]
    cp a, $02
    jr c, .check_screen_step
    ld de, Tiles2Plus20Tiles_1F_4AA0
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus30Tiles_1F_4AE0
    ld hl, vTiles2 + $30
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_BankF0
    ld de, $0012
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $02
    ld [hl], a
    ei
    ld de, $0220
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $03
    ld [hl], a
    ei

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, hTemp0, hTemp1, wIsCGB, wScreenStep
; writes: rRAMG2, rRAMB, wScreenSubStep, wBGPaletteUploadRequest, hTemp0, wArg3, wArg4, wArg7, ...
RunLinkSession8Case03Steps_DrawRect6x6From651BAtScroll41_BankF0::
Jump_0F0_5FA3:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, .call_get_list_entries_cell4_address_bank_f0
    call DrawRect6x6From651BAtScroll41_BankF0
    call GetListEntriesCell4Address_BankF0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $480
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_get_list_entries_cell4_address_bank_f0:
    call GetListEntriesCell4Address_BankF0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, .restore
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.restore:
    pop hl
    xor a, a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, TileRect_1F_64F7
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wRecordsFlagged
; writes: hSpriteHideTile, wScreenStep
RunLinkSession8Case03Steps_HandleListCursorInput_1D::
Jump_0F0_6041:: ; address name
    farcall HandleListCursorInput_1D
    ld a, [wMenuInputResult]
    and a, a
    jr z, .loop
    cp a, $FD
    jr z, .check_records_flagged
    cp a, $FE
    jr z, .call_split_list_cursor_by4_bank_f0
    cp a, $FF
    jr z, .call_split_list_cursor_by4_bank_f0

.loop:
    ret

.check_records_flagged:
    ld a, [wRecordsFlagged]
    cp a, $02
    jr c, .loop
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_split_list_cursor_by4_bank_f0:
    call SplitListCursorBy4_BankF0
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case03Steps_FillTilesBxC::
Jump_0F0_607B:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, vTiles2 + $480
    ld bc, $0904
    call FillTilesBxC
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case03Steps_WriteScreenStep_Case0A::
Jump_0F0_6096:: ; address name
    ld hl, TileCopyDestList_F0_64C2
    ld de, TileCopySrcList_F0_64D2
    call RunLinkSession8Case03Steps_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunLinkSession8Case03Steps_ShowString_BankF0::
Jump_0F0_60A7:: ; address name
    ld hl, TileCopyDestList_F0_6500
    ld de, TileCopySrcList_F0_64E0
    call RunLinkSession8Case03Steps_WriteGlyphListPos
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call ShowString_BankF0
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
RunLinkSession8Case03Steps_FillTilesBxC_Case0C::
Jump_0F0_60E7:: ; address name
    ld hl, vTiles1 + $3F0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $6A0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunLinkSession8Case03Steps_ClampRecordListPageCursor4::
Jump_0F0_6129:: ; address name
    ld de, TileRect_F0_6530
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    jr DrawPageIndicatorWhenTwoPagesAndStep_Skip

; with two or more pages draws the bracket and page-of-pages indicator at wWindowTileBuffer + $112; wScreenStep += 1 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawPageIndicatorWhenTwoPagesAndStep:: ; heuristic: follows a terminator; C0
Func_0F0_613D:: ; address name
    ld a, [wListPages]
    cp a, $02
    jr c, DrawPageIndicatorWhenTwoPagesAndStep_CheckScreenStep
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_BankF0
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_BankF0

DrawPageIndicatorWhenTwoPagesAndStep_CheckScreenStep::
Jump_0F0_6158:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

DrawPageIndicatorWhenTwoPagesAndStep_Skip::
Jump_0F0_6160:: ; address name
    ld de, TileRect_F0_616E
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_BankF0
    jr DrawPageIndicatorWhenTwoPagesAndStep_CheckScreenStep

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_F0_616E::
Data_0F0_616E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 14 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
RunLinkSession8Case03Steps_DrawRecordListPageSpeciesNames::
Jump_0F0_6176:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunLinkSession8Case03Steps_DrawRecordListPageMarks::
Jump_0F0_6188:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wListCursor]
    ld b, $BC
    ld hl, RunLinkSession8Exchange_Case01_Sub01_Table3_Case01_Data
    call StoreBAtWordTableEntry_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in RunLinkSession8Case03Steps
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep
; points at: wTextWindowTileLo
RunLinkSession8Case03Steps_RestoreSpriteStateClearCount_BankF0::
Jump_0F0_61B7:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    call BGMapAddressAtScroll_BankF0
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_BankF0
    call RestoreSpriteStateClearCount_BankF0
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

; wSavedSpriteClipMode = hSpriteWindowClipMode, then hSpriteWindowClipMode = hSpriteHideTile = 0; wSavedFieldDrawFlags = hFieldDrawFlags, wSavedSpriteSlotCount = wSpriteSlotCount; then hFieldDrawFlags = $FF and wSpriteSlotCount = 0 (E-0078) (the same 30 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunLinkSession8Case01Steps_UpdatePagedListCursor)
; reads: hSpriteWindowClipMode, hFieldDrawFlags, wSpriteSlotCount
; writes: wSavedSpriteClipMode, hSpriteWindowClipMode, hSpriteHideTile, wSavedFieldDrawFlags, wSavedSpriteSlotCount, hFieldDrawFlags, wSpriteSlotCount
SaveAndHideSpriteState_BankF0::
Func_0F0_61F6:: ; address name
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ldh [hSpriteHideTile], a
    ldh a, [hFieldDrawFlags]
    ld [wSavedFieldDrawFlags], a
    ld a, [wSpriteSlotCount]
    ld [wSavedSpriteSlotCount], a
    ld a, $FF
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wSpriteSlotCount], a
    ret

; hSpriteWindowClipMode = wSavedSpriteClipMode, hSpriteHideTile = $80, hFieldDrawFlags = wSavedFieldDrawFlags, wSpriteSlotCount = 0 (unlike RestoreSpriteStateFromSavedFieldDrawFlags, the count is cleared rather than restored) (E-0118)
; 1 call site from 1 routine (e.g. RunLinkSession8Case03Steps_RestoreSpriteStateClearCount_BankF0)
; reads: wSavedSpriteClipMode, wSavedFieldDrawFlags, wSavedSpriteSlotCount
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wSpriteSlotCount
RestoreSpriteStateClearCount_BankF0::
Func_0F0_6214:: ; address name
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    xor a, a
    ld [wSpriteSlotCount], a
    ret

; clears the default window, wTextWindowState = 1, wTextWindowStep = 0, hSpriteWindowClipMode = 2, then repeatedly far-calls Func_002_69D0 until wTextWindowState & 3 = 0 (E-0122)
; 6 call sites from 6 routines (e.g. RunLinkSession8Exchange_ObjectSceneThenSave_ShowHeroReceivedYourEgg, RunLinkSession8Exchange_ObtainedEgg_ShowObtainedAnEggFrom, RunLinkSession8Exchange_EggsTraded_ShowEggsWereTradedWith, RunLinkSession8Exchange_ObjectScene_RunTextUntilTextWindowStateDone_BankF0, ...)
; reads: wTextWindowState
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
RunTextUntilTextWindowStateDone_BankF0::
Func_0F0_622A:: ; address name
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, .loop
    ret

; wListPageIndex = wListCursor / 4 and wListCursor = wListCursor mod 4 (DivideHLByA) (E-0067) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunLinkSession8Case03Steps_HandleListCursorInput_1D)
; reads: wListCursor
; writes: wListCursor, wListPageIndex
SplitListCursorBy4_BankF0::
Func_0F0_624F:: ; address name
    ld a, [wListCursor]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    ld [wListCursor], a
    ld a, l
    ld [wListPageIndex], a
    ret

; draws a 6 x 6 tile rectangle from Data_0F0_651B at BGMapAddressAtScroll + $41 (DrawTileRectAtHLFromDE_BankF0) (E-0118)
; 1 call site from 1 routine (e.g. RunLinkSession8Case03Steps_DrawRect6x6From651BAtScroll41_BankF0)
; writes: wArg3, wArg4, wArg7
DrawRect6x6From651BAtScroll41_BankF0::
Func_0F0_6262:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    ret

; only called from routines of RunLinkSession8Case03Steps (E-0098)
; 3 call sites from 3 routines (e.g. RunLinkSession8Case03Steps_ShowString_BankF0, RunLinkSession8Case03Steps_WriteScreenStep_Case0A, RunLinkSession8Case03Steps_WriteScreenStep)
; writes: wGlyphListPos
RunLinkSession8Case03Steps_WriteGlyphListPos::
Func_0F0_627E:: ; address name
    ld b, $00

.skip:
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    jr z, .restore
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    pop bc
    inc b
    jr .skip

.restore:
    pop de
    pop hl
    pop bc
    xor a, a
    ld [wGlyphListPos], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 13 call sites from 13 routines (e.g. RunLinkSession8Exchange_Case01_Sub01_Table2_Case06, RunLinkSession8Case01Steps_CopyScreenBufferRectWithAttrs_F0, RunLinkSession8Case01Steps_ClampRecordListPageCursor4, RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_BankF0::
Func_0F0_62B8:: ; address name
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a, a
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
    push bc
    push hl

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (E-0062)
; 12 call sites from 11 routines (e.g. RunLinkSession8Exchange_Case01_Sub01_Table2_Case06, RunLinkSession8Case01Steps_BGMapAddressAtScroll_BankF0, RunLinkSession8Case01Steps_ClampRecordListPageCursor4, RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_BankF0::
Func_0F0_62F2:: ; address name
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyRectToBGMapWrapped
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 23 call sites from 20 routines (e.g. DrawArrowTileBCAtArg2Entry_F0, RunLinkSession8Exchange_Case01_Sub01_Table2_Case06, RunLinkSession8Case01Steps_BGMapAddressAtScroll_BankF0, RunLinkSession8Case01Steps_ClampRecordListPageCursor4, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_BankF0::
Func_0F0_632F:: ; address name
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

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (E-0121)
; 1 call site from 1 routine (e.g. RunLinkSession8Case01Steps_ClampRecordListPageCursor4)
DrawC5BEC6AtScrollOffsetDE_BankF0::
Func_0F0_6350:: ; address name
    push de
    call BGMapAddressAtScroll_BankF0
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 2 call sites from 2 routines (e.g. RunLinkSession8Case01Steps_ClampRecordListPageCursor4, DrawPageIndicatorWhenTwoPagesAndStep)
StoreC5BEC6AtHLStride2_BankF0::
Func_0F0_6376:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; the same instruction sequence as DrawPageOfPagesAtScrollOffset (bank $1E) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RunLinkSession8Case01Steps_ClampRecordListPageCursor4)
; reads: wArg1, wArg2, wListPageIndex, wListPages
DrawPageOfPagesAtScrollOffset_BankF0::
Func_0F0_6384:: ; address name
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    push de
    call BGMapAddressAtScroll_BankF0
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wListPageIndex]
    inc a
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    ld a, [wListPages]
    ld b, a
    pop hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    ret

; HL = the address in wArg1 (high) / wArg2 (low): writes tile $E0 + wListPageIndex + 1 there and tile $E0 + wListPages two bytes later (current page and page count, 1-based display) (E-0093) (the same 25 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunLinkSession8Case01Steps_ClampRecordListPageCursor4, DrawPageIndicatorWhenTwoPagesAndStep)
; reads: wArg1, wArg2, wListPageIndex, wListPages
DrawPageOfPagesAtArg1_BankF0::
Func_0F0_63BA:: ; address name
    ld a, [wArg1]
    ld h, a
    ld a, [wArg2]
    ld l, a
    ld a, [wListPageIndex]
    inc a
    add a, $E0
    ld [hl+], a
    inc hl
    ld a, [wListPages]
    ld b, a
    ld a, b
    add a, $E0
    ld [hl], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_F0)
CopyBytesDEToHL_BankF0::
Func_0F0_63D3:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_BankF0
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_F0)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_BankF0::
Func_0F0_63DC:: ; address name
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
    xor a, a
    ldh [rSVBK], a
    ret

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 2 call sites from 2 routines (e.g. RunLinkSession8Case01Steps_CopyScreenBufferRectWithAttrs_F0, RunLinkSession8Exchange_Case01_Sub01_Table4_Case00)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_F0::
Func_0F0_63EE:: ; address name
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
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_BankF0
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
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_BankF0
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
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_F0
    ret

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_F0_6442::
Data_0F0_6442:: ; address name
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $A0, vTiles2 + $B0, vTiles2 + $C0, vTiles2 + $D0, vTiles2 + $E0, vTiles2 + $F0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1A0, vTiles2 + $1B0, vTiles2 + $1C0, vTiles2 + $1D0, vTiles2 + $1E0, vTiles2 + $1F0, vTiles2 + $6F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_F0_6482::
Data_0F0_6482:: ; address name
    dw $42D0, $42B0, $4300, $44C0, $4400, $4AB0, $4310, $43F0 ; entry 0
    dw $42E0, $42F0, $42A0, $4320, $4260, $4390, $47B0, $4680
    dw $46B0, $49D0, $42B0, $43E0, $4890, $4790, $4880, $4440
    dw $4380, $4500, $44E0, $42C0, $4A30, $4270, $4AD0, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_F0_64C2::
Data_0F0_64C2:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_F0_64D2::
Data_0F0_64D2:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_F0_64E0::
Data_0F0_64E0:: ; address name
    dw $4440, $4480, $43E0, $42E0, $46B0, $47B0, $4650, $4400 ; entry 0
    dw $42B0, $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_F0_6500::
Data_0F0_6500:: ; address name
    dw vTiles2 + $7C0, vTiles2 + $7D0, vTiles2 + $7E0, vTiles2 + $7F0, vTiles1 + $5F0, vTiles1 + $7E0, vTiles1 + $7F0, vTiles2 + $770 ; entry 0
    dw vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760
    dw rIE

; address loaded by RunLinkSession8Exchange_Case01_Sub01_Table3_Case05, RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet, RunLinkSession8Case01Steps_ShowChooseTheKindOf
RunLinkSession8Exchange_Case01_Sub01_Table3_Case05_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6522:: ; address name
    db $26, $C4, $4E, $C4

; address loaded by RunLinkSession8Exchange_Case01_Sub01_Table3_Case01, RunLinkSession8Exchange_Case01_Sub01_Table3_Case04, RunLinkSession8Case03Steps_DrawRecordListPageMarks
RunLinkSession8Exchange_Case01_Sub01_Table3_Case01_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6526:: ; address name
    db $80, $C3, $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_F0_6530::
Data_0F0_6530:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $C0, $C1, $C2, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C7, $C8, $C9, $CA, $CB, $EA, $EB, $EC, $ED, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0234 (C0: no reference found; $B2 followed by eight $B7 frame tiles, between TileRect_F0_6530 and the unreferenced frames that follow; kept as bytes).
; record: bytes
FrameTiles_F0_65A5::
Data_0F0_65A5:: ; address name
    db $B2, $B7, $B7, $B7, $B7, $B7, $B7, $B7, $B7 ; id 0

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 7 x 5 tiles, one row per line
TileRect_F0_65AE::
Data_0F0_65AE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 7 x 5 tiles, one row per line
TileRect_F0_65D1::
Data_0F0_65D1:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $76, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $73, $74, $75, $76, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0234 (C1: no reference found; the top frame row ($B0 $B1.. $B2) of a 7 x 5 frame whose other four rows are TileRect_F0_65FB).
; record: 7 x 1 tiles, one row per line
TileRect_F0_65F4::
Data_0F0_65F4:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 7 x 4 tiles, one row per line
TileRect_F0_65FB::
Data_0F0_65FB:: ; address name
    db $B6, $C3, $70, $71, $72, $C3, $B7 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $73, $74, $75, $76, $B7 ; id 2
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 3

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_F0_6617::
Data_0F0_6617:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $70, $71, $72, $73, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $74, $75, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_F0_663F::
Data_0F0_663F:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $73, $74, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_F0_665D::
Data_0F0_665D:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_F0_6685::
Data_0F0_6685:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_F0_66AD::
Data_0F0_66AD:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; wArg5/wArg6 = HL (destination), wArg1/wArg2 = DE (source), then far-calls DrawTileRectFromArg1Params (width and rows already in wArg3/wArg4) (E-0093) (the same 23 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. DrawRect6x6From651BAtScroll41_BankF0, RunLinkSession8Case03Steps_DrawRect6x6From651BAtScroll41_BankF0, RunLinkSession8Case03Steps_UploadTilesFromData6D20)
; writes: wArg5, wArg6, wArg1, wArg2
DrawTileRectAtHLFromDE_BankF0::
Func_0F0_66D5:: ; address name
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

; the same 15 bytes as GetListEntriesCell4Address (1E:76F3)
; 4 call sites from 3 routines (e.g. RunLinkSession8Case03Steps_DrawRect6x6From651BAtScroll41_BankF0, RunLinkSession8Case03Steps_Case05_DrawRecordParentNames_Case05, RunLinkSession8Case03Steps_UploadTilesFromData6D20)
; reads: wArg5, wArg6
GetListEntriesCell4Address_BankF0::
Func_0F0_66EC:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 6 call sites from 6 routines (e.g. RunLinkSession8Case01Steps_ShowChooseTheKindOf, RunLinkSession8Case01Steps_ListRecordsInUseWithByte6ESet, RunLinkSession8Exchange_Case01_Sub01_Table3_Case05, RunLinkSession8Exchange_Case01_Sub01_Table3_Case04, ...)
StoreBAtWordTableEntry_BankF0::
Func_0F0_66FB:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; up/down moves wChoiceCursorF0 between two entries (sound $69); A selects (wMenuInputResult = $FF), B cancels ($FE); otherwise blinks the cursor (E-0127)
; 3 call sites from 3 routines (e.g. RunLinkSession8Exchange_Case01_Sub01_Table2_Case07, RunLinkSession8Exchange_Case01_Sub01_Table3_Case03, RunLinkSession8Exchange_Case01_Sub01_Table4_Case05)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursorF0
; writes: wMenuInputResult, wChoiceCursorF0
HandleTwoChoiceCursorInput_F0::
Func_0F0_6709:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank_f0
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank_f02
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .call_draw_arrow_tile_bc_at_arg2_entry_f0
    call BlinkCursorBlinkB8_BankF0
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_arg2_entry_f0:
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $FE
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank_f0:
    call DrawBlankTileC3_BankF0
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_choice_cursor_f02

.skip:
    dec a
    jr .set_choice_cursor_f02

.call_draw_blank_tile_c3_bank_f02:
    call DrawBlankTileC3_BankF0
    ld a, [wChoiceCursorF0]
    cp a, $01
    jr c, .set_choice_cursor_f0
    xor a, a
    jr .set_choice_cursor_f02

.set_choice_cursor_f0:
    inc a

.set_choice_cursor_f02:
    ld [wChoiceCursorF0], a
    call DrawCursorTileBB_BankF0
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wCursorBlinkB8 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wJoypadRepeatTimer, wCursorBlinkB8, wArg2, wChoiceCursorF0
; writes: wCursorBlinkB8
BlinkCursorBlinkB8_BankF0::
Func_0F0_676D:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_BankF0
    ld a, [wCursorBlinkB8]
    inc a
    ld [wCursorBlinkB8], a
    cp a, $10
    jr c, DrawCursorTileBB_BankF0
    cp a, $18
    jr c, DrawBlankTileC3_BankF0
    xor a, a
    ld [wCursorBlinkB8], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wArg2, wChoiceCursorF0
DrawCursorTileBB_BankF0::
Func_0F0_6787:: ; address name
    ld b, $BB
    jr DrawArrowTileBCAtArg2Entry_F0_ReadArg2

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wArg2, wChoiceCursorF0
DrawBlankTileC3_BankF0::
Func_0F0_678B:: ; address name
    ld b, $C3
    jr DrawArrowTileBCAtArg2Entry_F0_ReadArg2

; B = $BC, then writes B at the scroll position + the offset from Data_0F0_67C0[wArg2] entry wChoiceCursorF0 (E-0125)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wArg2, wChoiceCursorF0
DrawArrowTileBCAtArg2Entry_F0::
Func_0F0_678F:: ; address name
    ld b, $BC

DrawArrowTileBCAtArg2Entry_F0_ReadArg2::
Jump_0F0_6791:: ; address name
    ld a, [wArg2]
    add a, a
    ld hl, DrawArrowTileBCAtArg2Entry_F0_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wChoiceCursorF0]
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    push de
    call BGMapAddressAtScroll_BankF0
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawArrowTileBCAtArg2Entry_F0
DrawArrowTileBCAtArg2Entry_F0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_67C0:: ; address name
    db $C6, $67, $CA, $67, $CE, $67, $2D, $01, $6D, $01, $2E, $01, $6E, $01, $2F, $01
    db $6F, $01

; runs Func_0F0_67EE with wArg1 = 1 when wF0ScreenKind is 3 or 4, else 0 (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case17)
; reads: wF0ScreenKind
; writes: wArg1
Run67EEWithArg1ForF0ScreenKind::
Func_0F0_67D2:: ; address name
    ld a, [wF0ScreenKind]
    cp a, $03
    jr z, .set_arg1_to_01
    cp a, $04
    jr z, .set_arg1_to_01
    xor a, a
    ld [wArg1], a
    call Run67EEWithArg1ForF0ScreenKind_TestFlagBit
    ret

.set_arg1_to_01:
    ld a, $01
    ld [wArg1], a
    call Run67EEWithArg1ForF0ScreenKind_TestFlagBit
    ret

; only called from Run67EEWithArg1ForF0ScreenKind (E-0047)
; 2 call sites from 1 routine (e.g. Run67EEWithArg1ForF0ScreenKind)
; reads: wBankF0BlockC7, wArg1, wF0ScreenKind, wBankF0ByteA8, wBankF0ByteA9, wIsCGB, wBankF0ByteC8, wBankF0ByteC9
; writes: hTemp0, wObject5, wSpriteSlotCount, wObject2, hTemp1, wOBJPaletteUploadRequest
; points at: wSpriteSlots, wObject1, hTemp0, wObject2
Run67EEWithArg1ForF0ScreenKind_TestFlagBit::
Func_0F0_67EE:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, .skip
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A08
    jr .call_copy_bytes_de_from_hl_bank_f0

.skip:
    ld hl, SpriteSlotsInit_F0_6A18

.call_copy_bytes_de_from_hl_bank_f0:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, .skip2
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A28
    jr .call_copy_bytes_de_from_hl_bank_f02

.skip2:
    ld hl, Object1Init_F0_6A38

.call_copy_bytes_de_from_hl_bank_f02:
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld de, $0000
    call TestFlagBit
    jr c, .skip3
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69EA
    jr .call_copy_bytes_de_from_hl_bank_f03

.skip3:
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69F0

.call_copy_bytes_de_from_hl_bank_f03:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, .skip4
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69F6
    jr .call_copy_bytes_de_from_hl_bank_f04

.skip4:
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69FC

.call_copy_bytes_de_from_hl_bank_f04:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, [wArg1]
    and a, a
    jr z, .check_is_cgb
    ld hl, Object2Init_F0_6A48
    ld de, wObject2
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp a, $03
    jr nz, .read_bank_f0_byte_c8
    ld a, [wBankF0ByteA8]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wBankF0ByteA9]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    jr .skip5

.read_bank_f0_byte_c8:
    ld a, [wBankF0ByteC8]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wBankF0ByteC9]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a

.skip5:
    ld hl, Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A02
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp a, $03
    jr nz, .read_bank_f0_byte_c82
    ld a, [wBankF0ByteA8]
    ldh [hTemp0], a
    ld a, [wBankF0ByteA9]
    ldh [hTemp1], a
    jr .call_decompress_graphics_temp0_to_temp4

.read_bank_f0_byte_c82:
    ld a, [wBankF0ByteC8]
    ldh [hTemp0], a
    ld a, [wBankF0ByteC9]
    ldh [hTemp1], a

.call_decompress_graphics_temp0_to_temp4:
    farcall DecompressGraphicsTemp0ToTemp4

.check_is_cgb:
    ld a, [wIsCGB]
    and a, a
    jr z, .return
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 6 call sites from 1 routine (e.g. Run67EEWithArg1ForF0ScreenKind_TestFlagBit)
CopyBytesDEFromHL_BankF0::
Func_0F0_68DF:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF0
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 13 tiles, one row per line
TileRect_F0_68E6::
Data_0F0_68E6:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 12

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_69EA:: ; address name
    db $00, $00, $01, $04, $00, $80

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69F0:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_69F0:: ; address name
    db $01, $00, $01, $01, $00, $80

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_69F6:: ; address name
    db $00, $00, $01, $04, $00, $81

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_69FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_69FC:: ; address name
    db $01, $00, $01, $01, $00, $81

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A02:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6A02:: ; address name
    db $00, $00, $00, $02, $00, $82

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A08:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6A08:: ; address name
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

; E-0264 (derived: Func_0F0_68DF copies these 16 bytes to wSpriteSlots)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_F0_6A18::
Data_0F0_6A18:: ; address name
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00 ; entry 0

; address loaded by Run67EEWithArg1ForF0ScreenKind_TestFlagBit
Run67EEWithArg1ForF0ScreenKind_TestFlagBit_Data_6A28:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6A28:: ; address name
    db $00, $01, $00, $00, $F0, $40, $04, $03, $10, $00, $00, $F0, $40, $04, $00, $00

; E-0264 (derived: Func_0F0_68DF copies these 16 bytes to wObject1)
; record: 16 bytes copied to wObject1
Object1Init_F0_6A38::
Data_0F0_6A38:: ; address name
    db $00, $01, $01, $00, $F0, $40, $01, $03, $10, $00, $00, $F0, $40, $04, $00, $00 ; entry 0

; E-0264 (derived: Func_0F0_68DF copies these 16 bytes to wObject2)
; record: 16 bytes copied to wObject2
Object2Init_F0_6A48::
Data_0F0_6A48:: ; address name
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00 ; entry 0

; address loaded by RunLinkSession8Exchange_Case01_Sub01_Table5_Case09
RunLinkSession8Exchange_Case01_Sub01_Table5_Case09_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_6A58:: ; address name
    ds $A6, $FF

; while wFamilyBitCount > 0 and some resistance at wGiftRecord + $73 is below 3: picks at random one of the lowest-level resistances (levels 0, then 1, 2) and raises it (E-0129)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case11)
; reads: wFamilyBitCount, wCounterPtr0Lo, wLowestResistCount, wCounterPtr0Hi
; writes: wFamilyBitCount, wCounterPtr0Lo, wLowestResistCount
; points at: wCounterPtr0Hi
RaiseRandomLowestResistance::
Func_0F0_6AFE:: ; address name
    ld a, [wFamilyBitCount]
    and a, a
    ret z
    ld hl, wGiftRecord + MON_RESISTANCES
    ld b, $00

.loop:
    ld a, b
    cp a, $0F
    jr z, .next
    ld a, [hl]
    cp a, $03
    jr z, .next
    ld a, [wFamilyBitCount]
    dec a
    ld [wFamilyBitCount], a
    jp .clear_counter_ptr0_lo

.next:
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, .loop
    ret

.clear_counter_ptr0_lo:
    xor a, a
    ld [wCounterPtr0Lo], a

.skip:
    ld hl, wCounterPtr0Hi
    ld bc, $001C

.loop2:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld hl, wGiftRecord + MON_RESISTANCES
    ld de, wCounterPtr0Hi
    ld b, $00

.loop3:
    ld a, [hl]
    ld c, a
    ld a, [wCounterPtr0Lo]
    cp a, c
    jr nz, .next2
    ld a, b
    ld [de], a
    inc de
    ld a, [wLowestResistCount]
    inc a
    ld [wLowestResistCount], a

.next2:
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, .loop3
    ld a, [wLowestResistCount]
    and a, a
    jr nz, .check_lowest_resist_count
    ld a, [wCounterPtr0Lo]
    cp a, $02
    ret z
    inc a
    ld [wCounterPtr0Lo], a
    jr .skip

.check_lowest_resist_count:
    ld a, [wLowestResistCount]
    cp a, $01
    jr z, .read_counter_ptr0_hi
    ld b, a
    call NextTableByte
    ld a, l

.skip2:
    sub a, b
    cp a, b
    jr c, .skip3
    jr z, .skip3
    jr .skip2

.skip3:
    and a, a
    jr z, .skip4
    dec a

.skip4:
    ld hl, wCounterPtr0Hi
    add_a_to_hl
    ld a, [hl]
    cp a, $0F
    jp z, RaiseRandomLowestResistance
    jr .skip5

.read_counter_ptr0_hi:
    ld a, [wCounterPtr0Hi]

.skip5:
    ld hl, wGiftRecord + MON_RESISTANCES
    add_a_to_hl
    ld a, [hl]
    inc a
    ld [hl], a
    jp RaiseRandomLowestResistance

; loads species wGiftRecord + $B and copies its bytes wSpeciesRecord + $8-wSpeciesRecord + $A to wGiftRecord + $3C and the 27 bytes at wSpeciesRecord + $12 to wGiftRecord + $73; wGiftRecord + $5B = wGiftRecord + $5D, wGiftRecord + $5F = wGiftRecord + $61 (E-0124)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case11)
; reads: wGiftRecord, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi, wGiftRecord
LoadTopSpeciesLoSpeciesStatsToTopSpeciesGrowth::
Func_0F0_6BA1:: ; address name
    ld a, [wGiftRecord + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wGiftRecord + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [wGiftRecord + MON_SKILL_LIST], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [wGiftRecord + MON_SKILL_LIST + 1], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [wGiftRecord + MON_SKILL_LIST + 2], a
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES
    ld de, wGiftRecord + MON_RESISTANCES
    ld c, $1B

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ld a, [wGiftRecord + MON_MAX_HP]
    ld [wGiftRecord + MON_HP], a
    ld a, [wGiftRecord + MON_MAX_MP]
    ld [wGiftRecord + MON_MP], a
    ret

; ranks the 11 scores at wFamilyScores in descending order (ties at random) into wFamilyRanking, then wRankBand = BandOfFamilyBitCount (E-0130)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case11)
; reads: wRankIndex, wRankBand
; writes: wRankIndex, wRankBand, wGiftRecord
; points at: wFamilyScores, wFamilyRankTaken, wFamilyRanking
RankFamilyScoresIntoFamilyRanking::
Func_0F0_6BE0:: ; address name
    xor a, a
    ld [wRankIndex], a

.loop:
    ld hl, wFamilyScores
    ld c, $00
    ld b, $00
    ld e, $00

.loop2:
    push hl
    ld a, c
    ld hl, wFamilyRankTaken
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    pop hl
    jr .next

.restore:
    pop hl
    ld a, [hl]
    cp a, b
    jr c, .skip2
    jr z, .call_next_table_byte
    ld b, a

.skip:
    ld e, c
    jr .next

.skip2:
    jr .next

.call_next_table_byte:
    call NextTableByte
    bit 0, a
    jr nz, .next
    jr .skip

.next:
    inc hl
    inc c
    ld a, c
    cp a, $0B
    jr c, .loop2
    ld hl, wFamilyRanking
    ld a, [wRankIndex]
    add_a_to_hl
    ld a, e
    ld [hl], a
    ld hl, wFamilyRankTaken
    ld a, e
    add_a_to_hl
    set 7, a
    ld [hl], a
    ld a, [wRankIndex]
    inc a
    ld [wRankIndex], a
    cp a, $0B
    jr c, .loop
    call BandOfFamilyBitCount
    ld [wRankBand], a
    xor a, a
    ld [wRankIndex], a
    ld hl, wFamilyRanking
    ld b, $0A

.loop3:
    push hl
    push bc
    ld a, [hl]
    res 7, a
    add a, a
    ld de, FamilyBandSpeciesTable
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wRankBand]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.next2:
    inc de
    ld a, [de]
    dec de
    cp a, $FF
    jr z, .restore2
    cp a, $FE
    jr z, .next3
    push de
    ld b, $0F
    call RandomModulo29_BankF0
    ld a, l
    bit 0, a
    jr nz, .set_gift_record
    pop de
    inc de
    inc de
    jr .next2

.restore2:
    pop bc
    pop hl
    inc hl
    dec b
    jp nz, .loop3
    ld a, $0A
    ld [wGiftRecord + MON_FAMILY], a
    ld a, $74
    ld [wGiftRecord + MON_SPECIES], a
    ld a, $01
    ld [wGiftRecord + MON_SPECIES + 1], a
    ret

.next3:
    dec de
    dec de
    jr .set_gift_record2

.set_gift_record:
    pop de

.set_gift_record2:
    ld a, [de]
    ld [wGiftRecord + MON_SPECIES], a
    inc de
    ld a, [de]
    ld [wGiftRecord + MON_SPECIES + 1], a
    pop bc
    pop hl
    ld a, [hl]
    ld [wGiftRecord + MON_FAMILY], a
    ret

; E-0256 (C1: RankFamilyScoresIntoFamilyRanking walks wFamilyRanking (10 families), reads the word at $6CB5 + 2 * family, then the word at 2 * wRankBand (BandOfFamilyBitCount: 4-7) of that list, and walks the species words up to $FEFE (or $FFFF) taking one when RandomModulo29_BankF0 gives an odd number; the chosen species goes to wGiftRecord + MON_SPECIES (E-0312); 11 families in StringTable_MonsterFamilies order).
; record: band lists of this family
FamilyBandSpeciesTable::
Data_0F0_6CB5:: ; address name
    dw FamilyBandLists_Slime ; id 0
    dw FamilyBandLists_Dragon ; id 1
    dw FamilyBandLists_Beast ; id 2
    dw FamilyBandLists_Bird ; id 3
    dw FamilyBandLists_Plant ; id 4
    dw FamilyBandLists_Bug ; id 5
    dw FamilyBandLists_Demon ; id 6
    dw FamilyBandLists_Zombie ; id 7
    dw FamilyBandLists_Material ; id 8
    dw FamilyBandLists_Water ; id 9
    dw FamilyBandLists_Boss ; id 10

; E-0256 (C1: family 0 (Slime) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Slime::
Data_0F0_6CCB:: ; address name
    dw FamilyBandSpecies_Slime_000 ; id 0
    dw FamilyBandSpecies_Slime_001 ; id 1
    dw FamilyBandSpecies_Slime_002 ; id 2
    dw FamilyBandSpecies_Slime_003 ; id 3
    dw FamilyBandSpecies_Slime_004 ; id 4
    dw FamilyBandSpecies_Slime_005 ; id 5
    dw FamilyBandSpecies_Slime_006 ; id 6
    dw FamilyBandSpecies_Slime_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_000::
Data_0F0_6CDB:: ; address name
    dw $0002 ; id 0 SpotSlime
    dw $0005 ; id 1 Snaily
    dw $000F ; id 2 Slabbit
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $01 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_001::
Data_0F0_6CE3:: ; address name
    dw $0004 ; id 0 TreeSlime
    dw $0007 ; id 1 Babble
    dw $000A ; id 2 Slime
    dw $0014 ; id 3 TropicGel
    dw $001A ; id 4 WonderEgg
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $02 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_002::
Data_0F0_6CEF:: ; address name
    dw $0003 ; id 0 WingSlime
    dw $0008 ; id 1 BoxSlime
    dw $0009 ; id 2 PearlGel
    dw $000B ; id 3 Healer
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $03 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_003::
Data_0F0_6CF9:: ; address name
    dw $0001 ; id 0 DrakSlime
    dw $0006 ; id 1 SlimeNite
    dw $000C ; id 2 FangSlime
    dw $000D ; id 3 RockSlime
    dw $000E ; id 4 SlimeBorg
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $04 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_004::
Data_0F0_6D05:: ; address name
    dw $0011 ; id 0 Metaly
    dw $0013 ; id 1 SpotKing
    dw $0015 ; id 2 MimeSlime
    dw $0016 ; id 3 HaloSlime
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $05 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_005::
Data_0F0_6D0F:: ; address name
    dw $0010 ; id 0 KingSlime
    dw $0012 ; id 1 Metabble
    dw $0017 ; id 2 MetalKing
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $06 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_006::
Data_0F0_6D17:: ; address name
    dw $0018 ; id 0 GoldSlime
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $07 of FamilyBandLists_Slime; it runs to the next list)
; record: species
FamilyBandSpecies_Slime_007::
Data_0F0_6D1B:: ; address name
    dw $0019 ; id 0 GranSlime
    dw $FEFE ; id 1

; E-0256 (C1: family 1 (Dragon) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Dragon::
Data_0F0_6D1F:: ; address name
    dw FamilyBandSpecies_Dragon_000 ; id 0
    dw FamilyBandSpecies_Dragon_001 ; id 1
    dw FamilyBandSpecies_Dragon_002 ; id 2
    dw FamilyBandSpecies_Dragon_003 ; id 3
    dw FamilyBandSpecies_Dragon_004 ; id 4
    dw FamilyBandSpecies_Dragon_005 ; id 5
    dw FamilyBandSpecies_Dragon_006 ; id 6
    dw FamilyBandSpecies_Dragon_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_000::
Data_0F0_6D2F:: ; address name
    dw $0028 ; id 0 FairyDrak
    dw $0031 ; id 1 Chamelgon
    dw $0032 ; id 2 LizardFly
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $01 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_001::
Data_0F0_6D37:: ; address name
    dw $002A ; id 0 Poisongon
    dw $002E ; id 1 MiniDrak
    dw $0034 ; id 2 KingCobra
    dw $0036 ; id 3 SnakeBat
    dw $0039 ; id 4 Crestpent
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $02 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_002::
Data_0F0_6D43:: ; address name
    dw $0024 ; id 0 DragonKid
    dw $0025 ; id 1 Tortragon
    dw $0026 ; id 2 Pteranod
    dw $0027 ; id 3 Gasgon
    dw $003A ; id 4 WingSnake
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $03 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_003::
Data_0F0_6D4F:: ; address name
    dw $002B ; id 0 Swordgon
    dw $002C ; id 1 Drygon
    dw $0030 ; id 2 Rayburn
    dw $0035 ; id 3 Vampirus
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $04 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_004::
Data_0F0_6D59:: ; address name
    dw $0029 ; id 0 LizardMan
    dw $002D ; id 1 Dragon
    dw $002F ; id 2 MadDragon
    dw $0033 ; id 3 Andreal
    dw $0037 ; id 4 Spikerous
    dw $003B ; id 5 Coatol
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $05 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_005::
Data_0F0_6D67:: ; address name
    dw $0038 ; id 0 GreatDrak
    dw $003D ; id 1 BattleRex
    dw $003E ; id 2 SkyDragon
    dw $003F ; id 3 Serpentia
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $06 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_006::
Data_0F0_6D71:: ; address name
    dw $003C ; id 0 Orochi
    dw $0040 ; id 1 Divinegon
    dw $0042 ; id 2 GigaDraco
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $07 of FamilyBandLists_Dragon; it runs to the next list)
; record: species
FamilyBandSpecies_Dragon_007::
Data_0F0_6D79:: ; address name
    dw $0041 ; id 0 Orligon
    dw $FEFE ; id 1

; E-0256 (C1: family 2 (Beast) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Beast::
Data_0F0_6D7D:: ; address name
    dw FamilyBandSpecies_Beast_000 ; id 0
    dw FamilyBandSpecies_Beast_001 ; id 1
    dw FamilyBandSpecies_Beast_002 ; id 2
    dw FamilyBandSpecies_Beast_003 ; id 3
    dw FamilyBandSpecies_Beast_004 ; id 4
    dw FamilyBandSpecies_Beast_005 ; id 5
    dw FamilyBandSpecies_Beast_006 ; id 6
    dw FamilyBandSpecies_Beast_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_000::
Data_0F0_6D8D:: ; address name
    dw $0048 ; id 0 Almiraj
    dw $0049 ; id 1 CatFly
    dw $004A ; id 2 PillowRat
    dw $004B ; id 3 Saccer
    dw $0050 ; id 4 Antbear
    dw $005B ; id 5 FairyRat
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $01 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_001::
Data_0F0_6D9B:: ; address name
    dw $004D ; id 0 Skullroo
    dw $004E ; id 1 WindBeast
    dw $0053 ; id 2 Mommonja
    dw $0054 ; id 3 HammerMan
    dw $0057 ; id 4 ArrowDog
    dw $005A ; id 5 MadGopher
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $02 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_002::
Data_0F0_6DA9:: ; address name
    dw $0047 ; id 0 Tonguella
    dw $004F ; id 1 Beavern
    dw $0051 ; id 2 SuperTen
    dw $0052 ; id 3 IronTurt
    dw $0058 ; id 4 NoctoKing
    dw $0059 ; id 5 BeastNite
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $03 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_003::
Data_0F0_6DB7:: ; address name
    dw $0055 ; id 0 Grizzly
    dw $0056 ; id 1 Yeti
    dw $005D ; id 2 Goategon
    dw $005E ; id 3 WildApe
    dw $0065 ; id 4 CatMage
    dw $0066 ; id 5 Dumbira
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $04 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_004::
Data_0F0_6DC5:: ; address name
    dw $004C ; id 0 GulpBeast
    dw $005F ; id 1 Trumpeter
    dw $0062 ; id 2 MadCat
    dw $0063 ; id 3 BigEye
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $05 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_005::
Data_0F0_6DCF:: ; address name
    dw $005C ; id 0 Unicorn
    dw $0061 ; id 1 DarkHorn
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $06 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_006::
Data_0F0_6DD5:: ; address name
    dw $0060 ; id 0 KingLeo
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $07 of FamilyBandLists_Beast; it runs to the next list)
; record: species
FamilyBandSpecies_Beast_007::
Data_0F0_6DD9:: ; address name
    dw $0064 ; id 0 Gorago
    dw $FEFE ; id 1

; E-0256 (C1: family 3 (Bird) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Bird::
Data_0F0_6DDD:: ; address name
    dw FamilyBandSpecies_Bird_000 ; id 0
    dw FamilyBandSpecies_Bird_001 ; id 1
    dw FamilyBandSpecies_Bird_002 ; id 2
    dw FamilyBandSpecies_Bird_003 ; id 3
    dw FamilyBandSpecies_Bird_004 ; id 4
    dw FamilyBandSpecies_Bird_005 ; id 5
    dw FamilyBandSpecies_Bird_006 ; id 6
    dw FamilyBandSpecies_Bird_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_000::
Data_0F0_6DED:: ; address name
    dw $006A ; id 0 Picky
    dw $0073 ; id 1 Dracky
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $01 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_001::
Data_0F0_6DF3:: ; address name
    dw $006D ; id 0 Florajay
    dw $0070 ; id 1 MadRaven
    dw $0074 ; id 2 KiteHawk
    dw $0075 ; id 3 BigRoost
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $02 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_002::
Data_0F0_6DFD:: ; address name
    dw $006C ; id 0 BullBird
    dw $0071 ; id 1 MistyWing
    dw $0072 ; id 2 AquaHawk
    dw $0076 ; id 3 StubBird
    dw $0077 ; id 4 LandOwl
    dw $0084 ; id 5 CragDevil
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $03 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_003::
Data_0F0_6E0B:: ; address name
    dw $006B ; id 0 Wyvern
    dw $006E ; id 1 DuckKite
    dw $006F ; id 2 MadPecker
    dw $0078 ; id 3 MadGoose
    dw $0079 ; id 4 MadCondor
    dw $007A ; id 5 Emyu
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $04 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_004::
Data_0F0_6E19:: ; address name
    dw $007B ; id 0 Blizzardy
    dw $007C ; id 1 Phoenix
    dw $007D ; id 2 ZapBird
    dw $0080 ; id 3 FunkyBird
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $05 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_005::
Data_0F0_6E23:: ; address name
    dw $007E ; id 0 Garudian
    dw $007F ; id 1 WhipBird
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $06 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_006::
Data_0F0_6E29:: ; address name
    dw $0081 ; id 0 RainHawk
    dw $0083 ; id 1 Shantak
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $07 of FamilyBandLists_Bird; it runs to the next list)
; record: species
FamilyBandSpecies_Bird_007::
Data_0F0_6E2F:: ; address name
    dw $0082 ; id 0 Azurile
    dw $FEFE ; id 1

; E-0256 (C1: family 4 (Plant) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Plant::
Data_0F0_6E33:: ; address name
    dw FamilyBandSpecies_Plant_000 ; id 0
    dw FamilyBandSpecies_Plant_001 ; id 1
    dw FamilyBandSpecies_Plant_002 ; id 2
    dw FamilyBandSpecies_Plant_003 ; id 3
    dw FamilyBandSpecies_Plant_004 ; id 4
    dw FamilyBandSpecies_Plant_005 ; id 5
    dw FamilyBandSpecies_Plant_006 ; id 6
    dw FamilyBandSpecies_Plant_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_000::
Data_0F0_6E43:: ; address name
    dw $0091 ; id 0 CactiBall
    dw $0093 ; id 1 Toadstool
    dw $0095 ; id 2 Slurperon
    dw $00A6 ; id 3 Eggplaton
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $01 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_001::
Data_0F0_6E4D:: ; address name
    dw $008D ; id 0 MadPlant
    dw $0090 ; id 1 WingTree
    dw $0097 ; id 2 Oniono
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $02 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_002::
Data_0F0_6E55:: ; address name
    dw $008E ; id 0 FireWeed
    dw $008F ; id 1 FloraMan
    dw $0092 ; id 2 Gulpple
    dw $0096 ; id 3 Stubsuck
    dw $0098 ; id 4 DanceVegi
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $03 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_003::
Data_0F0_6E61:: ; address name
    dw $0094 ; id 0 AmberWeed
    dw $0099 ; id 1 TreeBoy
    dw $009A ; id 2 Devipine
    dw $009D ; id 3 BeanMan
    dw $009E ; id 4 EvilSeed
    dw $009F ; id 5 ManEater
    dw $00A7 ; id 6 FooHero
    dw $FEFE ; id 7

; E-0199 (derived: list for entry $04 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_004::
Data_0F0_6E71:: ; address name
    dw $00A0 ; id 0 Snapper
    dw $00A1 ; id 1 GhosTree
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $05 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_005::
Data_0F0_6E77:: ; address name
    dw $009A ; id 0 Devipine
    dw $009B ; id 1 FaceTree
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $06 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_006::
Data_0F0_6E7D:: ; address name
    dw $00A2 ; id 0 Rosevine
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $07 of FamilyBandLists_Plant; it runs to the next list)
; record: species
FamilyBandSpecies_Plant_007::
Data_0F0_6E81:: ; address name
    dw $00A3 ; id 0 Egdracil
    dw $00A4 ; id 1 Warubou
    dw $00A5 ; id 2 Watabou
    dw $FEFE ; id 3

; E-0256 (C1: family 5 (Bug) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Bug::
Data_0F0_6E89:: ; address name
    dw FamilyBandSpecies_Bug_000 ; id 0
    dw FamilyBandSpecies_Bug_001 ; id 1
    dw FamilyBandSpecies_Bug_002 ; id 2
    dw FamilyBandSpecies_Bug_003 ; id 3
    dw FamilyBandSpecies_Bug_004 ; id 4
    dw FamilyBandSpecies_Bug_005 ; id 5
    dw FamilyBandSpecies_Bug_006 ; id 6
    dw FamilyBandSpecies_Bug_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_000::
Data_0F0_6E99:: ; address name
    dw $00B0 ; id 0 GiantSlug
    dw $00B5 ; id 1 GiantWorm
    dw $00B9 ; id 2 ArmyAnt
    dw $00BB ; id 3 TailEater
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $01 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_001::
Data_0F0_6EA3:: ; address name
    dw $00B2 ; id 0 Gophecada
    dw $00B3 ; id 1 Butterfly
    dw $00BA ; id 2 GoHopper
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $02 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_002::
Data_0F0_6EAB:: ; address name
    dw $00B6 ; id 0 Lipsy
    dw $00B7 ; id 1 StagBug
    dw $00B8 ; id 2 Pyuro
    dw $00BD ; id 3 Eyeder
    dw $00C2 ; id 4 Belzebub
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $03 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_003::
Data_0F0_6EB7:: ; address name
    dw $00B1 ; id 0 Catapila
    dw $00B4 ; id 1 WeedBug
    dw $00BC ; id 2 ArmorPede
    dw $00BE ; id 3 GiantMoth
    dw $00BF ; id 4 Droll
    dw $00C1 ; id 5 MadHornet
    dw $00C9 ; id 6 MultiEyes
    dw $FEFE ; id 7

; E-0199 (derived: list for entry $04 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_004::
Data_0F0_6EC7:: ; address name
    dw $00C0 ; id 0 ArmyCrab
    dw $00C5 ; id 1 Sickler
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $05 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_005::
Data_0F0_6ECD:: ; address name
    dw $00C3 ; id 0 WarMantis
    dw $00C4 ; id 1 HornBeet
    dw $00C7 ; id 2 Digster
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $06 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_006::
Data_0F0_6ED5:: ; address name
    dw $00C6 ; id 0 Armorpion
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $07 of FamilyBandLists_Bug; it runs to the next list)
; record: species
FamilyBandSpecies_Bug_007::
Data_0F0_6ED9:: ; address name
    dw $00C8 ; id 0 Skularach
    dw $FEFE ; id 1

; E-0256 (C1: family 6 (Demon) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Demon::
Data_0F0_6EDD:: ; address name
    dw FamilyBandSpecies_Demon_000 ; id 0
    dw FamilyBandSpecies_Demon_001 ; id 1
    dw FamilyBandSpecies_Demon_002 ; id 2
    dw FamilyBandSpecies_Demon_003 ; id 3
    dw FamilyBandSpecies_Demon_004 ; id 4
    dw FamilyBandSpecies_Demon_005 ; id 5
    dw FamilyBandSpecies_Demon_006 ; id 6
    dw FamilyBandSpecies_Demon_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_000::
Data_0F0_6EED:: ; address name
    dw $00D3 ; id 0 Pixy
    dw $00D6 ; id 1 Demonite
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $01 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_001::
Data_0F0_6EF3:: ; address name
    dw $00DC ; id 0 1EyeClown
    dw $00DD ; id 1 Gremlin
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $02 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_002::
Data_0F0_6EF9:: ; address name
    dw $00D4 ; id 0 MedusaEye
    dw $00D8 ; id 1 EyeBall
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $03 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_003::
Data_0F0_6EFF:: ; address name
    dw $00D7 ; id 0 DarkEye
    dw $00D9 ; id 1 SkulRider
    dw $00E1 ; id 2 Orc
    dw $00EA ; id 3 Gigantes
    dw $00EC ; id 4 EvilArmor
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $04 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_004::
Data_0F0_6F0B:: ; address name
    dw $00DA ; id 0 EvilBeast
    dw $00DB ; id 1 Bubblemon
    dw $00DF ; id 2 Lionex
    dw $00E2 ; id 3 Ogre
    dw $00E8 ; id 4 MadKnight
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $05 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_005::
Data_0F0_6F17:: ; address name
    dw $00DE ; id 0 ArcDemon
    dw $00E0 ; id 1 GoatHorn
    dw $00E3 ; id 2 GateGuard
    dw $00E4 ; id 3 ChopClown
    dw $00E5 ; id 4 BossTroll
    dw $00E6 ; id 5 Grendal
    dw $00E9 ; id 6 EvilWell
    dw $00EB ; id 7 Centasaur
    dw $FEFE ; id 8

; E-0199 (derived: list for entry $06 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_006::
Data_0F0_6F29:: ; address name
    dw $00E7 ; id 0 Akubar
    dw $00ED ; id 1 Jamirus
    dw $00EE ; id 2 Durran
    dw $00F0 ; id 3 LampGenie
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $07 of FamilyBandLists_Demon; it runs to the next list)
; record: species
FamilyBandSpecies_Demon_007::
Data_0F0_6F33:: ; address name
    dw $00EF ; id 0 Titanis
    dw $FEFE ; id 1

; E-0256 (C1: family 7 (Zombie) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Zombie::
Data_0F0_6F37:: ; address name
    dw FamilyBandSpecies_Zombie_000 ; id 0
    dw FamilyBandSpecies_Zombie_001 ; id 1
    dw FamilyBandSpecies_Zombie_002 ; id 2
    dw FamilyBandSpecies_Zombie_003 ; id 3
    dw FamilyBandSpecies_Zombie_004 ; id 4
    dw FamilyBandSpecies_Zombie_005 ; id 5
    dw FamilyBandSpecies_Zombie_006 ; id 6
    dw FamilyBandSpecies_Zombie_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_000::
Data_0F0_6F47:: ; address name
    dw $00F6 ; id 0 Spooky
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $01 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_001::
Data_0F0_6F4B:: ; address name
    dw $00F9 ; id 0 RotRaven
    dw $0100 ; id 1 Mudron
    dw $0104 ; id 2 Inverzon
    dw $0105 ; id 3 FoxFire
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $02 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_002::
Data_0F0_6F55:: ; address name
    dw $00F8 ; id 0 PutrePup
    dw $00FA ; id 1 Mummy
    dw $00FD ; id 2 Shadow
    dw $00FE ; id 3 Skulpent
    dw $00FF ; id 4 Hork
    dw $0101 ; id 5 NiteWhip
    dw $0102 ; id 6 WindMerge
    dw $010F ; id 7 PomPomBom
    dw $FEFE ; id 8

; E-0199 (derived: list for entry $03 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_003::
Data_0F0_6F67:: ; address name
    dw $00FB ; id 0 DarkCrab
    dw $00FC ; id 1 DeadNite
    dw $0103 ; id 2 Reaper
    dw $0106 ; id 3 CaptDead
    dw $0109 ; id 4 BoneSlave
    dw $010E ; id 5 MadSpirit
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $04 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_004::
Data_0F0_6F75:: ; address name
    dw $010A ; id 0 Skeletor
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $05 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_005::
Data_0F0_6F79:: ; address name
    dw $00F7 ; id 0 Skullgon
    dw $010B ; id 1 Servant
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $06 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_006::
Data_0F0_6F7F:: ; address name
    dw $0107 ; id 0 DeadNoble
    dw $0108 ; id 1 WhiteKing
    dw $010D ; id 2 Copycat
    dw $0110 ; id 3 Niterich
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $07 of FamilyBandLists_Zombie; it runs to the next list)
; record: species
FamilyBandSpecies_Zombie_007::
Data_0F0_6F89:: ; address name
    dw $010C ; id 0 Lazamanus
    dw $FEFE ; id 1

; E-0256 (C1: family 8 (Material) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Material::
Data_0F0_6F8D:: ; address name
    dw FamilyBandSpecies_Material_000 ; id 0
    dw FamilyBandSpecies_Material_001 ; id 1
    dw FamilyBandSpecies_Material_002 ; id 2
    dw FamilyBandSpecies_Material_003 ; id 3
    dw FamilyBandSpecies_Material_004 ; id 4
    dw FamilyBandSpecies_Material_005 ; id 5
    dw FamilyBandSpecies_Material_006 ; id 6
    dw FamilyBandSpecies_Material_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_000::
Data_0F0_6F9D:: ; address name
    dw $011B ; id 0 MadCandle
    dw $011D ; id 1 Facer
    dw $011E ; id 2 SpikyBoy
    dw $0122 ; id 3 Goopi
    dw $0131 ; id 4 MudDoll
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $01 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_001::
Data_0F0_6FA9:: ; address name
    dw $0119 ; id 0 JewelBag
    dw $011C ; id 1 CoilBird
    dw $0128 ; id 2 Brushead
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $02 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_002::
Data_0F0_6FB1:: ; address name
    dw $011A ; id 0 EvilWand
    dw $0121 ; id 1 Puppetor
    dw $0127 ; id 2 CurseLamp
    dw $0137 ; id 3 ProtoMech
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $03 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_003::
Data_0F0_6FBB:: ; address name
    dw $011F ; id 0 MadMirror
    dw $0120 ; id 1 RogueNite
    dw $0123 ; id 2 Voodoll
    dw $0126 ; id 3 SabreMan
    dw $012B ; id 4 EvilPot
    dw $012C ; id 5 Gismo
    dw $0130 ; id 6 Exaucers
    dw $FEFE ; id 7

; E-0199 (derived: list for entry $04 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_004::
Data_0F0_6FCB:: ; address name
    dw $0124 ; id 0 MetalDrak
    dw $0129 ; id 1 Roboster
    dw $012F ; id 2 Mimic
    dw $0132 ; id 3 Golem
    dw $0134 ; id 4 BombCrag
    dw $0138 ; id 5 CloudKing
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $05 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_005::
Data_0F0_6FD9:: ; address name
    dw $0125 ; id 0 Balzak
    dw $012A ; id 1 Roboster2
    dw $012D ; id 2 LavaMan
    dw $012E ; id 3 IceMan
    dw $0133 ; id 4 StoneMan
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $06 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_006::
Data_0F0_6FE5:: ; address name
    dw $0135 ; id 0 GoldGolem
    dw $FEFE ; id 1

; E-0199 (derived: list for entry $07 of FamilyBandLists_Material; it runs to the next list)
; record: species
FamilyBandSpecies_Material_007::
Data_0F0_6FE9:: ; address name
    dw $0136 ; id 0 DarkMate
    dw $FEFE ; id 1

; E-0256 (C1: family 9 (Water) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Water::
Data_0F0_6FED:: ; address name
    dw FamilyBandSpecies_Water_000 ; id 0
    dw FamilyBandSpecies_Water_001 ; id 1
    dw FamilyBandSpecies_Water_002 ; id 2
    dw FamilyBandSpecies_Water_003 ; id 3
    dw FamilyBandSpecies_Water_004 ; id 4
    dw FamilyBandSpecies_Water_005 ; id 5
    dw FamilyBandSpecies_Water_006 ; id 6
    dw FamilyBandSpecies_Water_007 ; id 7

; E-0199 (derived: list for entry $00 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_000::
Data_0F0_6FFD:: ; address name
    dw $013C ; id 0 Petiteel
    dw $013D ; id 1 Moray
    dw $0144 ; id 2 PutreFish
    dw $FEFE ; id 3

; E-0199 (derived: list for entry $01 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_001::
Data_0F0_7005:: ; address name
    dw $0143 ; id 0 Octokid
    dw $0149 ; id 1 Gamanian
    dw $014D ; id 2 Scallopa
    dw $015B ; id 3 Starfish
    dw $FEFE ; id 4

; E-0199 (derived: list for entry $02 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_002::
Data_0F0_700F:: ; address name
    dw $0140 ; id 0 Anemon
    dw $0141 ; id 1 Aquarella
    dw $0145 ; id 2 Octoreach
    dw $014C ; id 3 RogueWave
    dw $015A ; id 4 Pumpoise
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $03 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_003::
Data_0F0_701B:: ; address name
    dw $013E ; id 0 WalrusMan
    dw $013F ; id 1 RayGigas
    dw $0142 ; id 2 Merman
    dw $0146 ; id 3 Angleron
    dw $0147 ; id 4 FishRider
    dw $014A ; id 5 Clawster
    dw $FEFE ; id 6

; E-0199 (derived: list for entry $04 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_004::
Data_0F0_7029:: ; address name
    dw $0148 ; id 0 RushFish
    dw $014B ; id 1 CancerMan
    dw $014E ; id 2 SeaHorse
    dw $014F ; id 3 HoodSquid
    dw $0150 ; id 4 MerTiger
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $05 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_005::
Data_0F0_7035:: ; address name
    dw $0151 ; id 0 AxeShark
    dw $0152 ; id 1 Octogon
    dw $0154 ; id 2 Digong
    dw $0155 ; id 3 WhaleMage
    dw $0157 ; id 4 Octoraid
    dw $FEFE ; id 5

; E-0199 (derived: list for entry $06 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_006::
Data_0F0_7041:: ; address name
    dw $0156 ; id 0 Aquadon
    dw $0158 ; id 1 Grakos
    dw $FEFE ; id 2

; E-0199 (derived: list for entry $07 of FamilyBandLists_Water; it runs to the next list)
; record: species
FamilyBandSpecies_Water_007::
Data_0F0_7047:: ; address name
    dw $0159 ; id 0 Poseidon
    dw $FEFE ; id 1

; E-0256 (C1: family 10 (Boss) of FamilyBandSpeciesTable, one list per wRankBand).
; record: species list for this band
FamilyBandLists_Boss::
Data_0F0_704B:: ; address name
    dw FamilyBandSpecies_Boss ; id 0
    dw FamilyBandSpecies_Boss_01 ; id 1
    dw FamilyBandSpecies_Boss_02 ; id 2
    dw FamilyBandSpecies_Boss_03 ; id 3
    dw FamilyBandSpecies_Boss_04 ; id 4
    dw FamilyBandSpecies_Boss_05 ; id 5
    dw FamilyBandSpecies_Boss_06 ; id 6
    dw FamilyBandSpecies_Boss_15 ; id 7

; E-0256 (C1: the boss family's eight band pointers start at successive words of this one list, so each band's list is a tail of it; 30 words up to RandomModulo29_BankF0 at $7097).
; record: species ($FFFF skipped, $FEFE ends a list)
FamilyBandSpecies_Boss::
Data_0F0_705B:: ; address name
    dw $FFFF ; id 0
FamilyBandSpecies_Boss_01:: ; heuristic: family band species list; C0
Data_0F0_705D:: ; address name
    dw $FFFF ; id 1
FamilyBandSpecies_Boss_02:: ; heuristic: family band species list; C0
Data_0F0_705F:: ; address name
    dw $FFFF ; id 2
FamilyBandSpecies_Boss_03:: ; heuristic: family band species list; C0
Data_0F0_7061:: ; address name
    dw $FFFF ; id 3
FamilyBandSpecies_Boss_04:: ; heuristic: family band species list; C0
Data_0F0_7063:: ; address name
    dw $FFFF ; id 4
FamilyBandSpecies_Boss_05:: ; heuristic: family band species list; C0
Data_0F0_7065:: ; address name
    dw $FFFF ; id 5
FamilyBandSpecies_Boss_06:: ; heuristic: family band species list; C0
Data_0F0_7067:: ; address name
    dw $015F ; id 6 DracoLord
    dw $0160 ; id 7 DracoLord
    dw $0162 ; id 8 Hargon
    dw $0163 ; id 9 Sidoh
    dw $0165 ; id 10 Baramos
    dw $0166 ; id 11 Zoma
    dw $0168 ; id 12 Pizzaro
    dw $016A ; id 13 Esterk
    dw $016B ; id 14 Mirudraas
    dw $016C ; id 15 Mirudraas
    dw $016D ; id 16 Mudou
    dw $016E ; id 17 DeathMore
    dw $016F ; id 18 DeathMore
    dw $0174 ; id 19 Darck
    dw $FEFE ; id 20
FamilyBandSpecies_Boss_15:: ; heuristic: family band species list; C0
Data_0F0_7085:: ; address name
    dw $0161 ; id 21 LordDraco
    dw $0164 ; id 22 Genosidoh
    dw $0167 ; id 23 AsuraZoma
    dw $0169 ; id 24 PsychoPiz
    dw $0170 ; id 25 DeathMore
    dw $0171 ; id 26 Darkdrium
    dw $0172 ; id 27 Orgodemir
    dw $0173 ; id 28 Orgodemir
    dw $FEFE ; id 29

; NextTableByte; L = wRandomLo, H = (wRandomLo rotated left through carry) & B; returns A = HL mod $29 (E-0118)
; 14 call sites from 4 routines (e.g. KeyWorldDoorItem_Case04_RandomModulo29_BankF0, RankFamilyScoresIntoFamilyRanking, RollMarkChangeCountChance, RecordGiftAndMaybeApplyPrevious)
; reads: wRandomLo
RandomModulo29_BankF0::
Func_0F0_7097:: ; address name
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $29
    call DivideHLByA
    ret

; A = 4, 5, 6 or 7 for wFamilyBitCount < 4, < 6, < $0A, or more (E-0124)
; 1 call site from 1 routine (e.g. RankFamilyScoresIntoFamilyRanking)
; reads: wFamilyBitCount
BandOfFamilyBitCount::
Func_0F0_70AA:: ; address name
    ld a, [wFamilyBitCount]
    cp a, $04
    jr c, .return_04
    cp a, $06
    jr c, .return_05
    cp a, $0A
    jr c, .return_06
    ld a, $07
    ret

.return_04:
    ld a, $04
    ret

.return_05:
    ld a, $05
    ret

.return_06:
    ld a, $06
    ret

; E-0241 (C0: no reference found in any bank (no address load, word or split high/low load of $70C5-$7244); 384 bytes after BandOfFamilyBitCount's last ret, all values 0-7, in runs that climb to 6 or 7 separated by zeros; meaning unknown, kept as 16-byte rows).
; record: bytes
UnreferencedBytes_F0_70C5::
Data_0F0_70C5:: ; address name
    db $03, $00, $02, $01, $00, $03, $01, $02, $02, $01, $02, $03, $03, $03, $00, $05 ; id 0
    db $04, $05, $04, $01, $04, $04, $05, $06, $07, $01, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $00, $00, $00, $02, $02, $02, $02, $00, $04, $01, $03, $03, $04, $01, $04 ; id 2
    db $03, $00, $00, $04, $01, $03, $01, $04, $05, $01, $02, $04, $06, $05, $05, $05 ; id 3
    db $06, $07, $06, $00, $00, $00, $00, $02, $00, $00, $00, $00, $04, $01, $01, $02 ; id 4
    db $00, $02, $02, $01, $01, $03, $03, $01, $02, $02, $01, $00, $05, $03, $03, $04 ; id 5
    db $06, $05, $04, $04, $07, $03, $03, $00, $00, $00, $00, $03, $02, $01, $03, $03 ; id 6
    db $01, $02, $02, $00, $01, $01, $02, $02, $03, $03, $03, $04, $04, $04, $05, $05 ; id 7
    db $04, $06, $07, $06, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $02 ; id 8
    db $01, $00, $02, $00, $03, $00, $02, $01, $02, $03, $03, $05, $05, $03, $03, $03 ; id 9
    db $04, $04, $06, $07, $07, $07, $00, $03, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $03, $01, $01, $03, $00, $02, $02, $02, $00, $01, $00, $03, $02, $03, $03 ; id 11
    db $04, $03, $02, $05, $05, $04, $06, $05, $07, $03, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $00, $00, $00, $02, $04, $00, $03, $02, $03, $04, $04, $01, $01, $05, $04 ; id 13
    db $05, $03, $04, $05, $05, $05, $05, $06, $04, $05, $03, $05, $03, $06, $06, $07 ; id 14
    db $06, $00, $00, $00, $00, $00, $00, $05, $02, $01, $02, $03, $03, $02, $02, $02 ; id 15
    db $01, $02, $02, $03, $01, $01, $03, $06, $06, $03, $04, $05, $07, $06, $03, $02 ; id 16
    db $06, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $01, $00, $00, $03 ; id 17
    db $03, $02, $00, $03, $04, $05, $03, $02, $01, $04, $05, $03, $03, $05, $05, $04 ; id 18
    db $03, $00, $04, $05, $04, $06, $07, $02, $04, $00, $00, $00, $00, $00, $03, $03 ; id 19
    db $02, $02, $03, $01, $00, $02, $03, $03, $04, $01, $03, $04, $02, $01, $04, $04 ; id 20
    db $04, $05, $05, $06, $05, $05, $06, $05, $06, $07, $02, $01, $00, $00, $00, $06 ; id 21
    db $06, $07, $06, $06, $07, $06, $06, $07, $06, $07, $06, $06, $06, $06, $06, $06 ; id 22
    db $07, $07, $07, $07, $06, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 23

; wMarkChangeCount counts changes of B (wLastMarkedBit); if bit B of the wFamilyBits array is new, sets it, wFamilyBitCount += 1 and C = 0; otherwise C = $FF (E-0125)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case00)
; reads: wLastMarkedBit, wMarkChangeCount, wFamilyBitCount
; writes: wMarkChangeCount, wLastMarkedBit, wFamilyBitCount
; points at: wFamilyBits
MarkBitBInFamilyBitsAndCount::
Func_0F0_7245:: ; address name
    ld a, [wLastMarkedBit]
    cp a, b
    jr z, .set_last_marked_bit
    ld a, [wMarkChangeCount]
    cp a, $FF
    jr z, .set_mark_change_count
    inc a

.set_mark_change_count:
    ld [wMarkChangeCount], a

.set_last_marked_bit:
    ld a, b
    ld [wLastMarkedBit], a
    ld hl, wFamilyBits
    ld e, a
    ld d, $00
    call TestBitDEOfBitArrayHL
    cp a, $FF
    jr z, .done2
    ld a, [wLastMarkedBit]
    ld hl, wFamilyBits
    ld e, a
    ld d, $00
    call OrDIntoTestBitDEOfBitArrayHLByte
    ld a, [wFamilyBitCount]
    cp a, $FF
    jr nc, .done
    inc a
    ld [wFamilyBitCount], a

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; wGiftCount (wGiftCount) += 1 up to $0F; when a gift is pending (wPendingGiftItem, wPendingGiftItem), applies its effect (ApplyGiftEffectByItem) if a random value is below 100 - 5 * wGiftCount; then the new gift item (wArg1, from PauseMenu_State4_GiftMenu_GiveGift) becomes pending (E-0124, E-0295)
; 1 call site from 1 routine (e.g. PauseMenu_State4_GiftMenu_GiveGift_WriteArg1AndCounterPtr0LoEtc)
; reads: wGiftCount, wPendingGiftItem, wArg1
; writes: wGiftCount, wPendingGiftItem
RecordGiftAndMaybeApplyPrevious::
Func_0F0_7284:: ; address name
    ld a, [wGiftCount]
    cp a, $0F
    jr nc, .check_pending_gift_item
    inc a
    ld [wGiftCount], a

.check_pending_gift_item:
    ld a, [wPendingGiftItem]
    and a, a
    jr z, .read_arg1
    ld a, [wGiftCount]
    ld c, $05
    call Multiply8
    ld a, $64
    sub a, l
    ld l, a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    pop de
    ld a, l
    cp a, e
    call c, ApplyGiftEffectByItem

.read_arg1:
    ld a, [wArg1]
    ld [wPendingGiftItem], a
    ret

; when wGM2TimerMinutes = $3B and wGM2TimerSeconds = wGM2TimerFrames = 0, clears wGiftCount and falls through (E-0122)
; 1 call site from 1 routine (e.g. CallF072B4WhenGM2TimerMinutesIs59)
; reads: wGM2TimerMinutes, wGM2TimerSeconds, wGM2TimerFrames, wPendingGiftItem
; writes: wGiftCount
ClearRollCounterWhenGM2TimerMinutesIs59::
Func_0F0_72B4:: ; address name
    ld a, [wGM2TimerMinutes]
    cp a, $3B
    ret nz
    ld a, [wGM2TimerSeconds]
    and a, a
    ret nz
    ld a, [wGM2TimerFrames]
    and a, a
    ret nz
    xor a, a
    ld [wGiftCount], a

; jumps by wPendingGiftItem (the item id of the previous gift, stored by RecordGiftAndMaybeApplyPrevious) to that item's effect; each effect adds to the gift record's MON_MAX_HP (wGiftRecord, capped at 999) and to or from entries of wFamilyScores, then clears wPendingGiftItem (E-0312)
; 1 call site from 1 routine (e.g. RecordGiftAndMaybeApplyPrevious)
; reads: wPendingGiftItem
ApplyGiftEffectByItem::
Func_0F0_72C8:: ; address name
    ld a, [wPendingGiftItem]
    rst $00
    dw GiftEffect_Item00
    dw GiftEffect_Herb
    dw GiftEffect_LoveWater
    dw GiftEffect_WorldDew
    dw GiftEffect_Potion
    dw GiftEffect_ElfWater
    dw GiftEffect_Antidote
    dw GiftEffect_MoonHerb
    dw GiftEffect_Laurel
    dw GiftEffect_AwakeSand
    dw GiftEffect_SkyBell
    dw GiftEffect_SageRock
    dw GiftEffect_WorldLeaf
    dw GiftEffect_ATKseed
    dw GiftEffect_DEFseed
    dw GiftEffect_AGLseed
    dw GiftEffect_INTseed
    dw GiftEffect_LifeAcorn
    dw GiftEffect_MysticNut
    dw GiftEffect_Quest
    dw GiftEffect_Horror
    dw GiftEffect_BeNice
    dw GiftEffect_Cheater
    dw GiftEffect_Smart
    dw GiftEffect_Comedy
    dw GiftEffect_BeefJerky
    dw GiftEffect_PorkChop
    dw GiftEffect_Rib
    dw GiftEffect_Sirloin
    dw GiftEffect_BadMeat
    dw GiftEffect_MeteOrb
    dw GiftEffect_BeastTail
    dw GiftEffect_Repellent
    dw GiftEffect_ShinyHarp
    dw GiftEffect_Mist
    dw GiftEffect_Friend
    dw GiftEffect_Wind
    dw GiftEffect_Bolt
    dw GiftEffect_Snow
    dw GiftEffect_Fire
    dw GiftEffect_Warp
    dw GiftEffect_WarpWing
    dw GiftEffect_ExitBell
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_TinyMedal
    dw GiftEffect_GoldPass
    dw GiftEffect_LogTwig
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_VITbelt
    dw GiftEffect_DracoBelt
    dw GiftEffect_MagicBelt
    dw GiftEffect_OddBelt
    dw GiftEffect_StoneFang
    dw GiftEffect_SteelFang
    dw GiftEffect_MermScale
    dw GiftEffect_DrakScale
    dw GiftEffect_AGL
    dw GiftEffect_Starry
    dw GiftEffect_Smart_4A
    dw GiftEffect_Wise
    dw GiftEffect_MagicCape
    dw GiftEffect_DracoCape
    dw GiftEffect_SilvrCape
    dw GiftEffect_GoldCape
    dw GiftEffect_PltnmCape
    dw GiftEffect_OrcaCape
    dw GiftEffect_BraveCape
    dw GiftEffect_DScale
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_BookmarkEtc
    dw GiftEffect_Life
    dw GiftEffect_Divine
    dw GiftEffect_War
    dw GiftEffect_Mage
    dw GiftEffect_Fight
    dw GiftEffect_Sailor
    dw GiftEffect_Thief
    dw GiftEffect_Cleric

; gift effect for item $00 : case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
GiftEffect_Item00::
Jump_0F0_7390:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ret

; gift effect for item $01 Herb: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_Herb::
Jump_0F0_739B:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $02 LoveWater: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_LoveWater::
Jump_0F0_73BD:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $03 WorldDew: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_WorldDew::
Jump_0F0_73DF:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $04 Potion: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Potion::
Jump_0F0_7401:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $05 ElfWater: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_ElfWater::
Jump_0F0_7423:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $06 Antidote: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Antidote::
Jump_0F0_7445:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $07 MoonHerb: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MoonHerb::
Jump_0F0_7452:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $08 Laurel: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Laurel::
Jump_0F0_7474:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $09 AwakeSand: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_AwakeSand::
Jump_0F0_7496:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0A SkyBell: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_SkyBell::
Jump_0F0_74B8:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0B SageRock: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_SageRock::
Jump_0F0_74DA:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0C WorldLeaf: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_WorldLeaf::
Jump_0F0_74FC:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0D ATKseed: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_ATKseed::
Jump_0F0_751E:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0E DEFseed: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_DEFseed::
Jump_0F0_7536:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $0F AGLseed: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_AGLseed::
Jump_0F0_754E:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $10 INTseed: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_INTseed::
Jump_0F0_7566:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $11 LifeAcorn: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_LifeAcorn::
Jump_0F0_757E:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $12 MysticNut: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MysticNut::
Jump_0F0_7596:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $13 Quest?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Quest::
Jump_0F0_75AE:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $14 Horror?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Horror::
Jump_0F0_75D0:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $15 BeNice?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BeNice::
Jump_0F0_75F2:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $16 Cheater?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Cheater::
Jump_0F0_7614:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $17 Smart?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Smart::
Jump_0F0_7636:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $18 Comedy?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_Comedy::
Jump_0F0_7658:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $19 BeefJerky: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BeefJerky::
Jump_0F0_767A:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1A PorkChop: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_PorkChop::
Jump_0F0_7692:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1B Rib: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Rib::
Jump_0F0_76B4:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1C Sirloin: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Sirloin::
Jump_0F0_76D6:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1D BadMeat: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BadMeat::
Jump_0F0_76F8:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1E MeteOrb: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MeteOrb::
Jump_0F0_7712:: ; address name
    ld hl, wFamilyScores + $A
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $1F BeastTail: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BeastTail::
Jump_0F0_7729:: ; address name
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $20 Repellent: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Repellent::
Jump_0F0_772E:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $21 ShinyHarp: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_ShinyHarp::
Jump_0F0_7746:: ; address name
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $22 Mist?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Mist::
Jump_0F0_774B:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $23 Friend?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Friend::
Jump_0F0_776D:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $24 Wind?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_Wind::
Jump_0F0_778F:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $25 Bolt?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Bolt::
Jump_0F0_77B1:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $26 Snow?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Snow::
Jump_0F0_77D3:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $27 Fire?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Fire::
Jump_0F0_77F5:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $28 Warp?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Warp::
Jump_0F0_7817:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $29 WarpWing: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_WarpWing::
Jump_0F0_7839:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $2A ExitBell: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_ExitBell::
Jump_0F0_785B:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $02
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $2B Bookmark, $2F , $30 WaterCall, $31 MoonRock, $32 Crest, $33 YunaSoul ...: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BookmarkEtc::
Jump_0F0_787D:: ; address name
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $2C TinyMedal: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_TinyMedal::
Jump_0F0_7882:: ; address name
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $2D GoldPass: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_GoldPass::
Jump_0F0_7887:: ; address name
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $2E LogTwig: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_LogTwig::
Jump_0F0_788C:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $40 VITbelt: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_VITbelt::
Jump_0F0_7899:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $41 DracoBelt: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_DracoBelt::
Jump_0F0_78BB:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $08
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $42 MagicBelt: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MagicBelt::
Jump_0F0_78DD:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $43 OddBelt: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_OddBelt::
Jump_0F0_78FF:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $08
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $44 StoneFang: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_StoneFang::
Jump_0F0_7921:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $45 SteelFang: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_SteelFang::
Jump_0F0_7943:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $46 MermScale: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MermScale::
Jump_0F0_7965:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $47 DrakScale: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_DrakScale::
Jump_0F0_7987:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $48 AGL?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_AGL::
Jump_0F0_79A9:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $49 Starry?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_Starry::
Jump_0F0_79CB:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4A Smart?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Smart_4A::
Jump_0F0_79ED:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4B Wise?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Wise::
Jump_0F0_7A0F:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4C MagicCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_MagicCape::
Jump_0F0_7A31:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $08
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4D DracoCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_DracoCape::
Jump_0F0_7A53:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4E SilvrCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_SilvrCape::
Jump_0F0_7A75:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $4F GoldCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_GoldCape::
Jump_0F0_7A97:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $50 PltnmCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_PltnmCape::
Jump_0F0_7AB9:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $A
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $51 OrcaCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_OrcaCape::
Jump_0F0_7ADB:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $52 BraveCape: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_BraveCape::
Jump_0F0_7AFD:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $53 D-Scale: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_DScale::
Jump_0F0_7B1F:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5A Life?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Life::
Jump_0F0_7B41:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5B Divine?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Divine::
Jump_0F0_7B63:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5C War?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_War::
Jump_0F0_7B85:: ; address name
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5D Mage?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Mage::
Jump_0F0_7BA7:: ; address name
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5E Fight?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Fight::
Jump_0F0_7BC9:: ; address name
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $5F Sailor?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Sailor::
Jump_0F0_7BEB:: ; address name
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $60 Thief?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
GiftEffect_Thief::
Jump_0F0_7C0D:: ; address name
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; gift effect for item $61 Cleric?: case of ApplyGiftEffectByItem
; no direct call (reached through a table, a jump or a vector)
; writes: wPendingGiftItem
; points at: wFamilyScores
GiftEffect_Cleric::
Jump_0F0_7C2F:: ; address name
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $FD
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wPendingGiftItem], a
    ret

; [HL] = min([HL] + B, C) (8-bit add, no overflow check); clobbers A, C
; 60 call sites from 60 routines (e.g. GiftEffect_Cleric, GiftEffect_Thief, GiftEffect_Sailor, GiftEffect_Fight, ...)
AddBClampedToC::
Func_0F0_7C51:: ; address name
    inc c
    ld a, [hl]
    add a, b
    cp a, c
    jr c, .done
    ld a, c
    dec a

.done:
    ld [hl], a
    ret

; [HL] = [HL] - B, or 0 when the result has bit 7 set; clobbers A
; 68 call sites from 68 routines (e.g. GiftEffect_Cleric, GiftEffect_Thief, GiftEffect_Sailor, GiftEffect_Fight, ...)
SubtractBClampedAtZero::
Func_0F0_7C5B:: ; address name
    ld a, [hl]
    sub a, b
    bit 7, a
    jr z, .done
    xor a, a

.done:
    ld [hl], a
    ret

; HL = address of a word: word = min(word + B, DE) (CompareHLWithDE); DE kept; clobbers A, BC, HL (E-0061)
; 66 call sites from 66 routines (e.g. GiftEffect_Cleric, GiftEffect_Thief, GiftEffect_Sailor, GiftEffect_Fight, ...)
AddBToWordAtHLCapped::
Func_0F0_7C64:: ; address name
    push hl
    ld a, [hl+]
    add a, b
    ld c, a
    ld a, [hl]
    adc a, $00
    ld h, a
    ld l, c
    call CompareHLWithDE
    ld a, c
    cp a, $FF
    jr nz, .restore
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

.restore:
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ret

; unsigned 16-bit compare: C = 0 when HL < DE, 1 when equal, $FF when HL > DE; clobbers A (E-0061)
; 1 call site from 1 routine (e.g. AddBToWordAtHLCapped)
CompareHLWithDE::
Func_0F0_7C81:: ; address name
    ld a, h
    cp a, d
    jr c, .done2
    jr nz, .done
    ld a, l
    cp a, e
    jr c, .done2
    jr z, .done3

.done:
    ld c, $FF
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; copies the $F0-terminated string [HL] of the category chosen by [HL + 1] (Data_0F0_4036 or Data_008_4038) from bank 8 to HL (E-0125)
; 2 call sites from 2 routines (e.g. RunLinkSession8Exchange_ObjectScene_ShowGHatchedFromThe, RunLinkSession8Exchange_EggHatched_ShowGHatchedFromThe)
CopyNameStringFromBank08Database::
Func_0F0_7C96:: ; address name
    push de
    inc hl
    ld a, [hl-]
    and a, a
    jr nz, .skip
    ld de, CopyNameStringFromBank08Database_Data_4036
    jr .call_read_far_pointer_at_de_in_bank_b

.skip:
    ld de, CopyNameStringFromBank08Database_Data_4038

.call_read_far_pointer_at_de_in_bank_b:
    push hl
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld c, l
    ld b, h
    pop hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    pop hl

.call_read_byte_in_bank:
    ld b, $08
    call ReadByteInBank
    ld a, c
    cp a, $F0
    jr z, .done
    ld [hl+], a
    inc de
    jr .call_read_byte_in_bank

.done:
    ld a, $F0
    ld [hl+], a
    ret

; A = $FF when bit DE of the bit array at HL is set (mask Data_0F0_7CFB), else 0; HL is left at the byte (E-0124)
; 2 call sites from 2 routines (e.g. MarkBitBInFamilyBitsAndCount, OrDIntoTestBitDEOfBitArrayHLByte)
TestBitDEOfBitArrayHL::
Func_0F0_7CD4:: ; address name
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop de
    push hl
    ld a, e
    and a, $07
    ld hl, TestBitDEOfBitArrayHL_Data
    add_a_to_hl
    ld a, [hl]
    ld d, a
    pop hl
    ld a, [hl]
    and a, d
    jr nz, .return_FF
    xor a, a
    ret

.return_FF:
    ld a, $FF
    ret

; address loaded by TestBitDEOfBitArrayHL
TestBitDEOfBitArrayHL_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F0_7CFB:: ; address name
    db $80, $40, $20, $10, $08, $04, $02, $01

; [HL from Func_0F0_7CD4] |= D (E-0122)
; 1 call site from 1 routine (e.g. MarkBitBInFamilyBitsAndCount)
OrDIntoTestBitDEOfBitArrayHLByte::
Func_0F0_7D03:: ; address name
    call TestBitDEOfBitArrayHL
    ld a, [hl]
    or a, d
    ld [hl], a
    ret

; only called from KeyWorldDoorItem_Case04 (E-0047)
; 1 call site from 1 routine (e.g. KeyWorldDoorItem_DrawDoorTilesForKeyWorldFloor)
; reads: wPlayerId
; points at: wGM2TimerFrames, wGiftRecord, wPlayerName
KeyWorldDoorItem_Case04_RandomModulo29_BankF0::
Func_0F0_7D0A:: ; address name
    ld hl, wGM2TimerFrames
    ld bc, $00D8

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wGiftRecord
    ld a, $01
    ld [hl+], a
    ld c, $0A

.loop2:
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, .loop2
    ld a, $1A
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld a, l
    and a, $01
    pop hl
    ld [hl+], a
    ld de, wPlayerName
    ld c, $0A

.loop3:
    ld a, [de]
    cp a, $F0
    jr z, .skip
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop3
    jr .read_player_id

.skip:
    ld a, $F0
    ld [hl+], a

.read_player_id:
    ld hl, wGiftRecord + MON_MASTER_ID
    ld a, [wPlayerId]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call KeyWorldDoorItem_WriteUnknownName
    ld c, $06
    ld b, $F0
    call KeyWorldDoorItem_FillCBytesWithB
    ld a, $F0
    ld [hl+], a
    call KeyWorldDoorItem_WriteUnknownName
    ld c, $06
    ld b, $F0
    call KeyWorldDoorItem_FillCBytesWithB
    ld a, $F0
    ld [hl+], a
    ld c, $21

.loop4:
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, .loop4
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hl+], a
    ld c, $1B

.loop5:
    xor a, a
    ld [hl+], a
    dec c
    jr nz, .loop5
    ld c, $0A

.loop6:
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, .loop6
    xor a, a
    ld [hl+], a
    ld c, $0A

.loop7:
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, .loop7
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

; fills C bytes at HL with B
; 2 call sites from 1 routine (e.g. KeyWorldDoorItem_Case04_RandomModulo29_BankF0)
KeyWorldDoorItem_FillCBytesWithB::
Func_0F0_7E4A:: ; address name
    ld a, b
    ld [hl+], a
    dec c
    jr nz, KeyWorldDoorItem_FillCBytesWithB
    ret

; writes three $98 placeholder glyphs and $F0 at HL
; 2 call sites from 1 routine (e.g. KeyWorldDoorItem_Case04_RandomModulo29_BankF0)
KeyWorldDoorItem_WriteUnknownName::
Func_0F0_7E50:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ret

; DE = (L mod B) + 1
; 10 call sites from 1 routine (e.g. KeyWorldDoorItem_Case04_RandomModulo29_BankF0)
KeyWorldDoorItem_ModuloBPlusOne::
Func_0F0_7E5D:: ; address name
    ld a, l

.skip:
    cp a, b
    jr c, .skip2
    sub a, b
    jr .skip

.skip2:
    inc a
    ld e, a
    ld d, $00
    ret

; A = 1 with a chance growing with wMarkChangeCount (none below 5, 10 per step to 80 from 13), else 0 (E-0124)
; 1 call site from 1 routine (e.g. RunLinkSession8Exchange_Case01_Sub01_Table5_Case00)
; reads: wMarkChangeCount
RollMarkChangeCountChance::
Func_0F0_7E69:: ; address name
    ld a, [wMarkChangeCount]
    cp a, $05
    jr nc, .cp_0D

.loop:
    xor a, a
    ret

.cp_0D:
    cp a, $0D
    jr nc, .skip
    sub a, $04
    ld c, $0A
    call Multiply8
    ld e, l
    jr .call_random_modulo29_bank_f0

.skip:
    ld e, $50

.call_random_modulo29_bank_f0:
    push de
    ld b, $0F
    call RandomModulo29_BankF0
    ld a, l
    pop de
    cp a, e
    jr nc, .loop
    ld a, $01
    ret
    ds $170, $00
