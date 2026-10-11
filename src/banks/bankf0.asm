SECTION "Bank F0", ROMX[$4000], BANK[$F0]
    db $F0

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case15)
BeginStringDisplay_BankF0_4001::
Func_0F0_4001:: ; address name
    ld de, Data_0F0_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_0F0_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $18, $40, $A2, $40, $DA, $40, $FB, $40, $1E, $41, $65, $41, $84, $41, $BA, $41
    db $D9, $41, $FE, $41, $19, $42, $3C, $42, $44, $42, $53, $42, $72, $42, $95, $42

Data_0F0_4036:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C0036, $6E
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's ", $F9, "0G a", $F1
    db "night.", $FA, $F7
    db $EF, $EE, "Will you stay with", $EF, $EE, "us tonight?"
    db $FF, $F0, $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well then, have", $F1
    db "a good rest.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please come stay", $F1
    db "another time.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sorry, but you", $F1
    db "lack the money.", $FA, $F7
    db $EF, $EE, "I hope you'll stay", $EF, $EE, "another time.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good morning", $F1
    db "and farewell!", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to my", $F1
    db "shop.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What would you", $F1
    db "like to buy?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have no more", $F1
    db "room for items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there", $F1
    db "anything else?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many would", $F1
    db "you like to buy?", $F0, $EA
    db $45, $90, $F9, $00, $98, $FF, $F0, $EA, $45, $90, $1D, $2B, $24, $31, $2E, $90
    db $3C, $32, $38, $99, $F7, $F0, $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? You're short", $F1
    db "some gold.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "any more items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What would you", $F1
    db "like to sell?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have no", $F1
    db "items to sell.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sorry, but I", $F1
    db "can't price that.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many will", $F1
    db "you sell?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thank you!", $F1
    db "Please come again.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "any more items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That comes to", $F1
    db $F9, "0G. OK?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "Vault.", $FA, $F7
    db $EF, $EE, "What can I do for", $EF, $EE, "you today?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What should we", $F1
    db "store for you?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "any items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there", $F1
    db "anything else?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sorry, but you", $F1
    db "filled the Vault.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What item should", $F1
    db "I store for you?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many should", $F1
    db "I store?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK, I'll put", $F1
    db "that away for you.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can't store", $F1
    db "that much.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "enough to store.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How much do you", $F1
    db "want to deposit?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What will you be", $F1
    db "taking out?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't have any", $F1
    db "of your items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "any more items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What do you want", $F1
    db "back?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many do you", $F1
    db "want back?", $F0, $EA
    db $45, $90, $11, $28, $35, $28, $90, $3C, $32, $38, $90, $2A, $32, $B5, $F7, $F0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "that much.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't have any", $F1
    db "of your money.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How much gold", $F1
    db "will you withdraw?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sorry, but I", $F1
    db "can't take another", $FA, $F7
    db $EF, $EE, "kind of item.", $EF, $EE, "There's no room.", $F7
    db $F0, $EA
    db $45, $90, $0C, $32, $30, $28, $90, $24, $2A, $24, $2C, $31, $F1, $24, $31, $3C
    db $37, $2C, $30, $28, $99, $F7, $F0, $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't have any", $F1
    db "more items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can't store", $F1
    db "that many.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can't take any", $F1
    db "more of that item.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "Vault.", $FA, $F7
    db $EF, $EE, "How may I help you", $EF, $EE, "today?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What would you", $F1
    db "like to buy?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "any more items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there", $F1
    db "anything else?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many would", $F1
    db "you like?", $F0, $EA
    db $45, $90, $F9, $00, $98, $FF, $F0, $EA, $45, $90, $1D, $2B, $24, $31, $2E, $90
    db $3C, $32, $38, $99, $F7, $F0, $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "enough gold.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't hold", $F1
    db "that many items.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What would you", $F1
    db "like to sell?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have nothing", $F1
    db "to sell me.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can't put a", $F1
    db "price on that.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many will", $F1
    db "you sell?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thank you!", $F1
    db "Please come again!", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't carry", $F1
    db "any more items.", $F7
    db $F0, $EA
    db $45, $90, $1D, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $25, $28, $F1, $F9
    db $00, $10, $B5, $90, $18, $14, $98, $F0

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. BeginString_BankF0_Cat0, ShowString_BankF0, DebugMessageTest_Update_Case18, Func_0F1_4001_Case02_Case02, ...)
BeginStringDisplay_BankF0_48A0::
Func_0F0_48A0:: ; address name
    ld de, Data_0F0_48B5
    call BeginStringDisplay
    ret
    db $11, $B5, $48, $CD, $FE, $25, $C9

; Func_0F0_48A0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 6 call sites from 6 routines (e.g. Func_0F0_4CA0_Table2_Case05, Func_0F0_4CA0_Table3_Case04, Func_0F0_4CA0_Table3_Case01, RunScreenStep_F0_5DE8_Case0B, ...)
ShowString_BankF0::
Func_0F0_48AE:: ; address name
    call BeginStringDisplay_BankF0_48A0
    call RunStringDisplayToEnd
    ret

Data_0F0_48B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F0_48B7

Data_0F0_48B7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_48FD
    dw Data_0F0_491A
    dw Data_0F0_4933
    dw Data_0F0_4954
    dw Data_0F0_4973
    dw Data_0F0_4998
    dw Data_0F0_49BB
    dw Data_0F0_49DA
    dw Data_0F0_49FD
    dw Data_0F0_4A0B
    dw Data_0F0_4A23
    dw Data_0F0_4A3E
    dw Data_0F0_4A5A
    dw Data_0F0_4AAF
    dw Data_0F0_4B05
    dw Data_0F0_4B43
    dw Data_0F0_4B43
    dw Data_0F0_4B43
    dw Data_0F0_4B57
    dw Data_0F0_4B65
    dw Data_0F0_4B89
    dw Data_0F0_4BC8
    dw Data_0F0_4C00
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C27
    dw Data_0F0_4C32
    dw Data_0F0_4C3D
    dw Data_0F0_4C44
    dw Data_0F0_4C4A
    dw Data_0F0_4C67
    dw Data_0F0_4C83

Data_0F0_48FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Obtain a Dream Egg", $F1
    db "from ", $F9, "m?", $F0

Data_0F0_491A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Give a Dream Egg", $F1
    db "to ", $F9, "m?", $F0

Data_0F0_4933:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Refused to accept", $F1
    db "a Dream Egg.", $F7
    db $F0

Data_0F0_4954:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Your Dream Egg was", $F1
    db "rejected.", $F7
    db $F0

Data_0F0_4973:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Choose the kind of", $F1
    db "egg to transfer.", $F0

Data_0F0_4998:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Choose the egg to", $F1
    db "be transferred.", $F0

Data_0F0_49BB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Is it OK to", $F1
    db "transfer the egg?", $F0

Data_0F0_49DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "OK to save the egg", $F1
    db "trade results?", $F0

Data_0F0_49FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Please wait", $A4, $F0

Data_0F0_4A0B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 received", $F1
    db "your egg.", $F7
    db $F0

Data_0F0_4A23:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Obtained an egg", $F1
    db "from ", $F9, "0.", $F7
    db $F0

Data_0F0_4A3E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Eggs were traded", $F1
    db "with ", $F9, "0.", $F7
    db $F0

Data_0F0_4A5A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "G hatched", $F1
    db "from the egg that", $FA, $F7
    db $EF, $EE, "you put up for", $EF, $EE, "transfer.", $FA, $F7
    db $EF, $EE, "Please name your", $EF, $EE, $F9, "G.", $F7
    db $F0

Data_0F0_4AAF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "G hatched", $F1
    db "from the egg that", $FA, $F7
    db $EF, $EE, "you were about to", $EF, $EE, "receive.", $FA, $F7
    db $EF, $EE, $F9, "G went", $EF, $EE, "back to ", $F9, "0.", $F7
    db $F0

Data_0F0_4B05:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 received", $F1
    db $F9, "G", $95, "s egg.", $FA, $F7
    db $EF, $EE, "Please raise it", $EF, $EE, "with loving care.", $F7
    db $F0

Data_0F0_4B43:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "You have no eggs.", $F7
    db $F0

Data_0F0_4B57:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Please wait", $A4, $F0

Data_0F0_4B65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "m has no Dream", $F1
    db "Egg to trade you.", $F7
    db $F0

Data_0F0_4B89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "There is no more", $F1
    db "room for eggs.", $FA, $F7
    db $EF, $EE, "Trading is not", $EF, $EE, "possible.", $F7
    db $F0

Data_0F0_4BC8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "You have an egg", $F1
    db "already.", $FA, $F7
    db $EF, $EE, "Trading is not", $EF, $EE, "possible.", $F7
    db $F0

Data_0F0_4C00:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "m already has", $F1
    db "a Dream Egg.", $F7
    db $F0

Data_0F0_4C1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiftExit", $F0

Data_0F0_4C27:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Store  Get", $F0

Data_0F0_4C32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ally Store", $F0

Data_0F0_4C3D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOK", $F0

Data_0F0_4C44:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YesNo", $F0

Data_0F0_4C4A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose what to", $F1
    db "give the egg.", $F0

Data_0F0_4C67:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "W is in", $F1
    db "front of the egg.", $F7
    db $F0

Data_0F0_4C83:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "W can't be", $F1
    db "given to an egg.", $F7
    db $F0

; only called from RunLinkExchangeState_457B_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_457B_Case01)
; reads: wFadeState, wScreenState, wTextFlags
; writes: wLinkScreenState
RunLinkExchangeState_457B_Case01_Sub01::
Func_0F0_4CA0:: ; address name
    ld a, $01
    ld [wLinkScreenState], a
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_0F0_4CB7
    ld a, [wTextFlags]
    bit 0, a
    ret nz

Jump_0F0_4CB7::
    ld a, [wScreenState]
    rst $00
    dw Func_0F0_4CA0_Case00
    dw Func_0F0_4CA0_Case01
    dw Func_0F0_4CA0_Case02
    dw Func_0F0_4CA0_Case03
    dw Func_0F0_4CA0_Case04
    dw Func_0F0_4CA0_Case05
    dw Func_0F0_4CA0_Case06
    dw Func_0F0_4CA0_Case07
    dw Func_0F0_4CA0_Case08
    dw Func_0F0_4CA0_Case09
    dw Func_0F0_4CA0_Case0A
    dw Func_0F0_4CA0_Case0B
    dw Func_0F0_4CA0_Case0C

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
Func_0F0_4CA0_Case00::
Jump_0F0_4CD5:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, Jump_0F0_4CEE
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

Jump_0F0_4CEE::
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Table2_Case00
    dw Func_0F0_4CA0_Table2_Case01
    dw Func_0F0_4CA0_Table2_Case02
    dw Func_0F0_4CA0_Table2_Case03
    dw Func_0F0_4CA0_Table2_Case04
    dw Func_0F0_4CA0_Table2_Case05
    dw Func_0F0_4CA0_Table2_Case06
    dw Func_0F0_4CA0_Table2_Case07

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
Func_0F0_4CA0_Table2_Case00::
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
Func_0F0_4CA0_Table2_Case01::
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
; reads: wScreenStep, wSaveByte16
; writes: wScreenStep, wBankF0ByteA3, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, ...
; points at: wPlayerName, wLinkRecvBuffer, wLinkPartnerName
Func_0F0_4CA0_Table2_Case02::
Jump_0F0_4D21:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wPlayerName
    ld de, wLinkRecvBuffer
    ld c, $0A

Jump_0F0_4D30::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0F0_4D3B
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_0F0_4D30

Jump_0F0_4D3B::
    ld a, $F0
    ld [de], a
    ld a, [wSaveByte16]
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
Func_0F0_4CA0_Table2_Case03::
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
Func_0F0_4CA0_Table2_Case04::
Jump_0F0_4D86:: ; address name
    ld hl, wLinkPartnerName
    ld de, wTextBuf3
    ld c, $0A

Jump_0F0_4D8E::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0F0_4D99
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, Jump_0F0_4D8E

Jump_0F0_4D99::
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wGM2Mode
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wFamilyRankTaken, wTextWindowTileLo, wScreenStep
Func_0F0_4CA0_Table2_Case05::
Jump_0F0_4DA4:: ; address name
    ld hl, wFamilyRankTaken
    ld b, $35

Jump_0F0_4DA9::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_4DA9
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
    ld a, [wGM2Mode]
    and a, a
    jr z, Jump_0F0_4DE7
    ld a, $01
    jr Jump_0F0_4DE8

Jump_0F0_4DE7::
    xor a, a

Jump_0F0_4DE8::
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wChoiceCursorF0
; points at: wScreenStep
Func_0F0_4CA0_Table2_Case06::
Jump_0F0_4DF0:: ; address name
    ld de, Data_0F0_663F
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
Func_0F0_4CA0_Table2_Case07::
Jump_0F0_4E11:: ; address name
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, Jump_0F0_4E25
    cp a, $FE
    jr z, Jump_0F0_4E3D
    ret

Jump_0F0_4E25::
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_0F0_4E3D
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $05
    ld [wScreenState], a
    ld a, $07
    call BeginString_BankF0_Cat0
    ret

Jump_0F0_4E3D::
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08
    call BeginString_BankF0_Cat0
    ld a, $BD
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
Func_0F0_4CA0_Case01::
Jump_0F0_4E54:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, Jump_0F0_4E6D
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

Jump_0F0_4E6D::
    call RunScreenStep_F0_5B50
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
Func_0F0_4CA0_Case02::
Jump_0F0_4E71:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, Jump_0F0_4E8A
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

Jump_0F0_4E8A::
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Table3_Case00
    dw Func_0F0_4CA0_Table3_Case01
    dw Func_0F0_4CA0_Table3_Case02
    dw Func_0F0_4CA0_Table3_Case03
    dw Func_0F0_4CA0_Table3_Case04
    dw Func_0F0_4CA0_Table3_Case05

