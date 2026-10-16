; ROM bank $F0: link sessions, family bands, gift effects
; The annotated listing of this bank is build/listing/bankf0.asm.

SECTION "Bank F0", ROMX[$4000], BANK[$F0]
    db $f0

; Starts the message wStringIndex of category wStringCategory from this bank first string table
; (BeginStringDisplay_BankF0_StringCategories: inn, shop and vault messages such as 'Will you stay
; with us tonight?') by calling BeginStringDisplay with DE = that table; the text printer then draws
; it. Far-called by DebugMessageTest_Update_ShowBankF0 and listed in StartMessageForGroup_Data for
; message modes 1 and 2. (C1, E-0385)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_BankF0)
BeginStringDisplay_BankF0::
    ld de, BeginStringDisplay_BankF0_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_BankF0_StringCategories::
    dw StringList_BankF0_StringCategories_0 ; id 0

; category list of BeginStringDisplay_BankF0_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_BankF0_StringCategories_0::
    dw Text_ItsGANight ; id 0
    dw Text_WellThenHaveA ; id 1
    dw Text_PleaseComeStayAnother ; id 2
    dw Text_SorryButYouLack ; id 3
    dw Text_GoodMorningAndFarewell ; id 4
    dw Text_WelcomeToMyShop ; id 5
    dw Text_WhatWouldYouLike ; id 6
    dw Text_YouHaveNoMore ; id 7
    dw Text_IsThereAnythingElse_2 ; id 8
    dw Text_HowManyWouldYou ; id 9
    dw Text_BufChoice ; id 10
    dw Text_ThankYou ; id 11
    dw Text_OhYoureShortSome ; id 12
    dw Text_YouCantCarryAny ; id 13
    dw Text_WhatWouldYouLike_2 ; id 14
CopyNameStringFromBank08Database_Data::
    dw Text_YouHaveNoItems ; id 15
    dw Text_SorryButICant ; id 16
    dw Text_HowManyWillYou ; id 17
    dw Text_ThankYouPleaseCome ; id 18
    dw Text_YouCantCarryAny_2 ; id 19
    dw Text_ThatComesToG ; id 20
    dw Text_ThisIsTheVault ; id 21
    dw Text_WhatShouldWeStore ; id 22
    dw Text_YouDontHaveAny ; id 23
    dw Text_IsThereAnythingElse_3 ; id 24
    dw Text_SorryButYouFilled ; id 25
    dw Text_WhatItemShouldI ; id 26
    dw Text_HowManyShouldI ; id 27
    dw Text_OKIllPutThat ; id 28
    dw Text_ICantStoreThat ; id 29
    dw Text_YouDontHaveEnough_3 ; id 30
    dw Text_HowMuchDoYou ; id 31
    dw Text_WhatWillYouBe ; id 32
    dw Text_IDontHaveAny ; id 33
    dw Text_YouCantCarryAny_3 ; id 34
    dw Text_WhatDoYouWant ; id 35
    dw Text_HowManyDoYou ; id 36
    dw Text_HereYouGo ; id 37
    dw Text_YouCantCarryThat ; id 38
    dw Text_IDontHaveAny_2 ; id 39
    dw Text_HowMuchGoldWill ; id 40
    dw Text_SorryButICant_2 ; id 41
    dw Text_SorryButICant_2 ; id 42
    dw Text_SorryButICant_2 ; id 43
    dw Text_SorryButICant_2 ; id 44
    dw Text_ComeAgainAnytime ; id 45
    dw Text_IDontHaveAny_3 ; id 46
    dw Text_ICantStoreThat_2 ; id 47
    dw Text_ICantTakeAny ; id 48
    dw Text_ThisIsTheVault_2 ; id 49
    dw Text_WhatWouldYouLike_3 ; id 50
    dw Text_YouCantCarryAny_4 ; id 51
    dw Text_IsThereAnythingElse_4 ; id 52
    dw Text_HowManyWouldYou_2 ; id 53
    dw Text_BufChoice_2 ; id 54
    dw Text_ThankYou_2 ; id 55
    dw Text_YouDontHaveEnough_4 ; id 56
    dw Text_YouCantHoldThat ; id 57
    dw Text_WhatWouldYouLike_4 ; id 58
    dw Text_YouHaveNothingTo ; id 59
    dw Text_ICantPutA ; id 60
    dw Text_HowManyWillYou_2 ; id 61
    dw Text_ThankYouPleaseCome_2 ; id 62
    dw Text_YouCantCarryAny_5 ; id 63
    dw Text_ThatWillBeG ; id 64
    dw BeginStringDisplay_BankF0_2 ; id 65
    dw BeginStringDisplay_BankF0_2 ; id 66
    dw BeginStringDisplay_BankF0_2 ; id 67
    dw BeginStringDisplay_BankF0_2 ; id 68

Text_ItsGANight::
    db "<VOICE1>*: It's <BUF0>G a<LINE>"
    db "night.<PROMPT>"
    db "<NEXT>Will you stay with"
    db "<NEXT>us tonight?<CHOICE>"
    db "@"

Text_WellThenHaveA::
    db "<VOICE1>*: Well then, have<LINE>"
    db "a good rest.<WAIT>"
    db "@"

Text_PleaseComeStayAnother::
    db "<VOICE1>*: Please come stay<LINE>"
    db "another time.<WAIT>"
    db "@"

Text_SorryButYouLack::
    db "<VOICE1>*: Sorry, but you<LINE>"
    db "lack the money.<PROMPT>"
    db "<NEXT>I hope you'll stay"
    db "<NEXT>another time.<WAIT>"
    db "@"

Text_GoodMorningAndFarewell::
    db "<VOICE1>*: Good morning<LINE>"
    db "and farewell!<WAIT>"
    db "@"

Text_WelcomeToMyShop::
    db "<VOICE1>*: Welcome to my<LINE>"
    db "shop.<PROMPT>"
    db "<NEXT>How may I serve"
    db "<NEXT>you today?@"

Text_WhatWouldYouLike::
    db "<VOICE1>*: What would you<LINE>"
    db "like to buy?@"

Text_YouHaveNoMore::
    db "<VOICE1>*: You have no more<LINE>"
    db "room for items.<WAIT>"
    db "@"

Text_IsThereAnythingElse_2::
    db "<VOICE1>*: Is there<LINE>"
    db "anything else?@"

Text_HowManyWouldYou::
    db "<VOICE1>*: How many would<LINE>"
    db "you like to buy?@"

Text_BufChoice::
    db "<VOICE1>*: <BUF0>?<CHOICE>"
    db "@"

Text_ThankYou::
    db "<VOICE1>*: Thank you!<WAIT>"
    db "@"

Text_OhYoureShortSome::
    db "<VOICE1>*: Oh? You're short<LINE>"
    db "some gold.<WAIT>"
    db "@"

Text_YouCantCarryAny::
    db "<VOICE1>*: You can't carry<LINE>"
    db "any more items.<WAIT>"
    db "@"

Text_WhatWouldYouLike_2::
    db "<VOICE1>*: What would you<LINE>"
    db "like to sell?@"

Text_YouHaveNoItems::
    db "<VOICE1>*: You have no<LINE>"
    db "items to sell.<WAIT>"
    db "@"

Text_SorryButICant::
    db "<VOICE1>*: Sorry, but I<LINE>"
    db "can't price that.<WAIT>"
    db "@"

Text_HowManyWillYou::
    db "<VOICE1>*: How many will<LINE>"
    db "you sell?@"

Text_ThankYouPleaseCome::
    db "<VOICE1>*: Thank you!<LINE>"
    db "Please come again.<WAIT>"
    db "@"

Text_YouCantCarryAny_2::
    db "<VOICE1>*: You can't carry<LINE>"
    db "any more items.<WAIT>"
    db "@"

Text_ThatComesToG::
    db "<VOICE1>*: That comes to<LINE>"
    db "<BUF0>G. OK?@"

Text_ThisIsTheVault::
    db "<VOICE1>*: This is the<LINE>"
    db "Vault.<PROMPT>"
    db "<NEXT>What can I do for"
    db "<NEXT>you today?@"

Text_WhatShouldWeStore::
    db "<VOICE1>*: What should we<LINE>"
    db "store for you?@"

Text_YouDontHaveAny::
    db "<VOICE1>*: You don't have<LINE>"
    db "any items.<WAIT>"
    db "@"

Text_IsThereAnythingElse_3::
    db "<VOICE1>*: Is there<LINE>"
    db "anything else?@"

Text_SorryButYouFilled::
    db "<VOICE1>*: Sorry, but you<LINE>"
    db "filled the Vault.<WAIT>"
    db "@"

Text_WhatItemShouldI::
    db "<VOICE1>*: What item should<LINE>"
    db "I store for you?@"

Text_HowManyShouldI::
    db "<VOICE1>*: How many should<LINE>"
    db "I store?@"

Text_OKIllPutThat::
    db "<VOICE1>*: OK, I'll put<LINE>"
    db "that away for you.<WAIT>"
    db "@"

Text_ICantStoreThat::
    db "<VOICE1>*: I can't store<LINE>"
    db "that much.<WAIT>"
    db "@"

Text_YouDontHaveEnough_3::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough to store.<WAIT>"
    db "@"

Text_HowMuchDoYou::
    db "<VOICE1>*: How much do you<LINE>"
    db "want to deposit?@"

Text_WhatWillYouBe::
    db "<VOICE1>*: What will you be<LINE>"
    db "taking out?@"

Text_IDontHaveAny::
    db "<VOICE1>*: I don't have any<LINE>"
    db "of your items.<WAIT>"
    db "@"

Text_YouCantCarryAny_3::
    db "<VOICE1>*: You can't carry<LINE>"
    db "any more items.<WAIT>"
    db "@"

Text_WhatDoYouWant::
    db "<VOICE1>*: What do you want<LINE>"
    db "back?@"

Text_HowManyDoYou::
    db "<VOICE1>*: How many do you<LINE>"
    db "want back?@"

Text_HereYouGo::
    db "<VOICE1>*: Here you go.<WAIT>"
    db "@"

Text_YouCantCarryThat::
    db "<VOICE1>*: You can't carry<LINE>"
    db "that much.<WAIT>"
    db "@"

Text_IDontHaveAny_2::
    db "<VOICE1>*: I don't have any<LINE>"
    db "of your money.<WAIT>"
    db "@"

Text_HowMuchGoldWill::
    db "<VOICE1>*: How much gold<LINE>"
    db "will you withdraw?@"

Text_SorryButICant_2::
    db "<VOICE1>*: Sorry, but I<LINE>"
    db "can't take another<PROMPT>"
    db "<NEXT>kind of item."
    db "<NEXT>There's no room.<WAIT>"
    db "@"

Text_ComeAgainAnytime::
    db "<VOICE1>*: Come again<LINE>"
    db "anytime!<WAIT>"
    db "@"

Text_IDontHaveAny_3::
    db "<VOICE1>*: I don't have any<LINE>"
    db "more items.<WAIT>"
    db "@"

Text_ICantStoreThat_2::
    db "<VOICE1>*: I can't store<LINE>"
    db "that many.<WAIT>"
    db "@"

Text_ICantTakeAny::
    db "<VOICE1>*: I can't take any<LINE>"
    db "more of that item.<WAIT>"
    db "@"

Text_ThisIsTheVault_2::
    db "<VOICE1>*: This is the<LINE>"
    db "Vault.<PROMPT>"
    db "<NEXT>How may I help you"
    db "<NEXT>today?@"

Text_WhatWouldYouLike_3::
    db "<VOICE1>*: What would you<LINE>"
    db "like to buy?@"

Text_YouCantCarryAny_4::
    db "<VOICE1>*: You can't carry<LINE>"
    db "any more items.<WAIT>"
    db "@"

Text_IsThereAnythingElse_4::
    db "<VOICE1>*: Is there<LINE>"
    db "anything else?@"

Text_HowManyWouldYou_2::
    db "<VOICE1>*: How many would<LINE>"
    db "you like?@"

Text_BufChoice_2::
    db "<VOICE1>*: <BUF0>?<CHOICE>"
    db "@"

Text_ThankYou_2::
    db "<VOICE1>*: Thank you!<WAIT>"
    db "@"

Text_YouDontHaveEnough_4::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough gold.<WAIT>"
    db "@"

Text_YouCantHoldThat::
    db "<VOICE1>*: You can't hold<LINE>"
    db "that many items.<WAIT>"
    db "@"

Text_WhatWouldYouLike_4::
    db "<VOICE1>*: What would you<LINE>"
    db "like to sell?@"

Text_YouHaveNothingTo::
    db "<VOICE1>*: You have nothing<LINE>"
    db "to sell me.<WAIT>"
    db "@"

Text_ICantPutA::
    db "<VOICE1>*: I can't put a<LINE>"
    db "price on that.<WAIT>"
    db "@"

Text_HowManyWillYou_2::
    db "<VOICE1>*: How many will<LINE>"
    db "you sell?@"

Text_ThankYouPleaseCome_2::
    db "<VOICE1>*: Thank you!<LINE>"
    db "Please come again!<WAIT>"
    db "@"

Text_YouCantCarryAny_5::
    db "<VOICE1>*: You can't carry<LINE>"
    db "any more items.<WAIT>"
    db "@"

Text_ThatWillBeG::
    db "<VOICE1>*: That will be<LINE>"
    db "<BUF0>G. OK?@"

; Starts the message wStringIndex of category wStringCategory from this bank second string table
; (BeginStringDisplay_BankF0_2_StringCategories: the Dream Egg exchange messages such as 'Obtain a
; Dream Egg from ...?') by calling BeginStringDisplay with DE = that table. Called by
; ShowString_BankF0 and BeginString_BankF0_Cat0 and far-called by
; DebugMessageTest_Update_ShowBankF0Second. (C1, E-0385)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_BankF0_2)
BeginStringDisplay_BankF0_2::
    ld de, BeginStringDisplay_BankF0_2_StringCategories
    call BeginStringDisplay
    ret
    db $11, $b5, $48, $cd, $fe, $25, $c9

; Calls BeginStringDisplay_BankF0_2 and then RunStringDisplayToEnd, so the message chosen by
; wStringCategory and wStringIndex is drawn whole at once (wTextFlags bit 1 set) instead of one
; glyph per frame. The Dream Egg screens use it for the small tile texts such as 'Info / OK' and
; 'Yes / No'. (C1, E-0385)
; BeginStringDisplay_BankF0_2 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_BankF0::
    call BeginStringDisplay_BankF0_2
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_BankF0_2_StringCategories::
    dw StringList_BankF0_2_StringCategories_0 ; id 0

; category list of BeginStringDisplay_BankF0_2_StringCategories; one pointer per wStringIndex
; (E-0217)
; record: string
StringList_BankF0_2_StringCategories_0::
    dw Text_ObtainADreamEgg ; id 0
    dw Text_GiveADreamEgg ; id 1
    dw Text_RefusedToAcceptA ; id 2
    dw Text_YourDreamEggWas ; id 3
    dw Text_ChooseTheKindOf ; id 4
    dw Text_ChooseTheEggTo ; id 5
    dw Text_IsItOKTo_5 ; id 6
    dw Text_OKToSaveThe ; id 7
    dw Text_PleaseWait_4 ; id 8
    dw Text_ReceivedYourEgg ; id 9
    dw Text_ObtainedAnEggFrom ; id 10
    dw Text_EggsWereTradedWith ; id 11
    dw Text_HatchedFromTheEgg ; id 12
    dw Text_HatchedFromTheEgg_2 ; id 13
    dw Text_ReceivedSEggPlease ; id 14
    dw Text_YouHaveNoEggs ; id 15
    dw Text_YouHaveNoEggs ; id 16
    dw Text_YouHaveNoEggs ; id 17
    dw Text_PleaseWait_5 ; id 18
    dw Text_HasNoDreamEgg ; id 19
    dw Text_ThereIsNoMore ; id 20
    dw Text_YouHaveAnEgg ; id 21
    dw Text_AlreadyHasADream ; id 22
    dw Text_GiftExit ; id 23
    dw Text_GiftExit ; id 24
    dw Text_GiftExit ; id 25
    dw Text_GiftExit ; id 26
    dw Text_GiftExit ; id 27
    dw Text_StoreGet ; id 28
    dw Text_AllyStore ; id 29
    dw Text_InfoOK_2 ; id 30
    dw Text_YesNo_2 ; id 31
    dw Text_ChooseWhatToGive ; id 32
    dw Text_IsInFrontOf ; id 33
    dw Text_CantBeGivenTo ; id 34

Text_ObtainADreamEgg::
    db "<VOICE1>Obtain a Dream Egg<LINE>"
    db "from <BUF3>?@"

Text_GiveADreamEgg::
    db "<VOICE1>Give a Dream Egg<LINE>"
    db "to <BUF3>?@"

Text_RefusedToAcceptA::
    db "<VOICE1>Refused to accept<LINE>"
    db "a Dream Egg.<WAIT>"
    db "@"

Text_YourDreamEggWas::
    db "<VOICE1>Your Dream Egg was<LINE>"
    db "rejected.<WAIT>"
    db "@"

Text_ChooseTheKindOf::
    db "<VOICE1>Choose the kind of<LINE>"
    db "egg to transfer.@"

Text_ChooseTheEggTo::
    db "<VOICE1>Choose the egg to<LINE>"
    db "be transferred.@"

Text_IsItOKTo_5::
    db "<VOICE1>Is it OK to<LINE>"
    db "transfer the egg?@"

Text_OKToSaveThe::
    db "<VOICE1>OK to save the egg<LINE>"
    db "trade results?@"

Text_PleaseWait_4::
    db "<VOICE1>Please wait…@"

Text_ReceivedYourEgg::
    db "<VOICE1><BUF0> received<LINE>"
    db "your egg.<WAIT>"
    db "@"

Text_ObtainedAnEggFrom::
    db "<VOICE1>Obtained an egg<LINE>"
    db "from <BUF0>.<WAIT>"
    db "@"

Text_EggsWereTradedWith::
    db "<VOICE1>Eggs were traded<LINE>"
    db "with <BUF0>.<WAIT>"
    db "@"

Text_HatchedFromTheEgg::
    db "<VOICE1><BUF1> hatched<LINE>"
    db "from the egg that<PROMPT>"
    db "<NEXT>you put up for"
    db "<NEXT>transfer.<PROMPT>"
    db "<NEXT>Please name your"
    db "<NEXT><BUF1>.<WAIT>"
    db "@"

Text_HatchedFromTheEgg_2::
    db "<VOICE1><BUF1> hatched<LINE>"
    db "from the egg that<PROMPT>"
    db "<NEXT>you were about to"
    db "<NEXT>receive.<PROMPT>"
    db "<NEXT><BUF1> went"
    db "<NEXT>back to <BUF0>.<WAIT>"
    db "@"

Text_ReceivedSEggPlease::
    db "<VOICE1><BUF0> received<LINE>"
    db "<BUF1>", $95, "s egg.<PROMPT>"
    db "<NEXT>Please raise it"
    db "<NEXT>with loving care.<WAIT>"
    db "@"

Text_YouHaveNoEggs::
    db "<VOICE1>You have no eggs.<WAIT>"
    db "@"

Text_PleaseWait_5::
    db "<VOICE1>Please wait…@"

Text_HasNoDreamEgg::
    db "<VOICE1><BUF3> has no Dream<LINE>"
    db "Egg to trade you.<WAIT>"
    db "@"

Text_ThereIsNoMore::
    db "<VOICE1>There is no more<LINE>"
    db "room for eggs.<PROMPT>"
    db "<NEXT>Trading is not"
    db "<NEXT>possible.<WAIT>"
    db "@"

Text_YouHaveAnEgg::
    db "<VOICE1>You have an egg<LINE>"
    db "already.<PROMPT>"
    db "<NEXT>Trading is not"
    db "<NEXT>possible.<WAIT>"
    db "@"

Text_AlreadyHasADream::
    db "<VOICE1><BUF3> already has<LINE>"
    db "a Dream Egg.<WAIT>"
    db "@"

Text_GiftExit::
    db "GiftExit@"

Text_StoreGet::
    db "Store  Get@"

Text_AllyStore::
    db "Ally Store@"

Text_InfoOK_2::
    db "InfoOK@"

Text_YesNo_2::
    db "YesNo@"

Text_ChooseWhatToGive::
    db "Choose what to<LINE>"
    db "give the egg.@"

Text_IsInFrontOf::
    db "<BUF2> is in<LINE>"
    db "front of the egg.<WAIT>"
    db "@"

Text_CantBeGivenTo::
    db "<BUF2> can't be<LINE>"
    db "given to an egg.<WAIT>"
    db "@"

; Link session 8's screen (the dream egg exchange): sets wTitleScreenState 1, waits for the fade and
; (outside state 4) the text, then runs state wScreenState: choosing, the egg list, Info / OK, the
; records, the message, saving, the exchange, the scenes, 'obtained an egg', 'eggs were traded',
; 'hatched' and waiting. (C1, E-0357)
RunLinkSession8Exchange_Receive_DreamEggScreen::
    ld a, $01
    ld [wTitleScreenState], a
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    cp $04
    jr z, .read_screen_state
    ld a, [wTextFlags]
    bit 0, a
    ret nz

.read_screen_state:
    ld a, [wScreenState]
    jumptable
    dw DreamEggs_State0
    dw DreamEggs_State1
    dw DreamEggs_State2
    dw DreamEggs_RecordScreen
    dw RunLinkSession8Exchange_ShowMessage
    dw RunLinkSession8Exchange_Saving
    dw RunLinkSession8Exchange_Trade
    dw RunLinkSession8Exchange_GivingScene
    dw RunLinkSession8Exchange_ObtainedEgg
    dw RunLinkSession8Exchange_EggsTraded
    dw HatchingScene
    dw RunLinkSession8Exchange_EggHatched
    dw RunLinkSession8Exchange_WaitForPartner

; Dream eggs, state 0: when the partner sends $BD (cancel) goes to the message state 4 answering
; $BB; otherwise the opening steps. (C1, E-0357)
DreamEggs_State0::
    ld a, [wLinkMessage]
    cp $bd
    jr nz, .read_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $bb
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    jumptable
    dw DreamEggs_State0_SendSync
    dw DreamEggs_State0_WaitSync
    dw DreamEggs_State0_StartNameSwap
    dw DreamEggs_State0_WaitNameSwap
    dw DreamEggs_State0_CopyPartnerName
    dw DreamEggs_State0_AskGiveOrObtain
    dw DreamEggs_State0_DrawYesNoBox
    dw RunLinkSession8Exchange_ReadSaveAnswer

; State 0, step 0: sends $BA. (C2, E-0357; probed E-0385)
DreamEggs_State0_SendSync::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $ba
    ld [wLinkSendByte], a
    ret

