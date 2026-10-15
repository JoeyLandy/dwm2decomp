; ROM bank $37: link sessions; strings
; The annotated listing of this bank is build/listing/bank37.asm.

SECTION "Bank 37", ROMX[$4000], BANK[$37]
    db $37

; Starts showing a string from the table of this bank: loads DE =
; BeginStringDisplay_Bank37_StringCategories and calls BeginStringDisplay, which clears the text
; window, looks up string wStringIndex of category wStringCategory and sets wTextFlags to 1 so the
; text printer draws it. Category 0 holds the item-use messages (for example 'But nothing
; happened!'), category 1 the skill-use messages (for example 'cast'). The caller sets
; wStringCategory, wStringIndex and the text window first; the pause menu
; (PauseMenu_Items_UseItem_ShowMessage and others) and DebugMessageTest_Update_ShowBank37 farcall
; it. The 14 bytes after its ret are not referenced by name: a second copy of the same three
; instructions followed by a call to BeginStringDisplay_Bank37 and RunStringDisplayToEnd. (C1,
; E-0382)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank37::
    ld de, BeginStringDisplay_Bank37_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank37_StringCategories::
    dw StringList_Bank37_StringCategories_0 ; id 0
    dw StringList_Bank37_StringCategories_1 ; id 1

; category list of BeginStringDisplay_Bank37_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank37_StringCategories_0::
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

StringList_Bank37_StringCategories_1::
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
    dw RunLinkSession5Exchange_RunScreen ; id 29
    dw RunLinkSession5Exchange_RunScreen ; id 30
    dw RunLinkSession5Exchange_RunScreen ; id 31

String_37_00_00::
    db "The <BUF2><LINE>"
    db "shattered!<WAIT>"
    db "@"

String_37_00_01::
    db "<BUF0> tried using<LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_02::
    db "But nothing<LINE>"
    db "happened!<WAIT>"
    db "@"

String_37_00_03::
    db "<BUF0> used the<LINE>"
    db "<BUF2> on<WAIT>"
    db "<CLEAR><BUF1>!<WAIT>"
    db "@"

String_37_00_04::
    db "<BUF1>'s wounds<LINE>"
    db "were healed!<WAIT>"
    db "@"

String_37_00_05::
    db "<BUF0> held aloft<LINE>"
    db "the <BUF2>!<WAIT>"
    db "@"

String_37_00_06::
    db "<BUF0> scattered<LINE>"
    db "the <BUF2>!<WAIT>"
    db "@"

String_37_00_07::
    db "<BUF1><LINE>"
    db "regained MP.<WAIT>"
    db "@"

String_37_00_08::
    db "<BUF1> was cured of<LINE>"
    db "poison.<WAIT>"
    db "@"

String_37_00_09::
    db "<BUF1> was cured of<LINE>"
    db "paralysis.<WAIT>"
    db "@"

String_37_00_0A::
    db "<BUF1> snapped<LINE>"
    db "out of confusion.<WAIT>"
    db "@"

String_37_00_0B::
    db "<BUF1> was<LINE>"
    db "uncursed.<WAIT>"
    db "@"

String_37_00_0C::
    db "<BUF1> woke up.<WAIT>"
    db "@"

String_37_00_0D::
    db "<BUF1> came<LINE>"
    db "back to life.<WAIT>"
    db "@"

String_37_00_0E::
    db "<BUF1>'s max.HP<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_0F::
    db "<BUF1>'s max.MP<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_10::
    db "<BUF1>'s ATK<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_11::
    db "<BUF1>'s DEF<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_12::
    db "<BUF1>'s AGL<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_13::
    db "<BUF1>'s INT<LINE>"
    db "rose by <BUF3>!<WAIT>"
    db "@"

String_37_00_14::
    db "<BUF0> gave <BUF1><LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_15::
    db "<BUF1> happily ate<LINE>"
    db "the treat.<WAIT>"
    db "<CLEAR><BUF1>'s affection<LINE>"
    db "for <PLAYER> rose!<WAIT>"
    db "@"

String_37_00_16::
    db "<BUF1> fearfully<LINE>"
    db "ate the foul mess.<WAIT>"
    db "<CLEAR><BUF1> glared with<LINE>"
    db "a sour expression.<WAIT>"
    db "<CLEAR><BUF1> became<LINE>"
    db "poisoned.<WAIT>"
    db "@"

String_37_00_17::
    db "<BUF0> held aloft<LINE>"
    db "the <BUF2>!<WAIT>"
    db "@"

String_37_00_18::
    db "<BUF0> tossed the<LINE>"
    db "<BUF2> up.<WAIT>"
    db "@"

String_37_00_19::
    db "<BUF0> used the<LINE>"
    db "<BUF2>!<WAIT>"
    db "@"

String_37_00_1A::
    db "<BUF0> read <BUF1><LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_1B::
    db "A stirring tale of<LINE>"
    db "honor, sacrifice<WAIT>"
    db "<CLEAR>and heroism made<LINE>"
    db "<BUF1> brave.<WAIT>"
    db "@"

String_37_00_1C::
    db "A bloodcurdling<LINE>"
    db "tale of horror<WAIT>"
    db "<CLEAR>turned <BUF1><LINE>"
    db "cowardly.<WAIT>"
    db "@"

String_37_00_1D::
    db "A heartwarming<LINE>"
    db "tale of selfless<WAIT>"
    db "<CLEAR>compassion made<LINE>"
    db "<BUF1> kind.<WAIT>"
    db "@"

String_37_00_1E::
    db "A shameless tale<LINE>"
    db "of greed, lies and<WAIT>"
    db "<CLEAR>deception made<LINE>"
    db "<BUF1> sly.<WAIT>"
    db "@"

String_37_00_1F::
    db "A practical guide<LINE>"
    db "on thinking in a<WAIT>"
    db "<CLEAR>rational manner<LINE>"
    db "made <BUF1> smart.<WAIT>"
    db "@"

String_37_00_20::
    db "A hilarious tale<LINE>"
    db "made <BUF1> simple.<WAIT>"
    db "@"

String_37_00_21::
    db "<PLAYER> held aloft<LINE>"
    db "the <BUF2>!<WAIT>"
    db "@"

String_37_00_22::
    db "The Orb glowed<LINE>"
    db "with a warm light.<WAIT>"
    db "@"

String_37_00_23::
    db "The presence of<LINE>"
    db "monsters faded.<WAIT>"
    db "@"

String_37_00_24::
    db "<BUF0> strummed<LINE>"
    db "the <BUF2>!<WAIT>"
    db "@"

String_37_00_25::
    db "Want to record<LINE>"
    db "your journey?@"

String_37_00_26::
    db "Your progress has<LINE>"
    db "been recorded.<WAIT>"
    db "@"

String_37_00_27::
    db "<BUF1> equipped<LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_28::
    db "<BUF3>'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "@"

String_37_00_29::
    db "<BUF3>'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "<CLEAR><BUF>", $40, "'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "@"

String_37_00_2A::
    db "<BUF3>'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "<CLEAR><BUF>", $40, "'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "<CLEAR><BUF>", $50, "'s wounds<LINE>"
    db "were healed.<WAIT>"
    db "@"

String_37_00_2B::
    db "<BUF0> gripped<LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_2C::
    db "The MarkStaff<LINE>"
    db "was sensed at<WAIT>"
    db "<CLEAR><BUF0>: <BUF1> and<LINE>"
    db "<BUF2>: <BUF3>.<WAIT>"
    db "@"

String_37_00_2D::
    db "The MarkStaff was<LINE>"
    db "not sensed.<WAIT>"
    db "<CLEAR>It doesn't appear<LINE>"
    db "to have been used.<WAIT>"
    db "@"

String_37_00_2E::
    db "<BUF0> put down<LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_2F::
    db "The Guide Bell's<LINE>"
    db "clear note echoed!<WAIT>"
    db "@"

String_37_00_30::
    db "<BUF0> gave <BUF1><LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_37_00_31::
    db "<BUF1> switched its<LINE>"
    db "<BUF3> with the<WAIT>"
    db "<CLEAR><BUF2>.<WAIT>"
    db "@"

String_37_00_32::
    db "…But that monster<LINE>"
    db "is dead…<WAIT>"
    db "@"

String_37_00_33::
    db "<BUF3> was<LINE>"
    db "uncursed.<WAIT>"
    db "@"

String_37_00_34::
    db "<BUF3> was<LINE>"
    db "uncursed.<WAIT>"
    db "<CLEAR><BUF>", $40, " was<LINE>"
    db "uncursed.<WAIT>"
    db "@"

String_37_00_35::
    db "<BUF3> was<LINE>"
    db "uncursed.<WAIT>"
    db "<CLEAR><BUF>", $40, " was<LINE>"
    db "uncursed.<WAIT>"
    db "<CLEAR><BUF>", $50, " was<LINE>"
    db "uncursed.<WAIT>"
    db "@"

String_37_01_00::
    db "<BUF0> cast<LINE>"
    db "<BUF2>!<WAIT>"
    db "@"

String_37_01_01::
    db "<BUF0> whistled!<WAIT>"
    db "@"

String_37_01_02::
    db "<BUF0> released its<LINE>"
    db "Pheromone.<WAIT>"
    db "@"

String_37_01_03::
    db "<BUF0> scanned the<LINE>"
    db "surroundings.<PROMPT>"
    db "@"

String_37_01_04::
    db "<PLAYER> asked <BUF0><LINE>"
    db "to run an errand.<WAIT>"
    db "@"

String_37_01_05::
    db "<BUF0> scanned the<LINE>"
    db "area sharply.<WAIT>"
    db "@"

String_37_01_06::
    db "<BUF1>'s wounds<LINE>"
    db "were healed!<WAIT>"
    db "@"

String_37_01_07::
    db "<BUF1> regained MP!<WAIT>"
    db "@"

String_37_01_08::
    db "<BUF1> came back to<LINE>"
    db "life!<WAIT>"
    db "@"

String_37_01_09::
    db "<BUF1> was cured of<LINE>"
    db "poison.<WAIT>"
    db "@"

String_37_01_0A::
    db "<BUF1> was<LINE>"
    db "uncursed.<WAIT>"
    db "@"

String_37_01_0B::
    db "<BUF0> whispered in<LINE>"
    db "<PLAYER>'s ear.<PROMPT>"
    db "@"

String_37_01_0C::
    db "<BUF0>: There are<LINE>"
    db "<BUF3> around.<PROMPT>"
    db "@"

String_37_01_0D::
    db "<BUF0> finished<LINE>"
    db "talking.<WAIT>"
    db "@"

String_37_01_0E::
    db "<BUF0> ran off with<LINE>"
    db "100G.<PROMPT>"
    db "<CLEAR>…………………………………………<LINE>"
    db "…………………………………………<PROMPT>"
    db "@"

String_37_01_0F::
    db "<BUF0> returned<LINE>"
    db "with an item.<PROMPT>"
    db "<CLEAR><PLAYER> obtained one<LINE>"
    db "<BUF3>.<WAIT>"
    db "@"

String_37_01_10::
    db "<BUF0> came back<LINE>"
    db "with nothing…<WAIT>"
    db "@"

String_37_01_11::
    db "<BUF0> sensed a<LINE>"
    db "treasure nearby.<PROMPT>"
    db "<CLEAR>It appears to be<LINE>"
    db "very close.<WAIT>"
    db "@"

String_37_01_12::
    db "But nothing<LINE>"
    db "happened.<WAIT>"
    db "@"

String_37_01_13::
    db "<BUF1> did not come<LINE>"
    db "back to life…<WAIT>"
    db "@"

String_37_01_14::
    db "But it couldn't be<LINE>"
    db "used here.<WAIT>"
    db "@"

String_37_01_15::
    db "But there were no<LINE>"
    db "monsters nearby.<WAIT>"
    db "@"

String_37_01_16::
    db "But there is no<LINE>"
    db "room for it…<WAIT>"
    db "@"

String_37_01_17::
    db "But there wasn't<LINE>"
    db "enough money.<WAIT>"
    db "@"

String_37_01_18::
    db "There are no<LINE>"
    db "treasures nearby.<WAIT>"
    db "@"

String_37_01_19::
    db "Not enough MP!<LINE>"
    db "<WAIT>"
    db "@"

String_37_01_1A::
    db "A dead monster<LINE>"
    db "can't use a skill.<WAIT>"
    db "@"

String_37_01_1B::
    db "That can't be used<LINE>"
    db "in the field.<WAIT>"
    db "@"

String_37_01_1C::
    db "The surroundings<LINE>"
    db "became clear.<WAIT>"
    db "@"

; Link session 5's screen (breeding with Terry's Wonderland): once no fade runs, by wScreenState:
; the swap menu, leaving, the start, the messages, the breeding steps, the handshake, the stats
; screens and the chosen record. (C1, E-0357)
RunLinkSession5Exchange_RunScreen::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw RunLinkSession5Exchange_SwapMenu
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_SignalPartner
    dw RunLinkSession5Exchange_ShowMessages
    dw LinkBreed
    dw RunLinkSession5Exchange_SendLeave
    dw RunLinkSession5Exchange_WaitPartnerLeave
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_RunStatsScreen
    dw PartnerStats
    dw RunLinkSession5Exchange_ResetListAndShowString
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ExitAfterText
    dw RunLinkSession5Exchange_ShowChosenRecord

; Session 5, state 0: runs the swap menu (SwapMonstersMenu) and goes on. (C1, E-0357)
RunLinkSession5Exchange_SwapMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Session 5, states 1, 7-11, 15 and 16: once wTextFlags bit 0 is clear, zero-fills the $6F bytes
; from wScreenState and requests game mode 5, state 1 (wGameMode, wModeState, wModeChangeRequest).
; (C2, E-0371; probed E-0382)
RunLinkSession5Exchange_ExitAfterText::
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
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; Session 5, state 5: after the text sends 3. (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_SendLeave::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $03
    ld [wLinkSendByte], a
    ld hl, wScreenState
    inc [hl]
    ret

; Session 5, state 6: on the partner's 3 goes to leaving (state 1). (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_WaitPartnerLeave::
    ld a, [wLinkMessage]
    cp $03
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wScreenState], a
    ret

; Session 5, state 2: moves to state 3, queues link byte 2 (wLinkSendByte) and increments
; wTitleScreenState. (C2, E-0371; probed E-0382)
RunLinkSession5Exchange_SignalPartner::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wTitleScreenState
    inc [hl]
    ret

; Session 5, state 3: runs one of four steps by wScreenStep: 0
; RunLinkSession5Exchange_ShowMessages_WaitTextFlags (wait for the text), 1
; RunLinkSession5Exchange_ShowMessages_TerryMessage (a received byte 2 shows the 'For breeding with'
; text and jumps to state 5, a received 0 goes on, any other byte waits), 2
; RunLinkSession5Exchange_ShowMessages_AskChoose ('Choose the monster for breeding.'), 3
; RunLinkSession5Exchange_ShowMessages_SetScreenStep (after the text moves on to state 4,
; LinkBreed). (C1, E-0382)
; text waits around two strings (ShowStringIndexA_Bank37)
RunLinkSession5Exchange_ShowMessages::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession5Exchange_ShowMessages_WaitTextFlags
    dw RunLinkSession5Exchange_ShowMessages_TerryMessage
    dw RunLinkSession5Exchange_ShowMessages_AskChoose
    dw RunLinkSession5Exchange_ShowMessages_SetScreenStep

