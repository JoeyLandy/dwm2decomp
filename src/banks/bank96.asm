SECTION "Bank 96", ROMX[$4000], BANK[$96]
    db $96

; overflow for message bank $80: wStringIndex -= $C8, then BeginStringDisplay with the table
; MessageStrings_Bank80_Overflow in this bank (E-0080)
BeginStringDisplay_Bank80_Overflow::
    ld de, MessageStrings_Bank80_Overflow
    ld a, [wStringIndex]
    sub $c8
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $80: wStringIndex -= $C8, then CopyStringToBuffer with the table
; MessageStrings_Bank80_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank80_Overflow::
    ld de, MessageStrings_Bank80_Overflow
    ld a, [wStringIndex]
    sub $c8
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; overflow for message bank $82: wStringIndex -= $90, then BeginStringDisplay with the table
; MessageStrings_Bank82_Overflow in this bank (E-0080)
BeginStringDisplay_Bank82_Overflow::
    ld de, MessageStrings_Bank82_Overflow
    ld a, [wStringIndex]
    sub $90
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $82: wStringIndex -= $90, then CopyStringToBuffer with the table
; MessageStrings_Bank82_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank82_Overflow::
    ld de, MessageStrings_Bank82_Overflow
    ld a, [wStringIndex]
    sub $90
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $26, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_96_404B::
MessageStrings_Bank80_Overflow::
    dw StringList_96_404D ; id 0

; category list of StringCategories_96_404B; one pointer per wStringIndex (E-0217)
; record: string
StringList_96_404D::
    dw String_96_404B_00_00 ; id 0
    dw String_96_404B_00_01 ; id 1
    dw String_96_404B_00_02 ; id 2
    dw String_96_404B_00_03 ; id 3
    dw String_96_404B_00_04 ; id 4
    dw String_96_404B_00_05 ; id 5
    dw String_96_404B_00_06 ; id 6
    dw String_96_404B_00_07 ; id 7
    dw String_96_404B_00_08 ; id 8
    dw String_96_404B_00_09 ; id 9
    dw String_96_404B_00_0A ; id 10
    dw String_96_404B_00_0B ; id 11
    dw String_96_404B_00_0C ; id 12
    dw String_96_404B_00_0D ; id 13
    dw String_96_404B_00_0E ; id 14
    dw String_96_404B_00_0E ; id 15
    dw String_96_404B_00_10 ; id 16
    dw String_96_404B_00_11 ; id 17
    dw String_96_404B_00_12 ; id 18
    dw String_96_404B_00_13 ; id 19
    dw String_96_404B_00_14 ; id 20
    dw String_96_404B_00_15 ; id 21
    dw String_96_404B_00_15 ; id 22
    dw String_96_404B_00_17 ; id 23
    dw String_96_404B_00_18 ; id 24
    dw String_96_404B_00_19 ; id 25
    dw String_96_404B_00_1A ; id 26
    dw String_96_404B_00_1B ; id 27
    dw String_96_404B_00_1C ; id 28
    dw String_96_404B_00_1D ; id 29
    dw String_96_404B_00_1E ; id 30
    dw String_96_404B_00_1F ; id 31
    dw String_96_404B_00_20 ; id 32
    dw String_96_404B_00_21 ; id 33
    dw String_96_404B_00_22 ; id 34
    dw String_96_404B_00_23 ; id 35
    dw String_96_404B_00_24 ; id 36
    dw String_96_404B_00_25 ; id 37
    dw String_96_404B_00_26 ; id 38
    dw String_96_404B_00_27 ; id 39
    dw String_96_404B_00_28 ; id 40
    dw String_96_404B_00_29 ; id 41
    dw String_96_404B_00_29 ; id 42
    dw String_96_404B_00_2B ; id 43
    dw String_96_404B_00_2C ; id 44
    dw String_96_404B_00_2D ; id 45
    dw String_96_404B_00_2E ; id 46
    dw String_96_404B_00_2E ; id 47
    dw String_96_404B_00_30 ; id 48
    dw String_96_404B_00_31 ; id 49
    dw String_96_404B_00_32 ; id 50
    dw String_96_404B_00_33 ; id 51
    dw String_96_404B_00_34 ; id 52
    dw String_96_404B_00_35 ; id 53
    dw String_96_404B_00_36 ; id 54
    dw String_96_404B_00_37 ; id 55

String_96_404B_00_00::
    db $eb, "*: You will?", $f1
    db "Thank you!", $fa, $f7
    db $ef, $ee, "Let me hide among", $ef, $ee, "your items.", $fa, $f7
    db $ef, $ee, "Oh? You have no", $ef, $ee, "room for me", $a4, $f7
    db $f0

String_96_404B_00_01::
    db $eb, "*: Oh", $a4, " How terribly", $f1
    db "disappointing.", $fa, $f7
    db $ef, $ee, "I'll have to find", $ef, $ee, "someone else who", $fa, $f7
    db $ef, $ee, "would be willing", $ef, $ee, "to help me", $a4, $f7
    db $f0

String_96_404B_00_02::
    db $eb, "*: I don't remember", $f1
    db "who I am, what I'm", $fa, $f7
    db $ef, $ee, "doing here, or", $ef, $ee, "anything else", $a4, $fa, $f7
    db $ef, $ee, "I just know that I", $ef, $ee, "need help", $a4, $fa, $f7
    db $ef, $ee, "Oh? Do you know", $ef, $ee, "who I am?", $fa, $f7
    db $ef, $ee, "Could I get you to", $ef, $ee, "take me back home?", $ff, $f0

String_96_404B_00_03::
    db $ea, "*: The crowds that", $f1
    db "flocked to the", $fa, $f7
    db $ef, $ee, "castle have all", $ef, $ee, "left.", $fa, $f7
    db $ef, $ee, "Not a one of them", $ef, $ee, "raised even the", $fa, $f7
    db $ef, $ee, "ghost of a smile", $ef, $ee, "from Lady Yuna", $a4, $f7
    db $f0

String_96_404B_00_04::
    db $ea, "King: Yuna has", $f1
    db "locked herself", $fa, $f7
    db $ef, $ee, "away in her room", $a4, $ef, $ee, "Everyone failed to", $fa, $f7
    db $ef, $ee, "cheer her up even", $ef, $ee, "the least bit", $a4, $f7
    db $f0

String_96_404B_00_05::
    db $ea, "*: Lady Yuna locked", $f1
    db "herself in and", $fa, $f7
    db $ef, $ee, "won't respond to", $ef, $ee, "repeated calls.", $f7
    db $f0

String_96_404B_00_06::
    db $f9, "0 checked the", $f1
    db "marionette.", $fa, $f7
    db $ef, $ee, "It sagged", $ef, $ee, "lifelessly.", $f7
    db $f0

String_96_404B_00_07::
    db $eb, "*: ", $a4, $a4, $a4, $a4, $f1
    db $fa, $f7
    db $ef, $ee, $f3, "W-where am I?", $f1
    db "I", $a4, " I", $a4, " I am", $a4, $fa, $f7
    db $ef, $ee, "I'm on the verge", $ef, $ee, "of remembering!", $f7
    db $f0

