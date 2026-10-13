; ROM bank $96: string tables
; The annotated listing of this bank is build/listing/bank96.asm.

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
    db "<VOICE2>*: You will?<LINE>"
    db "Thank you!<PROMPT>"
    db "<NEXT>Let me hide among"
    db "<NEXT>your items.<PROMPT>"
    db "<NEXT>Oh? You have no"
    db "<NEXT>room for me…<WAIT>"
    db "@"

String_96_404B_00_01::
    db "<VOICE2>*: Oh… How terribly<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I'll have to find"
    db "<NEXT>someone else who<PROMPT>"
    db "<NEXT>would be willing"
    db "<NEXT>to help me…<WAIT>"
    db "@"

String_96_404B_00_02::
    db "<VOICE2>*: I don't remember<LINE>"
    db "who I am, what I'm<PROMPT>"
    db "<NEXT>doing here, or"
    db "<NEXT>anything else…<PROMPT>"
    db "<NEXT>I just know that I"
    db "<NEXT>need help…<PROMPT>"
    db "<NEXT>Oh? Do you know"
    db "<NEXT>who I am?<PROMPT>"
    db "<NEXT>Could I get you to"
    db "<NEXT>take me back home?<CHOICE>"
    db "@"

String_96_404B_00_03::
    db "<VOICE1>*: The crowds that<LINE>"
    db "flocked to the<PROMPT>"
    db "<NEXT>castle have all"
    db "<NEXT>left.<PROMPT>"
    db "<NEXT>Not a one of them"
    db "<NEXT>raised even the<PROMPT>"
    db "<NEXT>ghost of a smile"
    db "<NEXT>from Lady Yuna…<WAIT>"
    db "@"

String_96_404B_00_04::
    db "<VOICE1>King: Yuna has<LINE>"
    db "locked herself<PROMPT>"
    db "<NEXT>away in her room…"
    db "<NEXT>Everyone failed to<PROMPT>"
    db "<NEXT>cheer her up even"
    db "<NEXT>the least bit…<WAIT>"
    db "@"

String_96_404B_00_05::
    db "<VOICE1>*: Lady Yuna locked<LINE>"
    db "herself in and<PROMPT>"
    db "<NEXT>won't respond to"
    db "<NEXT>repeated calls.<WAIT>"
    db "@"

String_96_404B_00_06::
    db "<BUF0> checked the<LINE>"
    db "marionette.<PROMPT>"
    db "<NEXT>It sagged"
    db "<NEXT>lifelessly.<WAIT>"
    db "@"

String_96_404B_00_07::
    db "<VOICE2>*: …………<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>W-where am I?<LINE>"
    db "I… I… I am…<PROMPT>"
    db "<NEXT>I'm on the verge"
    db "<NEXT>of remembering!<WAIT>"
    db "@"

String_96_404B_00_08::
    db "Yuna's soul filled<LINE>"
    db "her body.<WAIT>"
    db "@"

String_96_404B_00_09::
    db "<VOICE1>*: …… STOP…<LINE>"
    db "DON'T MEDDLE…<WAIT>"
    db "@"

String_96_404B_00_0A::
    db "<VOICE1>*: NEVER DID I<LINE>"
    db "EXPECT YUNA'S SOUL<PROMPT>"
    db "<NEXT>TO BE FOUND…"
    db "<NEXT>BUT, NO MATTER.<PROMPT>"
    db "<NEXT>YOU MUST DEFEAT ME"
    db "<NEXT>TO SAVE HER.<PROMPT>"
    db "<NEXT>DO YOU WISH TO"
    db "<NEXT>BATTLE?<CHOICE>"
    db "@"

String_96_404B_00_0B::
    db "<VOICE1>*: FOOLHARDY.<LINE>"
    db "BRAVE BUT FOOLISH.<WAIT>"
    db "@"

String_96_404B_00_0C::
    db "<VOICE1>*: H-HOW… BUT I…<LINE>"
    db "THIS ISN'T……<WAIT>"
    db "@"

