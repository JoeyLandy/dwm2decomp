; ROM bank $1D: the vault menu, scripts and glyph tiles
; The annotated listing of this bank is build/listing/bank1d.asm.

SECTION "Bank 1D", ROMX[$4000], BANK[$1D]
    db $1d

; Loads DE with BeginStringDisplay_Bank1D_StringCategories, this bank string table, and calls
; BeginStringDisplay of the home bank, which starts the text printer on string wStringIndex of
; category wStringCategory. Only DebugMessageTest_Update_ShowBank1D (the message test of the debug
; menu, library $13) calls it, by far call. The 8 bytes after its ret are not reached from it. (C1,
; E-0379)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank1D::
    ld de, BeginStringDisplay_Bank1D_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd

; Not a table: DrawNameGlyph_Bank1D uses the address of this label ($4010) only as the base of
; GlyphFont, adding 16 * glyph to it, and returns the result in DE for a copy from ROM bank $1F,
; where GlyphFont lies at $4010; the six bytes here in bank $1D are never read as data. They are the
; tail of a code sequence that starts one byte earlier, at $400F: call $4001
; (BeginStringDisplay_Bank1D), call $2611 (RunStringDisplayToEnd), ret; the label sits on the
; operand of the first call. (C1, E-0381)
DrawNameGlyph_Bank1D_GlyphFontAddr::
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
VaultMenu_Store_WriteWindowMap::
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

; VaultMenu_Store_WriteWindowMap copies bytes from $44E3 to vBGMap1 + $300 until $7F (wScreenState =
; 3) (E-0226, C1)
; record: 99 tiles written in a run from vBGMap1 + $300 (32 per BG map row), then $7F
BGMap1TileRun::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $a6, $cf, $a5, $a7, $df, $eb, $ad, $c3, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9 ; entry 0
    db $ba, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4
    db $b4, $b4, $b5
    db $7f ; end

; VaultMenu_Store_WriteWindowMap copies bytes from $4547 to vBGMap1 + $300 until $7F (any other
; wScreenState) (E-0226, C1)
BGMap1TileRun_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $ea, $eb, $ad, $ed, $ee, $ef, $ab, $ac, $b7, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9 ; entry 0
    db $ba, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4
    db $b4, $b4, $b5
    db $7f ; end

; Far-called by VaultMenu_Store_DrawRows (step 2 of VaultMenu_Store and VaultMenu_TakeOut): copies
; three 16-byte tiles from bank $1F to vTiles2 + $7A0, + $7B0 and + $7C0 (tile numbers $7A, $7B,
; $7C), then draws three 4 x 1 tile rows (LoadThreeTilesAndDrawRows_TileRect,
; LoadThreeTilesAndDrawRows_TileRect_2 and LoadThreeTilesAndDrawRows_TileRect_3) at the scroll
; origin + $62, + $A2 and + $E2 (rows 3, 5 and 7, column 2), each time setting
; wTextCursorLo/wTextCursorHi to HL + $21. The rows sit beside the choice cursor places of
; VaultMenu_DrawChoiceCursorTile_Data, so they are the labels of the three choices of
; VaultMenu_Store_ItemsGoldExit (the tile pictures were not checked). (C1, E-0379)
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
VaultMenu_TakeOut_ItemsGoldExit::
    call VaultMenu_ItemsGoldExit_Cursor
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
    jr z, .call_vault_menu_count_items
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

.call_vault_menu_count_items:
    call VaultMenu_CountItems
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
VaultMenu_Store_ItemsGoldExit::
    call VaultMenu_ItemsGoldExit_Cursor
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
VaultMenu_ItemsGoldExit_Cursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_vault_menu_items_gold_exit_hide_cursor
    bit 7, a
    jr nz, .call_vault_menu_items_gold_exit_hide_cursor2
    bit 0, a
    jr nz, .call_vault_menu_blink_cursor_blink_ef_bank1_d
    bit 1, a
    jp nz, .return_02
    call VaultMenu_ItemsGoldExit_BlinkCursor
    xor a
    ret

.call_vault_menu_items_gold_exit_hide_cursor:
    call VaultMenu_ItemsGoldExit_HideCursor
    ld a, [wVaultMode]
    and a
    jr nz, .set_vault_mode
    ld a, $02
    jr .set_vault_mode2

.set_vault_mode:
    dec a

.set_vault_mode2:
    ld [wVaultMode], a
    call VaultMenu_ItemsGoldExit_ShowCursor
    ld a, $69
    call QueueSoundEffect
    xor a
    ret

.call_vault_menu_items_gold_exit_hide_cursor2:
    call VaultMenu_ItemsGoldExit_HideCursor
    ld a, [wVaultMode]
    cp $02
    jr c, .skip
    xor a
    jr .set_vault_mode2

.skip:
    inc a
    jr .set_vault_mode2

.call_vault_menu_blink_cursor_blink_ef_bank1_d:
    call VaultMenu_BlinkCursorBlinkEF_Bank1D_MarkChosen
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

.return_02:
    ld a, $02
    ret

; Blinks the cursor of the vault three-way choice (VaultMenu_Store_ItemsGoldExit and
; VaultMenu_TakeOut_ItemsGoldExit). While wJoypadRepeatTimer is below $14 it only draws the cursor
; tile $BB at choice place wVaultMode; from $14 on it adds 1 to wCursorBlinkEF and draws $BB below
; $10, the blank tile $C3 from $10 to $17, and at $18 resets the count to 0 and draws $BB.
; VaultMenu_ItemsGoldExit_Cursor calls it when no key is pressed. (C1, E-0379)
; cycles wCursorBlinkEF through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was VaultMenu_ItemsGoldExit_BlinkCursor)
VaultMenu_ItemsGoldExit_BlinkCursor::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, VaultMenu_ItemsGoldExit_ShowCursor
    ld a, [wCursorBlinkEF]
    inc a
    ld [wCursorBlinkEF], a
    cp $10
    jr c, VaultMenu_ItemsGoldExit_ShowCursor
    cp $18
    jr c, VaultMenu_ItemsGoldExit_HideCursor
    xor a
    ld [wCursorBlinkEF], a

; Sets B = $BB, the cursor tile, and continues in VaultMenu_DrawChoiceCursorTile, which writes B at
; vault choice place wVaultMode (scroll origin + $61, $A1 or $E1: rows 3, 5 and 7 at column 1, with
; no wrap step). Called after VaultMenu_ItemsGoldExit_Cursor has moved the choice, and reached from
; BlinkCursorBlinkEF_Bank1D. (C1, E-0379)
; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was VaultMenu_ItemsGoldExit_ShowCursor)
VaultMenu_ItemsGoldExit_ShowCursor::
    ld b, $bb
    jr VaultMenu_DrawChoiceCursorTile

; Sets B = $C3, the blank tile, and continues in VaultMenu_DrawChoiceCursorTile, which writes B at
; vault choice place wVaultMode. VaultMenu_ItemsGoldExit_Cursor calls it to hide the cursor before
; moving it, and VaultMenu_ItemsGoldExit_BlinkCursor for the hidden part of the blink. (C1, E-0379)
; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was VaultMenu_ItemsGoldExit_HideCursor)
VaultMenu_ItemsGoldExit_HideCursor::
    ld b, $c3
    jr VaultMenu_DrawChoiceCursorTile

; B = the chosen tile ($BC) for the vault choice. (C1, E-0357)
VaultMenu_BlinkCursorBlinkEF_Bank1D_MarkChosen::
    ld b, $bc

; Writes tile B at vault choice wVaultMode's place. (C1, E-0357)
VaultMenu_DrawChoiceCursorTile::
    ld a, [wVaultMode]
    add a
    ld hl, VaultMenu_DrawChoiceCursorTile_Data
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

; Three words that are offsets from the top left BG map entry of the visible screen
; (BGMapAddressAtScroll_Bank1D): $0061, $00A1, $00E1, which are rows 3, 5 and 7 of column 1.
; VaultMenu_DrawChoiceCursorTile indexes them with wVaultMode and writes tile B at that entry. (C1,
; E-0381)
VaultMenu_DrawChoiceCursorTile_Data::
    db $61, $00, $a1, $00, $e1, $00

; Saves the area the vault item list will cover: copies 9 rows of 12 tiles from the BG map at the
; scroll origin + $0088 (row 4, column 8) to BG map 1 at $9F70 (vBGMap1 + $370), one after the
; other, and on a Game Boy Color the attribute bytes too (SaveBGMapRectWithAttrs), then adds 1 to
; wScreenStep. Step 5 of VaultMenu_Store and VaultMenu_TakeOut (through
; VaultMenu_Store_SaveListArea); VaultMenu_Store_RestoreAreasAgain copies it back. It saves, it does
; not draw. (C1, E-0379)
; draws rect $0088 (9 x 12) at vBGMap1 + $370 (SaveBGMapRectWithAttrs) and wScreenStep += 1 (E-0122)
VaultMenu_SaveListAreaToBGMap1::
    ld hl, $0088
    ld de, vBGMap1 + $370
    lb bc, $09, $0c
    call SaveBGMapRectWithAttrs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Saves the vault quantity box area: copies 3 rows of 7 tiles from the BG map at the scroll origin +
; $0140 (row 10, column 0, around the digits at + $0161) to BG map 1 at $9FE0 (vBGMap1 + $3E0) with
; attributes (SaveBGMapRectWithAttrs). In state 3 (wScreenState = 3) it then calls
; ListDistinctInventoryItemsToItemGrid and VaultMenu_ReorderBagOrStorage (which in that state
; switches the bag order list and rebuilds wItemGrid in that order). Adds 1 to wScreenStep. Step 6
; of VaultMenu_Store and VaultMenu_TakeOut (through VaultMenu_Store_SaveArea). (C1, E-0379)
; draws rect $0140 (3 x 7) at vBGMap1 + $3E0; in state 3 also runs
; ListDistinctInventoryItemsToItemGrid and VaultMenu_ReorderBagOrStorage; wScreenStep += 1 (E-0122)
VaultMenu_SaveQuantityAreaToBGMap1::
    ld hl, $0140
    ld de, vBGMap1 + $3e0
    lb bc, $03, $07
    call SaveBGMapRectWithAttrs
    ld a, [wScreenState]
    cp $03
    jr nz, .check_screen_step
    farcall ListDistinctInventoryItemsToItemGrid
    farcall VaultMenu_ReorderBagOrStorage

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Storing, step 7: draws the 12 x 9 item window (with page brackets when two or more pages) and on
; the GBC clears its attributes. (C1, E-0357)
VaultMenu_Store_DrawListWindow::
    ld a, $01
    ld [wArg1], a
    call VaultMenu_Store_CountListRows
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank1_d
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, VaultMenu_Store_DrawListWindow_TileRect
    push hl
    call DrawRectSetTextCursorLoPlus21_Bank1D
    jr .check_is_cgb

.call_bg_map_address_at_scroll_bank1_d:
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, VaultMenu_Store_DrawListWindow_TileRect_2
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
VaultMenu_Store_DrawListWindow_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c7, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff, $c8, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $c9, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $d8, $d9, $da, $db, $dc, $dd, $de, $aa, $ca, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $c5, $c3, $c3, $be, $c3, $c3, $c6, $b5 ; id 8

VaultMenu_Store_DrawListWindow_TileRect_2::
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
VaultMenu_Store_DrawPageNumbers::
    xor a
    ld [wArg1], a
    call VaultMenu_Store_CountListRows
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

; C = the number of non-zero bytes among the $18 bytes of wItemGrid (B ends $18, HL = wItemGrid +
; $18, A is clobbered). VaultMenu_Store_CountListRows uses it in state 3 to count the distinct bag
; items after ListDistinctInventoryItemsToItemGrid has filled wItemGrid. (C2, E-0379)
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
; wListPages. (C2, E-0357; probed E-0379)
VaultMenu_CountItems::
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

; Adds 1 to wSelectedRecord and draws the vault item cursor of the list: below $10 the cursor tile
; $BB at item place wItemGridX (VaultMenu_Store_PutItemCursorTile), from $10 to $17 the blank tile
; $C3 (VaultMenu_Store_EraseItemCursor), and at $18 it resets the count to 0 and draws $BB. The same
; blink as BlinkCursorSelectedRecord_Bank1C but without the wJoypadRepeatTimer test; nothing in src/
; calls it, so whether it ever runs is not known. (C1, E-0379)
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
    jr c, VaultMenu_Store_EraseItemCursor
    xor a
    ld [wSelectedRecord], a

.skip:
    ld b, $bb
    jr VaultMenu_Store_PutItemCursorTile

; Draws the blank tile ($C3) at item cursor wItemGridX (VaultMenu_Store_PutItemCursorTile).
; VaultMenu_Store_CountListRows calls it, and BlinkCursorSelectedRecord_Bank1D, which has no caller
; in src/, jumps to it. Two unreached bytes follow ($06 $BC, ld b, $BC). (C1, E-0370)
VaultMenu_Store_EraseItemCursor::
    ld b, $c3
    jr VaultMenu_Store_PutItemCursorTile
    db $06, $bc

; Writes tile B at item cursor wItemGridX's place. (C1, E-0357)
VaultMenu_Store_PutItemCursorTile::
    ld a, [wItemGridX]
    add a
    ld hl, VaultMenu_Store_PutItemCursorTile_Data
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

; Four words that are offsets from the top left BG map entry of the visible screen: $00A9, $00E9,
; $0129, $0169, which are rows 5, 7, 9 and 11 of column 9. VaultMenu_Store_PutItemCursorTile indexes
; them with wItemGridX (0 to 3) and writes tile B at that entry. The bytes are identical to
; VaultMenu_Store_ItemCursor_DrawTile_Data. (C1, E-0381)
VaultMenu_Store_PutItemCursorTile_Data::
    db $a9, $00, $e9, $00, $29, $01, $69, $01

; Storing, step 10: draws the count beside the chosen item: in the bag the number of copies held, in
; storage the stored count of that item. (C1, E-0357)
VaultMenu_Store_DrawCount::
    ld hl, VaultMenu_Store_DrawCount_Data
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

