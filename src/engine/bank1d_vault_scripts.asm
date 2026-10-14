; ROM bank $1D: the vault menu, scripts and glyph tiles
; The annotated listing of this bank is build/listing/bank1d.asm.

SECTION "Bank 1D", ROMX[$4000], BANK[$1D]
    db $1d

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank1D::
    ld de, BeginStringDisplay_Bank1D_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd

; data read by DrawNameGlyphBufGlyphsOverlaying8DAnd8E (6 bytes) (E-0347)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Data::
    db $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank1D_StringCategories::
    dw StringList_Bank1D_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank1D_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank1D_StringCategories_0::
    dw String_1D_00_00 ; id 0
    dw String_1D_00_00 ; id 1
    dw String_1D_00_02 ; id 2
    dw String_1D_00_03 ; id 3
    dw String_1D_00_04 ; id 4
    dw String_1D_00_05 ; id 5
    dw String_1D_00_06 ; id 6
    dw String_1D_00_07 ; id 7
    dw String_1D_00_08 ; id 8
    dw String_1D_00_09 ; id 9
    dw String_1D_00_0A ; id 10
    dw String_1D_00_0B ; id 11
    dw String_1D_00_0C ; id 12
    dw String_1D_00_0D ; id 13
    dw String_1D_00_0E ; id 14
    dw String_1D_00_0F ; id 15
    dw String_1D_00_10 ; id 16
    dw String_1D_00_11 ; id 17
    dw String_1D_00_12 ; id 18
    dw String_1D_00_13 ; id 19
    dw String_1D_00_14 ; id 20
    dw String_1D_00_15 ; id 21
    dw String_1D_00_16 ; id 22
    dw String_1D_00_16 ; id 23

String_1D_00_00::
    db "<VOICE1>*: Which monster<LINE>"
    db "will hibernate?@"

String_1D_00_02::
    db "<VOICE1>*: Do you need me<LINE>"
    db "for anything else?@"

String_1D_00_03::
    db "<VOICE1>*: So this one<LINE>"
    db "should hibernate?@"

String_1D_00_04::
    db "<VOICE1>*: OK my friend,<LINE>"
    db "time to sleep!<WAIT>"
    db "@"

String_1D_00_05::
    db "<VOICE1>*: Huh? There's no<LINE>"
    db "one on the farm.<WAIT>"
    db "@"

String_1D_00_06::
    db "<VOICE1>*: Uh-oh, the<LINE>"
    db "stable is full!<WAIT>"
    db "@"

String_1D_00_07::
    db "<VOICE1>*: Want to switch<LINE>"
    db "with someone?@"

String_1D_00_08::
    db "<VOICE1>*: Who should I<LINE>"
    db "wake up?@"

String_1D_00_09::
    db "<VOICE1>*: Wake this<LINE>"
    db "monster up?@"

String_1D_00_0A::
    db "<VOICE1>*: Which one should<LINE>"
    db "hibernate?@"

String_1D_00_0B::
    db "<VOICE1>*: So switch <BUF0><LINE>"
    db "and <BUF1>, huh?<PROMPT>"
    db "<CLEAR>OK, I'll do that<LINE>"
    db "for you.<WAIT>"
    db "@"

String_1D_00_0C::
    db "<VOICE1>*: Who should I<LINE>"
    db "wake up?@"

String_1D_00_0D::
    db "<VOICE1>*: I'll send <BUF1><LINE>"
    db "to the farm.<WAIT>"
    db "@"

String_1D_00_0E::
    db "<VOICE1>*: Huh? No one's<LINE>"
    db "sleeping now.<WAIT>"
    db "@"

String_1D_00_0F::
    db "<VOICE1>*: Huh? There's no<LINE>"
    db "room on the farm.<WAIT>"
    db "@"

String_1D_00_10::
    db "<VOICE1>*: Should someone<LINE>"
    db "else hibernate?@"

String_1D_00_11::
    db "<VOICE1>*: Who do you want<LINE>"
    db "to check?@"

String_1D_00_12::
    db "<VOICE1>*: Who do you want<LINE>"
    db "to release?@"

String_1D_00_13::
    db "<VOICE1>*: It'll disappear.<LINE>"
    db "Is that OK?@"

String_1D_00_14::
    db "<BUF1> was released<LINE>"
    db "in the wild.<WAIT>"
    db "@"

String_1D_00_15::
    db "<VOICE1>*: Come see me if<LINE>"
    db "you get more<PROMPT>"
    db "<NEXT>monsters."
    db "<NEXT>I'll be waiting.<WAIT>"
    db "@"

String_1D_00_16::
    db "<VOICE1>*: No one else can<LINE>"
    db "hibernate,I see.<WAIT>"
    db "@"

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_Hibernate::
    script_command SCRIPT_HIBERNATE
Script_Hibernate_2::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_Hibernate_3, Script_ToHibernate_11, Script_ToHibernate_16, Script_ComeSeeMeIf
Script_ComeSeeMeIf::
    script_command SCRIPT_HIBERNATE_CLOSE
    script_message $8015 ; '*: Come see me if you'
    script_command SCRIPT_HIBERNATE_CLOSE
    script_end
Script_ToHibernate_16::
    script_jump Script_Hibernate_16
    db $07, $6d, $44

Script_ToHibernate_11::
    script_jump Script_Hibernate_11
Script_Hibernate_3::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_ToUhOhTheStable, Script_HuhThere, Script_ToWhichMonsterWillHibernate
Script_ToWhichMonsterWillHibernate::
    script_jump Script_WhichMonsterWillHibernate
Script_HuhThere::
    script_message $c005 ; '*: Huh? There's no one on'
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_ToUhOhTheStable::
    script_jump Script_UhOhTheStable
Script_WhichMonsterWillHibernate::
    script_message $c001 ; '*: Which monster will hibernate?'
Script_Hibernate_4::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_SoThisOneShould, Script_DoYouNeedMe
Script_DoYouNeedMe::
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_SoThisOneShould::
    script_message $c003 ; '*: So this one should hibernate?'
Script_Hibernate_5::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_Hibernate_6, Script_OKMyFriendTime, Script_WhichMonsterWillHibernate_2
Script_WhichMonsterWillHibernate_2::
    script_message $c001 ; '*: Which monster will hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_4
Script_Hibernate_6::
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_5
Script_OKMyFriendTime::
    script_message $c004 ; '*: OK my friend, time to'
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_UhOhTheStable::
    script_message $c006 ; '*: Uh-oh, the stable is full!'
    script_message $c007 ; '*: Want to switch with someone?'
Script_Hibernate_7::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WhoShouldIWake, Script_DoYouNeedMe_2
Script_DoYouNeedMe_2::
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_WhoShouldIWake::
    script_message $c008 ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WakeThisMonsterUp, Script_WantToSwitchWith
Script_WantToSwitchWith::
    script_command SCRIPT_HIBERNATE
    script_message $c007 ; '*: Want to switch with someone?'
    script_jump Script_Hibernate_7
Script_WakeThisMonsterUp::
    script_message $c009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WhichOneShouldHibernate, Script_ToWhoShouldIWake
Script_ToWhoShouldIWake::
    script_jump Script_WhoShouldIWake
Script_WhichOneShouldHibernate::
    script_command SCRIPT_HIBERNATE
    script_message $c00a ; '*: Which one should hibernate?'
Script_Hibernate_8::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_SoThisOneShould_2, Script_ToWhoShouldIWake_2
Script_ToWhoShouldIWake_2::
    script_jump Script_WhoShouldIWake
Script_SoThisOneShould_2::
    script_message $c003 ; '*: So this one should hibernate?'
Script_Hibernate_9::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_Hibernate_10, Script_SoSwitchHeroAnd, Script_WhichOneShouldHibernate_2
Script_WhichOneShouldHibernate_2::
    script_message $c00a ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_8
Script_Hibernate_10::
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_9
Script_SoSwitchHeroAnd::
    script_message $c00b ; '*: So switch 0 and G,'
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_Hibernate_11::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WhoShouldIWake_2, Script_ToHuhThere_3, Script_HuhThere_2, Script_HuhNoOne, Script_NoOneElseCan
Script_NoOneElseCan::
    script_message $c017 ; '*: No one else can hibernate,I'
    script_jump Script_DoYouNeedMe_3
Script_HuhNoOne::
    script_message $c00e ; '*: Huh? No one's sleeping now.'
Script_DoYouNeedMe_3::
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_ToHuhThere_3::
    script_jump Script_HuhThere_3
Script_HuhThere_2::
    script_message $c00f ; '*: Huh? There's no room on'
    script_jump Script_DoYouNeedMe_3
Script_WhoShouldIWake_2::
    script_message $c00c ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WakeThisMonsterUp_2, Script_DoYouNeedMe_4
Script_DoYouNeedMe_4::
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_WakeThisMonsterUp_2::
    script_message $c009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_I_4, Script_ToWhoShouldIWake_2_2
Script_ToWhoShouldIWake_2_2::
    script_jump Script_WhoShouldIWake_2
Script_I_4::
    script_message $c00d ; '*: I'll send G to the'
    script_command SCRIPT_HIBERNATE
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_HuhThere_3::
    script_message $c00f ; '*: Huh? There's no room on'
    script_message $c010 ; '*: Should someone else hibernate?'
Script_Hibernate_12::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WhichOneShouldHibernate_3, Script_DoYouNeedMe_5
Script_DoYouNeedMe_5::
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_WhichOneShouldHibernate_3::
    script_message $c00a ; '*: Which one should hibernate?'
Script_Hibernate_13::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_SoThisOneShould_3, Script_ShouldSomeoneElseHibernate
Script_ShouldSomeoneElseHibernate::
    script_message $c010 ; '*: Should someone else hibernate?'
    script_jump Script_Hibernate_12
Script_SoThisOneShould_3::
    script_message $c003 ; '*: So this one should hibernate?'
Script_Hibernate_14::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_Hibernate_15, Script_WhoShouldIWake_3, Script_WhichOneShouldHibernate_4
Script_WhichOneShouldHibernate_4::
    script_message $c00a ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_13
Script_Hibernate_15::
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_14
Script_WhoShouldIWake_3::
    script_message $c008 ; '*: Who should I wake up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WakeThisMonsterUp_3, Script_WhichOneShouldHibernate_5
Script_WhichOneShouldHibernate_5::
    script_message $c00a ; '*: Which one should hibernate?'
    script_command SCRIPT_HIBERNATE
    script_jump Script_Hibernate_13
Script_WakeThisMonsterUp_3::
    script_message $c009 ; '*: Wake this monster up?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_SoSwitchHeroAnd_2, Script_ToWhoShouldIWake_3
Script_ToWhoShouldIWake_3::
    script_jump Script_WhoShouldIWake_3
Script_SoSwitchHeroAnd_2::
    script_message $c00b ; '*: So switch 0 and G,'
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
    db $eb, $e4, $0a, $00, $00, $05, $c0, $00, $02, $c0, $07, $36, $43, $00, $11, $c0
    db $eb, $e4, $07, $00, $00, $02, $c0, $07, $36, $43, $eb, $07, $7d, $44

Script_Hibernate_16::
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_WhoDoYouWant, Script_HuhNoOne_2
Script_HuhNoOne_2::
    script_message $c00e ; '*: Huh? No one's sleeping now.'
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_WhoDoYouWant::
    script_message $c012 ; '*: Who do you want to'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_It, Script_DoYouNeedMe_6
Script_DoYouNeedMe_6::
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2
Script_It::
    script_message $c013 ; '*: It'll disappear. Is that OK?'
    script_command SCRIPT_HIBERNATE
    script_choice_jump Script_GWasReleasedIn, Script_ToWhoDoYouWant
Script_ToWhoDoYouWant::
    script_jump Script_WhoDoYouWant
Script_GWasReleasedIn::
    script_message $c014 ; 'G was released in the wild.'
    script_command SCRIPT_HIBERNATE
    script_message $c002 ; '*: Do you need me for'
    script_jump Script_Hibernate_2

; Storing or taking out, step 0: writes the item window's tile map into BG map 1 at $9F00 (to the
; $7F end), the bag's (state 3) or the storage's version. (C1, E-0357)
VaultMenu_Store_WaitForVRAMAccess::
    ld a, [wScreenState]
    cp $03
    jr z, .skip
    ld hl, BGMap1TileRun_2
    jr .skip2

.skip:
    ld hl, BGMap1TileRun

.skip2:
    ld de, vBGMap1 + $300

.skip3:
    ld a, [hl]
    cp $7f
    jr z, .check_screen_step
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ld [de], a
    inc de
    ei
    jr .skip3

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; VaultMenu_Store_WaitForVRAMAccess copies bytes from $44E3 to vBGMap1 + $300 until $7F
; (wScreenState = 3) (E-0226, C1)
; record: 99 tiles written in a run from vBGMap1 + $300 (32 per BG map row), then $7F
BGMap1TileRun::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $a6, $cf, $a5, $a7, $df, $eb, $ad, $c3, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9 ; entry 0
    db $ba, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4
    db $b4, $b4, $b5
    db $7f ; end

; VaultMenu_Store_WaitForVRAMAccess copies bytes from $4547 to vBGMap1 + $300 until $7F (any other
; wScreenState) (E-0226, C1)
BGMap1TileRun_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $ea, $eb, $ad, $ed, $ee, $ef, $ab, $ac, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9 ; entry 0
    db $ba, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4
    db $b4, $b4, $b5
    db $7f ; end

; copies three tiles from bank $1F to vTiles2 + $7A0-$7C0, then draws the 4 x 1 rows
; LoadThreeTilesAndDrawRows_TileRect, 4607 and 460B at scroll + $62, $A2 and $E2 (E-0121) (E-0344:
; the address in its name dropped or read as the label there; was LoadThreeTilesAndDrawRows; a
; trailing preposition left by the dropped address removed)
LoadThreeTilesAndDrawRows::
    ld hl, vTiles2 + $7a0
    ld de, Tiles2Plus210Tiles
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7b0
    ld de, Tiles2Plus7B0Tiles
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7c0
    ld de, Tiles1Plus7C0Tiles
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank1D
    ld de, $0062
    add hl, de
    lb bc, $04, $01
    ld de, LoadThreeTilesAndDrawRows_TileRect
    call DrawRectSetTextCursorLoPlus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00a2
    add hl, de
    lb bc, $04, $01
    ld de, LoadThreeTilesAndDrawRows_TileRect_2
    call DrawRectSetTextCursorLoPlus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00e2
    add hl, de
    lb bc, $04, $01
    ld de, LoadThreeTilesAndDrawRows_TileRect_3
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 4 x 1 tiles, one row per line
LoadThreeTilesAndDrawRows_TileRect::
    db $7a, $ad, $cf, $7b ; id 0

LoadThreeTilesAndDrawRows_TileRect_2::
    db $bf, $a7, $7c, $ee ; id 0

LoadThreeTilesAndDrawRows_TileRect_3::
    db $a9, $a4, $eb, $ad ; id 0

; Taking out, step 3: the Items / Gold / Exit choice: B or Exit answers 6; Items with nothing stored
; answers 0, with a full bag (24) answers 1, otherwise 4 and on two steps; Gold with none banked
; answers 3, with more than 99,899 gold in hand 2, otherwise 5; each answer resumes the script. (C1,
; E-0357)
VaultMenu_TakeOut_WriteTwoChoiceCursorAndScreenStepEtc_2::
    call VaultMenu_BlinkCursorBlinkEF_Bank1D
    and a
    ret z
    cp $01
    jr z, .check_vault_mode
    cp $02
    jr z, .set_two_choice_cursor_to_06
    ret

.set_two_choice_cursor_to_06:
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_vault_mode:
    ld a, [wVaultMode]
    and a
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    cp $01
    jr z, .check_banked_gold_hi
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wSavedSpriteClipMode]
    and a
    jr z, .clear_two_choice_cursor
    ld a, [wListPages]
    cp $18
    jr z, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    and a
    jr nz, .check_gold_hi
    ld a, [wBankedGoldMid]
    and a
    jr nz, .check_gold_hi
    ld a, [wBankedGoldLo]
    and a
    jr nz, .check_gold_hi
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_gold_hi:
    ld a, [wGoldHi]
    cp $01
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wGoldMid]
    cp $86
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wGoldLo]
    cp $3b
    jr c, .set_two_choice_cursor_to_05
    jr z, .set_two_choice_cursor_to_05

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_05:
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp .clear_script_command_type