String_96_404B_00_0D::
    db "<VOICE2>*: I've finally<LINE>"
    db "remembered.<PROMPT>"
    db "<NEXT>I'm Yuna, the"
    db "<NEXT>King's daughter.<PROMPT>"
    db "<NEXT>I", $44, " overheard a"
    db "<NEXT>man and monsters<PROMPT>"
    db "<NEXT>concocting a"
    db "<NEXT>criminal plan in<PROMPT>"
    db "<NEXT>the forest, but"
    db "<NEXT>they found me.<PROMPT>"
    db "<NEXT>A monster drained"
    db "<NEXT>my soul, and my<PROMPT>"
    db "<NEXT>body was put under"
    db "<NEXT>its control.<PROMPT>"
    db "<NEXT>Their plan was"
    db "<NEXT>diabolical!<PROMPT>"
    db "<NEXT>They wanted to"
    db "<NEXT>steal the Sky<PROMPT>"
    db "<NEXT>Shield from the"
    db "<NEXT>elemental spirit,<PROMPT>"
    db "<NEXT>so they tried to"
    db "<NEXT>create strife<PROMPT>"
    db "<NEXT>among people to"
    db "<NEXT>weaken the spirit.<PROMPT>"
    db "<NEXT>Their next target"
    db "<NEXT>is Queen Helen of<PROMPT>"
    db "<NEXT>the kingdom in the"
    db "<NEXT>east.<PROMPT>"
    db "<NEXT>There can be no"
    db "<NEXT>one else.<PROMPT>"
    db "<NEXT>Please, go to her"
    db "<NEXT>and help her like<PROMPT>"
    db "<NEXT>you have helped"
    db "<NEXT>me.<WAIT>"
    db "@"

String_96_404B_00_0E::
    db "<VOICE2>Yuna: Their next<LINE>"
    db "target is Queen<PROMPT>"
    db "<NEXT>Helen of the"
    db "<NEXT>eastern kingdom.<PROMPT>"
    db "<NEXT>There can be no"
    db "<NEXT>one else.<PROMPT>"
    db "<NEXT>Please, go to her"
    db "<NEXT>and help her like<PROMPT>"
    db "<NEXT>you have helped"
    db "<NEXT>me.<WAIT>"
    db "@"

String_96_404B_00_10::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "regained her usual<PROMPT>"
    db "<NEXT>exuberance and"
    db "<NEXT>energy.<WAIT>"
    db "@"

String_96_404B_00_11::
    db "<VOICE1>*: Lady Yuna snuck<LINE>"
    db "out again.<PROMPT>"
    db "<NEXT>I'm not sure if we"
    db "<NEXT>should be happy or<PROMPT>"
    db "<NEXT>concerned about"
    db "<NEXT>it.<WAIT>"
    db "@"

String_96_404B_00_12::
    db "<VOICE1>*: Oh? How did you<LINE>"
    db "get in here?<WAIT>"
    db "@"

String_96_404B_00_13::
    db "<VOICE1>*: How could we<LINE>"
    db "ever thank you<PROMPT>"
    db "<NEXT>enough for saving"
    db "<NEXT>Lady Yuna?<WAIT>"
    db "@"

String_96_404B_00_14::
    db "<VOICE1>King: Yuna is back<LINE>"
    db "to being herself.<PROMPT>"
    db "<NEXT>Perhaps she is a"
    db "<NEXT>bit too energetic,<PROMPT>"
    db "<NEXT>but it's a cause"
    db "<NEXT>for celebration!<WAIT>"
    db "@"

String_96_404B_00_15::
    db "<VOICE1>*: Lady Yuna is<LINE>"
    db "back to her cheery<PROMPT>"
    db "<NEXT>smiling self!"
    db "<NEXT>Even the weather<PROMPT>"
    db "<NEXT>seems to be in a"
    db "<NEXT>celebrating mood.<WAIT>"
    db "@"

String_96_404B_00_17::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Lady Yuna has"
    db "<NEXT>regained her<PROMPT>"
    db "<NEXT>cheerful vivacity."
    db "<NEXT>The contest for<PROMPT>"
    db "<NEXT>cheering her up is"
    db "<NEXT>now finished.", $95, "<WAIT>"
    db "@"

String_96_404B_00_18::
    db "<VOICE1>*: Lady Yuna seems<LINE>"
    db "to be her cheerful<PROMPT>"
    db "<NEXT>old self again."
    db "<NEXT>But whatever<PROMPT>"
    db "<NEXT>became of the"
    db "<NEXT>reward?<WAIT>"
    db "@"

String_96_404B_00_19::
    db "<VOICE2>*: Lady Yuna tries<LINE>"
    db "to bolt from the<PROMPT>"
    db "<NEXT>Castle every day."
    db "<NEXT>That, of course,<PROMPT>"
    db "<NEXT>causes the King"
    db "<NEXT>great anxiety.<WAIT>"
    db "@"

String_96_404B_00_1A::
    db "<VOICE1>*: All the people<LINE>"
    db "swarming to the<PROMPT>"
    db "<NEXT>Castle have gone"
    db "<NEXT>away…<PROMPT>"
    db "<NEXT>I wish I could've"
    db "<NEXT>seen them…<PROMPT>"
    db "<NEXT>They should have"
    db "<NEXT>done shows here.<WAIT>"
    db "@"

String_96_404B_00_1B::
    db "<VOICE1>*: Queen Helen had<LINE>"
    db "been suffering<PROMPT>"
    db "<NEXT>from nightmares,"
    db "<NEXT>and now she has<PROMPT>"
    db "<NEXT>fallen terribly"
    db "<NEXT>ill…<PROMPT>"
    db "<NEXT>Her life is in"
    db "<NEXT>jeopardy…<WAIT>"
    db "@"