; The messages, step 0: after the text goes on. (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_ShowMessages_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The messages, step 1: after the text, a partner's 2 shows "For breeding with Terry's ..."
; (bank-$0E string $15) and goes to state 5; with no byte goes on. (C1, E-0357)
RunLinkSession5Exchange_ShowMessages_TerryMessage::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    or a
    jr z, .check_screen_step
    cp $02
    ret nz
    ld a, $05
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld a, $15
    call ShowStringIndexA_Bank37
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The messages, step 2: 'Choose the monster for breeding.' (string 9). (C1, E-0357)
RunLinkSession5Exchange_ShowMessages_AskChoose::
    xor a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The messages, step 3: after the text the next state. (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_ShowMessages_SetScreenStep::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Session 5, state 4 (the breeding itself): runs one of 34 steps by wScreenStep. Steps 0-3, 5-7 and
; 13 run the choice list (LinkBreed_RunList, which calls BreedMenu once the text is done); 4 draws
; the chosen record panel (LinkBreed_DrawPanel); 8 LinkBreed_ChooseOrRefuse; 9
; LinkBreed_WaitPartnerCancel; 10 LinkBreed_WaitText; 11 LinkBreed_ClosingExchange; 12
; LinkBreed_AskIsThisOK; 14 LinkBreed_PartnerCancel; 15 LinkBreed_WaitTextAgain; 16
; LinkBreed_AskChoose; 17 LinkBreed_CheckPick; 18 LinkBreed_SendRecord; 19 and 27
; LinkBreed_SendReady; 20 LinkBreed_ExchangeRecords; 21 LinkBreed_ReceiveRecord; 22
; LinkBreed_CheckGenders; 23 LinkBreed_DrawChoiceBox; 24 LinkBreed_ReadChoice; 25
; LinkBreed_DrawYesNo; 26 LinkBreed_ReadAnswer; 28 LinkBreed_WaitPartnerForChild; 29
; LinkBreed_MakeChild; 30 LinkBreed_StoreChildRecord; 31 LinkBreed_StartWorkBufExchange; 32
; LinkBreed_FinishExchange; 33 LinkBreed_WaitPartnerRefusal. The steps trade a record with the
; partner over the link and end in the egg screens (wLinkScene, wLinkBreedResult) or back at the
; title menu (game mode 5). (C1, E-0382)
; by wScreenStep: BreedMenu list steps, unpacks the partner's record from the link
; (UnpackLinkRecordToRecordBufB), ComputeBreedingChild and LinkBreed_StoreChildRecord (renamed from
; RunLinkSession5Exchange_LinkBreed from its E-0357 note, E-0367)
LinkBreed::
    ld a, [wScreenStep]
    jumptable
    dw LinkBreed_RunList
    dw LinkBreed_RunList
    dw LinkBreed_RunList
    dw LinkBreed_RunList
    dw LinkBreed_DrawPanel
    dw LinkBreed_RunList
    dw LinkBreed_RunList
    dw LinkBreed_RunList
    dw LinkBreed_ChooseOrRefuse
    dw LinkBreed_WaitPartnerCancel
    dw LinkBreed_WaitText
    dw LinkBreed_ClosingExchange
    dw LinkBreed_AskIsThisOK
    dw LinkBreed_RunList
    dw LinkBreed_PartnerCancel
    dw LinkBreed_WaitTextAgain
    dw LinkBreed_AskChoose
    dw LinkBreed_CheckPick
    dw LinkBreed_SendRecord
    dw LinkBreed_SendReady
    dw LinkBreed_ExchangeRecords
    dw LinkBreed_ReceiveRecord
    dw LinkBreed_CheckGenders
    dw LinkBreed_DrawChoiceBox
    dw LinkBreed_ReadChoice
    dw LinkBreed_DrawYesNo
    dw LinkBreed_ReadAnswer
    dw LinkBreed_SendReady
    dw LinkBreed_WaitPartnerForChild
    dw LinkBreed_MakeChild
    dw LinkBreed_StoreChildRecord
    dw LinkBreed_StartWorkBufExchange
    dw LinkBreed_FinishExchange
    dw LinkBreed_WaitPartnerRefusal

; Session 5 breeding, step 14: the partner's cancel ($FD) shows 'Your pal refused breeding.' (string
; $14), step 9, answering $FD (wAIFlag 1); otherwise the list's steps. (C1, E-0357)
LinkBreed_PartnerCancel::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fd
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $fd
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ret

; Session 5 breeding, step 8: the partner's cancel as above; otherwise the list, where B shows 'You
; refused breeding.' (string $13), step 9, sending $FD (wAIFlag 0). (C1, E-0357)
LinkBreed_ChooseOrRefuse::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fd
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $fd
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld a, [wMenuInputResult]
    cp $fe
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $13
    call ShowStringIndexA_Bank37
    ld a, $fd
    ld [wLinkSendByte], a
    ld a, $00
    ld [wAIFlag], a
    ret

; Session 5 breeding, step 0: after the text the list's steps (BreedMenu). (C1, E-0357)
LinkBreed_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; Session 5 breeding, step 16: with a pick runs the list and asks 'Choose the monster for
; breeding.'; after a cancel ($FF) runs the re-asking sub-steps. (C1, E-0357)
LinkBreed_AskChoose::
    ld a, [wSelectedRecord]
    cp $ff
    jr z, .read_screen_sub_step
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ld a, $09
    call ShowStringIndexA_Bank37
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    jumptable
    dw LinkBreed_AskChoose_PleaseWait
    dw LinkBreed_AskChoose_SendReady
    dw LinkBreed_AskChoose_AskAgain
    dw LinkBreed_AskChoose_RunList
    dw LinkBreed_AskChoose_PleaseWait
    dw LinkBreed_AskChoose_SendReady
    dw LinkBreed_AskChoose_AskAgain
    dw LinkBreed_AskChoose_RunList
    dw LinkBreed_AskChoose_PleaseWait
    dw LinkBreed_AskChoose_AskAgain2
    dw LinkBreed_AskChoose_RunList

; Re-asking, sub-step 0: after the text 'Please wait.' (string 7). (C1, E-0357)
LinkBreed_AskChoose_PleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $07
    call ShowStringIndexA_Bank37
    ret

; Re-asking, sub-steps 1 and 5: after the text queues link byte 1 (wLinkSendByte) and moves to the
; next sub-step, where LinkBreed_AskChoose_AskAgain waits for the partner's 1. (C2, E-0371; probed
; E-0382)
LinkBreed_AskChoose_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Re-asking, sub-step 2: on the partner's 1 'Choose the monster for breeding.'. (C1, E-0357)
LinkBreed_AskChoose_AskAgain::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Re-asking, sub-step 3: after the text runs the list and clears the pick. (C1, E-0357)
LinkBreed_AskChoose_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    xor a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

; Re-asking, sub-step 9: after the text 'Choose the monster for breeding.'. (C1, E-0357)
LinkBreed_AskChoose_AskAgain2::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Session 5 breeding, step 12: 'Is this one OK for breeding?' (string 4), then the list's next step
; with two cursor tiles reloaded. (C1, E-0357)
LinkBreed_AskIsThisOK::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_breed_menu
    ld a, $04
    call ShowStringIndexA_Bank37
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld de, Tiles1Plus6E0Tiles_2
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_2
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wScreenSubStep], a
    ret

; Session 5 breeding, step 4: loads the chosen record's family icon and draws its 12 x 5 panel with
; its sex mark and level. (C1, E-0357)
LinkBreed_DrawPanel::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank37
    ld de, LinkBreed_DrawPanel_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $05
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

; Session 5 breeding, step 15: returns while the text is still running. Once it is done it falls
; into LinkBreed_CopyBlockAndAdvance, which copies the 8 x 5 block of the screen buffer from offset
; $00AC to offset $0278, adds 1 to wScreenStep and sets wSelectedRecord to 0, all in the same call.
; (C2, E-0382)
LinkBreed_WaitTextAgain::
    ld a, [wTextFlags]
    and a
    ret nz

; Copies a block of the screen buffer from offset $00AC to offset $0278, 8 bytes wide and 5 rows
; high (CopyScreenBufferRectWithAttrs_37 with wArg1 = 0, wArg2 = 8, B = 0, C = 5), adds 1 to
; wScreenStep and sets wSelectedRecord to 0. Step 15 (LinkBreed_WaitTextAgain) falls into it, and
; LinkBreed_SendRecord calls it. (C2, E-0382)
; runs CopyScreenBufferRectWithAttrs_37 (C = 5, HL = $0278, DE = $00AC, wArg1/2 = 0/8), wScreenStep
; += 1 and clears wSelectedRecord (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was LinkBreed_CopyBlockAndAdvance)
LinkBreed_CopyBlockAndAdvance::
    ld b, $00
    ld c, $05
    ld hl, $0278
    ld de, $00ac
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wSelectedRecord], a
    ret

; Session 5 breeding, step 17: a pick below level 10 gives 'This one is too young to ...' (string 5)
; and a party member 'Choose from the farm's roster.' (string 6), both two steps back; otherwise
; keeps the record and the list place. (C1, E-0357)
LinkBreed_CheckPick::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0a
    ld [rRAMG2], a
    xor a
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
    cp $0a
    jr nc, .restore
    pop hl
    xor a
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
    cp c
    jr z, .check_screen_step
    inc de
    dec b
    jr nz, .loop
    jr .call_set_arg5_to_list_entries_cell5

.check_screen_step:
    xor a
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
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 18: copies the chosen SRAM record into wRecordBufA, converts it into
; wWorkBuf for the exchange (PackRecordBufAToLinkWorkBuf; here wRecordBufA holds this side's own
; record), shows 'Please wait.' and redraws. (C1, E-0357)
LinkBreed_SendRecord::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $a5

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    call PackRecordBufAToLinkWorkBuf
    ld a, $07
    call ShowStringIndexA_Bank37
    call LinkBreed_CopyBlockAndAdvance
    call BGMapAddressAtScroll_Bank37
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ret

; Session 5 breeding, steps 19 and 27: returns while the text is running; then wScreenStep + 1 and
; wLinkSendByte = 1, the byte that the partner side waits for in step 20 (LinkBreed_ExchangeRecords)
; and step 28 (LinkBreed_WaitPartnerForChild). (C2, E-0382)
LinkBreed_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Session 5 breeding, step 31: starts a $64-byte exchange of wWorkBuf. (C2, E-0357; probed E-0382)
LinkBreed_StartWorkBufExchange::
    ld a, $64
    ld [wLinkBufferCountLo], a
    xor a
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 20: on the partner's 1 starts a $95-byte exchange (wWorkBuf out, the
; partner's record into the battler record area); on $FD 'Your pal refused breeding.' (step 9). (C1,
; E-0357)
LinkBreed_ExchangeRecords::
    ld a, [wLinkMessage]
    cp $01
    jr z, .check_screen_step
    cp $fd
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $fd
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
    xor a
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; Session 5 breeding, step 21: when the exchange ends unpacks the partner's record into wRecordBufB
; (UnpackLinkRecordToRecordBufB). (C2, E-0357; probed E-0382)
LinkBreed_ReceiveRecord::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkReady], a
    call UnpackLinkRecordToRecordBufB
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 22: the same sex gives 'Identical genders can't breed.' and back to
; choosing (step $10, sub-step 8); otherwise shows the partner's monster (string $0F, 13 x 1 at VRAM
; $9600) and asks 'Proceed with breeding?'. (C1, E-0357)
LinkBreed_CheckGenders::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wRecordBufA + MON_SEX
    ld a, [wRecordBufA + MON_SEX]
    and $01
    ld b, a
    ld a, [wRecordBufB + MON_SEX]
    and $01
    cp b
    jr nz, .clear_link_send_byte
    ld a, $08
    call ShowStringIndexA_Bank37
    ld a, $10
    ld [wScreenStep], a
    ld a, $08
    ld [wScreenSubStep], a
    ld a, $ff
    ld [wSelectedRecord], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, $0f
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0d01
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
    ld a, $0b
    call ShowStringIndexA_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 29: the leader (link role bit 1 clear) works out the child
; (ComputeBreedingChild); then stores the received record in SRAM (LinkBreed_StoreChildRecord,
; repeated until it moves the step) and starts the $64-byte exchange. (C1, E-0357)
LinkBreed_MakeChild::
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
    call LinkBreed_StoreChildRecord
    pop bc
    ld a, [wScreenStep]
    cp b
    jr z, .loop
    jp LinkBreed_StartWorkBufExchange

; Session 5 breeding, step 23: plays sound $6C and draws the 9 x 7 three-way choice box. (C1,
; E-0357)
LinkBreed_DrawChoiceBox::
    ld a, [wTextFlags]
    and a
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
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $6c
    call QueueSoundEffect
    ld de, LinkBreed_DrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 24: the partner's refusal ($FE) restores the area and gives 'Your pal
; refused breeding.' (step $21); the choice: B or the third entry 'You refused breeding.' (step $21,
; sending $FE); the second opens the stats screen (state $0D); the first marks it and asks 'Is it OK
; to record the ...' (string $0C). (C1, E-0357)
LinkBreed_ReadChoice::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_handle_three_choice_cursor_input_37
    call LinkBreed_ClearChoiceBox
    ld a, $21
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.call_handle_three_choice_cursor_input_37:
    call HandleThreeChoiceCursorInput_37
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    call LinkBreed_ClearChoiceBox
    ld a, $21
    ld [wScreenStep], a
    ld a, $13
    call ShowStringIndexA_Bank37
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $00
    ld [wAIFlag], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $02
    jr z, .loop
    cp $01
    jr z, .read_screen_state
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, LinkBreed_ReadChoice_Data
    call StoreBAtWordTableEntry_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $0c
    call ShowStringIndexA_Bank37
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $0d
    ld [wScreenState], a
    ret

; Session 5 breeding, step 25: loads the yes/no tiles and draws its box. (C1, E-0357)
LinkBreed_DrawYesNo::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles2 + $720
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wTwoChoiceCursor], a
    ld de, LinkBreed_DrawYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Session 5 breeding, step 26: no or B asks 'Proceed with breeding?' again (step $17); yes shows
; 'Please wait.' and goes on. (C1, E-0357)
LinkBreed_ReadAnswer::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    ld a, $0b
    call ShowStringIndexA_Bank37
    ld a, $17
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $07
    call ShowStringIndexA_Bank37
    ret

; Session 5 breeding, step 30 (LinkBreed_MakeChild also calls it in a loop until wScreenStep moves).
; Does nothing while the text runs. With wScreenSubStep non-zero it clears it and adds 1 to
; wScreenStep. Otherwise a follower (bit 1 of wLinkRole set) only adds 1 to wScreenSubStep. A leader
; restores wListCursor and wListPageIndex from wItemGridX and wItemGridY, deletes the SRAM record
; under the list cell (DeleteSRAMRecordAndCompact with wArg1 = that record, wArg2 = 1), copies the
; $A5-byte record wChildRecord into the free record slot whose address that routine leaves in wArg6
; and wArg7, clears wSaveStep and wSaveRecordIndex, sets the child species bit in wMonsterLibraryBuf
; (SetBitInFieldAtArg3), zeroes the 7 bytes at wPackWork and adds 1 to wScreenSubStep. SRAM is
; enabled only for the copy. (C1, E-0382)
; when text is idle and not linking: copies the $A5-byte received record at wChildRecord into the
; record slot at wListEntries cell 5 and resets the save counters (E-0128)
LinkBreed_StoreChildRecord::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr z, .check_link_role
    xor a
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
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wChildRecord
    ld b, $a5

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
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
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Session 5 breeding, step 28: on the partner's 1 goes on to the child; on $FE 'Your pal refused
; breeding.' (step $21). (C1, E-0357)
LinkBreed_WaitPartnerForChild::
    ld a, [wLinkMessage]
    cp $01
    jr z, .check_screen_step
    cp $fe
    ret nz
    ld a, $21
    ld [wScreenStep], a
    ld a, $14
    call ShowStringIndexA_Bank37
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wAIFlag], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp LinkBreed_MakeChild

; Session 5 breeding, step 9: waits for the received byte $FD (the other side has refused or
; cancelled). Then wScreenStep + 1 and a jr into LinkBreed_WaitText, so with the text idle the same
; call goes on through step 10 to step $0B and starts the closing exchange
; (LinkBreed_StartClosingExchange); with the text still running it stays at step 10. (C2, E-0382)
LinkBreed_WaitPartnerCancel::
    ld a, [wLinkMessage]
    cp $fd
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jr LinkBreed_WaitText

; Session 5 breeding, step 33: on the received byte $FE (the other side refused) sets wLinkSendByte
; to 0 and wScreenStep to $0A, then jumps into LinkBreed_WaitText. With the text still running it
; returns at step $0A; with the text idle the same call moves to step $0B and starts the closing
; exchange (LinkBreed_StartClosingExchange), so wScreenStep ends at $0B, not $0A. Any other byte
; changes nothing. (C2, E-0382)
LinkBreed_WaitPartnerRefusal::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $0a
    ld [wScreenStep], a
    jr LinkBreed_WaitText

