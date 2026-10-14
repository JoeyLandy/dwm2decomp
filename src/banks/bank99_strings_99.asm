; ROM bank $99: string tables
; The annotated listing of this bank is build/listing/bank99.asm.

SECTION "Bank 99", ROMX[$4000], BANK[$99]
    db $99

; overflow for message bank $2D: wStringIndex -= $D5, then BeginStringDisplay with the table
; MessageStrings_Bank2D_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2D_Overflow::
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub $d5
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2D: wStringIndex -= $D5, then CopyStringToBuffer with the table
; MessageStrings_Bank2D_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2D_Overflow::
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub $d5
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; overflow for message bank $2E: wStringIndex -= $A6, then BeginStringDisplay with the table
; MessageStrings_Bank2E_Overflow in this bank (E-0080)
BeginStringDisplay_Bank2E_Overflow::
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub $a6
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2E: wStringIndex -= $A6, then CopyStringToBuffer with the table
; MessageStrings_Bank2E_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank2E_Overflow::
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub $a6
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $26, $40, $cd, $11, $26, $c9

; overflow for message bank $7C: wStringIndex -= $87, then BeginStringDisplay with the table
; MessageStrings_Bank7C_Overflow in this bank (E-0080)
BeginStringDisplay_Bank7C_Overflow::
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub $87
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $7C: wStringIndex -= $87, then CopyStringToBuffer with the table
; MessageStrings_Bank7C_Overflow in this bank (E-0080)
CopyStringToBuffer_Bank7C_Overflow::
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub $87
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $cd, $4b, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_99::
MessageStrings_Bank2D_Overflow::
    dw StringList_Bank2D_Overflow_0 ; id 0

; category list of StringCategories_99; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2D_Overflow_0::
    dw Text_MakeSureYouTell ; id 0
    dw Text_ImAsPlainAs ; id 1
    dw Text_IsntTheWeatherFabulous ; id 2
    dw Text_DontBeSoObstinate ; id 3
    dw Text_MasterPleaseConsiderSaving ; id 4
    dw Text_IPlanToLeave ; id 5
    dw Text_MeatMeatGiveMe ; id 6
    dw Text_KnowYourEnemyKnow ; id 7
    dw Text_UseAMateAs ; id 8
    dw Text_EnemiesDeserveNoMercy ; id 9
    dw Text_IUmShySorry ; id 10
    dw Text_ForMyPartnersAnd ; id 11
    dw Text_OhNoMustI ; id 12
    dw Text_IllCleanWashWhatever ; id 13
    dw Text_WellIsSeemsTo ; id 14
    dw Text_IsThereAnyWay ; id 15
    dw Text_TheDarkFireThat ; id 16
    dw Text_SeeingYourJoyAdds ; id 17
    dw Text_IWillTakeCare ; id 18
    dw Text_WorldDominationIsThe ; id 19
    dw Text_HoweverDireTheSituation ; id 20
    dw Text_HumanYouBeGrateful ; id 21
    dw Text_EvenOnceIWould ; id 22
    dw Text_FufufuPerhapsWeWill ; id 23
    dw Text_ForYouMasterI ; id 24
    dw Text_ExcitementTensionTheyAre ; id 25
    dw Text_PeopleAndMonstersShould ; id 26
    dw Text_GiveMeTheChance ; id 27
    dw Text_IAmTheLord ; id 28
    dw Text_AreThereNoUnbreakable ; id 29
    dw Text_DontBotherMeLeave ; id 30
    dw Text_LetMeConquerA ; id 31
    dw Text_ToBeConqueredBy ; id 32
    dw Text_TheWorldIsMine ; id 33
    dw Text_EverythingIsAccordingTo ; id 34
    dw Text_YouCanBeThe ; id 35
    dw Text_TheFeelingsOfHatred ; id 36
    dw Text_TravelingIsFineBut ; id 37
    dw Text_AllMyPowerI ; id 38
    dw Text_ThePPowerOf ; id 39
    dw Text_IfYouWouldAllow ; id 40
    dw Text_LifeIsntBadTake ; id 41
    dw Text_ICantBeBothered ; id 42

Text_MakeSureYouTell::
    db "<VOICE1>*: Make sure you<LINE>"
    db "tell the others <PROMPT>"
    db "<NEXT>that I'm No. 1,"
    db "<NEXT>do you understand?<WAIT>"
    db "@"

Text_ImAsPlainAs::
    db "<VOICE1>*: I'm as plain as<LINE>"
    db "a baked potato.<PROMPT>"
    db "<NEXT>Even what I say is"
    db "<NEXT>bland.<WAIT>"
    db "@"

Text_IsntTheWeatherFabulous::
    db "<VOICE1>*: Isn't the weather<LINE>"
    db "fabulous?<PROMPT>"
    db "<NEXT>We need to be out"
    db "<NEXT>traveling!<WAIT>"
    db "@"

Text_DontBeSoObstinate::
    db "<VOICE1>*: Don't be so<LINE>"
    db "obstinate?<PROMPT>"
    db "<NEXT>But I'm not!"
    db "<NEXT>Huh? I'm acting it?<WAIT>"
    db "@"

Text_MasterPleaseConsiderSaving::
    db "<VOICE1>*: Master, please<LINE>"
    db "consider saving<PROMPT>"
    db "<NEXT>your money, and"
    db "<NEXT>not wasting it.<WAIT>"
    db "@"

Text_IPlanToLeave::
    db "<VOICE1>*: I plan to leave<LINE>"
    db "as I see fit.<PROMPT>"
    db "<NEXT>Leave me alone,"
    db "<NEXT>please.<WAIT>"
    db "@"

Text_MeatMeatGiveMe::
    db "<VOICE1>*: Meat, meat, give<LINE>"
    db "me meat!<PROMPT>"
    db "<NEXT>Or I won't work"
    db "<NEXT>for you. Meat!<WAIT>"
    db "@"

Text_KnowYourEnemyKnow::
    db "<VOICE1>*: Know your enemy,<LINE>"
    db "know yourself,<PROMPT>"
    db "<NEXT>and you will win"
    db "<NEXT>without danger.<WAIT>"
    db "@"

Text_UseAMateAs::
    db "<VOICE1>*: Use a mate as a<LINE>"
    db "shield, escape…<PROMPT>"
    db "<NEXT>Whoops, uh… nah,"
    db "<NEXT>nothing…<WAIT>"
    db "@"

Text_EnemiesDeserveNoMercy::
    db "<VOICE1>*: Enemies deserve<LINE>"
    db "no mercy!<PROMPT>"
    db "<NEXT>Crush them with"
    db "<NEXT>all our might!<WAIT>"
    db "@"

Text_IUmShySorry::
    db "<VOICE1>*: I… Um… Shy…<LINE>"
    db "Sorry… I'm sorry…<WAIT>"
    db "@"

Text_ForMyPartnersAnd::
    db "<VOICE1>*: For my partners,<LINE>"
    db "and most of all<PROMPT>"
    db "<NEXT>for you, master,"
    db "<NEXT>I'll do my best!<WAIT>"
    db "@"

Text_OhNoMustI::
    db "<VOICE1>*: Oh, no…<LINE>"
    db "Must I go?<PROMPT>"
    db "<NEXT>Caves and dark"
    db "<NEXT>places are scary…<WAIT>"
    db "@"

Text_IllCleanWashWhatever::
    db "<VOICE1>*: I'll clean, wash,<LINE>"
    db "whatever you wish!<PROMPT>"
    db "<NEXT>Just give me the"
    db "<NEXT>word!<WAIT>"
    db "@"

Text_WellIsSeemsTo::
    db "<VOICE1>*: Well, is seems<LINE>"
    db "to me, the world<PROMPT>"
    db "<NEXT>at large is pretty"
    db "<NEXT>peaceful, ayup!<WAIT>"
    db "@"

Text_IsThereAnyWay::
    db "<VOICE1>*: Is there any way<LINE>"
    db "of fighting while<PROMPT>"
    db "<NEXT>you're asleep?"
    db "<NEXT>How ideal!<WAIT>"
    db "@"

Text_TheDarkFireThat::
    db "<VOICE1>*: The dark fire<LINE>"
    db "that spirals in my<PROMPT>"
    db "<NEXT>heart shall never"
    db "<NEXT>be extinguished!<WAIT>"
    db "@"

