; ROM bank $37: link sessions; strings
; The annotated listing of this bank is build/listing/bank37.asm.

SECTION "Bank 37", ROMX[$4000], BANK[$37]
    db $37

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank37::
    ld de, StringCategories_37_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_37_4016::
    dw StringList_37_401A ; id 0
    dw StringList_37_4086 ; id 1

; category list of StringCategories_37_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_37_401A::
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

StringList_37_4086::
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

RunLinkSession5Exchange_Case01_WaitFadeState::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    jumptable
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

RunLinkSession5Exchange_Case01_Sub01_ToSwapMonstersMenuAndStep::
    farcall SwapMonstersMenu
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags::
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

RunLinkSession5Exchange_Case01_Sub01_WaitTextFlags_Case05::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $03
    ld [wLinkSendByte], a
    ld hl, wScreenState
    inc [hl]
    ret

RunLinkSession5Exchange_Case01_Sub01_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $03
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wScreenState], a
    ret

RunLinkSession5Exchange_Case01_Sub01_SetScreenState::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wTitleScreenState
    inc [hl]
    ret

; text waits around two strings (ShowStringIndexA_Bank37)
RunLinkSession5Exchange_ShowMessages::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession5Exchange_ShowMessages_WaitTextFlags
    dw RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37_Case01
    dw RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37
    dw RunLinkSession5Exchange_ShowMessages_WaitTextFlags_Case03

RunLinkSession5Exchange_ShowMessages_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37_Case01::
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

RunLinkSession5Exchange_ShowMessages_ShowStringIndexA_Bank37::
    xor a
    ld [wLinkSendByte], a
    ld a, $09
    call ShowStringIndexA_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowMessages_WaitTextFlags_Case03::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: BreedMenu list steps, unpacks the partner's record from the link
; (UnpackLinkRecordToRecordBufB), ComputeBreedingChild and StoreReceivedRecordIntoSRAM
RunLinkSession5Exchange_LinkBreed::
    ld a, [wScreenStep]
    jumptable
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0E::
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37::
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

RunLinkSession5Exchange_LinkBreed_BreedMenu::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

RunLinkSession5Exchange_LinkBreed_BreedMenu_Case10::
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

RunLinkSession5Exchange_Case01_Sub01_Table2_Case00::
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

RunLinkSession5Exchange_Case01_Sub01_Table2_Case01::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

RunLinkSession5Exchange_Case01_Sub01_Table2_Case02::
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

RunLinkSession5Exchange_Case01_Sub01_Table2_Case03::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    xor a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

RunLinkSession5Exchange_Case01_Sub01_Table2_Case09::
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case0C::
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
    ld de, Tiles1Plus6E0Tiles_1F_4510
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4450
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wScreenSubStep], a
    ret

RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5::
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
    ld de, TileRect_37_647D
    ld hl, wWindowTileBuffer + $6c
    ld bc, $0c05
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

RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case0F::
    ld a, [wTextFlags]
    and a
    ret nz

; runs CopyScreenBufferRectWithAttrs_37 (C = 5, HL = $0278, DE = $00AC, wArg1/2 = 0/8), wScreenStep
; += 1 and clears wSelectedRecord (E-0122)
RunFunc5A5DAt0278AndStep::
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

RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5_Case11::
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

RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToWorkBuf::
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
    call UnpackLinkRecordToWorkBuf
    ld a, $07
    call ShowStringIndexA_Bank37
    call RunFunc5A5DAt0278AndStep
    call BGMapAddressAtScroll_Bank37
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ret

RunLinkSession5Exchange_LinkBreed_WaitTextFlags_Case13::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

RunLinkSession5Exchange_LinkBreed_WriteLinkBufferCountLoAndLinkBufferCountHiEtc::
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case14::
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

RunLinkSession5Exchange_LinkBreed_UnpackLinkRecordToRecordBufB::
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case16::
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

RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild::
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
    cp b
    jr z, .loop
    jp RunLinkSession5Exchange_LinkBreed_WriteLinkBufferCountLoAndLinkBufferCountHiEtc

RunLinkSession5Exchange_LinkBreed_CopyRectToScreenBufferAndClearAttributes_37::
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
    ld de, TileRect_37_64D7
    ld hl, wWindowTileBuffer + $e7
    ld bc, $0907
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_handle_three_choice_cursor_input_37
    call RunFunc5A5DAt024FAndDrawBox
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
    call RunFunc5A5DAt024FAndDrawBox
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
    ld hl, RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox_Data
    call StoreBAtWordTableEntry_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $0c
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
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $0d
    ld [wScreenState], a
    ret