; entry 0 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
Func_0F0_4CA0_Table3_Case00::
Jump_0F0_4E9A:: ; address name
    ld a, $06
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
; points at: wTextWindowTileLo
Func_0F0_4CA0_Table3_Case01::
Jump_0F0_4EA4:: ; address name
    ld de, Data_0F0_665D
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_0F0_6526
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
Func_0F0_4CA0_Table3_Case02::
Jump_0F0_4EFE:: ; address name
    ld de, Data_0F0_6617
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
Func_0F0_4CA0_Table3_Case03::
Jump_0F0_4F22:: ; address name
    xor a, a
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, Jump_0F0_4F35
    cp a, $FE
    jr z, Jump_0F0_4F5A
    ret

Jump_0F0_4F35::
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_0F0_4F47
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld hl, wScreenState
    inc [hl]
    ret

Jump_0F0_4F47::
    ld a, $07
    call BeginString_BankF0_Cat0
    xor a, a
    ld [wScreenStep], a
    ld a, $05
    ld [wScreenState], a
    xor a, a
    ld [wF0ScreenKind], a
    ret

Jump_0F0_4F5A::
    ld a, $05
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wTextWindowTileLo, wScreenStep
Func_0F0_4CA0_Table3_Case04::
Jump_0F0_4F64:: ; address name
    ld de, Data_0F0_6685
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_0F0_6526
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
Func_0F0_4CA0_Table3_Case05::
Jump_0F0_4FBB:: ; address name
    ld de, Data_0F0_65FB
    ld hl, wWindowTileBuffer + $125
    ld bc, $0704
    call CopyRectTo20ByteRows_BankF0
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, Data_0F0_6522
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
Func_0F0_4CA0_Case03::
Jump_0F0_4FED:: ; address name
    call RunScreenStep_F0_5DE8
    ret

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
Func_0F0_4CA0_Case04::
Jump_0F0_4FF1:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Case04_Case00
    dw Func_0F0_4CA0_Case04_Case01
    dw Func_0F0_4CA0_Case04_Case02
    dw Func_0F0_4CA0_Case04_Case03

; entry 1 of the `rst $00` table in Func_0F0_4CA0_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
Func_0F0_4CA0_Case04_Case01::
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

; entry 2 of the `rst $00` table in Func_0F0_4CA0_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
Func_0F0_4CA0_Case04_Case02::
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

; entry 0 of the `rst $00` table in Func_0F0_4CA0_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkSendByte, wLinkRole
; writes: wLinkSendByte
; points at: wScreenStep
Func_0F0_4CA0_Case04_Case00::
Jump_0F0_5028:: ; address name
    ld a, [wLinkMessage]
    cp a, $BB
    jr z, Jump_0F0_5046
    cp a, $BD
    ret nz
    ld a, [wLinkSendByte]
    cp a, $BB
    jr z, Jump_0F0_5042
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_0F0_5042
    jr Jump_0F0_5046

Jump_0F0_5042::
    ld b, $03
    jr Jump_0F0_5048

Jump_0F0_5046::
    ld b, $02

Jump_0F0_5048::
    xor a, a
    ld [wLinkSendByte], a
    ld a, b
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0F0_4CA0_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rSVBK, wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
Func_0F0_4CA0_Case04_Case03::
Jump_0F0_5055:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006F

Jump_0F0_5061::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_5061
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
Func_0F0_4CA0_Case05::
Jump_0F0_507B:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, Jump_0F0_5094
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

Jump_0F0_5094::
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Table4_Case00
    dw Func_0F0_4CA0_Table4_Case01
    dw Func_0F0_4CA0_Table4_Case02
    dw Func_0F0_4CA0_Table4_Case03
    dw Func_0F0_4CA0_Table4_Case04
    dw Func_0F0_4CA0_Table4_Case05

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
Func_0F0_4CA0_Table4_Case01::
Jump_0F0_50A4:: ; address name
    farcall CopyRect70C5ToWC364AndDraw
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wPickCount
; points at: wScreenStep
Func_0F0_4CA0_Table4_Case02::
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
Func_0F0_4CA0_Table4_Case03::
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
Func_0F0_4CA0_Table4_Case00::
Jump_0F0_50D7:: ; address name
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, Data_01F_4A60
    ld hl, vTiles1 + $6A0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A40
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_0F0_66AD
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
Func_0F0_4CA0_Table4_Case04::
Jump_0F0_5155:: ; address name
    ld de, Data_0F0_663F
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
Func_0F0_4CA0_Table4_Case05::
Jump_0F0_5176:: ; address name
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp a, $FF
    jr z, Jump_0F0_518A
    cp a, $FE
    jr z, Jump_0F0_51A1
    ret

Jump_0F0_518A::
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_0F0_51A1
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $08
    call BeginString_BankF0_Cat0
    ld hl, wScreenState
    inc [hl]
    ret

Jump_0F0_51A1::
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08
    call BeginString_BankF0_Cat0
    ld a, $BD
    ld [wLinkSendByte], a
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScreenState, wLinkSendByte
Func_0F0_4CA0_Case06::
Jump_0F0_51B8:: ; address name
    ld a, [wLinkMessage]
    cp a, $BD
    jr nz, Jump_0F0_51D1
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $BB
    ld [wLinkSendByte], a
    ret

Jump_0F0_51D1::
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Table5_Case00
    dw Func_0F0_4CA0_Table5_Case01
    dw Func_0F0_4CA0_Table5_Case02
    dw Func_0F0_4CA0_Table5_Case03
    dw Func_0F0_4CA0_Table5_Case04
    dw Func_0F0_4CA0_Table5_Case05
    dw Func_0F0_4CA0_Table5_Case06
    dw Func_0F0_4CA0_Table5_Case01
    dw Func_0F0_4CA0_Table5_Case02
    dw Func_0F0_4CA0_Table5_Case09
    dw Func_0F0_4CA0_Table5_Case04
    dw Func_0F0_4CA0_Table5_Case01
    dw Func_0F0_4CA0_Table5_Case02
    dw Func_0F0_4CA0_Table5_Case0D
    dw Func_0F0_4CA0_Table5_Case04
    dw Func_0F0_4CA0_Table5_Case01
    dw Func_0F0_4CA0_Table5_Case02
    dw Func_0F0_4CA0_Table5_Case11
    dw Func_0F0_4CA0_Table5_Case04
    dw Func_0F0_4CA0_Table5_Case13
    dw Func_0F0_4CA0_Table5_Case14
    dw Func_0F0_4CA0_Table5_Case15
    dw Func_0F0_4CA0_Table5_Case16
    dw Func_0F0_4CA0_Table5_Case17
    dw Func_0F0_4CA0_Table5_Case18
    dw Func_0F0_4CA0_Table5_Case19
    dw Func_0F0_4CA0_Table5_Case1A
    dw Func_0F0_4CA0_Table5_Case1B

; entry 21 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
Func_0F0_4CA0_Table5_Case15::
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
Func_0F0_4CA0_Table5_Case18::
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
Func_0F0_4CA0_Table5_Case16::
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
Func_0F0_4CA0_Table5_Case19::
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
Func_0F0_4CA0_Table5_Case1A::
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
Func_0F0_4CA0_Table5_Case1B::
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
; reads: wGM2Mode, wScreenStep
; writes: wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wRecordBufA, wGM2Mode
Func_0F0_4CA0_Table5_Case09::
Jump_0F0_527B:: ; address name
    ld a, [wGM2Mode]
    and a, a
    jr nz, Jump_0F0_5286
    ld hl, Data_0F0_6A58
    jr Jump_0F0_5289

Jump_0F0_5286::
    ld hl, wGM2Mode

Jump_0F0_5289::
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
Func_0F0_4CA0_Table5_Case0D::
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
; reads: wBankF0Byte99, wFamilyBitCount, wRankBand, wTopSpeciesLo, wTopSpeciesHi, wTopSpeciesByte, wScreenStep
; writes: wBankF0BlockA7, wFamilyBitCount, wBankF0ByteA8, wBankF0ByteA9, wBankF0ByteAA, wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, ...
; points at: wPlayerName, wBankF0BlockAB, wBankF0BlockA7, wBankF0BlockC7
Func_0F0_4CA0_Table5_Case11::
Jump_0F0_52EC:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F0_52F7
    xor a, a
    jr Jump_0F0_52F9

Jump_0F0_52F7::
    ld a, $01

Jump_0F0_52F9::
    ld [wBankF0BlockA7], a
    ld a, [wBankF0Byte99]
    and a, a
    jp z, Jump_0F0_5323
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

Jump_0F0_5323::
    ld a, [wTopSpeciesLo]
    ld [wBankF0ByteA8], a
    ld a, [wTopSpeciesHi]
    ld [wBankF0ByteA9], a
    ld a, [wTopSpeciesByte]
    ld [wBankF0ByteAA], a
    ld hl, wPlayerName
    ld de, wBankF0BlockAB
    ld b, $0A

Jump_0F0_533D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_533D
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

; entry 1 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
Func_0F0_4CA0_Table5_Case01::
Jump_0F0_5379:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $BA
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
Func_0F0_4CA0_Table5_Case02::
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
; reads: wF0ScreenKind, wGM2Mode, wBankF0ByteA3, wScreenStep
; writes: wLinkRecvBuffer, wBattleSetupByte98, wBankF0Byte99, wScreenStep
Func_0F0_4CA0_Table5_Case00::
Jump_0F0_5398:: ; address name
    ld a, [wF0ScreenKind]
    ld [wLinkRecvBuffer], a
    ld a, [wGM2Mode]
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
Func_0F0_4CA0_Table5_Case03::
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

; entry 4 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wLinkReady, wScreenStep
Func_0F0_4CA0_Table5_Case04::
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
; reads: wGM2Mode, wLinkPartnerByte1, wScreenStep
; writes: wScreenStep
; points at: wScreenStep
Func_0F0_4CA0_Table5_Case05::
Jump_0F0_5402:: ; address name
    ld a, [wGM2Mode]
    and a, a
    jr nz, Jump_0F0_5410
    ld a, [wLinkPartnerByte1]
    and a, a
    jr z, Jump_0F0_5429
    jr Jump_0F0_5416

Jump_0F0_5410::
    ld a, [wLinkPartnerByte1]
    and a, a
    jr nz, Jump_0F0_541F

Jump_0F0_5416::
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

Jump_0F0_541F::
    ld a, $16
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

Jump_0F0_5429::
    ld a, $13
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep, wScreenStep, wScreenState
Func_0F0_4CA0_Table5_Case06::
Jump_0F0_5433:: ; address name
    ld a, $12
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
; reads: wBankF0Byte99, wLinkPartnerByte2, wGM2Mode
; writes: wF0ScreenKind
; points at: wScreenStep
Func_0F0_4CA0_Table5_Case13::
Jump_0F0_5447:: ; address name
    ld a, [wBankF0Byte99]
    and a, a
    jr nz, Jump_0F0_545D
    ld a, [wLinkPartnerByte2]
    and a, a
    jr nz, Jump_0F0_5461
    ld a, [wGM2Mode]
    and a, a
    jr nz, Jump_0F0_5465
    ld a, $01
    jr Jump_0F0_5466

Jump_0F0_545D::
    ld a, $03
    jr Jump_0F0_5466

Jump_0F0_5461::
    ld a, $04
    jr Jump_0F0_5466

Jump_0F0_5465::
    xor a, a

Jump_0F0_5466::
    ld [wF0ScreenKind], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wF0ScreenKind
; writes: wPickCount
; points at: wScreenStep, wRecordBufA, wGM2Mode, wRecordBufB, wGM2TimerFrames
Func_0F0_4CA0_Table5_Case14::
Jump_0F0_546E:: ; address name
    ld a, [wF0ScreenKind]
    and a, a
    jr z, Jump_0F0_5483
    cp a, $01
    jr z, Jump_0F0_548F
    cp a, $02
    jr z, Jump_0F0_548F
    cp a, $03
    jp z, Jump_0F0_54B0
    jr Jump_0F0_54B0

Jump_0F0_5483::
    ld hl, wGM2TimerFrames
    ld b, $D8

Jump_0F0_5488::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_5488
    jr Jump_0F0_54B0

Jump_0F0_548F::
    ld hl, wRecordBufA
    ld a, $01
    ld [hl], a
    ld de, wGM2Mode
    ld b, $A5

Jump_0F0_549A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_549A
    ld hl, wRecordBufB
    ld de, wGM2TimerFrames
    ld b, $33

Jump_0F0_54A8::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_54A8
    jr Jump_0F0_54B0

Jump_0F0_54B0::
    ld hl, wScreenStep
    inc [hl]
    xor a, a
    ld [wPickCount], a
    ret

; entry 23 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wSGBActive
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hSpriteWindowClipMode, ...
Func_0F0_4CA0_Table5_Case17::
Jump_0F0_54B9:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, $5E12
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
    farcall DrawTileRectAndClearAttrs_5D9A
    call Run67EEWithArg1ForF0ScreenKind
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wSGBActive]
    and a, a
    jr z, Jump_0F0_54F9
    ld a, $02
    ret

Jump_0F0_54F9::
    ret

; entry 7 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
Func_0F0_4CA0_Case07::
Jump_0F0_54FA:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case01
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case04
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case07
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case0A
    dw Func_0F0_4CA0_Case07_Case0B
    dw Func_0F0_4CA0_Case07_Case0C

; entry 12 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSaveStep
; writes: wScreenStep, wScreenSubStep, wScreenState
Func_0F0_4CA0_Case07_Case0C::
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

; entry 1 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
Func_0F0_4CA0_Case07_Case01::
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