String_96_404B_00_08::
    db "Yuna's soul filled", $f1
    db "her body.", $f7
    db $f0

String_96_404B_00_09::
    db $ea, "*: ", $a4, $a4, " STOP", $a4, $f1
    db "DON'T MEDDLE", $a4, $f7
    db $f0

String_96_404B_00_0A::
    db $ea, "*: NEVER DID I", $f1
    db "EXPECT YUNA'S SOUL", $fa, $f7
    db $ef, $ee, "TO BE FOUND", $a4, $ef, $ee, "BUT, NO MATTER.", $fa, $f7
    db $ef, $ee, "YOU MUST DEFEAT ME", $ef, $ee, "TO SAVE HER.", $fa, $f7
    db $ef, $ee, "DO YOU WISH TO", $ef, $ee, "BATTLE?", $ff, $f0

String_96_404B_00_0B::
    db $ea, "*: FOOLHARDY.", $f1
    db "BRAVE BUT FOOLISH.", $f7
    db $f0

String_96_404B_00_0C::
    db $ea, "*: H-HOW", $a4, " BUT I", $a4, $f1
    db "THIS ISN'T", $a4, $a4, $f7
    db $f0

String_96_404B_00_0D::
    db $eb, "*: I've finally", $f1
    db "remembered.", $fa, $f7
    db $ef, $ee, "I'm Yuna, the", $ef, $ee, "King's daughter.", $fa, $f7
    db $ef, $ee, "I", $44, " overheard a", $ef, $ee, "man and monsters", $fa, $f7
    db $ef, $ee, "concocting a", $ef, $ee, "criminal plan in", $fa, $f7
    db $ef, $ee, "the forest, but", $ef, $ee, "they found me.", $fa, $f7
    db $ef, $ee, "A monster drained", $ef, $ee, "my soul, and my", $fa, $f7
    db $ef, $ee, "body was put under", $ef, $ee, "its control.", $fa, $f7
    db $ef, $ee, "Their plan was", $ef, $ee, "diabolical!", $fa, $f7
    db $ef, $ee, "They wanted to", $ef, $ee, "steal the Sky", $fa, $f7
    db $ef, $ee, "Shield from the", $ef, $ee, "elemental spirit,", $fa, $f7
    db $ef, $ee, "so they tried to", $ef, $ee, "create strife", $fa, $f7
    db $ef, $ee, "among people to", $ef, $ee, "weaken the spirit.", $fa, $f7
    db $ef, $ee, "Their next target", $ef, $ee, "is Queen Helen of", $fa, $f7
    db $ef, $ee, "the kingdom in the", $ef, $ee, "east.", $fa, $f7
    db $ef, $ee, "There can be no", $ef, $ee, "one else.", $fa, $f7
    db $ef, $ee, "Please, go to her", $ef, $ee, "and help her like", $fa, $f7
    db $ef, $ee, "you have helped", $ef, $ee, "me.", $f7
    db $f0

String_96_404B_00_0E::
    db $eb, "Yuna: Their next", $f1
    db "target is Queen", $fa, $f7
    db $ef, $ee, "Helen of the", $ef, $ee, "eastern kingdom.", $fa, $f7
    db $ef, $ee, "There can be no", $ef, $ee, "one else.", $fa, $f7
    db $ef, $ee, "Please, go to her", $ef, $ee, "and help her like", $fa, $f7
    db $ef, $ee, "you have helped", $ef, $ee, "me.", $f7
    db $f0

String_96_404B_00_10::
    db $ea, "*: Lady Yuna has", $f1
    db "regained her usual", $fa, $f7
    db $ef, $ee, "exuberance and", $ef, $ee, "energy.", $f7
    db $f0

String_96_404B_00_11::
    db $ea, "*: Lady Yuna snuck", $f1
    db "out again.", $fa, $f7
    db $ef, $ee, "I'm not sure if we", $ef, $ee, "should be happy or", $fa, $f7
    db $ef, $ee, "concerned about", $ef, $ee, "it.", $f7
    db $f0

String_96_404B_00_12::
    db $ea, "*: Oh? How did you", $f1
    db "get in here?", $f7
    db $f0

String_96_404B_00_13::
    db $ea, "*: How could we", $f1
    db "ever thank you", $fa, $f7
    db $ef, $ee, "enough for saving", $ef, $ee, "Lady Yuna?", $f7
    db $f0

String_96_404B_00_14::
    db $ea, "King: Yuna is back", $f1
    db "to being herself.", $fa, $f7
    db $ef, $ee, "Perhaps she is a", $ef, $ee, "bit too energetic,", $fa, $f7
    db $ef, $ee, "but it's a cause", $ef, $ee, "for celebration!", $f7
    db $f0

String_96_404B_00_15::
    db $ea, "*: Lady Yuna is", $f1
    db "back to her cheery", $fa, $f7
    db $ef, $ee, "smiling self!", $ef, $ee, "Even the weather", $fa, $f7
    db $ef, $ee, "seems to be in a", $ef, $ee, "celebrating mood.", $f7
    db $f0

String_96_404B_00_17::
    db $f9, "0 read the", $f1
    db "sign.", $fa, $f7
    db $ef, $ee, "'Lady Yuna has", $ef, $ee, "regained her", $fa, $f7
    db $ef, $ee, "cheerful vivacity.", $ef, $ee, "The contest for", $fa, $f7
    db $ef, $ee, "cheering her up is", $ef, $ee, "now finished.", $95, $f7
    db $f0

String_96_404B_00_18::
    db $ea, "*: Lady Yuna seems", $f1
    db "to be her cheerful", $fa, $f7
    db $ef, $ee, "old self again.", $ef, $ee, "But whatever", $fa, $f7
    db $ef, $ee, "became of the", $ef, $ee, "reward?", $f7
    db $f0

String_96_404B_00_19::
    db $eb, "*: Lady Yuna tries", $f1
    db "to bolt from the", $fa, $f7
    db $ef, $ee, "Castle every day.", $ef, $ee, "That, of course,", $fa, $f7
    db $ef, $ee, "causes the King", $ef, $ee, "great anxiety.", $f7
    db $f0

String_96_404B_00_1A::
    db $ea, "*: All the people", $f1
    db "swarming to the", $fa, $f7
    db $ef, $ee, "Castle have gone", $ef, $ee, "away", $a4, $fa, $f7
    db $ef, $ee, "I wish I could've", $ef, $ee, "seen them", $a4, $fa, $f7
    db $ef, $ee, "They should have", $ef, $ee, "done shows here.", $f7
    db $f0

String_96_404B_00_1B::
    db $ea, "*: Queen Helen had", $f1
    db "been suffering", $fa, $f7
    db $ef, $ee, "from nightmares,", $ef, $ee, "and now she has", $fa, $f7
    db $ef, $ee, "fallen terribly", $ef, $ee, "ill", $a4, $fa, $f7
    db $ef, $ee, "Her life is in", $ef, $ee, "jeopardy", $a4, $f7
    db $f0