; Session 5 breeding, step 10: once the text is done, wScreenStep + 1 and wScreenSubStep = 0, then
; it falls into LinkBreed_ClosingExchange, whose sub-step 0 (LinkBreed_StartClosingExchange) starts
; the exchange in the same call. While the text runs nothing changes. (C2, E-0382)
LinkBreed_WaitText::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a

; Session 5 breeding, step 11 of LinkBreed (by wScreenStep), also entered by falling through from
; LinkBreed_WaitText (which clears wScreenSubStep): by wScreenSubStep runs
; LinkBreed_StartClosingExchange (after the text starts an exchange of wWorkBuf with the partner)
; and then LinkBreed_EndClosingExchange (when the exchange ends clears $6F bytes from wScreenState
; and switches to wGameMode 5, wModeState 1, GameMode5_Init_TitleMenu). (C2, E-0372; probed E-0382)
; waits for the text, then for the partner's link message
LinkBreed_ClosingExchange::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkBreed_StartClosingExchange
    dw LinkBreed_EndClosingExchange

; The closing exchange, sub-step 0: after the text starts an exchange of wWorkBuf: $64 bytes for the
; leader, $48 for the follower ($45 after the partner cancelled). (C2, E-0357; probed E-0382)
LinkBreed_StartClosingExchange::
    ld a, [wTextFlags]
    and a
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
    or a
    jr z, .set_link_buffer_count_lo
    ld b, $45

.set_link_buffer_count_lo:
    ld a, b
    ld [wLinkBufferCountLo], a
    xor a
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; The closing exchange, sub-step 1: when it ends clears $6F bytes of screen state and returns to
; game mode 5, state 1. (C2, E-0357; probed E-0382)
LinkBreed_EndClosingExchange::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkReady], a
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a
    ld [wLinkSendByte], a
    ret

; Session 5 breeding, step 32: when the exchange ends sets wLinkScene and wLinkBreedResult 1 (the
; egg screens). (C2, E-0357; probed E-0382)
LinkBreed_FinishExchange::
    ld a, [wLinkMessage]
    cp $f0
    jr z, .clear_link_send_byte
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScene], a
    ld a, $01
    ld [wLinkBreedResult], a
    ret

; Session 5, state 12: runs the stats screen until its step $0A, then state 17. (C1, E-0357)
RunLinkSession5Exchange_RunStatsScreen::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $05
    ld [wScreenState], a
    ret

; Session 5, state 17: runs one of ten steps by wScreenStep to redraw the breeding list with the
; chosen record: 0 RunLinkSession5Exchange_ChosenRecordStart, 1 ShowString0EAndStep_Bank37, 2-4, 8
; and 9 RunLinkSession5Exchange_ChosenRecordList (the steps of BreedMenu), 5 LinkBreed_DrawPanel, 6
; RunLinkSession5Exchange_ClearNameTiles, 7 RunLinkSession5Exchange_ShowChosenRecord_DrawName. The
; state follows state 12 (RunLinkSession5Exchange_RunStatsScreen), which moves wScreenState to 17.
; (C1, E-0382)
; as RunScreenStateWhenNotFading_F1_ShowChosenRecord
RunLinkSession5Exchange_ShowChosenRecord::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession5Exchange_ChosenRecordStart
    dw ShowString0EAndStep_Bank37
    dw RunLinkSession5Exchange_ChosenRecordList
    dw RunLinkSession5Exchange_ChosenRecordList
    dw RunLinkSession5Exchange_ChosenRecordList
    dw LinkBreed_DrawPanel
    dw RunLinkSession5Exchange_ClearNameTiles
    dw RunLinkSession5Exchange_ShowChosenRecord_DrawName
    dw RunLinkSession5Exchange_ChosenRecordList
    dw RunLinkSession5Exchange_ChosenRecordList

; The chosen record, step 2: the list's steps. (C1, E-0357)
RunLinkSession5Exchange_ChosenRecordList::
    farcall BreedMenu
    ret

