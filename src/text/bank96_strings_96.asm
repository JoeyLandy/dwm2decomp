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
StringCategories_96::
; data read by BeginStringDisplay_Bank80_Overflow (1 word) (E-0347)
MessageStrings_Bank80_Overflow::
    dw StringList_Bank80_Overflow_0 ; id 0

; category list of StringCategories_96; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank80_Overflow_0::
    dw Text_YouWillThankYou ; id 0
    dw Text_OhHowTerriblyDisappointing ; id 1
    dw Text_IDontRememberWho ; id 2
    dw Text_TheCrowdsThatFlocked ; id 3
    dw Text_KingYunaHasLocked ; id 4
    dw Text_LadyYunaLockedHerself ; id 5
    dw Text_CheckedTheMarionetteIt ; id 6
    dw Text_WWhereAmI ; id 7
    dw Text_YunasSoulFilledHer ; id 8
    dw Text_STOPDONTMEDDLE ; id 9
    dw Text_NEVERDIDIEXPECT ; id 10
    dw Text_FOOLHARDYBRAVEBUTFOOLISH ; id 11
    dw Text_HHOWBUTI ; id 12
    dw Text_IveFinallyRememberedIm ; id 13
    dw Text_YunaTheirNextTarget ; id 14
    dw Text_YunaTheirNextTarget ; id 15
    dw Text_LadyYunaHasRegained ; id 16
    dw Text_LadyYunaSnuckOut ; id 17
    dw Text_OhHowDidYou ; id 18
    dw Text_HowCouldWeEver ; id 19
    dw Text_KingYunaIsBack ; id 20
    dw Text_LadyYunaIsBack ; id 21
    dw Text_LadyYunaIsBack ; id 22
    dw Text_ReadTheSignLady ; id 23
    dw Text_LadyYunaSeemsTo ; id 24
    dw Text_LadyYunaTriesTo ; id 25
    dw Text_AllThePeopleSwarming ; id 26
    dw Text_QueenHelenHadBeen ; id 27
    dw Text_YouCantComeIn ; id 28
    dw Text_TheReceptionHallIs ; id 29
    dw Text_IveTraveledFarTo ; id 30
    dw Text_CheckedTheBlueFlower ; id 31
    dw Text_CheckedTheBlueFlower_2 ; id 32
    dw Text_CheckedTheBlueFlower_3 ; id 33
    dw Text_PardonMeYouHave ; id 34
    dw Text_Wait ; id 35
    dw Text_TheQueenTookThe ; id 36
    dw Text_IWishYouWouldnt ; id 37
    dw Text_OurPlanCalledFor ; id 38
    dw Text_HehSuchAShow ; id 39
    dw Text_WhatLoseToA ; id 40
    dw Text_OhMyGoodnessThank ; id 41
    dw Text_OhMyGoodnessThank ; id 42
    dw Text_ThatWasALovely ; id 43
    dw Text_YourHighnessYoureAwake ; id 44
    dw Text_HelenIPutYou ; id 45
    dw Text_HelenThankYouSo ; id 46
    dw Text_HelenThankYouSo ; id 47
    dw Text_QuickGiveTheMedicine ; id 48
    dw Text_QueenHelenIsSafe ; id 49
    dw Text_YouHaveRestoredPeace ; id 50
    dw Text_QueenHelenIsntBedridden ; id 51
    dw Text_QueenHelenHasHad ; id 52
    dw Text_TheSkiesAreClear ; id 53
    dw Text_ItHasBeenGetting ; id 54
    dw Text_IHeardFromMy ; id 55

Text_YouWillThankYou::
    db "<VOICE2>*: You will?<LINE>"
    db "Thank you!<PROMPT>"
    db "<NEXT>Let me hide among"
    db "<NEXT>your items.<PROMPT>"
    db "<NEXT>Oh? You have no"
    db "<NEXT>room for me…<WAIT>"
    db "@"

Text_OhHowTerriblyDisappointing::
    db "<VOICE2>*: Oh… How terribly<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I'll have to find"
    db "<NEXT>someone else who<PROMPT>"
    db "<NEXT>would be willing"
    db "<NEXT>to help me…<WAIT>"
    db "@"

Text_IDontRememberWho::
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

Text_TheCrowdsThatFlocked::
    db "<VOICE1>*: The crowds that<LINE>"
    db "flocked to the<PROMPT>"
    db "<NEXT>castle have all"
    db "<NEXT>left.<PROMPT>"
    db "<NEXT>Not a one of them"
    db "<NEXT>raised even the<PROMPT>"
    db "<NEXT>ghost of a smile"
    db "<NEXT>from Lady Yuna…<WAIT>"
    db "@"

Text_KingYunaHasLocked::
    db "<VOICE1>King: Yuna has<LINE>"
    db "locked herself<PROMPT>"
    db "<NEXT>away in her room…"
    db "<NEXT>Everyone failed to<PROMPT>"
    db "<NEXT>cheer her up even"
    db "<NEXT>the least bit…<WAIT>"
    db "@"

Text_LadyYunaLockedHerself::
    db "<VOICE1>*: Lady Yuna locked<LINE>"
    db "herself in and<PROMPT>"
    db "<NEXT>won't respond to"
    db "<NEXT>repeated calls.<WAIT>"
    db "@"

Text_CheckedTheMarionetteIt::
    db "<BUF0> checked the<LINE>"
    db "marionette.<PROMPT>"
    db "<NEXT>It sagged"
    db "<NEXT>lifelessly.<WAIT>"
    db "@"