String_96_404B_00_1C::
    db $eb, "*: You can't come", $f1
    db "in here.", $fa, $f7
    db $ef, $ee, "Queen Helen's room", $ef, $ee, "is past here.", $fa, $f7
    db $ef, $ee, "She's taken sick", $ef, $ee, "from nightmares.", $fa, $f7
    db $ef, $ee, "If she could sleep", $ef, $ee, "deeply, far beyond", $fa, $f7
    db $ef, $ee, "seeing any dreams,", $ef, $ee, "she may be cured", $a4, $f7
    db $f0

String_96_404B_00_1D::
    db $ea, "*: The reception", $f1
    db "hall is past here.", $fa, $f7
    db $ef, $ee, "However, our Queen", $ef, $ee, "isn't there.", $f7
    db $f0

String_96_404B_00_1E::
    db $ea, "*: I've traveled far", $f1
    db "to study plants.", $fa, $f7
    db $ef, $ee, "SleepHerb is the", $ef, $ee, "one plant that", $fa, $f7
    db $ef, $ee, "assures a deep and", $ef, $ee, "dreamless sleep.", $fa, $f7
    db $ef, $ee, "It grows only atop", $ef, $ee, "a mountain on the", $fa, $f7
    db $ef, $ee, "east and north", $ef, $ee, "kingdom's border.", $fa, $f7
    db $ef, $ee, "It is a rare blue", $ef, $ee, "flower that grows", $fa, $f7
    db $ef, $ee, "only in extreme", $ef, $ee, "cold.", $fa, $f7
    db $ef, $ee, "Oh, the mountain", $ef, $ee, "can be reached", $fa, $f7
    db $ef, $ee, "only from the east", $ef, $ee, "side.", $fa, $f7
    db $ef, $ee, "It is far to the", $ef, $ee, "north of the", $fa, $f7
    db $ef, $ee, "eastern kingdom's", $ef, $ee, "castle.", $f7
    db $f0

String_96_404B_00_1F::
    db $f9, "0 checked the", $f1
    db "blue flower.", $fa, $f7
    db $ef, $ee, "It was the", $ef, $ee, "SleepHerb!", $fa, $f7
    db $ef, $ee, $f9, "0 obtained the", $ef, $ee, "SleepHerb.", $f7
    db $f0

String_96_404B_00_20::
    db $f9, "0 checked the", $f1
    db "blue flower.", $fa, $f7
    db $ef, $ee, "The SleepHerb", $ef, $ee, "poked out of snow.", $f7
    db $f0

String_96_404B_00_21::
    db $f9, "0 checked the", $f1
    db "blue flower.", $fa, $f7
    db $ef, $ee, "It was the", $ef, $ee, "SleepHerb!", $fa, $f7
    db $ef, $ee, "But there was no", $ef, $ee, "room for it.", $f7
    db $f0

String_96_404B_00_22::
    db $eb, "*: Pardon me?", $f1
    db "You have medicine?", $fa, $f7
    db $ef, $ee, "This flower will", $ef, $ee, "save our Queen?", $fa, $f7
    db $ef, $ee, "Please come with", $ef, $ee, "me to her room!", $f7
    db $f0

String_96_404B_00_23::
    db $eb, "*: ", $a4, $a4, $a4, $a4, $a4, $a4, $f7
    db $f0

String_96_404B_00_24::
    db "The Queen took the", $f1
    db "SleepHerb", $a4, $f7
    db $f0

String_96_404B_00_25::
    db $ea, "*: I wish you", $f1
    db "wouldn't do that", $a4, $f7
    db $f0

String_96_404B_00_26::
    db $ea, "*: Our plan called", $f1
    db "for chaos in the", $fa, $f7
    db $ef, $ee, "three kingdoms", $ef, $ee, "around the lake", $a4, $fa, $f7
    db $ef, $ee, "So I had wormed my", $ef, $ee, "way into the", $fa, $f7
    db $ef, $ee, "Queen's dreams to", $ef, $ee, "create nightmares.", $fa, $f7
    db $ef, $ee, "That drug will", $ef, $ee, "ruin my plan.", $fa, $f7
    db $ef, $ee, "You dare to defy", $ef, $ee, "me, child?", $ff, $f0

String_96_404B_00_27::
    db $ea, "*: Heh, such a show", $f1
    db "of false bravado!", $fa, $f7
    db $ef, $ee, "You will pay for", $ef, $ee, "it with your life!", $f7
    db $f0

String_96_404B_00_28::
    db $ea, "*: What? Lose to a", $f1
    db "child's monsters?", $fa, $f7
    db $ef, $ee, "So it was you who", $ef, $ee, "took the others!", $fa, $f7
    db $ef, $ee, "I must inform my", $ef, $ee, "King!", $f7
    db $f0

String_96_404B_00_29::
    db $eb, "*: Oh, my goodness!", $f1
    db "Thank you!", $fa, $f7
    db $ef, $ee, "You saved our", $ef, $ee, "Queen Helen!", $f7
    db $f0

String_96_404B_00_2B::
    db $eb, "*: That was a", $f1
    db "lovely sleep.", $fa, $f7
    db $ef, $ee, "I haven't slept so", $ef, $ee, "soundly in weeks.", $fa, $f7
    db $ef, $ee, "Oh? Who are you?", $ef, $ee, $f7
    db $f0

String_96_404B_00_2C::
    db $eb, "*: Your Highness!", $f1
    db "You're awake!", $fa, $f7
    db $ef, $ee, "This child rid you", $ef, $ee, "of the fiend that", $fa, $f7
    db $ef, $ee, "made nightmares of", $ef, $ee, "your dreams.", $f7
    db $f0

String_96_404B_00_2D::
    db $eb, "Helen: I put you", $f1
    db "through trouble", $a4, $fa, $f7
    db $ef, $ee, "Since I started", $ef, $ee, "having nightmares,", $fa, $f7
    db $ef, $ee, "I haven't awoken", $ef, $ee, "this refreshed.", $fa, $f7
    db $ef, $ee, "I am truly", $ef, $ee, "grateful.", $fa, $f7
    db $ef, $ee, "Oh! That Crest", $a4, $ef, $ee, "It's the spirit's", $a4, $fa, $f7
    db $ef, $ee, "So it was all the", $ef, $ee, "spirit's bidding", $a4, $f7
    db $f0

String_96_404B_00_2E::
    db $eb, "Helen: Thank you", $f1
    db "so much.", $fa, $f7
    db $ef, $ee, "Please thank the", $ef, $ee, "spirit for me too.", $fa, $f7
    db $ef, $ee, $a4, $a4, $a4, $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Oh? I saw a dark", $f1
    db "shadow over you", $a4, $fa, $f7
    db $ef, $ee, "But you're blessed", $ef, $ee, "by the spirit", $a4, $fa, $f7
    db $ef, $ee, "I must have just", $ef, $ee, "imagined it.", $fa, $f7
    db $ef, $ee, "Please don't think", $ef, $ee, "anything of it.", $f7
    db $f0

String_96_404B_00_30::
    db $eb, "*: Quick, give the", $f1
    db "medicine to our", $fa, $f7
    db $ef, $ee, "Queen Helen.", $ef, $ee, "Please, hurry!", $f7
    db $f0