String_96_404B_00_1C::
    db "<VOICE2>*: You can't come<LINE>"
    db "in here.<PROMPT>"
    db "<NEXT>Queen Helen's room"
    db "<NEXT>is past here.<PROMPT>"
    db "<NEXT>She's taken sick"
    db "<NEXT>from nightmares.<PROMPT>"
    db "<NEXT>If she could sleep"
    db "<NEXT>deeply, far beyond<PROMPT>"
    db "<NEXT>seeing any dreams,"
    db "<NEXT>she may be cured…<WAIT>"
    db "@"

String_96_404B_00_1D::
    db "<VOICE1>*: The reception<LINE>"
    db "hall is past here.<PROMPT>"
    db "<NEXT>However, our Queen"
    db "<NEXT>isn't there.<WAIT>"
    db "@"

String_96_404B_00_1E::
    db "<VOICE1>*: I've traveled far<LINE>"
    db "to study plants.<PROMPT>"
    db "<NEXT>SleepHerb is the"
    db "<NEXT>one plant that<PROMPT>"
    db "<NEXT>assures a deep and"
    db "<NEXT>dreamless sleep.<PROMPT>"
    db "<NEXT>It grows only atop"
    db "<NEXT>a mountain on the<PROMPT>"
    db "<NEXT>east and north"
    db "<NEXT>kingdom's border.<PROMPT>"
    db "<NEXT>It is a rare blue"
    db "<NEXT>flower that grows<PROMPT>"
    db "<NEXT>only in extreme"
    db "<NEXT>cold.<PROMPT>"
    db "<NEXT>Oh, the mountain"
    db "<NEXT>can be reached<PROMPT>"
    db "<NEXT>only from the east"
    db "<NEXT>side.<PROMPT>"
    db "<NEXT>It is far to the"
    db "<NEXT>north of the<PROMPT>"
    db "<NEXT>eastern kingdom's"
    db "<NEXT>castle.<WAIT>"
    db "@"

String_96_404B_00_1F::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>It was the"
    db "<NEXT>SleepHerb!<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>SleepHerb.<WAIT>"
    db "@"

String_96_404B_00_20::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>The SleepHerb"
    db "<NEXT>poked out of snow.<WAIT>"
    db "@"

String_96_404B_00_21::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>It was the"
    db "<NEXT>SleepHerb!<PROMPT>"
    db "<NEXT>But there was no"
    db "<NEXT>room for it.<WAIT>"
    db "@"

String_96_404B_00_22::
    db "<VOICE2>*: Pardon me?<LINE>"
    db "You have medicine?<PROMPT>"
    db "<NEXT>This flower will"
    db "<NEXT>save our Queen?<PROMPT>"
    db "<NEXT>Please come with"
    db "<NEXT>me to her room!<WAIT>"
    db "@"

String_96_404B_00_23::
    db "<VOICE2>*: ………………<WAIT>"
    db "@"

String_96_404B_00_24::
    db "The Queen took the<LINE>"
    db "SleepHerb…<WAIT>"
    db "@"

String_96_404B_00_25::
    db "<VOICE1>*: I wish you<LINE>"
    db "wouldn't do that…<WAIT>"
    db "@"

String_96_404B_00_26::
    db "<VOICE1>*: Our plan called<LINE>"
    db "for chaos in the<PROMPT>"
    db "<NEXT>three kingdoms"
    db "<NEXT>around the lake…<PROMPT>"
    db "<NEXT>So I had wormed my"
    db "<NEXT>way into the<PROMPT>"
    db "<NEXT>Queen's dreams to"
    db "<NEXT>create nightmares.<PROMPT>"
    db "<NEXT>That drug will"
    db "<NEXT>ruin my plan.<PROMPT>"
    db "<NEXT>You dare to defy"
    db "<NEXT>me, child?<CHOICE>"
    db "@"

String_96_404B_00_27::
    db "<VOICE1>*: Heh, such a show<LINE>"
    db "of false bravado!<PROMPT>"
    db "<NEXT>You will pay for"
    db "<NEXT>it with your life!<WAIT>"
    db "@"

String_96_404B_00_28::
    db "<VOICE1>*: What? Lose to a<LINE>"
    db "child's monsters?<PROMPT>"
    db "<NEXT>So it was you who"
    db "<NEXT>took the others!<PROMPT>"
    db "<NEXT>I must inform my"
    db "<NEXT>King!<WAIT>"
    db "@"

String_96_404B_00_29::
    db "<VOICE2>*: Oh, my goodness!<LINE>"
    db "Thank you!<PROMPT>"
    db "<NEXT>You saved our"
    db "<NEXT>Queen Helen!<WAIT>"
    db "@"