Text_WWhereAmI::
    db "<VOICE2>*: …………<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>W-where am I?<LINE>"
    db "I… I… I am…<PROMPT>"
    db "<NEXT>I'm on the verge"
    db "<NEXT>of remembering!<WAIT>"
    db "@"

Text_YunasSoulFilledHer::
    db "Yuna's soul filled<LINE>"
    db "her body.<WAIT>"
    db "@"

Text_STOPDONTMEDDLE::
    db "<VOICE1>*: …… STOP…<LINE>"
    db "DON'T MEDDLE…<WAIT>"
    db "@"

Text_NEVERDIDIEXPECT::
    db "<VOICE1>*: NEVER DID I<LINE>"
    db "EXPECT YUNA'S SOUL<PROMPT>"
    db "<NEXT>TO BE FOUND…"
    db "<NEXT>BUT, NO MATTER.<PROMPT>"
    db "<NEXT>YOU MUST DEFEAT ME"
    db "<NEXT>TO SAVE HER.<PROMPT>"
    db "<NEXT>DO YOU WISH TO"
    db "<NEXT>BATTLE?<CHOICE>"
    db "@"

Text_FOOLHARDYBRAVEBUTFOOLISH::
    db "<VOICE1>*: FOOLHARDY.<LINE>"
    db "BRAVE BUT FOOLISH.<WAIT>"
    db "@"

Text_HHOWBUTI::
    db "<VOICE1>*: H-HOW… BUT I…<LINE>"
    db "THIS ISN'T……<WAIT>"
    db "@"

Text_IveFinallyRememberedIm::
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

Text_YunaTheirNextTarget::
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

Text_LadyYunaHasRegained::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "regained her usual<PROMPT>"
    db "<NEXT>exuberance and"
    db "<NEXT>energy.<WAIT>"
    db "@"

Text_LadyYunaSnuckOut::
    db "<VOICE1>*: Lady Yuna snuck<LINE>"
    db "out again.<PROMPT>"
    db "<NEXT>I'm not sure if we"
    db "<NEXT>should be happy or<PROMPT>"
    db "<NEXT>concerned about"
    db "<NEXT>it.<WAIT>"
    db "@"

Text_OhHowDidYou::
    db "<VOICE1>*: Oh? How did you<LINE>"
    db "get in here?<WAIT>"
    db "@"

Text_HowCouldWeEver::
    db "<VOICE1>*: How could we<LINE>"
    db "ever thank you<PROMPT>"
    db "<NEXT>enough for saving"
    db "<NEXT>Lady Yuna?<WAIT>"
    db "@"

Text_KingYunaIsBack::
    db "<VOICE1>King: Yuna is back<LINE>"
    db "to being herself.<PROMPT>"
    db "<NEXT>Perhaps she is a"
    db "<NEXT>bit too energetic,<PROMPT>"
    db "<NEXT>but it's a cause"
    db "<NEXT>for celebration!<WAIT>"
    db "@"

Text_LadyYunaIsBack::
    db "<VOICE1>*: Lady Yuna is<LINE>"
    db "back to her cheery<PROMPT>"
    db "<NEXT>smiling self!"
    db "<NEXT>Even the weather<PROMPT>"
    db "<NEXT>seems to be in a"
    db "<NEXT>celebrating mood.<WAIT>"
    db "@"

Text_ReadTheSignLady::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Lady Yuna has"
    db "<NEXT>regained her<PROMPT>"
    db "<NEXT>cheerful vivacity."
    db "<NEXT>The contest for<PROMPT>"
    db "<NEXT>cheering her up is"
    db "<NEXT>now finished.", $95, "<WAIT>"
    db "@"

Text_LadyYunaSeemsTo::
    db "<VOICE1>*: Lady Yuna seems<LINE>"
    db "to be her cheerful<PROMPT>"
    db "<NEXT>old self again."
    db "<NEXT>But whatever<PROMPT>"
    db "<NEXT>became of the"
    db "<NEXT>reward?<WAIT>"
    db "@"

Text_LadyYunaTriesTo::
    db "<VOICE2>*: Lady Yuna tries<LINE>"
    db "to bolt from the<PROMPT>"
    db "<NEXT>Castle every day."
    db "<NEXT>That, of course,<PROMPT>"
    db "<NEXT>causes the King"
    db "<NEXT>great anxiety.<WAIT>"
    db "@"

Text_AllThePeopleSwarming::
    db "<VOICE1>*: All the people<LINE>"
    db "swarming to the<PROMPT>"
    db "<NEXT>Castle have gone"
    db "<NEXT>away…<PROMPT>"
    db "<NEXT>I wish I could've"
    db "<NEXT>seen them…<PROMPT>"
    db "<NEXT>They should have"
    db "<NEXT>done shows here.<WAIT>"
    db "@"

Text_QueenHelenHadBeen::
    db "<VOICE1>*: Queen Helen had<LINE>"
    db "been suffering<PROMPT>"
    db "<NEXT>from nightmares,"
    db "<NEXT>and now she has<PROMPT>"
    db "<NEXT>fallen terribly"
    db "<NEXT>ill…<PROMPT>"
    db "<NEXT>Her life is in"
    db "<NEXT>jeopardy…<WAIT>"
    db "@"

Text_YouCantComeIn::
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

Text_TheReceptionHallIs::
    db "<VOICE1>*: The reception<LINE>"
    db "hall is past here.<PROMPT>"
    db "<NEXT>However, our Queen"
    db "<NEXT>isn't there.<WAIT>"
    db "@"