Text_SeeingYourJoyAdds::
    db "<VOICE1>*: Seeing your joy<LINE>"
    db "adds to my own.<WAIT>"
    db "@"

Text_IWillTakeCare::
    db "<VOICE1>*: I will take care<LINE>"
    db "of you totally!<WAIT>"
    db "@"

Text_WorldDominationIsThe::
    db "<VOICE1>*: World domination<LINE>"
    db "is the ultimate<PROMPT>"
    db "<NEXT>goal in my life!"
    db "<NEXT><WAIT>"
    db "@"

Text_HoweverDireTheSituation::
    db "<VOICE1>*: However dire the<LINE>"
    db "situation, I will<PROMPT>"
    db "<NEXT>always shield you"
    db "<NEXT>from danger.<WAIT>"
    db "@"

Text_HumanYouBeGrateful::
    db "<VOICE1>*: Human! You be<LINE>"
    db "grateful that I<PROMPT>"
    db "<NEXT>have even chosen"
    db "<NEXT>to accompany you!<WAIT>"
    db "@"

Text_EvenOnceIWould::
    db "<VOICE1>*: Even once, I<LINE>"
    db "would have liked<PROMPT>"
    db "<NEXT>to have been a"
    db "<NEXT>hero…<WAIT>"
    db "@"

Text_FufufuPerhapsWeWill::
    db "<VOICE1>*: Fufufu… Perhaps<LINE>"
    db "we will be enemies<PROMPT>"
    db "<NEXT>if we meet again"
    db "<NEXT>in the future.<WAIT>"
    db "@"

Text_ForYouMasterI::
    db "<VOICE1>*: For you, master,<LINE>"
    db "I will leap into<PROMPT>"
    db "<NEXT>a pool of fire, if"
    db "<NEXT>you so command me.<WAIT>"
    db "@"

Text_ExcitementTensionTheyAre::
    db "<VOICE1>*: Excitement,<LINE>"
    db "tension…<PROMPT>"
    db "<NEXT>They are emotions"
    db "<NEXT>without meaning.<WAIT>"
    db "@"

Text_PeopleAndMonstersShould::
    db "<VOICE1>*: People and<LINE>"
    db "monsters should be<PROMPT>"
    db "<NEXT>punished alike for"
    db "<NEXT>sins they commit.<WAIT>"
    db "@"

Text_GiveMeTheChance::
    db "<VOICE1>*: Give me the<LINE>"
    db "chance to shine.<PROMPT>"
    db "<NEXT>I will protect you"
    db "<NEXT>if you do.<WAIT>"
    db "@"

Text_IAmTheLord::
    db "<VOICE1>*: I am the Lord of<LINE>"
    db "the monsters!<PROMPT>"
    db "<NEXT>What? Too plain?"
    db "<NEXT>You think so?<WAIT>"
    db "@"

Text_AreThereNoUnbreakable::
    db "<VOICE1>*: Are there no<LINE>"
    db "unbreakable toys <PROMPT>"
    db "<NEXT>that will keep"
    db "<NEXT>coming back?<WAIT>"
    db "@"

Text_DontBotherMeLeave::
    db "<VOICE1>*: Don't bother me…<LINE>"
    db "Leave me be…<WAIT>"
    db "@"

Text_LetMeConquerA::
    db "<VOICE1>*: Let me conquer a<LINE>"
    db "world for you, eh?<WAIT>"
    db "@"

Text_ToBeConqueredBy::
    db "<VOICE1>*: To be conquered<LINE>"
    db "by me is to know<PROMPT>"
    db "<NEXT>happiness!"
    db "<NEXT>Hahahahahah!<WAIT>"
    db "@"

Text_TheWorldIsMine::
    db "<VOICE1>*: The world is<LINE>"
    db "mine!<PROMPT>"
    db "<NEXT>That is the way it"
    db "<NEXT>has to be!<WAIT>"
    db "@"

Text_EverythingIsAccordingTo::
    db "<VOICE1>*: Everything is<LINE>"
    db "according to plan.<PROMPT>"
    db "<NEXT>Nothing unexpected"
    db "<NEXT>can happen.<WAIT>"
    db "@"

Text_YouCanBeThe::
    db "<VOICE1>*: You can be the<LINE>"
    db "decoy. I'll strike<PROMPT>"
    db "<NEXT>while you're under"
    db "<NEXT>attack. How's that?<WAIT>"
    db "@"

Text_TheFeelingsOfHatred::
    db "<VOICE1>*: The feelings of<LINE>"
    db "hatred and sorrow<PROMPT>"
    db "<NEXT>become my power."
    db "<NEXT><WAIT>"
    db "@"

Text_TravelingIsFineBut::
    db "<VOICE1>*: Traveling is<LINE>"
    db "fine, but quietly<PROMPT>"
    db "<NEXT>reading is also"
    db "<NEXT>pleasant…<WAIT>"
    db "@"

Text_AllMyPowerI::
    db "<VOICE1>*: All my power, I<LINE>"
    db "will use for you…<WAIT>"
    db "@"

Text_ThePPowerOf::
    db "<VOICE1>*: The p-power of<LINE>"
    db "heroes is scary…<WAIT>"
    db "@"

Text_IfYouWouldAllow::
    db "<VOICE1>*: If you would<LINE>"
    db "allow it, I wish<PROMPT>"
    db "<NEXT>to conquer this"
    db "<NEXT>world.<WAIT>"
    db "@"

Text_LifeIsntBadTake::
    db "<VOICE1>*: Life isn't bad!<LINE>"
    db "Take it easy,<PROMPT>"
    db "<NEXT>slow down, relax"
    db "<NEXT>and enjoy!<WAIT>"
    db "@"

Text_ICantBeBothered::
    db "<VOICE1>*: I can't be<LINE>"
    db "bothered to chat…<PROMPT>"
    db "<NEXT>Be gone…"
    db "<NEXT><WAIT>"
    db "@"

StringCategories_99_2::
MessageStrings_Bank2E_Overflow::
    dw StringList_Bank2E_Overflow_0 ; id 0