String_96_404B_00_2B::
    db "<VOICE2>*: That was a<LINE>"
    db "lovely sleep.<PROMPT>"
    db "<NEXT>I haven't slept so"
    db "<NEXT>soundly in weeks.<PROMPT>"
    db "<NEXT>Oh? Who are you?"
    db "<NEXT><WAIT>"
    db "@"

String_96_404B_00_2C::
    db "<VOICE2>*: Your Highness!<LINE>"
    db "You're awake!<PROMPT>"
    db "<NEXT>This child rid you"
    db "<NEXT>of the fiend that<PROMPT>"
    db "<NEXT>made nightmares of"
    db "<NEXT>your dreams.<WAIT>"
    db "@"

String_96_404B_00_2D::
    db "<VOICE2>Helen: I put you<LINE>"
    db "through trouble…<PROMPT>"
    db "<NEXT>Since I started"
    db "<NEXT>having nightmares,<PROMPT>"
    db "<NEXT>I haven't awoken"
    db "<NEXT>this refreshed.<PROMPT>"
    db "<NEXT>I am truly"
    db "<NEXT>grateful.<PROMPT>"
    db "<NEXT>Oh! That Crest…"
    db "<NEXT>It's the spirit's…<PROMPT>"
    db "<NEXT>So it was all the"
    db "<NEXT>spirit's bidding…<WAIT>"
    db "@"

String_96_404B_00_2E::
    db "<VOICE2>Helen: Thank you<LINE>"
    db "so much.<PROMPT>"
    db "<NEXT>Please thank the"
    db "<NEXT>spirit for me too.<PROMPT>"
    db "<NEXT>…………"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Oh? I saw a dark<LINE>"
    db "shadow over you…<PROMPT>"
    db "<NEXT>But you're blessed"
    db "<NEXT>by the spirit…<PROMPT>"
    db "<NEXT>I must have just"
    db "<NEXT>imagined it.<PROMPT>"
    db "<NEXT>Please don't think"
    db "<NEXT>anything of it.<WAIT>"
    db "@"

String_96_404B_00_30::
    db "<VOICE2>*: Quick, give the<LINE>"
    db "medicine to our<PROMPT>"
    db "<NEXT>Queen Helen."
    db "<NEXT>Please, hurry!<WAIT>"
    db "@"

String_96_404B_00_31::
    db "<VOICE2>*: Queen Helen is<LINE>"
    db "safe for now!<PROMPT>"
    db "<NEXT>Please get rid of"
    db "<NEXT>the monsters!<WAIT>"
    db "@"

String_96_404B_00_32::
    db "<VOICE2>*: You have<LINE>"
    db "restored peace.<PROMPT>"
    db "<NEXT>For this, we can"
    db "<NEXT>thank the spirit.<WAIT>"
    db "@"

String_96_404B_00_33::
    db "<VOICE1>*: Queen Helen isn't<LINE>"
    db "bedridden by<PROMPT>"
    db "<NEXT>nightmares"
    db "<NEXT>anymore.<PROMPT>"
    db "<NEXT>From now on, it's"
    db "<NEXT>our turn to do our<PROMPT>"
    db "<NEXT>best for Queen"
    db "<NEXT>Helen.<WAIT>"
    db "@"

String_96_404B_00_34::
    db "<VOICE1>*: Queen Helen has<LINE>"
    db "had a good dream,<PROMPT>"
    db "<NEXT>I've heard."
    db "<NEXT>What a change!<WAIT>"
    db "@"

String_96_404B_00_35::
    db "<VOICE1>*: The skies are<LINE>"
    db "clear, but my<PROMPT>"
    db "<NEXT>heart remains"
    db "<NEXT>heavy and clouded…<PROMPT>"
    db "<NEXT>When will my wife"
    db "<NEXT>come home?<WAIT>"
    db "@"

String_96_404B_00_36::
    db "<VOICE1>*: It has been<LINE>"
    db "getting warmer.<PROMPT>"
    db "<NEXT>The lake's ice is"
    db "<NEXT>starting to melt.<WAIT>"
    db "@"

String_96_404B_00_37::
    db "<VOICE2>*: I heard from my<LINE>"
    db "sister who works<PROMPT>"
    db "<NEXT>at the castle that"
    db "<NEXT>Queen Helen had<PROMPT>"
    db "<NEXT>been possessed by"
    db "<NEXT>a monster.<PROMPT>"
    db "<NEXT>That's why she was"
    db "<NEXT>in a bad mood!<WAIT>"
    db "@"

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
    db "<VOICE1>Kameha: So you're<LINE>"
    db "confident, huh?<PROMPT>"
    db "<NEXT>Let's go down to"
    db "<NEXT>the Arena!<WAIT>"
    db "@"

String_96_574A_00_01::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Scared, <BUF0>?<WAIT>"
    db "@"