; State 0, step 1: on the partner's $BA goes on. (C2, E-0357; probed E-0385)
DreamEggs_State0_WaitSync::
    ld a, [wLinkMessage]
    cp $ba
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; State 0, step 2: copies the player's name (up to 10 bytes, then $F0) to wLinkRecvBuffer, stores
; wPlayerId in wLinkEggFamilyBit (wLinkRecvBuffer + 12), then starts a 12-byte link exchange: source
; wLinkRecvBuffer (kept in wLinkTimeoutLo/Hi), destination wLinkPartnerName (wLinkBufferPtrLo/Hi),
; count wLinkBufferCountLo/Hi, wLinkSendByte = $FF and wLinkReady = 1. (C2, E-0371; probed E-0385)
DreamEggs_State0_StartNameSwap::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wPlayerName
    ld de, wLinkRecvBuffer
    ld c, $0a

.loop:
    ld a, [hl]
    cp $f0
    jr z, .read_player_id
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.read_player_id:
    ld a, $f0
    ld [de], a
    ld a, [wPlayerId]
    ld [wLinkEggFamilyBit], a
    ld hl, $000c
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; State 0, step 3: when the exchange ends ($F0) goes on. (C2, E-0357; probed E-0385)
DreamEggs_State0_WaitNameSwap::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; State 0, step 4: copies the partner's name into wTextBuf3. (C2, E-0357; probed E-0385)
DreamEggs_State0_CopyPartnerName::
    ld hl, wLinkPartnerName
    ld de, wTextBuf3
    ld c, $0a

.loop:
    ld a, [hl]
    cp $f0
    jr z, .check_screen_step
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, .loop

.check_screen_step:
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; State 0, step 5: clears $35 bytes from wFamilyRankTaken, shows 'Yes / No' (string $1F) at VRAM
; $9700 and asks 'Give a dream egg?' (string 1) when a gift record is set, otherwise 'Obtain a dream
; egg?' (string 0). (C1, E-0357)
DreamEggs_State0_AskGiveOrObtain::
    ld hl, wFamilyRankTaken
    ld b, $35

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wStringCategory], a
    ld a, $1f
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
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wGiftRecord]
    and a
    jr z, .call_begin_string_bank_f0_cat0
    ld a, $01
    jr .call_begin_string_bank_f0_cat02

.call_begin_string_bank_f0_cat0:
    xor a

.call_begin_string_bank_f0_cat02:
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; State 0, step 6: draws the yes/no box with the cursor on yes. (C1, E-0357)
DreamEggs_State0_DrawYesNoBox::
    ld de, DreamEggs_State0_DrawYesNoBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wMenuChoice], a
    ld hl, wScreenStep
    inc [hl]
    ret

; State 0, step 7: yes goes to saving (state 5, 'OK to save the egg trade ...', string 7); no or B
; shows 'Please wait...' (string 8), goes to state 4 and sends $BD. (C1, E-0357)
RunLinkSession8Exchange_ReadSaveAnswer::
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp $ff
    jr z, .check_menu_choice
    cp $fe
    jr z, .clear_screen_step
    ret

.check_menu_choice:
    ld a, [wMenuChoice]
    and a
    jr nz, .clear_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $05
    ld [wScreenState], a
    ld a, $07 ; 'OK to save the egg trade'
    call BeginString_BankF0_Cat0
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08 ; 'Please wait…'
    call BeginString_BankF0_Cat0
    ld a, $bd
    ld [wLinkSendByte], a
    ret

; Dream eggs, state 1: the partner's cancel as in state 0; otherwise the egg list's steps
; (LinkEggList). (C1, E-0357)
DreamEggs_State1::
    ld a, [wLinkMessage]
    cp $bd
    jr nz, .call_link_egg_list
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $bb
    ld [wLinkSendByte], a
    ret

.call_link_egg_list:
    call LinkEggList
    ret

; Dream eggs, state 2 (the chosen egg): the partner's cancel as in state 0; otherwise its six steps.
; (C1, E-0357)
DreamEggs_State2::
    ld a, [wLinkMessage]
    cp $bd
    jr nz, .read_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $bb
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    jumptable
    dw DreamEggs_State2_AskTransfer
    dw DreamEggs_State2_ShowInfoOK
    dw DreamEggs_State2_DrawInfoOKBox
    dw RunLinkSession8Exchange_InfoOrOK
    dw DreamEggs_State2_ShowAllyStore
    dw DreamEggs_State2_BackToList

; State 2, step 0: 'Is it OK to transfer the ...' (string 6). (C1, E-0357)
DreamEggs_State2_AskTransfer::
    ld a, $06 ; 'Is it OK to transfer the'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; State 2, step 1: draws the box, marks the list entry and shows 'Info / OK' (string $1E, 9 x 1 at
; VRAM $9700). (C1, E-0357)
DreamEggs_State2_ShowInfoOK::
    ld de, DreamEggs_State2_ShowInfoOK_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $bc
    ld hl, DreamEggs_State2_ShowInfoOK_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wStringCategory], a
    ld a, $1e
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
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; State 2, step 2: draws the box with the cursor on the first choice. (C1, E-0357)
DreamEggs_State2_DrawInfoOKBox::
    ld de, DreamEggs_State2_DrawInfoOKBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wMenuChoice], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; State 2, step 3: A on Info goes to the records (state 3); A on OK goes to saving ('OK to save the
; egg trade ...', state 5, screen kind 0); B shows 'Choose the egg to be transferred.' (string 5)
; and goes on. (C1, E-0357)
RunLinkSession8Exchange_InfoOrOK::
    xor a
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp $ff
    jr z, .check_menu_choice
    cp $fe
    jr z, .call_begin_string_bank_f0_cat02
    ret

.check_menu_choice:
    ld a, [wMenuChoice]
    and a
    jr nz, .call_begin_string_bank_f0_cat0
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld hl, wScreenState
    inc [hl]
    ret

.call_begin_string_bank_f0_cat0:
    ld a, $07 ; 'OK to save the egg trade'
    call BeginString_BankF0_Cat0
    xor a
    ld [wScreenStep], a
    ld a, $05
    ld [wScreenState], a
    xor a
    ld [wF0ScreenKind], a
    ret

.call_begin_string_bank_f0_cat02:
    ld a, $05 ; 'Choose the egg to be transferred.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; State 2, step 4 (back): redraws, clears the entry mark and shows 'Ally / Store' (string $1D, 7 x
; 1). (C1, E-0357)
DreamEggs_State2_ShowAllyStore::
    ld de, DreamEggs_State2_ShowAllyStore_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_BankF0
    ld a, [wListCursor]
    ld b, $c3
    ld hl, DreamEggs_State2_ShowInfoOK_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wStringCategory], a
    ld a, $1d
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
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; State 2, step 5: draws the Ally / Store box with the choice marked and returns to the list (state
; 1, step 6). (C1, E-0357)
DreamEggs_State2_BackToList::
    ld de, DreamEggs_State2_BackToList_TileRect
    ld hl, wWindowTileBuffer + $125
    lb bc, $07, $04
    call CopyRectTo20ByteRows_BankF0
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, DreamEggs_State2_BackToList_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenState], a
    ld a, $06
    ld [wScreenStep], a
    ret

; Dream eggs, state 3: the record screen (LinkRecordScreen). (C1, E-0357)
DreamEggs_RecordScreen::
    call LinkRecordScreen
    ret

; Dream Egg screen state 4, the closing message of an exchange that is cancelled or finished: runs
; the step for wScreenStep: 0 RunLinkSession8Exchange_ShowMessage_ShowStopReason (the reason message
; after the partner cancels), 1 RunLinkSession8Exchange_ShowMessage_SendReady, 2
; RunLinkSession8Exchange_ShowMessage_PartnerReady, 3
; RunLinkSession8Exchange_ShowMessage_WaitTextFlags (back to the link menu). (C1, E-0385)
; shows a category-0 string, then text waits
RunLinkSession8Exchange_ShowMessage::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession8Exchange_ShowMessage_ShowStopReason
    dw RunLinkSession8Exchange_ShowMessage_SendReady
    dw RunLinkSession8Exchange_ShowMessage_PartnerReady
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags

; The message, step 1: after the text sends 1. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_ShowMessage_SendReady::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The message, step 2: after the text, on the partner's 1 goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_ShowMessage_PartnerReady::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The message, step 0: on the partner's $BB or $BD shows why the exchange stopped (string 2, or 3
; when this side cancelled first or has link role bit 1) and goes on. (C1, E-0357)
RunLinkSession8Exchange_ShowMessage_ShowStopReason::
    ld a, [wLinkMessage]
    cp $bb
    jr z, .clear_link_send_byte
    cp $bd
    ret nz
    ld a, [wLinkSendByte]
    cp $bb
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
    xor a
    ld [wLinkSendByte], a
    ld a, b
    call BeginString_BankF0_Cat0
    ld hl, wScreenStep
    inc [hl]
    ret

; The message, step 3: after the text clears $6F bytes of screen state, selects WRAM bank 0 and
; returns to game mode 5, state 1 (the link menu). (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_ShowMessage_WaitTextFlags::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    xor a
    ldh [rSVBK], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; Dream eggs, state 5 (saving): the partner's cancel as in state 0; otherwise its six steps. (C1,
; E-0357)
RunLinkSession8Exchange_Saving::
    ld a, [wLinkMessage]
    cp $bd
    jr nz, .read_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $bb
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession8Exchange_Saving_DrawYesNo
    dw RunLinkSession8Exchange_Saving_DrawWindow
    dw RunLinkSession8Exchange_Saving_ShowSaveInfo
    dw RunLinkSession8Exchange_Saving_DrawBottomBox
    dw RunLinkSession8Exchange_Saving_RedrawYesNo
    dw RunLinkSession8Exchange_Saving_ReadAnswer

; Saving, step 1: draws the 20 x 11 save window (CopyRectToWindowTileBufferRow5AndDraw). (C1,
; E-0357)
RunLinkSession8Exchange_Saving_DrawWindow::
    farcall CopyRectToWindowTileBufferRow5AndDraw
    ld hl, wScreenStep
    inc [hl]
    ret

; Saving, step 2: shows the save file's details (ShowSaveFileInfoWindow) and sets wPickCount 1. (C1,
; E-0357)
RunLinkSession8Exchange_Saving_ShowSaveInfo::
    farcall ShowSaveFileInfoWindow
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wPickCount], a
    ret

; Saving, step 3: draws the link bottom box and resets the text window. (C1, E-0357)
RunLinkSession8Exchange_Saving_DrawBottomBox::
    farcall DrawBottomBoxForLinkAndSetScreenSubStep
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; Saving, step 0: moves a 13 x 9 area of the screen buffer, loads two tiles, draws the yes/no box
; and shows 'Yes / No' (string $1F), cursor on yes. (C1, E-0357)
RunLinkSession8Exchange_Saving_DrawYesNo::
    ld c, $09
    ld hl, $01d3
    ld de, $0007
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, Tiles1Plus6A0Tiles
    ld hl, vTiles1 + $6a0
    ld b, BANK(Tiles1Plus6A0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7D0Tiles
    ld hl, vTiles1 + $6d0
    ld b, BANK(Tiles1Plus7D0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, RunLinkSession8Exchange_Saving_DrawYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wStringCategory], a
    ld a, $1f
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
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wMenuChoice], a
    ld hl, wScreenStep
    inc [hl]
    ret

; Saving, step 4: draws the yes/no box with the cursor on yes. (C1, E-0357)
RunLinkSession8Exchange_Saving_RedrawYesNo::
    ld de, DreamEggs_State0_DrawYesNoBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    xor a
    ld [wMenuChoice], a
    ld hl, wScreenStep
    inc [hl]
    ret

; Saving, step 5: yes shows 'Please wait...' and goes on to the exchange (state 6); no or B shows
; 'Please wait...', goes to state 4 and sends $BD. (C1, E-0357)
RunLinkSession8Exchange_Saving_ReadAnswer::
    ld a, $02
    ld [wArg2], a
    call HandleTwoChoiceCursorInput_F0
    ld a, [wMenuInputResult]
    cp $ff
    jr z, .check_menu_choice
    cp $fe
    jr z, .clear_screen_step
    ret

.check_menu_choice:
    ld a, [wMenuChoice]
    and a
    jr nz, .clear_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $08 ; 'Please wait…'
    call BeginString_BankF0_Cat0
    ld hl, wScreenState
    inc [hl]
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $08 ; 'Please wait…'
    call BeginString_BankF0_Cat0
    ld a, $bd
    ld [wLinkSendByte], a
    ret

; Dream eggs, state 6 (the exchange): the partner's cancel as in state 0; otherwise its 28 steps of
; handshakes and record exchanges. (C1, E-0357)
RunLinkSession8Exchange_Trade::
    ld a, [wLinkMessage]
    cp $bd
    jr nz, .read_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $04
    ld [wScreenState], a
    ld a, $bb
    ld [wLinkSendByte], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession8Exchange_Trade_Pack
    dw RunLinkSession8Exchange_Trade_SendSync
    dw RunLinkSession8Exchange_Trade_WaitSync
    dw RunLinkSession8Exchange_Trade_StartFlagSwap
    dw RunLinkSession8Exchange_Trade_WaitSwapEnd
    dw RunLinkSession8Exchange_Trade_CheckPartnerEgg
    dw RunLinkSession8Exchange_Trade_Abort
    dw RunLinkSession8Exchange_Trade_SendSync
    dw RunLinkSession8Exchange_Trade_WaitSync
    dw RunLinkSession8Exchange_Trade_StartRecordSwap
    dw RunLinkSession8Exchange_Trade_WaitSwapEnd
    dw RunLinkSession8Exchange_Trade_SendSync
    dw RunLinkSession8Exchange_Trade_WaitSync
    dw RunLinkSession8Exchange_Trade_StartBlockSwap
    dw RunLinkSession8Exchange_Trade_WaitSwapEnd
    dw RunLinkSession8Exchange_Trade_SendSync
    dw RunLinkSession8Exchange_Trade_WaitSync
    dw RunLinkSession8Exchange_Trade_RankFamilies
    dw RunLinkSession8Exchange_Trade_WaitSwapEnd
    dw RunLinkSession8Exchange_Trade_PickScene
    dw RunLinkSession8Exchange_Trade_StoreReceived
    dw RunLinkSession8Exchange_Trade_SendStoredSync
    dw RunLinkSession8Exchange_Trade_WaitStoredSync
    dw RunLinkSession8Exchange_Trade_SetUpScene
    dw RunLinkSession8Exchange_Trade_SendSceneReady
    dw RunLinkSession8Exchange_Trade_WaitSceneReady
    dw RunLinkSession8Exchange_Trade_SendStartSync
    dw RunLinkSession8Exchange_Trade_StartScene

; The exchange: sends $B3. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_SendStoredSync::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $b3
    ld [wLinkSendByte], a
    ret

; The exchange: when wMenuCounter is 0 sends $A8. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_SendSceneReady::
    ld a, [wMenuCounter]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $a8
    ld [wLinkSendByte], a
    ret

; The exchange: on the partner's $B3 goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_WaitStoredSync::
    ld a, [wLinkMessage]
    cp $b3
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The exchange: on the partner's $A8 goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_WaitSceneReady::
    ld a, [wLinkMessage]
    cp $a8
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The exchange: sends $B6. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_SendStartSync::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $b6
    ld [wLinkSendByte], a
    ret