String_96_404B_00_31::
    db $eb, "*: Queen Helen is", $f1
    db "safe for now!", $fa, $f7
    db $ef, $ee, "Please get rid of", $ef, $ee, "the monsters!", $f7
    db $f0

String_96_404B_00_32::
    db $eb, "*: You have", $f1
    db "restored peace.", $fa, $f7
    db $ef, $ee, "For this, we can", $ef, $ee, "thank the spirit.", $f7
    db $f0

String_96_404B_00_33::
    db $ea, "*: Queen Helen isn't", $f1
    db "bedridden by", $fa, $f7
    db $ef, $ee, "nightmares", $ef, $ee, "anymore.", $fa, $f7
    db $ef, $ee, "From now on, it's", $ef, $ee, "our turn to do our", $fa, $f7
    db $ef, $ee, "best for Queen", $ef, $ee, "Helen.", $f7
    db $f0

String_96_404B_00_34::
    db $ea, "*: Queen Helen has", $f1
    db "had a good dream,", $fa, $f7
    db $ef, $ee, "I've heard.", $ef, $ee, "What a change!", $f7
    db $f0

String_96_404B_00_35::
    db $ea, "*: The skies are", $f1
    db "clear, but my", $fa, $f7
    db $ef, $ee, "heart remains", $ef, $ee, "heavy and clouded", $a4, $fa, $f7
    db $ef, $ee, "When will my wife", $ef, $ee, "come home?", $f7
    db $f0

String_96_404B_00_36::
    db $ea, "*: It has been", $f1
    db "getting warmer.", $fa, $f7
    db $ef, $ee, "The lake's ice is", $ef, $ee, "starting to melt.", $f7
    db $f0

String_96_404B_00_37::
    db $eb, "*: I heard from my", $f1
    db "sister who works", $fa, $f7
    db $ef, $ee, "at the castle that", $ef, $ee, "Queen Helen had", $fa, $f7
    db $ef, $ee, "been possessed by", $ef, $ee, "a monster.", $fa, $f7
    db $ef, $ee, "That's why she was", $ef, $ee, "in a bad mood!", $f7
    db $f0

StringCategories_96_574A::
MessageStrings_Bank82_Overflow::
    dw StringList_96_574C ; id 0

; category list of StringCategories_96_574A; one pointer per wStringIndex (E-0217)
StringList_96_574C::
    dw String_96_574A_00_00 ; id 0
    dw String_96_574A_00_01 ; id 1
    dw String_96_574A_00_02 ; id 2
    dw String_96_574A_00_03 ; id 3
    dw String_96_574A_00_04 ; id 4
    dw String_96_574A_00_05 ; id 5
    dw String_96_574A_00_06 ; id 6
    dw String_96_574A_00_07 ; id 7
    dw String_96_574A_00_08 ; id 8
    dw String_96_574A_00_09 ; id 9
    dw String_96_574A_00_0A ; id 10
    dw String_96_574A_00_0B ; id 11
    dw String_96_574A_00_0C ; id 12
    dw String_96_574A_00_0D ; id 13
    dw String_96_574A_00_0E ; id 14
    dw String_96_574A_00_0F ; id 15
    dw String_96_574A_00_10 ; id 16
    dw String_96_574A_00_11 ; id 17
    dw String_96_574A_00_12 ; id 18
    dw String_96_574A_00_13 ; id 19
    dw String_96_574A_00_14 ; id 20
    dw String_96_574A_00_15 ; id 21
    dw String_96_574A_00_16 ; id 22
    dw String_96_574A_00_17 ; id 23
    dw String_96_574A_00_18 ; id 24
    dw String_96_574A_00_19 ; id 25
    dw String_96_574A_00_19 ; id 26
    dw String_96_574A_00_19 ; id 27
    dw String_96_574A_00_19 ; id 28
    dw String_96_574A_00_1D ; id 29
    dw String_96_574A_00_1E ; id 30
    dw String_96_574A_00_1F ; id 31
    dw String_96_574A_00_20 ; id 32
    dw String_96_574A_00_21 ; id 33
    dw String_96_574A_00_22 ; id 34
    dw String_96_574A_00_23 ; id 35
    dw String_96_574A_00_24 ; id 36
    dw String_96_574A_00_25 ; id 37
    dw String_96_574A_00_26 ; id 38
    dw String_96_574A_00_27 ; id 39
    dw String_96_574A_00_28 ; id 40
    dw String_96_574A_00_29 ; id 41
    dw String_96_574A_00_2A ; id 42
    dw String_96_574A_00_2B ; id 43
    dw String_96_574A_00_2C ; id 44
    dw String_96_574A_00_2D ; id 45
    dw String_96_574A_00_2E ; id 46
    dw String_96_574A_00_2F ; id 47
    dw String_96_574A_00_30 ; id 48
    dw String_96_574A_00_31 ; id 49
    dw String_96_574A_00_32 ; id 50
    dw String_96_574A_00_33 ; id 51
    dw String_96_574A_00_34 ; id 52
    dw String_96_574A_00_34 ; id 53
    dw String_96_574A_00_34 ; id 54
    dw String_96_574A_00_34 ; id 55
    dw String_96_574A_00_34 ; id 56
    dw String_96_574A_00_34 ; id 57
    dw String_96_574A_00_34 ; id 58
    dw String_96_574A_00_34 ; id 59
    dw String_96_574A_00_34 ; id 60
    dw String_96_574A_00_34 ; id 61
    dw String_96_574A_00_34 ; id 62
    dw String_96_574A_00_34 ; id 63
    dw String_96_574A_00_34 ; id 64
    dw String_96_574A_00_34 ; id 65
    dw String_96_574A_00_34 ; id 66
    dw String_96_574A_00_34 ; id 67
    dw String_96_574A_00_34 ; id 68
    dw String_96_574A_00_34 ; id 69
    dw String_96_574A_00_34 ; id 70
    dw String_96_574A_00_34 ; id 71
    dw String_96_574A_00_34 ; id 72
    dw String_96_574A_00_34 ; id 73
    dw String_96_574A_00_34 ; id 74
    dw String_96_574A_00_34 ; id 75
    dw String_96_574A_00_34 ; id 76
    dw String_96_574A_00_34 ; id 77
    dw String_96_574A_00_34 ; id 78
    dw String_96_574A_00_34 ; id 79
    dw String_96_574A_00_34 ; id 80
    dw String_96_574A_00_34 ; id 81
    dw String_96_574A_00_34 ; id 82
    dw String_96_574A_00_34 ; id 83
    dw String_96_574A_00_34 ; id 84
    dw String_96_574A_00_34 ; id 85
    dw String_96_574A_00_34 ; id 86
    dw String_96_574A_00_34 ; id 87
    dw String_96_574A_00_34 ; id 88
    dw String_96_574A_00_34 ; id 89
    dw String_96_574A_00_34 ; id 90
    dw String_96_574A_00_34 ; id 91
    dw String_96_574A_00_34 ; id 92
    dw String_96_574A_00_34 ; id 93
    dw String_96_574A_00_34 ; id 94
    dw String_96_574A_00_34 ; id 95
    dw String_96_574A_00_34 ; id 96
    dw String_96_574A_00_34 ; id 97
    dw String_96_574A_00_34 ; id 98
    dw String_96_574A_00_34 ; id 99
    dw String_96_574A_00_34 ; id 100
    dw String_96_574A_00_34 ; id 101
    dw String_96_574A_00_34 ; id 102
    dw String_96_574A_00_34 ; id 103
    dw String_96_574A_00_34 ; id 104
    dw String_96_574A_00_34 ; id 105
    dw String_96_574A_00_34 ; id 106
    dw String_96_574A_00_34 ; id 107
    dw String_96_574A_00_34 ; id 108
    dw String_96_574A_00_34 ; id 109
    dw String_96_574A_00_34 ; id 110
    dw String_96_574A_00_34 ; id 111