; entry 4 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
Func_0F0_4CA0_Case07_Case04::
Jump_0F0_5558:: ; address name
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wObject1 + $B], a
    ld a, [wObject1 + $D]
    set 1, a
    ld [wObject1 + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 0 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep
Func_0F0_4CA0_Case07_Case00::
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

; entry 3 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
Func_0F0_4CA0_Case07_Case03::
Jump_0F0_5594:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 7 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
Func_0F0_4CA0_Case07_Case07::
Jump_0F0_55A6:: ; address name
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
Func_0F0_4CA0_Case07_Case0A::
Jump_0F0_55B6:: ; address name
    ld a, [wObject1 + $D]
    res 1, a
    ld [wObject1 + $D], a
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in Func_0F0_4CA0_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
Func_0F0_4CA0_Case07_Case0B::
Jump_0F0_55DC:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $09
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 8 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
Func_0F0_4CA0_Case08::
Jump_0F0_55FB:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case04
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case01
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case07
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case08_Case0A
    dw Func_0F0_4CA0_Case08_Case0B
    dw Func_0F0_4CA0_Case07_Case0C

; entry 10 of the `rst $00` table in Func_0F0_4CA0_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
Func_0F0_4CA0_Case08_Case0A::
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

; entry 11 of the `rst $00` table in Func_0F0_4CA0_Case08
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
Func_0F0_4CA0_Case08_Case0B::
Jump_0F0_563F:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $0A
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 9 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
Func_0F0_4CA0_Case09::
Jump_0F0_565E:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case01
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case04
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case07
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case07
    dw Func_0F0_4CA0_Case09_Case0E
    dw Func_0F0_4CA0_Case09_Case0F
    dw Func_0F0_4CA0_Case07_Case0C

; entry 14 of the `rst $00` table in Func_0F0_4CA0_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject1, wScreenSubStep
; writes: wSpriteSlots, wObject1, wScreenSubStep
Func_0F0_4CA0_Case09_Case0E::
Jump_0F0_5684:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, [wObject1 + $D]
    res 1, a
    ld [wObject1 + $D], a
    call StepObjectCB9AUpToE0
    call StepObjectCB8ADownToE0
    cp a, $FF
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; wCB86 = 3; while wCB88 & 3 is set, wCB8A -= 1 and A = $FF once it reaches $E0; otherwise A = 0 (E-0126)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Case09_Case0E)
; reads: wSpriteSlots
; writes: wSpriteSlots
StepObjectCB8ADownToE0::
Func_0F0_56A5:: ; address name
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    jr z, Jump_0F0_56C0
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    jr nz, Jump_0F0_56C0
    ld a, $FF
    ret

Jump_0F0_56C0::
    xor a, a
    ret

; wCB96 = 1; while wCB98 & 3 is set, wCB9A += 1 up to $E0 (E-0126)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Case09_Case0E)
; reads: wObject1
; writes: wObject1
StepObjectCB9AUpToE0::
Func_0F0_56C2:: ; address name
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    cp a, $E0
    ret nz
    ret

; entry 15 of the `rst $00` table in Func_0F0_4CA0_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wScreenSubStep
Func_0F0_4CA0_Case09_Case0F::
Jump_0F0_56D9:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld a, $0B
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 10 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
Func_0F0_4CA0_Case0A::
Jump_0F0_56F8:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case01
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case04
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case08
    dw Func_0F0_4CA0_Case0A_Case09
    dw Func_0F0_4CA0_Case0A_Case0A
    dw Func_0F0_4CA0_Case0A_Case0B
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case0F
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case11
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case0F
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case11
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case0F
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case1A
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case1C
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case1E
    dw Func_0F0_4CA0_Case0A_Case1F
    dw Func_0F0_4CA0_Case0A_Case20
    dw Func_0F0_4CA0_Case0A_Case21
    dw Func_0F0_4CA0_Case07_Case0C

; entry 32 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteEE, wScreenSubStep
; writes: wScreenSubStep
Func_0F0_4CA0_Case0A_Case20::
Jump_0F0_5742:: ; address name
    ld a, [wScreenByteEE]
    and a, a
    ret nz
    call RunTextUntilTextWindowStateDone_BankF0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 31 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep, wBattleScene, wSpriteSlotCount, wNameEntryState, wNameEntrySubState, wScreenByteEE
Func_0F0_4CA0_Case0A_Case1F::
Jump_0F0_5752:: ; address name
    ld de, Data_0F0_68E6
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

; entry 33 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wScreenStep, wScreenSubStep, wLinkByteE8, wLinkByteE9, wLinkByteEA, wModeChangeRequest
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkByteE8, wLinkByteE9, wLinkByteEA, wModeChangeRequest, wGameMode, ...
; points at: wGM2TimerFrames
Func_0F0_4CA0_Case0A_Case21::
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

Jump_0F0_57E1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_57E1
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 8 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, hTemp0, wObject5, wScreenCounter, wScreenSubStep
Func_0F0_4CA0_Case0A_Case08::
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
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
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

; entry 9 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
Func_0F0_4CA0_Case0A_Case09::
Jump_0F0_583B:: ; address name
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 15 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject2, wScreenSubStep
Func_0F0_4CA0_Case0A_Case0F::
Jump_0F0_5848:: ; address name
    ld a, $03
    ld [wObject2 + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 17 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject2, wScreenSubStep
Func_0F0_4CA0_Case0A_Case11::
Jump_0F0_5855:: ; address name
    ld a, $01
    ld [wObject2 + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 26 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
Func_0F0_4CA0_Case0A_Case1A::
Jump_0F0_5862:: ; address name
    ld a, [wObject2 + $D]
    res 1, a
    ld [wObject2 + $D], a
    ld a, $03
    ld [wObject2 + $7], a
    ld a, [wObject2 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + $B]
    dec a
    ld [wObject2 + $B], a
    cp a, $30
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; while wCB98 & 3 is set: wCB9A -= 1; at $60 runs field command $0E and sets wCBD3/4; at $58 sets bit 1 of wCB9C and wD782 += 1 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, hTemp0, wObject5, wScreenCounter, wScreenSubStep
StepObjectCB9AAndTriggerAt60:: ; heuristic: follows a terminator; C0
Func_0F0_5888:: ; address name
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    cp a, $60
    jr nz, Jump_0F0_58B2
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wScreenCounter], a

Jump_0F0_58B2::
    ld a, [wObject1 + $B]
    cp a, $59
    ret nc
    ld a, $58
    ld [wObject1 + $B], a
    ld a, [wObject1 + $D]
    set 1, a
    ld [wObject1 + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wSpriteSlotCount, wScreenSubStep
; writes: wScreenCounter, wObject5, wSpriteSlotCount, wScreenSubStep, wScreenStep
Func_0F0_4CA0_Case0A_Case0A::
Jump_0F0_58CD:: ; address name
    ld a, [wScreenCounter]
    cp a, $BA
    jr nz, Jump_0F0_58D9
    ld a, $74
    call QueueSoundEffect

Jump_0F0_58D9::
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

; entry 11 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
Func_0F0_4CA0_Case0A_Case0B::
Jump_0F0_58FE:: ; address name
    ld de, wObject1 + $C
    call StepScreenStepOffsetTableEvery4Frames
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

; entry 28 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wSpriteSlots, wScreenSubStep
; writes: wObject2, wSpriteSlots, wScreenSubStep
Func_0F0_4CA0_Case0A_Case1C::
Jump_0F0_590A:: ; address name
    ld a, [wObject2 + $D]
    res 1, a
    ld [wObject2 + $D], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld [wObject2 + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + $B]
    dec a
    ld [wObject2 + $B], a
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 30 of the `rst $00` table in Func_0F0_4CA0_Case0A
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wLinkByteE8, wLinkByteE9, wLinkByteEA, wLinkByteEB
; points at: wBankF0ByteA8, wTextBuf1, wScreenSubStep
Func_0F0_4CA0_Case0A_Case1E::
Jump_0F0_593A:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0ByteA8
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0C
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

; entry 11 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
Func_0F0_4CA0_Case0B::
Jump_0F0_5967:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case04
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case03
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case01
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0B_Case08
    dw Func_0F0_4CA0_Case0B_Case09
    dw Func_0F0_4CA0_Case0A_Case0A
    dw Func_0F0_4CA0_Case0B_Case0B
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case11
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case0F
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case11
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case0F
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0A_Case11
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0B_Case1A
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0B_Case1C
    dw Func_0F0_4CA0_Case07_Case00
    dw Func_0F0_4CA0_Case0B_Case1E
    dw Func_0F0_4CA0_Case07_Case0C

; entry 8 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, hTemp0, wObject5, wScreenCounter, wScreenSubStep
Func_0F0_4CA0_Case0B_Case08::
Jump_0F0_59AB:: ; address name
    ld a, [wObject1 + $D]
    res 1, a
    ld [wObject1 + $D], a
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    cp a, $70
    ret nz
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wScreenCounter], a
    ld a, [wObject1 + $D]
    set 1, a
    ld [wObject1 + $D], a
    ld a, $00
    ld [wObject1 + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 9 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject1, wScreenSubStep
Func_0F0_4CA0_Case0B_Case09::
Jump_0F0_59F6:: ; address name
    ld a, $03
    ld [wObject1 + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 26 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
Func_0F0_4CA0_Case0B_Case1A::
Jump_0F0_5A03:: ; address name
    ld a, [wObject2 + $D]
    res 1, a
    ld [wObject2 + $D], a
    ld a, $01
    ld [wObject2 + $7], a
    ld a, [wObject2 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + $B]
    inc a
    ld [wObject2 + $B], a
    cp a, $60
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; while wCB88 & 3 is set: wCB8A += 1; at $30 runs field command $0E and sets wCBD3/4; at $38 sets bit 1 of wCB8C and wD782 += 1 (E-0124)
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
    jr nz, Jump_0F0_5A53
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wScreenCounter], a

Jump_0F0_5A53::
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

; entry 11 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
Func_0F0_4CA0_Case0B_Case0B::
Jump_0F0_5A6C:: ; address name
    ld de, wSpriteSlots + $C
    call StepScreenStepOffsetTableEvery4Frames
    ret

; entry 28 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject1, wObject2, wScreenSubStep
; writes: wSpriteSlots, wObject1, wObject2, wScreenSubStep
Func_0F0_4CA0_Case0B_Case1C::
Jump_0F0_5A73:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, $01
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + $B]
    inc a
    ld [wObject2 + $B], a
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 30 of the `rst $00` table in Func_0F0_4CA0_Case0B
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wSaveStep, wSaveRecordIndex
; points at: wBankF0BlockCB, wTextBuf0, wBankF0ByteC8, wTextBuf1, wScreenSubStep
Func_0F0_4CA0_Case0B_Case1E::
Jump_0F0_5AA3:: ; address name
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wBankF0BlockCB
    ld de, wTextBuf0
    ld b, $0A
    call CopyStringMaxBToDE
    ld hl, wBankF0ByteC8
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0D
    call BeginString_BankF0_Cat0
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld hl, wScreenSubStep
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; entry 12 of the `rst $00` table in Func_0F0_4CA0
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
Func_0F0_4CA0_Case0C::
Jump_0F0_5ACE:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw Func_0F0_4CA0_Case0C_Case00
    dw Func_0F0_4CA0_Case0C_Case01
    dw Func_0F0_4CA0_Case0C_Case02
    dw Func_0F0_4CA0_Case04_Case03

; entry 0 of the `rst $00` table in Func_0F0_4CA0_Case0C
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
Func_0F0_4CA0_Case0C_Case00::
Jump_0F0_5ADA:: ; address name
    ld a, $08
    call BeginString_BankF0_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in Func_0F0_4CA0_Case0C
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
Func_0F0_4CA0_Case0C_Case01::
Jump_0F0_5AE7:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $BA
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_4CA0_Case0C
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
Func_0F0_4CA0_Case0C_Case02::
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

; every fourth frame adds Data_0F0_5B39[wD781] to [DE] and advances wD781; the $80 end mark advances wD782 and resets (E-0124)
; 2 call sites from 2 routines (e.g. Func_0F0_4CA0_Case0A_Case0B, Func_0F0_4CA0_Case0B_Case0B)
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
    ld hl, Data_0F0_5B39
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    jr z, Jump_0F0_5B2A
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    ld hl, wScreenStep
    inc [hl]
    ret

Jump_0F0_5B2A::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenCounter], a
    ret

Data_0F0_5B39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FD, $FD, $FE, $00, $01, $01, $03, $03, $80

; copies bytes from HL to DE until a $F0 or B bytes, then writes $F0; HL and DE advance (E-0078)
; 4 call sites from 4 routines (e.g. Func_0F0_4CA0_Case07_Case0B, Func_0F0_4CA0_Case08_Case0B, Func_0F0_4CA0_Case09_Case0F, Func_0F0_4CA0_Case0B_Case1E)
CopyStringMaxBToDE::
Func_0F0_5B42:: ; address name
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F0_5B4C
    ld [de], a
    inc de
    dec b
    jr nz, CopyStringMaxBToDE

Jump_0F0_5B4C::
    ld a, $F0
    ld [de], a
    ret

; runs the routine for wD781 (jump table of ten) (E-0122)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Case01)
; reads: wScreenStep
RunScreenStep_F0_5B50::
Func_0F0_5B50:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStep_F0_5B50_Case00
    dw RunScreenStep_F0_5B50_Case01
    dw RunScreenStep_F0_5B50_Case02
    dw RunScreenStep_F0_5B50_Case03
    dw RunScreenStep_F0_5B50_Case04
    dw RunScreenStep_F0_5B50_Case05
    dw RunScreenStep_F0_5B50_Case06
    dw RunScreenStep_F0_5B50_Case07
    dw RunScreenStep_F0_5B50_Case08
    dw RunScreenStep_F0_5B50_Case09

; entry 0 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
RunScreenStep_F0_5B50_Case00::
Jump_0F0_5B68:: ; address name
    farcall LoadTileList6DC4SixPerFrame
    ret

; entry 1 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursorF0, wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5B50_Case01::
Jump_0F0_5B6F:: ; address name
    ld de, Data_0F0_5BA0
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, Data_0F0_6522
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

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 13 x 9 tiles, one row per line
TileRect_F0_5BA0::
Data_0F0_5BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; entry 2 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
RunScreenStep_F0_5B50_Case02::
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

; entry 3 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunScreenStep_F0_5B50_Case03::
Jump_0F0_5C57:: ; address name
    ld de, Data_0F0_6530
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_0F0_5C98
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

Jump_0F0_5C98::
    call BGMapAddressAtScroll_BankF0
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
RunScreenStep_F0_5B50_Case04::
Jump_0F0_5CAC:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunScreenStep_F0_5B50_Case05::
Jump_0F0_5CBE:: ; address name
    ld de, Data_01F_4990
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