Text_IveTraveledFarTo::
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

Text_CheckedTheBlueFlower::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>It was the"
    db "<NEXT>SleepHerb!<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>SleepHerb.<WAIT>"
    db "@"

Text_CheckedTheBlueFlower_2::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>The SleepHerb"
    db "<NEXT>poked out of snow.<WAIT>"
    db "@"

Text_CheckedTheBlueFlower_3::
    db "<BUF0> checked the<LINE>"
    db "blue flower.<PROMPT>"
    db "<NEXT>It was the"
    db "<NEXT>SleepHerb!<PROMPT>"
    db "<NEXT>But there was no"
    db "<NEXT>room for it.<WAIT>"
    db "@"

Text_PardonMeYouHave::
    db "<VOICE2>*: Pardon me?<LINE>"
    db "You have medicine?<PROMPT>"
    db "<NEXT>This flower will"
    db "<NEXT>save our Queen?<PROMPT>"
    db "<NEXT>Please come with"
    db "<NEXT>me to her room!<WAIT>"
    db "@"

Text_Wait::
    db "<VOICE2>*: ………………<WAIT>"
    db "@"

Text_TheQueenTookThe::
    db "The Queen took the<LINE>"
    db "SleepHerb…<WAIT>"
    db "@"

Text_IWishYouWouldnt::
    db "<VOICE1>*: I wish you<LINE>"
    db "wouldn't do that…<WAIT>"
    db "@"

Text_OurPlanCalledFor::
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

Text_HehSuchAShow::
    db "<VOICE1>*: Heh, such a show<LINE>"
    db "of false bravado!<PROMPT>"
    db "<NEXT>You will pay for"
    db "<NEXT>it with your life!<WAIT>"
    db "@"

Text_WhatLoseToA::
    db "<VOICE1>*: What? Lose to a<LINE>"
    db "child's monsters?<PROMPT>"
    db "<NEXT>So it was you who"
    db "<NEXT>took the others!<PROMPT>"
    db "<NEXT>I must inform my"
    db "<NEXT>King!<WAIT>"
    db "@"

Text_OhMyGoodnessThank::
    db "<VOICE2>*: Oh, my goodness!<LINE>"
    db "Thank you!<PROMPT>"
    db "<NEXT>You saved our"
    db "<NEXT>Queen Helen!<WAIT>"
    db "@"

Text_ThatWasALovely::
    db "<VOICE2>*: That was a<LINE>"
    db "lovely sleep.<PROMPT>"
    db "<NEXT>I haven't slept so"
    db "<NEXT>soundly in weeks.<PROMPT>"
    db "<NEXT>Oh? Who are you?"
    db "<NEXT><WAIT>"
    db "@"

Text_YourHighnessYoureAwake::
    db "<VOICE2>*: Your Highness!<LINE>"
    db "You're awake!<PROMPT>"
    db "<NEXT>This child rid you"
    db "<NEXT>of the fiend that<PROMPT>"
    db "<NEXT>made nightmares of"
    db "<NEXT>your dreams.<WAIT>"
    db "@"

Text_HelenIPutYou::
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

Text_HelenThankYouSo::
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

Text_QuickGiveTheMedicine::
    db "<VOICE2>*: Quick, give the<LINE>"
    db "medicine to our<PROMPT>"
    db "<NEXT>Queen Helen."
    db "<NEXT>Please, hurry!<WAIT>"
    db "@"

Text_QueenHelenIsSafe::
    db "<VOICE2>*: Queen Helen is<LINE>"
    db "safe for now!<PROMPT>"
    db "<NEXT>Please get rid of"
    db "<NEXT>the monsters!<WAIT>"
    db "@"

Text_YouHaveRestoredPeace::
    db "<VOICE2>*: You have<LINE>"
    db "restored peace.<PROMPT>"
    db "<NEXT>For this, we can"
    db "<NEXT>thank the spirit.<WAIT>"
    db "@"

Text_QueenHelenIsntBedridden::
    db "<VOICE1>*: Queen Helen isn't<LINE>"
    db "bedridden by<PROMPT>"
    db "<NEXT>nightmares"
    db "<NEXT>anymore.<PROMPT>"
    db "<NEXT>From now on, it's"
    db "<NEXT>our turn to do our<PROMPT>"
    db "<NEXT>best for Queen"
    db "<NEXT>Helen.<WAIT>"
    db "@"

Text_QueenHelenHasHad::
    db "<VOICE1>*: Queen Helen has<LINE>"
    db "had a good dream,<PROMPT>"
    db "<NEXT>I've heard."
    db "<NEXT>What a change!<WAIT>"
    db "@"

Text_TheSkiesAreClear::
    db "<VOICE1>*: The skies are<LINE>"
    db "clear, but my<PROMPT>"
    db "<NEXT>heart remains"
    db "<NEXT>heavy and clouded…<PROMPT>"
    db "<NEXT>When will my wife"
    db "<NEXT>come home?<WAIT>"
    db "@"

Text_ItHasBeenGetting::
    db "<VOICE1>*: It has been<LINE>"
    db "getting warmer.<PROMPT>"
    db "<NEXT>The lake's ice is"
    db "<NEXT>starting to melt.<WAIT>"
    db "@"

Text_IHeardFromMy::
    db "<VOICE2>*: I heard from my<LINE>"
    db "sister who works<PROMPT>"
    db "<NEXT>at the castle that"
    db "<NEXT>Queen Helen had<PROMPT>"
    db "<NEXT>been possessed by"
    db "<NEXT>a monster.<PROMPT>"
    db "<NEXT>That's why she was"
    db "<NEXT>in a bad mood!<WAIT>"
    db "@"