String_96_574A_00_02::
    db "<VOICE1>Kameha: Well, uh,<LINE>"
    db "luck and status<PROMPT>"
    db "<NEXT>and conditions and"
    db "<NEXT>other factors just<PROMPT>"
    db "<NEXT>weren't right today"
    db "<NEXT>for me to win.<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<WAIT>"
    db "@"

String_96_574A_00_03::
    db "<BUF0> received the<LINE>"
    db "Elf Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_04::
    db "<VOICE1>Kameha: Well, uh,<LINE>"
    db "luck and status<PROMPT>"
    db "<NEXT>and conditions and"
    db "<NEXT>other factors just<PROMPT>"
    db "<NEXT>weren't right today"
    db "<NEXT>for me to win.<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

String_96_574A_00_05::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Oh, it's <BUF0>.<PROMPT>"
    db "<NEXT>Did you want"
    db "<NEXT>something?<PROMPT>"
    db "<NEXT>Just joking, you"
    db "<NEXT>came for this.<WAIT>"
    db "@"

String_96_574A_00_06::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Oh, it's <BUF0>.<PROMPT>"
    db "<NEXT>Did you want"
    db "<NEXT>something?<PROMPT>"
    db "<NEXT>Just joking, you"
    db "<NEXT>came for this.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

String_96_574A_00_07::
    db "<VOICE1>Kameha: Wahahahah!<LINE>"
    db "You're weak!<PROMPT>"
    db "<NEXT>You're a lot weaker"
    db "<NEXT>than I expected!<PROMPT>"
    db "<NEXT>I'll take you on"
    db "<NEXT>whenever you want!<WAIT>"
    db "@"

String_96_574A_00_08::
    db "<VOICE1>Kameha: Watch me,<LINE>"
    db "I'm going to train<PROMPT>"
    db "<NEXT>in other worlds"
    db "<NEXT>and flatten you!<PROMPT>"
    db "<NEXT>You're my rival,"
    db "<NEXT>so don't you dare<PROMPT>"
    db "<NEXT>lose to anyone"
    db "<NEXT>else before me!<WAIT>"
    db "@"

String_96_574A_00_09::
    db "<VOICE1>Kameha: …Whew.<LINE>"
    db "That was special.<PROMPT>"
    db "<NEXT>I may have lost"
    db "<NEXT>the battle, but I<PROMPT>"
    db "<NEXT>had you beat in"
    db "<NEXT>technique.<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<WAIT>"
    db "@"

String_96_574A_00_0A::
    db "<BUF0> received the<LINE>"
    db "Lonely Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_0B::
    db "<VOICE1>Kameha: …Whew.<LINE>"
    db "That was special.<PROMPT>"
    db "<NEXT>I may have lost"
    db "<NEXT>the battle, but I<PROMPT>"
    db "<NEXT>had you beat in"
    db "<NEXT>technique.<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

String_96_574A_00_0C::
    db "<VOICE1>Kameha: That was a<LINE>"
    db "good warmup!<PROMPT>"
    db "<NEXT>Are you ready for"
    db "<NEXT>the real thing?<PROMPT>"
    db "<NEXT>The last one"
    db "<NEXT>standing wins!<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<WAIT>"
    db "@"

String_96_574A_00_0D::
    db "<BUF0> received the<LINE>"
    db "Traveler Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_0E::
    db "<VOICE1>Kameha: That was a<LINE>"
    db "good warmup!<PROMPT>"
    db "<NEXT>Are you ready for"
    db "<NEXT>the real thing?<PROMPT>"
    db "<NEXT>The last one"
    db "<NEXT>standing wins!<PROMPT>"
    db "<NEXT>Oh, OK, I lost."
    db "<NEXT>It's my turn next.<PROMPT>"
    db "<NEXT>Here, you can have"
    db "<NEXT>this.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

String_96_574A_00_0F::
    db "<VOICE1>Kameha: Whew…<LINE>"
    db "Close, real close.<PROMPT>"
    db "<NEXT>I", $44, " say our skills"
    db "<NEXT>are almost equal.<PROMPT>"
    db "<NEXT>You don't have the"
    db "<NEXT>confidence to beat<PROMPT>"
    db "<NEXT>me again, do you?"
    db "<NEXT>I can tell.<PROMPT>"
    db "<NEXT>Oh, OK, a loss is"
    db "<NEXT>a loss.<PROMPT>"
    db "<NEXT>Here's my best"
    db "<NEXT>Magic Key.<WAIT>"
    db "@"