RunLinkSession5Exchange_LinkBreed_CopyFromBankWaitVRAM::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles2 + $720
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wTwoChoiceCursor], a
    ld de, TileRect_37_64B9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectToScreenBufferAndClearAttributes_37
    call BGMapAddressAtScroll_Bank37
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_LinkBreed_UpdateTwoChoiceCursor_Bank1D::
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

; when text is idle and not linking: copies the $A5-byte received record at wChildRecord into the
; record slot at WD789 cell 5 and resets the save counters (E-0128)
StoreReceivedRecordIntoSRAM::
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

RunLinkSession5Exchange_LinkBreed_ShowStringIndexA_Bank37_Case1C::
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
    jp RunLinkSession5Exchange_LinkBreed_ComputeBreedingChild

RunLinkSession5Exchange_LinkBreed_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $fd
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jr RunLinkSession5Exchange_LinkBreed_WaitTextFlags

RunLinkSession5Exchange_LinkBreed_WaitLinkMessage_Case21::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $0a
    ld [wScreenStep], a
    jr RunLinkSession5Exchange_LinkBreed_WaitTextFlags

RunLinkSession5Exchange_LinkBreed_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a

; waits for the text, then for the partner's link message
RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner::
    ld a, [wScreenSubStep]
    jumptable
    dw RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitTextFlags
    dw RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitLinkMessage

RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitTextFlags::
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

RunLinkSession5Exchange_LinkBreed_WaitTextThenPartner_WaitLinkMessage::
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

RunLinkSession5Exchange_LinkBreed_WriteLinkSendByteAndLinkSceneByte4BEtc::
    ld a, [wLinkMessage]
    cp $f0
    jr z, .clear_link_send_byte
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkSceneByte4B], a
    ld a, $01
    ld [wLinkByteEB], a
    ret

RunLinkSession5Exchange_Case01_Sub01_SwapMonstersMenu::
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

; as RunScreenStateWhenNotFading_F1_ShowChosenRecord
RunLinkSession5Exchange_ShowChosenRecord::
    ld a, [wScreenStep]
    jumptable
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

RunLinkSession5Exchange_ShowChosenRecord_ToBreedMenu::
    farcall BreedMenu
    ret

RunLinkSession5Exchange_ShowChosenRecord_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ShowString0EBank0EAtTiles2700AndLoadTiles, then wScreenStep += 1 (E-0122)
ShowString0EAndStep_Bank37::
    farcall ShowString0EBank0EAtTiles2700AndLoadTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowChosenRecord_FillTilesFromRequest::
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

RunLinkSession5Exchange_ShowChosenRecord_SetArg5ToListEntriesCell5::
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

; by wScreenStep: the stats screens of record buffer B, as
; RunScreenStateWhenNotFading_F1_ShowRecordStats
RunLinkSession5Exchange_ShowRecordStats::
    ld a, [wScreenStep]
    jumptable
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

RunLinkSession5Exchange_ShowRecordStats_Return::
    ret

RunLinkSession5Exchange_ShowRecordStats_ToClearBGMapAndLoadFrameTilesAndStep::
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_ShowString10Bank0EAtTiles2020ThenDefault::
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    farcall LoadSixteenGlyphTilesFromTable73BC
    call DrawWCA2CNameAtTiles1500

RunLinkSession5Exchange_ShowRecordStats_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears 5 tiles at vTiles1 + $500 and draws the name at wRecordBufB + $1 there (E-0122)
DrawWCA2CNameAtTiles1500::
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

RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37::
    call BGMapAddressAtScroll_Bank37
    ld de, TileRect_1F_687F
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

RunLinkSession5Exchange_ShowRecordStats_ToDrawRecordBufBStatsScreenAndStep::
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_ToDrawWCA36MonsterPictureInTwoSteps::
    farcall DrawWCA36MonsterPictureInTwoSteps
    ret

RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor::
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
    ld de, TileRect_1F_651B
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

RunLinkSession5Exchange_ShowRecordStats_FillTileRectWithArg1Tile::
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

RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest::
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

RunLinkSession5Exchange_ShowRecordStats_FillTilesFromRequest_Case0F::
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

RunLinkSession5Exchange_ShowRecordStats_DrawWCA2CNameAndWCA36String_Bank37::
    call DrawWCA2CNameAndWCA36String_Bank37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case11::
    call BGMapAddressAtScroll_Bank37
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_6577
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

RunLinkSession5Exchange_ShowRecordStats_ShowPersonalityNameAndWCA3AName::
    farcall ShowPersonalityNameAndWCA3AName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

RunLinkSession5Exchange_ShowRecordStats_DrawFamilyIconAndCountForWCA38::
    ld a, $6d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld a, $ea
    ld [wArg3], a
    ld a, $c7
    ld [wArg4], a
    farcall DrawFamilyIconAndCountForWCA38
    farcall DrawWCA83ExpAndToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