StringCategories_96_2::
MessageStrings_Bank82_Overflow::
    dw StringList_Bank82_Overflow_0 ; id 0

; category list of StringCategories_96_2; one pointer per wStringIndex (E-0217)
StringList_Bank82_Overflow_0::
    dw Text_KamehaSoYoureConfident ; id 0
    dw Text_KamehaWhatScared ; id 1
    dw Text_KamehaWellUhLuck ; id 2
    dw Text_ReceivedTheElfKey ; id 3
    dw Text_KamehaWellUhLuck_2 ; id 4
    dw Text_KamehaWhatOhIts ; id 5
    dw Text_KamehaWhatOhIts_2 ; id 6
    dw Text_KamehaWahahahahYoureWeak ; id 7
    dw Text_KamehaWatchMeIm ; id 8
    dw Text_KamehaWhewThatWas ; id 9
    dw Text_ReceivedTheLonelyKey ; id 10
    dw Text_KamehaWhewThatWas_2 ; id 11
    dw Text_KamehaThatWasA ; id 12
    dw Text_ReceivedTheTravelerKey ; id 13
    dw Text_KamehaThatWasA_2 ; id 14
    dw Text_KamehaWhewCloseReal ; id 15
    dw Text_ReceivedTheBrawnKey ; id 16
    dw Text_KamehaWhewCloseReal_2 ; id 17
    dw Text_KamehaTchRightTo ; id 18
    dw Text_WarubouWaHeyI ; id 19
    dw Text_WarubouWaHeyI_2 ; id 20
    dw Text_WarubouWaHeyGood ; id 21
    dw Text_PetibouWhatThisLittle ; id 22
    dw Text_WarubouWaHeyMy ; id 23
    dw Text_PetibouItsSortOf ; id 24
    dw Text_YouNeedToStrike ; id 25
    dw Text_YouNeedToStrike ; id 26
    dw Text_YouNeedToStrike ; id 27
    dw Text_YouNeedToStrike ; id 28
    dw Text_HumphImTerryIm ; id 29
    dw Text_TerryHumphConfidentHuh ; id 30
    dw Text_TerryOhItWas ; id 31
    dw Text_TerryIHeardAbout ; id 32
    dw Text_TerryWellThisProves ; id 33
    dw Text_TerryHumphDontTake ; id 34
    dw Text_TerryIHopeYoull ; id 35
    dw Text_ThereAreStillMany ; id 36
    dw Text_ObtainedTheBaffleKey ; id 37
    dw Text_FoundAMagicKey ; id 38
    dw Text_ObtainedTheSoulKey ; id 39
    dw Text_FoundAMagicKey_2 ; id 40
    dw Text_GreatLogAppearsToHave ; id 41
    dw Text_ImFeelingInvigoratedToo ; id 42
    dw Text_AhGreatLogsSaviorAre ; id 43
    dw Text_TheIslandHasBecome ; id 44
    dw Text_TheresSomethingWrongWith ; id 45
    dw Text_HeyHeyHeyWe ; id 46
    dw Text_HowGoodOfYou ; id 47
    dw Text_ObtainedTheMagicKey ; id 48
    dw Text_ButThereWasNothing ; id 49
    dw Text_ReceivedTheMagicKey_2 ; id 50
    dw Text_CheckedTheDesk ; id 51
    dw Text_Empty_2 ; id 52
    dw Text_Empty_2 ; id 53
    dw Text_Empty_2 ; id 54
    dw Text_Empty_2 ; id 55
    dw Text_Empty_2 ; id 56
    dw Text_Empty_2 ; id 57
    dw Text_Empty_2 ; id 58
    dw Text_Empty_2 ; id 59
    dw Text_Empty_2 ; id 60
    dw Text_Empty_2 ; id 61
    dw Text_Empty_2 ; id 62
    dw Text_Empty_2 ; id 63
    dw Text_Empty_2 ; id 64
    dw Text_Empty_2 ; id 65
    dw Text_Empty_2 ; id 66
    dw Text_Empty_2 ; id 67
    dw Text_Empty_2 ; id 68
    dw Text_Empty_2 ; id 69
    dw Text_Empty_2 ; id 70
    dw Text_Empty_2 ; id 71
    dw Text_Empty_2 ; id 72
    dw Text_Empty_2 ; id 73
    dw Text_Empty_2 ; id 74
    dw Text_Empty_2 ; id 75
    dw Text_Empty_2 ; id 76
    dw Text_Empty_2 ; id 77
    dw Text_Empty_2 ; id 78
    dw Text_Empty_2 ; id 79
    dw Text_Empty_2 ; id 80
    dw Text_Empty_2 ; id 81
    dw Text_Empty_2 ; id 82
    dw Text_Empty_2 ; id 83
    dw Text_Empty_2 ; id 84
    dw Text_Empty_2 ; id 85
    dw Text_Empty_2 ; id 86
    dw Text_Empty_2 ; id 87
    dw Text_Empty_2 ; id 88
    dw Text_Empty_2 ; id 89
    dw Text_Empty_2 ; id 90
    dw Text_Empty_2 ; id 91
    dw Text_Empty_2 ; id 92
    dw Text_Empty_2 ; id 93
    dw Text_Empty_2 ; id 94
    dw Text_Empty_2 ; id 95
    dw Text_Empty_2 ; id 96
    dw Text_Empty_2 ; id 97
    dw Text_Empty_2 ; id 98
    dw Text_Empty_2 ; id 99
    dw Text_Empty_2 ; id 100
    dw Text_Empty_2 ; id 101
    dw Text_Empty_2 ; id 102
    dw Text_Empty_2 ; id 103
    dw Text_Empty_2 ; id 104
    dw Text_Empty_2 ; id 105
    dw Text_Empty_2 ; id 106
    dw Text_Empty_2 ; id 107
    dw Text_Empty_2 ; id 108
    dw Text_Empty_2 ; id 109
    dw Text_Empty_2 ; id 110
    dw Text_Empty_2 ; id 111