; The chosen record, step 0: moves on. (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_ChosenRecordStart::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Farcalls ShowString0EBank0EAtTiles2700AndLoadTiles (it shows string $0E of the bank $0E table at
; vTiles2 + $700, puts the default text window back and copies two tiles into vTiles1), then adds 1
; to wScreenStep. Used as a step by RunLinkSession5Exchange_ShowChosenRecord and
; RunLinkSession5Exchange_ResetListAndShowString, and called by PartnerStats_DrawSummaryFrames. (C1,
; E-0382)
; far-calls ShowString0EBank0EAtTiles2700AndLoadTiles, then wScreenStep += 1 (E-0122)
ShowString0EAndStep_Bank37::
    farcall ShowString0EBank0EAtTiles2700AndLoadTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Step 6 of RunLinkSession5Exchange_ShowChosenRecord and of
; RunLinkSession5Exchange_ResetListAndShowString: clears the 9 x 1 species-name tiles at vTiles1 +
; $270 and the 5 x 1 name tiles at vTiles1 + $780 (FillTilesFromRequest), where the next step
; (RunLinkSession5Exchange_ShowChosenRecord_DrawName) draws them again, sets the string window back
; to vTiles1 with size $1202, and moves on (wScreenStep += 1). (C1, E-0372)
RunLinkSession5Exchange_ClearNameTiles::
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

; The chosen record, step 7: draws the chosen record's name and species name. (C1, E-0357)
RunLinkSession5Exchange_ShowChosenRecord_DrawName::
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

; Session 5, state 13: the stats screens of the monster of the partner (record buffer B), 33 steps
; by wScreenStep. 0 clears the screen, 1 shows the heading and the name, 2 moves on, 3-5 draw the
; frame, the stats and the picture, 6 reads the keys (PartnerStats_Cursor), 7 leaves
; (PartnerStats_Leave), 8-13 do nothing (PartnerStats_Idle), 14-22 build and draw the second page,
; 23-27 the skills page, 28 and 29 the summary page, 30-32 the pedigree page with the parents. The
; keys move between the pages by setting wScreenStep. (C1, E-0382)
; by wScreenStep: the stats screens of record buffer B, as
; RunScreenStateWhenNotFading_F1_ShowRecordStats (renamed from
; RunLinkSession5Exchange_ShowRecordStats from its E-0357 note, E-0367)
PartnerStats::
    ld a, [wScreenStep]
    jumptable
    dw PartnerStats_ClearScreen
    dw PartnerStats_ShowHeading
    dw PartnerStats_HeadingDone
    dw PartnerStats_DrawFrame
    dw PartnerStats_DrawStats
    dw PartnerStats_DrawPicture
    dw PartnerStats_Cursor
    dw PartnerStats_Leave
    dw PartnerStats_Idle
    dw PartnerStats_Idle
    dw PartnerStats_Idle
    dw PartnerStats_Idle
    dw PartnerStats_Idle
    dw PartnerStats_Idle
    dw PartnerStats_ClearPage2
    dw PartnerStats_ClearPage2Names
    dw PartnerStats_DrawNames
    dw PartnerStats_DrawPage2Frame
    dw PartnerStats_ShowPersonality
    dw PartnerStats_DrawFamilyIcon
    dw PartnerStats_LoadSprite
    dw PartnerStats_Page2Keys
    dw PartnerStats_DrawLevelRow
    dw PartnerStats_DrawSkillsFrames
    dw PartnerStats_ClearSkillsText
    dw PartnerStats_ShowSkillNames
    dw PartnerStats_ShowDescription
    dw PartnerStats_SkillsKeys
    dw PartnerStats_DrawSummaryFrames
    dw PartnerStats_DrawSummaryLevelRow
    dw PartnerStats_DrawPedigreeFrame
    dw PartnerStats_DrawParents
    dw PartnerStats_PedigreeKeys

; The partner's monster stats, steps 8-13: nothing (a bare ret). (C2, E-0371; probed E-0382)
PartnerStats_Idle::
    ret

; The partner's monster stats, step 0: clears the BG map and loads the frame tiles. (C1, E-0357)
PartnerStats_ClearScreen::
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 1: shows the heading (bank-$0E string $10), loads sixteen glyph
; tiles and draws the monster's name. (C1, E-0357)
PartnerStats_ShowHeading::
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    farcall LoadSixteenGlyphTilesFromTable
    call PartnerStats_DrawHeadingName

; The partner's monster stats, step 2 and the end of step 1 (PartnerStats_ShowHeading falls in):
; moves to the next step. (C2, E-0371; probed E-0382)
PartnerStats_HeadingDone::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Draws the name of record buffer B as tiles at vTiles1 + $500: clears a window of 5 x 1 tiles there
; (FillTilesFromRequest), copies the name at wRecordBufB + MON_NAME into wNameGlyphBuf
; (CopyF0NameToNameGlyphBuf) and writes its glyph tiles to vTiles1 + $500 (CopyGlyphTilesToVRAM). It
; leaves wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows and wTextWindowWidth set to that 5 x
; 1 window. PartnerStats_ShowHeading calls it. (C1, E-0382)
; clears 5 tiles at vTiles1 + $500 and draws the name at wRecordBufB + $1 there (E-0122) (E-0340:
; the address in its name read as its RAM name; was PartnerStats_DrawHeadingName)
PartnerStats_DrawHeadingName::
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

; The partner's monster stats, step 3: draws the 20 x 18 stats frame. (C1, E-0357)
PartnerStats_DrawFrame::
    call BGMapAddressAtScroll_Bank37
    ld de, PartnerStats_DrawFrame_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 4: draws its level, status and stats. (C1, E-0357)
PartnerStats_DrawStats::
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 5: draws its picture in two calls. (C1, E-0357)
PartnerStats_DrawPicture::
    farcall DrawRecordBufBSpeciesMonsterPictureInTwoSteps
    ret

; The partner's monster stats, step 6: B leaves; A redraws the picture frame and turns to the second
; page (step $0E). (C1, E-0357)
PartnerStats_Cursor::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .check_screen_step
    cp $ff
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
    ld de, BlankPictureTileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, $0e
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 7 (leaving): fills the BG map with the fill tile and goes to the
; next state. (C1, E-0357)
PartnerStats_Leave::
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
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; The second page, step 14: clears $0F x 2 tiles at VRAM $9200. (C1, E-0357)
PartnerStats_ClearPage2::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0f02
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 15: clears the species and name tile areas. (C1, E-0357)
PartnerStats_ClearPage2Names::
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

; The second page, step 16: draws the name and species name. (C1, E-0357)
PartnerStats_DrawNames::
    call PartnerStats_DrawNameAndSpecies
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 17: draws the 12 x 15 page frame. (C1, E-0357)
PartnerStats_DrawPage2Frame::
    call BGMapAddressAtScroll_Bank37
    ld de, $0068
    add hl, de
    ld de, MonsterDetailsPage2TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 18: shows its personality name and master's name. (C1, E-0357)
PartnerStats_ShowPersonality::
    farcall ShowPersonalityNameAndRecordBufBMasterNameName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 19: draws the family icon with its count and the experience still needed.
; (C1, E-0357)
PartnerStats_DrawFamilyIcon::
    ld a, $6d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld a, $ea
    ld [wArg3], a
    ld a, $c7
    ld [wArg4], a
    farcall DrawFamilyIconAndCountForRecordBufBFamily
    farcall DrawRecordBufBExpExpAndToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 20: decompresses the species' sprite graphics, shows its item string and
; draws the 8 x 7 sprite frame. (C1, E-0357)
PartnerStats_LoadSprite::
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $f0
    ldh [hSpriteHideTile], a
    farcall ShowRecordBufBItemCategory11StringAtTiles2320
    call BGMapAddressAtScroll_Bank37
    ld de, $0160
    add hl, de
    ld de, MonsterDetailsItemBoxTileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 21: B redraws and goes back to the first page (step 4); A goes on to the
; skills. (C1, E-0357)
PartnerStats_Page2Keys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .clear_sprite_hide_tile2
    cp $ff
    jr z, .clear_sprite_hide_tile
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    farcall MonsterDetails_DrawStatsPageFrames
    ld a, $04
    ld [wScreenStep], a
    ret

; The second page, step 22: draws the level and status row, then step $0F. (C1, E-0357)
PartnerStats_DrawLevelRow::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
    ld a, $0f
    ld [wScreenStep], a
    ret

; The skills page, step 23: draws its frames. (C1, E-0357)
PartnerStats_DrawSkillsFrames::
    farcall MonsterDetails_DrawBlankPageFrames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 24: clears the text tiles and draws the frames. (C1, E-0357)
PartnerStats_ClearSkillsText::
    farcall MonsterDetails_DrawSkillsPageFrames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 25: shows the eight skill names, or none. (C1, E-0357)
PartnerStats_ShowSkillNames::
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The skills page, step 26: shows the species' description. (C1, E-0357)
PartnerStats_ShowDescription::
    farcall ShowSpeciesCategory13StringAtTiles2680
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 27: B clears the text and goes on; A loads the summary tiles and frames and
; goes on three steps. (C1, E-0357)
PartnerStats_SkillsKeys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .set_text_window_tile_lo
    cp $ff
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
    ld de, Tiles1Plus2E0Tiles_2
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call PartnerStats_UploadSummaryTiles
    farcall DrawSummaryFrames
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

; The summary page, step 28: draws its frames, then shows the headings and goes on. (C1, E-0357)
PartnerStats_DrawSummaryFrames::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_show_string10_bank0_e_at_tiles2020_then
    farcall MonsterDetails_DrawSummaryPanelFrames
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_string10_bank0_e_at_tiles2020_then:
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    call ShowString0EAndStep_Bank37
    xor a
    ld [wScreenSubStep], a
    ret

; The summary page, step 29: draws the level row, the name and species and a tile, then step $11.
; (C1, E-0357)
PartnerStats_DrawSummaryLevelRow::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
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
    call PartnerStats_DrawNameAndSpecies
    ld de, Tiles1Plus4A0Tiles
    ld hl, vTiles2 + $6f0
    ld b, $1f
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

; The pedigree page, step 30: draws the 12 x 18 frame and decompresses the parents' species
; graphics. (C1, E-0357)
PartnerStats_DrawPedigreeFrame::
    call BGMapAddressAtScroll_Bank37
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsPedigreeTileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank37
    farcall DecompressRecordBufBSpeciesGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The pedigree page, step 31: draws the parents and hides sprite tile $F0. (C1, E-0357)
PartnerStats_DrawParents::
    farcall RunF2
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The pedigree page, step 32: B goes back to the skills page (step $17); A to leaving (step 7). (C1,
; E-0357)
PartnerStats_PedigreeKeys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    jr z, .return
    cp $fe
    jr z, .clear_sprite_hide_tile
    cp $ff
    jr z, .clear_sprite_hide_tile2

.return:
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; Session 5, state 14: runs one of ten steps by wScreenStep to go back to the breeding list: 0
; RunLinkSession5Exchange_RestoreListCursor, 1 ShowString0EAndStep_Bank37, 2-4
; RunLinkSession5Exchange_RunBreedList, 5 LinkBreed_DrawPanel, 6
; RunLinkSession5Exchange_ClearNameTiles, 7 RunLinkSession5Exchange_ShowChosenRecord_DrawName, 8
; RunLinkSession5Exchange_ShowPartnerMonster, 9 RunLinkSession5Exchange_RunBreedListFinal. (C1,
; E-0382)
; as RunScreenStateWhenNotFading_F1_RedrawBreedScreen
RunLinkSession5Exchange_ResetListAndShowString::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession5Exchange_RestoreListCursor
    dw ShowString0EAndStep_Bank37
    dw RunLinkSession5Exchange_RunBreedList
    dw RunLinkSession5Exchange_RunBreedList
    dw RunLinkSession5Exchange_RunBreedList
    dw LinkBreed_DrawPanel
    dw RunLinkSession5Exchange_ClearNameTiles
    dw RunLinkSession5Exchange_ShowChosenRecord_DrawName
    dw RunLinkSession5Exchange_ShowPartnerMonster
    dw RunLinkSession5Exchange_RunBreedListFinal

; Back to the list, step 0: restores the list cursor and page. (C2, E-0357; probed E-0382)
RunLinkSession5Exchange_RestoreListCursor::
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Step 9 (the last) of RunLinkSession5Exchange_ResetListAndShowString: sets wScreenState to $11 and
; runs BreedMenu's list steps like RunLinkSession5Exchange_RunBreedList, but the saved wScreenState
; is popped into A and never stored back, so wScreenState keeps whatever BreedMenu left there. (C1,
; E-0372)
RunLinkSession5Exchange_RunBreedListFinal::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

; Back to the list, step 2: runs the list's steps as state $11. (C1, E-0357)
RunLinkSession5Exchange_RunBreedList::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

; Back to the list, step 8: copies the 9 x 7 choice box (LinkBreed_DrawChoiceBox_TileRect) into
; wWindowTileBuffer + $E7 (CopyRectToScreenBufferAndClearAttributes_37), shows string $0F of
; category 0 (the partner's monster) as 13 x 1 tiles at vTiles2 + $600, sets the string window back
; to vTiles1 with size $1202, then falls into BlinkCursorScreenCounter_Bank37. (C1, E-0371)
RunLinkSession5Exchange_ShowPartnerMonster::
    ld de, LinkBreed_DrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectToScreenBufferAndClearAttributes_37
    ld a, $0f
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0d01
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

; Draws the picture of the species of record buffer B: wArg1 and wArg2 = the species word at
; wRecordBufB + MON_SPECIES, wArg3 = 0 (tile offset), wArg4 = $90 and wArg5 = $40 (screen position
; added to the scroll), wArg6 = 0, then farcalls DrawMetaSpritePartC0. Nothing in src names this
; routine as a caller target. (C1, E-0382)
; wArg1/2 = the species wRecordBufB + $B/7, wArg3-6 = $00, $90, $40, $00, then far-calls
; DrawMetaSpritePartC0 (E-0122) (E-0340: the address in its name read as its RAM name; was
; DrawRecordBufBSpeciesSpritePart)
DrawRecordBufBSpeciesSpritePart::
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    xor a
    ld [wArg6], a
    farcall DrawMetaSpritePartC0
    ret

; Copies the five 16-byte tiles of PartnerStats_UploadSummaryTiles_Tiles into VRAM with
; CopyTileBytesToVRAM_Bank37: the first two to vTiles2 + $6E0 and vTiles2 + $6F0, the next three to
; vTiles2 + $7C0, + $7D0 and + $7E0. PartnerStats_SkillsKeys calls it. (C1, E-0382)
; copies tiles from PartnerStats_UploadSummaryTiles_Tiles: two to vTiles2 + $6E0 and three to
; vTiles2 + $7C0 (CopyTileBytesToVRAM_Bank37) (E-0118) (E-0344: the address in its name dropped or
; read as the label there; was PartnerStats_UploadSummaryTiles)
PartnerStats_UploadSummaryTiles::
    ld hl, PartnerStats_UploadSummaryTiles_Tiles
    ld de, vTiles2 + $6e0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ld de, vTiles2 + $7c0
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    call CopyTileBytesToVRAM_Bank37
    ret

; HL = $58AE and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
PartnerStats_UploadSummaryTiles_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $ff ; entry 0
    db $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 1
    db $ff, $ff, $ff, $ff, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 2
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $ff, $ff, $ff ; entry 3
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 4

; Copies 16 bytes from [HL] to [DE], one at a time: each byte is written with interrupts off (di)
; after waiting until bit 1 of rSTAT is clear, then interrupts are turned on again (ei) before the
; next byte, so they are left enabled. HL and DE move on by 16, A is clobbered; C and the other
; registers are untouched. The same 20 bytes are in 3 banks. (C1, E-0382)
; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (E-0353: corrected; was: Copies 16 bytes
; from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to
; clear; clobbers A; HL and DE advance) (the same 20 bytes appear in 3 banks)
CopyTileBytesToVRAM_Bank37::
    xor a

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp $10
    jr c, .loop
    ret

; HL = a name: copies its characters to wNameGlyphBuf, at most 10 of them and stopping at a $F0, and
; then writes a $F0 terminator after them. Returns with A = $F0, C = the number of characters
; copied, DE = the address of the terminator written and HL = the source byte where it stopped (the
; source $F0, or the byte after the tenth). PartnerStats_DrawNameAndSpecies and
; PartnerStats_DrawHeadingName use it before CopyGlyphTilesToVRAM. (C2, E-0382)
; copies up to 10 bytes from HL to wNameGlyphBuf, stopping at $F0, and appends $F0 (E-0124)
CopyF0NameToNameGlyphBuf::
    ld de, wNameGlyphBuf
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; Draws record B's name (wRecordBufB + MON_NAME, CopyF0NameToNameGlyphBuf) as glyph tiles at vTiles1
; + $780 and its species name, string [wRecordBufB + MON_SPECIES] of category [wRecordBufB +
; MON_SPECIES + 1] + 2 (ShowString_Bank08), as 9 x 1 tiles at vTiles1 + $270, leaving the string
; window there. Used by PartnerStats_DrawNames and PartnerStats_DrawSummaryLevelRow. (C1, E-0372)
; draws the name at wRecordBufB + $1 at vTiles1 + $780 and shows string [wRecordBufB + $B] of
; category [wRecordBufB + $C] + 2 at vTiles1 + $270 with size $0109 (E-0124) (E-0340: the address in
; its name read as its RAM name; was PartnerStats_DrawNameAndSpecies)
PartnerStats_DrawNameAndSpecies::
    ld hl, wRecordBufB + MON_NAME
    call CopyF0NameToNameGlyphBuf
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wRecordBufB + MON_SPECIES
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    add $02
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

; HL = BG map destination, DE = source: stores them in wArg5, wArg6 (H, L) and wArg1, wArg2 (D, E),
; then farcalls DrawTileRectFromArg1Params, which draws the tile rectangle whose width and rows the
; caller has already put in wArg3 and wArg4 (wArg7 = 0 also clears the attributes on CGB). The same
; 23 bytes are in 4 banks. (C1, E-0382)
; wArg5/wArg6 = HL (destination), wArg1/wArg2 = DE (source), then far-calls
; DrawTileRectFromArg1Params (width and rows already in wArg3/wArg4) (E-0093) (the same 23 bytes
; appear in 4 banks)
DrawTileRectAtHLFromDE_Bank37::
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

; Copies a block of 9 bytes wide and 7 rows from screen buffer offset $0083 to offset $024F
; (CopyScreenBufferRectWithAttrs_37 with wArg1 = 0, wArg2 = 9, B = 0, C = 7), then redraws the 20 x
; 13 screen buffer area at offset $01CC onto the BG map at the scroll position
; (BGMapAddressAtScroll_Bank37, DrawScreenBufferRectToBGMap_37). Offset $024F is where
; LinkBreed_DrawChoiceBox put the 9 x 7 choice box, so LinkBreed_ReadChoice calls this to draw that
; area from the saved copy again when the choice ends. (C1, E-0382)
; runs CopyScreenBufferRectWithAttrs_37 (C = 7, HL = $024F, DE = $0083, wArg1/2 = 0/9), then draws
; the box at scroll + $1CC (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was LinkBreed_ClearChoiceBox; shortened from
; RunCopyScreenBufferRectWithAttrs_37At024FAndDrawBox)
LinkBreed_ClearChoiceBox::
    ld b, $00
    ld c, $07
    ld hl, $024f
    ld de, $0083
    xor a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_37
    call BGMapAddressAtScroll_Bank37
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ret

; A = string number: stores it in wStringIndex (wStringCategory is not touched) and farcalls
; BeginStringDisplay_Bank0E, which starts showing that string of the bank $0E breeding text table
; and sets wTextFlags to 1. Session 5 uses it for the texts such as 'Please wait.' (7) and 'Choose
; the monster for breeding.' (9). (C1, E-0382)
; wStringIndex = A (wStringCategory unchanged), then far-calls BeginStringDisplay_Bank0E (E-0066)
ShowStringIndexA_Bank37::
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0E
    ret

; Moves a cursor over three entries and reports the key in wMenuInputResult and A. Up (bit 6 of
; wJoypadPressedRepeat) and Down (bit 7) change wTwoChoiceCursor by one and wrap between 0 and 2:
; the old cursor tile is blanked ($C3), wScreenCounter restarts, the cursor tile $BB is drawn at the
; new entry, sound $69 is queued and the result is $FD. Otherwise A (bit 0 of wJoypadPressed) draws
; the arrow tile $BC at the entry, queues sound $69 and gives $FF; B (bit 1) gives $FE; with no key
; the cursor blinks (BlinkCursorScreenCounter_Bank37) and the result is 0. LinkBreed_ReadChoice
; reads the result. (C1, E-0382)
; up/down moves wTwoChoiceCursor over three entries (wMenuInputResult = $FD), A and B select or
; cancel; otherwise blinks the cursor (E-0127)
HandleThreeChoiceCursorInput_37::
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
    xor a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank37:
    call DrawBlankTileC3_Bank37
    ld a, [wTwoChoiceCursor]
    and a
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
    cp $02
    jr c, .set_two_choice_cursor2
    xor a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a
    ld [wScreenCounter], a
    call DrawCursorTileBB_Bank37
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_two_choice_entry:
    call DrawArrowTileBCAtTwoChoiceEntry_Bank37
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the cursor of the three-entry choice. While wJoypadRepeatTimer is below $14 it just draws
; the cursor tile $BB (DrawCursorTileBB_Bank37). From $14 on it adds 1 to wScreenCounter each call:
; below $10 it draws the cursor tile, from $10 to $17 a blank tile $C3 (DrawBlankTileC3_Bank37), and
; at $18 it resets the counter to 0 and draws the cursor tile, so the cursor is shown 16 calls and
; hidden 8. (C1, E-0382)
; once the joypad repeat timer reaches $14, cycles wScreenCounter through 0-$17 and draws the cursor
; tile ($BB) or a blank ($C3) (E-0122)
BlinkCursorScreenCounter_Bank37::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank37
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, DrawCursorTileBB_Bank37
    cp $18
    jr c, DrawBlankTileC3_Bank37
    xor a
    ld [wScreenCounter], a

; B = $BB (the cursor tile) and jumps to DrawTileBAtTwoChoiceEntry_Bank37, which writes it at the
; entry chosen by wTwoChoiceCursor. (C1, E-0382)
; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_Bank37::
    ld b, $bb
    jr DrawTileBAtTwoChoiceEntry_Bank37

; B = $C3 (the blank tile) and jumps to DrawTileBAtTwoChoiceEntry_Bank37, which writes it at the
; entry chosen by wTwoChoiceCursor. (C1, E-0382)
; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank37::
    ld b, $c3
    jr DrawTileBAtTwoChoiceEntry_Bank37

; B = $BC (the arrow tile) and falls into DrawTileBAtTwoChoiceEntry_Bank37, which writes it at the
; entry chosen by wTwoChoiceCursor in the BG map. (C1, E-0382)
; B = $BC, then writes B at the scroll position +
; DrawTileBAtTwoChoiceEntry_Bank37_Data[wTwoChoiceCursor] (E-0124)
DrawArrowTileBCAtTwoChoiceEntry_Bank37::
    ld b, $bc

; Writes tile B at choice wTwoChoiceCursor's place, stepping back on a scroll wrap. (C1, E-0357)
DrawTileBAtTwoChoiceEntry_Bank37::
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, DrawTileBAtTwoChoiceEntry_Bank37_Data
    add_a_to_hl
    ld a, [hli]
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

; Three little-endian BG map offsets from the top-left screen tile, $00EC, $012C and $016C: column
; 12 of rows 7, 9 and 11 (32 tiles per BG row). DrawTileBAtTwoChoiceEntry_Bank37 indexes it by
; wTwoChoiceCursor and writes tile B there, the cursor mark beside the chosen entry. (C1, E-0381)
DrawTileBAtTwoChoiceEntry_Bank37_Data::
    db $ec, $00, $2c, $01, $6c, $01

; Copies a block inside the screen buffer: HL = destination offset and DE = source offset into
; wScreenTileBuffer, wArg1:wArg2 (high, low) = bytes per row, rows B to C - 1 (B is the first row
; number, C the end), the offsets moving on by 20 (one buffer row) each row. When wIsCGB is non-zero
; the same block of the attribute buffer wScreenAttrBuffer is copied at the same offsets with
; CopyLow3BitsToWRAMBank2_Bank37 (each byte ANDed with 7). On return B = C and HL and DE have moved
; on by 20 per row. (C2, E-0382)
; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL for rows B to C,
; with CGB attributes (E-0128)
CopyScreenBufferRectWithAttrs_37::
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
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp c
    jr c, CopyScreenBufferRectWithAttrs_37
    ret

; DE = source, HL = destination, BC = number of bytes: copies the bytes one by one, DE and HL end
; just past the copy, BC = 0 and A = 0. The count is tested after the first byte, so BC = 0 would
; count down from 65536 and copy that many. The same 9 bytes are in 13 banks. (C2, E-0382)
; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank37::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank37
    ret

; DE = source, HL = destination, BC = number of bytes: sets rSVBK to 2, copies the bytes with each
; ANDed with $07 (only the low three bits of a CGB attribute are kept), then sets rSVBK to 0. DE and
; HL end past the copy, BC = 0. The same 19 bytes are in 5 banks. (C2, E-0382)
; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks)
CopyLow3BitsToWRAMBank2_Bank37::
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
    ld a, $00
    ldh [rSVBK], a
    ret

; B = record number, wArg1 = VRAM tile number: enables SRAM bank 0, reads the family byte of that
; SRAM record (MON_FAMILY, LoadSRAMRecordByte), stores its low nibble in wWorkBuf and wArg1 in
; wWorkBuf + 1, farcalls LoadFamilyIconTileForWorkBuf (which writes the family icon tile to that
; tile number) and disables SRAM again. LinkBreed_DrawPanel calls it with tile $C7. (C1, E-0382)
; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = wArg1, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_Bank37::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ret

; B = width, C = rows, DE = source, HL = destination in the screen buffer: copies C rows of B bytes,
; the destination moving on by 20 bytes (one buffer row) per row. When wIsCGB is non-zero it then
; clears the same rectangle of the attribute buffer, which lies $0E68 bytes above the tile buffer
; (HL + $0E68, wScreenAttrBuffer minus wScreenTileBuffer), with rSVBK set to 2, and puts rSVBK back
; to 0. DE ends just past the source rectangle; without CGB BC and HL come back as they were on
; entry. (C2, E-0382)
; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows
; in WRAM bank 2 (E-0127)
CopyRectToScreenBufferAndClearAttributes_37::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
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
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; B = width, C = rows, HL = BG map address, DE = offset into wScreenTileBuffer: copies that
; rectangle of the screen buffer to the BG map (CopyRectFromBankToBGMapWrapped), sets wTextCursorLo
; and wTextCursorHi to HL + $01C1 and, when wIsCGB is non-zero, copies the matching rectangle of
; wScreenAttrBuffer (WRAM bank 2) to VRAM bank 1 the same way; the VRAM bank and WRAM bank are put
; back to 0 at the end. (C1, E-0382)
; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL +
; $1C1, and on CGB copies its attributes (E-0127)
DrawScreenBufferRectToBGMap_37::
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
    xor a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add $c1
    ld l, a
    ld a, h
    adc $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4f
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
    xor a
    call CopyRectFromBankToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8: the BG map entry for the pixel at the scroll
; position (32 entries per map row, 8 pixels per entry). A and DE are clobbered. The same 33 bytes
; are in 18 banks. (C1, E-0382)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank37::
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

; HL = a table of 16-bit addresses, A = index, B = value: stores B at the address held in entry A of
; the table. BC is kept; A, DE and HL are clobbered. LinkBreed_ReadChoice uses it with
; LinkBreed_ReadChoice_Data to write the tile $BC. The same 16 bytes are in 4 banks. (C2, E-0382)
; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 16 bytes appear in 4 banks)
StoreBAtWordTableEntry_Bank37::
    push bc
    sla a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; Packs the own record of this side into the exchange buffer: wRecordBufA (the $A5-byte record
; LinkBreed_SendRecord copied from SRAM) becomes the $95 bytes at wWorkBuf that the link sends.
; State byte; name and master name cut to 4 glyphs plus 4 $F0 with the glyph codes of this game
; changed ($95, $AB, $B5, $94, $93 to $5C, $5E, $5F, $60, $61 and $0A-$3D up by $1A); the species as
; a one-byte code (SpeciesToLinkCodeTable); the family nibble (9 is looked up from the species, 10
; becomes 9); the sex bit; the master id; the two parent species as codes with their master names
; and the bytes after them (two '???' names behind $FF $FF when both parent species bytes are $FF);
; the 33 skill bytes mapped through LinkSkillMapTable_A and packed to the front of each list
; (MapAndCompactSkillListLinkSkillMapTable_A); status, level, cap, EXP and HP to DEF as they are;
; the AGL, INT and WLD words scaled down to about 51, 25 and 25 percent (999 becomes $01FF or
; $00FF); plus and egg bytes; the four personality bytes replaced by $28, $E6, the third one and
; $E6; 26 of the 27 resistances and a 0; and the two parent names with their plus values. It ends by
; farcalling LoadTableEntryForWorkBuf9ToLinkMenuEntryBytes, which writes three table bytes over
; wWorkBuf + $4D to $4F, so the EXP field of the buffer is the table value for the level.
; UnpackLinkRecordToRecordBufB does the reverse for the record received from the partner. (C2,
; E-0382)
; unpacks the received partner record at wRecordBufA into wWorkBuf: names, species, family, parents,
; skills and scaled stats (E-0129)
PackRecordBufAToLinkWorkBuf::
    ld hl, wWorkBuf
    ld de, wRecordBufA
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesToLinkFormat
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call FamilyNibbleOrSpeciesFamily
    ld a, [de]
    and $01
    ld [hli], a
    inc de
    call ConvertNameBytesToLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    dec de
    and c
    ld [wLinkRules], a
    cp $ff
    jr nz, .call_append_species_to_link_code_byte_for
    call WriteFFPairAndUnknownName
    jr .call_map_and_compact_skill_list_link_skill