; category list of StringCategories_99_2; one pointer per wStringIndex (E-0217)
StringList_Bank2E_Overflow_0::
    dw Text_OurDaughtersOnlyMemento ; id 0
    dw Text_ItDoesntLookLike ; id 1
    dw Text_TheOldCoupleAcross ; id 2
    dw Text_ThisIsTheTravelers ; id 3
    dw Text_ThatDealerHowExpensive ; id 4
    dw Text_LatelyTheTownOf ; id 5
    dw Text_ItsRumoredThatMonsters ; id 6
    dw Text_YouDidntKnowWell ; id 7
    dw Text_ThatDealersWaresCould ; id 8
    dw Text_HowDoesThisOrnament ; id 9
    dw Text_HowDoesThisJewelry ; id 10
    dw Text_HowDoesThisGrand ; id 11
    dw Text_IveNoUseFor ; id 12
    dw Text_HowDoesThisOrnament_2 ; id 13
    dw Text_HowDoesThisJewelry_2 ; id 14
    dw Text_HowDoesThisGrand_2 ; id 15
    dw Text_ThisPendantIsYours ; id 16
    dw Text_TheTowersEntryIs ; id 17
    dw Text_WhoAreYouYou ; id 18
    dw Text_YoureGoingToRegret ; id 19
    dw Text_WhatNotYouAgain ; id 20
    dw Text_WellSmashYouAs ; id 21
    dw Text_PleaseMercySpareUs ; id 22
    dw Text_OpenedTheTreasureChest ; id 23
    dw Text_FoundThePrettyRing ; id 24
    dw Text_FoundThePrettyRing ; id 25
    dw Text_IDugDeepIn ; id 26
    dw Text_WhatMonstersAttackedYou ; id 27
    dw Text_ThatDealerIsA ; id 28
    dw Text_For47HeroHero ; id 29
    dw Text_YouDefeatedTheMonsters ; id 30
    dw Text_YouDefeatedTheMonsters_2 ; id 31
    dw Text_AreYouMilayousFriend ; id 32
    dw Text_IfAMonsterCould ; id 33
    dw Text_DontYouThinkIts ; id 34
    dw Text_ArrrghThisIsSo ; id 35
    dw Text_ShowedThePrettyRing ; id 36
    dw Text_AhThatRingIs ; id 37
    dw Text_HandedOverThePretty ; id 38
    dw Text_ThankYouForGetting ; id 39
    dw Text_ThingsHaventBeenGood ; id 40
    dw Text_ThankYouForRecovering ; id 41
    dw Text_ReceivedASageRock ; id 42
    dw Text_ReceivedASageRockBut ; id 43
    dw Text_WeAreGratefulThat ; id 44
    dw Text_WeAreGratefulThat_2 ; id 45
    dw Text_TheOldCoupleLook ; id 46
    dw Text_ImSoGladThe ; id 47
    dw Text_WhatDoThoseMonsters ; id 48
    dw Text_MilayouIveBeenChecking ; id 49
    dw Text_IDugDeepIn_2 ; id 50
    dw Text_TheThievingMonstersHad ; id 51
    dw Text_WhatWhereIGet ; id 52
    dw Text_ThatGreedhoundDealerScuttled ; id 53
    dw Text_MilayouIThoughtThis ; id 54
    dw Text_MilayouPleaseDefeatThe ; id 55
    dw Text_Empty_8 ; id 56
    dw Text_Empty_8 ; id 57
    dw Text_Empty_8 ; id 58
    dw Text_Empty_8 ; id 59
    dw Text_Empty_8 ; id 60
    dw Text_Empty_8 ; id 61
    dw Text_Empty_8 ; id 62
    dw Text_Empty_8 ; id 63
    dw Text_Empty_8 ; id 64
    dw Text_Empty_8 ; id 65
    dw Text_Empty_8 ; id 66
    dw Text_Empty_8 ; id 67
    dw Text_Empty_8 ; id 68
    dw Text_Empty_8 ; id 69
    dw Text_Empty_8 ; id 70
    dw Text_Empty_8 ; id 71
    dw Text_Empty_8 ; id 72
    dw Text_Empty_8 ; id 73
    dw Text_Empty_8 ; id 74
    dw Text_Empty_8 ; id 75
    dw Text_Empty_8 ; id 76
    dw Text_Empty_8 ; id 77
    dw Text_Empty_8 ; id 78
    dw Text_Empty_8 ; id 79
    dw Text_Empty_8 ; id 80
    dw Text_Empty_8 ; id 81
    dw Text_Empty_8 ; id 82
    dw Text_Empty_8 ; id 83
    dw Text_Empty_8 ; id 84
    dw Text_Empty_8 ; id 85
    dw Text_Empty_8 ; id 86
    dw Text_Empty_8 ; id 87
    dw Text_Empty_8 ; id 88
    dw Text_Empty_8 ; id 89

Text_OurDaughtersOnlyMemento::
    db "<VOICE2>*: Our daughter's<LINE>"
    db "only memento was<PROMPT>"
    db "<NEXT>taken from us by"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>I'm losing the will"
    db "<NEXT>to keep living…<WAIT>"
    db "@"

Text_ItDoesntLookLike::
    db "<VOICE1>*: It doesn't look<LINE>"
    db "like the monsters<PROMPT>"
    db "<NEXT>are coming from"
    db "<NEXT>anywhere close.<PROMPT>"
    db "<NEXT>You ought to pay a"
    db "<NEXT>visit to the hut<PROMPT>"
    db "<NEXT>by the spring in"
    db "<NEXT>the west.<PROMPT>"
    db "<NEXT>It's for use by"
    db "<NEXT>travelers.<PROMPT>"
    db "<NEXT>You might talk to"
    db "<NEXT>them for clues.<WAIT>"
    db "@"

Text_TheOldCoupleAcross::
    db "<VOICE2>*: The old couple<LINE>"
    db "across the way<PROMPT>"
    db "<NEXT>were robbed of a"
    db "<NEXT>precious item.<PROMPT>"
    db "<NEXT>That's why they"
    db "<NEXT>were so sad.<WAIT>"
    db "@"

Text_ThisIsTheTravelers::
    db "<VOICE1>*: This is the<LINE>"
    db "traveler's hut.<PROMPT>"
    db "<NEXT>Stay and rest your"
    db "<NEXT>feet a while.<WAIT>"
    db "@"

Text_ThatDealerHowExpensive::
    db "<VOICE1>*: That dealer,<LINE>"
    db "how expensive!<PROMPT>"
    db "<NEXT>Nobody can afford"
    db "<NEXT>what he sells!<PROMPT>"
    db "<NEXT>But he does have"
    db "<NEXT>super merchandise…<WAIT>"
    db "@"

Text_LatelyTheTownOf::
    db "<VOICE1>*: Lately, the town<LINE>"
    db "of Miagen has been<PROMPT>"
    db "<NEXT>hit by plundering"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>Did you know that?"
    db "<NEXT><CHOICE>"
    db "@"

Text_ItsRumoredThatMonsters::
    db "<VOICE1>*: It's rumored that<LINE>"
    db "monsters raid the<PROMPT>"
    db "<NEXT>town by scaling"
    db "<NEXT>the mountain range<PROMPT>"
    db "<NEXT>to the north."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I think there was"
    db "<NEXT>a forest nearby.<PROMPT>"
    db "<NEXT>Perhaps they came"
    db "<NEXT>from that forest.<PROMPT>"
    db "<NEXT>The forest is east"
    db "<NEXT>from here.<WAIT>"
    db "@"

Text_YouDidntKnowWell::
    db "<VOICE1>*: You didn't know?<LINE>"
    db "Well, listen up.<PROMPT>"
    db "<NEXT>Go to the town of"
    db "<NEXT>Miagen.<PROMPT>"
    db "<NEXT>The townspeople"
    db "<NEXT>are in an uproar.<WAIT>"
    db "@"

Text_ThatDealersWaresCould::
    db "<VOICE2>*: That dealer's<LINE>"
    db "wares…<PROMPT>"
    db "<NEXT>Could he sell any"
    db "<NEXT>at those prices?<PROMPT>"
    db "<NEXT>I", $44, " like to make"
    db "<NEXT>money like that…<WAIT>"
    db "@"

Text_HowDoesThisOrnament::
    db "<VOICE1>*: How does this<LINE>"
    db "ornament look?<PROMPT>"
    db "<NEXT>Take it home for"
    db "<NEXT>just 12,000G.<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

Text_HowDoesThisJewelry::
    db "<VOICE1>*: How does this<LINE>"
    db "jewelry look?<PROMPT>"
    db "<NEXT>It's yours for a"
    db "<NEXT>mere 18,000G.<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

Text_HowDoesThisGrand::
    db "<VOICE1>*: How does this<LINE>"
    db "grand vase look?<PROMPT>"
    db "<NEXT>A bargain at"
    db "<NEXT>23,000G!<PROMPT>"
    db "<NEXT>You say that's too"
    db "<NEXT>much?<PROMPT>"
    db "<NEXT>Heh, scram if you"
    db "<NEXT>have no money.<WAIT>"
    db "@"

Text_IveNoUseFor::
    db "<VOICE1>*: I've no use for<LINE>"
    db "the poor.<PROMPT>"
    db "<NEXT>Come back if you"
    db "<NEXT>make some money.<WAIT>"
    db "@"

Text_HowDoesThisOrnament_2::
    db "<VOICE1>*: How does this<LINE>"
    db "ornament look?<PROMPT>"
    db "<NEXT>Take it home for"
    db "<NEXT>just 12,000G.<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Get lost if you're"
    db "<NEXT>not buying!<WAIT>"
    db "@"

Text_HowDoesThisJewelry_2::
    db "<VOICE1>*: How does this<LINE>"
    db "jewelry look?<PROMPT>"
    db "<NEXT>It's yours for a"
    db "<NEXT>mere 18,000G.<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I don't have time"
    db "<NEXT>to play games!<WAIT>"
    db "@"

Text_HowDoesThisGrand_2::
    db "<VOICE1>*: How does this<LINE>"
    db "grand vase look?<PROMPT>"
    db "<NEXT>A bargain at"
    db "<NEXT>23,000G!<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>If you're not a"
    db "<NEXT>customer, beat it!<WAIT>"
    db "@"

Text_ThisPendantIsYours::
    db "<VOICE1>*: This pendant is<LINE>"
    db "yours for 38,000G…<PROMPT>"
    db "<NEXT>What? Monsters?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>I don't know a"
    db "<NEXT>thing about that!<PROMPT>"
    db "<NEXT>You're bad for"
    db "<NEXT>business, vamoose!<WAIT>"
    db "@"