; A 7 by 3 tile picture of the count box (three rows of 7 tile ids): top border $B0 $B1 x5 $B2,
; middle $B6 $C3 $C3 $BE $C3 $C3 $B7, bottom $B3 $B4 x5 $B5. VaultMenu_Store_DrawCount copies it to
; wScreenList, then the tens and ones digits of the count of the chosen item are stored in
; wDigitWorkA and wDigitWorkB, which are the two $C3 cells after $BE (row 1, columns 4 and 5), and
; the rectangle is drawn at the scroll origin + $0140. (C1, E-0381)
VaultMenu_Store_DrawCount_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $c3, $be, $c3, $c3, $b7, $b3, $b4
    db $b4, $b4, $b4, $b4, $b5

; Storing, step 11: the item cursor: Select (VaultMenu_ReorderBagOrStorage) back four steps;
; Right/Left turn the page; Up/Down move; A picks; B leaves with answer 2 and resumes the script.
; (C1, E-0357)
VaultMenu_Store_ItemCursor::
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_vault_menu_reorder_bag_or_storage
    bit 4, a
    jr nz, .check_saved_sprite_slot_count
    bit 5, a
    jr nz, .check_saved_sprite_slot_count2
    bit 6, a
    jp nz, .call_vault_menu_store_item_cursor_hide_cursor
    bit 7, a
    jp nz, .call_vault_menu_store_item_cursor_hide_cursor2
    bit 0, a
    jp nz, .call_queue_sound_effect
    call VaultMenu_Store_ItemCursor_Blink
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

.call_vault_menu_reorder_bag_or_storage:
    farcall VaultMenu_ReorderBagOrStorage
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.loop:
    call VaultMenu_Store_ItemCursor_Blink
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

.call_vault_menu_store_item_cursor_hide_cursor:
    call VaultMenu_Store_ItemCursor_HideCursor
    ld a, [wItemGridX]
    and a
    jr nz, .set_item_grid_x
    ld a, [wMenuChoice]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a
    call VaultMenu_Store_ItemCursor_ShowCursor
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_vault_menu_store_item_cursor_hide_cursor2:
    call VaultMenu_Store_ItemCursor_HideCursor
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
    call VaultMenu_Store_ItemCursor_ShowCursor
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_Store_ItemCursor_MarkChosen
    ld a, [wScreenState]
    cp $04
    jr z, .check_screen_step
    call VaultMenu_Store_CheckRoom
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

; Blinks the item cursor of the vault list. While wJoypadRepeatTimer is below $14 it only draws the
; cursor tile $BB at item place wItemGridX (VaultMenu_Store_ItemCursor_ShowCursor); from $14 on it
; adds 1 to wSelectedRecord and draws $BB below $10, the blank tile $C3 from $10 to $17, and at $18
; resets the count to 0 and draws $BB. VaultMenu_Store_ItemCursor calls it when no key is pressed
; and after a cursor move. (C1, E-0379)
; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was VaultMenu_Store_ItemCursor_Blink)
VaultMenu_Store_ItemCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, VaultMenu_Store_ItemCursor_ShowCursor
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp $10
    jr c, VaultMenu_Store_ItemCursor_ShowCursor
    cp $18
    jr c, VaultMenu_Store_ItemCursor_HideCursor
    xor a
    ld [wSelectedRecord], a

; Sets B = $BB, the cursor tile, and continues in VaultMenu_Store_ItemCursor_DrawTile, which writes
; B at item place wItemGridX of the vault list (scroll origin + $A9, $E9, $129 or $169: column 9 of
; rows 5, 7, 9 and 11). Called by VaultMenu_Store_ItemCursor after a move and from
; BlinkCursorSelectedRecord_Bank1D_2. (C1, E-0379)
; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was VaultMenu_Store_ItemCursor_ShowCursor)
VaultMenu_Store_ItemCursor_ShowCursor::
    ld b, $bb
    jr VaultMenu_Store_ItemCursor_DrawTile

; Sets B = $C3, the blank tile, and continues in VaultMenu_Store_ItemCursor_DrawTile: removes the
; cursor from item place wItemGridX of the vault list. VaultMenu_Store_ItemCursor calls it before
; the cursor moves, and VaultMenu_Store_ItemCursor_Blink for the hidden part of the blink. (C1,
; E-0379)
; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was VaultMenu_Store_ItemCursor_HideCursor)
VaultMenu_Store_ItemCursor_HideCursor::
    ld b, $c3
    jr VaultMenu_Store_ItemCursor_DrawTile

; B = the chosen tile ($BC) for the item cursor. (C1, E-0357)
VaultMenu_Store_ItemCursor_MarkChosen::
    ld b, $bc

; Writes tile B at item cursor wItemGridX's place (VaultMenu_Store_ItemCursor_DrawTile_Data). (C1,
; E-0357)
VaultMenu_Store_ItemCursor_DrawTile::
    ld a, [wItemGridX]
    add a
    ld hl, VaultMenu_Store_ItemCursor_DrawTile_Data
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

; Four words that are offsets from the top left BG map entry of the visible screen: $00A9, $00E9,
; $0129, $0169, which are rows 5, 7, 9 and 11 of column 9, identical to
; VaultMenu_Store_PutItemCursorTile_Data. VaultMenu_Store_ItemCursor_DrawTile indexes them with
; wItemGridX (0 to 3) and writes tile B at that entry. (C1, E-0381)
VaultMenu_Store_ItemCursor_DrawTile_Data::
    db $a9, $00, $e9, $00, $29, $01, $69, $01

; For the chosen bag item: 0 when storage has room for it (a slot with fewer than 99, or a free
; slot), $FE when its slot is full (99), $FF when all 100 slots hold other items. (C2, E-0357;
; probed E-0379)
VaultMenu_Store_CheckRoom::
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
VaultMenu_Store_EnterQuantity::
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_02
    bit 4, a
    jr nz, .call_vault_menu_store_enter_quantity_show
    bit 5, a
    jr nz, .call_vault_menu_store_enter_quantity_show2
    bit 6, a
    jp nz, .call_queue_sound_effect
    bit 7, a
    jp nz, .call_queue_sound_effect2
    bit 0, a
    jp nz, .call_vault_menu_store_enter_quantity_show3
    call VaultMenu_Store_EnterQuantity_BlinkDigit
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

.call_vault_menu_store_enter_quantity_show:
    call VaultMenu_Store_EnterQuantity_ShowDigit
    ld a, [wNumberEditPos]
    cp $01
    jr nz, .set_number_edit_pos
    xor a
    jr .set_number_edit_pos2

.set_number_edit_pos:
    inc a

.set_number_edit_pos2:
    ld [wNumberEditPos], a
    call VaultMenu_Store_EnterQuantity_BlinkDigit
    ld a, $69
    call QueueSoundEffect
    ret

.call_vault_menu_store_enter_quantity_show2:
    call VaultMenu_Store_EnterQuantity_ShowDigit
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
    call VaultMenu_Store_EnterQuantity_BlinkDigit
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
    call VaultMenu_Store_EnterQuantity_BlinkDigit
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
    call VaultMenu_Store_EnterQuantity_BlinkDigit
    ret

.set_number_ones2:
    inc a
    ld [wNumberOnes], a
    call VaultMenu_Store_EnterQuantity_BlinkDigit
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
    call VaultMenu_Store_EnterQuantity_BlinkDigit
    ret

.set_number_tens2:
    dec a
    ld [wNumberTens], a
    ld b, a
    ld a, [wNumberOnes]
    or b
    jr nz, .call_vault_menu_store_enter_quantity_blink
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtScroll161
    ret

.call_vault_menu_store_enter_quantity_blink:
    call VaultMenu_Store_EnterQuantity_BlinkDigit
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
    call VaultMenu_Store_EnterQuantity_BlinkDigit
    ret

.set_number_ones3:
    dec a
    ld [wNumberOnes], a
    call VaultMenu_Store_EnterQuantity_BlinkDigit
    ret

.call_vault_menu_store_enter_quantity_show3:
    call VaultMenu_Store_EnterQuantity_ShowDigit
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
    jr z, .call_vault_menu_store_add_to_storage
    call CheckListPagesPlusNumberAtMost18
    and a
    jr z, .clear_two_choice_cursor
    jr .set_two_choice_cursor_to_01

.call_vault_menu_store_add_to_storage:
    call VaultMenu_Store_AddToStorage
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

; Blinks the digit being edited in the vault quantity box. While wJoypadRepeatTimer is below $14 it
; only draws the digit ($E0 + wNumberTens or wNumberOnes, by wNumberEditPos) through
; VaultMenu_Store_EnterQuantity_ShowDigit; from $14 on it adds 1 to wCursorBlinkCD and draws the
; digit below $10, the digit cursor tile $CB from $10 to $17
; (VaultMenu_Store_EnterQuantity_ShowEditCursor), and at $18 resets the count to 0 and draws the
; digit. VaultMenu_Store_EnterQuantity calls it when no key is pressed and after each digit move or
; change. (C1, E-0379)
; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was VaultMenu_Store_EnterQuantity_BlinkDigit)
VaultMenu_Store_EnterQuantity_BlinkDigit::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, VaultMenu_Store_EnterQuantity_ShowDigit
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp $10
    jr c, VaultMenu_Store_EnterQuantity_ShowDigit
    cp $18
    jr c, VaultMenu_Store_EnterQuantity_ShowEditCursor
    xor a
    ld [wCursorBlinkCD], a

; Draws the edited quantity digit ($E0 + tens or ones) at its place. (C1, E-0357)
VaultMenu_Store_EnterQuantity_ShowDigit::
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
    jr VaultMenu_Store_EnterQuantity_DrawDigitTile

; B = the digit cursor tile ($CB). (C1, E-0357)
VaultMenu_Store_EnterQuantity_ShowEditCursor::
    ld b, $cb

; Writes tile B at digit place wNumberEditPos. (C1, E-0357)
VaultMenu_Store_EnterQuantity_DrawDigitTile::
    ld a, [wNumberEditPos]
    add a
    ld hl, VaultMenu_Store_EnterQuantity_DrawDigitTile_Data
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

; Two words that are offsets from the top left BG map entry of the visible screen: $0161 and $0162,
; which are row 11 columns 1 and 2: the tens and ones places of the quantity.
; VaultMenu_Store_EnterQuantity_DrawDigitTile indexes them with wNumberEditPos (0 or 1) and writes
; tile B at that entry. (C1, E-0381)
VaultMenu_Store_EnterQuantity_DrawDigitTile_Data::
    db $61, $01, $62, $01

; Draws the quantity of the vault quantity box: the tile $E0 + wNumberTens at the scroll origin +
; $0161 (row 11, column 1) and $E0 + wNumberOnes at + $0162, each written after WaitForVRAMAccess
; (no wrap step). Called by VaultMenu_Store_ItemCursor when the quantity entry starts and by
; VaultMenu_Store_EnterQuantity when Up or Down changes the quantity. (C1, E-0379)
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

; A = $FF when wListPages + 10 * wNumberTens + wNumberOnes (the sum taken as one byte) is more than
; $18 (24), else 0. VaultMenu_Store_EnterQuantity calls it when A is pressed outside state 3 (taking
; out): 0 means the bag has room for the entered count, $FF makes it answer wTwoChoiceCursor = 1.
; (C2, E-0379)
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
; ones; $FF (nothing changed) when the slot would reach 100 or more. (C2, E-0357; probed E-0379)
VaultMenu_Store_AddToStorage::
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
; is empty, otherwise 2. (C2, E-0357; probed E-0379)
VaultMenu_Store_MoveItems_TakeOut::
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
    jr z, .call_vault_menu_count_items
    ld a, c
    cp $18
    jr c, .loop

.call_vault_menu_count_items:
    call VaultMenu_CountItems
    ld a, [wListPages]
    cp $18
    jr c, .check_saved_sprite_clip_mode
    xor a
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_AfterStoring_Finish

.check_saved_sprite_clip_mode:
    ld a, [wSavedSpriteClipMode]
    and a
    jr nz, .set_two_choice_cursor_to_02
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_AfterStoring_Finish

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp VaultMenu_Store_AfterStoring_Finish

; After storing: answers 0 when the bag is empty, 1 when storage holds 9,900 or more items in all,
; otherwise 2; then the next step. (C2, E-0357; probed E-0379)
VaultMenu_Store_AfterStoring::
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
    jp VaultMenu_Store_AfterStoring_Finish

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
    jr VaultMenu_Store_AfterStoring_Finish

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

; Ends the store and take-out steps: clears wTextCounter1 and wTextCounter3, flips wCounterPtr0Lo
; and runs VaultMenu_ReorderBagOrStorage, which flips it back (so it ends as it began) and then
; rebuilds wItemGrid from the bag in state 3, or sorts wItemStorage in the other states, in the
; order list of wCounterPtr0Lo (1: ItemOrderListA, 0: ItemOrderListB). Adds 1 to wScreenStep. Jumped
; to by VaultMenu_Store_AfterStoring and VaultMenu_Store_MoveItems_TakeOut with the answer already
; in wTwoChoiceCursor. (C2, E-0379)
VaultMenu_Store_AfterStoring_Finish::
    xor a
    ld [wTextCounter1], a
    ld [wTextCounter3], a
    ld a, [wCounterPtr0Lo]
    inc a
    and $01
    ld [wCounterPtr0Lo], a
    farcall VaultMenu_ReorderBagOrStorage
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

; Writes $80 zero bytes from $9700 (vTiles2 + $700), each write with interrupts off after
; WaitForVRAMAccess. Nothing in src/ calls it, so whether it ever runs is not known. (C1, E-0379)
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
VaultMenu_Store_BackToList::
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

; Saves a 13 x 3 area: copies 3 rows of 13 tiles from the BG map at the scroll origin + $0147 (row
; 10, column 7) to BG map 1 at $9F70 (vBGMap1 + $370) with attributes (SaveBGMapRectWithAttrs), adds
; 1 to wScreenStep, clears wCursorBlinkCD and the three bytes of wThreeDigits and sets
; wNumberEditPos = 2. Step 17 of VaultMenu_Store and VaultMenu_TakeOut (through
; VaultMenu_Store_SaveGoldArea); VaultMenu_Store_RestoreGoldArea copies the area back. (C1, E-0379)
; draws rect $0147 (3 x 13) at vBGMap1 + $370, wScreenStep += 1, clears wCursorBlinkCD-wThreeDigits
; + $2 and sets wNumberEditPos = 2 (E-0122)
VaultMenu_SaveGoldAreaToBGMap1::
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
VaultMenu_Store_DrawBankedGold::
    ld hl, wScreenList
    ld de, VaultMenu_Store_DrawBankedGold_Data
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