Text_KamehaSoYoureConfident::
    db "<VOICE1>Kameha: So you're<LINE>"
    db "confident, huh?<PROMPT>"
    db "<NEXT>Let's go down to"
    db "<NEXT>the Arena!<WAIT>"
    db "@"

Text_KamehaWhatScared::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Scared, <BUF0>?<WAIT>"
    db "@"

Text_KamehaWellUhLuck::
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

Text_ReceivedTheElfKey::
    db "<BUF0> received the<LINE>"
    db "Elf Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_KamehaWellUhLuck_2::
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

Text_KamehaWhatOhIts::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Oh, it's <BUF0>.<PROMPT>"
    db "<NEXT>Did you want"
    db "<NEXT>something?<PROMPT>"
    db "<NEXT>Just joking, you"
    db "<NEXT>came for this.<WAIT>"
    db "@"

Text_KamehaWhatOhIts_2::
    db "<VOICE1>Kameha: What?<LINE>"
    db "Oh, it's <BUF0>.<PROMPT>"
    db "<NEXT>Did you want"
    db "<NEXT>something?<PROMPT>"
    db "<NEXT>Just joking, you"
    db "<NEXT>came for this.<PROMPT>"
    db "<NEXT>…Your key ring's"
    db "<NEXT>full. Later, then.<WAIT>"
    db "@"

Text_KamehaWahahahahYoureWeak::
    db "<VOICE1>Kameha: Wahahahah!<LINE>"
    db "You're weak!<PROMPT>"
    db "<NEXT>You're a lot weaker"
    db "<NEXT>than I expected!<PROMPT>"
    db "<NEXT>I'll take you on"
    db "<NEXT>whenever you want!<WAIT>"
    db "@"

Text_KamehaWatchMeIm::
    db "<VOICE1>Kameha: Watch me,<LINE>"
    db "I'm going to train<PROMPT>"
    db "<NEXT>in other worlds"
    db "<NEXT>and flatten you!<PROMPT>"
    db "<NEXT>You're my rival,"
    db "<NEXT>so don't you dare<PROMPT>"
    db "<NEXT>lose to anyone"
    db "<NEXT>else before me!<WAIT>"
    db "@"

Text_KamehaWhewThatWas::
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

Text_ReceivedTheLonelyKey::
    db "<BUF0> received the<LINE>"
    db "Lonely Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_KamehaWhewThatWas_2::
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

Text_KamehaThatWasA::
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

Text_ReceivedTheTravelerKey::
    db "<BUF0> received the<LINE>"
    db "Traveler Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_KamehaThatWasA_2::
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

Text_KamehaWhewCloseReal::
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

Text_ReceivedTheBrawnKey::
    db "<BUF0> received the<LINE>"
    db "Brawn Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_KamehaWhewCloseReal_2::
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

Text_KamehaTchRightTo::
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

Text_WarubouWaHeyI::
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

Text_WarubouWaHeyI_2::
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

Text_WarubouWaHeyGood::
    db "<VOICE1>Warubou: Wa-hey!<LINE>"
    db "Good, good, good!<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on you!<PROMPT>"
    db "<NEXT>Wa-hey, Petibou"
    db "<NEXT>come here!<WAIT>"
    db "@"

Text_PetibouWhatThisLittle::
    db "<VOICE1>Petibou: What?<LINE>"
    db "This little kid?<PROMPT>"
    db "<NEXT>This is really a"
    db "<NEXT>monster master?<PROMPT>"
    db "<NEXT>But Papa said so,"
    db "<NEXT>so I'll do it.<WAIT>"
    db "@"

Text_WarubouWaHeyMy::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "my kid has a big<PROMPT>"
    db "<NEXT>mouth, but Petibou"
    db "<NEXT>will be useful.<PROMPT>"
    db "<NEXT>I will be at the"
    db "<NEXT>farm, warooh.<WAIT>"
    db "@"

Text_PetibouItsSortOf::
    db "<VOICE1>Petibou: It's sort<LINE>"
    db "of boring guarding<PROMPT>"
    db "<NEXT>the Log's Navel"
    db "<NEXT>like this…<PROMPT>"
    db "<NEXT>Maybe I'll pull"
    db "<NEXT>out the plug…<PROMPT>"
    db "<NEXT>I'm joking! Tch,"
    db "<NEXT>you look scary!<WAIT>"
    db "@"

Text_YouNeedToStrike::
    db "<VOICE1>*: You need to<LINE>"
    db "strike the right<PROMPT>"
    db "<NEXT>balance of skills"
    db "<NEXT>and abilities.<PROMPT>"
    db "<NEXT>That's important"
    db "<NEXT>for winning!<WAIT>"
    db "@"

Text_HumphImTerryIm::
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