RunLinkSession5Exchange_ShowRecordStats_DecompressGraphicsArg1ToArg4::
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
    farcall ShowWCACFCategory11StringAtTiles2320
    call BGMapAddressAtScroll_Bank37
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_66DF
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

RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case15::
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
    farcall DrawRects662BAnd653F
    ld a, $04
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81::
    farcall DrawLevelAndStatusRowForWCA81
    ld a, $0f
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_ToDrawRects6B4FAnd6C27AndStep::
    farcall DrawRects6B4FAnd6C27
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_ClearTilesAndDrawRects6C5FAnd6D37::
    farcall ClearTilesAndDrawRects6C5FAnd6D37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_ShowRecordBufBSkillNamesOrNone::
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

RunLinkSession5Exchange_ShowRecordStats_ShowSpeciesCategory13StringAtTiles2680::
    farcall ShowSpeciesCategory13StringAtTiles2680
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case1B::
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
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call UploadTilesFromData58AE
    farcall DrawSummaryFrames6E47And6D6F
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_DrawRects5E13And66DF::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_show_string10_bank0_e_at_tiles2020_then
    farcall DrawRects5E13And66DF
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

RunLinkSession5Exchange_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D::
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

RunLinkSession5Exchange_ShowRecordStats_DrawTileRectAtHLFromDE_Bank37_Case1E::
    call BGMapAddressAtScroll_Bank37
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_63D7
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

RunLinkSession5Exchange_ShowRecordStats_RunF24C3DAnd4D72::
    farcall RunF24C3DAnd4D72
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ShowRecordStats_UpdatePagedListCursor_Case20::
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

; as RunScreenStateWhenNotFading_F1_ResetListAndShowString
RunLinkSession5Exchange_ResetListAndShowString::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession5Exchange_ResetListAndShowString_SetListCursor
    dw ShowString0EAndStep_Bank37
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu
    dw RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ShowChosenRecord_FillTilesFromRequest
    dw RunLinkSession5Exchange_ShowChosenRecord_SetArg5ToListEntriesCell5
    dw RunLinkSession5Exchange_ResetListAndShowString_CallCopyRectToScreenBufferAndClearAttributes_37
    dw RunLinkSession5Exchange_ResetListAndShowString_BreedMenu_Case09

RunLinkSession5Exchange_ResetListAndShowString_SetListCursor::
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession5Exchange_ResetListAndShowString_BreedMenu_Case09::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

RunLinkSession5Exchange_ResetListAndShowString_BreedMenu::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

RunLinkSession5Exchange_ResetListAndShowString_CallCopyRectToScreenBufferAndClearAttributes_37::
    ld de, TileRect_37_64D7
    ld hl, wWindowTileBuffer + $e7
    ld bc, $0907
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

; wArg1/2 = the species wRecordBufB + $B/7, wArg3-6 = $00, $90, $40, $00, then far-calls
; DrawMetaSpritePartC0 (E-0122)
DrawWCA36SpritePart::
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

; copies tiles from Tiles_37_58AE: two to vTiles2 + $6E0 and three to vTiles2 + $7C0
; (CopyTileBytesToVRAM_Bank37) (E-0118)
UploadTilesFromData58AE::
    ld hl, Tiles_37_58AE
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
Tiles_37_58AE::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $ff ; entry 0
    db $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 1
    db $ff, $ff, $ff, $ff, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 2
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $ff, $ff, $ff ; entry 3
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 4

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
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

; draws the name at wRecordBufB + $1 at vTiles1 + $780 and shows string [wRecordBufB + $B] of
; category [wRecordBufB + $C] + 2 at vTiles1 + $270 with size $0109 (E-0124)
DrawWCA2CNameAndWCA36String_Bank37::
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

; runs CopyScreenBufferRectWithAttrs_37 (C = 7, HL = $024F, DE = $0083, wArg1/2 = 0/9), then draws
; the box at scroll + $1CC (E-0122)
RunFunc5A5DAt024FAndDrawBox::
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
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_37
    ret

; wStringIndex = A (wStringCategory unchanged), then far-calls BeginStringDisplay_Bank0E (E-0066)
ShowStringIndexA_Bank37::
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0E
    ret

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

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_Bank37::
    ld b, $bb
    jr DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank37::
    ld b, $c3
    jr DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor

; B = $BC, then writes B at the scroll position +
; DrawArrowTileBCAtTwoChoiceEntry_Bank37_Data[wTwoChoiceCursor] (E-0124)
DrawArrowTileBCAtTwoChoiceEntry_Bank37::
    ld b, $bc

DrawArrowTileBCAtTwoChoiceEntry_Bank37_ReadTwoChoiceCursor::
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, DrawArrowTileBCAtTwoChoiceEntry_Bank37_Data
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

DrawArrowTileBCAtTwoChoiceEntry_Bank37_Data::
    db $ec, $00, $2c, $01, $6c, $01

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