.call_append_species_to_link_code_byte_for:
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call ConvertNameBytesToLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesToLinkFormat
    ld a, [de]
    ld [hli], a
    inc de

.call_map_and_compact_skill_list_link_skill:
    call MapAndCompactSkillListLinkSkillMapTable_A
    ld b, $12
    call CopyBBytesDEToHL_Bank37
    call ScaleStatWordsToLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, $28
    ld [hli], a
    inc de
    ld a, $e6
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, $e6
    ld [hli], a
    inc de
    ld b, $1a
    call CopyBBytesDEToHL_Bank37
    ld a, $00
    ld [hli], a
    inc de
    ld a, [wLinkRules]
    cp $ff
    jr nz, .call_convert_name_bytes_to_link_format
    call WriteUnknownNameEntry
    jr .call_load_table_entry_for_work_buf9_to_link

.call_convert_name_bytes_to_link_format:
    call ConvertNameBytesToLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesToLinkFormat
    ld a, [de]
    ld [hl], a

.call_load_table_entry_for_work_buf9_to_link:
    farcall LoadTableEntryForWorkBuf9ToLinkMenuEntryBytes
    ret

; Unpacks the record received from the partner: the $95 bytes at wBattlerRecordSlot1 +
; BATTLER_SKILLS + 1 become a full record in wRecordBufB. State byte; name and master name changed
; to the glyphs of this game ($5C, $5E, $5F, $60, $61, $63, $64 to $95, $AB, $B5, $94, $93, $99,
; $98; $0A-$0D to 0-3; $24-$57 down by $1A) and padded to 10 bytes with two $F0; the species word
; from the one-byte code (LinkCodeToSpeciesTable) and its family from the species record
; (LoadSpeciesRecord); the sex bit; the master id; the two parent species words from their codes and
; then CheckBreedingRecipes, which can set bit 4 of MON_FAMILY; the parent master names and the
; bytes after them (four $FF and two blank names when the first parent code is $FF); the skills
; mapped through LinkSkillMapTable_B and packed to the front of each list; status to DEF, plus, egg
; and personality bytes copied; the AGL, INT and WLD words scaled up (999 for $01FF or $00FF, about
; 1.95 and 3.91 times otherwise); the resistances, the last one from the species record; the parent
; names with their plus values; and a 0 at MON_ITEM. It ends by farcalling
; LoadTableEntryForRecordBufBSpeciesToRecordBufBExp, which sets MON_EXP from the experience table
; for the level. (C2, E-0382)
; unpacks the received record at wBattlerRecordSlot1 + $F into wRecordBufB: names, species ids from
; LinkCodeToSpeciesTable, family, parents, skills and scaled stats (E-0127)
UnpackLinkRecordToRecordBufB::
    ld hl, wRecordBufB
    ld de, wBattlerRecordSlot1 + BATTLER_SKILLS + 1
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertLinkNameBytesToGameGlyphs
    call AppendLinkCodeToSpeciesWordForByteAtDE
    ld a, c
    ld [wSpeciesIdLo], a
    ld a, b
    ld [wSpeciesIdHi], a
    call StoreSpeciesFamilyAtHL
    ld a, [de]
    and $01
    ld [hli], a
    inc de
    call ConvertLinkNameBytesToGameGlyphs
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [wLinkRules], a
    cp $ff
    jr nz, .call_append_link_code_to_species_word_for
    call WriteFFQuadAndBlankName
    jr .call_map_and_compact_skill_list_link_skill

.call_append_link_code_to_species_word_for:
    call AppendLinkCodeToSpeciesWordForByteAtDE
    call AppendLinkCodeToSpeciesWordForByteAtDE
    call CallInBank81KeepRegs
    call ConvertLinkNameBytesToGameGlyphs
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertLinkNameBytesToGameGlyphs
    ld a, [de]
    ld [hli], a
    inc de

.call_map_and_compact_skill_list_link_skill:
    call MapAndCompactSkillListLinkSkillMapTable_B
    ld b, $12
    call CopyBBytesDEToHL_Bank37
    call ScaleStatWordsFromLinkFormat
    ld b, $06
    call CopyBBytesDEToHL_Bank37
    call Copy26BytesThenLastSpeciesResistance
    call ConvertLinkNameBytesToGameGlyphs
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertLinkNameBytesToGameGlyphs
    ld a, [de]
    ld [hli], a
    ld [hl], $00
    farcall LoadTableEntryForRecordBufBSpeciesToRecordBufBExp
    ret

; DE += 4, then writes the two bytes $FF $FF at HL and falls into WriteUnknownNameEntry, which
; writes two placeholder names. In all 20 bytes go to HL and DE moves on by $1A.
; PackRecordBufAToLinkWorkBuf calls it when both parent species bytes are $FF (the parents are
; unknown). (C2, E-0382)
; DE += 4, writes two $FF bytes and falls into the '???' name entry (E-0126)
WriteFFPairAndUnknownName::
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, $ff
    ld [hli], a
    ld [hli], a

; Calls WriteUnknownNamePlaceholder_Bank37 and falls into it again, so it writes two placeholder
; names ('???' as three $98, five $F0 and a 0, each 9 bytes): 18 bytes at HL and DE moves on by $16.
; This is the unknown-parents case of PackRecordBufAToLinkWorkBuf: one name for each parent master.
; (C2, E-0382)
; calls WriteUnknownNamePlaceholder_Bank37 and falls into it again (E-0126) (E-0344: the address in
; its name dropped or read as the label there; was WriteUnknownNameEntry)
WriteUnknownNameEntry::
    call WriteUnknownNamePlaceholder_Bank37

; Writes the placeholder name '???' at HL: the glyph $98 three times, five $F0 bytes and a 0 (9
; bytes); HL moves on 9 and DE moves on by $0B (it skips the name field of the record being read), A
; = 0. PackRecordBufAToLinkWorkBuf uses it for a parent name that is unknown. (C2, E-0382)
; DE += $0B; writes '???' ($98 x 3), five $F0 bytes and a 0 at HL (E-0120)
WriteUnknownNamePlaceholder_Bank37::
    ld a, e
    add $0b
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    xor a
    ld [hli], a
    ret

; DE += 2, writes four $FF bytes at HL and falls into WriteBlankName10_Bank37 twice (once by call,
; once by falling in): each writes ten $F0 and a 0 (11 bytes) and moves DE on by 9. In all 26 bytes
; go to HL and DE moves on by 20. UnpackLinkRecordToRecordBufB calls it when the first received
; parent code is $FF. (C2, E-0382)
; DE += 2, writes four $FF bytes, then WriteBlankName10_Bank37 (and falls into it) (E-0126)
WriteFFQuadAndBlankName::
    inc de
    inc de
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call WriteBlankName10_Bank37

; Blanks one name-and-byte group of the link record being built: DE += 9 (nine source bytes skipped,
; not read), then ten $F0 bytes and a 0 are written at HL, which ends 11 bytes on; A = 0.
; WriteFFQuadAndBlankName calls it and then falls into it again, so two groups are blanked;
; UnpackLinkRecordToRecordBufB does that for the parent fields when the first parent code byte it
; reads is $FF. (C2, E-0382)
; DE += 9; writes ten $F0 (blank) bytes and a terminating 0 at HL (E-0121)
WriteBlankName10_Bank37::
    ld a, e
    add $09
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, $f0
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    xor a
    ld [hli], a
    ret

; DE = source, HL = destination, B = count: copies B bytes from [DE] to [HL] and advances both (B =
; 0 copies 256 bytes); B ends 0 and A is the last byte copied. It moves the unconverted runs of a
; link record: the $12-byte and $1A-byte runs in PackRecordBufAToLinkWorkBuf, the $12-byte and
; 6-byte runs in UnpackLinkRecordToRecordBufB, and the 26 bytes of
; Copy26BytesThenLastSpeciesResistance. (C2, E-0382)
; copies B bytes from HL to DE; HL and DE advance, B = 0 (E-0115)
CopyBBytesDEToHL_Bank37::
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, CopyBBytesDEToHL_Bank37
    ret

; Converts one name glyph code of a received link record into the code the game itself uses. A =
; code in, A = code out: $5C, $5E, $5F, $60, $61, $63, $64 become $95, $AB, $B5, $94, $93, $99, $98;
; $0A-$0D become 0-3; $24-$57 go down by $1A; every other code is unchanged. It is called for each
; of the eight name bytes by the name converter that UnpackLinkRecordToRecordBufB uses;
; PackRecordBufAToLinkWorkBuf applies the opposite mapping when it packs a record for sending. (C2,
; E-0382)
ConvertLinkNameGlyphToGameGlyph::
    cp $5c
    jr z, .skip
    cp $5e
    jr z, .skip2
    cp $5f
    jr z, .skip3
    cp $60
    jr z, .skip4
    cp $61
    jr z, .skip5
    cp $63
    jr z, .skip6
    cp $64
    jr z, .return_98
    cp $0e
    jr nc, .cp_58
    cp $0a
    jr c, .cp_58
    sub $0a
    jr .return

.cp_58:
    cp $58
    jr nc, .return
    cp $24
    jr c, .return
    sub $1a
    jr .return

.skip:
    ld a, $95
    jr .return

.skip2:
    ld a, $ab
    jr .return

.skip3:
    ld a, $b5
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

; Packs one name for sending: DE = the name in the game glyph codes (8 bytes are read, then DE skips
; 2 more), HL = destination. Only the first four glyphs are kept: $0A-$3D go up by $1A, $95 $AB $B5
; $94 $93 become $5C $5E $5F $60 $61, other codes are unchanged, and four $F0 bytes follow, so a
; name is cut to four characters. DE ends 10 bytes on, HL 8 bytes on, B = 0, C = 4.
; PackRecordBufAToLinkWorkBuf uses it for each name of the record it builds in wWorkBuf. (C2,
; E-0382)
; converts 8 name bytes at DE to the game's glyphs ($0A-$3D + $1A, special marks $93-$95, $AB, $B5),
; padding after the fourth with $F0 (E-0127)
ConvertNameBytesToLinkFormat::
    ld c, $00
    ld b, $08

.loop:
    ld a, [de]
    cp $95
    jr z, .skip
    cp $ab
    jr z, .skip2
    cp $b5
    jr z, .skip3
    cp $94
    jr z, .skip4
    cp $93
    jr z, .skip5
    cp $0a
    jr c, .next
    cp $3e
    jr nc, .next
    add $1a
    jr .next

.skip:
    ld a, $5c
    jr .next

.skip2:
    ld a, $5e
    jr .next

.skip3:
    ld a, $5f
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
    ld a, $f0

.skip6:
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    inc de
    inc de
    ret

; DE = a species number (a word, low byte first), HL = destination: DE += 2; the byte at
; SpeciesToLinkCodeTable + species (this bank, read without a range check) is stored at [HL] and HL
; += 1; A = that byte, the link code of the species. PackRecordBufAToLinkWorkBuf uses it for the
; species of the record and for its two parents. (C2, E-0382)
; reads a word index at DE (DE += 2) and appends the byte at $6175 + index to [HL+] (E-0121)
AppendSpeciesToLinkCodeByteForWordAtDE::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, l
    add $75
    ld l, a
    ld a, h
    adc $61
    ld h, a
    ld a, [hl]
    pop hl
    ld [hli], a
    ret

; DE = source, HL = destination, where the byte before HL is the link code just written: A = [DE] &
; $0F, DE += 1. A nibble of 9 is replaced by the family of the species of that link code
; (LinkCodeToSpeciesTable gives the species, LoadSpeciesFamily the family); a value of 10 (the Boss
; family) becomes 9. The result is stored at [HL] and HL += 1. PackRecordBufAToLinkWorkBuf calls it
; right after the species code is written. (C2, E-0382)
; A = [DE] & $0F (DE += 1); for 9 looks up the species at LinkCodeToSpeciesTable[[HL - 1]] and uses
; its family; 10 becomes 9; stores it at [HL+] (E-0124)
FamilyNibbleOrSpeciesFamily::
    ld a, [de]
    and $0f
    inc de
    cp $09
    jr nz, .cp_0A
    push hl
    dec hl
    ld a, [hl]
    ld hl, LinkCodeToSpeciesTable
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesFamily
    pop de
    pop hl
    ld a, [wSpeciesRecord]

.cp_0A:
    cp $0a
    jr nz, .done
    ld a, $09

.done:
    ld [hli], a
    ret

; DE = source, HL = destination of $21 (33) skill bytes: each byte except $FF is replaced by
; LinkSkillMapTable_A[byte] (the index is not range checked). The first 8 mapped bytes and the next
; 25 are then each packed to the front of their own list, dropping every $FE and $FF, padded with
; $FF and written to HL; HL and DE end 33 bytes on. The packing is done in the 33 bytes at
; wBattlerRecordSlot5 + BATTLER_SKILLS + 2 (the first list there, the second from
; wBattlerRecordSlot5 + BATTLER_EXP), which are left holding the packed result.
; PackRecordBufAToLinkWorkBuf calls it once for the skill lists of the record being sent. (C2,
; E-0382)
; maps $21 bytes through LinkSkillMapTable_A and compacts the 8- and $19-entry lists, dropping
; $FE/$FF entries (E-0127)
MapAndCompactSkillListLinkSkillMapTable_A::
    ld b, $21
    push hl

.loop:
    ld a, [de]
    inc de
    cp $ff
    jr z, .skip
    push hl
    ld hl, LinkSkillMapTable_A
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip:
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    push de
    push hl
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2
    ld b, $21
    ld a, $ff

.loop2:
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld b, $08
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop3:
    ld a, [hli]
    cp $fe
    jr nc, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop3
    ld b, $19
    ld de, wBattlerRecordSlot5 + BATTLER_EXP

.loop4:
    ld a, [hli]
    cp $fe
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
    ld [hli], a
    dec b
    jr nz, .loop5
    pop de
    ret

; DE = three 16-bit words (low byte first), HL = destination: writes three words scaled down for the
; link record. Word 1 is $01FF when it is 999, otherwise word x $33 / 100 rounded up; words 2 and 3
; are $00FF when 999, otherwise word x $19 / 100 rounded up. DE and HL end 6 bytes on.
; PackRecordBufAToLinkWorkBuf calls it once; the receiving side scales back up. (C2, E-0382)
; converts three stat words at DE: 999 becomes $01FF/$00FF, otherwise word * $33 or $19 / 100
; rounded up; stores them at HL (E-0129)
ScaleStatWordsToLinkFormat::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03e7
    call CompareHLToBC
    jr nz, .call_multiply8_by16
    ld bc, $01ff
    jr .restore