; entry 6 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenState, wScreenStep
; writes: wMenuInputResult, wScreenStep, wScreenSubStep, wScreenState
RunScreenStep_F0_5B50_Case06::
Jump_0F0_5CE0:: ; address name
    ld a, $01
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_0F0_5D05
    cp a, $FC
    jr z, Jump_0F0_5D05
    cp a, $FD
    jr z, Jump_0F0_5D0E
    cp a, $FE
    jr z, Jump_0F0_5D0F
    cp a, $FF
    jr z, Jump_0F0_5D17
    ret

Jump_0F0_5D05::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_0F0_5D0E::
    ret

Jump_0F0_5D0F::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_0F0_5D17::
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    call SaveAndHideSpriteState_BankF0
    ret

; entry 7 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunScreenStep_F0_5B50_Case07::
Jump_0F0_5D29:: ; address name
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, Data_0F0_5D51
    ld hl, wWindowTileBuffer + $111
    ld bc, $0701
    call CopyRectTo20ByteRows_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 7 x 1 tiles, one row per line
TileRect_F0_5D51::
Data_0F0_5D51:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 8 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5B50_Case08::
Jump_0F0_5D58:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_BankF0
    ld de, Data_01F_4260
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in RunScreenStep_F0_5B50
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursorF0
; writes: wArg1, wArg2, wArg3, wArg4, wScreenState, wScreenSubStep, wScreenStep
RunScreenStep_F0_5B50_Case09::
Jump_0F0_5DA0:: ; address name
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, Data_0F0_6DC4
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
    ld hl, Data_0F0_6522
    call StoreBAtWordTableEntry_BankF0
    xor a, a
    ld [wScreenState], a
    ld [wScreenSubStep], a
    ld a, $04
    call BeginString_BankF0_Cat0
    ld a, $07
    ld [wScreenStep], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_BankF0_48A0
; 19 call sites from 15 routines (e.g. Func_0F0_4CA0_Table2_Case07, Func_0F0_4CA0_Table2_Case05, RunScreenStep_F0_5B50_Case09, Func_0F0_4CA0_Table3_Case03, ...)
; writes: wStringIndex, wStringCategory
BeginString_BankF0_Cat0::
Func_0F0_5DDD:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    call BeginStringDisplay_BankF0_48A0
    ret

; runs the routine for wD781 (jump table of seventeen) (E-0124)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Case03)
; reads: wScreenStep
RunScreenStep_F0_5DE8::
Func_0F0_5DE8:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStep_F0_5DE8_Case00
    dw RunScreenStep_F0_5DE8_Case01
    dw RunScreenStep_F0_5DE8_Case02
    dw RunScreenStep_F0_5DE8_Case03
    dw RunScreenStep_F0_5DE8_Case04
    dw RunScreenStep_F0_5DE8_Case05
    dw RunScreenStep_F0_5DE8_Case06
    dw RunScreenStep_F0_5DE8_Case07
    dw RunScreenStep_F0_5DE8_Case08
    dw DrawTileMap5E12AtScrollAndResetScroll_BankF0
    dw RunScreenStep_F0_5DE8_Case0A
    dw RunScreenStep_F0_5DE8_Case0B
    dw RunScreenStep_F0_5DE8_Case0C
    dw RunScreenStep_F0_5DE8_Case0D
    dw RunScreenStep_F0_5DE8_Case0E
    dw RunScreenStep_F0_5DE8_Case0F
    dw RunScreenStep_F0_5DE8_Case10

; entry 0 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
RunScreenStep_F0_5DE8_Case00::
Jump_0F0_5E0E:: ; address name
    call DrawTileMap5E12AtScrollAndResetScroll_BankF0
    ld de, Data_01F_4250
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; draws the 32 x 32 tile map at $5E12 at the scroll origin (Func_01F_5D9A with wD7F7 = 0), then hScrollX = hScrollY = 0 and wD781 += 1 (E-0121)
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5DE8_Case00)
; reads: wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hScrollX, ...
DrawTileMap5E12AtScrollAndResetScroll_BankF0::
Func_0F0_5E2C:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, $5E12
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
    farcall DrawTileRectAndClearAttrs_5D9A
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5DE8_Case01::
Jump_0F0_5E63:: ; address name
    ld hl, Data_0F0_6442
    ld de, Data_0F0_6482
    call RunScreenStep_F0_5DE8_Shared01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5DE8_Case02::
Jump_0F0_5E74:: ; address name
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $60
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $90
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $140
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $170
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $1A0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageIndex, wListCursor, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
RunScreenStep_F0_5DE8_Case03::
Jump_0F0_5ECA:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Data_01F_4A40
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

; entry 4 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wArg1, wArg2, wScreenStep
RunScreenStep_F0_5DE8_Case04::
Jump_0F0_5EF9:: ; address name
    farcall UploadTilesFromData6D20
    call BGMapAddressAtScroll_BankF0
    ld de, Data_0F0_6E7F
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

; entry 5 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenStep
; writes: hSpriteHideTile, wScreenStep
RunScreenStep_F0_5DE8_Case05::
Jump_0F0_5F2F:: ; address name
    call GetListEntriesCell4Address_BankF0
    ld a, [hl]
    ld e, a
    farcall RunScreenStep_F0_5DE8_Case05_Sub01
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
    jr c, Jump_0F0_5F9B
    ld de, Data_01F_4AA0
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AE0
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

Jump_0F0_5F9B::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, hTemp0, hTemp1, wIsCGB, wScreenStep
; writes: rRAMG2, rRAMB, wScreenSubStep, wBGPaletteUploadRequest, hTemp0, wArg3, wArg4, wArg7, ...
RunScreenStep_F0_5DE8_Case06::
Jump_0F0_5FA3:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_0F0_5FDD
    call DrawRect6x6From651BAtScroll41_BankF0
    call GetListEntriesCell4Address_BankF0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
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

Jump_0F0_5FDD::
    call GetListEntriesCell4Address_BankF0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_0F0_6014
    ld a, [hl]
    ld c, $0B
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

Jump_0F0_6014::
    pop hl
    xor a, a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, Data_0F0_64F7
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

; entry 7 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wRecordsFlagged
; writes: hSpriteHideTile, wScreenStep
RunScreenStep_F0_5DE8_Case07::
Jump_0F0_6041:: ; address name
    farcall HandleListCursorInput_1D
    ld a, [wMenuInputResult]
    and a, a
    jr z, Jump_0F0_6059
    cp a, $FD
    jr z, Jump_0F0_605A
    cp a, $FE
    jr z, Jump_0F0_606C
    cp a, $FF
    jr z, Jump_0F0_606C

Jump_0F0_6059::
    ret

Jump_0F0_605A::
    ld a, [wRecordsFlagged]
    cp a, $02
    jr c, Jump_0F0_6059
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_0F0_606C::
    call SplitListCursorBy4_BankF0
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5DE8_Case08::
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

; entry 10 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5DE8_Case0A::
Jump_0F0_6096:: ; address name
    ld hl, Data_0F0_64C2
    ld de, Data_0F0_64D2
    call RunScreenStep_F0_5DE8_Shared01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunScreenStep_F0_5DE8_Case0B::
Jump_0F0_60A7:: ; address name
    ld hl, Data_0F0_6500
    ld de, Data_0F0_64E0
    call RunScreenStep_F0_5DE8_Shared01
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
    ld de, Data_01F_48E0
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
RunScreenStep_F0_5DE8_Case0C::
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

; entry 13 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStep_F0_5DE8_Case0D::
Jump_0F0_6129:: ; address name
    ld de, Data_0F0_6530
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    jr Jump_0F0_6160

; with two or more pages draws the bracket and page-of-pages indicator at wC412; wD781 += 1 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawPageIndicatorWhenTwoPagesAndStep:: ; heuristic: follows a terminator; C0
Func_0F0_613D:: ; address name
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_0F0_6158
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_BankF0
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_BankF0

Jump_0F0_6158::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_0F0_6160::
    ld de, Data_0F0_616E
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_BankF0
    jr Jump_0F0_6158

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 8 x 1 tiles, one row per line
TileRect_F0_616E::
Data_0F0_616E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 14 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
RunScreenStep_F0_5DE8_Case0E::
Jump_0F0_6176:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunScreenStep_F0_5DE8_Case0F::
Jump_0F0_6188:: ; address name
    ld de, Data_01F_4990
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
    ld hl, Data_0F0_6526
    call StoreBAtWordTableEntry_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in RunScreenStep_F0_5DE8
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep
; points at: wTextWindowTileLo
RunScreenStep_F0_5DE8_Case10::
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

; wD7BC = hFFB9, then hFFB9 = hFFBA = 0; wD7BA = hFF8D, wD7BB = wSpriteSlotCount; then hFF8D = $FF and wSpriteSlotCount = 0 (E-0078) (the same 30 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5B50_Case06)
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

; hFFB9 = wD7BC, hFFBA = $80, hFF8D = wD7BA, wSpriteSlotCount = 0 (unlike RestoreSpriteStateFromSavedFieldDrawFlags, the count is cleared rather than restored) (E-0118)
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5DE8_Case10)
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

; clears the default window, wC8CB = 1, wC8CC = 0, hFFB9 = 2, then repeatedly far-calls Func_002_69D0 until wC8CB & 3 = 0 (E-0122)
; 6 call sites from 6 routines (e.g. Func_0F0_4CA0_Case07_Case0B, Func_0F0_4CA0_Case08_Case0B, Func_0F0_4CA0_Case09_Case0F, Func_0F0_4CA0_Case0A_Case20, ...)
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

Jump_0F0_6241::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_0F0_6241
    ret

; wD7AF = wD7AB / 4 and wD7AB = wD7AB mod 4 (DivideHLByA) (E-0067) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5DE8_Case07)
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
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5DE8_Case06)
; writes: wArg3, wArg4, wArg7
DrawRect6x6From651BAtScroll41_BankF0::
Func_0F0_6262:: ; address name
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, Data_0F0_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    ret

; only called from routines of RunScreenStep_F0_5DE8 (E-0098)
; 3 call sites from 3 routines (e.g. RunScreenStep_F0_5DE8_Case0B, RunScreenStep_F0_5DE8_Case0A, RunScreenStep_F0_5DE8_Case01)
; writes: wGlyphListPos
RunScreenStep_F0_5DE8_Shared01::
Func_0F0_627E:: ; address name
    ld b, $00

Jump_0F0_6280::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0F0_62B0
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
    jr Jump_0F0_6280

Jump_0F0_62B0::
    pop de
    pop hl
    pop bc
    xor a, a
    ld [wGlyphListPos], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 13 call sites from 13 routines (e.g. Func_0F0_4CA0_Table2_Case06, RunScreenStep_F0_5B50_Case07, RunScreenStep_F0_5B50_Case03, RunScreenStep_F0_5B50_Case01, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_BankF0::
Func_0F0_62B8:: ; address name
    push hl
    push bc

Jump_0F0_62BA::
    push bc
    push hl

Jump_0F0_62BC::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_62BC
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F0_62BA
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

Jump_0F0_62DE::
    push bc
    push hl

Jump_0F0_62E0::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_62E0
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F0_62DE
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 (E-0062)
; 12 call sites from 11 routines (e.g. Func_0F0_4CA0_Table2_Case06, RunScreenStep_F0_5B50_Case08, RunScreenStep_F0_5B50_Case03, RunScreenStep_F0_5B50_Case01, ...)
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
; 23 call sites from 20 routines (e.g. DrawArrowTileBCAtArg2Entry_F0, Func_0F0_4CA0_Table2_Case06, RunScreenStep_F0_5B50_Case08, RunScreenStep_F0_5B50_Case03, ...)
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
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5B50_Case03)
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
; 2 call sites from 2 routines (e.g. RunScreenStep_F0_5B50_Case03, DrawPageIndicatorWhenTwoPagesAndStep)
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
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5B50_Case03)
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

; HL = the address in wD7F1 (high) / wD7F2 (low): writes tile $E0 + wD7AF + 1 there and tile $E0 + wD7B0 two bytes later (current page and page count, 1-based display) (E-0093) (the same 25 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunScreenStep_F0_5B50_Case03, DrawPageIndicatorWhenTwoPagesAndStep)
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

Jump_0F0_63E0::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_63E0
    xor a, a
    ldh [rSVBK], a
    ret

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 2 call sites from 2 routines (e.g. RunScreenStep_F0_5B50_Case07, Func_0F0_4CA0_Table4_Case00)
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
    jr z, Jump_0F0_642F
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

Jump_0F0_642F::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_0F0_643E
    inc d

Jump_0F0_643E::
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_F0
    ret

Data_0F0_6442:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $90, $30, $90, $40, $90, $50, $90, $60, $90, $70, $90, $80, $90, $90, $90
    db $A0, $90, $B0, $90, $C0, $90, $D0, $90, $E0, $90, $F0, $90, $00, $91, $10, $91
    db $20, $91, $30, $91, $40, $91, $50, $91, $60, $91, $70, $91, $80, $91, $90, $91
    db $A0, $91, $B0, $91, $C0, $91, $D0, $91, $E0, $91, $F0, $91, $F0, $96, $FF, $FF

Data_0F0_6482:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $42, $B0, $42, $00, $43, $C0, $44, $00, $44, $B0, $4A, $10, $43, $F0, $43
    db $E0, $42, $F0, $42, $A0, $42, $20, $43, $60, $42, $90, $43, $B0, $47, $80, $46
    db $B0, $46, $D0, $49, $B0, $42, $E0, $43, $90, $48, $90, $47, $80, $48, $40, $44
    db $80, $43, $00, $45, $E0, $44, $C0, $42, $30, $4A, $70, $42, $D0, $4A, $FF, $FF

Data_0F0_64C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_0F0_64D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_0F0_64E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $44, $80, $44, $E0, $43, $E0, $42, $B0, $46, $B0, $47, $50, $46, $00, $44
    db $B0, $42, $30, $41, $20, $43, $A0

Data_0F0_64F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_0F0_6500:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $97, $D0, $97, $E0, $97, $F0, $97, $F0, $8D, $E0, $8F, $F0, $8F, $70, $97
    db $80, $97, $00, $97, $10, $97, $20, $97, $30, $97, $40