; unpacks the received partner record at wRecordBufA into wWorkBuf: names, species, family, parents,
; skills and scaled stats (E-0129)
UnpackLinkRecordToWorkBuf::
    ld hl, wWorkBuf
    ld de, wRecordBufA
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesFromLinkFormat
    call AppendSpeciesToLinkCodeByteForWordAtDE
    call FamilyNibbleOrSpeciesFamily
    ld a, [de]
    and $01
    ld [hli], a
    inc de
    call ConvertNameBytesFromLinkFormat
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
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hli], a
    inc de

.call_map_and_compact_skill_list_link_skill:
    call MapAndCompactSkillListLinkSkillMapTable_A
    ld b, $12
    call CopyBBytesHLToDE_Bank37
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
    call CopyBBytesHLToDE_Bank37
    ld a, $00
    ld [hli], a
    inc de
    ld a, [wLinkRules]
    cp $ff
    jr nz, .call_convert_name_bytes_from_link_format
    call WriteUnknownNameEntry_5CC8
    jr .call_load_table555_d_entry_for_wd0_a6_to_link

.call_convert_name_bytes_from_link_format:
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertNameBytesFromLinkFormat
    ld a, [de]
    ld [hl], a

.call_load_table555_d_entry_for_wd0_a6_to_link:
    farcall LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes
    ret

; unpacks the received record at wBattlerRecordSlot1 + $F into wRecordBufB: names, species ids from
; LinkCodeToSpeciesTable, family, parents, skills and scaled stats (E-0127)
UnpackLinkRecordToRecordBufB::
    ld hl, wRecordBufB
    ld de, wBattlerRecordSlot1 + BATTLER_SKILLS + 1
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertEightBytesAndPadF0
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
    call ConvertEightBytesAndPadF0
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
    call CallFunc4001InBank81KeepRegs
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hli], a
    inc de
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hli], a
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
    ld [hli], a
    inc de
    call ConvertEightBytesAndPadF0
    ld a, [de]
    ld [hli], a
    ld [hl], $00
    farcall LoadTable4E60EntryForWCA36ToWCA83
    ret

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

; calls WriteUnknownNamePlaceholder_Bank37 and falls into it again (E-0126)
WriteUnknownNameEntry_5CC8::
    call WriteUnknownNamePlaceholder_Bank37

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

; copies B bytes from HL to DE; HL and DE advance, B = 0 (E-0115)
CopyBBytesHLToDE_Bank37::
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, CopyBBytesHLToDE_Bank37
    ret

ConvertEightBytesAndPadF0_Cp5C::
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

; converts 8 name bytes at DE to the game's glyphs ($0A-$3D + $1A, special marks $93-$95, $AB, $B5),
; padding after the fourth with $F0 (E-0127)
ConvertNameBytesFromLinkFormat::
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

; converts 8 bytes from DE through ConvertEightBytesAndPadF0_Cp5C into HL, then appends two $F0
; bytes (E-0122)
ConvertEightBytesAndPadF0::
    ld b, $08

.loop:
    ld a, [de]
    call ConvertEightBytesAndPadF0_Cp5C
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [hli], a
    ld [hli], a
    ret

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

; reads a word at DE: $01FF becomes 999, otherwise word * $C3 / 100 rounded up; stores it at HL and
; continues with the next word (ScaleStatWordsForDisplay_5F78) (E-0125)
ScaleStatWordsForDisplay_5F4A::
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
    call ScaleStatWordsForDisplay_5F78

; reads a word at DE: $00FF becomes 999, otherwise word * $5B / 100 rounded up plus 3 * word; stores
; it at HL (E-0125)
ScaleStatWordsForDisplay_5F78::
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

; copies $1A bytes (CopyBBytesHLToDE_Bank37), then appends wSpeciesRecord + $2C as the 27th byte
; (E-0115)
Copy26BytesThenWD034::
    ld b, $1a
    call CopyBBytesHLToDE_Bank37
    ld a, [wSpeciesRecord + SPECIES_RESISTANCES + 26]
    ld [hli], a
    inc de
    ret

; far-calls CallFunc4001InBank81KeepRegs_WriteAIWeightsAndSpeciesIdLoEtc, preserving all registers
; (E-0122)
CallFunc4001InBank81KeepRegs::
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