; Storing, step 3: the Items / Gold / Exit choice: B or Exit answers 6; Items with an empty bag
; answers 0, with no room in storage (VaultMenu_Store_FindStorageSlots) 1, otherwise 4 and on two
; steps; Gold with under 100 in hand answers 2, with 999,900 or more banked 3, otherwise 5; each
; answer resumes the script. (C1, E-0357)
VaultMenu_Store_WriteTwoChoiceCursorAndScreenStepEtc::
    call VaultMenu_BlinkCursorBlinkEF_Bank1D
    and a
    ret z
    cp $01
    jr z, .check_vault_mode
    cp $02
    jr z, .set_two_choice_cursor_to_06
    ret

.set_two_choice_cursor_to_06:
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_vault_mode:
    ld a, [wVaultMode]
    and a
    jr z, .check_list_pages
    cp $01
    jr z, .check_gold_hi
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_pages:
    ld a, [wListPages]
    and a
    jr z, .clear_two_choice_cursor
    call VaultMenu_Store_FindStorageSlots
    cp $ff
    jr z, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_gold_hi:
    ld a, [wGoldHi]
    and a
    jr nz, .check_banked_gold_hi
    ld a, [wGoldMid]
    and a
    jr nz, .check_banked_gold_hi
    ld a, [wGoldLo]
    cp $64
    jr nc, .check_banked_gold_hi
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    cp $0f
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_03
    ld a, [wBankedGoldMid]
    cp $41
    jr c, .set_two_choice_cursor_to_05
    jr nz, .set_two_choice_cursor_to_03
    ld a, [wBankedGoldLo]
    cp $dc
    jr c, .set_two_choice_cursor_to_05

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_05:
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wScreenStep], a
    jp .clear_script_command_type

; The vault's choice cursor: Up/Down move over the three choices with wrap (sound $69); A marks it
; (sound $69) and returns 1; B returns 2; otherwise blinks the cursor and returns 0. (C1, E-0357)
VaultMenu_BlinkCursorBlinkEF_Bank1D::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank1_d
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank1_d2
    bit 0, a
    jr nz, .call_vault_menu_bg_map_address_at_scroll
    bit 1, a
    jp nz, .return_02
    call BlinkCursorBlinkEF_Bank1D
    xor a
    ret

.call_draw_blank_tile_c3_bank1_d:
    call DrawBlankTileC3_Bank1D
    ld a, [wVaultMode]
    and a
    jr nz, .set_vault_mode
    ld a, $02
    jr .set_vault_mode2

.set_vault_mode:
    dec a

.set_vault_mode2:
    ld [wVaultMode], a
    call DrawCursorTileBB_Bank1D
    ld a, $69
    call QueueSoundEffect
    xor a
    ret

.call_draw_blank_tile_c3_bank1_d2:
    call DrawBlankTileC3_Bank1D
    ld a, [wVaultMode]
    cp $02
    jr c, .skip
    xor a
    jr .set_vault_mode2

.skip:
    inc a
    jr .set_vault_mode2

.call_vault_menu_bg_map_address_at_scroll:
    call VaultMenu_BGMapAddressAtScroll_Bank1D
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

.return_02:
    ld a, $02
    ret

; cycles wCursorBlinkEF through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was BlinkCursorBlinkEF_Bank1D)
BlinkCursorBlinkEF_Bank1D::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank1D
    ld a, [wCursorBlinkEF]
    inc a
    ld [wCursorBlinkEF], a
    cp $10
    jr c, DrawCursorTileBB_Bank1D
    cp $18
    jr c, DrawBlankTileC3_Bank1D
    xor a
    ld [wCursorBlinkEF], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawCursorTileBB_Bank1D)
DrawCursorTileBB_Bank1D::
    ld b, $bb
    jr VaultMenu_BGMapAddressAtScroll_Bank1D_ReadVaultMode

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1D)
DrawBlankTileC3_Bank1D::
    ld b, $c3
    jr VaultMenu_BGMapAddressAtScroll_Bank1D_ReadVaultMode

; B = the chosen tile ($BC) for the vault choice. (C1, E-0357)
VaultMenu_BGMapAddressAtScroll_Bank1D::
    ld b, $bc

; Writes tile B at vault choice wVaultMode's place. (C1, E-0357)
VaultMenu_BGMapAddressAtScroll_Bank1D_ReadVaultMode::
    ld a, [wVaultMode]
    add a
    ld hl, VaultMenu_BGMapAddressAtScroll_Bank1D_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by VaultMenu (6 bytes) (E-0347)
VaultMenu_BGMapAddressAtScroll_Bank1D_Data::
    db $61, $00, $a1, $00, $e1, $00

; draws rect $0088 (9 x 12) at vBGMap1 + $370 (SaveBGMapRectWithAttrs) and wScreenStep += 1 (E-0122)
DrawRect0088AtBGMap1370AndStep::
    ld hl, $0088
    ld de, vBGMap1 + $370
    lb bc, $09, $0c
    call SaveBGMapRectWithAttrs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws rect $0140 (3 x 7) at vBGMap1 + $3E0; in state 3 also runs
; ListDistinctInventoryItemsToItemGrid and RunUnlessScreenStateIs3; wScreenStep += 1 (E-0122)
DrawRect0140AtBGMap13E0AndStep::
    ld hl, $0140
    ld de, vBGMap1 + $3e0
    lb bc, $03, $07
    call SaveBGMapRectWithAttrs
    ld a, [wScreenState]
    cp $03
    jr nz, .check_screen_step
    farcall ListDistinctInventoryItemsToItemGrid
    farcall RunUnlessScreenStateIs3

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Storing, step 7: draws the 12 x 9 item window (with page brackets when two or more pages) and on
; the GBC clears its attributes. (C1, E-0357)
VaultMenu_Store_DrawRectSetTextCursorLoPlus21_Bank1D::
    ld a, $01
    ld [wArg1], a
    call VaultMenu_Store_CountNonZeroItemGridBytes
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank1_d
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, VaultMenu_Store_DrawRectSetTextCursorLoPlus21_Bank1D_TileRect
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D
    jr .check_is_cgb

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, VaultMenu_Store_DrawRectSetTextCursorLoPlus21_Bank1D_2
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D

.check_is_cgb:
    pop hl
    ld a, [wIsCGB]
    and a
    jr nz, .skip
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld bc, $0000

.loop:
    push hl

.loop2:
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a
    ld [hli], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp $0c
    jr c, .loop2
    pop hl
    ld c, $00
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc b
    ld a, b
    cp $09
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 9 tiles, one row per line
VaultMenu_Store_DrawRectSetTextCursorLoPlus21_Bank1D_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c7, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff, $c8, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $c9, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $d8, $d9, $da, $db, $dc, $dd, $de, $aa, $ca, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $c5, $c3, $c3, $be, $c3, $c3, $c6, $b5 ; id 8

VaultMenu_Store_DrawRectSetTextCursorLoPlus21_Bank1D_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c7, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff, $c8, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $c9, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $d8, $d9, $da, $db, $dc, $dd, $de, $aa, $ca, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; Storing, step 8: with two or more pages draws the page numbers (page / pages, a leading blank for
; one digit). (C1, E-0357)
VaultMenu_Store_HLToDecimalDigits::
    xor a
    ld [wArg1], a
    call VaultMenu_Store_CountNonZeroItemGridBytes
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr nz, .check_saved_sprite_slot_count
    ld a, $e3
    ld [wDigits + $1], a

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .check_screen_step
    call BGMapAddressAtScroll_Bank1D
    ld de, $0190
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    inc hl
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, $e3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $018d
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ei

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; C = the number of non-zero bytes among the $18 bytes at wItemGrid (E-0122)
CountNonZeroItemGridBytes::
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp $18
    jr c, .loop
    ret

; Counts the stored items (100 two-byte slots) into wSavedSpriteClipMode and the bag's items into
; wListPages. (C1, E-0357)
VaultMenu_WriteSavedSpriteClipModeAndListPages::
    ld hl, wItemStorage
    ld c, $00
    ld b, $00

.loop:
    ld a, [hl]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc c

.next:
    inc hl
    inc hl
    inc b
    ld a, b
    cp $64
    jr c, .loop
    ld a, c
    ld [wSavedSpriteClipMode], a
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop2:
    ld a, [hl]
    and a
    jr z, .next2
    cp $ff
    jr z, .next2
    inc c

.next2:
    inc hl
    inc b
    ld a, b
    cp $18
    jr c, .loop2
    ld a, c
    ld [wListPages], a
    ret

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; BlinkCursorSelectedRecord_Bank1D)
BlinkCursorSelectedRecord_Bank1D::
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp $10
    jr c, .skip
    cp $18
    jr c, VaultMenu_Store_ReadItemGridX
    xor a
    ld [wSelectedRecord], a

.skip:
    ld b, $bb
    jr VaultMenu_Store_ReadItemGridX_ReadItemGridX

; Draws the blank tile ($C3) at item cursor wItemGridX. (C1, E-0357)
VaultMenu_Store_ReadItemGridX::
    ld b, $c3
    jr VaultMenu_Store_ReadItemGridX_ReadItemGridX
    db $06, $bc

; Writes tile B at item cursor wItemGridX's place. (C1, E-0357)
VaultMenu_Store_ReadItemGridX_ReadItemGridX::
    ld a, [wItemGridX]
    add a
    ld hl, VaultMenu_Store_ReadItemGridX_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by VaultMenu (8 bytes) (E-0347)
VaultMenu_Store_ReadItemGridX_Data::
    db $a9, $00, $e9, $00, $29, $01, $69, $01

; Storing, step 10: draws the count beside the chosen item: in the bag the number of copies held, in
; storage the stored count of that item. (C1, E-0357)
VaultMenu_Store_WriteDigitsAndDigitWorkAEtc::
    ld hl, VaultMenu_Store_WriteDigitsAndDigitWorkAEtc_Data
    ld de, wScreenList
    ld c, $00

.loop:
    ld a, [hli]
    ld [de], a
    inc c
    inc de
    ld a, c
    cp $15
    jr c, .loop
    ld a, [wScreenState]
    cp $03
    jp z, .read_item_grid_y
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a
    add_a_to_hl
    ld e, [hl]
    ld hl, wItemStorage
    ld bc, $0000

.loop2:
    ld a, [hl]
    cp e
    jr nz, .next
    and a
    jr z, .next
    inc hl
    ld c, [hl]
    jr .skip

.next:
    inc b
    inc hl
    inc hl
    ld a, b
    cp $64
    jr c, .loop2
    ld c, $00
    jr .skip

.read_item_grid_y:
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld e, [hl]
    ld hl, wInventory
    ld bc, $0000

.loop3:
    ld a, [hl]
    cp e
    jr nz, .next2
    and a
    jr z, .next2
    cp $ff
    jr z, .next2
    inc c

.next2:
    inc b
    inc hl
    ld a, b
    cp $18
    jr c, .loop3

.skip:
    ld a, c
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr nz, .read_digits
    ld a, $e3
    ld [wDigits + $1], a

.read_digits:
    ld a, [wDigits + $1]
    add $e0
    ld [wDigitWorkA], a
    ld a, [wDigits + $2]
    add $e0
    ld [wDigitWorkB], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    lb bc, $07, $03
    ld de, wScreenList
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wIsCGB]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0000

.loop4:
    push hl

.loop5:
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a
    ld [hli], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp $07
    jr c, .loop5
    pop hl
    ld c, $00
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc b
    ld a, b
    cp $03
    jr c, .loop4
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; data read by VaultMenu (21 bytes) (E-0347)
VaultMenu_Store_WriteDigitsAndDigitWorkAEtc_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $c3, $be, $c3, $c3, $b7, $b3, $b4
    db $b4, $b4, $b4, $b4, $b5

; Storing, step 11: the item cursor: Select (RunUnlessScreenStateIs3) back four steps; Right/Left
; turn the page; Up/Down move; A picks; B leaves with answer 2 and resumes the script. (C1, E-0357)
VaultMenu_Store_BlinkCursorSelectedRecord_Bank1D_2::
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_run_unless_screen_state_is3
    bit 4, a
    jr nz, .check_saved_sprite_slot_count
    bit 5, a
    jr nz, .check_saved_sprite_slot_count2
    bit 6, a
    jp nz, .call_draw_blank_tile_c3_bank1_d_2
    bit 7, a
    jp nz, .call_draw_blank_tile_c3_bank1_d_22
    bit 0, a
    jp nz, .call_queue_sound_effect
    call BlinkCursorSelectedRecord_Bank1D_2
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_run_unless_screen_state_is3:
    farcall RunUnlessScreenStateIs3
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.loop:
    call BlinkCursorSelectedRecord_Bank1D_2
    ret

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .loop
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp b
    jr c, .set_item_grid_y
    xor a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, [wScreenStep]
    dec a
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_sprite_slot_count2:
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .loop
    ld a, [wItemGridY]
    and a
    jr nz, .skip
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.call_draw_blank_tile_c3_bank1_d_2:
    call DrawBlankTileC3_Bank1D_2
    ld a, [wItemGridX]
    and a
    jr nz, .set_item_grid_x
    ld a, [wMenuChoice]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a
    call DrawCursorTileBB_Bank1D_2
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_bank1_d_22:
    call DrawBlankTileC3_Bank1D_2
    ld a, [wMenuChoice]
    ld b, a
    ld a, [wItemGridX]
    cp b
    jr c, .set_item_grid_x3
    xor a
    jr .set_item_grid_x4

.set_item_grid_x3:
    inc a

.set_item_grid_x4:
    ld [wItemGridX], a
    call DrawCursorTileBB_Bank1D_2
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_Store_BGMapAddressAtScroll_Bank1D
    ld a, [wScreenState]
    cp $04
    jr z, .check_screen_step
    call VaultMenu_Store_ReadItemGridYAndItemGridX
    and a
    jr z, .check_screen_step
    cp $fe
    jr z, .set_two_choice_cursor_to_03
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld a, [wScreenState]
    cp $04
    jr z, .call_split_item_storage_entry_into_digits
    farcall CountItemInInventoryToDigits
    jr .call_draw_number_tens_number_ones_digits_at

.call_split_item_storage_entry_into_digits:
    call SplitItemStorageEntryIntoDigits

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtScroll161
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was BlinkCursorSelectedRecord_Bank1D_2)
BlinkCursorSelectedRecord_Bank1D_2::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank1D_2
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp $10
    jr c, DrawCursorTileBB_Bank1D_2
    cp $18
    jr c, DrawBlankTileC3_Bank1D_2
    xor a
    ld [wSelectedRecord], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawCursorTileBB_Bank1D_2)
DrawCursorTileBB_Bank1D_2::
    ld b, $bb
    jr VaultMenu_Store_BGMapAddressAtScroll_Bank1D_ReadItemGridX

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1D_2)
DrawBlankTileC3_Bank1D_2::
    ld b, $c3
    jr VaultMenu_Store_BGMapAddressAtScroll_Bank1D_ReadItemGridX

; B = the chosen tile ($BC) for the item cursor. (C1, E-0357)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D::
    ld b, $bc

; Writes tile B at item cursor wItemGridX's place
; (VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data). (C1, E-0357)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_ReadItemGridX::
    ld a, [wItemGridX]
    add a
    ld hl, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by VaultMenu (8 bytes) (E-0347)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data::
    db $a9, $00, $e9, $00, $29, $01, $69, $01

; For the chosen bag item: 0 when storage has room for it (a slot with fewer than 99, or a free
; slot), $FE when its slot is full (99), $FF when all 100 slots hold other items. (C1, E-0357)
VaultMenu_Store_ReadItemGridYAndItemGridX::
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld b, [hl]
    ld hl, wItemStorage
    ld c, $00

.loop:
    ld a, [hl]
    cp b
    jr z, .next
    and a
    jr z, .return_0
    inc hl
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop
    ld a, $ff
    ret

.next:
    inc hl
    ld a, [hl]
    cp $63
    jr c, .return_0
    ld a, $fe
    ret

.return_0:
    xor a
    ret

; Storing, step 13: the quantity entry: B clears the box and returns to the item cursor (answer 2,
; step $0B); Right/Left move between the digits; Up/Down change the digit, at most the count
; available (wCountTens/wCountOnes); A goes on; the digit cursor blinks. (C1, E-0357)
VaultMenu_Store_BlinkCursorBlinkCD_Bank1D::
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_02
    bit 4, a
    jr nz, .call_vault_menu_store_bg_map_address_at
    bit 5, a
    jr nz, .call_vault_menu_store_bg_map_address_at2
    bit 6, a
    jp nz, .call_queue_sound_effect
    bit 7, a
    jp nz, .call_queue_sound_effect2
    bit 0, a
    jp nz, .call_vault_menu_store_bg_map_address_at3
    call BlinkCursorBlinkCD_Bank1D
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $0b
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [hli], a
    ld [hl], a
    ei
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_vault_menu_store_bg_map_address_at:
    call VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2
    ld a, [wNumberEditPos]
    cp $01
    jr nz, .set_number_edit_pos
    xor a
    jr .set_number_edit_pos2