; The exchange, step 27: on the partner's $B6 clears wLinkSendByte and moves to wScreenState +
; wF0ScreenKind + 1 (from state 6: 7 RunLinkSession8Exchange_GivingScene, 8
; RunLinkSession8Exchange_ObtainedEgg, 9 RunLinkSession8Exchange_EggsTraded, 10 HatchingScene, 11
; RunLinkSession8Exchange_EggHatched for kinds 0-4) with wScreenStep and wScreenSubStep 0. (C2,
; E-0371; probed E-0385)
RunLinkSession8Exchange_Trade_StartScene::
    ld a, [wLinkMessage]
    cp $b6
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wF0ScreenKind]
    ld b, a
    ld a, [wScreenState]
    add b
    inc a
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; The exchange, step 9: starts the $A5-byte record exchange: this side's gift record (or, without
; one, the empty record RunLinkSession8Exchange_Trade_StartRecordSwap_Data) out, the partner's into
; wRecordBufA. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_StartRecordSwap::
    ld a, [wGiftRecord]
    and a
    jr nz, .check_screen_step
    ld hl, RunLinkSession8Exchange_Trade_StartRecordSwap_Data
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
    ld hl, $00a5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufA
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; The exchange, step 13: starts a $D8-byte link exchange of the block at wGM2TimerFrames (which
; holds wGiftRecord from + $33) into wRecordBufB: source in wLinkTimeoutLo/Hi, destination in
; wLinkBufferPtrLo/Hi, wLinkSendByte = $FF, wLinkReady = 1. (C2, E-0371; probed E-0385)
RunLinkSession8Exchange_Trade_StartBlockSwap::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wGM2TimerFrames
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $00d8
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufB
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; The exchange, step 17: sets wLinkEggData (0; 1 behind EVENT_NEVER_SET); with an egg state ranks
; the family scores, gives the gift record its top species' growth, sets wFamilyBitCount = count x
; (8 - wRankBand) / 5 and raises that many random lowest resistances; then fills the egg data
; (species, family, the player's name) and starts a 16-byte exchange into wLinkHatchData. (C2,
; E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_RankFamilies::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .set_link_egg_data_to_01
    xor a
    jr .set_link_egg_data

.set_link_egg_data_to_01:
    ld a, $01

.set_link_egg_data:
    ld [wLinkEggData], a
    ld a, [wLinkEggState]
    and a
    jp z, .read_gift_record
    call RankFamilyScoresIntoFamilyRanking
    call GiftRecord_LoadSkillsResistancesFromSpecies
    ld a, [wFamilyBitCount]
    ld c, a
    ld a, [wRankBand]
    ld b, a
    ld a, $08
    sub b
    call Multiply8
    ld a, $05
    call DivideHLByA
    ld a, l
    ld [wFamilyBitCount], a
    call RaiseLowestResistances

.read_gift_record:
    ld a, [wGiftRecord + MON_SPECIES]
    ld [wLinkEggSpeciesLo], a
    ld a, [wGiftRecord + MON_SPECIES + 1]
    ld [wLinkEggSpeciesHi], a
    ld a, [wGiftRecord + MON_FAMILY]
    ld [wLinkEggFamily], a
    ld hl, wPlayerName
    ld de, wLinkEggExtra
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wLinkEggData
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $0010
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wLinkHatchData
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $00
    ld [wLinkReady], a
    ret

; The exchange: sends $BA. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_SendSync::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $ba
    ld [wLinkSendByte], a
    ret

; The exchange: on the partner's $BA goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_WaitSync::
    ld a, [wLinkMessage]
    cp $ba
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The exchange, step 0: packs the screen kind and the gift flag to send, marks the partner's family
; bit (MarkBitBInFamilyBitsAndCount) and rolls whether the egg improves (RollMarkChangeCountChance,
; wLinkEggState). (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_Pack::
    ld a, [wF0ScreenKind]
    ld [wLinkRecvBuffer], a
    ld a, [wGiftRecord]
    ld [wIntroOrFamilyCount], a
    ld a, [wLinkEggFamilyBit]
    ld b, a
    call MarkBitBInFamilyBitsAndCount
    call RollMarkChangeCountChance
    ld [wLinkEggState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The exchange, step 3: starts a 3-byte link exchange of the bytes
; RunLinkSession8Exchange_Trade_Pack packed at wLinkRecvBuffer (wF0ScreenKind, then the gift flag in
; wIntroOrFamilyCount, then wLinkEggState) into wLinkPartnerName, whose bytes 1 and 2 are
; wLinkPartnerByte1 and wLinkPartnerByte2; wLinkSendByte = $FF, wLinkReady = 1. (C2, E-0371; probed
; E-0385)
RunLinkSession8Exchange_Trade_StartFlagSwap::
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; The exchange: when the exchange ends ($F0) goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_WaitSwapEnd::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The exchange, step 5: when this side gives and the partner already has a dream egg shows '...
; already has a Dream Egg.' (string $16); when this side obtains and the partner has none, '... has
; no Dream Egg to ...' (string $13); otherwise skips two steps. (C1, E-0357)
RunLinkSession8Exchange_Trade_CheckPartnerEgg::
    ld a, [wGiftRecord]
    and a
    jr nz, .check_link_partner_byte1
    ld a, [wLinkPartnerByte1]
    and a
    jr z, .call_begin_string_bank_f0_cat02
    jr .read_screen_step

.check_link_partner_byte1:
    ld a, [wLinkPartnerByte1]
    and a
    jr nz, .call_begin_string_bank_f0_cat0

.read_screen_step:
    ld a, [wScreenStep]
    add $02
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

; The exchange, step 6: 'Please wait...' (string $12) and on to the message state 4 (step 1). (C1,
; E-0357)
RunLinkSession8Exchange_Trade_Abort::
    ld a, $12 ; 'Please wait…'
    call BeginString_BankF0_Cat0
    xor a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $04
    ld [wScreenState], a
    ret

; The exchange, step 19: picks the closing scene (wF0ScreenKind): 3 when the egg improved, 4 when
; the partner's byte 2 is set, 0 when this side gave an egg, otherwise 1. (C2, E-0357; probed
; E-0385)
RunLinkSession8Exchange_Trade_PickScene::
    ld a, [wLinkEggState]
    and a
    jr nz, .skip
    ld a, [wLinkPartnerByte2]
    and a
    jr nz, .skip2
    ld a, [wGiftRecord]
    and a
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
    xor a

.set_f0_screen_kind:
    ld [wF0ScreenKind], a
    ld hl, wScreenStep
    inc [hl]
    ret

; The exchange, step 20: kind 0 clears the $D8 bytes from wGM2TimerFrames; kinds 1 and 2 store the
; received record as the new gift record (first byte 1) and copy $33 bytes of wRecordBufB to
; wGM2TimerFrames; then goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_Trade_StoreReceived::
    ld a, [wF0ScreenKind]
    and a
    jr z, .skip
    cp $01
    jr z, .skip2
    cp $02
    jr z, .skip2
    cp $03
    jp z, .skip3
    jr .skip3

.skip:
    ld hl, wGM2TimerFrames
    ld b, $d8

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    jr .skip3

.skip2:
    ld hl, wRecordBufA
    ld a, $01
    ld [hl], a
    ld de, wGiftRecord
    ld b, $a5

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld hl, wRecordBufB
    ld de, wGM2TimerFrames
    ld b, $33

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    jr .skip3

.skip3:
    ld hl, wScreenStep
    inc [hl]
    xor a
    ld [wPickCount], a
    ret

; The exchange, step 23: fills the 32 x 32 BG map from BGMapAddressAtScroll_BankF0 with BGFillTile
; (FillTileRectWithArg1Tile through wArg1-wArg7), sets up the closing scene's objects
; (RunWithArg1ForF0ScreenKind), clears hSpriteWindowClipMode and goes on to the next step; returns A
; = 2 when wSGBActive is set. (C1, E-0371)
RunLinkSession8Exchange_Trade_SetUpScene::
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
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    call RunWithArg1ForF0ScreenKind
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wSGBActive]
    and a
    jr z, .return
    ld a, $02
    ret

.return:
    ret

; Dream Egg screen state 7, the closing scene when this side gave an egg (wF0ScreenKind 0): runs the
; step for wScreenSubStep (13 steps): timed waits (RunLinkSession8Exchange_GivingScene_Wait), the
; sprite moving right (RunLinkSession8Exchange_GivingScene_MoveSprite), the egg shown and hidden,
; object 1 walking left and off the screen (RunLinkSession8Exchange_GivingScene_WalkObject1,
; RunLinkSession8Exchange_GivingScene_WalkObject1Off), then
; RunLinkSession8Exchange_GivingScene_EggReceived (the message '... received your egg.') and
; RunLinkSession8Exchange_GivingScene_Save (RunSaveGameSteps, then state $0C). (C1, E-0385)
; by wScreenSubStep: timed waits and moves of field objects 1 and 5, then RunSaveGameSteps (renamed
; from RunLinkSession8Exchange_ObjectSceneThenSave from its E-0357 note, E-0367)
RunLinkSession8Exchange_GivingScene::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_MoveSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_WalkObject1
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_HideEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_WalkObject1Off
    dw RunLinkSession8Exchange_GivingScene_EggReceived
    dw RunLinkSession8Exchange_GivingScene_Save

; Giving scene, step 12: after the text saves (RunSaveGameSteps), then the waiting state $0C. (C2,
; E-0357; probed E-0385)
RunLinkSession8Exchange_GivingScene_Save::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0c
    ld [wScreenState], a
    ret

; Giving scene, step 1: moves the sprite at wSpriteSlots + $B right on three counts of four until
; $38, then sets its flag bit 1. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_GivingScene_MoveSprite::
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $38
    ret nz
    ld a, [wSpriteSlots + $d]
    set 1, a
    ld [wSpriteSlots + $d], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Giving scene, step 4: walks object 1 left on three counts of four until X $58, then sets its flag
; bit 1. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_GivingScene_WalkObject1::
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $59
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

; Giving scene, step 0: a 16-frame wait. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_GivingScene_Wait::
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    ret c
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; A scene step shared by the giving, obtained, traded, hatching and hatched scenes: sets wObject5
; byte 0 to $80 (bit 7 = shown, the script meta-sprite object) and wArg1 to 1, then advances
; wScreenSubStep. (C2, E-0371; probed E-0385)
RunLinkSession8Exchange_GivingScene_ShowEgg::
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; A scene step shared by the giving, obtained and traded scenes: clears wObject5 byte 0 (hides the
; script meta-sprite object) and wArg1, then advances wScreenSubStep. (C2, E-0371; probed E-0385)
RunLinkSession8Exchange_GivingScene_HideEgg::
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Giving scene, step 10: turns object 1 right and walks it off the screen (X $E0). (C2, E-0357;
; probed E-0385)
RunLinkSession8Exchange_GivingScene_WalkObject1Off::
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Giving scene, step 11: '<name> received your egg.' (string 9) and resets the save steps. (C1,
; E-0357)
RunLinkSession8Exchange_GivingScene_EggReceived::
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wLinkEggMessageBlock
    ld de, wTextBuf0
    ld b, $0a
    call CopyStringMaxBToDE
    ld a, $09 ; '0 received your egg.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; Dream Egg screen state 8, the closing scene when this side obtained an egg (wF0ScreenKind 1): runs
; the step for wScreenSubStep (13 steps): timed waits, object 1 walking in, the egg shown and
; hidden, the sprite moving in and off the screen (RunLinkSession8Exchange_GivingScene_MoveSprite,
; RunLinkSession8Exchange_ObtainedEgg_MoveSpriteOff), then
; RunLinkSession8Exchange_ObtainedEgg_ShowObtained (the message 'Obtained an egg from ...') and
; RunLinkSession8Exchange_GivingScene_Save. (C1, E-0385)
; by wScreenSubStep: an object animation, then 'Obtained an egg from 0.'
RunLinkSession8Exchange_ObtainedEgg::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_WalkObject1
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_MoveSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_HideEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_ObtainedEgg_MoveSpriteOff
    dw RunLinkSession8Exchange_ObtainedEgg_ShowObtained
    dw RunLinkSession8Exchange_GivingScene_Save

; Obtaining scene, step 10: turns the sprite at wSpriteSlots + $B left and moves it off the screen
; ($E0). (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_ObtainedEgg_MoveSpriteOff::
    ld a, [wSpriteSlots + $d]
    res 1, a
    ld [wSpriteSlots + $d], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Obtaining scene, step 11: 'Obtained an egg from <name>.' (string $0A) and resets the save steps.
; (C1, E-0357)
RunLinkSession8Exchange_ObtainedEgg_ShowObtained::
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wLinkEggMessageBlock
    ld de, wTextBuf0
    ld b, $0a
    call CopyStringMaxBToDE
    ld a, $0a ; 'Obtained an egg from 0.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; Dream Egg screen state 9, a closing scene for 'Eggs were traded with ...' (wF0ScreenKind 2): runs
; the step for wScreenSubStep (17 steps): the egg is shown and hidden twice, object 1 and the sprite
; leave (RunLinkSession8Exchange_EggsTraded_MoveOff), then
; RunLinkSession8Exchange_EggsTraded_ShowTraded (the message) and
; RunLinkSession8Exchange_GivingScene_Save. RunLinkSession8Exchange_Trade_PickScene only picks kinds
; 0, 1, 3 and 4, so no code read here enters this state. (C1, E-0385)
; by wScreenSubStep: an object animation, then 'Eggs were traded with 0.'
RunLinkSession8Exchange_EggsTraded::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_MoveSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_WalkObject1
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_HideEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_HideEgg
    dw RunLinkSession8Exchange_EggsTraded_MoveOff
    dw RunLinkSession8Exchange_EggsTraded_ShowTraded
    dw RunLinkSession8Exchange_GivingScene_Save

; Trading scene, step 14: clears flag bit 1 of the sprite at wSpriteSlots and of wObject1, moves
; wObject1 right (EggsTraded_MoveOff_StepObject1Right) and the sprite left
; (EggsTraded_MoveOff_StepSpriteLeft). Only the sprite ends the step: wScreenSubStep += 1 when the
; sprite X reaches $E0; the X of wObject1 is not tested. (C2, E-0385)
RunLinkSession8Exchange_EggsTraded_MoveOff::
    ld a, [wSpriteSlots + $d]
    res 1, a
    ld [wSpriteSlots + $d], a
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    call EggsTraded_MoveOff_StepObject1Right
    call EggsTraded_MoveOff_StepSpriteLeft
    cp $ff
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Part of RunLinkSession8Exchange_EggsTraded_MoveOff. Sets the sprite state (wSpriteSlots + $7) to
; 3; when the counter wSpriteSlots + $9 & 3 is non-zero decrements the sprite X (wSpriteSlots + $B)
; and returns A = $FF when it reaches $E0; otherwise A = 0. (C2, E-0385)
; wSpriteSlots + $7 = 3; while wSpriteSlots + $9 & 3 is set, wSpriteSlots + $B -= 1 and A = $FF once
; it reaches $E0; otherwise A = 0 (E-0126)
EggsTraded_MoveOff_StepSpriteLeft::
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    jr z, .return_0
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $e0
    jr nz, .return_0
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; Part of RunLinkSession8Exchange_EggsTraded_MoveOff. Sets wObject1 + OBJ_STATE to 1; when wObject1
; + OBJ_ANIM_COUNTER & 3 is non-zero increments wObject1 + OBJ_X (nothing stops it at $E0: the
; compare at the end has no effect). Returns A = the new X, or 0 when the counter is idle. (C2,
; E-0385)
; wObject1 + $7 = 1; while wObject1 + $9 & 3 is set, wObject1 + $B += 1 up to $E0 (E-0126)
EggsTraded_MoveOff_StepObject1Right::
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $e0
    ret nz
    ret

; Trading scene, step 15: 'Eggs were traded with <name>.' (string $0B) and resets the save steps.
; (C1, E-0357)
RunLinkSession8Exchange_EggsTraded_ShowTraded::
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wLinkEggMessageBlock
    ld de, wTextBuf0
    ld b, $0a
    call CopyStringMaxBToDE
    ld a, $0b ; 'Eggs were traded with 0.'
    call BeginString_BankF0_Cat0
    ld hl, wScreenSubStep
    inc [hl]
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; Dream Egg screen state 10, the closing scene when the egg improved (wF0ScreenKind 3): runs the
; step for wScreenSubStep (35 steps): waits, the sprite and object 1 walking, the egg shown
; (HatchingScene_ShowEgg) and hatching (HatchingScene_Hatch, HatchingScene_Bob), object 2 turning
; and walking off, the message '... hatched from the egg that you put up for transfer.' which ends
; 'Please name your ...' (HatchingScene_ShowGHatchedFromThe), the frame (HatchingScene_DrawFrame),
; the text window (HatchingScene_RunText), the egg screens (HatchingScene_RunEggScreens, game mode 6
; update), then RunLinkSession8Exchange_GivingScene_Save. (C1, E-0385)
; by wScreenSubStep: the steps of RunLinkSession8Exchange_GivingScene in another order (renamed from
; RunLinkSession8Exchange_ObjectScene from its E-0357 note, E-0367)
HatchingScene::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_MoveSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_WalkObject1
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_ShowEgg
    dw HatchingScene_TurnSpriteRight
    dw HatchingScene_Hatch
    dw HatchingScene_Bob
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Right
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Right
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_WalkObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_WalkOff
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_ShowGHatchedFromThe
    dw HatchingScene_DrawFrame
    dw HatchingScene_RunText
    dw HatchingScene_RunEggScreens
    dw RunLinkSession8Exchange_GivingScene_Save

; Hatching scene, step 32: once wMenuCounter is 0 runs the text window and goes on. (C1, E-0357)
HatchingScene_RunText::
    ld a, [wMenuCounter]
    and a
    ret nz
    call RunTextUntilTextWindowStateDone_BankF0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatching scene, step 31: draws the 20 x 13 frame, clears the battle scene, sprite count and name
; entry state and sets wMenuCounter 1. (C2, E-0357; probed E-0385)
HatchingScene_DrawFrame::
    ld de, HatchingScene_DrawFrame_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $14, $0d
    call CopyRectTo20ByteRows_BankF0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
    ld [wBattleScene], a
    ld [wSpriteSlotCount], a
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, $01
    ld [wMenuCounter], a
    ret

; Hatching scene, step 33: runs game mode 6's update with the hatch state swapped into the screen
; state (the egg screens); when it asks for a mode change switches to game mode 7, state $0A,
; sub-step $22, clearing $D8 bytes from wGM2TimerFrames and the save steps. (C1, E-0357)
HatchingScene_RunEggScreens::
    ld a, [wScreenState]
    ld l, a
    ld a, [wScreenStep]
    ld h, a
    ld a, [wScreenSubStep]
    ld e, a
    push hl
    push de
    ld a, [wLinkSceneSpeciesLo]
    ld [wScreenState], a
    ld a, [wLinkSceneSpeciesHi]
    ld [wScreenStep], a
    ld a, [wLinkSceneFamily]
    ld [wScreenSubStep], a
    farcall GameMode6_Update
    ld a, [wScreenState]
    ld [wLinkSceneSpeciesLo], a
    ld a, [wScreenStep]
    ld [wLinkSceneSpeciesHi], a
    ld a, [wScreenSubStep]
    ld [wLinkSceneFamily], a
    pop de
    pop hl
    ld a, l
    ld [wScreenState], a
    ld a, h
    ld [wScreenStep], a
    ld a, e
    ld [wScreenSubStep], a
    ld a, [wModeChangeRequest]
    and a
    ret z
    xor a
    ld [wModeChangeRequest], a
    ld a, $07
    ld [wGameMode], a
    ld a, $0a
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld a, $22
    ld [wScreenSubStep], a
    ld hl, wGM2TimerFrames
    ld bc, $00d8

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; Hatching scene, step 8: turns the sprite left and moves it to $20, then starts field command $0E
; (the egg at ($48, $40)) and stops the sprite. (C1, E-0357)
HatchingScene_ShowEgg::
    ld a, [wSpriteSlots + $d]
    res 1, a
    ld [wSpriteSlots + $d], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $20
    ret nz
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wScreenCounter], a
    ld a, [wSpriteSlots + $d]
    set 1, a
    ld [wSpriteSlots + $d], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatching scene, step 9: turns the sprite right. (C2, E-0357; probed E-0385)
HatchingScene_TurnSpriteRight::
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Sets wObject2 + OBJ_STATE to 3 (facing left in these scenes) and advances wScreenSubStep. A step
; of HatchingScene (three times) and RunLinkSession8Exchange_EggHatched (twice). (C2, E-0371; probed
; E-0385)
HatchingScene_TurnObject2Left::
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Sets wObject2 + OBJ_STATE to 1 (facing right in these scenes) and advances wScreenSubStep. A step
; of HatchingScene (twice) and RunLinkSession8Exchange_EggHatched (three times). (C2, E-0371; probed
; E-0385)
HatchingScene_TurnObject2Right::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatching scene, step 26: walks object 2 left until X $30. (C2, E-0357; probed E-0385)
HatchingScene_WalkObject2Left::
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    cp $30
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; No caller was found in src. While wObject1 + OBJ_ANIM_COUNTER & 3 is non-zero: decrements wObject1
; + OBJ_X; at X $60 runs field command $0E (RunFieldCommandTemp0), sets wObject5 + SCRIPTOBJ_X/Y to
; $48/$40 and clears wScreenCounter; when X is below $59 sets it to $58, sets flag bit 1 of wObject1
; and wScreenSubStep += 1. A variant of the egg-showing steps of the closing scenes. (C1, E-0385)
; while wObject1 + $9 & 3 is set: wObject1 + $B -= 1; at $60 runs field command $0E and sets
; wObject5 + $4/4; at $58 sets bit 1 of wObject1 + $D and wScreenSubStep += 1 (E-0125)
UnusedStepObject1LeftShowEgg::
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $60
    jr nz, .check_object1
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wScreenCounter], a

.check_object1:
    ld a, [wObject1 + OBJ_X]
    cp $59
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

; Hatching scene, step 10: counts $D9 frames (sound $74 at frame $BA), then hides the egg, adds a
; sprite slot and goes on. (C2, E-0357; probed E-0385)
HatchingScene_Hatch::
    ld a, [wScreenCounter]
    cp $ba
    jr nz, .check_screen_counter
    ld a, $74
    call QueueSoundEffect

.check_screen_counter:
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $d9
    ret c
    xor a
    ld [wScreenCounter], a
    xor a
    ld [wObject5], a
    ld a, [wSpriteSlotCount]
    inc a
    ld [wSpriteSlotCount], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
    ld [wScreenStep], a
    ret

; Hatching scene, step 11: bobs object 1's Y through the offset table every four frames and turns
; the sprite right. (C2, E-0357; probed E-0385)
HatchingScene_Bob::
    ld de, wObject1 + OBJ_Y
    call StepScreenStepOffsetTableEvery4Frames
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

; Hatching scene, step 28: walks object 2 and the sprite left off the screen. (C2, E-0357; probed
; E-0385)
HatchingScene_WalkOff::
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld [wObject2 + OBJ_STATE], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatching scene, step 30: '<species> hatched from the egg that ...' (string $0C, the egg's species)
; and prepares the egg screen (hatch state 2, link breed result 1). (C1, E-0357)
HatchingScene_ShowGHatchedFromThe::
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wLinkEggSpeciesLo
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0c ; 'G hatched from the egg that'
    call BeginString_BankF0_Cat0
    xor a
    ldh [hSpriteWindowClipMode], a
    ld hl, wScreenSubStep
    inc [hl]
    ld a, $02
    ld [wLinkSceneSpeciesLo], a
    ld a, $00
    ld [wLinkSceneSpeciesHi], a
    ld a, $01
    ld [wLinkSceneFamily], a
    ld a, $01
    ld [wLinkBreedResult], a
    ret

; Dream Egg screen state 11, the closing scene when the partner byte 2 is set (wF0ScreenKind 4):
; runs the step for wScreenSubStep (32 steps): waits, object 1 walking, the egg shown
; (RunLinkSession8Exchange_EggHatched_ShowEgg) and hatching (HatchingScene_Hatch,
; RunLinkSession8Exchange_EggHatched_BobSprite), object 2 turning and walking off, then
; RunLinkSession8Exchange_EggHatched_ShowHatched (the message '... hatched from the egg that you
; were about to receive.') and RunLinkSession8Exchange_GivingScene_Save. (C1, E-0385)
; by wScreenSubStep: an object animation, then 'G hatched from the egg that ...'
RunLinkSession8Exchange_EggHatched::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_WalkObject1
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_ShowEgg
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_MoveSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_EggHatched_ShowEgg
    dw RunLinkSession8Exchange_EggHatched_TurnObject1Left
    dw HatchingScene_Hatch
    dw RunLinkSession8Exchange_EggHatched_BobSprite
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Right
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Right
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Left
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw HatchingScene_TurnObject2Right
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_EggHatched_WalkObject2
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_EggHatched_WalkOff
    dw RunLinkSession8Exchange_GivingScene_Wait
    dw RunLinkSession8Exchange_EggHatched_ShowHatched
    dw RunLinkSession8Exchange_GivingScene_Save

; Hatched scene, step 8: walks object 1 right to X $70, then starts field command $0E (the egg at
; ($48, $40)) and stops it. (C1, E-0357)
RunLinkSession8Exchange_EggHatched_ShowEgg::
    ld a, [wObject1 + OBJ_FLAGS]
    res 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $70
    ret nz
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
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

; Hatched scene, step 9: turns object 1 left. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_EggHatched_TurnObject1Left::
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatched scene, step 26: walks object 2 right until X $60. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_EggHatched_WalkObject2::
    ld a, [wObject2 + OBJ_FLAGS]
    res 1, a
    ld [wObject2 + OBJ_FLAGS], a
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp $60
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; No caller was found in src. While wSpriteSlots + $9 & 3 is non-zero: increments wSpriteSlots + $B
; (the sprite X); at X $30 runs field command $0E (RunFieldCommandTemp0), sets wObject5 +
; SCRIPTOBJ_X/Y to $48/$40 and clears wScreenCounter; at X $38 sets flag bit 1 of the sprite and
; wScreenSubStep += 1. A variant of the egg-showing steps of the closing scenes. (C1, E-0385)
; while wSpriteSlots + $9 & 3 is set: wSpriteSlots + $B += 1; at $30 runs field command $0E and sets
; wObject5 + $4/4; at $38 sets bit 1 of wSpriteSlots + $D and wScreenSubStep += 1 (E-0124)
UnusedStepSpriteRightShowEgg::
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $30
    jr nz, .check_sprite_slots
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wScreenCounter], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $b]
    cp $38
    ret nz
    ld [wSpriteSlots + $b], a
    ld a, [wSpriteSlots + $d]
    set 1, a
    ld [wSpriteSlots + $d], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatched scene step: every fourth frame adds the next offset of
; StepScreenStepOffsetTableEvery4Frames's table to wSpriteSlots + $C (the sprite's Y), advancing
; wScreenStep; the table's $80 end mark advances wScreenSubStep. (C2, E-0371; probed E-0385)
RunLinkSession8Exchange_EggHatched_BobSprite::
    ld de, wSpriteSlots + $c
    call StepScreenStepOffsetTableEvery4Frames
    ret

; Hatched scene, step 28: walks objects 1 and 2 right off the screen. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_EggHatched_WalkOff::
    ld a, [wSpriteSlots + $d]
    res 1, a
    ld [wSpriteSlots + $d], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hatched scene, step 30: '<species> hatched from the egg that <name> ...' (string $0D, the hatched
; species) and resets the save steps. (C1, E-0357)
RunLinkSession8Exchange_EggHatched_ShowHatched::
    call RunTextUntilTextWindowStateDone_BankF0
    ld hl, wLinkEggMessageBlock
    ld de, wTextBuf0
    ld b, $0a
    call CopyStringMaxBToDE
    ld hl, wLinkHatchSpeciesLo
    ld de, wTextBuf1
    call CopyNameStringFromBank08Database
    ld a, $0d ; 'G hatched from the egg that'
    call BeginString_BankF0_Cat0
    xor a
    ldh [hSpriteWindowClipMode], a
    ld hl, wScreenSubStep
    inc [hl]
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ret

; Dream Egg screen state 12 (the save is done): runs the step for wScreenStep: 0 shows 'Please
; wait...', 1 sends $BA, 2 waits for the partner $BA, 3 runs
; RunLinkSession8Exchange_ShowMessage_WaitTextFlags (back to the link menu). (C1, E-0385)
; by wScreenStep: 'Please wait', then a link message wait
RunLinkSession8Exchange_WaitForPartner::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession8Exchange_WaitForPartner_ShowWait
    dw RunLinkSession8Exchange_WaitForPartner_SendSync
    dw RunLinkSession8Exchange_WaitForPartner_WaitSync
    dw RunLinkSession8Exchange_ShowMessage_WaitTextFlags

; Waiting for the partner, step 0: 'Please wait...' (string 8). (C1, E-0357)
RunLinkSession8Exchange_WaitForPartner_ShowWait::
    ld a, $08 ; 'Please wait…'
    call BeginString_BankF0_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Waiting for the partner, step 1: sends $BA. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_WaitForPartner_SendSync::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $ba
    ld [wLinkSendByte], a
    ret

; Waiting for the partner, step 2: on the partner's $BA goes on. (C2, E-0357; probed E-0385)
RunLinkSession8Exchange_WaitForPartner_WaitSync::
    ld a, [wLinkMessage]
    cp $ba
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; DE = address of a byte (here the Y of an object or sprite). Adds 1 to wScreenCounter; every fourth
; call (counter & 3 = 0) adds the signed entry
; StepScreenStepOffsetTableEvery4Frames_Data[wScreenStep] ($FD, $FD, $FE, $00, $01, $01, $03, $03)
; to [DE] and increments wScreenStep; at the end mark $80 it increments wScreenSubStep and clears
; wScreenStep and wScreenCounter. It makes the hatching sprite bob. (C2, E-0385)
; every fourth frame adds StepScreenStepOffsetTableEvery4Frames_Data[wScreenStep] to [DE] and
; advances wScreenStep; the $80 end mark advances wScreenSubStep and resets (E-0124)
StepScreenStepOffsetTableEvery4Frames::
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    and $03
    and a
    ret nz
    ld a, [wScreenStep]
    ld hl, StepScreenStepOffsetTableEvery4Frames_Data
    add_a_to_hl
    ld a, [hl]
    cp $80
    jr z, .check_screen_sub_step
    ld b, a
    ld a, [de]
    add b
    ld [de], a
    ld hl, wScreenStep
    inc [hl]
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenCounter], a
    ret

; Nine bytes: signed steps $FD, $FD, $FE, $00, $01, $01, $03, $03 (net zero), then the end mark $80.
; Every fourth call StepScreenStepOffsetTableEvery4Frames adds entry [wScreenStep] to the byte at DE
; and increments wScreenStep; at the $80 it increments wScreenSubStep and clears wScreenStep and
; wScreenCounter. (C1, E-0381)
StepScreenStepOffsetTableEvery4Frames_Data::
    db $fd, $fd, $fe, $00, $01, $01, $03, $03, $80