; FamilyNibbleOrSpeciesFamily reads the word at $5FC7 + 2 * code to look up a species' family while
; UnpackLinkRecordToWorkBuf unpacks a record; for all 215 codes, SpeciesToLinkCodeTable[species]
; gives the code back (C2 for the pairing) (E-0217, C1)
; record: species for this link code
LinkCodeToSpeciesTable::
    dw $0001 ; id 0 DrakSlime
    dw $0002 ; id 1 SpotSlime
    dw $0003 ; id 2 WingSlime
    dw $0004 ; id 3 TreeSlime
    dw $0005 ; id 4 Snaily
    dw $0006 ; id 5 SlimeNite
    dw $0007 ; id 6 Babble
    dw $0008 ; id 7 BoxSlime
    dw $000a ; id 8 Slime
    dw $000b ; id 9 Healer
    dw $000c ; id 10 FangSlime
    dw $000d ; id 11 RockSlime
    dw $000e ; id 12 SlimeBorg
    dw $000f ; id 13 Slabbit
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
    dw $002a ; id 26 Poisongon
    dw $002b ; id 27 Swordgon
    dw $002d ; id 28 Dragon
    dw $002e ; id 29 MiniDrak
    dw $002f ; id 30 MadDragon
    dw $0030 ; id 31 Rayburn
    dw $0031 ; id 32 Chamelgon
    dw $0032 ; id 33 LizardFly
    dw $0033 ; id 34 Andreal
    dw $0034 ; id 35 KingCobra
    dw $0037 ; id 36 Spikerous
    dw $0038 ; id 37 GreatDrak
    dw $0039 ; id 38 Crestpent
    dw $003a ; id 39 WingSnake
    dw $003b ; id 40 Coatol
    dw $003c ; id 41 Orochi
    dw $003d ; id 42 BattleRex
    dw $003e ; id 43 SkyDragon
    dw $0040 ; id 44 Divinegon
    dw $0047 ; id 45 Tonguella
    dw $0048 ; id 46 Almiraj
    dw $0049 ; id 47 CatFly
    dw $004a ; id 48 PillowRat
    dw $004b ; id 49 Saccer
    dw $004c ; id 50 GulpBeast
    dw $004d ; id 51 Skullroo
    dw $004e ; id 52 WindBeast
    dw $0050 ; id 53 Antbear
    dw $0051 ; id 54 SuperTen
    dw $0052 ; id 55 IronTurt
    dw $0053 ; id 56 Mommonja
    dw $0054 ; id 57 HammerMan
    dw $0055 ; id 58 Grizzly
    dw $0056 ; id 59 Yeti
    dw $005a ; id 60 MadGopher
    dw $005b ; id 61 FairyRat
    dw $005c ; id 62 Unicorn
    dw $005d ; id 63 Goategon
    dw $005e ; id 64 WildApe
    dw $005f ; id 65 Trumpeter
    dw $0060 ; id 66 KingLeo
    dw $0061 ; id 67 DarkHorn
    dw $0062 ; id 68 MadCat
    dw $0063 ; id 69 BigEye
    dw $006a ; id 70 Picky
    dw $006b ; id 71 Wyvern
    dw $006c ; id 72 BullBird
    dw $006d ; id 73 Florajay
    dw $006e ; id 74 DuckKite
    dw $006f ; id 75 MadPecker
    dw $0070 ; id 76 MadRaven
    dw $0071 ; id 77 MistyWing
    dw $0073 ; id 78 Dracky
    dw $0075 ; id 79 BigRoost
    dw $0076 ; id 80 StubBird
    dw $0077 ; id 81 LandOwl
    dw $0078 ; id 82 MadGoose
    dw $0079 ; id 83 MadCondor
    dw $007b ; id 84 Blizzardy
    dw $007c ; id 85 Phoenix
    dw $007d ; id 86 ZapBird
    dw $007f ; id 87 WhipBird
    dw $0080 ; id 88 FunkyBird
    dw $0081 ; id 89 RainHawk
    dw $008d ; id 90 MadPlant
    dw $008e ; id 91 FireWeed
    dw $008f ; id 92 FloraMan
    dw $0090 ; id 93 WingTree
    dw $0091 ; id 94 CactiBall
    dw $0092 ; id 95 Gulpple
    dw $0093 ; id 96 Toadstool
    dw $0094 ; id 97 AmberWeed
    dw $0096 ; id 98 Stubsuck
    dw $0097 ; id 99 Oniono
    dw $0098 ; id 100 DanceVegi
    dw $0099 ; id 101 TreeBoy
    dw $009b ; id 102 FaceTree
    dw $009c ; id 103 HerbMan
    dw $009d ; id 104 BeanMan
    dw $009e ; id 105 EvilSeed
    dw $009f ; id 106 ManEater
    dw $00a0 ; id 107 Snapper
    dw $00a2 ; id 108 Rosevine
    dw $00a5 ; id 109 Watabou
    dw $00b0 ; id 110 GiantSlug
    dw $00b1 ; id 111 Catapila
    dw $00b2 ; id 112 Gophecada
    dw $00b3 ; id 113 Butterfly
    dw $00b4 ; id 114 WeedBug
    dw $00b5 ; id 115 GiantWorm
    dw $00b6 ; id 116 Lipsy
    dw $00b7 ; id 117 StagBug
    dw $00b9 ; id 118 ArmyAnt
    dw $00ba ; id 119 GoHopper
    dw $00bb ; id 120 TailEater
    dw $00bc ; id 121 ArmorPede
    dw $00bd ; id 122 Eyeder
    dw $00be ; id 123 GiantMoth
    dw $00bf ; id 124 Droll
    dw $00c0 ; id 125 ArmyCrab
    dw $00c1 ; id 126 MadHornet
    dw $00c4 ; id 127 HornBeet
    dw $00c6 ; id 128 Armorpion
    dw $00c7 ; id 129 Digster
    dw $00d3 ; id 130 Pixy
    dw $00de ; id 131 ArcDemon
    dw $00d5 ; id 132 AgDevil
    dw $00d6 ; id 133 Demonite
    dw $00d7 ; id 134 DarkEye
    dw $00d8 ; id 135 EyeBall
    dw $00d9 ; id 136 SkulRider
    dw $00da ; id 137 EvilBeast
    dw $00dc ; id 138 1EyeClown
    dw $00dd ; id 139 Gremlin
    dw $00d4 ; id 140 MedusaEye
    dw $00df ; id 141 Lionex
    dw $00e0 ; id 142 GoatHorn
    dw $00e1 ; id 143 Orc
    dw $00e2 ; id 144 Ogre
    dw $00e3 ; id 145 GateGuard
    dw $00e4 ; id 146 ChopClown
    dw $00e6 ; id 147 Grendal
    dw $00e7 ; id 148 Akubar
    dw $00e8 ; id 149 MadKnight
    dw $00ea ; id 150 Gigantes
    dw $00eb ; id 151 Centasaur
    dw $00ec ; id 152 EvilArmor
    dw $00ed ; id 153 Jamirus
    dw $00ee ; id 154 Durran
    dw $00f6 ; id 155 Spooky
    dw $00f7 ; id 156 Skullgon
    dw $00f8 ; id 157 PutrePup
    dw $00f9 ; id 158 RotRaven
    dw $00fa ; id 159 Mummy
    dw $00fb ; id 160 DarkCrab
    dw $00fc ; id 161 DeadNite
    dw $00fd ; id 162 Shadow
    dw $00ff ; id 163 Hork
    dw $0100 ; id 164 Mudron
    dw $0101 ; id 165 NiteWhip
    dw $010e ; id 166 MadSpirit
    dw $0102 ; id 167 WindMerge
    dw $0103 ; id 168 Reaper
    dw $0107 ; id 169 DeadNoble
    dw $0108 ; id 170 WhiteKing
    dw $0109 ; id 171 BoneSlave
    dw $010a ; id 172 Skeletor
    dw $010b ; id 173 Servant
    dw $010d ; id 174 Copycat
    dw $0119 ; id 175 JewelBag
    dw $011a ; id 176 EvilWand
    dw $011b ; id 177 MadCandle
    dw $011c ; id 178 CoilBird
    dw $011d ; id 179 Facer
    dw $011e ; id 180 SpikyBoy
    dw $011f ; id 181 MadMirror
    dw $0120 ; id 182 RogueNite
    dw $0122 ; id 183 Goopi
    dw $0123 ; id 184 Voodoll
    dw $0124 ; id 185 MetalDrak
    dw $0125 ; id 186 Balzak
    dw $0126 ; id 187 SabreMan
    dw $0127 ; id 188 CurseLamp
    dw $0129 ; id 189 Roboster
    dw $012b ; id 190 EvilPot
    dw $012c ; id 191 Gismo
    dw $012d ; id 192 LavaMan
    dw $012e ; id 193 IceMan
    dw $012f ; id 194 Mimic
    dw $0131 ; id 195 MudDoll
    dw $0132 ; id 196 Golem
    dw $0133 ; id 197 StoneMan
    dw $0134 ; id 198 BombCrag
    dw $0135 ; id 199 GoldGolem
    dw $015f ; id 200 DracoLord
    dw $0160 ; id 201 DracoLord
    dw $0162 ; id 202 Hargon
    dw $0163 ; id 203 Sidoh
    dw $0165 ; id 204 Baramos
    dw $0166 ; id 205 Zoma
    dw $0168 ; id 206 Pizzaro
    dw $016a ; id 207 Esterk
    dw $016b ; id 208 Mirudraas
    dw $016c ; id 209 Mirudraas
    dw $016d ; id 210 Mudou
    dw $016e ; id 211 DeathMore
    dw $016f ; id 212 DeathMore
    dw $0170 ; id 213 DeathMore
    dw $0171 ; id 214 Darkdrium

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
    db $01 ; id 0
    db $02 ; id 1
    db $03 ; id 2
    db $04 ; id 3
    db $05 ; id 4
    db $06 ; id 5
    db $07 ; id 6
    db $08 ; id 7
    db $09 ; id 8
    db $0a ; id 9
    db $0b ; id 10
    db $0c ; id 11
    db $10 ; id 12
    db $11 ; id 13
    db $12 ; id 14
    db $0d ; id 15
    db $0e ; id 16
    db $0f ; id 17
    db $13 ; id 18
    db $14 ; id 19
    db $15 ; id 20
    db $2f ; id 21
    db $30 ; id 22
    db $33 ; id 23
    db $2e ; id 24
    db $34 ; id 25
    db $32 ; id 26
    db $31 ; id 27
    db $27 ; id 28
    db $28 ; id 29
    db $25 ; id 30
    db $26 ; id 31
    db $2b ; id 32
    db $2c ; id 33
    db $29 ; id 34
    db $2a ; id 35
    db $38 ; id 36
    db $2d ; id 37
    db $39 ; id 38
    db $36 ; id 39
    db $37 ; id 40
    db $3a ; id 41
    db $35 ; id 42
    db $16 ; id 43
    db $17 ; id 44
    db $18 ; id 45
    db $19 ; id 46
    db $1a ; id 47
    db $1e ; id 48
    db $1f ; id 49
    db $20 ; id 50
    db $21 ; id 51
    db $23 ; id 52
    db $22 ; id 53
    db $24 ; id 54
    db $a4 ; id 55
    db $a9 ; id 56
    db $3c ; id 57
    db $00 ; id 58
    db $6d ; id 59
    db $6f ; id 60
    db $6e ; id 61
    db $70 ; id 62
    db $6c ; id 63
    db $6b ; id 64
    db $68 ; id 65
    db $6a ; id 66
    db $89 ; id 67
    db $50 ; id 68
    db $52 ; id 69
    db $51 ; id 70
    db $53 ; id 71
    db $5e ; id 72
    db $55 ; id 73
    db $56 ; id 74
    db $57 ; id 75
    db $5a ; id 76
    db $5b ; id 77
    db $5c ; id 78
    db $66 ; id 79
    db $63 ; id 80
    db $64 ; id 81
    db $4e ; id 82
    db $4f ; id 83
    db $8a ; id 84
    db $62 ; id 85
    db $69 ; id 86
    db $65 ; id 87
    db $48 ; id 88
    db $49 ; id 89
    db $4a ; id 90
    db $4b ; id 91
    db $40 ; id 92
    db $41 ; id 93
    db $42 ; id 94
    db $43 ; id 95
    db $44 ; id 96
    db $45 ; id 97
    db $46 ; id 98
    db $47 ; id 99
    db $3f ; id 100
    db $3e ; id 101
    db $3d ; id 102
    db $5f ; id 103
    db $61 ; id 104
    db $60 ; id 105
    db $71 ; id 106
    db $72 ; id 107
    db $73 ; id 108
    db $74 ; id 109
    db $78 ; id 110
    db $75 ; id 111
    db $8f ; id 112
    db $79 ; id 113
    db $7e ; id 114
    db $7f ; id 115
    db $80 ; id 116
    db $76 ; id 117
    db $77 ; id 118
    db $7d ; id 119
    db $7a ; id 120
    db $8b ; id 121
    db $8c ; id 122
    db $8d ; id 123
    db $8e ; id 124
    db $90 ; id 125
    db $a2 ; id 126
    db $9e ; id 127
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
    db $9a ; id 139
    db $95 ; id 140
    db $95 ; id 141
    db $94 ; id 142
    db $9d ; id 143
    db $96 ; id 144
    db $92 ; id 145
    db $93 ; id 146
    db $9f ; id 147
    db $7c ; id 148
    db $a0 ; id 149
    db $7b ; id 150
    db $c8 ; id 151
    db $ab ; id 152
    db $c0 ; id 153
    db $c1 ; id 154
    db $c2 ; id 155
    db $c3 ; id 156
    db $c4 ; id 157
    db $c5 ; id 158
    db $c6 ; id 159
    db $c7 ; id 160
    db $c8 ; id 161
    db $b0 ; id 162
    db $b1 ; id 163
    db $b2 ; id 164
    db $b3 ; id 165
    db $b4 ; id 166
    db $b5 ; id 167
    db $b6 ; id 168
    db $b7 ; id 169
    db $b8 ; id 170
    db $b9 ; id 171
    db $ba ; id 172
    db $bb ; id 173
    db $bc ; id 174
    db $bd ; id 175
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
    db $3b ; id 213
    db $54 ; id 214
    db $58 ; id 215
    db $59 ; id 216
    db $67 ; id 217
    db $34 ; id 218
    db $c8 ; id 219
    db $35 ; id 220
    db $8f ; id 221