.set_number_edit_pos:
    inc a

.set_number_edit_pos2:
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1D
    ld a, $69
    call QueueSoundEffect
    ret

.call_vault_menu_store_bg_map_address_at2:
    call VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2
    ld a, [wNumberEditPos]
    and a
    jr nz, .skip
    ld a, $01
    jr .set_number_edit_pos2

.skip:
    dec a
    jr .set_number_edit_pos2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a
    jr nz, .read_count_tens
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
    jr c, .set_number_tens
    ld a, b
    ld [wNumberTens], a
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.loop:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp b
    jr c, .call_draw_number_tens_number_ones_digits_at
    ld a, b
    ld [wNumberOnes], a

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.set_number_tens:
    inc a
    ld [wNumberTens], a
    push af
    ld a, [wCountTens]
    ld b, a
    pop af
    cp b
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1D
    ret

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
    jr c, .check_number_ones
    ld a, [wCountOnes]
    ld b, a
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp b
    jr c, .set_number_ones2
    ld a, [wCountOnes]
    cp b
    jr nz, .check_number_tens
    call BlinkCursorBlinkCD_Bank1D
    ret

.check_number_tens:
    ld a, [wNumberTens]
    and a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a

.set_number_ones:
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D
    ret

.set_number_ones2:
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a
    jr nz, .check_number_tens2
    ld a, [wNumberTens]
    and a
    jr nz, .set_number_tens2
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp b
    jr c, .read_count_tens2
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.read_count_tens2:
    ld a, [wCountTens]
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1D
    ret

.set_number_tens2:
    dec a
    ld [wNumberTens], a
    ld b, a
    ld a, [wNumberOnes]
    or b
    jr nz, .call_blink_cursor_blink_cd_bank1_d
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.call_blink_cursor_blink_cd_bank1_d:
    call BlinkCursorBlinkCD_Bank1D
    ret

.check_number_tens2:
    ld a, [wNumberTens]
    and a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp $01
    jr nz, .set_number_ones3
    jr .read_count_tens3

.check_number_ones3:
    ld a, [wNumberOnes]
    and a
    jr nz, .set_number_ones3

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
    jr c, .set_number_ones_to_09
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.set_number_ones_to_09:
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D
    ret

.set_number_ones3:
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1D
    ret

.call_vault_menu_store_bg_map_address_at3:
    call VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2
    ld a, [wNumberTens]
    and a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a
    ret z

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    cp $03
    jr z, .call_vault_menu_store_write_text_counter1_and
    call CheckListPagesPlusNumberAtMost18
    and a
    jr z, .clear_two_choice_cursor
    jr .set_two_choice_cursor_to_01

.call_vault_menu_store_write_text_counter1_and:
    call VaultMenu_Store_WriteTextCounter1AndTextCounter3
    and a
    jr z, .clear_two_choice_cursor

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was BlinkCursorBlinkCD_Bank1D)
BlinkCursorBlinkCD_Bank1D::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp $10
    jr c, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2
    cp $18
    jr c, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2_Skip
    xor a
    ld [wCursorBlinkCD], a

; Draws the edited quantity digit ($E0 + tens or ones) at its place. (C1, E-0357)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2::
    ld a, [wNumberEditPos]
    and a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add $e0
    ld b, a
    jr VaultMenu_Store_ReadNumberEditPos

; B = the digit cursor tile ($CB). (C1, E-0357)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_2_Skip::
    ld b, $cb

; Writes tile B at digit place wNumberEditPos. (C1, E-0357)
VaultMenu_Store_ReadNumberEditPos::
    ld a, [wNumberEditPos]
    add a
    ld hl, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data_2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by VaultMenu_Store_ReadNumberEditPos (4 bytes) (E-0347)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data_2::
    db $61, $01, $62, $01

; writes wNumberTens and wNumberOnes as digit tiles ($E0 + n) at BGMapAddressAtScroll_Bank1D + $161
; and + $162 (E-0120)
DrawNumberTensNumberOnesDigitsAtScroll161::
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    ld a, [wNumberTens]
    add $e0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    call BGMapAddressAtScroll_Bank1D
    ld de, $0162
    add hl, de
    ld a, [wNumberOnes]
    add $e0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; A = $FF when wListPages + TenTimesNumberTensPlusNumberOnes exceeds $18, else 0 (E-0122)
CheckListPagesPlusNumberAtMost18::
    call TenTimesNumberTensPlusNumberOnes
    ld a, [wListPages]
    add l
    cp $18
    jr c, .return_0
    jr z, .return_0
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; Adds the quantity of the chosen bag item to storage: to its slot, or a new slot after the used
; ones; $FF (nothing changed) when the slot would reach 100 or more. (C1, E-0357)
VaultMenu_Store_WriteTextCounter1AndTextCounter3::
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld b, [hl]
    ld hl, wItemStorage
    xor a
    ld [wTextCounter1], a
    ld c, $00

.loop:
    ld a, [hli]
    cp b
    jr z, .skip
    and a
    jr z, .next
    ld a, [wTextCounter1]
    inc a
    ld [wTextCounter1], a

.next:
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop
    ld hl, wItemStorage
    ld a, [wTextCounter1]
    add a
    add_a_to_hl
    ld a, b
    ld [hli], a

.skip:
    ld a, [hl]
    push hl
    ld b, a
    call TenTimesNumberTensPlusNumberOnes
    ld a, l
    add b
    cp $64
    jr nc, .clear_text_counter1
    pop hl
    ld [hl], a
    dec hl
    ld a, [hl]
    ld [wTextCounter3], a
    xor a
    ld [wTextCounter1], a
    ret

.clear_text_counter1:
    pop hl
    xor a
    ld [wTextCounter1], a
    ld a, $ff
    ret

; Taking out the quantity of the chosen stored item: takes it from its slot (clearing the slot at 0)
; and puts the copies in the bag's free places; then answers 0 when the bag is full, 1 when storage
; is empty, otherwise 2. (C1, E-0357)
VaultMenu_Store_TenTimesNumberTensPlusNumberOnes::
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, a
    push hl
    call TenTimesNumberTensPlusNumberOnes
    ld e, l
    pop hl
    push de
    ld a, [hl]
    sub e
    ld [hl], a
    pop de
    and a
    jr nz, .skip
    dec hl
    xor a
    ld [hl], a

.skip:
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .skip2
    cp $ff
    jr z, .skip2
    jr .next

.skip2:
    ld a, b
    ld [hl], a
    dec e

.next:
    inc hl
    inc c
    ld a, e
    and a
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    ld a, c
    cp $18
    jr c, .loop

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wListPages]
    cp $18
    jr c, .check_saved_sprite_clip_mode
    xor a
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_ClearTextCounter1

.check_saved_sprite_clip_mode:
    ld a, [wSavedSpriteClipMode]
    and a
    jr nz, .set_two_choice_cursor_to_02
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_ClearTextCounter1

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_ClearTextCounter1

; After storing: answers 0 when the bag is empty, 1 when storage holds 9,900 or more items in all,
; otherwise 2; then the next step. (C1, E-0357)
VaultMenu_Store_WriteTwoChoiceCursorAndTextCounter1Etc::
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    jr .skip

.next:
    inc hl
    inc c
    ld a, c
    cp $18
    jr c, .loop
    xor a
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_ClearTextCounter1

.skip:
    ld hl, wItemStorage
    ld de, $0000
    ld c, $00

.loop2:
    inc hl
    ld a, [hl]
    add e
    ld e, a
    jr nc, .next2
    inc d

.next2:
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop2
    ld a, d
    cp $26
    jr c, .skip2
    ld a, e
    cp $ac
    jr c, .skip2
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr VaultMenu_Store_ClearTextCounter1

.skip2:
    ld hl, wItemStorage
    ld c, $00

.loop3:
    ld a, [hl]
    and a
    jr z, .set_two_choice_cursor_to_02
    ld b, a
    ld a, [wTextCounter3]
    cp b
    jr nz, .next3
    inc hl
    ld a, [hl]
    cp $63
    jr c, .set_two_choice_cursor_to_02

.next3:
    inc hl
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop3

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a

; Clears the counters, toggles wCounterPtr0Lo, refreshes the lists (RunUnlessScreenStateIs3) and
; goes on. (C1, E-0357)
VaultMenu_Store_ClearTextCounter1::
    xor a
    ld [wTextCounter1], a
    ld [wTextCounter3], a
    ld a, [wCounterPtr0Lo]
    inc a
    and $01
    ld [wCounterPtr0Lo], a
    farcall RunUnlessScreenStateIs3
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; two $FF-terminated lists holding the numbers $01-$62 in two different orders; no reader was found,
; directly or by a computed base (E-0227, C1)
; record: 95 numbers, then $FF
OrderList1D_1::
    db $21, $28, $29, $2a, $2e, $1f, $20, $2b, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $19, $1a, $1b, $1c, $1d, $1e, $13, $14, $15, $16, $17, $18, $0d, $0e, $0f, $10, $11, $12, $2c, $2d, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $22, $23, $24, $25, $26, $27, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d ; entry 0
    db $ff ; end

OrderList1D_2::
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $22, $23, $24, $25, $26, $27, $19, $1a, $1b, $1c, $1d, $1e, $13, $14, $15, $16, $17, $18, $0d, $0e, $0f, $10, $11, $12, $2c, $2d, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $21, $28, $29, $2a, $2e, $1f, $20, $2b, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d ; entry 0
    db $ff ; end

; writes $80 zero bytes from $9700 with interrupts off around each VRAM wait (WaitForVRAMAccess); no
; caller found (E-0227)
ClearVRAM9700Block_Unreferenced:: ; configured code entry (E-0227); C0
    ld hl, vTiles2 + $700
    ld bc, $0080

.loop:
    di
    call WaitForVRAMAccess
    xor a
    ld [hli], a
    ei
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Storing, step 15: with answer 2 (more to do) returns to the item list (step 7) with the cursor
; reset and the count cleared; otherwise goes on; the script resumes. (C1, E-0357)
VaultMenu_Store_WriteScreenStepAndScriptCommandTypeEtc::
    ld a, [wTwoChoiceCursor]
    cp $02
    jr z, .set_screen_step_to_07
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_07:
    ld a, $07
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [hli], a
    ld [hl], a
    ei
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws rect $0147 (3 x 13) at vBGMap1 + $370, wScreenStep += 1, clears wCursorBlinkCD-wThreeDigits
; + $2 and sets wNumberEditPos = 2 (E-0122)
DrawRect0147AndResetNumberEditPos::
    ld hl, $0147
    ld de, vBGMap1 + $370
    lb bc, $03, $0d
    call SaveBGMapRectWithAttrs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wCursorBlinkCD], a
    ld [wThreeDigits], a
    ld [wThreeDigits + $1], a
    ld [wThreeDigits + $2], a
    ld a, $02
    ld [wNumberEditPos], a
    ret

; Draws the banked gold (six digits, leading blanks) in its 9 x 3 box at the screen's row 10, column
; 11. (C1, E-0357)
VaultMenu_Store_Number24ToPackedBCD::
    ld hl, wScreenList
    ld de, VaultMenu_Store_Number24ToPackedBCD_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $27
    jr c, .loop
    ld hl, wBankedGoldLo
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and $f0
    swap a
    ld [wSharedMenuWork], a
    ldh a, [hTemp2]
    and $0f
    ld [wListEntries2], a
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wMenuWordBuf], a
    ldh a, [hTemp1]
    and $0f
    ld [wMenuWordBuf1], a
    ldh a, [hTemp0]
    and $f0
    swap a
    ld [wMenuWordBuf2], a
    ldh a, [hTemp0]
    and $0f
    ld [wTextCounter0], a
    ld hl, wSharedMenuWork
    ld c, $00

.loop2:
    ld a, [hl]
    and a
    jr nz, .skip
    add $e3
    ld [hl], a
    inc c
    inc hl
    ld a, c
    cp $05
    jr c, .loop2

.skip:
    ld hl, wSharedMenuWork
    ld de, wDigitWorkA
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $014b
    add hl, de
    ld de, wScreenList
    lb bc, $09, $03
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wIsCGB]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_d
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $014b
    add hl, de
    ld bc, $0000

.loop3:
    push hl

.loop4:
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a
    ld [hli], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp $09
    jr c, .loop4
    pop hl
    ld c, $00
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc b
    ld a, b
    cp $03
    jr c, .loop3
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; data read by VaultMenu (27 bytes) (E-0347)
VaultMenu_Store_Number24ToPackedBCD_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $bf, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; Storing gold, step 20: draws the amount box with the three digits of the amount (wThreeDigits);
; for depositing the limit is the gold in hand, for withdrawing the banked gold (at most 99,900,
; shown as 999). (C1, E-0357)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_3::
    ld hl, wScreenList
    ld de, VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data_3
    ld c, $00

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $10
    jr c, .loop
    ld a, [wThreeDigits]
    add $e0
    ld [wGrid2CursorX], a
    ld a, [wThreeDigits + $1]
    add $e0
    ld [wGrid2CursorY], a
    ld a, [wThreeDigits + $2]
    add $e0
    ld [wScreenArea], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $006c
    add hl, de
    ld de, wScreenList
    lb bc, $08, $02
    call DrawRectSetTextCursorLoPlus21_Bank1D
    ld a, [wScreenState]
    cp $03
    jp nz, .check_banked_gold_hi
    ld hl, wGoldLo
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and $0f
    ld [wCountTens], a
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wCountOnes], a
    ldh a, [hTemp1]
    and $0f
    ld [wItemGrid], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_banked_gold_hi:
    ld a, [wBankedGoldHi]
    cp $01
    jr c, .set_digits
    jr nz, .set_count_tens_to_09
    ld a, [wBankedGoldMid]
    cp $86
    jr c, .set_digits
    jr nz, .set_count_tens_to_09
    ld a, [wBankedGoldLo]
    cp $3c
    jr c, .set_digits
    jr z, .set_digits

.set_count_tens_to_09:
    ld a, $09
    ld [wCountTens], a
    ld [wCountOnes], a
    ld [wItemGrid], a
    jp .check_screen_step

.set_digits:
    ld hl, wBankedGoldLo
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and $0f
    ld [wCountTens], a
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wCountOnes], a
    ldh a, [hTemp1]
    and $0f
    ld [wItemGrid], a
    jp .check_screen_step

; data read by VaultMenu_Store_BGMapAddressAtScroll_Bank1D_3 (16 bytes) (E-0347)
VaultMenu_Store_BGMapAddressAtScroll_Bank1D_Data_3::
    db $b6, $bf, $c3, $c3, $c3, $e0, $e0, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; Storing gold, step 21: the amount entry (VaultMenu_WriteNumberEditPosAndThreeDigitsEtc); B goes on
; with answer 2; on A with a non-zero amount, turns the three digits into gold (x 10,000, 1,000 and
; 100) and adds the banked gold: a total of 999,901 or more is refused (wTwoChoiceCursor = 1). (C1,
; E-0357)
VaultMenu_Store_WriteScreenStepAndTwoChoiceCursorEtc::
    call VaultMenu_WriteNumberEditPosAndThreeDigitsEtc
    and a
    ret z
    cp $01
    jr z, .call_draw_three_digits_at_scroll_offset6_e
    cp $02
    jr z, .check_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $1]
    and a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $2]
    and a
    jr nz, .read_three_digits
    ret

.read_three_digits:
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03e8
    call Multiply8By16

.skip:
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add l
    ld l, a
    ld a, h
    adc c
    ld h, a
    ld a, b
    adc e
    ld e, a
    inc d
    ld a, d
    cp $02
    jr nc, .read_banked_gold_lo
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr .skip

.read_banked_gold_lo:
    push de
    push hl
    ld a, [wBankedGoldLo]
    add l
    ld l, a
    ld a, [wBankedGoldMid]
    adc h
    ld h, a
    ld a, [wBankedGoldHi]
    adc e
    ld e, a
    ld a, e
    cp $0f
    jr c, .set_banked_gold_hi
    jr nz, .restore
    ld a, h
    cp $41
    jr c, .set_banked_gold_hi
    jr nz, .restore
    ld a, l
    cp $dd
    jr c, .set_banked_gold_hi