Data_0F0_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $97, $50, $97, $60, $97, $FF, $FF

Data_0F0_6522:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $C4, $4E, $C4

Data_0F0_6526:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $C3, $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 13 x 9 tiles, one row per line
TileRect_F0_6530::
Data_0F0_6530:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $C0, $C1, $C2, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C7, $C8, $C9, $CA, $CB, $EA, $EB, $EC, $ED, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    INCBIN "dwm2-cobi-us.gbc", $3C25A5, $56

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 7 x 4 tiles, one row per line
TileRect_F0_65FB::
Data_0F0_65FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $70, $71, $72, $C3, $B7 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $73, $74, $75, $76, $B7 ; id 2
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 3

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 8 x 5 tiles, one row per line
TileRect_F0_6617::
Data_0F0_6617:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $70, $71, $72, $73, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $74, $75, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 6 x 5 tiles, one row per line
TileRect_F0_663F::
Data_0F0_663F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $73, $74, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 8 x 5 tiles, one row per line
TileRect_F0_665D::
Data_0F0_665D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 8 x 5 tiles, one row per line
TileRect_F0_6685::
Data_0F0_6685:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 8 x 5 tiles, one row per line
TileRect_F0_66AD::
Data_0F0_66AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; wD7F5/wD7F6 = HL (destination), wD7F1/wD7F2 = DE (source), then far-calls DrawTileRectFromArg1Params (width and rows already in wD7F3/wD7F4) (E-0093) (the same 23 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. DrawRect6x6From651BAtScroll41_BankF0, RunScreenStep_F0_5DE8_Case06, RunScreenStep_F0_5DE8_Case04)
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
; 4 call sites from 3 routines (e.g. RunScreenStep_F0_5DE8_Case06, RunScreenStep_F0_5DE8_Case05, RunScreenStep_F0_5DE8_Case04)
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
; 6 call sites from 6 routines (e.g. RunScreenStep_F0_5B50_Case09, RunScreenStep_F0_5B50_Case01, Func_0F0_4CA0_Table3_Case05, Func_0F0_4CA0_Table3_Case04, ...)
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

; up/down moves wD7B7 between two entries (sound $69); A selects (wMenuInputResult = $FF), B cancels ($FE); otherwise blinks the cursor (E-0127)
; 3 call sites from 3 routines (e.g. Func_0F0_4CA0_Table2_Case07, Func_0F0_4CA0_Table3_Case03, Func_0F0_4CA0_Table4_Case05)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursorF0
; writes: wMenuInputResult, wChoiceCursorF0
HandleTwoChoiceCursorInput_F0::
Func_0F0_6709:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_0F0_673E
    bit 7, a
    jr nz, Jump_0F0_674E
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_0F0_6727
    bit 1, a
    jr nz, Jump_0F0_6735
    call BlinkCursorBlinkB8_BankF0
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_0F0_6727::
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_0F0_6735::
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $FE
    ld [wMenuInputResult], a
    ret

Jump_0F0_673E::
    call DrawBlankTileC3_BankF0
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_0F0_674B
    ld a, $01
    jr Jump_0F0_675C

Jump_0F0_674B::
    dec a
    jr Jump_0F0_675C

Jump_0F0_674E::
    call DrawBlankTileC3_BankF0
    ld a, [wChoiceCursorF0]
    cp a, $01
    jr c, Jump_0F0_675B
    xor a, a
    jr Jump_0F0_675C

Jump_0F0_675B::
    inc a

Jump_0F0_675C::
    ld [wChoiceCursorF0], a
    call DrawCursorTileBB_BankF0
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wD7B8 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
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
    jr Jump_0F0_6791

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wArg2, wChoiceCursorF0
DrawBlankTileC3_BankF0::
Func_0F0_678B:: ; address name
    ld b, $C3
    jr Jump_0F0_6791

; B = $BC, then writes B at the scroll position + the offset from Data_0F0_67C0[wD7F2] entry wD7B7 (E-0125)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_F0)
; reads: wArg2, wChoiceCursorF0
DrawArrowTileBCAtArg2Entry_F0::
Func_0F0_678F:: ; address name
    ld b, $BC

Jump_0F0_6791::
    ld a, [wArg2]
    add a, a
    ld hl, Data_0F0_67C0
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wChoiceCursorF0]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F0_67A9
    inc d

Jump_0F0_67A9::
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

Data_0F0_67C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C6, $67, $CA, $67, $CE, $67, $2D, $01, $6D, $01, $2E, $01, $6E, $01, $2F, $01
    db $6F, $01

; runs Func_0F0_67EE with wD7F1 = 1 when wD7EC is 3 or 4, else 0 (E-0122)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case17)
; reads: wF0ScreenKind
; writes: wArg1
Run67EEWithArg1ForF0ScreenKind::
Func_0F0_67D2:: ; address name
    ld a, [wF0ScreenKind]
    cp a, $03
    jr z, Jump_0F0_67E5
    cp a, $04
    jr z, Jump_0F0_67E5
    xor a, a
    ld [wArg1], a
    call Run67EEWithArg1ForF0ScreenKind_Sub01
    ret

Jump_0F0_67E5::
    ld a, $01
    ld [wArg1], a
    call Run67EEWithArg1ForF0ScreenKind_Sub01
    ret

; only called from Run67EEWithArg1ForF0ScreenKind (E-0047)
; 2 call sites from 1 routine (e.g. Run67EEWithArg1ForF0ScreenKind)
; reads: wBankF0BlockC7, wArg1, wF0ScreenKind, wBankF0ByteA8, wBankF0ByteA9, wIsCGB, wBankF0ByteC8, wBankF0ByteC9
; writes: hTemp0, wObject5, wSpriteSlotCount, wObject2, hTemp1, wOBJPaletteUploadRequest
; points at: wSpriteSlots, wObject1, hTemp0, wObject2
Run67EEWithArg1ForF0ScreenKind_Sub01::
Func_0F0_67EE:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F0_67FB
    ld hl, Data_0F0_6A08
    jr Jump_0F0_67FE

Jump_0F0_67FB::
    ld hl, Data_0F0_6A18

Jump_0F0_67FE::
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, Jump_0F0_6811
    ld hl, Data_0F0_6A28
    jr Jump_0F0_6814

Jump_0F0_6811::
    ld hl, Data_0F0_6A38

Jump_0F0_6814::
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F0_6829
    ld hl, Data_0F0_69EA
    jr Jump_0F0_682C

Jump_0F0_6829::
    ld hl, Data_0F0_69F0

Jump_0F0_682C::
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, Jump_0F0_6845
    ld hl, Data_0F0_69F6
    jr Jump_0F0_6848

Jump_0F0_6845::
    ld hl, Data_0F0_69FC

Jump_0F0_6848::
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
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, [wArg1]
    and a, a
    jr z, Jump_0F0_68D3
    ld hl, Data_0F0_6A48
    ld de, wObject2
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp a, $03
    jr nz, Jump_0F0_6899
    ld a, [wBankF0ByteA8]
    ld [wObject2 + $2], a
    ld a, [wBankF0ByteA9]
    ld [wObject2 + $3], a
    jr Jump_0F0_68A5

Jump_0F0_6899::
    ld a, [wBankF0ByteC8]
    ld [wObject2 + $2], a
    ld a, [wBankF0ByteC9]
    ld [wObject2 + $3], a

Jump_0F0_68A5::
    ld hl, Data_0F0_6A02
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp a, $03
    jr nz, Jump_0F0_68C3
    ld a, [wBankF0ByteA8]
    ldh [hTemp0], a
    ld a, [wBankF0ByteA9]
    ldh [hTemp1], a
    jr Jump_0F0_68CD

Jump_0F0_68C3::
    ld a, [wBankF0ByteC8]
    ldh [hTemp0], a
    ld a, [wBankF0ByteC9]
    ldh [hTemp1], a

Jump_0F0_68CD::
    farcall DecompressGraphicsTemp0ToTemp4

Jump_0F0_68D3::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_0F0_68DE
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

Jump_0F0_68DE::
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 6 call sites from 1 routine (e.g. Run67EEWithArg1ForF0ScreenKind_Sub01)
CopyBytesDEFromHL_BankF0::
Func_0F0_68DF:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF0
    ret

; E-0161 (derived: a packed tile rectangle passed in DE, with B = width and C = rows, to a rectangle copier)
; record: 20 x 13 tiles, one row per line
TileRect_F0_68E6::
Data_0F0_68E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

Data_0F0_69EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_0F0_69F0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_0F0_69F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $81

Data_0F0_69FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $81

Data_0F0_6A02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $02, $00, $82

Data_0F0_6A08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A18:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A38:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

Data_0F0_6A58:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A6, $FF

; while wCE9E > 0 and some resistance at wCF41 is below 3: picks at random one of the lowest-level resistances (levels 0, then 1, 2) and raises it (E-0129)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case11)
; reads: wFamilyBitCount, wCounterPtr0Lo, wLowestResistCount, wCounterPtr0Hi
; writes: wFamilyBitCount, wCounterPtr0Lo, wLowestResistCount
; points at: wResistanceLevels, wCounterPtr0Hi
RaiseRandomLowestResistance::
Func_0F0_6AFE:: ; address name
    ld a, [wFamilyBitCount]
    and a, a
    ret z
    ld hl, wResistanceLevels
    ld b, $00

Jump_0F0_6B08::
    ld a, b
    cp a, $0F
    jr z, Jump_0F0_6B1C
    ld a, [hl]
    cp a, $03
    jr z, Jump_0F0_6B1C
    ld a, [wFamilyBitCount]
    dec a
    ld [wFamilyBitCount], a
    jp Jump_0F0_6B24

Jump_0F0_6B1C::
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, Jump_0F0_6B08
    ret

Jump_0F0_6B24::
    xor a, a
    ld [wCounterPtr0Lo], a

Jump_0F0_6B28::
    ld hl, wCounterPtr0Hi
    ld bc, $001C

Jump_0F0_6B2E::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_6B2E
    ld hl, wResistanceLevels
    ld de, wCounterPtr0Hi
    ld b, $00

Jump_0F0_6B3D::
    ld a, [hl]
    ld c, a
    ld a, [wCounterPtr0Lo]
    cp a, c
    jr nz, Jump_0F0_6B4F
    ld a, b
    ld [de], a
    inc de
    ld a, [wLowestResistCount]
    inc a
    ld [wLowestResistCount], a

Jump_0F0_6B4F::
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, Jump_0F0_6B3D
    ld a, [wLowestResistCount]
    and a, a
    jr nz, Jump_0F0_6B68
    ld a, [wCounterPtr0Lo]
    cp a, $02
    ret z
    inc a
    ld [wCounterPtr0Lo], a
    jr Jump_0F0_6B28

Jump_0F0_6B68::
    ld a, [wLowestResistCount]
    cp a, $01
    jr z, Jump_0F0_6B90
    ld b, a
    call NextTableByte
    ld a, l

Jump_0F0_6B74::
    sub a, b
    cp a, b
    jr c, Jump_0F0_6B7C
    jr z, Jump_0F0_6B7C
    jr Jump_0F0_6B74

Jump_0F0_6B7C::
    and a, a
    jr z, Jump_0F0_6B80
    dec a

Jump_0F0_6B80::
    ld hl, wCounterPtr0Hi
    add_a_to_hl
    ld a, [hl]
    cp a, $0F
    jp z, RaiseRandomLowestResistance
    jr Jump_0F0_6B93

Jump_0F0_6B90::
    ld a, [wCounterPtr0Hi]

Jump_0F0_6B93::
    ld hl, wResistanceLevels
    add_a_to_hl
    ld a, [hl]
    inc a
    ld [hl], a
    jp RaiseRandomLowestResistance

; loads species wCED9 and copies its bytes wD010-wD012 to wCF0A and the 27 bytes at wD01A to wCF41; wCF29 = wCF2B, wCF2D = wCF2F (E-0124)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case11)
; reads: wTopSpeciesLo, wTopSpeciesHi, wSpeciesRecord, wTopStat1, wTopStat3
; writes: wSpeciesIdLo, wSpeciesIdHi, wTopSpeciesGrowth, wTopStat0, wTopStat2
; points at: wResistanceLevels
LoadTopSpeciesLoSpeciesStatsToTopSpeciesGrowth::
Func_0F0_6BA1:: ; address name
    ld a, [wTopSpeciesLo]
    ld [wSpeciesIdLo], a
    ld a, [wTopSpeciesHi]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $8]
    ld [wTopSpeciesGrowth], a
    ld a, [wSpeciesRecord + $9]
    ld [wTopSpeciesGrowth + $1], a
    ld a, [wSpeciesRecord + $A]
    ld [wTopSpeciesGrowth + $2], a
    ld hl, wSpeciesRecord + $12
    ld de, wResistanceLevels
    ld c, $1B

Jump_0F0_6BCD::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F0_6BCD
    ld a, [wTopStat1]
    ld [wTopStat0], a
    ld a, [wTopStat3]
    ld [wTopStat2], a
    ret

; ranks the 11 scores at wCEC3 in descending order (ties at random) into wCF7E, then wCF8A = BandOfFamilyBitCount (E-0130)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case11)
; reads: wRankIndex, wRankBand
; writes: wRankIndex, wRankBand, wTopSpeciesLo, wTopSpeciesHi, wTopSpeciesByte
; points at: wFamilyScores, wFamilyRankTaken, wFamilyRanking
RankFamilyScoresIntoFamilyRanking::
Func_0F0_6BE0:: ; address name
    xor a, a
    ld [wRankIndex], a

Jump_0F0_6BE4::
    ld hl, wFamilyScores
    ld c, $00
    ld b, $00
    ld e, $00

Jump_0F0_6BED::
    push hl
    ld a, c
    ld hl, wFamilyRankTaken
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F0_6BFF
    pop hl
    jr Jump_0F0_6C15

Jump_0F0_6BFF::
    pop hl
    ld a, [hl]
    cp a, b
    jr c, Jump_0F0_6C0A
    jr z, Jump_0F0_6C0C
    ld b, a

Jump_0F0_6C07::
    ld e, c
    jr Jump_0F0_6C15