String_96_574A_00_00::
    db $ea, "Kameha: So you're", $f1
    db "confident, huh?", $fa, $f7
    db $ef, $ee, "Let's go down to", $ef, $ee, "the Arena!", $f7
    db $f0

String_96_574A_00_01::
    db $ea, "Kameha: What?", $f1
    db "Scared, ", $f9, "0?", $f7
    db $f0

String_96_574A_00_02::
    db $ea, "Kameha: Well, uh,", $f1
    db "luck and status", $fa, $f7
    db $ef, $ee, "and conditions and", $ef, $ee, "other factors just", $fa, $f7
    db $ef, $ee, "weren't right today", $ef, $ee, "for me to win.", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $f7
    db $f0

String_96_574A_00_03::
    db $f9, "0 received the", $f1
    db "Elf Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_04::
    db $ea, "Kameha: Well, uh,", $f1
    db "luck and status", $fa, $f7
    db $ef, $ee, "and conditions and", $ef, $ee, "other factors just", $fa, $f7
    db $ef, $ee, "weren't right today", $ef, $ee, "for me to win.", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $fa, $f7
    db $ef, $ee, $a4, "Your key ring's", $ef, $ee, "full. Later, then.", $f7
    db $f0

String_96_574A_00_05::
    db $ea, "Kameha: What?", $f1
    db "Oh, it's ", $f9, "0.", $fa, $f7
    db $ef, $ee, "Did you want", $ef, $ee, "something?", $fa, $f7
    db $ef, $ee, "Just joking, you", $ef, $ee, "came for this.", $f7
    db $f0

String_96_574A_00_06::
    db $ea, "Kameha: What?", $f1
    db "Oh, it's ", $f9, "0.", $fa, $f7
    db $ef, $ee, "Did you want", $ef, $ee, "something?", $fa, $f7
    db $ef, $ee, "Just joking, you", $ef, $ee, "came for this.", $fa, $f7
    db $ef, $ee, $a4, "Your key ring's", $ef, $ee, "full. Later, then.", $f7
    db $f0

String_96_574A_00_07::
    db $ea, "Kameha: Wahahahah!", $f1
    db "You're weak!", $fa, $f7
    db $ef, $ee, "You're a lot weaker", $ef, $ee, "than I expected!", $fa, $f7
    db $ef, $ee, "I'll take you on", $ef, $ee, "whenever you want!", $f7
    db $f0

String_96_574A_00_08::
    db $ea, "Kameha: Watch me,", $f1
    db "I'm going to train", $fa, $f7
    db $ef, $ee, "in other worlds", $ef, $ee, "and flatten you!", $fa, $f7
    db $ef, $ee, "You're my rival,", $ef, $ee, "so don't you dare", $fa, $f7
    db $ef, $ee, "lose to anyone", $ef, $ee, "else before me!", $f7
    db $f0

String_96_574A_00_09::
    db $ea, "Kameha: ", $a4, "Whew.", $f1
    db "That was special.", $fa, $f7
    db $ef, $ee, "I may have lost", $ef, $ee, "the battle, but I", $fa, $f7
    db $ef, $ee, "had you beat in", $ef, $ee, "technique.", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $f7
    db $f0

String_96_574A_00_0A::
    db $f9, "0 received the", $f1
    db "Lonely Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_0B::
    db $ea, "Kameha: ", $a4, "Whew.", $f1
    db "That was special.", $fa, $f7
    db $ef, $ee, "I may have lost", $ef, $ee, "the battle, but I", $fa, $f7
    db $ef, $ee, "had you beat in", $ef, $ee, "technique.", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $fa, $f7
    db $ef, $ee, $a4, "Your key ring's", $ef, $ee, "full. Later, then.", $f7
    db $f0

String_96_574A_00_0C::
    db $ea, "Kameha: That was a", $f1
    db "good warmup!", $fa, $f7
    db $ef, $ee, "Are you ready for", $ef, $ee, "the real thing?", $fa, $f7
    db $ef, $ee, "The last one", $ef, $ee, "standing wins!", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $f7
    db $f0

String_96_574A_00_0D::
    db $f9, "0 received the", $f1
    db "Traveler Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_0E::
    db $ea, "Kameha: That was a", $f1
    db "good warmup!", $fa, $f7
    db $ef, $ee, "Are you ready for", $ef, $ee, "the real thing?", $fa, $f7
    db $ef, $ee, "The last one", $ef, $ee, "standing wins!", $fa, $f7
    db $ef, $ee, "Oh, OK, I lost.", $ef, $ee, "It's my turn next.", $fa, $f7
    db $ef, $ee, "Here, you can have", $ef, $ee, "this.", $fa, $f7
    db $ef, $ee, $a4, "Your key ring's", $ef, $ee, "full. Later, then.", $f7
    db $f0

String_96_574A_00_0F::
    db $ea, "Kameha: Whew", $a4, $f1
    db "Close, real close.", $fa, $f7
    db $ef, $ee, "I", $44, " say our skills", $ef, $ee, "are almost equal.", $fa, $f7
    db $ef, $ee, "You don't have the", $ef, $ee, "confidence to beat", $fa, $f7
    db $ef, $ee, "me again, do you?", $ef, $ee, "I can tell.", $fa, $f7
    db $ef, $ee, "Oh, OK, a loss is", $ef, $ee, "a loss.", $fa, $f7
    db $ef, $ee, "Here's my best", $ef, $ee, "Magic Key.", $f7
    db $f0

String_96_574A_00_10::
    db $f9, "0 received the", $f1
    db "Brawn Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_11::
    db $ea, "Kameha: Whew", $a4, $f1
    db "Close, real close.", $fa, $f7
    db $ef, $ee, "I", $44, " say our skills", $ef, $ee, "are almost equal.", $fa, $f7
    db $ef, $ee, "You don't have the", $ef, $ee, "confidence to beat", $fa, $f7
    db $ef, $ee, "me again, do you?", $ef, $ee, "I can tell.", $fa, $f7
    db $ef, $ee, "Oh, OK, a loss is", $ef, $ee, "a loss.", $fa, $f7
    db $ef, $ee, "Here's my best", $ef, $ee, "Magic Key.", $fa, $f7
    db $ef, $ee, $a4, "Your key ring's", $ef, $ee, "full. Later, then.", $f7
    db $f0