.restore:
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_banked_gold_hi:
    ld a, e
    ld [wBankedGoldHi], a
    ld a, h
    ld [wBankedGoldMid], a
    ld a, l
    ld [wBankedGoldLo], a
    pop hl
    pop de
    ld a, [wGoldLo]
    sub l
    ld l, a
    ld a, [wGoldMid]
    sbc h
    ld h, a
    ld a, [wGoldHi]
    sbc e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Taking out gold, step 21: as storing, but the amount is added to the gold in hand, and a total
; over 99,999 is refused (wTwoChoiceCursor = 1). (C1, E-0357)
VaultMenu_TakeOut_WriteScreenStepAndTwoChoiceCursorEtc_2::
    call VaultMenu_WriteNumberEditPosAndThreeDigitsEtc
    and a
    ret z
    cp $01
    jr z, .call_draw_three_digits_at_scroll_offset6_e
    cp $02
    jr z, .check_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wThreeDigits]
    and a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $1]
    and a
    jr nz, .read_three_digits
    ld a, [wThreeDigits + $2]
    and a
    jr nz, .read_three_digits
    ret

.read_three_digits:
    ld a, [wThreeDigits]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wThreeDigits + $1]
    ld bc, $03e8
    call Multiply8By16

.skip:
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add l
    ld l, a
    ld a, h
    adc c
    ld h, a
    ld a, b
    adc e
    ld e, a
    inc d
    ld a, d
    cp $02
    jr nc, .read_gold_lo
    push de
    push hl
    ld a, [wThreeDigits + $2]
    ld bc, $0064
    call Multiply8By16
    jr .skip

.read_gold_lo:
    push de
    push hl
    ld a, [wGoldLo]
    add l
    ld l, a
    ld a, [wGoldMid]
    adc h
    ld h, a
    ld a, [wGoldHi]
    adc e
    ld e, a
    ld a, e
    cp $01
    jr c, .set_gold_hi
    jr nz, .restore
    ld a, h
    cp $86
    jr c, .set_gold_hi
    jr nz, .restore
    ld a, l
    cp $9f
    jr c, .set_gold_hi
    jr z, .set_gold_hi

.restore:
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_gold_hi:
    ld a, e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    pop hl
    pop de
    ld a, [wBankedGoldLo]
    sub l
    ld l, a
    ld a, [wBankedGoldMid]
    sbc h
    ld h, a
    ld a, [wBankedGoldHi]
    sbc e
    ld [wBankedGoldHi], a
    ld a, h
    ld [wBankedGoldMid], a
    ld a, l
    ld [wBankedGoldLo], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The three-digit amount entry: A answers 1, B 2; Up/Down raise or lower the digit at wNumberEditPos
; (wrapping 9 to 0), keeping the amount within the limit digits wCountTens / wCountOnes / wItemGrid;
; Right/Left move between the digits; otherwise the cursor blinks; 0 while editing. (C1, E-0357)
VaultMenu_WriteNumberEditPosAndThreeDigitsEtc::
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .return_02
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_queue_sound_effect2
    bit 7, a
    jp nz, .call_queue_sound_effect3
    bit 4, a
    jp nz, .call_queue_sound_effect4
    bit 5, a
    jp nz, .call_queue_sound_effect5
    call VaultMenu_WriteCursorBlinkCD
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

.return_02:
    ld a, $02
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a
    jr z, .read_count_tens
    cp $01
    jp z, .read_count_tens2
    jp .read_count_tens3

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .set_three_digits
    jr z, .read_count_ones
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wThreeDigits + $1]
    ld b, a
    ld a, [wCountOnes]
    cp b
    jr nc, .call_draw_three_digits_at_scroll_offset6_e
    ld [wThreeDigits + $1], a
    ld a, [wThreeDigits + $2]
    ld b, a
    ld a, [wItemGrid]
    cp b
    jr nc, .call_draw_three_digits_at_scroll_offset6_e
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e:
    call DrawThreeDigitsAtScrollOffset6E
    xor a
    ret

.read_count_ones:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr nc, .read_count_ones2

.read_count_ones2:
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    jr .call_draw_three_digits_at_scroll_offset6_e

.set_three_digits:
    inc a
    ld [wThreeDigits], a
    call VaultMenu_WriteThreeDigits
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.read_count_tens2:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr nc, .read_count_ones3
    ld a, [wThreeDigits + $1]
    cp $09
    jr c, .loop
    xor a
    ld [wThreeDigits + $1], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.loop:
    inc a
    ld [wThreeDigits + $1], a
    call VaultMenu_WriteThreeDigits
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.read_count_ones3:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr c, .loop
    ld [wCountOnes], a
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a
    ret

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .check_three_digits
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr c, .check_three_digits
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp b
    jr c, .set_three_digits2
    ld a, b
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.check_three_digits:
    ld a, [wThreeDigits + $2]
    cp $09
    jr c, .set_three_digits2
    xor a
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.set_three_digits2:
    inc a
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a
    jr z, .check_three_digits2
    cp $01
    jp z, .read_count_tens4
    jp .read_count_tens5

.check_three_digits2:
    ld a, [wThreeDigits]
    and a
    jr nz, .set_three_digits3
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a
    ret

.set_three_digits3:
    dec a
    ld [wThreeDigits], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.read_count_tens4:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .check_three_digits3
    ld a, [wThreeDigits + $1]
    and a
    jr nz, .set_three_digits4
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp b
    jr c, .call_draw_three_digits_at_scroll_offset6_e2
    jr z, .call_draw_three_digits_at_scroll_offset6_e2
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e2:
    call DrawThreeDigitsAtScrollOffset6E
    xor a
    ret

.check_three_digits3:
    ld a, [wThreeDigits + $1]
    and a
    jr nz, .set_three_digits4
    ld a, $09
    ld [wThreeDigits + $1], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.set_three_digits4:
    dec a
    ld [wThreeDigits + $1], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.read_count_tens5:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .check_three_digits4
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr c, .check_three_digits4
    ld a, [wThreeDigits + $2]
    and a
    jr nz, .set_three_digits5
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.check_three_digits4:
    ld a, [wThreeDigits + $2]
    and a
    jr nz, .set_three_digits5
    ld a, $09
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.set_three_digits5:
    dec a
    ld [wThreeDigits + $2], a
    call VaultMenu_WriteCursorBlinkCD
    xor a
    ret

.call_queue_sound_effect4:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    cp $02
    jr nc, .read_count_tens6
    inc a
    ld [wNumberEditPos], a
    jr .read_count_tens6

.call_queue_sound_effect5:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a
    jr z, .read_count_tens6
    dec a
    ld [wNumberEditPos], a

.read_count_tens6:
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp b
    jr c, .call_draw_three_digits_at_scroll_offset6_e3
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a

.call_draw_three_digits_at_scroll_offset6_e3:
    call DrawThreeDigitsAtScrollOffset6E
    xor a
    ret

; Blinks the amount cursor once the pad has been still for 20 frames: the digit for 16 counts, the
; cursor tile $CB for 8; drawn at digit place wNumberEditPos. (C1, E-0357)
VaultMenu_WriteCursorBlinkCD::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .read_number_edit_pos
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp $10
    jr c, .read_number_edit_pos
    cp $18
    jr c, .read_number_edit_pos2
    xor a
    ld [wCursorBlinkCD], a

.read_number_edit_pos:
    ld hl, wThreeDigits
    ld a, [wNumberEditPos]
    add_a_to_hl
    ld a, [hl]
    add $e0
    ld b, a
    jr .read_number_edit_pos3

.read_number_edit_pos2:
    ld b, $cb

.read_number_edit_pos3:
    ld a, [wNumberEditPos]
    add a
    ld hl, VaultMenu_WriteCursorBlinkCD_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by VaultMenu (6 bytes) (E-0347)
VaultMenu_WriteCursorBlinkCD_Data::
    db $6e, $00, $6f, $00, $70, $00

; writes the three bytes at wThreeDigits as digit tiles ($E0 + digit) at the BG map entry
; BGMapAddressAtScroll_Bank1D + $6E (row 3, column 14 of the view), one per byte with
; WaitForVRAMAccess (E-0104)
DrawThreeDigitsAtScrollOffset6E::
    call BGMapAddressAtScroll_Bank1D
    ld de, $006e
    add hl, de
    ld de, wThreeDigits
    ld c, $00

.loop:
    ld a, [de]
    add $e0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hli], a
    ei
    inc de
    inc c
    ld a, c
    cp $03
    jr c, .loop
    ret

; takes the byte at wItemStorage + 8 * wItemGridY + 2 * wItemGridX + 1 and stores its value / 10 in
; wCountTens and value mod 10 in wCountOnes (E-0120)
SplitItemStorageEntryIntoDigits::
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add a
    add_a_to_hl
    inc hl
    ld l, [hl]
    ld h, $00
    ld a, $0a
    call DivideHLByA
    ld [wCountOnes], a
    ld a, l
    ld [wCountTens], a
    ret

; copies a B x C rectangle of the BG map at scroll + HL (and its CGB attributes) to DE (E-0127)
SaveBGMapRectWithAttrs::
    push bc
    push de
    push hl
    call BGMapAddressAtScroll_Bank1D
    ld e, l
    ld d, h
    pop hl
    add hl, de
    pop de
    pop bc
    ld a, c
    ld [wListCursorBlink], a
    push hl
    push hl

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a
    jr z, .next
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc

.next:
    inc hl
    inc de
    dec c
    jp nz, .loop
    ld a, [wListCursorBlink]
    ld c, a
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    dec b
    jp nz, .loop
    pop hl
    pop hl
    ret

; for each inventory item finds a matching or free wItemStorage slot (100 two-byte slots) (E-0305)
VaultMenu_Store_FindStorageSlots::
    ld hl, wItemStorage
    ld de, wInventory
    ld bc, $0000

.loop:
    ld a, [de]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    push bc
    ld b, a
    ld c, $00
    ld a, [hl]
    cp b
    jr z, .next2
    and a
    jp z, .done
    pop bc
    inc hl
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop
    ld hl, wItemStorage

.next:
    inc de
    ld c, $00
    inc b
    ld a, b
    cp $18
    jr c, .loop

.return_FF:
    ld a, $ff
    ret

.next2:
    inc hl
    ld a, [hl]
    cp $63
    jr c, .done
    pop bc
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop
    ld hl, wItemStorage
    inc de
    ld c, $00
    inc b
    ld a, b
    cp $18
    jr c, .loop
    jr .return_FF

.done:
    pop bc
    xor a
    ret

; A = 0 when one of the 100 two-byte entries at wItemStorage has a non-zero first byte, else $FF
; (E-0124)
ItemStorageHasNonZeroEntry::
    ld hl, wItemStorage
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr nz, .return_0
    inc hl
    inc hl
    inc c
    ld a, c
    cp $64
    jr c, .loop
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank1D::
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

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets
; wTextCursorLo = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2
; switched in (E-0121; a copy, not a clear: E-0226)
DrawRectBothBanksSetTextCursorLoPlus1C1_Bank1D::
    push de
    push bc
    push hl
    xor a
    call CopyRectToBGMapWrapped_Bank1D
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
    xor a
    call CopyRectToBGMapWrapped_Bank1D
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_Bank1D) and sets
; wTextCursorLo = HL + $21 (E-0124; a copy, not a clear: E-0226)
DrawRectSetTextCursorLoPlus21_Bank1D::
    push de
    push bc
    push hl
    xor a
    call CopyRectToBGMapWrapped_Bank1D
    pop hl
    push hl
    ld a, l
    add $21
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ret

; copies a B x C rectangle from DE to the BG map at HL, wrapping at the row and map edges (E-0125)
CopyRectToBGMapWrapped_Bank1D::
    push hl
    push bc

.loop:
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    ld a, l
    and $1f
    jp nz, .next
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .return
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $9b
    ld h, a
    jr CopyRectToBGMapWrapped_Bank1D

.return:
    ret

; HL = 10 * wNumberTens + wNumberOnes (E-0120)
TenTimesNumberTensPlusNumberOnes::
    ld a, [wNumberTens]
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wNumberOnes]
    add_a_to_hl
    ret

; Caps the three-digit amount at the limit digits (wCountTens, wCountOnes, wItemGrid) and redraws it
; when it was over. (C1, E-0357)
VaultMenu_WriteThreeDigits::
    ld a, [wCountTens]
    ld b, a
    ld a, [wThreeDigits]
    cp b
    jr c, .return
    jr nz, .read_count_tens
    ld a, [wCountOnes]
    ld b, a
    ld a, [wThreeDigits + $1]
    cp b
    jr c, .return
    jr nz, .read_count_tens
    ld a, [wItemGrid]
    ld b, a
    ld a, [wThreeDigits + $2]
    cp b
    jr c, .return
    jr nz, .read_count_tens
    jr .return

.read_count_tens:
    ld a, [wCountTens]
    ld [wThreeDigits], a
    ld a, [wCountOnes]
    ld [wThreeDigits + $1], a
    ld a, [wItemGrid]
    ld [wThreeDigits + $2], a
    call DrawThreeDigitsAtScrollOffset6E

.return:
    ret

; After a change to the item lists: counts the entries (the bag's, or storage's in state 3) into
; rows of four, sets the row count, and pulls the item cursor back within the last row when it is
; past the end. (C1, E-0357)
VaultMenu_Store_CountNonZeroItemGridBytes::
    ld a, [wScreenState]
    cp $03
    jr z, .call_vault_menu_write_saved_sprite_clip_mode
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    call CountNonZeroItemGridBytes
    ld a, [wSavedSpriteClipMode]
    jr .skip

.call_vault_menu_write_saved_sprite_clip_mode:
    call VaultMenu_WriteSavedSpriteClipModeAndListPages
    call CountNonZeroItemGridBytes
    ld a, c

.skip:
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a
    jr z, .set_saved_sprite_slot_count
    inc l

.set_saved_sprite_slot_count:
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp l
    jr c, .set_menu_choice_to_03
    pop af
    push af
    and a
    jr nz, .set_menu_choice
    ld a, [wItemGridY]
    inc a
    cp l
    jr z, .set_menu_choice_to_03
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr .set_menu_choice_to_03

.set_menu_choice:
    pop af
    dec a
    ld [wMenuChoice], a
    ld b, a
    ld a, [wItemGridX]
    cp b
    jr c, .return
    jr z, .return
    push bc
    push hl
    ld a, [wArg1]
    and a
    jr nz, .restore
    call VaultMenu_Store_ReadItemGridX

.restore:
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr .return

.set_menu_choice_to_03:
    pop af
    ld a, $03
    ld [wMenuChoice], a

.return:
    ret

; record wArg1 (bank 1): writes its mark (field $0E), level (field $56) and four stat words (fields
; from DrawRecordStatsBoxForArg1_Data1) into the screen buffer (E-0128)
DrawRecordStatsBoxForArg1::
    ld a, [wArg1]
    ld b, a
    push bc
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    add $cc
    ld [wWindowTileBuffer + $86], a
    pop bc
    push bc
    ld a, b
    ld c, MON_LEVEL
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    ld a, [wDigits + $1]
    add $e0
    ld [wWindowTileBuffer + $89], a
    ld a, [wDigits + $2]
    add $e0
    ld [wWindowTileBuffer + $8a], a
    pop bc
    push bc
    ld c, $00

.loop:
    push bc
    ld a, c
    ld hl, DrawRecordStatsBoxForArg1_Data1
    add_a_to_hl
    ld c, [hl]
    ld a, b
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a
    ld hl, DrawRecordStatsBoxForArg1_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wDigits]
    add $e0
    ld [de], a
    inc de
    ld a, [wDigits + $1]
    add $e0
    ld [de], a
    inc de
    ld a, [wDigits + $2]
    add $e0
    ld [de], a
    inc c
    ld a, c
    cp $04
    jr c, .loop
    pop bc
    xor a
    ld [rRAMG2], a
    ret

; data read by DrawRecordStatsBoxForArg1 (4 bytes) (E-0347)
DrawRecordStatsBoxForArg1_Data1::
    db $5b, $5d, $5f, $61

DrawRecordStatsBoxForArg1_Data2::
    db $d4, $c3, $d8, $c3, $fc, $c3, $00, $c4

; saves wArg1-wMenuInputResult and hTemp0-hSpriteScrollXLo, runs DrawPartySpeciesSprites for the
; record at wListEntries cell 5, then restores them (E-0125)
CallDrawPartySpeciesSpritesPreservingArg1AndTemp0::
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld de, hTemp0
    ld b, $0d

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    call SetArg5ToListEntriesCell5
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    call DrawPartySpeciesSprites
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld de, hTemp0
    ld b, $0d