Text_TheTowersEntryIs::
    db "The tower's entry<LINE>"
    db "is sealed tight.<WAIT>"
    db "@"

Text_WhoAreYouYou::
    db "<VOICE1>*: Who are you?<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>You shouldn't be"
    db "<NEXT>meddling here!<WAIT>"
    db "@"

Text_YoureGoingToRegret::
    db "<VOICE1>*: You're going to<LINE>"
    db "regret seeing us.<PROMPT>"
    db "<NEXT>We can't let you"
    db "<NEXT>go blab. Gwaaaaah!<WAIT>"
    db "@"

Text_WhatNotYouAgain::
    db "<VOICE1>*: What, not you<LINE>"
    db "again!<WAIT>"
    db "@"

Text_WellSmashYouAs::
    db "<VOICE1>*: We'll smash you<LINE>"
    db "as often as it<PROMPT>"
    db "<NEXT>takes to make you"
    db "<NEXT>stop meddling!<WAIT>"
    db "@"

Text_PleaseMercySpareUs::
    db "<VOICE1>*: Please! Mercy!<LINE>"
    db "Spare us!<PROMPT>"
    db "<NEXT>Take back every-"
    db "<NEXT>thing we took!<WAIT>"
    db "@"

Text_OpenedTheTreasureChest::
    db "<BUF0> opened the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>Pretty Ring.<WAIT>"
    db "@"

Text_FoundThePrettyRing::
    db "<BUF0> found the<LINE>"
    db "Pretty Ring.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> put the"
    db "<NEXT>Pretty Ring back.<WAIT>"
    db "@"

Text_IDugDeepIn::
    db "<VOICE1>*: I dug deep in my<LINE>"
    db "purse to buy from<PROMPT>"
    db "<NEXT>that dealer, but"
    db "<NEXT>it feel very odd.<PROMPT>"
    db "<NEXT>What I buy look"
    db "<NEXT>very familiar.<PROMPT>"
    db "<NEXT>I don't know why."
    db "<NEXT>I will remember.<WAIT>"
    db "@"

Text_WhatMonstersAttackedYou::
    db "<VOICE1>*: What? Monsters<LINE>"
    db "attacked you in<PROMPT>"
    db "<NEXT>the northern"
    db "<NEXT>forest?<PROMPT>"
    db "<NEXT>I'm surprised to"
    db "<NEXT>see you alive.<PROMPT>"
    db "<NEXT>Um… Are you maybe"
    db "<NEXT>really tough?<WAIT>"
    db "@"

Text_ThatDealerIsA::
    db "<VOICE2>*: That dealer is a<LINE>"
    db "greedy hound!<PROMPT>"
    db "<NEXT>He won't tell me"
    db "<NEXT>where he gets his<PROMPT>"
    db "<NEXT>merchandise, the"
    db "<NEXT>cheapskate!<WAIT>"
    db "@"

Text_For47HeroHero::
    db "<VOICE1>*: For 47,000G this<LINE>"
    db "earring… What?<PROMPT>"
    db "<NEXT>You went to the"
    db "<NEXT>northern forest?<PROMPT>"
    db "<NEXT>Monsters didn't"
    db "<NEXT>attack you?<WAIT>"
    db "@"

Text_YouDefeatedTheMonsters::
    db "<VOICE1>*: You defeated the<LINE>"
    db "monsters?<PROMPT>"
    db "<NEXT>You're not joking,"
    db "<NEXT>are you?<WAIT>"
    db "@"

Text_YouDefeatedTheMonsters_2::
    db "<VOICE1>*: You defeated the<LINE>"
    db "monsters…<PROMPT>"
    db "<NEXT>…You're not joking,"
    db "<NEXT>are you?<WAIT>"
    db "@"

Text_AreYouMilayousFriend::
    db "<VOICE2>*: Are you Milayou's<LINE>"
    db "friend?<PROMPT>"
    db "<NEXT>The little monster"
    db "<NEXT>master?<PROMPT>"
    db "<NEXT>You're after the"
    db "<NEXT>bad monsters aren't<PROMPT>"
    db "<NEXT>you? That is just"
    db "<NEXT>so neat!<WAIT>"
    db "@"

Text_IfAMonsterCould::
    db "<VOICE1>*: If a monster<LINE>"
    db "could be good or<PROMPT>"
    db "<NEXT>bad, does that"
    db "<NEXT>mean there are<PROMPT>"
    db "<NEXT>both good masters"
    db "<NEXT>and bad ones?<WAIT>"
    db "@"

Text_DontYouThinkIts::
    db "<VOICE1>*: Don't you think<LINE>"
    db "it's odd that the<PROMPT>"
    db "<NEXT>monsters are after"
    db "<NEXT>treasures?<PROMPT>"
    db "<NEXT>I can understand"
    db "<NEXT>if they went for<PROMPT>"
    db "<NEXT>food, but…"
    db "<NEXT><WAIT>"
    db "@"

Text_ArrrghThisIsSo::
    db "<VOICE2>*: Arrrgh! This is<LINE>"
    db "so infuriating!<PROMPT>"
    db "<NEXT>The monsters took"
    db "<NEXT>my lingerie again!<PROMPT>"
    db "<NEXT>What exactly would"
    db "<NEXT>they want with my<PROMPT>"
    db "<NEXT>underwear anyway?"
    db "<NEXT>It makes no sense!<WAIT>"
    db "@"

Text_ShowedThePrettyRing::
    db "<BUF0> showed the<LINE>"
    db "Pretty Ring.<WAIT>"
    db "@"

Text_AhThatRingIs::
    db "<VOICE1>*: Ah… That ring…<LINE>"
    db "Is… Is it…<PROMPT>"
    db "<NEXT>That's my daughter's"
    db "<NEXT>ring!<WAIT>"
    db "@"

Text_HandedOverThePretty::
    db "<BUF0> handed over<LINE>"
    db "the Pretty Ring.<WAIT>"
    db "@"

Text_ThankYouForGetting::
    db "<VOICE1>*: Thank you for<LINE>"
    db "getting the ring<PROMPT>"
    db "<NEXT>back for me."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>But things haven't"
    db "<NEXT>been good for us.<PROMPT>"
    db "<NEXT>First, there was a"
    db "<NEXT>traveling dealer<PROMPT>"
    db "<NEXT>who was terribly"
    db "<NEXT>pushy and rude.<PROMPT>"
    db "<NEXT>He also stared at"
    db "<NEXT>our belongings.<PROMPT>"
    db "<NEXT>We had to throw"
    db "<NEXT>him out.<WAIT>"
    db "@"

Text_ThingsHaventBeenGood::
    db "<VOICE1>*: Things haven't<LINE>"
    db "been good for us.<PROMPT>"
    db "<NEXT>There was a"
    db "<NEXT>traveling dealer<PROMPT>"
    db "<NEXT>who was terribly"
    db "<NEXT>pushy and rude.<PROMPT>"
    db "<NEXT>He also stared at"
    db "<NEXT>our belongings.<PROMPT>"
    db "<NEXT>We had to throw"
    db "<NEXT>him out.<WAIT>"
    db "@"

Text_ThankYouForRecovering::
    db "<VOICE2>*: Thank you for<LINE>"
    db "recovering our<PROMPT>"
    db "<NEXT>daughter's ring."
    db "<NEXT>As a show of our<PROMPT>"
    db "<NEXT>thanks, would you"
    db "<NEXT>accept this?<WAIT>"
    db "@"

Text_ReceivedASageRock::
    db "<BUF0> received a<LINE>"
    db "SageRock.<WAIT>"
    db "@"

Text_ReceivedASageRockBut::
    db "<BUF0> received a<LINE>"
    db "SageRock.<PROMPT>"
    db "<NEXT>But there is no"
    db "<NEXT>room for it.<PROMPT>"
    db "<NEXT><BUF0> gave back"
    db "<NEXT>the SageRock.<WAIT>"
    db "@"

Text_WeAreGratefulThat::
    db "<VOICE2>*: We are grateful<LINE>"
    db "that you recovered<PROMPT>"
    db "<NEXT>our daughter's"
    db "<NEXT>ring. As a show of<PROMPT>"
    db "<NEXT>our thanks, would"
    db "<NEXT>you accept this?<WAIT>"
    db "@"