Jump_0F0_6C0A::
    jr Jump_0F0_6C15

Jump_0F0_6C0C::
    call NextTableByte
    bit 0, a
    jr nz, Jump_0F0_6C15
    jr Jump_0F0_6C07

Jump_0F0_6C15::
    inc hl
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_0F0_6BED
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
    jr c, Jump_0F0_6BE4
    call BandOfFamilyBitCount
    ld [wRankBand], a
    xor a, a
    ld [wRankIndex], a
    ld hl, wFamilyRanking
    ld b, $0A

Jump_0F0_6C4F::
    push hl
    push bc
    ld a, [hl]
    res 7, a
    add a, a
    ld de, Data_0F0_6CB5
    add a, e
    ld e, a
    jr nc, Jump_0F0_6C5D
    inc d

Jump_0F0_6C5D::
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

Jump_0F0_6C6E::
    inc de
    ld a, [de]
    dec de
    cp a, $FF
    jr z, Jump_0F0_6C89
    cp a, $FE
    jr z, Jump_0F0_6CA0
    push de
    ld b, $0F
    call RandomModulo29_BankF0
    ld a, l
    bit 0, a
    jr nz, Jump_0F0_6CA4
    pop de
    inc de
    inc de
    jr Jump_0F0_6C6E

Jump_0F0_6C89::
    pop bc
    pop hl
    inc hl
    dec b
    jp nz, Jump_0F0_6C4F
    ld a, $0A
    ld [wTopSpeciesByte], a
    ld a, $74
    ld [wTopSpeciesLo], a
    ld a, $01
    ld [wTopSpeciesHi], a
    ret

Jump_0F0_6CA0::
    dec de
    dec de
    jr Jump_0F0_6CA5

Jump_0F0_6CA4::
    pop de

Jump_0F0_6CA5::
    ld a, [de]
    ld [wTopSpeciesLo], a
    inc de
    ld a, [de]
    ld [wTopSpeciesHi], a
    pop bc
    pop hl
    ld a, [hl]
    ld [wTopSpeciesByte], a
    ret

Data_0F0_6CB5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F0_6CCB
    dw Data_0F0_6D1F
    dw Data_0F0_6D7D
    dw Data_0F0_6DDD
    dw Data_0F0_6E33
    dw Data_0F0_6E89
    dw Data_0F0_6EDD
    dw Data_0F0_6F37
    dw Data_0F0_6F8D
    dw Data_0F0_6FED
    dw Data_0F0_704B

Data_0F0_6CCB:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6CDB
    dw Data_0F0_6CE3
    dw Data_0F0_6CEF
    dw Data_0F0_6CF9
    dw Data_0F0_6D05
    dw Data_0F0_6D0F
    dw Data_0F0_6D17
    dw Data_0F0_6D1B

Data_0F0_6CDB:: ; heuristic: target of a monotone pointer table; C0
    db $02, $00, $05, $00, $0F, $00, $FE, $FE

Data_0F0_6CE3:: ; heuristic: target of a monotone pointer table; C0
    db $04, $00, $07, $00, $0A, $00, $14, $00, $1A, $00, $FE, $FE

Data_0F0_6CEF:: ; heuristic: target of a monotone pointer table; C0
    db $03, $00, $08, $00, $09, $00, $0B, $00, $FE, $FE

Data_0F0_6CF9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $06, $00, $0C, $00, $0D, $00, $0E, $00, $FE, $FE

Data_0F0_6D05:: ; heuristic: target of a monotone pointer table; C0
    db $11, $00, $13, $00, $15, $00, $16, $00, $FE, $FE

Data_0F0_6D0F:: ; heuristic: target of a monotone pointer table; C0
    db $10, $00, $12, $00, $17, $00, $FE, $FE

Data_0F0_6D17:: ; heuristic: target of a monotone pointer table; C0
    db $18, $00, $FE, $FE

Data_0F0_6D1B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $00, $FE, $FE

Data_0F0_6D1F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6D2F
    dw Data_0F0_6D37
    dw Data_0F0_6D43
    dw Data_0F0_6D4F
    dw Data_0F0_6D59
    dw Data_0F0_6D67
    dw Data_0F0_6D71
    dw Data_0F0_6D79

; LZSS-compressed asset: 43 bytes expand to 40 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D2F:: ; heuristic: target of a monotone pointer table; C0
    db $28, $00, $31, $00, $32, $00, $FE, $FE

; LZSS-compressed asset: 45 bytes expand to 42 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D37:: ; heuristic: target of a monotone pointer table; C0
    db $2A, $00, $2E, $00, $34, $00, $36, $00, $39, $00, $FE, $FE

; LZSS-compressed asset: 39 bytes expand to 36 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D43:: ; heuristic: target of a monotone pointer table; C0
    db $24, $00, $25, $00, $26, $00, $27, $00, $3A, $00, $FE, $FE

; LZSS-compressed asset: 46 bytes expand to 43 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D4F:: ; heuristic: target of a monotone pointer table; C0
    db $2B, $00, $2C, $00, $30, $00, $35, $00, $FE, $FE

; LZSS-compressed asset: 44 bytes expand to 41 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D59:: ; heuristic: target of a monotone pointer table; C0
    db $29, $00, $2D, $00, $2F, $00, $33, $00, $37, $00, $3B, $00, $FE, $FE

; LZSS-compressed asset: 59 bytes expand to 56 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D67:: ; heuristic: target of a monotone pointer table; C0
    db $38, $00, $3D, $00, $3E, $00, $3F, $00, $FE, $FE

; LZSS-compressed asset: 63 bytes expand to 60 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D71:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $40, $00, $42, $00, $FE, $FE

; LZSS-compressed asset: 40 bytes expand to 65 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D79:: ; heuristic: target of a monotone pointer table; C0
    db $41, $00, $FE, $FE

Data_0F0_6D7D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6D8D
    dw Data_0F0_6D9B
    dw Data_0F0_6DA9
    dw Data_0F0_6DB7
    dw Data_0F0_6DC5
    dw Data_0F0_6DCF
    dw Data_0F0_6DD5
    dw Data_0F0_6DD9

; LZSS-compressed asset: 75 bytes expand to 72 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D8D:: ; heuristic: target of a monotone pointer table; C0
    db $48, $00, $49, $00, $4A, $00, $4B, $00, $50, $00, $5B, $00, $FE, $FE

; LZSS-compressed asset: 80 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D9B:: ; heuristic: target of a monotone pointer table; C0
    db $4D, $00, $4E, $00, $53, $00, $54, $00, $57, $00, $5A, $00, $FE, $FE

; LZSS-compressed asset: 74 bytes expand to 71 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DA9:: ; heuristic: target of a monotone pointer table; C0
    db $47, $00, $4F, $00, $51, $00, $52, $00, $58, $00, $59, $00, $FE, $FE

; LZSS-compressed asset: 88 bytes expand to 85 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DB7:: ; heuristic: target of a monotone pointer table; C0
    db $55, $00, $56, $00, $5D, $00, $5E, $00, $65, $00, $66, $00, $FE

Data_0F0_6DC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE

; LZSS-compressed asset: 79 bytes expand to 76 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DC5:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5F, $00, $62, $00, $63, $00, $FE, $FE

; LZSS-compressed asset: 95 bytes expand to 92 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DCF:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00, $61, $00, $FE, $FE

; LZSS-compressed asset: 55 bytes expand to 96 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DD5:: ; heuristic: target of a monotone pointer table; C0
    db $60, $00, $FE, $FE

; LZSS-compressed asset: 51 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DD9:: ; heuristic: target of a monotone pointer table; C0
    db $64, $00, $FE, $FE

Data_0F0_6DDD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6DED
    dw Data_0F0_6DF3
    dw Data_0F0_6DFD
    dw Data_0F0_6E0B
    dw Data_0F0_6E19
    dw Data_0F0_6E23
    dw Data_0F0_6E29
    dw Data_0F0_6E2F

; LZSS-compressed asset: 109 bytes expand to 106 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DED:: ; heuristic: target of a monotone pointer table; C0
    db $6A, $00, $73, $00, $FE, $FE

; LZSS-compressed asset: 112 bytes expand to 109 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DF3:: ; heuristic: target of a monotone pointer table; C0
    db $6D, $00, $70, $00, $74, $00, $75, $00, $FE, $FE

; LZSS-compressed asset: 103 bytes expand to 108 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DFD:: ; heuristic: target of a monotone pointer table; C0
    db $6C, $00, $71, $00, $72, $00, $76, $00, $77, $00, $84, $00, $FE, $FE

; LZSS-compressed asset: 56 bytes expand to 107 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E0B:: ; heuristic: target of a monotone pointer table; C0
    db $6B, $00, $6E, $00, $6F, $00, $78, $00, $79, $00, $7A, $00, $FE, $FE

; LZSS-compressed asset: 126 bytes expand to 123 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E19:: ; heuristic: target of a monotone pointer table; C0
    db $7B, $00, $7C, $00, $7D, $00, $80, $00, $FE, $FE

; LZSS-compressed asset: 129 bytes expand to 126 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E23:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00, $7F, $00, $FE, $FE

; LZSS-compressed asset: 132 bytes expand to 129 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E29:: ; heuristic: target of a monotone pointer table; C0
    db $81, $00, $83, $00, $FE, $FE

; LZSS-compressed asset: 73 bytes expand to 130 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E2F:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00, $FE, $FE

Data_0F0_6E33:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6E43
    dw Data_0F0_6E4D
    dw Data_0F0_6E55
    dw Data_0F0_6E61
    dw Data_0F0_6E71
    dw Data_0F0_6E77
    dw Data_0F0_6E7D
    dw Data_0F0_6E81

; LZSS-compressed asset: 148 bytes expand to 145 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E43:: ; heuristic: target of a monotone pointer table; C0
    db $91, $00, $93, $00, $95, $00, $A6, $00, $FE, $FE

; LZSS-compressed asset: 144 bytes expand to 141 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E4D:: ; heuristic: target of a monotone pointer table; C0
    db $8D, $00, $90, $00, $97, $00, $FE, $FE

; LZSS-compressed asset: 145 bytes expand to 142 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E55:: ; heuristic: target of a monotone pointer table; C0
    db $8E, $00, $8F, $00, $92, $00, $96, $00, $98, $00, $FE, $FE

; LZSS-compressed asset: 147 bytes expand to 148 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E61:: ; heuristic: target of a monotone pointer table; C0
    db $94, $00, $99, $00, $9A, $00, $9D, $00, $9E, $00, $9F, $00, $A7, $00, $FE, $FE

; LZSS-compressed asset: 163 bytes expand to 160 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E71:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $00, $A1, $00, $FE, $FE

; LZSS-compressed asset: 157 bytes expand to 154 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E77:: ; heuristic: target of a monotone pointer table; C0
    db $9A, $00, $9B, $00, $FE, $FE

; LZSS-compressed asset: 107 bytes expand to 162 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E7D:: ; heuristic: target of a monotone pointer table; C0
    db $A2, $00

Data_0F0_6E7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE

; LZSS-compressed asset: 166 bytes expand to 163 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E81:: ; heuristic: target of a monotone pointer table; C0
    db $A3, $00, $A4, $00, $A5, $00, $FE, $FE

Data_0F0_6E89:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6E99
    dw Data_0F0_6EA3
    dw Data_0F0_6EAB
    dw Data_0F0_6EB7
    dw Data_0F0_6EC7
    dw Data_0F0_6ECD
    dw Data_0F0_6ED5
    dw Data_0F0_6ED9

; LZSS-compressed asset: 179 bytes expand to 176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E99:: ; heuristic: target of a monotone pointer table; C0
    db $B0, $00, $B5, $00, $B9, $00, $BB, $00, $FE, $FE

; LZSS-compressed asset: 181 bytes expand to 178 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EA3:: ; heuristic: target of a monotone pointer table; C0
    db $B2, $00, $B3, $00, $BA, $00, $FE, $FE

; LZSS-compressed asset: 185 bytes expand to 182 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EAB:: ; heuristic: target of a monotone pointer table; C0
    db $B6, $00, $B7, $00, $B8, $00, $BD, $00, $C2, $00, $FE, $FE

; LZSS-compressed asset: 180 bytes expand to 177 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EB7:: ; heuristic: target of a monotone pointer table; C0
    db $B1, $00, $B4, $00, $BC, $00, $BE, $00, $BF, $00, $C1, $00, $C9, $00, $FE, $FE

; LZSS-compressed asset: 195 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EC7:: ; heuristic: target of a monotone pointer table; C0
    db $C0, $00, $C5, $00, $FE, $FE

; LZSS-compressed asset: 198 bytes expand to 195 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ECD:: ; heuristic: target of a monotone pointer table; C0
    db $C3, $00, $C4, $00, $C7, $00, $FE, $FE

; LZSS-compressed asset: 103 bytes expand to 198 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ED5:: ; heuristic: target of a monotone pointer table; C0
    db $C6, $00, $FE, $FE

; LZSS-compressed asset: 105 bytes expand to 200 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ED9:: ; heuristic: target of a monotone pointer table; C0
    db $C8, $00, $FE, $FE

Data_0F0_6EDD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6EED
    dw Data_0F0_6EF3
    dw Data_0F0_6EF9
    dw Data_0F0_6EFF
    dw Data_0F0_6F0B
    dw Data_0F0_6F17
    dw Data_0F0_6F29
    dw Data_0F0_6F33

; LZSS-compressed asset: 214 bytes expand to 211 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EED:: ; heuristic: target of a monotone pointer table; C0
    db $D3, $00, $D6, $00, $FE, $FE

; LZSS-compressed asset: 223 bytes expand to 220 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EF3:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $DD, $00, $FE, $FE

; LZSS-compressed asset: 215 bytes expand to 212 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EF9:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00, $D8, $00, $FE, $FE

; LZSS-compressed asset: 212 bytes expand to 215 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EFF:: ; heuristic: target of a monotone pointer table; C0
    db $D7, $00, $D9, $00, $E1, $00, $EA, $00, $EC, $00, $FE, $FE

; LZSS-compressed asset: 221 bytes expand to 218 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F0B:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $00, $DB, $00, $DF, $00, $E2, $00, $E8, $00, $FE, $FE