.loop4:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ret

; saves wArg1-wMenuInputResult and hTemp0-hSpriteScrollXLo, draws the species sprite of the record
; at wListEntries cell 5 at ($90, $40) (DrawSpeciesMetaSpriteAtScrollOffset), then restores them
; (E-0127)
DrawListEntriesCell5SpeciesSprite::
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld de, hTemp0
    ld b, $0d

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    call SetArg5ToListEntriesCell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a
    ld h, a
    ld e, a
    ld l, $90
    ld d, $40
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset
    ld hl, wRecordBuffer
    ld de, wArg1
    ld b, $09

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld de, hTemp0
    ld b, $0d

.loop4:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ret

; with SRAM bank 0 enabled reads the record at wListEntries cell 5 and continues at
; HibernateMenu_ChooseRecords_CallCopyRecordNameToNameGlyphBuf (E-0126) (E-0344: the address in its
; name dropped or read as the label there; was LoadListEntriesCell5RecordAndContinue)
LoadListEntriesCell5RecordAndContinue::
    call SetArg5ToListEntriesCell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    jr HibernateMenu_ChooseRecords_CallCopyRecordNameToNameGlyphBuf

; Copies the selected SRAM record's name into wTextBuf0 ($F0-terminated, at most 10 letters) for the
; message (SRAM enabled around the read). (C1, E-0357)
HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf_2::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]

; The name copy of HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf_2:
; CopyRecordNameToNameGlyphBuf, then up to 10 bytes to wTextBuf0 and the $F0 end. (C1, E-0357)
HibernateMenu_ChooseRecords_CallCopyRecordNameToNameGlyphBuf::
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    xor a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
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

; record wArg1: draws its name at vTiles1 + $780 and the name of its species (field $0B) at vTiles1
; + $270 (E-0127)
DrawRecordNameAndSpeciesNameTiles::
    ld a, [wArg1]
    ld b, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop bc
    push bc
    ld a, b
    ld c, MON_SPECIES
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, vTiles1 + $270
    call CopyGlyphTilesToVRAM
    pop bc
    xor a
    ld [rRAMG2], a
    ret

; entry wAreaGraphicsIndex (3 bytes per entry): decompresses the tiles named at AreaTilesetTable to
; vTiles2 and copies the $40-byte palette named at AreaPaletteTable into wBGPaletteBuffer (E-0120)
LoadAreaGraphicsForAreaGraphicsIndex::
    ld a, [wAreaGraphicsIndex]
    ld c, a
    add a
    add c
    push af
    ld hl, AreaTilesetTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, AreaPaletteTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ret

; LoadAreaGraphicsForAreaGraphicsIndex decompresses the far pointer at $5D78 + 3 *
; wAreaGraphicsIndex to vTiles2; two entries decode, the bytes after them are AreaPaletteTable
; (E-0145, C1)
; record: compressed BG tiles (vTiles2); its ROM bank
AreaTilesetTable::
    dfar AreaTileset0 ; id 0
    dfar AreaTileset1 ; id 1

; LoadAreaGraphicsForAreaGraphicsIndex copies $40 bytes from the far pointer at $5D7E + 3 *
; wAreaGraphicsIndex to wBGPaletteBuffer (E-0145, C1)
; record: $40-byte BG palette set; its ROM bank
AreaPaletteTable::
    dfar AreaPalettes0 ; id 0
    dfar AreaPalettes1 ; id 1

; wArg5/wArg6 (big-endian pointer) = wListEntries + 5 * wListPageIndex + wListCursor (E-0353)
SetArg5ToListEntriesCell5::
    ld a, [wListPageIndex]
    ld b, a
    add a
    add a
    add b
    ld b, a
    ld a, [wListCursor]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ret

; wArg5/wArg6 (big-endian pointer) = wListEntries + 4 * wListPageIndex + wListCursor (E-0353)
SetArg5ToListEntriesCell4::
    ld a, [wListPageIndex]
    add a
    add a
    ld b, a
    ld a, [wListCursor]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ret

; shows string (field $A4 of the record at wListEntries cell 5) of category $0B at $9320 with size
; $0602 (E-0121)
ShowCategory11StringOfListEntriesCell5Record::
    call SetArg5ToListEntriesCell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, MON_ITEM
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [wStringIndex], a
    ld a, $0b
    ld [wStringCategory], a
    xor a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    ld a, $20
    ld [hli], a
    ld a, $93
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; loads the species of the record at wListEntries cell 5 (field $0B) and shows string
; [wSpeciesRecord + $B] of category $0D at $9680 with size $0602 (E-0121)
ShowSpeciesCategory13StringOfListEntriesCell5Record::
    call SetArg5ToListEntriesCell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wSpeciesIdLo], a
    ldh a, [hTemp1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_FIELD_ABILITY]
    ld [wStringIndex], a
    ld a, $0d
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    ld a, $80
    ld [hli], a
    ld a, $96
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set
; by LoadRecordCapacityFromFarmLevelTable): wRecordsInUse = how many have byte 0 equal to 1 or 2 (in
; use) (E-0104)
CountRecordsInUse::
    call LoadRecordCapacityFromFarmLevelTable
    ld d, c
    xor a
    ld [wRecordsInUse], a
    ld hl, sRecords
    ld b, $00
    ld c, $a5

.loop:
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    cp $01
    jr z, .check_records_in_use
    cp $02
    jr z, .check_records_in_use
    jr .next

.check_records_in_use:
    ld a, [wRecordsInUse]
    inc a
    ld [wRecordsInUse], a

.next:
    inc b
    ld a, c
    add_a_to_hl
    ld a, b
    cp d
    jr c, .loop
    xor a
    ld [rRAMG2], a
    ret

; clears the wListEntries list, then lists the party records whose SRAM record byte 0 is 2 and
; counts them in wListCount (E-0127)
ListPartyRecordsWithState2ToListEntries::
    call LoadRecordCapacityFromFarmLevelTable
    ld b, c
    ld hl, wListEntries

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld de, wPartyList
    ld b, $00

.loop2:
    ld a, [de]
    ld c, a
    ld a, $a5
    push bc
    push de
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, [hl]
    cp $02
    jr nz, .restore
    pop de
    pop bc
    ld hl, wListEntries
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    inc b
    ld a, [wListCount]
    inc a
    ld [wListCount], a
    jr .check_party_count

.restore:
    pop de
    pop bc

.check_party_count:
    inc de
    ld a, [wPartyCount]
    cp b
    jr nz, .loop2
    xor a
    ld [rRAMG2], a
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set
; by LoadRecordCapacityFromFarmLevelTable): clears the 30-byte list wListEntries, then appends the
; number of every record whose byte 0 is 1 and byte $6E is 0; wListCount = the list length,
; wRecordsFlagged = how many state-1 records had byte $6E set (E-0104) (E-0345: record byte $6E is
; MON_EGG; was ListRecordsState1NotEggs)
ListRecordsState1NotEggs::
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop2:
    ld a, [de]
    cp $01
    jr nz, .skip2
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    and a
    jr nz, .check_records_flagged
    pop de
    inc c
    ld a, b
    ld [hli], a
    jr .skip2

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip2:
    ld a, $a5
    add e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp b
    jr nz, .loop2
    jr c, .loop2
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set
; by LoadRecordCapacityFromFarmLevelTable): clears wListEntries and wListEntries2 (30 bytes each),
; then appends every record whose byte 0 is 1 or 2 and byte $6E is 0; wListCount = the list length,
; wRecordsFlagged = how many in-use records had byte $6E set (E-0104) (E-0345: record byte $6E is
; MON_EGG; was ListRecordsInUseNotEggs)
ListRecordsInUseNotEggs::
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1e

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop3:
    ld a, [de]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a
    jr nz, .check_records_flagged
    pop de
    inc c
    ld a, b
    ld [hli], a
    jr .skip3

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip3:
    ld a, $a5
    add e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp b
    jr nz, .loop3
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a

; moves the party records found in the record list wListEntries to its front and pads the list to
; $1E entries with $FF (E-0129)
MovePartyRecordsToFrontOfList::
    ld a, [wListCount]
    and a
    ret z
    ld hl, wListEntries
    ld de, wPartyList
    ld bc, $0000

.loop:
    push hl
    push de
    push bc
    ld b, $00

.loop2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    cp c
    jr z, .skip
    inc b
    inc hl
    ld a, [wListCount]
    ld c, a
    ld a, b
    cp c
    jr c, .loop2
    pop bc
    pop de
    pop hl
    jr .check_party_count

.skip:
    ld a, $ff
    ld [hl], a
    pop bc
    ld hl, wListEntries2
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    pop de
    pop hl
    inc b

.check_party_count:
    inc c
    inc de
    ld a, [wPartyCount]
    cp c
    jr nz, .loop
    ld hl, wListEntries2
    ld a, b
    add_a_to_hl
    ld de, wListEntries
    ld a, [wListCount]
    ld c, a

.loop3:
    ld a, [de]
    cp $ff
    jr z, .next
    ld [hli], a

.next:
    inc de
    dec c
    jr nz, .loop3
    ld hl, wListEntries2
    ld de, wListEntries
    ld a, [wListCount]
    ld b, a

.loop4:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ld a, [wListCount]
    cp $1e
    jr nc, .return
    ld hl, wListEntries
    add_a_to_hl
    ld a, [wListCount]
    ld b, a
    ld a, $1e
    sub b
    ld b, a

.loop5:
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop5

.return:
    ret

; over the first wRecordCapacity SRAM records ($A5 bytes each from sRecords; wRecordCapacity is set
; by LoadRecordCapacityFromFarmLevelTable): clears wListEntries, then appends every record whose
; byte 0 is 1 or 2 and byte $6E is non-zero; wListCount = the list length (E-0104) (C2 from E-0325:
; Evaluate with no egg in any record shows 'You don't have any eggs') (E-0345: record byte $6E is
; MON_EGG; was ListRecordsInUseEggs)
ListRecordsInUseEggs::
    call LoadRecordCapacityFromFarmLevelTable
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop2:
    ld a, [de]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a
    jr z, .restore
    pop de
    inc c
    ld a, b
    ld [hli], a
    jr .skip3

.restore:
    pop de

.skip3:
    ld a, $a5
    add e
    ld e, a
    jr nc, .check_record_capacity
    inc d

.check_record_capacity:
    inc b
    ld a, [wRecordCapacity]
    cp b
    jr nz, .loop2
    ld a, c
    ld [wListCount], a
    ld [wRecordsFlagged], a
    xor a
    ld [rRAMG2], a
    ret

; for the visible entries of page wListPageIndex draws the species name (field $0B, category 2 of
; the bank-08 database) of each listed record (E-0129)
DrawRecordListPageSpeciesNames::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a
    add a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    add a
    add a
    add c
    cp b
    jr nc, .done
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SPECIES
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $f0
    ld [wNameGlyphBuf + $f], a
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .done
    ld a, c
    cp $04
    jp c, .loop

.done:
    xor a
    ld [rRAMG2], a
    ret

; draws the $F0-terminated text at wNameGlyphBuf glyph by glyph; marks $8D and $8E are ORed onto the
; previous tile (E-0125)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D::
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp $f0
    jp z, .clear_glyph_list_start
    cp $8d
    jr z, .check_glyph_list_start
    cp $8e
    jr z, .check_glyph_list_start
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart
    call CopyFromBankWaitVRAM
    pop bc
    jr .check_glyph_list_start2

.check_glyph_list_start:
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart
    call OrFromBankWaitVRAM
    pop bc

.check_glyph_list_start2:
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr .read_glyph_list_pos

.clear_glyph_list_start:
    pop hl
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; For the glyph being drawn: DE = its 16-byte pattern in the font (glyph x 16), HL = its VRAM tile
; from the destination table for layout wArg5 (0-4) at wGlyphListStart; B = $1F, C = $10. (C1,
; E-0357)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart::
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    ld hl, DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_Data
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wArg5]
    and a
    jr z, .skip4
    cp $01
    jr z, .skip3
    cp $02
    jr z, .skip2
    cp $03
    jr z, .skip
    ld de, GlyphTileDestTable_1D_4
    jr .skip5

.skip:
    ld de, GlyphTileDestTable_1D_3
    jr .skip5

.skip2:
    ld de, GlyphTileDestTable_1D_2
    jr .skip5

.skip3:
    ld de, GlyphTileDestTable_1D_1
    jr .skip5

.skip4:
    ld de, GlyphTileDestTable_1D_0

.skip5:
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wGlyphListStart]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld h, d
    ld l, e
    pop de
    ld b, $1f
    ld c, $10
    ret

; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart picks the table by wArg5
; (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 *
; wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 *
; glyph, B = $1F and C = $10, as the bank $0D copy (E-0235) (E-0239, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_0::
    dw GlyphTileDests_1D_0_0 ; id 0
    dw GlyphTileDests_1D_0_1 ; id 1
    dw GlyphTileDests_1D_0_2 ; id 2
    dw GlyphTileDests_1D_0_3 ; id 3

; list 0 of GlyphTileDestTable_1D_0; 9 words (E-0239, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_0_0::
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; list 1 of GlyphTileDestTable_1D_0; 9 words (E-0239, C1)
GlyphTileDests_1D_0_1::
    dw vTiles1 + $590, vTiles1 + $5a0, vTiles1 + $5b0, vTiles1 + $5c0, vTiles1 + $5d0, vTiles1 + $5e0 ; entry 0
    dw vTiles1 + $400, vTiles1 + $410, vTiles1 + $420

; list 2 of GlyphTileDestTable_1D_0; 9 words (E-0239, C1)
GlyphTileDests_1D_0_2::
    dw vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790, vTiles1 + $7a0 ; entry 0
    dw vTiles1 + $7b0, vTiles1 + $7c0, vTiles1 + $3f0

; list 3 of GlyphTileDestTable_1D_0; 9 words (E-0239, C1)
GlyphTileDests_1D_0_3::
    dw vTiles1 + $470, vTiles1 + $480, vTiles1 + $490, vTiles1 + $4a0, vTiles1 + $4b0, vTiles1 + $6a0 ; entry 0
    dw vTiles1 + $6b0, vTiles1 + $6c0, vTiles1 + $6d0

; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart picks the table by wArg5
; (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 *
; wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 *
; glyph, B = $1F and C = $10, as the bank $0D copy (E-0235) (E-0239, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_1::
    dw GlyphTileDests_1D_1_0 ; id 0
    dw GlyphTileDests_1D_1_1 ; id 1
    dw GlyphTileDests_1D_1_2 ; id 2
    dw GlyphTileDests_1D_1_3 ; id 3

; list 0 of GlyphTileDestTable_1D_1; 9 words (E-0239, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_1_0::
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; list 1 of GlyphTileDestTable_1D_1; 9 words (E-0239, C1)
GlyphTileDests_1D_1_1::
    dw vTiles1 + $590, vTiles1 + $5a0, vTiles1 + $5b0, vTiles1 + $5c0, vTiles1 + $5d0, vTiles1 + $5e0 ; entry 0
    dw vTiles1 + $790, vTiles1 + $7a0, vTiles1 + $7b0

; list 2 of GlyphTileDestTable_1D_1; 9 words (E-0239, C1)
GlyphTileDests_1D_1_2::
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780

; list 3 of GlyphTileDestTable_1D_1; 9 words (E-0239, C1)
GlyphTileDests_1D_1_3::
    dw vTiles1 + $400, vTiles1 + $410, vTiles1 + $420, vTiles1 + $470, vTiles1 + $480, vTiles1 + $490 ; entry 0
    dw vTiles1 + $4a0, vTiles1 + $4b0, vTiles1 + $7c0

; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart picks the table by wArg5
; (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 *
; wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 *
; glyph, B = $1F and C = $10, as the bank $0D copy (E-0235) (E-0239, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_2::
    dw GlyphTileDests_1D_2_0 ; id 0

; list 0 of GlyphTileDestTable_1D_2; 5 words (E-0239, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_2_0::
    dw vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $7d0, vTiles1 + $7e0 ; entry 0

GlyphTileDestTable_1D_3::
    dw GlyphTileDests_1D_3_0 ; id 0

; list 0 of GlyphTileDestTable_1D_3; 9 words (E-0239, C1)
GlyphTileDests_1D_3_0::
    dw vTiles2 + $770, vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730 ; entry 0
    dw vTiles2 + $740, vTiles2 + $750, vTiles2 + $760

; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D_ReadArg5AndGlyphListStart picks the table by wArg5
; (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299), reads the word at 2 * C, then the word at 2 *
; wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 *
; glyph, B = $1F and C = $10, as the bank $0D copy (E-0235) (E-0239, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_4::
    dw GlyphTileDests_1D_4_0 ; id 0

; list 0 of GlyphTileDestTable_1D_4; 9 words (E-0239, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_4_0::
    dw vTiles2 + $7c0, vTiles2 + $7d0, vTiles2 + $7e0, vTiles2 + $7f0, vTiles1 + $400, vTiles1 + $410 ; entry 0
    dw vTiles1 + $420, vTiles1 + $4a0, vTiles1 + $4b0

; with SRAM enabled, for each of the wPartyCount record numbers in wPartyList copies the record's
; name (CopyRecordNameToNameGlyphBuf, C = 1) and draws it as glyph tiles at the VRAM address from
; DrawRecordListNameTiles_Bank1D_Data (CopyGlyphTilesToVRAM); then disables SRAM (E-0106)
DrawRecordListNameTiles_Bank1D::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld c, $00

.loop:
    push bc
    ld hl, wPartyList
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, DrawRecordListNameTiles_Bank1D_Data
    pop bc
    push bc
    ld a, c
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    ld a, [wPartyCount]
    cp c
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

; data read by DrawRecordListNameTiles_Bank1D (6 bytes) (E-0347)
DrawRecordListNameTiles_Bank1D_Data::
    db $00, $8d, $50, $8d, $a0, $8d

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank1D_2::
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

; for the visible entries of page wListPageIndex draws each record's mark ($CC/$CD from field $0E,
; or $CE for state 2) beside it (E-0130)
DrawRecordListPageMarks::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a
    add a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    add a
    add a
    add c
    cp b
    jp nc, .done
    push hl
    push bc
    ld a, [hl]
    ld c, MON_EGG
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp $02
    jr nz, .skip
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    add $cc
    ld e, a
    jr .restore

.skip:
    ld e, $ce

.restore:
    pop bc
    push bc
    push de
    call BGMapAddressAtScroll_Bank1D_2
    push hl
    ld a, [wArg2]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip2
    ld hl, DrawRecordListPageMarks_Data3
    jr .skip4

.skip2:
    ld hl, DrawRecordListPageMarks_Data2
    jr .skip4

.skip3:
    ld hl, DrawRecordListPageMarks_Data1

.skip4:
    ld a, c
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    pop de
    ld a, [wArg1]
    and a
    jr nz, .restore2
    di
    call WaitForVRAMAccess
    ld a, e
    ld [hl], a
    ei

.restore2:
    pop bc
    push bc
    push de
    ld a, [wArg2]
    and a
    jr z, .skip6
    cp $01
    jr z, .skip5
    ld de, DrawRecordListPageMarks_Data6
    jr .skip7

.skip5:
    ld de, DrawRecordListPageMarks_Data5
    jr .skip7

.skip6:
    ld de, DrawRecordListPageMarks_Data4

.skip7:
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, e
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .done
    ld a, c
    cp $04
    jp c, .loop

.done:
    xor a
    ld [rRAMG2], a
    ret

; data read by DrawRecordListPageMarks (8 bytes) (E-0347)
DrawRecordListPageMarks_Data1::
    db $32, $00, $72, $00, $b2, $00, $f2, $00

DrawRecordListPageMarks_Data2::
    db $b2, $00, $f2, $00, $32, $01, $72, $01

DrawRecordListPageMarks_Data3::
    db $2b, $00, $6b, $00, $ab, $00, $eb, $00

DrawRecordListPageMarks_Data4::
    db $8a, $c3, $b2, $c3, $da, $c3, $02, $c4

DrawRecordListPageMarks_Data5::
    db $da, $c3, $02, $c4, $2a, $c4, $52, $c4

DrawRecordListPageMarks_Data6::
    db $83, $c3, $ab, $c3, $d3, $c3, $fb, $c3

; The view-records cursor: Up/Down move between the two choices (wrapping) and answer $FD; A plays
; sound $69, marks the choice and answers $FF; B erases the cursor and answers $FE; otherwise blinks
; the cursor and answers 0. (C1, E-0357)
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank1_d_32
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank1_d_33
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .call_draw_blank_tile_c3_bank1_d_3
    call BlinkCursorBlinkB8_Bank1D
    xor a
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_ChooseToView_StepBGMapAddressBackOnScrollWrap
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank1_d_3:
    call DrawBlankTileC3_Bank1D_3
    ld a, $fe
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank1_d_32:
    call DrawBlankTileC3_Bank1D_3
    ld a, [wMenuChoice]
    and a
    jr nz, .skip
    ld a, $01
    jr .set_menu_choice2

.skip:
    dec a
    jr .set_menu_choice2

.call_draw_blank_tile_c3_bank1_d_33:
    call DrawBlankTileC3_Bank1D_3
    ld a, [wMenuChoice]
    cp $01
    jr c, .set_menu_choice
    xor a
    jr .set_menu_choice2

.set_menu_choice:
    inc a

.set_menu_choice2:
    ld [wMenuChoice], a
    call DrawCursorTileBB_Bank1D_3
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

; cycles wListCursorBlink through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was BlinkCursorBlinkB8_Bank1D)
BlinkCursorBlinkB8_Bank1D::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank1D_3
    ld a, [wListCursorBlink]
    inc a
    ld [wListCursorBlink], a
    cp $10
    jr c, DrawCursorTileBB_Bank1D_3
    cp $18
    jr c, DrawBlankTileC3_Bank1D_3
    xor a
    ld [wListCursorBlink], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawCursorTileBB_Bank1D_3)
DrawCursorTileBB_Bank1D_3::
    ld b, $bb
    jr SwapMonstersMenu_ChooseToView_ReadMenuChoice

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1D_3)
DrawBlankTileC3_Bank1D_3::
    ld b, $c3
    jr SwapMonstersMenu_ChooseToView_ReadMenuChoice

; B = the chosen-cursor tile ($BC), then SwapMonstersMenu_ChooseToView_ReadMenuChoice. (C1, E-0357)
SwapMonstersMenu_ChooseToView_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

; Writes tile B at choice wMenuChoice's place (SwapMonstersMenu_ChooseToView_Data), allowing for the
; scroll wrap. (C1, E-0357)
SwapMonstersMenu_ChooseToView_ReadMenuChoice::
    ld a, [wMenuChoice]
    add a
    ld hl, SwapMonstersMenu_ChooseToView_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by SwapMonstersMenu (4 bytes) (E-0347)
SwapMonstersMenu_ChooseToView_Data::
    db $28, $01, $68, $01

; up/down moves wListCursor over wListCount entries ($FD), A selects ($FF, sound $69), B cancels
; ($FE); wListPageIndex = 0 (E-0128)
HandleListCursorInput_1D::
    xor a
    ld [wListPageIndex], a
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .check_list_cursor
    bit 7, a
    jr nz, .check_list_count
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    bit 0, a
    jr nz, .call_queue_sound_effect
    xor a
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a
    jr nz, .skip
    ld a, [wListCount]
    dec a
    jr nz, .set_list_cursor2
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.skip:
    dec a
    jr .set_list_cursor2

.check_list_count:
    ld a, [wListCount]
    dec a
    jr nz, .check_list_cursor2
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.check_list_cursor2:
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .set_list_cursor
    xor a
    jr .set_list_cursor2

.set_list_cursor:
    inc a

.set_list_cursor2:
    ld [wListCursor], a
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the
; new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor
; (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks
; (wScreenCounter counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Cursor
; positions are BG map offsets $012F and $016F from the scroll origin (E-0068)
UpdateTwoChoiceCursor_Bank1D::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_erase_two_choice_cursor
    bit 7, a
    jr nz, .call_erase_two_choice_cursor2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_draw_two_choice_cursor_confirmed
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkTwoChoiceCursor
    xor a
    ld [wMenuInputResult], a
    ret

.call_erase_two_choice_cursor:
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .set_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor:
    dec a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.call_erase_two_choice_cursor2:
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    cp $01
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
    call DrawTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_draw_two_choice_cursor_confirmed:
    call DrawTwoChoiceCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; once wJoypadRepeatTimer >= $14, counts wScreenCounter up: frames 0-$0F draw the cursor, $10-$17
; erase it, then the count restarts (E-0068)
BlinkTwoChoiceCursor::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, DrawTwoChoiceCursor
    cp $18
    jr c, EraseTwoChoiceCursor
    xor a
    ld [wScreenCounter], a

; writes tile $BB at the position of wTwoChoiceCursor (DrawTwoChoiceCursorConfirmed_Data offset from
; BGMapAddressAtScroll_Bank1D, StepBGMapAddressBackOnScrollWrap) (E-0068)
DrawTwoChoiceCursor::
    ld b, $bb
    jr DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor

; writes tile $C3 at the position of wTwoChoiceCursor (E-0068)
EraseTwoChoiceCursor::
    ld b, $c3
    jr DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor

; writes tile $BC at the position of wTwoChoiceCursor (E-0068)
DrawTwoChoiceCursorConfirmed::
    ld b, $bc

; Writes tile B at yes/no place wTwoChoiceCursor (DrawTwoChoiceCursorConfirmed_Data), allowing for
; the scroll wrap. (C1, E-0357)
DrawTwoChoiceCursorConfirmed_ReadTwoChoiceCursor::
    ld a, [wTwoChoiceCursor]
    add a
    ld hl, DrawTwoChoiceCursorConfirmed_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by DrawTwoChoiceCursorConfirmed (4 bytes) (E-0347)
DrawTwoChoiceCursorConfirmed_Data::
    db $2f, $01, $6f, $01

; list cursor over wListCount entries: Up/Down move wListCursor with wrap, erase and redraw the
; cursor, play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor, plays sound
; $69 and sets $FF; B sets $FE; with no input the cursor blinks and the result is 0 (the codes of
; UpdatePagedListCursor) (E-0106)
UpdateListCursorListCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_update_list_cursor_list_cursor_read_list
    bit 7, a
    jr nz, .call_update_list_cursor_list_cursor_read_list2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call UpdateListCursorListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.call_update_list_cursor_list_cursor_read_list:
    call UpdateListCursorListCursor_ReadListCursor_2
    ld a, [wListCursor]
    and a
    jr nz, .set_list_cursor
    ld a, [wListCount]
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor:
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.call_update_list_cursor_list_cursor_read_list2:
    call UpdateListCursorListCursor_ReadListCursor_2
    ld a, [wListCount]
    dec a
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .set_list_cursor2
    xor a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor2:
    inc a
    ld [wListCursor], a

.clear_list_cursor_aux:
    xor a
    ld [wListCursorAux], a
    call UpdateListCursorListCursor_ReadListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the list cursor once the pad has been still for 20 frames: the cursor tile $BB for 16
; counts, a blank for 8. (C1, E-0357)
UpdateListCursorListCursor_WriteListCursorAux::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdateListCursorListCursor_ReadListCursor
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp $10
    jr c, UpdateListCursorListCursor_ReadListCursor
    cp $18
    jr c, UpdateListCursorListCursor_ReadListCursor_2
    xor a
    ld [wListCursorAux], a

; B = the cursor tile ($BB), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_ReadListCursor::
    ld b, $bb
    jr UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor

; B = the blank tile ($C3), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_ReadListCursor_2::
    ld b, $c3
    jr UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor

; B = the chosen-cursor tile ($BC), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

; Writes tile B at list row wListCursor's place (UpdateListCursorListCursor_Data), allowing for the
; scroll wrap. (C1, E-0357)
UpdateListCursorListCursor_StepBGMapAddressBackOnScrollWrap_ReadListCursor::
    ld a, [wListCursor]
    add a
    ld hl, UpdateListCursorListCursor_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by UpdateListCursorListCursor (8 bytes) (E-0347)
UpdateListCursorListCursor_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00

; row wListCursor runs 0..wListLastRow and page wListPageIndex runs 0..wListPages - 1, both
; wrapping; Up/Down move the row (wMenuInputResult = $FD), Left/Right move the page ($FB); a move
; erases the old cursor (tile $C3) and draws the new one (tile $BB) with sound $69; A draws tile
; $BC, plays sound $69 and sets $FF; B sets $FE. When the range is a single entry the press only
; blinks the cursor and the result is 0, as with no input (E-0068)
UpdatePagedListCursor::
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .read_list_pages
    bit 5, a
    jr nz, .check_list_page_index
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_update_paged_list_cursor_read_menu_input
    bit 7, a
    jp nz, .call_update_paged_list_cursor_read_menu_input2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_update_paged_list_cursor_bg_map_address
    bit 1, a
    jp nz, .set_menu_input_result_to_FE
    call UpdatePagedListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.read_list_pages:
    ld a, [wListPages]
    ld b, a
    ld a, [wListPageIndex]
    inc a
    cp b
    jr c, .set_list_page_index
    ld a, [wListPages]
    cp $01
    jr nz, .clear_list_page_index
    call UpdatePagedListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.clear_list_page_index:
    xor a

.set_list_page_index:
    ld [wListPageIndex], a
    xor a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fb
    ld [wMenuInputResult], a
    ret

.check_list_page_index:
    ld a, [wListPageIndex]
    and a
    jr nz, .skip2
    ld a, [wListPages]
    cp $01
    jr nz, .skip
    call UpdatePagedListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.skip:
    dec a
    jp .set_list_page_index

.skip2:
    dec a
    jp .set_list_page_index

.call_update_paged_list_cursor_read_menu_input:
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor_2
    ld a, [wListCursor]
    and a
    jr nz, .set_list_cursor2
    ld a, [wListLastRow]
    and a
    jr nz, .set_list_cursor
    call UpdatePagedListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.set_list_cursor:
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor2:
    dec a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.call_update_paged_list_cursor_read_menu_input2:
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor_2
    ld a, [wListLastRow]
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .set_list_cursor3
    ld a, [wListLastRow]
    and a
    jr nz, .clear_list_cursor
    call UpdatePagedListCursor_WriteListCursorAux
    xor a
    ld [wMenuInputResult], a
    ret

.clear_list_cursor:
    xor a
    ld [wListCursor], a
    jr .clear_list_cursor_aux

.set_list_cursor3:
    inc a
    ld [wListCursor], a

.clear_list_cursor_aux:
    xor a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_update_paged_list_cursor_bg_map_address:
    call UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_2
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the paged-list cursor once the pad has been still for 20 frames: the cursor tile for 16
; counts, a blank for 8. (C1, E-0357)
UpdatePagedListCursor_WriteListCursorAux::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp $10
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor
    cp $18
    jr c, UpdatePagedListCursor_ReadMenuInputResultAndListCursor_2
    xor a
    ld [wListCursorAux], a

; B = the cursor tile ($BB), then the draw. (C1, E-0357)
UpdatePagedListCursor_ReadMenuInputResultAndListCursor::
    ld b, $bb
    jr UpdatePagedListCursor_ReadMenuInputResult

; B = the blank tile ($C3), then the draw. (C1, E-0357)
UpdatePagedListCursor_ReadMenuInputResultAndListCursor_2::
    ld b, $c3
    jr UpdatePagedListCursor_ReadMenuInputResult

; B = the chosen-cursor tile ($BC), then the draw. (C1, E-0357)
UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_2::
    ld b, $bc

; Writes tile B at row wListCursor of layout wMenuInputResult (a table of five rows per layout),
; allowing for the scroll wrap. (C1, E-0357)
UpdatePagedListCursor_ReadMenuInputResult::
    ld a, [wMenuInputResult]
    ld c, a
    add a
    add a
    add c
    add a
    ld hl, UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_2_Data
    add_a_to_hl
    ld a, [wListCursor]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by UpdatePagedListCursor (60 bytes) (E-0347)
UpdatePagedListCursor_BGMapAddressAtScroll_Bank1D_2_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01, $28, $00, $68, $00, $a8, $00
    db $e8, $00, $28, $01, $a8, $00, $e8, $00, $28, $01, $68, $01, $a8, $01, $a6, $00
    db $e6, $00, $26, $01, $66, $01, $a6, $01, $a4, $00, $e4, $00, $24, $01, $64, $01
    db $a4, $01, $a2, $00, $e2, $00, $22, $01, $62, $01, $a2, $01

; for the three records listed at wArg1 loads each species' sprite graphics and palette to the slots
; in LoadPartySpeciesSpriteGraphics_Data1 (E-0128)
LoadPartySpeciesSpriteGraphics::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    ld bc, $0300

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $10
    jr nz, .skip
    ld de, LoadPartySpeciesSpriteGraphics_Data2
    jr .restore

.skip:
    ld de, LoadPartySpeciesSpriteGraphics_Data3

.restore:
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp $ff
    jr z, .restore2
    pop bc
    push bc
    ld a, c
    add a
    add c
    ld de, LoadPartySpeciesSpriteGraphics_Data1
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld hl, wArg3
    ld c, $03

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .loop2
    call LoadSpeciesSpriteGraphicsAndPalette

.restore2:
    pop bc
    pop hl
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; data read by LoadPartySpeciesSpriteGraphics (9 bytes) (E-0347)
LoadPartySpeciesSpriteGraphics_Data1::
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; for the three records listed at wArg1 draws each species sprite at the positions in
; DrawPartySpeciesSprites_Data (E-0128)
DrawPartySpeciesSprites::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    ld bc, $0300

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $10
    jr nz, .skip
    ld de, LoadPartySpeciesSpriteGraphics_Data2
    jr .restore

.skip:
    ld de, LoadPartySpeciesSpriteGraphics_Data3

.restore:
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    cp $ff
    jr z, .restore2
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    add a
    add a
    ld hl, DrawPartySpeciesSprites_Data
    add_a_to_hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld l, c
    ld h, b
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset

.restore2:
    pop bc
    pop hl
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    ret

; data read by DrawPartySpeciesSprites (12 bytes) (E-0347)
DrawPartySpeciesSprites_Data::
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; decompresses the sprite graphics of species hTemp0/7 (far pointer MonsterSpriteTable + 3 * id) to
; the VRAM address in wArg4/5; on CGB copies its 8-byte palette from bank $27 into wOBJPaletteBuffer
; + wArg3 (E-0127)
LoadSpeciesSpriteGraphicsAndPalette::
    ldh a, [hTemp0]
    ld l, a
    ld e, a
    ldh a, [hTemp1]
    ld h, a
    ld d, a
    push hl
    add hl, hl
    add hl, de
    ld de, MonsterSpriteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wArg4]
    ld l, a
    ld a, [wArg5]
    ld h, a
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    and a
    ret z
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $28
    ld l, a
    ld a, h
    adc $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wOBJPaletteBuffer
    ld a, [wArg3]
    add_a_to_hl
    ld c, $08

.loop:
    push bc
    call ReadByteInBank
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, c
    ld [hli], a
    ei
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; graphics number = the word wArg1/wArg2: reads its far pointer (3 bytes per entry) from
; MonsterSpriteTable in bank $04 (ReadFarPointerAtDEInBankB) and DecompressToVRAM to the address in
; wArg4/wArg5; on CGB it continues with the palette (not read) (E-0104)
; code: calls ReadFarPointerAtDEInBankB; calls DecompressToVRAM; branches on wIsCGB; calls
; ReadByteInBank; branches on rSTAT; sets wOBJPaletteUploadRequest to $7f; also changes HL, DE, BC
; and A by register arithmetic (E-0347)
DecompressGraphicsArg1ToArg4::
    ld a, [wArg1]
    ld l, a
    ld e, a
    ld a, [wArg2]
    ld h, a
    ld d, a
    add hl, hl
    add hl, de
    ld de, MonsterSpriteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wArg4]
    ld l, a
    ld a, [wArg5]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $28
    ld l, a
    ld a, h
    adc $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wOBJPaletteBuffer
    ld a, [wArg3]
    add_a_to_hl
    ld c, $08

.loop:
    push bc
    call ReadByteInBank
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, c
    ld [hli], a
    ei
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; draws sprite set wArg1 & $7F (from bank $25, $26 or $27 by wArg2 and bit 7 of wArg1) at the scroll
; position + (L, D), tile offset H, attribute E, alternating two frames (E-0127)
DrawSpeciesMetaSpriteAtScrollOffset::
    ld c, $00
    ld a, e
    ldh [hSpriteAttrXor], a
    ld a, c
    and a
    jr nz, .clear_sprite_sub_index
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    jr .set_sprite_tile_offset

.clear_sprite_sub_index:
    xor a
    ldh [hSpriteSubIndex], a

.set_sprite_tile_offset:
    ld a, h
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    add l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    add d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    ld a, [wArg1]
    and $7f
    ldh [hSpriteSetIndex], a
    ld a, [wArg2]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [wArg1]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; Sets the sprite attribute bits from wArg6 and draws the meta-sprite
; (DrawSpritePart9000At88_28_ReadArg3). (C1, E-0357)
DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc::
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    jr DrawSpritePart9000At88_28_ReadArg3

; C = 0, then falls into the sprite part draw
; (DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc body) (E-0122)
DrawMetaSpritePartC0::
    ld c, $00

; Sets the attribute bits from wArg6; with C = 0 the frame alternates every 16 frames
; (wFrameCounterLo bit 4), otherwise frame 0; then draws (DrawSpritePart9000At88_28_ReadArg3). (C1,
; E-0357)
DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc::
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    ld a, c
    and a
    jr nz, .clear_sprite_sub_index
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    jr DrawSpritePart9000At88_28_ReadArg3

.clear_sprite_sub_index:
    xor a
    ldh [hSpriteSubIndex], a

; Draws meta-sprite set wArg1 (bit 7 chooses bank $26 over $25; a non-zero wArg2 chooses bank $27)
; with tile offset wArg3 at screen position (wArg4, wArg5) plus the scroll. (C1, E-0357)
DrawSpritePart9000At88_28_ReadArg3::
    ld a, [wArg3]
    ldh [hSpriteTileOffset], a
    ld a, [wArg4]
    ld b, a
    ldh a, [hScrollX]
    add b
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ld a, [wArg5]
    ld b, a
    ldh a, [hScrollY]
    add b
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    ld a, [wArg1]
    and $7f
    ldh [hSpriteSetIndex], a
    ld a, [wArg2]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [wArg1]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; for each party record found on the current list page (wListEntries page wListPageIndex) draws a
; party mark at its row (scroll offsets MarkPartyMembersInRecordListPage_Data2 when wArg1 is set,
; else screen-buffer offsets MarkPartyMembersInRecordListPage_Data1) (E-0128)
MarkPartyMembersInRecordListPage::
    ld hl, wPartyList
    ld bc, $0000
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a

.loop:
    push bc
    push hl
    ld b, [hl]
    ld a, [wListPageIndex]
    ld c, a
    add a
    add a
    add c
    ld hl, wListEntries
    add_a_to_hl
    ld c, $00

.loop2:
    ld a, [hl]
    cp b
    jr z, .check_arg1
    inc hl
    inc c
    ld a, [wListLastRow]
    cp c
    jr nc, .loop2
    pop hl
    pop bc

.check_party_count:
    inc hl
    inc b
    ld a, [wPartyCount]
    cp b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    ret

.check_arg1:
    ld a, [wArg1]
    and a
    jr z, .skip
    ld hl, MarkPartyMembersInRecordListPage_Data2
    ld a, c
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld e, l
    ld d, h
    jr .restore

.skip:
    ld a, c
    add a
    ld hl, MarkPartyMembersInRecordListPage_Data1
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.restore:
    pop hl
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    add $e1
    ld [de], a
    ei
    jp .check_party_count

; data read by MarkPartyMembersInRecordListPage (10 bytes) (E-0347)
MarkPartyMembersInRecordListPage_Data1::
    db $78, $c3, $a0, $c3, $c8, $c3, $f0, $c3, $18, $c4

MarkPartyMembersInRecordListPage_Data2::
    db $20, $00, $60, $00, $a0, $00, $e0, $00, $20, $01

; Swap menu, state 3: sets the text window, then by wGridCursorX: 0 lists the party (fewer than 2
; goes to step $10); 1 lists the farm records that are not eggs (none returns to state 1, step 3),
; with a full party (3 or more) going to step $1E; 2 and 3 take their own lists; starts the script.
; (C1, E-0357)
SwapMonstersMenu_ListPartyRecordsWithState2ToListEntries::
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wGridCursorX]
    and a
    jr z, .call_list_party_records_with_state2_to_list
    cp $01
    jp z, .call_list_records_state1_not_eggs
    cp $02
    jp z, .read_screen_state2
    cp $03
    jp z, .read_screen_state3

.call_list_party_records_with_state2_to_list:
    call ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    cp $02
    jr c, .set_screen_step_to_10
    xor a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wListPageIndex], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_10:
    ld a, $10
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wListPageIndex], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_list_records_state1_not_eggs:
    farcall ListRecordsState1NotEggs
    ld a, [wListCount]
    and a
    jr nz, .read_screen_state
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_state:
    ld a, [wScreenState]
    add $02
    ld [wScreenState], a
    ld a, [wPartyCount]
    cp $03
    jr c, .set_two_choice_cursor_to_02
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $1e
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_state2:
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_state3:
    ld a, [wScreenState]
    add $04
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; copies tiles listed at the address in wArg3/4 to wArg1/2 + 16 * n, six per call; wArg5 = $FF when
; the $FF end is reached, else 0 (E-0128)
LoadTileListSixPerCall::
    ld a, [wArg3]
    ld d, a
    ld a, [wArg4]
    ld e, a
    xor a
    ld [wGlyphListPos], a

.loop:
    push hl
    push de
    ld a, [wGlyphListStart]
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $ff
    jr z, .restore
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    push de
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    ld h, a
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    add hl, de
    pop de
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $06
    jr c, .loop
    xor a
    ld [wArg5], a
    ret

.restore:
    pop de
    pop hl
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ld a, $ff
    ld [wArg5], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; (E-0353)
CopyTileBytesToVRAM_Bank1D::
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; HL = CloseHibernateMenu_LoadTileListSixPerCall_Data, wArg1/2 = $9C/0, DE = vBGMap1, wGlyphListPos
; = 0, then continues at LoadTileListSixPerFrame_Loop (E-0126) (E-0344: the address in its name
; dropped or read as the label there; was SetupTileMapAtBGMap1)
SetupTileMapAtBGMap1::
    ld hl, CloseHibernateMenu_LoadTileListSixPerCall_Data
    ld a, $9c
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, vBGMap1
    xor a
    ld [wGlyphListPos], a
    jr LoadTileListSixPerFrame_Loop

; copies tiles listed in LoadTileListSixPerFrame_Data to vBGMap1 + $200 onward six per call; at the
; $FF end resets the counters and wScreenStep += 1 (E-0127) (E-0344: the address in its name dropped
; or read as the label there; was LoadTileListSixPerFrame)
LoadTileListSixPerFrame::
    ld hl, LoadTileListSixPerFrame_Data
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, vBGMap1 + $200
    xor a
    ld [wGlyphListPos], a

; Copies up to six tiles a call from the list (the pointers at wGlyphListStart) to the destination
; wArg1:wArg2 + 16 x the entry; at the $FF end clears the counters and goes to the next step. (C1,
; E-0357)
LoadTileListSixPerFrame_Loop::
    push hl
    push de
    ld a, [wGlyphListStart]
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .restore
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e
    push hl
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    ld h, a
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $06
    jr c, LoadTileListSixPerFrame_Loop
    ret

.restore:
    pop de
    pop hl
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies tiles from UploadTilesFromData_Tiles: two to vTiles2 + $6E0 and three to vTiles2 + $7C0
; (CopyTileBytesToVRAM_Bank1D) (E-0118) (E-0344: the address in its name dropped or read as the
; label there; was UploadTilesFromData)
UploadTilesFromData::
    ld hl, UploadTilesFromData_Tiles
    ld de, vTiles2 + $6e0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ld de, vTiles2 + $7c0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ret

; HL = $6D20 and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
UploadTilesFromData_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $ff ; entry 0
    db $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 1
    db $ff, $ff, $ff, $ff, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 2
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $ff, $ff, $ff ; entry 3
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 4

; C = wRecordCapacity = LoadRecordCapacityFromFarmLevelTable_Data[wFarmLevel] (E-0073)
LoadRecordCapacityFromFarmLevelTable::
    ld a, [wFarmLevel]
    ld de, LoadRecordCapacityFromFarmLevelTable_Data
    add e
    ld e, a
    jr nc, .set_record_capacity
    inc d

.set_record_capacity:
    ld a, [de]
    ld c, a
    ld [wRecordCapacity], a
    ret

; data read by LoadRecordCapacityFromFarmLevelTable (3 bytes) (E-0347)
LoadRecordCapacityFromFarmLevelTable_Data::
    db $0a, $14, $1e

CloseHibernateMenu_LoadTileListSixPerCall_Data::
    db $40, $8a, $50, $8a, $60, $8a, $70, $8a, $80, $8a, $90, $8a, $a0, $8a, $b0, $8a
    db $c0, $8a, $d0, $8a, $e0, $8a, $f0, $8a, $e0, $8e, $f0, $8e, $00, $8f, $10, $8f
    db $20, $8f, $30, $8f, $40, $8f, $50, $8f, $60, $8f, $70, $8f, $80, $8f, $90, $8f
    db $a0, $8f, $b0, $8f, $c0, $8f, $d0, $8f, $e0, $8f, $f0, $8f, $b0, $8e, $ff, $ff

LoadTileListSixPerFrame_Data::
    db $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0, $8c, $b0, $8c
    db $f0, $8b, $a0, $8e, $b0, $8e, $c0, $8e, $d0, $8e, $ff, $ff

LoadPartySpeciesSpriteGraphics_Data2::
    db $0b, $1a, $1c

LoadPartySpeciesSpriteGraphics_Data3::
    db $0b, $1c, $1a, $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0
    db $8c, $b0, $8c, $ff, $ff

; wArg5 = the number of SRAM records (29 in bank 0 from sCompactRecords plus one in bank 1) with bit
; 7 of byte 0 set (E-0125)
CountFlaggedSRAMRecords::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    xor a
    ld [wArg5], a
    ld hl, sCompactRecords
    ld c, $00
    ld b, $00

.loop:
    ld a, [hl]
    bit 7, a
    jr z, .next
    inc c

.next:
    inc b
    ld a, $6f
    add_a_to_hl
    ld a, b
    cp $1d
    jr c, .loop
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, .set_arg5
    inc c

.set_arg5:
    ld a, c
    ld [wArg5], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; packs SRAM record wArg1's family, state, mark and other fields into the compact form in SRAM bank
; wArg2 (wPackWork workspace) (E-0131)
PackRecordFieldsToBank1Slot::
    ld bc, $0007
    ld hl, wPackWork

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push de
    ld a, [de]
    and $03
    swap a
    sla a
    set 7, a
    ld c, a
    pop de
    push de
    ld a, $0d
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    and $1f
    or c
    pop de
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    push af
    xor a
    ld [rRAMB], a
    pop af
    push hl
    push de
    ld a, $0e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and $01
    sla a
    sla a
    sla a
    ld c, a
    ld a, [de]
    and $f0
    or c
    ld c, a
    pop de
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    and $03
    sla a
    or c
    ld c, a
    pop de
    push de
    ld a, $0b
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc de
    ld a, [de]
    and $01
    or c
    ld c, a
    dec de
    ld a, [de]
    pop de
    pop hl
    ld b, a
    ld a, c
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    ld a, b
    ld [hli], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a

; Packs text field wPackFieldIndex of SRAM record wArg1 into the compact slot in SRAM bank wArg2:
; each letter goes across, the marks $8D and $8E become 1 and 2 against the letter before
; (wPackFields), and $F0 ends the field. (C1, E-0357)
PackRecordFieldsToBank1Slot_Skip::
    ld hl, wPackFields
    ld c, $00

.loop:
    xor a
    ld [hli], a
    inc c
    ld a, c
    cp $05
    jr c, .loop
    call SRAMRecordAddressOfArg1
    ld a, $03
    add_a_to_hl
    ld a, [wPackFieldIndex]
    ld b, a
    sla a
    sla a
    add b
    add_a_to_hl
    ld bc, $0000
    call EnableSRAMBank0
    push hl
    ld a, [wPackFieldIndex]
    ld hl, PackRecordFieldsToBank1Slot_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add e
    ld e, a
    jr nc, .loop2
    inc d

.loop2:
    push af
    xor a
    ld [rRAMB], a
    pop af
    push de
    push hl
    push bc
    ld a, [de]
    cp $8d
    jr z, .restore
    cp $8e
    jr z, .restore
    cp $f0
    jr z, .restore3
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    push bc
    ld a, c
    ld hl, wPackFields
    add_a_to_hl
    xor a
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    inc b
    jr .restore2

.restore:
    pop bc
    dec c
    push bc
    ld b, a
    ld a, c
    ld hl, wPackFields
    add_a_to_hl
    ld a, b
    cp $8d
    jr z, .read_arg2
    ld a, $02
    jr .read_arg22

.read_arg2:
    ld a, $01

.read_arg22:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    inc b
    inc c
    pop hl

.restore2:
    pop de
    inc de
    ld a, c
    cp $05
    jr c, .loop2
    ld a, b
    cp $0a
    jr c, .loop2
    jr .check_pack_field_index

.restore3:
    pop bc
    pop hl
    pop de
    ld a, c
    cp $05
    jr nc, .check_pack_field_index
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $f0
    ld [hl], a

.check_pack_field_index:
    ld a, [wPackFieldIndex]
    and a
    jp z, PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg1
    cp $01
    jp z, PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg12
    cp $02
    jp z, PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg13
    cp $03
    jp z, PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg14
    cp $04
    jp z, PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg15
    jp PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg16

; data read by PackRecordFieldsToBank1Slot (6 bytes) (E-0347)
PackRecordFieldsToBank1Slot_Data::
    db $01, $0f, $1e, $29, $8e, $99

; Field 0's marks: packs four wPackFields entries into one byte at slot offset $21 and wPackValue's
; two bits into the top of offset $27; next field. (C1, E-0357)
PackRecordFieldsToBank1Slot_Data_CallSRAMRecordAddressOfArg1::
    call SRAMRecordAddressOfArg1
    ld a, $21
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $06
    add_a_to_hl
    ld a, [wPackValue]
    and $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackFieldIndex]
    inc a
    ld [wPackFieldIndex], a
    jp PackRecordFieldsToBank1Slot_Skip

; Field 1's marks: packs into slot offset $22 and bits 4-5 of offset $27; next field. (C1, E-0357)
PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg12::
    call SRAMRecordAddressOfArg1
    ld a, $22
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $05
    add_a_to_hl
    ld a, [wPackValue]
    and $03
    swap a
    ld b, a
    ld a, [hl]
    or b
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackFieldIndex]
    inc a
    ld [wPackFieldIndex], a
    jp PackRecordFieldsToBank1Slot_Skip

; Field 2's marks: packs into slot offset $23 and bits 2-3 of offset $27; next field. (C1, E-0357)
PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg13::
    call SRAMRecordAddressOfArg1
    ld a, $23
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, [wPackValue]
    and $03
    sla a
    sla a
    ld b, a
    ld a, [hl]
    or b
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackFieldIndex]
    inc a
    ld [wPackFieldIndex], a
    jp PackRecordFieldsToBank1Slot_Skip

; Field 3's marks: packs into slot offset $24 and bits 0-1 of offset $27; next field. (C1, E-0357)
PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg14::
    call SRAMRecordAddressOfArg1
    ld a, $24
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wPackValue]
    and $03
    ld b, a
    ld a, [hl]
    or b
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackFieldIndex]
    inc a
    ld [wPackFieldIndex], a
    jp PackRecordFieldsToBank1Slot_Skip