; HL = source, DE = destination, B = the most bytes to copy: copies bytes until a $F0 (not copied)
; or B bytes are copied, then writes $F0 at DE. HL ends one past the last byte read and DE at the
; written $F0. The closing scenes use it to copy the name in wLinkEggMessageBlock to wTextBuf0. (C2,
; E-0385)
; copies bytes from HL to DE until a $F0 or B bytes, then writes $F0; HL and DE advance (E-0078)
CopyStringMaxBToDE::
    ld a, [hli]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    dec b
    jr nz, CopyStringMaxBToDE

.done:
    ld a, $f0
    ld [de], a
    ret

; The egg list of the Dream Egg screen (state 1, DreamEggs_State1 calls it when the partner has not
; cancelled): runs the step for wScreenStep: LinkEggList_LoadTiles, LinkEggList_ListEggs,
; LinkEggList_ClearText, LinkEggList_DrawPageFrame, LinkEggList_DrawSpeciesNames,
; LinkEggList_DrawMarks, LinkEggList_Cursor (a page change goes back four steps, A picks the egg and
; goes to state 2, B goes on), LinkEggList_Cancel, LinkEggList_RedrawScreen,
; LinkEggList_ShowChooseTheKindOf. (C1, E-0385)
; runs the routine for wScreenStep (jump table of ten) (E-0122) (renamed from
; RunLinkSession8Case01Steps from its E-0357 note, E-0367)
LinkEggList::
    ld a, [wScreenStep]
    jumptable
    dw LinkEggList_LoadTiles
    dw LinkEggList_ListEggs
    dw LinkEggList_ClearText
    dw LinkEggList_DrawPageFrame
    dw LinkEggList_DrawSpeciesNames
    dw LinkEggList_DrawMarks
    dw LinkEggList_Cursor
    dw LinkEggList_Cancel
    dw LinkEggList_RedrawScreen
    dw LinkEggList_ShowChooseTheKindOf

; The egg list, step 0: loads the list's tiles six per call (SaveTilesToBGMap1BottomHalf). (C1,
; E-0357)
LinkEggList_LoadTiles::
    farcall SaveTilesToBGMap1BottomHalf
    ret

; The egg list, step 1: draws the 13 x 9 list box with the Ally / Store choice marked and lists the
; eggs (ListRecordsInUseEggs). (C1, E-0357)
LinkEggList_ListEggs::
    ld de, LinkEggList_ListEggs_TileRect
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_BankF0
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, DreamEggs_State2_BackToList_Data
    call StoreBAtWordTableEntry_BankF0
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    farcall ListRecordsInUseEggs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 9 tiles, one row per line
LinkEggList_ListEggs_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; The egg list, step 2: clears five tile areas of the text and resets the text window. (C1, E-0357)
LinkEggList_ClearText::
    ld hl, vTiles1 + $3f0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $6a0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The egg list, step 3: redraws the box, clamps the page cursor of four and, with two or more pages,
; draws the page brackets and page-of-pages numbers. (C1, E-0357)
LinkEggList_DrawPageFrame::
    ld de, LinkEggList_DrawPageFrame_TileRect
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank_f0
    ld de, $010e
    call DrawC5BEC6AtScrollOffsetDE_BankF0
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_BankF0
    ld de, $010f
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
    lb bc, $14, $09
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The egg list, step 4: draws the page's species names. (C1, E-0357)
LinkEggList_DrawSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The egg list, step 5: loads the mark tiles and draws the page's marks. (C1, E-0357)
LinkEggList_DrawMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus420Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The egg list, step 6: the list cursor: a page change goes back four steps; B goes on; A picks the
; egg, goes to state 2 and hides the sprites. (C1, E-0357)
LinkEggList_Cursor::
    ld a, $01
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .return
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .clear_screen_step
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
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
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    call SaveAndHideSpriteState_BankF0
    ret

; The egg list, step 7 (B): moves a 13 x 9 area of the screen buffer and draws a 7 x 1 strip. (C2,
; E-0357; probed E-0385)
LinkEggList_Cancel::
    ld c, $09
    ld hl, $01d3
    ld de, $0007
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F0
    ld de, LinkEggList_Cancel_TileRect
    ld hl, wWindowTileBuffer + $111
    lb bc, $07, $01
    call CopyRectTo20ByteRows_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 7 x 1 tiles, one row per line
LinkEggList_Cancel_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; The egg list, step 8: draws the screen and loads four frame tiles. (C1, E-0357)
LinkEggList_RedrawScreen::
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $09
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    ld de, Tiles1Plus4F0Tiles
    ld hl, vTiles1 + $4f0
    ld b, BANK(Tiles1Plus4F0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $750
    ld b, BANK(Tiles1Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $760
    ld b, BANK(Tiles2Plus240Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles
    ld hl, vTiles1 + $770
    ld b, BANK(Tiles1Plus770Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The egg list, step 9: reloads the list tiles six per call; when done clears the choice mark and
; returns to state 0, step 7 with 'Choose the kind of egg to ...' (string 4). (C1, E-0357)
LinkEggList_ShowChooseTheKindOf::
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SaveTilesToBGMap1BottomHalf_Data
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wMenuChoice]
    ld b, $c3
    ld hl, DreamEggs_State2_BackToList_Data
    call StoreBAtWordTableEntry_BankF0
    xor a
    ld [wScreenState], a
    ld [wScreenSubStep], a
    ld a, $04 ; 'Choose the kind of egg to'
    call BeginString_BankF0_Cat0
    ld a, $07
    ld [wScreenStep], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_BankF0_2 starts
; that Dream Egg screen message (for example 6 'Is it OK to transfer the egg?', 7 'OK to save the
; egg trade results?', 8 'Please wait...'). (C1, E-0385)
; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_BankF0_2
BeginString_BankF0_Cat0::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    call BeginStringDisplay_BankF0_2
    ret

; The record screen of the Dream Egg screen (state 3, DreamEggs_RecordScreen calls it): shows the
; record of the chosen egg with its parents; runs the step for wScreenStep (17 steps): clear, load
; glyph tiles, frame, parents, picture, Cursor (move through the records, A or B goes on), then the
; list box, species names and marks, and Leave (back to state 2, step 3). (C1, E-0385)
; the record-list screen of link session 8's receive side: clears the BG map, draws a paged record
; list with species names and marks, and moves the list cursor (HandleListCursorInput_1D) (E-0354;
; was: runs the routine for wScreenStep (jump table of seventeen) (E-0124)) (renamed from
; RunLinkSession8Case03Steps from its E-0357 note, E-0367)
LinkRecordScreen::
    ld a, [wScreenStep]
    jumptable
    dw LinkRecordScreen_Clear
    dw LinkRecordScreen_CopyGlyphTiles
    dw LinkRecordScreen_OrGlyphs
    dw LinkRecordScreen_ClearText
    dw LinkRecordScreen_DrawPedigreeFrame
    dw LinkRecordScreen_DrawParents
    dw LinkRecordScreen_LoadPicture
    dw LinkRecordScreen_Cursor
    dw LinkRecordScreen_ClearTiles
    dw ClearBGMapAtScrollAndResetScroll_BankF0
    dw LinkRecordScreen_CopyGlyphs
    dw LinkRecordScreen_ShowInfoOK
    dw LinkRecordScreen_ClearTextAgain
    dw LinkRecordScreen_DrawListBox
    dw LinkRecordScreen_DrawSpeciesNames
    dw LinkRecordScreen_DrawMarks
    dw LinkRecordScreen_Leave

; The record screen, step 0: clears the BG map, resets the scroll and loads two tiles. (C1, E-0357)
LinkRecordScreen_Clear::
    call ClearBGMapAtScrollAndResetScroll_BankF0
    ld de, Tiles1Plus2F0Tiles
    ld hl, vTiles1 + $7e0
    ld b, BANK(Tiles1Plus2F0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles
    ld hl, vTiles1 + $7f0
    ld b, BANK(Tiles1Plus7F0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Fills the 32 x 32 BG map from the scroll origin (BGMapAddressAtScroll_BankF0) with BGFillTile
; through FillTileRectWithArg1Tile (wArg1/wArg2 = BGFillTile, wArg3 = wArg4 = $20, wArg5/wArg6 = HL,
; wArg7 = 0), then hScrollX = hScrollY = 0 and wScreenStep += 1. Called by LinkRecordScreen_Clear
; and entry 9 of the LinkRecordScreen jump table. (C1, E-0385)
; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3) through
; FillTileRectWithArg1Tile with wArg7 = 0, then hScrollX = hScrollY = 0 and wScreenStep += 1
; (E-0121; fill, not a tile map: E-0186)
ClearBGMapAtScrollAndResetScroll_BankF0::
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
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen (LinkRecordScreen, entry 1 of its jumptable on wScreenStep): copies 31 glyph
; tiles from bank $1F (sources in LinkRecordScreen_CopyGlyphTiles_TileCopySrcList) to vTiles2 + $20
; through + $1F0 and to vTiles2 + $6F0 (LinkRecordScreen_CopyGlyphTiles_TileCopyDestList, ended by
; $FFFF) through SwapMonstersMenu_CopyGlyphTiles_BankF0, then wScreenStep += 1, on to
; LinkRecordScreen_OrGlyphs. (C1, E-0370)
LinkRecordScreen_CopyGlyphTiles::
    ld hl, LinkRecordScreen_CopyGlyphTiles_TileCopyDestList
    ld de, LinkRecordScreen_CopyGlyphTiles_TileCopySrcList
    call SwapMonstersMenu_CopyGlyphTiles_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 2: ORs six glyph tiles into VRAM $9020 onward (OrFromBankWaitVRAM). (C1,
; E-0357)
LinkRecordScreen_OrGlyphs::
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $20
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $60
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $90
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $140
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $170
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $1a0
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 3: clears the text tiles, loads a frame tile and turns the paged cursor
; into a plain index (page x 4 + row). (C1, E-0357)
LinkRecordScreen_ClearText::
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Tiles1Plus7D0Tiles
    ld hl, vTiles1 + $6d0
    ld b, BANK(Tiles1Plus7D0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wListPageIndex]
    add a
    add a
    ld b, a
    ld a, [wListCursor]
    add b
    ld [wListCursor], a
    xor a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 4: loads the arrow tiles, draws the 20 x 18 pedigree frame and loads the
; party's species sprites. (C1, E-0357)
LinkRecordScreen_DrawPedigreeFrame::
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_BankF0
    ld de, SwapMonstersMenu_ShowParents2_DrawFrame_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    call GetListEntriesCell4Address_BankF0
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadPedigreeSpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 5: draws the record's parents' names and family entries, the arrow tiles
; $6C/$6D, and with two or more entries the scroll arrows. (C1, E-0357)
LinkRecordScreen_DrawParents::
    call GetListEntriesCell4Address_BankF0
    ld a, [hl]
    ld e, a
    farcall LinkRecordScreen_DrawParents_DrawNamesAndFamily
    ld a, $f0
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0069
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $6c
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $6d
    ld [hl], a
    ei
    ld a, [wListCount]
    cp $02
    jr c, .check_screen_step
    ld de, Tiles2Plus20Tiles
    ld hl, vTiles2 + $20
    ld b, BANK(Tiles2Plus20Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus30Tiles
    ld hl, vTiles2 + $30
    ld b, BANK(Tiles2Plus30Tiles)
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

; The record screen, step 6: in two sub-steps loads the monster's picture into VRAM $9480 and, on
; the GBC, its palette and attributes, then draws its 6 x 6 frame. (C1, E-0357)
LinkRecordScreen_LoadPicture::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_get_list_entries_cell4_address_bank_f0
    call LinkRecordScreen_DrawBlankPicture
    call GetListEntriesCell4Address_BankF0
    ld a, $0a
    ld [rRAMG2], a
    xor a
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
    xor a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_get_list_entries_cell4_address_bank_f0:
    call GetListEntriesCell4Address_BankF0
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a
    jr z, .restore
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7f
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
    xor a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, SwapMonstersMenu_ShowParents2_LoadPicture_TileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 7: the cursor; a move with two or more flagged records goes on one step; A
; or B split the cursor back into page and row and go on two steps. (C2, E-0357; probed E-0385)
LinkRecordScreen_Cursor::
    farcall HandleListCursorInput_1D
    ld a, [wMenuInputResult]
    and a
    jr z, .loop
    cp $fd
    jr z, .check_records_flagged
    cp $fe
    jr z, .call_split_list_cursor_by4_bank_f0
    cp $ff
    jr z, .call_split_list_cursor_by4_bank_f0

.loop:
    ret

.check_records_flagged:
    ld a, [wRecordsFlagged]
    cp $02
    jr c, .loop
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_split_list_cursor_by4_bank_f0:
    call SplitListCursorBy4_BankF0
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; The record screen, step 8: clears the text and picture tiles and goes back four steps. (C1,
; E-0357)
LinkRecordScreen_ClearTiles::
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, vTiles2 + $480
    ld bc, $0904
    call FillTilesBxC
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; The record screen, step 10: copies the list glyph tiles. (C1, E-0357)
LinkRecordScreen_CopyGlyphs::
    ld hl, LinkRecordScreen_CopyGlyphs_TileCopyDestList
    ld de, LinkRecordScreen_CopyGlyphs_TileCopySrcList
    call SwapMonstersMenu_CopyGlyphTiles_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 11: copies more glyph tiles, shows 'Info / OK' (string $1E, 9 x 1) and ORs
; a glyph tile in. (C1, E-0357)
LinkRecordScreen_ShowInfoOK::
    ld hl, LinkRecordScreen_ShowInfoOK_TileCopyDestList
    ld de, LinkRecordScreen_ShowInfoOK_TileCopySrcList
    call SwapMonstersMenu_CopyGlyphTiles_BankF0
    xor a
    ld [wStringCategory], a
    ld a, $1e
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
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles1 + $7f0
    ld b, BANK(CopyGlyphTilesToVRAM_Data1)
    ld c, $10
    call OrFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 12: clears five tile areas of the text and resets the text window. (C1,
; E-0357)
LinkRecordScreen_ClearTextAgain::
    ld hl, vTiles1 + $3f0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $6a0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 13: draws the list box and clamps the page cursor of four. (C1, E-0357)
LinkRecordScreen_DrawListBox::
    ld de, LinkEggList_DrawPageFrame_TileRect
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_BankF0
    farcall ClampRecordListPageCursor4
    jr LinkRecordScreen_DrawListBox_PageStrip

; With wListPages of 2 or more draws the page indicator in the window tile buffer: tiles $C5, $BE,
; $C6 two apart at wWindowTileBuffer + $112 (StoreC5BEC6AtHLStride2_BankF0) and the current page and
; the page count as tiles at + $113 and + $115 (DrawPageOfPagesAtArg1_BankF0); then wScreenStep += 1
; (with fewer than 2 pages only the increment). (C2, E-0385)
; with two or more pages draws the bracket and page-of-pages indicator at wWindowTileBuffer + $112;
; wScreenStep += 1 (E-0124)
DrawPageIndicatorWhenTwoPagesAndStep::
    ld a, [wListPages]
    cp $02
    jr c, DrawPageIndicatorWhenTwoPagesAndStep_NextStep
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_BankF0
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_BankF0

; Increments wScreenStep. The shared tail of DrawPageIndicatorWhenTwoPagesAndStep (directly when
; wListPages is below 2, otherwise after drawing the indicator) and of
; LinkRecordScreen_DrawListBox_PageStrip. (C2, E-0371; probed E-0385)
DrawPageIndicatorWhenTwoPagesAndStep_NextStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Copies the 8 x 1 tile strip after it to wWindowTileBuffer + $110 (CopyRectTo20ByteRows_BankF0),
; then increments wScreenStep. Reached only from LinkRecordScreen_DrawListBox, after the list box is
; drawn and the page cursor clamped. (C2, E-0371; probed E-0385)
LinkRecordScreen_DrawListBox_PageStrip::
    ld de, LinkRecordScreen_DrawListBox_PageStrip_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_BankF0
    jr DrawPageIndicatorWhenTwoPagesAndStep_NextStep

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
LinkRecordScreen_DrawListBox_PageStrip_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; The record screen, step 14: draws the page's species names. (C1, E-0357)
LinkRecordScreen_DrawSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 15: loads the mark tiles, draws the page's marks and marks the cursor
; entry. (C1, E-0357)
LinkRecordScreen_DrawMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus420Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wListCursor]
    ld b, $bc
    ld hl, DreamEggs_State2_ShowInfoOK_Data
    call StoreBAtWordTableEntry_BankF0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The record screen, step 16 (leaving): redraws the screen and the bottom rows, restores the sprite
; state and hide tile $70 and returns to the chosen egg (state 2, step 3). (C1, E-0357)
LinkRecordScreen_Leave::
    call BGMapAddressAtScroll_BankF0
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF0
    call BGMapAddressAtScroll_BankF0
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_BankF0
    call RestoreSpriteStateClearCount_BankF0
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

; Saves hSpriteWindowClipMode, hFieldDrawFlags and wSpriteSlotCount in wSavedSpriteClipMode,
; wSavedFieldDrawFlags and wSavedSpriteSlotCount, then sets the clip mode and hSpriteHideTile to 0,
; hFieldDrawFlags to $FF and wSpriteSlotCount to 0. Called when the egg list hands over to the next
; state (LinkEggList_Cursor). (C2, E-0385)
; wSavedSpriteClipMode = hSpriteWindowClipMode, then hSpriteWindowClipMode = hSpriteHideTile = 0;
; wSavedFieldDrawFlags = hFieldDrawFlags, wSavedSpriteSlotCount = wSpriteSlotCount; then
; hFieldDrawFlags = $FF and wSpriteSlotCount = 0 (E-0078) (the same 30 bytes appear in 2 banks)
SaveAndHideSpriteState_BankF0::
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    xor a
    ldh [hSpriteWindowClipMode], a
    ldh [hSpriteHideTile], a
    ldh a, [hFieldDrawFlags]
    ld [wSavedFieldDrawFlags], a
    ld a, [wSpriteSlotCount]
    ld [wSavedSpriteSlotCount], a
    ld a, $ff
    ldh [hFieldDrawFlags], a
    xor a
    ld [wSpriteSlotCount], a
    ret

; Restores hSpriteWindowClipMode and hFieldDrawFlags from the saved copies, sets hSpriteHideTile to
; $80 and sets wSpriteSlotCount to 0: the saved count is read but then replaced by 0 (xor a), so it
; is not restored. Called by LinkRecordScreen_Leave. (C2, E-0385)
; hSpriteWindowClipMode = wSavedSpriteClipMode, hSpriteHideTile = $80, hFieldDrawFlags =
; wSavedFieldDrawFlags, wSpriteSlotCount = 0 (unlike RestoreSpriteStateFromSavedFieldDrawFlags, the
; count is cleared rather than restored) (E-0118)
RestoreSpriteStateClearCount_BankF0::
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    xor a
    ld [wSpriteSlotCount], a
    ret

; Clears the default window (FillTilesRequest on vTiles1, size $1202), sets wTextWindowState = 1,
; wTextWindowStep = 0 and hSpriteWindowClipMode = 2, then calls StepTextWindowOpenClose until
; wTextWindowState & 3 is 0. Called by the closing scene steps that show a message
; (RunLinkSession8Exchange_GivingScene_EggReceived,
; RunLinkSession8Exchange_ObtainedEgg_ShowObtained, RunLinkSession8Exchange_EggsTraded_ShowTraded,
; HatchingScene_RunText, HatchingScene_ShowGHatchedFromThe,
; RunLinkSession8Exchange_EggHatched_ShowHatched). (C1, E-0385)
; clears the default window, wTextWindowState = 1, wTextWindowStep = 0, hSpriteWindowClipMode = 2,
; then repeatedly far-calls StepTextWindowOpenClose until wTextWindowState & 3 = 0 (E-0122)
RunTextUntilTextWindowStateDone_BankF0::
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
    and $03
    jr nz, .loop
    ret

; Turns the plain list index in wListCursor into page and row for a list with four rows per page:
; wListPageIndex = wListCursor / 4 and wListCursor = wListCursor mod 4 (DivideHLByA). Called by
; LinkRecordScreen_Cursor on A or B. (C2, E-0385)
; wListPageIndex = wListCursor / 4 and wListCursor = wListCursor mod 4 (DivideHLByA) (E-0067) (the
; same 19 bytes appear in 2 banks)
SplitListCursorBy4_BankF0::
    ld a, [wListCursor]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    ld [wListCursor], a
    ld a, l
    ld [wListPageIndex], a
    ret

; HL = BGMapAddressAtScroll_BankF0 + $41; draws the 6 x 6 rectangle BlankPictureTileRect (all tile
; $C3) there with wArg3 = wArg4 = 6 and wArg7 = 0 (DrawTileRectAtHLFromDE_BankF0): blanks the
; picture frame of the record screen. Called by LinkRecordScreen_LoadPicture. (C1, E-0385)
; draws a 6 x 6 tile rectangle from Data_0F0_651B at BGMapAddressAtScroll_BankF0 + $41
; (DrawTileRectAtHLFromDE_BankF0) (E-0118) (E-0344: the address in its name dropped or read as the
; label there; was LinkRecordScreen_DrawBlankPicture)
LinkRecordScreen_DrawBlankPicture::
    call BGMapAddressAtScroll_BankF0
    ld de, $0041
    add hl, de
    ld de, BlankPictureTileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF0
    ret

; Copies glyph tiles from a pair of tile lists (destinations at HL, sources at DE, bank $1F) to VRAM
; until the list ends ($FF), then clears wGlyphListPos. (C1, E-0357)
; the same 58 bytes as SwapMonstersMenu_CopyGlyphTiles (SwapMonstersMenu_CopyGlyphTiles) (E-0370)
SwapMonstersMenu_CopyGlyphTiles_BankF0::
    ld b, $00

.skip:
    push bc
    push hl
    push de
    ld a, b
    add a
    add_a_to_hl
    ld a, [hli]
    cp $ff
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
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1f
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
    xor a
    ld [wGlyphListPos], a
    ret

; DE = source, HL = destination, B = width, C = rows: copies C rows of B bytes from [DE] to [HL],
; the rows $14 apart in the destination (a window tile buffer row is 20 bytes). On a DMG HL and BC
; are kept and DE ends past the source. On a CGB (wIsCGB set) it then zero-fills the same-shaped
; rectangle at HL + $0E68 with rSVBK = 2 and returns with rSVBK = 0, HL and BC changed. (C2, E-0385)
; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks)
CopyRectTo20ByteRows_BankF0::
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
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
    and a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push bc
    push hl

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: draws that rectangle
; of the screen buffer to the BG map (CopyRectToBGMapWrapped) and sets wTextCursorLo/wTextCursorHi =
; HL + $01C1. On a CGB (wIsCGB set) it then also draws the same rectangle from wScreenAttrBuffer +
; DE (rSVBK = 2) into VRAM bank 1, the tile attributes. On a DMG BC, DE and HL are kept. (C1,
; E-0385)
; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address:
; CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from
; wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (E-0062)
DrawScreenBufferRect_BankF0::
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
    add $c1
    ld [wTextCursorLo], a
    ld a, h
    adc $01
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a
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
    xor a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for the scroll position
; (hScrollX, hScrollY); clobbers A and DE. (C1, E-0385)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_BankF0::
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and $f8
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

; DE = offset: draws tiles $C5, $BE and $C6 into the BG map two entries apart starting at
; BGMapAddressAtScroll_BankF0 + DE (StepBGMapAddressBackOnScrollWrap before the first,
; WaitForVRAMAccess before each write). Used by LinkEggList_DrawPageFrame for the page brackets.
; (C1, E-0385)
; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_BankF0 + DE, two entries apart (E-0121)
DrawC5BEC6AtScrollOffsetDE_BankF0::
    push de
    call BGMapAddressAtScroll_BankF0
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $c5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $be
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $c6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL + 2] = $BE, [HL + 4] = $C6 (the page bracket tiles in a tile buffer); HL ends at
; the original HL + 4; clobbers A. (C2, E-0385)
; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks)
StoreC5BEC6AtHLStride2_BankF0::
    ld a, $c5
    ld [hl], a
    inc hl
    inc hl
    ld a, $be
    ld [hl], a
    inc hl
    inc hl
    ld a, $c6
    ld [hl], a
    ret

; wArg1:wArg2 = an offset: at BGMapAddressAtScroll_BankF0 + offset writes tile $E0 + wListPageIndex
; + 1 (the current page, counted from 1) and two entries later tile $E0 + wListPages (the page
; count) to the BG map (StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess before each write).
; Called by LinkEggList_DrawPageFrame. (C1, E-0385)
; the same instruction sequence as DrawPageOfPagesAtScrollOffset (bank $1E) apart from label
; operands, which refer to this bank's own routines and tables; the twin's note describes the shape
; (E-0107)
DrawPageOfPagesAtScrollOffset_BankF0::
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
    add $e0
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
    add $e0
    ld [hl], a
    ei
    ret

; HL = wArg1:wArg2 (wArg1 is the high byte): writes tile $E0 + wListPageIndex + 1 (the current page,
; counted from 1) at HL and tile $E0 + wListPages (the page count) at HL + 2. HL ends at the
; original HL + 2. (C2, E-0385)
; HL = the address in wArg1 (high) / wArg2 (low): writes tile $E0 + wListPageIndex + 1 there and
; tile $E0 + wListPages two bytes later (current page and page count, 1-based display) (E-0093) (the
; same 25 bytes appear in 2 banks)
DrawPageOfPagesAtArg1_BankF0::
    ld a, [wArg1]
    ld h, a
    ld a, [wArg2]
    ld l, a
    ld a, [wListPageIndex]
    inc a
    add $e0
    ld [hli], a
    inc hl
    ld a, [wListPages]
    ld b, a
    ld a, b
    add $e0
    ld [hl], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes from [DE] to [HL] (BC = 0 copies
; 65536). DE and HL end past the copy; BC = 0 and A is clobbered. (C2, E-0385)
; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_BankF0::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_BankF0
    ret

; DE = source, HL = destination, BC = count: sets rSVBK = 2, copies BC bytes from [DE] to [HL] each
; ANDed with $07 (the CGB tile attribute buffer is copied this way), then sets rSVBK = 0. DE and HL
; end past the copy and BC = 0. (C2, E-0385)
; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks)
CopyLow3BitsToWRAMBank2_BankF0::
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and $07
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    xor a
    ldh [rSVBK], a
    ret

; HL = destination offset, DE = source offset (both into wScreenTileBuffer), C = rows, wArg1:wArg2 =
; the byte count per row (wArg1 is the high byte): for each row copies that many bytes
; (CopyBytesDEToHL_BankF0), on a CGB (wIsCGB set) also the same range of wScreenAttrBuffer with each
; byte ANDed with $07 (CopyLow3BitsToWRAMBank2_BankF0), then moves HL and DE on by $14 and repeats
; until C rows are done. (C2, E-0385)
; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with
; CGB attributes (E-0127)
CopyScreenBufferRectWithAttrs_F0::
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
    and a
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
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_F0
    ret

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
LinkRecordScreen_CopyGlyphTiles_TileCopyDestList::
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $a0, vTiles2 + $b0, vTiles2 + $c0, vTiles2 + $d0, vTiles2 + $e0, vTiles2 + $f0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1a0, vTiles2 + $1b0, vTiles2 + $1c0, vTiles2 + $1d0, vTiles2 + $1e0, vTiles2 + $1f0, vTiles2 + $6f0, rIE

; record: bank-$1F tile sources
LinkRecordScreen_CopyGlyphTiles_TileCopySrcList::
    dw GlyphFont + $2c0, GlyphFont + $2a0, GlyphFont + $2f0, GlyphFont + $4b0, GlyphFont + $3f0, GlyphFont + $aa0, GlyphFont + $300, GlyphFont + $3e0 ; entry 0
    dw GlyphFont + $2d0, GlyphFont + $2e0, GlyphFont + $290, GlyphFont + $310, GlyphFont + $250, GlyphFont + $380, GlyphFont + $7a0, GlyphFont + $670
    dw GlyphFont + $6a0, GlyphFont + $9c0, GlyphFont + $2a0, GlyphFont + $3d0, GlyphFont + $880, GlyphFont + $780, GlyphFont + $870, GlyphFont + $430
    dw GlyphFont + $370, GlyphFont + $4f0, GlyphFont + $4d0, GlyphFont + $2b0, GlyphFont + $a20, GlyphFont + $260, GlyphFont + $ac0, $ffff

LinkRecordScreen_CopyGlyphs_TileCopyDestList::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

LinkRecordScreen_CopyGlyphs_TileCopySrcList::
    dw GlyphFont + $120, GlyphFont + $310, GlyphFont + $290, GlyphFont + $320, GlyphFont + $180, GlyphFont + $140, $ffff ; entry 0

LinkRecordScreen_ShowInfoOK_TileCopySrcList::
    dw GlyphFont + $430, GlyphFont + $470, GlyphFont + $3d0, GlyphFont + $2d0, GlyphFont + $6a0, GlyphFont + $7a0, GlyphFont + $640, GlyphFont + $3f0 ; entry 0
    dw GlyphFont + $2a0, GlyphFont + $120, GlyphFont + $310, GlyphFont + $290, GlyphFont + $320, GlyphFont + $180, GlyphFont + $140, $ffff

LinkRecordScreen_ShowInfoOK_TileCopyDestList::
    dw vTiles2 + $7c0, vTiles2 + $7d0, vTiles2 + $7e0, vTiles2 + $7f0, vTiles1 + $5f0, vTiles1 + $7e0, vTiles1 + $7f0, vTiles2 + $770 ; entry 0
    dw vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760
    dw rIE

DreamEggs_State2_BackToList_Data::
    db $26, $c4, $4e, $c4

DreamEggs_State2_ShowInfoOK_Data::
    db $80, $c3, $a8, $c3, $d0, $c3, $f8, $c3, $20, $c4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 9 tiles, one row per line
LinkEggList_DrawPageFrame_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d9, $da, $db, $dc, $dd, $de, $c0, $c1, $c2, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f5, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $bf, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c7, $c8, $c9, $ca, $cb, $ea, $eb, $ec, $ed, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; no reference found; $B2 followed by eight $B7 frame tiles, between
; LinkEggList_DrawPageFrame_TileRect and the unreferenced frames that follow; kept as bytes (E-0234,
; C0)
; record: bytes
FrameTilesF0_1::
    db $b2, $b7, $b7, $b7, $b7, $b7, $b7, $b7, $b7 ; id 0

; no reference found; the bytes form a window frame with the frame tiles used by the referenced
; rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5
; (E-0234, C1)
; record: 7 x 5 tiles, one row per line
TileRectF0_1::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

TileRectF0_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $76, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $73, $74, $75, $76, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; no reference found; the top frame row ($B0 $B1.. $B2) of a 7 x 5 frame whose other four rows are
; DreamEggs_State2_BackToList_TileRect (E-0234, C1)
; record: 7 x 1 tiles, one row per line
TileRectF0_3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 7 x 4 tiles, one row per line
DreamEggs_State2_BackToList_TileRect::
    db $b6, $c3, $70, $71, $72, $c3, $b7 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $73, $74, $75, $76, $b7 ; id 2
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; id 3

; record: 8 x 5 tiles, one row per line
DreamEggs_State2_DrawInfoOKBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $70, $71, $72, $73, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $74, $75, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
DreamEggs_State0_DrawYesNoBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $73, $74, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

DreamEggs_State2_ShowInfoOK_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

DreamEggs_State2_ShowAllyStore_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0
    db $c3, $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $c3, $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $c3, $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $c3, $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

RunLinkSession8Exchange_Saving_DrawYesNo_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

; HL = destination, DE = source tiles: wArg5/wArg6 = HL (high/low), wArg1/wArg2 = DE (high/low),
; then far-calls DrawTileRectFromArg1Params (the width and rows are already in wArg3/wArg4, wArg7 is
; the mode). (C1, E-0385)
; wArg5/wArg6 = HL (destination), wArg1/wArg2 = DE (source), then far-calls
; DrawTileRectFromArg1Params (width and rows already in wArg3/wArg4) (E-0093) (the same 23 bytes
; appear in 4 banks)
DrawTileRectAtHLFromDE_BankF0::
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

; HL = wListEntries + 4 * wListPageIndex + wListCursor, the address of the list cell under the
; cursor, through SetArg5ToListEntriesCell4 (which also stores it in wArg5/wArg6). (C2, E-0385)
; the same 15 bytes as GetListEntriesCell4Address (GetListEntriesCell4Address) (E-0075)
GetListEntriesCell4Address_BankF0::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A. BC is kept; A, DE
; and HL are clobbered. (C2, E-0385)
; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks)
StoreBAtWordTableEntry_BankF0::
    push bc
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; wArg2 = which cursor place table to use (0-2, DrawTileBAtArg2Entry_F0_Data). Up or Down (bits 6
; and 7 of wJoypadPressedRepeat): erases the cursor (tile $C3), toggles wMenuChoice between 0 and 1,
; draws the cursor tile $BB, queues sound $69 and sets wMenuInputResult = $FD. A (bit 0 of
; wJoypadPressed): queues sound $69, draws the arrow tile $BC at the choice and sets
; wMenuInputResult = $FF. B (bit 1): draws the arrow tile $BC and sets wMenuInputResult = $FE
; without a sound. With no button it blinks the cursor (BlinkCursorBlinkB8_BankF0) and sets
; wMenuInputResult = 0. (C1, E-0385)
; up/down moves wMenuChoice between two entries (sound $69); A selects (wMenuInputResult = $FF), B
; cancels ($FE); otherwise blinks the cursor (E-0127)
HandleTwoChoiceCursorInput_F0::
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
    xor a
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_arg2_entry_f0:
    call DrawArrowTileBCAtArg2Entry_F0
    ld a, $fe
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank_f0:
    call DrawBlankTileC3_BankF0
    ld a, [wMenuChoice]
    and a
    jr nz, .skip
    ld a, $01
    jr .set_menu_choice2