Text_TerryHumphConfidentHuh::
    db "<VOICE1>Terry: Humph…<LINE>"
    db "Confident, huh?<PROMPT>"
    db "<NEXT>I'll tell you"
    db "<NEXT>right now, I'm<PROMPT>"
    db "<NEXT>pretty confident"
    db "<NEXT>too.<PROMPT>"
    db "<NEXT>I'll see you in"
    db "<NEXT>the ring.<WAIT>"
    db "@"

Text_TerryOhItWas::
    db "<VOICE1>Terry: Oh, it was<LINE>"
    db "someone else?<PROMPT>"
    db "<NEXT>So much for my"
    db "<NEXT>instinct.<PROMPT>"
    db "<NEXT>I was looking"
    db "<NEXT>forward to seeing<PROMPT>"
    db "<NEXT>GreatLog's savior"
    db "<NEXT>in battle.<WAIT>"
    db "@"

Text_TerryIHeardAbout::
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

Text_TerryWellThisProves::
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

Text_TerryHumphDontTake::
    db "<VOICE1>Terry: Humph…<LINE>"
    db "Don't take it hard.<PROMPT>"
    db "<NEXT>You really weren't"
    db "<NEXT>weak.<PROMPT>"
    db "<NEXT>I was just a bit"
    db "<NEXT>better, that's all.<WAIT>"
    db "@"

Text_TerryIHopeYoull::
    db "<VOICE1>Terry: I hope<LINE>"
    db "you'll stay a good<PROMPT>"
    db "<NEXT>rival of mine"
    db "<NEXT>after this.<PROMPT>"
    db "<NEXT>If it's all right"
    db "<NEXT>with you, we ought<PROMPT>"
    db "<NEXT>to breed our"
    db "<NEXT>monsters sometime.<WAIT>"
    db "@"

Text_ThereAreStillMany::
    db "<VOICE1>*: There are still<LINE>"
    db "many things that I<PROMPT>"
    db "<NEXT>know nothing about"
    db "<NEXT>in the world.<PROMPT>"
    db "<NEXT>That's why life is"
    db "<NEXT>so exciting.<PROMPT>"
    db "<NEXT>I'm not calling it"
    db "<NEXT>quits yet!<WAIT>"
    db "@"

Text_ObtainedTheBaffleKey::
    db "<BUF0> obtained the<LINE>"
    db "Baffle Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_FoundAMagicKey::
    db "<BUF0> found a<LINE>"
    db "Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

Text_ObtainedTheSoulKey::
    db "<BUF0> obtained the<LINE>"
    db "Soul Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_FoundAMagicKey_2::
    db "<BUF0> found a<LINE>"
    db "Magic Key.<PROMPT>"
    db "<NEXT>But the key ring"
    db "<NEXT>is full.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Magic Key back.<WAIT>"
    db "@"

Text_GreatLogAppearsToHave::
    db "<VOICE1>*: GreatLog appears<LINE>"
    db "to have returned<PROMPT>"
    db "<NEXT>to normal, the way"
    db "<NEXT>it once was.<PROMPT>"
    db "<NEXT>On second thought,"
    db "<NEXT>perhaps not.<PROMPT>"
    db "<NEXT>It looks better"
    db "<NEXT>than before!<WAIT>"
    db "@"

Text_ImFeelingInvigoratedToo::
    db "<VOICE2>*: I'm feeling<LINE>"
    db "invigorated too.<PROMPT>"
    db "<NEXT>I want to live as"
    db "<NEXT>long as GreatLog!<WAIT>"
    db "@"

Text_AhGreatLogsSaviorAre::
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

Text_TheIslandHasBecome::
    db "<VOICE1>*: The island has<LINE>"
    db "become more lush<PROMPT>"
    db "<NEXT>and green. Thank"
    db "<NEXT>you, hero!<WAIT>"
    db "@"

Text_TheresSomethingWrongWith::
    db "<VOICE2>*: There's something<LINE>"
    db "wrong with Emyu…<PROMPT>"
    db "<NEXT>It's become a bit"
    db "<NEXT>too energetic.<PROMPT>"
    db "<NEXT>What can I do"
    db "<NEXT>about it?<WAIT>"
    db "@"

Text_HeyHeyHeyWe::
    db "<VOICE1>*: Hey, hey, hey!<LINE>"
    db "We have to hustle!<PROMPT>"
    db "<NEXT>We have to move to"
    db "<NEXT>find a new groove!<WAIT>"
    db "@"

Text_HowGoodOfYou::
    db "<VOICE1>*: How good of you<LINE>"
    db "to overcome those<PROMPT>"
    db "<NEXT>demanding trials,"
    db "<NEXT>my little friend!<PROMPT>"
    db "<NEXT>You've certainly"
    db "<NEXT>impressed me!<PROMPT>"
    db "<NEXT>Take this!"
    db "<NEXT>It's a gift!<WAIT>"
    db "@"

Text_ObtainedTheMagicKey::
    db "<BUF0> obtained the<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_ButThereWasNothing::
    db "But there was<LINE>"
    db "nothing there.<WAIT>"
    db "@"

Text_ReceivedTheMagicKey_2::
    db "<BUF0> received the<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_CheckedTheDesk::
    db "<BUF0> checked the<LINE>"
    db "desk.<WAIT>"
    db "@"

Text_Empty_2::
    db $f0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_EggService::
    script_command SCRIPT_EGG_SERVICE
Script_EggService_2::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_EggService_3, Script_ToEggService_12, Script_PleaseComeSeeMe
Script_PleaseComeSeeMe::
    script_command SCRIPT_BREED_CLOSE
    script_message $800a ; '*: Please come see me when'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_ToEggService_12::
    script_jump Script_EggService_12