; Field 4's marks: packs into slot offset $25 and the top two bits of offset $28; next field. (C1,
; E-0357)
PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg15::
    call SRAMRecordAddressOfArg1
    ld a, $25
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wPackValue]
    and $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wPackFieldIndex]
    inc a
    ld [wPackFieldIndex], a
    jp PackRecordFieldsToBank1Slot_Skip

; Field 5's marks: packs into slot offset $26 and bits 4-5 of offset $28; then clears the field
; number and packs the two-bit values (Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1).
; (C1, E-0357)
PackRecordFieldsToBank1Slot_CallSRAMRecordAddressOfArg16::
    call SRAMRecordAddressOfArg1
    ld a, $26
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromPackFields
    pop hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    ld a, [wPackValue]
    and $03
    swap a
    ld b, a
    ld a, [hl]
    or b
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackFieldIndex], a
    jp Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1

; B = (wPackFields & 3) << 6 | (wPackFields + $1 & 3) << 4 | (wPackFields + $2 & 3) << 2 |
; (wPackFields + $3 & 3), the opposite of unpacking a byte into four 2-bit fields (E-0104)
Pack2BitFieldsFromPackFields::
    ld a, [wPackFields]
    and $03
    swap a
    sla a
    sla a
    ld b, a
    ld a, [wPackFields + $1]
    and $03
    swap a
    or b
    ld b, a
    ld a, [wPackFields + $2]
    and $03
    sla a
    sla a
    or b
    ld b, a
    ld a, [wPackFields + $3]
    and $03
    or b
    ld b, a
    ret