.skip:
    dec a
    jr .set_menu_choice2

.call_draw_blank_tile_c3_bank_f02:
    call DrawBlankTileC3_BankF0
    ld a, [wMenuChoice]
    cp $01
    jr c, .set_menu_choice
    xor a
    jr .set_menu_choice2

.set_menu_choice:
    inc a

.set_menu_choice2:
    ld [wMenuChoice], a
    call DrawCursorTileBB_BankF0
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

; While wJoypadRepeatTimer is below $14 draws the cursor tile $BB. From $14 on it increments
; wListCursorBlink (0-$17, then back to 0) and draws the cursor tile $BB for counts below $10 and
; the blank tile $C3 for $10-$17, both at the place of wMenuChoice through DrawTileBAtArg2Entry_F0.
; (C1, E-0385)
; once the joypad repeat timer reaches $14, cycles wListCursorBlink through 0-$17 and draws the
; cursor tile ($BB) or a blank ($C3) (E-0122)
BlinkCursorBlinkB8_BankF0::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_BankF0
    ld a, [wListCursorBlink]
    inc a
    ld [wListCursorBlink], a
    cp $10
    jr c, DrawCursorTileBB_BankF0
    cp $18
    jr c, DrawBlankTileC3_BankF0
    xor a
    ld [wListCursorBlink], a

; B = $BB (the cursor tile) and jumps to DrawTileBAtArg2Entry_F0, which draws it at the place of
; wMenuChoice in the table chosen by wArg2. (C1, E-0385)
; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_BankF0::
    ld b, $bb
    jr DrawTileBAtArg2Entry_F0

; B = $C3 (the blank tile) and jumps to DrawTileBAtArg2Entry_F0, which draws it at the place of
; wMenuChoice in the table chosen by wArg2. (C1, E-0385)
; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_BankF0::
    ld b, $c3
    jr DrawTileBAtArg2Entry_F0

; B = $BC (the arrow tile) and falls into DrawTileBAtArg2Entry_F0, which draws it at the place of
; wMenuChoice in the table chosen by wArg2. (C1, E-0385)
; B = $BC, then writes B at the scroll position + the offset from
; DrawTileBAtArg2Entry_F0_Data[wArg2] entry wMenuChoice (E-0125)
DrawArrowTileBCAtArg2Entry_F0::
    ld b, $bc

; Writes tile B at the cursor place of entry wMenuChoice in table wArg2
; (DrawTileBAtArg2Entry_F0_Data), stepping back on a scroll wrap. (C1, E-0357)
DrawTileBAtArg2Entry_F0::
    ld a, [wArg2]
    add a
    ld hl, DrawTileBAtArg2Entry_F0_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wMenuChoice]
    add a
    add e
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

; Nine words in two layers: three pointers ($67C6, $67CA, $67CE, into this block) followed by three
; pairs of offsets ($012D and $016D, $012E and $016E, $012F and $016F). DrawTileBAtArg2Entry_F0
; picks a pair with wArg2 (0-2) and an offset in it with wMenuChoice; the offset (row 9 or row 11,
; column 13, 14 or 15) is added to the BG map address of the scroll position
; (BGMapAddressAtScroll_BankF0) and tile B is written there. (C1, E-0381)
DrawTileBAtArg2Entry_F0_Data::
    db $c6, $67, $ca, $67, $ce, $67, $2d, $01, $6d, $01, $2e, $01, $6e, $01, $2f, $01
    db $6f, $01

; Sets wArg1 = 1 when wF0ScreenKind is 3 or 4 and 0 otherwise, then calls
; RunWithArg1ForF0ScreenKind_SetUpScene, which sets up the objects of the closing scene (a non-zero
; wArg1 adds object 2, the egg species of kind 3 or the hatched species). Called by
; RunLinkSession8Exchange_Trade_SetUpScene. (C1, E-0385)
; runs RunWithArg1ForF0ScreenKind_SetUpScene with wArg1 = 1 when wF0ScreenKind is 3 or 4, else 0
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; RunWithArg1ForF0ScreenKind)
RunWithArg1ForF0ScreenKind::
    ld a, [wF0ScreenKind]
    cp $03
    jr z, .set_arg1_to_01
    cp $04
    jr z, .set_arg1_to_01
    xor a
    ld [wArg1], a
    call RunWithArg1ForF0ScreenKind_SetUpScene
    ret

.set_arg1_to_01:
    ld a, $01
    ld [wArg1], a
    call RunWithArg1ForF0ScreenKind_SetUpScene
    ret

; Sets up a closing scene: the sprite slots and object 1 (with or without the hatch data; the
; alternatives behind EVENT_NEVER_SET are never chosen), decompresses their graphics, starts field
; command $0D (the egg at ($48, $40), hidden) and two sprite slots; with wArg1 also object 2 as the
; egg's species (kind 3) or the hatched species, with its graphics. (C1, E-0357)
RunWithArg1ForF0ScreenKind_SetUpScene::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data6
    jr .call_copy_bytes_de_from_hl_bank_f0

.skip:
    ld hl, EggSceneAltSpriteSlots

.call_copy_bytes_de_from_hl_bank_f0:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wLinkHatchData]
    and a
    jr nz, .skip2
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data7
    jr .call_copy_bytes_de_from_hl_bank_f02

.skip2:
    ld hl, Object1Init_2

.call_copy_bytes_de_from_hl_bank_f02:
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip3
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data1
    jr .call_copy_bytes_de_from_hl_bank_f03

.skip3:
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data2

.call_copy_bytes_de_from_hl_bank_f03:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wLinkHatchData]
    and a
    jr nz, .skip4
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data3
    jr .call_copy_bytes_de_from_hl_bank_f04

.skip4:
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data4

.call_copy_bytes_de_from_hl_bank_f04:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0d
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a
    ld [wObject5], a
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, [wArg1]
    and a
    jr z, .check_is_cgb
    ld hl, Object2Init_2
    ld de, wObject2
    ld b, $10
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp $03
    jr nz, .read_link_hatch_species_lo
    ld a, [wLinkEggSpeciesLo]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wLinkEggSpeciesHi]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    jr .skip5

.read_link_hatch_species_lo:
    ld a, [wLinkHatchSpeciesLo]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wLinkHatchSpeciesHi]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a

.skip5:
    ld hl, RunWithArg1ForF0ScreenKind_SetUpScene_Data5
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF0
    ld a, [wF0ScreenKind]
    cp $03
    jr nz, .read_link_hatch_species_lo2
    ld a, [wLinkEggSpeciesLo]
    ldh [hTemp0], a
    ld a, [wLinkEggSpeciesHi]
    ldh [hTemp1], a
    jr .call_decompress_graphics_temp0_to_temp4

.read_link_hatch_species_lo2:
    ld a, [wLinkHatchSpeciesLo]
    ldh [hTemp0], a
    ld a, [wLinkHatchSpeciesHi]
    ldh [hTemp1], a

.call_decompress_graphics_temp0_to_temp4:
    farcall DecompressGraphicsTemp0ToTemp4

.check_is_cgb:
    ld a, [wIsCGB]
    and a
    jr z, .return
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; HL = source, DE = destination, B = count (0 copies 256): copies B bytes from [HL] to [DE]. HL and
; DE end past the copy, B = 0 and A is clobbered. (C2, E-0385)
; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_BankF0::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF0
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 13 tiles, one row per line
HatchingScene_DrawFrame_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 12

RunWithArg1ForF0ScreenKind_SetUpScene_Data1::
    db $00, $00, $01, $04, $00, $80

RunWithArg1ForF0ScreenKind_SetUpScene_Data2::
    db $01, $00, $01, $01, $00, $80

RunWithArg1ForF0ScreenKind_SetUpScene_Data3::
    db $00, $00, $01, $04, $00, $81

RunWithArg1ForF0ScreenKind_SetUpScene_Data4::
    db $01, $00, $01, $01, $00, $81

RunWithArg1ForF0ScreenKind_SetUpScene_Data5::
    db $00, $00, $00, $02, $00, $82

RunWithArg1ForF0ScreenKind_SetUpScene_Data6::
    db $00, $01, $00, $00, $f0, $40, $04, $01, $00, $00, $00, $f0, $40, $04, $00, $00

; Sixteen bytes for wSpriteSlots (the first object slot) that RunWithArg1ForF0ScreenKind_SetUpScene
; copies with CopyBytesDEFromHL_BankF0 only when EVENT_NEVER_SET is set; since that flag is never
; set, RunWithArg1ForF0ScreenKind_SetUpScene_Data6 is copied instead. The two differ only in byte
; OBJ_SPRITE_ID ($01 here, $00 there) and byte OBJ_ATTR ($01 here, $04 there); both have OBJ_X $F0
; and OBJ_Y $40. (C1, E-0373)
; CopyBytesDEFromHL_BankF0 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
EggSceneAltSpriteSlots::
    db $00, $01, $01, $00, $f0, $40, $01, $01, $00, $00, $00, $f0, $40, $04, $00, $00 ; entry 0

RunWithArg1ForF0ScreenKind_SetUpScene_Data7::
    db $00, $01, $00, $00, $f0, $40, $04, $03, $10, $00, $00, $f0, $40, $04, $00, $00

; CopyBytesDEFromHL_BankF0 copies these 16 bytes to wObject1 (E-0264)
; record: 16 bytes copied to wObject1
Object1Init_2::
    db $00, $01, $01, $00, $f0, $40, $01, $03, $10, $00, $00, $f0, $40, $04, $00, $00 ; entry 0

; CopyBytesDEFromHL_BankF0 copies these 16 bytes to wObject2 (E-0264)
; record: 16 bytes copied to wObject2
Object2Init_2::
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00 ; entry 0

RunLinkSession8Exchange_Trade_StartRecordSwap_Data::
    ds $a6, $ff

; Raises the 27 resistance levels at wGiftRecord + MON_RESISTANCES (levels 0-3) once for each unit
; of wFamilyBitCount, then returns. Each round returns at once when wFamilyBitCount is 0 or every
; resistance except index 15 is already 3. Otherwise it subtracts 1 from wFamilyBitCount, finds the
; lowest level (0, then 1, then 2) that any resistance has (wCounterPtr0Lo), lists the indexes at
; that level in order (from wCounterPtr0Hi on; wLowestResistCount of them) and adds 1 to one of
; them: the only one, or with several entry (91 mod count) of the list. The pick is not random: the
; byte from NextTableByte is thrown away because A is reloaded from L, which is the fixed low byte
; $5C of the address just past the 27 resistances. A multi-entry pick that lands on index 15 raises
; nothing and still uses up the count. RunLinkSession8Exchange_Trade_RankFamilies sets
; wFamilyBitCount and calls it. (C2, E-0385)
; while wFamilyBitCount > 0 and some resistance at wGiftRecord + $73 is below 3: picks at random one
; of the lowest-level resistances (levels 0, then 1, 2) and raises it (E-0129)
RaiseLowestResistances::
    ld a, [wFamilyBitCount]
    and a
    ret z
    ld hl, wGiftRecord + MON_RESISTANCES
    ld b, $00

.loop:
    ld a, b
    cp $0f
    jr z, .next
    ld a, [hl]
    cp $03
    jr z, .next
    ld a, [wFamilyBitCount]
    dec a
    ld [wFamilyBitCount], a
    jp .clear_counter_ptr0_lo

.next:
    inc hl
    inc b
    ld a, b
    cp $1b
    jr c, .loop
    ret

.clear_counter_ptr0_lo:
    xor a
    ld [wCounterPtr0Lo], a

.skip:
    ld hl, wCounterPtr0Hi
    ld bc, $001c

.loop2:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld hl, wGiftRecord + MON_RESISTANCES
    ld de, wCounterPtr0Hi
    ld b, $00