Script_EggService_3::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_WhichEggShouldI_3, Script_UmYouDon
Script_UmYouDon::
    script_message $c006 ; '*: Um… You don't have any'
    script_message $c004 ; '*: How else may I serve'
    script_jump Script_EggService_2
Script_WhichEggShouldI_3::
    script_message $c002 ; '*: Which egg should I appraise?'
Script_EggService_4::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_ItWillCost2Hero, Script_HowElseMayI
Script_HowElseMayI::
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_2
Script_ItWillCost2Hero::
    script_message $c003 ; '*: It will cost 20G. It'
Script_EggService_5::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_EggService_6, Script_EggService_7, Script_WhichEggShouldI_4
Script_WhichEggShouldI_4::
    script_message $c002 ; '*: Which egg should I appraise?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_4
Script_EggService_6::
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_5
Script_EggService_7::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_OKI_3, Script_UmYouDon_2
Script_UmYouDon_2::
    script_message $c005 ; '*: Um… You don't have enough'
    script_jump Script_HowElseMayI_3
Script_OKI_3::
    script_message $c00b ; '*: OK, I'll evaluate this egg'
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_It_4, Script_It_5, Script_WowThisEggIs, Script_OhMyThisEgg
Script_It_4::
    script_message $c00c ; '*: It's fine. There's nothing wrong.'
    script_jump Script_EggService_8
Script_It_5::
    script_message $c00d ; '*: It's good, and growing healthy.'
    script_jump Script_EggService_8
Script_WowThisEggIs::
    script_message $c00e ; '*: Wow, this egg is really'
    script_jump Script_EggService_8
Script_OhMyThisEgg::
    script_message $c00f ; '*: Oh, my! This egg is'
Script_EggService_8::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_Don_2, Script_ItHasAFair, Script_ItInheritedItsParents, Script_ItKnowsAGreat
Script_Don_2::
    script_message $c010 ; '*: Don't expect too many skills.'
    script_jump Script_EggService_9
Script_ItHasAFair::
    script_message $c011 ; '*: It has a fair number'
    script_jump Script_EggService_9
Script_ItInheritedItsParents::
    script_message $c012 ; '*: It inherited its parents' skills.'
    script_jump Script_EggService_9
Script_ItKnowsAGreat::
    script_message $c013 ; '*: It knows a great variety'
Script_EggService_9::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_ItsGrowthMayBe, Script_ItWillGrowIn, Script_ItWillBeHard, Script_ItsGrowthCan
Script_ItsGrowthMayBe::
    script_message $c014 ; '*: Its growth may be a'
    script_jump Script_EggService_10
Script_ItWillGrowIn::
    script_message $c015 ; '*: It will grow in an'
    script_jump Script_EggService_10
Script_ItWillBeHard::
    script_message $c016 ; '*: It will be hard to'
    script_jump Script_EggService_10
Script_ItsGrowthCan::
    script_message $c017 ; '*: Its growth can't be faulted.'
Script_EggService_10::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_ItAppearsToBe, Script_ThisOneSeemsTo, Script_ICanTellThis
Script_ItAppearsToBe::
    script_message $c018 ; '*: It appears to be a'
    script_jump Script_EggService_11
Script_ThisOneSeemsTo::
    script_message $c019 ; '*: This one seems to be'
    script_jump Script_EggService_11
Script_ICanTellThis::
    script_message $c01a ; '*: I can tell this one'
Script_EggService_11::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_NoDoubtAtAll, Script_NoDoubtAtAll_2
Script_NoDoubtAtAll::
    script_message $c01b ; '*: No doubt at all-it's male.'
    script_jump Script_That_4
Script_NoDoubtAtAll_2::
    script_message $c01c ; '*: No doubt at all-it's female.'
Script_That_4::
    script_command SCRIPT_EGG_SERVICE
    script_message $c01d ; '*: That's the best I could'
    script_jump Script_HowElseMayI_3
Script_EggService_12::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_WhichEggShouldI_5, Script_ToUmYouDon
Script_ToUmYouDon::
    script_jump Script_UmYouDon
Script_WhichEggShouldI_5::
    script_message $c007 ; '*: Which egg should I bless?'
Script_EggService_13::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_ItWillCostHero, Script_HowElseMayI_2
Script_HowElseMayI_2::
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_2
Script_ItWillCostHero::
    script_message $c008 ; '*: It will cost 0G. Is'
Script_EggService_14::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_EggService_15, Script_EggService_16, Script_WhichEggShouldI_6
Script_WhichEggShouldI_6::
    script_message $c007 ; '*: Which egg should I bless?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_13
Script_EggService_15::
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_14
Script_EggService_16::
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_EggEggTossAnd, Script_UmYouDon_3
Script_UmYouDon_3::
    script_message $c005 ; '*: Um… You don't have enough'
    script_jump Script_HowElseMayI_3
Script_EggEggTossAnd::
    script_message $c009 ; '*: Egg, egg, toss and scramble…'
Script_HowElseMayI_3::
    script_command SCRIPT_EGG_SERVICE
    script_command SCRIPT_EGG_SERVICE
    script_message $c004 ; '*: How else may I serve'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_EggService_2
Script_Rename::
    script_command SCRIPT_RENAME
    script_command SCRIPT_RENAME
    script_choice_jump Script_PickTheMonsterTo, Script_ComeHereForRenaming
Script_ComeHereForRenaming::
    script_command SCRIPT_RENAME_CLOSE
    script_message $8022 ; '*: Come here for renaming monsters.'
    script_command SCRIPT_RENAME_CLOSE
    script_end