; LZSS-compressed asset: 225 bytes expand to 222 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F17:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E0, $00, $E3, $00, $E4, $00, $E5, $00, $E6, $00, $E9, $00, $EB, $00
    db $FE, $FE

; LZSS-compressed asset: 234 bytes expand to 231 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F29:: ; heuristic: target of a monotone pointer table; C0
    db $E7, $00, $ED, $00, $EE, $00, $F0, $00, $FE, $FE

; LZSS-compressed asset: 79 bytes expand to 239 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F33:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $00, $FE, $FE

Data_0F0_6F37:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6F47
    dw Data_0F0_6F4B
    dw Data_0F0_6F55
    dw Data_0F0_6F67
    dw Data_0F0_6F75
    dw Data_0F0_6F79
    dw Data_0F0_6F7F
    dw Data_0F0_6F89

; LZSS-compressed asset: 121 bytes expand to 246 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F47:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $00, $FE, $FE

; LZSS-compressed asset: 245 bytes expand to 249 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F4B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $00, $01, $04, $01, $05, $01, $FE, $FE

; LZSS-compressed asset: 251 bytes expand to 248 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F55:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $00, $FA, $00, $FD, $00, $FE, $00, $FF, $00, $01, $01, $02, $01, $0F, $01
    db $FE, $FE

; LZSS-compressed asset: 254 bytes expand to 251 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F67:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $00, $FC, $00, $03, $01, $06, $01, $09, $01, $0E, $01, $FE, $FE

Data_0F0_6F75:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $01, $FE, $FE

; LZSS-compressed asset: 250 bytes expand to 247 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F79:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0B, $01, $FE, $FE

; LZSS-compressed asset: 266 bytes expand to 263 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F7F:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $08, $01, $0D, $01, $10, $01, $FE, $FE

; LZSS-compressed asset: 52 bytes expand to 268 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F89:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $01, $FE, $FE

Data_0F0_6F8D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6F9D
    dw Data_0F0_6FA9
    dw Data_0F0_6FB1
    dw Data_0F0_6FBB
    dw Data_0F0_6FCB
    dw Data_0F0_6FD9
    dw Data_0F0_6FE5
    dw Data_0F0_6FE9

; LZSS-compressed asset: 286 bytes expand to 283 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F9D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $01, $1D, $01, $1E, $01, $22, $01, $31, $01, $FE, $FE

; LZSS-compressed asset: 284 bytes expand to 281 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FA9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $01, $1C, $01, $28, $01, $FE, $FE

; LZSS-compressed asset: 285 bytes expand to 282 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FB1:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $01, $21, $01, $27, $01, $37, $01, $FE, $FE

; LZSS-compressed asset: 290 bytes expand to 287 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FBB:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $01, $20, $01, $23, $01, $26, $01, $2B, $01, $2C, $01, $30, $01, $FE, $FE

; LZSS-compressed asset: 287 bytes expand to 292 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FCB:: ; heuristic: target of a monotone pointer table; C0
    db $24, $01, $29, $01, $2F, $01, $32, $01, $34, $01, $38, $01, $FE, $FE

; LZSS-compressed asset: 296 bytes expand to 293 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FD9:: ; heuristic: target of a monotone pointer table; C0
    db $25, $01, $2A, $01, $2D, $01, $2E, $01, $33, $01, $FE, $FE

Data_0F0_6FE5:: ; heuristic: target of a monotone pointer table; C0
    db $35, $01, $FE, $FE

; LZSS-compressed asset: 207 bytes expand to 310 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FE9:: ; heuristic: target of a monotone pointer table; C0
    db $36, $01, $FE, $FE

Data_0F0_6FED:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6FFD
    dw Data_0F0_7005
    dw Data_0F0_700F
    dw Data_0F0_701B
    dw Data_0F0_7029
    dw Data_0F0_7035
    dw Data_0F0_7041
    dw Data_0F0_7047

; LZSS-compressed asset: 319 bytes expand to 316 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FFD:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $01, $3D, $01, $44, $01, $FE, $FE

; LZSS-compressed asset: 326 bytes expand to 323 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7005:: ; heuristic: target of a monotone pointer table; C0
    db $43, $01, $49, $01, $4D, $01, $5B, $01, $FE, $FE

; LZSS-compressed asset: 323 bytes expand to 320 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_700F:: ; heuristic: target of a monotone pointer table; C0
    db $40, $01, $41, $01, $45, $01, $4C, $01, $5A, $01, $FE, $FE

; LZSS-compressed asset: 321 bytes expand to 318 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_701B:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $3F, $01, $42, $01, $46, $01, $47, $01, $4A, $01, $FE, $FE

; LZSS-compressed asset: 331 bytes expand to 328 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7029:: ; heuristic: target of a monotone pointer table; C0
    db $48, $01, $4B, $01, $4E, $01, $4F, $01, $50, $01, $FE, $FE

; LZSS-compressed asset: 340 bytes expand to 337 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7035:: ; heuristic: target of a monotone pointer table; C0
    db $51, $01, $52, $01, $54, $01, $55, $01, $57, $01, $FE, $FE

; LZSS-compressed asset: 345 bytes expand to 342 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7041:: ; heuristic: target of a monotone pointer table; C0
    db $56, $01, $58, $01, $FE, $FE

; LZSS-compressed asset: 312 bytes expand to 345 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7047:: ; heuristic: target of a monotone pointer table; C0
    db $59, $01, $FE, $FE

Data_0F0_704B:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_705B
    dw Data_0F0_705D
    dw Data_0F0_705F
    dw Data_0F0_7061
    dw Data_0F0_7063
    dw Data_0F0_7065
    dw Data_0F0_7067
    dw Data_0F0_7085

Data_0F0_705B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_705D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_705F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7061:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7063:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7065:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7067:: ; heuristic: target of a monotone pointer table; C0
    db $5F, $01, $60, $01, $62, $01, $63, $01, $65, $01, $66, $01, $68, $01, $6A, $01
    db $6B, $01, $6C, $01, $6D, $01, $6E, $01, $6F, $01, $74, $01, $FE, $FE

Data_0F0_7085:: ; heuristic: target of a monotone pointer table; C0
    db $61, $01, $64, $01, $67, $01, $69, $01, $70, $01, $71, $01, $72, $01, $73, $01
    db $FE, $FE

; NextTableByte; L = wC5E7, H = (wC5E7 rotated left through carry) & B; returns A = HL mod $29 (E-0118)
; 14 call sites from 4 routines (e.g. ScriptCommand86_Run_Case04_Sub01, RankFamilyScoresIntoFamilyRanking, RollMarkChangeCountChance, RollCounterChanceAndRun72C8)
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

; A = 4, 5, 6 or 7 for wCE9E < 4, < 6, < $0A, or more (E-0124)
; 1 call site from 1 routine (e.g. RankFamilyScoresIntoFamilyRanking)
; reads: wFamilyBitCount
BandOfFamilyBitCount::
Func_0F0_70AA:: ; address name
    ld a, [wFamilyBitCount]
    cp a, $04
    jr c, Jump_0F0_70BC
    cp a, $06
    jr c, Jump_0F0_70BF
    cp a, $0A
    jr c, Jump_0F0_70C2
    ld a, $07
    ret

Jump_0F0_70BC::
    ld a, $04
    ret

Jump_0F0_70BF::
    ld a, $05
    ret

Jump_0F0_70C2::
    ld a, $06
    ret
    INCBIN "dwm2-cobi-us.gbc", $3C30C5, $180

; wCEC0 counts changes of B (wCEBF); if bit B of the wCE9F array is new, sets it, wCE9E += 1 and C = 0; otherwise C = $FF (E-0125)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case00)
; reads: wLastMarkedBit, wMarkChangeCount, wFamilyBitCount
; writes: wMarkChangeCount, wLastMarkedBit, wFamilyBitCount
; points at: wFamilyBits
MarkBitBInFamilyBitsAndCount::
Func_0F0_7245:: ; address name
    ld a, [wLastMarkedBit]
    cp a, b
    jr z, Jump_0F0_7256
    ld a, [wMarkChangeCount]
    cp a, $FF
    jr z, Jump_0F0_7253
    inc a

Jump_0F0_7253::
    ld [wMarkChangeCount], a

Jump_0F0_7256::
    ld a, b
    ld [wLastMarkedBit], a
    ld hl, wFamilyBits
    ld e, a
    ld d, $00
    call TestBitDEOfBitArrayHL
    cp a, $FF
    jr z, Jump_0F0_7281
    ld a, [wLastMarkedBit]
    ld hl, wFamilyBits
    ld e, a
    ld d, $00
    call OrDIntoFunc7CD4Byte
    ld a, [wFamilyBitCount]
    cp a, $FF
    jr nc, Jump_0F0_727E
    inc a
    ld [wFamilyBitCount], a

Jump_0F0_727E::
    ld c, $00
    ret

Jump_0F0_7281::
    ld c, $FF
    ret

; wCEC2 += 1 up to $0F; when wCEC1 is set, runs Func_0F0_72C8 if a random value is below 100 - 5 * wCEC2; then wCEC1 = wD7F1 (E-0124)
; 1 call site from 1 routine (e.g. Func_0F1_4001_Case02_Case00)
; reads: wRollCounter, wRollState, wArg1
; writes: wRollCounter, wRollState
RollCounterChanceAndRun72C8::
Func_0F0_7284:: ; address name
    ld a, [wRollCounter]
    cp a, $0F
    jr nc, Jump_0F0_728F
    inc a
    ld [wRollCounter], a

Jump_0F0_728F::
    ld a, [wRollState]
    and a, a
    jr z, Jump_0F0_72AD
    ld a, [wRollCounter]
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
    call c, RollCounterChanceAndRun72C8_Sub01

Jump_0F0_72AD::
    ld a, [wArg1]
    ld [wRollState], a
    ret

; when wCE9D = $3B and wCE9C = wCE9B = 0, clears wCEC2 and falls through (E-0122)
; 1 call site from 1 routine (e.g. CallF072B4WhenGM2TimerMinutesIs59)
; reads: wGM2TimerMinutes, wGM2TimerSeconds, wGM2TimerFrames, wRollState
; writes: wRollCounter
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
    ld [wRollCounter], a

; only called from RollCounterChanceAndRun72C8 (E-0047)
; 1 call site from 1 routine (e.g. RollCounterChanceAndRun72C8)
; reads: wRollState
RollCounterChanceAndRun72C8_Sub01::
Func_0F0_72C8:: ; address name
    ld a, [wRollState]
    rst $00
    dw Func_0F0_72C8_Case00
    dw Func_0F0_72C8_Case01
    dw Func_0F0_72C8_Case02
    dw Func_0F0_72C8_Case03
    dw Func_0F0_72C8_Case04
    dw Func_0F0_72C8_Case05
    dw Func_0F0_72C8_Case06
    dw Func_0F0_72C8_Case07
    dw Func_0F0_72C8_Case08
    dw Func_0F0_72C8_Case09
    dw Func_0F0_72C8_Case0A
    dw Func_0F0_72C8_Case0B
    dw Func_0F0_72C8_Case0C
    dw Func_0F0_72C8_Case0D
    dw Func_0F0_72C8_Case0E
    dw Func_0F0_72C8_Case0F
    dw Func_0F0_72C8_Case10
    dw Func_0F0_72C8_Case11
    dw Func_0F0_72C8_Case12
    dw Func_0F0_72C8_Case13
    dw Func_0F0_72C8_Case14
    dw Func_0F0_72C8_Case15
    dw Func_0F0_72C8_Case16
    dw Func_0F0_72C8_Case17
    dw Func_0F0_72C8_Case18
    dw Func_0F0_72C8_Case19
    dw Func_0F0_72C8_Case1A
    dw Func_0F0_72C8_Case1B
    dw Func_0F0_72C8_Case1C
    dw Func_0F0_72C8_Case1D
    dw Func_0F0_72C8_Case1E
    dw Func_0F0_72C8_Case1F
    dw Func_0F0_72C8_Case20
    dw Func_0F0_72C8_Case21
    dw Func_0F0_72C8_Case22
    dw Func_0F0_72C8_Case23
    dw Func_0F0_72C8_Case24
    dw Func_0F0_72C8_Case25
    dw Func_0F0_72C8_Case26
    dw Func_0F0_72C8_Case27
    dw Func_0F0_72C8_Case28
    dw Func_0F0_72C8_Case29
    dw Func_0F0_72C8_Case2A
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2C
    dw Func_0F0_72C8_Case2D
    dw Func_0F0_72C8_Case2E
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case40
    dw Func_0F0_72C8_Case41
    dw Func_0F0_72C8_Case42
    dw Func_0F0_72C8_Case43
    dw Func_0F0_72C8_Case44
    dw Func_0F0_72C8_Case45
    dw Func_0F0_72C8_Case46
    dw Func_0F0_72C8_Case47
    dw Func_0F0_72C8_Case48
    dw Func_0F0_72C8_Case49
    dw Func_0F0_72C8_Case4A
    dw Func_0F0_72C8_Case4B
    dw Func_0F0_72C8_Case4C
    dw Func_0F0_72C8_Case4D
    dw Func_0F0_72C8_Case4E
    dw Func_0F0_72C8_Case4F
    dw Func_0F0_72C8_Case50
    dw Func_0F0_72C8_Case51
    dw Func_0F0_72C8_Case52
    dw Func_0F0_72C8_Case53
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case2B
    dw Func_0F0_72C8_Case5A
    dw Func_0F0_72C8_Case5B
    dw Func_0F0_72C8_Case5C
    dw Func_0F0_72C8_Case5D
    dw Func_0F0_72C8_Case5E
    dw Func_0F0_72C8_Case5F
    dw Func_0F0_72C8_Case60
    dw Func_0F0_72C8_Case61

; entry 0 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
Func_0F0_72C8_Case00::
Jump_0F0_7390:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ret