; A 9 by 3 tile picture of the banked gold box (three rows of 9 tile ids): top border $B0 $B1 x7
; $B2, middle $B6 $BF $C3 x6 $B7, bottom $B3 $B4 x7 $B5. VaultMenu_Store_DrawBankedGold copies it to
; wScreenList, then writes the six digit tiles of wBankedGold* into wDigitWorkA onward (row 1,
; columns 2 to 7) and draws the rectangle at the scroll origin + $014B. The copy loop runs 39 ($27)
; times, so the 12 bytes after the table (the start of VaultMenu_Store_DrawAmountBox) are copied to
; wScreenList as well and the rectangle draw does not use them. (C1, E-0381)
VaultMenu_Store_DrawBankedGold_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $bf, $c3, $c3, $c3, $c3, $c3
    db $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; Storing gold, step 20: draws the amount box with the three digits of the amount (wThreeDigits);
; for depositing the limit is the gold in hand, for withdrawing the banked gold (at most 99,900,
; shown as 999). (C1, E-0357)
VaultMenu_Store_DrawAmountBox::
    ld hl, wScreenList
    ld de, VaultMenu_Store_DrawAmountBox_Data
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

; An 8 by 2 tile picture of the amount box (two rows of 8 tile ids): $B6 $BF $C3 $C3 $C3 $E0 $E0
; $B7, then the bottom border $B3 $B4 x6 $B5. VaultMenu_Store_DrawAmountBox copies it to wScreenList
; and replaces the three $C3 cells (wGrid2CursorX, wGrid2CursorY, wScreenArea: columns 2 to 4 of row
; 0) with $E0 + each digit of wThreeDigits; the two $E0 tiles at columns 5 and 6 are fixed zero
; digits, and the rectangle is drawn at the scroll origin + $006C. (C1, E-0381)
VaultMenu_Store_DrawAmountBox_Data::
    db $b6, $bf, $c3, $c3, $c3, $e0, $e0, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; Storing gold, step 21: the amount entry (VaultMenu_EnterThreeDigits); B goes on with answer 2; on
; A with a non-zero amount, turns the three digits into gold (x 10,000, 1,000 and 100) and adds the
; banked gold: a total of 999,901 or more is refused (wTwoChoiceCursor = 1). (C1, E-0357)
VaultMenu_Store_EnterGold::
    call VaultMenu_EnterThreeDigits
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
VaultMenu_TakeOut_EnterGold::
    call VaultMenu_EnterThreeDigits
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
VaultMenu_EnterThreeDigits::
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_CapAtLimit
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.loop:
    inc a
    ld [wThreeDigits + $1], a
    call VaultMenu_EnterThreeDigits_CapAtLimit
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.check_three_digits:
    ld a, [wThreeDigits + $2]
    cp $09
    jr c, .set_three_digits2
    xor a
    ld [wThreeDigits + $2], a
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.set_three_digits2:
    inc a
    ld [wThreeDigits + $2], a
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.set_three_digits4:
    dec a
    ld [wThreeDigits + $1], a
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.check_three_digits4:
    ld a, [wThreeDigits + $2]
    and a
    jr nz, .set_three_digits5
    ld a, $09
    ld [wThreeDigits + $2], a
    call VaultMenu_EnterThreeDigits_BlinkCursor
    xor a
    ret

.set_three_digits5:
    dec a
    ld [wThreeDigits + $2], a
    call VaultMenu_EnterThreeDigits_BlinkCursor
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
VaultMenu_EnterThreeDigits_BlinkCursor::
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
    ld hl, VaultMenu_EnterThreeDigits_BlinkCursor_Data
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

; Three words that are offsets from the top left BG map entry of the visible screen: $006E, $006F,
; $0070, which are row 3 columns 14, 15 and 16: the three digit places of the number editor.
; VaultMenu_EnterThreeDigits_BlinkCursor indexes them with wNumberEditPos (0 to 2) and writes either
; the digit tile ($E0 + wThreeDigits[wNumberEditPos]) or the blank-cursor tile $CB there, to make
; the edited digit blink. (C1, E-0381)
VaultMenu_EnterThreeDigits_BlinkCursor_Data::
    db $6e, $00, $6f, $00, $70, $00

; Draws the three digits in wThreeDigits as tiles ($E0 + digit) at the BG map entries $6E past
; BGMapAddressAtScroll_Bank1D (row 3, column 14 of the screen at the current scroll), one tile per
; byte, each written with interrupts off after WaitForVRAMAccess. The Vault amount entry steps
; (VaultMenu_EnterThreeDigits, VaultMenu_Store_EnterGold and VaultMenu_TakeOut_EnterGold) call it
; after every change of the digits. Clobbers A, BC, DE and HL. (C1, E-0379)
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

; Reads the count byte of the Vault entry under the item cursor, wItemStorage + 8 * wItemGridY + 2 *
; wItemGridX + 1 (each entry is an item id followed by a count, four entries per row), and stores
; count / 10 in wCountTens and count mod 10 in wCountOnes by DivideHLByA; a count above 99 would
; give a tens value above 9. Called by VaultMenu_Store_ItemCursor. (C2, E-0379)
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

; Copies a rectangle of the BG map into VRAM at DE: HL = offset of its top-left tile from the screen
; origin at the current scroll (BGMapAddressAtScroll_Bank1D + HL), B = number of rows, C = tiles per
; row (the other way round from the usual width in B and rows in C). Source rows are $20 apart, the
; destination runs on without gaps, and on CGB every tile is also copied with VRAM bank 1 selected,
; so its attribute byte lands at the same offset in bank 1 of the destination. Each byte is read and
; written after WaitForVRAMAccess with interrupts off; C is parked in wListCursorBlink while the
; rows are counted. The three Vault callers (VaultMenu_SaveListAreaToBGMap1,
; VaultMenu_SaveQuantityAreaToBGMap1 and VaultMenu_SaveGoldAreaToBGMap1) save the screen areas under
; their windows into vBGMap1; a Vault step in bank $1C draws those areas back. (C1, E-0379)
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

; Looks for room in the Vault for the first bag item that has any. It walks the 24 slots of
; wInventory (0 and $FF are skipped) and for each item the 100 two-byte entries of wItemStorage in
; order: an entry with the same item id and a count below $63 or the first empty entry (id 0) ends
; the whole search with A = 0, B = bag slot number, C = entry number, DE = address of the bag slot,
; and HL = the count byte of a matching entry or the id byte of the empty one; an entry holding
; another item is passed over, so is a matching entry that already holds $63, and an empty entry
; ends the search for that item even if a later entry matches. When an item finds nothing in all 100
; entries the next bag slot is tried, and A = $FF when no item finds room. The only caller,
; VaultMenu_Store_ItemsGoldExit, tests just whether A is $FF. (C2, E-0379)
; for each inventory item finds a matching or free wItemStorage slot (100 two-byte slots)
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

; A = 0 when one of the 100 two-byte entries at wItemStorage has a non-zero first byte (item id),
; else A = $FF; the count byte is not looked at. Clobbers C and HL. No call to it is named in src/.
; (C2, E-0379)
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for the top-left pixel of the
; screen at the current scroll; clobbers A and DE. The Vault menu drawing steps add their own
; offsets to it. Same bytes as the BGMapAddressAtScroll_Bank1D copies in other banks. (C1, E-0379)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
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

; Copies the B x C tile rectangle at DE (B = width, C = rows) to the BG map at HL with
; CopyRectToBGMapWrapped_Bank1D and sets wTextCursorLo and wTextCursorHi to HL + $1C1 (14 rows down,
; one column right). On CGB it then does a second copy of the same rectangle from the same DE to the
; same HL with VRAM bank 1 selected (rVBK = 1) and WRAM bank 2 switched in (rSVBK = 2), so a source
; in VRAM or in WRAM bank 2 is read as attribute data and written to the attribute map, and sets
; both bank registers back to 0. BC, DE and HL are unchanged after the first copy. No call to this
; bank copy is named in src/. (C1, E-0379)
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

; Copies the B x C tile rectangle at DE (B = width, C = rows) to the BG map at HL with
; CopyRectToBGMapWrapped_Bank1D and sets wTextCursorLo and wTextCursorHi to HL + $21 (one row down,
; one column right of the box corner). BC, DE and HL are unchanged; A is clobbered. Called by the
; Vault drawing steps (LoadThreeTilesAndDrawRows, VaultMenu_Store_DrawListWindow,
; VaultMenu_Store_DrawCount, VaultMenu_Store_DrawBankedGold and VaultMenu_Store_DrawAmountBox). (C1,
; E-0379)
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

; Copies a tile rectangle from DE to the BG map at HL: B = width, C = rows, the source runs on
; without gaps. Each tile goes out through WriteVRAMByteInc; when HL reaches the start of the next
; 32-tile row it is moved back $20, so a row that runs past column 31 wraps to column 0 of the same
; row, and each new row starts $20 further on with H masked by $9B so the map wraps from the last
; row to the first. Returns with C = 0 and HL at the start of the last row. Called by the two
; DrawRect routines above it in this bank, and by itself for the next row. (C1, E-0379)
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

; HL = 10 * wNumberTens + wNumberOnes, computed as 2 * tens + 8 * tens + ones in 16 bits (so tens
; values above 25 still fit); clobbers A and DE. Turns the two digits of a number being edited into
; its value for CheckListPagesPlusNumberAtMost18, VaultMenu_Store_AddToStorage and
; VaultMenu_Store_MoveItems_TakeOut. (C2, E-0379)
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
VaultMenu_EnterThreeDigits_CapAtLimit::
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

; Recounts the list on screen in rows of four: in state 3 (storing) the bag's distinct items in
; wItemGrid (CountNonZeroItemGridBytes), otherwise the stored items (wSavedSpriteClipMode;
; VaultMenu_CountItems runs in both cases). Sets wSavedSpriteSlotCount and HL to the row count,
; rounded up. When wItemGridY is on or past the last row and that row is not full, wMenuChoice =
; that row's last column and a cursor past it is erased (unless wArg1 is non-zero) and pulled back
; into wItemGridX; when the last row is full and wItemGridY is past it, wItemGridY steps back one
; row; otherwise wMenuChoice = 3. (C1, E-0370)
VaultMenu_Store_CountListRows::
    ld a, [wScreenState]
    cp $03
    jr z, .call_vault_menu_count_items
    call VaultMenu_CountItems
    call CountNonZeroItemGridBytes
    ld a, [wSavedSpriteClipMode]
    jr .skip

.call_vault_menu_count_items:
    call VaultMenu_CountItems
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
    call VaultMenu_Store_EraseItemCursor

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

; Fills the stats box of SRAM record wArg1 in wWindowTileBuffer, with SRAM bank 0 enabled for the
; duration and disabled again at the end. Writes the sex mark tile ($CC + bit 0 of MON_SEX) at
; offset +$86, the level (MON_LEVEL as tens and ones digit tiles, $E0 + digit, a leading zero blank)
; at +$89 and +$8A, and the four words MON_HP, MON_MAX_HP, MON_MP and MON_MAX_MP as three digit
; tiles each at +$D4, +$D8, +$FC and +$100, with leading zeros made blank by
; BlankLeadingZeroDigits_F. A word above 999 gives a first digit tile above $E9 because
; HLToDecimalDigits keeps hundreds in one byte. Far-called by the hibernate, breed and swap screens.
; (C2, E-0379; probed E-0384)
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

; Four bytes $5B, $5D, $5F, $61: the record offsets of the four word fields MON_HP, MON_MAX_HP,
; MON_MP and MON_MAX_MP. DrawRecordStatsBoxForArg1 loops c = 0 to 3, reads field c of SRAM record
; wArg1 with LoadSRAMRecordWord, converts it with HLToDecimalDigits and draws the three digits at
; word c of DrawRecordStatsBoxForArg1_Data2. (C1, E-0381)
DrawRecordStatsBoxForArg1_Data1::
    db $5b, $5d, $5f, $61

; Four words, addresses of cells in wWindowTileBuffer (rows of 20 bytes): $C3D4, $C3D8, $C3FC,
; $C400, which are row 10 column 12, row 10 column 16, row 12 column 12 and row 12 column 16.
; DrawRecordStatsBoxForArg1 writes the three digit tiles ($E0 + digit) of field c of
; DrawRecordStatsBoxForArg1_Data1 (current HP, maximum HP, current MP, maximum MP) starting at word
; c. (C1, E-0381)
DrawRecordStatsBoxForArg1_Data2::
    db $d4, $c3, $d8, $c3, $fc, $c3, $00, $c4

; Draws the pedigree sprites (DrawPedigreeSpeciesSprites) of the record in the list cell
; wListEntries + 5 * wListPageIndex + wListCursor: it sets wArg1 and wArg2 to the address of that
; cell (from SetArg5ToListEntriesCell5). The drawing code uses wArg1 to wMenuInputResult and hTemp0
; to hSpriteScrollXLo as scratch, so those 9 and 13 bytes are saved in wRecordBuffer first and
; copied back at the end. Called by the link session and swap menu detail screens. (C1, E-0379)
; saves wArg1-wMenuInputResult and hTemp0-hSpriteScrollXLo, runs DrawPedigreeSpeciesSprites for the
; record at wListEntries cell 5, then restores them (E-0125)
DrawListEntriesCell5PedigreeSprites::
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
    call DrawPedigreeSpeciesSprites
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

; Draws the species sprite of the record in the list cell wListEntries + 5 * wListPageIndex +
; wListCursor (SetArg5ToListEntriesCell5): reads its MON_SPECIES word from SRAM bank 0 (disabled
; again straight after), puts it in wArg1 and wArg2 and calls DrawSpeciesMetaSpriteAtScrollOffset
; with X offset $90, Y offset $40, tile offset 0 and attribute 0. wArg1 to wMenuInputResult and
; hTemp0 to hSpriteScrollXLo are saved in wRecordBuffer first and restored at the end. Called by the
; link session and swap menu detail screens. (C1, E-0379)
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