Script_PickTheMonsterTo::
    script_message $c023 ; '*: Pick the monster to rename.'
Script_Rename_2::
    script_command SCRIPT_RENAME
    script_choice_jump Script_Rename_3, Script_ToComeHereForRenaming
Script_ToComeHereForRenaming::
    script_jump Script_ComeHereForRenaming
Script_Rename_3::
    script_command SCRIPT_RENAME
    script_jump Script_Rename_2

; Sets wStringIndex; calls BeginStringDisplay (E-0347)
DebugMessageTest_Update_BeginStringDisplay_2::
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
StringCategories_96_3::
; data read by DebugMessageTest_Update_BeginStringDisplay_2 (1 word) (E-0347)
MessageStrings_Bank0E_Overflow::
    dw StringList_Bank0E_Overflow_0 ; id 0

; category list of StringCategories_96_3; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank0E_Overflow_0::
    dw Text_HeyHeyWellLooky ; id 0
    dw Text_OKLetsNotWaste ; id 1
    dw Text_AllRightWellHave ; id 2
    dw Text_WillBeInYour ; id 3
    dw Text_ItsAccessoryIsIn ; id 4
    dw Text_HmThatsTooBad ; id 5
    dw Text_HmThatsTooBad ; id 6
    dw Text_HmThatsTooBad ; id 7
    dw Text_HmThatsTooBad ; id 8
    dw Text_HmThatsTooBad ; id 9
    dw Text_HmThatsTooBad ; id 10
    dw Text_WhatWillBeMy ; id 11
    dw Text_ListenChildHowWould ; id 12
    dw Text_IsThatYourChoice ; id 13
    dw Text_IRatherYouDidnt ; id 14
    dw Text_YouMustntBeAll ; id 15
    dw Text_HmWellWellSomething ; id 16
    dw Text_ILikeThatReply ; id 17
    dw Text_ThankYouMyLittle ; id 18
    dw Text_WillBeYourBaby ; id 19
    dw Text_ItsAccessoryIsIn_2 ; id 20
    dw Text_Empty_3 ; id 21
    dw Text_Empty_3 ; id 22
    dw Text_Empty_3 ; id 23

Text_HeyHeyWellLooky::
    db "<VOICE1>*: Hey, hey.<LINE>"
    db "Well, looky here.<PROMPT>"
    db "<NEXT>Something great's"
    db "<NEXT>going to result.<PROMPT>"
    db "<NEXT>We have to let"
    db "<NEXT>this pair breed.@"

Text_OKLetsNotWaste::
    db "<VOICE1>*: OK? Let's not<LINE>"
    db "waste any time.<WAIT>"
    db "@"

Text_AllRightWellHave::
    db "<VOICE1>*: All right, we'll<LINE>"
    db "have to do this<PROMPT>"
    db "<NEXT>again another"
    db "<NEXT>time.<WAIT>"
    db "@"

Text_WillBeInYour::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be in your<PROMPT>"
    db "<NEXT>egg.<PROMPT>"
    db "<NEXT>Want to do this"
    db "<NEXT>breeding?@"

Text_ItsAccessoryIsIn::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault now.<WAIT>"
    db "@"

Text_HmThatsTooBad::
    db "<VOICE1>*: Hm, that's too<LINE>"
    db "bad, then.<PROMPT>"
    db "<NEXT>It's a wasted"
    db "<NEXT>opportunity…<WAIT>"
    db "@"

Text_WhatWillBeMy::
    db "<VOICE1>*: What will be my<LINE>"
    db "StoneMan's mate?@"

Text_ListenChildHowWould::
    db "<VOICE1>*: Listen, child.<LINE>"
    db "How would you like<PROMPT>"
    db "<NEXT>to breed something"
    db "<NEXT>with my StoneMan?@"

Text_IsThatYourChoice::
    db "<VOICE1>*: Is that your<LINE>"
    db "choice?@"

Text_IRatherYouDidnt::
    db "<VOICE1>*: I", $44, " rather you<LINE>"
    db "didn't use such a <PROMPT>"
    db "<NEXT>low-level monster"
    db "<NEXT>for breeding.<WAIT>"
    db "@"

Text_YouMustntBeAll::
    db "<VOICE1>*: You mustn't be<LINE>"
    db "all alone.<WAIT>"
    db "@"

Text_HmWellWellSomething::
    db "<VOICE1>*: Hm? Well, well.<LINE>"
    db "Something a little<PROMPT>"
    db "<NEXT>extraordinary will"
    db "<NEXT>be the result.<PROMPT>"
    db "<NEXT>Well, do you wish"
    db "<NEXT>to proceed?@"

Text_ILikeThatReply::
    db "<VOICE1>*: I like that<LINE>"
    db "reply! Let's start.<WAIT>"
    db "@"

Text_ThankYouMyLittle::
    db "<VOICE1>*: Thank you, my<LINE>"
    db "little friend!<PROMPT>"
    db "<NEXT>We'll have to do"
    db "<NEXT>this again.<WAIT>"
    db "@"

Text_WillBeYourBaby::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will be your baby.<PROMPT>"
    db "<NEXT>Is that acceptable"
    db "<NEXT>to you?@"

Text_ItsAccessoryIsIn_2::
    db "<VOICE1>*: Its accessory is<LINE>"
    db "in the Vault.<WAIT>"
    db "@"

Text_Empty_3::
    db $f0
    ds $c18, $00