; Packs the two-bit values from SRAM record byte $73 on into the compact slot from offset $28: two
; into its low bits, then four to a byte for six bytes, and one in the top bits; then the record
; fields from offset $1A on. (C1, E-0357)
Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1::
    call SRAMRecordAddressOfArg1
    ld a, $28
    add_a_to_hl
    ld a, $73
    add e
    ld e, a
    jr nc, .call_enable_sram_bank0
    inc d

.call_enable_sram_bank0:
    call EnableSRAMBank0
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and $03
    or b
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or b
    ld [hli], a
    inc de
    ld c, $00

.loop:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    swap a
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and $03
    swap a
    or b
    ld b, a
    inc de
    ld a, [de]
    and $03
    sla a
    sla a
    or b
    ld b, a
    inc de
    ld a, [de]
    and $03
    or b
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $06
    jr c, .loop
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    swap a
    sla a
    sla a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    push hl
    call SRAMRecordAddressOfArg1
    pop hl
    ld a, $1a
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $01
    sla a
    ld b, a
    inc de
    inc de
    ld a, [de]
    and $01
    or b
    ld b, a
    dec de
    dec de
    dec de
    ld a, [de]
    ld c, a
    inc de
    inc de
    ld a, [de]
    ld e, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or b
    ld [hli], a
    ld a, c
    ld [hli], a
    ld a, e
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackFieldIndex], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push de
    ld a, $19
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $32
    add_a_to_hl
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop de
    pop hl
    ld a, $28
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, $33
    add_a_to_hl
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    ld a, $0b
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    ld c, $00

.loop2:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $22
    jr c, .loop2
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    ld a, $5b
    add e
    ld e, a
    jr nc, .call_enable_sram_bank02
    inc d

.call_enable_sram_bank02:
    ld a, $57
    add_a_to_hl
    call EnableSRAMBank0
    ld c, $00

.loop3:
    push bc
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    ld [wPackFields], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    ld [wPackFields + $1], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    ld [wPackFields + $2], a
    inc de
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $03
    ld [wPackFields + $3], a
    inc de
    call Pack2BitFieldsFromPackFields
    ld a, b
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop bc
    inc c
    ld a, c
    cp $02
    jr c, .loop3
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    ld a, $6b
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, $61
    add_a_to_hl
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $02
    sla a
    sla a
    swap a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $01
    swap a
    sla a
    sla a
    sla a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hld], a
    pop de
    ld a, $56
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $7f
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or b
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and $7f
    ld b, a
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or b
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    ld a, $6f
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, $67
    add_a_to_hl
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop de
    push de
    ld a, $6d
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop de
    push de
    ld a, $98
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop de
    push de
    ld a, $a3
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop de
    push de
    ld a, $a4
    add e
    ld e, a
    jr nc, .skip10
    inc d

.skip10:
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld [hli], a
    pop de
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    xor a
    ld [wPackWork], a
    ld a, $ff
    ld [wArg5], a
    ret

; unpacks the compact record in SRAM bank wArg2 back into the record fields (family, state, mark
; ...) (E-0131)
UnpackRecordFromBank1Slot::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $60
    srl a
    swap a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0d
    add e
    ld e, a
    jr nc, .read_arg2
    inc d

.read_arg2:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $1f
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    inc hl
    ld a, $0e
    add e
    ld e, a
    jr nc, .read_arg22
    inc d

.read_arg22:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $08
    srl a
    srl a
    srl a
    ld b, a
    ld a, [hl]
    and $f0
    or b
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .read_arg23
    inc d

.read_arg23:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $06
    srl a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $0b
    add e
    ld e, a
    jr nc, .read_arg24
    inc d

.read_arg24:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    and $01
    inc de
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push de
    call LoadRecordNameEntry0
    pop de
    push de
    ld a, $01
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank0
    inc d

.call_copy_ten_bytes_then_select_sram_bank0:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry1
    pop de
    push de
    ld a, $0f
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank02
    inc d

.call_copy_ten_bytes_then_select_sram_bank02:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry2
    pop de
    push de
    ld a, $1e
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank03
    inc d

.call_copy_ten_bytes_then_select_sram_bank03:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry3
    pop de
    push de
    ld a, $29
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank04
    inc d

.call_copy_ten_bytes_then_select_sram_bank04:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry4
    pop de
    push de
    ld a, $8e
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank05
    inc d

.call_copy_ten_bytes_then_select_sram_bank05:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry5
    pop de
    push de
    ld a, $99
    add e
    ld e, a
    jr nc, .call_copy_ten_bytes_then_select_sram_bank06
    inc d

.call_copy_ten_bytes_then_select_sram_bank06:
    ld hl, wNameGlyphBuf
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    jp CopyTenBytesThenSelectSRAMBank0_CallSRAMRecordAddressOfArg1

; copies 10 bytes from HL to DE, selecting SRAM bank 0 (rRAMB = 0) after each byte is read; HL and
; DE advance (E-0106)
CopyTenBytesThenSelectSRAMBank0::
    ld c, $00

.loop:
    ld a, [hl]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $0a
    jr c, .loop
    ret

; Unpacks the compact slot back into the record: the two-bit values from slot offset $28 into record
; bytes from $73, one per byte (the reverse of
; Pack2BitFieldsFromPackFields_CallSRAMRecordAddressOfArg1), and onward. (C1, E-0357)
CopyTenBytesThenSelectSRAMBank0_CallSRAMRecordAddressOfArg1::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $28
    add_a_to_hl
    push de
    ld a, $73
    add e
    ld e, a
    jr nc, .read_arg2
    inc d

.read_arg2:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $0c
    srl a
    srl a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    and $03
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld c, $00

.loop:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $30
    swap a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $0c
    srl a
    srl a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    and $03
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $06
    jr c, .loop
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $1a
    add e
    ld e, a
    jr nc, .read_arg22
    inc d

.read_arg22:
    inc hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    dec hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $02
    srl a
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp $01
    jr nz, .next
    dec de
    ld a, [de]
    inc de
    cp $ff
    jr nz, .next
    ld a, $ff
    ld [de], a

.next:
    inc de
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $01
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    inc hl
    inc hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp $ff
    jr nz, .skip
    inc de
    ld a, [de]
    cp $01
    jr nz, .skip
    ld a, $ff
    ld [de], a

.skip:
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $32
    add_a_to_hl
    push de
    ld a, $19
    add e
    ld e, a
    jr nc, .read_arg23
    inc d

.read_arg23:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $28
    add e
    ld e, a
    jr nc, .read_arg24
    inc d

.read_arg24:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0b
    add e
    ld e, a
    jr nc, .read_arg25
    inc d

.read_arg25:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $34
    add e
    ld e, a
    jr nc, .read_arg26
    inc d

.read_arg26:
    ld c, $00

.loop2:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $22
    jr c, .loop2
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $57
    add_a_to_hl
    push de
    ld a, $5b
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld c, $00

.loop3:
    push de
    push hl
    ld a, $04
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    pop hl
    pop de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg5]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg6]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg7]
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wArg8]
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $02
    jr c, .loop3
    pop de
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $61
    add_a_to_hl
    push de
    ld a, $6b
    add e
    ld e, a
    jr nc, .read_arg27
    inc d

.read_arg27:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    ld c, a
    ld a, [hli]
    and $80
    srl a
    srl a
    swap a
    ld b, a
    ld a, [hld]
    and $80
    srl a
    srl a
    srl a
    swap a
    or b
    ld b, a
    ld a, c
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de
    ld a, $56
    add e
    ld e, a
    jr nc, .read_arg28
    inc d

.read_arg28:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    and $7f
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    and $7f
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    ld a, $67
    add_a_to_hl
    push de
    ld a, $6f
    add e
    ld e, a
    jr nc, .read_arg29
    inc d

.read_arg29:
    ld c, $00

.loop4:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $04
    jr c, .loop4
    pop de
    push de
    ld a, $6d
    add e
    ld e, a
    jr nc, .read_arg210
    inc d

.read_arg210:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $98
    add e
    ld e, a
    jr nc, .read_arg211
    inc d

.read_arg211:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $a3
    add e
    ld e, a
    jr nc, .read_arg212
    inc d

.read_arg212:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $a4
    add e
    ld e, a
    jr nc, .read_arg213
    inc d

.read_arg213:
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hli]
    push af
    xor a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wPackWork], a
    ld a, $ff
    ld [wArg5], a
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $21 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 7-6 of byte $27, and copies the 5-glyph name entry at offset 3
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry0::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $21
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    inc hl
    inc hl
    inc hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $22 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 5-4 of byte $27, and copies the 5-glyph name entry at offset 8
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry1::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $22
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $08
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $23 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 3-2 of byte $27, and copies the 5-glyph name entry at offset $0D
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry2::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $23
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    and $0c
    srl a
    srl a
    ld [wMenuInputResult], a
    pop hl
    ld a, $0d
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $24 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 1-0 of byte $27, and copies the 5-glyph name entry at offset $12
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry3::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $24
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    ld a, $03
    add_a_to_hl
    ld a, [hl]
    and $03
    ld [wMenuInputResult], a
    pop hl
    ld a, $12
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $25 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 7-6 of byte $28, and copies the 5-glyph name entry at offset $17
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry4::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $25
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $17
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; record wArg1 (SRAM bank wArg2): unpacks byte $26 into the four 2-bit fields wArg5-wArg8, sets
; wMenuInputResult = bits 5-4 of byte $28, and copies the 5-glyph name entry at offset $1C
; (BuildFiveGlyphNameWithMarksToNameGlyphBuf); one of six name entries in the record (E-0120)
LoadRecordNameEntry5::
    call SRAMRecordAddressOfArg1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, $26
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsArg5
    inc hl
    inc hl
    ld a, [hl]
    and $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $1c
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToNameGlyphBuf
    ret

; fills wNameGlyphBuf with $F0 and copies up to five glyphs from HL, adding mark $8D or $8E after
; each glyph whose wArg5 field is 1 or 2 (E-0127)
BuildFiveGlyphNameWithMarksToNameGlyphBuf::
    ld de, wNameGlyphBuf
    ld c, $00

.loop:
    ld a, $f0
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $0b
    jr c, .loop
    ld bc, $0000
    ld de, wNameGlyphBuf

.loop2:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    push hl
    ld a, c
    ld hl, wArg5
    add_a_to_hl
    ld a, [hl]
    and a
    jr z, .restore
    cp $01
    jr z, .skip2
    cp $02
    jr z, .skip
    jr .restore

.skip:
    ld a, $8e
    jr .skip3

.skip2:
    ld a, $8d

.skip3:
    ld [de], a
    inc de

.restore:
    pop hl
    inc hl
    inc c
    ld a, c
    cp $05
    jr c, .loop2
    ld a, $f0

.done:
    ld [de], a
    ret

; with SRAM bank wArg2 selected, splits the byte at HL into four 2-bit fields: wArg5 = bits 7-6,
; wArg6 = bits 5-4, wArg7 = bits 3-2, wArg8 = bits 1-0 (E-0104)
UnpackByteAtHLTo2BitFieldsArg5::
    push af
    ld a, [wArg2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    ld [wArg5], a
    ld a, [hl]
    and $30
    swap a
    ld [wArg6], a
    ld a, [hl]
    and $0c
    srl a
    srl a
    ld [wArg7], a
    ld a, [hl]
    and $03
    ld [wArg8], a
    ret

; writes $0A to the RAM-enable register (rRAMG2 alias) and selects SRAM bank 0 (rRAMB = 0); clobbers
; A (E-0066)
EnableSRAMBank0::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ret

; HL = the word at wArg3/wArg4; DE = sRecords + $A5 * wArg1, the start of SRAM record wArg1 (records
; are $A5 bytes, as in SRAMRecordAddress); clobbers A, BC (E-0063)
SRAMRecordAddressOfArg1::
    ld a, [wArg3]
    ld l, a
    ld a, [wArg4]
    ld h, a
    push hl
    ld a, [wArg1]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret
    ds $4d8, $00