; Takes the record number in the list cell wListEntries + 5 * wListPageIndex + wListCursor
; (SetArg5ToListEntriesCell5), enables SRAM bank 0 and jumps to CopyRecordNameToTextBuf0 with A =
; that record number, which copies its name into wTextBuf0 (at most 10 letters, $F0-terminated) and
; disables SRAM. No call or jump to this label is named in src/. (C2, E-0379; probed E-0384)
; with SRAM bank 0 enabled reads the record at wListEntries cell 5 and continues at
; CopyRecordNameToTextBuf0 (E-0126) (E-0344: the address in its name dropped or read as the label
; there; was LoadListEntriesCell5RecordAndContinue)
LoadListEntriesCell5RecordAndContinue::
    call SetArg5ToListEntriesCell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    jr CopyRecordNameToTextBuf0

; Enables SRAM bank 0 (rRAMG2, rRAMB = 0) and copies the name (MON_NAME) of SRAM record
; wSelectedRecord into wTextBuf0, at most 10 letters and $F0-terminated, by falling into
; CopyRecordNameToTextBuf0. Far-called by HibernateMenu_ChooseRecords_ReadSwapAnswer when the swap
; is answered yes. (C2, E-0370; probed E-0384)
CopySelectedRecordNameToTextBuf0::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]

; A = SRAM record (SRAM enabled by the caller): copies its MON_NAME into wNameGlyphBuf
; (CopyRecordNameToNameGlyphBuf, which writes the placeholder bytes $98, $98, $98, $90, $90 for a
; record whose first name byte is $FF), stores $F0 at wNameGlyphBuf + $A, disables SRAM (rRAMG2 =
; 0), then copies bytes from wNameGlyphBuf to wTextBuf0 up to the first $F0 or 10 bytes and ends
; wTextBuf0 with $F0. Entered by CopySelectedRecordNameToTextBuf0 falling through and by a jump from
; LoadListEntriesCell5RecordAndContinue (which has no direct caller). (C2, E-0370; probed E-0384)
CopyRecordNameToTextBuf0::
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

; Draws two names as glyph tiles for SRAM record wArg1, with SRAM bank 0 enabled and disabled again
; at the end. Its MON_NAME goes to wNameGlyphBuf ($F0 stored at +$A) and CopyGlyphTilesToVRAM draws
; it at vTiles1 + $780; then the MON_SPECIES word is turned into the string of that species through
; the second table of StringDatabase (bank $08, 16 bytes copied to wNameGlyphBuf) and drawn at
; vTiles1 + $270. Far-called by the breed, hibernate and swap screens to put the name and species
; into the tiles of their windows. (C1, E-0379)
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

; Uses wAreaGraphicsIndex as an index into two 3-byte far pointer tables: the entry of
; AreaTilesetTable is decompressed to vTiles2 (DecompressToVRAM) and the entry of AreaPaletteTable
; gives $40 bytes that CopyFromBankWaitVRAM copies to wBGPaletteBuffer. Both tables hold two entries
; (index 0 and 1). Far-called by SwapMonstersMenu_ShowMonsterDetails_ReloadArea. (C1, E-0379)
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

; HL = wListEntries + 5 * wListPageIndex + wListCursor, the address of the list cell under the
; cursor for lists of five cells per page (the index is added as one byte); also stores H in wArg5
; and L in wArg6. Clobbers A and B. Called, mostly by farcall, by the record list screens that need
; the record number under the cursor. (C2, E-0379)
; wArg5/wArg6 (big-endian pointer) = wListEntries + 5 * wListPageIndex + wListCursor
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

; HL = wListEntries + 4 * wListPageIndex + wListCursor, the address of the list cell under the
; cursor for lists of four cells per page (the index is added as one byte); also stores H in wArg5
; and L in wArg6. Clobbers A and B. Called, mostly by farcall, by the egg, key, prize and breed list
; screens. (C2, E-0379)
; wArg5/wArg6 (big-endian pointer) = wListEntries + 4 * wListPageIndex + wListCursor
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

; Shows the item name of a record: takes the record number in the list cell wListEntries + 5 *
; wListPageIndex + wListCursor, reads its MON_ITEM byte from SRAM bank 0 (disabled again straight
; after), sets wStringIndex to it and wStringCategory to $0B, sets the text window (the four bytes
; from wTextWindowTileLo) to the tiles at $9320 with 2 rows and width 6 and far-calls
; ShowString_Bank08. Category $0B is the table of equipment names such as 'VIT Belt' and 'Stone
; Fang'. Far-called by SwapMonstersMenu_ShowMonsterDetails_LoadSprite. (C1, E-0379)
; shows string (field $A4 of the record at wListEntries cell 5) of category $0B at $9320 with size
; $0602 (E-0121)
ShowListEntriesCell5RecordItemName::
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

; For the record in cell 5 of wListEntries (SetArg5ToListEntriesCell5) reads its MON_SPECIES word
; from SRAM bank 0, loads the species record (LoadSpeciesRecord) and shows string
; SPECIES_FIELD_ABILITY of category $0D, the field ability name, through ShowString_Bank08 with the
; text window at $9680 (wTextWindowTileLo/Hi = $80, $96, then $02, $06). Far-called by
; SwapMonstersMenu_ShowMonsterDetails_ShowCategory (stats screen step 26). (C1, E-0372)
; loads the species of the record at wListEntries cell 5 (field $0B) and shows string
; [wSpeciesRecord + $B] of category $0D at $9680 with size $0602 (E-0121)
ShowCursorRecordFieldAbility::
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

; Sets wRecordsInUse to the number of SRAM records among the first wRecordCapacity ones ($A5 bytes
; apart from sRecords) whose state byte MON_STATE is 1 or 2; the capacity comes from
; LoadRecordCapacityFromFarmLevelTable. SRAM bank 0 is enabled before each record is read and SRAM
; is disabled at the end. Clobbers A, BC, DE and HL. Called by the option box and count steps of the
; hibernate and swap menus (for example SwapMonstersMenu_SetupPartyList_DrawOptions and
; SwapMonstersMenu_Check_RedrawCounts) and by the prize menu. (C2, E-0379; probed E-0384)
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

; Clears wRecordCapacity bytes of wListEntries (10, 20 or 30, from
; LoadRecordCapacityFromFarmLevelTable), sets wListCount to 0, then takes the record numbers of
; wPartyList in order and appends each whose MON_STATE is 2 to wListEntries, counting them in
; wListCount. The loop ends when the number appended equals wPartyCount (it compares wPartyCount
; with the count of records listed, not with the number of party slots looked at). SRAM bank 0 is
; enabled during the scan and disabled at the end. (C2, E-0379; probed E-0384)
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

; Clears 30 bytes of wListEntries and sets wListCount and wRecordsFlagged to 0, then scans the first
; wRecordCapacity SRAM records in order: a record whose MON_STATE is 1 and whose MON_EGG is 0 has
; its number appended to wListEntries (wListCount counts them), and a state-1 record whose MON_EGG
; is non-zero only adds 1 to wRecordsFlagged. SRAM bank 0 is enabled during the scan and disabled at
; the end. (C2, E-0379; probed E-0384)
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

; Clears 30 bytes each of wListEntries and wListEntries2 and sets wListCount and wRecordsFlagged to
; 0, then scans the first wRecordCapacity SRAM records in order: a record whose MON_STATE is 1 or 2
; and whose MON_EGG is 0 has its number appended to wListEntries (wListCount counts them), and one
; with MON_EGG non-zero only adds 1 to wRecordsFlagged. It then disables SRAM and falls straight
; into the next routine (see MovePartyRecordsToFrontOfList), so the party members end up first in
; the list and the list is padded with $FF. (C2, E-0379; probed E-0384)
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

; Does nothing when wListCount is 0. Otherwise, for each record number of wPartyList (wPartyCount of
; them, in order) it looks for that number in the first wListCount entries of wListEntries, marks
; the entry $FF and copies the number into wListEntries2; then it appends the unmarked entries in
; their old order, copies wListCount bytes of wListEntries2 back to wListEntries and, when
; wListCount is below $1E, fills the rest of the 30-byte list with $FF. So the party members present
; in the list come first, in party order. Called directly by BreedMenu_ListMates and the
; ListAvailableRecordsForSelection routines, and reached by fall-through from the routine before it
; (see ListRecordsInUseNotEggs). (C2, E-0379)
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

; Clears 30 bytes of wListEntries and sets wListCount and wRecordsFlagged to 0, then scans the first
; wRecordCapacity SRAM records in order and appends the number of each one whose MON_STATE is 1 or 2
; and whose MON_EGG is non-zero (appraised or not) to wListEntries. At the end wListCount and
; wRecordsFlagged both hold the number of eggs listed. SRAM bank 0 is enabled during the scan and
; disabled at the end. (C2, E-0379; probed E-0384)
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

; Draws the species names of the records on page wListPageIndex of wListEntries (four records per
; page, at most wListCount of them) as glyph tiles. For each record it reads MON_SPECIES from SRAM
; bank 0, finds the species string through the second table of StringDatabase (bank $08), copies its
; 16 bytes to wNameGlyphBuf with $F0 as the last byte, and calls
; DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D with C = the record number on the page (0-3), which
; picks the tile slots with the layout in wArg5. SRAM is disabled at the end. (C1, E-0379)
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

; Draws the $F0-terminated text at wNameGlyphBuf glyph by glyph, one VRAM tile slot per glyph, with
; C = the name number on the page (kept for DrawNameGlyph_Bank1D) and wArg5 = the slot layout.
; wGlyphListPos walks the text and wGlyphListStart the slots: an ordinary glyph is copied into its
; slot with CopyFromBankWaitVRAM, while a mark glyph $8D or $8E first steps wGlyphListStart back and
; is ORed into the tile of the previous glyph with OrFromBankWaitVRAM. Both counters are 0 again on
; return. Far-called after a name is put in wNameGlyphBuf (DrawRecordListPageSpeciesNames is one of
; the callers). (C1, E-0379)
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
    call DrawNameGlyph_Bank1D
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
    call DrawNameGlyph_Bank1D
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
; from the destination table for layout wArg5 (0-4) at wGlyphListStart; B = $1F, C = $10. (C2,
; E-0357; probed E-0379)
DrawNameGlyph_Bank1D::
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    ld hl, DrawNameGlyph_Bank1D_GlyphFontAddr
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