String_96_574A_00_10::
    db "<BUF0> received the<LINE>"
    db "Brawn Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_11::
    db "<VOICE1>Kameha: Whew…<LINE>"
    db "Close, real close.<PROMPT>"
    db "<NEXT>I", $44, " say our skills"
    db "<NEXT>are almost equal.<PROMPT>"
    db "<NEXT>You don't have the"
    db "<NEXT>confidence to beat<PROMPT>"
    db "<NEXT>me again, do you?"
    db "<NEXT>I can tell.<PROMPT>"
    db "<NEXT>Oh, OK, a loss is"
    db "<NEXT>a loss.<PROMPT>"
    db "<NEXT>Here's my best"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

String_96_574A_00_12::
    db "<VOICE1>Kameha: Tch, right<LINE>"
    db "to the end I could<PROMPT>"
    db "<NEXT>never beat you,"
    db "<NEXT><BUF0>.<PROMPT>"
    db "<NEXT>I don't have any"
    db "<NEXT>more rare keys,<PROMPT>"
    db "<NEXT>but we should keep"
    db "<NEXT>battling.<PROMPT>"
    db "<NEXT>After all, we're"
    db "<NEXT>still rivals!<WAIT>"
    db "@"

String_96_574A_00_13::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "I was thinking…<PROMPT>"
    db "<NEXT>GreatLog isn't in"
    db "<NEXT>danger anymore.<PROMPT>"
    db "<NEXT>It doesn't matter"
    db "<NEXT>if I'm not here.<PROMPT>"
    db "<NEXT>I want to go on a"
    db "<NEXT>journey, warooh!<PROMPT>"
    db "<NEXT>Will you take me"
    db "<NEXT>with you, warooh?<PROMPT>"
    db "<NEXT>Oh? But there's no"
    db "<NEXT>room for me…<WAIT>"
    db "@"

String_96_574A_00_14::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "I was thinking…<PROMPT>"
    db "<NEXT>GreatLog isn't in"
    db "<NEXT>danger anymore.<PROMPT>"
    db "<NEXT>It doesn't matter"
    db "<NEXT>if I'm not here.<PROMPT>"
    db "<NEXT>I want to go on a"
    db "<NEXT>journey, warooh!<PROMPT>"
    db "<NEXT>Will you take me"
    db "<NEXT>with you, warooh?<CHOICE>"
    db "@"

String_96_574A_00_15::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Good, good, good!<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on you!<PROMPT>"
    db "<NEXT>Wa-hey, Petibou"
    db "<NEXT>come here!<WAIT>"
    db "@"

String_96_574A_00_16::
    db "<VOICE1>Petibou: What?<LINE>"
    db "This little kid?<PROMPT>"
    db "<NEXT>This is really a"
    db "<NEXT>monster master?<PROMPT>"
    db "<NEXT>But Papa said so,"
    db "<NEXT>so I'll do it.<WAIT>"
    db "@"

String_96_574A_00_17::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "my kid has a big<PROMPT>"
    db "<NEXT>mouth, but Petibou"
    db "<NEXT>will be useful.<PROMPT>"
    db "<NEXT>I will be at the"
    db "<NEXT>farm, warooh.<WAIT>"
    db "@"

String_96_574A_00_18::
    db "<VOICE1>Petibou: It's sort<LINE>"
    db "of boring guarding<PROMPT>"
    db "<NEXT>the Log's Navel"
    db "<NEXT>like this…<PROMPT>"
    db "<NEXT>Maybe I'll pull"
    db "<NEXT>out the plug…<PROMPT>"
    db "<NEXT>I'm joking! Tch,"
    db "<NEXT>you look scary!<WAIT>"
    db "@"

String_96_574A_00_19::
    db "<VOICE1>*: You need to<LINE>"
    db "strike the right<PROMPT>"
    db "<NEXT>balance of skills"
    db "<NEXT>and abilities.<PROMPT>"
    db "<NEXT>That's important"
    db "<NEXT>for winning!<WAIT>"
    db "@"

String_96_574A_00_1D::
    db "<VOICE1>*: Humph…<LINE>"
    db "I'm Terry.<PROMPT>"
    db "<NEXT>I'm a master from"
    db "<NEXT>GreatTree.<PROMPT>"
    db "<NEXT>I", $44, " heard about"
    db "<NEXT>GreatLog's heroic<PROMPT>"
    db "<NEXT>master, so I came"
    db "<NEXT>to look.<PROMPT>"
    db "<NEXT>Are you that"
    db "<NEXT>master?<PROMPT>"
    db "<NEXT>I can't tell by"
    db "<NEXT>the way you look,<PROMPT>"
    db "<NEXT>but a battle will"
    db "<NEXT>prove it.<PROMPT>"
    db "<NEXT>Do you feel like"
    db "<NEXT>battling me?<CHOICE>"
    db "@"

String_96_574A_00_1E::
    db "<VOICE1>Terry: Humph…<LINE>"
    db "Confident, huh?<PROMPT>"
    db "<NEXT>I'll tell you"
    db "<NEXT>right now, I'm<PROMPT>"
    db "<NEXT>pretty confident"
    db "<NEXT>too.<PROMPT>"
    db "<NEXT>I'll see you in"
    db "<NEXT>the ring.<WAIT>"
    db "@"