Text_WeAreGratefulThat_2::
    db "<VOICE2>*: We are grateful<LINE>"
    db "that you recovered<PROMPT>"
    db "<NEXT>our daughter's"
    db "<NEXT>ring.<WAIT>"
    db "@"

Text_TheOldCoupleLook::
    db "<VOICE1>*: The old couple<LINE>"
    db "look happy after<PROMPT>"
    db "<NEXT>they got their"
    db "<NEXT>treasure back.<WAIT>"
    db "@"

Text_ImSoGladThe::
    db "<VOICE2>*: I'm so glad the<LINE>"
    db "people across the<PROMPT>"
    db "<NEXT>way got back their"
    db "<NEXT>stolen treasure.<WAIT>"
    db "@"

Text_WhatDoThoseMonsters::
    db "<VOICE1>*: What do those<LINE>"
    db "monsters do with<PROMPT>"
    db "<NEXT>the things that"
    db "<NEXT>they steal?<PROMPT>"
    db "<NEXT>If it were me, I", $44
    db "<NEXT>act as a fence and<PROMPT>"
    db "<NEXT>sell them on the"
    db "<NEXT>sly for big money…<PROMPT>"
    db "<NEXT>I'm only joking!"
    db "<NEXT>Just a joke!<WAIT>"
    db "@"

Text_MilayouIveBeenChecking::
    db "<VOICE2>Milayou: I've been<LINE>"
    db "checking around,<PROMPT>"
    db "<NEXT>and I think the"
    db "<NEXT>evidence is clear.<PROMPT>"
    db "<NEXT>Somebody is behind"
    db "<NEXT>the monsters.<PROMPT>"
    db "<NEXT>It's the work of a"
    db "<NEXT>dark master.<PROMPT>"
    db "<NEXT>I don't know who"
    db "<NEXT>it is, though.<PROMPT>"
    db "<NEXT>Do you have any"
    db "<NEXT>idea who?<WAIT>"
    db "@"

Text_IDugDeepIn_2::
    db "<VOICE1>*: I dug deep in my<LINE>"
    db "purse to buy from<PROMPT>"
    db "<NEXT>that dealer, but"
    db "<NEXT>that ornament, it<PROMPT>"
    db "<NEXT>was the one stolen"
    db "<NEXT>from my neighbor.<PROMPT>"
    db "<NEXT>What sort of"
    db "<NEXT>nonsense is this?<WAIT>"
    db "@"

Text_TheThievingMonstersHad::
    db "<VOICE1>*: The thieving<LINE>"
    db "monsters had a<PROMPT>"
    db "<NEXT>boss, didn't they?"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>He must be a sly"
    db "<NEXT>scoundrel to let<PROMPT>"
    db "<NEXT>his underlings do"
    db "<NEXT>his dirty deeds.<WAIT>"
    db "@"

Text_WhatWhereIGet::
    db "<VOICE1>*: What? Where", $44, " I<LINE>"
    db "get my wares?<PROMPT>"
    db "<NEXT>Uh… Erm… Whoops!"
    db "<NEXT>Look at the time!<PROMPT>"
    db "<NEXT>Out of the way,"
    db "<NEXT>I'm late!<WAIT>"
    db "@"

Text_ThatGreedhoundDealerScuttled::
    db "<VOICE2>*: That greedhound<LINE>"
    db "dealer scuttled<PROMPT>"
    db "<NEXT>off in an awful"
    db "<NEXT>hurry.<WAIT>"
    db "@"

Text_MilayouIThoughtThis::
    db "<VOICE2>Milayou: I thought<LINE>"
    db "this forest looked<PROMPT>"
    db "<NEXT>suspicious, so I"
    db "<NEXT>was investigating…<PROMPT>"
    db "<NEXT>I was jumped from"
    db "<NEXT>behind and my<PROMPT>"
    db "<NEXT>party was crushed"
    db "<NEXT>just like that.<PROMPT>"
    db "<NEXT>A man, he looked"
    db "<NEXT>like a dealer, was<PROMPT>"
    db "<NEXT>commanding the"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>He must have been"
    db "<NEXT>the mastermind.<PROMPT>"
    db "<NEXT>The dark master"
    db "<NEXT>went into the<PROMPT>"
    db "<NEXT>tower. Please go"
    db "<NEXT>after him for me!<WAIT>"
    db "@"

Text_MilayouPleaseDefeatThe::
    db "<VOICE2>Milayou: Please<LINE>"
    db "defeat the dark<PROMPT>"
    db "<NEXT>master and bring"
    db "<NEXT>him to justice!<WAIT>"
    db "@"

Text_Empty_8::
    db $f0

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_99_3::
MessageStrings_Bank7C_Overflow::
    dw StringList_Bank7C_Overflow_0 ; id 0

; category list of StringCategories_99_3; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank7C_Overflow_0::
    dw Text_CheckedTheTreasureChest_3 ; id 0
    dw Text_CheckedTheTreasureChest_4 ; id 1
    dw Text_PeeredIntoTheOven_3 ; id 2
    dw Text_PeeredIntoTheVase_6 ; id 3
    dw Text_ReadTheSignWelcome ; id 4
    dw Text_PeeredIntoTheVase_7 ; id 5
    dw Text_PeeredIntoTheOven_4 ; id 6
    dw Text_ThisIsTheMermaid ; id 7
    dw Text_CloseYourEyesFor ; id 8
    dw Text_OhTellMeIf ; id 9
    dw Text_KamehaAiyeeeeeh ; id 10
    dw Text_YourMonstersAppearDispirited ; id 11
    dw Text_ThickSuctionCuppedTentacles ; id 12
    dw Text_TheRagingSeaCalmed ; id 13
    dw Text_FatherPutUpA ; id 14
    dw Text_FatherPutUpA ; id 15
    dw Text_FatherPutUpA ; id 16
    dw Text_FatherPutUpA ; id 17
    dw Text_FatherPutUpA ; id 18
    dw Text_FatherPutUpA ; id 19
    dw Text_FatherPutUpA ; id 20
    dw Text_FatherPutUpA ; id 21
    dw Text_FatherPutUpA ; id 22
    dw Text_FatherPutUpA ; id 23
    dw Text_FatherPutUpA ; id 24
    dw Text_FatherPutUpA ; id 25
    dw Text_OhYoullRunAnother ; id 26
    dw Text_MyWhatHasGotten ; id 27
    dw Text_MamaHandedOver4Hero ; id 28
    dw Text_NoMiraclesTodayOh ; id 29
    dw Text_INeedYouTo ; id 30
    dw Text_OhYouveFoundWhat ; id 31
    dw Text_HandedOverThePotion ; id 32
    dw Text_WellCouldYouGo ; id 33
    dw Text_MamaHandedOver6Hero ; id 34
    dw Text_IWantYouTo ; id 35
    dw Text_HandedOverTheRib ; id 36
    dw Text_HandedOverTheRib ; id 37
    dw Text_ThanksYoureGreatHelp ; id 38
    dw Text_MyFatherWasA ; id 39
    dw Text_BeavernHelpedPutUp ; id 40
    dw Text_ILikeToGet ; id 41
    dw Text_IfOneJoinsYou ; id 42
    dw Text_AMadGopherJoinedYou ; id 43
    dw Text_AMadGopherJoinedYou_2 ; id 44
    dw Text_GreatThanksALot ; id 45
    dw Text_INeedYourHelp ; id 46
    dw Text_MadGophersBeenAGreat ; id 47
    dw Text_IveFinishedWorkingCan ; id 48
    dw Text_ImCountingOnYou ; id 49
    dw Text_ButYouHaveNo_3 ; id 50
    dw Text_TchIThoughtI ; id 51
    dw Text_YouHaveToTamp ; id 52
    dw Text_CobiWhatWasIt ; id 53
    dw Text_TaraBigBrotherTell ; id 54
    dw Text_IncludingTheMonstersWith ; id 55
    dw Text_MasterOnlyMakesMe ; id 56
    dw Text_WeGetMoreAnd ; id 57
    dw Text_HeyYoureTheKid ; id 58
    dw Text_IHaveNothingFor ; id 59
    dw Text_ToTakeOffAn ; id 60
    dw Text_TheWomanNextTo ; id 61
    dw Text_IWantToOpen ; id 62
    dw Text_WaitCouldIGet ; id 63
    dw Text_WaitCouldIGet ; id 64
    dw Text_WaitCouldIGet_2 ; id 65
    dw Text_FantasticICanOpen ; id 66
    dw Text_OhThatsVeryDisappointing ; id 67
    dw Text_ArmyAntHelpedMeGet ; id 68
    dw Text_WelcomeHowMayI ; id 69
    dw Text_CheckedTheDoorThe ; id 70
    dw Text_ManyTreesHaveSubmerged ; id 71
    dw Text_UmImTheEgg ; id 72
    dw Text_ImTheEggEvaluator ; id 73
    dw Text_TheEvaluatorSaidI ; id 74
    dw Text_GoDownTheseStairs ; id 75
    dw Text_WelcomeToTheStarry ; id 76
    dw Text_WelcomeToTheStarry_2 ; id 77
    dw Text_ImTheProfsAssistant ; id 78
    dw Text_YouCanBreedMonsters ; id 79
    dw Text_TalkToTheProf ; id 80
    dw Text_CheckedTheBookshelfBreeding ; id 81
    dw Text_CheckedTheBookshelfBreeding_2 ; id 82
    dw Text_Empty_9 ; id 83
    dw Text_Empty_9 ; id 84
    dw Text_Empty_9 ; id 85
    dw Text_Empty_9 ; id 86
    dw Text_Empty_9 ; id 87
    dw Text_Empty_9 ; id 88
    dw Text_Empty_9 ; id 89
    dw Text_Empty_9 ; id 90
    dw Text_Empty_9 ; id 91
    dw Text_Empty_9 ; id 92
    dw Text_Empty_9 ; id 93
    dw Text_Empty_9 ; id 94
    dw Text_Empty_9 ; id 95
    dw Text_Empty_9 ; id 96
    dw Text_Empty_9 ; id 97
    dw Text_Empty_9 ; id 98
    dw Text_Empty_10 ; id 99
    dw Text_Empty_10 ; id 100
    dw Text_Empty_10 ; id 101
    dw Text_Empty_10 ; id 102
    dw Text_Empty_10 ; id 103
    dw Text_Empty_10 ; id 104
    dw Text_Empty_10 ; id 105
    dw Text_Empty_10 ; id 106
    dw Text_Empty_10 ; id 107
    dw Text_Empty_10 ; id 108
    dw Text_Empty_10 ; id 109
    dw Text_Empty_10 ; id 110
    dw Text_Empty_10 ; id 111
    dw Text_Empty_10 ; id 112
    dw Text_Empty_10 ; id 113
    dw Text_Empty_10 ; id 114
    dw Text_Empty_10 ; id 115
    dw Text_Empty_10 ; id 116
    dw Text_Empty_10 ; id 117
    dw Text_Empty_10 ; id 118
    dw Text_Empty_10 ; id 119
    dw Text_Empty_10 ; id 120