; DrawNameGlyph_Bank1D picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299),
; reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL
; (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy
; (E-0235) (E-0239, C1)
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

; DrawNameGlyph_Bank1D picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299),
; reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL
; (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy
; (E-0235) (E-0239, C1)
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

; DrawNameGlyph_Bank1D picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299),
; reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL
; (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy
; (E-0235) (E-0239, C1)
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

; DrawNameGlyph_Bank1D picks the table by wArg5 (0 $61D9, 1 $6229, 2 $6279, 3 $6285, else $6299),
; reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL
; (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10, as the bank $0D copy
; (E-0235) (E-0239, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable_1D_4::
    dw GlyphTileDests_1D_4_0 ; id 0

; list 0 of GlyphTileDestTable_1D_4; 9 words (E-0239, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests_1D_4_0::
    dw vTiles2 + $7c0, vTiles2 + $7d0, vTiles2 + $7e0, vTiles2 + $7f0, vTiles1 + $400, vTiles1 + $410 ; entry 0
    dw vTiles1 + $420, vTiles1 + $4a0, vTiles1 + $4b0

; For each of the wPartyCount records of wPartyList (SRAM bank 0 enabled, disabled at the end)
; copies its MON_NAME to wNameGlyphBuf with $F0 stored at +$A and draws it with CopyGlyphTilesToVRAM
; at the VRAM address from DrawRecordListNameTiles_Bank1D_Data ($8D00, $8D50 and $8DA0 for party
; members 0 to 2). Then it puts the default text window back: the four bytes from wTextWindowTileLo
; become $8800 (tile address), 2 rows and width $12. Far-called when menus close and redraw the
; names (CloseBreedMenu_RedrawNamesAndFinish, CloseShopMenu_RedrawNamesAndFinish and
; CloseHibernateMenu_RedrawNamesAndFinish). (C1, E-0379)
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

; Three words, VRAM tile addresses $8D00, $8D50, $8DA0 (vTiles1 + $500, + $550, + $5A0).
; DrawRecordListNameTiles_Bank1D copies the name of party member c (from wPartyList, c below
; wPartyCount) to wNameGlyphBuf and has CopyGlyphTilesToVRAM draw its glyph tiles at word c. (C1,
; E-0381)
DrawRecordListNameTiles_Bank1D_Data::
    db $00, $8d, $50, $8d, $a0, $8d

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for the top-left pixel of the
; screen at the current scroll; clobbers A and DE. A second copy of BGMapAddressAtScroll_Bank1D
; inside this bank, used by the list, mark and cursor drawing routines after it
; (DrawRecordListPageMarks, UpdateListCursorListCursor_DrawTile, UpdatePagedListCursor_DrawTile and
; others). (C1, E-0379)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
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

; Draws a mark beside each record on page wListPageIndex of wListEntries (four per page, at most
; wListCount of them). The tile is $CC + bit 0 of MON_SEX when the record MON_EGG is 2 (an appraised
; egg) and $CE for any other record. wArg2 (0, 1 or anything else) picks one of three layouts: the
; tile goes to the BG map at BGMapAddressAtScroll_Bank1D_2 plus an offset from
; DrawRecordListPageMarks_Data1, _Data2 or _Data3 (adjusted by StepBGMapAddressBackOnScrollWrap)
; unless wArg1 is non-zero, and always to the matching byte of the window tile buffer at $C300
; (address from DrawRecordListPageMarks_Data4, _Data5 or _Data6). SRAM bank 0 is enabled during the
; scan and disabled at the end. (C1, E-0379)
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

; Four words that are offsets from the top left BG map entry of the visible screen: $0032, $0072,
; $00B2, $00F2, which are rows 1, 3, 5 and 7 of column 18. The BG map write (only when wArg1 is 0)
; uses this table when wArg2 is 0. DrawRecordListPageMarks writes the mark of list entry c (c = 0 to
; 3 of the page) at word c: the sex mark $CC plus the sex bit for an appraised egg (MON_EGG = 2),
; otherwise $CE. (C1, E-0381)
DrawRecordListPageMarks_Data1::
    db $32, $00, $72, $00, $b2, $00, $f2, $00

; Four words that are offsets from the top left BG map entry of the visible screen: $00B2, $00F2,
; $0132, $0172, which are rows 5, 7, 9 and 11 of column 18. The BG map write (only when wArg1 is 0)
; uses this table when wArg2 is 1. DrawRecordListPageMarks writes the mark of list entry c (c = 0 to
; 3 of the page) at word c: the sex mark $CC plus the sex bit for an appraised egg (MON_EGG = 2),
; otherwise $CE. (C1, E-0381)
DrawRecordListPageMarks_Data2::
    db $b2, $00, $f2, $00, $32, $01, $72, $01

; Four words that are offsets from the top left BG map entry of the visible screen: $002B, $006B,
; $00AB, $00EB, which are rows 1, 3, 5 and 7 of column 11. The BG map write (only when wArg1 is 0)
; uses this table when wArg2 is 2 or more. DrawRecordListPageMarks writes the mark of list entry c
; (c = 0 to 3 of the page) at word c: the sex mark $CC plus the sex bit for an appraised egg
; (MON_EGG = 2), otherwise $CE. (C1, E-0381)
DrawRecordListPageMarks_Data3::
    db $2b, $00, $6b, $00, $ab, $00, $eb, $00

; Four words, addresses in wWindowTileBuffer (rows of 20 bytes): $C38A, $C3B2, $C3DA, $C402, which
; are rows 6, 8, 10 and 12 of column 18. The mark of list entry c is always stored at word c when
; wArg2 is 0 (a store that does not depend on wArg1). (C1, E-0381)
DrawRecordListPageMarks_Data4::
    db $8a, $c3, $b2, $c3, $da, $c3, $02, $c4

; Four words, addresses in wWindowTileBuffer (rows of 20 bytes): $C3DA, $C402, $C42A, $C452, which
; are rows 10, 12, 14 and 16 of column 18. The mark of list entry c is always stored at word c when
; wArg2 is 1. (C1, E-0381)
DrawRecordListPageMarks_Data5::
    db $da, $c3, $02, $c4, $2a, $c4, $52, $c4

; Four words, addresses in wWindowTileBuffer (rows of 20 bytes): $C383, $C3AB, $C3D3, $C3FB, which
; are rows 6, 8, 10 and 12 of column 11. The mark of list entry c is always stored at word c when
; wArg2 is 2 or more. (C1, E-0381)
DrawRecordListPageMarks_Data6::
    db $83, $c3, $ab, $c3, $d3, $c3, $fb, $c3

; The view-records cursor: Up/Down move between the two choices (wrapping) and answer $FD; A plays
; sound $69, marks the choice and answers $FF; B erases the cursor and answers $FE; otherwise blinks
; the cursor and answers 0. (C1, E-0357)
SwapMonstersMenu_MonstersOrEggsCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_swap_monsters_menu_monsters_or_eggs2
    bit 7, a
    jr nz, .call_swap_monsters_menu_monsters_or_eggs3
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .call_swap_monsters_menu_monsters_or_eggs
    call SwapMonstersMenu_MonstersOrEggsCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_MarkMonstersOrEggs
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.call_swap_monsters_menu_monsters_or_eggs:
    call SwapMonstersMenu_MonstersOrEggsCursor_Hide
    ld a, $fe
    ld [wMenuInputResult], a
    ret

.call_swap_monsters_menu_monsters_or_eggs2:
    call SwapMonstersMenu_MonstersOrEggsCursor_Hide
    ld a, [wMenuChoice]
    and a
    jr nz, .skip
    ld a, $01
    jr .set_menu_choice2

.skip:
    dec a
    jr .set_menu_choice2

.call_swap_monsters_menu_monsters_or_eggs3:
    call SwapMonstersMenu_MonstersOrEggsCursor_Hide
    ld a, [wMenuChoice]
    cp $01
    jr c, .set_menu_choice
    xor a
    jr .set_menu_choice2

.set_menu_choice:
    inc a

.set_menu_choice2:
    ld [wMenuChoice], a
    call SwapMonstersMenu_MonstersOrEggsCursor_Show
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

; Blinks the Monsters / Eggs cursor of the swap menu: while wJoypadRepeatTimer is below $14 it just
; shows the cursor; from then on wListCursorBlink counts up on every call, values below $10 show the
; cursor tile and $10 to $17 hide it with the blank tile, and at $18 the counter restarts at 0 and
; the cursor is shown. Called by SwapMonstersMenu_MonstersOrEggsCursor when no button was pressed.
; (C1, E-0379)
; cycles wListCursorBlink through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (after the joypad repeat timer reaches $14) (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was SwapMonstersMenu_MonstersOrEggsCursor_Blink)
SwapMonstersMenu_MonstersOrEggsCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, SwapMonstersMenu_MonstersOrEggsCursor_Show
    ld a, [wListCursorBlink]
    inc a
    ld [wListCursorBlink], a
    cp $10
    jr c, SwapMonstersMenu_MonstersOrEggsCursor_Show
    cp $18
    jr c, SwapMonstersMenu_MonstersOrEggsCursor_Hide
    xor a
    ld [wListCursorBlink], a

; Loads B = $BB (the cursor tile) and jumps to SwapMonstersMenu_DrawMonstersOrEggsTile, which writes
; B at the place of the Monsters / Eggs choice wMenuChoice. Called by
; SwapMonstersMenu_MonstersOrEggsCursor after a move and reached by the blink routine before it.
; (C1, E-0379)
; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was SwapMonstersMenu_MonstersOrEggsCursor_Show)
SwapMonstersMenu_MonstersOrEggsCursor_Show::
    ld b, $bb
    jr SwapMonstersMenu_DrawMonstersOrEggsTile

; Loads B = $C3 (the blank tile) and jumps to SwapMonstersMenu_DrawMonstersOrEggsTile, which writes
; B at the place of the Monsters / Eggs choice wMenuChoice. Called by
; SwapMonstersMenu_MonstersOrEggsCursor before it moves the cursor and when B cancels, and reached
; by the blink routine before it. (C1, E-0379)
; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was SwapMonstersMenu_MonstersOrEggsCursor_Hide)
SwapMonstersMenu_MonstersOrEggsCursor_Hide::
    ld b, $c3
    jr SwapMonstersMenu_DrawMonstersOrEggsTile

; B = the chosen tile $BC, then falls into SwapMonstersMenu_DrawMonstersOrEggsTile: marks the
; confirmed choice when A is pressed on the Monsters / Eggs cursor
; (SwapMonstersMenu_MonstersOrEggsCursor). (C1, E-0370)
SwapMonstersMenu_MarkMonstersOrEggs::
    ld b, $bc

; Writes tile B at the place of choice wMenuChoice (0 Monsters, 1 Eggs) of the Monsters / Eggs
; cursor: the BG map offset from the 4-byte word table after it ($128, $168) is added to
; BGMapAddressAtScroll_Bank1D_2, wrapped by StepBGMapAddressBackOnScrollWrap and written with
; interrupts off after WaitForVRAMAccess. Shared by SwapMonstersMenu_MonstersOrEggsCursor_Show
; ($BB), SwapMonstersMenu_MonstersOrEggsCursor_Hide ($C3) and SwapMonstersMenu_MarkMonstersOrEggs
; ($BC). (C1, E-0370)
SwapMonstersMenu_DrawMonstersOrEggsTile::
    ld a, [wMenuChoice]
    add a
    ld hl, SwapMonstersMenu_DrawMonstersOrEggsTile_Data
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

; Two words that are offsets from the top left BG map entry of the visible screen: $0128 and $0168,
; which are rows 9 and 11 of column 8. SwapMonstersMenu_DrawMonstersOrEggsTile indexes them with
; wMenuChoice (0 or 1) and writes tile B at that entry, stepping back a row when the view has
; wrapped. (C1, E-0381)
SwapMonstersMenu_DrawMonstersOrEggsTile_Data::
    db $28, $01, $68, $01

; Answers the buttons for a one-column list of wListCount entries and sets wListPageIndex to 0
; first; it draws nothing, the caller redraws the cursor. Up (bit 6 of wJoypadPressedRepeat) moves
; wListCursor up and from row 0 wraps to wListCount - 1; Down (bit 7) moves it down and from the
; last row wraps to 0; either queues sound $69 and answers wMenuInputResult = $FD, except that a
; list of a single entry leaves wListCursor alone and answers $FD without a sound. With neither, B
; (bit 1 of wJoypadPressed) answers $FE with no sound, else A (bit 0) queues sound $69 and answers
; $FF, else the answer is 0. Far-called by SwapMonstersMenu_ShowParents2_Cursor and
; LinkRecordScreen_Cursor. (C2, E-0379)
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

; Cursor of a yes/no question with the choice in wTwoChoiceCursor (0 or 1). Up or Down (bits 6 and 7
; of wJoypadPressedRepeat) erase the old cursor, toggle wTwoChoiceCursor, restart the blink
; (wScreenCounter = 0), draw the cursor tile at the new place, queue sound $69 and answer
; wMenuInputResult = $FD. A (bit 0 of wJoypadPressed) draws the chosen tile, queues sound $69 and
; answers $FF; B (bit 1) answers $FE with no sound; with no input BlinkTwoChoiceCursor runs and the
; answer is 0. The tiles are written at BG map offsets $012F and $016F from the screen origin.
; Far-called by the yes/no questions of the arena, rename, key appraisal, medal prize, breed,
; hibernate, egg, priest and link menus. (C1, E-0379)
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

; Blinks the yes/no cursor: while wJoypadRepeatTimer is below $14 it draws the cursor; from then on
; wScreenCounter counts up on every call, values below $10 draw the cursor tile, $10 to $17 erase it
; with the blank tile, and at $18 the counter restarts at 0 and the cursor is drawn. Called by
; UpdateTwoChoiceCursor_Bank1D when no button was pressed. (C1, E-0379)
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

; Loads B = $BB (the cursor tile) and jumps to DrawTileAtTwoChoiceCursor, which writes B at the
; place of the choice wTwoChoiceCursor. Called when the cursor moves and by BlinkTwoChoiceCursor.
; (C1, E-0379)
; writes tile $BB at the position of wTwoChoiceCursor (DrawTileAtTwoChoiceCursor_Data offset from
; BGMapAddressAtScroll_Bank1D, StepBGMapAddressBackOnScrollWrap) (E-0068)
DrawTwoChoiceCursor::
    ld b, $bb
    jr DrawTileAtTwoChoiceCursor

; Loads B = $C3 (the blank tile) and jumps to DrawTileAtTwoChoiceCursor, which writes B at the place
; of the choice wTwoChoiceCursor. Called before the cursor moves and by BlinkTwoChoiceCursor. (C1,
; E-0379)
; writes tile $C3 at the position of wTwoChoiceCursor (E-0068)
EraseTwoChoiceCursor::
    ld b, $c3
    jr DrawTileAtTwoChoiceCursor

; Loads B = $BC (the tile of a confirmed choice) and falls into the routine below it (see
; DrawTileAtTwoChoiceCursor), which writes B at the place of the choice wTwoChoiceCursor. Called by
; UpdateTwoChoiceCursor_Bank1D when A is pressed. (C1, E-0379)
; writes tile $BC at the position of wTwoChoiceCursor (E-0068)
DrawTwoChoiceCursorConfirmed::
    ld b, $bc

; Writes tile B at yes/no place wTwoChoiceCursor (DrawTileAtTwoChoiceCursor_Data), allowing for the
; scroll wrap. (C1, E-0357)
DrawTileAtTwoChoiceCursor::
    ld a, [wTwoChoiceCursor]
    add a
    ld hl, DrawTileAtTwoChoiceCursor_Data
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

; Two words that are offsets from the top left BG map entry of the visible screen: $012F and $016F,
; which are rows 9 and 11 of column 15. DrawTileAtTwoChoiceCursor indexes them with wTwoChoiceCursor
; (0 or 1) and writes tile B at that entry. (C1, E-0381)
DrawTileAtTwoChoiceCursor_Data::
    db $2f, $01, $6f, $01

; Cursor of a one-column list of wListCount entries (up to four rows) with the row in wListCursor.
; Up or Down (bits 6 and 7 of wJoypadPressedRepeat) hide the old cursor, move wListCursor with
; wrap-around (from row 0 up to wListCount - 1, from the last row down to 0), clear wListCursorAux,
; show the cursor, queue sound $69 and answer wMenuInputResult = $FD. A (bit 0 of wJoypadPressed)
; queues sound $69, draws the chosen tile and answers $FF; B (bit 1) answers $FE with no sound; with
; no input UpdateListCursorListCursor_Blink runs and the answer is 0. Far-called by the swap menu
; party list and detail pages and PriestMenu_PayForService_PickService. (C1, E-0379)
; list cursor over wListCount entries: Up/Down move wListCursor with wrap, erase and redraw the
; cursor, play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor, plays sound
; $69 and sets $FF; B sets $FE; with no input the cursor blinks and the result is 0 (the codes of
; UpdatePagedListCursor) (E-0106)
UpdateListCursorListCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_update_list_cursor_list_cursor_hide
    bit 7, a
    jr nz, .call_update_list_cursor_list_cursor_hide2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call UpdateListCursorListCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.call_update_list_cursor_list_cursor_hide:
    call UpdateListCursorListCursor_Hide
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

.call_update_list_cursor_list_cursor_hide2:
    call UpdateListCursorListCursor_Hide
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
    call UpdateListCursorListCursor_Show
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call UpdateListCursorListCursor_Mark
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the list cursor at row wListCursor: while wJoypadRepeatTimer is below $14 the cursor tile
; $BB is drawn; from $14 on, wListCursorAux counts up each call, $00-$0F drawing $BB and $10-$17 the
; blank $C3, and restarts at 0 after $17. (C1, E-0370)
UpdateListCursorListCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdateListCursorListCursor_Show
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp $10
    jr c, UpdateListCursorListCursor_Show
    cp $18
    jr c, UpdateListCursorListCursor_Hide
    xor a
    ld [wListCursorAux], a

; B = the cursor tile ($BB), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_Show::
    ld b, $bb
    jr UpdateListCursorListCursor_DrawTile

; B = the blank tile ($C3), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_Hide::
    ld b, $c3
    jr UpdateListCursorListCursor_DrawTile

; B = the chosen-cursor tile ($BC), then the draw at row wListCursor. (C1, E-0357)
UpdateListCursorListCursor_Mark::
    ld b, $bc

; Writes tile B at list row wListCursor's place (UpdateListCursorListCursor_DrawTile_Data), allowing
; for the scroll wrap. (C1, E-0357)
UpdateListCursorListCursor_DrawTile::
    ld a, [wListCursor]
    add a
    ld hl, UpdateListCursorListCursor_DrawTile_Data
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

; Four words that are offsets from the top left BG map entry of the visible screen: $0021, $0061,
; $00A1, $00E1, which are rows 1, 3, 5 and 7 of column 1. UpdateListCursorListCursor_DrawTile
; indexes them with wListCursor and writes tile B at that entry. (C1, E-0381)
UpdateListCursorListCursor_DrawTile_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00

; Cursor of a paged list: wListCursor is the row (0 to wListLastRow) and wListPageIndex the page (0
; to wListPages - 1), both wrapping. Right and Left (bits 4 and 5 of wJoypadPressedRepeat) change
; the page, clear wListCursorAux, show the cursor, queue sound $69 and answer wMenuInputResult =
; $FB; Up and Down (bits 6 and 7) hide the old cursor, move the row, clear wListCursorAux, show the
; cursor, queue sound $69 and answer $FD. A (bit 0 of wJoypadPressed) queues sound $69, draws the
; chosen tile and answers $FF; B (bit 1) answers $FE with no sound. With no input, or when the move
; cannot happen because there is only one page or one row, UpdatePagedListCursor_Blink runs and the
; answer is 0. The caller stores the screen layout (0 to 5) in wMenuInputResult before the call; it
; picks the cursor positions in UpdatePagedListCursor_DrawTile_Data and is overwritten by the
; answer. (C1, E-0379)
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
    jp nz, .call_update_paged_list_cursor_draw_blank_tile
    bit 7, a
    jp nz, .call_update_paged_list_cursor_draw_blank_tile2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_update_paged_list_cursor_draw_chosen
    bit 1, a
    jp nz, .set_menu_input_result_to_FE
    call UpdatePagedListCursor_Blink
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
    call UpdatePagedListCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.clear_list_page_index:
    xor a

.set_list_page_index:
    ld [wListPageIndex], a
    xor a
    ld [wListCursorAux], a
    call UpdatePagedListCursor_DrawCursorTile
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
    call UpdatePagedListCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.skip:
    dec a
    jp .set_list_page_index

.skip2:
    dec a
    jp .set_list_page_index

.call_update_paged_list_cursor_draw_blank_tile:
    call UpdatePagedListCursor_DrawBlankTile
    ld a, [wListCursor]
    and a
    jr nz, .set_list_cursor2
    ld a, [wListLastRow]
    and a
    jr nz, .set_list_cursor
    call UpdatePagedListCursor_Blink
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

.call_update_paged_list_cursor_draw_blank_tile2:
    call UpdatePagedListCursor_DrawBlankTile
    ld a, [wListLastRow]
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .set_list_cursor3
    ld a, [wListLastRow]
    and a
    jr nz, .clear_list_cursor
    call UpdatePagedListCursor_Blink
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
    call UpdatePagedListCursor_DrawCursorTile
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_update_paged_list_cursor_draw_chosen:
    call UpdatePagedListCursor_DrawChosenTile
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
UpdatePagedListCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdatePagedListCursor_DrawCursorTile
    ld a, [wListCursorAux]
    inc a
    ld [wListCursorAux], a
    cp $10
    jr c, UpdatePagedListCursor_DrawCursorTile
    cp $18
    jr c, UpdatePagedListCursor_DrawBlankTile
    xor a
    ld [wListCursorAux], a

; B = the cursor tile ($BB), then the draw. (C1, E-0357)
UpdatePagedListCursor_DrawCursorTile::
    ld b, $bb
    jr UpdatePagedListCursor_DrawTile

; B = the blank tile ($C3), then the draw. (C1, E-0357)
UpdatePagedListCursor_DrawBlankTile::
    ld b, $c3
    jr UpdatePagedListCursor_DrawTile

; B = the chosen-cursor tile ($BC), then the draw. (C1, E-0357)
UpdatePagedListCursor_DrawChosenTile::
    ld b, $bc

; Writes tile B at row wListCursor of layout wMenuInputResult: the BG map offset is the word at 10 *
; layout + 2 * row of the 60-byte table after it (six layouts of five rows), added to
; BGMapAddressAtScroll_Bank1D_2 with the scroll wrap and written after WaitForVRAMAccess. The
; callers of UpdatePagedListCursor store the layout (0-5) in wMenuInputResult before the call, and
; every draw happens before UpdatePagedListCursor overwrites it with its answer. (C1, E-0370)
UpdatePagedListCursor_DrawTile::
    ld a, [wMenuInputResult]
    ld c, a
    add a
    add a
    add c
    add a
    ld hl, UpdatePagedListCursor_DrawTile_Data
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

; Six layouts of five words (60 bytes), all offsets from the top left BG map entry of the visible
; screen. Layout 0: rows 1, 3, 5, 7, 9 of column 1; layout 1: the same rows of column 8; layouts 2
; to 5: rows 5, 7, 9, 11, 13 of column 8, 6, 4 and 2. UpdatePagedListCursor_DrawTile picks the
; layout with wMenuInputResult (its callers store 0 to 5 there first) and the row with wListCursor,
; and writes tile B ($BB cursor, $C3 blank or $BC chosen) at that entry. (C1, E-0381)
UpdatePagedListCursor_DrawTile_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01, $28, $00, $68, $00, $a8, $00
    db $e8, $00, $28, $01, $a8, $00, $e8, $00, $28, $01, $68, $01, $a8, $01, $a6, $00
    db $e6, $00, $26, $01, $66, $01, $a6, $01, $a4, $00, $e4, $00, $24, $01, $64, $01
    db $a4, $01, $a2, $00, $e2, $00, $22, $01, $62, $01, $a2, $01

; Loads the sprite graphics of the three species in the family of one record: wArg1 (low byte) and
; wArg2 (high byte) point to the list cell holding the record number, which is used for all three.
; In SRAM bank 0 (disabled again at the end) the record MON_SPECIES, MON_PARENT1_SPECIES and
; MON_PARENT2_SPECIES words are read in that order, swapped to MON_PARENT2_SPECIES first when bit 4
; of its MON_FAMILY byte is set, and each one whose high byte is not $FF goes through
; LoadSpeciesSpriteGraphicsAndPalette with wArg3 = 0, 8 or $10 (object palette offset) and
; wArg4/wArg5 = VRAM $8000, $8100 or $8200 (LoadPedigreeSpeciesSpriteGraphics_Data1). Far-called by
; the pedigree pages (SwapMonstersMenu_ShowMonsterDetails_DrawPedigree,
; SwapMonstersMenu_ShowParents2_DrawFrame and LinkRecordScreen_DrawPedigreeFrame). (C1, E-0379)
; for the three records listed at wArg1 loads each species' sprite graphics and palette to the slots
; in LoadPedigreeSpeciesSpriteGraphics_Data1 (E-0128)
LoadPedigreeSpeciesSpriteGraphics::
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
    ld de, LoadPedigreeSpeciesSpriteGraphics_Data2
    jr .restore

.skip:
    ld de, LoadPedigreeSpeciesSpriteGraphics_Data3

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
    ld de, LoadPedigreeSpeciesSpriteGraphics_Data1
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

; Three 3-byte entries for pedigree slot c (0 to 2): $00 $00 $80, $08 $00 $81, $10 $00 $82.
; LoadPedigreeSpeciesSpriteGraphics copies entry c to wArg3, wArg4 and wArg5 for
; LoadSpeciesSpriteGraphicsAndPalette: wArg3 is the offset in wOBJPaletteBuffer (0, 8, $10) where
; the species 8-byte palette goes, and wArg5:wArg4 the VRAM address the sprite graphics are
; decompressed to ($8000, $8100, $8200). (C1, E-0381)
LoadPedigreeSpeciesSpriteGraphics_Data1::
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; Draws the three pedigree sprites of one record: wArg1 (low byte) and wArg2 (high byte) point to
; the list cell holding the record number, used for all three. In SRAM bank 0 (disabled again at the
; end) it reads MON_SPECIES, MON_PARENT1_SPECIES and MON_PARENT2_SPECIES in that order (parents
; swapped when bit 4 of MON_FAMILY is set) and for each word whose high byte is not $FF calls
; DrawSpeciesMetaSpriteAtScrollOffset with the position and tile offset from
; DrawPartySpeciesSprites_Data: X $10, Y $78 for the record itself, X $30, Y $68 and X $30, Y $88
; for the other two, tile offsets 0, $10 and $20 and attribute 0, 1 and 2. wArg1 and wArg2 are
; overwritten with the last species word drawn. Far-called by the pedigree pages and the link
; screens. (C1, E-0379)
; for the three records listed at wArg1 draws each species sprite at the positions in
; DrawPedigreeSpeciesSprites_Data (E-0128)
DrawPedigreeSpeciesSprites::
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
    ld de, LoadPedigreeSpeciesSpriteGraphics_Data2
    jr .restore

.skip:
    ld de, LoadPedigreeSpeciesSpriteGraphics_Data3

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
    ld hl, DrawPedigreeSpeciesSprites_Data
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

; Three 4-byte entries for pedigree slot c (0 to 2): $00 $10 $78 $00, $10 $30 $68 $01, $20 $30 $88
; $02. DrawPedigreeSpeciesSprites loads the bytes as H (tile offset $00, $10, $20), L (X offset $10,
; $30, $30), D (Y offset $78, $68, $88) and E (attribute XOR 0, 1, 2) and calls
; DrawSpeciesMetaSpriteAtScrollOffset for the species of that slot. (C1, E-0381)
DrawPedigreeSpeciesSprites_Data::
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; Loads the sprite graphics of the species whose id word is in hTemp0 (low) and hTemp1 (high): the
; 3-byte far pointer at MonsterSpriteTable + 3 * id (bank $04) is decompressed with DecompressToVRAM
; to the VRAM address wArg5:wArg4 (wArg4 is the low byte). On CGB it then copies the 8 palette bytes
; at $7328 + 8 * id in bank $27 into wOBJPaletteBuffer + wArg3, each written after waiting for VRAM
; access, and sets wOBJPaletteUploadRequest to $7F. On DMG it returns after the graphics. Called for
; each of up to three species by LoadPedigreeSpeciesSpriteGraphics. (C1, E-0379)
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
    add LOW(MonsterSpritePalettes)
    ld l, a
    ld a, h
    adc HIGH(MonsterSpritePalettes)
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

; Graphics number = word wArg1/wArg2: decompresses its picture (far pointer from MonsterSpriteTable
; in bank $04) to the VRAM address wArg4/wArg5; on CGB also copies its 8 palette bytes from bank $27
; ($7328 + 8 x number) into wOBJPaletteBuffer + wArg3 and requests an object palette upload. (C1,
; E-0357)
; graphics number = the word wArg1/wArg2: reads its far pointer (3 bytes per entry) from
; MonsterSpriteTable in bank $04 (ReadFarPointerAtDEInBankB) and DecompressToVRAM to the address in
; wArg4/wArg5; on CGB it continues with the palette (not read) (E-0104)
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
    add LOW(MonsterSpritePalettes)
    ld l, a
    ld a, h
    adc HIGH(MonsterSpritePalettes)
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

; Draws the meta-sprite of the species whose id word is in wArg1 (low) and wArg2 (high) at the
; screen position hScrollX + L, hScrollY + D (16-bit, with the carry into the high bytes), with tile
; offset H and attribute XOR E. The set index is wArg1 & $7F, drawn by DrawMetaSpriteSet_Bank27 when
; wArg2 is non-zero, else by DrawMetaSpriteSet_Bank26 when bit 7 of wArg1 is set, else by
; DrawMetaSpriteSet_Bank25. The incoming C is ignored (it is set to 0): hSpriteSubIndex is bit 4 of
; wFrameCounterLo, so the sprite changes between two frames every 16 frames. (C1, E-0379)
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

; Sets the sprite attribute bits from wArg6 and draws the meta-sprite (DrawMetaSpriteSetFromArgs).
; (C1, E-0357)
DrawThreeMetaSpritePartsAtGridCursor_SetAttrs::
    ld a, [wArg6]
    ldh [hSpriteAttrXor], a
    jr DrawMetaSpriteSetFromArgs

; Sets C = 0 and falls into the routine below it (see DrawSpritePart9000At88_28_SetAttrs, see
; DrawMetaSpriteSetFromArgs): hSpriteAttrXor = wArg6 and hSpriteSubIndex = bit 4 of wFrameCounterLo
; (two frames, changing every 16 frames), then the meta-sprite set numbered by the first argument
; byte & $7F (bank $27 when the second argument byte is non-zero, else bank $26 when bit 7 of the
; first is set, else bank $25) is drawn with tile offset wArg3 at the screen position hScrollX +
; wArg4, hScrollY + wArg5. Far-called by the pause menu, name entry, swap menu and record sprite
; screens. (C1, E-0379)
; C = 0, then falls into the sprite part draw (DrawThreeMetaSpritePartsAtGridCursor_SetAttrs body)
; (E-0122)
DrawMetaSpritePartC0::
    ld c, $00

; Sets the attribute bits from wArg6; with C = 0 the frame alternates every 16 frames
; (wFrameCounterLo bit 4), otherwise frame 0; then draws (DrawMetaSpriteSetFromArgs). (C1, E-0357)
DrawSpritePart9000At88_28_SetAttrs::
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
    jr DrawMetaSpriteSetFromArgs

.clear_sprite_sub_index:
    xor a
    ldh [hSpriteSubIndex], a

; Draws meta-sprite set wArg1 (bit 7 chooses bank $26 over $25; a non-zero wArg2 chooses bank $27)
; with tile offset wArg3 at screen position (wArg4, wArg5) plus the scroll. (C1, E-0357)
DrawMetaSpriteSetFromArgs::
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

; For each party member (wPartyList, wPartyCount of them) looks for its record number in the cells
; of page wListPageIndex of wListEntries (five cells per page, rows 0 to wListLastRow). When it is
; there, the tile $E1 + the party index (the digit 1, 2 or 3) is written beside that row: into the
; window tile buffer at $C300 with the offset from MarkPartyMembersInRecordListPage_Data1 when wArg1
; is 0, else into the BG map at BGMapAddressAtScroll_Bank1D_2 plus an offset from
; MarkPartyMembersInRecordListPage_Data2 (adjusted by StepBGMapAddressBackOnScrollWrap). The write
; waits for VRAM access. SRAM is enabled but not read, and disabled at the end. (C1, E-0379)
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

; Five little-endian words, $C378, $C3A0, $C3C8, $C3F0 and $C418: positions in the window tile
; buffer (wWindowTileBuffer, 20 tiles per row) of column 0 in rows 6, 8, 10, 12 and 14, two buffer
; rows apart. MarkPartyMembersInRecordListPage indexes it by the row c of the matching list cell
; within the page (word c) when wArg1 is 0, and writes the party digit tile ($E1 plus the party
; index) at that address. (C1, E-0381)
MarkPartyMembersInRecordListPage_Data1::
    db $78, $c3, $a0, $c3, $c8, $c3, $f0, $c3, $18, $c4

; Five little-endian words, $0020, $0060, $00A0, $00E0 and $0120: BG map offsets of 1, 3, 5, 7 and 9
; BG rows (32 tiles each) below the top-left screen tile. When wArg1 is not 0,
; MarkPartyMembersInRecordListPage indexes it by the row c of the matching list cell within the
; page, adds the word to the BGMapAddressAtScroll_Bank1D_2 result and writes the party digit tile
; there. (C1, E-0381)
MarkPartyMembersInRecordListPage_Data2::
    db $20, $00, $60, $00, $a0, $00, $e0, $00, $20, $01

; Swap menu, state 3 (far-called by SwapMonstersMenu_ListParty): sets the text window to vTiles1
; with rows $02 and width $12, then by the chosen option wGridCursorX: 0 (Drop off) lists the party
; (ListPartyRecordsWithState2ToListEntries), clears wListPageIndex and goes to state 4
; (SwapMonstersMenu_MoveRecords), at step $10 with wTwoChoiceCursor 0 when fewer than two are
; listed, else step 0 with wTwoChoiceCursor 1; 1 (Pick up) lists the farm records that are not eggs
; (ListRecordsState1NotEggs): none returns to state 1, step 3 with wTwoChoiceCursor and
; wScreenSubStep 0, otherwise state 5 (SwapMonstersMenu_ChooseFromFarm) at step $1E with
; wTwoChoiceCursor 1 when wPartyCount is 3 or more, else step 0 with wTwoChoiceCursor 2; 2 (Check)
; goes to state 6 and 3 (Release) to state 7 without listing anything. Every case starts the script
; (wScriptStartRequest = $80). (C2, E-0370; probed E-0384)
SwapMonstersMenu_ListParty_StartOption::
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

; Copies saved tiles back to the tile area, six per call. wArg3 (high byte) and wArg4 (low byte)
; point to a list of VRAM tile addresses that ends at an entry whose first byte is $FF; wArg1 (high)
; and wArg2 (low) give the base of the saved copies, 16 bytes per list entry. Starting at list entry
; wGlyphListStart it copies the 16 bytes at base + 16 * wGlyphListStart to the listed address with
; CopyTileBytesToVRAM_Bank1D and moves on, at most six entries per call (counted in wGlyphListPos),
; leaving wArg5 = 0. At the end of the list it resets wGlyphListStart and wGlyphListPos to 0 and
; sets wArg5 = $FF. HL is kept; DE ends as the list address. Far-called by the menu close and reload
; steps (CloseHibernateMenu_RestoreGlyphs, SwapMonstersMenu_Check_ReloadTiles,
; SwapMonstersMenu_Release_ReloadTiles and others), which wait for wArg5 = $FF. (C1, E-0379)
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

; Copies 16 bytes from [HL] to [DE], each byte stored after waiting for rSTAT bit 1 to clear with
; interrupts off; HL and DE end 16 bytes further on; clobbers A and C (C ends 0). One tile of 16
; bytes at a time for LoadTileListSixPerCall, CopyListedTilesSixPerFrame and UploadTilesFromData.
; Same bytes as the CopyTileBytesToVRAM_Bank1D copies in other banks. (C1, E-0379)
; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
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

; Starts saving the menu tiles into BG map 1: sets HL to CloseHibernateMenu_RestoreGlyphs_Data (a
; list of VRAM tile addresses), wArg1 and wArg2 to $9C and $00 (the base of the saved copies,
; vBGMap1), DE to vBGMap1 (not used afterwards) and wGlyphListPos to 0, then jumps to the shared
; copier (see CopyListedTilesSixPerFrame), which copies the 16 bytes of each listed tile to base +
; 16 * n, six per frame, and adds 1 to wScreenStep at the end of the list. The tiles are copied back
; later (see LoadTileListSixPerCall). Far-called by HibernateMenu_SetupPartyList_LoadTileMap and
; SwapMonstersMenu_SetupPartyList_SaveTiles. (C1, E-0379)
; HL = CloseHibernateMenu_RestoreGlyphs_Data, wArg1/2 = $9C/0, DE = vBGMap1, wGlyphListPos = 0, then
; continues at CopyListedTilesSixPerFrame (E-0126) (E-0344: the address in its name dropped or read
; as the label there; was SaveTilesToBGMap1TopHalf)
SaveTilesToBGMap1TopHalf::
    ld hl, CloseHibernateMenu_RestoreGlyphs_Data
    ld a, $9c
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, vBGMap1
    xor a
    ld [wGlyphListPos], a
    jr CopyListedTilesSixPerFrame

; Starts saving the menu tiles into the second half of BG map 1: sets HL to
; SaveTilesToBGMap1BottomHalf_Data (13 VRAM tile addresses), wArg1 and wArg2 to $9E and $00 (the
; base of the saved copies, vBGMap1 + $200), DE to vBGMap1 + $200 (not used afterwards) and
; wGlyphListPos to 0, then falls into the routine below it (see CopyListedTilesSixPerFrame), which
; copies the 16 bytes of each listed tile to base + 16 * n, six per frame, and adds 1 to wScreenStep
; at the end of the list. Far-called by SwapMonstersMenu_Check_SaveTiles and LinkEggList_LoadTiles;
; the tiles are copied back later (see LoadTileListSixPerCall). (C1, E-0379)
; copies tiles listed in SaveTilesToBGMap1BottomHalf_Data to vBGMap1 + $200 onward six per call; at
; the $FF end resets the counters and wScreenStep += 1 (E-0127) (E-0344: the address in its name
; dropped or read as the label there; was SaveTilesToBGMap1BottomHalf)
SaveTilesToBGMap1BottomHalf::
    ld hl, SaveTilesToBGMap1BottomHalf_Data
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, vBGMap1 + $200
    xor a
    ld [wGlyphListPos], a

; HL = list of VRAM tile addresses ending in $FF (the low byte is tested), wArg1/wArg2 = destination
; base (high, low): copies the 16-byte tile at list entry wGlyphListStart to base + 16 *
; wGlyphListStart (CopyTileBytesToVRAM_Bank1D), advancing wGlyphListStart, at most six per call
; (counted in wGlyphListPos); at the $FF end it clears both counters and increments wScreenStep.
; Entered by SaveTilesToBGMap1TopHalf (CloseHibernateMenu_RestoreGlyphs_Data to $9C00) and
; SaveTilesToBGMap1BottomHalf (SaveTilesToBGMap1BottomHalf_Data to $9E00); the DE they set is not
; used. (C1, E-0370)
CopyListedTilesSixPerFrame::
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
    jr c, CopyListedTilesSixPerFrame
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

; Copies five 16-byte tiles from UploadTilesFromData_Tiles with CopyTileBytesToVRAM_Bank1D: the
; first two to vTiles2 + $6E0 and vTiles2 + $6F0, the other three to vTiles2 + $7C0, $7D0 and $7E0.
; Far-called by the swap menu detail pages and the link record screen when they draw their pedigree
; frame. (C1, E-0379)
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

; C and wRecordCapacity = the byte at index wFarmLevel of the 3-byte table
; LoadRecordCapacityFromFarmLevelTable_Data (10, 20, 30); A holds the same value; clobbers DE. This
; is the number of records the following scans cover. A wFarmLevel above 2 would read the bytes
; after the table. (C2, E-0379)
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

; Three bytes, 10, 20 and 30: the number of records for farm levels 0, 1 and 2.
; LoadRecordCapacityFromFarmLevelTable indexes it by wFarmLevel and stores the byte in
; wRecordCapacity and register C; a wFarmLevel above 2 would read into the table that follows. (C1,
; E-0381)
LoadRecordCapacityFromFarmLevelTable_Data::
    db $0a, $14, $1e

; A list of 31 little-endian VRAM addresses of 16-byte tiles ($8A40 to $8AF0 in steps of $10, $8EE0,
; $8EF0, $8F00 to $8FF0 in steps of $10, then $8EB0), ended by $FFFF (only the first byte is
; tested). SaveTilesToBGMap1TopHalf has the shared copier save tile n to vBGMap1 + 16 * n, and
; CloseHibernateMenu_RestoreGlyphs copies them back with LoadTileListSixPerCall, six per call. (C1,
; E-0381)
CloseHibernateMenu_RestoreGlyphs_Data::
    db $40, $8a, $50, $8a, $60, $8a, $70, $8a, $80, $8a, $90, $8a, $a0, $8a, $b0, $8a
    db $c0, $8a, $d0, $8a, $e0, $8a, $f0, $8a, $e0, $8e, $f0, $8e, $00, $8f, $10, $8f
    db $20, $8f, $30, $8f, $40, $8f, $50, $8f, $60, $8f, $70, $8f, $80, $8f, $90, $8f
    db $a0, $8f, $b0, $8f, $c0, $8f, $d0, $8f, $e0, $8f, $f0, $8f, $b0, $8e, $ff, $ff

; A list of 13 little-endian VRAM addresses of 16-byte tiles ($8C00, $8C10, $8C20, $8C70 to $8CB0 in
; steps of $10, $8BF0, $8EA0, $8EB0, $8EC0, $8ED0), ended by $FFFF. SaveTilesToBGMap1BottomHalf has
; the shared copier save tile n to vBGMap1 + $200 + 16 * n; SwapMonstersMenu_Check_ReloadTiles,
; SwapMonstersMenu_Release_ReloadTiles and LinkEggList_ShowChooseTheKindOf copy them back with
; LoadTileListSixPerCall. (C1, E-0381)
SaveTilesToBGMap1BottomHalf_Data::
    db $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0, $8c, $b0, $8c
    db $f0, $8b, $a0, $8e, $b0, $8e, $c0, $8e, $d0, $8e, $ff, $ff

; Three record field offsets, $0B (MON_SPECIES), $1A (MON_PARENT1_SPECIES) and $1C
; (MON_PARENT2_SPECIES): the order in which LoadPedigreeSpeciesSpriteGraphics and
; DrawPedigreeSpeciesSprites read the three species words of a record when bit 4 of its MON_FAMILY
; byte is clear. The loop counter (0 to 2) is the index. (C1, E-0381)
LoadPedigreeSpeciesSpriteGraphics_Data2::
    db $0b, $1a, $1c

; The first three bytes are $0B (MON_SPECIES), $1C (MON_PARENT2_SPECIES) and $1A
; (MON_PARENT1_SPECIES): the same offsets as the Data2 table with the parents swapped, used by
; LoadPedigreeSpeciesSpriteGraphics and DrawPedigreeSpeciesSprites when bit 4 of MON_FAMILY is set.
; The 18 bytes after them (VRAM tile addresses $8C00, $8C10, $8C20, $8C70 to $8CB0, then $FFFF) are
; not reached by that index. (C1, E-0381)
LoadPedigreeSpeciesSpriteGraphics_Data3::
    db $0b, $1c, $1a, $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0
    db $8c, $b0, $8c, $ff, $ff

; wArg5 = the number of compact record slots in use: it counts the slots whose first byte has bit 7
; set (see PackRecordFieldsToBank1Slot, which sets it) among the 29 slots of $6F bytes from
; sCompactRecords in SRAM bank 0 and the slot at sRecords in SRAM bank 1. SRAM is disabled and rRAMB
; set back to 0 at the end. Called by PauseMenu_Plan_PlayerRecord_Build and the
; HibernateMenu_DoOption steps. (C2, E-0379; probed E-0384)
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

; Packs SRAM record wArg1 (sRecords + $A5 * wArg1) into the compact slot whose address is wArg3
; (low) and wArg4 (high) in SRAM bank wArg2. It clears the 7 bytes from wPackWork, then writes slot
; byte 0 = bit 7 set | MON_STATE & 3 in bits 6-5 | MON_FAMILY & $1F, byte 1 = the high nibble of the
; MON_SEX byte | bit 0 of MON_SEX in bit 3 | MON_EGG & 3 in bits 2-1 | bit 0 of the high byte of
; MON_SPECIES, and byte 2 = the low byte of MON_SPECIES (SRAM bank 0 for the record and wArg2 for
; the slot, switched with rRAMB). It then falls into PackRecordFieldsToBank1Slot_PackName, which
; packs the six names and then PackRecordFieldsToBank1Slot_PackOtherFields, which packs the rest;
; that last step ends with SRAM disabled, wPackWork = 0 and wArg5 = $FF. Far-called by the hibernate
; menu and PackNextSavedRecord. (C2, E-0379; probed E-0384)
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

; Packs name field wPackFieldIndex (0-5) of SRAM record wArg1 into the compact slot (address in
; wArg3/wArg4, SRAM bank wArg2): clears the five wPackFields bytes, then reads the field at record
; offset PackRecordFieldsToBank1Slot_PackName_Data[field] (MON_NAME, MON_MASTER_NAME,
; MON_PARENT1_MASTER, MON_PARENT2_MASTER, MON_PARENT1_NAME, MON_PARENT2_NAME) and writes each letter
; from slot offset 3 + 5 * field on, clearing its wPackFields entry; a mark byte $8D or $8E sets the
; previous letter's wPackFields entry to 1 or 2 instead; $F0 ends the field and is stored only when
; fewer than five letters were written. Otherwise reading stops once five letters and ten bytes have
; been taken. Then jumps to the field's mark step (PackRecordFieldsToBank1Slot_NameMarks,
; PackRecordFieldsToBank1Slot_MasterNameMarks, PackRecordFieldsToBank1Slot_Parent1MasterMarks,
; PackRecordFieldsToBank1Slot_Parent2MasterMarks, PackRecordFieldsToBank1Slot_Parent1NameMarks or
; PackRecordFieldsToBank1Slot_Parent2NameMarks for fields 0-5). Entered from
; PackRecordFieldsToBank1Slot (whose cleared wPackWork starts it at field 0) and from the mark steps
; of fields 0-4. (C2, E-0370; probed E-0384)
PackRecordFieldsToBank1Slot_PackName::
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
    ld hl, PackRecordFieldsToBank1Slot_PackName_Data
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
    jp z, PackRecordFieldsToBank1Slot_NameMarks
    cp $01
    jp z, PackRecordFieldsToBank1Slot_MasterNameMarks
    cp $02
    jp z, PackRecordFieldsToBank1Slot_Parent1MasterMarks
    cp $03
    jp z, PackRecordFieldsToBank1Slot_Parent2MasterMarks
    cp $04
    jp z, PackRecordFieldsToBank1Slot_Parent1NameMarks
    jp PackRecordFieldsToBank1Slot_Parent2NameMarks

; Six record field offsets, $01 (MON_NAME), $0F (MON_MASTER_NAME), $1E (MON_PARENT1_MASTER), $29
; (MON_PARENT2_MASTER), $8E (MON_PARENT1_NAME) and $99 (MON_PARENT2_NAME).
; PackRecordFieldsToBank1Slot_PackName indexes it by wPackFieldIndex (0 to 5) to find the name to
; pack. (C1, E-0381)
PackRecordFieldsToBank1Slot_PackName_Data::
    db $01, $0f, $1e, $29, $8e, $99

; Mark step of field 0 (MON_NAME): stores Pack2BitFieldsFromPackFields (the marks of letters 1-4) at
; slot offset $21 and the fifth letter's mark (wPackValue & 3) as bits 7-6 of offset $27,
; overwriting that byte (fields 1-3 OR theirs in below it); disables SRAM, increments
; wPackFieldIndex and goes back to PackRecordFieldsToBank1Slot_PackName. (C2, E-0370; probed E-0384)
PackRecordFieldsToBank1Slot_NameMarks::
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
    jp PackRecordFieldsToBank1Slot_PackName

; Mark step of field 1 (MON_MASTER_NAME), jumped to from PackRecordFieldsToBank1Slot_PackName when
; wPackFieldIndex is 1: with rRAMB = wArg2 stores Pack2BitFieldsFromPackFields (the marks of letters
; 1-4) at slot offset $22 (slot address wArg3/wArg4, through SRAMRecordAddressOfArg1) and ORs the
; fifth letter's mark (wPackValue & 3) into bits 5-4 of offset $27. Then disables SRAM (rRAMG2 = 0,
; rRAMB = 0), increments wPackFieldIndex and goes back to PackRecordFieldsToBank1Slot_PackName for
; field 2. (C2, E-0370; probed E-0384)
PackRecordFieldsToBank1Slot_MasterNameMarks::
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
    jp PackRecordFieldsToBank1Slot_PackName