String_96_574A_00_12::
    db $ea, "Kameha: Tch, right", $f1
    db "to the end I could", $fa, $f7
    db $ef, $ee, "never beat you,", $ef, $ee, $f9, "0.", $fa, $f7
    db $ef, $ee, "I don't have any", $ef, $ee, "more rare keys,", $fa, $f7
    db $ef, $ee, "but we should keep", $ef, $ee, "battling.", $fa, $f7
    db $ef, $ee, "After all, we're", $ef, $ee, "still rivals!", $f7
    db $f0

String_96_574A_00_13::
    db $ea, "Warubou: Wa-hey!", $f1
    db "I was thinking", $a4, $fa, $f7
    db $ef, $ee, "GreatLog isn't in", $ef, $ee, "danger anymore.", $fa, $f7
    db $ef, $ee, "It doesn't matter", $ef, $ee, "if I'm not here.", $fa, $f7
    db $ef, $ee, "I want to go on a", $ef, $ee, "journey, warooh!", $fa, $f7
    db $ef, $ee, "Will you take me", $ef, $ee, "with you, warooh?", $fa, $f7
    db $ef, $ee, "Oh? But there's no", $ef, $ee, "room for me", $a4, $f7
    db $f0

String_96_574A_00_14::
    db $ea, "Warubou: Wa-hey!", $f1
    db "I was thinking", $a4, $fa, $f7
    db $ef, $ee, "GreatLog isn't in", $ef, $ee, "danger anymore.", $fa, $f7
    db $ef, $ee, "It doesn't matter", $ef, $ee, "if I'm not here.", $fa, $f7
    db $ef, $ee, "I want to go on a", $ef, $ee, "journey, warooh!", $fa, $f7
    db $ef, $ee, "Will you take me", $ef, $ee, "with you, warooh?", $ff, $f0

String_96_574A_00_15::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Good, good, good!", $fa, $f7
    db $ef, $ee, "I knew I could", $ef, $ee, "count on you!", $fa, $f7
    db $ef, $ee, "Wa-hey, Petibou", $ef, $ee, "come here!", $f7
    db $f0

String_96_574A_00_16::
    db $ea, "Petibou: What?", $f1
    db "This little kid?", $fa, $f7
    db $ef, $ee, "This is really a", $ef, $ee, "monster master?", $fa, $f7
    db $ef, $ee, "But Papa said so,", $ef, $ee, "so I'll do it.", $f7
    db $f0

String_96_574A_00_17::
    db $ea, "Warubou: Wa-hey,", $f1
    db "my kid has a big", $fa, $f7
    db $ef, $ee, "mouth, but Petibou", $ef, $ee, "will be useful.", $fa, $f7
    db $ef, $ee, "I will be at the", $ef, $ee, "farm, warooh.", $f7
    db $f0

String_96_574A_00_18::
    db $ea, "Petibou: It's sort", $f1
    db "of boring guarding", $fa, $f7
    db $ef, $ee, "the Log's Navel", $ef, $ee, "like this", $a4, $fa, $f7
    db $ef, $ee, "Maybe I'll pull", $ef, $ee, "out the plug", $a4, $fa, $f7
    db $ef, $ee, "I'm joking! Tch,", $ef, $ee, "you look scary!", $f7
    db $f0

String_96_574A_00_19::
    db $ea, "*: You need to", $f1
    db "strike the right", $fa, $f7
    db $ef, $ee, "balance of skills", $ef, $ee, "and abilities.", $fa, $f7
    db $ef, $ee, "That's important", $ef, $ee, "for winning!", $f7
    db $f0

String_96_574A_00_1D::
    db $ea, "*: Humph", $a4, $f1
    db "I'm Terry.", $fa, $f7
    db $ef, $ee, "I'm a master from", $ef, $ee, "GreatTree.", $fa, $f7
    db $ef, $ee, "I", $44, " heard about", $ef, $ee, "GreatLog's heroic", $fa, $f7
    db $ef, $ee, "master, so I came", $ef, $ee, "to look.", $fa, $f7
    db $ef, $ee, "Are you that", $ef, $ee, "master?", $fa, $f7
    db $ef, $ee, "I can't tell by", $ef, $ee, "the way you look,", $fa, $f7
    db $ef, $ee, "but a battle will", $ef, $ee, "prove it.", $fa, $f7
    db $ef, $ee, "Do you feel like", $ef, $ee, "battling me?", $ff, $f0

String_96_574A_00_1E::
    db $ea, "Terry: Humph", $a4, $f1
    db "Confident, huh?", $fa, $f7
    db $ef, $ee, "I'll tell you", $ef, $ee, "right now, I'm", $fa, $f7
    db $ef, $ee, "pretty confident", $ef, $ee, "too.", $fa, $f7
    db $ef, $ee, "I'll see you in", $ef, $ee, "the ring.", $f7
    db $f0

String_96_574A_00_1F::
    db $ea, "Terry: Oh, it was", $f1
    db "someone else?", $fa, $f7
    db $ef, $ee, "So much for my", $ef, $ee, "instinct.", $fa, $f7
    db $ef, $ee, "I was looking", $ef, $ee, "forward to seeing", $fa, $f7
    db $ef, $ee, "GreatLog's savior", $ef, $ee, "in battle.", $f7
    db $f0

String_96_574A_00_20::
    db $ea, "Terry: I", $44, " heard", $f1
    db "about GreatLog's", $fa, $f7
    db $ef, $ee, "heroic master, so", $ef, $ee, "I came to look.", $fa, $f7
    db $ef, $ee, "Are you that", $ef, $ee, "master?", $fa, $f7
    db $ef, $ee, "I can't tell by", $ef, $ee, "the way you look,", $fa, $f7
    db $ef, $ee, "but a battle will", $ef, $ee, "prove it.", $fa, $f7
    db $ef, $ee, "Do you feel like", $ef, $ee, "battling me?", $ff, $f0

String_96_574A_00_21::
    db $ea, "Terry: Well, this", $f1
    db "proves that I have", $fa, $f7
    db $ef, $ee, "lots to learn", $ef, $ee, "still.", $fa, $f7
    db $ef, $ee, "I hope you'll stay", $ef, $ee, "a good rival.", $fa, $f7
    db $ef, $ee, "If it's all right", $ef, $ee, "with you, we ought", $fa, $f7
    db $ef, $ee, "to breed our", $ef, $ee, "monsters sometime.", $f7
    db $f0

String_96_574A_00_22::
    db $ea, "Terry: Humph", $a4, $f1
    db "Don't take it hard.", $fa, $f7
    db $ef, $ee, "You really weren't", $ef, $ee, "weak.", $fa, $f7
    db $ef, $ee, "I was just a bit", $ef, $ee, "better, that's all.", $f7
    db $f0

String_96_574A_00_23::
    db $ea, "Terry: I hope", $f1
    db "you'll stay a good", $fa, $f7
    db $ef, $ee, "rival of mine", $ef, $ee, "after this.", $fa, $f7
    db $ef, $ee, "If it's all right", $ef, $ee, "with you, we ought", $fa, $f7
    db $ef, $ee, "to breed our", $ef, $ee, "monsters sometime.", $f7
    db $f0