.call_multiply8_by16:
    push de
    ld a, $33
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a
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
    ld hl, $03e7
    call CompareHLToBC
    jr nz, .call_multiply8_by162
    ld bc, $00ff
    jr .restore2

.call_multiply8_by162:
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a
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
    ld hl, $03e7
    call CompareHLToBC
    jr nz, .call_multiply8_by163
    ld bc, $00ff
    jr .restore3

.call_multiply8_by163:
    push de
    ld a, $19
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a
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

; DE = a name of 8 bytes in the link format, HL = destination: each byte is converted to the game
; glyph code by the glyph converter (the table of $5C to $95 and so on) and two $F0 bytes are
; appended, giving the 10-byte name of a game record. DE ends 8 bytes on, HL 10 bytes on, B = 0.
; UnpackLinkRecordToRecordBufB calls it for every name field of the partner record it receives. (C2,
; E-0382)
; converts 8 bytes from DE through ConvertLinkNameGlyphToGameGlyph into HL, then appends two $F0
; bytes (E-0122)
ConvertLinkNameBytesToGameGlyphs::
    ld b, $08

.loop:
    ld a, [de]
    call ConvertLinkNameGlyphToGameGlyph
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [hli], a
    ld [hli], a
    ret

; DE = a link code byte (0-214), HL = destination: DE += 1; the word at LinkCodeToSpeciesTable + 2 x
; code, a species number, is stored at [HL] low byte first and HL += 2; A = C = the low byte, B =
; the high byte. UnpackLinkRecordToRecordBufB uses it for the species of the received record and for
; its two parents. (C2, E-0382)
; reads a byte index at DE (DE += 1) and appends the word at $5FC7 + 2 * index to [HL]; HL ends
; after the word, C = low byte (E-0121)
AppendLinkCodeToSpeciesWordForByteAtDE::
    ld a, [de]
    inc de
    push hl
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add $c7
    ld l, a
    ld a, h
    adc $5f
    ld h, a
    ld a, [hli]
    ld b, [hl]
    pop hl
    ld [hli], a
    ld [hl], b
    ld c, a
    inc hl
    ret

; wSpeciesIdLo/Hi = a species: LoadSpeciesRecord (a far call) fills wSpeciesRecord, whose first byte
; is the family, and that byte is stored at [HL]; HL += 1 and DE += 1 (the source byte at DE is
; skipped, not read), other registers kept. UnpackLinkRecordToRecordBufB calls it right after the
; species of the received record is converted, which also leaves the whole species record in
; wSpeciesRecord for Copy26BytesThenLastSpeciesResistance. (C2, E-0382)
; LoadSpeciesRecord (id already in wSpeciesIdLo/Hi), then stores its family at HL; HL += 1, DE += 1
; (E-0118)
StoreSpeciesFamilyAtHL::
    push hl
    push de
    farcall LoadSpeciesRecord
    pop de
    pop hl
    ld a, [wSpeciesRecord]
    ld [hli], a
    inc de
    ret

; As MapAndCompactSkillListLinkSkillMapTable_A but through LinkSkillMapTable_B and dropping only
; $FF: each source byte except $FF is replaced by LinkSkillMapTable_B[byte], the first 8 and the
; next 25 results are packed to the front of their own lists and padded with $FF, and HL and DE end
; 33 bytes on. A mapped $FE is kept; the table has 222 entries, so a source byte of $DE or more
; reads the bytes after it (249 gives $FE). UnpackLinkRecordToRecordBufB calls it once for the
; skills of the received record. (C2, E-0382)
; maps $21 bytes through LinkSkillMapTable_B and compacts the 8- and $19-entry lists, dropping $FF
; entries (E-0127)
MapAndCompactSkillListLinkSkillMapTable_B::
    ld b, $21
    push hl

.loop:
    ld a, [de]
    inc de
    cp $ff
    jr z, .skip
    push hl
    ld hl, LinkSkillMapTable_B
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip:
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    push de
    push hl
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2
    ld b, $21
    ld a, $ff

.loop2:
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld b, $08
    ld de, wBattlerRecordSlot5 + BATTLER_SKILLS + 2

.loop3:
    ld a, [hli]
    cp $ff
    jr z, .next
    ld [de], a
    inc de

.next:
    dec b
    jr nz, .loop3
    ld b, $19
    ld de, wBattlerRecordSlot5 + BATTLER_EXP

.loop4:
    ld a, [hli]
    cp $ff
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
    ld [hli], a
    dec b
    jr nz, .loop5
    pop de
    ret

; DE = three 16-bit words of a received link record (low byte first), HL = destination: word 1 is
; 999 when it is $01FF, otherwise word x $C3 / 100 rounded up. The routine that follows is then
; called for word 2 and entered again by falling into it for word 3. DE and HL end 6 bytes on. It
; undoes the scaling that ScaleStatWordsToLinkFormat applied when the record was sent, and
; UnpackLinkRecordToRecordBufB calls it once. (C2, E-0382)
; reads a word at DE: $01FF becomes 999, otherwise word * $C3 / 100 rounded up; stores it at HL and
; continues with the next word (ScaleStatWordsFromLinkFormat_NextWord) (E-0125) (E-0344: the address
; in its name dropped or read as the label there; was ScaleStatWordsFromLinkFormat)
ScaleStatWordsFromLinkFormat::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $01ff
    call CompareHLToBC
    jr nz, .call_multiply8_by16
    ld bc, $03e7
    jr .restore

.call_multiply8_by16:
    push de
    ld a, $c3
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a
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
    call ScaleStatWordsFromLinkFormat_NextWord

; DE = a 16-bit word (low byte first), HL = destination: stores 999 when the word is $00FF,
; otherwise word x $5B / 100 rounded up plus 3 x word (about 3.9 x word), as a 16-bit sum; DE and HL
; advance 2. ScaleStatWordsFromLinkFormat calls it for its second word and then falls into it for
; the third. (C2, E-0382)
; reads a word at DE: $00FF becomes 999, otherwise word * $5B / 100 rounded up plus 3 * word; stores
; it at HL (E-0125) (E-0344: the address in its name dropped or read as the label there; was
; ScaleStatWordsFromLinkFormat_NextWord)
ScaleStatWordsFromLinkFormat_NextWord::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $00ff
    call CompareHLToBC
    jr nz, .skip
    ld bc, $03e7
    jr .restore

.skip:
    push de
    push bc
    ld a, $5b
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    or a
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

; DE = source, HL = destination: copies 26 ($1A) bytes from [DE] to [HL], then appends the last base
; resistance of the species record loaded earlier (wSpeciesRecord + SPECIES_RESISTANCES + 26) as the
; 27th byte. DE ends 27 bytes on (the 27th source byte is skipped), HL 27 on.
; UnpackLinkRecordToRecordBufB uses it to build the 27 resistance bytes of the received record. (C2,
; E-0382)
; copies $1A bytes (CopyBBytesDEToHL_Bank37), then appends wSpeciesRecord + $2C as the 27th byte
; (E-0115) (E-0340: the address in its name read as its RAM name; was
; Copy26BytesThenLastSpeciesResistance) (E-0345: the byte after the 26 is wSpeciesRecord + $2C, the
; last resistance; was Copy26BytesThenLastSpeciesResistance)
Copy26BytesThenLastSpeciesResistance::
    ld b, $1a
    call CopyBBytesDEToHL_Bank37
    ld a, [wSpeciesRecord + SPECIES_RESISTANCES + 26]
    ld [hli], a
    inc de
    ret

; Far-calls CheckBreedingRecipes in bank $81 with AF, BC, DE and HL pushed and restored, so the
; caller loses nothing. CheckBreedingRecipes works on wRecordBufB: it tests the two parents against
; the recipes of the record species and sets bit 4 of MON_FAMILY when only the swapped parent order
; matches; it leaves wSpeciesIdLo/Hi equal to the species of wRecordBufB.
; UnpackLinkRecordToRecordBufB calls it once the species and parents of the received record are in
; wRecordBufB. (C2, E-0382)
; far-calls CheckBreedingRecipes, preserving all registers (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was CallInBank81KeepRegs)
CallInBank81KeepRegs::
    push af
    push bc
    push de
    push hl
    farcall CheckBreedingRecipes
    pop hl
    pop de
    pop bc
    pop af
    ret

; FamilyNibbleOrSpeciesFamily reads the word at $5FC7 + 2 * code to look up a species' family while
; PackRecordBufAToLinkWorkBuf unpacks a record; for all 215 codes, SpeciesToLinkCodeTable[species]
; gives the code back (C2 for the pairing) (E-0217, C1)
; record: species for this link code
LinkCodeToSpeciesTable::
    dw MONSTER_DRAKSLIME ; id 0
    dw MONSTER_SPOTSLIME ; id 1
    dw MONSTER_WINGSLIME ; id 2
    dw MONSTER_TREESLIME ; id 3
    dw MONSTER_SNAILY ; id 4
    dw MONSTER_SLIMENITE ; id 5
    dw MONSTER_BABBLE ; id 6
    dw MONSTER_BOXSLIME ; id 7
    dw MONSTER_SLIME ; id 8
    dw MONSTER_HEALER ; id 9
    dw MONSTER_FANGSLIME ; id 10
    dw MONSTER_ROCKSLIME ; id 11
    dw MONSTER_SLIMEBORG ; id 12
    dw MONSTER_SLABBIT ; id 13
    dw MONSTER_SPOTKING ; id 14
    dw MONSTER_KINGSLIME ; id 15
    dw MONSTER_METALY ; id 16
    dw MONSTER_METABBLE ; id 17
    dw MONSTER_METALKING ; id 18
    dw MONSTER_GOLDSLIME ; id 19
    dw MONSTER_DRAGONKID ; id 20
    dw MONSTER_TORTRAGON ; id 21
    dw MONSTER_PTERANOD ; id 22
    dw MONSTER_GASGON ; id 23
    dw MONSTER_FAIRYDRAK ; id 24
    dw MONSTER_LIZARDMAN ; id 25
    dw MONSTER_POISONGON ; id 26
    dw MONSTER_SWORDGON ; id 27
    dw MONSTER_DRAGON ; id 28
    dw MONSTER_MINIDRAK ; id 29
    dw MONSTER_MADDRAGON ; id 30
    dw MONSTER_RAYBURN ; id 31
    dw MONSTER_CHAMELGON ; id 32
    dw MONSTER_LIZARDFLY ; id 33
    dw MONSTER_ANDREAL ; id 34
    dw MONSTER_KINGCOBRA ; id 35
    dw MONSTER_SPIKEROUS ; id 36
    dw MONSTER_GREATDRAK ; id 37
    dw MONSTER_CRESTPENT ; id 38
    dw MONSTER_WINGSNAKE ; id 39
    dw MONSTER_COATOL ; id 40
    dw MONSTER_OROCHI ; id 41
    dw MONSTER_BATTLEREX ; id 42
    dw MONSTER_SKYDRAGON ; id 43
    dw MONSTER_DIVINEGON ; id 44
    dw MONSTER_TONGUELLA ; id 45
    dw MONSTER_ALMIRAJ ; id 46
    dw MONSTER_CATFLY ; id 47
    dw MONSTER_PILLOWRAT ; id 48
    dw MONSTER_SACCER ; id 49
    dw MONSTER_GULPBEAST ; id 50
    dw MONSTER_SKULLROO ; id 51
    dw MONSTER_WINDBEAST ; id 52
    dw MONSTER_ANTBEAR ; id 53
    dw MONSTER_SUPERTEN ; id 54
    dw MONSTER_IRONTURT ; id 55
    dw MONSTER_MOMMONJA ; id 56
    dw MONSTER_HAMMERMAN ; id 57
    dw MONSTER_GRIZZLY ; id 58
    dw MONSTER_YETI ; id 59
    dw MONSTER_MADGOPHER ; id 60
    dw MONSTER_FAIRYRAT ; id 61
    dw MONSTER_UNICORN ; id 62
    dw MONSTER_GOATEGON ; id 63
    dw MONSTER_WILDAPE ; id 64
    dw MONSTER_TRUMPETER ; id 65
    dw MONSTER_KINGLEO ; id 66
    dw MONSTER_DARKHORN ; id 67
    dw MONSTER_MADCAT ; id 68
    dw MONSTER_BIGEYE ; id 69
    dw MONSTER_PICKY ; id 70
    dw MONSTER_WYVERN ; id 71
    dw MONSTER_BULLBIRD ; id 72
    dw MONSTER_FLORAJAY ; id 73
    dw MONSTER_DUCKKITE ; id 74
    dw MONSTER_MADPECKER ; id 75
    dw MONSTER_MADRAVEN ; id 76
    dw MONSTER_MISTYWING ; id 77
    dw MONSTER_DRACKY ; id 78
    dw MONSTER_BIGROOST ; id 79
    dw MONSTER_STUBBIRD ; id 80
    dw MONSTER_LANDOWL ; id 81
    dw MONSTER_MADGOOSE ; id 82
    dw MONSTER_MADCONDOR ; id 83
    dw MONSTER_BLIZZARDY ; id 84
    dw MONSTER_PHOENIX ; id 85
    dw MONSTER_ZAPBIRD ; id 86
    dw MONSTER_WHIPBIRD ; id 87
    dw MONSTER_FUNKYBIRD ; id 88
    dw MONSTER_RAINHAWK ; id 89
    dw MONSTER_MADPLANT ; id 90
    dw MONSTER_FIREWEED ; id 91
    dw MONSTER_FLORAMAN ; id 92
    dw MONSTER_WINGTREE ; id 93
    dw MONSTER_CACTIBALL ; id 94
    dw MONSTER_GULPPLE ; id 95
    dw MONSTER_TOADSTOOL ; id 96
    dw MONSTER_AMBERWEED ; id 97
    dw MONSTER_STUBSUCK ; id 98
    dw MONSTER_ONIONO ; id 99
    dw MONSTER_DANCEVEGI ; id 100
    dw MONSTER_TREEBOY ; id 101
    dw MONSTER_FACETREE ; id 102
    dw MONSTER_HERBMAN ; id 103
    dw MONSTER_BEANMAN ; id 104
    dw MONSTER_EVILSEED ; id 105
    dw MONSTER_MANEATER ; id 106
    dw MONSTER_SNAPPER ; id 107
    dw MONSTER_ROSEVINE ; id 108
    dw MONSTER_WATABOU ; id 109
    dw MONSTER_GIANTSLUG ; id 110
    dw MONSTER_CATAPILA ; id 111
    dw MONSTER_GOPHECADA ; id 112
    dw MONSTER_BUTTERFLY ; id 113
    dw MONSTER_WEEDBUG ; id 114
    dw MONSTER_GIANTWORM ; id 115
    dw MONSTER_LIPSY ; id 116
    dw MONSTER_STAGBUG ; id 117
    dw MONSTER_ARMYANT ; id 118
    dw MONSTER_GOHOPPER ; id 119
    dw MONSTER_TAILEATER ; id 120
    dw MONSTER_ARMORPEDE ; id 121
    dw MONSTER_EYEDER ; id 122
    dw MONSTER_GIANTMOTH ; id 123
    dw MONSTER_DROLL ; id 124
    dw MONSTER_ARMYCRAB ; id 125
    dw MONSTER_MADHORNET ; id 126
    dw MONSTER_HORNBEET ; id 127
    dw MONSTER_ARMORPION ; id 128
    dw MONSTER_DIGSTER ; id 129
    dw MONSTER_PIXY ; id 130
    dw MONSTER_ARCDEMON ; id 131
    dw MONSTER_AGDEVIL ; id 132
    dw MONSTER_DEMONITE ; id 133
    dw MONSTER_DARKEYE ; id 134
    dw MONSTER_EYEBALL ; id 135
    dw MONSTER_SKULRIDER ; id 136
    dw MONSTER_EVILBEAST ; id 137
    dw MONSTER_1EYECLOWN ; id 138
    dw MONSTER_GREMLIN ; id 139
    dw MONSTER_MEDUSAEYE ; id 140
    dw MONSTER_LIONEX ; id 141
    dw MONSTER_GOATHORN ; id 142
    dw MONSTER_ORC ; id 143
    dw MONSTER_OGRE ; id 144
    dw MONSTER_GATEGUARD ; id 145
    dw MONSTER_CHOPCLOWN ; id 146
    dw MONSTER_GRENDAL ; id 147
    dw MONSTER_AKUBAR ; id 148
    dw MONSTER_MADKNIGHT ; id 149
    dw MONSTER_GIGANTES ; id 150
    dw MONSTER_CENTASAUR ; id 151
    dw MONSTER_EVILARMOR ; id 152
    dw MONSTER_JAMIRUS ; id 153
    dw MONSTER_DURRAN ; id 154
    dw MONSTER_SPOOKY ; id 155
    dw MONSTER_SKULLGON ; id 156
    dw MONSTER_PUTREPUP ; id 157
    dw MONSTER_ROTRAVEN ; id 158
    dw MONSTER_MUMMY ; id 159
    dw MONSTER_DARKCRAB ; id 160
    dw MONSTER_DEADNITE ; id 161
    dw MONSTER_SHADOW ; id 162
    dw MONSTER_HORK ; id 163
    dw MONSTER_MUDRON ; id 164
    dw MONSTER_NITEWHIP ; id 165
    dw MONSTER_MADSPIRIT ; id 166
    dw MONSTER_WINDMERGE ; id 167
    dw MONSTER_REAPER ; id 168
    dw MONSTER_DEADNOBLE ; id 169
    dw MONSTER_WHITEKING ; id 170
    dw MONSTER_BONESLAVE ; id 171
    dw MONSTER_SKELETOR ; id 172
    dw MONSTER_SERVANT ; id 173
    dw MONSTER_COPYCAT ; id 174
    dw MONSTER_JEWELBAG ; id 175
    dw MONSTER_EVILWAND ; id 176
    dw MONSTER_MADCANDLE ; id 177
    dw MONSTER_COILBIRD ; id 178
    dw MONSTER_FACER ; id 179
    dw MONSTER_SPIKYBOY ; id 180
    dw MONSTER_MADMIRROR ; id 181
    dw MONSTER_ROGUENITE ; id 182
    dw MONSTER_GOOPI ; id 183
    dw MONSTER_VOODOLL ; id 184
    dw MONSTER_METALDRAK ; id 185
    dw MONSTER_BALZAK ; id 186
    dw MONSTER_SABREMAN ; id 187
    dw MONSTER_CURSELAMP ; id 188
    dw MONSTER_ROBOSTER ; id 189
    dw MONSTER_EVILPOT ; id 190
    dw MONSTER_GISMO ; id 191
    dw MONSTER_LAVAMAN ; id 192
    dw MONSTER_ICEMAN ; id 193
    dw MONSTER_MIMIC ; id 194
    dw MONSTER_MUDDOLL ; id 195
    dw MONSTER_GOLEM ; id 196
    dw MONSTER_STONEMAN ; id 197
    dw MONSTER_BOMBCRAG ; id 198
    dw MONSTER_GOLDGOLEM ; id 199
    dw MONSTER_DRACOLORD ; id 200
    dw MONSTER_DRACOLORD_160 ; id 201
    dw MONSTER_HARGON ; id 202
    dw MONSTER_SIDOH ; id 203
    dw MONSTER_BARAMOS ; id 204
    dw MONSTER_ZOMA ; id 205
    dw MONSTER_PIZZARO ; id 206
    dw MONSTER_ESTERK ; id 207
    dw MONSTER_MIRUDRAAS ; id 208
    dw MONSTER_MIRUDRAAS_16C ; id 209
    dw MONSTER_MUDOU ; id 210
    dw MONSTER_DEATHMORE ; id 211
    dw MONSTER_DEATHMORE_16F ; id 212
    dw MONSTER_DEATHMORE_170 ; id 213
    dw MONSTER_DARKDRIUM ; id 214