; MapAndCompactSkillListLinkSkillMapTable_A, from UnpackLinkRecordToWorkBuf, maps $21 skill bytes
; through $63D3 + byte and compacts the lists; 170 entries end at TileRect_37_647D; for 155 of them
; LinkSkillMapTable_B maps the result back (E-0217, C1)
; record: mapped skill ($FE = dropped)
LinkSkillMapTable_A::
    db $3a ; id 0
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
    db $0a ; id 11
    db $0b ; id 12
    db $0f ; id 13
    db $10 ; id 14
    db $11 ; id 15
    db $0c ; id 16
    db $0d ; id 17
    db $0e ; id 18
    db $12 ; id 19
    db $13 ; id 20
    db $14 ; id 21
    db $2b ; id 22
    db $2c ; id 23
    db $2d ; id 24
    db $2e ; id 25
    db $2f ; id 26
    db $fe ; id 27
    db $fe ; id 28
    db $fe ; id 29
    db $30 ; id 30
    db $31 ; id 31
    db $32 ; id 32
    db $33 ; id 33
    db $35 ; id 34
    db $34 ; id 35
    db $36 ; id 36
    db $1e ; id 37
    db $1f ; id 38
    db $1c ; id 39
    db $1d ; id 40
    db $22 ; id 41
    db $23 ; id 42
    db $20 ; id 43
    db $21 ; id 44
    db $25 ; id 45
    db $18 ; id 46
    db $15 ; id 47
    db $16 ; id 48
    db $1b ; id 49
    db $1a ; id 50
    db $17 ; id 51
    db $19 ; id 52
    db $2a ; id 53
    db $27 ; id 54
    db $28 ; id 55
    db $24 ; id 56
    db $26 ; id 57
    db $29 ; id 58
    db $d5 ; id 59
    db $39 ; id 60
    db $66 ; id 61
    db $65 ; id 62
    db $64 ; id 63
    db $5c ; id 64
    db $5d ; id 65
    db $5e ; id 66
    db $5f ; id 67
    db $60 ; id 68
    db $61 ; id 69
    db $62 ; id 70
    db $63 ; id 71
    db $58 ; id 72
    db $59 ; id 73
    db $5a ; id 74
    db $5b ; id 75
    db $fe ; id 76
    db $fe ; id 77
    db $52 ; id 78
    db $53 ; id 79
    db $44 ; id 80
    db $46 ; id 81
    db $45 ; id 82
    db $47 ; id 83
    db $d6 ; id 84
    db $49 ; id 85
    db $4a ; id 86
    db $4b ; id 87
    db $d7 ; id 88
    db $d8 ; id 89
    db $4c ; id 90
    db $4d ; id 91
    db $4e ; id 92
    db $fe ; id 93
    db $48 ; id 94
    db $67 ; id 95
    db $69 ; id 96
    db $68 ; id 97
    db $55 ; id 98
    db $50 ; id 99
    db $51 ; id 100
    db $57 ; id 101
    db $4f ; id 102
    db $d9 ; id 103
    db $41 ; id 104
    db $56 ; id 105
    db $42 ; id 106
    db $40 ; id 107
    db $3f ; id 108
    db $3b ; id 109
    db $3d ; id 110
    db $3c ; id 111
    db $3e ; id 112
    db $6a ; id 113
    db $6b ; id 114
    db $6c ; id 115
    db $6d ; id 116
    db $6f ; id 117
    db $75 ; id 118
    db $76 ; id 119
    db $6e ; id 120
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
    db $7a ; id 140
    db $7b ; id 141
    db $7c ; id 142
    db $70 ; id 143
    db $7d ; id 144
    db $fe ; id 145
    db $91 ; id 146
    db $92 ; id 147
    db $8e ; id 148
    db $8c ; id 149
    db $90 ; id 150
    db $88 ; id 151
    db $89 ; id 152
    db $8a ; id 153
    db $8b ; id 154
    db $fe ; id 155
    db $fe ; id 156
    db $8f ; id 157
    db $7f ; id 158
    db $93 ; id 159
    db $95 ; id 160
    db $fe ; id 161
    db $7e ; id 162
    db $fe ; id 163
    db $37 ; id 164
    db $fe ; id 165
    db $fe ; id 166
    db $fe ; id 167
    db $fe ; id 168
    db $38 ; id 169

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
TileRect_37_647D::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
TileRect_37_64B9::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 9 x 7 tiles, one row per line
TileRect_37_64D7::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $60, $61, $62, $62, $63, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $64, $65, $66, $67, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $68, $69, $6a, $6b, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

RunLinkSession5Exchange_LinkBreed_RunFunc5A5DAt024FAndDrawBox_Data::
    db $fc, $c3, $24, $c4, $4c, $c4
    ds $1ae4, $00