Text_CheckedTheTreasureChest_3::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained"
    db "<NEXT>the MoonRock.<WAIT>"
    db "@"

Text_CheckedTheTreasureChest_4::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT>There was the"
    db "<NEXT>MoonRock inside.<PROMPT>"
    db "<NEXT>But there was no"
    db "<NEXT>room for it.<WAIT>"
    db "@"

Text_PeeredIntoTheOven_3::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It smelled of"
    db "<NEXT>grilled fish.<WAIT>"
    db "@"

Text_PeeredIntoTheVase_6::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>merchandise.<WAIT>"
    db "@"

Text_ReadTheSignWelcome::
    db "<BUF0> read the<LINE>"
    db "sign.<PROMPT>"
    db "<NEXT>'Welcome to the"
    db "<NEXT>Port of Polona!<PROMPT>"
    db "<NEXT>Frolic with"
    db "<NEXT>mermaids…", $95, "<WAIT>"
    db "@"

Text_PeeredIntoTheVase_7::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>There were tourist"
    db "<NEXT>pamphlets inside.<PROMPT>"
    db "<NEXT>'Infinitely clear"
    db "<NEXT>blue waters and<PROMPT>"
    db "<NEXT>playful mermaids"
    db "<NEXT>await you!", $95, "<WAIT>"
    db "@"

Text_PeeredIntoTheOven_4::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>Two shiny pots"
    db "<NEXT>were inside.<WAIT>"
    db "@"

Text_ThisIsTheMermaid::
    db "<VOICE2>*: This is the<LINE>"
    db "mermaid kingdom.<PROMPT>"
    db "<NEXT>Did you want to go"
    db "<NEXT>home?<CHOICE>"
    db "@"

Text_CloseYourEyesFor::
    db "<VOICE2>*: Close your eyes<LINE>"
    db "for a little bit…<WAIT>"
    db "@"

Text_OhTellMeIf::
    db "<VOICE2>*: Oh. Tell me if<LINE>"
    db "you want to go.<WAIT>"
    db "@"

Text_KamehaAiyeeeeeh::
    db "<VOICE1>Kameha: Aiyeeeeeh…<LINE>"
    db "<WAIT>"
    db "@"

Text_YourMonstersAppearDispirited::
    db "<VOICE1>*: …Your monsters<LINE>"
    db "appear dispirited…<PROMPT>"
    db "<NEXT>It's unfortunate,"
    db "<NEXT>but next time.<WAIT>"
    db "@"

Text_ThickSuctionCuppedTentacles::
    db "Thick, suction-<LINE>"
    db "cupped tentacles<PROMPT>"
    db "<NEXT>snaked out of the"
    db "<NEXT>whirlpool!<WAIT>"
    db "@"

Text_TheRagingSeaCalmed::
    db "The raging sea<LINE>"
    db "calmed, and the<PROMPT>"
    db "<NEXT>whirlpool smoothed"
    db "<NEXT>to nothing.<WAIT>"
    db "@"

Text_FatherPutUpA::
    db "<VOICE2>*: Father put up a<LINE>"
    db "bridge across to<PROMPT>"
    db "<NEXT>that tiny island."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>We have more room"
    db "<NEXT>for monsters now.<WAIT>"
    db "@"

Text_OhYoullRunAnother::
    db "<VOICE2>*: Oh? You'll run<LINE>"
    db "another errand?<CHOICE>"
    db "@"

Text_MyWhatHasGotten::
    db "<VOICE2>*: My, what has<LINE>"
    db "gotten into you?<PROMPT>"
    db "<NEXT>Will miracles"
    db "<NEXT>never cease?<PROMPT>"
    db "<NEXT>Could you go buy a"
    db "<NEXT>Potion for me?<PROMPT>"
    db "<NEXT>Father's run down"
    db "<NEXT>from overwork.<WAIT>"
    db "@"

Text_MamaHandedOver4Hero::
    db "Mama handed over<LINE>"
    db "400G.<WAIT>"
    db "@"

Text_NoMiraclesTodayOh::
    db "<VOICE2>*: No miracles<LINE>"
    db "today! Oh, well.<PROMPT>"
    db "<NEXT>Of course, off you"
    db "<NEXT>go and play!<WAIT>"
    db "@"

Text_INeedYouTo::
    db "<VOICE2>*: I need you to<LINE>"
    db "get me a Potion.<WAIT>"
    db "@"

Text_OhYouveFoundWhat::
    db "<VOICE2>*: Oh… You've found<LINE>"
    db "what I wanted.<PROMPT>"
    db "<NEXT>I knew I could"
    db "<NEXT>count on you!<WAIT>"
    db "@"

Text_HandedOverThePotion::
    db "<BUF0> handed over<LINE>"
    db "the Potion.<WAIT>"
    db "@"

Text_WellCouldYouGo::
    db "<VOICE2>*: Well, could you<LINE>"
    db "go buy a Rib?<PROMPT>"
    db "<NEXT>It'll be a change"
    db "<NEXT>from fish.<WAIT>"
    db "@"

Text_MamaHandedOver6Hero::
    db "Mama handed over<LINE>"
    db "600G.<WAIT>"
    db "@"

Text_IWantYouTo::
    db "<VOICE2>*: I want you to<LINE>"
    db "buy me a Rib.<WAIT>"
    db "@"

Text_HandedOverTheRib::
    db "<BUF0> handed over<LINE>"
    db "the Rib.<WAIT>"
    db "@"

Text_ThanksYoureGreatHelp::
    db "<VOICE2>*: Thanks, <BUF0>!<LINE>"
    db "You're great help!<WAIT>"
    db "@"