; AppendSpeciesToLinkCodeByteForWordAtDE appends the byte at $6175 + species word; 384 bytes end at
; LinkSkillMapTable_B; the first two bytes are also the last word of LinkCodeToSpeciesTable's range
; end (E-0217, C1)
; record: link code for this species (0 = none)
SpeciesToLinkCodeTable::
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
    db $0a ; id 12 FangSlime
    db $0b ; id 13 RockSlime
    db $0c ; id 14 SlimeBorg
    db $0d ; id 15 Slabbit
    db $0f ; id 16 KingSlime
    db $10 ; id 17 Metaly
    db $11 ; id 18 Metabble
    db $0e ; id 19 SpotKing
    db $03 ; id 20 TropicGel
    db $0d ; id 21 MimeSlime
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
    db $1a ; id 42 Poisongon
    db $1b ; id 43 Swordgon
    db $1e ; id 44 Drygon
    db $1c ; id 45 Dragon
    db $1d ; id 46 MiniDrak
    db $1e ; id 47 MadDragon
    db $1f ; id 48 Rayburn
    db $20 ; id 49 Chamelgon
    db $21 ; id 50 LizardFly
    db $22 ; id 51 Andreal
    db $23 ; id 52 KingCobra
    db $1f ; id 53 Vampirus
    db $16 ; id 54 SnakeBat
    db $24 ; id 55 Spikerous
    db $25 ; id 56 GreatDrak
    db $26 ; id 57 Crestpent
    db $27 ; id 58 WingSnake
    db $28 ; id 59 Coatol
    db $29 ; id 60 Orochi
    db $2a ; id 61 BattleRex
    db $2b ; id 62 SkyDragon
    db $29 ; id 63 Serpentia
    db $2c ; id 64 Divinegon
    db $2a ; id 65 Orligon
    db $2a ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $2d ; id 71 Tonguella
    db $2e ; id 72 Almiraj
    db $2f ; id 73 CatFly
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
    db $3a ; id 85 Grizzly
    db $3b ; id 86 Yeti
    db $2f ; id 87 ArrowDog
    db $2d ; id 88 NoctoKing
    db $39 ; id 89 BeastNite
    db $3c ; id 90 MadGopher
    db $3d ; id 91 FairyRat
    db $3e ; id 92 Unicorn
    db $3f ; id 93 Goategon
    db $40 ; id 94 WildApe
    db $41 ; id 95 Trumpeter
    db $42 ; id 96 KingLeo
    db $43 ; id 97 DarkHorn
    db $44 ; id 98 MadCat
    db $45 ; id 99 BigEye
    db $44 ; id 100 Gorago
    db $2f ; id 101 CatMage
    db $2d ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $46 ; id 106 Picky
    db $47 ; id 107 Wyvern
    db $48 ; id 108 BullBird
    db $49 ; id 109 Florajay
    db $4a ; id 110 DuckKite
    db $4b ; id 111 MadPecker
    db $4c ; id 112 MadRaven
    db $4d ; id 113 MistyWing
    db $47 ; id 114 AquaHawk
    db $4e ; id 115 Dracky
    db $4a ; id 116 KiteHawk
    db $4f ; id 117 BigRoost
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
    db $5a ; id 141 MadPlant
    db $5b ; id 142 FireWeed
    db $5c ; id 143 FloraMan
    db $5d ; id 144 WingTree
    db $5e ; id 145 CactiBall
    db $5f ; id 146 Gulpple
    db $60 ; id 147 Toadstool
    db $61 ; id 148 AmberWeed
    db $6a ; id 149 Slurperon
    db $62 ; id 150 Stubsuck
    db $63 ; id 151 Oniono
    db $64 ; id 152 DanceVegi
    db $65 ; id 153 TreeBoy
    db $5f ; id 154 Devipine
    db $66 ; id 155 FaceTree
    db $67 ; id 156 HerbMan
    db $68 ; id 157 BeanMan
    db $69 ; id 158 EvilSeed
    db $6a ; id 159 ManEater
    db $6b ; id 160 Snapper
    db $67 ; id 161 GhosTree
    db $6c ; id 162 Rosevine
    db $6c ; id 163 Egdracil
    db $6d ; id 164 Warubou
    db $6d ; id 165 Watabou
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
    db $6e ; id 176 GiantSlug
    db $6f ; id 177 Catapila
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
    db $7a ; id 189 Eyeder
    db $7b ; id 190 GiantMoth
    db $7c ; id 191 Droll
    db $7d ; id 192 ArmyCrab
    db $7e ; id 193 MadHornet
    db $7b ; id 194 Belzebub
    db $7d ; id 195 WarMantis
    db $7f ; id 196 HornBeet
    db $75 ; id 197 Sickler
    db $80 ; id 198 Armorpion
    db $81 ; id 199 Digster
    db $80 ; id 200 Skularach
    db $7c ; id 201 MultiEyes
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
    db $8c ; id 212 MedusaEye
    db $84 ; id 213 AgDevil
    db $85 ; id 214 Demonite
    db $86 ; id 215 DarkEye
    db $87 ; id 216 EyeBall
    db $88 ; id 217 SkulRider
    db $89 ; id 218 EvilBeast
    db $8f ; id 219 Bubblemon
    db $8a ; id 220 1EyeClown
    db $8b ; id 221 Gremlin
    db $83 ; id 222 ArcDemon
    db $8d ; id 223 Lionex
    db $8e ; id 224 GoatHorn
    db $8f ; id 225 Orc
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
    db $9a ; id 238 Durran
    db $99 ; id 239 Titanis
    db $97 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $9b ; id 246 Spooky
    db $9c ; id 247 Skullgon
    db $9d ; id 248 PutrePup
    db $9e ; id 249 RotRaven
    db $9f ; id 250 Mummy
    db $a0 ; id 251 DarkCrab
    db $a1 ; id 252 DeadNite
    db $a2 ; id 253 Shadow
    db $9c ; id 254 Skulpent
    db $a3 ; id 255 Hork
    db $a4 ; id 256 Mudron
    db $a5 ; id 257 NiteWhip
    db $a7 ; id 258 WindMerge
    db $a8 ; id 259 Reaper
    db $a3 ; id 260 Inverzon
    db $ae ; id 261 FoxFire
    db $a1 ; id 262 CaptDead
    db $a9 ; id 263 DeadNoble
    db $aa ; id 264 WhiteKing
    db $ab ; id 265 BoneSlave
    db $ac ; id 266 Skeletor
    db $ad ; id 267 Servant
    db $aa ; id 268 Lazamanus
    db $ae ; id 269 Copycat
    db $a6 ; id 270 MadSpirit
    db $ae ; id 271 PomPomBom
    db $a9 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $af ; id 281 JewelBag
    db $b0 ; id 282 EvilWand
    db $b1 ; id 283 MadCandle
    db $b2 ; id 284 CoilBird
    db $b3 ; id 285 Facer
    db $b4 ; id 286 SpikyBoy
    db $b5 ; id 287 MadMirror
    db $b6 ; id 288 RogueNite
    db $c3 ; id 289 Puppetor
    db $b7 ; id 290 Goopi
    db $b8 ; id 291 Voodoll
    db $b9 ; id 292 MetalDrak
    db $ba ; id 293 Balzak
    db $bb ; id 294 SabreMan
    db $bc ; id 295 CurseLamp
    db $b1 ; id 296 Brushead
    db $bd ; id 297 Roboster
    db $bd ; id 298 Roboster2
    db $be ; id 299 EvilPot
    db $bf ; id 300 Gismo
    db $c0 ; id 301 LavaMan
    db $c1 ; id 302 IceMan
    db $c2 ; id 303 Mimic
    db $b5 ; id 304 Exaucers
    db $c3 ; id 305 MudDoll
    db $c4 ; id 306 Golem
    db $c5 ; id 307 StoneMan
    db $c6 ; id 308 BombCrag
    db $c7 ; id 309 GoldGolem
    db $c7 ; id 310 DarkMate
    db $bd ; id 311 ProtoMech
    db $bf ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $08 ; id 316 Petiteel
    db $26 ; id 317 Moray
    db $3a ; id 318 WalrusMan
    db $4a ; id 319 RayGigas
    db $5a ; id 320 Anemon
    db $78 ; id 321 Aquarella
    db $89 ; id 322 Merman
    db $be ; id 323 Octokid
    db $9c ; id 324 PutreFish
    db $06 ; id 325 Octoreach
    db $1a ; id 326 Angleron
    db $88 ; id 327 FishRider
    db $3f ; id 328 RushFish
    db $74 ; id 329 Gamanian
    db $a0 ; id 330 Clawster
    db $81 ; id 331 CancerMan
    db $bf ; id 332 RogueWave
    db $c2 ; id 333 Scallopa
    db $85 ; id 334 SeaHorse
    db $84 ; id 335 HoodSquid
    db $41 ; id 336 MerTiger
    db $2a ; id 337 AxeShark
    db $ac ; id 338 Octogon
    db $ad ; id 339 KingSquid
    db $57 ; id 340 Digong
    db $aa ; id 341 WhaleMage
    db $2b ; id 342 Aquadon
    db $98 ; id 343 Octoraid
    db $83 ; id 344 Grakos
    db $42 ; id 345 Poseidon
    db $5e ; id 346 Pumpoise
    db $84 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $c8 ; id 351 DracoLord
    db $c9 ; id 352 DracoLord
    db $c9 ; id 353 LordDraco
    db $ca ; id 354 Hargon
    db $cb ; id 355 Sidoh
    db $cb ; id 356 Genosidoh
    db $cc ; id 357 Baramos
    db $cd ; id 358 Zoma
    db $cd ; id 359 AsuraZoma
    db $ce ; id 360 Pizzaro
    db $ce ; id 361 PsychoPiz
    db $cf ; id 362 Esterk
    db $d0 ; id 363 Mirudraas
    db $d1 ; id 364 Mirudraas
    db $d2 ; id 365 Mudou
    db $d3 ; id 366 DeathMore
    db $d4 ; id 367 DeathMore
    db $d5 ; id 368 DeathMore
    db $d6 ; id 369 Darkdrium
    db $d6 ; id 370 Orgodemir
    db $d4 ; id 371 Orgodemir
    db $d2 ; id 372 Darck
    db $00 ; id 373 Tatsu
    db $00 ; id 374 Diago
    db $00 ; id 375 Samsi
    db $00 ; id 376 Bazoo
    db $00 ; id 377 ?
    db $00 ; id 378 ?
    db $00 ; id 379 ?
    db $59 ; id 380 Lamia
    db $2c ; id 381 Dimensaur
    db $6d ; id 382 Kagebou
    db $00 ; id 383 ?