String_96_574A_00_1F::
    db "<VOICE1>Terry: Oh, it was<LINE>"
    db "someone else?<PROMPT>"
    db "<NEXT>So much for my"
    db "<NEXT>instinct.<PROMPT>"
    db "<NEXT>I was looking"
    db "<NEXT>forward to seeing<PROMPT>"
    db "<NEXT>GreatLog's savior"
    db "<NEXT>in battle.<WAIT>"
    db "@"

String_96_574A_00_20::
    db "<VOICE1>Terry: I", $44, " heard<LINE>"
    db "about GreatLog's<PROMPT>"
    db "<NEXT>heroic master, so"
    db "<NEXT>I came to look.<PROMPT>"
    db "<NEXT>Are you that"
    db "<NEXT>master?<PROMPT>"
    db "<NEXT>I can't tell by"
    db "<NEXT>the way you look,<PROMPT>"
    db "<NEXT>but a battle will"
    db "<NEXT>prove it.<PROMPT>"
    db "<NEXT>Do you feel like"
    db "<NEXT>battling me?<CHOICE>"
    db "@"

String_96_574A_00_21::
    db "<VOICE1>Terry: Well, this<LINE>"
    db "proves that I have<PROMPT>"
    db "<NEXT>lots to learn"
    db "<NEXT>still.<PROMPT>"
    db "<NEXT>I hope you'll stay"
    db "<NEXT>a good rival.<PROMPT>"
    db "<NEXT>If it's all right"
    db "<NEXT>with you, we ought<PROMPT>"
    db "<NEXT>to breed our"
    db "<NEXT>monsters sometime.<WAIT>"
    db "@"

String_96_574A_00_22::
    db "<VOICE1>Terry: Humph…<LINE>"
    db "Don't take it hard.<PROMPT>"
    db "<NEXT>You really weren't"
    db "<NEXT>weak.<PROMPT>"
    db "<NEXT>I was just a bit"
    db "<NEXT>better, that's all.<WAIT>"
    db "@"

String_96_574A_00_23::
    db "<VOICE1>Terry: I hope<LINE>"
    db "you'll stay a good<PROMPT>"
    db "<NEXT>rival of mine"
    db "<NEXT>after this.<PROMPT>"
    db "<NEXT>If it's all right"
    db "<NEXT>with you, we ought<PROMPT>"
    db "<NEXT>to breed our"
    db "<NEXT>monsters sometime.<WAIT>"
    db "@"

String_96_574A_00_24::
    db "<VOICE1>*: There are still<LINE>"
    db "many things that I<PROMPT>"
    db "<NEXT>know nothing about"
    db "<NEXT>in the world.<PROMPT>"
    db "<NEXT>That's why life is"
    db "<NEXT>so exciting.<PROMPT>"
    db "<NEXT>I'm not calling it"
    db "<NEXT>quits yet!<WAIT>"
    db "@"

String_96_574A_00_25::
    db "<BUF0> obtained the<LINE>"
    db "Baffle Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_26::
    db "<BUF0> found a<LINE>"
    db "Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

String_96_574A_00_27::
    db "<BUF0> obtained the<LINE>"
    db "Soul Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_28::
    db "<BUF0> found a<LINE>"
    db "Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

String_96_574A_00_29::
    db "<VOICE1>*: GreatLog appears<LINE>"
    db "to have returned<PROMPT>"
    db "<NEXT>to normal, the way"
    db "<NEXT>it once was.<PROMPT>"
    db "<NEXT>On second thought,"
    db "<NEXT>perhaps not.<PROMPT>"
    db "<NEXT>It looks better"
    db "<NEXT>than before!<WAIT>"
    db "@"

String_96_574A_00_2A::
    db "<VOICE2>*: I'm feeling<LINE>"
    db "invigorated too.<PROMPT>"
    db "<NEXT>I want to live as"
    db "<NEXT>long as GreatLog!<WAIT>"
    db "@"

String_96_574A_00_2B::
    db "<VOICE1>*: Ah, GreatLog's<LINE>"
    db "savior!<PROMPT>"
    db "<NEXT>Are you taking a"
    db "<NEXT>break from your<PROMPT>"
    db "<NEXT>otherworldly"
    db "<NEXT>journeys?<PROMPT>"
    db "<NEXT>The view from here"
    db "<NEXT>is said to be the<PROMPT>"
    db "<NEXT>best in all"
    db "<NEXT>GreatLog!<WAIT>"
    db "@"

String_96_574A_00_2C::
    db "<VOICE1>*: The island has<LINE>"
    db "become more lush<PROMPT>"
    db "<NEXT>and green. Thank"
    db "<NEXT>you, hero!<WAIT>"
    db "@"