String_96_574A_00_24::
    db $ea, "*: There are still", $f1
    db "many things that I", $fa, $f7
    db $ef, $ee, "know nothing about", $ef, $ee, "in the world.", $fa, $f7
    db $ef, $ee, "That's why life is", $ef, $ee, "so exciting.", $fa, $f7
    db $ef, $ee, "I'm not calling it", $ef, $ee, "quits yet!", $f7
    db $f0

String_96_574A_00_25::
    db $f9, "0 obtained the", $f1
    db "Baffle Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_26::
    db $f9, "0 found a", $f1
    db "Magic Key.", $fa, $f7
    db $ef, $ee, "But the key ring", $ef, $ee, "is full.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Magic Key back.", $f7
    db $f0

String_96_574A_00_27::
    db $f9, "0 obtained the", $f1
    db "Soul Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_28::
    db $f9, "0 found a", $f1
    db "Magic Key.", $fa, $f7
    db $ef, $ee, "But the key ring", $ef, $ee, "is full.", $fa, $f7
    db $ef, $ee, $f9, "0 put the", $ef, $ee, "Magic Key back.", $f7
    db $f0

String_96_574A_00_29::
    db $ea, "*: GreatLog appears", $f1
    db "to have returned", $fa, $f7
    db $ef, $ee, "to normal, the way", $ef, $ee, "it once was.", $fa, $f7
    db $ef, $ee, "On second thought,", $ef, $ee, "perhaps not.", $fa, $f7
    db $ef, $ee, "It looks better", $ef, $ee, "than before!", $f7
    db $f0

String_96_574A_00_2A::
    db $eb, "*: I'm feeling", $f1
    db "invigorated too.", $fa, $f7
    db $ef, $ee, "I want to live as", $ef, $ee, "long as GreatLog!", $f7
    db $f0

String_96_574A_00_2B::
    db $ea, "*: Ah, GreatLog's", $f1
    db "savior!", $fa, $f7
    db $ef, $ee, "Are you taking a", $ef, $ee, "break from your", $fa, $f7
    db $ef, $ee, "otherworldly", $ef, $ee, "journeys?", $fa, $f7
    db $ef, $ee, "The view from here", $ef, $ee, "is said to be the", $fa, $f7
    db $ef, $ee, "best in all", $ef, $ee, "GreatLog!", $f7
    db $f0

String_96_574A_00_2C::
    db $ea, "*: The island has", $f1
    db "become more lush", $fa, $f7
    db $ef, $ee, "and green. Thank", $ef, $ee, "you, hero!", $f7
    db $f0

String_96_574A_00_2D::
    db $eb, "*: There's something", $f1
    db "wrong with Emyu", $a4, $fa, $f7
    db $ef, $ee, "It's become a bit", $ef, $ee, "too energetic.", $fa, $f7
    db $ef, $ee, "What can I do", $ef, $ee, "about it?", $f7
    db $f0

String_96_574A_00_2E::
    db $ea, "*: Hey, hey, hey!", $f1
    db "We have to hustle!", $fa, $f7
    db $ef, $ee, "We have to move to", $ef, $ee, "find a new groove!", $f7
    db $f0

String_96_574A_00_2F::
    db $ea, "*: How good of you", $f1
    db "to overcome those", $fa, $f7
    db $ef, $ee, "demanding trials,", $ef, $ee, "my little friend!", $fa, $f7
    db $ef, $ee, "You've certainly", $ef, $ee, "impressed me!", $fa, $f7
    db $ef, $ee, "Take this!", $ef, $ee, "It's a gift!", $f7
    db $f0

String_96_574A_00_30::
    db $f9, "0 obtained the", $f1
    db "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_31::
    db "But there was", $f1
    db "nothing there.", $f7
    db $f0

String_96_574A_00_32::
    db $f9, "0 received the", $f1
    db "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_96_574A_00_33::
    db $f9, "0 checked the", $f1
    db "desk.", $f7
    db $f0

String_96_574A_00_34::
    db $f0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_96_6EF7::
    script_command SCRIPT_EGG_SERVICE
Script_96_6EF8::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F06, Script_96_6F03, Script_96_6EFD
Script_96_6EFD::
    script_command SCRIPT_BREED_CLOSE
    script_message $800a ; '*: Please come see me when'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_96_6F03::
    script_jump Script_96_6FBA
Script_96_6F06::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F13, Script_96_6F0A
Script_96_6F0A::
    script_message $c006 ; '*: Um You don't have any'
    script_message $c004 ; '*: How else may I serve'
    script_jump Script_96_6EF8
Script_96_6F13::
    script_message $c002 ; '*: Which egg should I appraise?'
Script_96_6F16::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F21, Script_96_6F1A
Script_96_6F1A::
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6F21::
    script_message $c003 ; '*: It will cost 20G. It'
Script_96_6F24::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F30, Script_96_6F34, Script_96_6F29
Script_96_6F29::
    script_message $c002 ; '*: Which egg should I appraise?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6F16
Script_96_6F30::
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6F24
Script_96_6F34::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F3E, Script_96_6F38
Script_96_6F38::
    script_message $c005 ; '*: Um You don't have enough'
    script_jump Script_96_6FEF
Script_96_6F3E::
    script_message $c00b ; '*: OK, I'll evaluate this egg'
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F47, Script_96_6F4D, Script_96_6F53, Script_96_6F59
Script_96_6F47::
    script_message $c00c ; '*: It's fine. There's nothing wrong.'
    script_jump Script_96_6F5C
Script_96_6F4D::
    script_message $c00d ; '*: It's good, and growing healthy.'
    script_jump Script_96_6F5C
Script_96_6F53::
    script_message $c00e ; '*: Wow, this egg is really'
    script_jump Script_96_6F5C
Script_96_6F59::
    script_message $c00f ; '*: Oh, my! This egg is'
Script_96_6F5C::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F62, Script_96_6F68, Script_96_6F6E, Script_96_6F74
Script_96_6F62::
    script_message $c010 ; '*: Don't expect too many skills.'
    script_jump Script_96_6F77
Script_96_6F68::
    script_message $c011 ; '*: It has a fair number'
    script_jump Script_96_6F77
Script_96_6F6E::
    script_message $c012 ; '*: It inherited its parents' skills.'
    script_jump Script_96_6F77
Script_96_6F74::
    script_message $c013 ; '*: It knows a great variety'
Script_96_6F77::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F7D, Script_96_6F83, Script_96_6F89, Script_96_6F8F
Script_96_6F7D::
    script_message $c014 ; '*: Its growth may be a'
    script_jump Script_96_6F92
Script_96_6F83::
    script_message $c015 ; '*: It will grow in an'
    script_jump Script_96_6F92
Script_96_6F89::
    script_message $c016 ; '*: It will be hard to'
    script_jump Script_96_6F92
Script_96_6F8F::
    script_message $c017 ; '*: Its growth can't be faulted.'
Script_96_6F92::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F97, Script_96_6F9D, Script_96_6FA3
Script_96_6F97::
    script_message $c018 ; '*: It appears to be a'
    script_jump Script_96_6FA6
Script_96_6F9D::
    script_message $c019 ; '*: This one seems to be'
    script_jump Script_96_6FA6
Script_96_6FA3::
    script_message $c01a ; '*: I can tell this one'