; Field 2's marks: packs into slot offset $23 and bits 2-3 of offset $27; next field. (C2, E-0357;
; probed E-0384)
PackRecordFieldsToBank1Slot_Parent1MasterMarks::
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
    jp PackRecordFieldsToBank1Slot_PackName

; Field 3's marks: packs into slot offset $24 and bits 0-1 of offset $27; next field. (C2, E-0357;
; probed E-0384)
PackRecordFieldsToBank1Slot_Parent2MasterMarks::
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
    jp PackRecordFieldsToBank1Slot_PackName

; Field 4's marks: packs into slot offset $25 and the top two bits of offset $28; next field. (C2,
; E-0357; probed E-0384)
PackRecordFieldsToBank1Slot_Parent1NameMarks::
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
    jp PackRecordFieldsToBank1Slot_PackName

; Field 5's marks: packs into slot offset $26 and bits 4-5 of offset $28; then clears the field
; number and packs the two-bit values (PackRecordFieldsToBank1Slot_PackOtherFields). (C2, E-0357;
; probed E-0384)
PackRecordFieldsToBank1Slot_Parent2NameMarks::
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
    jp PackRecordFieldsToBank1Slot_PackOtherFields

; B = (wPackFields & 3) << 6 | (wPackFields + 1 & 3) << 4 | (wPackFields + 2 & 3) << 2 |
; (wPackFields + 3 & 3), and A = B: four 2-bit values from four bytes packed into one, the reverse
; of the unpacking (see UnpackByteAtHLTo2BitFieldsArg5). Used by
; PackRecordFieldsToBank1Slot_NameMarks and the other mark steps, and by
; PackRecordFieldsToBank1Slot_PackOtherFields. (C2, E-0379)
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