String_96_574A_00_2D::
    db "<VOICE2>*: There's something<LINE>"
    db "wrong with Emyu…<PROMPT>"
    db "<NEXT>It's become a bit"
    db "<NEXT>too energetic.<PROMPT>"
    db "<NEXT>What can I do"
    db "<NEXT>about it?<WAIT>"
    db "@"

String_96_574A_00_2E::
    db "<VOICE1>*: Hey, hey, hey!<LINE>"
    db "We have to hustle!<PROMPT>"
    db "<NEXT>We have to move to"
    db "<NEXT>find a new groove!<WAIT>"
    db "@"

String_96_574A_00_2F::
    db "<VOICE1>*: How good of you<LINE>"
    db "to overcome those<PROMPT>"
    db "<NEXT>demanding trials,"
    db "<NEXT>my little friend!<PROMPT>"
    db "<NEXT>You've certainly"
    db "<NEXT>impressed me!<PROMPT>"
    db "<NEXT>Take this!"
    db "<NEXT>It's a gift!<WAIT>"
    db "@"

String_96_574A_00_30::
    db "<BUF0> obtained the<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_31::
    db "But there was<LINE>"
    db "nothing there.<WAIT>"
    db "@"

String_96_574A_00_32::
    db "<BUF0> received the<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_96_574A_00_33::
    db "<BUF0> checked the<LINE>"
    db "desk.<WAIT>"
    db "@"

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
    script_message $c006 ; '*: Um… You don't have any'
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
    script_message $c005 ; '*: Um… You don't have enough'
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
    script_message $c005 ; '*: Um… You don't have enough'
    script_jump Script_96_6FEF
Script_96_6FEC::
    script_message $c009 ; '*: Egg, egg, toss and scramble…'
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
    db "<VOICE1>*: Hey, hey.<LINE>"
    db "Well, looky here.<PROMPT>"
    db "<NEXT>Something great's"
    db "<NEXT>going to result.<PROMPT>"
    db "<NEXT>We have to let"
    db "<NEXT>this pair breed.@"

String_96_7036_00_01::
    db "<VOICE1>*: OK? Let's not<LINE>"
    db "waste any time.<WAIT>"
    db "@"

String_96_7036_00_02::
    db "<VOICE1>*: All right, we'll<LINE>"
    db "have to do this<PROMPT>"
    db "<NEXT>again another"
    db "<NEXT>time.<WAIT>"
    db "@"

String_96_7036_00_03::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be in your<PROMPT>"
    db "<NEXT>egg.<PROMPT>"
    db "<NEXT>Want to do this"
    db "<NEXT>breeding?@"

String_96_7036_00_04::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault now.<WAIT>"
    db "@"

String_96_7036_00_05::
    db "<VOICE1>*: Hm, that's too<LINE>"
    db "bad, then.<PROMPT>"
    db "<NEXT>It's a wasted"
    db "<NEXT>opportunity…<WAIT>"
    db "@"

String_96_7036_00_0B::
    db "<VOICE1>*: What will be my<LINE>"
    db "StoneMan's mate?@"

String_96_7036_00_0C::
    db "<VOICE1>*: Listen, child.<LINE>"
    db "How would you like<PROMPT>"
    db "<NEXT>to breed something"
    db "<NEXT>with my StoneMan?@"

String_96_7036_00_0D::
    db "<VOICE1>*: Is that your<LINE>"
    db "choice?@"

String_96_7036_00_0E::
    db "<VOICE1>*: I", $44, " rather you<LINE>"
    db "didn't use such a <PROMPT>"
    db "<NEXT>low-level monster"
    db "<NEXT>for breeding.<WAIT>"
    db "@"

String_96_7036_00_0F::
    db "<VOICE1>*: You mustn't be<LINE>"
    db "all alone.<WAIT>"
    db "@"

String_96_7036_00_10::
    db "<VOICE1>*: Hm? Well, well.<LINE>"
    db "Something a little<PROMPT>"
    db "<NEXT>extraordinary will"
    db "<NEXT>be the result.<PROMPT>"
    db "<NEXT>Well, do you wish"
    db "<NEXT>to proceed?@"

String_96_7036_00_11::
    db "<VOICE1>*: I like that<LINE>"
    db "reply! Let's start.<WAIT>"
    db "@"

String_96_7036_00_12::
    db "<VOICE1>*: Thank you, my<LINE>"
    db "little friend!<PROMPT>"
    db "<NEXT>We'll have to do"
    db "<NEXT>this again.<WAIT>"
    db "@"

String_96_7036_00_13::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be your baby.<PROMPT>"
    db "<NEXT>Is that acceptable"
    db "<NEXT>to you?@"

String_96_7036_00_14::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

String_96_7036_00_15::
    db $f0
    ds $c18, $00
