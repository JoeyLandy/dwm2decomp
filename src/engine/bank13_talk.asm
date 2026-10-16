; ROM bank $13: talk events: messages by region (GreatLog, Norden and others), chests
; The annotated listing of this bank is build/listing/bank13.asm.

SECTION "Bank 13", ROMX
    db $13

; Starts message word HL through script command $09: wScriptParam0 = L, wScriptParam1 = H,
; wModeState = 1, wScriptCommandType = 9, wScriptRunning = 1, wScriptStep = 0 and
; wScriptStartRequest = 0 (the $80 stored to it first is overwritten). Command 9 shows the message
; by the same group dispatch as ShowMessageHL. Most talk handlers of this bank end with it. (C2,
; E-0377)
; starts a message through script command $09 (message word HL, shown by the same group dispatch as
; ShowMessageHL when wMessageMode = 0): HL is stored in wScriptParam0 (low) and wScriptParam1
; (high); then wModeState = 1, wScriptCommandType = 9, wScriptRunning = 1, wScriptStep = 0 and
; wScriptStartRequest = 0 (an earlier store of $80 to wScriptStartRequest is overwritten)
StartMessageCommand09HL_B13::
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $09
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

SECTION "Bank 13 StartTreasureFlagDE_B13", ROMX

; Starts a one-time treasure through script command $0A (RunOneTimeTreasure): DE = the story flag,
; stored in wMessageIndex (low) and wMessageGroup (high), which that command tests and sets; the
; caller has put the kind in wScriptParam0 and the item in wScriptParam1. Then wModeState = 1,
; wScriptCommandType = $0A, wScriptRunning = 1, wScriptStep = 0 and wScriptStartRequest = 0 (the $80
; stored to it first is overwritten). The chest and vase handlers of this bank call it. (C2, E-0377)
; starts script command $0A (RunOneTimeTreasure) with DE = the treasure's story flag, stored in
; wMessageIndex/wMessageGroup (which that command passes to TestFlagBit and SetFlagBit; it is not a
; message word, correcting E-0081); then wScriptCommandType = $0A, wScriptRunning = 1, wScriptStep =
; 0 (E-0269)
StartTreasureFlagDE_B13::
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $0a
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

SECTION "Bank 13 StartScriptAtHL_B13", ROMX

; Starts the event script at HL: wScriptPointerLo/Hi = HL, wScriptStartRequest = $80 and wModeState
; = 1, so the script engine starts fetching there; wScriptRunning and wScriptStep are not touched.
; The talk handlers of this bank that run a script call it. (C2, E-0377)
; HL is stored in wScriptPointerLo/Hi; then wScriptStartRequest = $80 and wModeState = 1, so the
; script engine starts fetching at HL (E-0082)
StartScriptAtHL_B13::
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ret

SECTION "Bank 13 DispatchTalkEvent", ROMX

; Starts the talk event: in a special map type (bit 7 set; not types $80, $82, $84-$86, nor $83 on a
; key-world floor of kind 6, nor talk event 9) it requests script start $80 and mode state 1; there
; talk group $FD becomes event 9 group 1, and any other group runs script command 9 with the floor's
; state byte for that group as parameter. Otherwise jumps by wTalkEventIndex to the talk-event table
; of the area (field, GreatLog, Kalka, Yold, Norden, Fhunt, Darck, the elf village, the traveler
; events, key worlds, readable things). (C1, E-0357)
DispatchTalkEvent::
    ld a, [wMapType]
    bit 7, a
    jp z, .read_talk_event_index
    ld a, [wTalkEventIndex]
    cp $09
    jp z, .read_talk_event_index
    ld a, [wMapType]
    cp $80
    jp z, .read_talk_event_index
    cp $82
    jp z, .read_talk_event_index
    cp $84
    jp z, .read_talk_event_index
    cp $85
    jp z, .read_talk_event_index
    cp $86
    jp z, .read_talk_event_index
    cp $83
    jr nz, .set_script_start_request_to_80
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $06
    jr z, .read_talk_event_index

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $2
    add_a_to_hl
    ld a, [wTalkEventGroup]
    cp $fd
    jr nz, .skip
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $01
    ld [wTalkEventGroup], a
    jr .read_talk_event_index

.skip:
    push af
    pop af
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    xor a
    ld [wScriptParam1], a
    ld a, $09
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

.read_talk_event_index:
    ld a, [wTalkEventIndex]
    jumptable
    dw DispatchTalkEvent_Field
    dw GreatLogTalkEvents
    dw DispatchTalkEvent_Kalka
    dw DispatchTalkEvent_Yold
    dw NordenTalkEvents
    dw FhuntTalkEvents
    dw DispatchTalkEvent_Darck
    dw DispatchTalkEvent_ElvenVillage
    dw Talk_TravelerEvent
    dw DispatchTalkEvent_KeyWorld
    dw DispatchTalkEvent_Readable

; Talk category 0: the field events (FieldTalkEvents). (C2, E-0357; probed E-0377)
DispatchTalkEvent_Field::
    farcall FieldTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_Readable", ROMX

; Talk category $0A: notices and bookshelves (ReadableTalkEvents). (C1, E-0357)
DispatchTalkEvent_Readable::
    farcall ReadableTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_ElvenVillage", ROMX

; Talk category 7: the Elven village world (ElvenVillageTalkEvents). (C2, E-0357; probed E-0377)
DispatchTalkEvent_ElvenVillage::
    farcall ElvenVillageTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_KeyWorld", ROMX

; Talk category 9: the key worlds (KeyWorldTalkEvents). (C2, E-0357; probed E-0377)
DispatchTalkEvent_KeyWorld::
    farcall KeyWorldTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_Darck", ROMX

; Talk category 6: Darck's talk (DarckTalkEvents). (C2, E-0357; probed E-0377)
DispatchTalkEvent_Darck::
    farcall DarckTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_Kalka", ROMX

; Talk category 2: the Kalka oasis world (KalkaTalkEvents). (C1, E-0357)
DispatchTalkEvent_Kalka::
    farcall KalkaTalkEvents
    ret

SECTION "Bank 13 DispatchTalkEvent_Yold", ROMX

; Talk category 3: Yold, Polona and Port Ritz (YoldTalkEvents). (C2, E-0357; probed E-0377)
DispatchTalkEvent_Yold::
    farcall YoldTalkEvents
    ret

SECTION "Bank 13 FhuntTalkEvents", ROMX

; Talk category 5 (entry 5 of DispatchTalkEvent): jumps by wTalkEventGroup through 115 entries to
; the talk handlers of Fhunt village, Pei, the Castle of Hitano and the places around them (messages
; mostly $0400-$04AF); entry $71 is a zero word (an unused index) and entry $72 is
; ToggleMapBetween7FAnd92. There is no range check. (C2, E-0377)
; talk category 5: jumps by wTalkEventGroup to the talk handlers of Fhunt village and Pei (messages
; $0400-$04AF)
FhuntTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw TalkMsg0400_ThisIsTheVillageOfFhunt
    dw TalkMsg0401_TheGreatSageUgorSavedThe
    dw TalkMsg0402_YouveComeAllThisWay
    dw TalkMsg0403_TheGreatSageAfterSavingThe
    dw TalkMsg0404_YoureNotAboutToGoAfter
    dw TalkMsg0405_SomeTimeAgoLightningStruck
    dw TalkMsg0407_ASuspensionBridgeIsInThe
    dw TalkMsg0406_NobodyCanDefyTheOrbsBearer
    dw TalkMsg0408_AHugeBirdPerchesAtopThe
    dw TalkMsg0409_TheTowersGateIsTightlySealed
    dw TalkMsg040A_TheTopOfTheTowerCollapsed
    dw Talk_HowMayWeServeYourMortal
    dw TalkMsg040E_HeroCheckedTheGraveTheTombstone
    dw FhuntTalkEvents_Grave
    dw Talk_WelcomeToOurInn
    dw FhuntTalkEvents_ShowBeGoneIfYour
    dw ChestItem_ExitBell_Flag00A1
    dw TalkMsg0413_HeroCheckedTheTreasureChest
    dw ChestItem_Cleric_Flag00A2
    dw ChestMagicKey
    dw Talk_Kweeeeh
    dw FhuntTalkEvents_ShowHeroCheckedBehindThe
    dw FhuntTalkEvents_Sleeper
    dw TalkMsg041E_ThisIsTheTownOfPei
    dw TalkMsg041F_NyaTravelersThatsRare
    dw TalkMsg0420_ToTheWestIsAMountain
    dw TalkMsg0421_YouShouldStayWellClearOf
    dw TalkMsg0422_ICameCloseToBeingAbducted
    dw TalkMsg0423_SomeTimeAgoAHumanChild
    dw TalkMsg0424_ThereWasntAMonsterKingFor
    dw TalkMsg0425_TheNewMonsterKingMakesOthers
    dw FhuntTalkEvents_AreYouAMonster
    dw TalkMsg042A_ThisIsJustARumorBut
    dw TalkMsg042B_TheTunnelInTheWestWill
    dw TalkMsg042C_AreYouLookingForSomething
    dw Talk_HowMayWeServeYourMortal_2
    dw FhuntTalkEvents_Shop
    dw TalkMsg0430_HeroPeeredIntoTheVaseIt
    dw TalkMsg04AA_HeroReadTheSignDetermine
    dw TalkMsg0DD3_InnDownstairsRoomsAvailable
    dw Talk_WelcomeToTheTravelersInn
    dw FhuntTalkEvents_GiantBird
    dw FhuntTalkEvents_ShowWhenIPassedToo
    dw TalkMsg0436_HeroOpenedTheTreasureChest
    dw ChestItem_WorldDew_Flag00AA
    dw TalkMsg0437_ThisIsTheCastleOfHitano
    dw TalkMsg0438_AMonsterKingHasAppearedTo
    dw Talk_IveLivedHereFor200
    dw TalkMsg043C_TheCastleIsUnderTheMonster
    dw TalkMsg043E_TheCaveToTheSouthThat
    dw TalkMsg043F_TheNewMonsterKingIsSaid
    dw TalkMsg0440_HardlyNoOneHasSeenThe
    dw FhuntTalkEvents_SoldierThreeItems
    dw FhuntTalkEvents_SoldierThreeItems2
    dw TalkMsg0445_IfYouHaveTheLightOrbYou
    dw TalkMsg0446_IfIHadTheLightOrbEven
    dw Talk_WantToKnowTheMostFundamental
    dw TalkMsg044A_HearMeOutIfYouWish
    dw FhuntTalkEvents_Shop2
    dw Talk_HowMayOurChurchHelpYou
    dw TalkMsg044D_HeroReadTheSignTheFinder
    dw TalkMsg0450_HeroPeeredIntoTheVaseA
    dw TalkMsg0314_HeroTriedToOpenTheChest
    dw Talk_WelcomeToTheTravelersInn_13
    dw TalkMsg0452_TheChangeStaffWillOpenPaths
    dw TalkMsg0453_HeyKiddoYoureNewHereDont
    dw TalkMsg0454_HeyKiddoYoureNewHereDont
    dw TalkMsg0455_HeyKiddoYoureNewHereDont
    dw TalkMsg0457_OnTheIslandToTheWest
    dw TalkMsg0458_ToTheEastIsASuspension
    dw TalkMsg0459_ThoseInsideTheHauntedCastle
    dw FhuntTalkEvents_ShowHeroCheckedTheSmall
    dw ChestItem_SilvrCape_Flag00AB
    dw ChestItem_Heaven
    dw FhuntTalkEvents_YouCanTakeThis
    dw ChestItem_Heaven_Flag00AF
    dw FhuntTalkEvents_PowerOfJustice
    dw TalkMsg0462_HeroCheckedTheNoticeLayThe
    dw Talk_SceneJustice
    dw TalkMsg04A8_WhereIsMyCasketWhereRing
    dw TalkMsg04A9_HeroCheckedTheNoticeGuide
    dw Talk_SceneGravestone
    dw TalkMsg0463_HeroCheckedTheNoticeFollow
    dw TalkMsg040E_HeroCheckedTheGraveTheTombstone_13
    dw FhuntTalkEvents_GravestoneButton
    dw FhuntTalkEvents_YouOvercameTheTraps
    dw ChestItem_Heaven_Flag00B5
    dw TalkMsg046D_TheMonsterArmysGeneralIs
    dw TalkMsg046E_OurKingsCastleIsAnInvincible
    dw TalkMsg046F_WhatYouveGotTheThree
    dw FhuntTalkEvents_Mayor
    dw VaseItem_TinyMedal_Flag0200
    dw Talk_SceneFoundMeBattle
    dw Talk_Kweeeeeh
    dw TalkMsg0DE2_HeroCheckedTheTombstoneThere
    dw TalkMsg0476_AwaarghImLateImLateThey
    dw TalkMsg0477_TheyKeepPilingOnTheseLudicrous
    dw TalkMsg0478_GaahYouFoundMeWhileI
    dw ChestItem_WorldDew_Flag00BC
    dw TalkMsg0450_HeroPeeredIntoTheVaseA_13
    dw ChestItem_Thief_Flag00BD
    dw ChestItem_Bolt
    dw ChestItem_SteelFang_Flag00BF
    dw FhuntTalkEvents_Fwahahaha
    dw Talk_KamehaSoItWasYouWho
    dw Talk_ThisWayHereHere
    dw FhuntTalkEvents_Sound
    dw TalkMsg04A6_IWasTakingAWalkOutside
    dw TalkMsg04A4_SouthBeyondTheMountainsIs
    dw TalkMsg04A5_SeveralAncientRuinsRemain
    dw FhuntTalkEvents_PowerOfJustice2
    dw FhuntTalkEvents_PowerOfJustice3
    dw TalkMsg0413_HeroCheckedTheTreasureChest_13
    dw $0000 ; unused index (E-0207)
    dw ToggleMapBetween7FAnd92

; Fhunt talk group $00 (FhuntTalkEvents): starts message $0400 (with 'This is the village of
; Fhunt.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0400 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the village of Fhunt. We' (E-0268, the E-0082 shape; was
; TalkMsg0400_ThisIsTheVillageOfFhunt)
TalkMsg0400_ThisIsTheVillageOfFhunt::
    ld hl, $0400 ; '*: This is the village of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0401_TheGreatSageUgorSavedThe", ROMX

; Fhunt talk group $01 (FhuntTalkEvents): starts message $0401 (with 'The Great Sage Ugor saved the
; world') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0401 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Great Sage Ugor saved the world' (E-0268, the E-0082 shape; was
; TalkMsg0401_TheGreatSageUgorSavedThe)
TalkMsg0401_TheGreatSageUgorSavedThe::
    ld hl, $0401 ; '*: The Great Sage Ugor saved'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0402_YouveComeAllThisWay", ROMX

; Fhunt talk group $02 (FhuntTalkEvents): starts message $0402 (with 'time to pay your respect to
; Ugor.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0402 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'You've come all this way, take' (E-0268, the E-0082 shape; was TalkMsg0402_YouveComeAllThisWay)
; (E-0324: was TalkMsg0402_YouveComeAllThisWay; read before $42 was known as 'v)
TalkMsg0402_YouveComeAllThisWay::
    ld hl, $0402 ; '*: You've come all this way,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0403_TheGreatSageAfterSavingThe", ROMX

; Fhunt talk group $03 (FhuntTalkEvents): starts message $0403 (with 'The Great Sage, after saving
; the world,') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the
; message word). (C2, E-0377)
; starts message $0403 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Great Sage, after saving the world,' (E-0268, the E-0082 shape; was
; TalkMsg0403_TheGreatSageAfterSavingThe)
TalkMsg0403_TheGreatSageAfterSavingThe::
    ld hl, $0403 ; '*: The Great Sage, after saving'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0404_YoureNotAboutToGoAfter", ROMX

; Fhunt talk group $04 (FhuntTalkEvents): starts message $0404 (with 'I suggest you lose that
; thought now.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the
; message word). (C2, E-0377)
; starts message $0404 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'You're not about to go after the' (E-0268, the E-0082 shape; was
; TalkMsg0404_YoureNotAboutToGoAfter)
TalkMsg0404_YoureNotAboutToGoAfter::
    ld hl, $0404 ; '*: You're not about to go'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0405_SomeTimeAgoLightningStruck", ROMX

; Fhunt talk group $05 (FhuntTalkEvents): message $0492 (with 'Some time ago, lightning struck')
; once EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0405 (with 'Some time ago, lightning
; struck the tower,'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0405_SomeTimeAgoLightningStruck.call_start_message_command09_hl_b13); starts message $0405
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Some time ago,
; lightning struck the tower,' (E-0268, the E-0082 shape; was
; TalkMsg0405_SomeTimeAgoLightningStruck)
TalkMsg0405_SomeTimeAgoLightningStruck::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0405 ; '*: Some time ago, lightning struck'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0492 ; '*: Some time ago, lightning struck'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0407_ASuspensionBridgeIsInThe", ROMX

; Fhunt talk group $06 (FhuntTalkEvents): starts message $0407 (with 'A suspension bridge is in the
; south,') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0407 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'A suspension bridge is in the south,' (E-0268, the E-0082 shape; was
; TalkMsg0407_ASuspensionBridgeIsInThe)
TalkMsg0407_ASuspensionBridgeIsInThe::
    ld hl, $0407 ; '*: A suspension bridge is in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0406_NobodyCanDefyTheOrbsBearer", ROMX

; Fhunt talk group $07 (FhuntTalkEvents): starts message $0406 (with 'Nobody can defy the Orb')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $0406 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Nobody can defy the Orb's bearer. It' (E-0268, the E-0082 shape; was
; TalkMsg0406_NobodyCanDefyTheOrbsBearer)
TalkMsg0406_NobodyCanDefyTheOrbsBearer::
    ld hl, $0406 ; '*: Nobody can defy the Orb's'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0408_AHugeBirdPerchesAtopThe", ROMX

; Fhunt talk group $08 (FhuntTalkEvents): message $0D2C (with 'That giant bird') once
; EVENT_SCENE_THREE_ITEMS is set; otherwise message $0408 (with 'A huge bird perches atop the
; tower'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 0024 then jr c,
; TalkMsg0408_AHugeBirdPerchesAtopThe.call_start_message_command09_hl_b13); starts message $0408
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'A huge bird perches
; atop the tower' (E-0268, the E-0082 shape; was TalkMsg0408_AHugeBirdPerchesAtopThe)
TalkMsg0408_AHugeBirdPerchesAtopThe::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0408 ; '*: A huge bird perches atop'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d2c ; '*: That giant bird hasn't flown'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0409_TheTowersGateIsTightlySealed", ROMX

; Fhunt talk group $09 (FhuntTalkEvents): starts message $0409 (with 'is tightly sealed. Anyone with
; any trace of wildness is kept out of the tower by magic.') through StartMessageCommand09HL_B13
; (script command $09; wScriptParam0/1 = the message word). (C2, E-0377)
; starts message $0409 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The tower's gate is tightly sealed. Anyone' (E-0268, the E-0082 shape; was
; TalkMsg0409_TheTowersGateIsTightlySealed)
TalkMsg0409_TheTowersGateIsTightlySealed::
    ld hl, $0409 ; '*: The tower's gate is tightly'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg040A_TheTopOfTheTowerCollapsed", ROMX

; Fhunt talk group $0A (FhuntTalkEvents): message $0D2D (with 'Was that bird going after') once
; EVENT_SCENE_THREE_ITEMS is set; else message $0414 (with 'What? What? What happened?') once
; EVENT_SCENE_MADCONDOR is set; otherwise message $040A (with 'The top of the tower collapsed
; when'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 0024 then jr c,
; TalkMsg040A_TheTopOfTheTowerCollapsed.call_start_message_command09_hl_b132; flag 00A4 then jr c,
; TalkMsg040A_TheTopOfTheTowerCollapsed.call_start_message_command09_hl_b13); starts message $040A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The top of the tower
; collapsed when' (E-0268, the E-0082 shape; was TalkMsg040A_TheTopOfTheTowerCollapsed)
TalkMsg040A_TheTopOfTheTowerCollapsed::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MADCONDOR
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $040a ; '*: The top of the tower'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0414 ; '*: What? What? What happened? I'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0d2d ; '*: Was that bird going after'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HowMayWeServeYourMortal", ROMX

; Fhunt talk group $0B (FhuntTalkEvents): sets wDataBank = $1F, then starts Script_HowMayWeServe
; with StartScriptAtHL_B13 (its first message has 'How may we serve your mortal'). (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayWeServe (StartScriptAtHL_B13); its first message
; begins 'How may we serve your mortal' (E-0271; was Talk_HowMayWeServeYourMortal) (E-0344: the
; address in its name dropped or read as the label there; was Talk_HowMayWeServeYourMortal;
; shortened from TalkScript_HowMayWeServeYourMortal)
; starts Script_HowMayWeServe: '*: How may we serve your' (E-0248)
Talk_HowMayWeServeYourMortal::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayWeServe ; script '*: How may we serve your'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg040E_HeroCheckedTheGraveTheTombstone", ROMX

; Fhunt talk group $0C (FhuntTalkEvents): starts message $040E (with '0 checked the grave. The
; tombstone was') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the
; message word). (C2, E-0377)
; starts message $040E through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the grave. The tombstone was' (E-0268, the E-0082 shape; was
; TalkMsg040E_HeroCheckedTheGraveTheTombstone)
TalkMsg040E_HeroCheckedTheGraveTheTombstone::
    ld hl, $040e ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Grave", ROMX

; Fhunt talk group $0D (wTalkEventGroup): checking the grave starts Script_HeroCheckedTheGrave ('0
; checked the grave. There was', SCRIPT_SCENE_GRAVE, then sets EVENT_SCENE_GRAVE) the first time,
; and Script_HeroCheckedTheGrave_2 (the same message and scene without the flag) once
; EVENT_SCENE_GRAVE is set. (C2, E-0370; probed E-0377)
; starts Script_HeroCheckedTheGrave: '0 checked the grave. There was' (E-0248)
FhuntTalkEvents_Grave::
    ld de, EVENT_SCENE_GRAVE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_HeroCheckedTheGrave ; script '0 checked the grave. There was'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HeroCheckedTheGrave_2 ; script '0 checked the grave. There was'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_WelcomeToOurInn", ROMX

; Fhunt talk group $0E (FhuntTalkEvents): sets wDataBank = $10, then starts Script_WelcomeToOurInn_9
; with StartScriptAtHL_B13 (its first message has 'Welcome to our inn!'). (C2, E-0377)
; sets wDataBank = $10, then starts Script_WelcomeToOurInn_9 (StartScriptAtHL_B13); its first
; message begins 'Welcome to our inn!' (E-0271; was Talk_WelcomeToOurInn) (E-0344: the address in
; its name dropped or read as the label there; was Talk_WelcomeToOurInn; shortened from
; TalkScript_WelcomeToOurInn)
; starts Script_WelcomeToOurInn_9: '*: Welcome to our inn!' (E-0248)
Talk_WelcomeToOurInn::
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeToOurInn_9 ; script '*: Welcome to our inn!'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_ShowBeGoneIfYour", ROMX

; Fhunt talk group $0F, the voice at the grave: does nothing when the screen buffer entry
; wScreenTileBuffer + $D2 (row 10, column 10) is tile $68; otherwise far-calls
; FhuntTalkEvents_PartyIsTame and starts Script_FineYou ('Fine!') when every party member without
; MON_STATUS bit 7 has a MON_WLD of 0 (and the party is not empty), otherwise message $0410 ('Be
; gone! If your soul'). (C2, E-0377)
FhuntTalkEvents_ShowBeGoneIfYour::
    ld a, [wScreenTileBuffer + $d2]
    cp $68
    ret z
    farcall FhuntTalkEvents_PartyIsTame
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_script_at_hl_b13
    ld hl, $0410 ; '*: …Be gone! If your soul'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_FineYou ; script '*: …Fine! You've done well to'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_ExitBell_Flag00A1", ROMX

; Fhunt talk group $10 (FhuntTalkEvents), a one-time treasure chest: wScriptParam0 = 0 (the kind),
; wScriptParam1 = $2A and DE = story flag $00A1, then StartTreasureFlagDE_B13 (script command $0A);
; while the flag is clear that command gives item $2A (ExitBell) and sets the flag (message $A0 of
; group 0; $A1 when the flag is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $00A1 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag00A1)
ChestItem_ExitBell_Flag00A1::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $00a1
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0413_HeroCheckedTheTreasureChest", ROMX

; Fhunt talk group $11 (FhuntTalkEvents): starts message $0413 (with '0 checked the treasure chest.
; The chest') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0413 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the treasure chest. The chest' (E-0268, the E-0082 shape; was
; TalkMsg0413_HeroCheckedTheTreasureChest)
TalkMsg0413_HeroCheckedTheTreasureChest::
    ld hl, $0413 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_Cleric_Flag00A2", ROMX

; Fhunt talk group $12 (FhuntTalkEvents), a one-time treasure chest: wScriptParam0 = 0 (the kind),
; wScriptParam1 = $61 and DE = story flag $00A2, then StartTreasureFlagDE_B13 (script command $0A);
; while the flag is clear that command gives item $61 (Cleric) and sets the flag (message $A0 of
; group 0; $A1 when the flag is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $61, story flag $00A2 in DE: when the flag is clear it gives item $61 (Cleric) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Cleric_Flag00A2)
ChestItem_Cleric_Flag00A2::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $00a2
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestMagicKey", ROMX

; Fhunt talk group $13 (FhuntTalkEvents), a one-time treasure chest: wScriptParam0 = 3 (the kind),
; wScriptParam1 = $00 and DE = story flag $00A3, then StartTreasureFlagDE_B13 (script command $0A);
; while the flag is clear that command gives a Magic Key (GenerateNewKeyEntry) and sets the flag
; (message $A9 of group 0; $AA when the flag is already set, $AB when there is no room). (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 3 (kind) and wScriptParam1 =
; $00, story flag $00A3 in DE: when the flag is clear it gives a Magic Key (GenerateNewKeyEntry) and
; sets the flag (message $A9 of group 0; $AA when the flag is already set, $AB when there is no
; room) (E-0269; was ChestMagicKey)
ChestMagicKey::
    ld a, $03
    ld [wScriptParam0], a
    ld a, $00
    ld [wScriptParam1], a
    ld de, $00a3
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 Talk_Kweeeeh", ROMX

; Fhunt talk group $14 (FhuntTalkEvents): starts Script_Kweeeeh with StartScriptAtHL_B13 (its first
; message has 'Kweeeeh!'). (C2, E-0377)
; starts Script_Kweeeeh (StartScriptAtHL_B13); its first message begins 'Kweeeeh!' (E-0271; was
; Talk_Kweeeeh) (E-0344: the address in its name dropped or read as the label there; was
; Talk_Kweeeeh; shortened from TalkScript_Kweeeeh)
; starts Script_Kweeeeh: '*: Kweeeeh!' (E-0248)
Talk_Kweeeeh::
    ld hl, Script_Kweeeeh ; script '*: Kweeeeh!'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_ShowHeroCheckedBehindThe", ROMX

; Fhunt talk 21, behind the grave: after agreeing at the grave (EVENT_SCENE_GRAVE_0A6) gives item
; $35 (the Change Staff) when the bag has room and sets EVENT_HERO_CHECKED_BEHIND_THE (message
; $041A), says the bag is full ($041B), or after it 'There ...' ($04A2). (C2, E-0357; probed E-0377)
FhuntTalkEvents_ShowHeroCheckedBehindThe::
    ld de, EVENT_SCENE_GRAVE_0A6
    call TestFlagBit
    ret nc
    ld de, EVENT_HERO_CHECKED_BEHIND_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, .call_start_message_command09_hl_b13
    ld [hl], $35
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, $041a ; '0 checked behind the grave. The'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HERO_CHECKED_BEHIND_THE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $041b ; '0 checked behind the grave. The'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $04a2 ; '0 checked behind the grave. There'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Sleeper", ROMX

; Fhunt talk 22: asleep ($0DF8) after EVENT_HM_YOURE_FROM_THE_VILLAGE; to a player disguised as a
; monster (hPlayerSpriteOverride bit 7, bit 0 clear) standing at X $50 'Hm? You're from the
; village!' ($041D), elsewhere the script of that name, which sets the flag; otherwise 'Hm? You're a
; stranger!' ($041C). (C2, E-0357; probed E-0377)
FhuntTalkEvents_Sleeper::
    ld de, EVENT_HM_YOURE_FROM_THE_VILLAGE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .call_start_message_command09_hl_b13
    and $01
    jr z, .check_sprite_slots

.call_start_message_command09_hl_b13:
    ld hl, $041c ; '*: Hm? You're a stranger! You'
    call StartMessageCommand09HL_B13
    ret

.check_sprite_slots:
    ld a, [wSpriteSlots + $b]
    cp $50
    jr z, .call_start_message_command09_hl_b132
    ld hl, Script_HmYou ; script '*: Hm? You're from the village!'
    call StartScriptAtHL_B13
    ld de, EVENT_HM_YOURE_FROM_THE_VILLAGE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $041d ; '*: Hm? You're from the village!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0df8 ; '*: ZZZZZ… Ssss… ZZZZZ… Ssss…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg041E_ThisIsTheTownOfPei", ROMX

; Fhunt talk group $17 (FhuntTalkEvents): starts message $041E (with 'This is the town of Pei.')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $041E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the town of Pei. You'll' (E-0268, the E-0082 shape; was TalkMsg041E_ThisIsTheTownOfPei)
TalkMsg041E_ThisIsTheTownOfPei::
    ld hl, $041e ; '*: This is the town of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg041F_NyaTravelersThatsRare", ROMX

; Fhunt talk group $18 (FhuntTalkEvents): starts message $041F (with 'Nya? Travelers?') through
; StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2, E-0377)
; starts message $041F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Nya? Travelers? That's rare!' (E-0268, the E-0082 shape; was TalkMsg041F_NyaTravelersThatsRare)
TalkMsg041F_NyaTravelersThatsRare::
    ld hl, $041f ; '*: Nya? Travelers? That's rare!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0420_ToTheWestIsAMountain", ROMX

; Fhunt talk group $19 (FhuntTalkEvents): starts message $0420 (with 'To the west is a mountain.')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $0420 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'To the west is a mountain. A' (E-0268, the E-0082 shape; was TalkMsg0420_ToTheWestIsAMountain)
TalkMsg0420_ToTheWestIsAMountain::
    ld hl, $0420 ; '*: To the west is a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0421_YouShouldStayWellClearOf", ROMX

; Fhunt talk group $1A (FhuntTalkEvents): starts message $0421 (with 'You should stay well clear of
; the') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0421 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'You should stay well clear of the' (E-0268, the E-0082 shape; was
; TalkMsg0421_YouShouldStayWellClearOf)
TalkMsg0421_YouShouldStayWellClearOf::
    ld hl, $0421 ; '*: You should stay well clear'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0422_ICameCloseToBeingAbducted", ROMX

; Fhunt talk group $1B (FhuntTalkEvents): message $0D2E (with 'They say the giant bird') once
; EVENT_SCENE_THREE_ITEMS is set; otherwise message $0422 (with 'I came close to being abducted
; by'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 0024 then jr c,
; TalkMsg0422_ICameCloseToBeingAbducted.call_start_message_command09_hl_b13); starts message $0422
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I came close to
; being abducted by' (E-0268, the E-0082 shape; was TalkMsg0422_ICameCloseToBeingAbducted)
TalkMsg0422_ICameCloseToBeingAbducted::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0422 ; '*: I came close to being'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d2e ; '*: They say the giant bird'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0423_SomeTimeAgoAHumanChild", ROMX

; Fhunt talk group $1C (FhuntTalkEvents): message $0D2F (with 'The giant bird took off') once
; EVENT_SCENE_THREE_ITEMS is set; otherwise message $0423 (with 'Some time ago, a human child was'),
; each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 0024 then jr c,
; TalkMsg0423_SomeTimeAgoAHumanChild.call_start_message_command09_hl_b13); starts message $0423
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Some time ago, a
; human child was' (E-0268, the E-0082 shape; was TalkMsg0423_SomeTimeAgoAHumanChild)
TalkMsg0423_SomeTimeAgoAHumanChild::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0423 ; '*: Some time ago, a human'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d2f ; '*: The giant bird took off'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0424_ThereWasntAMonsterKingFor", ROMX

; Fhunt talk group $1D (FhuntTalkEvents): message $0494 (with 'I heard on my travels') once
; EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0424 (with 'a new king appeared recently to
; take the vacant throne.'), each through StartMessageCommand09HL_B13 (script command $09). (C2,
; E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0424_ThereWasntAMonsterKingFor.call_start_message_command09_hl_b13); starts message $0424
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'There wasn't a
; monster king for a' (E-0268, the E-0082 shape; was TalkMsg0424_ThereWasntAMonsterKingFor)
TalkMsg0424_ThereWasntAMonsterKingFor::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0424 ; '*: There wasn't a monster king'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0494 ; '*: I heard on my travels'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0425_TheNewMonsterKingMakesOthers", ROMX

; Fhunt talk group $1E (FhuntTalkEvents): message $0495 (with 'The monster King disappeared.') once
; EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0425 (with 'The new monster king makes
; others obey'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0425_TheNewMonsterKingMakesOthers.call_start_message_command09_hl_b13); starts message
; $0425 through StartMessageCommand09HL_B13 (script command $09); that string begins 'The new
; monster king makes others obey' (E-0268, the E-0082 shape; was
; TalkMsg0425_TheNewMonsterKingMakesOthers)
TalkMsg0425_TheNewMonsterKingMakesOthers::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0425 ; '*: The new monster king makes'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0495 ; '*: The monster King disappeared. He'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_AreYouAMonster", ROMX

; Fhunt talk 31: 'You... Are you a monster?' in one of two scripts, the second for a player
; disguised as a monster. (C2, E-0357; probed E-0377)
FhuntTalkEvents_AreYouAMonster::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .call_start_script_at_hl_b13
    and $01
    jr z, .call_start_script_at_hl_b132

.call_start_script_at_hl_b13:
    ld hl, Script_YouAreYouA ; script '*: You… Are you a monster?'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_YouAreYouA_2 ; script '*: You… Are you a monster?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg042A_ThisIsJustARumorBut", ROMX

; Fhunt talk group $20 (FhuntTalkEvents): starts message $042A (with 'This is just a rumor, but
; the') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $042A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is just a rumor, but the' (E-0268, the E-0082 shape; was TalkMsg042A_ThisIsJustARumorBut)
TalkMsg042A_ThisIsJustARumorBut::
    ld hl, $042a ; '*: This is just a rumor,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg042B_TheTunnelInTheWestWill", ROMX

; Fhunt talk group $21 (FhuntTalkEvents): starts message $042B (with 'The tunnel in the west will
; take') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $042B through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The tunnel in the west will take' (E-0268, the E-0082 shape; was
; TalkMsg042B_TheTunnelInTheWestWill)
TalkMsg042B_TheTunnelInTheWestWill::
    ld hl, $042b ; '*: The tunnel in the west'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg042C_AreYouLookingForSomething", ROMX

; Fhunt talk group $22 (FhuntTalkEvents): starts message $042C (with 'Are you looking for
; something?') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the
; message word). (C2, E-0377)
; starts message $042C through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Are you looking for something? Huh? The' (E-0268, the E-0082 shape; was
; TalkMsg042C_AreYouLookingForSomething)
TalkMsg042C_AreYouLookingForSomething::
    ld hl, $042c ; '*: Are you looking for something?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HowMayWeServeYourMortal_2", ROMX

; Fhunt talk group $23 (FhuntTalkEvents): sets wDataBank = $1F, then starts Script_HowMayWeServe_2
; with StartScriptAtHL_B13 (its first message has 'How may we serve your mortal'). (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayWeServe_2 (StartScriptAtHL_B13); its first message
; begins 'How may we serve your mortal' (E-0271; was Talk_HowMayWeServeYourMortal_2) (E-0344: the
; address in its name dropped or read as the label there; was Talk_HowMayWeServeYourMortal_2;
; shortened from TalkScript_HowMayWeServeYourMortal_2)
; starts Script_HowMayWeServe_2: '*: How may we serve your' (E-0248)
Talk_HowMayWeServeYourMortal_2::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayWeServe_2 ; script '*: How may we serve your'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Shop", ROMX

; Fhunt talk 36, a shop: shop $0D (wScreenTableIndex) with scripts in bank $10, 'Good day. How may I
; ...'. (C2, E-0357; probed E-0377)
FhuntTalkEvents_Shop::
    ld a, $0d
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_GoodDayHowMay ; script '*: Good day. How may I'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0430_HeroPeeredIntoTheVaseIt", ROMX

; Fhunt talk group $25 (FhuntTalkEvents): starts message $0430 (with '0 peered into the vase.')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $0430 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It appeared' (E-0268, the E-0082 shape; was
; TalkMsg0430_HeroPeeredIntoTheVaseIt)
TalkMsg0430_HeroPeeredIntoTheVaseIt::
    ld hl, $0430 ; '0 peered into the vase. …It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04AA_HeroReadTheSignDetermine", ROMX

; Fhunt talk group $26 (FhuntTalkEvents): starts message $04AA (with '0 read the sign.') through
; StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2, E-0377)
; starts message $04AA through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 read the sign. Determine where you' (E-0268, the E-0082 shape; was
; TalkMsg04AA_HeroReadTheSignDetermine)
TalkMsg04AA_HeroReadTheSignDetermine::
    ld hl, $04aa ; '0 read the sign. 'Determine where'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DD3_InnDownstairsRoomsAvailable", ROMX

; Fhunt talk group $27 (FhuntTalkEvents): starts message $0DD3 (with 'Inn downstairs. Rooms
; available.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the
; message word). (C2, E-0377)
; starts message $0DD3 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Inn downstairs. Rooms available.' (E-0268, the E-0082 shape; was
; TalkMsg0DD3_InnDownstairsRoomsAvailable)
TalkMsg0DD3_InnDownstairsRoomsAvailable::
    ld hl, $0dd3 ; ''Inn downstairs. Rooms available.''
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_WelcomeToTheTravelersInn", ROMX

; Fhunt talk group $28 (FhuntTalkEvents): sets wDataBank = $10, then starts
; Script_WelcomeToTheTraveler with StartScriptAtHL_B13 (its first message has 'Welcome to the
; traveler'). (C2, E-0377)
; sets wDataBank = $10, then starts Script_WelcomeToTheTraveler (StartScriptAtHL_B13); its first
; message begins 'Welcome to the traveler's inn.' (E-0271; was Talk_WelcomeToTheTravelersInn)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_WelcomeToTheTravelersInn; shortened from TalkScript_WelcomeToTheTravelersInn)
; starts Script_WelcomeToTheTraveler: '*: Welcome to the traveler's inn.' (E-0248)
Talk_WelcomeToTheTravelersInn::
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeToTheTraveler ; script '*: Welcome to the traveler's inn.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_GiantBird", ROMX

; Fhunt talk group $29, the giant bird: after EVENT_SCENE_MADCONDOR, starts Script_Kweeeeeh
; ('Kweeeeeh!') when FhuntTalkEvents_GiantBird_IsBirdPresent sets hTemp0: the player is disguised as
; a monster (hPlayerSpriteOverride bit 7 set, bit 0 clear) whose graphics id is in
; TalkEvent29WordList, or a party member without MON_STATUS bit 7 has a MON_SPECIES in that list;
; otherwise nothing. (C2, E-0377)
FhuntTalkEvents_GiantBird::
    ld de, EVENT_SCENE_MADCONDOR
    call TestFlagBit
    ret nc
    farcall FhuntTalkEvents_GiantBird_IsBirdPresent
    ldh a, [hTemp0]
    or a
    ret z
    ld hl, Script_Kweeeeeh ; script '*: Kweeeeeh!'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_ShowWhenIPassedToo", ROMX

; Fhunt talk 42: 'When I passed too close ...' ($0434) the first time (EVENT_WHEN_IPASSED_TOO), then
; 'I... I didn't take anything!' ($0435). (C2, E-0357; probed E-0377)
FhuntTalkEvents_ShowWhenIPassedToo::
    ld de, EVENT_WHEN_IPASSED_TOO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0434 ; '*: When I passed too close'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WHEN_IPASSED_TOO
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0435 ; '*: I… I didn't take anything!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0436_HeroOpenedTheTreasureChest", ROMX

; Fhunt talk group $2B (FhuntTalkEvents): starts message $0436 (with '0 opened the treasure chest.
; But it') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0436 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 opened the treasure chest. But it' (E-0268, the E-0082 shape; was
; TalkMsg0436_HeroOpenedTheTreasureChest)
TalkMsg0436_HeroOpenedTheTreasureChest::
    ld hl, $0436 ; '0 opened the treasure chest. But'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_WorldDew_Flag00AA", ROMX

; Fhunt talk group $2C (FhuntTalkEvents), a one-time treasure chest: wScriptParam0 = 0 (the kind),
; wScriptParam1 = $03 and DE = story flag $00AA, then StartTreasureFlagDE_B13 (script command $0A);
; while the flag is clear that command gives item $03 (WorldDew) and sets the flag (message $A0 of
; group 0; $A1 when the flag is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00AA in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WorldDew_Flag00AA)
ChestItem_WorldDew_Flag00AA::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00aa
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0437_ThisIsTheCastleOfHitano", ROMX

; Fhunt talk group $2D (FhuntTalkEvents): starts message $0437 (with 'This is the Castle of
; Hitano.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0437 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the Castle of Hitano. It' (E-0268, the E-0082 shape; was
; TalkMsg0437_ThisIsTheCastleOfHitano)
TalkMsg0437_ThisIsTheCastleOfHitano::
    ld hl, $0437 ; '*: This is the Castle of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0438_AMonsterKingHasAppearedTo", ROMX

; Fhunt talk group $2E (FhuntTalkEvents): message $0496 (with 'When the monster King disappeared,')
; once EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0438 (with 'A monster king has
; appeared to take'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0438_AMonsterKingHasAppearedTo.call_start_message_command09_hl_b13); starts message $0438
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'A monster king has
; appeared to take' (E-0268, the E-0082 shape; was TalkMsg0438_AMonsterKingHasAppearedTo)
TalkMsg0438_AMonsterKingHasAppearedTo::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0438 ; '*: A monster king has appeared'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0496 ; '*: When the monster King disappeared,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_IveLivedHereFor200", ROMX

; Fhunt talk group $2F (FhuntTalkEvents): starts Script_I_15 with StartScriptAtHL_B13 (its first
; message has 'lived here for 200'). (C2, E-0377)
; starts Script_I_15 (StartScriptAtHL_B13); its first message begins 'I've lived here for 200'
; (E-0271; was Talk_IveLivedHereFor200) (E-0344: the address in its name dropped or read as the
; label there; was Talk_IveLivedHereFor200; shortened from TalkScript_IELivedHereFor2Hero)
; starts Script_I_15: '*: I've lived here for 200' (E-0248)
Talk_IveLivedHereFor200::
    ld hl, Script_I_15 ; script '*: I've lived here for 200'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg043C_TheCastleIsUnderTheMonster", ROMX

; Fhunt talk group $30 (FhuntTalkEvents): message $0497 (with 'The Castle is now managed') once
; EVENT_SCENE_THREE_ITEMS_0C2 is set; else message $043D (with 'Did you see the monster') once
; EVENT_SCENE_MADCONDOR_CRY is set; otherwise message $043C (with 'The Castle is under the
; monster'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg043C_TheCastleIsUnderTheMonster.call_start_message_command09_hl_b132; flag 00A8 then jr c,
; TalkMsg043C_TheCastleIsUnderTheMonster.call_start_message_command09_hl_b13); starts message $043C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The Castle is under
; the monster King's' (E-0268, the E-0082 shape; was TalkMsg043C_TheCastleIsUnderTheMonster)
TalkMsg043C_TheCastleIsUnderTheMonster::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MADCONDOR_CRY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $043c ; '*: The Castle is under the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $043d ; '*: Did you see the monster'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0497 ; '*: The Castle is now managed'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg043E_TheCaveToTheSouthThat", ROMX

; Fhunt talk group $31 (FhuntTalkEvents): starts message $043E (with 'The cave to the south')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $043E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The cave to the south That has' (E-0268, the E-0082 shape; was TalkMsg043E_TheCaveToTheSouthThat)
TalkMsg043E_TheCaveToTheSouthThat::
    ld hl, $043e ; '*: The cave to the south…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg043F_TheNewMonsterKingIsSaid", ROMX

; Fhunt talk group $32 (FhuntTalkEvents): starts message $043F (with 'The new monster King is said
; to') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word).
; (C2, E-0377)
; starts message $043F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The new monster King is said to' (E-0268, the E-0082 shape; was
; TalkMsg043F_TheNewMonsterKingIsSaid)
TalkMsg043F_TheNewMonsterKingIsSaid::
    ld hl, $043f ; '*: The new monster King is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0440_HardlyNoOneHasSeenThe", ROMX

; Fhunt talk group $33 (FhuntTalkEvents): message $0498 (with 'Rumor has it that almost') once
; EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0440 (with 'Hardly no one has seen the
; new'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0440_HardlyNoOneHasSeenThe.call_start_message_command09_hl_b13); starts message $0440
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Hardly no one has
; seen the new' (E-0268, the E-0082 shape; was TalkMsg0440_HardlyNoOneHasSeenThe)
TalkMsg0440_HardlyNoOneHasSeenThe::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0440 ; '*: Hardly no one has seen'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0498 ; '*: Rumor has it that almost'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_SoldierThreeItems", ROMX

; Fhunt talk 52, a soldier: after EVENT_SCENE_THREE_ITEMS_0C2 'Where has our King gone?' ($0499);
; carrying all three of items $39-$3B the script 'What? You have the three ...'; otherwise $0441, or
; $0442 after EVENT_SCENE_MADCONDOR_CRY. (C2, E-0357; probed E-0377)
FhuntTalkEvents_SoldierThreeItems::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    ld a, $3a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    ld a, $3b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    jr .call_start_script_at_hl_b13

.call_test_flag_bit:
    ld de, EVENT_SCENE_MADCONDOR_CRY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0441 ; '*: This is only for army'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0442 ; '*: The King has posted a'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WhatYouHaveThe ; script '*: What? You have the three'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0499 ; '*: Where has our King gone?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_SoldierThreeItems2", ROMX

; Fhunt talk 53: after EVENT_SCENE_THREE_ITEMS_0C2 $049A; after EVENT_WHAT_YOU_HAVE_THE_THREE_0B7
; $046C; carrying items $39-$3B 'What? You have the three ...' ($046B), setting that flag; otherwise
; $0443, or 'Give away the LightOrb?' ($0444) after EVENT_SCENE_MADCONDOR_CRY. (C2, E-0357; probed
; E-0377)
FhuntTalkEvents_SoldierThreeItems2::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_WHAT_YOU_HAVE_THE_THREE_0B7
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    ld a, $3a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    ld a, $3b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_test_flag_bit
    jr .call_start_message_command09_hl_b132

.call_test_flag_bit:
    ld de, EVENT_SCENE_MADCONDOR_CRY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0443 ; '*: If you wish to join'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0444 ; '*: Give away the LightOrb? But'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $046b ; '*: What? You have the three'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WHAT_YOU_HAVE_THE_THREE_0B7
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $046c ; '*: Who would've thought anyone would'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $049a ; '*: There's no point staying in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0445_IfYouHaveTheLightOrbYou", ROMX

; Fhunt talk group $36 (FhuntTalkEvents): message $04A3 once EVENT_SCENE_THREE_ITEMS_0C2 is set;
; otherwise message $0445 (with 'If you have the LightOrb, you can'), each through
; StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0445_IfYouHaveTheLightOrbYou.call_start_message_command09_hl_b13); starts message $0445
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'If you have the
; LightOrb, you can' (E-0268, the E-0082 shape; was TalkMsg0445_IfYouHaveTheLightOrbYou)
TalkMsg0445_IfYouHaveTheLightOrbYou::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0445 ; '*: If you have the LightOrb,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04a3 ; '*: The King's gone. What should'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0446_IfIHadTheLightOrbEven", ROMX

; Fhunt talk group $37 (FhuntTalkEvents): message $049B (with 'If I had the LightOrb,') once
; EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $0446 (with 'If I had the LightOrb, even
; I'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg0446_IfIHadTheLightOrbEven.call_start_message_command09_hl_b13); starts message $0446
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'If I had the
; LightOrb, even I' (E-0268, the E-0082 shape; was TalkMsg0446_IfIHadTheLightOrbEven)
TalkMsg0446_IfIHadTheLightOrbEven::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0446 ; '*: If I had the LightOrb,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $049b ; '*: If I had the LightOrb,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_WantToKnowTheMostFundamental", ROMX

; Fhunt talk group $38 (FhuntTalkEvents): starts Script_WantToKnowThe with StartScriptAtHL_B13 (its
; first message has 'Want to know the most fundamental'). (C2, E-0377)
; starts Script_WantToKnowThe (StartScriptAtHL_B13); its first message begins 'Want to know the most
; fundamental' (E-0271; was Talk_WantToKnowTheMostFundamental) (E-0344: the address in its name
; dropped or read as the label there; was Talk_WantToKnowTheMostFundamental; shortened from
; TalkScript_WantToKnowTheMostFundamental)
; starts Script_WantToKnowThe: '*: Want to know the most' (E-0248)
Talk_WantToKnowTheMostFundamental::
    ld hl, Script_WantToKnowThe ; script '*: Want to know the most'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg044A_HearMeOutIfYouWish", ROMX

; Fhunt talk group $39 (FhuntTalkEvents): starts message $044A (with 'Hear me out if you wish to')
; through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2,
; E-0377)
; starts message $044A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Hear me out if you wish to' (E-0268, the E-0082 shape; was TalkMsg044A_HearMeOutIfYouWish)
TalkMsg044A_HearMeOutIfYouWish::
    ld hl, $044a ; '*: Hear me out if you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Shop2", ROMX

; Fhunt talk 58, a shop: shop $0E with scripts in bank $10, 'Welcome! How may I serve ...'. (C2,
; E-0357; probed E-0377)
FhuntTalkEvents_Shop2::
    ld a, $0e
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeHowMayI_4 ; script '*: Welcome! How may I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HowMayOurChurchHelpYou", ROMX

; Fhunt talk group $3B (FhuntTalkEvents): sets wDataBank = $1F, then starts Script_HowMayOurChurch_4
; with StartScriptAtHL_B13 (its first message has 'How may our church help you?'). (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch_4 (StartScriptAtHL_B13); its first
; message begins 'How may our church help you?' (E-0271; was Talk_HowMayOurChurchHelpYou) (E-0344:
; the address in its name dropped or read as the label there; was Talk_HowMayOurChurchHelpYou;
; shortened from TalkScript_HowMayOurChurchHelpYou)
; starts Script_HowMayOurChurch_4: '*: How may our church help' (E-0248)
Talk_HowMayOurChurchHelpYou::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch_4 ; script '*: How may our church help'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg044D_HeroReadTheSignTheFinder", ROMX

; Fhunt talk group $3C (FhuntTalkEvents): message $049C once EVENT_SCENE_THREE_ITEMS_0C2 is set;
; else message $044E once EVENT_SCENE_MADCONDOR_CRY is set; otherwise message $044D (with '0 read
; the sign.'), each through StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg044D_HeroReadTheSignTheFinder.call_start_message_command09_hl_b132; flag 00A8 then jr c,
; TalkMsg044D_HeroReadTheSignTheFinder.call_start_message_command09_hl_b13); starts message $044D
; through StartMessageCommand09HL_B13 (script command $09); that string begins '0 read the sign. The
; finder of' (E-0268, the E-0082 shape; was TalkMsg044D_HeroReadTheSignTheFinder)
TalkMsg044D_HeroReadTheSignTheFinder::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MADCONDOR_CRY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $044d ; '0 read the sign. 'The finder'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $044e ; '0 read the sign. 'The Heaven'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $049c ; '0 read the sign. 'Town of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0450_HeroPeeredIntoTheVaseA", ROMX

; Fhunt talk group $3D (FhuntTalkEvents): starts message $0450 (with '0 peered into the vase. A
; face') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0450 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. A face' (E-0268, the E-0082 shape; was
; TalkMsg0450_HeroPeeredIntoTheVaseA)
TalkMsg0450_HeroPeeredIntoTheVaseA::
    ld hl, $0450 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0314_HeroTriedToOpenTheChest", ROMX

; Fhunt talk group $3E (FhuntTalkEvents): starts message $0314 (with '0 tried to open the chest.
; But') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0314 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0314_HeroTriedToOpenTheChest)
TalkMsg0314_HeroTriedToOpenTheChest::
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_WelcomeToTheTravelersInn_13", ROMX

; Fhunt talk group $3F (FhuntTalkEvents): sets wDataBank = $10, then starts
; Script_WelcomeToTheTraveler with StartScriptAtHL_B13 (its first message has 'Welcome to the
; traveler'). (C2, E-0377)
; sets wDataBank = $10, then starts Script_WelcomeToTheTraveler (StartScriptAtHL_B13); its first
; message begins 'Welcome to the traveler's inn.' (E-0271; was Talk_WelcomeToTheTravelersInn_13)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_WelcomeToTheTravelersInn_13; shortened from TalkScript_WelcomeToTheTravelersInn_13)
; starts Script_WelcomeToTheTraveler: '*: Welcome to the traveler's inn.' (E-0248)
Talk_WelcomeToTheTravelersInn_13::
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeToTheTraveler ; script '*: Welcome to the traveler's inn.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0452_TheChangeStaffWillOpenPaths", ROMX

; Fhunt talk group $40 (FhuntTalkEvents): starts message $0452 (with 'The Change Staff will open
; paths.') through StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message
; word). (C2, E-0377)
; starts message $0452 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Change Staff will open paths. I' (E-0268, the E-0082 shape; was
; TalkMsg0452_TheChangeStaffWillOpenPaths)
TalkMsg0452_TheChangeStaffWillOpenPaths::
    ld hl, $0452 ; '*: The Change Staff will open'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0453_HeyKiddoYoureNewHereDont", ROMX

; Fhunt talk group $41 (FhuntTalkEvents): starts message $0453 (with 'Hey, kiddo!') through
; StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2, E-0377)
; starts message $0453 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Hey, kiddo! You're new here. Don't cause' (E-0268, the E-0082 shape; was
; TalkMsg0453_HeyKiddoYoureNewHereDont)
TalkMsg0453_HeyKiddoYoureNewHereDont::
    ld hl, $0453 ; '*: Hey, kiddo! You're new here.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0454_HeyKiddoYoureNewHereDont", ROMX

; Fhunt talk group $42 (FhuntTalkEvents): starts message $0454 (with 'Hey, kiddo!') through
; StartMessageCommand09HL_B13 (script command $09; wScriptParam0/1 = the message word). (C2, E-0377)
; starts message $0454 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Hey, kiddo! You're new here. Don't cause' (E-0268, the E-0082 shape; was
; TalkMsg0454_HeyKiddoYoureNewHereDont)
TalkMsg0454_HeyKiddoYoureNewHereDont::
    ld hl, $0454 ; '*: Hey, kiddo! You're new here.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0455_HeyKiddoYoureNewHereDont", ROMX

; Fhunt talk group $43 (FhuntTalkEvents): message $0456 (with 'Hey, kiddo! You treasure hunting?')
; once EVENT_SCENE_MADCONDOR_CRY is set; otherwise message $0455 (with 'Hey, kiddo!'), each through
; StartMessageCommand09HL_B13 (script command $09). (C2, E-0377)
; tests story flags (flag 00A8 then jr c,
; TalkMsg0455_HeyKiddoYoureNewHereDont.call_start_message_command09_hl_b13); starts message $0455
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Hey, kiddo! You're
; new here. Don't cause' (E-0268, the E-0082 shape; was TalkMsg0455_HeyKiddoYoureNewHereDont)
TalkMsg0455_HeyKiddoYoureNewHereDont::
    ld de, EVENT_SCENE_MADCONDOR_CRY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0455 ; '*: Hey, kiddo! You're new here.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0456 ; '*: Hey, kiddo! You treasure hunting?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0457_OnTheIslandToTheWest", ROMX

; Fhunt talk 68 ($44): starts message $0457 ('On the island to the west, there is the Wind Tower.
; ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0457 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'On the island to the west, there' (E-0268, the E-0082 shape; was
; TalkMsg0457_OnTheIslandToTheWest)
TalkMsg0457_OnTheIslandToTheWest::
    ld hl, $0457 ; '*: On the island to the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0458_ToTheEastIsASuspension", ROMX

; Fhunt talk 69 ($45): starts message $0458 ('To the east is a suspension bridge. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0458 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'To the east is a suspension bridge.' (E-0268, the E-0082 shape; was
; TalkMsg0458_ToTheEastIsASuspension)
TalkMsg0458_ToTheEastIsASuspension::
    ld hl, $0458 ; '*: To the east is a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0459_ThoseInsideTheHauntedCastle", ROMX

; Fhunt talk 70 ($46): starts message $0459 ('Those inside the haunted castle speak only amongst
; themselves. ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; starts message $0459 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Those inside the haunted castle speak only' (E-0268, the E-0082 shape; was
; TalkMsg0459_ThoseInsideTheHauntedCastle)
TalkMsg0459_ThoseInsideTheHauntedCastle::
    ld hl, $0459 ; '*: Those inside the haunted castle'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_ShowHeroCheckedTheSmall", ROMX

; Fhunt talk 71, the small hole: by FhuntTalkEvents_IsDisguisedAsListedMonster's answer (the
; player's monster disguise listed in TalkEvent47WordList): message $045B, $045C, or the script
; 'checked the small hole. It ...'. (C2, E-0357; probed E-0377)
FhuntTalkEvents_ShowHeroCheckedTheSmall::
    farcall FhuntTalkEvents_IsDisguisedAsListedMonster
    ldh a, [hTemp0]
    or a
    jr nz, .skip
    ld hl, $045b ; '0 checked the small hole. It's'
    call StartMessageCommand09HL_B13
    ret

.skip:
    dec a
    jr nz, .call_start_script_at_hl_b13
    ld hl, $045c ; '0 checked the small hole. It's'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HeroCheckedTheSmall ; script '0 checked the small hole. It'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_SilvrCape_Flag00AB", ROMX

; Fhunt talk 72 ($48), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_SILVRCAPE ($4E) and
; story flag $00AB in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the
; first time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room.
; (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4E, story flag $00AB in DE: when the flag is clear it gives item $4E (SilvrCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_SilvrCape_Flag00AB)
ChestItem_SilvrCape_Flag00AB::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4e
    ld [wScriptParam1], a
    ld de, $00ab
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Heaven", ROMX

; Fhunt talk 73 ($49), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HEAVEN ($39) and story
; flag $00AC in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room. (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $39, story flag $00AC in DE: when the flag is clear it gives item $39 (Heaven) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Heaven)
ChestItem_Heaven::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $39
    ld [wScriptParam1], a
    ld de, $00ac
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_YouCanTakeThis", ROMX

; Fhunt talk group $4A: before EVENT_YOU_CAN_TAKE_THIS_TREASURE starts Script_YouCanTakeThis ('You
; can take this treasure,' and sets that flag), afterwards Script_I_16 ('I'm up for your
; challenge'); both go on to scripted encounter 6, 'Heh, you're not half bad!', two walks of object
; 0, hiding it, EVENT_HEH_YOU and SCRIPT_HIDE_SPRITES. (C2, E-0370; probed E-0377)
; starts Script_YouCanTakeThis: '*: You can take this treasure,' (E-0248)
FhuntTalkEvents_YouCanTakeThis::
    ld de, EVENT_YOU_CAN_TAKE_THIS_TREASURE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_YouCanTakeThis ; script '*: You can take this treasure,'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_I_16 ; script '*: I'm up for your challenge'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_Heaven_Flag00AF", ROMX

; Fhunt talk 75 ($4B), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HEAVEN_3A ($3A) and
; story flag $00AF in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the
; first time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room.
; (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $3A, story flag $00AF in DE: when the flag is clear it gives item $3A (Heaven) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Heaven_Flag00AF)
ChestItem_Heaven_Flag00AF::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $3a
    ld [wScriptParam1], a
    ld de, $00af
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_PowerOfJustice", ROMX

; Fhunt talk 76 ($4C): calls FhuntTalkEvents_PowerOfJustice_IsDisguised, then reads hTemp0: 0 starts
; Script_LetThePowerOf ('Let the power of justice ...') through StartScriptAtHL_B13, non-zero shows
; message $0461 ('Step once on each of the two floor tiles on the right.') through
; StartMessageCommand09HL_B13. The helper clears hTemp0 when the player is not disguised as sprite
; $00F6-$00FF or any $01xx sprite; for such a disguise it only sets hTemp1 = 1, so the choice then
; rests on whatever hTemp0 held on entry. (C2, E-0377)
FhuntTalkEvents_PowerOfJustice::
    farcall FhuntTalkEvents_PowerOfJustice_IsDisguised
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, Script_LetThePowerOf ; script '*: Let the power of justice'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0461 ; '*: Step once on each of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0462_HeroCheckedTheNoticeLayThe", ROMX

; Fhunt talk 77 ($4D): starts message $0462 (the player checks the notice: 'Lay the souls to eternal
; rest.') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0462 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the notice. Lay the souls' (E-0268, the E-0082 shape; was
; TalkMsg0462_HeroCheckedTheNoticeLayThe)
; starts Script_SceneJustice (E-0248)
TalkMsg0462_HeroCheckedTheNoticeLayThe::
    ld hl, $0462 ; '0 checked the notice. 'Lay the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_SceneJustice", ROMX

; Fhunt talk 78 ($4E): starts Script_SceneJustice, whose one command is SCRIPT_SCENE_JUSTICE through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; starts Script_SceneJustice (StartScriptAtHL_B13) (E-0271; was Talk_SceneJustice) (E-0344: the
; address in its name dropped or read as the label there; was Talk_SceneJustice; named after the
; script it starts, Script_SceneJustice)
; starts Script_SceneJustice (E-0248)
Talk_SceneJustice::
    ld hl, Script_SceneJustice
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg04A8_WhereIsMyCasketWhereRing", ROMX

; Fhunt talk 79 ($4F): starts message $04A8 ('Where is my casket...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $04A8 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Where is my casket Where Ring the' (E-0268, the E-0082 shape; was
; TalkMsg04A8_WhereIsMyCasketWhereRing)
TalkMsg04A8_WhereIsMyCasketWhereRing::
    ld hl, $04a8 ; '*: …Where is my casket… Where…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04A9_HeroCheckedTheNoticeGuide", ROMX

; Fhunt talk 80 ($50): starts message $04A9 (the player checks the notice: 'Guide the lost
; souls...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $04A9 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the notice. Guide the lost' (E-0268, the E-0082 shape; was
; TalkMsg04A9_HeroCheckedTheNoticeGuide)
; starts Script_SceneGravestone (E-0248)
TalkMsg04A9_HeroCheckedTheNoticeGuide::
    ld hl, $04a9 ; '0 checked the notice. 'Guide the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_SceneGravestone", ROMX

; Fhunt talk 81 ($51): starts Script_SceneGravestone (sound $9B, then SCRIPT_SCENE_GRAVESTONE)
; through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1). (C2, E-0377)
; starts Script_SceneGravestone (StartScriptAtHL_B13) (E-0271; was Talk_SceneGravestone) (E-0344:
; the address in its name dropped or read as the label there; was Talk_SceneGravestone; named after
; the script it starts, Script_SceneGravestone)
; starts Script_SceneGravestone (E-0248)
Talk_SceneGravestone::
    ld hl, Script_SceneGravestone
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0463_HeroCheckedTheNoticeFollow", ROMX

; Fhunt talk 82 ($52): starts message $0463 (the player checks the notice: 'Follow the eyes of the
; undead. The key lies at the end.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0463 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the notice. Follow the eyes' (E-0268, the E-0082 shape; was
; TalkMsg0463_HeroCheckedTheNoticeFollow)
TalkMsg0463_HeroCheckedTheNoticeFollow::
    ld hl, $0463 ; '0 checked the notice. 'Follow the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg040E_HeroCheckedTheGraveTheTombstone_13", ROMX

; Fhunt talk 83 ($53): starts message $040E (the name of the player, then 'checked the grave. The
; tombstone was covered in moss.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $040E through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the grave. The tombstone was' (E-0268, the E-0082 shape; was
; TalkMsg040E_HeroCheckedTheGraveTheTombstone_13) (E-0344: the address in its name dropped or read
; as the label there; was TalkMsg040E_HeroCheckedTheGraveTheTombstone_13)
TalkMsg040E_HeroCheckedTheGraveTheTombstone_13::
    ld hl, $040e ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_GravestoneButton", ROMX

; Fhunt talk group $54: before EVENT_SET_FLAG_322 starts Script_HeroCheckedTheGravestone ('0 checked
; the gravestone. There was a round button. Press it?' with a choice: one answer runs
; Script_ADoorOpenedSomewhere, which plays sound $66, waits 60 frames, shows 'A door opened
; somewhere...', runs SCRIPT_SET_FLAG_322 and sets EVENT_SET_FLAG_322; the other shows '0 released
; the grave's button.'); afterwards shows message $040E ('0 checked the grave. The tombstone was
; covered in moss.') with StartMessageCommand09HL_B13. (C2, E-0370; probed E-0377)
; starts Script_HeroCheckedTheGravestone: '0 checked the gravestone. There was' (E-0248)
FhuntTalkEvents_GravestoneButton::
    ld de, EVENT_SET_FLAG_322
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_HeroCheckedTheGravestone ; script '0 checked the gravestone. There was'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $040e ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_YouOvercameTheTraps", ROMX

; Fhunt talk group $55: before EVENT_YOU_OVERCAME_THE_TRAPS_I starts Script_YouOvercameTheTraps
; ('You overcame the traps I' and sets that flag), afterwards Script_WahahahahHereAgainAre
; ('Wahahahah! Here again, are you?'); both go on to scripted encounter 8, 'You've beaten me
; fairly... Take', SCRIPT_SCENE_BEATEN_FAIRLY and the flags EVENT_SCENE_BEATEN_FAIRLY and
; EVENT_SCENE_BEATEN_FAIRLY_0C5 to EVENT_SCENE_BEATEN_FAIRLY_0C7. (C2, E-0370; probed E-0377)
; starts Script_YouOvercameTheTraps: '*: You overcame the traps I' (E-0248)
FhuntTalkEvents_YouOvercameTheTraps::
    ld de, EVENT_YOU_OVERCAME_THE_TRAPS_I
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_YouOvercameTheTraps ; script '*: You overcame the traps I'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WahahahahHereAgainAre ; script '*: Wahahahah! Here again, are you?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_Heaven_Flag00B5", ROMX

; Fhunt talk 86 ($56), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HEAVEN_3B ($3B) and
; story flag $00B5 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the
; first time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room.
; (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $3B, story flag $00B5 in DE: when the flag is clear it gives item $3B (Heaven) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Heaven_Flag00B5)
ChestItem_Heaven_Flag00B5::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $3b
    ld [wScriptParam1], a
    ld de, $00b5
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg046D_TheMonsterArmysGeneralIs", ROMX

; Fhunt talk 87 ($57): tests story flags with TestFlagBit and shows message $049D ('The Mayor is
; beyond here. ...') when EVENT_SCENE_THREE_ITEMS_0C2 is set; otherwise message $046D ('... You had
; better be on your best behavior.'). The message starts through StartMessageCommand09HL_B13 (script
; command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 00C2 then jr c,
; TalkMsg046D_TheMonsterArmysGeneralIs.call_start_message_command09_hl_b13); starts message $046D
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The monster army's
; general is beyond here.' (E-0268, the E-0082 shape; was TalkMsg046D_TheMonsterArmysGeneralIs)
TalkMsg046D_TheMonsterArmysGeneralIs::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $046d ; '*: The monster army's general is'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $049d ; '*: The Mayor is beyond here.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg046E_OurKingsCastleIsAnInvincible", ROMX

; Fhunt talk 88 ($58): starts message $046E ('... is an invincible fortress that is guarded by the
; elite in the monster army.') through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; starts message $046E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Our King's castle is an invincible fortress' (E-0268, the E-0082 shape; was
; TalkMsg046E_OurKingsCastleIsAnInvincible)
TalkMsg046E_OurKingsCastleIsAnInvincible::
    ld hl, $046e ; '*: Our King's castle is an'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg046F_WhatYouveGotTheThree", ROMX

; Fhunt talk 89 ($59): starts message $046F ('What? ... That means you get the LightOrb...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $046F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'What? You've got the three items?' (E-0268, the E-0082 shape; was
; TalkMsg046F_WhatYouveGotTheThree) (E-0324: was TalkMsg046F_WhatYouveGotTheThree; read before $42
; was known as 'v)
TalkMsg046F_WhatYouveGotTheThree::
    ld hl, $046f ; '*: What? You've got the three'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Mayor", ROMX

; Fhunt talk 90, the mayor: after EVENT_SCENE_THREE_ITEMS_0C2 $049E; after EVENT_SCENE_FOUND_ME
; $0472; carrying items $39-$3B the script 'I'm surprised anyone managed to ...'; otherwise 'Hm? How
; did you get ...' ($0470). (C2, E-0357; probed E-0377)
FhuntTalkEvents_Mayor::
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_FOUND_ME
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    ld a, $3a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    ld a, $3b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    jr .call_start_script_at_hl_b13

.call_start_message_command09_hl_b13:
    ld hl, $0470 ; '*: Hm? How did you get'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_I_17 ; script '*: I'm surprised anyone managed to'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0472 ; '*: If you can't even reach'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $049e ; '*: I've become the Mayor, but'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_TinyMedal_Flag0200", ROMX

; Fhunt talk 91 ($5B), a one-time vase: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL ($2C) and story
; flag $0200 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A3), shows $A4 once the flag is set and $A5 when there is no room. (C2,
; E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $0200 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag0200)
VaseItem_TinyMedal_Flag0200::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0200
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 Talk_SceneFoundMeBattle", ROMX

; Fhunt talk 92 ($5C): starts Script_SceneFoundMeBattle, whose one command is
; SCRIPT_SCENE_FOUND_ME_BATTLE through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneFoundMeBattle (StartScriptAtHL_B13) (E-0271; was Talk_SceneFoundMeBattle)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneFoundMeBattle;
; named after the script it starts, Script_SceneFoundMeBattle)
; starts Script_SceneFoundMeBattle (E-0248)
Talk_SceneFoundMeBattle::
    ld hl, Script_SceneFoundMeBattle
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_Kweeeeeh", ROMX

; Fhunt talk 93 ($5D): starts Script_Kweeeeeh_2 (message $0433 'Kweeeeeh!', scripted encounter 5
; with MadCondor and two Slimes, then it sets EVENT_SCENE_MADCONDOR_CRY) through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_Kweeeeeh_2 (StartScriptAtHL_B13); its first message begins 'Kweeeeeh!' (E-0271; was
; Talk_Kweeeeeh) (E-0344: the address in its name dropped or read as the label there; was
; Talk_Kweeeeeh; shortened from TalkScript_Kweeeeeh)
; starts Script_Kweeeeeh_2: '*: Kweeeeeh!' (E-0248)
Talk_Kweeeeeh::
    ld hl, Script_Kweeeeeh_2 ; script '*: Kweeeeeh!'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0DE2_HeroCheckedTheTombstoneThere", ROMX

; Fhunt talk 94 ($5E): starts message $0DE2 (the name of the player, then 'checked the tombstone.
; There appeared to be nothing.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0DE2 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the tombstone. There appeared to' (E-0268, the E-0082 shape; was
; TalkMsg0DE2_HeroCheckedTheTombstoneThere)
TalkMsg0DE2_HeroCheckedTheTombstoneThere::
    ld hl, $0de2 ; '0 checked the tombstone. There appeared'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0476_AwaarghImLateImLateThey", ROMX

; Fhunt talk 95 ($5F): starts message $0476 ('Awaargh, ... They overwork us terribly here.') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0476 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Awaargh, I'm late, I'm late! They overwork' (E-0268, the E-0082 shape; was
; TalkMsg0476_AwaarghImLateImLateThey)
TalkMsg0476_AwaarghImLateImLateThey::
    ld hl, $0476 ; '*: Awaargh, I'm late, I'm late!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0477_TheyKeepPilingOnTheseLudicrous", ROMX

; Fhunt talk 96 ($60): starts message $0477 ('They keep piling on these ludicrous orders. ...')
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0477 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'They keep piling on these ludicrous orders.' (E-0268, the E-0082 shape; was
; TalkMsg0477_TheyKeepPilingOnTheseLudicrous)
TalkMsg0477_TheyKeepPilingOnTheseLudicrous::
    ld hl, $0477 ; '*: They keep piling on these'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0478_GaahYouFoundMeWhileI", ROMX

; Fhunt talk 97 ($61): starts message $0478 ('Gaah! You found me while I was sluffing off from
; work...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0478 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Gaah! You found me while I was' (E-0268, the E-0082 shape; was TalkMsg0478_GaahYouFoundMeWhileI)
TalkMsg0478_GaahYouFoundMeWhileI::
    ld hl, $0478 ; '*: Gaah! You found me while'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_WorldDew_Flag00BC", ROMX

; Fhunt talk 98 ($62), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WORLDDEW ($03) and story
; flag $00BC in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room. (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00BC in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WorldDew_Flag00BC)
ChestItem_WorldDew_Flag00BC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00bc
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0450_HeroPeeredIntoTheVaseA_13", ROMX

; Fhunt talk 99 ($63): starts message $0450 (the name of the player, then 'peered into the vase. A
; face grinned up from the darkness. The vase actually was an EvilPot.') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0450 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. A face' (E-0268, the E-0082 shape; was
; TalkMsg0450_HeroPeeredIntoTheVaseA_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0450_HeroPeeredIntoTheVaseA_13)
TalkMsg0450_HeroPeeredIntoTheVaseA_13::
    ld hl, $0450 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_Thief_Flag00BD", ROMX

; Fhunt talk 100 ($64), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_THIEF ($60) and story
; flag $00BD in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room. (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $60, story flag $00BD in DE: when the flag is clear it gives item $60 (Thief) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Thief_Flag00BD)
ChestItem_Thief_Flag00BD::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00bd
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Bolt", ROMX

; Fhunt talk 101 ($65), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_BOLT ($25) and story
; flag $00BE in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room. (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $25, story flag $00BE in DE: when the flag is clear it gives item $25 (Bolt) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Bolt)
ChestItem_Bolt::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $25
    ld [wScriptParam1], a
    ld de, $00be
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_SteelFang_Flag00BF", ROMX

; Fhunt talk 102 ($66), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_STEELFANG ($45) and
; story flag $00BF in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the
; first time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room.
; (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $45, story flag $00BF in DE: when the flag is clear it gives item $45 (SteelFang) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_SteelFang_Flag00BF)
ChestItem_SteelFang_Flag00BF::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00bf
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Fwahahaha", ROMX

; Fhunt talk 103: after EVENT_GOOD_YOU_HAVE_BROUGHT_THE the script 'Fwahahaha! Don't you ever give
; ...'; carrying items $39-$3B takes all three and runs 'Ah, so good of you ...'; otherwise message
; $0479. (C2, E-0357; probed E-0377)
FhuntTalkEvents_Fwahahaha::
    ld de, EVENT_GOOD_YOU_HAVE_BROUGHT_THE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    ld a, $3a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    ld a, $3b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b13
    jr .set_temp0_to_39

.call_start_message_command09_hl_b13:
    ld hl, $0479 ; '*: Ah, so good of you'
    call StartMessageCommand09HL_B13
    ret

.set_temp0_to_39:
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $3a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $3b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_AhSoGoodOf ; script '*: Ah, so good of you'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_FwahahahaDon ; script '*: Fwahahaha! Don't you ever give'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_KamehaSoItWasYouWho", ROMX

; Fhunt talk 104 ($68): starts Script_KamehaSoItWas (sound $28, walks of object 0, Kameha: 'So it
; was you who got the three treasures' ($0481), more walks, message $0482, then
; SCRIPT_SCENE_THREE_ITEMS) through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_KamehaSoItWas (StartScriptAtHL_B13); its first message begins 'Kameha So it was you
; who' (E-0271; was Talk_KamehaSoItWasYouWho) (E-0344: the address in its name dropped or read as
; the label there; was Talk_KamehaSoItWasYouWho; shortened from TalkScript_KamehaSoItWasYouWho)
; starts Script_KamehaSoItWas: 'Kameha: So it was you who' (E-0248)
Talk_KamehaSoItWasYouWho::
    ld hl, Script_KamehaSoItWas ; script 'Kameha: So it was you who'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_ThisWayHereHere", ROMX

; Fhunt talk 105 ($69): starts Script_ThisWayHereHere (message $04A7 '......This way... ...Here...',
; then SCRIPT_SCENE_THIS_WAY) through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_ThisWayHereHere (StartScriptAtHL_B13); its first message begins 'This way Here Here'
; (E-0271; was Talk_ThisWayHereHere) (E-0344: the address in its name dropped or read as the label
; there; was Talk_ThisWayHereHere; shortened from TalkScript_ThisWayHereHere)
; starts Script_ThisWayHereHere: '*: ……This way… …Here… …Here…' (E-0248)
Talk_ThisWayHereHere::
    ld hl, Script_ThisWayHereHere ; script '*: ……This way… …Here… …Here…'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_Sound", ROMX

; Fhunt talk 106: object 1 faces down; unless the player stands at Y $70, runs Script_Sound. (C2,
; E-0357; probed E-0377)
FhuntTalkEvents_Sound::
    xor a
    ld [wObject1 + OBJ_STATE], a
    ldh a, [hPlayerY]
    cp $70
    ret z
    ld hl, Script_Sound
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg04A6_IWasTakingAWalkOutside", ROMX

; Fhunt talk 107 ($6B): starts message $04A6 ('I was taking a walk outside with my friend Roboster
; ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $04A6 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I was taking a walk outside with' (E-0268, the E-0082 shape; was
; TalkMsg04A6_IWasTakingAWalkOutside)
TalkMsg04A6_IWasTakingAWalkOutside::
    ld hl, $04a6 ; '*: I was taking a walk'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04A4_SouthBeyondTheMountainsIs", ROMX

; Fhunt talk 108 ($6C): starts message $04A4 ('South beyond the mountains is the ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $04A4 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'South beyond the mountains is the King's' (E-0268, the E-0082 shape; was
; TalkMsg04A4_SouthBeyondTheMountainsIs)
TalkMsg04A4_SouthBeyondTheMountainsIs::
    ld hl, $04a4 ; '*: South beyond the mountains is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04A5_SeveralAncientRuinsRemain", ROMX

; Fhunt talk 109 ($6D): starts message $04A5 ('Several ancient ruins remain in the southern part of
; the continent. ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1).
; (C2, E-0377)
; starts message $04A5 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Several ancient ruins remain in the southern' (E-0268, the E-0082 shape; was
; TalkMsg04A5_SeveralAncientRuinsRemain)
TalkMsg04A5_SeveralAncientRuinsRemain::
    ld hl, $04a5 ; '*: Several ancient ruins remain in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_PowerOfJustice2", ROMX

; Fhunt talk 110 ($6E): calls FhuntTalkEvents_PowerOfJustice_IsDisguised, then reads hTemp0: 0
; starts Script_LetThePowerOf ('Let the power of justice ...') through StartScriptAtHL_B13, non-zero
; shows message $04A0 ('... lord summons monsters...') through StartMessageCommand09HL_B13. The
; helper clears hTemp0 when the player is not disguised as sprite $00F6-$00FF or any $01xx sprite;
; for such a disguise it only sets hTemp1 = 1, so the choice then rests on whatever hTemp0 held on
; entry. (C2, E-0377)
FhuntTalkEvents_PowerOfJustice2::
    farcall FhuntTalkEvents_PowerOfJustice_IsDisguised
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, Script_LetThePowerOf ; script '*: Let the power of justice'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04a0 ; '*: The castle's lord summons monsters…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 FhuntTalkEvents_PowerOfJustice3", ROMX

; Fhunt talk 111 ($6F): calls FhuntTalkEvents_PowerOfJustice_IsDisguised, then reads hTemp0: 0
; starts Script_LetThePowerOf ('Let the power of justice ...') through StartScriptAtHL_B13, non-zero
; shows message $04A1 ('A button hides behind a grave... A button that opens a door...') through
; StartMessageCommand09HL_B13. The helper clears hTemp0 when the player is not disguised as sprite
; $00F6-$00FF or any $01xx sprite; for such a disguise it only sets hTemp1 = 1, so the choice then
; rests on whatever hTemp0 held on entry. (C2, E-0377)
FhuntTalkEvents_PowerOfJustice3::
    farcall FhuntTalkEvents_PowerOfJustice_IsDisguised
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, Script_LetThePowerOf ; script '*: Let the power of justice'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04a1 ; '*: A button hides behind a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0413_HeroCheckedTheTreasureChest_13", ROMX

; Fhunt talk 112 ($70): starts message $0413 (the name of the player, then 'checked the treasure
; chest. The chest was empty. Could the LightOrb have been in it?') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0413 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the treasure chest. The chest' (E-0268, the E-0082 shape; was
; TalkMsg0413_HeroCheckedTheTreasureChest_13) (E-0344: the address in its name dropped or read as
; the label there; was TalkMsg0413_HeroCheckedTheTreasureChest_13)
TalkMsg0413_HeroCheckedTheTreasureChest_13::
    ld hl, $0413 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ToggleMapBetween7FAnd92", ROMX

; Fhunt talk 114 ($72), the last entry of FhuntTalkEvents (113 is an unused $0000 word): returns at
; once when wMapToggleRequest is 0. Otherwise it clears the request and swaps maps: on map $7F it
; sets hMapId = $92 with wWarpDestX/Y = $40, $40; on any other map hMapId = $7F with wWarpDestX/Y =
; $40, $10. It then clears wJoypadHeld, wJoypadPressed, wWarpDestFacing, wMapToggleFlag, wMenuState
; and wMenuSubState and sets wFieldTransitionKind = 1 and wModeState = 6 (FieldState_FieldMenu,
; which runs WarpEffect). (C2, E-0377)
; when wMapToggleRequest is set: clears it and warps between map $7F and $92 (position $40, $40 or
; $40, $10) through mode state 6 (E-0125)
ToggleMapBetween7FAnd92::
    ld a, [wMapToggleRequest]
    or a
    ret z
    xor a
    ld [wMapToggleRequest], a
    ldh a, [hMapId]
    cp $7f
    jr nz, .set_map_id_to_7F
    ld a, $92
    ldh [hMapId], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    jr .clear_joypad_held

.set_map_id_to_7F:
    ld a, $7f
    ldh [hMapId], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $10
    ld [wWarpDestY], a

.clear_joypad_held:
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a
    ld [wWarpDestFacing], a
    xor a
    ld [wMapToggleFlag], a
    ld a, $06
    ld [wModeState], a
    xor a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

SECTION "Bank 13 NordenTalkEvents", ROMX

; Talk category 4 (entry 4 of the DispatchTalkEvent table, picked by wTalkEventIndex): jumps by
; wTalkEventGroup through a 171-entry table (groups $00-$AA) to the talk handlers of the Norden
; kingdom, its port of Nofor and the border mine, Weston and Westania Castle in the west, and the
; castle of Estria. Nothing checks the group against the table size. (C2, E-0377)
; talk category 4: jumps by wTalkEventGroup to the talk handlers of the Norden kingdom and its port
; (messages $0300-$03BF, $0AB0-$0ACF)
NordenTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw TalkMsg0300_ThisIsNordenTheKingdomOf
    dw TalkMsg0301_ThereAreThreeKingdomsSituated
    dw TalkMsg0302_TravelNorthAlongTheMountain
    dw TalkMsg0303_TheWinterHereIsHarshStay
    dw TalkMsg0304_ListenDidYouHearTheyFound
    dw TalkMsg0305_UrrrrrghTheWesternWretches
    dw TalkMsg0306_EveryonesBeenActingStrangely
    dw TalkMsg0307_TheSpringInTheNorthWhere
    dw Talk_HaveYouHeardAboutTheSpirit
    dw TalkMsg030B_AroundThesePartsWeGetA
    dw TalkMsg030C_ItsBecomeMuchColderWeMay
    dw NordenTalkEvents_ShowHisMajestyIsIn
    dw TalkMsg030F_TheMineOnTheWesternBorder
    dw NordenTalkEvents_Shop
    dw TalkMsg0311_HeroPeeredIntoTheVaseIt
    dw VaseItem_TinyMedal_Flag01E6
    dw TalkMsg0313_HeroPeeredIntoTheOvenIt
    dw TalkMsg0314_HeroTriedToOpenTheChest_13
    dw NordenTalkEvents_Inn
    dw TalkMsg0315_TheBorderIsClosedSoI
    dw NordenTalkEvents_Shield
    dw TalkMsg031E_HisMajestyHasBeenCrankyIs
    dw TalkMsg031F_AfterTheGoldDiscoveryOur
    dw TalkMsg0320_IRememberTheKingToBe
    dw NordenTalkEvents_TwoKings
    dw TalkMsg0ABD_HeroCheckedTheBookshelfHistory
    dw TalkMsg0ABE_HeroCheckedTheBookshelfHistory
    dw TalkMsg0ABC_HeroPeeredIntoTheOvenIt
    dw TalkMsg0324_ThisTunnelGoesToAPort
    dw TalkMsg0325_ThisIsThePortOfNofor
    dw TalkMsg0326_ItsUselessBeyondUselessThe
    dw TalkMsg0327_InAllMyYearsIve
    dw TalkMsg0328_ThreeKingdomsRingThisLake
    dw TalkMsg0329_TheBorderItsNotHereThe
    dw TalkMsg032A_MamaSaidToStayOffThe
    dw TalkMsg032B_WeWerePassingThroughFrom
    dw TalkMsg032C_TheyDiscoveredGoldAtTheMine
    dw TalkMsg032D_IHearTheWestAndThe
    dw TalkMsg032E_DoYouKnowLadyYunaOf
    dw TalkMsg032F_TheScholarInTheTavernSaid
    dw TalkMsg0330_DontYouThinkItsTooExpensive
    dw NordenTalkEvents_Shop0A
    dw NordenTalkEvents_Shop08
    dw NordenTalkEvents_Shop09
    dw Talk_HowMayOurChurchServeYou_2
    dw TalkMsg0312_HeroPeeredIntoTheBarrelIt
    dw TalkMsg0D3B_Whinny
    dw TalkMsg0314_HeroTriedToOpenTheChest_13_2
    dw TalkMsg0313_HeroPeeredIntoTheOvenIt_13
    dw TalkMsg0334_WeveBeenFullUpWith
    dw TalkMsg0335_UrrrpHooListenToThisMy
    dw TalkMsg0336_SighIsntThatScholarAppealing
    dw TalkMsg0337_ICameFromTheEasternKingdom
    dw TalkMsg0ABF_HeroPeeredIntoTheBarrelIt
    dw NordenTalkEvents_SecondInn
    dw TalkMsg0338_TheKingOfTheWestIs
    dw TalkMsg0339_ThisIsTheBorderWeShare
    dw TalkMsg033A_TheBorderHasBeenSealedBy
    dw TalkMsg033B_ATravelerAreYouSorryBut
    dw TalkMsg033C_OurTunnelingFoundGoldBut
    dw TalkMsg033D_ThisSideIsTheWesternKingdom
    dw TalkMsg033E_TheNorthernersWantOurGold
    dw TalkMsg033F_TheNorthernersMuscledInOn
    dw TalkMsg0340_HehYouveComeWayDown
    dw TalkMsg0345_KidYouHaveGutsToBe
    dw TalkMsg0341_ThereIsABoulderBlockingThe
    dw TalkMsg0342_HurryWeHaveToBeatThe
    dw TalkMsg0344_TheGoldIsOursTheWest
    dw TalkMsg0343_TheVeinOfGoldIsJust
    dw Talk_WhatWhatWasThatExplosion
    dw Talk_WhatWhatWasThatExplosion_2
    dw ChestItem_VITbelt
    dw NordenTalkEvents_ShowAhSavedAtLast
    dw NordenTalkEvents_ShowKamehaWheresTheExit
    dw Talk_HeroTappedOnTheWallThe
    dw Talk_HeroTappedOnTheWallSound
    dw Talk_ImTheRealKingYouFake
    dw NordenTalkEvents_ShowIAmRealDont
    dw TalkMsg037E_ThisIsTheTownOfWeston
    dw TalkMsg037F_TheWestsCastleHasSeenA
    dw TalkMsg0380_AcrossFromUsOnTheLake
    dw TalkMsg0381_ISawLadyYunaRidingTowards
    dw TalkMsg0382_LadyYunaHasBeenALively
    dw TalkMsg0383_IHaventBeenSeeingTooMany
    dw TalkMsg0384_LadyYunaIsSaidToBe
    dw TalkMsg0385_IveHeardRumorsThatSomething
    dw TalkMsg0386_TheKingDotesOverLadyYuna
    dw TalkMsg0387_TheRoadToTheEasternKingdom
    dw TalkMsg0388_LadyYunaLocksHerselfInHer
    dw TalkMsg0389_IfYouCanCheerUpThe
    dw TalkMsg038A_AWoodsmanCameByAWhile
    dw TalkMsg0312_HeroPeeredIntoTheBarrelIt_13
    dw BarrelItem_TinyMedal_Flag01E7
    dw TalkMsg0313_HeroPeeredIntoTheOvenIt_13_2
    dw NordenTalkEvents_ThirdInn
    dw NordenTalkEvents_Shop0B
    dw TalkMsg038C_TheLakeIsFrozenSoI
    dw TalkMsg038D_ThisIsWestaniaCastleWestania
    dw TalkMsg038E_NobodyFailsToBeImpressed
    dw TalkMsg038F_IveBroughtWithMeA
    dw TalkMsg0390_WhenIBalanceOnMyBall
    dw TalkMsg0391_IHurlKnivesWithIncredible
    dw TalkMsg0392_PleaseLineUpAndQuitPushing
    dw TalkMsg0393_OhLadyYunaToThinkThat
    dw NordenTalkEvents_Sign
    dw TalkMsg0397_TheCastleIsInAnUproar
    dw TalkMsg0398_LadyYunaUsedToBeVery
    dw TalkMsg0399_InTheEastLivesAnOld
    dw TalkMsg039A_WhatHappenedToLadyYunaIts
    dw TalkMsg039B_BeforeLadyYunaWouldBeUp
    dw NordenTalkEvents_ShowOhHowDidYou
    dw NordenTalkEvents_ShowYoureHereToCheer
    dw Talk_KingMagnificentDontYouAgree
    dw TalkMsg03A4_KingSighNotEvenThisYou
    dw NordenTalkEvents_Yuna
    dw TalkMsg03A6_ThisIsTheCastleOfEstria
    dw TalkMsg03A7_QueenHelenCameByAWhile
    dw TalkMsg03A8_TheSpiritsSpringHasFrozen
    dw TalkMsg03A9_QueenHelensDreamsComeTrue
    dw TalkMsg03AA_OurQueenIsAKindPerson
    dw TalkMsg03AB_ATeacherFromTheWestLives
    dw TalkMsg03AE_TheQueenLooksHaggardRecently
    dw TalkMsg03AD_IHeardThisOnTheSly
    dw TalkMsg03AF_AroundThesePartsThereAre
    dw NordenTalkEvents_ShowThisIsNoPlace
    dw NordenTalkEvents_Shop0C
    dw TalkMsg03B4_ABotanistDoesLiveHereBut
    dw Talk_IRetiredAsATeacher
    dw Talk_HowMayOurChurchServeYou_3
    dw Talk_SceneChestServant
    dw Talk_HowMayOurChurchServeYou_13
    dw Talk_HowMayOurChurchServeYou_13_2
    dw TalkMsg0313_HeroPeeredIntoTheOvenIt_13_3
    dw TalkMsg0312_HeroPeeredIntoTheBarrelIt_13_2
    dw NordenTalkEvents_FourthInn
    dw TalkMsg03B8_IWantToReturnToThe
    dw TalkMsg03AC_ThereIsASpringInThe
    dw TalkMsg0396_ItsAMeanOldWorldOut
    dw TalkMsg03B9_QueenHelenHasBeenSuffering
    dw TalkMsg0DD6_NightmaresSoHorribleThat
    dw TalkMsg0DD7_OurHeartsAreLike
    dw Talk0DD8_QueenHelenIsWracked
    dw Talk0DD9_TheReceptionHallIs
    dw TalkMsg0DDA_OurQueenHelensPremonition
    dw TalkMsg0DDB_WhatIsItLeave
    dw TalkMsg00FF_Composing_13
    dw TalkMsg0DDC_ThisHappenedWhenIWasDeep
    dw TalkMsg0DDD_MyFatherIsSoCowardlyGetting
    dw TalkMsg0AC0_HeroCheckedTheBookshelfHistory
    dw TalkMsg0AC0_HeroCheckedTheBookshelfHistory
    dw TalkMsg0AC1_HeroCheckedTheBookshelfHistory
    dw TalkMsg0ABC_HeroPeeredIntoTheOvenIt_13
    dw Talk_SceneSpiritEnvoy2
    dw NordenTalkEvents_Startled
    dw NordenTalkEvents_ShowHeroCheckedTheMarionette
    dw TalkMsg0A16_MyMaidIsAngryThatI
    dw NordenTalkEvents_BlueFlower
    dw ChestMagicKey_Flag01E0
    dw NordenTalkEvents_FaceObject2Down
    dw Talk_SceneShield
    dw NordenTalkEvents_ShowHeroCheckedTheTreasure
    dw NordenTalkEvents_SecondShieldScene
    dw ChestItem_Bolt_Flag01E9
    dw ChestItem_DracoBelt
    dw ChestItem_BraveCape_Flag01EB
    dw ChestItem_Smart_Flag01EC
    dw ChestItem_Friend_Flag01ED
    dw ChestItem_Mage_Flag01EE
    dw ChestItem_Divine_Flag01EF
    dw ChestItem_MeteOrb
    dw Talk_SceneShieldGuardian

; Norden talk 0 ($00): starts message $0300 ('This is Norden, the kingdom of the north.') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0300 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is Norden, the kingdom of the' (E-0268, the E-0082 shape; was
; TalkMsg0300_ThisIsNordenTheKingdomOf)
TalkMsg0300_ThisIsNordenTheKingdomOf::
    ld hl, $0300 ; '*: This is Norden, the kingdom'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0301_ThereAreThreeKingdomsSituated", ROMX

; Norden talk 1 ($01): starts message $0301 ('There are three kingdoms situated around a lake. ...')
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0301 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There are three kingdoms situated around a' (E-0268, the E-0082 shape; was
; TalkMsg0301_ThereAreThreeKingdomsSituated)
TalkMsg0301_ThereAreThreeKingdomsSituated::
    ld hl, $0301 ; '*: There are three kingdoms situated'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0302_TravelNorthAlongTheMountain", ROMX

; Norden talk 2 ($02): starts message $0302 ('Travel north along the mountain range, and ...')
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0302 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Travel north along the mountain range, and' (E-0268, the E-0082 shape; was
; TalkMsg0302_TravelNorthAlongTheMountain)
TalkMsg0302_TravelNorthAlongTheMountain::
    ld hl, $0302 ; '*: Travel north along the mountain'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0303_TheWinterHereIsHarshStay", ROMX

; Norden talk 3 ($03): starts message $0303 ('The winter here is harsh. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0303 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The winter here is harsh. Stay outside' (E-0268, the E-0082 shape; was
; TalkMsg0303_TheWinterHereIsHarshStay)
TalkMsg0303_TheWinterHereIsHarshStay::
    ld hl, $0303 ; '*: The winter here is harsh.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0304_ListenDidYouHearTheyFound", ROMX

; Norden talk 4 ($04): tests story flags with TestFlagBit and shows message $0355 ('... Squabbling
; over gold that ...') when EVENT_SCENE_GOT_TO is set; otherwise message $0304 ('Listen, did you
; hear? ...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg0304_ListenDidYouHearTheyFound.call_start_message_command09_hl_b13); starts message $0304
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Listen, did you
; hear? They found gold' (E-0268, the E-0082 shape; was TalkMsg0304_ListenDidYouHearTheyFound)
TalkMsg0304_ListenDidYouHearTheyFound::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0304 ; '*: Listen, did you hear? They'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0355 ; '*: I've heard about the mine.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0305_UrrrrrghTheWesternWretches", ROMX

; Norden talk 5 ($05): tests story flags with TestFlagBit and shows message $0356 ('... no telling
; what greed will make people do...') when EVENT_SCENE_GOT_TO is set; otherwise message $0305
; ('Urrrrrgh! The western wretches! The mine on the border is on a rich vein of pure gold!'). The
; message starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg0305_UrrrrrghTheWesternWretches.call_start_message_command09_hl_b13); starts message $0305
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Urrrrrgh! The
; western wretches! The mine on' (E-0268, the E-0082 shape; was
; TalkMsg0305_UrrrrrghTheWesternWretches)
TalkMsg0305_UrrrrrghTheWesternWretches::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0305 ; '*: Urrrrrgh! The western wretches! The'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0356 ; '*: There's just no telling what'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0306_EveryonesBeenActingStrangely", ROMX

; Norden talk 6 ($06): tests story flags with TestFlagBit and shows message $0357 ('Did you know?
; ...') when EVENT_SCENE_GOT_TO is set; otherwise message $0306 ('... Even the King has
; changed...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg0306_EveryonesBeenActingStrangely.call_start_message_command09_hl_b13); starts message
; $0306 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Everyone's
; been acting strangely since they found' (E-0268, the E-0082 shape; was
; TalkMsg0306_EveryonesBeenActingStrangely)
TalkMsg0306_EveryonesBeenActingStrangely::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0306 ; '*: Everyone's been acting strangely since'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0357 ; '*: Did you know? There is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0307_TheSpringInTheNorthWhere", ROMX

; Norden talk 7 ($07): tests story flags with TestFlagBit and shows message $0A0B ('... However cold
; it may be, spring always comes, I guess.') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message
; $0307 ('The spring in the north, where the elemental lives, has frozen. ...'). The message starts
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0307_TheSpringInTheNorthWhere.call_start_message_command09_hl_b13); starts message $0307
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The spring in the
; north, where the' (E-0268, the E-0082 shape; was TalkMsg0307_TheSpringInTheNorthWhere)
TalkMsg0307_TheSpringInTheNorthWhere::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0307 ; '*: The spring in the north,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a0b ; '*: The spirit's spring in the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HaveYouHeardAboutTheSpirit", ROMX

; Norden talk 8 ($08): starts Script_HaveYouHeardAbout_2: message word $4308 ('Have you heard about
; the spirit in the spring?'); script_skip_if_no goes on to Script_ALongTimeAgo (word $8309, 'A long
; time ago the spirit made a shield using her mystical powers.'), otherwise word $830A ('Many years
; ago, our ancestors came to this land after a long journey.') through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_HaveYouHeardAbout_2 (StartScriptAtHL_B13); its first message begins 'Have you heard
; about the spirit' (E-0271; was Talk_HaveYouHeardAboutTheSpirit) (E-0344: the address in its name
; dropped or read as the label there; was Talk_HaveYouHeardAboutTheSpirit; shortened from
; TalkScript_HaveYouHeardAboutTheSpirit)
; starts Script_HaveYouHeardAbout_2: '*: Have you heard about the' (E-0248)
Talk_HaveYouHeardAboutTheSpirit::
    ld hl, Script_HaveYouHeardAbout_2 ; script '*: Have you heard about the'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg030B_AroundThesePartsWeGetA", ROMX

; Norden talk 9 ($09): tests story flags with TestFlagBit and shows message $0D21 ('Star spuds grow
; plentifully around these parts. ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $030B
; ('Around these parts, we get a lot of star spuds ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg030B_AroundThesePartsWeGetA.call_start_message_command09_hl_b13); starts message $030B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Around these parts,
; we get a lot' (E-0268, the E-0082 shape; was TalkMsg030B_AroundThesePartsWeGetA)
TalkMsg030B_AroundThesePartsWeGetA::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $030b ; '*: Around these parts, we get'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d21 ; '*: Star spuds grow plentifully around'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg030C_ItsBecomeMuchColderWeMay", ROMX

; Norden talk 10 ($0A): tests story flags with TestFlagBit and shows message $0DF2 ('The weather has
; been mild. ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $030C ('... We may need
; the help of the spirit again to ...'). The message starts through StartMessageCommand09HL_B13
; (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg030C_ItsBecomeMuchColderWeMay.call_start_message_command09_hl_b13); starts message $030C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'It's become much
; colder. We may need' (E-0268, the E-0082 shape; was TalkMsg030C_ItsBecomeMuchColderWeMay)
TalkMsg030C_ItsBecomeMuchColderWeMay::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $030c ; '*: It's become much colder. We'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0df2 ; '*: The weather has been mild.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowHisMajestyIsIn", ROMX

; Norden talk 11, the castle guard: after EVENT_WHAT_IS_THAT_DIRTY_MEDAL 'Please enter, your
; envoyship!' ($031D); carrying item $32 (the Crest) the script 'What is that dirty medal?';
; otherwise 'His Majesty is in talks ...' ($030E). (C2, E-0357; probed E-0377)
NordenTalkEvents_ShowHisMajestyIsIn::
    ld de, EVENT_WHAT_IS_THAT_DIRTY_MEDAL
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b13
    ld hl, $030e ; '*: His Majesty is in talks'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WhatIsThatDirty ; script '*: What is that dirty medal?'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $031d ; '*: Please enter, your envoyship!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg030F_TheMineOnTheWesternBorder", ROMX

; Norden talk 12 ($0C): tests story flags with TestFlagBit and shows message $037A ('The border with
; the west is open! ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message $030F ('The
; mine on the western border is closed right now. ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg030F_TheMineOnTheWesternBorder.call_start_message_command09_hl_b13); starts message $030F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The mine on the
; western border is' (E-0268, the E-0082 shape; was TalkMsg030F_TheMineOnTheWesternBorder)
TalkMsg030F_TheMineOnTheWesternBorder::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $030f ; '*: The mine on the western'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $037a ; '*: The border with the west'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shop", ROMX

; Norden talk 13, a shop: shop 7 with scripts in bank $10, 'Welcome! How may I serve ...'. (C2,
; E-0357; probed E-0377)
NordenTalkEvents_Shop::
    ld a, $07
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeHowMayI_3 ; script '*: Welcome! How may I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0311_HeroPeeredIntoTheVaseIt", ROMX

; Norden talk 14 ($0E): starts message $0311 ('peered into the vase. It was filled with lumpy
; potatoes.', after a '*:' speaker mark rather than the name of the player) through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0311 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0311_HeroPeeredIntoTheVaseIt)
TalkMsg0311_HeroPeeredIntoTheVaseIt::
    ld hl, $0311 ; '*: 0 peered into the vase.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_TinyMedal_Flag01E6", ROMX

; Norden talk 15 ($0F), a one-time vase: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL ($2C) and story
; flag $01E6 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A3), shows $A4 once the flag is set and $A5 when there is no room. (C2,
; E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $01E6 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag01E6)
VaseItem_TinyMedal_Flag01E6::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01e6
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0313_HeroPeeredIntoTheOvenIt", ROMX

; Norden talk 16 ($10): starts message $0313 (the name of the player, then 'peered into the oven. It
; felt just a little warm.') through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; starts message $0313 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0313_HeroPeeredIntoTheOvenIt)
TalkMsg0313_HeroPeeredIntoTheOvenIt::
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0314_HeroTriedToOpenTheChest_13", ROMX

; Norden talk 17 ($11): starts message $0314 (the name of the player, then 'tried to open the chest.
; But the treasure chest was locked.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0314 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0314_HeroTriedToOpenTheChest_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0314_HeroTriedToOpenTheChest_13)
; starts Script_WelcomeToOurInn_5: '*: Welcome to our inn!' (E-0248)
TalkMsg0314_HeroTriedToOpenTheChest_13::
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Inn", ROMX

; Norden talk 18, an inn: starts Script_WelcomeToOurInn_5 ('Welcome to our inn!', then a jump to the
; inn script Script_It_3 in the data bank) and sets wDataBank = $10 for that jump. (C2, E-0370;
; probed E-0377)
; starts Script_WelcomeToOurInn_5: '*: Welcome to our inn!' (E-0248)
NordenTalkEvents_Inn::
    ld hl, Script_WelcomeToOurInn_5 ; script '*: Welcome to our inn!'
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 13 TalkMsg0315_TheBorderIsClosedSoI", ROMX

; Norden talk 19 ($13): starts message $0315 ('The border is closed, so I ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0315 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The border is closed, so I can't' (E-0268, the E-0082 shape; was
; TalkMsg0315_TheBorderIsClosedSoI)
TalkMsg0315_TheBorderIsClosedSoI::
    ld hl, $0315 ; '*: The border is closed, so'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shield", ROMX

; Norden talk 20, the shield: after EVENT_SCENE_SHIELD_1E4 it fakes a press of A
; (wJoypadHeld/wJoypadPressed = 1); after EVENT_SCENE_SHIELD_GUARDIAN_1E2 the shield scene script,
; or 'checked the shield.' before EVENT_SCENE_SHIELD; after EVENT_BLINK_SPRITES 'If you restore this
; world's ...' ($031B); otherwise 'checked the shield. A beautiful ...'. (C2, E-0357; probed E-0377)
NordenTalkEvents_Shield::
    ld de, EVENT_SCENE_SHIELD_1E4
    call TestFlagBit
    jr c, .set_joypad_held
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_BLINK_SPRITES
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_HeroCheckedTheShield ; script '0 checked the shield. A beautiful'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $031b ; '*: If you restore this world's'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_SHIELD
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_HeroCheckedTheShield_2 ; script '0 checked the shield.'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_SceneShield
    call StartScriptAtHL_B13
    ret

.set_joypad_held:
    xor a
    set 0, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

SECTION "Bank 13 TalkMsg031E_HisMajestyHasBeenCrankyIs", ROMX

; Norden talk 21 ($15): tests story flags with TestFlagBit and shows message $0379 ('Who was that
; boy who came out of the dungeon ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message
; $0ABA ('Am I dreaming? ...') when EVENT_SCENE_REPORT_TO_KING is set; otherwise message $0358 ('...
; But the King still suspects the west...') when EVENT_SCENE_GOT_TO is set; otherwise message $031E
; ('His Majesty has been cranky...'). The message starts through StartMessageCommand09HL_B13 (script
; command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg031E_HisMajestyHasBeenCrankyIs.call_start_message_command09_hl_b133; flag 0087 then jr c,
; TalkMsg031E_HisMajestyHasBeenCrankyIs.call_start_message_command09_hl_b132; flag 0086 then jr c,
; TalkMsg031E_HisMajestyHasBeenCrankyIs.call_start_message_command09_hl_b13); starts message $031E
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'His Majesty has been
; cranky Is the' (E-0268, the E-0082 shape; was TalkMsg031E_HisMajestyHasBeenCrankyIs)
TalkMsg031E_HisMajestyHasBeenCrankyIs::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_REPORT_TO_KING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $031e ; '*: His Majesty has been cranky…'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0358 ; '*: I've heard from friends who'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0aba ; '*: Am I dreaming? Two Kings?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0379 ; '*: Who was that boy who'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg031F_AfterTheGoldDiscoveryOur", ROMX

; Norden talk 22 ($16): tests story flags with TestFlagBit and shows message $0377 ('Well, we
; managed to avoid war with the west. ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise
; message $031F ('After the gold discovery, our relationship with the west soured. ...'). The
; message starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg031F_AfterTheGoldDiscoveryOur.call_start_message_command09_hl_b13); starts message $031F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'After the gold
; discovery, our relationship with' (E-0268, the E-0082 shape; was
; TalkMsg031F_AfterTheGoldDiscoveryOur)
TalkMsg031F_AfterTheGoldDiscoveryOur::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $031f ; '*: After the gold discovery, our'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0377 ; '*: Well, we managed to avoid'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0320_IRememberTheKingToBe", ROMX

; Norden talk 23 ($17): tests story flags with TestFlagBit and shows message $0378 ('This is just
; between you and me, but the fake ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message
; $0320 ('I remember the King to be placid, but he has ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg0320_IRememberTheKingToBe.call_start_message_command09_hl_b13); starts message $0320
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I remember the King
; to be placid,' (E-0268, the E-0082 shape; was TalkMsg0320_IRememberTheKingToBe)
TalkMsg0320_IRememberTheKingToBe::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0320 ; '*: I remember the King to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0378 ; '*: This is just between you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_TwoKings", ROMX

; Norden talk 24: by story progress: $0376 after EVENT_SCENE_PLAN_RUINED_094, 'What? Why are there
; two ...' ($0ABB) after EVENT_SCENE_REPORT_TO_KING, 'We reported to the King ...' after
; EVENT_SCENE_GOT_TO, 'His Majesty is furious ...' ($0323) after EVENT_SCENE_SPIRIT_ENVOY, else 'Ah,
; you are the spirit's ...'. (C2, E-0357; probed E-0377)
NordenTalkEvents_TwoKings::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_REPORT_TO_KING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld de, EVENT_SCENE_SPIRIT_ENVOY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_AhYouAreThe ; script '*: Ah, you are the spirit's'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0323 ; '*: His Majesty is furious over'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WeReportedToThe ; script '*: We reported to the King'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0abb ; '*: What? Why are there two'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0376 ; '*: Who would've thought that a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0ABD_HeroCheckedTheBookshelfHistory", ROMX

; Norden talk 25 ($19): starts message $0ABD (the player checks the bookshelf: 'History of the Lake
; Kingdoms... The three Kingdoms surrounding the lake were once a single kingdom' ...) through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0ABD through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. History of the' (E-0268, the E-0082 shape; was
; TalkMsg0ABD_HeroCheckedTheBookshelfHistory)
TalkMsg0ABD_HeroCheckedTheBookshelfHistory::
    ld hl, $0abd ; '0 checked the bookshelf. 'History of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0ABE_HeroCheckedTheBookshelfHistory", ROMX

; Norden talk 26 ($1A): starts message $0ABE (the player checks the bookshelf: 'History of the Lake
; Kingdoms... The elemental spirit in the spring is a kind- hearted being' ...) through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0ABE through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. History of the' (E-0268, the E-0082 shape; was
; TalkMsg0ABE_HeroCheckedTheBookshelfHistory)
TalkMsg0ABE_HeroCheckedTheBookshelfHistory::
    ld hl, $0abe ; '0 checked the bookshelf. 'History of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0ABC_HeroPeeredIntoTheOvenIt", ROMX

; Norden talk 27 ($1B): starts message $0ABC (the name of the player, then 'peered into the oven. It
; felt just a little warm.') through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; starts message $0ABC through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0ABC_HeroPeeredIntoTheOvenIt)
TalkMsg0ABC_HeroPeeredIntoTheOvenIt::
    ld hl, $0abc ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0324_ThisTunnelGoesToAPort", ROMX

; Norden talk 28 ($1C): tests story flags with TestFlagBit and shows message $0AC3 ('This tunnel
; leads to a port.') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $0324 ('This tunnel goes
; to a port. ...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0324_ThisTunnelGoesToAPort.call_start_message_command09_hl_b13); starts message $0324
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'This tunnel goes to
; a port. The' (E-0268, the E-0082 shape; was TalkMsg0324_ThisTunnelGoesToAPort)
TalkMsg0324_ThisTunnelGoesToAPort::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0324 ; '*: This tunnel goes to a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ac3 ; '*: This tunnel leads to a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0325_ThisIsThePortOfNofor", ROMX

; Norden talk 29 ($1D): starts message $0325 ('This is the port of Nofor.') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0325 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the port of Nofor.' (E-0268, the E-0082 shape; was TalkMsg0325_ThisIsThePortOfNofor)
TalkMsg0325_ThisIsThePortOfNofor::
    ld hl, $0325 ; '*: This is the port of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0326_ItsUselessBeyondUselessThe", ROMX

; Norden talk 30 ($1E): tests story flags with TestFlagBit and shows message $0A0C ('The ice
; blocking the harbor finally broke up and melted away. ...') when EVENT_SCENE_SHIELD2_1E5 is set;
; otherwise message $0326 ('... Beyond useless! The ice has the port clogged. No ships can sail.').
; The message starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0326_ItsUselessBeyondUselessThe.call_start_message_command09_hl_b13); starts message $0326
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'It's useless! Beyond
; useless! The ice has' (E-0268, the E-0082 shape; was TalkMsg0326_ItsUselessBeyondUselessThe)
TalkMsg0326_ItsUselessBeyondUselessThe::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0326 ; '*: It's useless! Beyond useless! The'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a0c ; '*: The ice blocking the harbor'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0327_InAllMyYearsIve", ROMX

; Norden talk 31 ($1F): tests story flags with TestFlagBit and shows message $0AC4 ('The ice melted
; away! ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $0327 ('In all my years, ...').
; The message starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0327_InAllMyYearsIve.call_start_message_command09_hl_b13); starts message $0327 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'In all my years, I've never'
; (E-0268, the E-0082 shape; was TalkMsg0327_InAllMyYearsIve) (E-0324: was
; TalkMsg0327_InAllMyYearsIve; read before $42 was known as 'v)
TalkMsg0327_InAllMyYearsIve::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0327 ; '*: In all my years, I've'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ac4 ; '*: The ice melted away! The'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0328_ThreeKingdomsRingThisLake", ROMX

; Norden talk 32 ($20): starts message $0328 ('Three kingdoms ring this lake. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0328 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Three kingdoms ring this lake. They are' (E-0268, the E-0082 shape; was
; TalkMsg0328_ThreeKingdomsRingThisLake)
TalkMsg0328_ThreeKingdomsRingThisLake::
    ld hl, $0328 ; '*: Three kingdoms ring this lake.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0329_TheBorderItsNotHereThe", ROMX

; Norden talk 33 ($21): tests story flags with TestFlagBit and shows message $0A0D ('The long winter
; seems to be over. ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $0329 ('The border?
; ...'). The message starts through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0329_TheBorderItsNotHereThe.call_start_message_command09_hl_b13); starts message $0329
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The border? It's not
; here. The border' (E-0268, the E-0082 shape; was TalkMsg0329_TheBorderItsNotHereThe)
TalkMsg0329_TheBorderItsNotHereThe::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0329 ; '*: The border? It's not here.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a0d ; '*: The long winter seems to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032A_MamaSaidToStayOffThe", ROMX

; Norden talk 34 ($22): starts message $032A ('Mama said to stay off the ice. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $032A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Mama said to stay off the ice.' (E-0268, the E-0082 shape; was TalkMsg032A_MamaSaidToStayOffThe)
TalkMsg032A_MamaSaidToStayOffThe::
    ld hl, $032a ; '*: Mama said to stay off'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032B_WeWerePassingThroughFrom", ROMX

; Norden talk 35 ($23): tests story flags with TestFlagBit and shows message $0A0E ('We were
; visiting from the east. ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $032B ('We
; were passing through from the east, but the ice ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg032B_WeWerePassingThroughFrom.call_start_message_command09_hl_b13); starts message $032B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'We were passing
; through from the east,' (E-0268, the E-0082 shape; was TalkMsg032B_WeWerePassingThroughFrom)
TalkMsg032B_WeWerePassingThroughFrom::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $032b ; '*: We were passing through from'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a0e ; '*: We were visiting from the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032C_TheyDiscoveredGoldAtTheMine", ROMX

; Norden talk 36 ($24): tests story flags with TestFlagBit and shows message $037B ('The discovery
; of gold was a bust...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message $032C ('They
; discovered gold at the mine on the western border! ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg032C_TheyDiscoveredGoldAtTheMine.call_start_message_command09_hl_b13); starts message $032C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'They discovered gold
; at the mine on' (E-0268, the E-0082 shape; was TalkMsg032C_TheyDiscoveredGoldAtTheMine)
TalkMsg032C_TheyDiscoveredGoldAtTheMine::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $032c ; '*: They discovered gold at the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $037b ; '*: The discovery of gold was'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032D_IHearTheWestAndThe", ROMX

; Norden talk 37 ($25): tests story flags with TestFlagBit and shows message $0DF5 ('The kingdoms of
; the north and west have reconciled from ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise
; message $032D ('I hear the west and the north are locking horns ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg032D_IHearTheWestAndThe.call_start_message_command09_hl_b13); starts message $032D through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'I hear the west and the
; north' (E-0268, the E-0082 shape; was TalkMsg032D_IHearTheWestAndThe)
TalkMsg032D_IHearTheWestAndThe::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $032d ; '*: I hear the west and'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0df5 ; '*: The kingdoms of the north'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032E_DoYouKnowLadyYunaOf", ROMX

; Norden talk 38 ($26): starts message $032E ('Do you know Lady Yuna of the west? ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $032E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Do you know Lady Yuna of the' (E-0268, the E-0082 shape; was TalkMsg032E_DoYouKnowLadyYunaOf)
TalkMsg032E_DoYouKnowLadyYunaOf::
    ld hl, $032e ; '*: Do you know Lady Yuna'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg032F_TheScholarInTheTavernSaid", ROMX

; Norden talk 39 ($27): tests story flags with TestFlagBit and shows message $0DF6 ('The scholar who
; was in the tavern? ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $032F ('The
; scholar in the tavern said he came from the eastern kingdom. ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg032F_TheScholarInTheTavernSaid.call_start_message_command09_hl_b13); starts message $032F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The scholar in the
; tavern said he' (E-0268, the E-0082 shape; was TalkMsg032F_TheScholarInTheTavernSaid)
TalkMsg032F_TheScholarInTheTavernSaid::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $032f ; '*: The scholar in the tavern'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0df6 ; '*: The scholar who was in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0330_DontYouThinkItsTooExpensive", ROMX

; Norden talk 40 ($28): starts message $0330 (too expensive ... 'If I had a Gold Pass' ...) through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0330 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Don't you think it's too expensive? If' (E-0268, the E-0082 shape; was
; TalkMsg0330_DontYouThinkItsTooExpensive)
TalkMsg0330_DontYouThinkItsTooExpensive::
    ld hl, $0330 ; '*: Don't you think it's too'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shop0A", ROMX

; Norden talk 41, a shop: shop $0A with scripts in bank $10, 'Welcome! What can I do ...'. (C2,
; E-0357; probed E-0377)
NordenTalkEvents_Shop0A::
    ld a, $0a
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeWhatCanI ; script '*: Welcome! What can I do'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shop08", ROMX

; Norden talk 42, a shop: shop 8 with scripts in bank $10, 'Greetings! How shall I serve ...'. (C2,
; E-0357; probed E-0377)
NordenTalkEvents_Shop08::
    ld a, $08
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_GreetingsHowShallI ; script '*: Greetings! How shall I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shop09", ROMX

; Norden talk 43, a shop: shop 9 with scripts in bank $10, 'Hello! Have a look at ...'. (C2, E-0357;
; probed E-0377)
NordenTalkEvents_Shop09::
    ld a, $09
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_HelloHaveALook ; script '*: Hello! Have a look at'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HowMayOurChurchServeYou_2", ROMX

; Norden talk 44 ($2C): sets wDataBank = $1F, then starts Script_HowMayOurChurch_2 (message word
; $4820, 'How may our church serve you?'), which jumps to Script_Priest in the data bank through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch_2 (StartScriptAtHL_B13); its first
; message begins 'How may our church serve you?' (E-0271; was Talk_HowMayOurChurchServeYou_2)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_HowMayOurChurchServeYou_2; shortened from TalkScript_HowMayOurChurchServeYou_2)
; starts Script_HowMayOurChurch_2: '*: How may our church serve' (E-0248)
Talk_HowMayOurChurchServeYou_2::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch_2 ; script '*: How may our church serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0312_HeroPeeredIntoTheBarrelIt", ROMX

; Norden talk 45 ($2D): starts message $0312 (the name of the player, then 'peered into the barrel.
; It was filled with black rocks.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0312 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg0312_HeroPeeredIntoTheBarrelIt)
TalkMsg0312_HeroPeeredIntoTheBarrelIt::
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0D3B_Whinny", ROMX

; Norden talk 46 ($2E): starts message $0D3B ('Whinny!') through StartMessageCommand09HL_B13 (script
; command $09, wModeState = 1). (C2, E-0377)
; starts message $0D3B through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Whinny!' (E-0268, the E-0082 shape; was TalkMsg0D3B_Whinny)
TalkMsg0D3B_Whinny::
    ld hl, $0d3b ; '*: Whinny!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0314_HeroTriedToOpenTheChest_13_2", ROMX

; Norden talk 47 ($2F): starts message $0314 (the name of the player, then 'tried to open the chest.
; But the treasure chest was locked.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0314 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0314_HeroTriedToOpenTheChest_13_2) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0314_HeroTriedToOpenTheChest_13_2)
TalkMsg0314_HeroTriedToOpenTheChest_13_2::
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0313_HeroPeeredIntoTheOvenIt_13", ROMX

; Norden talk 48 ($30): starts message $0313 (the name of the player, then 'peered into the oven. It
; felt just a little warm.') through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; starts message $0313 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0313_HeroPeeredIntoTheOvenIt_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0313_HeroPeeredIntoTheOvenIt_13)
TalkMsg0313_HeroPeeredIntoTheOvenIt_13::
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0334_WeveBeenFullUpWith", ROMX

; Norden talk 49 ($31): tests story flags with TestFlagBit and shows message $0A0F ('... the sailors
; went away with it...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $0334 ('... I can
; understand why a landlocked sailor would be down, but...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0334_WeveBeenFullUpWith.call_start_message_command09_hl_b13); starts message $0334 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'We've been full up with
; sailors' (E-0268, the E-0082 shape; was TalkMsg0334_WeveBeenFullUpWith) (E-0324: was
; TalkMsg0334_WeveBeenFullUpWith; read before $42 was known as 'v)
TalkMsg0334_WeveBeenFullUpWith::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0334 ; '*: We've been full up with'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a0f ; '*: When the harbor's ice disappeared,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0335_UrrrpHooListenToThisMy", ROMX

; Norden talk 50 ($32): starts message $0335 ('Urrrp! Hoo, listen to this! My ship, she froze solid
; in ice, hey?') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; starts message $0335 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Urrrp! Hoo, listen to this! My ship,' (E-0268, the E-0082 shape; was
; TalkMsg0335_UrrrpHooListenToThisMy)
TalkMsg0335_UrrrpHooListenToThisMy::
    ld hl, $0335 ; '*: Urrrp! Hoo, listen to this!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0336_SighIsntThatScholarAppealing", ROMX

; Norden talk 51 ($33): tests story flags with TestFlagBit and shows message $0A10 ('Welcome! Oh?
; Hi, there! ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $0336 ('... The intellect
; in his eyes...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0336_SighIsntThatScholarAppealing.call_start_message_command09_hl_b13); starts message
; $0336 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Sigh Isn't
; that scholar appealing? The intellect' (E-0268, the E-0082 shape; was
; TalkMsg0336_SighIsntThatScholarAppealing)
TalkMsg0336_SighIsntThatScholarAppealing::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0336 ; '*: …Sigh… Isn't that scholar appealing?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a10 ; '*: Welcome! Oh? Hi, there! Well,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0337_ICameFromTheEasternKingdom", ROMX

; Norden talk 52 ($34): before EVENT_SCENE_PRINCESS_MEDICINE_09D shows message $0337 ('I came from
; the eastern kingdom.'). After it, searches wInventory for item $34 (ITEM_SLEEPHERB) with
; FindTemp0InInventoryList: carrying it shows message $0D20 ('Oh! That blue flower! ...'); without
; it shows message $0AE6 ('... SleepHerb is the one plant that assures a deep and dreamless sleep.')
; and sets EVENT_ICAME_FROM_THE_EASTERN_KINGDOM. Each message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c, TalkMsg0337_ICameFromTheEasternKingdom.set_temp0_to_34);
; starts message $0337 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I came from the eastern kingdom. I'm' (E-0268, the E-0082 shape; was
; TalkMsg0337_ICameFromTheEasternKingdom)
TalkMsg0337_ICameFromTheEasternKingdom::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .set_temp0_to_34
    ld hl, $0337 ; '*: I came from the eastern'
    call StartMessageCommand09HL_B13
    ret

.set_temp0_to_34:
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_message_command09_hl_b13
    ld hl, $0ae6 ; '*: I've traveled far to study'
    call StartMessageCommand09HL_B13
    ld de, EVENT_ICAME_FROM_THE_EASTERN_KINGDOM
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d20 ; '*: Oh! That blue flower! It's'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0ABF_HeroPeeredIntoTheBarrelIt", ROMX

; Norden talk 53 ($35): starts message $0ABF (the name of the player, then 'peered into the barrel.
; It was filled with a noxious fluid.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0ABF through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg0ABF_HeroPeeredIntoTheBarrelIt)
; starts Script_WelcomeToOurInn_6: '*: Welcome to our inn!' (E-0248)
TalkMsg0ABF_HeroPeeredIntoTheBarrelIt::
    ld hl, $0abf ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_SecondInn", ROMX

; Norden talk 54, an inn: starts Script_WelcomeToOurInn_6 ('Welcome to our inn!', then a jump to the
; inn script Script_It_3 in the data bank) and sets wDataBank = $10 for that jump. (C2, E-0370;
; probed E-0377)
; starts Script_WelcomeToOurInn_6: '*: Welcome to our inn!' (E-0248)
NordenTalkEvents_SecondInn::
    ld hl, Script_WelcomeToOurInn_6 ; script '*: Welcome to our inn!'
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 13 TalkMsg0338_TheKingOfTheWestIs", ROMX

; Norden talk 55 ($37): starts message $0338 ('The King of the west is said to dote on ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0338 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The King of the west is said' (E-0268, the E-0082 shape; was TalkMsg0338_TheKingOfTheWestIs)
TalkMsg0338_TheKingOfTheWestIs::
    ld hl, $0338 ; '*: The King of the west'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0339_ThisIsTheBorderWeShare", ROMX

; Norden talk 56 ($38): tests story flags with TestFlagBit and shows message $034E ('We almost went
; to war with the west over a ...') when EVENT_SCENE_GOT_TO is set; otherwise message $0339 ('This
; is the border we share with the western kingdom. ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg0339_ThisIsTheBorderWeShare.call_start_message_command09_hl_b13); starts message $0339
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'This is the border
; we share with' (E-0268, the E-0082 shape; was TalkMsg0339_ThisIsTheBorderWeShare)
TalkMsg0339_ThisIsTheBorderWeShare::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0339 ; '*: This is the border we'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $034e ; '*: We almost went to war'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033A_TheBorderHasBeenSealedBy", ROMX

; Norden talk 57 ($39): tests story flags with TestFlagBit and shows message $037C ('The King gave
; word to lift the blockade of the border. ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise
; message $034F ('The King has sealed the border. ...') when EVENT_SCENE_GOT_TO is set; otherwise
; message $033A ('The border has been sealed by the ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg033A_TheBorderHasBeenSealedBy.call_start_message_command09_hl_b132; flag 0086 then jr c,
; TalkMsg033A_TheBorderHasBeenSealedBy.call_start_message_command09_hl_b13); starts message $033A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The border has been
; sealed by the' (E-0268, the E-0082 shape; was TalkMsg033A_TheBorderHasBeenSealedBy)
TalkMsg033A_TheBorderHasBeenSealedBy::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033a ; '*: The border has been sealed'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $034f ; '*: The King has sealed the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $037c ; '*: The King gave word to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033B_ATravelerAreYouSorryBut", ROMX

; Norden talk 58 ($3A): tests story flags with TestFlagBit and shows message $037D ('A monster was
; playing the part of our King...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message $0350
; ('... This, despite the absence of gold.') when EVENT_SCENE_GOT_TO is set; otherwise message $033B
; ('A traveler, are you? ...'). The message starts through StartMessageCommand09HL_B13 (script
; command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg033B_ATravelerAreYouSorryBut.call_start_message_command09_hl_b132; flag 0086 then jr c,
; TalkMsg033B_ATravelerAreYouSorryBut.call_start_message_command09_hl_b13); starts message $033B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'A traveler, are you?
; Sorry, but I' (E-0268, the E-0082 shape; was TalkMsg033B_ATravelerAreYouSorryBut)
TalkMsg033B_ATravelerAreYouSorryBut::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033b ; '*: A traveler, are you? Sorry,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0350 ; '*: We're still under orders to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $037d ; '*: A monster was playing the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033C_OurTunnelingFoundGoldBut", ROMX

; Norden talk 59 ($3B): tests story flags with TestFlagBit and shows message $0351 ('Was that really
; all the gold? ...') when EVENT_SCENE_GOT_TO is set; otherwise message $033C ('Our tunneling found
; gold, but we also ran into the ...'). The message starts through StartMessageCommand09HL_B13
; (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg033C_OurTunnelingFoundGoldBut.call_start_message_command09_hl_b13); starts message $033C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our tunneling found
; gold, but we also' (E-0268, the E-0082 shape; was TalkMsg033C_OurTunnelingFoundGoldBut)
TalkMsg033C_OurTunnelingFoundGoldBut::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033c ; '*: Our tunneling found gold, but'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0351 ; '*: Was that really all the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033D_ThisSideIsTheWesternKingdom", ROMX

; Norden talk 60 ($3C): tests story flags with TestFlagBit and shows message $0D1C ('The King of the
; north was a fake, or so ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message $0352
; ('... There was almost no gold at all.') when EVENT_SCENE_GOT_TO is set; otherwise message $033D
; ('This side is the western kingdom! ...'). The message starts through StartMessageCommand09HL_B13
; (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg033D_ThisSideIsTheWesternKingdom.call_start_message_command09_hl_b132; flag 0086 then jr c,
; TalkMsg033D_ThisSideIsTheWesternKingdom.call_start_message_command09_hl_b13); starts message $033D
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'This side is the
; western kingdom! You' (E-0268, the E-0082 shape; was TalkMsg033D_ThisSideIsTheWesternKingdom)
TalkMsg033D_ThisSideIsTheWesternKingdom::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033d ; '*: This side is the western'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0352 ; '*: I've heard… There was almost'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0d1c ; '*: The King of the north'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033E_TheNorthernersWantOurGold", ROMX

; Norden talk 61 ($3D): tests story flags with TestFlagBit and shows message $0D1D ('If you go
; south, ...') when EVENT_SCENE_PLAN_RUINED_094 is set; otherwise message $0353 ('... King still
; suspects us.') when EVENT_SCENE_GOT_TO is set; otherwise message $033E ('The northerners want our
; gold! ...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 0094 then jr c,
; TalkMsg033E_TheNorthernersWantOurGold.call_start_message_command09_hl_b132; flag 0086 then jr c,
; TalkMsg033E_TheNorthernersWantOurGold.call_start_message_command09_hl_b13); starts message $033E
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The northerners want
; our gold! There's no' (E-0268, the E-0082 shape; was TalkMsg033E_TheNorthernersWantOurGold)
TalkMsg033E_TheNorthernersWantOurGold::
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033e ; '*: The northerners want our gold!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0353 ; '*: The north's King still suspects'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0d1d ; '*: If you go south, you'll'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg033F_TheNorthernersMuscledInOn", ROMX

; Norden talk 62 ($3E): tests story flags with TestFlagBit and shows message $0354 ('... keep
; picking away.') when EVENT_SCENE_GOT_TO is set; otherwise message $033F ('The northerners muscled
; in on the gold mine that we discovered. ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0086 then jr c,
; TalkMsg033F_TheNorthernersMuscledInOn.call_start_message_command09_hl_b13); starts message $033F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The northerners
; muscled in on the gold' (E-0268, the E-0082 shape; was TalkMsg033F_TheNorthernersMuscledInOn)
TalkMsg033F_TheNorthernersMuscledInOn::
    ld de, EVENT_SCENE_GOT_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $033f ; '*: The northerners muscled in on'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0354 ; '*: We're not certain about what'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0340_HehYouveComeWayDown", ROMX

; Norden talk 63 ($3F): starts message $0340 ('Heh, ... The monsters are tough down here!') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0340 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Heh, you've come way down deep.' (E-0268, the E-0082 shape; was TalkMsg0340_HehYouveComeWayDown)
; (E-0324: was TalkMsg0340_HehYouveComeWayDown; read before $42 was known as 'v)
TalkMsg0340_HehYouveComeWayDown::
    ld hl, $0340 ; '*: Heh, you've come way down'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0345_KidYouHaveGutsToBe", ROMX

; Norden talk 64 ($40): starts message $0345 ('Kid, you have guts to be here.') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0345 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Kid, you have guts to be here.' (E-0268, the E-0082 shape; was TalkMsg0345_KidYouHaveGutsToBe)
TalkMsg0345_KidYouHaveGutsToBe::
    ld hl, $0345 ; '*: Kid, you have guts to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0341_ThereIsABoulderBlockingThe", ROMX

; Norden talk 65 ($41): starts message $0341 ('There is a boulder blocking the way a little further
; ahead. ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; starts message $0341 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There is a boulder blocking the way' (E-0268, the E-0082 shape; was
; TalkMsg0341_ThereIsABoulderBlockingThe)
TalkMsg0341_ThereIsABoulderBlockingThe::
    ld hl, $0341 ; '*: There is a boulder blocking'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0342_HurryWeHaveToBeatThe", ROMX

; Norden talk 66 ($42): starts message $0342 ('Hurry! We have to beat the swine of the west to the
; mine!') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0342 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Hurry! We have to beat the swine' (E-0268, the E-0082 shape; was
; TalkMsg0342_HurryWeHaveToBeatThe)
TalkMsg0342_HurryWeHaveToBeatThe::
    ld hl, $0342 ; '*: Hurry! We have to beat'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0344_TheGoldIsOursTheWest", ROMX

; Norden talk 67 ($43): starts message $0344 ('The gold is ours! ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0344 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The gold is ours! The west must' (E-0268, the E-0082 shape; was TalkMsg0344_TheGoldIsOursTheWest)
TalkMsg0344_TheGoldIsOursTheWest::
    ld hl, $0344 ; '*: The gold is ours! The'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0343_TheVeinOfGoldIsJust", ROMX

; Norden talk 68 ($44): starts message $0343 ('The vein of gold is just ahead! ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0343 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The vein of gold is just ahead!' (E-0268, the E-0082 shape; was TalkMsg0343_TheVeinOfGoldIsJust)
; starts Script_WhatWhatWasThat: '*: What? What was that explosion?' (E-0248)
TalkMsg0343_TheVeinOfGoldIsJust::
    ld hl, $0343 ; '*: The vein of gold is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_WhatWhatWasThatExplosion", ROMX

; Norden talk 69 ($45): starts Script_WhatWhatWasThat (sound $65, SCRIPT_SCENE_EXPLOSION, walks of
; objects 1 and 2, messages $0349-$034D from 'What? What was that explosion?', then
; SCRIPT_SCENE_GOT_TO and EVENT_SCENE_GOT_TO set) through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_WhatWhatWasThat (StartScriptAtHL_B13); its first message begins 'What? What was that
; explosion?' (E-0271; was Talk_WhatWhatWasThatExplosion) (E-0344: the address in its name dropped
; or read as the label there; was Talk_WhatWhatWasThatExplosion; shortened from
; TalkScript_WhatWhatWasThatExplosion)
; starts Script_WhatWhatWasThat: '*: What? What was that explosion?' (E-0248)
Talk_WhatWhatWasThatExplosion::
    ld hl, Script_WhatWhatWasThat ; script '*: What? What was that explosion?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_WhatWhatWasThatExplosion_2", ROMX

; Norden talk 70 ($46): starts Script_WhatWhatWasThat_2 (Script_WhatWhatWasThat without its first
; sound: SCRIPT_SCENE_EXPLOSION, walks, messages $0349-$034D from 'What? What was that explosion?',
; then SCRIPT_SCENE_GOT_TO and EVENT_SCENE_GOT_TO set) through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_WhatWhatWasThat_2 (StartScriptAtHL_B13); its first message begins 'What? What was
; that explosion?' (E-0271; was Talk_WhatWhatWasThatExplosion_2) (E-0344: the address in its name
; dropped or read as the label there; was Talk_WhatWhatWasThatExplosion_2; shortened from
; TalkScript_WhatWhatWasThatExplosion_2)
; starts Script_WhatWhatWasThat_2: '*: What? What was that explosion?' (E-0248)
Talk_WhatWhatWasThatExplosion_2::
    ld hl, Script_WhatWhatWasThat_2 ; script '*: What? What was that explosion?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_VITbelt", ROMX

; Norden talk 71 ($47), a one-time treasure chest: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_VITBELT ($40) and story
; flag $0084 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the first
; time (group-0 message $A0), shows $A1 once the flag is set and $A2 when there is no room. (C2,
; E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $40, story flag $0084 in DE: when the flag is clear it gives item $40 (VITbelt) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_VITbelt)
ChestItem_VITbelt::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $40
    ld [wScriptParam1], a
    ld de, $0084
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowAhSavedAtLast", ROMX

; Norden talk 72, the king in the cell: by story progress $0AC2, $0375, 'Awaaargh! A m-m-monster!'
; ($0373) after the plan is ruined; before that a run of pleas set in turn by flags: 'Ah, saved at
; last!' ($035C), $035D, then after EVENT_SCENE_REAL_KING 'I'm real!' ($0367), $0368, $0369 and
; $036A. (C2, E-0357; probed E-0377)
NordenTalkEvents_ShowAhSavedAtLast::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b138
    ld de, EVENT_SCENE_PLAN_RUINED_094
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b137
    ld de, EVENT_SCENE_PLAN_RUINED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld de, EVENT_AH_SAVED_AT_LAST_08E
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_AH_SAVED_AT_LAST_08D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_AH_SAVED_AT_LAST_08C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_REAL_KING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_AH_SAVED_AT_LAST
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $035c ; '*: Ah, saved at last! The'
    call StartMessageCommand09HL_B13
    ld de, EVENT_AH_SAVED_AT_LAST
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $035d ; '*: I want to get out,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0367 ; '*: I'm real! Don't you believe'
    call StartMessageCommand09HL_B13
    ld de, EVENT_AH_SAVED_AT_LAST_08C
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0368 ; '*: Look in my eyes! I'm'
    call StartMessageCommand09HL_B13
    ld de, EVENT_AH_SAVED_AT_LAST_08D
    call SetFlagBit
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0369 ; '*: If you can't see the'
    call StartMessageCommand09HL_B13
    ld de, EVENT_AH_SAVED_AT_LAST_08E
    call SetFlagBit
    ret

.call_start_message_command09_hl_b135:
    ld hl, $036a ; '*: Didn't we work together to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0373 ; '*: Awaaargh! A m-m-monster! A monster'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b137:
    ld hl, $0375 ; 'King: I'll have the border opened.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b138:
    ld hl, $0ac2 ; 'King: The spirit made it possible'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowKamehaWheresTheExit", ROMX

; Norden talk 73: Kameha's 'Where's the exit? We'll starve ...' ($035E the first time, setting
; EVENT_KAMEHA_WHERES_THE_EXIT, then $035F). (C2, E-0357; probed E-0377)
NordenTalkEvents_ShowKamehaWheresTheExit::
    ld de, EVENT_KAMEHA_WHERES_THE_EXIT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $035e ; 'Kameha: Where's the exit? We'll starve'
    call StartMessageCommand09HL_B13
    ld de, EVENT_KAMEHA_WHERES_THE_EXIT
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $035f ; 'Kameha: Where's the exit? We'll starve'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HeroTappedOnTheWallThe", ROMX

; Norden talk 74 ($4A): starts Script_HeroTappedOnThe (message $0360, the player 'tapped on the
; wall. The wall sounded heavy and solid.', a face command, then SCRIPT_SCENE_WALL_EXIT) through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; starts Script_HeroTappedOnThe (StartScriptAtHL_B13); its first message begins '0 tapped on the
; wall. The' (E-0271; was Talk_HeroTappedOnTheWallThe) (E-0344: the address in its name dropped or
; read as the label there; was Talk_HeroTappedOnTheWallThe; shortened from
; TalkScript_HeroTappedOnTheWallThe)
; starts Script_HeroTappedOnThe: '0 tapped on the wall. The' (E-0248)
Talk_HeroTappedOnTheWallThe::
    ld hl, Script_HeroTappedOnThe ; script '0 tapped on the wall. The'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HeroTappedOnTheWallSound", ROMX

; Norden talk 75 ($4B): starts Script_HeroTappedOnThe_2 (message $0363, the player 'tapped on the
; wall. Sound echoed as if it were hollow.', SCRIPT_SCENE_WALL_EXIT, Kameha message $0364, walks,
; hides objects 1 and 0, sets EVENT_SCENE_WALL_EXIT) through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_HeroTappedOnThe_2 (StartScriptAtHL_B13); its first message begins '0 tapped on the
; wall. Sound' (E-0271; was Talk_HeroTappedOnTheWallSound) (E-0344: the address in its name dropped
; or read as the label there; was Talk_HeroTappedOnTheWallSound; shortened from
; TalkScript_HeroTappedOnTheWallSound)
; starts Script_HeroTappedOnThe_2: '0 tapped on the wall. Sound' (E-0248)
Talk_HeroTappedOnTheWallSound::
    ld hl, Script_HeroTappedOnThe_2 ; script '0 tapped on the wall. Sound'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_ImTheRealKingYouFake", ROMX

; Norden talk 76 ($4C): starts Script_I_14 (SCRIPT_SCENE_REAL_KING, messages $0365 and $0366 from
; the two kings, 'How dare you, impostor!', then it sets EVENT_SCENE_REAL_KING) through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; starts Script_I_14 (StartScriptAtHL_B13); its first message begins 'I'm the real King, you fake!'
; (E-0271; was Talk_ImTheRealKingYouFake) (E-0344: the address in its name dropped or read as the
; label there; was Talk_ImTheRealKingYouFake; shortened from TalkScript_ImTheRealKingYouFake)
; starts Script_I_14: '*: I'm the real King, you' (E-0248)
Talk_ImTheRealKingYouFake::
    ld hl, Script_I_14 ; script '*: I'm the real King, you'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowIAmRealDont", ROMX

; Norden talk 77, the false king: after EVENT_SCENE_PLAN_RUINED the script 'It almost worked to
; perfection!'; before it a run of claims set in turn by flags ('I am real! Don't believe ...'
; $036C, $036D, $036E, $036F), then the script 'Arrgh, you've ruined my plan ...'. (C2, E-0357;
; probed E-0377)
NordenTalkEvents_ShowIAmRealDont::
    ld de, EVENT_SCENE_PLAN_RUINED
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld de, EVENT_IAM_REAL_DONT_092
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld de, EVENT_IAM_REAL_DONT_091
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_IAM_REAL_DONT_090
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_IAM_REAL_DONT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $036c ; '*: I am real! Don't believe'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IAM_REAL_DONT
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $036d ; '*: My regal bearing should be'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IAM_REAL_DONT_090
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $036e ; '*: Look at him! He's grimy!'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IAM_REAL_DONT_091
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $036f ; '*: You suspect me still? Kiki!'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IAM_REAL_DONT_092
    call SetFlagBit
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_ArrghYou ; script '*: Arrgh, you've ruined my plan'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_ItAlmostWorkedTo ; script '*: It almost worked to perfection!'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg037E_ThisIsTheTownOfWeston", ROMX

; Norden talk 78 ($4E): starts message $037E ('This is the town of Weston. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $037E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the town of Weston. It's' (E-0268, the E-0082 shape; was
; TalkMsg037E_ThisIsTheTownOfWeston)
TalkMsg037E_ThisIsTheTownOfWeston::
    ld hl, $037e ; '*: This is the town of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg037F_TheWestsCastleHasSeenA", ROMX

; Norden talk 79 ($4F): tests story flags with TestFlagBit and shows message $0D3D ('They say Lady
; Yuna is back to her usual cheerful self. ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise
; message $037F ('... castle has seen a steady stream of visitors and gifts.' and a reward for
; cheering up Lady Yuna). The message starts through StartMessageCommand09HL_B13 (script command
; $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg037F_TheWestsCastleHasSeenA.call_start_message_command09_hl_b13); starts message $037F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The west's castle
; has seen a steady' (E-0268, the E-0082 shape; was TalkMsg037F_TheWestsCastleHasSeenA)
TalkMsg037F_TheWestsCastleHasSeenA::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $037f ; '*: The west's castle has seen'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d3d ; '*: They say Lady Yuna is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0380_AcrossFromUsOnTheLake", ROMX

; Norden talk 80 ($50): tests story flags with TestFlagBit and shows message $0A11 ('... Rumor has
; it that Queen Helen has recovered from her illness.') when EVENT_SCENE_SHIELD2_1E5 is set;
; otherwise message $0380 ('Across from us on the lake is the eastern kingdom. ...'). The message
; starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0380_AcrossFromUsOnTheLake.call_start_message_command09_hl_b13); starts message $0380
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Across from us on
; the lake is' (E-0268, the E-0082 shape; was TalkMsg0380_AcrossFromUsOnTheLake)
TalkMsg0380_AcrossFromUsOnTheLake::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0380 ; '*: Across from us on the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a11 ; '*: The eastern kingdom's castle is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0381_ISawLadyYunaRidingTowards", ROMX

; Norden talk 81 ($51): starts message $0381 ('I saw Lady Yuna riding towards the forest in the
; southeast. ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; starts message $0381 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I saw Lady Yuna riding towards the' (E-0268, the E-0082 shape; was
; TalkMsg0381_ISawLadyYunaRidingTowards)
TalkMsg0381_ISawLadyYunaRidingTowards::
    ld hl, $0381 ; '*: I saw Lady Yuna riding'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0382_LadyYunaHasBeenALively", ROMX

; Norden talk 82 ($52): tests story flags with TestFlagBit and shows message $0DC8 ('Lady Yuna has
; always been highly energetic and rambunctious. ...') when EVENT_SCENE_PRINCESS_MEDICINE_09D is
; set; otherwise message $0382 ('Lady Yuna has been a lively girl for as long ...'). The message
; starts through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0382_LadyYunaHasBeenALively.call_start_message_command09_hl_b13); starts message $0382
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Lady Yuna has been a
; lively girl' (E-0268, the E-0082 shape; was TalkMsg0382_LadyYunaHasBeenALively)
TalkMsg0382_LadyYunaHasBeenALively::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0382 ; '*: Lady Yuna has been a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0dc8 ; '*: Lady Yuna has always been'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0383_IHaventBeenSeeingTooMany", ROMX

; Norden talk 83 ($53): tests story flags with TestFlagBit and shows message $0A12 ('The harbor has
; been busy with boats coming and going recently. ...') when EVENT_SCENE_SHIELD2_1E5 is set;
; otherwise message $0383 ('... I wonder why that could be.'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0383_IHaventBeenSeeingTooMany.call_start_message_command09_hl_b13); starts message $0383
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I haven't been
; seeing too many ships' (E-0268, the E-0082 shape; was TalkMsg0383_IHaventBeenSeeingTooMany)
TalkMsg0383_IHaventBeenSeeingTooMany::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0383 ; '*: I haven't been seeing too'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a12 ; '*: The harbor has been busy'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0384_LadyYunaIsSaidToBe", ROMX

; Norden talk 84 ($54): tests story flags with TestFlagBit and shows message $0D22 ('Out at the
; western castle, I heard that no one ...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message
; $0AE0 ('Lady Yuna seems to be her cheerful old self again. ...') when
; EVENT_SCENE_PRINCESS_MEDICINE_09D is set; otherwise message $0384 ('Lady Yuna is said to be quiet
; and withdrawn these days. ...'). The message starts through StartMessageCommand09HL_B13 (script
; command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0384_LadyYunaIsSaidToBe.call_start_message_command09_hl_b132; flag 009D then jr c,
; TalkMsg0384_LadyYunaIsSaidToBe.call_start_message_command09_hl_b13); starts message $0384 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'Lady Yuna is said to be
; quiet' (E-0268, the E-0082 shape; was TalkMsg0384_LadyYunaIsSaidToBe)
TalkMsg0384_LadyYunaIsSaidToBe::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0384 ; '*: Lady Yuna is said to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ae0 ; '*: Lady Yuna seems to be'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0d22 ; '*: Out at the western castle,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0385_IveHeardRumorsThatSomething", ROMX

; Norden talk 85 ($55): tests story flags with TestFlagBit and shows message $0DF3 ('Lady Yuna has
; come out of her depression. ...') when EVENT_SCENE_PRINCESS_MEDICINE_09D is set; otherwise message
; $0385 ('... I wonder what it could be?'). The message starts through StartMessageCommand09HL_B13
; (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0385_IveHeardRumorsThatSomething.call_start_message_command09_hl_b13); starts message $0385
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I've heard rumors
; that something is' (E-0268, the E-0082 shape; was TalkMsg0385_IveHeardRumorsThatSomething)
; (E-0324: was TalkMsg0385_IveHeardRumorsThatSomething; read before $42 was known as 'v)
TalkMsg0385_IveHeardRumorsThatSomething::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0385 ; '*: I've heard rumors that something'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0df3 ; '*: Lady Yuna has come out'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0386_TheKingDotesOverLadyYuna", ROMX

; Norden talk 86 ($56): starts message $0386 ('The King dotes over Lady Yuna. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0386 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The King dotes over Lady Yuna. He' (E-0268, the E-0082 shape; was
; TalkMsg0386_TheKingDotesOverLadyYuna)
TalkMsg0386_TheKingDotesOverLadyYuna::
    ld hl, $0386 ; '*: The King dotes over Lady'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0387_TheRoadToTheEasternKingdom", ROMX

; Norden talk 87 ($57): starts message $0387 ('The road to the eastern kingdom is teeming with tough
; monsters. ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2,
; E-0377)
; starts message $0387 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The road to the eastern kingdom is' (E-0268, the E-0082 shape; was
; TalkMsg0387_TheRoadToTheEasternKingdom)
TalkMsg0387_TheRoadToTheEasternKingdom::
    ld hl, $0387 ; '*: The road to the eastern'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0388_LadyYunaLocksHerselfInHer", ROMX

; Norden talk 88 ($58): tests story flags with TestFlagBit and shows message $0AE1 ('Lady Yuna tries
; to bolt from the Castle every day. ...') when EVENT_SCENE_PRINCESS_MEDICINE_09D is set; otherwise
; message $0388 ('Lady Yuna locks herself in her room all day long and ...'). The message starts
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0388_LadyYunaLocksHerselfInHer.call_start_message_command09_hl_b13); starts message $0388
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Lady Yuna locks
; herself in her room' (E-0268, the E-0082 shape; was TalkMsg0388_LadyYunaLocksHerselfInHer)
TalkMsg0388_LadyYunaLocksHerselfInHer::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0388 ; '*: Lady Yuna locks herself in'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ae1 ; '*: Lady Yuna tries to bolt'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0389_IfYouCanCheerUpThe", ROMX

; Norden talk 89 ($59): tests story flags with TestFlagBit and shows message $0AE2 ('All the people
; swarming to the Castle have gone away...') when EVENT_SCENE_PRINCESS_MEDICINE_09D is set;
; otherwise message $0389 ('If you can cheer up the princess, you can earn ...'). The message starts
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0389_IfYouCanCheerUpThe.call_start_message_command09_hl_b13); starts message $0389 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'If you can cheer up the
; princess,' (E-0268, the E-0082 shape; was TalkMsg0389_IfYouCanCheerUpThe)
TalkMsg0389_IfYouCanCheerUpThe::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0389 ; '*: If you can cheer up'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ae2 ; '*: All the people swarming to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg038A_AWoodsmanCameByAWhile", ROMX

; Norden talk 90 ($5A): tests story flags with TestFlagBit and shows message $0D23 ('I just heard a
; rumor...') when EVENT_SCENE_SHIELD2_1E5 is set; otherwise message $038A ('A woodsman came by a
; while back. ...'). The message starts through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg038A_AWoodsmanCameByAWhile.call_start_message_command09_hl_b13); starts message $038A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'A woodsman came by a
; while back.' (E-0268, the E-0082 shape; was TalkMsg038A_AWoodsmanCameByAWhile)
TalkMsg038A_AWoodsmanCameByAWhile::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $038a ; '*: A woodsman came by a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d23 ; '*: I just heard a rumor…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0312_HeroPeeredIntoTheBarrelIt_13", ROMX

; Norden talk 91 ($5B): starts message $0312 (the name of the player, then 'peered into the barrel.
; It was filled with black rocks.') through StartMessageCommand09HL_B13 (script command $09,
; wModeState = 1). (C2, E-0377)
; starts message $0312 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg0312_HeroPeeredIntoTheBarrelIt_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0312_HeroPeeredIntoTheBarrelIt_13)
TalkMsg0312_HeroPeeredIntoTheBarrelIt_13::
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 BarrelItem_TinyMedal_Flag01E7", ROMX

; Norden talk 92 ($5C), a one-time barrel: StartTreasureFlagDE_B13 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_TINYMEDAL ($2C) and
; story flag $01E7 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag the
; first time (group-0 message $A6), shows $A7 once the flag is set and $A8 when there is no room.
; (C2, E-0377)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $01E7 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_TinyMedal_Flag01E7)
BarrelItem_TinyMedal_Flag01E7::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01e7
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0313_HeroPeeredIntoTheOvenIt_13_2", ROMX

; Norden talk 93 ($5D): starts message $0313 (the name of the player, then 'peered into the oven. It
; felt just a little warm.') through StartMessageCommand09HL_B13 (script command $09, wModeState =
; 1). (C2, E-0377)
; starts message $0313 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0313_HeroPeeredIntoTheOvenIt_13_2) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0313_HeroPeeredIntoTheOvenIt_13_2)
; starts Script_WelcomeToOurInn_7: '*: Welcome to our inn!' (E-0248)
TalkMsg0313_HeroPeeredIntoTheOvenIt_13_2::
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ThirdInn", ROMX

; Norden talk 94, an inn: starts Script_WelcomeToOurInn_7 ('Welcome to our inn!', then a jump to the
; inn script Script_It_3 in the data bank) and sets wDataBank = $10 for that jump. (C2, E-0370;
; probed E-0377)
; starts Script_WelcomeToOurInn_7: '*: Welcome to our inn!' (E-0248)
NordenTalkEvents_ThirdInn::
    ld hl, Script_WelcomeToOurInn_7 ; script '*: Welcome to our inn!'
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 13 NordenTalkEvents_Shop0B", ROMX

; Norden talk 95, a shop: shop $0B with scripts in bank $10, 'Hello! How may I serve ...'. (C2,
; E-0357; probed E-0377)
NordenTalkEvents_Shop0B::
    ld a, $0b
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_HelloHowMayI_3 ; script '*: Hello! How may I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg038C_TheLakeIsFrozenSoI", ROMX

; Norden talk 96 ($60): tests story flags with TestFlagBit and shows message $0A13 ('The piled up
; ice floes disappeared from the harbor just like that. ...') when EVENT_SCENE_SHIELD2_1E5 is set;
; otherwise message $038C ('The lake is frozen, so I ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg038C_TheLakeIsFrozenSoI.call_start_message_command09_hl_b13); starts message $038C through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'The lake is frozen, so I
; can't' (E-0268, the E-0082 shape; was TalkMsg038C_TheLakeIsFrozenSoI)
TalkMsg038C_TheLakeIsFrozenSoI::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $038c ; '*: The lake is frozen, so'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a13 ; '*: The piled up ice floes'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg038D_ThisIsWestaniaCastleWestania", ROMX

; Norden talk 97 ($61): starts message $038D ('This is Westania Castle. ...') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $038D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is Westania Castle. Westania is the' (E-0268, the E-0082 shape; was
; TalkMsg038D_ThisIsWestaniaCastleWestania)
TalkMsg038D_ThisIsWestaniaCastleWestania::
    ld hl, $038d ; '*: This is Westania Castle. Westania'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg038E_NobodyFailsToBeImpressed", ROMX

; Norden talk 98 ($62): starts message $038E ('Nobody fails to be impressed when I breathe fire, and
; ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $038E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Nobody fails to be impressed when I' (E-0268, the E-0082 shape; was
; TalkMsg038E_NobodyFailsToBeImpressed)
TalkMsg038E_NobodyFailsToBeImpressed::
    ld hl, $038e ; '*: Nobody fails to be impressed'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg038F_IveBroughtWithMeA", ROMX

; Norden talk 99 ($63): starts message $038F ('... Any woman would be delighted by it!') through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $038F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I've brought with me a necklace' (E-0268, the E-0082 shape; was TalkMsg038F_IveBroughtWithMeA)
; (E-0324: was TalkMsg038F_IveBroughtWithMeA; read before $42 was known as 'v)
TalkMsg038F_IveBroughtWithMeA::
    ld hl, $038f ; '*: I've brought with me a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0390_WhenIBalanceOnMyBall", ROMX

; Norden talk 100 ($64): starts message $0390 ('When I balance on my ball, people simply go wild.
; ...') through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0390 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'When I balance on my ball, people' (E-0268, the E-0082 shape; was
; TalkMsg0390_WhenIBalanceOnMyBall)
TalkMsg0390_WhenIBalanceOnMyBall::
    ld hl, $0390 ; '*: When I balance on my'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0391_IHurlKnivesWithIncredible", ROMX

; Norden talk 101 ($65): starts message $0391 ('I hurl knives with incredible accuracy. ...')
; through StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; starts message $0391 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I hurl knives with incredible accuracy. I' (E-0268, the E-0082 shape; was
; TalkMsg0391_IHurlKnivesWithIncredible)
TalkMsg0391_IHurlKnivesWithIncredible::
    ld hl, $0391 ; '*: I hurl knives with incredible'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0392_PleaseLineUpAndQuitPushing", ROMX

; Norden talk 102 ($66): tests story flags with TestFlagBit and shows message $0ACB ('The crowds
; that flocked to the castle have all left. ...') when EVENT_SCENE_CHEER_YUNA is set; otherwise
; message $0AB9 ('... Someone else could win the reward!') when EVENT_GATHER_FOLLOWERS is set;
; otherwise message $0392 ('Please, line up! ...'). The message starts through
; StartMessageCommand09HL_B13 (script command $09, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0096 then jr c,
; TalkMsg0392_PleaseLineUpAndQuitPushing.call_start_message_command09_hl_b132; flag 0095 then jr c,
; TalkMsg0392_PleaseLineUpAndQuitPushing.call_start_message_command09_hl_b13); starts message $0392
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Please, line up! And
; quit pushing! Everyone' (E-0268, the E-0082 shape; was TalkMsg0392_PleaseLineUpAndQuitPushing)
TalkMsg0392_PleaseLineUpAndQuitPushing::
    ld de, EVENT_SCENE_CHEER_YUNA
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_GATHER_FOLLOWERS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0392 ; '*: Please, line up! And quit'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ab9 ; '*: If you've come to entertain'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0acb ; '*: The crowds that flocked to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0393_OhLadyYunaToThinkThat", ROMX

; Norden talk 103 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0ADE ('Lady Yuna is back to ...'); else with
; EVENT_YOU_WILL_THANK_YOU_LET set, message $0D1E ('Oh... Lady Yuna... I miss ...'); otherwise,
; message $0393 ('Oh... Lady Yuna... To think ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0393_OhLadyYunaToThinkThat.call_start_message_command09_hl_b132; flag 009B then jr c,
; TalkMsg0393_OhLadyYunaToThinkThat.call_start_message_command09_hl_b13); starts message $0393
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Oh Lady Yuna To
; think that I' (E-0268, the E-0082 shape; was TalkMsg0393_OhLadyYunaToThinkThat)
TalkMsg0393_OhLadyYunaToThinkThat::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_YOU_WILL_THANK_YOU_LET
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0393 ; '*: Oh… Lady Yuna… To think'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d1e ; '*: Oh… Lady Yuna… I miss'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0ade ; '*: Lady Yuna is back to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Sign", ROMX

; Norden talk 104, the sign: 'Lady Yuna ...' ($0ADF) after EVENT_SCENE_PRINCESS_MEDICINE_09D; 'Come
; all ...' as message $0394 after EVENT_GATHER_FOLLOWERS, otherwise as a script. (C2, E-0357; probed
; E-0377)
NordenTalkEvents_Sign::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_GATHER_FOLLOWERS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_HeroReadTheSign ; script '0 read the sign. 'Come all'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0394 ; '0 read the sign. 'Come all'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0adf ; '0 read the sign. 'Lady Yuna'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0397_TheCastleIsInAnUproar", ROMX

; Norden talk 105 (NordenTalkEvents): starts message $0397 ('The Castle is in an ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0397 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Castle is in an uproar.' (E-0268, the E-0082 shape; was TalkMsg0397_TheCastleIsInAnUproar)
TalkMsg0397_TheCastleIsInAnUproar::
    ld hl, $0397 ; '*: The Castle is in an'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0398_LadyYunaUsedToBeVery", ROMX

; Norden talk 106 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0AD8 ('Lady Yuna has regained her ...');
; otherwise, message $0398 ('Lady Yuna used to be ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg0398_LadyYunaUsedToBeVery.call_start_message_command09_hl_b13); starts message $0398
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Lady Yuna used to be
; very lively.' (E-0268, the E-0082 shape; was TalkMsg0398_LadyYunaUsedToBeVery)
TalkMsg0398_LadyYunaUsedToBeVery::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0398 ; '*: Lady Yuna used to be'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ad8 ; '*: Lady Yuna has regained her'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0399_InTheEastLivesAnOld", ROMX

; Norden talk 107 (NordenTalkEvents): starts message $0399 ('In the east lives an ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0399 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'In the east lives an old man' (E-0268, the E-0082 shape; was TalkMsg0399_InTheEastLivesAnOld)
TalkMsg0399_InTheEastLivesAnOld::
    ld hl, $0399 ; '*: In the east lives an'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg039A_WhatHappenedToLadyYunaIts", ROMX

; Norden talk 108 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0DE1 ('Seeing the liveliness of Lady ...');
; otherwise, message $039A ('What happened to Lady Yuna? ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg039A_WhatHappenedToLadyYunaIts.call_start_message_command09_hl_b13); starts message $039A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'What happened to
; Lady Yuna? It's as' (E-0268, the E-0082 shape; was TalkMsg039A_WhatHappenedToLadyYunaIts)
TalkMsg039A_WhatHappenedToLadyYunaIts::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $039a ; '*: What happened to Lady Yuna?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0de1 ; '*: Seeing the liveliness of Lady'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg039B_BeforeLadyYunaWouldBeUp", ROMX

; Norden talk 109 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0AD9 ('Lady Yuna snuck out again. ...');
; otherwise, message $039B ('Before, Lady Yuna would be ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg039B_BeforeLadyYunaWouldBeUp.call_start_message_command09_hl_b13); starts message $039B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Before, Lady Yuna
; would be up and' (E-0268, the E-0082 shape; was TalkMsg039B_BeforeLadyYunaWouldBeUp)
TalkMsg039B_BeforeLadyYunaWouldBeUp::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $039b ; '*: Before, Lady Yuna would be'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ad9 ; '*: Lady Yuna snuck out again.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowOhHowDidYou", ROMX

; Norden talk 110: 'Oh? How did you get ...' ($0ADA) to a player at Y $30, otherwise 'This leads to
; Lady Yuna's ...' ($039C). (C2, E-0357; probed E-0377)
NordenTalkEvents_ShowOhHowDidYou::
    ldh a, [hPlayerY]
    cp $30
    jr nz, .call_start_message_command09_hl_b13
    ld hl, $0ada ; '*: Oh? How did you get'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $039c ; '*: This leads to Lady Yuna's'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowYoureHereToCheer", ROMX

; Norden talk 111: by story progress $0ADB, $0ACD, $03A5; otherwise 'You're here to cheer Lady ...'
; in versions by the player's spot (X $50: $039D), a party of three with nobody fallen (the script),
; a fallen member ($039E) or a smaller party ($039F). (C2, E-0357; probed E-0377)
NordenTalkEvents_ShowYoureHereToCheer::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_YOU_WILL_THANK_YOU_LET
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_CHEER_YUNA
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld a, [wSpriteSlots + $b]
    cp $50
    jr nz, .check_party_count
    ld hl, $039d ; '*: You're here to cheer Lady'
    call StartMessageCommand09HL_B13
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr nz, .call_start_message_command09_hl_b132
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, Script_You_10 ; script '*: You're here to cheer Lady'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $039e ; '*: You're here to cheer Lady'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $039f ; '*: You're here to cheer Lady'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $03a5 ; '*: Many have tried to cheer'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0acd ; '*: Lady Yuna locked herself in'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0adb ; '*: How could we ever thank'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_KingMagnificentDontYouAgree", ROMX

; Norden talk 112 (NordenTalkEvents): starts Script_KingMagnificentDon (plays sound $28, runs script
; command SCRIPT_SCENE_CHEER_YUNA, then 'King: Magnificent! ...'). A script starts through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; starts Script_KingMagnificentDon (StartScriptAtHL_B13); its first message begins 'King
; Magnificent! Don't you agree?' (E-0271; was Talk_KingMagnificentDontYouAgree) (E-0344: the address
; in its name dropped or read as the label there; was Talk_KingMagnificentDontYouAgree; shortened
; from TalkScript_KingMagnificentDontYouAgree)
; starts Script_KingMagnificentDon: 'King: Magnificent! Don't you agree?' (E-0248)
Talk_KingMagnificentDontYouAgree::
    ld hl, Script_KingMagnificentDon ; script 'King: Magnificent! Don't you agree?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg03A4_KingSighNotEvenThisYou", ROMX

; Norden talk 113 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0ADC ('King: Yuna is back to being ...'); else
; with EVENT_YOU_WILL_THANK_YOU_LET set, message $0ACC ('King: Yuna has locked herself away ...');
; otherwise, message $03A4 ('King: ...Sigh... Not even this... You ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 009D then jr c,
; TalkMsg03A4_KingSighNotEvenThisYou.call_start_message_command09_hl_b132; flag 009B then jr c,
; TalkMsg03A4_KingSighNotEvenThisYou.call_start_message_command09_hl_b13); starts message $03A4
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'King Sigh Not even
; this You were' (E-0268, the E-0082 shape; was TalkMsg03A4_KingSighNotEvenThisYou)
TalkMsg03A4_KingSighNotEvenThisYou::
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_YOU_WILL_THANK_YOU_LET
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03a4 ; 'King: …Sigh… Not even this… You'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0acc ; 'King: Yuna has locked herself away'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0adc ; 'King: Yuna is back to being'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Yuna", ROMX

; Norden talk 114, Yuna: 'I heard that you saved ...' ($0AC5) after EVENT_SCENE_SHIELD2_1E5, 'Their
; next target is Queen ...' ($0AD7) after the medicine scene's end, the medicine script once
; EVENT_SCENE_PRINCESS_MEDICINE is set; after EVENT_YOU_WILL_THANK_YOU_LET and carrying item $33
; (YunaSoul) the script '............!', otherwise '............' ($03A3). (C2, E-0357; probed
; E-0377)
NordenTalkEvents_Yuna::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_PRINCESS_MEDICINE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld de, EVENT_YOU_WILL_THANK_YOU_LET
    call TestFlagBit
    jr c, .set_temp0_to_33

.loop:
    ld hl, $03a3 ; '*: …………'
    call StartMessageCommand09HL_B13
    ret

.set_temp0_to_33:
    ld a, $33
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld hl, Script_Message ; script '*: …………!'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_Message_2 ; script '*: …………'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ad7 ; 'Yuna: Their next target is Queen'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0ac5 ; 'Yuna: I heard that you saved'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03A6_ThisIsTheCastleOfEstria", ROMX

; Norden talk 115 (NordenTalkEvents): starts message $03A6 ('This is the Castle of ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $03A6 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is the Castle of Estria, the' (E-0268, the E-0082 shape; was
; TalkMsg03A6_ThisIsTheCastleOfEstria)
TalkMsg03A6_ThisIsTheCastleOfEstria::
    ld hl, $03a6 ; '*: This is the Castle of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03A7_QueenHelenCameByAWhile", ROMX

; Norden talk 116 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0AC6 ('Queen Helen came by the ...'); otherwise, message $03A7 ('Queen Helen came by
; a ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg03A7_QueenHelenCameByAWhile.call_start_message_command09_hl_b13); starts message $03A7
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Queen Helen came by
; a while ago,' (E-0268, the E-0082 shape; was TalkMsg03A7_QueenHelenCameByAWhile)
TalkMsg03A7_QueenHelenCameByAWhile::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03a7 ; '*: Queen Helen came by a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ac6 ; '*: Queen Helen came by the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03A8_TheSpiritsSpringHasFrozen", ROMX

; Norden talk 117 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0A14 ('The warm weather melted the ...'); otherwise, message $03A8 ('... spring has
; frozen. ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg03A8_TheSpiritsSpringHasFrozen.call_start_message_command09_hl_b13); starts message $03A8
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The spirit's spring
; has frozen. The lake' (E-0268, the E-0082 shape; was TalkMsg03A8_TheSpiritsSpringHasFrozen)
TalkMsg03A8_TheSpiritsSpringHasFrozen::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03a8 ; '*: The spirit's spring has frozen.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a14 ; '*: The warm weather melted the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03A9_QueenHelensDreamsComeTrue", ROMX

; Norden talk 118 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0AC7 ('... dreams come true ...'); otherwise, message $03A9 ('... dreams come true.
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg03A9_QueenHelensDreamsComeTrue.call_start_message_command09_hl_b13); starts message $03A9
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Queen Helen's dreams
; come true. If she' (E-0268, the E-0082 shape; was TalkMsg03A9_QueenHelensDreamsComeTrue)
TalkMsg03A9_QueenHelensDreamsComeTrue::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03a9 ; '*: Queen Helen's dreams come true.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ac7 ; '*: Queen Helen's dreams come true'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AA_OurQueenIsAKindPerson", ROMX

; Norden talk 119 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0DF4 ('... lost her scary ...'); otherwise, message $03AA ('Our Queen is a kind
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg03AA_OurQueenIsAKindPerson.call_start_message_command09_hl_b13); starts message $03AA
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our Queen is a kind
; person who' (E-0268, the E-0082 shape; was TalkMsg03AA_OurQueenIsAKindPerson)
TalkMsg03AA_OurQueenIsAKindPerson::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03aa ; '*: Our Queen is a kind'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0df4 ; '*: The Queen's lost her scary'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AB_ATeacherFromTheWestLives", ROMX

; Norden talk 120 (NordenTalkEvents): starts message $03AB ('A teacher from the west ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $03AB through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'A teacher from the west lives over' (E-0268, the E-0082 shape; was
; TalkMsg03AB_ATeacherFromTheWestLives)
TalkMsg03AB_ATeacherFromTheWestLives::
    ld hl, $03ab ; '*: A teacher from the west'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AE_TheQueenLooksHaggardRecently", ROMX

; Norden talk 121 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0A00 ('Queen Helen has become healthy. ...');
; otherwise, message $03AE ('The Queen looks haggard recently. ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E2 then jr c,
; TalkMsg03AE_TheQueenLooksHaggardRecently.call_start_message_command09_hl_b13); starts message
; $03AE through StartMessageCommand09HL_B13 (script command $09); that string begins 'The Queen
; looks haggard recently. Lack of' (E-0268, the E-0082 shape; was
; TalkMsg03AE_TheQueenLooksHaggardRecently)
TalkMsg03AE_TheQueenLooksHaggardRecently::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03ae ; '*: The Queen looks haggard recently.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a00 ; '*: Queen Helen has become healthy.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AD_IHeardThisOnTheSly", ROMX

; Norden talk 122 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0AFF ('I heard from my sister ...'); otherwise,
; message $03AD ('I heard this on the ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 01E2 then jr c,
; TalkMsg03AD_IHeardThisOnTheSly.call_start_message_command09_hl_b13); starts message $03AD through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'I heard this on the sly
; from' (E-0268, the E-0082 shape; was TalkMsg03AD_IHeardThisOnTheSly)
TalkMsg03AD_IHeardThisOnTheSly::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03ad ; '*: I heard this on the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0aff ; '*: I heard from my sister'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AF_AroundThesePartsThereAre", ROMX

; Norden talk 123 (NordenTalkEvents): starts message $03AF ('Around these parts, there are ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $03AF through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Around these parts, there are times of' (E-0268, the E-0082 shape; was
; TalkMsg03AF_AroundThesePartsThereAre)
TalkMsg03AF_AroundThesePartsThereAre::
    ld hl, $03af ; '*: Around these parts, there are'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowThisIsNoPlace", ROMX

; Norden talk 124 (NordenTalkEvents): after EVENT_OH_AN_ENVOY_FROM_THE message $03B2 ('I beg your
; pardon, please! ...'); otherwise, when item $32 (ITEM_CREST) is in the bag
; (FindTemp0InInventoryList), Script_ThisIsNoPlace_2 for a player X (hPlayerX) of $41 or more and
; Script_ThisIsNoPlace below it (both say 'This is no place for ...' and 'Oh? An envoy from the
; ...'); without the item message $03B0. Messages start through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1) and scripts
; through StartScriptAtHL_B13 (wScriptPointerLo/Hi, wScriptStartRequest = $80, wModeState = 1). (C2,
; E-0377)
NordenTalkEvents_ShowThisIsNoPlace::
    ld de, EVENT_OH_AN_ENVOY_FROM_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .check_player_x
    ld hl, $03b0 ; '*: This is no place for'
    call StartMessageCommand09HL_B13
    ret

.check_player_x:
    ldh a, [hPlayerX]
    cp $41
    jr nc, .call_start_script_at_hl_b13
    ld hl, Script_ThisIsNoPlace ; script '*: This is no place for'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_ThisIsNoPlace_2 ; script '*: This is no place for'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $03b2 ; '*: I beg your pardon, please!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Shop0C", ROMX

; Norden talk 125 (NordenTalkEvents), a shop: sets wScreenTableIndex = $0C and wDataBank = $10, then
; starts Script_HelloWhatMayI ('Hello! What may I do ...', then a jump to Script_Shop_5 in the data
; bank) through StartScriptAtHL_B13. (C2, E-0377)
NordenTalkEvents_Shop0C::
    ld a, $0c
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_HelloWhatMayI ; script '*: Hello! What may I do'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg03B4_ABotanistDoesLiveHereBut", ROMX

; Norden talk 126 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0A15 ('The scholar came back finally ...'); otherwise, message $03B4 ('A botanist
; does live here... ...'). A message starts through StartMessageCommand09HL_B13 (script command 9
; with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg03B4_ABotanistDoesLiveHereBut.call_start_message_command09_hl_b13); starts message $03B4
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'A botanist does live
; here But he's' (E-0268, the E-0082 shape; was TalkMsg03B4_ABotanistDoesLiveHereBut)
TalkMsg03B4_ABotanistDoesLiveHereBut::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03b4 ; '*: A botanist does live here…'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a15 ; '*: The scholar came back finally'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_IRetiredAsATeacher", ROMX

; Norden talk 127 (NordenTalkEvents): starts Script_IRetiredAsA (first message 'I retired as a
; teacher ...'). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_IRetiredAsA (StartScriptAtHL_B13); its first message begins 'I retired as a teacher
; and' (E-0271; was Talk_IRetiredAsATeacher) (E-0344: the address in its name dropped or read as the
; label there; was Talk_IRetiredAsATeacher; shortened from TalkScript_IRetiredAsATeacher)
; starts Script_IRetiredAsA: '*: I retired as a teacher' (E-0248)
Talk_IRetiredAsATeacher::
    ld hl, Script_IRetiredAsA ; script '*: I retired as a teacher'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HowMayOurChurchServeYou_3", ROMX

; Norden talk 128 (NordenTalkEvents), a church: sets wDataBank = $1F and starts
; Script_HowMayOurChurch_3 (message $4820 'How may our church serve ...', then a jump to
; Script_Priest in the data bank) through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). Norden talks 128, 130 and 131 are three identical
; copies of this routine. (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch_3 (StartScriptAtHL_B13); its first
; message begins 'How may our church serve you?' (E-0271; was Talk_HowMayOurChurchServeYou_3)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_HowMayOurChurchServeYou_3; shortened from TalkScript_HowMayOurChurchServeYou_3)
; starts Script_HowMayOurChurch_3: '*: How may our church serve' (E-0248)
Talk_HowMayOurChurchServeYou_3::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch_3 ; script '*: How may our church serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_SceneChestServant", ROMX

; Norden talk 129 (NordenTalkEvents): starts Script_SceneChestServant (runs script command
; SCRIPT_SCENE_CHEST_SERVANT). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneChestServant (StartScriptAtHL_B13) (E-0271; was Talk_SceneChestServant)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneChestServant;
; named after the script it starts, Script_SceneChestServant)
; starts Script_SceneChestServant (E-0248)
Talk_SceneChestServant::
    ld hl, Script_SceneChestServant
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HowMayOurChurchServeYou_13", ROMX

; Norden talk 130 (NordenTalkEvents), a church: sets wDataBank = $1F and starts
; Script_HowMayOurChurch_3 (message $4820 'How may our church serve ...', then a jump to
; Script_Priest in the data bank) through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). Norden talks 128, 130 and 131 are three identical
; copies of this routine. (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch_3 (StartScriptAtHL_B13); its first
; message begins 'How may our church serve you?' (E-0271; was Talk_HowMayOurChurchServeYou_13)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_HowMayOurChurchServeYou_13; shortened from TalkScript_HowMayOurChurchServeYou_13)
; starts Script_HowMayOurChurch_3: '*: How may our church serve' (E-0248)
Talk_HowMayOurChurchServeYou_13::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch_3 ; script '*: How may our church serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HowMayOurChurchServeYou_13_2", ROMX

; Norden talk 131 (NordenTalkEvents), a church: sets wDataBank = $1F and starts
; Script_HowMayOurChurch_3 (message $4820 'How may our church serve ...', then a jump to
; Script_Priest in the data bank) through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). Norden talks 128, 130 and 131 are three identical
; copies of this routine. (C2, E-0377)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch_3 (StartScriptAtHL_B13); its first
; message begins 'How may our church serve you?' (E-0271; was Talk_HowMayOurChurchServeYou_13_2)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_HowMayOurChurchServeYou_13_2; shortened from TalkScript_HowMayOurChurchServeYou_13_2)
; starts Script_HowMayOurChurch_3: '*: How may our church serve' (E-0248)
Talk_HowMayOurChurchServeYou_13_2::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch_3 ; script '*: How may our church serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0313_HeroPeeredIntoTheOvenIt_13_3", ROMX

; Norden talk 132 (NordenTalkEvents): starts message $0313 ('<BUF0> peered into the oven. It ...').
; A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0313 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0313_HeroPeeredIntoTheOvenIt_13_3) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0313_HeroPeeredIntoTheOvenIt_13_3)
TalkMsg0313_HeroPeeredIntoTheOvenIt_13_3::
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0312_HeroPeeredIntoTheBarrelIt_13_2", ROMX

; Norden talk 133 (NordenTalkEvents): starts message $0312 ('<BUF0> peered into the barrel. It
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0312 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg0312_HeroPeeredIntoTheBarrelIt_13_2) (E-0344: the address in its name dropped or read as
; the label there; was TalkMsg0312_HeroPeeredIntoTheBarrelIt_13_2)
; starts Script_WelcomeToOurInn_8: '*: Welcome to our inn!' (E-0248)
TalkMsg0312_HeroPeeredIntoTheBarrelIt_13_2::
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_FourthInn", ROMX

; Norden talk 134, an inn: starts Script_WelcomeToOurInn_8 ('Welcome to our inn!', then a jump to
; the inn script Script_It_3 in the data bank) and sets wDataBank = $10 for that jump. (C2, E-0370;
; probed E-0377)
; starts Script_WelcomeToOurInn_8: '*: Welcome to our inn!' (E-0248)
NordenTalkEvents_FourthInn::
    ld hl, Script_WelcomeToOurInn_8 ; script '*: Welcome to our inn!'
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 13 TalkMsg03B8_IWantToReturnToThe", ROMX

; Norden talk 135 (NordenTalkEvents): starts message $03B8 ('I want to return to ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $03B8 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I want to return to the north,' (E-0268, the E-0082 shape; was TalkMsg03B8_IWantToReturnToThe)
TalkMsg03B8_IWantToReturnToThe::
    ld hl, $03b8 ; '*: I want to return to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03AC_ThereIsASpringInThe", ROMX

; Norden talk 136 (NordenTalkEvents): starts message $03AC ('There is a spring in ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $03AC through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There is a spring in the far' (E-0268, the E-0082 shape; was TalkMsg03AC_ThereIsASpringInThe)
TalkMsg03AC_ThereIsASpringInThe::
    ld hl, $03ac ; '*: There is a spring in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0396_ItsAMeanOldWorldOut", ROMX

; Norden talk 137 (NordenTalkEvents): starts message $0396 ('... a mean old world ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0396 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'It's a mean old world out there.' (E-0268, the E-0082 shape; was TalkMsg0396_ItsAMeanOldWorldOut)
TalkMsg0396_ItsAMeanOldWorldOut::
    ld hl, $0396 ; '*: It's a mean old world'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg03B9_QueenHelenHasBeenSuffering", ROMX

; Norden talk 138 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0AFB ('Queen Helen ...'); else with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0AE3 ('Queen Helen had been suffering ...');
; otherwise, message $03B9 ('Queen Helen has been suffering ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E2 then jr c,
; TalkMsg03B9_QueenHelenHasBeenSuffering.call_start_message_command09_hl_b132; flag 009D then jr c,
; TalkMsg03B9_QueenHelenHasBeenSuffering.call_start_message_command09_hl_b13); starts message $03B9
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Queen Helen has been
; suffering from nightmares' (E-0268, the E-0082 shape; was TalkMsg03B9_QueenHelenHasBeenSuffering)
TalkMsg03B9_QueenHelenHasBeenSuffering::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $03b9 ; '*: Queen Helen has been suffering'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0ae3 ; '*: Queen Helen had been suffering'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0afb ; '*: Queen Helen isn't bedridden by'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DD6_NightmaresSoHorribleThat", ROMX

; Norden talk 139 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0AFC ('Queen Helen has had a ...'); otherwise,
; message $0DD6 ('Nightmares so horrible that they ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E2 then jr c,
; TalkMsg0DD6_NightmaresSoHorribleThat.call_start_message_command09_hl_b13); starts message $0DD6
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Nightmares so
; horrible that they keep Queen' (E-0268, the E-0082 shape; was
; TalkMsg0DD6_NightmaresSoHorribleThat)
TalkMsg0DD6_NightmaresSoHorribleThat::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0dd6 ; '*: Nightmares so horrible that they'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0afc ; '*: Queen Helen has had a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DD7_OurHeartsAreLike", ROMX

; Norden talk 140 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0AFD ('The skies are clear, but ...'); else with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0DC9 ('How can we save Queen ...'); otherwise,
; message $0DD7 ('Our hearts are like the ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $01E2 set: jr to
; TalkMsg0DD7_OurHeartsAreLike.call_start_message_command09_hl_b132; flag $009D set: jr to
; TalkMsg0DD7_OurHeartsAreLike.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0DD7 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Our hearts are like the skies' (E-0082)
TalkMsg0DD7_OurHeartsAreLike::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0dd7 ; '*: Our hearts are like the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0dc9 ; '*: How can we save Queen'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0afd ; '*: The skies are clear, but'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0DD8_QueenHelenIsWracked", ROMX

; Talk: after the shield guardian scenes 'You have restored peace...' ($0AFA) or 'Queen Helen is
; safe...' ($0AF9); once the medicine is given 'Quick, give the medicine to...' ($0AF8); after the
; hero checked the blue flower, with the princess-medicine scene set, the medicine script
; (Script_PardonMeYouHave) when a SleepHerb (item $34) is in the bag, else 'You can't come in here.'
; ($0AE4); before that 'Queen Helen is wracked by...' ($0DD8), or 'You can't come in here.' once the
; medicine scene is set. (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5
; constant message(s) depending on story flags and state; the first one in the code is $0DD8, whose
; string begins 'Queen Helen is wracked by awful' (E-0097)
Talk0DD8_QueenHelenIsWracked::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_SHIELD_GUARDIAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MEDICINE_GIVEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_HERO_CHECKED_THE_BLUE_FLOWER
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .loop2

.loop:
    ld hl, $0dd8 ; '*: Queen Helen is wracked by'
    call StartMessageCommand09HL_B13
    ret

.loop2:
    ld hl, $0ae4 ; '*: You can't come in here.'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr nc, .loop
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop2
    ld hl, Script_PardonMeYouHave ; script '*: Pardon me? You have medicine?'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0af8 ; '*: Quick, give the medicine to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0af9 ; '*: Queen Helen is safe for'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0afa ; '*: You have restored peace. For'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0DD9_TheReceptionHallIs", ROMX

; Talk: 'The reception hall is past...' ($0AE5) between the princess-medicine scene and the second
; shield scene; otherwise 'The reception hall is beyond...' ($0DD9). (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0DD9, whose
; string begins 'The reception hall is beyond here.' (E-0097)
Talk0DD9_TheReceptionHallIs::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0dd9 ; '*: The reception hall is beyond'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0ae5 ; '*: The reception hall is past'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DDA_OurQueenHelensPremonition", ROMX

; Norden talk 143 (NordenTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_SHIELD_GUARDIAN_1E2 set, message $0AFE ('It has been getting warmer. ...'); else with
; EVENT_SCENE_PRINCESS_MEDICINE_09D set, message $0D1F ('How can we help Queen ...'); otherwise,
; message $0DDA ('Our Queen ...'). A message starts through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $01E2 set: jr to
; TalkMsg0DDA_OurQueenHelensPremonition.call_start_message_command09_hl_b132; flag $009D set: jr to
; TalkMsg0DDA_OurQueenHelensPremonition.call_start_message_command09_hl_b13); when none of them
; branches, starts message $0DDA through StartMessageCommand09HL_B13 (script command $09); that
; string begins 'Our Queen Helen's premonition made it' (E-0082)
TalkMsg0DDA_OurQueenHelensPremonition::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0dda ; '*: Our Queen Helen's premonition made'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d1f ; '*: How can we help Queen'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0afe ; '*: It has been getting warmer.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DDB_WhatIsItLeave", ROMX

; Norden talk 144 (NordenTalkEvents): with EVENT_SCENE_SHIELD2_1E5 set starts message $0DE0 ('Helen:
; I thank you from the ...'); else with EVENT_SCENE_SHIELD_GUARDIAN_1E2 set $0AF7 ('Helen: Thank you
; so much. Please ...'); else with EVENT_SCENE_SHIELD_GUARDIAN set it clears wSpriteSlots + $7
; (OBJ_STATE of sprite slot 0) and starts Script_SceneShieldGuardian_2 (script command
; SCRIPT_SCENE_SHIELD_GUARDIAN); else with EVENT_SCENE_MEDICINE_GIVEN set it only clears
; wSpriteSlots + $7 and starts nothing; otherwise $0DDB ('What is it? Leave at ...'). Messages start
; through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1) and scripts through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $01E5 set: jr to
; TalkMsg0DDB_WhatIsItLeave.call_start_message_command09_hl_b132; flag $01E2 set: jr to
; TalkMsg0DDB_WhatIsItLeave.call_start_message_command09_hl_b13; flag $01E1 set: jr to
; TalkMsg0DDB_WhatIsItLeave.clear_sprite_slots2; flag $01F1 set: jr to
; TalkMsg0DDB_WhatIsItLeave.clear_sprite_slots); when none of them branches, starts message $0DDB
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'What is it? Leave at
; once!' (E-0082)
TalkMsg0DDB_WhatIsItLeave::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_SHIELD_GUARDIAN
    call TestFlagBit
    jr c, .clear_sprite_slots2
    ld de, EVENT_SCENE_MEDICINE_GIVEN
    call TestFlagBit
    jr c, .clear_sprite_slots
    ld hl, $0ddb ; '*: What is it? Leave at'
    call StartMessageCommand09HL_B13
    ret

.clear_sprite_slots:
    xor a
    ld [wSpriteSlots + $7], a
    ret

.clear_sprite_slots2:
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, Script_SceneShieldGuardian_2
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0af7 ; 'Helen: Thank you so much. Please'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0de0 ; 'Helen: I thank you from the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg00FF_Composing_13", ROMX

; Norden talk 145 (NordenTalkEvents): starts message $00FF ('Composing ...'). A message starts
; through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $00FF through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Composing' (E-0268, the E-0082 shape; was TalkMsg00FF_Composing_13) (E-0344: the address in its
; name dropped or read as the label there; was TalkMsg00FF_Composing_13)
TalkMsg00FF_Composing_13::
    ld hl, $00ff ; 'Composing'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DDC_ThisHappenedWhenIWasDeep", ROMX

; Norden talk 146 (NordenTalkEvents): picks the reply by story flags: with EVENT_SCENE_SHIELD2_1E5
; set, message $0D24 ('Now that I think about ...'); otherwise, message $0DDC ('This happened when I
; was ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 01E5 then jr c,
; TalkMsg0DDC_ThisHappenedWhenIWasDeep.call_start_message_command09_hl_b13); starts message $0DDC
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'This happened when I
; was deep in' (E-0268, the E-0082 shape; was TalkMsg0DDC_ThisHappenedWhenIWasDeep)
TalkMsg0DDC_ThisHappenedWhenIWasDeep::
    ld de, EVENT_SCENE_SHIELD2_1E5
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0ddc ; '*: This happened when I was'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d24 ; '*: Now that I think about'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DDD_MyFatherIsSoCowardlyGetting", ROMX

; Norden talk 147 (NordenTalkEvents): starts message $0DDD ('My father is so cowardly ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0DDD through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'My father is so cowardly, getting all' (E-0268, the E-0082 shape; was
; TalkMsg0DDD_MyFatherIsSoCowardlyGetting)
TalkMsg0DDD_MyFatherIsSoCowardlyGetting::
    ld hl, $0ddd ; '*: My father is so cowardly,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0AC0_HeroCheckedTheBookshelfHistory", ROMX

; Norden talks 148 and 149 (NordenTalkEvents): starts message $0AC0 ('<BUF0> checked the bookshelf.'
; 'History of ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0AC0 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. History of the' (E-0268, the E-0082 shape; was
; TalkMsg0AC0_HeroCheckedTheBookshelfHistory)
TalkMsg0AC0_HeroCheckedTheBookshelfHistory::
    ld hl, $0ac0 ; '0 checked the bookshelf. 'History of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0AC1_HeroCheckedTheBookshelfHistory", ROMX

; Norden talk 150 (NordenTalkEvents): starts message $0AC1 ('<BUF0> checked the bookshelf.' 'History
; of ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0AC1 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. History of the' (E-0268, the E-0082 shape; was
; TalkMsg0AC1_HeroCheckedTheBookshelfHistory)
TalkMsg0AC1_HeroCheckedTheBookshelfHistory::
    ld hl, $0ac1 ; '0 checked the bookshelf. 'History of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0ABC_HeroPeeredIntoTheOvenIt_13", ROMX

; Norden talk 151 (NordenTalkEvents): starts message $0ABC ('<BUF0> peered into the oven. It ...').
; A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0ABC through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It felt' (E-0268, the E-0082 shape; was
; TalkMsg0ABC_HeroPeeredIntoTheOvenIt_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0ABC_HeroPeeredIntoTheOvenIt_13)
; starts Script_SceneSpiritEnvoy2 (E-0248)
TalkMsg0ABC_HeroPeeredIntoTheOvenIt_13::
    ld hl, $0abc ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_SceneSpiritEnvoy2", ROMX

; Norden talk 152 (NordenTalkEvents): starts Script_SceneSpiritEnvoy2 (runs script command
; SCRIPT_SCENE_SPIRIT_ENVOY_2). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneSpiritEnvoy2 (StartScriptAtHL_B13) (E-0271; was Talk_SceneSpiritEnvoy2)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneSpiritEnvoy2;
; named after the script it starts, Script_SceneSpiritEnvoy2)
; starts Script_SceneSpiritEnvoy2 (E-0248)
Talk_SceneSpiritEnvoy2::
    ld hl, Script_SceneSpiritEnvoy2
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_Startled", ROMX

; Norden talk 153 (NordenTalkEvents): before EVENT_GIVE_ITEM_BLINK_09A one of three 'You startled me
; ...' scripts, after it one of three 'remember who I ...' scripts: Script_YouStartledMeI or
; Script_IDon_2 before EVENT_SCENE_CHEER_YUNA, then Script_YouStartledMeI_2 or Script_IDon_3 when
; InventoryHasFreeSlotCheck_Bank13 finds room in the bag, and Script_YouStartledMeI_3 or
; Script_IDon_4 when it is full. Scripts start through StartScriptAtHL_B13. (C2, E-0377)
NordenTalkEvents_Startled::
    ld de, EVENT_GIVE_ITEM_BLINK_09A
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_CHEER_YUNA
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check_bank13
    ld hl, Script_YouStartledMeI ; script '*: …………? You startled me… I'
    call StartScriptAtHL_B13
    ret

.call_inventory_has_free_slot_check_bank13:
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, .call_start_script_at_hl_b13
    ld hl, Script_YouStartledMeI_2 ; script '*: …………? You startled me… I'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_YouStartledMeI_3 ; script '*: …………? You startled me… I'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_CHEER_YUNA
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check_bank132
    ld hl, Script_IDon_2 ; script '*: I don't remember who I'
    call StartScriptAtHL_B13
    ret

.call_inventory_has_free_slot_check_bank132:
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, .call_start_script_at_hl_b132
    ld hl, Script_IDon_3 ; script '*: I don't remember who I'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_IDon_4 ; script '*: I don't remember who I'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowHeroCheckedTheMarionette", ROMX

; Norden talk 154 (NordenTalkEvents), the marionette: with object 1 at X $80 and Y $10 (wObject1 +
; OBJ_X, OBJ_Y) message $0ACE ('<BUF0> checked the marionette. It sagged ...'), otherwise
; Script_Message_2 (the '............' script that ends in script command
; SCRIPT_SCENE_PRINCESS_MEDICINE). Messages start through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1) and scripts
; through StartScriptAtHL_B13 (wScriptPointerLo/Hi, wScriptStartRequest = $80, wModeState = 1). (C2,
; E-0377)
NordenTalkEvents_ShowHeroCheckedTheMarionette::
    ld a, [wObject1 + OBJ_X]
    cp $80
    jr nz, .call_start_script_at_hl_b13
    ld a, [wObject1 + OBJ_Y]
    cp $10
    jr nz, .call_start_script_at_hl_b13
    ld hl, $0ace ; '0 checked the marionette. It sagged'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_Message_2 ; script '*: …………'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0A16_MyMaidIsAngryThatI", ROMX

; Norden talk 155 (NordenTalkEvents): starts message $0A16 ('My maid is angry that ...'). A message
; starts through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A16 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'My maid is angry that I left' (E-0268, the E-0082 shape; was TalkMsg0A16_MyMaidIsAngryThatI)
TalkMsg0A16_MyMaidIsAngryThatI::
    ld hl, $0a16 ; '*: My maid is angry that'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_BlueFlower", ROMX

; Norden talk 156 (NordenTalkEvents), the blue flower: after EVENT_HERO_CHECKED_THE_BLUE_FLOWER
; message $0AE8; otherwise, when InventoryHasFreeSlotCheck_Bank13 finds room, it writes item $34
; (ITEM_SLEEPHERB) to the first free slot, sets bit 6 of wInventorySortFlags, says $0AE7 and sets
; the flag; with a full bag it says $0AE9 (it cannot be carried) and changes nothing else. Messages
; start through StartMessageCommand09HL_B13 (script command 9). (C2, E-0377)
NordenTalkEvents_BlueFlower::
    ld de, EVENT_HERO_CHECKED_THE_BLUE_FLOWER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    jr .call_inventory_has_free_slot_check_bank13

.call_start_message_command09_hl_b13:
    ld hl, $0ae8 ; '0 checked the blue flower. The'
    call StartMessageCommand09HL_B13
    ret

.call_inventory_has_free_slot_check_bank13:
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, .call_start_message_command09_hl_b132
    ld [hl], $34
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, $0ae7 ; '0 checked the blue flower. It'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HERO_CHECKED_THE_BLUE_FLOWER
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0ae9 ; '0 checked the blue flower. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestMagicKey_Flag01E0", ROMX

; Norden talk 157 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 3 (the kind)
; and wScriptParam1 = 0, then StartTreasureFlagDE_B13 with DE = $01E0 (the story flag, stored in
; wMessageIndex = $E0 and wMessageGroup = $01) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives a Magic Key (GenerateNewKeyEntry) and sets the flag (message $A9 of
; group 0; $AA when the flag is already set, $AB when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 3 (kind) and wScriptParam1 =
; $00, story flag $01E0 in DE: when the flag is clear it gives a Magic Key (GenerateNewKeyEntry) and
; sets the flag (message $A9 of group 0; $AA when the flag is already set, $AB when there is no
; room) (E-0269; was ChestMagicKey_Flag01E0)
ChestMagicKey_Flag01E0::
    ld a, $03
    ld [wScriptParam0], a
    ld a, $00
    ld [wScriptParam1], a
    ld de, $01e0
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 NordenTalkEvents_FaceObject2Down", ROMX

; Norden talk 158: sets wObject2 + OBJ_STATE = 0, the facing value other readings take as down
; (hPlayerFacing 0 moves the interaction check 16 pixels down), and starts no message or script. The
; generated comment above it ('starts Script_SceneShield') belongs to the next entry,
; Talk_SceneShield. (C2, E-0370; probed E-0377)
; starts Script_SceneShield (E-0248)
NordenTalkEvents_FaceObject2Down::
    xor a
    ld [wObject2 + OBJ_STATE], a
    ret

SECTION "Bank 13 Talk_SceneShield", ROMX

; Norden talk 159 (NordenTalkEvents): starts Script_SceneShield (runs script command
; SCRIPT_SCENE_SHIELD). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the
; script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneShield (StartScriptAtHL_B13) (E-0271; was Talk_SceneShield) (E-0344: the
; address in its name dropped or read as the label there; was Talk_SceneShield; named after the
; script it starts, Script_SceneShield)
; starts Script_SceneShield (E-0248)
Talk_SceneShield::
    ld hl, Script_SceneShield
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_ShowHeroCheckedTheTreasure", ROMX

; Norden talk 160 (NordenTalkEvents), a treasure chest: with room in the bag
; (InventoryHasFreeSlotCheck_Bank13) it writes item $32 (ITEM_CREST) to the first free slot, sets
; bit 6 of wInventorySortFlags and starts Script_HeroCheckedTheTreasure_2 ('<BUF0> checked the
; treasure chest. ...', which hides object 1 and sets EVENT_HERO_CHECKED_THE_TREASURE_CHEST); with a
; full bag message $0D27. (C2, E-0377)
NordenTalkEvents_ShowHeroCheckedTheTreasure::
    call InventoryHasFreeSlotCheck_Bank13
    jr c, .read_inventory_sort_flags
    ld hl, $0d27 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

.read_inventory_sort_flags:
    ld [hl], $32
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheTreasure_2 ; script '0 checked the treasure chest. 0'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 NordenTalkEvents_SecondShieldScene", ROMX

; Norden talk 161 (NordenTalkEvents): finds item $32 (ITEM_CREST) in the bag
; (FindTemp0InInventoryList), removes that slot (RemoveInventorySlotShiftDown: later slots move down
; one and wInventory + $17 becomes $FF) and starts Script_SceneShield2 (script command
; SCRIPT_SCENE_SHIELD_2). It does not check that the item was found: with hTemp0 = $FF the remove
; shifts the 24 bytes at wInventory + $100-$117 down by one instead and still sets wInventory + $17
; = $FF. (C2, E-0377)
NordenTalkEvents_SecondShieldScene::
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_SceneShield2
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 ChestItem_Bolt_Flag01E9", ROMX

; Norden talk 162 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $25 (ITEM_BOLT), then StartTreasureFlagDE_B13 with DE = $01E9 (the story flag,
; stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $25, story flag $01E9 in DE: when the flag is clear it gives item $25 (Bolt) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01E9)
ChestItem_Bolt_Flag01E9::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $25
    ld [wScriptParam1], a
    ld de, $01e9
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_DracoBelt", ROMX

; Norden talk 163 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $41 (ITEM_DRACOBELT), then StartTreasureFlagDE_B13 with DE = $01EA (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $41, story flag $01EA in DE: when the flag is clear it gives item $41 (DracoBelt) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01EA)
ChestItem_DracoBelt::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $41
    ld [wScriptParam1], a
    ld de, $01ea
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_BraveCape_Flag01EB", ROMX

; Norden talk 164 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $52 (ITEM_BRAVECAPE), then StartTreasureFlagDE_B13 with DE = $01EB (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $52, story flag $01EB in DE: when the flag is clear it gives item $52 (BraveCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01EB)
ChestItem_BraveCape_Flag01EB::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $01eb
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Smart_Flag01EC", ROMX

; Norden talk 165 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $17 (ITEM_SMART), then StartTreasureFlagDE_B13 with DE = $01EC (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $17, story flag $01EC in DE: when the flag is clear it gives item $17 (Smart) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01EC)
ChestItem_Smart_Flag01EC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $17
    ld [wScriptParam1], a
    ld de, $01ec
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Friend_Flag01ED", ROMX

; Norden talk 166 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $23 (ITEM_FRIEND), then StartTreasureFlagDE_B13 with DE = $01ED (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $23, story flag $01ED in DE: when the flag is clear it gives item $23 (Friend) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01ED)
ChestItem_Friend_Flag01ED::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01ed
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Mage_Flag01EE", ROMX

; Norden talk 167 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $5D (ITEM_MAGE), then StartTreasureFlagDE_B13 with DE = $01EE (the story flag,
; stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5D, story flag $01EE in DE: when the flag is clear it gives item $5D (Mage) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01EE)
ChestItem_Mage_Flag01EE::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5d
    ld [wScriptParam1], a
    ld de, $01ee
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Divine_Flag01EF", ROMX

; Norden talk 168 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $5B (ITEM_DIVINE), then StartTreasureFlagDE_B13 with DE = $01EF (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5B, story flag $01EF in DE: when the flag is clear it gives item $5B (Divine) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01EF)
ChestItem_Divine_Flag01EF::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5b
    ld [wScriptParam1], a
    ld de, $01ef
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_MeteOrb", ROMX

; Norden talk 169 (NordenTalkEvents), a one-time treasure chest: sets wScriptParam0 = 0 (the kind)
; and wScriptParam1 = $1E (ITEM_METEORB), then StartTreasureFlagDE_B13 with DE = $01F0 (the story
; flag, stored in wMessageIndex/wMessageGroup) starts script command $0A, RunOneTimeTreasure
; (wScriptCommandType = $0A, wScriptRunning = 1, wModeState = 1). By the earlier reading of that
; command, a clear flag gives the item and sets the flag (message $A0 of group 0; $A1 when the flag
; is already set, $A2 when there is no room). (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $1E, story flag $01F0 in DE: when the flag is clear it gives item $1E (MeteOrb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F0)
ChestItem_MeteOrb::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1e
    ld [wScriptParam1], a
    ld de, $01f0
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 Talk_SceneShieldGuardian", ROMX

; Norden talk 170 (NordenTalkEvents): starts Script_SceneShieldGuardian (runs script command
; SCRIPT_SCENE_SHIELD_GUARDIAN). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneShieldGuardian (StartScriptAtHL_B13) (E-0271; was Talk_SceneShieldGuardian)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneShieldGuardian;
; named after the script it starts, Script_SceneShieldGuardian)
; starts Script_SceneShieldGuardian (E-0248)
Talk_SceneShieldGuardian::
    ld hl, Script_SceneShieldGuardian
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_TravelerEvent", ROMX

; Talk category 8 (DispatchTalkEvent entry 8, wTalkEventIndex = 8): starts Script_TravelerEvent
; (runs script command SCRIPT_TRAVELER_EVENT) through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the
; script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_TravelerEvent (StartScriptAtHL_B13) (E-0271; was Talk_TravelerEvent) (E-0344: the
; address in its name dropped or read as the label there; was Talk_TravelerEvent; named after the
; script it starts; E-0364: was Talk_TravelerEvent)
; starts Script_TravelerEvent (E-0248)
Talk_TravelerEvent::
    ld hl, Script_TravelerEvent
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents", ROMX

; Talk category 1 (DispatchTalkEvent entry 1, wTalkEventIndex = 1): jumps by wTalkEventGroup through
; its table of 247 handlers, with no bound check. The first entries are the Great Log island talks
; (0 GreatLogTalkEvents_NoEvent, 1 Talk_SceneTerry, 2 GreatLogTalkEvents_Mama, then townspeople,
; bookshelves and vases) and the last three are GreatLogTalkEvents_SyncMap17ObjectFlags,
; GreatLogTalkEvents_SyncMap04ObjectFlags and GreatLogTalkEvents_YoureTheChildAfterRival. The
; handlers read here start messages up to $0DEF as well as scripts, so the range $0000-$02DF of the
; earlier note is too narrow. (C1, E-0377)
; talk category 1: jumps by wTalkEventGroup to the talk handlers of the Great Log home island
; (messages from $0000-$02DF: Warubou, Prince Kameha, the arena sign)
GreatLogTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw GreatLogTalkEvents_NoEvent
    dw Talk_SceneTerry
    dw GreatLogTalkEvents_Mama
    dw TalkMsg0023_HeroCheckedTheBookshelfBehavior
    dw TalkMsg001B_ThisHayIsPrettyGoodMaybe
    dw TalkMsg0026_HeroCheckedTheOvenItSmelled
    dw TalkMsg0027_HeroPeeredIntoTheVaseIt
    dw TalkMsg0016_ItSeemsToMeThatThe
    dw GreatLogTalkEvents_ShowYoDidYouEnjoy
    dw TalkMsg0019_ThereArentManyFriendsHere
    dw TalkMsg0032_HelloThereYouMustBeThe
    dw TalkMsg003C_YoureTheKidsFromTheNew
    dw TalkMsg0040_OnThisIslandEveryDayGoes
    dw GreatLogTalkEvents_GiveTinyMedal
    dw TalkMsg0034_TheHorridPrinceAndThatElemental
    dw TalkMsg020F_ThereAreSomeItemsThatCan
    dw TalkMsg003A_ThatWeirdApeThingIsWarubou
    dw TalkMsg0035_TheKingIsTooLenientOn
    dw TalkMsg003B_ThisPalmTreeIsGreatLogWe
    dw TalkMsg0038_HeroPeeredIntoTheVaseA
    dw TalkMsg0041_WarubouIsTheIslandsSpirit
    dw TalkMsg003D_WeLiveInsideHereImKeeping
    dw TalkMsg003F_InsideTheWellIsTheLogs
    dw GreatLogTalkEvents_ShowImWarubouGreatLogsSpirit
    dw GreatLogTalkEvents_ShowImPrinceKamehaOf
    dw GreatLogTalkEvents_WarubouInCastle
    dw TalkMsg001A_IAccidentallyWentOutside
    dw GreatLogTalkEvents_ShowCobiHeroWhileYoure
    dw GreatLogTalkEvents_ShowTaraBigBrotherWhile
    dw TalkMsg011E_IfYourPartyIsWipedOut
    dw TalkMsg021F_DoYouKnowAboutLogTwigIts
    dw TalkMsg04D0_HeroReadTheSignMonsterArena
    dw GreatLogTalkEvents_Guide
    dw GreatLogTalkEvents_Slide
    dw TalkMsg021C_MonstersHateBeingAwayFrom
    dw TalkMsg0221_HelloThereYoungsterTakeThese
    dw TalkMsg0222_HeyALittleBittyMasterHi
    dw GreatLogTalkEvents_Grandparent
    dw TalkMsg0224_TakeCareToFindTinyMedals
    dw GreatLogTalkEvents_Master
    dw TalkMsg0D8C_WataWataTerryBattledInThe
    dw TalkMsg0D8D_FwahahahahaHowAmusingEven
    dw TalkMsg022D_WarpWingReturnsYouInstantly
    dw Talk_DoYouHaveAnyIdeaAbout
    dw TalkMsg022C_ThereAreBooksThatChangeYour
    dw TalkMsg0005_YouFolksRunAMonsterFarm
    dw TalkMsg0006_TheresASpiritInGreatLogThats
    dw GreatLogTalkEvents_OnTheShip
    dw Talk_SailingIsSureExhilarating
    dw TalkMsg000A_WellSoonBeReachingGreatLog
    dw GreatLogTalkEvents_EditionChoice
    dw GreatLogTalkEvents_ShowTheFarmIsFull
    dw GreatLogTalkEvents_ShowTheFarmIsFull
    dw GreatLogTalkEvents_ShowTheFarmIsFull
    dw TalkMsg0BAC_YouNeedToStrikeTheRight
    dw TalkMsg0D84_SomeMonstersMayBeToughBut
    dw TalkMsg023F_IWasOnMyWayTo
    dw TalkMsg0240_PackProperlyIfYoureGoing
    dw TalkMsg0241_TryTheSlideItsAShortcut
    dw TalkMsg0243_HeroCheckedTheBookshelfBookmark
    dw TalkMsg0244_HeroCheckedTheBookshelfJournal
    dw TalkMsg0245_HeroPeeredIntoTheVaseIt
    dw GreatLogTalkEvents_LetMeAsk
    dw TalkMsg0249_HeroCheckedTheBookshelfDiary
    dw TalkMsg0256_HeroCheckedTheDresserItWas
    dw TalkMsg02B0_HeroPeeredIntoTheBarrelIt
    dw GreatLogTalkEvents_DidYouKnow
    dw TalkMsg025A_HeroCheckedTheDresserItWas
    dw TalkMsg025B_HeroCheckedTheBookshelfThis
    dw IfFlag134Msg0314_HeroTriedToOpenTheChest
    dw GreatLogTalkEvents_Christener
    dw TalkMsg04C5_HeroCheckedTheBookshelfHandbook
    dw TalkMsg04C6_HeroCheckedTheBookshelfHandbook
    dw TalkMsg04C7_HeroCheckedTheBookshelfHandbook
    dw TalkMsg08C0_WeGetMoreAndMoreStubborn
    dw GreatLogTalkEvents_ShowHeresThatTinyMedalWait
    dw GreatLogTalkEvents_Hibernation
    dw TalkMsg0A50_ZzzzYawnHuhIsItMorning
    dw TalkMsg0A52_OurKindAlwaysStaysNearWater
    dw TalkMsg0A53_ZzzZzzZzzWhoopsWasI
    dw TalkMsg0A59_HeroReadTheSignSshMonsters
    dw Talk_HeroCheckedTheCasket
    dw Talk_HeroCheckedTheCasket_2
    dw TalkMsg0A5D_HeroReadTheSignWatchYour
    dw Talk_HeroPeeredIntoTheHole
    dw TalkMsg0292_TheyTakeEntryFeesFromMasters
    dw TalkMsg027D_WhatDoYouSupposeMonsters
    dw TalkMsg027E_GRAHHUNGRYLOOKDELICIOUS
    dw TalkMsg028C_ListenToWinYouNeedBalance
    dw TalkMsg028D_ItsNotAllAboutWinningWe
    dw TalkMsg028E_ArrrrrooohMyBloodBurnsICan
    dw TalkMsg0287_MonstersCanGrowOnlySoMuch
    dw TalkMsg0286_TheArenaIsWhereMastersCan
    dw TalkMsg028F_IfYouComeAcrossAMonster
    dw TalkMsg0294_IfYouWinAnArenaTourney
    dw TalkMsg0290_SirloinIsTheTopsHarrumph
    dw TalkMsg0291_IIDidntFallForAny
    dw GreatLogTalkEvents_ArenaReceptionist
    dw TalkMsg0296_HeroPeeredIntoTheVaseIt
    dw VaseItem_TinyMedal_Flag010C
    dw TalkMsg027A_ListenThisIsASecretTheres
    dw GreatLogTalkEvents_ArenaClassChoice
    dw GreatLogTalkEvents_Breeder
    dw TalkMsg04B5_DoYouKnowAllTheKinds
    dw TalkMsg04B6_IfYouEatAnyBadMeatLike
    dw GreatLogTalkEvents_EggEvaluator
    dw GreatLogTalkEvents_StarryShrine
    dw Talk_ImTheProfsAssistantDoYou
    dw TalkMsg08D8_HeroCheckedTheBookshelfBreeding
    dw TalkMsg08D9_HeroCheckedTheBookshelfBreeding
    dw TalkMsg08CD_HeroCheckedTheDoorTheDoor
    dw TalkMsg02DC_GreatLogsStarryShrineWasnt
    dw TalkMsg0DD4_IfYouBreedTheParentsGo
    dw TalkMsg02DD_ParentsPassOnAbilitiesTo
    dw GreatLogTalkEvents_YouCanCallMe
    dw TalkMsg0A6F_MyHusbandLovesToCollectThings
    dw TalkMsg0A75_HeroCheckedTheDresserItOverflowed
    dw TalkMsg0A76_HeroCheckedTheDresserItOverflowed
    dw TalkMsg0A77_HeroCheckedTheOvenThereWas
    dw TalkMsg025E_MyGranddaughterIsPainfully
    dw TalkMsg0269_HeroCheckedTheDresserGirls
    dw VaseItem_LogTwig
    dw TalkMsg026A_HeroCheckedThePlushDollIt
    dw TalkMsg0A32_ThereArePowersThatLetYou
    dw TalkMsg0A33_HaveYouBeenToTheStarry
    dw TalkMsg020A_ImChoppingSomeTreesDownTo
    dw TalkMsg08BF_MasterOnlyMakesMeChargeIt
    dw GreatLogTalkEvents_Shopkeeper
    dw TalkMsg0A39_TheManHereHasRareKeys
    dw TalkMsg0A3C_KingIfYouSee
    dw TalkMsg0A3E_YoureFreeToGo
    dw TalkMsg0A3F_TheKingAndPrinces
    dw Talk0A41_ThisIsGreatLogCastle
    dw TalkMsg0A42_TheTavernJustOutsideTheCastle
    dw TalkMsg0A43_HeyWelcomeAllMastersAreWelcome
    dw TalkMsg0A44_WhenYouBreedNoticeANumber
    dw TalkMsg0A45_IfYouWantToMakeA
    dw Talk0A49_BreedingCouldResultIn
    dw TalkMsg0A4A_FromUpHerePeople
    dw VaseItem_DrakScale
    dw TalkMsg0A4C_GreatLogCastleWasMade
    dw TalkMsg0A4D_TheIslandUsedTo
    dw Talk04BA_IfYouGetAn
    dw Talk04CB_ThatKeyIUsed
    dw Talk04CE_HeroCheckedTheShelf
    dw TalkMsg04CF_HeroPeeredIntoTheVaseIt
    dw GreatLogTalkEvents_ShowItsExcitingToThink
    dw TalkMsg0299_ImApprenticingUnderTheBoss
    dw TalkMsg029A_DayAfterDayIExamineKeys
    dw GreatLogTalkEvents_NothingToSay
    dw GreatLogTalkEvents_NothingToSay
    dw GreatLogTalkEvents_NothingToSay
    dw TalkMsg0504_IfTheIslandSink
    dw TalkMsg0512_KamehaYoHeroThanks
    dw ChestItem_LifeAcorn_Flag011B
    dw ChestItem_Quest
    dw Talk04C0_AllRightyWellDo
    dw Talk0276_IfYouWantTo
    dw GreatLogTalkEvents_CongratulationsAfterDarck
    dw Talk_SlimeEncounter
    dw TalkMsg0024_HeroCheckedTheDresserChildrens
    dw TalkMsg0025_HeroCheckedTheDresserItSmelled
    dw TalkMsg001D_HeroPeeredIntoTheBarrelIt
    dw TalkMsg001C_HeroCheckedThePumpItsRusted
    dw GreatLogTalkEvents_Healer
    dw TalkMsg0037_HeroTriedToOpenTheChest_13
    dw GreatLogTalkEvents_Shop
    dw GreatLogTalkEvents_ShowTerryHereJustTake
    dw TalkMsg0D4E_ImDiggingHereBecauseIThink
    dw Talk0043_HeroCheckedTheOdd
    dw Talk0036_ThereWereManyWild
    dw Talk0037_HeroTriedToOpen
    dw GreatLogTalkEvents_TravelingMerchant
    dw TalkMsg0268_YepShesTakingGood
    dw TalkMsg022E_SnivelThisBookIsSoSad
    dw TalkMsg022F_EvenICanCastSpellsIf
    dw TalkMsg0242_MyDadsAFamousMonsterMaster
    dw TalkMsg02B1_HeroPeeredIntoTheOvenIt
    dw GreatLogTalkEvents_WantToKnowHow
    dw TalkMsg02A6_PuttingUpABridgeIsEasy
    dw TalkMsg0209_DidYouKnowYouCanRecord
    dw TalkMsg0A51_WhenAAppearsByAMonsters
    dw Talk_DoYouWantToKnowHow
    dw Talk08D1_TheEvaluatorSaidI
    dw Talk04D2_UpAheadIsThe
    dw TalkMsg021F_DoYouKnowAbout
    dw TalkMsg0220_InOtherWorldsYoull
    dw TalkMsg027F_ItsNotEasyTo
    dw TalkMsg0280_MamaIsABig
    dw TalkMsg0284_IComeToWatchEveryDay
    dw TalkMsg0285_MonstersMirrorTheirMasters
    dw TalkMsg0288_MyHusbandIsAMasterStill
    dw Talk_HelloThereDoYouKnowAbout
    dw TalkMsg0293_IfYouWinInTheS
    dw TalkMsg0295_InAnArenaBattleYouCant
    dw TalkMsg027B_WhichToTakeMonstersYouve
    dw TalkMsg027C_YouNeedLuckOnYourSide
    dw TalkMsg029C_HeroPeeredIntoTheOvenIt
    dw TalkMsg029D_HeroPeeredIntoTheVaseIt
    dw VaseItem_TinyMedal_Flag0132
    dw TalkMsg02B1_HeroPeeredIntoTheOvenIt_13
    dw TalkMsg0225_HeroPeeredIntoTheVaseThere
    dw VaseItem_TinyMedal_Flag0130
    dw TalkMsg024A_HeroCheckedThePlushDollIt
    dw GreatLogTalkEvents_Talk204
    dw GreatLogTalkEvents_ShowHereItIstheTinyMedal
    dw TalkMsg0245_HeroPeeredIntoTheVaseIt_13
    dw Talk00FC_YouHaveToEat
    dw TalkMsg0A74_TheMedalMasterWas
    dw GreatLogTalkEvents_PrinceKamehaMissing
    dw BarrelItem_TinyMedal_Flag013C
    dw VaseItem_Sirloin
    dw TalkMsg0A35_ImABugSo
    dw TalkMsg0A34_UhehehehDidYouKnowThisZombies
    dw TalkMsg0A68_MyEmyuIsVery
    dw TalkMsg0A6B_MonstersLookSoFrightening
    dw Talk0A40_PleaseEnterTheKing
    dw TalkMsg0A4B_OnTheHorizonYou
    dw TalkMsg04D1_ThereAreTimesWhenYouHave
    dw GreatLogTalkEvents_ShowHeroFoundAMagic
    dw TalkMsg0519_ThisIsATimeWeNeed
    dw TalkMsg051A_IDidntWantToBelieveGreatLog
    dw TalkMsg051B_IWontBelieveThatGreatLog
    dw TalkMsg051C_TheKingSaidThatGreatLogWill
    dw TalkMsg051D_EveryonePleaseRemainCalm
    dw TalkMsg051E_TheGreatLogTreeAppearedTo
    dw TalkMsg055E_HeroCheckedTheBookshelfMagic
    dw TalkMsg0DD5_MonsterSkillsArePassedOn
    dw GreatLogTalkEvents_ShowEgg
    dw GreatLogTalkEvents_Egg
    dw GreatLogTalkEvents_SpeciesPreset
    dw GreatLogTalkEvents_ResetKeyShopTalk
    dw $0000 ; unused index (E-0207)
    dw TalkMsg029B_IFoundAKey
    dw Talk0DE3_TheSeaIsHuge
    dw TalkMsg0220_InOtherWorldsYoull_2
    dw ChestItem_Snow
    dw ChestItem_MagicBelt
    dw GreatLogTalkEvents_Msg055F_HeroCheckedTheBookshelf
    dw $0000 ; unused index (E-0207)
    dw Talk0B56_WhenYouBreedMonsters
    dw Talk0B6D_BreedingFireAndIce
    dw Talk0D90_HumphImTerry
    dw GreatLogTalkEvents_SetObject0XAfter50Species
    dw GreatLogTalkEvents_SyncMap17ObjectFlags
    dw GreatLogTalkEvents_SyncMap04ObjectFlags
    dw GreatLogTalkEvents_YoureTheChildAfterRival

; Great Log talk 0: returns at once; this entry starts nothing. The generated comment above it
; ('starts Script_SceneTerry') belongs to the next entry, Talk_SceneTerry. (C2, E-0370; probed
; E-0377)
; starts Script_SceneTerry (E-0248)
GreatLogTalkEvents_NoEvent::
    ret

SECTION "Bank 13 Talk_SceneTerry", ROMX

; Great Log talk 1 (GreatLogTalkEvents): starts Script_SceneTerry (plays sound $60, runs script
; command SCRIPT_SCENE_TERRY). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SceneTerry (StartScriptAtHL_B13) (E-0271; was Talk_SceneTerry) (E-0344: the address
; in its name dropped or read as the label there; was Talk_SceneTerry; named after the script it
; starts, Script_SceneTerry)
; starts Script_SceneTerry (E-0248)
Talk_SceneTerry::
    ld hl, Script_SceneTerry
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Mama", ROMX

; Great Log talk, Mama: by story progress: after EVENT_THANKS_FOR_COMING_BY_025 'you were so busy'
; ($0D91) once (only after the errands began and before the LoveWater), then 'The weather is
; beautiful again.' ($0B00); after the three items scene $0500; after the rival is defeated the
; errands (GreatLogTalkEvents_Mama_Errands); after the long faces scene an Herb (item 1) with 'Are
; you going out to ...' when the bag has room, then $0102; after Warubou's food scene the package
; script once, with field command 1, then $006C; after the vault scene $0022; otherwise 'You've come
; at the right ...'. (C1, E-0357)
GreatLogTalkEvents_Mama::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_test_flag_bit3
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .skip2
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jp c, .skip
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_great_log_talk_events_mama_errands
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_VAULT_SETTLED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_You_3 ; script '*: You've come at the right'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0022 ; '*: Go to the Vault and'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_DID_YOU_GET_THE_PACKAGE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, Script_DidYouGetThe ; script '*: Did you get the package'
    call StartScriptAtHL_B13
    ld de, EVENT_DID_YOU_GET_THE_PACKAGE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $006c ; '*: You can go out, but'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_HERO_RECEIVED_AN_HERB
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    call InventoryHasFreeSlotCheck_Bank13
    jr c, .call_start_script_at_hl_b13

.call_start_message_command09_hl_b133:
    ld hl, $0102 ; '*: It's a beautiful day for'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld [hl], $01
    ld hl, Script_AreYouGoingOut ; script '*: Are you going out to'
    call StartScriptAtHL_B13
    ret

.call_great_log_talk_events_mama_errands:
    call GreatLogTalkEvents_Mama_Errands
    ret

.skip:
    jr .call_great_log_talk_events_mama_errands

.skip2:
    jr .call_great_log_talk_events_mama_errands

.call_start_message_command09_hl_b134:
    ld hl, $0500 ; '*: 0… There have been frequent'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit3:
    ld de, EVENT_HERO_YOU_WERE_SO_BUSY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_YOUVE_BEEN_GOING_OUT_A_180
    call TestFlagBit
    jr nc, .call_start_message_command09_hl_b135
    ld de, EVENT_OH_YOU_BOUGHT_THE_LOVE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld hl, $0d91 ; '*: 0, you were so busy'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HERO_YOU_WERE_SO_BUSY
    call SetFlagBit
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0b00 ; '*: The weather is beautiful again.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Mama_Errands", ROMX

; Great Log talk, the errands of Mama (called from GreatLogTalkEvents_Mama after the rival is
; defeated). First ITEM_LOVEWATER: Script_You_4 once (setting EVENT_YOUVE_BEEN_GOING_OUT_A and
; EVENT_YOUVE_BEEN_GOING_OUT_A_180), the reminder $0202 until the item is carried, then
; Script_OhYouBoughtThe takes it (EVENT_OH_YOU_BOUGHT_THE_LOVE) and the next talk says $0214
; (EVENT_ILL_GET_YOU_TO_RUN). Then two errands, ITEM_POTION (until
; EVENT_HERO_HANDED_OVER_THE_POTION; reminder $08A5) and ITEM_RIB (until
; EVENT_HERO_HANDED_OVER_THE_RIB; reminder $08AA), each asked by Script_OhYou or Script_OhYou_3
; until EVENT_MAMA_HANDED_OVER_400_G or EVENT_MAMA_HANDED_OVER_600_G is set and finished by
; Script_OhYou_2 or Script_OhYou_4 taking the item. After those, $0205 until
; EVENT_SCENE_MERMAID_KINGDOM_022; then the ITEM_SIRLOIN errand: Script_IWasGoingTo (or
; Script_IWasGoingTo_2 behind EVENT_NEVER_SET) until EVENT_MAMA_HANDED_OVER_1_200, the reminder
; $0A27, Script_TheyDidn when the item is taken, and $0A2A once EVENT_HERO_HANDED_OVER_THE_SIRLOIN
; is set. (C2, E-0370; probed E-0377)
GreatLogTalkEvents_Mama_Errands::
    ld de, EVENT_ILL_GET_YOU_TO_RUN
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_OH_YOU_BOUGHT_THE_LOVE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_YOUVE_BEEN_GOING_OUT_A_180
    call TestFlagBit
    jr c, .set_temp0_to_02
    ld hl, Script_You_4 ; script '*: You've been going out a'
    call StartScriptAtHL_B13
    ld de, EVENT_YOUVE_BEEN_GOING_OUT_A
    call SetFlagBit
    ld de, EVENT_YOUVE_BEEN_GOING_OUT_A_180
    call SetFlagBit
    ret

.set_temp0_to_02:
    ld a, $02
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_remove_inventory_slot_shift_down
    ld hl, $0202 ; '*: Buy LoveWater for me, OK?'
    call StartMessageCommand09HL_B13
    ret

.call_remove_inventory_slot_shift_down:
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_OhYouBoughtThe ; script '*: Oh? You bought the LoveWater!'
    call StartScriptAtHL_B13
    ld de, EVENT_OH_YOU_BOUGHT_THE_LOVE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0214 ; '*: I'll get you to run'
    call StartMessageCommand09HL_B13
    ld de, EVENT_ILL_GET_YOU_TO_RUN
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, EVENT_HERO_HANDED_OVER_THE_POTION
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_MAMA_HANDED_OVER_400_G
    call TestFlagBit
    jr c, .set_temp0_to_04
    ld hl, Script_OhYou ; script '*: Oh? You'll run another errand?'
    call StartScriptAtHL_B13
    ret

.set_temp0_to_04:
    ld a, $04
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b13
    ld hl, $08a5 ; '*: I need you to get'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_OhYou_2 ; script '*: Oh… You've found what I'
    call StartScriptAtHL_B13
    farcall RemoveInventorySlotShiftDown
    ret

.call_test_flag_bit2:
    ld de, EVENT_HERO_HANDED_OVER_THE_RIB
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, EVENT_MAMA_HANDED_OVER_600_G
    call TestFlagBit
    jr c, .set_temp0_to_1B
    ld hl, Script_OhYou_3 ; script '*: Oh? You'll run another errand?'
    call StartScriptAtHL_B13
    ret

.set_temp0_to_1B:
    ld a, $1b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b132
    ld hl, $08aa ; '*: I want you to buy'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_OhYou_4 ; script '*: Oh… You've found what I'
    call StartScriptAtHL_B13
    farcall RemoveInventorySlotShiftDown
    ret

.call_test_flag_bit3:
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit4
    ld hl, $0205 ; '*: I don't need any help'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit4:
    ld de, EVENT_HERO_HANDED_OVER_THE_SIRLOIN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_MAMA_HANDED_OVER_1_200
    call TestFlagBit
    jr c, .set_temp0_to_1C
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b133
    ld hl, Script_IWasGoingTo ; script '*: I was going to ask'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b133:
    ld hl, Script_IWasGoingTo_2 ; script '*: I was going to ask'
    call StartScriptAtHL_B13
    ret

.set_temp0_to_1C:
    ld a, $1c
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_remove_inventory_slot_shift_down2
    ld hl, $0a27 ; '*: Buy some Sirloin for our'
    call StartMessageCommand09HL_B13
    ret

.call_remove_inventory_slot_shift_down2:
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_TheyDidn ; script '*: They didn't have any around'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0a2a ; '*: I don't have any errands'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0023_HeroCheckedTheBookshelfBehavior", ROMX

; Great Log talk 3 (GreatLogTalkEvents): starts message $0023 ('<BUF0> checked the bookshelf.'
; 'Behavior of ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with
; the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0023 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Behavior of Wild' (E-0268, the E-0082 shape; was
; TalkMsg0023_HeroCheckedTheBookshelfBehavior)
TalkMsg0023_HeroCheckedTheBookshelfBehavior::
    ld hl, $0023 ; '0 checked the bookshelf. 'Behavior of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg001B_ThisHayIsPrettyGoodMaybe", ROMX

; Great Log talk 4 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_MERMAID_KINGDOM_022 set and EVENT_THIS_IS_AGREAT set, Script_HaveYouEverFound (first
; message 'Have you ever found a ...'); else with EVENT_SCENE_MERMAID_KINGDOM_022 set,
; Script_ThisIsAGreat; otherwise, message $001B ('This hay is pretty good. ...'). A message starts
; through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1); a script starts through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0022 then jr c, TalkMsg001B_ThisHayIsPrettyGoodMaybe.call_test_flag_bit);
; starts message $001B through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This hay is pretty good. Maybe I' (E-0268, the E-0082 shape; was
; TalkMsg001B_ThisHayIsPrettyGoodMaybe)
TalkMsg001B_ThisHayIsPrettyGoodMaybe::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $001b ; '*: This hay is pretty good.'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_THIS_IS_AGREAT
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_ThisIsAGreat ; script '*: This is a great spot'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HaveYouEverFound ; script '*: Have you ever found a'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0026_HeroCheckedTheOvenItSmelled", ROMX

; Great Log talk 5 (GreatLogTalkEvents): starts message $0026 ('<BUF0> checked the oven. It smelled
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0026 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the oven. It smelled of' (E-0268, the E-0082 shape; was
; TalkMsg0026_HeroCheckedTheOvenItSmelled)
TalkMsg0026_HeroCheckedTheOvenItSmelled::
    ld hl, $0026 ; '0 checked the oven. It smelled'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0027_HeroPeeredIntoTheVaseIt", ROMX

; Great Log talk 6 (GreatLogTalkEvents): starts message $0027 ('<BUF0> peered into the vase. It
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0027 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0027_HeroPeeredIntoTheVaseIt)
TalkMsg0027_HeroPeeredIntoTheVaseIt::
    ld hl, $0027 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0016_ItSeemsToMeThatThe", ROMX

; Great Log talk 7 (GreatLogTalkEvents): picks the reply by story flags, latest first. With
; EVENT_THANKS_FOR_COMING_BY_025 set it counts the species flagged or listed
; (TotalSpeciesFlaggedOrListed, total in hTemp1:hTemp0) and says $0B01 ('You and your monsters saved
; ...') below 20; $0DE7, $0DE8, $0DE9, $0DEA, $0DEB, $0DEC and $0DED ('Hey, <BUF0>! ...') for 20-29,
; 30-39, 40-49, 50-99, 100-149, 150-199 and 200-249; $0DEE for 250-311; and $0DEF ('Congratulations,
; <BUF0>! ...') for 312 or more. Else EVENT_SCENE_THREE_ITEMS: $0501; EVENT_SCENE_SHIELD2_023: $0A2B
; ('MadGopher helped me excavate. Look ...'); EVENT_SCENE_MERMAID_KINGDOM_022:
; TalkMsg0016_ItSeemsToMeThatThe_MadGopher; EVENT_SCENE_RIVAL_DEFEATED_021: $0204 ('A bridge to the
; island ...'); EVENT_SCENE_LONG_FACES_002: the first time, with room in the bag, item $1A
; (ITEM_PORKCHOP) goes into the first free slot (without setting bit 6 of wInventorySortFlags),
; Script_WhyDoYouHave starts and EVENT_IT_SEEMS_TO_ME_THAT is set ($0107 when the bag is full);
; after that $0107 with one monster, $0108 once with two or more (setting
; EVENT_IT_SEEMS_TO_ME_THAT_101) and then $0109; EVENT_LOOK_AN_ISLAND_JUST_DOESN: $0064;
; EVENT_SCENE_WARUBOU_FOOD2_00C: Script_HahTheIsland (Script_HahTheIsland_2 behind EVENT_NEVER_SET);
; EVENT_FOLLOWER_FACE_PLAYER: $002E ('Go help your mother now. ...'); EVENT_SCENE_VAULT_SETTLED:
; Script_I_5 (Script_I_6 behind EVENT_NEVER_SET); otherwise $0016 ('It seems to me that ...').
; Messages start through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1) and scripts through StartScriptAtHL_B13
; (wScriptPointerLo/Hi, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_total_species_flagged_or_listed; flag 0024 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_start_message_command09_hl_b136; flag 0023 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_start_message_command09_hl_b135; flag 0022 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_talk_msg0016_it_seems_to_me_that_the_mad; flag 0021 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_start_message_command09_hl_b134; flag 0002 then jp c,
; TalkMsg0016_ItSeemsToMeThatThe.call_test_flag_bit3; flag 000E then jr c,
; TalkMsg0016_ItSeemsToMeThatThe.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg0016_ItSeemsToMeThatThe.call_test_flag_bit2; flag 0014 then jr c,
; TalkMsg0016_ItSeemsToMeThatThe.call_start_message_command09_hl_b13; flag 0003 then jr c,
; TalkMsg0016_ItSeemsToMeThatThe.call_test_flag_bit); starts message $0016 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'It seems to me that the
; people' (E-0268, the E-0082 shape; was TalkMsg0016_ItSeemsToMeThatThe)
TalkMsg0016_ItSeemsToMeThatThe::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_total_species_flagged_or_listed
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b136
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jp c, .call_talk_msg0016_it_seems_to_me_that_the_mad
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jp c, .call_test_flag_bit3
    ld de, EVENT_LOOK_AN_ISLAND_JUST_DOESN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_FOLLOWER_FACE_PLAYER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_VAULT_SETTLED
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0016 ; '*: It seems to me that'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_I_5 ; script '*: I've heard that there are'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_I_6 ; script '*: I've heard that there are'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $002e ; '*: Go help your mother now.'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld hl, Script_HahTheIsland ; script '*: Hah? The island's going to'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_HahTheIsland_2 ; script '*: Hah? The island's going to'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0064 ; '*: The island's sinking, right. Not'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit3:
    ld de, EVENT_IT_SEEMS_TO_ME_THAT
    call TestFlagBit
    jr c, .check_party_count
    call InventoryHasFreeSlotCheck_Bank13
    jr c, .call_start_script_at_hl_b133
    ld hl, $0107 ; '*: To win the trust of'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b133:
    ld [hl], $1a
    ld hl, Script_WhyDoYouHave ; script '*: Why do you have a'
    call StartScriptAtHL_B13
    ld de, EVENT_IT_SEEMS_TO_ME_THAT
    call SetFlagBit
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $02
    jr nc, .call_test_flag_bit4
    ld hl, $0107 ; '*: To win the trust of'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit4:
    ld de, EVENT_IT_SEEMS_TO_ME_THAT_101
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld hl, $0108 ; '*: It looks like you've become'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IT_SEEMS_TO_ME_THAT_101
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0109 ; '*: Your monsters are your friends'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0204 ; '*: A bridge to the island'
    call StartMessageCommand09HL_B13
    ret

.call_talk_msg0016_it_seems_to_me_that_the_mad:
    call TalkMsg0016_ItSeemsToMeThatThe_MadGopher
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0a2b ; '*: MadGopher helped me excavate. Look'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0501 ; '*: People have been whispering that'
    call StartMessageCommand09HL_B13
    ret

.call_total_species_flagged_or_listed:
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jp nz, .check_temp0
    ldh a, [hTemp0]
    cp $14
    jr nc, .cp_1E
    ld hl, $0b01 ; '*: You and your monsters saved'
    call StartMessageCommand09HL_B13
    ret

.cp_1E:
    cp $1e
    jr nc, .cp_28
    ld hl, $0de7 ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_28:
    cp $28
    jr nc, .cp_32
    ld hl, $0de8 ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_32:
    cp $32
    jr nc, .cp_64
    ld hl, $0de9 ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_64:
    cp $64
    jr nc, .cp_96
    ld hl, $0dea ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_96:
    cp $96
    jr nc, .cp_C8
    ld hl, $0deb ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_C8:
    cp $c8
    jr nc, .cp_FA
    ld hl, $0dec ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.cp_FA:
    cp $fa
    jr nc, .loop
    ld hl, $0ded ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.loop:
    ld hl, $0dee ; '*: Hey, 0! You've befriended a'
    call StartMessageCommand09HL_B13
    ret

.check_temp0:
    ldh a, [hTemp0]
    cp $38
    jr c, .loop
    ld hl, $0def ; '*: Congratulations, 0! You've cataloged every'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0016_ItSeemsToMeThatThe_MadGopher", ROMX

; Great Log talk, the carpenter: after EVENT_REWARD_ITEM_OR_KEY 'MadGopher's been a great help.'
; ($08B6); with a MadGopher (species $5A) in a party of two or more 'A MadGopher joined you? Could
; ...' in three scripts (the reward given, the bag full or not); without it 'Beavern helped put up
; the ...', or $08B2 with only one monster. (C2, E-0357; probed E-0377)
TalkMsg0016_ItSeemsToMeThatThe_MadGopher::
    ld de, EVENT_REWARD_ITEM_OR_KEY
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b132
    ld de, EVENT_BEAVERN_HELPED_PUT_UP
    call TestFlagBit
    jr c, .set_temp0
    ld hl, Script_BeavernHelpedPutUp ; script '*: Beavern helped put up the'
    call StartScriptAtHL_B13
    ret

.set_temp0:
    ld hl, $005a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, .check_party_count
    ld hl, Script_BeavernHelpedPutUp ; script '*: Beavern helped put up the'
    call StartScriptAtHL_B13
    ret

.check_party_count:
    ld a, [wPartyCount]
    dec a
    jr z, .call_start_message_command09_hl_b13
    ld de, EVENT_REWARD_ITEM_OR_KEY_2
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_script_at_hl_b13
    or a
    jr z, .call_start_script_at_hl_b13
    ld hl, Script_AMadGopherJoinedYou_2 ; script '*: A MadGopher joined you? Could'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_AMadGopherJoinedYou_3 ; script '*: A MadGopher joined you? Could'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_AMadGopherJoinedYou ; script '*: A MadGopher joined you? Could'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $08b2 ; '*: A MadGopher joined you? Could'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $08b6 ; '*: MadGopher's been a great help.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowYoDidYouEnjoy", ROMX

; Great Log talk, Slash: 'Yo, did you enjoy the ...' ($0017) the first time, then 'If you're in need
; of ...' ($0018); after Warubou's food scene 'The island's going to sink?' ($0065). (C2, E-0357;
; probed E-0377)
GreatLogTalkEvents_ShowYoDidYouEnjoy::
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_YO_DID_YOU_ENJOY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0017 ; '*: Yo, did you enjoy the'
    call StartMessageCommand09HL_B13
    ld de, EVENT_YO_DID_YOU_ENJOY
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0018 ; 'Slash: If you're in need of'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0065 ; 'Slash: The island's going to sink?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0019_ThereArentManyFriendsHere", ROMX

; Great Log talk 9 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B08 ('The items you find in ...'); else with
; EVENT_SCENE_LONG_FACES_002 set, message $010A ('Off to another world! There ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $0066 ('This island is going to ...'); else with
; EVENT_SCENE_VAULT_SETTLED set, message $002F ('If some monster masters keep ...'); otherwise,
; message $0019 ('... many friends here. ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg0019_ThereArentManyFriendsHere.call_start_message_command09_hl_b134; flag 0002 then jr c,
; TalkMsg0019_ThereArentManyFriendsHere.call_start_message_command09_hl_b133; flag 000C then jr c,
; TalkMsg0019_ThereArentManyFriendsHere.call_start_message_command09_hl_b132; flag 0003 then jr c,
; TalkMsg0019_ThereArentManyFriendsHere.call_start_message_command09_hl_b13); starts message $0019
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'There aren't many
; friends here. It's lonely' (E-0268, the E-0082 shape; was TalkMsg0019_ThereArentManyFriendsHere)
TalkMsg0019_ThereArentManyFriendsHere::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_VAULT_SETTLED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0019 ; '*: There aren't many friends here.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $002f ; '*: If some monster masters keep'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0066 ; '*: This island is going to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $010a ; '*: Off to another world! There'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0b08 ; '*: The items you find in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0032_HelloThereYouMustBeThe", ROMX

; Great Log talk 10 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set message $0B0D; else with EVENT_SCENE_DARCK_DEFEATED set $053F;
; else with EVENT_SCENE_THREE_ITEMS set $0505 ('People have been saying that ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set $020B ('Take the ladder up ahead ...'); else with
; EVENT_SCENE_LONG_FACES_002 set $010C; else with EVENT_SCENE_WARUBOU_FOOD2_00C set $0068 ('Huh? The
; island is going ...') the first time, setting EVENT_HELLO_THERE_YOU_MUST_BE, then $0069 ('Prince
; Kameha was saying the ...'); otherwise $0032 ('Hello, there! You must be ...'). Messages start
; through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_start_message_command09_hl_b136; flag 00D1 then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_start_message_command09_hl_b135; flag 0024 then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_start_message_command09_hl_b134; flag 0021 then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_start_message_command09_hl_b133; flag 0002 then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg0032_HelloThereYouMustBeThe.call_test_flag_bit); starts message $0032 through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'Hello, there! You must be
; the farm' (E-0268, the E-0082 shape; was TalkMsg0032_HelloThereYouMustBeThe)
TalkMsg0032_HelloThereYouMustBeThe::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0032 ; '*: Hello, there! You must be'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_HELLO_THERE_YOU_MUST_BE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0068 ; '*: Huh? The island is going'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HELLO_THERE_YOU_MUST_BE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0069 ; '*: Prince Kameha was saying the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $010c ; '*: Oh, that's cute! Hahahahaha! We'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $020b ; '*: Take the ladder up ahead'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0505 ; '*: People have been saying that'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $053f ; '*: I don't think I was'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0b0d ; '*: Hello, GreatLog's mighty hero! Are'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg003C_YoureTheKidsFromTheNew", ROMX

; Great Log talk 11 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set message $0D88 ('I teased you as a ...'); else with
; EVENT_SCENE_THREE_ITEMS set $0D30 ('What if the island sinks ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set $0D0D ('While I was on the ...'); else with
; EVENT_SCENE_LONG_FACES_002 set $011B ('Hm? Are you a master ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set $0073 ('Hm? Warubou wants you to ...') and
; EVENT_YOURE_THE_KIDS_FROM_THE is set (on every such talk; the routine never tests it); else with
; EVENT_THANKS_FOR_COMING_BY set Script_HaveYouHeardAbout ('Have you heard about Magic ...');
; otherwise $003C. Messages start through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1) and scripts through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_message_command09_hl_b135; flag 0024 then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_message_command09_hl_b134; flag 0021 then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_message_command09_hl_b133; flag 0002 then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_message_command09_hl_b13; flag 0007 then jr c,
; TalkMsg003C_YoureTheKidsFromTheNew.call_start_script_at_hl_b13); starts message $003C through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'You're the kids from the new
; farm.' (E-0268, the E-0082 shape; was TalkMsg003C_YoureTheKidsFromTheNew)
TalkMsg003C_YoureTheKidsFromTheNew::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_THANKS_FOR_COMING_BY
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, $003c ; '*: You're the kids from the'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HaveYouHeardAbout ; script '*: Have you heard about Magic'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0073 ; '*: Hm? Warubou wants you to'
    call StartMessageCommand09HL_B13
    ld de, EVENT_YOURE_THE_KIDS_FROM_THE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $011b ; '*: Hm? Are you a master'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0d0d ; '*: While I was on the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0d30 ; '*: What if the island sinks,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0d88 ; '*: I teased you as a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0040_OnThisIslandEveryDayGoes", ROMX

; Great Log talk 12 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B11 ('... traveling, you can ...'); else with
; EVENT_SCENE_DARCK_DEFEATED set, message $0541 ('I hate myself for not ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $050C ('My beloved island is sinking... ...'); else with
; EVENT_SCENE_MERMAID_KINGDOM_022 set, message $08CE ('Many trees have submerged... The ...'); else
; with EVENT_SCENE_LONG_FACES_002 set, message $011A ('Even the most ordinary of ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $0072 ('This island is sinking? If ...'); otherwise,
; message $0040 ('On this island, every day ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b136; flag 00D1 then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b135; flag 0024 then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b134; flag 0022 then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b133; flag 0002 then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg0040_OnThisIslandEveryDayGoes.call_start_message_command09_hl_b13); starts message $0040
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'On this island,
; every day goes by' (E-0268, the E-0082 shape; was TalkMsg0040_OnThisIslandEveryDayGoes)
TalkMsg0040_OnThisIslandEveryDayGoes::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0040 ; '*: On this island, every day'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0072 ; '*: This island is sinking? If'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $011a ; '*: Even the most ordinary of'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $08ce ; '*: Many trees have submerged… The'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $050c ; '*: My beloved island is sinking…'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0541 ; '*: I hate myself for not'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0b11 ; '*: When you're traveling, you can'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_GiveTinyMedal", ROMX

; Great Log talk: gives item $2C when the bag has room, with 'Hey, that's mine! <hero> obtained ...'
; ($00FD). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_GiveTinyMedal::
    call InventoryHasFreeSlotCheck_Bank13
    jr c, .read_inventory_sort_flags
    ret

.read_inventory_sort_flags:
    ld [hl], $2c
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, $00fd ; '*: Hey, that's mine! 0 obtained'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0034_TheHorridPrinceAndThatElemental", ROMX

; Great Log talk 14 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B19 ('Prince Kameha is in training ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set, message $020C ('The castle is in an ...'); else with
; EVENT_SCENE_LONG_FACES_002 set, message $0114 ('... seen Prince Kameha ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $0074 ('... after a monster master? ...'); otherwise,
; message $0034 ('The horrid Prince and that ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0034_TheHorridPrinceAndThatElemental.call_start_message_command09_hl_b134; flag 0021 then
; jr c, TalkMsg0034_TheHorridPrinceAndThatElemental.call_start_message_command09_hl_b133; flag 0002
; then jr c, TalkMsg0034_TheHorridPrinceAndThatElemental.call_start_message_command09_hl_b132; flag
; 000C then jr c, TalkMsg0034_TheHorridPrinceAndThatElemental.call_start_message_command09_hl_b13);
; starts message $0034 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The horrid Prince and that elemental sidekick' (E-0268, the E-0082 shape; was
; TalkMsg0034_TheHorridPrinceAndThatElemental)
TalkMsg0034_TheHorridPrinceAndThatElemental::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0034 ; '*: The horrid Prince and that'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0074 ; '*: You're after a monster master?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0114 ; '*: I haven't seen Prince Kameha'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $020c ; '*: The castle is in an'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0b19 ; '*: Prince Kameha is in training'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg020F_ThereAreSomeItemsThatCan", ROMX

; Great Log talk 15 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B18 ('... shops buy and sell ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0507 ('Prince Kameha came back! What ...'); otherwise,
; message $020F ('There are some items that ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg020F_ThereAreSomeItemsThatCan.call_start_message_command09_hl_b132; flag 0024 then jr c,
; TalkMsg020F_ThereAreSomeItemsThatCan.call_start_message_command09_hl_b13); starts message $020F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'There are some items
; that can be' (E-0268, the E-0082 shape; was TalkMsg020F_ThereAreSomeItemsThatCan)
TalkMsg020F_ThereAreSomeItemsThatCan::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $020f ; '*: There are some items that'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0507 ; '*: Prince Kameha came back! What'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b18 ; '*: GreatLog's shops buy and sell'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg003A_ThatWeirdApeThingIsWarubou", ROMX

; Great Log talk 16 (GreatLogTalkEvents): with EVENT_THANKS_FOR_COMING_BY_025 set it sets
; wScreenTableIndex = 2 and wDataBank = $10 and starts Script_HelloHowMayI ('Hello! How may I serve
; ...') once EVENT_THAT_WEIRD_APE_THING_IS_12C is set, otherwise Script_I_12 (which sets that flag
; first); else with EVENT_SCENE_THREE_ITEMS set message $0506; else with
; EVENT_SCENE_MERMAID_KINGDOM_022 set $08C1 the first time, setting EVENT_THAT_WEIRD_APE_THING_IS,
; then $08C2 ('I have nothing for a ...'); else with EVENT_SCENE_WARUBOU_FOOD2_00C set, the first
; time it sets bit 0 of wStoryFlags + $60 directly (flag $300, which SetFlagBit cannot set), says
; $0077 and sets EVENT_HERO_RECEIVED_THE_GREAT_LOG, then $0078; otherwise $003A ('That weird ape
; thing is ...'). Messages start through StartMessageCommand09HL_B13 (script command 9 with the word
; in wScriptParam0/1, wScriptRunning = 1, wModeState = 1) and scripts through StartScriptAtHL_B13
; (wScriptPointerLo/Hi, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg003A_ThatWeirdApeThingIsWarubou.set_screen_table_index_to_02; flag 0024 then jr c,
; TalkMsg003A_ThatWeirdApeThingIsWarubou.call_start_message_command09_hl_b133; flag 0022 then jr c,
; TalkMsg003A_ThatWeirdApeThingIsWarubou.call_test_flag_bit2; flag 000C then jr c,
; TalkMsg003A_ThatWeirdApeThingIsWarubou.call_test_flag_bit); starts message $003A through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'That weird ape thing is
; Warubou, GreatLog's' (E-0268, the E-0082 shape; was TalkMsg003A_ThatWeirdApeThingIsWarubou)
TalkMsg003A_ThatWeirdApeThingIsWarubou::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_screen_table_index_to_02
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $003a ; '*: That weird ape thing is'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_HERO_RECEIVED_THE_GREAT_LOG
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld hl, $0077 ; '*: The island's sinking? That's hard'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HERO_RECEIVED_THE_GREAT_LOG
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0078 ; '*: It's pointless if you're dead.'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_THAT_WEIRD_APE_THING_IS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld hl, $08c1 ; '*: Hey! You're the kid who'
    call StartMessageCommand09HL_B13
    ld de, EVENT_THAT_WEIRD_APE_THING_IS
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $08c2 ; '*: I have nothing for a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0506 ; '*: Hey! You're the kid who'
    call StartMessageCommand09HL_B13
    ret

.set_screen_table_index_to_02:
    ld a, $02
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, EVENT_THAT_WEIRD_APE_THING_IS_12C
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_I_12 ; script '*: I'm sorry. I was wrong'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HelloHowMayI ; script '*: Hello! How may I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0035_TheKingIsTooLenientOn", ROMX

; Great Log talk 17 (GreatLogTalkEvents): with EVENT_THANKS_FOR_COMING_BY_025 set it sets
; wScreenTableIndex = 0 and wDataBank = $10 and starts Script_WellWellIfIt the first time (setting
; EVENT_THE_KING_IS_TOO_LENIENT), then Script_WelcomeHowMayI ('Welcome! How may I serve ...'); else
; with EVENT_SCENE_RIVAL_DEFEATED_021 set: Script_WelcomeHowMayI (same bank setup) once
; EVENT_THE_KING_IS_TOO_LENIENT_106 is set, Script_You_5 (setting EVENT_THE_KING_IS_TOO_LENIENT_106)
; when EVENT_YOUVE_BEEN_GOING_OUT_A is set, otherwise message $0115 ('I am a dealer- a ...'); else
; with EVENT_SCENE_LONG_FACES_002 set $0115; else with EVENT_SCENE_WARUBOU_FOOD2_00C set $0075;
; otherwise $0035 ('The King is too lenient ...'). Messages start through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1) and scripts through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c, TalkMsg0035_TheKingIsTooLenientOn.call_test_flag_bit2;
; flag 0021 then jr c, TalkMsg0035_TheKingIsTooLenientOn.call_test_flag_bit; flag 0002 then jr c,
; TalkMsg0035_TheKingIsTooLenientOn.loop; flag 000C then jr c,
; TalkMsg0035_TheKingIsTooLenientOn.call_start_message_command09_hl_b13); starts message $0035
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'The King is too
; lenient on Prince' (E-0268, the E-0082 shape; was TalkMsg0035_TheKingIsTooLenientOn)
TalkMsg0035_TheKingIsTooLenientOn::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .loop
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0035 ; '*: The King is too lenient'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0075 ; '*: The island's going to sink?'
    call StartMessageCommand09HL_B13
    ret

.loop:
    ld hl, $0115 ; '*: I am a dealer- a'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_THE_KING_IS_TOO_LENIENT_106
    call TestFlagBit
    jr c, .loop2
    ld de, EVENT_YOUVE_BEEN_GOING_OUT_A
    call TestFlagBit
    jr nc, .loop
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_You_5 ; script '*: You're too young to be'
    call StartScriptAtHL_B13
    ld de, EVENT_THE_KING_IS_TOO_LENIENT_106
    call SetFlagBit
    ret

.loop2:
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeHowMayI ; script '*: Welcome! How may I serve'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_THE_KING_IS_TOO_LENIENT
    call TestFlagBit
    jr c, .loop2
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WellWellIfIt ; script '*: Well, well! If it isn't'
    call StartScriptAtHL_B13
    ld de, EVENT_THE_KING_IS_TOO_LENIENT
    call SetFlagBit
    ret

SECTION "Bank 13 TalkMsg003B_ThisPalmTreeIsGreatLogWe", ROMX

; Great Log talk 18 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B0F ('Have you found another world ...'); else with
; EVENT_SCENE_DARCK_DEFEATED set, message $0540 ('Oh, wow! ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set, message $0D0E ('... really trying to become ...'); else with
; EVENT_SCENE_LONG_FACES_002 set, message $0116 ('You have such cute monsters! ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $006D ('... going to sink? ...'); otherwise, message
; $003B ('This palm tree is GreatLog. ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg003B_ThisPalmTreeIsGreatLogWe.call_start_message_command09_hl_b135; flag 00D1 then jr c,
; TalkMsg003B_ThisPalmTreeIsGreatLogWe.call_start_message_command09_hl_b134; flag 0021 then jr c,
; TalkMsg003B_ThisPalmTreeIsGreatLogWe.call_start_message_command09_hl_b133; flag 0002 then jr c,
; TalkMsg003B_ThisPalmTreeIsGreatLogWe.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg003B_ThisPalmTreeIsGreatLogWe.call_start_message_command09_hl_b13); starts message $003B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'This palm tree is
; GreatLog. We've' (E-0268, the E-0082 shape; was TalkMsg003B_ThisPalmTreeIsGreatLogWe)
TalkMsg003B_ThisPalmTreeIsGreatLogWe::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $003b ; '*: This palm tree is GreatLog.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $006d ; '*: The island's going to sink?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0116 ; '*: You have such cute monsters!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0d0e ; '*: You're really trying to become'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0540 ; '*: Oh, wow! You're really famous!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0b0f ; '*: Have you found another world'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0038_HeroPeeredIntoTheVaseA", ROMX

; Great Log talk 19 (GreatLogTalkEvents): starts message $0038 ('<BUF0> peered into the vase. A
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0038 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. A large,' (E-0268, the E-0082 shape; was
; TalkMsg0038_HeroPeeredIntoTheVaseA)
TalkMsg0038_HeroPeeredIntoTheVaseA::
    ld hl, $0038 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0041_WarubouIsTheIslandsSpirit", ROMX

; Great Log talk 20 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_SCENE_LONG_FACES_002 set, message $0119 ('Monster masters are people who ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $0070 ('The island ...'); otherwise, message $0041
; ('Warubou is the ...'). A message starts through StartMessageCommand09HL_B13 (script command 9
; with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0002 then jr c,
; TalkMsg0041_WarubouIsTheIslandsSpirit.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg0041_WarubouIsTheIslandsSpirit.call_start_message_command09_hl_b13); starts message $0041
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Warubou is the
; island's spirit. So we' (E-0268, the E-0082 shape; was TalkMsg0041_WarubouIsTheIslandsSpirit)
TalkMsg0041_WarubouIsTheIslandsSpirit::
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0041 ; '*: Warubou is the island's spirit.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0070 ; '*: The island isn't sinking. If'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0119 ; '*: Monster masters are people who'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg003D_WeLiveInsideHereImKeeping", ROMX

; Great Log talk 21 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B1A ('I heard that ...'); else with
; EVENT_SCENE_DARCK_DEFEATED set, message $0542 ('... sorry for doubting you. ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0508 ('Hi! Have you heard? GreatLog ...'); else with
; EVENT_SCENE_MERMAID_KINGDOM_022 set, message $08C3 ('To take off an accessory ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set, message $0210 ('Oh, my... Where did the ...'); else with
; EVENT_SCENE_LONG_FACES_002 set, message $0117 ('... seen Prince Kameha ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $006E ('The island is sinking? Prince ...'); otherwise,
; message $003D ('We live inside here. ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b137; flag 00D1 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b136; flag 0024 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b135; flag 0022 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b134; flag 0021 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b133; flag 0002 then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg003D_WeLiveInsideHereImKeeping.call_start_message_command09_hl_b13); starts message $003D
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'We live inside here.
; I'm keeping my' (E-0268, the E-0082 shape; was TalkMsg003D_WeLiveInsideHereImKeeping)
TalkMsg003D_WeLiveInsideHereImKeeping::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b137
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $003d ; '*: We live inside here. I'm'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $006e ; '*: The island is sinking? Prince'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0117 ; '*: I haven't seen Prince Kameha'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0210 ; '*: Oh, my… Where did the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $08c3 ; '*: To take off an accessory,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0508 ; '*: Hi! Have you heard? GreatLog'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0542 ; '*: I'm sorry for doubting you.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b137:
    ld hl, $0b1a ; '*: I heard that you're the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg003F_InsideTheWellIsTheLogs", ROMX

; Great Log talk 22 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B1B ('The woman next to me ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0509 ('My neighbor is buying all ...'); else with
; EVENT_SCENE_MERMAID_KINGDOM_022 set, message $08C4 ('The woman next to me ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set, message $0211 ('I hear rumors that Prince ...'); else with
; EVENT_SCENE_LONG_FACES_002 set, message $0118 ('Warubou has gone down the ...'); else with
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $006F ('Oh, you kids! You ...'); else with
; EVENT_SCENE_WARUBOU_SMELLS set, message $0052 ('Oh my, the well ...'); otherwise, message $003F
; ('Inside the well is the ...'). A message starts through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b137; flag 0024 then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b136; flag 0022 then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b135; flag 0021 then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b134; flag 0002 then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b133; flag 000C then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b132; flag 000A then jr c,
; TalkMsg003F_InsideTheWellIsTheLogs.call_start_message_command09_hl_b13); starts message $003F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Inside the well is
; the Log's Navel.' (E-0268, the E-0082 shape; was TalkMsg003F_InsideTheWellIsTheLogs)
TalkMsg003F_InsideTheWellIsTheLogs::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b137
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $003f ; '*: Inside the well is the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0052 ; '*: Oh my, the well isn't'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $006f ; '*: Oh, you kids! You shouldn't'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0118 ; '*: Warubou has gone down the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0211 ; '*: I hear rumors that Prince'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $08c4 ; '*: The woman next to me,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0509 ; '*: My neighbor is buying all'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b137:
    ld hl, $0b1b ; '*: The woman next to me'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowImWarubouGreatLogsSpirit", ROMX

; Great Log talk, Warubou at the plug: 'I'm Warubou, GreatLog's spirit!' ($004A) the first time;
; after meeting Kameha, on screen X 2 the script 'Wha...? I smell something!' with the scene object
; (field command 1) at ($20, $50) and EVENT_SCENE_WARUBOU_SMELLS, elsewhere 'It's a dead end,
; warooh!' ($004B); before it, on screen X 2 'Give me something!' ($004F). (C1, E-0357)
GreatLogTalkEvents_ShowImWarubouGreatLogsSpirit::
    ld de, EVENT_IM_WARUBOU_GREAT_LOGS_SPIRIT
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $004a ; '*: I'm Warubou, GreatLog's spirit! Warooh,'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IM_WARUBOU_GREAT_LOGS_SPIRIT
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, EVENT_IM_PRINCE_KAMEHA_OF
    call TestFlagBit
    jr c, .check_map_screen_x
    ldh a, [hMapScreenX]
    cp $02
    jr z, .call_start_message_command09_hl_b13

.loop:
    ld hl, $004b ; 'Warubou: It's a dead end, warooh!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $004f ; 'Warubou: Wa-hey! Give me something! Then,'
    call StartMessageCommand09HL_B13
    ret

.check_map_screen_x:
    ldh a, [hMapScreenX]
    cp $02
    jr nz, .loop
    ld hl, Script_WarubouWhaISmell ; script 'Warubou: Wha…? I smell something! I'
    call StartScriptAtHL_B13
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call SetFlagBit
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowImPrinceKamehaOf", ROMX

; Great Log talk, Kameha: 'I'm Prince Kameha of GreatLog!' ($0048) the first time, then 'Wahahah! No
; going by me!' ($0049). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowImPrinceKamehaOf::
    ld de, EVENT_IM_PRINCE_KAMEHA_OF
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0048 ; '*: I'm Prince Kameha of GreatLog!'
    call StartMessageCommand09HL_B13
    ld de, EVENT_IM_PRINCE_KAMEHA_OF
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0049 ; 'Kameha: Wahahah! No going by me!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_WarubouInCastle", ROMX

; Great Log talk, Warubou in the castle: by story progress: the plug and package lines, 'You
; remember the promise ...', 'I trust you! Go!' ($0082); after each key world 'find another Magic
; Key' and 'Too slow! Kameha ...' in turn; after the three items 'Are you ready?' (two scripts by
; inventory slot $15) or $0532 before EVENT_SCENE_LIMBO; at the end the Limbo monster scenes by the
; total of species seen (TotalSpeciesFlaggedOrListed: 250-289 the first, 290 or more the second,
; fewer 'How are you? Still ...' $0B26), or Petibou's $0BA8. Seven unreached bytes after one branch
; decode as ld hl, $537B / call $4049 / ret. (C1, E-0357)
GreatLogTalkEvents_WarubouInCastle::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_test_flag_bit5
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_test_flag_bit4
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .call_test_flag_bit3
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jp c, .call_test_flag_bit2
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .loop
    ld de, EVENT_SCENE_OASIS_KEY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_DID_YOU_GET_THE_PACKAGE
    call TestFlagBit
    jr nc, .call_start_message_command09_hl_b13
    ld de, EVENT_YOURE_THE_KIDS_FROM_THE
    call TestFlagBit
    jr nc, .call_start_message_command09_hl_b13
    ld de, EVENT_HERO_RECEIVED_THE_GREAT_LOG
    call TestFlagBit
    jr c, .set_temp0_to_02

.call_start_message_command09_hl_b13:
    ld hl, $005f ; 'Warubou: A new plug for the'
    call StartMessageCommand09HL_B13
    ret

.set_temp0_to_02:
    ld a, $02
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, EVENT_WARUBOU_NO_THEN_FIND_SOMEONE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_WarubouWaHeyGood ; script 'Warubou: Wa-hey! Good, you're back. You'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WarubouWaHeyNo ; script 'Warubou: Wa-hey? No one believed! You'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0082 ; 'Warubou: Wa-hey! I trust you! Go!'
    call StartMessageCommand09HL_B13
    ret

.loop:
    ld hl, Script_WarubouWaHeyYou ; script 'Warubou: Wa-hey! You remember the promise'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_WARUBOU_WA_HEY_HERO_YOURE
    call TestFlagBit
    jr c, .loop
    ld de, EVENT_WARUBOU_WA_HEY_THIS_TIME
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld hl, $029e ; 'Warubou: Wa-hey! This time, you'll have'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $02a4 ; 'Warubou: Wa-hey, 0 you're slow! Kameha'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WARUBOU_WA_HEY_HERO_YOURE
    call SetFlagBit
    ret
    db $21, $7b, $53, $cd, $49, $40, $c9

.call_test_flag_bit2:
    ld de, EVENT_WARUBOU_WA_HEY_HERO_TOO
    call TestFlagBit
    jr c, .loop
    ld de, EVENT_WARUBOU_WA_HEY_FIND_ANOTHER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld hl, $0d1a ; 'Warubou: Wa-hey, find another Magic Key'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0d1b ; 'Warubou: Wa-hey, 0! Too slow! Kameha'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WARUBOU_WA_HEY_HERO_TOO
    call SetFlagBit
    ret

.call_test_flag_bit3:
    ld de, EVENT_WARUBOU_WA_HEY_HERO_YOU
    call TestFlagBit
    jr c, .loop
    ld de, EVENT_WHAT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    ld hl, $0d2a ; 'Warubou: Wa-hey, find another Magic Key'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0d2b ; 'Warubou: Wa-hey, 0! You have the'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WARUBOU_WA_HEY_HERO_YOU
    call SetFlagBit
    ret

.call_test_flag_bit4:
    ld de, EVENT_SCENE_LIMBO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    ld a, [wInventory + $15]
    or a
    jr z, .call_start_script_at_hl_b132
    cp $ff
    jr z, .call_start_script_at_hl_b132
    ld hl, Script_WarubouWaHeyAre ; script 'Warubou: Wa-hey! Are you ready? Ready'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_WarubouWaHeyAre_2 ; script 'Warubou: Wa-hey! Are you ready? Ready'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0532 ; 'Warubou: Wa-hey, you have to find'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit5:
    ld de, EVENT_SCENE_LIMBO_MONSTER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b138
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b139
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr z, .check_temp0
    cp $01
    jr nz, .call_start_script_at_hl_b133
    ldh a, [hTemp0]
    cp $22
    jr c, .call_start_script_at_hl_b134

.call_start_script_at_hl_b133:
    ld hl, Script_SceneLimboMonster2
    call StartScriptAtHL_B13
    ret

.check_temp0:
    ldh a, [hTemp0]
    cp $fa
    jr c, .call_start_message_command09_hl_b137

.call_start_script_at_hl_b134:
    ld hl, Script_SceneLimboMonster
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b137:
    ld hl, $0b26 ; 'Warubou: Wa-hey! How are you? Still'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b138:
    ld hl, $0b2d ; 'Warubou: Wa-hey, the bond between human'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b139:
    ld hl, $0ba8 ; 'Petibou: It's sort of boring guarding'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg001A_IAccidentallyWentOutside", ROMX

; Great Log talk 26 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B04 ('I heard about a world ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set and EVENT_OH_YOU_BOUGHT_THE_LOVE set and
; EVENT_SCENE_MERMAID_KINGDOM_022 set, message $08AE ('My father was a Slime ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 set and EVENT_OH_YOU_BOUGHT_THE_LOVE set, message $0215 ('Aooh,
; LoveWater soothes sunburn... ...'); else with EVENT_SCENE_RIVAL_DEFEATED_021 set and
; EVENT_OH_YOU_BOUGHT_THE_LOVE clear, message $0203 ('I was taking a nap ...'); else with
; EVENT_SCENE_RIVAL_DEFEATED_021 clear and EVENT_SCENE_LONG_FACES_002 set, message $010B ('A
; tropical isle is too ...'); else with EVENT_SCENE_RIVAL_DEFEATED_021 clear and
; EVENT_SCENE_WARUBOU_FOOD2_00C set, message $0067 ('... going to sink? I ...'); otherwise, message
; $001A ('I accidentally went outside. People ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg001A_IAccidentallyWentOutside.call_start_message_command09_hl_b134; flag 0021 then jr c,
; TalkMsg001A_IAccidentallyWentOutside.call_test_flag_bit; flag 0002 then jr c,
; TalkMsg001A_IAccidentallyWentOutside.call_start_message_command09_hl_b132; flag 000C then jr c,
; TalkMsg001A_IAccidentallyWentOutside.call_start_message_command09_hl_b13); starts message $001A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I accidentally went
; outside. People gave me' (E-0268, the E-0082 shape; was TalkMsg001A_IAccidentallyWentOutside)
TalkMsg001A_IAccidentallyWentOutside::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $001a ; '*: I accidentally went outside. People'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0067 ; '*: We're going to sink? I'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $010b ; '*: A tropical isle is too'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_OH_YOU_BOUGHT_THE_LOVE
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld hl, $0203 ; '*: I was taking a nap'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld hl, $0215 ; '*: Aooh, LoveWater soothes sunburn…'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $08ae ; '*: My father was a Slime'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0b04 ; '*: I heard about a world'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowCobiHeroWhileYoure", ROMX

; Great Log talk, Cobi (the scripts in bank $1F): a line for each story phase ('while you're gone,
; I'll ...', 'Hi, I'm helping Papa ...', 'what was it like ...' after each key world, 'tell me about
; what ...', 'I envied you ...'), each phase's first talk setting its flag, then 'Hi, <hero>! What's
; up today?'. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowCobiHeroWhileYoure::
    ld a, $1f
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_test_flag_bit6
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_test_flag_bit5
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .call_test_flag_bit4
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_COBI_HERO_WHILE_YOURE
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0103 ; 'Cobi: 0, while you're gone, I'll'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_COBI_HI_I
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHiI ; script 'Cobi: Hi, I'm helping Papa to'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, Script_CobiHiHeroWhat ; script 'Cobi: Hi, 0! What's up today?'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_COBI_HERO_WHAT_WAS
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHeroWhatWas ; script 'Cobi: 0, what was it like'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit3:
    ld de, EVENT_COBI_HERO_WHAT_WAS_109
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHeroWhatWas_2 ; script 'Cobi: 0, what was it like'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit4:
    ld de, EVENT_COBI_HERO_WHAT_WAS_115
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHeroWhatWas_3 ; script 'Cobi: 0, what was it like'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit5:
    ld de, EVENT_COBI_HERO_TELL_ME
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHeroTellMe ; script 'Cobi: 0, tell me about what'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit6:
    ld de, EVENT_COBI_HERO_IENVIED
    call TestFlagBit
    jr c, .loop
    ld hl, Script_CobiHeroIEnvied ; script 'Cobi: 0, I envied you for'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowTaraBigBrotherWhile", ROMX

; Great Log talk, Tara (scripts in bank $1F): the same phases as Cobi's talk with Tara's lines ('Big
; brother, while you're in ...', 'Big brother, tell me about ...', 'I was a little ...'), then 'Hi!
; How are you?'. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowTaraBigBrotherWhile::
    ld a, $1f
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_test_flag_bit6
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_test_flag_bit5
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .call_test_flag_bit4
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_COBI_HERO_WHILE_YOURE
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0104 ; 'Tara: Big brother, while you're in'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_COBI_HI_I
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraI ; script 'Tara: I'm helping Papa take care'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, Script_TaraHiHowAre ; script 'Tara: Hi! How are you? Do'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_COBI_HERO_WHAT_WAS
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraBigBrotherHave ; script 'Tara: Big brother, have you found'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit3:
    ld de, EVENT_COBI_HERO_WHAT_WAS_109
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraBigBrotherTell ; script 'Tara: Big brother, tell me about'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit4:
    ld de, EVENT_COBI_HERO_WHAT_WAS_115
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraBigBrotherTell_2 ; script 'Tara: Big brother, tell me about'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit5:
    ld de, EVENT_COBI_HERO_TELL_ME
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraBigBrotherTell_3 ; script 'Tara: Big brother, tell me about'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit6:
    ld de, EVENT_COBI_HERO_IENVIED
    call TestFlagBit
    jr c, .loop
    ld hl, Script_TaraHeroIWas ; script 'Tara: 0, I was a little'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg011E_IfYourPartyIsWipedOut", ROMX

; Great Log talk 29 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B1D ('If you have a lot ...'); otherwise, message
; $011E ('If your party is wiped ...'). A message starts through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg011E_IfYourPartyIsWipedOut.call_start_message_command09_hl_b13); starts message $011E
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'If your party is
; wiped out, half' (E-0268, the E-0082 shape; was TalkMsg011E_IfYourPartyIsWipedOut)
TalkMsg011E_IfYourPartyIsWipedOut::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $011e ; '*: If your party is wiped'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b1d ; '*: If you have a lot'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg021F_DoYouKnowAboutLogTwigIts", ROMX

; Great Log talk 30 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B14 ('You know how to commune ...'); else with
; EVENT_SCENE_SHIELD2_023 set, message $0DE5 ('The water flowed right over ...'); otherwise, message
; $021F ('Do you know about LogTwig? ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg021F_DoYouKnowAboutLogTwigIts.call_start_message_command09_hl_b132; flag 0023 then jp c,
; TalkMsg021F_DoYouKnowAboutLogTwigIts.call_start_message_command09_hl_b13); starts message $021F
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Do you know about
; LogTwig? It's an' (E-0268, the E-0082 shape; was TalkMsg021F_DoYouKnowAboutLogTwigIts)
TalkMsg021F_DoYouKnowAboutLogTwigIts::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $021f ; '*: Do you know about LogTwig?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0de5 ; '*: The water flowed right over'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b14 ; '*: You know how to commune'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04D0_HeroReadTheSignMonsterArena", ROMX

; Great Log talk 31 (GreatLogTalkEvents): starts message $04D0 ('<BUF0> read the sign.' 'Monster
; Arena ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word
; in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04D0 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 read the sign. Monster Arena, where' (E-0268, the E-0082 shape; was
; TalkMsg04D0_HeroReadTheSignMonsterArena)
TalkMsg04D0_HeroReadTheSignMonsterArena::
    ld hl, $04d0 ; '0 read the sign. 'Monster Arena,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Guide", ROMX

; Great Log talk 32 (GreatLogTalkEvents), a guide: after the three items (EVENT_SCENE_THREE_ITEMS)
; Script_IfTheIslandSink ('If the island sink, is ...', which sets EVENT_WHAT first) until
; EVENT_WHAT is set, then $0A3D ('Prince Kameha wandered off like ...'); else after
; EVENT_SCENE_SHIELD2_023 Script_PrinceKamehaHasBeen ('Prince Kameha has been missing ...'; only its
; Script_What branch sets EVENT_WHAT, so it repeats until that branch is taken), then $0A3D; else
; $021B ('This leads to GreatLog Castle! ...') after EVENT_SCENE_RIVAL_DEFEATED_021, $003E (about
; the major facilities of GreatLog) after EVENT_SCENE_LONG_FACES_002, $0071 ('Looking for a monster
; master? ...') after EVENT_SCENE_WARUBOU_FOOD2_00C, otherwise $003E. Messages start through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1) and scripts through StartScriptAtHL_B13 (wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
GreatLogTalkEvents_Guide::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $003e ; '*: GreatLog's major facilities are situated'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0071 ; '*: Looking for a monster master?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $021b ; '*: This leads to GreatLog Castle!'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_WHAT
    call TestFlagBit
    jr c, .loop
    ld hl, Script_PrinceKamehaHasBeen ; script '*: Prince Kameha has been missing'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, $0a3d ; '*: Prince Kameha wandered off like'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_WHAT
    call TestFlagBit
    jr c, .loop
    ld hl, Script_IfTheIslandSink ; script '*: If the island sink, is'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Slide", ROMX

; Great Log talk: the slide: 'Take this slide as a ...' the first time, then 'It's easy to get down,
; ...' ($021E); at the end 'The rope in the farm ...' ($0B10). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Slide::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_TAKE_THIS_SLIDE_AS_A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_TakeThisSlideAs ; script '*: Take this slide as a'
    call StartScriptAtHL_B13
    ld de, EVENT_TAKE_THIS_SLIDE_AS_A
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $021e ; '*: It's easy to get down,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b10 ; '*: The rope in the farm'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg021C_MonstersHateBeingAwayFrom", ROMX

; Great Log talk 34 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B0E ('... beginning to feel that ...'); otherwise,
; message $021C ('Monsters hate being away from ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg021C_MonstersHateBeingAwayFrom.call_start_message_command09_hl_b13); starts message $021C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Monsters hate being
; away from their master.' (E-0268, the E-0082 shape; was TalkMsg021C_MonstersHateBeingAwayFrom)
TalkMsg021C_MonstersHateBeingAwayFrom::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $021c ; '*: Monsters hate being away from'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b0e ; '*: I'm beginning to feel that'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0221_HelloThereYoungsterTakeThese", ROMX

; Great Log talk 35 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B2F ('... great hero! How ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0521 ('The Arena is closed under ...'); otherwise, message
; $0221 ('Hello there, youngster! Take these ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0221_HelloThereYoungsterTakeThese.call_start_message_command09_hl_b132; flag 0024 then jr
; c, TalkMsg0221_HelloThereYoungsterTakeThese.call_start_message_command09_hl_b13); starts message
; $0221 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Hello there,
; youngster! Take these stairs to' (E-0268, the E-0082 shape; was
; TalkMsg0221_HelloThereYoungsterTakeThese)
TalkMsg0221_HelloThereYoungsterTakeThese::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0221 ; '*: Hello there, youngster! Take these'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0521 ; '*: The Arena is closed under'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b2f ; '*: Ah, GreatLog's great hero! How'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0222_HeyALittleBittyMasterHi", ROMX

; Great Log talk 36 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B30 ('Well, well ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0522 ('... been decided to shut ...'); otherwise, message
; $0222 ('Hey, a little bitty master! ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0222_HeyALittleBittyMasterHi.call_start_message_command09_hl_b132; flag 0024 then jr c,
; TalkMsg0222_HeyALittleBittyMasterHi.call_start_message_command09_hl_b13); starts message $0222
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Hey, a little bitty
; master! Hi! You'll' (E-0268, the E-0082 shape; was TalkMsg0222_HeyALittleBittyMasterHi)
TalkMsg0222_HeyALittleBittyMasterHi::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0222 ; '*: Hey, a little bitty master!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0522 ; '*: It's been decided to shut'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b30 ; '*: Well, well, it's GreatLog's savior!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Grandparent", ROMX

; Great Log talk, a grandparent: 'I like my grandchildren to ...' ($0543) after Darck's defeat until
; the end, otherwise 'Well, you're a mighty lively ...' ($0223). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Grandparent::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0223 ; '*: Well, you're a mighty lively'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0543 ; '*: I like my grandchildren to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0224_TakeCareToFindTinyMedals", ROMX

; Great Log talk 38 (GreatLogTalkEvents): starts message $0224 ('Take care to find Tiny ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0224 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Take care to find Tiny Medals. Look' (E-0268, the E-0082 shape; was
; TalkMsg0224_TakeCareToFindTinyMedals)
TalkMsg0224_TakeCareToFindTinyMedals::
    ld hl, $0224 ; '*: Take care to find Tiny'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Master", ROMX

; Great Log talk, a master: 'I became a master because ...' at the end; after the three items $0D32
; or $0528; after the master's thanks $0267; otherwise 'Oh... You're so lucky to ...', as a script
; when a species-2 monster is in a party of two or more. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Master::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_MASTER_THANKS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, [wPartyCount]
    dec a
    jr z, .call_start_message_command09_hl_b13
    ld hl, $0002
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b13

.call_start_message_command09_hl_b13:
    ld hl, $0263 ; '*: Oh… You're so lucky to'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_OhYou_5 ; script '*: Oh… You're so lucky to'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0267 ; '*: What should I do with'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_MASTER_THANKS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld hl, $0d32 ; '*: Do we have to leave'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0528 ; '*: I don't want to leave'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_IBecameAMaster ; script '*: I became a master because'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0D8C_WataWataTerryBattledInThe", ROMX

; Great Log talk 40 (GreatLogTalkEvents): starts message $0D8C ('Wata, wata. Terry battled in ...').
; A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0D8C through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Wata, wata. Terry battled in the Starry' (E-0268, the E-0082 shape; was
; TalkMsg0D8C_WataWataTerryBattledInThe)
TalkMsg0D8C_WataWataTerryBattledInThe::
    ld hl, $0d8c ; '*: Wata, wata. Terry battled in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0D8D_FwahahahahaHowAmusingEven", ROMX

; Great Log talk 41 (GreatLogTalkEvents): starts message $0D8D ('Fwahahahaha! How amusing! Even I
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0D8D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Fwahahahaha! How amusing! Even I fell before' (E-0268, the E-0082 shape; was
; TalkMsg0D8D_FwahahahahaHowAmusingEven)
TalkMsg0D8D_FwahahahahaHowAmusingEven::
    ld hl, $0d8d ; '*: Fwahahahaha! How amusing! Even I'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg022D_WarpWingReturnsYouInstantly", ROMX

; Great Log talk 42 (GreatLogTalkEvents): starts message $022D ('WarpWing returns you instantly to
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $022D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'WarpWing returns you instantly to GreatLog, so' (E-0268, the E-0082 shape; was
; TalkMsg022D_WarpWingReturnsYouInstantly)
; starts Script_DoYouHaveAny: '*: Do you have any idea' (E-0248)
TalkMsg022D_WarpWingReturnsYouInstantly::
    ld hl, $022d ; '*: WarpWing returns you instantly to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_DoYouHaveAnyIdeaAbout", ROMX

; Great Log talk 43 (GreatLogTalkEvents): starts Script_DoYouHaveAny (first message 'Do you have any
; idea ...'). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_DoYouHaveAny (StartScriptAtHL_B13); its first message begins 'Do you have any idea
; about' (E-0271; was Talk_DoYouHaveAnyIdeaAbout) (E-0344: the address in its name dropped or read
; as the label there; was Talk_DoYouHaveAnyIdeaAbout; shortened from
; TalkScript_DoYouHaveAnyIdeaAbout)
; starts Script_DoYouHaveAny: '*: Do you have any idea' (E-0248)
Talk_DoYouHaveAnyIdeaAbout::
    ld hl, Script_DoYouHaveAny ; script '*: Do you have any idea'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg022C_ThereAreBooksThatChangeYour", ROMX

; Great Log talk 44 (GreatLogTalkEvents): starts message $022C ('There are books that change ...').
; A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $022C through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There are books that change your personality' (E-0268, the E-0082 shape; was
; TalkMsg022C_ThereAreBooksThatChangeYour)
TalkMsg022C_ThereAreBooksThatChangeYour::
    ld hl, $022c ; '*: There are books that change'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0005_YouFolksRunAMonsterFarm", ROMX

; Great Log talk 45 (GreatLogTalkEvents): starts message $0005 ('You folks run a monster ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0005 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'You folks run a monster farm? We' (E-0268, the E-0082 shape; was
; TalkMsg0005_YouFolksRunAMonsterFarm)
TalkMsg0005_YouFolksRunAMonsterFarm::
    ld hl, $0005 ; '*: You folks run a monster'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0006_TheresASpiritInGreatLogThats", ROMX

; Great Log talk 46 (GreatLogTalkEvents): starts message $0006 ('... a spirit in GreatLog ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0006 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There's a spirit in GreatLog that's famous' (E-0268, the E-0082 shape; was
; TalkMsg0006_TheresASpiritInGreatLogThats)
TalkMsg0006_TheresASpiritInGreatLogThats::
    ld hl, $0006 ; '*: There's a spirit in GreatLog'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_OnTheShip", ROMX

; Great Log talk on the ship: message $0004 before EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED; after it
; Tara's 'Big brother! GreatLog will be ...'; Cobi's script sits behind a constant test (ld a, 1 /
; or a) for the other edition. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_OnTheShip::
    ld de, EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED
    call TestFlagBit
    jr c, .skip
    ld l, $04
    ld h, $00
    call StartMessageCommand09HL_B13
    ret

.skip:
    ld a, $01
    or a
    jr z, .call_start_script_at_hl_b13
    ld hl, Script_TaraBigBrotherGreatLog ; script 'Tara: Big brother! GreatLog will be'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_CobiHeroTheySaid ; script 'Cobi: 0! They said GreatLog will'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_SailingIsSureExhilarating", ROMX

; Great Log talk 48 (GreatLogTalkEvents): starts Script_SailingIsSureExhilarating (first message
; 'Sailing is sure exhilarating. Right? ...'). A script starts through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_SailingIsSureExhilarating (StartScriptAtHL_B13); its first message begins 'Sailing
; is sure exhilarating. Right?' (E-0271; was Talk_SailingIsSureExhilarating) (E-0344: the address in
; its name dropped or read as the label there; was Talk_SailingIsSureExhilarating; shortened from
; TalkScript_SailingIsSureExhilarating)
; starts Script_SailingIsSureExhilarating: '*: Sailing is sure exhilarating. Right?' (E-0248)
Talk_SailingIsSureExhilarating::
    ld hl, Script_SailingIsSureExhilarating ; script '*: Sailing is sure exhilarating. Right?'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg000A_WellSoonBeReachingGreatLog", ROMX

; Great Log talk 49 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED set, message $000E ('Worried about your monsters? ...');
; otherwise, message $000A ('... soon be reaching GreatLog. ...'). A message starts through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1, wScriptRunning =
; 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0013 then jr c,
; TalkMsg000A_WellSoonBeReachingGreatLog.call_start_message_command09_hl_b13); starts message $000A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'We'll soon be
; reaching GreatLog. I wonder,' (E-0268, the E-0082 shape; was
; TalkMsg000A_WellSoonBeReachingGreatLog)
TalkMsg000A_WellSoonBeReachingGreatLog::
    ld de, EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $000a ; '*: We'll soon be reaching GreatLog.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $000e ; '*: Worried about your monsters? Don't'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_EditionChoice", ROMX

; Great Log talk on the ship: message $000B (the constant $02 & 1 + $0B: the edition choice) the
; first time, setting EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED, then 'When our farm gets established
; ...' ($000D). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_EditionChoice::
    ld de, EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $02
    and $01
    add $0b
    ld l, a
    ld h, $00
    call StartMessageCommand09HL_B13
    ld de, EVENT_WHEN_OUR_FARM_GETS_ESTABLISHED
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $000d ; '*: When our farm gets established'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowTheFarmIsFull", ROMX

; Great Log talk, a gift monster: 'The farm is full.' ($0D62) when no SRAM slot is free; otherwise
; message $0D63 + (wTalkEventGroup - $33) and a new monster of kind wTalkEventGroup - $33 + 6 in the
; free slot (CreateMonsterRecordOfKindTemp1). (C2, E-0357; probed E-0384)
GreatLogTalkEvents_ShowTheFarmIsFull::
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .read_talk_event_group
    ld hl, $0d62 ; 'The farm is full.'
    call StartMessageCommand09HL_B13
    ret

.read_talk_event_group:
    ld a, [wTalkEventGroup]
    sub $33
    add $63
    ld l, a
    ld h, $0d
    call StartMessageCommand09HL_B13
    ld a, [wTalkEventGroup]
    sub $33
    add $06
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ret

SECTION "Bank 13 TalkMsg0BAC_YouNeedToStrikeTheRight", ROMX

; Great Log talk 54 (GreatLogTalkEvents): starts message $0BAC ('You need to strike the ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0BAC through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'You need to strike the right balance' (E-0268, the E-0082 shape; was
; TalkMsg0BAC_YouNeedToStrikeTheRight)
TalkMsg0BAC_YouNeedToStrikeTheRight::
    ld hl, $0bac ; '*: You need to strike the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0D84_SomeMonstersMayBeToughBut", ROMX

; Great Log talk 55 (GreatLogTalkEvents): starts message $0D84 ('Some monsters may be tough ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0D84 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Some monsters may be tough, but they' (E-0268, the E-0082 shape; was
; TalkMsg0D84_SomeMonstersMayBeToughBut)
TalkMsg0D84_SomeMonstersMayBeToughBut::
    ld hl, $0d84 ; '*: Some monsters may be tough,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg023F_IWasOnMyWayTo", ROMX

; Great Log talk 56 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0D8B ('You might know this already ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0523 ('... be fooled by those ...'); otherwise, message
; $023F ('I was on my way ...'). A message starts through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg023F_IWasOnMyWayTo.call_start_message_command09_hl_b132; flag 0024 then jr c,
; TalkMsg023F_IWasOnMyWayTo.call_start_message_command09_hl_b13); starts message $023F through
; StartMessageCommand09HL_B13 (script command $09); that string begins 'I was on my way to the'
; (E-0268, the E-0082 shape; was TalkMsg023F_IWasOnMyWayTo)
TalkMsg023F_IWasOnMyWayTo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $023f ; '*: I was on my way'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0523 ; '*: Don't be fooled by those'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0d8b ; '*: You might know this already,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0240_PackProperlyIfYoureGoing", ROMX

; Great Log talk 57 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B31 ('Make sure ...'); else with
; EVENT_SCENE_THREE_ITEMS set, message $0524 ('He can talk tough now ...'); otherwise, message $0240
; ('Pack properly if ...'). A message starts through StartMessageCommand09HL_B13 (script command 9
; with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0240_PackProperlyIfYoureGoing.call_start_message_command09_hl_b132; flag 0024 then jr c,
; TalkMsg0240_PackProperlyIfYoureGoing.call_start_message_command09_hl_b13); starts message $0240
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Pack properly if
; you're going off to' (E-0268, the E-0082 shape; was TalkMsg0240_PackProperlyIfYoureGoing)
TalkMsg0240_PackProperlyIfYoureGoing::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0240 ; '*: Pack properly if you're going'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0524 ; '*: He can talk tough now,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b31 ; '*: Make sure you're fully prepared'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0241_TryTheSlideItsAShortcut", ROMX

; Great Log talk 58 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B32 ('Have you used the rope ...'); otherwise,
; message $0241 ('Try the slide! ...'). A message starts through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0241_TryTheSlideItsAShortcut.call_start_message_command09_hl_b13); starts message $0241
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Try the slide! It's
; a shortcut!' (E-0268, the E-0082 shape; was TalkMsg0241_TryTheSlideItsAShortcut)
TalkMsg0241_TryTheSlideItsAShortcut::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0241 ; '*: Try the slide! It's a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b32 ; '*: Have you used the rope'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0243_HeroCheckedTheBookshelfBookmark", ROMX

; Great Log talk 59 (GreatLogTalkEvents): starts message $0243 ('<BUF0> checked the bookshelf.'
; 'Bookmark... Place ...'). A message starts through StartMessageCommand09HL_B13 (script command 9
; with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0243 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Bookmark Place inside' (E-0268, the E-0082 shape; was
; TalkMsg0243_HeroCheckedTheBookshelfBookmark)
TalkMsg0243_HeroCheckedTheBookshelfBookmark::
    ld hl, $0243 ; '0 checked the bookshelf. 'Bookmark… Place'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0244_HeroCheckedTheBookshelfJournal", ROMX

; Great Log talk 60 (GreatLogTalkEvents): starts message $0244 ('<BUF0> checked the bookshelf.'
; 'Journal... A ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with
; the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0244 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Journal A book' (E-0268, the E-0082 shape; was
; TalkMsg0244_HeroCheckedTheBookshelfJournal)
TalkMsg0244_HeroCheckedTheBookshelfJournal::
    ld hl, $0244 ; '0 checked the bookshelf. 'Journal… A'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0245_HeroPeeredIntoTheVaseIt", ROMX

; Great Log talk 61 (GreatLogTalkEvents): starts message $0245 ('<BUF0> peered into the vase. It
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0245 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0245_HeroPeeredIntoTheVaseIt)
TalkMsg0245_HeroPeeredIntoTheVaseIt::
    ld hl, $0245 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_LetMeAsk", ROMX

; Great Log talk: 'Hey, let me ask you ...' (script), 'If GreatLog were to sink, ...' ($0526) after
; the three items, 'The girl next door? Well, ...' ($0B42) at the end. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_LetMeAsk::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_HeyLetMeAsk ; script '*: Hey, let me ask you'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0526 ; '*: If GreatLog were to sink,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b42 ; '*: The girl next door? Well,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0249_HeroCheckedTheBookshelfDiary", ROMX

; Great Log talk 63 (GreatLogTalkEvents): starts message $0249 ('<BUF0> checked the bookshelf.'
; 'Diary... A ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0249 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Diary A girl' (E-0268, the E-0082 shape; was
; TalkMsg0249_HeroCheckedTheBookshelfDiary)
TalkMsg0249_HeroCheckedTheBookshelfDiary::
    ld hl, $0249 ; '0 checked the bookshelf. 'Diary… A'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0256_HeroCheckedTheDresserItWas", ROMX

; Great Log talk 64 (GreatLogTalkEvents): starts message $0256 ('<BUF0> checked the dresser. It was
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0256 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. It was jammed' (E-0268, the E-0082 shape; was
; TalkMsg0256_HeroCheckedTheDresserItWas)
TalkMsg0256_HeroCheckedTheDresserItWas::
    ld hl, $0256 ; '0 checked the dresser. It was'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg02B0_HeroPeeredIntoTheBarrelIt", ROMX

; Great Log talk 65 (GreatLogTalkEvents): starts message $02B0 ('<BUF0> peered into the barrel. It
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $02B0 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg02B0_HeroPeeredIntoTheBarrelIt)
TalkMsg02B0_HeroPeeredIntoTheBarrelIt::
    ld hl, $02b0 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_DidYouKnow", ROMX

; Great Log talk: 'Did you know that there's ...', 'Everyone's saying GreatLog'll sink!' ($0525)
; after the three items; at the end a gift monster of kind 2 ('The way you saved GreatLog ...',
; $0B43, or $0B44 when the farm is full) once, then 'Our monsters left on a ...' ($0B45). (C2,
; E-0357; probed E-0384)
GreatLogTalkEvents_DidYouKnow::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_DidYouKnowThat ; script '*: Did you know that there's'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0525 ; '*: Everyone's saying GreatLog'll sink!'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_THE_WAY_YOU_SAVED_GREAT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .set_temp1_to_02
    ld hl, $0b44 ; '*: The way you saved GreatLog'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_02:
    ld a, $02
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, $0b43 ; '*: The way you saved GreatLog'
    call StartMessageCommand09HL_B13
    ld de, EVENT_THE_WAY_YOU_SAVED_GREAT
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b45 ; '*: Our monsters left on a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg025A_HeroCheckedTheDresserItWas", ROMX

; Great Log talk 67 (GreatLogTalkEvents): starts message $025A ('<BUF0> checked the dresser. It was
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $025A through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. It was tidily' (E-0268, the E-0082 shape; was
; TalkMsg025A_HeroCheckedTheDresserItWas)
TalkMsg025A_HeroCheckedTheDresserItWas::
    ld hl, $025a ; '0 checked the dresser. It was'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg025B_HeroCheckedTheBookshelfThis", ROMX

; Great Log talk 68 (GreatLogTalkEvents): starts message $025B ('<BUF0> checked the bookshelf.'
; 'This is ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $025B through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. This is the' (E-0268, the E-0082 shape; was
; TalkMsg025B_HeroCheckedTheBookshelfThis)
TalkMsg025B_HeroCheckedTheBookshelfThis::
    ld hl, $025b ; '0 checked the bookshelf. 'This is'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 IfFlag134Msg0314_HeroTriedToOpenTheChest", ROMX

; Great Log talk 69 (GreatLogTalkEvents): returns at once, starting nothing, unless
; EVENT_REWARD_ITEM_OR_KEY_2 is set; then starts message $0314 ('<BUF0> tried to open the chest.
; ...') through StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0134 then ret nc); starts message $0314 through
; StartMessageCommand09HL_B13 (script command $09); that string begins '0 tried to open the chest.
; But' (E-0268, the E-0082 shape; was IfFlag134Msg0314_HeroTriedToOpenTheChest)
IfFlag134Msg0314_HeroTriedToOpenTheChest::
    ld de, EVENT_REWARD_ITEM_OR_KEY_2
    call TestFlagBit
    ret nc
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Christener", ROMX

; Great Log talk, the Christener (scripts in bank $96): 'Welcome. I'm the Christener. I ...' the
; first time, then '... Do ...'. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Christener::
    ld a, $96
    ld [wDataBank], a
    ld de, EVENT_WELCOME_IM_THE_CHRISTENER_I
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_WelcomeI ; script '*: Welcome. I'm the Christener. I'
    call StartScriptAtHL_B13
    ld de, EVENT_WELCOME_IM_THE_CHRISTENER_I
    call SetFlagBit
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WelcomeI_2 ; script '*: Welcome. I'm the Christener. Do'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg04C5_HeroCheckedTheBookshelfHandbook", ROMX

; Great Log talk 71 (GreatLogTalkEvents): starts message $04C5 ('<BUF0> checked the bookshelf.'
; 'Handbook on ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with
; the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04C5 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Handbook on Naming' (E-0268, the E-0082 shape; was
; TalkMsg04C5_HeroCheckedTheBookshelfHandbook)
TalkMsg04C5_HeroCheckedTheBookshelfHandbook::
    ld hl, $04c5 ; '0 checked the bookshelf. 'Handbook on'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04C6_HeroCheckedTheBookshelfHandbook", ROMX

; Great Log talk 72 (GreatLogTalkEvents): starts message $04C6 ('<BUF0> checked the bookshelf.'
; 'Handbook on ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with
; the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04C6 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Handbook on Naming' (E-0268, the E-0082 shape; was
; TalkMsg04C6_HeroCheckedTheBookshelfHandbook)
TalkMsg04C6_HeroCheckedTheBookshelfHandbook::
    ld hl, $04c6 ; '0 checked the bookshelf. 'Handbook on'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04C7_HeroCheckedTheBookshelfHandbook", ROMX

; Great Log talk 73 (GreatLogTalkEvents): starts message $04C7 ('<BUF0> checked the bookshelf.'
; 'Handbook on ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with
; the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04C7 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Handbook on Naming' (E-0268, the E-0082 shape; was
; TalkMsg04C7_HeroCheckedTheBookshelfHandbook)
TalkMsg04C7_HeroCheckedTheBookshelfHandbook::
    ld hl, $04c7 ; '0 checked the bookshelf. 'Handbook on'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg08C0_WeGetMoreAndMoreStubborn", ROMX

; Great Log talk 74 (GreatLogTalkEvents): starts message $08C0 ('We get more and more ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $08C0 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'We get more and more stubborn as' (E-0268, the E-0082 shape; was
; TalkMsg08C0_WeGetMoreAndMoreStubborn)
TalkMsg08C0_WeGetMoreAndMoreStubborn::
    ld hl, $08c0 ; '*: We get more and more'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowHeresThatTinyMedalWait", ROMX

; Great Log talk: after EVENT_REWARD_ITEM_OR_KEY_1A3 and before receiving it, a TinyMedal (item $2C)
; with 'Here's that TinyMedal.' when the bag has room, or $0D4A; otherwise 'You have to tamp the
; ...' ($08BB), or 'GreatLog is a floating island?' ($0D87) at the end. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowHeresThatTinyMedalWait::
    ld de, EVENT_REWARD_ITEM_OR_KEY_1A3
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_HERO_RECEIVED_A_TINY_MEDAL
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_script_at_hl_b13
    or a
    jr z, .call_start_script_at_hl_b13
    ld hl, $0d4a ; '*: Here's that TinyMedal. …Wait, you'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_Here_3 ; script '*: Here's that TinyMedal.'
    call StartScriptAtHL_B13
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $08bb ; '*: You have to tamp the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d87 ; '*: GreatLog is a floating island?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Hibernation", ROMX

; Great Log talk 76, hibernation: the first time starts Script_HelloHeroWelcomeThis ('Hello, 0,
; welcome! This is') and sets EVENT_HELLO_HERO_WELCOME_THIS_IS; afterwards starts
; Script_HelloHeroWelcomeWant ('Hello, 0, welcome! Want to'). Both scripts jump to Script_Hibernate
; in the data bank (script command SCRIPT_HIBERNATE, HibernateMenu), so it sets wDataBank = $1D.
; (C2, E-0370; probed E-0377)
; starts Script_HelloHeroWelcomeThis: '*: Hello, 0, welcome! This is' (E-0248)
GreatLogTalkEvents_Hibernation::
    ld de, EVENT_HELLO_HERO_WELCOME_THIS_IS
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_HelloHeroWelcomeThis ; script '*: Hello, 0, welcome! This is'
    call StartScriptAtHL_B13
    ld a, $1d
    ld [wDataBank], a
    ld de, EVENT_HELLO_HERO_WELCOME_THIS_IS
    call SetFlagBit
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HelloHeroWelcomeWant ; script '*: Hello, 0, welcome! Want to'
    call StartScriptAtHL_B13
    ld a, $1d
    ld [wDataBank], a
    ret

SECTION "Bank 13 TalkMsg0A50_ZzzzYawnHuhIsItMorning", ROMX

; Great Log talk 77 (GreatLogTalkEvents): starts message $0A50 ('Zzzz... Yawn... Huh? Is it ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A50 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Zzzz Yawn Huh? Is it morning already?' (E-0268, the E-0082 shape; was
; TalkMsg0A50_ZzzzYawnHuhIsItMorning)
TalkMsg0A50_ZzzzYawnHuhIsItMorning::
    ld hl, $0a50 ; '*: Zzzz… Yawn… Huh? Is it'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A52_OurKindAlwaysStaysNearWater", ROMX

; Great Log talk 78 (GreatLogTalkEvents): starts message $0A52 ('Our kind always stays near ...'). A
; message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A52 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Our kind always stays near water. Go' (E-0268, the E-0082 shape; was
; TalkMsg0A52_OurKindAlwaysStaysNearWater)
TalkMsg0A52_OurKindAlwaysStaysNearWater::
    ld hl, $0a52 ; '*: Our kind always stays near'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A53_ZzzZzzZzzWhoopsWasI", ROMX

; Great Log talk 79 (GreatLogTalkEvents): starts message $0A53 ('Zzz... Zzz... Zzz... Whoops! Was
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A53 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Zzz Zzz Zzz Whoops! Was I breathing' (E-0268, the E-0082 shape; was
; TalkMsg0A53_ZzzZzzZzzWhoopsWasI)
TalkMsg0A53_ZzzZzzZzzWhoopsWasI::
    ld hl, $0a53 ; '*: Zzz… Zzz… Zzz… Whoops! Was'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A59_HeroReadTheSignSshMonsters", ROMX

; Great Log talk 80 (GreatLogTalkEvents): starts message $0A59 ('<BUF0> read the sign.' 'Ssh...
; Monsters ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A59 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 read the sign. Ssh Monsters are' (E-0268, the E-0082 shape; was
; TalkMsg0A59_HeroReadTheSignSshMonsters)
; starts Script_HeroCheckedTheCasket: '0 checked the casket.' (E-0248)
TalkMsg0A59_HeroReadTheSignSshMonsters::
    ld hl, $0a59 ; '0 read the sign. 'Ssh… Monsters'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HeroCheckedTheCasket", ROMX

; Great Log talk 81 (GreatLogTalkEvents): starts Script_HeroCheckedTheCasket (first message '<BUF0>
; checked the casket. ...'). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the
; script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_HeroCheckedTheCasket (StartScriptAtHL_B13); its first message begins '0 checked the
; casket.' (E-0271; was Talk_HeroCheckedTheCasket) (E-0344: the address in its name dropped or read
; as the label there; was Talk_HeroCheckedTheCasket; shortened from TalkScript_HeroCheckedTheCasket)
; starts Script_HeroCheckedTheCasket: '0 checked the casket.' (E-0248)
Talk_HeroCheckedTheCasket::
    ld hl, Script_HeroCheckedTheCasket ; script '0 checked the casket.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_HeroCheckedTheCasket_2", ROMX

; Great Log talk 82 (GreatLogTalkEvents): starts Script_HeroCheckedTheCasket_2 (first message
; '<BUF0> checked the casket. ...'). A script starts through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_HeroCheckedTheCasket_2 (StartScriptAtHL_B13); its first message begins '0 checked
; the casket.' (E-0271; was Talk_HeroCheckedTheCasket_2) (E-0344: the address in its name dropped or
; read as the label there; was Talk_HeroCheckedTheCasket_2; shortened from
; TalkScript_HeroCheckedTheCasket_2)
; starts Script_HeroCheckedTheCasket_2: '0 checked the casket.' (E-0248)
Talk_HeroCheckedTheCasket_2::
    ld hl, Script_HeroCheckedTheCasket_2 ; script '0 checked the casket.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0A5D_HeroReadTheSignWatchYour", ROMX

; Great Log talk 83 (GreatLogTalkEvents): starts message $0A5D ('<BUF0> read the sign.' 'Watch your
; ...'). A message starts through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A5D through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 read the sign. Watch your step!' (E-0268, the E-0082 shape; was
; TalkMsg0A5D_HeroReadTheSignWatchYour)
; starts Script_HeroPeeredIntoThe: '0 peered into the hole.' (E-0248)
TalkMsg0A5D_HeroReadTheSignWatchYour::
    ld hl, $0a5d ; '0 read the sign. 'Watch your'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HeroPeeredIntoTheHole", ROMX

; Great Log talk 84 (GreatLogTalkEvents): starts Script_HeroPeeredIntoThe (first message '<BUF0>
; peered into the hole. ...'). A script starts through StartScriptAtHL_B13 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; starts Script_HeroPeeredIntoThe (StartScriptAtHL_B13); its first message begins '0 peered into the
; hole.' (E-0271; was Talk_HeroPeeredIntoTheHole) (E-0344: the address in its name dropped or read
; as the label there; was Talk_HeroPeeredIntoTheHole; shortened from
; TalkScript_HeroPeeredIntoTheHole)
; starts Script_HeroPeeredIntoThe: '0 peered into the hole.' (E-0248)
Talk_HeroPeeredIntoTheHole::
    ld hl, Script_HeroPeeredIntoThe ; script '0 peered into the hole.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0292_TheyTakeEntryFeesFromMasters", ROMX

; Great Log talk 85 (GreatLogTalkEvents): picks the reply by story flags: with
; EVENT_THANKS_FOR_COMING_BY_025 set, message $0B79 ('You have to pay an ...'); otherwise, message
; $0292 ('They take entry fees from ...'). A message starts through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0292_TheyTakeEntryFeesFromMasters.call_start_message_command09_hl_b13); starts message
; $0292 through StartMessageCommand09HL_B13 (script command $09); that string begins 'They take
; entry fees from masters for' (E-0268, the E-0082 shape; was
; TalkMsg0292_TheyTakeEntryFeesFromMasters)
TalkMsg0292_TheyTakeEntryFeesFromMasters::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0292 ; '*: They take entry fees from'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b79 ; '*: You have to pay an'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg027D_WhatDoYouSupposeMonsters", ROMX

; Great Log talk 86 (GreatLogTalkEvents): message $0B75 ('I've learned how to tell') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $027D ('What do you suppose monsters are
; thinking?'); both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg027D_WhatDoYouSupposeMonsters.call_start_message_command09_hl_b13); starts message $027D
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'What do you suppose
; monsters are thinking?' (E-0268, the E-0082 shape; was TalkMsg027D_WhatDoYouSupposeMonsters)
TalkMsg027D_WhatDoYouSupposeMonsters::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $027d ; '*: What do you suppose monsters'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b75 ; '*: I've learned how to tell'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg027E_GRAHHUNGRYLOOKDELICIOUS", ROMX

; Great Log talk 87 (GreatLogTalkEvents): starts message $027E ('GRAH, HUNGRY. LOOK DELICIOUS...')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $027E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'GRAH, HUNGRY. LOOK DELICIOUS' (E-0268, the E-0082 shape; was TalkMsg027E_GRAHHUNGRYLOOKDELICIOUS)
TalkMsg027E_GRAHHUNGRYLOOKDELICIOUS::
    ld hl, $027e ; '*: GRAH, HUNGRY. LOOK DELICIOUS…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg028C_ListenToWinYouNeedBalance", ROMX

; Great Log talk 88 (GreatLogTalkEvents): starts message $028C ('Listen, to win you need balance.
; Attack,') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $028C through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Listen, to win you need balance. Attack,' (E-0268, the E-0082 shape; was
; TalkMsg028C_ListenToWinYouNeedBalance)
TalkMsg028C_ListenToWinYouNeedBalance::
    ld hl, $028c ; '*: Listen, to win you need'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg028D_ItsNotAllAboutWinningWe", ROMX

; Great Log talk 89 (GreatLogTalkEvents): starts message $028D ('It's not all about winning. We
; should,') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $028D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'It's not all about winning. We should,' (E-0268, the E-0082 shape; was
; TalkMsg028D_ItsNotAllAboutWinningWe)
TalkMsg028D_ItsNotAllAboutWinningWe::
    ld hl, $028d ; '*: It's not all about winning.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg028E_ArrrrrooohMyBloodBurnsICan", ROMX

; Great Log talk 90 (GreatLogTalkEvents): starts message $028E ('Arrrrroooh! My blood burns! I can
; taste') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $028E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Arrrrroooh! My blood burns! I can taste' (E-0268, the E-0082 shape; was
; TalkMsg028E_ArrrrrooohMyBloodBurnsICan)
TalkMsg028E_ArrrrrooohMyBloodBurnsICan::
    ld hl, $028e ; '*: Arrrrroooh! My blood burns! I'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0287_MonstersCanGrowOnlySoMuch", ROMX

; Great Log talk 91 (GreatLogTalkEvents): starts message $0287 ('Monsters can grow only so much.
; They') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0287 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Monsters can grow only so much. They' (E-0268, the E-0082 shape; was
; TalkMsg0287_MonstersCanGrowOnlySoMuch)
TalkMsg0287_MonstersCanGrowOnlySoMuch::
    ld hl, $0287 ; '*: Monsters can grow only so'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0286_TheArenaIsWhereMastersCan", ROMX

; Great Log talk 92 (GreatLogTalkEvents): starts message $0286 ('The Arena is where masters can
; test') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0286 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Arena is where masters can test' (E-0268, the E-0082 shape; was
; TalkMsg0286_TheArenaIsWhereMastersCan)
TalkMsg0286_TheArenaIsWhereMastersCan::
    ld hl, $0286 ; '*: The Arena is where masters'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg028F_IfYouComeAcrossAMonster", ROMX

; Great Log talk 93 (GreatLogTalkEvents): starts message $028F ('If you come across a monster that')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $028F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'If you come across a monster that' (E-0268, the E-0082 shape; was
; TalkMsg028F_IfYouComeAcrossAMonster)
TalkMsg028F_IfYouComeAcrossAMonster::
    ld hl, $028f ; '*: If you come across a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0294_IfYouWinAnArenaTourney", ROMX

; Great Log talk 94 (GreatLogTalkEvents): message $0B7A ('I've never heard of a') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0294 ('If you win an Arena tourney, your'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0294_IfYouWinAnArenaTourney.call_start_message_command09_hl_b13); starts message $0294
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'If you win an Arena
; tourney, your' (E-0268, the E-0082 shape; was TalkMsg0294_IfYouWinAnArenaTourney)
TalkMsg0294_IfYouWinAnArenaTourney::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0294 ; '*: If you win an Arena'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b7a ; '*: I've never heard of a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0290_SirloinIsTheTopsHarrumph", ROMX

; Great Log talk 95 (GreatLogTalkEvents): starts message $0290 ('Sirloin is the tops, harrumph! It
; just') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0290 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Sirloin is the tops, harrumph! It just' (E-0268, the E-0082 shape; was
; TalkMsg0290_SirloinIsTheTopsHarrumph)
TalkMsg0290_SirloinIsTheTopsHarrumph::
    ld hl, $0290 ; '*: Sirloin is the tops, harrumph!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0291_IIDidntFallForAny", ROMX

; Great Log talk 96 (GreatLogTalkEvents): starts message $0291 ('I... I didn't fall for') through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0291 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I I didn't fall for any meat.' (E-0268, the E-0082 shape; was TalkMsg0291_IIDidntFallForAny)
TalkMsg0291_IIDidntFallForAny::
    ld hl, $0291 ; '*: I… I didn't fall for'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ArenaReceptionist", ROMX

; Great Log talk, the arena receptionist: by wArenaRank 'Oh, a cute little master!', then 'Oh,
; you're the Kids/C/B/A Class ...' (each in a second script behind EVENT_NEVER_SET), or 'You have to
; pay an ...' ($0B78) above A class. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ArenaReceptionist::
    ld a, [wArenaRank]
    or a
    jr nz, .skip
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_OhACuteLittle ; script '*: Oh, a cute little master!'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_OhACuteLittle_2 ; script '*: Oh, a cute little master!'
    call StartScriptAtHL_B13
    ret

.skip:
    dec a
    jr nz, .skip2
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld hl, Script_OhYou_7 ; script '*: Oh, you're the Kids Class'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_OhYou_11 ; script '*: Oh, you're the Kids Class'
    call StartScriptAtHL_B13
    ret

.skip2:
    dec a
    jr nz, .skip3
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b133
    ld hl, Script_OhYou_8 ; script '*: Oh, you're the C Class'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b133:
    ld hl, Script_OhYou_12 ; script '*: Oh, you're the C Class'
    call StartScriptAtHL_B13
    ret

.skip3:
    dec a
    jr nz, .skip4
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b134
    ld hl, Script_OhYou_9 ; script '*: Oh, you're the B Class'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b134:
    ld hl, Script_OhYou_13 ; script '*: Oh, you're the B Class'
    call StartScriptAtHL_B13
    ret

.skip4:
    dec a
    jr nz, .call_start_message_command09_hl_b13
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b135
    ld hl, Script_OhYou_10 ; script '*: Oh, you're the A Class'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b135:
    ld hl, Script_OhYou_14 ; script '*: Oh, you're the A Class'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b78 ; '*: You have to pay an'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0296_HeroPeeredIntoTheVaseIt", ROMX

; Great Log talk 98 (GreatLogTalkEvents): starts message $0296 ('<BUF0> peered into the vase. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0296 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0296_HeroPeeredIntoTheVaseIt)
TalkMsg0296_HeroPeeredIntoTheVaseIt::
    ld hl, $0296 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_TinyMedal_Flag010C", ROMX

; Great Log talk 99 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL and
; story flag $010C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $010C in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag010C)
VaseItem_TinyMedal_Flag010C::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $010c
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg027A_ListenThisIsASecretTheres", ROMX

; Great Log talk 100 (GreatLogTalkEvents): message $0B67 ('Listen, this is a secret.') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $027A ('Listen, this is a secret. There's a');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg027A_ListenThisIsASecretTheres.call_start_message_command09_hl_b13); starts message $027A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Listen, this is a
; secret. There's a' (E-0268, the E-0082 shape; was TalkMsg027A_ListenThisIsASecretTheres)
TalkMsg027A_ListenThisIsASecretTheres::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $027a ; '*: Listen, this is a secret.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b67 ; '*: Listen, this is a secret.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ArenaClassChoice", ROMX

; Great Log talk 101, the arena desk (scripts in bank $0C): sets wDataBank = $0C and
; wScreenTableIndex = 0 and clears the arena data (GreatLogTalkEvents_ClearArenaData, $20F bytes
; from wArenaEntry); then by wArenaRank: rank 0 starts Script_WelcomeToTheArena ('Welcome to the
; Arena! Masters'); rank 1 starts Script_WelcomeToTheArena_2 ('Welcome to the Arena! The', which
; sets EVENT_WELCOME_TO_THE_ARENA) until that flag is set, then Script_HelloWhichClassWill ('Hello,
; which Class will it'); rank 5 starts Script_WelcomeDoYouWish ('Welcome! Do you wish to'). Ranks
; 2-4 first hand over the prize key while wArenaOutcome is 0: GenerateNewKeyEntry, its result (1
; made, 0 key list full) into wArenaOutcome, then Script_Here_2 ('received a Magic Key') or
; Script_Here ('Oh? But your key ring'); once wArenaOutcome is set they get the rank-1 scripts. (C2,
; E-0377)
GreatLogTalkEvents_ArenaClassChoice::
    ld a, $0c
    ld [wDataBank], a
    xor a
    ld [wScreenTableIndex], a
    farcall GreatLogTalkEvents_ClearArenaData
    ld a, [wArenaRank]
    or a
    jr z, .call_start_script_at_hl_b132
    cp $01
    jr z, .call_test_flag_bit
    cp $05
    jr z, .call_start_script_at_hl_b134
    ld a, [wArenaOutcome]
    or a
    jr nz, .check_arena_rank
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    ld [wArenaOutcome], a
    or a
    jr nz, .call_start_script_at_hl_b13
    ld hl, Script_Here ; script '*: Here's the Magic Key you'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_Here_2 ; script '*: Here's the Magic Key you'
    call StartScriptAtHL_B13
    ret

.check_arena_rank:
    ld a, [wArenaRank]
    or a
    jr nz, .call_test_flag_bit

.call_start_script_at_hl_b132:
    ld hl, Script_WelcomeToTheArena ; script '*: Welcome to the Arena! Masters'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_WELCOME_TO_THE_ARENA
    call TestFlagBit
    jr c, .call_start_script_at_hl_b133
    ld hl, Script_WelcomeToTheArena_2 ; script '*: Welcome to the Arena! The'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b133:
    ld hl, Script_HelloWhichClassWill ; script '*: Hello, which Class will it'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b134:
    ld hl, Script_WelcomeDoYouWish ; script '*: Welcome! Do you wish to'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Breeder", ROMX

; Great Log talk, the breeder (scripts in bank $0E): saves the screen and the player's position; 'I
; lost again. I need ...' in two versions, or 'When you breed, the offspring ...' ($04B4) after
; EVENT_WHEN_YOU_BREED_THE_OFFSPRING. (C1, E-0357)
GreatLogTalkEvents_Breeder::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, EVENT_WHEN_YOU_BREED_THE_OFFSPRING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $0e
    ld [wDataBank], a
    ld de, EVENT_I_LOST_AGAIN_I_NEED
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_ILostAgainI ; script '*: I lost again. I need'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_ILostAgainI_2 ; script '*: I lost again. I need'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04b4 ; '*: When you breed, the offspring'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04B5_DoYouKnowAllTheKinds", ROMX

; Great Log talk 103 (GreatLogTalkEvents): by story progress, latest first: after
; EVENT_THANKS_FOR_COMING_BY_025 message $0B6E ('My frigid breath chills even'), after
; EVENT_SCENE_SHIELD2_023 $04C1 ('Arr, matey! I'm CaptDead!'), after EVENT_SCENE_MERMAID_KINGDOM_022
; $04BB ('NoctoKing is my name! Darkness'), otherwise $04B5 ('Do you know all the kinds of'); each
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg04B5_DoYouKnowAllTheKinds.call_start_message_command09_hl_b133; flag 0023 then jr c,
; TalkMsg04B5_DoYouKnowAllTheKinds.call_start_message_command09_hl_b132; flag 0022 then jr c,
; TalkMsg04B5_DoYouKnowAllTheKinds.call_start_message_command09_hl_b13); starts message $04B5
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Do you know all the
; kinds of' (E-0268, the E-0082 shape; was TalkMsg04B5_DoYouKnowAllTheKinds)
TalkMsg04B5_DoYouKnowAllTheKinds::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $04b5 ; '*: Do you know all the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04bb ; '*: NoctoKing is my name! Darkness'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $04c1 ; '*: Arr, matey! I'm CaptDead! A'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b6e ; '*: My frigid breath chills even'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04B6_IfYouEatAnyBadMeatLike", ROMX

; Great Log talk 104 (GreatLogTalkEvents): by story progress, latest first: after
; EVENT_THANKS_FOR_COMING_BY_025 message $0B6F ('As I level up, my'), after EVENT_SCENE_SHIELD2_023
; $04C2 ('I strike with my eight'), after EVENT_SCENE_MERMAID_KINGDOM_022 $04BC ('I learned how to
; Massacre!'), otherwise $04B6 ('If you eat any BadMeat like me,'); each through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg04B6_IfYouEatAnyBadMeatLike.call_start_message_command09_hl_b133; flag 0023 then jr c,
; TalkMsg04B6_IfYouEatAnyBadMeatLike.call_start_message_command09_hl_b132; flag 0022 then jr c,
; TalkMsg04B6_IfYouEatAnyBadMeatLike.call_start_message_command09_hl_b13); starts message $04B6
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'If you eat any
; BadMeat like me,' (E-0268, the E-0082 shape; was TalkMsg04B6_IfYouEatAnyBadMeatLike)
TalkMsg04B6_IfYouEatAnyBadMeatLike::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $04b6 ; '*: If you eat any BadMeat'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04bc ; '*: I learned how to Massacre!'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $04c2 ; '*: I strike with my eight'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b6f ; '*: As I level up, my'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_EggEvaluator", ROMX

; Great Log talk, the Egg Evaluator (scripts in bank $96): 'Um... I'm the Egg Evaluator.' the first
; time, then 'I'm the Egg Evaluator. May ...'; at the end 'Oh, the savior of GreatLog.' once. (C2,
; E-0357; probed E-0377)
GreatLogTalkEvents_EggEvaluator::
    ld a, $96
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_UM_I
    call TestFlagBit
    jr c, .loop
    ld hl, Script_UmI ; script '*: Um… I'm the Egg Evaluator.'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, Script_I_7 ; script '*: I'm the Egg Evaluator. May'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_OH_THE_SAVIOR_OF
    call TestFlagBit
    jr c, .loop
    ld hl, Script_OhTheSaviorOf ; script '*: Oh, the savior of GreatLog.'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_StarryShrine", ROMX

; Great Log talk, the Starry Shrine (scripts in bank $15): saves the screen and the player's
; position; 'Welcome to the Starry Shrine.' in two versions; at the end 'Aren't you GreatLog's
; savior?' once. (C1, E-0357)
GreatLogTalkEvents_StarryShrine::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $15
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_WELCOME_TO_THE_STARRY_SHRINE
    call TestFlagBit
    jr c, .loop
    ld hl, Script_WelcomeToTheStarry ; script '*: Welcome to the Starry Shrine.'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, Script_WelcomeToTheStarry_2 ; script '*: Welcome to the Starry Shrine.'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_AREN
    call TestFlagBit
    jr c, .loop
    ld hl, Script_Aren ; script '*: Aren't you GreatLog's savior? Well,'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_ImTheProfsAssistantDoYou", ROMX

; Great Log talk 107 (GreatLogTalkEvents): starts Script_I_8 ('I'm the Prof's assistant. Do')
; through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1). (C2, E-0377)
; starts Script_I_8 (StartScriptAtHL_B13); its first message begins 'I'm the Prof's assistant. Do
; you' (E-0271; was Talk_ImTheProfsAssistantDoYou) (E-0344: the address in its name dropped or read
; as the label there; was Talk_ImTheProfsAssistantDoYou; shortened from
; TalkScript_ImTheProfsAssistantDoYou)
; starts Script_I_8: '*: I'm the Prof's assistant. Do' (E-0248)
Talk_ImTheProfsAssistantDoYou::
    ld hl, Script_I_8 ; script '*: I'm the Prof's assistant. Do'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg08D8_HeroCheckedTheBookshelfBreeding", ROMX

; Great Log talk 108 (GreatLogTalkEvents): starts message $08D8 ('<BUF0> checked the bookshelf.
; "Breeding Guide..."') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). The next entry,
; TalkMsg08D9_HeroCheckedTheBookshelfBreeding, shows $08D9, which begins the same way. (C2, E-0377)
; starts message $08D8 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Breeding Guide In' (E-0268, the E-0082 shape; was
; TalkMsg08D8_HeroCheckedTheBookshelfBreeding)
TalkMsg08D8_HeroCheckedTheBookshelfBreeding::
    ld hl, $08d8 ; '0 checked the bookshelf. 'Breeding Guide…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg08D9_HeroCheckedTheBookshelfBreeding", ROMX

; Great Log talk 109 (GreatLogTalkEvents): starts message $08D9 ('<BUF0> checked the bookshelf.
; "Breeding Guide..."') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). The entry before,
; TalkMsg08D8_HeroCheckedTheBookshelfBreeding, shows $08D8, which begins the same way. (C2, E-0377)
; starts message $08D9 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Breeding Guide In' (E-0268, the E-0082 shape; was
; TalkMsg08D9_HeroCheckedTheBookshelfBreeding)
TalkMsg08D9_HeroCheckedTheBookshelfBreeding::
    ld hl, $08d9 ; '0 checked the bookshelf. 'Breeding Guide…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg08CD_HeroCheckedTheDoorTheDoor", ROMX

; Great Log talk 110 (GreatLogTalkEvents): starts message $08CD ('<BUF0> checked the door. The door
; won't') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $08CD through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the door. The door won't' (E-0268, the E-0082 shape; was
; TalkMsg08CD_HeroCheckedTheDoorTheDoor)
TalkMsg08CD_HeroCheckedTheDoorTheDoor::
    ld hl, $08cd ; '0 checked the door. The door'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg02DC_GreatLogsStarryShrineWasnt", ROMX

; Great Log talk 111 (GreatLogTalkEvents): starts message $02DC ('GreatLog's Starry Shrine wasn't in
; use for') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $02DC through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'GreatLog's Starry Shrine wasn't in use for' (E-0268, the E-0082 shape; was
; TalkMsg02DC_GreatLogsStarryShrineWasnt)
TalkMsg02DC_GreatLogsStarryShrineWasnt::
    ld hl, $02dc ; '*: GreatLog's Starry Shrine wasn't in'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DD4_IfYouBreedTheParentsGo", ROMX

; Great Log talk 112 (GreatLogTalkEvents): starts message $0DD4 ('If you breed, the parents go
; away') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0DD4 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'If you breed, the parents go away' (E-0268, the E-0082 shape; was
; TalkMsg0DD4_IfYouBreedTheParentsGo)
TalkMsg0DD4_IfYouBreedTheParentsGo::
    ld hl, $0dd4 ; '*: If you breed, the parents'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg02DD_ParentsPassOnAbilitiesTo", ROMX

; Great Log talk 113 (GreatLogTalkEvents): starts message $02DD ('Parents pass on abilities to their
; children,') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $02DD through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Parents pass on abilities to their children,' (E-0268, the E-0082 shape; was
; TalkMsg02DD_ParentsPassOnAbilitiesTo)
TalkMsg02DD_ParentsPassOnAbilitiesTo::
    ld hl, $02dd ; '*: Parents pass on abilities to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_YouCanCallMe", ROMX

; Great Log talk (scripts in bank $0C): 'You can call me the ...' in two versions; at the end 'Well,
; who would have thought ...' once. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_YouCanCallMe::
    ld a, $0c
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_YOU_CAN_CALL_ME
    call TestFlagBit
    jr c, .loop
    ld hl, Script_YouCanCallMe ; script '*: You can call me the'
    call StartScriptAtHL_B13
    ret

.loop:
    ld hl, Script_YouCanCallMe_2 ; script '*: You can call me the'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_WELL_WHO_WOULD_HAVE
    call TestFlagBit
    jr c, .loop
    ld hl, Script_WellWhoWouldHave ; script '*: Well, who would have thought'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0A6F_MyHusbandLovesToCollectThings", ROMX

; Great Log talk 115 (GreatLogTalkEvents): starts message $0A6F ('My husband loves to collect things
; that') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A6F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'My husband loves to collect things that' (E-0268, the E-0082 shape; was
; TalkMsg0A6F_MyHusbandLovesToCollectThings)
TalkMsg0A6F_MyHusbandLovesToCollectThings::
    ld hl, $0a6f ; '*: My husband loves to collect'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A75_HeroCheckedTheDresserItOverflowed", ROMX

; Great Log talk 116 (GreatLogTalkEvents): starts message $0A75 ('<BUF0> checked the dresser. It
; overflowed with') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). The next entry,
; TalkMsg0A76_HeroCheckedTheDresserItOverflowed, shows $0A76, which begins the same way. (C2,
; E-0377)
; starts message $0A75 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. It overflowed with' (E-0268, the E-0082 shape; was
; TalkMsg0A75_HeroCheckedTheDresserItOverflowed)
TalkMsg0A75_HeroCheckedTheDresserItOverflowed::
    ld hl, $0a75 ; '0 checked the dresser. It overflowed'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A76_HeroCheckedTheDresserItOverflowed", ROMX

; Great Log talk 117 (GreatLogTalkEvents): starts message $0A76 ('<BUF0> checked the dresser. It
; overflowed with') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). The entry before,
; TalkMsg0A75_HeroCheckedTheDresserItOverflowed, shows $0A75, which begins the same way. (C2,
; E-0377)
; starts message $0A76 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. It overflowed with' (E-0268, the E-0082 shape; was
; TalkMsg0A76_HeroCheckedTheDresserItOverflowed)
TalkMsg0A76_HeroCheckedTheDresserItOverflowed::
    ld hl, $0a76 ; '0 checked the dresser. It overflowed'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A77_HeroCheckedTheOvenThereWas", ROMX

; Great Log talk 118 (GreatLogTalkEvents): starts message $0A77 ('<BUF0> checked the oven. There was
; an') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A77 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the oven. There was an' (E-0268, the E-0082 shape; was
; TalkMsg0A77_HeroCheckedTheOvenThereWas)
TalkMsg0A77_HeroCheckedTheOvenThereWas::
    ld hl, $0a77 ; '0 checked the oven. There was'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg025E_MyGranddaughterIsPainfully", ROMX

; Great Log talk 119 (GreatLogTalkEvents): after EVENT_THANKS_FOR_COMING_BY_025 message $0B46 ('My
; granddaughter became a master.'); after EVENT_SCENE_THREE_ITEMS $0527 ('I'm an adult so I') with
; EVENT_SCENE_MASTER_THANKS, else $0D31 ('For the sake of my'); after
; EVENT_HERO_RECEIVED_A_LIFE_ACORN $0262 ('My granddaughter now insists that'); after
; EVENT_SCENE_MASTER_THANKS the gift: with a free bag slot (InventoryHasFreeSlotCheck_Bank13) it
; writes ITEM_LIFEACORN ($11) into that slot, sets bit 6 of wInventorySortFlags and starts
; Script_I_9 ('I've never seen my granddaughter', 'received a LifeAcorn.', which sets
; EVENT_HERO_RECEIVED_A_LIFE_ACORN), with a full bag only message $0261; before all of these $025E
; ('My granddaughter is painfully shy.'). Messages go through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg025E_MyGranddaughterIsPainfully.call_start_message_command09_hl_b133; flag 0024 then jr c,
; TalkMsg025E_MyGranddaughterIsPainfully.call_test_flag_bit; flag 012E then jr c,
; TalkMsg025E_MyGranddaughterIsPainfully.call_start_message_command09_hl_b13; flag 012D then jr c,
; TalkMsg025E_MyGranddaughterIsPainfully.call_inventory_has_free_slot_check_bank13); starts message
; $025E through StartMessageCommand09HL_B13 (script command $09); that string begins 'My
; granddaughter is painfully shy. She seems' (E-0268, the E-0082 shape; was
; TalkMsg025E_MyGranddaughterIsPainfully)
TalkMsg025E_MyGranddaughterIsPainfully::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_HERO_RECEIVED_A_LIFE_ACORN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_MASTER_THANKS
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check_bank13
    ld hl, $025e ; '*: My granddaughter is painfully shy.'
    call StartMessageCommand09HL_B13
    ret

.call_inventory_has_free_slot_check_bank13:
    call InventoryHasFreeSlotCheck_Bank13
    jr c, .read_inventory_sort_flags
    ld hl, $0261 ; '*: I've never seen my granddaughter'
    call StartMessageCommand09HL_B13
    ret

.read_inventory_sort_flags:
    ld [hl], $11
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_I_9 ; script '*: I've never seen my granddaughter'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0262 ; '*: My granddaughter now insists that'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_MASTER_THANKS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld hl, $0d31 ; '*: For the sake of my'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0527 ; '*: I'm an adult so I'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b46 ; '*: My granddaughter became a master.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0269_HeroCheckedTheDresserGirls", ROMX

; Great Log talk 120 (GreatLogTalkEvents): starts message $0269 ('<BUF0> checked the dresser. Girls'
; clothes') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0269 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. Girls clothes were' (E-0268, the E-0082 shape; was
; TalkMsg0269_HeroCheckedTheDresserGirls)
TalkMsg0269_HeroCheckedTheDresserGirls::
    ld hl, $0269 ; '0 checked the dresser. Girls' clothes'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_LogTwig", ROMX

; Great Log talk 121 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_LOGTWIG and
; story flag $0114 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2E, story
; flag $0114 in DE: when the flag is clear it gives item $2E (LogTwig) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_LogTwig)
VaseItem_LogTwig::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2e
    ld [wScriptParam1], a
    ld de, $0114
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg026A_HeroCheckedThePlushDollIt", ROMX

; Great Log talk 122 (GreatLogTalkEvents): starts message $026A ('<BUF0> checked the plush doll. It
; had') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $026A through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the plush doll. It had' (E-0268, the E-0082 shape; was
; TalkMsg026A_HeroCheckedThePlushDollIt)
TalkMsg026A_HeroCheckedThePlushDollIt::
    ld hl, $026a ; '0 checked the plush doll. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A32_ThereArePowersThatLetYou", ROMX

; Great Log talk 123 (GreatLogTalkEvents): starts message $0A32 ('There are powers that let you
; cross') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A32 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There are powers that let you cross' (E-0268, the E-0082 shape; was
; TalkMsg0A32_ThereArePowersThatLetYou)
TalkMsg0A32_ThereArePowersThatLetYou::
    ld hl, $0a32 ; '*: There are powers that let'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A33_HaveYouBeenToTheStarry", ROMX

; Great Log talk 124 (GreatLogTalkEvents): message $0B06 ('Many kinds of monsters result') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0A33 ('Have you been to the Starry Shrine?');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg0A33_HaveYouBeenToTheStarry.call_start_message_command09_hl_b13); starts message $0A33
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Have you been to the
; Starry Shrine?' (E-0268, the E-0082 shape; was TalkMsg0A33_HaveYouBeenToTheStarry)
TalkMsg0A33_HaveYouBeenToTheStarry::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a33 ; '*: Have you been to the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b06 ; '*: Many kinds of monsters result'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg020A_ImChoppingSomeTreesDownTo", ROMX

; Great Log talk 125 (GreatLogTalkEvents): message $0B0B ('Members of the dragon family,') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $020A ('I'm chopping some trees down to make');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg020A_ImChoppingSomeTreesDownTo.call_start_message_command09_hl_b13); starts message $020A
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'I'm chopping some
; trees down to make' (E-0268, the E-0082 shape; was TalkMsg020A_ImChoppingSomeTreesDownTo)
TalkMsg020A_ImChoppingSomeTreesDownTo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $020a ; '*: I'm chopping some trees down'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b0b ; '*: Members of the dragon family,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg08BF_MasterOnlyMakesMeChargeIt", ROMX

; Great Log talk 126 (GreatLogTalkEvents): message $0B0C ('The master's battle plan alters') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $08BF ('Master only makes me charge. It made');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg08BF_MasterOnlyMakesMeChargeIt.call_start_message_command09_hl_b13); starts message $08BF
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Master only makes me
; charge. It made' (E-0268, the E-0082 shape; was TalkMsg08BF_MasterOnlyMakesMeChargeIt)
TalkMsg08BF_MasterOnlyMakesMeChargeIt::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $08bf ; '*: Master only makes me charge.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b0c ; '*: The master's battle plan alters'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Shopkeeper", ROMX

; Great Log talk 127, the shopkeeper (scripts in bank $10): before EVENT_REWARD_ITEM_OR_KEY_2: the
; first time sets EVENT_I_WANT_TO_OPEN_UP and says $08C5 ('I want to open up'); later, with an
; ArmyAnt (MONSTER_ARMYANT, $B9, FindPartyIndexOfSpeciesTemp0) in the party, $08C7 ('Wait! Could I
; get you') when it is the only member, else the 'Wait! Could I get you' scripts:
; Script_WaitCouldIGet after EVENT_REWARD_ITEM_OR_KEY, otherwise Script_WaitCouldIGet_3 when the
; last bag slot (wInventory + $17) is free ($00 or $FF) and Script_WaitCouldIGet_2 when it is not;
; without an ArmyAnt $08C5 again. After EVENT_REWARD_ITEM_OR_KEY_2 it sets wScreenTableIndex = 1;
; after EVENT_SCENE_SHIELD2_023 with object 1 at X $10 the shop opens (wDataBank = $10):
; Script_ArmyAntHelpedMeGet once (setting EVENT_ARMY_ANT_HELPED_ME_GET), then
; Script_WelcomeHowMayI_2; otherwise message $0D25 ('ArmyAnt's help means I can'). (C2, E-0377)
GreatLogTalkEvents_Shopkeeper::
    ld de, EVENT_REWARD_ITEM_OR_KEY_2
    call TestFlagBit
    jr c, .set_screen_table_index_to_01
    ld de, EVENT_I_WANT_TO_OPEN_UP
    call TestFlagBit
    jr c, .set_temp0
    ld de, EVENT_I_WANT_TO_OPEN_UP
    call SetFlagBit

.loop:
    ld hl, $08c5 ; '*: I want to open up'
    call StartMessageCommand09HL_B13
    ret

.set_temp0:
    ld hl, $00b9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld a, [wPartyCount]
    dec a
    jr z, .call_start_message_command09_hl_b13
    ld de, EVENT_REWARD_ITEM_OR_KEY
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_script_at_hl_b13
    or a
    jr z, .call_start_script_at_hl_b13
    ld hl, Script_WaitCouldIGet_2 ; script '*: Wait! Could I get you'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WaitCouldIGet_3 ; script '*: Wait! Could I get you'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_WaitCouldIGet ; script '*: Wait! Could I get you'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $08c7 ; '*: Wait! Could I get you'
    call StartMessageCommand09HL_B13
    ret

.set_screen_table_index_to_01:
    ld a, $01
    ld [wScreenTableIndex], a
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, .check_object1

.loop2:
    ld hl, $0d25 ; '*: ArmyAnt's help means I can'
    call StartMessageCommand09HL_B13
    ret

.check_object1:
    ld a, [wObject1 + OBJ_X]
    cp $10
    jr nz, .loop2
    ld a, $10
    ld [wDataBank], a
    ld de, EVENT_ARMY_ANT_HELPED_ME_GET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b133
    ld hl, Script_ArmyAntHelpedMeGet ; script '*: ArmyAnt helped me get my'
    call StartScriptAtHL_B13
    ld de, EVENT_ARMY_ANT_HELPED_ME_GET
    call SetFlagBit
    ret

.call_start_script_at_hl_b133:
    ld hl, Script_WelcomeHowMayI_2 ; script '*: Welcome! How may I serve'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0A39_TheManHereHasRareKeys", ROMX

; Great Log talk 128 (GreatLogTalkEvents): starts message $0A39 ('The man here has rare keys.
; Doesn't') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A39 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The man here has rare keys. Doesn't' (E-0268, the E-0082 shape; was
; TalkMsg0A39_TheManHereHasRareKeys)
TalkMsg0A39_TheManHereHasRareKeys::
    ld hl, $0a39 ; '*: The man here has rare'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A3C_KingIfYouSee", ROMX

; Great Log talk 129 (GreatLogTalkEvents), the King. Before EVENT_THANKS_FOR_COMING_BY_025: after
; EVENT_SCENE_DARCK_DEFEATED message $053D ('King: GreatLog's crisis has passed.'); after
; EVENT_SCENE_THREE_ITEMS $050F ('King: There have been many quakes.') once EVENT_SCENE_KAMEHA_BACK
; is set, else $050E ('King: Kameha came back safely from') which sets EVENT_WHAT and
; EVENT_SCENE_KAMEHA_BACK; otherwise $0A3C ('King: If you see Kameha again,'). After it, four rounds
; of the same shape, each gated by the previous round's EVENT_HERO_RECEIVED_10_000_G / _20_000_G /
; _30_000_G: with that round's EVENT_KING_IF_YOU_SEE flag (EVENT_KING_IF_YOU_SEE, _196, _199, _19C)
; it adds 10,000, 20,000, 30,000 or 40,000 gold (AddGoldCapped) and starts
; Script_KingAhYou(_2/_3/_4) ('King: Ah, you've finally caught the'); with its
; EVENT_KING_YOU_WILL_I_KNEW flag (EVENT_KING_YOU_WILL_I_KNEW, _195, _198, _19B) message
; $0B7F/$0B85/$0B88/$0B8B ('King: There is an evil master'); otherwise Script_KingOhIt(_2/_3/_4)
; when TotalSpeciesFlaggedOrListed reaches 100, 120, 140 or 160, else $0B7B (round 1) or $0B82
; ('King: I was right to trust'). After EVENT_HERO_RECEIVED_40_000_G, message $0B8D. Messages go
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to TalkMsg0A3C_KingIfYouSee.call_test_flag_bit2;
; flag $00D1 set: jr to TalkMsg0A3C_KingIfYouSee.call_start_message_command09_hl_b132; flag $0024
; set: jp to TalkMsg0A3C_KingIfYouSee.call_test_flag_bit); when none of them branches, starts
; message $0A3C through StartMessageCommand09HL_B13 (script command $09); that string begins 'King
; If you see Kameha again,' (E-0082)
TalkMsg0A3C_KingIfYouSee::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_test_flag_bit
    ld hl, $0a3c ; 'King: If you see Kameha again,'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_KAMEHA_BACK
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $050e ; 'King: Kameha came back safely from'
    call StartMessageCommand09HL_B13
    ld de, EVENT_WHAT
    call SetFlagBit
    ld de, EVENT_SCENE_KAMEHA_BACK
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $050f ; 'King: There have been many quakes.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $053d ; 'King: GreatLog's crisis has passed. We'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_HERO_RECEIVED_10_000_G
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, EVENT_KING_IF_YOU_SEE
    call TestFlagBit
    jr c, .set_temp0
    ld de, EVENT_KING_YOU_WILL_I_KNEW
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b13
    ldh a, [hTemp0]
    cp $64
    jr nc, .call_start_script_at_hl_b13
    ld hl, $0b7b ; 'King: Oh? It's our savior 0!'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_KingOhIt ; script 'King: Oh? It's our savior 0!'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b7f ; 'King: There is an evil master'
    call StartMessageCommand09HL_B13
    ret

.set_temp0:
    ld hl, $2710
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_KingAhYou ; script 'King: Ah, you've finally caught the'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit3:
    ld de, EVENT_HERO_RECEIVED_20_000_G
    call TestFlagBit
    jr c, .call_test_flag_bit4
    ld de, EVENT_KING_IF_YOU_SEE_196
    call TestFlagBit
    jr c, .set_temp02
    ld de, EVENT_KING_YOU_WILL_I_KNEW_195
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b132
    ldh a, [hTemp0]
    cp $78
    jr nc, .call_start_script_at_hl_b132
    ld hl, $0b82 ; 'King: I was right to trust'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_KingOhIt_2 ; script 'King: Oh? It's our savior 0!'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $0b85 ; 'King: There is an evil master'
    call StartMessageCommand09HL_B13
    ret

.set_temp02:
    ld hl, 20000
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_KingAhYou_2 ; script 'King: Ah, you've finally caught the'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit4:
    ld de, EVENT_HERO_RECEIVED_30_000_G
    call TestFlagBit
    jr c, .call_test_flag_bit5
    ld de, EVENT_KING_IF_YOU_SEE_199
    call TestFlagBit
    jr c, .set_temp03
    ld de, EVENT_KING_YOU_WILL_I_KNEW_198
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b135
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b133
    ldh a, [hTemp0]
    cp $8c
    jr nc, .call_start_script_at_hl_b133
    ld hl, $0b82 ; 'King: I was right to trust'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b133:
    ld hl, Script_KingOhIt_3 ; script 'King: Oh? It's our savior 0!'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b135:
    ld hl, $0b88 ; 'King: There is an evil master'
    call StartMessageCommand09HL_B13
    ret

.set_temp03:
    ld hl, 30000
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_KingAhYou_3 ; script 'King: Ah, you've finally caught the'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit5:
    ld de, EVENT_HERO_RECEIVED_40_000_G
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b137
    ld de, EVENT_KING_IF_YOU_SEE_19C
    call TestFlagBit
    jr c, .set_temp04
    ld de, EVENT_KING_YOU_WILL_I_KNEW_19B
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b136
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b134
    ldh a, [hTemp0]
    cp $a0
    jr nc, .call_start_script_at_hl_b134
    ld hl, $0b82 ; 'King: I was right to trust'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b134:
    ld hl, Script_KingOhIt_4 ; script 'King: Oh? It's our savior 0!'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b136:
    ld hl, $0b8b ; 'King: There is an evil master'
    call StartMessageCommand09HL_B13
    ret

.set_temp04:
    ld hl, vBGMap1 + $40
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_KingAhYou_4 ; script 'King: Ah, you've finally caught the'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b137:
    ld hl, $0b8d ; 'King: I was right to trust'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A3E_YoureFreeToGo", ROMX

; Great Log talk 130 (GreatLogTalkEvents): before EVENT_THANKS_FOR_COMING_BY_025, message $0510
; ('The frequent quakes have raised') after EVENT_SCENE_THREE_ITEMS, else $0A3E ('You're free to go
; anywhere in'). After it, $0D93 ('We've had reports of rogue') until EVENT_KING_YOU_WILL_I_KNEW is
; set; then it tests the King round flags latest first (EVENT_KING_IF_YOU_SEE_19C,
; EVENT_KING_YOU_WILL_I_KNEW_19B, _199, _198, _196, _195, then EVENT_KING_IF_YOU_SEE): the first set
; EVENT_KING_IF_YOU_SEE flag gives $0D94 ('Ah, bless you! As GreatLog's'), the first set
; EVENT_KING_YOU_WILL_I_KNEW flag (or none) gives $0B8E ('It would be our Kingdom's'). Messages go
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to TalkMsg0A3E_YoureFreeToGo.call_test_flag_bit;
; flag $0024 set: jp to TalkMsg0A3E_YoureFreeToGo.call_start_message_command09_hl_b13); when none of
; them branches, starts message $0A3E through StartMessageCommand09HL_B13 (script command $09); that
; string begins 'You're free to go anywhere in' (E-0082)
TalkMsg0A3E_YoureFreeToGo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a3e ; '*: You're free to go anywhere'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0510 ; '*: The frequent quakes have raised'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_KING_YOU_WILL_I_KNEW
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld hl, $0d93 ; '*: We've had reports of rogue'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_KING_IF_YOU_SEE_19C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_KING_YOU_WILL_I_KNEW_19B
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_KING_IF_YOU_SEE_199
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_KING_YOU_WILL_I_KNEW_198
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_KING_IF_YOU_SEE_196
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_KING_YOU_WILL_I_KNEW_195
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_KING_IF_YOU_SEE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133

.call_start_message_command09_hl_b132:
    ld hl, $0b8e ; '*: It would be our Kingdom's'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0d94 ; '*: Ah, bless you! As GreatLog's'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A3F_TheKingAndPrinces", ROMX

; Great Log talk 131 (GreatLogTalkEvents): message $0511 ('Beyond here is his Majesty') after
; EVENT_THANKS_FOR_COMING_BY_025 or, before it, after EVENT_SCENE_KAMEHA_BACK; $0544 ('I can't eat
; another... Zzz') after EVENT_SCENE_DARCK_DEFEATED (tested before EVENT_SCENE_KAMEHA_BACK);
; otherwise $0A3F ('The King and Prince's chamber is'); each through StartMessageCommand09HL_B13
; (script command 9 with the word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState =
; 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A3F_TheKingAndPrinces.call_start_message_command09_hl_b13; flag $00D1 set: jr to
; TalkMsg0A3F_TheKingAndPrinces.call_start_message_command09_hl_b132; flag $0122 set: jr to
; TalkMsg0A3F_TheKingAndPrinces.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0A3F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The King and Prince's chamber is' (E-0082)
TalkMsg0A3F_TheKingAndPrinces::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_KAMEHA_BACK
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a3f ; '*: The King and Prince's chamber'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0511 ; '*: Beyond here is his Majesty'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0544 ; '*: ……I can't eat another… Zzz…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0A41_ThisIsGreatLogCastle", ROMX

; Talk: 'You're today's guest of honor!' ($0545) after Darck's defeat until
; EVENT_THANKS_FOR_COMING_BY_025 is set; otherwise 'This is GreatLog Castle...' ($0A41). (C2,
; E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0A41, whose
; string begins 'This is GreatLog Castle. The reception' (E-0097)
Talk0A41_ThisIsGreatLogCastle::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0a41 ; '*: This is GreatLog Castle. The'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0545 ; '*: You're today's guest of honor!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A42_TheTavernJustOutsideTheCastle", ROMX

; Great Log talk 133 (GreatLogTalkEvents): starts message $0A42 ('The tavern just outside the Castle
; is') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A42 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The tavern just outside the Castle is' (E-0268, the E-0082 shape; was
; TalkMsg0A42_TheTavernJustOutsideTheCastle)
TalkMsg0A42_TheTavernJustOutsideTheCastle::
    ld hl, $0a42 ; '*: The tavern just outside the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A43_HeyWelcomeAllMastersAreWelcome", ROMX

; Great Log talk 134 (GreatLogTalkEvents): message $0B52 ('Ah, the savior of GreatLog!') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0A43 ('Hey, welcome! All masters are welcome
; here,'); both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0A43_HeyWelcomeAllMastersAreWelcome.call_start_message_command09_hl_b13); starts message
; $0A43 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Hey, welcome!
; All masters are welcome here,' (E-0268, the E-0082 shape; was
; TalkMsg0A43_HeyWelcomeAllMastersAreWelcome)
TalkMsg0A43_HeyWelcomeAllMastersAreWelcome::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a43 ; '*: Hey, welcome! All masters are'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b52 ; '*: Ah, the savior of GreatLog!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A44_WhenYouBreedNoticeANumber", ROMX

; Great Log talk 135 (GreatLogTalkEvents): starts message $0A44 ('When you breed, notice a number
; after') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A44 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'When you breed, notice a number after' (E-0268, the E-0082 shape; was
; TalkMsg0A44_WhenYouBreedNoticeANumber)
TalkMsg0A44_WhenYouBreedNoticeANumber::
    ld hl, $0a44 ; '*: When you breed, notice a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A45_IfYouWantToMakeA", ROMX

; Great Log talk 136 (GreatLogTalkEvents): starts message $0A45 ('If you want to make a certain')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A45 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'If you want to make a certain' (E-0268, the E-0082 shape; was TalkMsg0A45_IfYouWantToMakeA)
TalkMsg0A45_IfYouWantToMakeA::
    ld hl, $0a45 ; '*: If you want to make'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0A49_BreedingCouldResultIn", ROMX

; Talk (traveling merchant / scientist): before the three-items scene, the merchant's script
; (Script_I_10, screen table 1) until EVENT_BREEDING_COULD_RESULT_IN, then 'Breeding could result in
; monsters...' ($0A49); after it, the scientist's script (Script_I_11, screen table 3) until
; EVENT_BREEDING_COULD_RESULT_IN_125, then 'Hm... So that combination of...' ($0516). Saves the
; screen and the player's place first; the scripts set wDataBank $0E. (C1, E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0A49, whose
; string begins 'Breeding could result in monsters with' (E-0097)
Talk0A49_BreedingCouldResultIn::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_save_screen_buffer_to_bg_map1
    ld de, EVENT_BREEDING_COULD_RESULT_IN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $01
    ld [wScreenTableIndex], a
    ld hl, Script_I_10 ; script '*: I'm a traveling merchant. I'm'
    call StartScriptAtHL_B13
    ld a, $0e
    ld [wDataBank], a
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a49 ; '*: Breeding could result in monsters'
    call StartMessageCommand09HL_B13
    ret

.call_save_screen_buffer_to_bg_map1:
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, EVENT_BREEDING_COULD_RESULT_IN_125
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, $03
    ld [wScreenTableIndex], a
    ld hl, Script_I_11 ; script '*: I'm a scientist. I've been'
    call StartScriptAtHL_B13
    ld a, $0e
    ld [wDataBank], a
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0516 ; '*: Hm… So that combination of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A4A_FromUpHerePeople", ROMX

; Great Log talk 138 (GreatLogTalkEvents): message $0BB9 ('GreatLog appears to have returned') after
; EVENT_THANKS_FOR_COMING_BY_025, $0517 ('GreatLog is sinking I heard,') after
; EVENT_SCENE_THREE_ITEMS, otherwise $0A4A ('From up here people look like'); each through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A4A_FromUpHerePeople.call_start_message_command09_hl_b132; flag $0024 set: jp to
; TalkMsg0A4A_FromUpHerePeople.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0A4A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'From up here people look like' (E-0082)
TalkMsg0A4A_FromUpHerePeople::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a4a ; '*: From up here people look'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0517 ; '*: GreatLog is sinking I heard,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0bb9 ; '*: GreatLog appears to have returned'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_DrakScale", ROMX

; Great Log talk 139 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_DRAKSCALE and
; story flag $0126 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $47, story
; flag $0126 in DE: when the flag is clear it gives item $47 (DrakScale) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_DrakScale)
VaseItem_DrakScale::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $0126
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0A4C_GreatLogCastleWasMade", ROMX

; Great Log talk 140 (GreatLogTalkEvents): message $0BBB ('Ah, GreatLog's savior! Are you') after
; EVENT_THANKS_FOR_COMING_BY_025, $051F ('Right now, we are investigating') after
; EVENT_SCENE_THREE_ITEMS, otherwise $0A4C ('GreatLog Castle was made by hollowing'); each through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A4C_GreatLogCastleWasMade.call_start_message_command09_hl_b132; flag $0024 set: jp to
; TalkMsg0A4C_GreatLogCastleWasMade.call_start_message_command09_hl_b13); when none of them
; branches, starts message $0A4C through StartMessageCommand09HL_B13 (script command $09); that
; string begins 'GreatLog Castle was made by hollowing' (E-0082)
TalkMsg0A4C_GreatLogCastleWasMade::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a4c ; '*: GreatLog Castle was made by'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $051f ; '*: Right now, we are investigating'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0bbb ; '*: Ah, GreatLog's savior! Are you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A4D_TheIslandUsedTo", ROMX

; Great Log talk 141 (GreatLogTalkEvents): message $0BBC ('The island has become more') after
; EVENT_THANKS_FOR_COMING_BY_025, $0520 ('I've studied GreatLog over a') after
; EVENT_SCENE_THREE_ITEMS, otherwise $0A4D ('The island used to be lush'); each through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A4D_TheIslandUsedTo.call_start_message_command09_hl_b132; flag $0024 set: jr to
; TalkMsg0A4D_TheIslandUsedTo.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0A4D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The island used to be lush' (E-0082)
TalkMsg0A4D_TheIslandUsedTo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a4d ; '*: The island used to be'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0520 ; '*: I've studied GreatLog over a'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0bbc ; '*: The island has become more'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk04BA_IfYouGetAn", ROMX

; Talk: the 'Hm? Little one, are you...' script (screen table 2) until EVENT_IF_YOU_GET_AN, then 'If
; you get an EvilArmor,...' ($04BA); saves the screen and the player's place first. (C1, E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $04BA, whose
; string begins 'If you get an EvilArmor, I' (E-0097)
Talk04BA_IfYouGetAn::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, EVENT_IF_YOU_GET_AN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_HmLittleOneAre ; script '*: Hm? Little one, are you'
    call StartScriptAtHL_B13
    ld a, $02
    ld [wScreenTableIndex], a
    ld a, $0e
    ld [wDataBank], a
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04ba ; '*: If you get an EvilArmor,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk04CB_ThatKeyIUsed", ROMX

; Talk (the old key keeper): before EVENT_THANKS_FOR_COMING_BY_025, the 'I was once a great...'
; script (Script_IWasOnceA) until EVENT_YOU_11D, then 'That key, I used on...' ($04CB). After it:
; with EVENT_DESK_KEY_0C8 'There are still many things...' ($0BB4); with EVENT_DESK_KEY, the 'How
; good of you to...' script (Script_HowGoodOfYou, setting EVENT_THAT_KEY_IUSED_03E) once both
; EVENT_SCENE_CHEST_BATTLE and EVENT_SCENE_CHEST_BATTLE_207 are set, else 'Obtain the other key
; that...' ($0B4D); otherwise the first time 'I heard that you went...' ($0B4A, setting
; EVENT_THAT_KEY_IUSED), later the 'Oh! Goodness!' script (Script_OhGoodnessI) when
; Talk04CB_ThatKeyIUsed_CheckPartySpecies returns hTemp0 nonzero (a living party member is
; LordDraco, Genosidoh, AsuraZoma, PsychoPiz or Darck; with an empty party hTemp0 is left as it
; was), else 'Those monsters don't surprise me.' ($0B4B). (C2, E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5
; constant message(s) depending on story flags and state; the first one in the code is $04CB, whose
; string begins 'That key, I used on my' (E-0097)
Talk04CB_ThatKeyIUsed::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_YOU_11D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_IWasOnceA ; script '*: I was once a great'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04cb ; '*: That key, I used on'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_DESK_KEY_0C8
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_DESK_KEY
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_THAT_KEY_IUSED
    call TestFlagBit
    jr c, .call_talk04_cb_that_key_i_used_check_party
    ld hl, $0b4a ; '*: I heard that you went'
    call StartMessageCommand09HL_B13
    ld de, EVENT_THAT_KEY_IUSED
    call SetFlagBit
    ret

.call_talk04_cb_that_key_i_used_check_party:
    farcall Talk04CB_ThatKeyIUsed_CheckPartySpecies
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_script_at_hl_b13
    ld hl, $0b4b ; '*: Those monsters don't surprise me.'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_OhGoodnessI ; script '*: Oh! Goodness! I'm surprised! I've'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_SCENE_CHEST_BATTLE
    call TestFlagBit
    jr nc, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_CHEST_BATTLE_207
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132

.call_start_message_command09_hl_b132:
    ld hl, $0b4d ; '*: Obtain the other key that'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_HowGoodOfYou ; script '*: How good of you to'
    call StartScriptAtHL_B13
    ld de, EVENT_THAT_KEY_IUSED_03E
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0bb4 ; '*: There are still many things'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk04CE_HeroCheckedTheShelf", ROMX

; Checking the shelf: after EVENT_HERO_CHECKED_THE_SHELF 'Souvenirs from...' ($04CC); otherwise
; tries a new key (GenerateNewKeyEntry): got one, '0 obtained...' ($04CD) and the flag is set; else
; '0 found...' ($04CE). (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $04CE, whose
; string begins '0 checked the shelf. 0 found' (E-0097)
Talk04CE_HeroCheckedTheShelf::
    ld de, EVENT_HERO_CHECKED_THE_SHELF
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, $04ce ; '0 checked the shelf. 0 found'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04cd ; '0 checked the shelf. 0 obtained'
    call StartMessageCommand09HL_B13
    ld de, EVENT_HERO_CHECKED_THE_SHELF
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $04cc ; '0 checked the shelf. Souvenirs from'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04CF_HeroPeeredIntoTheVaseIt", ROMX

; Great Log talk 145 (GreatLogTalkEvents): starts message $04CF ('<BUF0> peered into the vase. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04CF through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg04CF_HeroPeeredIntoTheVaseIt)
TalkMsg04CF_HeroPeeredIntoTheVaseIt::
    ld hl, $04cf ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowItsExcitingToThink", ROMX

; Great Log talk, the Key Shop (scripts in bank $0D): 'It's exciting to think where ...' ($0DC2)
; when wGreatLogEventFlag is 1; otherwise saves the screen, 'Welcome to my Key Shop!' once then the
; shop, and at the end 'You're GreatLog's savior!' once. (C1, E-0357)
GreatLogTalkEvents_ShowItsExcitingToThink::
    ld a, [wGreatLogEventFlag]
    cp $01
    jr nz, .call_save_screen_buffer_to_bg_map1
    ld hl, $0dc2 ; '*: It's exciting to think where'
    call StartMessageCommand09HL_B13
    ret

.call_save_screen_buffer_to_bg_map1:
    farcall SaveScreenBufferToBGMap1
    ld a, $0d
    ld [wDataBank], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_WELCOME_TO_MY_KEY
    call TestFlagBit
    jr c, .loop
    ld hl, Script_WelcomeToMyKey ; script '*: Welcome to my Key Shop!'
    call StartScriptAtHL_B13
    ld de, EVENT_WELCOME_TO_MY_KEY
    call SetFlagBit
    ret

.loop:
    ld hl, Script_WelcomeToMyKey_2 ; script '*: Welcome to my Key Shop!'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_YOU
    call TestFlagBit
    jr c, .loop
    ld hl, Script_You_7 ; script '*: You're GreatLog's savior! Do you'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0299_ImApprenticingUnderTheBoss", ROMX

; Great Log talk 147 (GreatLogTalkEvents): starts message $0299 ('I'm apprenticing under the boss.
; He told') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0299 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I'm apprenticing under the boss. He told' (E-0268, the E-0082 shape; was
; TalkMsg0299_ImApprenticingUnderTheBoss)
TalkMsg0299_ImApprenticingUnderTheBoss::
    ld hl, $0299 ; '*: I'm apprenticing under the boss.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg029A_DayAfterDayIExamineKeys", ROMX

; Great Log talk 148 (GreatLogTalkEvents): starts message $029A ('Day after day, I examine keys.
; But') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $029A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Day after day, I examine keys. But' (E-0268, the E-0082 shape; was
; TalkMsg029A_DayAfterDayIExamineKeys)
TalkMsg029A_DayAfterDayIExamineKeys::
    ld hl, $029a ; '*: Day after day, I examine'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_NothingToSay", ROMX

; Returns at once (a Great Log talk with nothing to say). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_NothingToSay::
    ret

SECTION "Bank 13 TalkMsg0504_IfTheIslandSink", ROMX

; Great Log talk 152 (GreatLogTalkEvents): message $0B05 ('This rope, it was not') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0504 ('If the island sink, is no'); both through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jp to
; TalkMsg0504_IfTheIslandSink.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0504 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'If the island sink, is no' (E-0082)
TalkMsg0504_IfTheIslandSink::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0504 ; '*: If the island sink, is'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b05 ; '*: This rope, it was not'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0512_KamehaYoHeroThanks", ROMX

; Great Log talk 153 (GreatLogTalkEvents), Kameha. Before EVENT_THANKS_FOR_COMING_BY_025: message
; $053E ('Kameha: I couldn't do anything, so') after EVENT_SCENE_DARCK_DEFEATED, else $0512
; ('Kameha: Yo, <BUF0>. Thanks for coming.'). After it, two rounds, the second after
; EVENT_HERO_RECEIVED_THE_ELF_KEY: after its key battle flag (EVENT_SCENE_KAMEHA_KEY_BATTLE, then
; EVENT_SCENE_KAMEHA_KEY_BATTLE2) Kameha gives a key of kind 7 (round 2: kind 9): when that kind is
; already in wKeyList a random one (GenerateNewKeyEntry, Script_KamehaWhatOhIt_2/_4); otherwise,
; with room, WriteKeyEntryTemp0 writes kind 7 or 9 to the next free entry, with bit 6 set ($47/$49)
; after EVENT_KEY_BOSS_BEATEN_203 / EVENT_KEY_BOSS_BEATEN_2_205, and starts Script_KamehaWhatOhIt /
; _3; a full key list gives message $0B96 ('Kameha: What? Oh, it's <BUF0>. Did'). Before the battle
; flag: Script_KamehaI / _2 ('Kameha: I've gone to other worlds') when TotalSpeciesFlaggedOrListed
; reaches 50 (round 2: 150), else $0D92 ('Kameha: I think I have the') or $0B98 ('Kameha: Watch me,
; I'm going to'). After EVENT_HERO_RECEIVED_THE_TRAVELER_KEY, message $0B98. Messages go through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0512_KamehaYoHeroThanks.call_test_flag_bit; flag $00D1 set: jr to
; TalkMsg0512_KamehaYoHeroThanks.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0512 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Kameha Yo, 0. Thanks for coming.' (E-0082) (E-0324: was TalkMsg0512_KamehaYoHeroThanks; read
; before $42 was known as 'v)
TalkMsg0512_KamehaYoHeroThanks::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0512 ; 'Kameha: Yo, 0. Thanks for coming.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $053e ; 'Kameha: I couldn't do anything, so'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_HERO_RECEIVED_THE_ELF_KEY
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld de, EVENT_SCENE_KAMEHA_KEY_BATTLE
    call TestFlagBit
    jr c, .set_temp0_to_07
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b13
    ldh a, [hTemp0]
    cp $32
    jr nc, .call_start_script_at_hl_b13
    ld hl, $0d92 ; 'Kameha: I think I have the'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_KamehaI ; script 'Kameha: I've gone to other worlds'
    call StartScriptAtHL_B13
    ret

.set_temp0_to_07:
    ld a, $07
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_07

.loop:
    ld hl, $0b96 ; 'Kameha: What? Oh, it's 0. Did'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_07:
    ld a, $07
    ldh [hTemp1], a
    ld de, EVENT_KEY_BOSS_BEATEN_203
    call TestFlagBit
    jr nc, .call_write_key_entry_temp0
    ld a, $47
    ldh [hTemp1], a

.call_write_key_entry_temp0:
    farcall WriteKeyEntryTemp0
    ld hl, Script_KamehaWhatOhIt ; script 'Kameha: What? Oh, it's 0. Did'
    call StartScriptAtHL_B13
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop
    ld hl, Script_KamehaWhatOhIt_2 ; script 'Kameha: What? Oh, it's 0. Did'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_HERO_RECEIVED_THE_TRAVELER_KEY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_KAMEHA_KEY_BATTLE2
    call TestFlagBit
    jr c, .set_temp0_to_09
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .call_start_script_at_hl_b132
    ldh a, [hTemp0]
    cp $96
    jr nc, .call_start_script_at_hl_b132
    ld hl, $0b98 ; 'Kameha: Watch me, I'm going to'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_KamehaI_2 ; script 'Kameha: I've gone to other worlds'
    call StartScriptAtHL_B13
    ret

.set_temp0_to_09:
    ld a, $09
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry2
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_09

.loop2:
    ld hl, $0b96 ; 'Kameha: What? Oh, it's 0. Did'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_09:
    ld a, $09
    ldh [hTemp1], a
    ld de, EVENT_KEY_BOSS_BEATEN_2_205
    call TestFlagBit
    jr nc, .call_write_key_entry_temp02
    ld a, $49
    ldh [hTemp1], a

.call_write_key_entry_temp02:
    farcall WriteKeyEntryTemp0
    ld hl, Script_KamehaWhatOhIt_3 ; script 'Kameha: What? Oh, it's 0. Did'
    call StartScriptAtHL_B13
    ret

.call_generate_new_key_entry2:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop2
    ld hl, Script_KamehaWhatOhIt_4 ; script 'Kameha: What? Oh, it's 0. Did'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b98 ; 'Kameha: Watch me, I'm going to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_LifeAcorn_Flag011B", ROMX

; Great Log talk 154 (GreatLogTalkEvents), a one-time chest: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_LIFEACORN
; and story flag $011B in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $11, story flag $011B in DE: when the flag is clear it gives item $11 (LifeAcorn) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LifeAcorn_Flag011B)
ChestItem_LifeAcorn_Flag011B::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $011b
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_Quest", ROMX

; Great Log talk 155 (GreatLogTalkEvents), a one-time chest: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_QUEST and
; story flag $011C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A0),
; shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $13, story flag $011C in DE: when the flag is clear it gives item $13 (Quest) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Quest)
ChestItem_Quest::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $13
    ld [wScriptParam1], a
    ld de, $011c
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 Talk04C0_AllRightyWellDo", ROMX

; Talk: the 'Yo! Up close, you look...' script (screen table 4) until EVENT_ALL_RIGHTY_WELL_DO, then
; 'All righty! We'll do this...' ($04C0); saves the screen and the player's place first. (C1,
; E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $04C0, whose
; string begins 'All righty! We'll do this again' (E-0097)
Talk04C0_AllRightyWellDo::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, EVENT_ALL_RIGHTY_WELL_DO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, Script_YoUpCloseYou ; script '*: Yo! Up close, you look'
    call StartScriptAtHL_B13
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $0e
    ld [wDataBank], a
    ret

.call_start_message_command09_hl_b13:
    ld hl, $04c0 ; '*: All righty! We'll do this'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0276_IfYouWantTo", ROMX

; Arena desk: 'If you want to enter,...' ($0276) at arena rank 0; the 'Welcome to the Arena!' script
; at ranks 1-4 (Script_WelcomeToTheArena_3) and at rank 5 (Script_WelcomeToTheArena_4). (C2, E-0357;
; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0276, whose
; string begins 'If you want to enter, please' (E-0097)
Talk0276_IfYouWantTo::
    ld a, [wArenaRank]
    cp $05
    jr z, .call_start_script_at_hl_b132
    or a
    jr nz, .call_start_script_at_hl_b13
    ld hl, $0276 ; '*: If you want to enter,'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WelcomeToTheArena_3 ; script '*: Welcome to the Arena! Would'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_WelcomeToTheArena_4 ; script '*: Welcome to the Arena! Would'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk_SlimeEncounter", ROMX

; Great Log talk 159 (GreatLogTalkEvents): starts Script_Encounter through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is a
; single script_encounter command (encounter words $1A: Slime, Slime, Slime). (C2, E-0377)
; starts Script_Encounter (StartScriptAtHL_B13) (E-0271; was Talk_SlimeEncounter) (E-0344: the
; address in its name dropped or read as the label there; was Talk_SlimeEncounter; named after the
; script it starts, Script_Encounter, which is script_encounter $1A: Slime, Slime, Slime)
; starts Script_Encounter (E-0248)
Talk_SlimeEncounter::
    ld hl, Script_Encounter
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_CongratulationsAfterDarck", ROMX

; Great Log talk 158 (GreatLogTalkEvents): returns at once until EVENT_SCENE_DARCK_DEFEATED is set;
; then starts Script_TaraHeroCongratulationsI ('Tara: <BUF0>, congratulations! I was sad'), or
; Script_CobiHeroCongratulationsI ('Cobi: <BUF0>, congratulations!') when EVENT_NEVER_SET (flag 0)
; is set; either through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest
; = $80, wModeState = 1). (C2, E-0377)
; map event: with story flag $D1 set, starts script $56F5 if flag 0 is set, else $5709 (E-0122)
; (E-0344: the address in its name dropped or read as the label there; was
; GreatLogTalkEvents_CongratulationsAfterDarck)
GreatLogTalkEvents_CongratulationsAfterDarck::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_TaraHeroCongratulationsI ; script 'Tara: 0, congratulations! I was sad'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_CobiHeroCongratulationsI ; script 'Cobi: 0, congratulations! I thought we'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0024_HeroCheckedTheDresserChildrens", ROMX

; Great Log talk 160 (GreatLogTalkEvents): starts message $0024 ('<BUF0> checked the dresser.
; Children's clothes were') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0024 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. Children's clothes were' (E-0268, the E-0082 shape; was
; TalkMsg0024_HeroCheckedTheDresserChildrens)
TalkMsg0024_HeroCheckedTheDresserChildrens::
    ld hl, $0024 ; '0 checked the dresser. Children's clothes'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0025_HeroCheckedTheDresserItSmelled", ROMX

; Great Log talk 161 (GreatLogTalkEvents): starts message $0025 ('<BUF0> checked the dresser. It
; smelled of') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0025 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the dresser. It smelled of' (E-0268, the E-0082 shape; was
; TalkMsg0025_HeroCheckedTheDresserItSmelled)
TalkMsg0025_HeroCheckedTheDresserItSmelled::
    ld hl, $0025 ; '0 checked the dresser. It smelled'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg001D_HeroPeeredIntoTheBarrelIt", ROMX

; Great Log talk 162 (GreatLogTalkEvents): starts message $001D ('<BUF0> peered into the barrel. It
; is') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $001D through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the barrel. It is' (E-0268, the E-0082 shape; was
; TalkMsg001D_HeroPeeredIntoTheBarrelIt)
TalkMsg001D_HeroPeeredIntoTheBarrelIt::
    ld hl, $001d ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg001C_HeroCheckedThePumpItsRusted", ROMX

; Great Log talk 163 (GreatLogTalkEvents): starts message $001C ('<BUF0> checked the pump. It's
; rusted and') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $001C through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the pump. It's rusted and' (E-0268, the E-0082 shape; was
; TalkMsg001C_HeroCheckedThePumpItsRusted)
TalkMsg001C_HeroCheckedThePumpItsRusted::
    ld hl, $001c ; '0 checked the pump. It's rusted'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Healer", ROMX

; Great Log talk, a healer: fully heals the party, moves fallen members to the back and reloads the
; names and sprites. (C1, E-0357)
GreatLogTalkEvents_Healer::
    farcall FullyHealParty
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

SECTION "Bank 13 TalkMsg0037_HeroTriedToOpenTheChest_13", ROMX

; Great Log talk 165 (GreatLogTalkEvents): starts message $0037 ('<BUF0> tried to open the chest.
; But') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). Talk0037_HeroTriedToOpen (talk
; 171) shows the same message only when a screen tile matches. (C2, E-0377)
; starts message $0037 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0037_HeroTriedToOpenTheChest_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0037_HeroTriedToOpenTheChest_13)
TalkMsg0037_HeroTriedToOpenTheChest_13::
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Shop", ROMX

; Great Log talk, a shop: shop $17 with scripts in bank $10, 'Hello! What can I do ...'. (C2,
; E-0357; probed E-0377)
GreatLogTalkEvents_Shop::
    ld a, $17
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_HelloWhatCanI ; script '*: Hello! What can I do'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowTerryHereJustTake", ROMX

; Great Log talk, Terry: gives 10,000 gold (AddGoldCapped) with 'Here, just take this. <hero> ...'
; ($00FE). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowTerryHereJustTake::
    ld hl, $2710
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $00fe ; 'Terry: Here, just take this. 0'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0D4E_ImDiggingHereBecauseIThink", ROMX

; Great Log talk 168 (GreatLogTalkEvents): starts message $0D4E ('I'm digging here because I think
; this') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0D4E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I'm digging here because I think this' (E-0268, the E-0082 shape; was
; TalkMsg0D4E_ImDiggingHereBecauseIThink)
TalkMsg0D4E_ImDiggingHereBecauseIThink::
    ld hl, $0d4e ; '*: I'm digging here because I'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0043_HeroCheckedTheOdd", ROMX

; The odd object: '0 checked the odd object...' ($0043) before the Warubou food scene and after
; EVENT_THANKS_FOR_COMING_BY_025; nothing in between. (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0043, whose
; string begins '0 checked the odd object. It' (E-0097)
Talk0043_HeroCheckedTheOdd::
    ld de, EVENT_SCENE_WARUBOU_FOOD2
    call TestFlagBit
    jr nc, .call_start_message_command09_hl_b13
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    ret nc

.call_start_message_command09_hl_b13:
    ld hl, $0043 ; '0 checked the odd object. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0036_ThereWereManyWild", ROMX

; Talk: 'There were many wild monsters...' ($0036) at first and after
; EVENT_THANKS_FOR_COMING_BY_025; after the Warubou food scene 'The island is sinking? Hahah,...'
; ($0076), after the long-faces scene 'They say you use Magic...' ($0D00), after the three-items
; scene 'When things are tough, you...' ($050A). (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4
; constant message(s) depending on story flags and state; the first one in the code is $0036, whose
; string begins 'There were many wild monsters in' (E-0097)
Talk0036_ThereWereManyWild::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b134
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0036 ; '*: There were many wild monsters'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0076 ; '*: The island is sinking? Hahah,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0d00 ; '*: They say you use Magic'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b134:
    ld hl, $050a ; '*: When things are tough, you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0037_HeroTriedToOpen", ROMX

; The chest: '0 tried to open the chest.' ($0037) when the tile at screen buffer $D2 is $1A. (C2,
; E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0037, whose
; string begins '0 tried to open the chest.' (E-0097)
Talk0037_HeroTriedToOpen::
    ld a, [wScreenTileBuffer + $d2]
    cp $1a
    ret nz
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_TravelingMerchant", ROMX

; Great Log talk 172 (GreatLogTalkEvents): sets wScreenTableIndex = 1, starts Script_I_10 ('I'm a
; traveling merchant.') through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1), then sets wDataBank = $0E; the same start as the first
; branch of Talk0A49_BreedingCouldResultIn, without its flag tests. (C2, E-0377)
; wScreenTableIndex = 1, StartScriptAtHL_B13 with HL = $5660, then wDataBank = $0E (E-0119) (E-0344:
; the address in its name dropped or read as the label there; was
; GreatLogTalkEvents_TravelingMerchant)
; starts Script_I_10: '*: I'm a traveling merchant. I'm' (E-0248)
GreatLogTalkEvents_TravelingMerchant::
    ld a, $01
    ld [wScreenTableIndex], a
    ld hl, Script_I_10 ; script '*: I'm a traveling merchant. I'm'
    call StartScriptAtHL_B13
    ld a, $0e
    ld [wDataBank], a
    ret

SECTION "Bank 13 TalkMsg0268_YepShesTakingGood", ROMX

; Great Log talk 173 (GreatLogTalkEvents): message $0B48 ('My master has gotten good.') after
; EVENT_THANKS_FOR_COMING_BY_025, $0529 ('Grandpa and the others are') after
; EVENT_SCENE_THREE_ITEMS, otherwise $0268 ('Yep, she's taking good care of'); each through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0268_YepShesTakingGood.call_start_message_command09_hl_b132; flag $0024 set: jr to
; TalkMsg0268_YepShesTakingGood.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0268 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Yep, she's taking good care of' (E-0082)
TalkMsg0268_YepShesTakingGood::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0268 ; '*: Yep, she's taking good care'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0529 ; '*: Grandpa and the others are'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b48 ; '*: My master has gotten good.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg022E_SnivelThisBookIsSoSad", ROMX

; Great Log talk 174 (GreatLogTalkEvents): starts message $022E ('Snivel... This book is so')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $022E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Snivel This book is so sad' (E-0268, the E-0082 shape; was TalkMsg022E_SnivelThisBookIsSoSad)
TalkMsg022E_SnivelThisBookIsSoSad::
    ld hl, $022e ; '*: Snivel… This book is so'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg022F_EvenICanCastSpellsIf", ROMX

; Great Log talk 175 (GreatLogTalkEvents): starts message $022F ('Even I can cast spells if I')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $022F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Even I can cast spells if I' (E-0268, the E-0082 shape; was TalkMsg022F_EvenICanCastSpellsIf)
TalkMsg022F_EvenICanCastSpellsIf::
    ld hl, $022f ; '*: Even I can cast spells'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0242_MyDadsAFamousMonsterMaster", ROMX

; Great Log talk 176 (GreatLogTalkEvents): message $0B33 ('Papa is a famous monster') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0242 ('My dad's a famous monster master. I'm');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg0242_MyDadsAFamousMonsterMaster.call_start_message_command09_hl_b13); starts message $0242
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'My dad's a famous
; monster master. I'm' (E-0268, the E-0082 shape; was TalkMsg0242_MyDadsAFamousMonsterMaster)
TalkMsg0242_MyDadsAFamousMonsterMaster::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0242 ; '*: My dad's a famous monster'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b33 ; '*: Papa is a famous monster'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg02B1_HeroPeeredIntoTheOvenIt", ROMX

; Great Log talk 177 (GreatLogTalkEvents): starts message $02B1 ('<BUF0> peered into the oven. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). Great Log talk 200
; (TalkMsg02B1_HeroPeeredIntoTheOvenIt_13) is an identical copy. (C2, E-0377)
; starts message $02B1 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It was' (E-0268, the E-0082 shape; was
; TalkMsg02B1_HeroPeeredIntoTheOvenIt)
TalkMsg02B1_HeroPeeredIntoTheOvenIt::
    ld hl, $02b1 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_WantToKnowHow", ROMX

; Great Log talk: 'Want to know how the ...' in three scripts by progress (after the rival, after
; the mermaid kingdom). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_WantToKnowHow::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_script_at_hl_b132
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_start_script_at_hl_b13
    ld hl, Script_WantToKnowHow ; script '*: Want to know how the'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_WantToKnowHow_2 ; script '*: Want to know how the'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b132:
    ld hl, Script_WantToKnowHow_3 ; script '*: Want to know how the'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg02A6_PuttingUpABridgeIsEasy", ROMX

; Great Log talk 179 (GreatLogTalkEvents): message $0B07 ('A world with lots of') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $02A6 ('Putting up a bridge is easy!'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg02A6_PuttingUpABridgeIsEasy.call_start_message_command09_hl_b13); starts message $02A6
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Putting up a bridge
; is easy!' (E-0268, the E-0082 shape; was TalkMsg02A6_PuttingUpABridgeIsEasy)
TalkMsg02A6_PuttingUpABridgeIsEasy::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $02a6 ; '*: Putting up a bridge is'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b07 ; '*: A world with lots of'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0209_DidYouKnowYouCanRecord", ROMX

; Great Log talk 180 (GreatLogTalkEvents): message $0B09 ('Listen, even in other worlds,') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0209 ('Did you know? You can record in'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jp c,
; TalkMsg0209_DidYouKnowYouCanRecord.call_start_message_command09_hl_b13); starts message $0209
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Did you know? You
; can record in' (E-0268, the E-0082 shape; was TalkMsg0209_DidYouKnowYouCanRecord)
TalkMsg0209_DidYouKnowYouCanRecord::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0209 ; '*: Did you know? You can'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b09 ; '*: Listen, even in other worlds,'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A51_WhenAAppearsByAMonsters", ROMX

; Great Log talk 181 (GreatLogTalkEvents): starts message $0A51 ('When a', then a star mark,
; 'appears by a monster's level') through StartMessageCommand09HL_B13 (script command 9 with the
; word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A51 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'When a appears by a monster's level' (E-0268, the E-0082 shape; was
; TalkMsg0A51_WhenAAppearsByAMonsters)
; starts Script_DoYouWantTo: '*: Do you want to know' (E-0248)
TalkMsg0A51_WhenAAppearsByAMonsters::
    ld hl, $0a51 ; '*: When a ★ appears by'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_DoYouWantToKnowHow", ROMX

; Great Log talk 182 (GreatLogTalkEvents): starts Script_DoYouWantTo ('Do you want to know') through
; StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0377)
; starts Script_DoYouWantTo (StartScriptAtHL_B13); its first message begins 'Do you want to know
; how' (E-0271; was Talk_DoYouWantToKnowHow) (E-0344: the address in its name dropped or read as the
; label there; was Talk_DoYouWantToKnowHow; shortened from TalkScript_DoYouWantToKnowHow)
; starts Script_DoYouWantTo: '*: Do you want to know' (E-0248)
Talk_DoYouWantToKnowHow::
    ld hl, Script_DoYouWantTo ; script '*: Do you want to know'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk08D1_TheEvaluatorSaidI", ROMX

; Talk (the farm helper): 'The Evaluator said I had...' ($08D1) until EVENT_THANKS_FOR_COMING_BY_025
; and once EVENT_GIVE_MONSTER is set; in between the 'Hello, hero! Let me help' script, the second
; version when the farm is not at its limit (wArg5 not $FF after
; ClearArg5IfAtOrAboveLimitForFarmLevel). (C2, E-0357; probed E-0384)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $08D1, whose
; string begins 'The Evaluator said I had an' (E-0097)
Talk08D1_TheEvaluatorSaidI::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_test_flag_bit

.loop:
    ld hl, $08d1 ; '*: The Evaluator said I had'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_GIVE_MONSTER
    call TestFlagBit
    jr c, .loop
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .call_start_script_at_hl_b13
    ld hl, Script_HelloHeroLetMe ; script '*: Hello, hero! Let me help'
    call StartScriptAtHL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HelloHeroLetMe_2 ; script '*: Hello, hero! Let me help'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 Talk04D2_UpAheadIsThe", ROMX

; Talk: 'Up ahead is the Starry...' ($04D2 at arena rank 0, $0D0C later); after the mermaid kingdom
; scene 'Go down these stairs to...' ($08D2); after EVENT_THANKS_FOR_COMING_BY_025 'The Evaluator's
; singing is magic.' ($0B25). (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4
; constant message(s) depending on story flags and state; the first one in the code is $04D2, whose
; string begins 'Up ahead is the Starry Shrine' (E-0097)
Talk04D2_UpAheadIsThe::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld a, [wArenaRank]
    or a
    jr nz, .call_start_message_command09_hl_b13
    ld hl, $04d2 ; '*: Up ahead is the Starry'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0d0c ; '*: Up ahead is the Starry'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $08d2 ; '*: Go down these stairs to'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b25 ; '*: The Evaluator's singing is magic.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg021F_DoYouKnowAbout", ROMX

; Great Log talk 185 (GreatLogTalkEvents): message $0B12 ('A bard demanded to battle') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $021F ('Do you know about LogTwig? It's'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg021F_DoYouKnowAbout.call_start_message_command09_hl_b13); when none of them branches,
; starts message $021F through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Do you know about LogTwig? It's' (E-0082)
TalkMsg021F_DoYouKnowAbout::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $021f ; '*: Do you know about LogTwig?'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b12 ; '*: A bard demanded to battle'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0220_InOtherWorldsYoull", ROMX

; Great Log talk 186 (GreatLogTalkEvents): message $0B13 ('I just happened to come') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0220 ('In other worlds, you'll meet other');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). Great Log talk 235
; (TalkMsg0220_InOtherWorldsYoull_2) is an identical copy. (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0220_InOtherWorldsYoull.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'In other worlds, you'll meet other' (E-0082)
TalkMsg0220_InOtherWorldsYoull::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0220 ; '*: In other worlds, you'll meet'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b13 ; '*: I just happened to come'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg027F_ItsNotEasyTo", ROMX

; Great Log talk 187 (GreatLogTalkEvents): message $0B76 ('Have you become a pro') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $027F ('It's not easy to win right'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg027F_ItsNotEasyTo.call_start_message_command09_hl_b13); when none of them branches, starts
; message $027F through StartMessageCommand09HL_B13 (script command $09); that string begins 'It's
; not easy to win right' (E-0082)
TalkMsg027F_ItsNotEasyTo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $027f ; '*: It's not easy to win'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b76 ; '*: Have you become a pro'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0280_MamaIsABig", ROMX

; Great Log talk 188 (GreatLogTalkEvents): message $0B77 ('My Mama gets so ahead') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0280 ('Mama is a big worrier...'); both through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0280_MamaIsABig.call_start_message_command09_hl_b13); when none of them branches, starts
; message $0280 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Mama
; is a big worrier But' (E-0082)
TalkMsg0280_MamaIsABig::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0280 ; '*: Mama is a big worrier…'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b77 ; '*: My Mama gets so ahead'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0284_IComeToWatchEveryDay", ROMX

; Great Log talk 189 (GreatLogTalkEvents): starts message $0284 ('I come to watch every day. The')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0284 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I come to watch every day. The' (E-0268, the E-0082 shape; was TalkMsg0284_IComeToWatchEveryDay)
TalkMsg0284_IComeToWatchEveryDay::
    ld hl, $0284 ; '*: I come to watch every'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0285_MonstersMirrorTheirMasters", ROMX

; Great Log talk 190 (GreatLogTalkEvents): starts message $0285 ('Monsters mirror their masters. The
; plans you') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0285 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Monsters mirror their masters. The plans you' (E-0268, the E-0082 shape; was
; TalkMsg0285_MonstersMirrorTheirMasters)
TalkMsg0285_MonstersMirrorTheirMasters::
    ld hl, $0285 ; '*: Monsters mirror their masters. The'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0288_MyHusbandIsAMasterStill", ROMX

; Great Log talk 191 (GreatLogTalkEvents): starts message $0288 ('My husband is a master still. He')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0288 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'My husband is a master still. He' (E-0268, the E-0082 shape; was
; TalkMsg0288_MyHusbandIsAMasterStill)
; starts Script_HelloThereDoYou: '*: Hello there. Do you know' (E-0248)
TalkMsg0288_MyHusbandIsAMasterStill::
    ld hl, $0288 ; '*: My husband is a master'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk_HelloThereDoYouKnowAbout", ROMX

; Great Log talk 192 (GreatLogTalkEvents): starts Script_HelloThereDoYou ('Hello there. Do you
; know') through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1). (C2, E-0377)
; starts Script_HelloThereDoYou (StartScriptAtHL_B13); its first message begins 'Hello there. Do you
; know about' (E-0271; was Talk_HelloThereDoYouKnowAbout) (E-0344: the address in its name dropped
; or read as the label there; was Talk_HelloThereDoYouKnowAbout; shortened from
; TalkScript_HelloThereDoYouKnowAbout)
; starts Script_HelloThereDoYou: '*: Hello there. Do you know' (E-0248)
Talk_HelloThereDoYouKnowAbout::
    ld hl, Script_HelloThereDoYou ; script '*: Hello there. Do you know'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 TalkMsg0293_IfYouWinInTheS", ROMX

; Great Log talk 193 (GreatLogTalkEvents): starts message $0293 ('If you win in the S Class,')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0293 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'If you win in the S Class,' (E-0268, the E-0082 shape; was TalkMsg0293_IfYouWinInTheS)
TalkMsg0293_IfYouWinInTheS::
    ld hl, $0293 ; '*: If you win in the'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0295_InAnArenaBattleYouCant", ROMX

; Great Log talk 194 (GreatLogTalkEvents): starts message $0295 ('In an Arena battle, you can't
; command') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0295 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'In an Arena battle, you can't command' (E-0268, the E-0082 shape; was
; TalkMsg0295_InAnArenaBattleYouCant)
TalkMsg0295_InAnArenaBattleYouCant::
    ld hl, $0295 ; '*: In an Arena battle, you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg027B_WhichToTakeMonstersYouve", ROMX

; Great Log talk 195 (GreatLogTalkEvents): message $0B68 ('Monsters that are caught at') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $027B ('Which to take? Monsters you've raised,');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg027B_WhichToTakeMonstersYouve.call_start_message_command09_hl_b13); starts message $027B
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'Which to take?
; Monsters you've raised,' (E-0268, the E-0082 shape; was TalkMsg027B_WhichToTakeMonstersYouve)
; (E-0324: was TalkMsg027B_WhichToTakeMonstersYouve; read before $42 was known as 'v)
TalkMsg027B_WhichToTakeMonstersYouve::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $027b ; '*: Which to take? Monsters you've'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b68 ; '*: Monsters that are caught at'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg027C_YouNeedLuckOnYourSide", ROMX

; Great Log talk 196 (GreatLogTalkEvents): message $0B69 ('When you're at the pro') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $027C ('You need luck on your side to'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags (flag 0025 then jr c,
; TalkMsg027C_YouNeedLuckOnYourSide.call_start_message_command09_hl_b13); starts message $027C
; through StartMessageCommand09HL_B13 (script command $09); that string begins 'You need luck on
; your side to' (E-0268, the E-0082 shape; was TalkMsg027C_YouNeedLuckOnYourSide)
TalkMsg027C_YouNeedLuckOnYourSide::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $027c ; '*: You need luck on your'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b69 ; '*: When you're at the pro'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg029C_HeroPeeredIntoTheOvenIt", ROMX

; Great Log talk 197 (GreatLogTalkEvents): starts message $029C ('<BUF0> peered into the oven. It
; greedily') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $029C through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It greedily' (E-0268, the E-0082 shape; was
; TalkMsg029C_HeroPeeredIntoTheOvenIt)
TalkMsg029C_HeroPeeredIntoTheOvenIt::
    ld hl, $029c ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg029D_HeroPeeredIntoTheVaseIt", ROMX

; Great Log talk 198 (GreatLogTalkEvents): starts message $029D ('<BUF0> peered into the vase. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $029D through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg029D_HeroPeeredIntoTheVaseIt)
TalkMsg029D_HeroPeeredIntoTheVaseIt::
    ld hl, $029d ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_TinyMedal_Flag0132", ROMX

; Great Log talk 199 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL and
; story flag $0132 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $0132 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag0132)
VaseItem_TinyMedal_Flag0132::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0132
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg02B1_HeroPeeredIntoTheOvenIt_13", ROMX

; Great Log talk 200 (GreatLogTalkEvents): starts message $02B1 ('<BUF0> peered into the oven. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). An identical copy of Great Log
; talk 177 (TalkMsg02B1_HeroPeeredIntoTheOvenIt). (C2, E-0377)
; starts message $02B1 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the oven. It was' (E-0268, the E-0082 shape; was
; TalkMsg02B1_HeroPeeredIntoTheOvenIt_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg02B1_HeroPeeredIntoTheOvenIt_13)
TalkMsg02B1_HeroPeeredIntoTheOvenIt_13::
    ld hl, $02b1 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0225_HeroPeeredIntoTheVaseThere", ROMX

; Great Log talk 201 (GreatLogTalkEvents): starts message $0225 ('<BUF0> peered into the vase. There
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0225 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. There was' (E-0268, the E-0082 shape; was
; TalkMsg0225_HeroPeeredIntoTheVaseThere)
TalkMsg0225_HeroPeeredIntoTheVaseThere::
    ld hl, $0225 ; '0 peered into the vase. There'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 VaseItem_TinyMedal_Flag0130", ROMX

; Great Log talk 202 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL and
; story flag $0130 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $0130 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag0130)
VaseItem_TinyMedal_Flag0130::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0130
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg024A_HeroCheckedThePlushDollIt", ROMX

; Great Log talk 203 (GreatLogTalkEvents): starts message $024A ('<BUF0> checked the plush doll. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $024A through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the plush doll. It was' (E-0268, the E-0082 shape; was
; TalkMsg024A_HeroCheckedThePlushDollIt)
TalkMsg024A_HeroCheckedThePlushDollIt::
    ld hl, $024a ; '0 checked the plush doll. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Talk204", ROMX

; Great Log talk 204: far-calls GreatLogTalkEvents_Talk204_PassCheck, which clears hTemp1, so the
; bit-7 test never returns early: sets the tile action to 0 and runs the strongest-master scene
; script. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Talk204::
    farcall GreatLogTalkEvents_Talk204_PassCheck
    ldh a, [hTemp1]
    bit 7, a
    ret nz
    ld [wTileActionKind], a
    ld hl, Script_SceneStrongestMaster
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowHereItIstheTinyMedal", ROMX

; Great Log talk: after EVENT_REWARD_ITEM_OR_KEY_2_1A5 and before receiving it, a TinyMedal (item
; $2C) with 'Here it is-the TinyMedal.' (or $0D45 when the bag is full); otherwise 'Hup, hup, hup!'
; ($0D26), or 'When master's shop starts making ...' ($0B15) at the end. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowHereItIstheTinyMedal::
    ld de, EVENT_REWARD_ITEM_OR_KEY_2_1A5
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_HERO_RECEIVED_A_TINY_MEDAL_1A6
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld a, [wInventory + $17]
    cp $ff
    jr z, .set_step_ptr_lo_to_2C
    or a
    jr z, .set_step_ptr_lo_to_2C
    ld hl, $0d45 ; '*: Here it is-the TinyMedal. My'
    call StartMessageCommand09HL_B13
    ret

.set_step_ptr_lo_to_2C:
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld hl, Script_HereItIsThe ; script '*: Here it is-the TinyMedal. My'
    call StartScriptAtHL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0d26 ; '*: Hup, hup, hup! Heh, this'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b15 ; '*: When master's shop starts making'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0245_HeroPeeredIntoTheVaseIt_13", ROMX

; Great Log talk 206 (GreatLogTalkEvents): starts message $0245 ('<BUF0> peered into the vase. It
; was') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0245 through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0245_HeroPeeredIntoTheVaseIt_13) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0245_HeroPeeredIntoTheVaseIt_13)
TalkMsg0245_HeroPeeredIntoTheVaseIt_13::
    ld hl, $0245 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk00FC_YouHaveToEat", ROMX

; Talk: adds 100 to the party's INT (capped at 999; AddHundredToPartyINTCapped999) and says 'You
; have to eat your...' ($00FC). (C2, E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $00FC, whose
; string begins 'You have to eat your vegetables!' (E-0097)
Talk00FC_YouHaveToEat::
    farcall AddHundredToPartyINTCapped999
    ld hl, $00fc ; '*: You have to eat your'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A74_TheMedalMasterWas", ROMX

; Great Log talk 208 (GreatLogTalkEvents): message $0B51 ('If you find even more') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0A74 ('The Medal Master was famous as'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A74_TheMedalMasterWas.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0A74 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The Medal Master was famous as' (E-0082)
TalkMsg0A74_TheMedalMasterWas::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a74 ; '*: The Medal Master was famous'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b51 ; '*: If you find even more'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_PrinceKamehaMissing", ROMX

; Great Log talk 209 (GreatLogTalkEvents): returns at once until EVENT_SCENE_SHIELD2_023 is set;
; then starts Script_PrinceKamehaHasBeen_2 (sets EVENT_PRINCE_KAMEHA_HAS_BEEN, runs
; SCRIPT_SCENE_KAMEHA_MISSING, 'Prince Kameha has been missing') through StartScriptAtHL_B13
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; when story flag $23 is set, StartScriptAtHL_B13 with HL = $57A2 (E-0119) (E-0344: the address in
; its name dropped or read as the label there; was GreatLogTalkEvents_PrinceKamehaMissing)
; starts Script_PrinceKamehaHasBeen_2: '*: Prince Kameha has been missing' (E-0248)
GreatLogTalkEvents_PrinceKamehaMissing::
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    ret nc
    ld hl, Script_PrinceKamehaHasBeen_2 ; script '*: Prince Kameha has been missing'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 BarrelItem_TinyMedal_Flag013C", ROMX

; Great Log talk 210 (GreatLogTalkEvents), a one-time barrel: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_TINYMEDAL
; and story flag $013C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A6), shows $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0377)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $013C in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_TinyMedal_Flag013C)
BarrelItem_TinyMedal_Flag013C::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $013c
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 VaseItem_Sirloin", ROMX

; Great Log talk 211 (GreatLogTalkEvents), a one-time vase: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_SIRLOIN and
; story flag $013D in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A3),
; shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0377)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $1C, story
; flag $013D in DE: when the flag is clear it gives item $1C (Sirloin) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Sirloin)
VaseItem_Sirloin::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1c
    ld [wScriptParam1], a
    ld de, $013d
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 TalkMsg0A35_ImABugSo", ROMX

; Great Log talk 212 (GreatLogTalkEvents): message $0B0A ('Bugs like me grow super-quick!') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0A35 ('I'm a bug, so I'm not'); both through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jp to
; TalkMsg0A35_ImABugSo.call_start_message_command09_hl_b13); when none of them branches, starts
; message $0A35 through StartMessageCommand09HL_B13 (script command $09); that string begins 'I'm a
; bug, so I'm not' (E-0082)
TalkMsg0A35_ImABugSo::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a35 ; '*: I'm a bug, so I'm'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b0a ; '*: Bugs like me grow super-quick!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A34_UhehehehDidYouKnowThisZombies", ROMX

; Great Log talk 213 (GreatLogTalkEvents): starts message $0A34 ('Uheheheh, did you know this?
; Zombies like') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0A34 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Uheheheh, did you know this? Zombies like' (E-0268, the E-0082 shape; was
; TalkMsg0A34_UhehehehDidYouKnowThisZombies)
TalkMsg0A34_UhehehehDidYouKnowThisZombies::
    ld hl, $0a34 ; '*: Uheheheh, did you know this?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A68_MyEmyuIsVery", ROMX

; Great Log talk 214 (GreatLogTalkEvents): message $0BBD ('There's something wrong with Emyu...')
; once EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0A68 ('My Emyu is very timid. I'); both
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A68_MyEmyuIsVery.call_start_message_command09_hl_b13); when none of them branches, starts
; message $0A68 through StartMessageCommand09HL_B13 (script command $09); that string begins 'My
; Emyu is very timid. I' (E-0082)
TalkMsg0A68_MyEmyuIsVery::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a68 ; '*: My Emyu is very timid.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0bbd ; '*: There's something wrong with Emyu…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A6B_MonstersLookSoFrightening", ROMX

; Great Log talk 215 (GreatLogTalkEvents): message $0BBE ('Hey, hey, hey! We have') after
; EVENT_THANKS_FOR_COMING_BY_025, $0A6C ('I should be more assertive.') after
; EVENT_MONSTERS_LOOK_SO_FRIGHTENING, otherwise $0A6B ('Monsters look so frightening... Yes, I');
; each through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). This routine does not set
; EVENT_MONSTERS_LOOK_SO_FRIGHTENING. (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A6B_MonstersLookSoFrightening.call_start_message_command09_hl_b132; flag $0136 set: jr to
; TalkMsg0A6B_MonstersLookSoFrightening.call_start_message_command09_hl_b13); when none of them
; branches, starts message $0A6B through StartMessageCommand09HL_B13 (script command $09); that
; string begins 'Monsters look so frightening Yes, I' (E-0082)
TalkMsg0A6B_MonstersLookSoFrightening::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_MONSTERS_LOOK_SO_FRIGHTENING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0a6b ; '*: Monsters look so frightening… Yes,'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0a6c ; '*: I should be more assertive.'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0bbe ; '*: Hey, hey, hey! We have'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0A40_PleaseEnterTheKing", ROMX

; Talk: 'You're today's guest of honor!' ($0545) after Darck's defeat until
; EVENT_THANKS_FOR_COMING_BY_025; otherwise 'Please enter. The King awaits...' ($0A40). (C2, E-0357;
; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0A40, whose
; string begins 'Please enter. The King awaits you' (E-0097)
Talk0A40_PleaseEnterTheKing::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0a40 ; '*: Please enter. The King awaits'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0545 ; '*: You're today's guest of honor!'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0A4B_OnTheHorizonYou", ROMX

; Great Log talk 217 (GreatLogTalkEvents): message $0BBA ('I'm feeling invigorated too.') after
; EVENT_THANKS_FOR_COMING_BY_025, $0518 ('I've never once left the') after EVENT_SCENE_THREE_ITEMS,
; otherwise $0A4B ('On the horizon, you can see'); each through StartMessageCommand09HL_B13 (script
; command 9 with the word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0A4B_OnTheHorizonYou.call_start_message_command09_hl_b132; flag $0024 set: jp to
; TalkMsg0A4B_OnTheHorizonYou.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0A4B through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'On the horizon, you can see' (E-0082)
TalkMsg0A4B_OnTheHorizonYou::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b13
    ld hl, $0a4b ; '*: On the horizon, you can'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0518 ; '*: I've never once left the'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0bba ; '*: I'm feeling invigorated too. I'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg04D1_ThereAreTimesWhenYouHave", ROMX

; Great Log talk 218 (GreatLogTalkEvents): starts message $04D1 ('There are times when you have to')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $04D1 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'There are times when you have to' (E-0268, the E-0082 shape; was
; TalkMsg04D1_ThereAreTimesWhenYouHave)
TalkMsg04D1_ThereAreTimesWhenYouHave::
    ld hl, $04d1 ; '*: There are times when you'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowHeroFoundAMagic", ROMX

; Great Log talk, the desk: gives a Magic Key: kind $0A (a constant test picks it over $0B, the
; other edition's), later kind $0C after EVENT_THAT_KEY_IUSED_03E; with bit 6 when the matching
; EVENT_SCENE_CHEST_BATTLE flag is set; 'checked the desk.' scripts; a random new key
; (GenerateNewKeyEntry) instead when the kind is already held, setting EVENT_DESK_KEY/_0C8; 'found a
; Magic Key. But ...' when the key list is full. (C2, E-0357; probed E-0377)
GreatLogTalkEvents_ShowHeroFoundAMagic::
    ld de, EVENT_DESK_KEY_0C8
    call TestFlagBit
    ret c
    ld de, EVENT_DESK_KEY
    call TestFlagBit
    jp c, .call_test_flag_bit
    ld a, $01
    or a
    jr z, .set_temp0_to_0B
    ld a, $0a
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_0A
    ld hl, $0b4f ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_0A:
    ld a, $0a
    ldh [hTemp1], a
    ld de, EVENT_SCENE_CHEST_BATTLE
    call TestFlagBit
    jr nc, .call_write_key_entry_temp0
    ld a, $4a
    ldh [hTemp1], a

.call_write_key_entry_temp0:
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .call_start_message_command09_hl_b13
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk_4 ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ld de, EVENT_DESK_KEY
    call SetFlagBit
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b4f ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

.set_temp0_to_0B:
    ld a, $0b
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry2
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_0B
    ld hl, $0bb8 ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_0B:
    ld a, $0b
    ldh [hTemp1], a
    ld de, EVENT_SCENE_CHEST_BATTLE_207
    call TestFlagBit
    jr nc, .call_write_key_entry_temp02
    ld a, $4b
    ldh [hTemp1], a

.call_write_key_entry_temp02:
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk_2 ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ret

.call_generate_new_key_entry2:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .call_start_message_command09_hl_b132
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk_4 ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ld de, EVENT_DESK_KEY
    call SetFlagBit
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b4f ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_THAT_KEY_IUSED_03E
    call TestFlagBit
    ret nc
    ld a, $0c
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry3
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_0C
    ld hl, $0bb8 ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

.set_temp1_to_0C:
    ld a, $0c
    ldh [hTemp1], a
    ld de, EVENT_SCENE_CHEST_BATTLE_208
    call TestFlagBit
    jr nc, .call_write_key_entry_temp03
    ld a, $4c
    ldh [hTemp1], a

.call_write_key_entry_temp03:
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk_3 ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ret

.call_generate_new_key_entry3:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .call_start_message_command09_hl_b133
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheDesk_4 ; script '0 checked the desk.'
    call StartScriptAtHL_B13
    ld de, EVENT_DESK_KEY_0C8
    call SetFlagBit
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b4f ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0519_ThisIsATimeWeNeed", ROMX

; Great Log talk 220 (GreatLogTalkEvents): starts message $0519 ('This is a time we need Warubou's')
; through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0519 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'This is a time we need Warubou's' (E-0268, the E-0082 shape; was TalkMsg0519_ThisIsATimeWeNeed)
TalkMsg0519_ThisIsATimeWeNeed::
    ld hl, $0519 ; '*: This is a time we'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg051A_IDidntWantToBelieveGreatLog", ROMX

; Great Log talk 221 (GreatLogTalkEvents): starts message $051A ('I didn't want to believe GreatLog
; is') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $051A through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I didn't want to believe GreatLog is' (E-0268, the E-0082 shape; was
; TalkMsg051A_IDidntWantToBelieveGreatLog)
TalkMsg051A_IDidntWantToBelieveGreatLog::
    ld hl, $051a ; '*: I didn't want to believe'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg051B_IWontBelieveThatGreatLog", ROMX

; Great Log talk 222 (GreatLogTalkEvents): starts message $051B ('I won't believe that GreatLog is
; sinking.') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $051B through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'I won't believe that GreatLog is sinking.' (E-0268, the E-0082 shape; was
; TalkMsg051B_IWontBelieveThatGreatLog)
TalkMsg051B_IWontBelieveThatGreatLog::
    ld hl, $051b ; '*: I won't believe that GreatLog'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg051C_TheKingSaidThatGreatLogWill", ROMX

; Great Log talk 223 (GreatLogTalkEvents): starts message $051C ('The King said that GreatLog will
; not') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $051C through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The King said that GreatLog will not' (E-0268, the E-0082 shape; was
; TalkMsg051C_TheKingSaidThatGreatLogWill)
TalkMsg051C_TheKingSaidThatGreatLogWill::
    ld hl, $051c ; '*: The King said that GreatLog'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg051D_EveryonePleaseRemainCalm", ROMX

; Great Log talk 224 (GreatLogTalkEvents): starts message $051D ('Everyone, please remain calm. Even
; if GreatLog') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $051D through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Everyone, please remain calm. Even if GreatLog' (E-0268, the E-0082 shape; was
; TalkMsg051D_EveryonePleaseRemainCalm)
TalkMsg051D_EveryonePleaseRemainCalm::
    ld hl, $051d ; '*: Everyone, please remain calm. Even'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg051E_TheGreatLogTreeAppearedTo", ROMX

; Great Log talk 225 (GreatLogTalkEvents): starts message $051E ('The GreatLog tree appeared to be
; healthy') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $051E through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'The GreatLog tree appeared to be healthy' (E-0268, the E-0082 shape; was
; TalkMsg051E_TheGreatLogTreeAppearedTo)
TalkMsg051E_TheGreatLogTreeAppearedTo::
    ld hl, $051e ; '*: The GreatLog tree appeared to'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg055E_HeroCheckedTheBookshelfMagic", ROMX

; Great Log talk 226 (GreatLogTalkEvents): starts message $055E ('<BUF0> checked the bookshelf.
; "Magic Keys..."') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $055E through StartMessageCommand09HL_B13 (script command $09); that string begins
; '0 checked the bookshelf. Magic Keys The' (E-0268, the E-0082 shape; was
; TalkMsg055E_HeroCheckedTheBookshelfMagic)
TalkMsg055E_HeroCheckedTheBookshelfMagic::
    ld hl, $055e ; '0 checked the bookshelf. 'Magic Keys…'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0DD5_MonsterSkillsArePassedOn", ROMX

; Great Log talk 227 (GreatLogTalkEvents): starts message $0DD5 ('Monster skills are passed on from
; parents') through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; starts message $0DD5 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'Monster skills are passed on from parents' (E-0268, the E-0082 shape; was
; TalkMsg0DD5_MonsterSkillsArePassedOn)
TalkMsg0DD5_MonsterSkillsArePassedOn::
    ld hl, $0dd5 ; '*: Monster skills are passed on'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_ShowEgg", ROMX

; Great Log talk: when the egg receives gifts (wGiftRecord 1) and the scene object is free, shows
; the egg (field command $14). (C1, E-0357)
GreatLogTalkEvents_ShowEgg::
    ld a, [wGiftRecord]
    cp $01
    ret nz
    ld a, [wObject5]
    or a
    ret nz
    ld a, $14
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ret

SECTION "Bank 13 GreatLogTalkEvents_Egg", ROMX

; Great Log talk, the egg: when it receives gifts, 'What will you give to the ...' with no gift
; pending, otherwise '<item> has been given to the ...' with the pending item's name. (C2, E-0357;
; probed E-0377)
GreatLogTalkEvents_Egg::
    ld a, [wGiftRecord]
    cp $01
    ret nz
    ld a, [wPendingGiftItem]
    or a
    jr nz, .call_copy_item_name_to_de
    ld hl, Script_WhatWillYouGive ; script 'What will you give to the'
    call StartScriptAtHL_B13
    ret

.call_copy_item_name_to_de:
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld hl, Script_YHasBeenGiven ; script 'Y has been given to the'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_SpeciesPreset", ROMX

; Great Log talk: by the player's X ($30, $40 or other) message $0D66, $0D67 or $0D68 and the
; matching species-flag preset 0, 1 or 2 (LoadSpeciesFlagsPresetC). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_SpeciesPreset::
    ldh a, [hPlayerX]
    cp $30
    jr nz, .cp_40
    ld hl, $0d66
    ld c, $00
    jr .call_start_message_command09_hl_b132

.cp_40:
    cp $40
    jr nz, .call_start_message_command09_hl_b13
    ld hl, $0d67
    ld c, $01
    jr .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0d68
    ld c, $02

.call_start_message_command09_hl_b132:
    call StartMessageCommand09HL_B13
    farcall LoadSpeciesFlagsPresetC
    ret

SECTION "Bank 13 GreatLogTalkEvents_ResetKeyShopTalk", ROMX

; Great Log talk 231: clears wGreatLogEventFlag, the byte KeyAppraisalMenu_ChooseKey_PayAndAppraise
; sets to 1 after the save that follows an appraisal; while it is 1,
; GreatLogTalkEvents_ShowItsExcitingToThink only shows message $0DC2 instead of opening the Key
; Shop. (C2, E-0370; probed E-0377)
GreatLogTalkEvents_ResetKeyShopTalk::
    xor a
    ld [wGreatLogEventFlag], a
    ret

SECTION "Bank 13 TalkMsg029B_IFoundAKey", ROMX

; Great Log talk 233 (GreatLogTalkEvents): message $0B1F ('My grandpa gave me a') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $029B ('I found a key in another'); both through
; StartMessageCommand09HL_B13 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg029B_IFoundAKey.call_start_message_command09_hl_b13); when none of them branches, starts
; message $029B through StartMessageCommand09HL_B13 (script command $09); that string begins 'I
; found a key in another' (E-0082)
TalkMsg029B_IFoundAKey::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $029b ; '*: I found a key in'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b1f ; '*: My grandpa gave me a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0DE3_TheSeaIsHuge", ROMX

; Talk: 'Huh? Has the sea risen?' ($0DE4) after the mermaid kingdom scene until
; EVENT_THANKS_FOR_COMING_BY_025; otherwise 'The sea is huge and...' ($0DE3). (C2, E-0357; probed
; E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0DE3, whose
; string begins 'The sea is huge and mysterious.' (E-0097)
Talk0DE3_TheSeaIsHuge::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132

.call_start_message_command09_hl_b13:
    ld hl, $0de3 ; '*: The sea is huge and'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0de4 ; '*: Huh? Has the sea risen?'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 TalkMsg0220_InOtherWorldsYoull_2", ROMX

; Great Log talk 235 (GreatLogTalkEvents): message $0B13 ('I just happened to come') once
; EVENT_THANKS_FOR_COMING_BY_025 is set, otherwise $0220 ('In other worlds, you'll meet other');
; both through StartMessageCommand09HL_B13 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). An identical copy of Great Log
; talk 186 (TalkMsg0220_InOtherWorldsYoull). (C2, E-0377)
; tests story flags in turn (flag $0025 set: jr to
; TalkMsg0220_InOtherWorldsYoull_2.call_start_message_command09_hl_b13); when none of them branches,
; starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins
; 'In other worlds, you'll meet other' (E-0082) (E-0344: the address in its name dropped or read as
; the label there; was TalkMsg0220_InOtherWorldsYoull_2)
TalkMsg0220_InOtherWorldsYoull_2::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld hl, $0220 ; '*: In other worlds, you'll meet'
    call StartMessageCommand09HL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b13 ; '*: I just happened to come'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 ChestItem_Snow", ROMX

; Great Log talk 236 (GreatLogTalkEvents), a one-time chest: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_SNOW and
; story flag $013E in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState =
; 1). That command gives the item and sets the flag when the flag is clear (group-0 message $A0),
; shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $26, story flag $013E in DE: when the flag is clear it gives item $26 (Snow) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Snow)
ChestItem_Snow::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $26
    ld [wScriptParam1], a
    ld de, $013e
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 ChestItem_MagicBelt", ROMX

; Great Log talk 237 (GreatLogTalkEvents), a one-time chest: StartTreasureFlagDE_B13 starts script
; command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_MAGICBELT
; and story flag $013F in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0377)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $42, story flag $013F in DE: when the flag is clear it gives item $42 (MagicBelt) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_MagicBelt)
ChestItem_MagicBelt::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $42
    ld [wScriptParam1], a
    ld de, $013f
    call StartTreasureFlagDE_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_Msg055F_HeroCheckedTheBookshelf", ROMX

; Great Log talk: 'checked the bookshelf. 'Magic Keys...' ($055F). (C2, E-0357; probed E-0377)
GreatLogTalkEvents_Msg055F_HeroCheckedTheBookshelf::
    ld hl, $055f ; '0 checked the bookshelf. 'Magic Keys…'
    call StartMessageCommand09HL_B13
    ret
    db $c9

; Breeding masters (by sprite slot 2's kind): kind $13 asks for 100 species
; (TotalSpeciesFlaggedOrListed) before its 'Ah, you must be the...' script (screen table 6), else 'I
; heard of a little...' ($0D8E), then 'Generations of breeding passes on...' ($0B5A); kind $17 asks
; for 150 before 'I didn't think GreatLog's hero...' (screen table 7), else 'What a scruffy lot
; of...' ($0D8F), then 'Put accessories on your monsters.' ($0B5E); others the 'Didn't you save
; GreatLog?' script (screen table 5), then 'When you breed monsters with...' ($0B56). Saves the
; screen and the player's place; wDataBank $0E. (C1, E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5
; constant message(s) depending on story flags and state; the first one in the code is $0B56, whose
; string begins 'When you breed monsters with another' (E-0097)
Talk0B56_WhenYouBreedMonsters::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0e
    ld [wDataBank], a
    ld a, [wSpriteSlots + $2]
    cp $17
    jr z, .call_test_flag_bit2
    cp $13
    jr z, .call_test_flag_bit
    ld de, EVENT_WHEN_YOU_BREED_MONSTERS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $05
    ld [wScreenTableIndex], a
    ld hl, Script_Didn ; script '*: Didn't you save GreatLog? That'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b56 ; '*: When you breed monsters with'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_WHEN_YOU_BREED_MONSTERS_033
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .set_screen_table_index_to_06
    ldh a, [hTemp0]
    cp $64
    jr nc, .set_screen_table_index_to_06
    ld hl, $0d8e ; '*: I heard of a little'
    call StartMessageCommand09HL_B13
    ret

.set_screen_table_index_to_06:
    ld a, $06
    ld [wScreenTableIndex], a
    ld hl, Script_AhYouMustBe ; script '*: Ah, you must be the'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b5a ; '*: Generations of breeding passes on'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit2:
    ld de, EVENT_WHEN_YOU_BREED_MONSTERS_034
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b133
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .set_screen_table_index_to_07
    ldh a, [hTemp0]
    cp $96
    jr nc, .set_screen_table_index_to_07
    ld hl, $0d8f ; '*: What a scruffy lot of'
    call StartMessageCommand09HL_B13
    ret

.set_screen_table_index_to_07:
    ld a, $07
    ld [wScreenTableIndex], a
    ld hl, Script_IDidn ; script '*: I didn't think GreatLog's hero'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b133:
    ld hl, $0b5e ; '*: Put accessories on your monsters.'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0B6D_BreedingFireAndIce", ROMX

; Breeding master: sprite kind $14 asks for 100 species before the 'Hey! You're still at it,...'
; script (screen table 9), else 'A master who can satisfy...' ($0D85), then 'Through breeding the
; number beside...' ($0B73); others the 'Are you perhaps GreatLog's savior?' script (screen table
; 8), then 'Breeding fire and ice together...' ($0B6D). (C1, E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $0B6D, whose
; string begins 'Breeding fire and ice together makes' (E-0097)
Talk0B6D_BreedingFireAndIce::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0e
    ld [wDataBank], a
    ld a, [wSpriteSlots + $2]
    cp $14
    jr z, .call_test_flag_bit
    ld de, EVENT_BREEDING_FIRE_AND_ICE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    ld a, $08
    ld [wScreenTableIndex], a
    ld hl, Script_AreYouPerhapsGreatLog ; script '*: Are you perhaps GreatLog's savior?'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0b6d ; '*: Breeding fire and ice together'
    call StartMessageCommand09HL_B13
    ret

.call_test_flag_bit:
    ld de, EVENT_BREEDING_FIRE_AND_ICE_036
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b132
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .set_screen_table_index_to_09
    ldh a, [hTemp0]
    cp $64
    jr nc, .set_screen_table_index_to_09
    ld hl, $0d85 ; '*: A master who can satisfy'
    call StartMessageCommand09HL_B13
    ret

.set_screen_table_index_to_09:
    ld a, $09
    ld [wScreenTableIndex], a
    ld hl, Script_HeyYou ; script '*: Hey! You're still at it,'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b132:
    ld hl, $0b73 ; '*: Through breeding the number beside'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 Talk0D90_HumphImTerry", ROMX

; Terry: after the Terry battle scene 'Terry: I hope you'll stay a...' ($0BB3); otherwise his battle
; script (Script_HumphI) with 150 species or more, else 'Humph... I'm Terry...' ($0D90). (C2,
; E-0357; probed E-0377)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0D90, whose
; string begins 'Humph I'm Terry. Terry I'm a' (E-0097)
Talk0D90_HumphImTerry::
    ld de, EVENT_SCENE_TERRY_BATTLE_038
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b13
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    cp $01
    jr z, .call_start_script_at_hl_b13
    ldh a, [hTemp0]
    cp $96
    jr nc, .call_start_script_at_hl_b13
    ld hl, $0d90 ; '*: Humph… I'm Terry. Terry: I'm'
    call StartMessageCommand09HL_B13
    ret

.call_start_script_at_hl_b13:
    ld hl, Script_HumphI ; script '*: Humph… I'm Terry. I'm a'
    call StartScriptAtHL_B13
    ret

.call_start_message_command09_hl_b13:
    ld hl, $0bb3 ; 'Terry: I hope you'll stay a'
    call StartMessageCommand09HL_B13
    ret

SECTION "Bank 13 GreatLogTalkEvents_SetObject0XAfter50Species", ROMX

; Great Log talk 243 (GreatLogTalkEvents): after EVENT_THANKS_FOR_COMING_BY_025, when
; TotalSpeciesFlaggedOrListed is 50 or more, sets wSpriteSlots + $B (byte OBJ_X of the first 16-byte
; object slot) to $30; otherwise returns without a change. Starts no message or script. (C2, E-0377)
; map event: with story flag $25 set, sets wSpriteSlots + $B = $30 when the count from
; TotalSpeciesFlaggedOrListed is at least 50 (E-0122) (E-0340: the address in its name read as its
; RAM name; was GreatLogTalkEvents_SetObject0XAfter50Species)
GreatLogTalkEvents_SetObject0XAfter50Species::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    ret nc
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr nz, .set_sprite_slots_to_30
    ldh a, [hTemp0]
    cp $32
    ret c

.set_sprite_slots_to_30:
    ld a, $30
    ld [wSpriteSlots + $b], a
    ret

SECTION "Bank 13 GreatLogTalkEvents_SyncMap17ObjectFlags", ROMX

; Great Log talk 244 (GreatLogTalkEvents): sets EVENT_MAP_17_OBJECT_REMOVED when
; EVENT_WHEN_YOU_BREED_MONSTERS is set and EVENT_MAP_17_OBJECT_REMOVED_0CA when
; EVENT_WHEN_YOU_BREED_MONSTERS_033 is set (the flags of the breeding master talks,
; Talk0B56_WhenYouBreedMonsters); clears nothing and starts no message. (C2, E-0377)
; sets story flag $C9 if flag $32 is set and flag $CA if flag $33 is set (E-0122)
GreatLogTalkEvents_SyncMap17ObjectFlags::
    ld de, EVENT_WHEN_YOU_BREED_MONSTERS
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_MAP_17_OBJECT_REMOVED
    call SetFlagBit

.call_test_flag_bit:
    ld de, EVENT_WHEN_YOU_BREED_MONSTERS_033
    call TestFlagBit
    ret nc
    ld de, EVENT_MAP_17_OBJECT_REMOVED_0CA
    call SetFlagBit
    ret

SECTION "Bank 13 GreatLogTalkEvents_SyncMap04ObjectFlags", ROMX

; Great Log talk 245 (GreatLogTalkEvents): sets EVENT_MAP_04_OBJECT_REMOVED when
; EVENT_BREEDING_FIRE_AND_ICE is set and EVENT_MAP_04_OBJECT_REMOVED_0CC when
; EVENT_BREEDING_FIRE_AND_ICE_036 is set (the flags of the breeding master talks,
; Talk0B6D_BreedingFireAndIce); clears nothing and starts no message. (C2, E-0377)
; sets story flag $CB if flag $35 is set and flag $CC if flag $36 is set (E-0122)
GreatLogTalkEvents_SyncMap04ObjectFlags::
    ld de, EVENT_BREEDING_FIRE_AND_ICE
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_MAP_04_OBJECT_REMOVED
    call SetFlagBit

.call_test_flag_bit:
    ld de, EVENT_BREEDING_FIRE_AND_ICE_036
    call TestFlagBit
    ret nc
    ld de, EVENT_MAP_04_OBJECT_REMOVED_0CC
    call SetFlagBit
    ret

SECTION "Bank 13 GreatLogTalkEvents_YoureTheChildAfterRival", ROMX

; Great Log talk 246 (GreatLogTalkEvents): returns at once until EVENT_SCENE_RIVAL_DEFEATED_021 is
; set; then starts Script_You_9 (a walk, 'You're the child of the', 'What? You don't know about',
; sets EVENT_WHAT_YOU_DON) through StartScriptAtHL_B13 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0377)
; when story flag $21 is set, StartScriptAtHL_B13 with HL = $5988 (E-0119) (E-0344: the address in
; its name dropped or read as the label there; was GreatLogTalkEvents_YoureTheChildAfterRival)
; starts Script_You_9: '*: You're the child of the' (E-0248)
GreatLogTalkEvents_YoureTheChildAfterRival::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    ret nc
    ld hl, Script_You_9 ; script '*: You're the child of the'
    call StartScriptAtHL_B13
    ret

SECTION "Bank 13 InventoryHasFreeSlotCheck_Bank13", ROMX

; Bank-$13 copy of InventoryHasFreeSlotCheck: when the last bag slot (wInventory + $17) holds an
; item (not $00 or $FF) it returns A = 0 and carry clear (bag full); otherwise it returns carry set
; with HL = the first slot of wInventory that is $00 or $FF (A = that byte).
; TalkMsg025E_MyGranddaughterIsPainfully writes its gift through that HL. (C2, E-0377)
; the same 28 bytes as InventoryHasFreeSlotCheck (InventoryHasFreeSlotCheck) (E-0124)
InventoryHasFreeSlotCheck_Bank13::
    ld a, [wInventory + $17]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    sub a
    ret

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hl]
    cp $ff
    jr z, .return_carry
    or a
    jr z, .return_carry
    inc hl
    jr .skip2

.return_carry:
    scf
    ret

SECTION "Bank 13 SavePlayerPositionState", ROMX

; Copies wSpriteSlots + 7, hPlayerX, hPlayerY, hPlayerFacing and the follower bytes wFollowerRecords
; + 0, 1, 2, 5, 6, 7, $A, $B and $C into the 13 bytes wSavedPlayerState to wSavedPlayerState + $C,
; in that order. The Great Log talks that start a breeding or shrine script
; (GreatLogTalkEvents_Breeder, GreatLogTalkEvents_StarryShrine, Talk0A49_BreedingCouldResultIn,
; Talk04BA_IfYouGetAn, Talk04C0_AllRightyWellDo, Talk0B56_WhenYouBreedMonsters,
; Talk0B6D_BreedingFireAndIce) call it after SaveScreenBufferToBGMap1. (C2, E-0377)
; copies wSpriteSlots + $7, the player position and facing, wFollowerRecords and wFollowerRecords +
; $1-wFollowerRecords + $C fields into wSavedPlayerState-wSavedPlayerState + $C (E-0121)
SavePlayerPositionState::
    ld a, [wSpriteSlots + $7]
    ld [wSavedPlayerState], a
    ldh a, [hPlayerX]
    ld [wSavedPlayerState + $1], a
    ldh a, [hPlayerY]
    ld [wSavedPlayerState + $2], a
    ldh a, [hPlayerFacing]
    ld [wSavedPlayerState + $3], a
    ld a, [wFollowerRecords]
    ld [wSavedPlayerState + $4], a
    ld a, [wFollowerRecords + $1]
    ld [wSavedPlayerState + $5], a
    ld a, [wFollowerRecords + $2]
    ld [wSavedPlayerState + $6], a
    ld a, [wFollowerRecords + $5]
    ld [wSavedPlayerState + $7], a
    ld a, [wFollowerRecords + $6]
    ld [wSavedPlayerState + $8], a
    ld a, [wFollowerRecords + $7]
    ld [wSavedPlayerState + $9], a
    ld a, [wFollowerRecords + $a]
    ld [wSavedPlayerState + $a], a
    ld a, [wFollowerRecords + $b]
    ld [wSavedPlayerState + $b], a
    ld a, [wFollowerRecords + $c]
    ld [wSavedPlayerState + $c], a
    ret
    db $00, $00, $00, $00