; MapAndCompactSkillListLinkSkillMapTable_B, from UnpackLinkRecordToRecordBufB, maps $21 skill bytes
; through $62F5 + byte (except $FF) and compacts the lists, dropping $FE/$FF; 222 entries end at
; LinkSkillMapTable_A (E-0217, C1)
; record: mapped skill ($FE/$FF = dropped)
LinkSkillMapTable_B::
    db SKILL_BLAZE ; id 0
    db SKILL_BLAZEMORE ; id 1
    db SKILL_BLAZEMOST ; id 2
    db SKILL_FIREBAL ; id 3
    db SKILL_FIREBANE ; id 4
    db SKILL_FIREBOLT ; id 5
    db SKILL_BANG ; id 6
    db SKILL_BOOM ; id 7
    db SKILL_EXPLODET ; id 8
    db SKILL_INFERNOS ; id 9
    db SKILL_INFERMORE ; id 10
    db SKILL_INFERMOST ; id 11
    db SKILL_ICEBOLT ; id 12
    db SKILL_SNOWSTORM ; id 13
    db SKILL_BLIZZARD ; id 14
    db SKILL_BOLT ; id 15
    db SKILL_ZAP ; id 16
    db SKILL_THORDAIN ; id 17
    db SKILL_BEAT ; id 18
    db SKILL_DEFEAT ; id 19
    db SKILL_SACRIFICE ; id 20
    db SKILL_SLEEP ; id 21
    db SKILL_SLEEPALL ; id 22
    db SKILL_STOPSPELL ; id 23
    db SKILL_SURROUND ; id 24
    db SKILL_PANICALL ; id 25
    db SKILL_ROBMAGIC ; id 26
    db SKILL_TAKEMAGIC ; id 27
    db SKILL_SAP ; id 28
    db SKILL_DEFENSE ; id 29
    db SKILL_UPPER ; id 30
    db SKILL_INCREASE ; id 31
    db SKILL_SLOW ; id 32
    db SKILL_SLOWALL ; id 33
    db SKILL_SPEED ; id 34
    db SKILL_SPEEDUP ; id 35
    db SKILL_BARRIER ; id 36
    db SKILL_TWINHITS ; id 37
    db SKILL_MAGICWALL ; id 38
    db SKILL_MAGICBACK ; id 39
    db SKILL_BOUNCE ; id 40
    db SKILL_TRANSFORM ; id 41
    db SKILL_IRONIZE ; id 42
    db SKILL_HEAL ; id 43
    db SKILL_HEALMORE ; id 44
    db SKILL_HEALALL ; id 45
    db SKILL_HEALUS ; id 46
    db SKILL_HEALUSALL ; id 47
    db SKILL_VIVIFY ; id 48
    db SKILL_REVIVE ; id 49
    db SKILL_FAREWELL ; id 50
    db SKILL_ANTIDOTE ; id 51
    db SKILL_NUMBOFF ; id 52
    db SKILL_DECHAOS ; id 53
    db SKILL_CURSEOFF ; id 54
    db SKILL_STEPGUARD ; id 55
    db SKILL_MAPMAGIC ; id 56
    db SKILL_CHANCE ; id 57
    db ACTION_FIGHT ; id 58
    db SKILL_TWINSLASH ; id 59
    db SKILL_RAMMING ; id 60
    db SKILL_BERSERKER ; id 61
    db SKILL_KAMIKAZE ; id 62
    db SKILL_MASSACRE ; id 63
    db SKILL_EVILSLASH ; id 64
    db SKILL_CHARGEUP ; id 65
    db SKILL_HIGHJUMP ; id 66
    db SKILL_SUCKAIR ; id 67
    db SKILL_FIRESLASH ; id 68
    db SKILL_BOLTSLASH ; id 69
    db SKILL_VACUSLASH ; id 70
    db SKILL_ICESLASH ; id 71
    db SKILL_METALCUT ; id 72
    db SKILL_DRAKSLASH ; id 73
    db SKILL_BEASTCUT ; id 74
    db SKILL_BIRDBLOW ; id 75
    db SKILL_DEVILCUT ; id 76
    db SKILL_ZOMBIECUT ; id 77
    db SKILL_CLEANCUT ; id 78
    db SKILL_MULTICUT ; id 79
    db SKILL_BIATTACK ; id 80
    db SKILL_QUADHITS ; id 81
    db SKILL_CALLHELP ; id 82
    db SKILL_YELLHELP ; id 83
    db SKILL_FOCUS ; id 84
    db SKILL_SQUALLHIT ; id 85
    db SKILL_PSYCHEUP ; id 86
    db SKILL_RAINSLASH ; id 87
    db SKILL_WINDBEAST ; id 88
    db SKILL_VACUUM ; id 89
    db SKILL_LIGHTNING ; id 90
    db SKILL_ROCKTHROW ; id 91
    db SKILL_FIREAIR ; id 92
    db SKILL_BLAZEAIR ; id 93
    db SKILL_SCORCHING ; id 94
    db SKILL_WHITEFIRE ; id 95
    db SKILL_FRIGIDAIR ; id 96
    db SKILL_ICEAIR ; id 97
    db SKILL_ICESTORM ; id 98
    db SKILL_WHITEAIR ; id 99
    db SKILL_HELLBLAST ; id 100
    db SKILL_BIGBANG ; id 101
    db SKILL_MEGAMAGIC ; id 102
    db SKILL_POISONHIT ; id 103
    db SKILL_NAPATTACK ; id 104
    db SKILL_PARALYZE ; id 105
    db SKILL_SLEEPAIR ; id 106
    db SKILL_PALSYAIR ; id 107
    db SKILL_POISONGAS ; id 108
    db SKILL_POISONAIR ; id 109
    db SKILL_PANIDANCE ; id 110
    db SKILL_CURSE ; id 111
    db SKILL_AHHH ; id 112
    db SKILL_KODANCE ; id 113
    db SKILL_SANDSTORM ; id 114
    db SKILL_RADIANT ; id 115
    db SKILL_EERIELITE ; id 116
    db SKILL_ODDDANCE ; id 117
    db SKILL_ROBDANCE ; id 118
    db SKILL_SIDESTEP ; id 119
    db SKILL_LUREDANCE ; id 120
    db SKILL_LUSHLICKS ; id 121
    db SKILL_SICKLICK ; id 122
    db SKILL_LEGSWEEP ; id 123
    db SKILL_BIGTRIP ; id 124
    db SKILL_WARCRY ; id 125
    db SKILL_WHISTLE ; id 126
    db SKILL_IMITATE ; id 127
    db SKILL_DEMAGIC ; id 128
    db SKILL_SURGE ; id 129
    db SKILL_ULTRADOWN ; id 130
    db SKILL_THICKFOG ; id 131
    db SKILL_TATSUCALL ; id 132
    db SKILL_DIAGOCALL ; id 133
    db SKILL_SAMSICALL ; id 134
    db SKILL_BAZOOCALL ; id 135
    db SKILL_COVER ; id 136
    db SKILL_GUARDIAN ; id 137
    db SKILL_TAILWIND ; id 138
    db SKILL_STORMWIND ; id 139
    db SKILL_DODGE ; id 140
    db SKILL_DODGE ; id 141
    db SKILL_STRONGD ; id 142
    db SKILL_SUCKALL ; id 143
    db SKILL_BLADED ; id 144
    db SKILL_DANCESHUT ; id 145
    db SKILL_MOUTHSHUT ; id 146
    db SKILL_MEDITATE ; id 147
    db SKILL_HUSTLE ; id 148
    db SKILL_LIFESONG ; id 149
    db SKILL_LIFEDANCE ; id 150
    db ACTION_C8 ; id 151
    db SKILL_ZONEOUT ; id 152
    db ACTION_C0 ; id 153
    db ACTION_C1 ; id 154
    db ACTION_C2 ; id 155
    db ACTION_C3 ; id 156
    db ACTION_C4 ; id 157
    db ACTION_C5 ; id 158
    db ACTION_C6 ; id 159
    db ACTION_C7 ; id 160
    db ACTION_C8 ; id 161
    db ACTION_B0 ; id 162
    db ACTION_B1 ; id 163
    db ACTION_B2 ; id 164
    db ACTION_B3 ; id 165
    db ACTION_B4 ; id 166
    db ACTION_B5 ; id 167
    db ACTION_B6 ; id 168
    db ACTION_B7 ; id 169
    db ACTION_B8 ; id 170
    db ACTION_B9 ; id 171
    db ACTION_BA ; id 172
    db ACTION_BB ; id 173
    db ACTION_BC ; id 174
    db ACTION_BD ; id 175
    db $ff ; id 176
    db $ff ; id 177
    db $ff ; id 178
    db $ff ; id 179
    db $ff ; id 180
    db $ff ; id 181
    db $ff ; id 182
    db $ff ; id 183
    db $ff ; id 184
    db $ff ; id 185
    db $ff ; id 186
    db $ff ; id 187
    db $ff ; id 188
    db $ff ; id 189
    db $ff ; id 190
    db $ff ; id 191
    db $ff ; id 192
    db $ff ; id 193
    db $ff ; id 194
    db $ff ; id 195
    db $ff ; id 196
    db $ff ; id 197
    db $ff ; id 198
    db $ff ; id 199
    db $ff ; id 200
    db $ff ; id 201
    db $ff ; id 202
    db $ff ; id 203
    db $ff ; id 204
    db $ff ; id 205
    db $ff ; id 206
    db $ff ; id 207
    db $ff ; id 208
    db $ff ; id 209
    db $ff ; id 210
    db $ff ; id 211
    db $ff ; id 212
    db SKILL_BEDRAGON ; id 213
    db SKILL_SLIMEBLOW ; id 214
    db SKILL_BUGBLOW ; id 215
    db SKILL_SHEARS ; id 216
    db SKILL_GIGASLASH ; id 217
    db SKILL_PANICALL ; id 218
    db ACTION_C8 ; id 219
    db SKILL_IRONIZE ; id 220
    db SKILL_AHHH ; id 221

; MapAndCompactSkillListLinkSkillMapTable_A, from UnpackLinkRecordToWorkBuf, maps $21 skill bytes
; through $63D3 + byte and compacts the lists; 170 entries end at LinkBreed_DrawPanel_TileRect; for
; 155 of them LinkSkillMapTable_B maps the result back (E-0217, C1)
; record: mapped skill ($FE = dropped)
LinkSkillMapTable_A::
    db SKILL_TRANSFORM ; id 0
    db ACTION_FIGHT ; id 1
    db SKILL_BLAZE ; id 2
    db SKILL_BLAZEMORE ; id 3
    db SKILL_BLAZEMOST ; id 4
    db SKILL_FIREBAL ; id 5
    db SKILL_FIREBANE ; id 6
    db SKILL_FIREBOLT ; id 7
    db SKILL_BANG ; id 8
    db SKILL_BOOM ; id 9
    db SKILL_EXPLODET ; id 10
    db SKILL_INFERNOS ; id 11
    db SKILL_INFERMORE ; id 12
    db SKILL_THORDAIN ; id 13
    db SKILL_ICEBOLT ; id 14
    db SKILL_SNOWSTORM ; id 15
    db SKILL_INFERMOST ; id 16
    db SKILL_BOLT ; id 17
    db SKILL_ZAP ; id 18
    db SKILL_BLIZZARD ; id 19
    db SKILL_BEAT ; id 20
    db SKILL_DEFEAT ; id 21
    db SKILL_SLOW ; id 22
    db SKILL_SLOWALL ; id 23
    db SKILL_TWINHITS ; id 24
    db SKILL_SURROUND ; id 25
    db SKILL_SLEEP ; id 26
    db $fe ; id 27
    db $fe ; id 28
    db $fe ; id 29
    db SKILL_SLEEPALL ; id 30
    db SKILL_TAKEMAGIC ; id 31
    db SKILL_ROBMAGIC ; id 32
    db SKILL_STOPSPELL ; id 33
    db SKILL_IRONIZE ; id 34
    db SKILL_PANICALL ; id 35
    db SKILL_MAGICBACK ; id 36
    db SKILL_VIVIFY ; id 37
    db SKILL_REVIVE ; id 38
    db SKILL_MPASSMORE ; id 39
    db SKILL_MPASSMOST ; id 40
    db SKILL_DECHAOS ; id 41
    db SKILL_NUMBOFF ; id 42
    db SKILL_FAREWELL ; id 43
    db SKILL_ANTIDOTE ; id 44
    db SKILL_UPPER ; id 45
    db SKILL_HEALALL ; id 46
    db SKILL_SACRIFICE ; id 47
    db SKILL_HEAL ; id 48
    db SKILL_MPASS ; id 49
    db SKILL_HEALUSALL ; id 50
    db SKILL_HEALMORE ; id 51
    db SKILL_HEALUS ; id 52
    db SKILL_SPEEDUP ; id 53
    db SKILL_SAP ; id 54
    db SKILL_DEFENSE ; id 55
    db SKILL_CURSEOFF ; id 56
    db SKILL_INCREASE ; id 57
    db SKILL_SPEED ; id 58
    db ACTION_D5 ; id 59
    db SKILL_MAGICWALL ; id 60
    db SKILL_MULTICUT ; id 61
    db SKILL_RAINSLASH ; id 62
    db SKILL_QUADHITS ; id 63
    db SKILL_CLEANCUT ; id 64
    db SKILL_AQUACUT ; id 65
    db SKILL_METALCUT ; id 66
    db SKILL_POISONHIT ; id 67
    db SKILL_PARALYZE ; id 68
    db SKILL_NAPATTACK ; id 69
    db SKILL_SQUALLHIT ; id 70
    db SKILL_BIATTACK ; id 71
    db SKILL_BUGBLOW ; id 72
    db SKILL_SHEARS ; id 73
    db SKILL_DEVILCUT ; id 74
    db SKILL_ZOMBIECUT ; id 75
    db $fe ; id 76
    db $fe ; id 77
    db SKILL_BOLTSLASH ; id 78
    db SKILL_ICESLASH ; id 79
    db SKILL_FRIGIDAIR ; id 80
    db SKILL_ICESTORM ; id 81
    db SKILL_ICEAIR ; id 82
    db SKILL_WHITEAIR ; id 83
    db ACTION_D6 ; id 84
    db SKILL_VACUUM ; id 85
    db SKILL_LIGHTNING ; id 86
    db SKILL_ROCKTHROW ; id 87
    db ACTION_D7 ; id 88
    db ACTION_D8 ; id 89
    db SKILL_WATERSHOT ; id 90
    db SKILL_TIDALWAVE ; id 91
    db SKILL_CALLHELP ; id 92
    db $fe ; id 93
    db SKILL_WINDBEAST ; id 94
    db SKILL_GIGASLASH ; id 95
    db SKILL_PSYCHEUP ; id 96
    db SKILL_CHARGEUP ; id 97
    db SKILL_DRAKSLASH ; id 98
    db SKILL_FIRESLASH ; id 99
    db SKILL_VACUSLASH ; id 100
    db SKILL_BIRDBLOW ; id 101
    db SKILL_YELLHELP ; id 102
    db ACTION_D9 ; id 103
    db SKILL_BLAZEAIR ; id 104
    db SKILL_BEASTCUT ; id 105
    db SKILL_SCORCHING ; id 106
    db SKILL_FIREAIR ; id 107
    db SKILL_HELLBLAST ; id 108
    db SKILL_BEDRAGON ; id 109
    db SKILL_MEGAMAGIC ; id 110
    db SKILL_CHANCE ; id 111
    db SKILL_BIGBANG ; id 112
    db SKILL_HIGHJUMP ; id 113
    db SKILL_EVILSLASH ; id 114
    db SKILL_MASSACRE ; id 115
    db SKILL_TWINSLASH ; id 116
    db SKILL_RAMMING ; id 117
    db SKILL_CURSE ; id 118
    db SKILL_ODDDANCE ; id 119
    db SKILL_BERSERKER ; id 120
    db SKILL_SLEEPAIR ; id 121
    db SKILL_PANIDANCE ; id 122
    db SKILL_BLADED ; id 123
    db SKILL_STRONGD ; id 124
    db SKILL_ROBDANCE ; id 125
    db SKILL_PALSYAIR ; id 126
    db SKILL_POISONGAS ; id 127
    db SKILL_POISONAIR ; id 128
    db SKILL_SURGE ; id 129
    db SKILL_ULTRADOWN ; id 130
    db SKILL_EERIELITE ; id 131
    db SKILL_DEMAGIC ; id 132
    db SKILL_THICKFOG ; id 133
    db SKILL_TATSUCALL ; id 134
    db SKILL_DIAGOCALL ; id 135
    db SKILL_SAMSICALL ; id 136
    db SKILL_WHITEFIRE ; id 137
    db SKILL_SLIMEBLOW ; id 138
    db SKILL_KODANCE ; id 139
    db SKILL_LUREDANCE ; id 140
    db SKILL_LIFEDANCE ; id 141
    db SKILL_HUSTLE ; id 142
    db SKILL_KAMIKAZE ; id 143
    db SKILL_SIDESTEP ; id 144
    db $fe ; id 145
    db SKILL_GEYSER ; id 146
    db SKILL_DANCESHUT ; id 147
    db SKILL_BIGTRIP ; id 148
    db SKILL_SICKLICK ; id 149
    db SKILL_WARCRY ; id 150
    db SKILL_BAZOOCALL ; id 151
    db SKILL_SUCKAIR ; id 152
    db SKILL_FOCUS ; id 153
    db SKILL_LUSHLICKS ; id 154
    db $fe ; id 155
    db $fe ; id 156
    db SKILL_AHHH ; id 157
    db SKILL_RADIANT ; id 158
    db SKILL_MOUTHSHUT ; id 159
    db SKILL_DODGE ; id 160
    db $fe ; id 161
    db SKILL_SANDSTORM ; id 162
    db $fe ; id 163
    db SKILL_BOUNCE ; id 164
    db $fe ; id 165
    db $fe ; id 166
    db $fe ; id 167
    db $fe ; id 168
    db SKILL_BARRIER ; id 169

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
LinkBreed_DrawPanel_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
LinkBreed_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 9 x 7 tiles, one row per line
LinkBreed_DrawChoiceBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $60, $61, $62, $62, $63, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $64, $65, $66, $67, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $68, $69, $6a, $6b, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

LinkBreed_ReadChoice_Data::
    db $fc, $c3, $24, $c4, $4c, $c4
    ds $1ae4, $00