; Jumped to from field 5's mark step: packs the rest of SRAM record wArg1 into the compact slot
; (wArg3/wArg4, SRAM bank wArg2), switching rRAMB between 0 (record) and wArg2 (slot) per byte: the
; 27 two-bit MON_RESISTANCES into offsets $28 (bits 3-0, ORed in) to $2F (bits 7-6); bit 0 of the
; high bytes of MON_PARENT1_SPECIES and MON_PARENT2_SPECIES into bits 1 and 0 of $2F and their low
; bytes into $30 and $31; MON_MASTER_ID, MON_UNUSED_28 and MON_UNUSED_33 into $32-$34; the 34 bytes
; from MON_SKILLS into $35-$56; the eight words MON_HP to MON_INT as low bytes with a byte of their
; 2-bit high parts after each group of four ($57-$60); MON_WLD's low byte at $61 and its high bits
; as bit 7 of $62 and $63, which hold MON_LEVEL and MON_MAX_LEVEL in bits 6-0; MON_EXP at $64-$66;
; MON_PERSONALITY at $67-$6A; MON_PLUS, MON_PARENT1_PLUS, MON_PARENT2_PLUS and MON_ITEM at $6B-$6E.
; Ends with SRAM disabled, wPackFieldIndex and wPackWork 0 and wArg5 = $FF. (C2, E-0370; probed
; E-0384)
PackRecordFieldsToBank1Slot_PackOtherFields::
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