.loop3:
    ld a, [hl]
    ld c, a
    ld a, [wCounterPtr0Lo]
    cp c
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
    cp $1b
    jr c, .loop3
    ld a, [wLowestResistCount]
    and a
    jr nz, .check_lowest_resist_count
    ld a, [wCounterPtr0Lo]
    cp $02
    ret z
    inc a
    ld [wCounterPtr0Lo], a
    jr .skip

.check_lowest_resist_count:
    ld a, [wLowestResistCount]
    cp $01
    jr z, .read_counter_ptr0_hi
    ld b, a
    call NextTableByte
    ld a, l

.skip2:
    sub b
    cp b
    jr c, .skip3
    jr z, .skip3
    jr .skip2

.skip3:
    and a
    jr z, .skip4
    dec a

.skip4:
    ld hl, wCounterPtr0Hi
    add_a_to_hl
    ld a, [hl]
    cp $0f
    jp z, RaiseLowestResistances
    jr .skip5

.read_counter_ptr0_hi:
    ld a, [wCounterPtr0Hi]

.skip5:
    ld hl, wGiftRecord + MON_RESISTANCES
    add_a_to_hl
    ld a, [hl]
    inc a
    ld [hl], a
    jp RaiseLowestResistances

; Fills the gift Egg record from its species: loads the species record of the id at wGiftRecord +
; MON_SPECIES (LoadSpeciesRecord), copies its three natural skills (SPECIES_SKILLS) to the first
; three bytes of MON_SKILL_LIST and its 27 base resistances (SPECIES_RESISTANCES) over
; MON_RESISTANCES, then copies only the low byte of MON_MAX_HP to MON_HP and of MON_MAX_MP to MON_MP
; (the high bytes stay as they were). RunLinkSession8Exchange_Trade_RankFamilies calls it right
; after RankFamilyScoresIntoFamilyRanking has chosen the species. (C2, E-0385)
; loads species wGiftRecord + $B and copies its bytes wSpeciesRecord + $8-wSpeciesRecord + $A to
; wGiftRecord + $3C and the 27 bytes at wSpeciesRecord + $12 to wGiftRecord + $73; wGiftRecord + $5B
; = wGiftRecord + $5D, wGiftRecord + $5F = wGiftRecord + $61 (E-0124)
GiftRecord_LoadSkillsResistancesFromSpecies::
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
    ld c, $1b

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ld a, [wGiftRecord + MON_MAX_HP]
    ld [wGiftRecord + MON_HP], a
    ld a, [wGiftRecord + MON_MAX_MP]
    ld [wGiftRecord + MON_MP], a
    ret

; Chooses the family and species of the gift Egg from the 11 family scores at wFamilyScores. It
; ranks the families from the highest score down into wFamilyRanking: a tie is settled by bit 0 of
; the next NextTableByte value, a ranked family gets a value with bit 7 set in its wFamilyRankTaken
; byte (this routine never clears them), and a score of 0 ties with the starting best of 0, so with
; only zero scores left the pick can be family 0 again. It then sets wRankBand from
; BandOfFamilyBitCount and tries the 10 best families in turn: it takes that family list from
; FamilyBandSpeciesTable, the band list of wRankBand from it, and walks its species words, taking
; one when RandomModulo29_BankF0 returns an odd quotient. A list ends at $FFFF (try the next family)
; or at $FEFE (take the word before the marker). If no family gives a species it stores family $0A
; and species $0174. The result goes to MON_FAMILY and MON_SPECIES of wGiftRecord; wRankIndex ends
; 0. RunLinkSession8Exchange_Trade_RankFamilies calls it when the egg state is set. (C2, E-0385)
; ranks the 11 scores at wFamilyScores in descending order (ties at random) into wFamilyRanking,
; then wRankBand = BandOfFamilyBitCount (E-0130)
RankFamilyScoresIntoFamilyRanking::
    xor a
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
    cp b
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
    cp $0b
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
    cp $0b
    jr c, .loop
    call BandOfFamilyBitCount
    ld [wRankBand], a
    xor a
    ld [wRankIndex], a
    ld hl, wFamilyRanking
    ld b, $0a

.loop3:
    push hl
    push bc
    ld a, [hl]
    res 7, a
    add a
    ld de, FamilyBandSpeciesTable
    add e
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
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.next2:
    inc de
    ld a, [de]
    dec de
    cp $ff
    jr z, .restore2
    cp $fe
    jr z, .next3
    push de
    ld b, $0f
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
    ld a, $0a
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

; RankFamilyScoresIntoFamilyRanking walks wFamilyRanking (10 families), reads the word at $6CB5 + 2
; * family, then the word at 2 * wRankBand (BandOfFamilyBitCount: 4-7) of that list, and walks the
; species words up to $FEFE (or $FFFF) taking one when RandomModulo29_BankF0 gives an odd number;
; the chosen species goes to wGiftRecord + MON_SPECIES (E-0312); 11 families in
; StringTable_MonsterFamilies order (E-0256, C1)
; record: band lists of this family
FamilyBandSpeciesTable::
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

; family 0 (Slime) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Slime::
    dw FamilyBandSpecies_Slime_000 ; id 0
    dw FamilyBandSpecies_Slime_001 ; id 1
    dw FamilyBandSpecies_Slime_002 ; id 2
    dw FamilyBandSpecies_Slime_003 ; id 3
    dw FamilyBandSpecies_Slime_004 ; id 4
    dw FamilyBandSpecies_Slime_005 ; id 5
    dw FamilyBandSpecies_Slime_006 ; id 6
    dw FamilyBandSpecies_Slime_007 ; id 7

; list for entry $00 of FamilyBandLists_Slime; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Slime_000::
    dw MONSTER_SPOTSLIME ; id 0
    dw MONSTER_SNAILY ; id 1
    dw MONSTER_SLABBIT ; id 2
    dw $fefe ; id 3

; list for entry $01 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_001::
    dw MONSTER_TREESLIME ; id 0
    dw MONSTER_BABBLE ; id 1
    dw MONSTER_SLIME ; id 2
    dw MONSTER_TROPICGEL ; id 3
    dw MONSTER_WONDEREGG ; id 4
    dw $fefe ; id 5

; list for entry $02 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_002::
    dw MONSTER_WINGSLIME ; id 0
    dw MONSTER_BOXSLIME ; id 1
    dw MONSTER_PEARLGEL ; id 2
    dw MONSTER_HEALER ; id 3
    dw $fefe ; id 4

; list for entry $03 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_003::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SLIMENITE ; id 1
    dw MONSTER_FANGSLIME ; id 2
    dw MONSTER_ROCKSLIME ; id 3
    dw MONSTER_SLIMEBORG ; id 4
    dw $fefe ; id 5

; list for entry $04 of FamilyBandLists_Slime; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Slime_004::
    dw MONSTER_METALY ; id 0
    dw MONSTER_SPOTKING ; id 1
    dw MONSTER_MIMESLIME ; id 2
    dw MONSTER_HALOSLIME ; id 3
    dw $fefe ; id 4

; list for entry $05 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_005::
    dw MONSTER_KINGSLIME ; id 0
    dw MONSTER_METABBLE ; id 1
    dw MONSTER_METALKING ; id 2
    dw $fefe ; id 3

; list for entry $06 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_006::
    dw MONSTER_GOLDSLIME ; id 0
    dw $fefe ; id 1

; list for entry $07 of FamilyBandLists_Slime; it runs to the next list (E-0199)
FamilyBandSpecies_Slime_007::
    dw MONSTER_GRANSLIME ; id 0
    dw $fefe ; id 1

; family 1 (Dragon) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Dragon::
    dw FamilyBandSpecies_Dragon_000 ; id 0
    dw FamilyBandSpecies_Dragon_001 ; id 1
    dw FamilyBandSpecies_Dragon_002 ; id 2
    dw FamilyBandSpecies_Dragon_003 ; id 3
    dw FamilyBandSpecies_Dragon_004 ; id 4
    dw FamilyBandSpecies_Dragon_005 ; id 5
    dw FamilyBandSpecies_Dragon_006 ; id 6
    dw FamilyBandSpecies_Dragon_007 ; id 7

; list for entry $00 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Dragon_000::
    dw MONSTER_FAIRYDRAK ; id 0
    dw MONSTER_CHAMELGON ; id 1
    dw MONSTER_LIZARDFLY ; id 2
    dw $fefe ; id 3

; list for entry $01 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_001::
    dw MONSTER_POISONGON ; id 0
    dw MONSTER_MINIDRAK ; id 1
    dw MONSTER_KINGCOBRA ; id 2
    dw MONSTER_SNAKEBAT ; id 3
    dw MONSTER_CRESTPENT ; id 4
    dw $fefe ; id 5

; list for entry $02 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_002::
    dw MONSTER_DRAGONKID ; id 0
    dw MONSTER_TORTRAGON ; id 1
    dw MONSTER_PTERANOD ; id 2
    dw MONSTER_GASGON ; id 3
    dw MONSTER_WINGSNAKE ; id 4
    dw $fefe ; id 5

; list for entry $03 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_003::
    dw MONSTER_SWORDGON ; id 0
    dw MONSTER_DRYGON ; id 1
    dw MONSTER_RAYBURN ; id 2
    dw MONSTER_VAMPIRUS ; id 3
    dw $fefe ; id 4

; list for entry $04 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Dragon_004::
    dw MONSTER_LIZARDMAN ; id 0
    dw MONSTER_DRAGON ; id 1
    dw MONSTER_MADDRAGON ; id 2
    dw MONSTER_ANDREAL ; id 3
    dw MONSTER_SPIKEROUS ; id 4
    dw MONSTER_COATOL ; id 5
    dw $fefe ; id 6

; list for entry $05 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_005::
    dw MONSTER_GREATDRAK ; id 0
    dw MONSTER_BATTLEREX ; id 1
    dw MONSTER_SKYDRAGON ; id 2
    dw MONSTER_SERPENTIA ; id 3
    dw $fefe ; id 4

; list for entry $06 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_006::
    dw MONSTER_OROCHI ; id 0
    dw MONSTER_DIVINEGON ; id 1
    dw MONSTER_GIGADRACO ; id 2
    dw $fefe ; id 3

; list for entry $07 of FamilyBandLists_Dragon; it runs to the next list (E-0199)
FamilyBandSpecies_Dragon_007::
    dw MONSTER_ORLIGON ; id 0
    dw $fefe ; id 1

; family 2 (Beast) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Beast::
    dw FamilyBandSpecies_Beast_000 ; id 0
    dw FamilyBandSpecies_Beast_001 ; id 1
    dw FamilyBandSpecies_Beast_002 ; id 2
    dw FamilyBandSpecies_Beast_003 ; id 3
    dw FamilyBandSpecies_Beast_004 ; id 4
    dw FamilyBandSpecies_Beast_005 ; id 5
    dw FamilyBandSpecies_Beast_006 ; id 6
    dw FamilyBandSpecies_Beast_007 ; id 7

; list for entry $00 of FamilyBandLists_Beast; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Beast_000::
    dw MONSTER_ALMIRAJ ; id 0
    dw MONSTER_CATFLY ; id 1
    dw MONSTER_PILLOWRAT ; id 2
    dw MONSTER_SACCER ; id 3
    dw MONSTER_ANTBEAR ; id 4
    dw MONSTER_FAIRYRAT ; id 5
    dw $fefe ; id 6

; list for entry $01 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_001::
    dw MONSTER_SKULLROO ; id 0
    dw MONSTER_WINDBEAST ; id 1
    dw MONSTER_MOMMONJA ; id 2
    dw MONSTER_HAMMERMAN ; id 3
    dw MONSTER_ARROWDOG ; id 4
    dw MONSTER_MADGOPHER ; id 5
    dw $fefe ; id 6

; list for entry $02 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_002::
    dw MONSTER_TONGUELLA ; id 0
    dw MONSTER_BEAVERN ; id 1
    dw MONSTER_SUPERTEN ; id 2
    dw MONSTER_IRONTURT ; id 3
    dw MONSTER_NOCTOKING ; id 4
    dw MONSTER_BEASTNITE ; id 5
    dw $fefe ; id 6

; list for entry $03 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_003::
    dw MONSTER_GRIZZLY ; id 0
    dw MONSTER_YETI ; id 1
    dw MONSTER_GOATEGON ; id 2
    dw MONSTER_WILDAPE ; id 3
    dw MONSTER_CATMAGE ; id 4
    dw MONSTER_DUMBIRA ; id 5
    dw $fefe ; id 6

; list for entry $04 of FamilyBandLists_Beast; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Beast_004::
    dw MONSTER_GULPBEAST ; id 0
    dw MONSTER_TRUMPETER ; id 1
    dw MONSTER_MADCAT ; id 2
    dw MONSTER_BIGEYE ; id 3
    dw $fefe ; id 4

; list for entry $05 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_005::
    dw MONSTER_UNICORN ; id 0
    dw MONSTER_DARKHORN ; id 1
    dw $fefe ; id 2

; list for entry $06 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_006::
    dw MONSTER_KINGLEO ; id 0
    dw $fefe ; id 1

; list for entry $07 of FamilyBandLists_Beast; it runs to the next list (E-0199)
FamilyBandSpecies_Beast_007::
    dw MONSTER_GORAGO ; id 0
    dw $fefe ; id 1

; family 3 (Bird) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Bird::
    dw FamilyBandSpecies_Bird_000 ; id 0
    dw FamilyBandSpecies_Bird_001 ; id 1
    dw FamilyBandSpecies_Bird_002 ; id 2
    dw FamilyBandSpecies_Bird_003 ; id 3
    dw FamilyBandSpecies_Bird_004 ; id 4
    dw FamilyBandSpecies_Bird_005 ; id 5
    dw FamilyBandSpecies_Bird_006 ; id 6
    dw FamilyBandSpecies_Bird_007 ; id 7

; list for entry $00 of FamilyBandLists_Bird; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Bird_000::
    dw MONSTER_PICKY ; id 0
    dw MONSTER_DRACKY ; id 1
    dw $fefe ; id 2

; list for entry $01 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_001::
    dw MONSTER_FLORAJAY ; id 0
    dw MONSTER_MADRAVEN ; id 1
    dw MONSTER_KITEHAWK ; id 2
    dw MONSTER_BIGROOST ; id 3
    dw $fefe ; id 4

; list for entry $02 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_002::
    dw MONSTER_BULLBIRD ; id 0
    dw MONSTER_MISTYWING ; id 1
    dw MONSTER_AQUAHAWK ; id 2
    dw MONSTER_STUBBIRD ; id 3
    dw MONSTER_LANDOWL ; id 4
    dw MONSTER_CRAGDEVIL ; id 5
    dw $fefe ; id 6

; list for entry $03 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_003::
    dw MONSTER_WYVERN ; id 0
    dw MONSTER_DUCKKITE ; id 1
    dw MONSTER_MADPECKER ; id 2
    dw MONSTER_MADGOOSE ; id 3
    dw MONSTER_MADCONDOR ; id 4
    dw MONSTER_EMYU ; id 5
    dw $fefe ; id 6

; list for entry $04 of FamilyBandLists_Bird; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Bird_004::
    dw MONSTER_BLIZZARDY ; id 0
    dw MONSTER_PHOENIX ; id 1
    dw MONSTER_ZAPBIRD ; id 2
    dw MONSTER_FUNKYBIRD ; id 3
    dw $fefe ; id 4

; list for entry $05 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_005::
    dw MONSTER_GARUDIAN ; id 0
    dw MONSTER_WHIPBIRD ; id 1
    dw $fefe ; id 2

; list for entry $06 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_006::
    dw MONSTER_RAINHAWK ; id 0
    dw MONSTER_SHANTAK ; id 1
    dw $fefe ; id 2

; list for entry $07 of FamilyBandLists_Bird; it runs to the next list (E-0199)
FamilyBandSpecies_Bird_007::
    dw MONSTER_AZURILE ; id 0
    dw $fefe ; id 1

; family 4 (Plant) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Plant::
    dw FamilyBandSpecies_Plant_000 ; id 0
    dw FamilyBandSpecies_Plant_001 ; id 1
    dw FamilyBandSpecies_Plant_002 ; id 2
    dw FamilyBandSpecies_Plant_003 ; id 3
    dw FamilyBandSpecies_Plant_004 ; id 4
    dw FamilyBandSpecies_Plant_005 ; id 5
    dw FamilyBandSpecies_Plant_006 ; id 6
    dw FamilyBandSpecies_Plant_007 ; id 7

; list for entry $00 of FamilyBandLists_Plant; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Plant_000::
    dw MONSTER_CACTIBALL ; id 0
    dw MONSTER_TOADSTOOL ; id 1
    dw MONSTER_SLURPERON ; id 2
    dw MONSTER_EGGPLATON ; id 3
    dw $fefe ; id 4

; list for entry $01 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_001::
    dw MONSTER_MADPLANT ; id 0
    dw MONSTER_WINGTREE ; id 1
    dw MONSTER_ONIONO ; id 2
    dw $fefe ; id 3

; list for entry $02 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_002::
    dw MONSTER_FIREWEED ; id 0
    dw MONSTER_FLORAMAN ; id 1
    dw MONSTER_GULPPLE ; id 2
    dw MONSTER_STUBSUCK ; id 3
    dw MONSTER_DANCEVEGI ; id 4
    dw $fefe ; id 5

; list for entry $03 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_003::
    dw MONSTER_AMBERWEED ; id 0
    dw MONSTER_TREEBOY ; id 1
    dw MONSTER_DEVIPINE ; id 2
    dw MONSTER_BEANMAN ; id 3
    dw MONSTER_EVILSEED ; id 4
    dw MONSTER_MANEATER ; id 5
    dw MONSTER_FOOHERO ; id 6
    dw $fefe ; id 7

; list for entry $04 of FamilyBandLists_Plant; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Plant_004::
    dw MONSTER_SNAPPER ; id 0
    dw MONSTER_GHOSTREE ; id 1
    dw $fefe ; id 2

; list for entry $05 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_005::
    dw MONSTER_DEVIPINE ; id 0
    dw MONSTER_FACETREE ; id 1
    dw $fefe ; id 2

; list for entry $06 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_006::
    dw MONSTER_ROSEVINE ; id 0
    dw $fefe ; id 1

; list for entry $07 of FamilyBandLists_Plant; it runs to the next list (E-0199)
FamilyBandSpecies_Plant_007::
    dw MONSTER_EGDRACIL ; id 0
    dw MONSTER_WARUBOU ; id 1
    dw MONSTER_WATABOU ; id 2
    dw $fefe ; id 3

; family 5 (Bug) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Bug::
    dw FamilyBandSpecies_Bug_000 ; id 0
    dw FamilyBandSpecies_Bug_001 ; id 1
    dw FamilyBandSpecies_Bug_002 ; id 2
    dw FamilyBandSpecies_Bug_003 ; id 3
    dw FamilyBandSpecies_Bug_004 ; id 4
    dw FamilyBandSpecies_Bug_005 ; id 5
    dw FamilyBandSpecies_Bug_006 ; id 6
    dw FamilyBandSpecies_Bug_007 ; id 7

; list for entry $00 of FamilyBandLists_Bug; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Bug_000::
    dw MONSTER_GIANTSLUG ; id 0
    dw MONSTER_GIANTWORM ; id 1
    dw MONSTER_ARMYANT ; id 2
    dw MONSTER_TAILEATER ; id 3
    dw $fefe ; id 4

; list for entry $01 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_001::
    dw MONSTER_GOPHECADA ; id 0
    dw MONSTER_BUTTERFLY ; id 1
    dw MONSTER_GOHOPPER ; id 2
    dw $fefe ; id 3

; list for entry $02 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_002::
    dw MONSTER_LIPSY ; id 0
    dw MONSTER_STAGBUG ; id 1
    dw MONSTER_PYURO ; id 2
    dw MONSTER_EYEDER ; id 3
    dw MONSTER_BELZEBUB ; id 4
    dw $fefe ; id 5

; list for entry $03 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_003::
    dw MONSTER_CATAPILA ; id 0
    dw MONSTER_WEEDBUG ; id 1
    dw MONSTER_ARMORPEDE ; id 2
    dw MONSTER_GIANTMOTH ; id 3
    dw MONSTER_DROLL ; id 4
    dw MONSTER_MADHORNET ; id 5
    dw MONSTER_MULTIEYES ; id 6
    dw $fefe ; id 7

; list for entry $04 of FamilyBandLists_Bug; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Bug_004::
    dw MONSTER_ARMYCRAB ; id 0
    dw MONSTER_SICKLER ; id 1
    dw $fefe ; id 2

; list for entry $05 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_005::
    dw MONSTER_WARMANTIS ; id 0
    dw MONSTER_HORNBEET ; id 1
    dw MONSTER_DIGSTER ; id 2
    dw $fefe ; id 3

; list for entry $06 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_006::
    dw MONSTER_ARMORPION ; id 0
    dw $fefe ; id 1

; list for entry $07 of FamilyBandLists_Bug; it runs to the next list (E-0199)
FamilyBandSpecies_Bug_007::
    dw MONSTER_SKULARACH ; id 0
    dw $fefe ; id 1

; family 6 (Demon) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Demon::
    dw FamilyBandSpecies_Demon_000 ; id 0
    dw FamilyBandSpecies_Demon_001 ; id 1
    dw FamilyBandSpecies_Demon_002 ; id 2
    dw FamilyBandSpecies_Demon_003 ; id 3
    dw FamilyBandSpecies_Demon_004 ; id 4
    dw FamilyBandSpecies_Demon_005 ; id 5
    dw FamilyBandSpecies_Demon_006 ; id 6
    dw FamilyBandSpecies_Demon_007 ; id 7

; list for entry $00 of FamilyBandLists_Demon; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Demon_000::
    dw MONSTER_PIXY ; id 0
    dw MONSTER_DEMONITE ; id 1
    dw $fefe ; id 2

; list for entry $01 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_001::
    dw MONSTER_1EYECLOWN ; id 0
    dw MONSTER_GREMLIN ; id 1
    dw $fefe ; id 2

; list for entry $02 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_002::
    dw MONSTER_MEDUSAEYE ; id 0
    dw MONSTER_EYEBALL ; id 1
    dw $fefe ; id 2

; list for entry $03 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_003::
    dw MONSTER_DARKEYE ; id 0
    dw MONSTER_SKULRIDER ; id 1
    dw MONSTER_ORC ; id 2
    dw MONSTER_GIGANTES ; id 3
    dw MONSTER_EVILARMOR ; id 4
    dw $fefe ; id 5

; list for entry $04 of FamilyBandLists_Demon; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Demon_004::
    dw MONSTER_EVILBEAST ; id 0
    dw MONSTER_BUBBLEMON ; id 1
    dw MONSTER_LIONEX ; id 2
    dw MONSTER_OGRE ; id 3
    dw MONSTER_MADKNIGHT ; id 4
    dw $fefe ; id 5

; list for entry $05 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_005::
    dw MONSTER_ARCDEMON ; id 0
    dw MONSTER_GOATHORN ; id 1
    dw MONSTER_GATEGUARD ; id 2
    dw MONSTER_CHOPCLOWN ; id 3
    dw MONSTER_BOSSTROLL ; id 4
    dw MONSTER_GRENDAL ; id 5
    dw MONSTER_EVILWELL ; id 6
    dw MONSTER_CENTASAUR ; id 7
    dw $fefe ; id 8