Text_MyFatherWasA::
    db "<VOICE1>*: My father was a<LINE>"
    db "Slime and Mama was<PROMPT>"
    db "<NEXT>a MiniDrak, and"
    db "<NEXT>I'm neither.<PROMPT>"
    db "<NEXT>When the parents"
    db "<NEXT>are different, the<PROMPT>"
    db "<NEXT>offspring are"
    db "<NEXT>different too.<WAIT>"
    db "@"

Text_BeavernHelpedPutUp::
    db "<VOICE1>*: Beavern helped<LINE>"
    db "put up the bridge.<PROMPT>"
    db "<NEXT>It's a solid piece"
    db "<NEXT>of work, this!<PROMPT>"
    db "<NEXT>An underground"
    db "<NEXT>stable is next,<PROMPT>"
    db "<NEXT>or at least if I"
    db "<NEXT>can get help.<PROMPT>"
    db "<NEXT>Have you seen any"
    db "<NEXT>MadGophers?<CHOICE>"
    db "@"

Text_ILikeToGet::
    db "<VOICE1>*: I", $44, " like to get<LINE>"
    db "help for digging.<PROMPT>"
    db "<NEXT>Could you befriend"
    db "<NEXT>a MadGopher?<WAIT>"
    db "@"

Text_IfOneJoinsYou::
    db "<VOICE1>*: If one joins<LINE>"
    db "you, could you<PROMPT>"
    db "<NEXT>bring it home to"
    db "<NEXT>meet me?<WAIT>"
    db "@"

Text_AMadGopherJoinedYou::
    db "<VOICE1>*: A MadGopher<LINE>"
    db "joined you?<PROMPT>"
    db "<NEXT>Could you pass it"
    db "<NEXT>over to me?<PROMPT>"
    db "<NEXT>…But that will"
    db "<NEXT>leave you alone…<WAIT>"
    db "@"

Text_AMadGopherJoinedYou_2::
    db "<VOICE1>*: A MadGopher<LINE>"
    db "joined you?<PROMPT>"
    db "<NEXT>Could you pass it"
    db "<NEXT>over to me?<CHOICE>"
    db "@"

Text_GreatThanksALot::
    db "<VOICE1>*: Great, <BUF0>!<LINE>"
    db "Thanks a lot!<PROMPT>"
    db "<NEXT>This will make the"
    db "<NEXT>farm more useful!<WAIT>"
    db "@"

Text_INeedYourHelp::
    db "<VOICE1>*: <BUF0>, I need<LINE>"
    db "your help.<PROMPT>"
    db "<NEXT>Please get me a"
    db "<NEXT>MadGopher.<WAIT>"
    db "@"

Text_MadGophersBeenAGreat::
    db "<VOICE1>*: MadGopher's been<LINE>"
    db "a great help.<PROMPT>"
    db "<NEXT>The excavation"
    db "<NEXT>should go quickly.<WAIT>"
    db "@"

Text_IveFinishedWorkingCan::
    db "<VOICE1>*: I've finished<LINE>"
    db "working.<PROMPT>"
    db "<NEXT>Can I go with you"
    db "<NEXT>again?<CHOICE>"
    db "@"

Text_ImCountingOnYou::
    db "<VOICE1>*: I'm counting on<LINE>"
    db "you!<WAIT>"
    db "@"

Text_ButYouHaveNo_3::
    db "<VOICE1>*: …But you have no<LINE>"
    db "room for me…<WAIT>"
    db "@"

Text_TchIThoughtI::
    db "<VOICE1>*: Tch, I thought I<LINE>"
    db "could help you…<WAIT>"
    db "@"

Text_YouHaveToTamp::
    db "<VOICE1>*: You have to tamp<LINE>"
    db "the ground firmly<PROMPT>"
    db "<NEXT>around where you"
    db "<NEXT>do your digging.<WAIT>"
    db "@"

Text_CobiWhatWasIt::
    db "<VOICE1>Cobi: <BUF0>, what<LINE>"
    db "was it like in the<PROMPT>"
    db "<NEXT>other worlds?"
    db "<NEXT>I", $44, " like to know.<PROMPT>"
    db "<NEXT>…Oh… Kameha's out"
    db "<NEXT>there too.<PROMPT>"
    db "<NEXT>No wonder he hasn't"
    db "<NEXT>been around.<PROMPT>"
    db "<NEXT>There's a bridge"
    db "<NEXT>over to the next<PROMPT>"
    db "<NEXT>island, so the"
    db "<NEXT>farm grew a bit<PROMPT>"
    db "<NEXT>bigger."
    db "<NEXT>So, what can I do<PROMPT>"
    db "<NEXT>for you, sis?"
    db "<NEXT><WAIT>"
    db "@"

Text_TaraBigBrotherTell::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "tell me about your<PROMPT>"
    db "<NEXT>adventures in"
    db "<NEXT>other worlds.<PROMPT>"
    db "<NEXT>…Oh… The Prince is"
    db "<NEXT>searching too.<PROMPT>"
    db "<NEXT>Papa put a bridge"
    db "<NEXT>over to that tiny<PROMPT>"
    db "<NEXT>island, so the"
    db "<NEXT>farm is bigger.<PROMPT>"
    db "<NEXT>You can leave more"
    db "<NEXT>monsters now.<PROMPT>"
    db "<NEXT>Do you need me for"
    db "<NEXT>anything?<WAIT>"
    db "@"

Text_IncludingTheMonstersWith::
    db "<VOICE1>*: Including the<LINE>"
    db "monsters with you,<PROMPT>"
    db "<NEXT>the farm can hold"
    db "<NEXT>up to 30 now.<PROMPT>"
    db "<NEXT>Expansion added to"
    db "<NEXT>capacity.<PROMPT>"
    db "<NEXT>Monsters in the"
    db "<NEXT>farm earn some<PROMPT>"
    db "<NEXT>EX points as you"
    db "<NEXT>battle.<PROMPT>"
    db "<NEXT>But if you leave"
    db "<NEXT>them in the farm,<PROMPT>"
    db "<NEXT>they will grow"
    db "<NEXT>without learning<PROMPT>"
    db "<NEXT>skills, and they"
    db "<NEXT>turn disobedient.<PROMPT>"
    db "<NEXT>So, you should"
    db "<NEXT>take different<PROMPT>"
    db "<NEXT>monsters out for"
    db "<NEXT>training.<WAIT>"
    db "@"

Text_MasterOnlyMakesMe::
    db "<VOICE1>*: Master only<LINE>"
    db "makes me charge.<PROMPT>"
    db "<NEXT>It made me more"
    db "<NEXT>courageous!<WAIT>"
    db "@"

Text_WeGetMoreAnd::
    db "<VOICE1>*: We get more and<LINE>"
    db "more stubborn as<PROMPT>"
    db "<NEXT>we grow to higher"
    db "<NEXT>levels.<PROMPT>"
    db "<NEXT>Our personalities"
    db "<NEXT>don't change much,<PROMPT>"
    db "<NEXT>once we get old."
    db "<NEXT>Fwohohoho!<WAIT>"
    db "@"

Text_HeyYoureTheKid::
    db "<VOICE1>*: Hey! You're the<LINE>"
    db "kid who said the<PROMPT>"
    db "<NEXT>island was going"
    db "<NEXT>to sink!<PROMPT>"
    db "<NEXT>I believed you and"
    db "<NEXT>sailed off, but<PROMPT>"
    db "<NEXT>the island's still"
    db "<NEXT>here!<PROMPT>"
    db "<NEXT>You rotten little"
    db "<NEXT>lie master!<WAIT>"
    db "@"

Text_IHaveNothingFor::
    db "<VOICE1>*: I have nothing<LINE>"
    db "for a liar!<WAIT>"
    db "@"

Text_ToTakeOffAn::
    db "<VOICE2>*: To take off an<LINE>"
    db "accessory, just<PROMPT>"
    db "<NEXT>put a different"
    db "<NEXT>accessory on.<PROMPT>"
    db "<NEXT>Try equipping a"
    db "<NEXT>D-Scale, that will<PROMPT>"
    db "<NEXT>remove whatever is"
    db "<NEXT>equipped.<PROMPT>"
    db "<NEXT>It's common"
    db "<NEXT>knowledge!<WAIT>"
    db "@"