Script_96_6FA6::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FAA, Script_96_6FB0
Script_96_6FAA::
    script_message $c01b ; '*: No doubt at all-it's male.'
    script_jump Script_96_6FB3
Script_96_6FB0::
    script_message $c01c ; '*: No doubt at all-it's female.'
Script_96_6FB3::
    script_command SCRIPT_EGG_SERVICE
    script_message $c01d ; '*: That's the best I could'
    script_jump Script_96_6FEF
Script_96_6FBA::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FC1, Script_96_6FBE
Script_96_6FBE::
    script_jump Script_96_6F0A
Script_96_6FC1::
    script_message $c007 ; '*: Which egg should I bless?'
Script_96_6FC4::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FCF, Script_96_6FC8
Script_96_6FC8::
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6FCF::
    script_message $c008 ; '*: It will cost 0G. Is'
Script_96_6FD2::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FDE, Script_96_6FE2, Script_96_6FD7
Script_96_6FD7::
    script_message $c007 ; '*: Which egg should I bless?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6FC4
Script_96_6FDE::
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6FD2
Script_96_6FE2::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FEC, Script_96_6FE6
Script_96_6FE6::
    script_message $c005 ; '*: Um You don't have enough'
    script_jump Script_96_6FEF
Script_96_6FEC::
    script_message $c009 ; '*: Egg, egg, toss and scramble'
Script_96_6FEF::
    script_command SCRIPT_EGG_SERVICE
    script_command SCRIPT_EGG_SERVICE
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6FF8::
    script_command SCRIPT_RENAME
    script_command SCRIPT_RENAME
    script_choice_jump Script_96_7003, Script_96_6FFD
Script_96_6FFD::
    script_command SCRIPT_RENAME_CLOSE
    script_message $8022 ; '*: Come here for renaming monsters.'
    script_command SCRIPT_RENAME_CLOSE
    script_end
Script_96_7003::
    script_message $c023 ; '*: Pick the monster to rename.'
Script_96_7006::
    script_command SCRIPT_RENAME
    script_choice_jump Script_96_700D, Script_96_700A
Script_96_700A::
    script_jump Script_96_6FFD
Script_96_700D::
    script_command SCRIPT_RENAME
    script_jump Script_96_7006

DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay::
    ld de, MessageStrings_Bank0E_Overflow
    ld a, [wStringIndex]
    sub $88
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $0E: wStringIndex -= $88, then CopyStringToBuffer with the table
; MessageStrings_Bank0E_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank0E_Overflow::
    ld de, MessageStrings_Bank0E_Overflow
    ld a, [wStringIndex]
    sub $88
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $11, $70, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_96_7036::
MessageStrings_Bank0E_Overflow::
    dw StringList_96_7038 ; id 0

; category list of StringCategories_96_7036; one pointer per wStringIndex (E-0217)
; record: string
StringList_96_7038::
    dw String_96_7036_00_00 ; id 0
    dw String_96_7036_00_01 ; id 1
    dw String_96_7036_00_02 ; id 2
    dw String_96_7036_00_03 ; id 3
    dw String_96_7036_00_04 ; id 4
    dw String_96_7036_00_05 ; id 5
    dw String_96_7036_00_05 ; id 6
    dw String_96_7036_00_05 ; id 7
    dw String_96_7036_00_05 ; id 8
    dw String_96_7036_00_05 ; id 9
    dw String_96_7036_00_05 ; id 10
    dw String_96_7036_00_0B ; id 11
    dw String_96_7036_00_0C ; id 12
    dw String_96_7036_00_0D ; id 13
    dw String_96_7036_00_0E ; id 14
    dw String_96_7036_00_0F ; id 15
    dw String_96_7036_00_10 ; id 16
    dw String_96_7036_00_11 ; id 17
    dw String_96_7036_00_12 ; id 18
    dw String_96_7036_00_13 ; id 19
    dw String_96_7036_00_14 ; id 20
    dw String_96_7036_00_15 ; id 21
    dw String_96_7036_00_15 ; id 22
    dw String_96_7036_00_15 ; id 23

String_96_7036_00_00::
    db $ea, "*: Hey, hey.", $f1
    db "Well, looky here.", $fa, $f7
    db $ef, $ee, "Something great's", $ef, $ee, "going to result.", $fa, $f7
    db $ef, $ee, "We have to let", $ef, $ee, "this pair breed.", $f0

String_96_7036_00_01::
    db $ea, "*: OK? Let's not", $f1
    db "waste any time.", $f7
    db $f0

String_96_7036_00_02::
    db $ea, "*: All right, we'll", $f1
    db "have to do this", $fa, $f7
    db $ef, $ee, "again another", $ef, $ee, "time.", $f7
    db $f0

String_96_7036_00_03::
    db $ea, "*: ", $f9, "0", $f1
    db "will be in your", $fa, $f7
    db $ef, $ee, "egg.", $fa, $f7
    db $ef, $ee, "Want to do this", $ef, $ee, "breeding?", $f0

String_96_7036_00_04::
    db $ea, "*: Its accessory is", $f1
    db "in the Vault now.", $f7
    db $f0

String_96_7036_00_05::
    db $ea, "*: Hm, that's too", $f1
    db "bad, then.", $fa, $f7
    db $ef, $ee, "It's a wasted", $ef, $ee, "opportunity", $a4, $f7
    db $f0

String_96_7036_00_0B::
    db $ea, "*: What will be my", $f1
    db "StoneMan's mate?", $f0

String_96_7036_00_0C::
    db $ea, "*: Listen, child.", $f1
    db "How would you like", $fa, $f7
    db $ef, $ee, "to breed something", $ef, $ee, "with my StoneMan?", $f0

String_96_7036_00_0D::
    db $ea, "*: Is that your", $f1
    db "choice?", $f0

String_96_7036_00_0E::
    db $ea, "*: I", $44, " rather you", $f1
    db "didn't use such a ", $fa, $f7
    db $ef, $ee, "low-level monster", $ef, $ee, "for breeding.", $f7
    db $f0

String_96_7036_00_0F::
    db $ea, "*: You mustn't be", $f1
    db "all alone.", $f7
    db $f0

String_96_7036_00_10::
    db $ea, "*: Hm? Well, well.", $f1
    db "Something a little", $fa, $f7
    db $ef, $ee, "extraordinary will", $ef, $ee, "be the result.", $fa, $f7
    db $ef, $ee, "Well, do you wish", $ef, $ee, "to proceed?", $f0

String_96_7036_00_11::
    db $ea, "*: I like that", $f1
    db "reply! Let's start.", $f7
    db $f0

String_96_7036_00_12::
    db $ea, "*: Thank you, my", $f1
    db "little friend!", $fa, $f7
    db $ef, $ee, "We'll have to do", $ef, $ee, "this again.", $f7
    db $f0

String_96_7036_00_13::
    db $ea, "*: ", $f9, "0", $f1
    db "will be your baby.", $fa, $f7
    db $ef, $ee, "Is that acceptable", $ef, $ee, "to you?", $f0

String_96_7036_00_14::
    db $ea, "*: Its accessory is", $f1
    db "in the Vault.", $f7
    db $f0

String_96_7036_00_15::
    db $f0
    ds $c18, $00