; list for entry $06 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_006::
    dw MONSTER_AKUBAR ; id 0
    dw MONSTER_JAMIRUS ; id 1
    dw MONSTER_DURRAN ; id 2
    dw MONSTER_LAMPGENIE ; id 3
    dw $fefe ; id 4

; list for entry $07 of FamilyBandLists_Demon; it runs to the next list (E-0199)
FamilyBandSpecies_Demon_007::
    dw MONSTER_TITANIS ; id 0
    dw $fefe ; id 1

; family 7 (Zombie) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Zombie::
    dw FamilyBandSpecies_Zombie_000 ; id 0
    dw FamilyBandSpecies_Zombie_001 ; id 1
    dw FamilyBandSpecies_Zombie_002 ; id 2
    dw FamilyBandSpecies_Zombie_003 ; id 3
    dw FamilyBandSpecies_Zombie_004 ; id 4
    dw FamilyBandSpecies_Zombie_005 ; id 5
    dw FamilyBandSpecies_Zombie_006 ; id 6
    dw FamilyBandSpecies_Zombie_007 ; id 7

; list for entry $00 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Zombie_000::
    dw MONSTER_SPOOKY ; id 0
    dw $fefe ; id 1

; list for entry $01 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_001::
    dw MONSTER_ROTRAVEN ; id 0
    dw MONSTER_MUDRON ; id 1
    dw MONSTER_INVERZON ; id 2
    dw MONSTER_FOXFIRE ; id 3
    dw $fefe ; id 4

; list for entry $02 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_002::
    dw MONSTER_PUTREPUP ; id 0
    dw MONSTER_MUMMY ; id 1
    dw MONSTER_SHADOW ; id 2
    dw MONSTER_SKULPENT ; id 3
    dw MONSTER_HORK ; id 4
    dw MONSTER_NITEWHIP ; id 5
    dw MONSTER_WINDMERGE ; id 6
    dw MONSTER_POMPOMBOM ; id 7
    dw $fefe ; id 8

; list for entry $03 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_003::
    dw MONSTER_DARKCRAB ; id 0
    dw MONSTER_DEADNITE ; id 1
    dw MONSTER_REAPER ; id 2
    dw MONSTER_CAPTDEAD ; id 3
    dw MONSTER_BONESLAVE ; id 4
    dw MONSTER_MADSPIRIT ; id 5
    dw $fefe ; id 6

; list for entry $04 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Zombie_004::
    dw MONSTER_SKELETOR ; id 0
    dw $fefe ; id 1

; list for entry $05 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_005::
    dw MONSTER_SKULLGON ; id 0
    dw MONSTER_SERVANT ; id 1
    dw $fefe ; id 2

; list for entry $06 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_006::
    dw MONSTER_DEADNOBLE ; id 0
    dw MONSTER_WHITEKING ; id 1
    dw MONSTER_COPYCAT ; id 2
    dw MONSTER_NITERICH ; id 3
    dw $fefe ; id 4

; list for entry $07 of FamilyBandLists_Zombie; it runs to the next list (E-0199)
FamilyBandSpecies_Zombie_007::
    dw MONSTER_LAZAMANUS ; id 0
    dw $fefe ; id 1

; family 8 (Material) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Material::
    dw FamilyBandSpecies_Material_000 ; id 0
    dw FamilyBandSpecies_Material_001 ; id 1
    dw FamilyBandSpecies_Material_002 ; id 2
    dw FamilyBandSpecies_Material_003 ; id 3
    dw FamilyBandSpecies_Material_004 ; id 4
    dw FamilyBandSpecies_Material_005 ; id 5
    dw FamilyBandSpecies_Material_006 ; id 6
    dw FamilyBandSpecies_Material_007 ; id 7

; list for entry $00 of FamilyBandLists_Material; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Material_000::
    dw MONSTER_MADCANDLE ; id 0
    dw MONSTER_FACER ; id 1
    dw MONSTER_SPIKYBOY ; id 2
    dw MONSTER_GOOPI ; id 3
    dw MONSTER_MUDDOLL ; id 4
    dw $fefe ; id 5

; list for entry $01 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_001::
    dw MONSTER_JEWELBAG ; id 0
    dw MONSTER_COILBIRD ; id 1
    dw MONSTER_BRUSHEAD ; id 2
    dw $fefe ; id 3

; list for entry $02 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_002::
    dw MONSTER_EVILWAND ; id 0
    dw MONSTER_PUPPETOR ; id 1
    dw MONSTER_CURSELAMP ; id 2
    dw MONSTER_PROTOMECH ; id 3
    dw $fefe ; id 4

; list for entry $03 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_003::
    dw MONSTER_MADMIRROR ; id 0
    dw MONSTER_ROGUENITE ; id 1
    dw MONSTER_VOODOLL ; id 2
    dw MONSTER_SABREMAN ; id 3
    dw MONSTER_EVILPOT ; id 4
    dw MONSTER_GISMO ; id 5
    dw MONSTER_EXAUCERS ; id 6
    dw $fefe ; id 7

; list for entry $04 of FamilyBandLists_Material; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Material_004::
    dw MONSTER_METALDRAK ; id 0
    dw MONSTER_ROBOSTER ; id 1
    dw MONSTER_MIMIC ; id 2
    dw MONSTER_GOLEM ; id 3
    dw MONSTER_BOMBCRAG ; id 4
    dw MONSTER_CLOUDKING ; id 5
    dw $fefe ; id 6

; list for entry $05 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_005::
    dw MONSTER_BALZAK ; id 0
    dw MONSTER_ROBOSTER2 ; id 1
    dw MONSTER_LAVAMAN ; id 2
    dw MONSTER_ICEMAN ; id 3
    dw MONSTER_STONEMAN ; id 4
    dw $fefe ; id 5

; list for entry $06 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_006::
    dw MONSTER_GOLDGOLEM ; id 0
    dw $fefe ; id 1

; list for entry $07 of FamilyBandLists_Material; it runs to the next list (E-0199)
FamilyBandSpecies_Material_007::
    dw MONSTER_DARKMATE ; id 0
    dw $fefe ; id 1

; family 9 (Water) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Water::
    dw FamilyBandSpecies_Water_000 ; id 0
    dw FamilyBandSpecies_Water_001 ; id 1
    dw FamilyBandSpecies_Water_002 ; id 2
    dw FamilyBandSpecies_Water_003 ; id 3
    dw FamilyBandSpecies_Water_004 ; id 4
    dw FamilyBandSpecies_Water_005 ; id 5
    dw FamilyBandSpecies_Water_006 ; id 6
    dw FamilyBandSpecies_Water_007 ; id 7

; list for entry $00 of FamilyBandLists_Water; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Water_000::
    dw MONSTER_PETITEEL ; id 0
    dw MONSTER_MORAY ; id 1
    dw MONSTER_PUTREFISH ; id 2
    dw $fefe ; id 3

; list for entry $01 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_001::
    dw MONSTER_OCTOKID ; id 0
    dw MONSTER_GAMANIAN ; id 1
    dw MONSTER_SCALLOPA ; id 2
    dw MONSTER_STARFISH ; id 3
    dw $fefe ; id 4

; list for entry $02 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_002::
    dw MONSTER_ANEMON ; id 0
    dw MONSTER_AQUARELLA ; id 1
    dw MONSTER_OCTOREACH ; id 2
    dw MONSTER_ROGUEWAVE ; id 3
    dw MONSTER_PUMPOISE ; id 4
    dw $fefe ; id 5

; list for entry $03 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_003::
    dw MONSTER_WALRUSMAN ; id 0
    dw MONSTER_RAYGIGAS ; id 1
    dw MONSTER_MERMAN ; id 2
    dw MONSTER_ANGLERON ; id 3
    dw MONSTER_FISHRIDER ; id 4
    dw MONSTER_CLAWSTER ; id 5
    dw $fefe ; id 6

; list for entry $04 of FamilyBandLists_Water; it runs to the next list (E-0199)
; record: species
FamilyBandSpecies_Water_004::
    dw MONSTER_RUSHFISH ; id 0
    dw MONSTER_CANCERMAN ; id 1
    dw MONSTER_SEAHORSE ; id 2
    dw MONSTER_HOODSQUID ; id 3
    dw MONSTER_MERTIGER ; id 4
    dw $fefe ; id 5

; list for entry $05 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_005::
    dw MONSTER_AXESHARK ; id 0
    dw MONSTER_OCTOGON ; id 1
    dw MONSTER_DIGONG ; id 2
    dw MONSTER_WHALEMAGE ; id 3
    dw MONSTER_OCTORAID ; id 4
    dw $fefe ; id 5

; list for entry $06 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_006::
    dw MONSTER_AQUADON ; id 0
    dw MONSTER_GRAKOS ; id 1
    dw $fefe ; id 2

; list for entry $07 of FamilyBandLists_Water; it runs to the next list (E-0199)
FamilyBandSpecies_Water_007::
    dw MONSTER_POSEIDON ; id 0
    dw $fefe ; id 1

; family 10 (Boss) of FamilyBandSpeciesTable, one list per wRankBand (E-0256, C1)
; record: species list for this band
FamilyBandLists_Boss::
    dw FamilyBandSpecies_Boss ; id 0
    dw FamilyBandSpecies_Boss_01 ; id 1
    dw FamilyBandSpecies_Boss_02 ; id 2
    dw FamilyBandSpecies_Boss_03 ; id 3
    dw FamilyBandSpecies_Boss_04 ; id 4
    dw FamilyBandSpecies_Boss_05 ; id 5
    dw FamilyBandSpecies_Boss_06 ; id 6
    dw FamilyBandSpecies_Boss_15 ; id 7

; the boss family's eight band pointers start at successive words of this one list, so each band's
; list is a tail of it; 30 words up to RandomModulo29_BankF0 at $7097 (E-0256, C1)
; record: species ($FFFF skipped, $FEFE ends a list)
FamilyBandSpecies_Boss::
    dw $ffff ; id 0
FamilyBandSpecies_Boss_01::
    dw $ffff ; id 1
FamilyBandSpecies_Boss_02::
    dw $ffff ; id 2
FamilyBandSpecies_Boss_03::
    dw $ffff ; id 3
FamilyBandSpecies_Boss_04::
    dw $ffff ; id 4
FamilyBandSpecies_Boss_05::
    dw $ffff ; id 5
FamilyBandSpecies_Boss_06::
    dw MONSTER_DRACOLORD ; id 6
    dw MONSTER_DRACOLORD_160 ; id 7
    dw MONSTER_HARGON ; id 8
    dw MONSTER_SIDOH ; id 9
    dw MONSTER_BARAMOS ; id 10
    dw MONSTER_ZOMA ; id 11
    dw MONSTER_PIZZARO ; id 12
    dw MONSTER_ESTERK ; id 13
    dw MONSTER_MIRUDRAAS ; id 14
    dw MONSTER_MIRUDRAAS_16C ; id 15
    dw MONSTER_MUDOU ; id 16
    dw MONSTER_DEATHMORE ; id 17
    dw MONSTER_DEATHMORE_16F ; id 18
    dw MONSTER_DARCK ; id 19
    dw $fefe ; id 20
FamilyBandSpecies_Boss_15::
    dw MONSTER_LORDDRACO ; id 21
    dw MONSTER_GENOSIDOH ; id 22
    dw MONSTER_ASURAZOMA ; id 23
    dw MONSTER_PSYCHOPIZ ; id 24
    dw MONSTER_DEATHMORE_170 ; id 25
    dw MONSTER_DARKDRIUM ; id 26
    dw MONSTER_ORGODEMIR ; id 27
    dw MONSTER_ORGODEMIR_173 ; id 28
    dw $fefe ; id 29

; B = mask. Steps the table random number (NextTableByte), forms HL = wRandomLo + 256 * ((wRandomLo
; * 2) AND B) and divides HL by 41 ($29) with DivideHLByA: HL = the quotient, A = the remainder.
; With B = $0F the quotient is 0-99 and with B = $1F 0-199. Every caller in this bank uses the
; quotient (L), as a percentage roll or a value to reduce, and ignores the remainder. It is the copy
; in this bank of RandomModulo29 (bank $0E). (C2, E-0385)
; NextTableByte; L = wRandomLo, H = (wRandomLo rotated left through carry) & B; returns A = HL mod
; $29 (E-0118)
RandomModulo29_BankF0::
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and b
    ld h, a
    ld a, $29
    call DivideHLByA
    ret

; A = 4 when wFamilyBitCount is below 4, 5 when below 6, 6 when below 10, else 7.
; RankFamilyScoresIntoFamilyRanking stores it in wRankBand to pick one of the 8 band lists of each
; family (only bands 4-7 are ever chosen), and RunLinkSession8Exchange_Trade_RankFamilies scales the
; number of resistance raises by 8 minus this band. (C2, E-0385)
; A = 4, 5, 6 or 7 for wFamilyBitCount < 4, < 6, < $0A, or more (E-0124)
BandOfFamilyBitCount::
    ld a, [wFamilyBitCount]
    cp $04
    jr c, .return_04
    cp $06
    jr c, .return_05
    cp $0a
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

; no reference found in any bank (no address load, word or split high/low load of $70C5-$7244); 384
; bytes after BandOfFamilyBitCount's last ret, all values 0-7, in runs that climb to 6 or 7
; separated by zeros; meaning unknown, kept as 16-byte rows (E-0241, C0)
; record: bytes
UnreferencedBytesF0_1::
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

; B = a bit number (RunLinkSession8Exchange_Trade_Pack passes wLinkEggFamilyBit, the partner family
; bit). When B differs from wLastMarkedBit, adds 1 to wMarkChangeCount (it stops at $FF) and B
; becomes wLastMarkedBit. Then if bit B of the wFamilyBits array (bit 0 is the high bit of its first
; byte) is clear, sets it, adds 1 to wFamilyBitCount (stops at $FF) and returns C = 0; if it was
; already set returns C = $FF and leaves the count alone. (C2, E-0385)
; wMarkChangeCount counts changes of B (wLastMarkedBit); if bit B of the wFamilyBits array is new,
; sets it, wFamilyBitCount += 1 and C = 0; otherwise C = $FF (E-0125)
MarkBitBInFamilyBitsAndCount::
    ld a, [wLastMarkedBit]
    cp b
    jr z, .set_last_marked_bit
    ld a, [wMarkChangeCount]
    cp $ff
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
    cp $ff
    jr z, .done2
    ld a, [wLastMarkedBit]
    ld hl, wFamilyBits
    ld e, a
    ld d, $00
    call OrDIntoTestBitDEOfBitArrayHLByte
    ld a, [wFamilyBitCount]
    cp $ff
    jr nc, .done
    inc a
    ld [wFamilyBitCount], a

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

; Records a gift given to the Egg: adds 1 to wGiftCount (it stops at $0F). When wPendingGiftItem is
; not 0 (the previous gift), rolls 0-99 with RandomModulo29_BankF0 and runs ApplyGiftEffectByItem
; when the roll is below 100 - 5 * wGiftCount. Then wArg1, the item being given now, becomes
; wPendingGiftItem. So each gift takes effect only when the next one is given, with a smaller chance
; the more gifts have been given. PauseMenu_State4_GiftMenu_GiveGift_Check far-calls it with wArg1
; set; ClearRollCounterWhenGM2TimerMinutesIs59 resets wGiftCount. (C2, E-0385)
; wGiftCount (wGiftCount) += 1 up to $0F; when a gift is pending (wPendingGiftItem,
; wPendingGiftItem), applies its effect (ApplyGiftEffectByItem) if a random value is below 100 - 5 *
; wGiftCount; then the new gift item (wArg1, from PauseMenu_State4_GiftMenu_GiveGift) becomes
; pending (E-0124, E-0295)
RecordGiftAndMaybeApplyPrevious::
    ld a, [wGiftCount]
    cp $0f
    jr nc, .check_pending_gift_item
    inc a
    ld [wGiftCount], a

.check_pending_gift_item:
    ld a, [wPendingGiftItem]
    and a
    jr z, .read_arg1
    ld a, [wGiftCount]
    ld c, $05
    call Multiply8
    ld a, $64
    sub l
    ld l, a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    pop de
    ld a, l
    cp e
    call c, ApplyGiftEffectByItem

.read_arg1:
    ld a, [wArg1]
    ld [wPendingGiftItem], a
    ret

; Returns unless wGM2TimerMinutes is $3B and wGM2TimerSeconds and wGM2TimerFrames are 0. In that one
; frame it sets wGiftCount to 0 and then falls straight into ApplyGiftEffectByItem, so the pending
; gift (wPendingGiftItem) takes effect at once with no roll (with nothing pending that is
; GiftEffect_Item00). FarClearRollCounterWhenGM2TimerMinutesIs59 far-calls it, and several field
; states call that wrapper every frame. (C2, E-0385)
; when wGM2TimerMinutes = $3B and wGM2TimerSeconds = wGM2TimerFrames = 0, clears wGiftCount and
; falls through (E-0122)
ClearRollCounterWhenGM2TimerMinutesIs59::
    ld a, [wGM2TimerMinutes]
    cp $3b
    ret nz
    ld a, [wGM2TimerSeconds]
    and a
    ret nz
    ld a, [wGM2TimerFrames]
    and a
    ret nz
    xor a
    ld [wGiftCount], a

; Runs the effect of the gift item in wPendingGiftItem: a jump table of 98 entries indexed by item
; id ($00-$61); items with no effect share GiftEffect_None. The index is not range checked. Each
; effect adds to one stat word of wGiftRecord (at most 999) and to or from entries of wFamilyScores,
; then clears wPendingGiftItem. Reached from RecordGiftAndMaybeApplyPrevious after a successful
; roll, and by fall-through from ClearRollCounterWhenGM2TimerMinutesIs59. (C2, E-0385)
; jumps by wPendingGiftItem (the item id of the previous gift, stored by
; RecordGiftAndMaybeApplyPrevious) to that item's effect; each effect adds to the gift record's
; MON_MAX_HP (wGiftRecord, capped at 999) and to or from entries of wFamilyScores, then clears
; wPendingGiftItem (E-0312)
ApplyGiftEffectByItem::
    ld a, [wPendingGiftItem]
    jumptable
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
    dw GiftEffect_None
    dw GiftEffect_TinyMedal
    dw GiftEffect_GoldPass
    dw GiftEffect_LogTwig
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
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
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_None
    dw GiftEffect_Life
    dw GiftEffect_Divine
    dw GiftEffect_War
    dw GiftEffect_Mage
    dw GiftEffect_Fight
    dw GiftEffect_Sailor
    dw GiftEffect_Thief
    dw GiftEffect_Cleric

; Gift effect for ITEM_00, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; wFamilyScores + 7 (family 7, Zombie; at most 254); it does not clear wPendingGiftItem. (C2,
; E-0385)
; gift effect for item $00 : case of ApplyGiftEffectByItem
GiftEffect_Item00::
    ld hl, wFamilyScores + $7
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ret