; Unpacks the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2 into SRAM record
; wArg1, the reverse of the packing (see PackRecordFieldsToBank1Slot). Slot byte 0 gives MON_STATE
; (bits 6-5) and MON_FAMILY (bits 4-0), byte 1 gives MON_SEX (high nibble kept, bit 3 moved to bit
; 0), MON_EGG (bits 2-1) and the high byte of MON_SPECIES (bit 0), and byte 2 the low byte of
; MON_SPECIES. It then builds the six names with LoadRecordNameEntry0 to LoadRecordNameEntry5 and
; copies each (CopyTenBytesThenSelectSRAMBank0, 10 bytes from wNameGlyphBuf) to MON_NAME,
; MON_MASTER_NAME, MON_PARENT1_MASTER, MON_PARENT2_MASTER, MON_PARENT1_NAME and MON_PARENT2_NAME,
; and jumps to UnpackRecordFromBank1Slot_UnpackOtherFields for the rest, which ends with SRAM
; disabled, wPackWork = 0 and wArg5 = $FF. Far-called by the hibernate menu and
; UnpackNextSavedRecord. (C2, E-0379; probed E-0384)
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
    jp UnpackRecordFromBank1Slot_UnpackOtherFields

; Copies 10 bytes from [HL] to [DE]; after each byte is read it selects SRAM bank 0 (rRAMB = 0), so
; the first read can come from the bank that was selected and every write goes to bank 0. HL and DE
; end 10 bytes further on; clobbers A and C. Called six times by UnpackRecordFromBank1Slot, once per
; name, with HL pointing at the name just built. (C2, E-0379)
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

; Jumped to from UnpackRecordFromBank1Slot after the six names: the reverse of
; PackRecordFieldsToBank1Slot_PackOtherFields, from the compact slot (wArg3/wArg4, SRAM bank wArg2)
; back into SRAM record wArg1: offsets $28-$2F to MON_RESISTANCES one value per byte; $30/$31 to the
; low bytes of MON_PARENT1_SPECIES/MON_PARENT2_SPECIES with bits 1/0 of $2F as their high bytes (a
; high bit of 1 with a low byte of $FF is restored as $FF, so a $FFFF word survives); $32-$34 to
; MON_MASTER_ID, MON_UNUSED_28 and MON_UNUSED_33; $35-$56 to the 34 bytes from MON_SKILLS; the eight
; words MON_HP to MON_INT (UnpackByteAtHLTo2BitFieldsArg5 gives their high bytes); then MON_WLD,
; MON_LEVEL, MON_MAX_LEVEL, MON_EXP, MON_PERSONALITY, MON_PLUS, MON_PARENT1_PLUS, MON_PARENT2_PLUS
; and MON_ITEM. Ends with SRAM disabled, wPackWork 0 and wArg5 = $FF. (C2, E-0370; probed E-0384)
UnpackRecordFromBank1Slot_UnpackOtherFields::
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

; Reads name entry 0 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $21 into the four 2-bit mark fields wArg5 to wArg8 (marks of letters 1-4), puts the mark
; of letter 5 (bits 7-6 of slot byte $27) in wMenuInputResult, and builds the name from the 5
; letters at slot offset 3 in wNameGlyphBuf (BuildFiveGlyphNameWithMarksToNameGlyphBuf). Entry 0 is
; the MON_NAME of the record. SRAM stays enabled with rRAMB = wArg2. Far-called by the hibernate
; menu and the save file info window, and by UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Reads name entry 1 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $22 into wArg5 to wArg8, puts the mark of letter 5 (bits 5-4 of slot byte $27) in
; wMenuInputResult, and builds the name from the 5 letters at slot offset 8 in wNameGlyphBuf. Entry
; 1 is the MON_MASTER_NAME of the record. SRAM stays enabled with rRAMB = wArg2. Called by
; UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Reads name entry 2 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $23 into wArg5 to wArg8, puts the mark of letter 5 (bits 3-2 of slot byte $27) in
; wMenuInputResult, and builds the name from the 5 letters at slot offset $0D in wNameGlyphBuf.
; Entry 2 is the MON_PARENT1_MASTER of the record. SRAM stays enabled with rRAMB = wArg2. Called by
; UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Reads name entry 3 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $24 into wArg5 to wArg8, puts the mark of letter 5 (bits 1-0 of slot byte $27) in
; wMenuInputResult, and builds the name from the 5 letters at slot offset $12 in wNameGlyphBuf.
; Entry 3 is the MON_PARENT2_MASTER of the record. SRAM stays enabled with rRAMB = wArg2. Called by
; UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Reads name entry 4 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $25 into wArg5 to wArg8, puts the mark of letter 5 (bits 7-6 of slot byte $28) in
; wMenuInputResult, and builds the name from the 5 letters at slot offset $17 in wNameGlyphBuf.
; Entry 4 is the MON_PARENT1_NAME of the record. SRAM stays enabled with rRAMB = wArg2. Called by
; UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Reads name entry 5 of the compact slot at wArg3 (low) and wArg4 (high) in SRAM bank wArg2: unpacks
; slot byte $26 into wArg5 to wArg8, puts the mark of letter 5 (bits 5-4 of slot byte $28) in
; wMenuInputResult, and builds the name from the 5 letters at slot offset $1C in wNameGlyphBuf.
; Entry 5 is the MON_PARENT2_NAME of the record. SRAM stays enabled with rRAMB = wArg2. Called by
; UnpackRecordFromBank1Slot. (C2, E-0379; probed E-0384)
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

; Builds a name in wNameGlyphBuf from up to five letters at HL: the first 11 bytes of the buffer are
; filled with $F0, then each letter is copied and followed by the mark $8D when the mark field of
; that letter is 1 or $8E when it is 2 (fields wArg5 to wArg8 for letters 1-4 and the byte after
; wArg8 for letter 5; any other value adds no mark). A $F0 in the letters ends the name early; after
; five letters (with their marks) a $F0 is stored. Called by LoadRecordNameEntry0 to
; LoadRecordNameEntry5. (C2, E-0379)
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

; Selects SRAM bank wArg2 (rRAMB) and splits the byte at HL into four 2-bit fields: wArg5 = bits
; 7-6, wArg6 = bits 5-4, wArg7 = bits 3-2, wArg8 = bits 1-0. A ends as wArg8. Called by
; LoadRecordNameEntry0 to LoadRecordNameEntry5 and UnpackRecordFromBank1Slot_UnpackOtherFields. (C2,
; E-0379)
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

; Writes $0A to rRAMG2 (cartridge RAM on) and selects SRAM bank 0 (rRAMB = 0); A ends 0. Same bytes
; as the other EnableSRAMBank0 copies; used by the pack and unpack routines of this bank to switch
; back to the record bank. (C2, E-0379; probed E-0384)
; writes $0A to the RAM-enable register (rRAMG2 alias) and selects SRAM bank 0 (rRAMB = 0); clobbers
; A (E-0066)
EnableSRAMBank0::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ret

; HL = the 16-bit pointer wArg4:wArg3 (wArg3 is the low byte), DE = sRecords + $A5 * wArg1, the
; start of SRAM record wArg1 (Multiply8 gives HL = $A5 * wArg1); clobbers A and BC. The pack and
; unpack routines get the compact slot address in HL and the full record address in DE from it. (C2,
; E-0379)
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