Text_TheWomanNextTo::
    db "<VOICE2>*: The woman next<LINE>"
    db "to me, she repeats<PROMPT>"
    db "<NEXT>whatever she hears"
    db "<NEXT>from other people<PROMPT>"
    db "<NEXT>and acts smart."
    db "<NEXT>What a Copycat…<WAIT>"
    db "@"

Text_IWantToOpen::
    db "<VOICE1>*: I want to open<LINE>"
    db "up a shop here,<PROMPT>"
    db "<NEXT>but I need help"
    db "<NEXT>unloading my ship.<PROMPT>"
    db "<NEXT>I heard an ArmyAnt"
    db "<NEXT>can carry things<PROMPT>"
    db "<NEXT>much bigger than"
    db "<NEXT>itself.<PROMPT>"
    db "<NEXT>Yep, an ArmyAnt"
    db "<NEXT>would be helpful…<WAIT>"
    db "@"

Text_WaitCouldIGet::
    db "<VOICE1>*: Wait! Could I<LINE>"
    db "get you to leave<PROMPT>"
    db "<NEXT>your Army Ant with"
    db "<NEXT>me?<PROMPT>"
    db "<NEXT>Oh… But that would"
    db "<NEXT>leave you alone…<WAIT>"
    db "@"

Text_WaitCouldIGet_2::
    db "<VOICE1>*: Wait! Could I<LINE>"
    db "get you to leave<PROMPT>"
    db "<NEXT>your Army Ant with"
    db "<NEXT>me?<CHOICE>"
    db "@"

Text_FantasticICanOpen::
    db "<VOICE1>*: Fantastic! I can<LINE>"
    db "open my shop now!<WAIT>"
    db "@"

Text_OhThatsVeryDisappointing::
    db "<VOICE1>*: Oh… That's very<LINE>"
    db "disappointing.<PROMPT>"
    db "<NEXT>I could have my"
    db "<NEXT>shop quickly too…<WAIT>"
    db "@"

Text_ArmyAntHelpedMeGet::
    db "<VOICE1>*: ArmyAnt helped<LINE>"
    db "me get my shop up.<PROMPT>"
    db "<NEXT>Would you care to"
    db "<NEXT>see my wares?<WAIT>"
    db "@"

Text_WelcomeHowMayI::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I serve you?<WAIT>"
    db "@"

Text_CheckedTheDoorThe::
    db "<BUF0> checked the<LINE>"
    db "door.<PROMPT>"
    db "<NEXT>The door won't open"
    db "<NEXT>with any key.<WAIT>"
    db "@"

Text_ManyTreesHaveSubmerged::
    db "<VOICE1>*: Many trees have<LINE>"
    db "submerged…<PROMPT>"
    db "<NEXT>The island seems"
    db "<NEXT>to be undergoing<PROMPT>"
    db "<NEXT>an unwelcome"
    db "<NEXT>change…<WAIT>"
    db "@"

Text_UmImTheEgg::
    db "<VOICE2>*: Um… I'm the Egg<LINE>"
    db "Evaluator.<PROMPT>"
    db "<NEXT>You don't know who"
    db "<NEXT>I am… Right?<PROMPT>"
    db "<NEXT>Um… All monsters"
    db "<NEXT>hatch from eggs.<PROMPT>"
    db "<NEXT>I check your eggs"
    db "<NEXT>to determine the<PROMPT>"
    db "<NEXT>gender of the"
    db "<NEXT>monster inside.<PROMPT>"
    db "<NEXT>I can also sing a"
    db "<NEXT>song to change the<PROMPT>"
    db "<NEXT>gender of the"
    db "<NEXT>monster in an egg.<PROMPT>"
    db "<NEXT>May I help you in"
    db "<NEXT>any way today?<WAIT>"
    db "@"

Text_ImTheEggEvaluator::
    db "<VOICE2>*: I'm the Egg<LINE>"
    db "Evaluator.<PROMPT>"
    db "<NEXT>May I help you in"
    db "<NEXT>any way today?<WAIT>"
    db "@"

Text_TheEvaluatorSaidI::
    db "<VOICE1>*: The Evaluator<LINE>"
    db "said I had an<PROMPT>"
    db "<NEXT>amazing egg."
    db "<NEXT>But I stumbled on<PROMPT>"
    db "<NEXT>the stairs and"
    db "<NEXT>almost broke it.<WAIT>"
    db "@"

Text_GoDownTheseStairs::
    db "<VOICE2>*: Go down these<LINE>"
    db "stairs to the<PROMPT>"
    db "<NEXT>Starry Shrine."
    db "<NEXT><WAIT>"
    db "@"

Text_WelcomeToTheStarry::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Starry Shrine.<PROMPT>"
    db "<NEXT>I'm Professor"
    db "<NEXT>Monster.<PROMPT>"
    db "<NEXT>I have the run of"
    db "<NEXT>the place while I<PROMPT>"
    db "<NEXT>study monsters and"
    db "<NEXT>their breeding.<PROMPT>"
    db "<NEXT>I can help you"
    db "<NEXT>breed monsters<PROMPT>"
    db "<NEXT>and hatch the eggs"
    db "<NEXT>that result.<PROMPT>"
    db "<NEXT>So, what do you"
    db "<NEXT>need of me today?<WAIT>"
    db "@"

Text_WelcomeToTheStarry_2::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Starry Shrine.<PROMPT>"
    db "<NEXT>What do you need"
    db "<NEXT>of me today?<WAIT>"
    db "@"

Text_ImTheProfsAssistant::
    db "<VOICE1>*: I'm the Prof's<LINE>"
    db "assistant.<PROMPT>"
    db "<NEXT>Do you want to"
    db "<NEXT>hear about the<PROMPT>"
    db "<NEXT>Starry Shrine?"
    db "<NEXT><CHOICE>"
    db "@"

Text_YouCanBreedMonsters::
    db "<VOICE1>*: You can breed<LINE>"
    db "monsters and hatch<PROMPT>"
    db "<NEXT>their eggs here at"
    db "<NEXT>the Starry Shrine.<PROMPT>"
    db "<NEXT>Breeding happens"
    db "<NEXT>when two monsters<PROMPT>"
    db "<NEXT>get married to"
    db "<NEXT>each other.<PROMPT>"
    db "<NEXT>Their egg contains"
    db "<NEXT>a monster that<PROMPT>"
    db "<NEXT>has the abilities"
    db "<NEXT>of the parents.<PROMPT>"
    db "<NEXT>We can hatch that"
    db "<NEXT>egg for you too.<PROMPT>"
    db "<NEXT>The parents will"
    db "<NEXT>go away somewhere,<PROMPT>"
    db "<NEXT>but you won't lose"
    db "<NEXT>accessories.<PROMPT>"
    db "<NEXT>Those get sent to"
    db "<NEXT>the Vault.<WAIT>"
    db "@"

Text_TalkToTheProf::
    db "<VOICE1>*: Talk to the Prof<LINE>"
    db "if you need help.<WAIT>"
    db "@"

Text_CheckedTheBookshelfBreeding::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Breeding Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>In breeding, the"
    db "<NEXT>monster chosen as<PROMPT>"
    db "<NEXT>the base sets the"
    db "<NEXT>baby's family.<PROMPT>"
    db "<NEXT>If a Slime family"
    db "<NEXT>monster is chosen<PROMPT>"
    db "<NEXT>as the base, the"
    db "<NEXT>baby will also be<PROMPT>"
    db "<NEXT>of the Slime"
    db "<NEXT>family.<PROMPT>"
    db "<NEXT>And if a Dragon"
    db "<NEXT>family monster is<PROMPT>"
    db "<NEXT>the base monster,"
    db "<NEXT>the baby will also<PROMPT>"
    db "<NEXT>be of the Dragon"
    db "<NEXT>family.", $95, "<WAIT>"
    db "@"

Text_CheckedTheBookshelfBreeding_2::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Breeding Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>In breeding, the"
    db "<NEXT>families and the<PROMPT>"
    db "<NEXT>species of the"
    db "<NEXT>parents determine<PROMPT>"
    db "<NEXT>the species of the"
    db "<NEXT>baby.<PROMPT>"
    db "<NEXT>Changing the mix"
    db "<NEXT>of families and<PROMPT>"
    db "<NEXT>species results in"
    db "<NEXT>different babies.", $95, "<WAIT>"
    db "@"

Text_Empty_9::
    db $ea

Text_Empty_10::
    db $f0
    ds $112, $00