; Gift effect for ITEM_HERB, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 0 (family 0, Slime; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $01 Herb: case of ApplyGiftEffectByItem
GiftEffect_Herb::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_LOVEWATER, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 9 (family 9, Water;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $02 LoveWater: case of ApplyGiftEffectByItem
GiftEffect_LoveWater::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WORLDDEW, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 1 (family 1,
; Dragon; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit
; 7 set, as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $03 WorldDew: case of ApplyGiftEffectByItem
GiftEffect_WorldDew::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_POTION, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_MAX_MP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 6 (family 6, Demon; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $04 Potion: case of ApplyGiftEffectByItem
GiftEffect_Potion::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_ELFWATER, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 4 (family 4, Plant;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $05 ElfWater: case of ApplyGiftEffectByItem
GiftEffect_ElfWater::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_ANTIDOTE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem:
; subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as when it would go
; below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $06 Antidote: case of ApplyGiftEffectByItem
GiftEffect_Antidote::
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MOONHERB, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_ATK word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 2 (family 2, Beast; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $07 MoonHerb: case of ApplyGiftEffectByItem
GiftEffect_MoonHerb::
    ld hl, wGiftRecord + MON_ATK
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_LAUREL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_DEF word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 3 (family 3, Bird; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $08 Laurel: case of ApplyGiftEffectByItem
GiftEffect_Laurel::
    ld hl, wGiftRecord + MON_DEF
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_AWAKESAND, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_AGL word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 5 (family 5, Bug; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $09 AwakeSand: case of ApplyGiftEffectByItem
GiftEffect_AwakeSand::
    ld hl, wGiftRecord + MON_AGL
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SKYBELL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_INT word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 8 (family 8, Material;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $0A SkyBell: case of ApplyGiftEffectByItem
GiftEffect_SkyBell::
    ld hl, wGiftRecord + MON_INT
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SAGEROCK, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 8 (family 8,
; Material; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with
; bit 7 set, as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $0B SageRock: case of ApplyGiftEffectByItem
GiftEffect_SageRock::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WORLDLEAF, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 4 (family 4, Plant;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $0C WorldLeaf: case of ApplyGiftEffectByItem
GiftEffect_WorldLeaf::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_ATKSEED, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_ATK word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7 (family
; 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $0D ATKseed: case of ApplyGiftEffectByItem
GiftEffect_ATKseed::
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DEFSEED, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_DEF word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7 (family
; 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $0E DEFseed: case of ApplyGiftEffectByItem
GiftEffect_DEFseed::
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_AGLSEED, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_AGL word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7 (family
; 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $0F AGLseed: case of ApplyGiftEffectByItem
GiftEffect_AGLseed::
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_INTSEED, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_INT word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7 (family
; 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $10 INTseed: case of ApplyGiftEffectByItem
GiftEffect_INTseed::
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_LIFEACORN, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5
; to the MON_MAX_HP word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7
; (family 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $11 LifeAcorn: case of ApplyGiftEffectByItem
GiftEffect_LifeAcorn::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MYSTICNUT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5
; to the MON_MAX_MP word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7
; (family 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $12 MysticNut: case of ApplyGiftEffectByItem
GiftEffect_MysticNut::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_QUEST, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 1 (family 1, Dragon; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $13 Quest?: case of ApplyGiftEffectByItem
GiftEffect_Quest::
    ld hl, wGiftRecord + MON_ATK
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_HORROR, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_DEF word of wGiftRecord (at most 999), adds 5 to wFamilyScores + 2 (family 2, Beast; at
; most 250), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $14 Horror?: case of ApplyGiftEffectByItem
GiftEffect_Horror::
    ld hl, wGiftRecord + MON_DEF
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $05
    ld c, $fa
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BENICE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 3 (family 3, Bird; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $15 BeNice?: case of ApplyGiftEffectByItem
GiftEffect_BeNice::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_CHEATER, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5
; to the MON_AGL word of wGiftRecord (at most 999), adds 5 to wFamilyScores + 6 (family 6, Demon; at
; most 250), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $16 Cheater?: case of ApplyGiftEffectByItem
GiftEffect_Cheater::
    ld hl, wGiftRecord + MON_AGL
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $05
    ld c, $fa
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SMART, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_INT word of wGiftRecord (at most 999), adds 5 to wFamilyScores + 4 (family 4, Plant; at
; most 250), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $17 Smart?: case of ApplyGiftEffectByItem
GiftEffect_Smart::
    ld hl, wGiftRecord + MON_INT
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $05
    ld c, $fa
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_COMEDY, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_MAX_MP word of wGiftRecord (at most 999), adds 5 to wFamilyScores + 0 (family 0, Slime; at
; most 250), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $18 Comedy?: case of ApplyGiftEffectByItem
GiftEffect_Comedy::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $05
    ld c, $fa
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BEEFJERKY, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_MAX_HP word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7
; (family 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $19 BeefJerky: case of ApplyGiftEffectByItem
GiftEffect_BeefJerky::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_PORKCHOP, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 8 (family 8,
; Material; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with
; bit 7 set, as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $1A PorkChop: case of ApplyGiftEffectByItem
GiftEffect_PorkChop::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_RIB, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 5 (family 5, Bug; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $1B Rib: case of ApplyGiftEffectByItem
GiftEffect_Rib::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SIRLOIN, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 9 (family 9, Water;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $1C Sirloin: case of ApplyGiftEffectByItem
GiftEffect_Sirloin::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BADMEAT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_MAX_HP word of wGiftRecord (at most 999), and adds 5 to wFamilyScores + 7 (family 7,
; Zombie; at most 250), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $1D BadMeat: case of ApplyGiftEffectByItem
GiftEffect_BadMeat::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $05
    ld c, $fa
    call AddBClampedToC
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_METEORB, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to wFamilyScores + 10 (family 10, Boss; at most 254), and subtracts 2 from wFamilyScores + 7
; (family 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $1E MeteOrb: case of ApplyGiftEffectByItem
GiftEffect_MeteOrb::
    ld hl, wFamilyScores + $a
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BEASTTAIL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem:
; changes nothing except clearing wPendingGiftItem. (C2, E-0385)
; gift effect for item $1F BeastTail: case of ApplyGiftEffectByItem
GiftEffect_BeastTail::
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_REPELLENT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_MAX_HP word of wGiftRecord (at most 999), and subtracts 2 from wFamilyScores + 7
; (family 7, Zombie; a result with bit 7 set, as when it would go below 0, becomes 0), then clears
; wPendingGiftItem. (C2, E-0385)
; gift effect for item $20 Repellent: case of ApplyGiftEffectByItem
GiftEffect_Repellent::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SHINYHARP, a case of ApplyGiftEffectByItem picked by wPendingGiftItem:
; changes nothing except clearing wPendingGiftItem. (C2, E-0385)
; gift effect for item $21 ShinyHarp: case of ApplyGiftEffectByItem
GiftEffect_ShinyHarp::
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MIST, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 6 (family 6, Demon; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $22 Mist?: case of ApplyGiftEffectByItem
GiftEffect_Mist::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_FRIEND, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 2 (family 2, Beast; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $23 Friend?: case of ApplyGiftEffectByItem
GiftEffect_Friend::
    ld hl, wGiftRecord + MON_ATK
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WIND, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_DEF word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 0 (family 0, Slime; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $24 Wind?: case of ApplyGiftEffectByItem
GiftEffect_Wind::
    ld hl, wGiftRecord + MON_DEF
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BOLT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_AGL word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 4 (family 4, Plant; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $25 Bolt?: case of ApplyGiftEffectByItem
GiftEffect_Bolt::
    ld hl, wGiftRecord + MON_AGL
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SNOW, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_INT word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 5 (family 5, Bug; at most
; 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as when
; it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $26 Snow?: case of ApplyGiftEffectByItem
GiftEffect_Snow::
    ld hl, wGiftRecord + MON_INT
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_FIRE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 1 (family 1, Dragon; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $27 Fire?: case of ApplyGiftEffectByItem
GiftEffect_Fire::
    ld hl, wGiftRecord + MON_ATK
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WARP, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2 to
; the MON_DEF word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 9 (family 9, Water; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $28 Warp?: case of ApplyGiftEffectByItem
GiftEffect_Warp::
    ld hl, wGiftRecord + MON_DEF
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WARPWING, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2
; to the MON_AGL word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 3 (family 3, Bird; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $29 WarpWing: case of ApplyGiftEffectByItem
GiftEffect_WarpWing::
    ld hl, wGiftRecord + MON_AGL
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_EXITBELL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 2
; to the MON_INT word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 8 (family 8, Material;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $2A ExitBell: case of ApplyGiftEffectByItem
GiftEffect_ExitBell::
    ld hl, wGiftRecord + MON_INT
    ld b, $02
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BOOKMARK ($2B), $2F-$3F (ITEM_2F to ITEM_ACCESSORY_3F) and $54-$59 (ITEM_NONE
; to ITEM_NONE_59), a case of ApplyGiftEffectByItem picked by wPendingGiftItem: changes nothing
; except clearing wPendingGiftItem. (C2, E-0385)
; gift effect for item $2B Bookmark, $2F , $30 WaterCall, $31 MoonRock, $32 Crest, $33 YunaSoul ...:
; case of ApplyGiftEffectByItem
GiftEffect_None::
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_TINYMEDAL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem:
; changes nothing except clearing wPendingGiftItem. (C2, E-0385)
; gift effect for item $2C TinyMedal: case of ApplyGiftEffectByItem
GiftEffect_TinyMedal::
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_GOLDPASS, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: changes
; nothing except clearing wPendingGiftItem. (C2, E-0385)
; gift effect for item $2D GoldPass: case of ApplyGiftEffectByItem
GiftEffect_GoldPass::
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_LOGTWIG, a case of ApplyGiftEffectByItem picked by wPendingGiftItem:
; subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as when it would go
; below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $2E LogTwig: case of ApplyGiftEffectByItem
GiftEffect_LogTwig::
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_VITBELT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 5 (family 5, Bug;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $40 VITbelt: case of ApplyGiftEffectByItem
GiftEffect_VITbelt::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DRACOBELT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 8
; to the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 5 (family 5, Bug;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $41 DracoBelt: case of ApplyGiftEffectByItem
GiftEffect_DracoBelt::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $08
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MAGICBELT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_MAX_MP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 4 (family 4, Plant;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $42 MagicBelt: case of ApplyGiftEffectByItem
GiftEffect_MagicBelt::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_ODDBELT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 8
; to the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 4 (family 4, Plant;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $43 OddBelt: case of ApplyGiftEffectByItem
GiftEffect_OddBelt::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $08
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_STONEFANG, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_ATK word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 2 (family 2, Beast; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $44 StoneFang: case of ApplyGiftEffectByItem
GiftEffect_StoneFang::
    ld hl, wGiftRecord + MON_ATK
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_STEELFANG, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5
; to the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 2 (family 2, Beast; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $45 SteelFang: case of ApplyGiftEffectByItem
GiftEffect_SteelFang::
    ld hl, wGiftRecord + MON_ATK
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MERMSCALE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_DEF word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 9 (family 9, Water; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $46 MermScale: case of ApplyGiftEffectByItem
GiftEffect_MermScale::
    ld hl, wGiftRecord + MON_DEF
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DRAKSCALE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5
; to the MON_DEF word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 9 (family 9, Water; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $47 DrakScale: case of ApplyGiftEffectByItem
GiftEffect_DrakScale::
    ld hl, wGiftRecord + MON_DEF
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_AGL, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_AGL word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 0 (family 0, Slime; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $48 AGL?: case of ApplyGiftEffectByItem
GiftEffect_AGL::
    ld hl, wGiftRecord + MON_AGL
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_STARRY, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_AGL word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 0 (family 0, Slime; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $49 Starry?: case of ApplyGiftEffectByItem
GiftEffect_Starry::
    ld hl, wGiftRecord + MON_AGL
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SMART_4A, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1
; to the MON_INT word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 6 (family 6, Demon; at
; most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4A Smart?: case of ApplyGiftEffectByItem
GiftEffect_Smart_4A::
    ld hl, wGiftRecord + MON_INT
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WISE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 5 to
; the MON_INT word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 6 (family 6, Demon; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4B Wise?: case of ApplyGiftEffectByItem
GiftEffect_Wise::
    ld hl, wGiftRecord + MON_INT
    ld b, $05
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MAGICCAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 8
; to the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 3 (family 3, Bird;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4C MagicCape: case of ApplyGiftEffectByItem
GiftEffect_MagicCape::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $08
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DRACOCAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 1 (family 1, Dragon;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4D DracoCape: case of ApplyGiftEffectByItem
GiftEffect_DracoCape::
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SILVRCAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_AGL word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 8 (family 8, Material;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4E SilvrCape: case of ApplyGiftEffectByItem
GiftEffect_SilvrCape::
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_GOLDCAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_INT word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 8 (family 8, Material;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $4F GoldCape: case of ApplyGiftEffectByItem
GiftEffect_GoldCape::
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_PLTNMCAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_DEF word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 10 (family 10, Boss;
; at most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $50 PltnmCape: case of ApplyGiftEffectByItem
GiftEffect_PltnmCape::
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $a
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_ORCACAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_AGL word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 9 (family 9, Water; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $51 OrcaCape: case of ApplyGiftEffectByItem
GiftEffect_OrcaCape::
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_BRAVECAPE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3
; to the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 2 (family 2, Beast; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $52 BraveCape: case of ApplyGiftEffectByItem
GiftEffect_BraveCape::
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DSCALE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 1 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 1 to wFamilyScores + 1 (family 1, Dragon;
; at most 254), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set,
; as when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $53 D-Scale: case of ApplyGiftEffectByItem
GiftEffect_DScale::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $01
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $1
    ld b, $01
    ld c, $fe
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_LIFE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 5 (family 5, Bug; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5A Life?: case of ApplyGiftEffectByItem
GiftEffect_Life::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $5
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_DIVINE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 4 (family 4, Plant; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5B Divine?: case of ApplyGiftEffectByItem
GiftEffect_Divine::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $4
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_WAR, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_MAX_HP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 9 (family 9, Water; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5C War?: case of ApplyGiftEffectByItem
GiftEffect_War::
    ld hl, wGiftRecord + MON_MAX_HP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $9
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_MAGE, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_MAX_MP word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 6 (family 6, Demon; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5D Mage?: case of ApplyGiftEffectByItem
GiftEffect_Mage::
    ld hl, wGiftRecord + MON_MAX_MP
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $6
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_FIGHT, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_ATK word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 2 (family 2, Beast; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5E Fight?: case of ApplyGiftEffectByItem
GiftEffect_Fight::
    ld hl, wGiftRecord + MON_ATK
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $2
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_SAILOR, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_DEF word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 8 (family 8, Material; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $5F Sailor?: case of ApplyGiftEffectByItem
GiftEffect_Sailor::
    ld hl, wGiftRecord + MON_DEF
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $8
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_THIEF, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_AGL word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 3 (family 3, Bird; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $60 Thief?: case of ApplyGiftEffectByItem
GiftEffect_Thief::
    ld hl, wGiftRecord + MON_AGL
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores + $3
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; Gift effect for ITEM_CLERIC, a case of ApplyGiftEffectByItem picked by wPendingGiftItem: adds 3 to
; the MON_INT word of wGiftRecord (at most 999), adds 2 to wFamilyScores + 0 (family 0, Slime; at
; most 253), and subtracts 2 from wFamilyScores + 7 (family 7, Zombie; a result with bit 7 set, as
; when it would go below 0, becomes 0), then clears wPendingGiftItem. (C2, E-0385)
; gift effect for item $61 Cleric?: case of ApplyGiftEffectByItem
GiftEffect_Cleric::
    ld hl, wGiftRecord + MON_INT
    ld b, $03
    ld de, $03e7
    call AddBToWordAtHLCapped
    ld hl, wFamilyScores
    ld b, $02
    ld c, $fd
    call AddBClampedToC
    ld hl, wFamilyScores + $7
    ld b, $02
    call SubtractBClampedAtZero
    xor a
    ld [wPendingGiftItem], a
    ret

; HL = address of a byte, B = amount, C = cap: [HL] = [HL] + B, but not above C. The 8-bit sum wraps
; at $100 before it is compared (250 + 10 with C = 250 gives 4). Clobbers A and C (C ends as the old
; C + 1). Used by the gift effect routines to raise a family score. (C2, E-0385)
; [HL] = min([HL] + B, C) (8-bit add, no overflow check); clobbers A, C
AddBClampedToC::
    inc c
    ld a, [hl]
    add b
    cp c
    jr c, .done
    ld a, c
    dec a

.done:
    ld [hl], a
    ret

; HL = address of a byte, B = amount: [HL] = [HL] - B, or 0 when the 8-bit result has bit 7 set
; (going below 0, or any value of $80 or more). Clobbers A. Used by the gift effect routines to
; lower a family score. (C2, E-0385)
; [HL] = [HL] - B, or 0 when the result has bit 7 set; clobbers A
SubtractBClampedAtZero::
    ld a, [hl]
    sub b
    bit 7, a
    jr z, .done
    xor a

.done:
    ld [hl], a
    ret

; HL = address of a 16-bit word (low byte first), B = amount, DE = cap: the word becomes word + B,
; or DE when that sum is above DE, so a word already above DE is lowered to DE. DE is kept; clobbers
; A, BC and HL. The gift effect routines add to a stat of wGiftRecord with DE = 999. (C2, E-0385)
; HL = address of a word: word = min(word + B, DE) (CompareHLWithDE); DE kept; clobbers A, BC, HL
; (E-0061)
AddBToWordAtHLCapped::
    push hl
    ld a, [hli]
    add b
    ld c, a
    ld a, [hl]
    adc $00
    ld h, a
    ld l, c
    call CompareHLWithDE
    ld a, c
    cp $ff
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

; Unsigned 16-bit compare: C = 0 when HL < DE, 1 when HL = DE, $FF when HL > DE. Clobbers A. Only
; AddBToWordAtHLCapped calls it. (C2, E-0385)
; unsigned 16-bit compare: C = 0 when HL < DE, 1 when equal, $FF when HL > DE; clobbers A (E-0061)
CompareHLWithDE::
    ld a, h
    cp d
    jr c, .done2
    jr nz, .done
    ld a, l
    cp e
    jr c, .done2
    jr z, .done3

.done:
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; HL = a species id word (low byte, then high byte), DE = destination: copies the name string of
; that monster from the string database of bank $08 up to and including its $F0 end mark. A high
; byte of 0 uses database list 2 (the table at $4036 of bank $08), any other high byte list 3
; (StringDatabase_MonsterNames2); the low byte indexes the list. Used by the hatching scene steps to
; put the egg species name into wTextBuf1. (C2, E-0385)
; copies the $F0-terminated string [HL] of the category chosen by [HL + 1]
; (CopyNameStringFromBank08Database_Data or StringDatabase_MonsterNames2) from bank 8 to HL (E-0125)
CopyNameStringFromBank08Database::
    push de
    inc hl
    ld a, [hld]
    and a
    jr nz, .skip
    ld de, CopyNameStringFromBank08Database_Data
    jr .call_read_far_pointer_at_de_in_bank_b

.skip:
    ld de, StringDatabase_MonsterNames2

.call_read_far_pointer_at_de_in_bank_b:
    push hl
    ld b, BANK(StringDatabase_MonsterNames2)
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
    cp $f0
    jr z, .done
    ld [hli], a
    inc de
    jr .call_read_byte_in_bank

.done:
    ld a, $f0
    ld [hli], a
    ret

; HL = start of a bit array, DE = bit number: A = $FF when the bit is set, else 0. Bit 0 is the high
; bit of the first byte. HL ends at the byte (HL + DE / 8), D holds the one-bit mask and E is kept.
; MarkBitBInFamilyBitsAndCount and OrDIntoTestBitDEOfBitArrayHLByte use it. (C2, E-0385)
; A = $FF when bit DE of the bit array at HL is set (mask TestBitDEOfBitArrayHL_Data), else 0; HL is
; left at the byte (E-0124)
TestBitDEOfBitArrayHL::
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
    and $07
    ld hl, TestBitDEOfBitArrayHL_Data
    add_a_to_hl
    ld a, [hl]
    ld d, a
    pop hl
    ld a, [hl]
    and d
    jr nz, .return_FF
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; Eight single-bit masks, $80, $40, $20, $10, $08, $04, $02, $01. TestBitDEOfBitArrayHL adds DE / 8
; to HL, indexes the table with DE & 7 and ANDs the mask with that byte, returning $FF in A when the
; bit is set and 0 when it is clear, so bit 0 of the array is the high bit of its first byte. (C1,
; E-0381)
TestBitDEOfBitArrayHL_Data::
    db $80, $40, $20, $10, $08, $04, $02, $01

; HL = start of a bit array, DE = bit number: sets that bit. It runs TestBitDEOfBitArrayHL, which
; leaves HL at the byte and D as the one-bit mask, then ORs D into [HL]. (C2, E-0385)
; [HL from TestBitDEOfBitArrayHL] |= D (E-0122)
OrDIntoTestBitDEOfBitArrayHLByte::
    call TestBitDEOfBitArrayHL
    ld a, [hl]
    or d
    ld [hl], a
    ret

; Far-called by KeyWorldDoorItem_OpenDoor: clears the $D8 bytes from wGM2TimerFrames, then builds
; the record at wGiftRecord: MON_STATE 1, a blank MON_NAME ($F0 x 10), MON_SPECIES $001A, MON_FAMILY
; 0, a random MON_SEX bit, the player's name as MON_MASTER_NAME and wPlayerId as MON_MASTER_ID, $FF
; for both parent species, '???' ($98 glyphs) parent master names, $FF over MON_SKILLS and
; MON_SKILL_LIST, MON_STATUS 0, MON_LEVEL 1, MON_MAX_LEVEL 40, zero MON_EXP, then HP, MP, ATK, DEF,
; AGL and INT each (random mod 32) + 1 (HP and MP also copied to their maximums), zero MON_WLD,
; MON_PLUS and MON_EGG, four MON_PERSONALITY bytes of (random mod 254) + 1, zero resistances, blank
; parent names, and zero parent plus values and MON_ITEM. The random bytes come from
; RandomModulo29_BankF0 and KeyWorldDoorItem_ModuloBPlusOne. (C2, E-0371; probed E-0385)
KeyWorldDoorItem_OpenDoor_BuildGiftRecord::
    ld hl, wGM2TimerFrames
    ld bc, $00d8

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wGiftRecord
    ld a, $01
    ld [hli], a
    ld c, $0a

.loop2:
    ld a, $f0
    ld [hli], a
    dec c
    jr nz, .loop2
    ld a, $1a
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld a, l
    and $01
    pop hl
    ld [hli], a
    ld de, wPlayerName
    ld c, $0a

.loop3:
    ld a, [de]
    cp $f0
    jr z, .skip
    ld [hli], a
    inc de
    dec c
    jr nz, .loop3
    jr .read_player_id

.skip:
    ld a, $f0
    ld [hli], a

.read_player_id:
    ld hl, wGiftRecord + MON_MASTER_ID
    ld a, [wPlayerId]
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call KeyWorldDoorItem_WriteUnknownName
    ld c, $06
    ld b, $f0
    call KeyWorldDoorItem_FillCBytesWithB
    ld a, $f0
    ld [hli], a
    call KeyWorldDoorItem_WriteUnknownName
    ld c, $06
    ld b, $f0
    call KeyWorldDoorItem_FillCBytesWithB
    ld a, $f0
    ld [hli], a
    ld c, $21

.loop4:
    ld a, $ff
    ld [hli], a
    dec c
    jr nz, .loop4
    xor a
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $28
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $20
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    xor a
    ld [hli], a
    xor a
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $fe
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $fe
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $fe
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    push hl
    ld b, $0f
    call RandomModulo29_BankF0
    ld b, $fe
    call KeyWorldDoorItem_ModuloBPlusOne
    pop hl
    ld a, e
    ld [hli], a
    ld c, $1b

.loop5:
    xor a
    ld [hli], a
    dec c
    jr nz, .loop5
    ld c, $0a

.loop6:
    ld a, $f0
    ld [hli], a
    dec c
    jr nz, .loop6
    xor a
    ld [hli], a
    ld c, $0a

.loop7:
    ld a, $f0
    ld [hli], a
    dec c
    jr nz, .loop7
    xor a
    ld [hli], a
    xor a
    ld [hli], a
    ret

; Fills C bytes at HL with B (C = 0 fills 256); HL ends just past them and C ends 0.
; KeyWorldDoorItem_OpenDoor_BuildGiftRecord uses it for the $F0 padding of the parent names. (C2,
; E-0385)
; fills C bytes at HL with B
KeyWorldDoorItem_FillCBytesWithB::
    ld a, b
    ld [hli], a
    dec c
    jr nz, KeyWorldDoorItem_FillCBytesWithB
    ret

; Writes the placeholder name '???' ($98 is the glyph '?') and the $F0 end mark at HL; HL ends 4
; bytes on and A = $F0. KeyWorldDoorItem_OpenDoor_BuildGiftRecord uses it for the two parent master
; names. (C2, E-0385)
; writes three $98 placeholder glyphs and $F0 at HL
KeyWorldDoorItem_WriteUnknownName::
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ret

; DE = (L mod B) + 1, by repeated subtraction (D = 0, E = A = the result). L is the low byte of the
; quotient RandomModulo29_BankF0 leaves in HL, so this turns a roll into 1..B.
; KeyWorldDoorItem_OpenDoor_BuildGiftRecord calls it with B = $20 for the stats and $FE for the
; personality bytes. (C2, E-0385)
; DE = (L mod B) + 1
KeyWorldDoorItem_ModuloBPlusOne::
    ld a, l

.skip:
    cp b
    jr c, .skip2
    sub b
    jr .skip

.skip2:
    inc a
    ld e, a
    ld d, $00
    ret

; A = 1 with a chance that grows with wMarkChangeCount, else 0. Below 5 changes the answer is always
; 0. From 5 to 12 the threshold is 10 * (count - 4), from 13 on 80; the roll is the 0-99 quotient of
; RandomModulo29_BankF0 with B = $0F, and A = 1 only when the roll is below the threshold.
; RunLinkSession8Exchange_Trade_Pack stores the answer in wLinkEggState. (C2, E-0385)
; A = 1 with a chance growing with wMarkChangeCount (none below 5, 10 per step to 80 from 13), else
; 0 (E-0124)
RollMarkChangeCountChance::
    ld a, [wMarkChangeCount]
    cp $05
    jr nc, .cp_0D

.loop:
    xor a
    ret

.cp_0D:
    cp $0d
    jr nc, .skip
    sub $04
    ld c, $0a
    call Multiply8
    ld e, l
    jr .call_random_modulo29_bank_f0

.skip:
    ld e, $50

.call_random_modulo29_bank_f0:
    push de
    ld b, $0f
    call RandomModulo29_BankF0
    ld a, l
    pop de
    cp e
    jr nc, .loop
    ld a, $01
    ret
    ds $170, $00