; entry 1 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1, wFamilyScores
Func_0F0_72C8_Case01::
Jump_0F0_739B:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 2 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case02::
Jump_0F0_73BD:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 3 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case03::
Jump_0F0_73DF:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 4 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case04::
Jump_0F0_7401:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 5 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case05::
Jump_0F0_7423:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 6 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case06::
Jump_0F0_7445:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 7 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case07::
Jump_0F0_7452:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 8 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case08::
Jump_0F0_7474:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 9 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case09::
Jump_0F0_7496:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 10 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case0A::
Jump_0F0_74B8:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 11 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case0B::
Jump_0F0_74DA:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 12 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case0C::
Jump_0F0_74FC:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 13 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case0D::
Jump_0F0_751E:: ; address name
    ld hl, wTopStat4
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 14 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case0E::
Jump_0F0_7536:: ; address name
    ld hl, wTopStat5
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 15 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case0F::
Jump_0F0_754E:: ; address name
    ld hl, wTopStat6
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 16 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case10::
Jump_0F0_7566:: ; address name
    ld hl, wTopStat7
    ld b, $03
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 17 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case11::
Jump_0F0_757E:: ; address name
    ld hl, wTopStat1
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 18 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case12::
Jump_0F0_7596:: ; address name
    ld hl, wTopStat3
    ld b, $05
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 19 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case13::
Jump_0F0_75AE:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 20 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case14::
Jump_0F0_75D0:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 21 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case15::
Jump_0F0_75F2:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 22 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case16::
Jump_0F0_7614:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 23 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case17::
Jump_0F0_7636:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 24 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3, wFamilyScores
Func_0F0_72C8_Case18::
Jump_0F0_7658:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 25 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case19::
Jump_0F0_767A:: ; address name
    ld hl, wTopStat1
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 26 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case1A::
Jump_0F0_7692:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 27 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case1B::
Jump_0F0_76B4:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 28 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case1C::
Jump_0F0_76D6:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 29 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case1D::
Jump_0F0_76F8:: ; address name
    ld hl, wTopStat1
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $05
    ld c, $FA
    call AddBClampedToC
    xor a, a
    ld [wRollState], a
    ret

; entry 30 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case1E::
Jump_0F0_7712:: ; address name
    ld hl, wFamilyScores + $A
    ld b, $01
    ld c, $FE
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 31 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case1F::
Jump_0F0_7729:: ; address name
    xor a, a
    ld [wRollState], a
    ret

; entry 32 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case20::
Jump_0F0_772E:: ; address name
    ld hl, wTopStat1
    ld b, $01
    ld de, $03E7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 33 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case21::
Jump_0F0_7746:: ; address name
    xor a, a
    ld [wRollState], a
    ret

; entry 34 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case22::
Jump_0F0_774B:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 35 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case23::
Jump_0F0_776D:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 36 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5, wFamilyScores
Func_0F0_72C8_Case24::
Jump_0F0_778F:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 37 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case25::
Jump_0F0_77B1:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 38 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case26::
Jump_0F0_77D3:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 39 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case27::
Jump_0F0_77F5:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 40 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case28::
Jump_0F0_7817:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 41 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case29::
Jump_0F0_7839:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 42 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case2A::
Jump_0F0_785B:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 43 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case2B::
Jump_0F0_787D:: ; address name
    xor a, a
    ld [wRollState], a
    ret

; entry 44 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case2C::
Jump_0F0_7882:: ; address name
    xor a, a
    ld [wRollState], a
    ret

; entry 45 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case2D::
Jump_0F0_7887:: ; address name
    xor a, a
    ld [wRollState], a
    ret

; entry 46 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
Func_0F0_72C8_Case2E::
Jump_0F0_788C:: ; address name
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a, a
    ld [wRollState], a
    ret

; entry 64 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case40::
Jump_0F0_7899:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 65 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case41::
Jump_0F0_78BB:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 66 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case42::
Jump_0F0_78DD:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 67 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case43::
Jump_0F0_78FF:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 68 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case44::
Jump_0F0_7921:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 69 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case45::
Jump_0F0_7943:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 70 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case46::
Jump_0F0_7965:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 71 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case47::
Jump_0F0_7987:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 72 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6, wFamilyScores
Func_0F0_72C8_Case48::
Jump_0F0_79A9:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 73 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6, wFamilyScores
Func_0F0_72C8_Case49::
Jump_0F0_79CB:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 74 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case4A::
Jump_0F0_79ED:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 75 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case4B::
Jump_0F0_7A0F:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 76 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case4C::
Jump_0F0_7A31:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 77 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case4D::
Jump_0F0_7A53:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 78 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case4E::
Jump_0F0_7A75:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 79 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7
Func_0F0_72C8_Case4F::
Jump_0F0_7A97:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; entry 80 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case50::
Jump_0F0_7AB9:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 81 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case51::
Jump_0F0_7ADB:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 82 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case52::
Jump_0F0_7AFD:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 83 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case53::
Jump_0F0_7B1F:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 90 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case5A::
Jump_0F0_7B41:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 91 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case5B::
Jump_0F0_7B63:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 92 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat1
Func_0F0_72C8_Case5C::
Jump_0F0_7B85:: ; address name
    ld hl, wTopStat1
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
    ld [wRollState], a
    ret

; entry 93 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat3
Func_0F0_72C8_Case5D::
Jump_0F0_7BA7:: ; address name
    ld hl, wTopStat3
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
    ld [wRollState], a
    ret

; entry 94 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat4
Func_0F0_72C8_Case5E::
Jump_0F0_7BC9:: ; address name
    ld hl, wTopStat4
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
    ld [wRollState], a
    ret

; entry 95 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat5
Func_0F0_72C8_Case5F::
Jump_0F0_7BEB:: ; address name
    ld hl, wTopStat5
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
    ld [wRollState], a
    ret

; entry 96 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat6
Func_0F0_72C8_Case60::
Jump_0F0_7C0D:: ; address name
    ld hl, wTopStat6
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
    ld [wRollState], a
    ret

; entry 97 of the `rst $00` table in Func_0F0_72C8
; no direct call (reached through a table, a jump or a vector)
; writes: wRollState
; points at: wTopStat7, wFamilyScores
Func_0F0_72C8_Case61::
Jump_0F0_7C2F:: ; address name
    ld hl, wTopStat7
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
    ld [wRollState], a
    ret

; [HL] = min([HL] + B, C) (8-bit add, no overflow check); clobbers A, C
; 60 call sites from 60 routines (e.g. Func_0F0_72C8_Case61, Func_0F0_72C8_Case60, Func_0F0_72C8_Case5F, Func_0F0_72C8_Case5E, ...)
AddBClampedToC::
Func_0F0_7C51:: ; address name
    inc c
    ld a, [hl]
    add a, b
    cp a, c
    jr c, Jump_0F0_7C59
    ld a, c
    dec a

Jump_0F0_7C59::
    ld [hl], a
    ret

; [HL] = [HL] - B, or 0 when the result has bit 7 set; clobbers A
; 68 call sites from 68 routines (e.g. Func_0F0_72C8_Case61, Func_0F0_72C8_Case60, Func_0F0_72C8_Case5F, Func_0F0_72C8_Case5E, ...)
SubtractBClampedAtZero::
Func_0F0_7C5B:: ; address name
    ld a, [hl]
    sub a, b
    bit 7, a
    jr z, Jump_0F0_7C62
    xor a, a

Jump_0F0_7C62::
    ld [hl], a
    ret

; HL = address of a word: word = min(word + B, DE) (CompareHLWithDE); DE kept; clobbers A, BC, HL (E-0061)
; 66 call sites from 66 routines (e.g. Func_0F0_72C8_Case61, Func_0F0_72C8_Case60, Func_0F0_72C8_Case5F, Func_0F0_72C8_Case5E, ...)
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
    jr nz, Jump_0F0_7C7A
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

Jump_0F0_7C7A::
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
    jr c, Jump_0F0_7C90
    jr nz, Jump_0F0_7C8D
    ld a, l
    cp a, e
    jr c, Jump_0F0_7C90
    jr z, Jump_0F0_7C93

Jump_0F0_7C8D::
    ld c, $FF
    ret

Jump_0F0_7C90::
    ld c, $00
    ret

Jump_0F0_7C93::
    ld c, $01
    ret

; copies the $F0-terminated string [HL] of the category chosen by [HL + 1] (Data_0F0_4036 or Data_008_4038) from bank 8 to HL (E-0125)
; 2 call sites from 2 routines (e.g. Func_0F0_4CA0_Case0A_Case1E, Func_0F0_4CA0_Case0B_Case1E)
CopyNameStringFromBank08Database::
Func_0F0_7C96:: ; address name
    push de
    inc hl
    ld a, [hl-]
    and a, a
    jr nz, Jump_0F0_7CA1
    ld de, Data_0F0_4036
    jr Jump_0F0_7CA4

Jump_0F0_7CA1::
    ld de, Data_008_4038

Jump_0F0_7CA4::
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

Jump_0F0_7CC2::
    ld b, $08
    call ReadByteInBank
    ld a, c
    cp a, $F0
    jr z, Jump_0F0_7CD0
    ld [hl+], a
    inc de
    jr Jump_0F0_7CC2

Jump_0F0_7CD0::
    ld a, $F0
    ld [hl+], a
    ret

; A = $FF when bit DE of the bit array at HL is set (mask Data_0F0_7CFB), else 0; HL is left at the byte (E-0124)
; 2 call sites from 2 routines (e.g. MarkBitBInFamilyBitsAndCount, OrDIntoFunc7CD4Byte)
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
    ld hl, Data_0F0_7CFB
    add_a_to_hl
    ld a, [hl]
    ld d, a
    pop hl
    ld a, [hl]
    and a, d
    jr nz, Jump_0F0_7CF8
    xor a, a
    ret

Jump_0F0_7CF8::
    ld a, $FF
    ret

Data_0F0_7CFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

; [HL from Func_0F0_7CD4] |= D (E-0122)
; 1 call site from 1 routine (e.g. MarkBitBInFamilyBitsAndCount)
OrDIntoFunc7CD4Byte::
Func_0F0_7D03:: ; address name
    call TestBitDEOfBitArrayHL
    ld a, [hl]
    or a, d
    ld [hl], a
    ret

; only called from ScriptCommand86_Run_Case04 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand86_Run_Case04)
; reads: wSaveByte16
; points at: wGM2TimerFrames, wGM2Mode, wPlayerName, wGM2Byte
ScriptCommand86_Run_Case04_Sub01::
Func_0F0_7D0A:: ; address name
    ld hl, wGM2TimerFrames
    ld bc, $00D8

Jump_0F0_7D10::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_7D10
    ld hl, wGM2Mode
    ld a, $01
    ld [hl+], a
    ld c, $0A

Jump_0F0_7D1F::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7D1F
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

Jump_0F0_7D3B::
    ld a, [de]
    cp a, $F0
    jr z, Jump_0F0_7D47
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F0_7D3B
    jr Jump_0F0_7D4A

Jump_0F0_7D47::
    ld a, $F0
    ld [hl+], a

Jump_0F0_7D4A::
    ld hl, wGM2Byte
    ld a, [wSaveByte16]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call ScriptCommand86_Run_Case04_Sub01_Sub02
    ld c, $06
    ld b, $F0
    call ScriptCommand86_Run_Case04_Sub01_Sub01
    ld a, $F0
    ld [hl+], a
    call ScriptCommand86_Run_Case04_Sub01_Sub02
    ld c, $06
    ld b, $F0
    call ScriptCommand86_Run_Case04_Sub01_Sub01
    ld a, $F0
    ld [hl+], a
    ld c, $21

Jump_0F0_7D73::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7D73
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
    call ScriptCommand86_Run_Case04_Sub01_Sub03
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
    call ScriptCommand86_Run_Case04_Sub01_Sub03
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
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $20
    call ScriptCommand86_Run_Case04_Sub01_Sub03
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
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call RandomModulo29_BankF0
    ld b, $FE
    call ScriptCommand86_Run_Case04_Sub01_Sub03
    pop hl
    ld a, e
    ld [hl+], a
    ld c, $1B

Jump_0F0_7E2E::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E2E
    ld c, $0A

Jump_0F0_7E35::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E35
    xor a, a
    ld [hl+], a
    ld c, $0A

Jump_0F0_7E3F::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E3F
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

; only called from ScriptCommand86_Run_Case04_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommand86_Run_Case04_Sub01)
ScriptCommand86_Run_Case04_Sub01_Sub01::
Func_0F0_7E4A:: ; address name
    ld a, b
    ld [hl+], a
    dec c
    jr nz, ScriptCommand86_Run_Case04_Sub01_Sub01
    ret

; only called from ScriptCommand86_Run_Case04_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommand86_Run_Case04_Sub01)
ScriptCommand86_Run_Case04_Sub01_Sub02::
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

; only called from ScriptCommand86_Run_Case04_Sub01 (E-0047)
; 10 call sites from 1 routine (e.g. ScriptCommand86_Run_Case04_Sub01)
ScriptCommand86_Run_Case04_Sub01_Sub03::
Func_0F0_7E5D:: ; address name
    ld a, l

Jump_0F0_7E5E::
    cp a, b
    jr c, Jump_0F0_7E64
    sub a, b
    jr Jump_0F0_7E5E

Jump_0F0_7E64::
    inc a
    ld e, a
    ld d, $00
    ret

; A = 1 with a chance growing with wCEC0 (none below 5, 10 per step to 80 from 13), else 0 (E-0124)
; 1 call site from 1 routine (e.g. Func_0F0_4CA0_Table5_Case00)
; reads: wMarkChangeCount
RollMarkChangeCountChance::
Func_0F0_7E69:: ; address name
    ld a, [wMarkChangeCount]
    cp a, $05
    jr nc, Jump_0F0_7E72

Jump_0F0_7E70::
    xor a, a
    ret

Jump_0F0_7E72::
    cp a, $0D
    jr nc, Jump_0F0_7E80
    sub a, $04
    ld c, $0A
    call Multiply8
    ld e, l
    jr Jump_0F0_7E82

Jump_0F0_7E80::
    ld e, $50

Jump_0F0_7E82::
    push de
    ld b, $0F
    call RandomModulo29_BankF0
    ld a, l
    pop de
    cp a, e
    jr nc, Jump_0F0_7E70
    ld a, $01
    ret
    ds $170, $00
