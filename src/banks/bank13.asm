SECTION "Bank 13", ROMX[$4000], BANK[$13]
    db $13

; starts a message through script command $09 (message word HL, shown by the same group dispatch as ShowMessageHL when wD7F0 = 0): HL is stored in wScriptParam0 (low) and wScriptParam1 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 783 call sites from 406 routines (e.g. Talk0D90_HumphImTerry, Talk0B6D_BreedingFireAndIce, Talk0B56_WhenYouBreedMonsters, DispatchTalkEvent_Case01_CaseEE, ...)
; writes: wScriptParam0, wScriptParam1, wScriptStartRequest, wModeState, wScriptCommandType, wScriptRunning, wScriptStep
StartMessageCommand09HL_B13::
Func_013_4001:: ; address name
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
    xor a, a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; starts a message through script command $0A: DE is stored in wMessageIndex (low) and wMessageGroup (high); then wC5DC = 1, wC920 = $0A, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 is overwritten)
; 36 call sites from 36 routines (e.g. Msg013F_TheCircusMasterWas, Msg013E_OurKingHasBeen, Msg013D_StrongMonstersAreIn, Msg013C_ISawALake, ...)
; writes: wMessageIndex, wMessageGroup, wScriptStartRequest, wModeState, wScriptCommandType, wScriptRunning, wScriptStep
StartMessageScriptDE_B13::
Func_013_4025:: ; address name
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $0A
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a, a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; HL is stored in wScriptPointerLo/Hi; then wScriptStartRequest = $80 and wModeState = 1, so the script engine starts fetching at HL (E-0082)
; 252 call sites from 135 routines (e.g. DispatchTalkEvent_Case08, IfFlag0021StartScript5988, Talk0D90_HumphImTerry, Talk0B6D_BreedingFireAndIce, ...)
; writes: wScriptPointerLo, wScriptPointerHi, wScriptStartRequest, wModeState
StartScriptAtHL_B13::
Func_013_4049:: ; address name
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ret

; unless wCC44 says otherwise (several special values), starts an event: when wC916 is not $FD it runs script command $09 with a parameter from wCDAE; otherwise (and for the other paths) it jumps through an 11-entry table by wC917 (the handler group: cases far-call bank-$04 dispatchers or, for group 4, dispatch on wC916 through a 257-entry table of talk handlers such as TalkMsg0DD7_OurHeartsAreLike). Group/entry meaning beyond talk handlers is not read (E-0097)
; 39 call sites from 26 routines (e.g. RunFieldReturnPhase_Case02, RunFieldReturnPhase_Case01, FieldModeStateDispatch_Shared01_Sub02, FieldModeStateDispatch_Shared01_Sub03, ...)
; reads: wMapType, wTalkEventIndex, wKeyWorldFloor, wTalkEventGroup
; writes: wScriptStartRequest, wModeState, wTalkEventIndex, wTalkEventGroup, wScriptParam0, wScriptParam1, wScriptCommandType, wScriptRunning, ...
DispatchTalkEvent::
Func_013_405C:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp z, Jump_013_40E9
    ld a, [wTalkEventIndex]
    cp a, $09
    jp z, Jump_013_40E9
    ld a, [wMapType]
    cp a, $80
    jp z, Jump_013_40E9
    cp a, $82
    jp z, Jump_013_40E9
    cp a, $84
    jp z, Jump_013_40E9
    cp a, $85
    jp z, Jump_013_40E9
    cp a, $86
    jp z, Jump_013_40E9
    cp a, $83
    jr nz, Jump_013_409E
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr z, Jump_013_40E9

Jump_013_409E::
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $2
    add_a_to_hl
    ld a, [wTalkEventGroup]
    cp a, $FD
    jr nz, Jump_013_40C8
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $01
    ld [wTalkEventGroup], a
    jr Jump_013_40E9

Jump_013_40C8::
    push af
    pop af
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptParam1], a
    ld a, $09
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a, a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

Jump_013_40E9::
    ld a, [wTalkEventIndex]
    rst $00
    dw DispatchTalkEvent_Case00
    dw DispatchTalkEvent_Case01
    dw DispatchTalkEvent_Case02
    dw DispatchTalkEvent_Case03
    dw DispatchTalkEvent_Case04
    dw DispatchTalkEvent_Case05
    dw DispatchTalkEvent_Case06
    dw DispatchTalkEvent_Case07
    dw DispatchTalkEvent_Case08
    dw DispatchTalkEvent_Case09
    dw DispatchTalkEvent_Case0A

; entry 0 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case00::
Jump_013_4103:: ; address name
    farcall DispatchTalkEvent_Case00_Sub01
    ret

; entry 10 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case0A::
Jump_013_410A:: ; address name
    farcall DispatchTalkEvent_Case0A_Sub01
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07::
Jump_013_4111:: ; address name
    farcall DispatchTalkEvent_Case07_Sub01
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case09::
Jump_013_4118:: ; address name
    farcall DispatchTalkEvent_Case09_Sub01
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case06::
Jump_013_411F:: ; address name
    farcall DispatchTalkEvent_Case06_Sub01
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case02::
Jump_013_4126:: ; address name
    farcall DispatchTalkEvent_Case02_Sub01
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case03::
Jump_013_412D:: ; address name
    farcall DispatchTalkEvent_Case03_Sub01
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wTalkEventGroup
DispatchTalkEvent_Case05::
Jump_013_4134:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case05_Case00
    dw DispatchTalkEvent_Case05_Case01
    dw DispatchTalkEvent_Case05_Case02
    dw DispatchTalkEvent_Case05_Case03
    dw DispatchTalkEvent_Case05_Case04
    dw DispatchTalkEvent_Case05_Case05
    dw DispatchTalkEvent_Case05_Case06
    dw DispatchTalkEvent_Case05_Case07
    dw DispatchTalkEvent_Case05_Case08
    dw DispatchTalkEvent_Case05_Case09
    dw DispatchTalkEvent_Case05_Case0A
    dw DispatchTalkEvent_Case05_Case0B
    dw DispatchTalkEvent_Case05_Case0C
    dw DispatchTalkEvent_Case05_Case0D
    dw DispatchTalkEvent_Case05_Case0E
    dw DispatchTalkEvent_Case05_Case0F
    dw DispatchTalkEvent_Case05_Case10
    dw DispatchTalkEvent_Case05_Case11
    dw DispatchTalkEvent_Case05_Case12
    dw DispatchTalkEvent_Case05_Case13
    dw DispatchTalkEvent_Case05_Case14
    dw DispatchTalkEvent_Case05_Case15
    dw DispatchTalkEvent_Case05_Case16
    dw DispatchTalkEvent_Case05_Case17
    dw DispatchTalkEvent_Case05_Case18
    dw DispatchTalkEvent_Case05_Case19
    dw DispatchTalkEvent_Case05_Case1A
    dw DispatchTalkEvent_Case05_Case1B
    dw DispatchTalkEvent_Case05_Case1C
    dw DispatchTalkEvent_Case05_Case1D
    dw DispatchTalkEvent_Case05_Case1E
    dw DispatchTalkEvent_Case05_Case1F
    dw DispatchTalkEvent_Case05_Case20
    dw DispatchTalkEvent_Case05_Case21
    dw DispatchTalkEvent_Case05_Case22
    dw DispatchTalkEvent_Case05_Case23
    dw DispatchTalkEvent_Case05_Case24
    dw DispatchTalkEvent_Case05_Case25
    dw DispatchTalkEvent_Case05_Case26
    dw DispatchTalkEvent_Case05_Case27
    dw DispatchTalkEvent_Case05_Case28
    dw DispatchTalkEvent_Case05_Case29
    dw DispatchTalkEvent_Case05_Case2A
    dw DispatchTalkEvent_Case05_Case2B
    dw DispatchTalkEvent_Case05_Case2C
    dw DispatchTalkEvent_Case05_Case2D
    dw DispatchTalkEvent_Case05_Case2E
    dw DispatchTalkEvent_Case05_Case2F
    dw DispatchTalkEvent_Case05_Case30
    dw DispatchTalkEvent_Case05_Case31
    dw DispatchTalkEvent_Case05_Case32
    dw DispatchTalkEvent_Case05_Case33
    dw DispatchTalkEvent_Case05_Case34
    dw DispatchTalkEvent_Case05_Case35
    dw DispatchTalkEvent_Case05_Case36
    dw DispatchTalkEvent_Case05_Case37
    dw DispatchTalkEvent_Case05_Case38
    dw DispatchTalkEvent_Case05_Case39
    dw DispatchTalkEvent_Case05_Case3A
    dw DispatchTalkEvent_Case05_Case3B
    dw DispatchTalkEvent_Case05_Case3C
    dw DispatchTalkEvent_Case05_Case3D
    dw DispatchTalkEvent_Case05_Case3E
    dw DispatchTalkEvent_Case05_Case3F
    dw DispatchTalkEvent_Case05_Case40
    dw DispatchTalkEvent_Case05_Case41
    dw DispatchTalkEvent_Case05_Case42
    dw DispatchTalkEvent_Case05_Case43
    dw DispatchTalkEvent_Case05_Case44
    dw DispatchTalkEvent_Case05_Case45
    dw DispatchTalkEvent_Case05_Case46
    dw DispatchTalkEvent_Case05_Case47
    dw DispatchTalkEvent_Case05_Case48
    dw DispatchTalkEvent_Case05_Case49
    dw DispatchTalkEvent_Case05_Case4A
    dw DispatchTalkEvent_Case05_Case4B
    dw DispatchTalkEvent_Case05_Case4C
    dw DispatchTalkEvent_Case05_Case4D
    dw DispatchTalkEvent_Case05_Case4E
    dw DispatchTalkEvent_Case05_Case4F
    dw DispatchTalkEvent_Case05_Case50
    dw DispatchTalkEvent_Case05_Case51
    dw DispatchTalkEvent_Case05_Case52
    dw DispatchTalkEvent_Case05_Case53
    dw DispatchTalkEvent_Case05_Case54
    dw DispatchTalkEvent_Case05_Case55
    dw DispatchTalkEvent_Case05_Case56
    dw DispatchTalkEvent_Case05_Case57
    dw DispatchTalkEvent_Case05_Case58
    dw DispatchTalkEvent_Case05_Case59
    dw DispatchTalkEvent_Case05_Case5A
    dw DispatchTalkEvent_Case05_Case5B
    dw DispatchTalkEvent_Case05_Case5C
    dw DispatchTalkEvent_Case05_Case5D
    dw DispatchTalkEvent_Case05_Case5E
    dw DispatchTalkEvent_Case05_Case5F
    dw DispatchTalkEvent_Case05_Case60
    dw DispatchTalkEvent_Case05_Case61
    dw DispatchTalkEvent_Case05_Case62
    dw DispatchTalkEvent_Case05_Case63
    dw DispatchTalkEvent_Case05_Case64
    dw DispatchTalkEvent_Case05_Case65
    dw DispatchTalkEvent_Case05_Case66
    dw DispatchTalkEvent_Case05_Case67
    dw DispatchTalkEvent_Case05_Case68
    dw DispatchTalkEvent_Case05_Case69
    dw DispatchTalkEvent_Case05_Case6A
    dw DispatchTalkEvent_Case05_Case6B
    dw DispatchTalkEvent_Case05_Case6C
    dw DispatchTalkEvent_Case05_Case6D
    dw DispatchTalkEvent_Case05_Case6E
    dw DispatchTalkEvent_Case05_Case6F
    dw DispatchTalkEvent_Case05_Case70
    dw $0000 ; unused index (E-0207)
    dw ToggleMapBetween7FAnd92

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case00::
Jump_013_421E:: ; address name
    ld hl, $0400 ; 'This is the village of Fhunt.'
    call StartMessageCommand09HL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case01::
Jump_013_4225:: ; address name
    ld hl, $0401 ; 'The Great Sage Ugor saved the'
    call StartMessageCommand09HL_B13
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case02::
Jump_013_422C:: ; address name
    ld hl, $0402 ; 'You e come all this way,'
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case03::
Jump_013_4233:: ; address name
    ld hl, $0403 ; 'The Great Sage, after saving the'
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case04::
Jump_013_423A:: ; address name
    ld hl, $0404 ; 'You're not about to go after'
    call StartMessageCommand09HL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case05::
Jump_013_4241:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4250
    ld hl, $0405 ; 'Some time ago, lightning struck the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4250::
    ld hl, $0492 ; 'Some time ago, lightning struck the'
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case06::
Jump_013_4257:: ; address name
    ld hl, $0407 ; 'A suspension bridge is in the'
    call StartMessageCommand09HL_B13
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case07::
Jump_013_425E:: ; address name
    ld hl, $0406 ; 'Nobody can defy the Orb's bearer.'
    call StartMessageCommand09HL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case08::
Jump_013_4265:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_4274
    ld hl, $0408 ; 'A huge bird perches atop the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4274::
    ld hl, $0D2C ; 'That giant bird hasn't flown over'
    call StartMessageCommand09HL_B13
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case09::
Jump_013_427B:: ; address name
    ld hl, $0409 ; 'The tower's gate is tightly sealed.'
    call StartMessageCommand09HL_B13
    ret

; entry 10 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case0A::
Jump_013_4282:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_42A0
    ld de, $00A4
    call TestFlagBit
    jr c, Jump_013_4299
    ld hl, $040A ; 'The top of the tower collapsed'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4299::
    ld hl, $0414 ; 'What? What? What happened? I saw'
    call StartMessageCommand09HL_B13
    ret

Jump_013_42A0::
    ld hl, $0D2D ; 'Was that bird going after the'
    call StartMessageCommand09HL_B13
    ret

; entry 11 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5FE8: 'How may we serve your mortal'
DispatchTalkEvent_Case05_Case0B::
Jump_013_42A7:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5FE8
    call StartScriptAtHL_B13
    ret

; entry 12 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case0C::
Jump_013_42B3:: ; address name
    ld hl, $040E ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

; entry 13 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_5FEF: '0 checked the grave. There was'
DispatchTalkEvent_Case05_Case0D::
Jump_013_42BA:: ; address name
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_013_42C9
    ld hl, Script_5FEF
    call StartScriptAtHL_B13
    ret

Jump_013_42C9::
    ld hl, Script_5FF7
    call StartScriptAtHL_B13
    ret

; entry 14 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_6003: 'Welcome to our inn!'
DispatchTalkEvent_Case05_Case0E::
Jump_013_42D0:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_6003
    call StartScriptAtHL_B13
    ret

; entry 15 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTileBuffer, hTemp0
DispatchTalkEvent_Case05_Case0F::
Jump_013_42DC:: ; address name
    ld a, [wScreenTileBuffer + $D2]
    cp a, $68
    ret z
    farcall DispatchTalkEvent_Case05_Case0F_Sub01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_42F4
    ld hl, $0410 ; 'Be gone! If your soul can't'
    call StartMessageCommand09HL_B13
    ret

Jump_013_42F4::
    ld hl, Script_5FFC
    call StartScriptAtHL_B13
    ret

; entry 16 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case10::
Jump_013_42FB:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $00A1
    call StartMessageScriptDE_B13
    ret

; entry 17 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case11::
Jump_013_430C:: ; address name
    ld hl, $0413 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

; entry 18 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case12::
Jump_013_4313:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $00A2
    call StartMessageScriptDE_B13
    ret

; entry 19 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case13::
Jump_013_4324:: ; address name
    ld a, $03
    ld [wScriptParam0], a
    ld a, $00
    ld [wScriptParam1], a
    ld de, $00A3
    call StartMessageScriptDE_B13
    ret

; entry 20 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_600A: 'Kweeeeh!'
DispatchTalkEvent_Case05_Case14::
Jump_013_4335:: ; address name
    ld hl, Script_600A
    call StartScriptAtHL_B13
    ret

; entry 21 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case05_Case15::
Jump_013_433C:: ; address name
    ld de, $00A6
    call TestFlagBit
    ret nc
    ld de, $00A7
    call TestFlagBit
    jr c, Jump_013_436E
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, Jump_013_4367
    ld [hl], $35
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $041A ; '0 checked behind the grave. The'
    call StartMessageCommand09HL_B13
    ld de, $00A7
    call SetFlagBit
    ret

Jump_013_4367::
    ld hl, $041B ; '0 checked behind the grave. The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_436E::
    ld hl, $04A2 ; '0 checked behind the grave. There'
    call StartMessageCommand09HL_B13
    ret

; entry 22 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerSpriteOverride, wSpriteSlots
DispatchTalkEvent_Case05_Case16::
Jump_013_4375:: ; address name
    ld de, $0209
    call TestFlagBit
    jr c, Jump_013_43A9
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_013_4387
    and a, $01
    jr z, Jump_013_438E

Jump_013_4387::
    ld hl, $041C ; 'Hm? You're a stranger! You make'
    call StartMessageCommand09HL_B13
    ret

Jump_013_438E::
    ld a, [wSpriteSlots + $B]
    cp a, $50
    jr z, Jump_013_43A2
    ld hl, Script_6015
    call StartScriptAtHL_B13
    ld de, $0209
    call SetFlagBit
    ret

Jump_013_43A2::
    ld hl, $041D ; 'Hm? You're from the village! Hurry'
    call StartMessageCommand09HL_B13
    ret

Jump_013_43A9::
    ld hl, $0DF8 ; 'ZZZZZ Ssss ZZZZZ Ssss'
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case17::
Jump_013_43B0:: ; address name
    ld hl, $041E ; 'This is the town of Pei.'
    call StartMessageCommand09HL_B13
    ret

; entry 24 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case18::
Jump_013_43B7:: ; address name
    ld hl, $041F ; 'Nya? Travelers? That's rare!'
    call StartMessageCommand09HL_B13
    ret

; entry 25 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case19::
Jump_013_43BE:: ; address name
    ld hl, $0420 ; 'To the west is a mountain.'
    call StartMessageCommand09HL_B13
    ret

; entry 26 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1A::
Jump_013_43C5:: ; address name
    ld hl, $0421 ; 'You should stay well clear of'
    call StartMessageCommand09HL_B13
    ret

; entry 27 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1B::
Jump_013_43CC:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43DB
    ld hl, $0422 ; 'I came close to being abducted'
    call StartMessageCommand09HL_B13
    ret

Jump_013_43DB::
    ld hl, $0D2E ; 'They say the giant bird has'
    call StartMessageCommand09HL_B13
    ret

; entry 28 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1C::
Jump_013_43E2:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43F1
    ld hl, $0423 ; 'Some time ago, a human child'
    call StartMessageCommand09HL_B13
    ret

Jump_013_43F1::
    ld hl, $0D2F ; 'The giant bird took off with'
    call StartMessageCommand09HL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1D::
Jump_013_43F8:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4407
    ld hl, $0424 ; 'There wasn't a monster king for'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4407::
    ld hl, $0494 ; 'I heard on my travels that'
    call StartMessageCommand09HL_B13
    ret

; entry 30 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1E::
Jump_013_440E:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_441D
    ld hl, $0425 ; 'The new monster king makes others'
    call StartMessageCommand09HL_B13
    ret

Jump_013_441D::
    ld hl, $0495 ; 'The monster King disappeared. He made'
    call StartMessageCommand09HL_B13
    ret

; entry 31 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerSpriteOverride
DispatchTalkEvent_Case05_Case1F::
Jump_013_4424:: ; address name
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_013_442E
    and a, $01
    jr z, Jump_013_4435

Jump_013_442E::
    ld hl, Script_6020
    call StartScriptAtHL_B13
    ret

Jump_013_4435::
    ld hl, Script_602D
    call StartScriptAtHL_B13
    ret

; entry 32 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case20::
Jump_013_443C:: ; address name
    ld hl, $042A ; 'This is just a rumor, but'
    call StartMessageCommand09HL_B13
    ret

; entry 33 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case21::
Jump_013_4443:: ; address name
    ld hl, $042B ; 'The tunnel in the west will'
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case22::
Jump_013_444A:: ; address name
    ld hl, $042C ; 'Are you looking for something? Huh?'
    call StartMessageCommand09HL_B13
    ret

; entry 35 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_603A: 'How may we serve your mortal'
DispatchTalkEvent_Case05_Case23::
Jump_013_4451:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_603A
    call StartScriptAtHL_B13
    ret

; entry 36 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case05_Case24::
Jump_013_445D:: ; address name
    ld a, $0D
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_6041
    call StartScriptAtHL_B13
    ret

; entry 37 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case25::
Jump_013_446E:: ; address name
    ld hl, $0430 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case26::
Jump_013_4475:: ; address name
    ld hl, $04AA ; '0 read the sign. Determine where'
    call StartMessageCommand09HL_B13
    ret

; entry 39 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case27::
Jump_013_447C:: ; address name
    ld hl, $0DD3 ; 'Inn downstairs. Rooms available.'
    call StartMessageCommand09HL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_6048: 'Welcome to the traveler's inn.'
DispatchTalkEvent_Case05_Case28::
Jump_013_4483:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_6048
    call StartScriptAtHL_B13
    ret

; entry 41 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
DispatchTalkEvent_Case05_Case29::
Jump_013_448F:: ; address name
    ld de, $00A4
    call TestFlagBit
    ret nc
    farcall DispatchTalkEvent_Case05_Case29_Sub01
    ldh a, [hTemp0]
    or a, a
    ret z
    ld hl, Script_604F
    call StartScriptAtHL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2A::
Jump_013_44A7:: ; address name
    ld de, $00A9
    call TestFlagBit
    jr c, Jump_013_44BC
    ld hl, $0434 ; 'When I passed too close to'
    call StartMessageCommand09HL_B13
    ld de, $00A9
    call SetFlagBit
    ret

Jump_013_44BC::
    ld hl, $0435 ; 'I I didn't take anything! There'
    call StartMessageCommand09HL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2B::
Jump_013_44C3:: ; address name
    ld hl, $0436 ; '0 opened the treasure chest. But'
    call StartMessageCommand09HL_B13
    ret

; entry 44 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case2C::
Jump_013_44CA:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00AA
    call StartMessageScriptDE_B13
    ret

; entry 45 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2D::
Jump_013_44DB:: ; address name
    ld hl, $0437 ; 'This is the Castle of Hitano.'
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2E::
Jump_013_44E2:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_44F1
    ld hl, $0438 ; 'A monster king has appeared to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_44F1::
    ld hl, $0496 ; 'When the monster King disappeared, we'
    call StartMessageCommand09HL_B13
    ret

; entry 47 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6062: 'I e lived here for 200'
DispatchTalkEvent_Case05_Case2F::
Jump_013_44F8:: ; address name
    ld hl, Script_6062
    call StartScriptAtHL_B13
    ret

; entry 48 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case30::
Jump_013_44FF:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_451D
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4516
    ld hl, $043C ; 'The Castle is under the monster'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4516::
    ld hl, $043D ; 'Did you see the monster King's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_451D::
    ld hl, $0497 ; 'The Castle is now managed by'
    call StartMessageCommand09HL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case31::
Jump_013_4524:: ; address name
    ld hl, $043E ; 'The cave to the south That'
    call StartMessageCommand09HL_B13
    ret

; entry 50 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case32::
Jump_013_452B:: ; address name
    ld hl, $043F ; 'The new monster King is said'
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case33::
Jump_013_4532:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4541
    ld hl, $0440 ; 'Hardly no one has seen the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4541::
    ld hl, $0498 ; 'Rumor has it that almost no'
    call StartMessageCommand09HL_B13
    ret

; entry 52 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case05_Case34::
Jump_013_4548:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_459F
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    jr Jump_013_4598

Jump_013_4582::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4591
    ld hl, $0441 ; 'This is only for army personnel!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4591::
    ld hl, $0442 ; 'The King has posted a notice.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4598::
    ld hl, Script_6119
    call StartScriptAtHL_B13
    ret

Jump_013_459F::
    ld hl, $0499 ; 'Where has our King gone?'
    call StartMessageCommand09HL_B13
    ret

; entry 53 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case05_Case35::
Jump_013_45A6:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4612
    ld de, $00B7
    call TestFlagBit
    jr c, Jump_013_460B
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    jr Jump_013_45FE

Jump_013_45E8::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_45F7
    ld hl, $0443 ; 'If you wish to join our'
    call StartMessageCommand09HL_B13
    ret

Jump_013_45F7::
    ld hl, $0444 ; 'Give away the LightOrb? But that's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_45FE::
    ld hl, $046B ; 'What? You have the three items?'
    call StartMessageCommand09HL_B13
    ld de, $00B7
    call SetFlagBit
    ret

Jump_013_460B::
    ld hl, $046C ; 'Who would e thought anyone would'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4612::
    ld hl, $049A ; 'There's no point staying in the'
    call StartMessageCommand09HL_B13
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case36::
Jump_013_4619:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4628
    ld hl, $0445 ; 'If you have the LightOrb, you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4628::
    ld hl, $04A3 ; 'The King's gone. What should I'
    call StartMessageCommand09HL_B13
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case37::
Jump_013_462F:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_463E
    ld hl, $0446 ; 'If I had the LightOrb, even'
    call StartMessageCommand09HL_B13
    ret

Jump_013_463E::
    ld hl, $049B ; 'If I had the LightOrb, even'
    call StartMessageCommand09HL_B13
    ret

; entry 56 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_606F: 'Want to know the most fundamental'
DispatchTalkEvent_Case05_Case38::
Jump_013_4645:: ; address name
    ld hl, Script_606F
    call StartScriptAtHL_B13
    ret

; entry 57 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case39::
Jump_013_464C:: ; address name
    ld hl, $044A ; 'Hear me out if you wish'
    call StartMessageCommand09HL_B13
    ret

; entry 58 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case05_Case3A::
Jump_013_4653:: ; address name
    ld a, $0E
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_607C
    call StartScriptAtHL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_6083: 'How may our church help you?'
DispatchTalkEvent_Case05_Case3B::
Jump_013_4664:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_6083
    call StartScriptAtHL_B13
    ret

; entry 60 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case3C::
Jump_013_4670:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_468E
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4687
    ld hl, $044D ; '0 read the sign. The finder'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4687::
    ld hl, $044E ; '0 read the sign. The Heaven'
    call StartMessageCommand09HL_B13
    ret

Jump_013_468E::
    ld hl, $049C ; '0 read the sign. Town of'
    call StartMessageCommand09HL_B13
    ret

; entry 61 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case3D::
Jump_013_4695:: ; address name
    ld hl, $0450 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

; entry 62 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case3E::
Jump_013_469C:: ; address name
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_6048: 'Welcome to the traveler's inn.'
DispatchTalkEvent_Case05_Case3F::
Jump_013_46A3:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_6048
    call StartScriptAtHL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case40::
Jump_013_46AF:: ; address name
    ld hl, $0452 ; 'The Change Staff will open paths.'
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case41::
Jump_013_46B6:: ; address name
    ld hl, $0453 ; 'Hey, kiddo! You're new here. Don't'
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case42::
Jump_013_46BD:: ; address name
    ld hl, $0454 ; 'Hey, kiddo! You're new here. Don't'
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case43::
Jump_013_46C4:: ; address name
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_46D3
    ld hl, $0455 ; 'Hey, kiddo! You're new here. Don't'
    call StartMessageCommand09HL_B13
    ret

Jump_013_46D3::
    ld hl, $0456 ; 'Hey, kiddo! You treasure hunting? The'
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case44::
Jump_013_46DA:: ; address name
    ld hl, $0457 ; 'On the island to the west,'
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case45::
Jump_013_46E1:: ; address name
    ld hl, $0458 ; 'To the east is a suspension'
    call StartMessageCommand09HL_B13
    ret

; entry 70 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case46::
Jump_013_46E8:: ; address name
    ld hl, $0459 ; 'Those inside the haunted castle speak'
    call StartMessageCommand09HL_B13
    ret

; entry 71 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
DispatchTalkEvent_Case05_Case47::
Jump_013_46EF:: ; address name
    farcall DispatchTalkEvent_Case05_Case47_Sub01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_4701
    ld hl, $045B ; '0 checked the small hole. It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4701::
    dec a
    jr nz, Jump_013_470B
    ld hl, $045C ; '0 checked the small hole. It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_470B::
    ld hl, Script_6091
    call StartScriptAtHL_B13
    ret

; entry 72 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case48::
Jump_013_4712:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4E
    ld [wScriptParam1], a
    ld de, $00AB
    call StartMessageScriptDE_B13
    ret

; entry 73 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case49::
Jump_013_4723:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $39
    ld [wScriptParam1], a
    ld de, $00AC
    call StartMessageScriptDE_B13
    ret

; entry 74 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6096: 'You can take this treasure, but'
DispatchTalkEvent_Case05_Case4A::
Jump_013_4734:: ; address name
    ld de, $00AD
    call TestFlagBit
    jr c, Jump_013_4743
    ld hl, Script_6096
    call StartScriptAtHL_B13
    ret

Jump_013_4743::
    ld hl, Script_60B0
    call StartScriptAtHL_B13
    ret

; entry 75 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case4B::
Jump_013_474A:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $3A
    ld [wScriptParam1], a
    ld de, $00AF
    call StartMessageScriptDE_B13
    ret

; entry 76 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
DispatchTalkEvent_Case05_Case4C::
Jump_013_475B:: ; address name
    farcall DispatchTalkEvent_Shared01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_476D
    ld hl, Script_60C7
    call StartScriptAtHL_B13
    ret

Jump_013_476D::
    ld hl, $0461 ; 'Step once on each of the'
    call StartMessageCommand09HL_B13
    ret

; entry 77 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60CE
DispatchTalkEvent_Case05_Case4D::
Jump_013_4774:: ; address name
    ld hl, $0462 ; '0 checked the notice. Lay the'
    call StartMessageCommand09HL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60CE
DispatchTalkEvent_Case05_Case4E::
Jump_013_477B:: ; address name
    ld hl, Script_60CE
    call StartScriptAtHL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case4F::
Jump_013_4782:: ; address name
    ld hl, $04A8 ; 'Where is my casket Where Ring'
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60D0
DispatchTalkEvent_Case05_Case50::
Jump_013_4789:: ; address name
    ld hl, $04A9 ; '0 checked the notice. Guide the'
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60D0
DispatchTalkEvent_Case05_Case51::
Jump_013_4790:: ; address name
    ld hl, Script_60D0
    call StartScriptAtHL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case52::
Jump_013_4797:: ; address name
    ld hl, $0463 ; '0 checked the notice. Follow the'
    call StartMessageCommand09HL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case53::
Jump_013_479E:: ; address name
    ld hl, $040E ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

; entry 84 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60D4: '0 checked the gravestone. There was'
DispatchTalkEvent_Case05_Case54::
Jump_013_47A5:: ; address name
    ld de, $00B2
    call TestFlagBit
    jr c, Jump_013_47B4
    ld hl, Script_60D4
    call StartScriptAtHL_B13
    ret

Jump_013_47B4::
    ld hl, $040E ; '0 checked the grave. The tombstone'
    call StartMessageCommand09HL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_60EA: 'You overcame the traps I laid'
DispatchTalkEvent_Case05_Case55::
Jump_013_47BB:: ; address name
    ld de, $00B3
    call TestFlagBit
    jr c, Jump_013_47CA
    ld hl, Script_60EA
    call StartScriptAtHL_B13
    ret

Jump_013_47CA::
    ld hl, Script_6103
    call StartScriptAtHL_B13
    ret

; entry 86 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case56::
Jump_013_47D1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $3B
    ld [wScriptParam1], a
    ld de, $00B5
    call StartMessageScriptDE_B13
    ret

; entry 87 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case57::
Jump_013_47E2:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_47F1
    ld hl, $046D ; 'The monster army's general is beyond'
    call StartMessageCommand09HL_B13
    ret

Jump_013_47F1::
    ld hl, $049D ; 'The Mayor is beyond here. Please'
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case58::
Jump_013_47F8:: ; address name
    ld hl, $046E ; 'Our King's castle is an invincible'
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case59::
Jump_013_47FF:: ; address name
    ld hl, $046F ; 'What? You e got the three'
    call StartMessageCommand09HL_B13
    ret

; entry 90 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case05_Case5A::
Jump_013_4806:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_485D
    ld de, $00B8
    call TestFlagBit
    jr c, Jump_013_4856
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    jr Jump_013_484F

Jump_013_4848::
    ld hl, $0470 ; 'Hm? How did you get in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_484F::
    ld hl, Script_6126
    call StartScriptAtHL_B13
    ret

Jump_013_4856::
    ld hl, $0472 ; 'If you can't even reach the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_485D::
    ld hl, $049E ; 'I e become the Mayor, but'
    call StartMessageCommand09HL_B13
    ret

; entry 91 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case5B::
Jump_013_4864:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0200
    call StartMessageScriptDE_B13
    ret

; entry 92 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6131
DispatchTalkEvent_Case05_Case5C::
Jump_013_4875:: ; address name
    ld hl, Script_6131
    call StartScriptAtHL_B13
    ret

; entry 93 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6059: 'Kweeeeeh!'
DispatchTalkEvent_Case05_Case5D::
Jump_013_487C:: ; address name
    ld hl, Script_6059
    call StartScriptAtHL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case5E::
Jump_013_4883:: ; address name
    ld hl, $0DE2 ; '0 checked the tombstone. There appeared'
    call StartMessageCommand09HL_B13
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case5F::
Jump_013_488A:: ; address name
    ld hl, $0476 ; 'Awaargh, I'm late, I'm late! They'
    call StartMessageCommand09HL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case60::
Jump_013_4891:: ; address name
    ld hl, $0477 ; 'They keep piling on these ludicrous'
    call StartMessageCommand09HL_B13
    ret

; entry 97 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case61::
Jump_013_4898:: ; address name
    ld hl, $0478 ; 'Gaah! You found me while I'
    call StartMessageCommand09HL_B13
    ret

; entry 98 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case62::
Jump_013_489F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00BC
    call StartMessageScriptDE_B13
    ret

; entry 99 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case63::
Jump_013_48B0:: ; address name
    ld hl, $0450 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

; entry 100 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case64::
Jump_013_48B7:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00BD
    call StartMessageScriptDE_B13
    ret

; entry 101 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case65::
Jump_013_48C8:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $25
    ld [wScriptParam1], a
    ld de, $00BE
    call StartMessageScriptDE_B13
    ret

; entry 102 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case05_Case66::
Jump_013_48D9:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00BF
    call StartMessageScriptDE_B13
    ret

; entry 103 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case05_Case67::
Jump_013_48EA:: ; address name
    ld de, $00C0
    call TestFlagBit
    jr c, Jump_013_4962
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    jr Jump_013_492B

Jump_013_4924::
    ld hl, $0479 ; 'Ah, so good of you to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_492B::
    ld a, $39
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $3A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $3B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_6133
    call StartScriptAtHL_B13
    ret

Jump_013_4962::
    ld hl, Script_614A
    call StartScriptAtHL_B13
    ret

; entry 104 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6152: 'Kameha So it was you who'
DispatchTalkEvent_Case05_Case68::
Jump_013_4969:: ; address name
    ld hl, Script_6152
    call StartScriptAtHL_B13
    ret

; entry 105 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; starts Script_6198: 'This way Here Here'
DispatchTalkEvent_Case05_Case69::
Jump_013_4970:: ; address name
    ld hl, Script_6198
    call StartScriptAtHL_B13
    ret

; entry 106 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wObject1
DispatchTalkEvent_Case05_Case6A::
Jump_013_4977:: ; address name
    xor a, a
    ld [wObject1 + $7], a
    ldh a, [hPlayerY]
    cp a, $70
    ret z
    ld hl, Script_618B
    call StartScriptAtHL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6B::
Jump_013_4987:: ; address name
    ld hl, $04A6 ; 'I was taking a walk outside'
    call StartMessageCommand09HL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6C::
Jump_013_498E:: ; address name
    ld hl, $04A4 ; 'South beyond the mountains is the'
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6D::
Jump_013_4995:: ; address name
    ld hl, $04A5 ; 'Several ancient ruins remain in the'
    call StartMessageCommand09HL_B13
    ret

; entry 110 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
DispatchTalkEvent_Case05_Case6E::
Jump_013_499C:: ; address name
    farcall DispatchTalkEvent_Shared01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_49AE
    ld hl, Script_60C7
    call StartScriptAtHL_B13
    ret

Jump_013_49AE::
    ld hl, $04A0 ; 'The castle's lord summons monsters'
    call StartMessageCommand09HL_B13
    ret

; entry 111 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
DispatchTalkEvent_Case05_Case6F::
Jump_013_49B5:: ; address name
    farcall DispatchTalkEvent_Shared01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_49C7
    ld hl, Script_60C7
    call StartScriptAtHL_B13
    ret

Jump_013_49C7::
    ld hl, $04A1 ; 'A button hides behind a grave'
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case70::
Jump_013_49CE:: ; address name
    ld hl, $0413 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

; when wC955 is set: clears it and warps between map $7F and $92 (position $40, $40 or $40, $10) through mode state 6 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wMapToggleRequest, hMapId
; writes: wMapToggleRequest, hMapId, wWarpDestX, wWarpDestY, wJoypadHeld, wJoypadPressed, wWarpDestFacing, wMapToggleFlag, ...
ToggleMapBetween7FAnd92::
Jump_013_49D5:: ; address name
    ld a, [wMapToggleRequest]
    or a, a
    ret z
    xor a, a
    ld [wMapToggleRequest], a
    ldh a, [hMapId]
    cp a, $7F
    jr nz, Jump_013_49F4
    ld a, $92
    ldh [hMapId], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    jr Jump_013_4A02

Jump_013_49F4::
    ld a, $7F
    ldh [hMapId], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $10
    ld [wWarpDestY], a

Jump_013_4A02::
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a, a
    ld [wWarpDestFacing], a
    xor a, a
    ld [wMapToggleFlag], a
    ld a, $06
    ld [wModeState], a
    xor a, a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wTalkEventGroup
DispatchTalkEvent_Case04::
Jump_013_4A23:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case04_Case00
    dw DispatchTalkEvent_Case04_Case01
    dw DispatchTalkEvent_Case04_Case02
    dw DispatchTalkEvent_Case04_Case03
    dw DispatchTalkEvent_Case04_Case04
    dw DispatchTalkEvent_Case04_Case05
    dw DispatchTalkEvent_Case04_Case06
    dw DispatchTalkEvent_Case04_Case07
    dw DispatchTalkEvent_Case04_Case08
    dw DispatchTalkEvent_Case04_Case09
    dw DispatchTalkEvent_Case04_Case0A
    dw DispatchTalkEvent_Case04_Case0B
    dw DispatchTalkEvent_Case04_Case0C
    dw DispatchTalkEvent_Case04_Case0D
    dw DispatchTalkEvent_Case04_Case0E
    dw DispatchTalkEvent_Case04_Case0F
    dw DispatchTalkEvent_Case04_Case10
    dw DispatchTalkEvent_Case04_Case11
    dw DispatchTalkEvent_Case04_Case12
    dw DispatchTalkEvent_Case04_Case13
    dw DispatchTalkEvent_Case04_Case14
    dw DispatchTalkEvent_Case04_Case15
    dw DispatchTalkEvent_Case04_Case16
    dw DispatchTalkEvent_Case04_Case17
    dw DispatchTalkEvent_Case04_Case18
    dw DispatchTalkEvent_Case04_Case19
    dw DispatchTalkEvent_Case04_Case1A
    dw DispatchTalkEvent_Case04_Case1B
    dw DispatchTalkEvent_Case04_Case1C
    dw DispatchTalkEvent_Case04_Case1D
    dw DispatchTalkEvent_Case04_Case1E
    dw DispatchTalkEvent_Case04_Case1F
    dw DispatchTalkEvent_Case04_Case20
    dw DispatchTalkEvent_Case04_Case21
    dw DispatchTalkEvent_Case04_Case22
    dw DispatchTalkEvent_Case04_Case23
    dw DispatchTalkEvent_Case04_Case24
    dw DispatchTalkEvent_Case04_Case25
    dw DispatchTalkEvent_Case04_Case26
    dw DispatchTalkEvent_Case04_Case27
    dw DispatchTalkEvent_Case04_Case28
    dw DispatchTalkEvent_Case04_Case29
    dw DispatchTalkEvent_Case04_Case2A
    dw DispatchTalkEvent_Case04_Case2B
    dw DispatchTalkEvent_Case04_Case2C
    dw DispatchTalkEvent_Case04_Case2D
    dw DispatchTalkEvent_Case04_Case2E
    dw DispatchTalkEvent_Case04_Case2F
    dw DispatchTalkEvent_Case04_Case30
    dw DispatchTalkEvent_Case04_Case31
    dw DispatchTalkEvent_Case04_Case32
    dw DispatchTalkEvent_Case04_Case33
    dw DispatchTalkEvent_Case04_Case34
    dw DispatchTalkEvent_Case04_Case35
    dw DispatchTalkEvent_Case04_Case36
    dw DispatchTalkEvent_Case04_Case37
    dw DispatchTalkEvent_Case04_Case38
    dw DispatchTalkEvent_Case04_Case39
    dw DispatchTalkEvent_Case04_Case3A
    dw DispatchTalkEvent_Case04_Case3B
    dw DispatchTalkEvent_Case04_Case3C
    dw DispatchTalkEvent_Case04_Case3D
    dw DispatchTalkEvent_Case04_Case3E
    dw DispatchTalkEvent_Case04_Case3F
    dw DispatchTalkEvent_Case04_Case40
    dw DispatchTalkEvent_Case04_Case41
    dw DispatchTalkEvent_Case04_Case42
    dw DispatchTalkEvent_Case04_Case43
    dw DispatchTalkEvent_Case04_Case44
    dw DispatchTalkEvent_Case04_Case45
    dw DispatchTalkEvent_Case04_Case46
    dw DispatchTalkEvent_Case04_Case47
    dw DispatchTalkEvent_Case04_Case48
    dw DispatchTalkEvent_Case04_Case49
    dw DispatchTalkEvent_Case04_Case4A
    dw DispatchTalkEvent_Case04_Case4B
    dw DispatchTalkEvent_Case04_Case4C
    dw DispatchTalkEvent_Case04_Case4D
    dw DispatchTalkEvent_Case04_Case4E
    dw DispatchTalkEvent_Case04_Case4F
    dw DispatchTalkEvent_Case04_Case50
    dw DispatchTalkEvent_Case04_Case51
    dw DispatchTalkEvent_Case04_Case52
    dw DispatchTalkEvent_Case04_Case53
    dw DispatchTalkEvent_Case04_Case54
    dw DispatchTalkEvent_Case04_Case55
    dw DispatchTalkEvent_Case04_Case56
    dw DispatchTalkEvent_Case04_Case57
    dw DispatchTalkEvent_Case04_Case58
    dw DispatchTalkEvent_Case04_Case59
    dw DispatchTalkEvent_Case04_Case5A
    dw DispatchTalkEvent_Case04_Case5B
    dw DispatchTalkEvent_Case04_Case5C
    dw DispatchTalkEvent_Case04_Case5D
    dw DispatchTalkEvent_Case04_Case5E
    dw DispatchTalkEvent_Case04_Case5F
    dw DispatchTalkEvent_Case04_Case60
    dw DispatchTalkEvent_Case04_Case61
    dw DispatchTalkEvent_Case04_Case62
    dw DispatchTalkEvent_Case04_Case63
    dw DispatchTalkEvent_Case04_Case64
    dw DispatchTalkEvent_Case04_Case65
    dw DispatchTalkEvent_Case04_Case66
    dw DispatchTalkEvent_Case04_Case67
    dw DispatchTalkEvent_Case04_Case68
    dw DispatchTalkEvent_Case04_Case69
    dw DispatchTalkEvent_Case04_Case6A
    dw DispatchTalkEvent_Case04_Case6B
    dw DispatchTalkEvent_Case04_Case6C
    dw DispatchTalkEvent_Case04_Case6D
    dw DispatchTalkEvent_Case04_Case6E
    dw DispatchTalkEvent_Case04_Case6F
    dw DispatchTalkEvent_Case04_Case70
    dw DispatchTalkEvent_Case04_Case71
    dw DispatchTalkEvent_Case04_Case72
    dw DispatchTalkEvent_Case04_Case73
    dw DispatchTalkEvent_Case04_Case74
    dw DispatchTalkEvent_Case04_Case75
    dw DispatchTalkEvent_Case04_Case76
    dw DispatchTalkEvent_Case04_Case77
    dw DispatchTalkEvent_Case04_Case78
    dw DispatchTalkEvent_Case04_Case79
    dw DispatchTalkEvent_Case04_Case7A
    dw DispatchTalkEvent_Case04_Case7B
    dw DispatchTalkEvent_Case04_Case7C
    dw DispatchTalkEvent_Case04_Case7D
    dw DispatchTalkEvent_Case04_Case7E
    dw DispatchTalkEvent_Case04_Case7F
    dw DispatchTalkEvent_Case04_Case80
    dw DispatchTalkEvent_Case04_Case81
    dw DispatchTalkEvent_Case04_Case82
    dw DispatchTalkEvent_Case04_Case83
    dw DispatchTalkEvent_Case04_Case84
    dw DispatchTalkEvent_Case04_Case85
    dw DispatchTalkEvent_Case04_Case86
    dw DispatchTalkEvent_Case04_Case87
    dw DispatchTalkEvent_Case04_Case88
    dw DispatchTalkEvent_Case04_Case89
    dw DispatchTalkEvent_Case04_Case8A
    dw DispatchTalkEvent_Case04_Case8B
    dw TalkMsg0DD7_OurHeartsAreLike
    dw Talk0DD8_QueenHelenIsWracked
    dw Talk0DD9_TheReceptionHallIs
    dw TalkMsg0DDA_OurQueenHelensPremonition
    dw TalkMsg0DDB_WhatIsItLeave
    dw DispatchTalkEvent_Case04_Case91
    dw DispatchTalkEvent_Case04_Case92
    dw DispatchTalkEvent_Case04_Case93
    dw DispatchTalkEvent_Case04_Case94
    dw DispatchTalkEvent_Case04_Case94
    dw DispatchTalkEvent_Case04_Case96
    dw DispatchTalkEvent_Case04_Case97
    dw DispatchTalkEvent_Case04_Case98
    dw DispatchTalkEvent_Case04_Case99
    dw DispatchTalkEvent_Case04_Case9A
    dw DispatchTalkEvent_Case04_Case9B
    dw DispatchTalkEvent_Case04_Case9C
    dw DispatchTalkEvent_Case04_Case9D
    dw DispatchTalkEvent_Case04_Case9E
    dw DispatchTalkEvent_Case04_Case9F
    dw DispatchTalkEvent_Case04_CaseA0
    dw DispatchTalkEvent_Case04_CaseA1
    dw Msg01E9
    dw Msg01EA
    dw Msg01EB
    dw Msg01EC
    dw Msg01ED
    dw Msg01EE
    dw Msg01EF
    dw Msg01F0
    dw DispatchTalkEvent_Case04_CaseAA

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case00::
Jump_013_4B7D:: ; address name
    ld hl, $0300 ; 'This is Norden, the kingdom of'
    call StartMessageCommand09HL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case01::
Jump_013_4B84:: ; address name
    ld hl, $0301 ; 'There are three kingdoms situated around'
    call StartMessageCommand09HL_B13
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case02::
Jump_013_4B8B:: ; address name
    ld hl, $0302 ; 'Travel north along the mountain range,'
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case03::
Jump_013_4B92:: ; address name
    ld hl, $0303 ; 'The winter here is harsh. Stay'
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case04::
Jump_013_4B99:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BA8
    ld hl, $0304 ; 'Listen, did you hear? They found'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BA8::
    ld hl, $0355 ; 'I e heard about the mine.'
    call StartMessageCommand09HL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case05::
Jump_013_4BAF:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BBE
    ld hl, $0305 ; 'Urrrrrgh! The western wretches! The mine'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BBE::
    ld hl, $0356 ; 'There's just no telling what greed'
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case06::
Jump_013_4BC5:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BD4
    ld hl, $0306 ; 'Everyone's been acting strangely since they'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BD4::
    ld hl, $0357 ; 'Did you know? There is a'
    call StartMessageCommand09HL_B13
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case07::
Jump_013_4BDB:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4BEA
    ld hl, $0307 ; 'The spring in the north, where'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BEA::
    ld hl, $0A0B ; 'The spirit's spring in the north'
    call StartMessageCommand09HL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D5B: 'Have you heard about the spirit'
DispatchTalkEvent_Case04_Case08::
Jump_013_4BF1:: ; address name
    ld hl, Script_5D5B
    call StartScriptAtHL_B13
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case09::
Jump_013_4BF8:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C07
    ld hl, $030B ; 'Around these parts, we get a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C07::
    ld hl, $0D21 ; 'Star spuds grow plentifully around these'
    call StartMessageCommand09HL_B13
    ret

; entry 10 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0A::
Jump_013_4C0E:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C1D
    ld hl, $030C ; 'It's become much colder. We may'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C1D::
    ld hl, $0DF2 ; 'The weather has been mild. It's'
    call StartMessageCommand09HL_B13
    ret

; entry 11 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case04_Case0B::
Jump_013_4C24:: ; address name
    ld de, $0081
    call TestFlagBit
    jr c, Jump_013_4C4A
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_4C43
    ld hl, $030E ; 'His Majesty is in talks with'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C43::
    ld hl, Script_5D8A
    call StartScriptAtHL_B13
    ret

Jump_013_4C4A::
    ld hl, $031D ; 'Please enter, your envoyship!'
    call StartMessageCommand09HL_B13
    ret

; entry 12 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0C::
Jump_013_4C51:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4C60
    ld hl, $030F ; 'The mine on the western border'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C60::
    ld hl, $037A ; 'The border with the west is'
    call StartMessageCommand09HL_B13
    ret

; entry 13 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case0D::
Jump_013_4C67:: ; address name
    ld a, $07
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5D68
    call StartScriptAtHL_B13
    ret

; entry 14 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0E::
Jump_013_4C78:: ; address name
    ld hl, $0311 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 15 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case04_Case0F::
Jump_013_4C7F:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01E6
    call StartMessageScriptDE_B13
    ret

; entry 16 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case10::
Jump_013_4C90:: ; address name
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 17 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D6F: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case11::
Jump_013_4C97:: ; address name
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; entry 18 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5D6F: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case12::
Jump_013_4C9E:: ; address name
    ld hl, Script_5D6F
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 19 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case13::
Jump_013_4CAA:: ; address name
    ld hl, $0315 ; 'The border is closed, so I'
    call StartMessageCommand09HL_B13
    ret

; entry 20 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wJoypadHeld, wJoypadPressed
DispatchTalkEvent_Case04_Case14::
Jump_013_4CB1:: ; address name
    ld de, $01E4
    call TestFlagBit
    jr c, Jump_013_4CED
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_4CD7
    ld de, $01E8
    call TestFlagBit
    jr c, Jump_013_4CD0
    ld hl, Script_5D76
    call StartScriptAtHL_B13
    ret

Jump_013_4CD0::
    ld hl, $031B ; 'If you restore this world's peace,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4CD7::
    ld de, $01E3
    call TestFlagBit
    jr c, Jump_013_4CE6
    ld hl, Script_5FCD
    call StartScriptAtHL_B13
    ret

Jump_013_4CE6::
    ld hl, Script_5FD2
    call StartScriptAtHL_B13
    ret

Jump_013_4CED::
    xor a, a
    set 0, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; entry 21 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case15::
Jump_013_4CF7:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D24
    ld de, $0087
    call TestFlagBit
    jr c, Jump_013_4D1D
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4D16
    ld hl, $031E ; 'His Majesty has been cranky Is'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D16::
    ld hl, $0358 ; 'I e heard from friends who'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D1D::
    ld hl, $0ABA ; 'Am I dreaming? Two Kings?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D24::
    ld hl, $0379 ; 'Who was that boy who came'
    call StartMessageCommand09HL_B13
    ret

; entry 22 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case16::
Jump_013_4D2B:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D3A
    ld hl, $031F ; 'After the gold discovery, our relationship'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D3A::
    ld hl, $0377 ; 'Well, we managed to avoid war'
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case17::
Jump_013_4D41:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D50
    ld hl, $0320 ; 'I remember the King to be'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D50::
    ld hl, $0378 ; 'This is just between you and'
    call StartMessageCommand09HL_B13
    ret

; entry 24 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case18::
Jump_013_4D57:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D93
    ld de, $0087
    call TestFlagBit
    jr c, Jump_013_4D8C
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4D85
    ld de, $0082
    call TestFlagBit
    jr c, Jump_013_4D7E
    ld hl, Script_5D97
    call StartScriptAtHL_B13
    ret

Jump_013_4D7E::
    ld hl, $0323 ; 'His Majesty is furious over the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D85::
    ld hl, Script_5DA6
    call StartScriptAtHL_B13
    ret

Jump_013_4D8C::
    ld hl, $0ABB ; 'What? Why are there two Kings?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D93::
    ld hl, $0376 ; 'Who would e thought that a'
    call StartMessageCommand09HL_B13
    ret

; entry 25 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case19::
Jump_013_4D9A:: ; address name
    ld hl, $0ABD ; '0 checked the bookshelf. History of'
    call StartMessageCommand09HL_B13
    ret

; entry 26 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1A::
Jump_013_4DA1:: ; address name
    ld hl, $0ABE ; '0 checked the bookshelf. History of'
    call StartMessageCommand09HL_B13
    ret

; entry 27 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1B::
Jump_013_4DA8:: ; address name
    ld hl, $0ABC ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 28 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1C::
Jump_013_4DAF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DBE
    ld hl, $0324 ; 'This tunnel goes to a port.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DBE::
    ld hl, $0AC3 ; 'This tunnel leads to a port.'
    call StartMessageCommand09HL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1D::
Jump_013_4DC5:: ; address name
    ld hl, $0325 ; 'This is the port of Nofor.'
    call StartMessageCommand09HL_B13
    ret

; entry 30 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1E::
Jump_013_4DCC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DDB
    ld hl, $0326 ; 'It's useless! Beyond useless! The ice'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DDB::
    ld hl, $0A0C ; 'The ice blocking the harbor finally'
    call StartMessageCommand09HL_B13
    ret

; entry 31 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1F::
Jump_013_4DE2:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DF1
    ld hl, $0327 ; 'In all my years, I e'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DF1::
    ld hl, $0AC4 ; 'The ice melted away! The port'
    call StartMessageCommand09HL_B13
    ret

; entry 32 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case20::
Jump_013_4DF8:: ; address name
    ld hl, $0328 ; 'Three kingdoms ring this lake. They'
    call StartMessageCommand09HL_B13
    ret

; entry 33 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case21::
Jump_013_4DFF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E0E
    ld hl, $0329 ; 'The border? It's not here. The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E0E::
    ld hl, $0A0D ; 'The long winter seems to be'
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case22::
Jump_013_4E15:: ; address name
    ld hl, $032A ; 'Mama said to stay off the'
    call StartMessageCommand09HL_B13
    ret

; entry 35 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case23::
Jump_013_4E1C:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E2B
    ld hl, $032B ; 'We were passing through from the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E2B::
    ld hl, $0A0E ; 'We were visiting from the east.'
    call StartMessageCommand09HL_B13
    ret

; entry 36 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case24::
Jump_013_4E32:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4E41
    ld hl, $032C ; 'They discovered gold at the mine'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E41::
    ld hl, $037B ; 'The discovery of gold was a'
    call StartMessageCommand09HL_B13
    ret

; entry 37 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case25::
Jump_013_4E48:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E57
    ld hl, $032D ; 'I hear the west and the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E57::
    ld hl, $0DF5 ; 'The kingdoms of the north and'
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case26::
Jump_013_4E5E:: ; address name
    ld hl, $032E ; 'Do you know Lady Yuna of'
    call StartMessageCommand09HL_B13
    ret

; entry 39 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case27::
Jump_013_4E65:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E74
    ld hl, $032F ; 'The scholar in the tavern said'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E74::
    ld hl, $0DF6 ; 'The scholar who was in the'
    call StartMessageCommand09HL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case28::
Jump_013_4E7B:: ; address name
    ld hl, $0330 ; 'Don't you think it's too expensive?'
    call StartMessageCommand09HL_B13
    ret

; entry 41 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case29::
Jump_013_4E82:: ; address name
    ld a, $0A
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5DB0
    call StartScriptAtHL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case2A::
Jump_013_4E93:: ; address name
    ld a, $08
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5DB7
    call StartScriptAtHL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case2B::
Jump_013_4EA4:: ; address name
    ld a, $09
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5DBE
    call StartScriptAtHL_B13
    ret

; entry 44 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5DCC: 'How may our church serve you?'
DispatchTalkEvent_Case04_Case2C::
Jump_013_4EB5:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5DCC
    call StartScriptAtHL_B13
    ret

; entry 45 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2D::
Jump_013_4EC1:: ; address name
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2E::
Jump_013_4EC8:: ; address name
    ld hl, $0D3B ; 'Whinny!'
    call StartMessageCommand09HL_B13
    ret

; entry 47 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2F::
Jump_013_4ECF:: ; address name
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; entry 48 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case30::
Jump_013_4ED6:: ; address name
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case31::
Jump_013_4EDD:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4EEC
    ld hl, $0334 ; 'We e been full up with'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4EEC::
    ld hl, $0A0F ; 'When the harbor's ice disappeared, the'
    call StartMessageCommand09HL_B13
    ret

; entry 50 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case32::
Jump_013_4EF3:: ; address name
    ld hl, $0335 ; 'Urrrp! Hoo, listen to this! My'
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case33::
Jump_013_4EFA:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4F09
    ld hl, $0336 ; 'Sigh Isn't that scholar appealing? The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F09::
    ld hl, $0A10 ; 'Welcome! Oh? Hi, there! Well, you're'
    call StartMessageCommand09HL_B13
    ret

; entry 52 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case04_Case34::
Jump_013_4F10:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_4F1F
    ld hl, $0337 ; 'I came from the eastern kingdom.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F1F::
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_4F3C
    ld hl, $0AE6 ; 'I e traveled far to study'
    call StartMessageCommand09HL_B13
    ld de, $009E
    call SetFlagBit
    ret

Jump_013_4F3C::
    ld hl, $0D20 ; 'Oh! That blue flower! It's unmistakably'
    call StartMessageCommand09HL_B13
    ret

; entry 53 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5DC5: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case35::
Jump_013_4F43:: ; address name
    ld hl, $0ABF ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5DC5: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case36::
Jump_013_4F4A:: ; address name
    ld hl, Script_5DC5
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case37::
Jump_013_4F56:: ; address name
    ld hl, $0338 ; 'The King of the west is'
    call StartMessageCommand09HL_B13
    ret

; entry 56 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case38::
Jump_013_4F5D:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4F6C
    ld hl, $0339 ; 'This is the border we share'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F6C::
    ld hl, $034E ; 'We almost went to war with'
    call StartMessageCommand09HL_B13
    ret

; entry 57 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case39::
Jump_013_4F73:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4F91
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4F8A
    ld hl, $033A ; 'The border has been sealed by'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F8A::
    ld hl, $034F ; 'The King has sealed the border.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F91::
    ld hl, $037C ; 'The King gave word to lift'
    call StartMessageCommand09HL_B13
    ret

; entry 58 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3A::
Jump_013_4F98:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4FB6
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FAF
    ld hl, $033B ; 'A traveler, are you? Sorry, but'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FAF::
    ld hl, $0350 ; 'We're still under orders to keep'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FB6::
    ld hl, $037D ; 'A monster was playing the part'
    call StartMessageCommand09HL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3B::
Jump_013_4FBD:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FCC
    ld hl, $033C ; 'Our tunneling found gold, but we'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FCC::
    ld hl, $0351 ; 'Was that really all the gold?'
    call StartMessageCommand09HL_B13
    ret

; entry 60 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3C::
Jump_013_4FD3:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4FF1
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FEA
    ld hl, $033D ; 'This side is the western kingdom!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FEA::
    ld hl, $0352 ; 'I e heard There was almost'
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FF1::
    ld hl, $0D1C ; 'The King of the north was'
    call StartMessageCommand09HL_B13
    ret

; entry 61 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3D::
Jump_013_4FF8:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_5016
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_500F
    ld hl, $033E ; 'The northerners want our gold! There's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_500F::
    ld hl, $0353 ; 'The north's King still suspects us.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5016::
    ld hl, $0D1D ; 'If you go south, you'll eventually'
    call StartMessageCommand09HL_B13
    ret

; entry 62 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3E::
Jump_013_501D:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_502C
    ld hl, $033F ; 'The northerners muscled in on the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_502C::
    ld hl, $0354 ; 'We're not certain about what we'll'
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3F::
Jump_013_5033:: ; address name
    ld hl, $0340 ; 'Heh, you e come way down'
    call StartMessageCommand09HL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case40::
Jump_013_503A:: ; address name
    ld hl, $0345 ; 'Kid, you have guts to be'
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case41::
Jump_013_5041:: ; address name
    ld hl, $0341 ; 'There is a boulder blocking the'
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case42::
Jump_013_5048:: ; address name
    ld hl, $0342 ; 'Hurry! We have to beat the'
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case43::
Jump_013_504F:: ; address name
    ld hl, $0344 ; 'The gold is ours! The west'
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5DD3: 'What? What was that explosion?'
DispatchTalkEvent_Case04_Case44::
Jump_013_5056:: ; address name
    ld hl, $0343 ; 'The vein of gold is just'
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5DD3: 'What? What was that explosion?'
DispatchTalkEvent_Case04_Case45::
Jump_013_505D:: ; address name
    ld hl, Script_5DD3
    call StartScriptAtHL_B13
    ret

; entry 70 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5E02: 'What? What was that explosion?'
DispatchTalkEvent_Case04_Case46::
Jump_013_5064:: ; address name
    ld hl, Script_5E02
    call StartScriptAtHL_B13
    ret

; entry 71 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case04_Case47::
Jump_013_506B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $40
    ld [wScriptParam1], a
    ld de, $0084
    call StartMessageScriptDE_B13
    ret

; entry 72 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case48::
Jump_013_507C:: ; address name
    ld de, $01E5
    call TestFlagBit
    jp c, Jump_013_510D
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_5106
    ld de, $0093
    call TestFlagBit
    jr c, Jump_013_50FF
    ld de, $008E
    call TestFlagBit
    jr c, Jump_013_50F8
    ld de, $008D
    call TestFlagBit
    jr c, Jump_013_50EB
    ld de, $008C
    call TestFlagBit
    jr c, Jump_013_50DE
    ld de, $008B
    call TestFlagBit
    jr c, Jump_013_50D1
    ld de, $0088
    call TestFlagBit
    jr c, Jump_013_50CA
    ld hl, $035C ; 'Ah, saved at last! The two'
    call StartMessageCommand09HL_B13
    ld de, $0088
    call SetFlagBit
    ret

Jump_013_50CA::
    ld hl, $035D ; 'I want to get out, but'
    call StartMessageCommand09HL_B13
    ret

Jump_013_50D1::
    ld hl, $0367 ; 'I'm real! Don't you believe me?'
    call StartMessageCommand09HL_B13
    ld de, $008C
    call SetFlagBit
    ret

Jump_013_50DE::
    ld hl, $0368 ; 'Look in my eyes! I'm not'
    call StartMessageCommand09HL_B13
    ld de, $008D
    call SetFlagBit
    ret

Jump_013_50EB::
    ld hl, $0369 ; 'If you can't see the truth,'
    call StartMessageCommand09HL_B13
    ld de, $008E
    call SetFlagBit
    ret

Jump_013_50F8::
    ld hl, $036A ; 'Didn't we work together to escape'
    call StartMessageCommand09HL_B13
    ret

Jump_013_50FF::
    ld hl, $0373 ; 'Awaaargh! A m-m-monster! A monster was'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5106::
    ld hl, $0375 ; 'King I'll have the border opened.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_510D::
    ld hl, $0AC2 ; 'King The spirit made it possible'
    call StartMessageCommand09HL_B13
    ret

; entry 73 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case49::
Jump_013_5114:: ; address name
    ld de, $0089
    call TestFlagBit
    jr c, Jump_013_5129
    ld hl, $035E ; 'Kameha Where's the exit? We'll starve'
    call StartMessageCommand09HL_B13
    ld de, $0089
    call SetFlagBit
    ret

Jump_013_5129::
    ld hl, $035F ; 'Kameha Where's the exit? We'll starve'
    call StartMessageCommand09HL_B13
    ret

; entry 74 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5E2F: '0 tapped on the wall. The'
DispatchTalkEvent_Case04_Case4A::
Jump_013_5130:: ; address name
    ld hl, Script_5E2F
    call StartScriptAtHL_B13
    ret

; entry 75 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5E37: '0 tapped on the wall. Sound'
DispatchTalkEvent_Case04_Case4B::
Jump_013_5137:: ; address name
    ld hl, Script_5E37
    call StartScriptAtHL_B13
    ret

; entry 76 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5E5A: 'I'm the real King, you fake!'
DispatchTalkEvent_Case04_Case4C::
Jump_013_513E:: ; address name
    ld hl, Script_5E5A
    call StartScriptAtHL_B13
    ret

; entry 77 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4D::
Jump_013_5145:: ; address name
    ld de, $0093
    call TestFlagBit
    jr c, Jump_013_51A8
    ld de, $0092
    call TestFlagBit
    jr c, Jump_013_51A1
    ld de, $0091
    call TestFlagBit
    jr c, Jump_013_5194
    ld de, $0090
    call TestFlagBit
    jr c, Jump_013_5187
    ld de, $008F
    call TestFlagBit
    jr c, Jump_013_517A
    ld hl, $036C ; 'I am real! Don't believe him!'
    call StartMessageCommand09HL_B13
    ld de, $008F
    call SetFlagBit
    ret

Jump_013_517A::
    ld hl, $036D ; 'My regal bearing should be evidence'
    call StartMessageCommand09HL_B13
    ld de, $0090
    call SetFlagBit
    ret

Jump_013_5187::
    ld hl, $036E ; 'Look at him! He's grimy! He's'
    call StartMessageCommand09HL_B13
    ld de, $0091
    call SetFlagBit
    ret

Jump_013_5194::
    ld hl, $036F ; 'You suspect me still? Kiki! Gaaah!'
    call StartMessageCommand09HL_B13
    ld de, $0092
    call SetFlagBit
    ret

Jump_013_51A1::
    ld hl, Script_5E67
    call StartScriptAtHL_B13
    ret

Jump_013_51A8::
    ld hl, Script_5E77
    call StartScriptAtHL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4E::
Jump_013_51AF:: ; address name
    ld hl, $037E ; 'This is the town of Weston.'
    call StartMessageCommand09HL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4F::
Jump_013_51B6:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51C5
    ld hl, $037F ; 'The west's castle has seen a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_51C5::
    ld hl, $0D3D ; 'They say Lady Yuna is back'
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case50::
Jump_013_51CC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51DB
    ld hl, $0380 ; 'Across from us on the lake'
    call StartMessageCommand09HL_B13
    ret

Jump_013_51DB::
    ld hl, $0A11 ; 'The eastern kingdom's castle is across'
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case51::
Jump_013_51E2:: ; address name
    ld hl, $0381 ; 'I saw Lady Yuna riding towards'
    call StartMessageCommand09HL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case52::
Jump_013_51E9:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_51F8
    ld hl, $0382 ; 'Lady Yuna has been a lively'
    call StartMessageCommand09HL_B13
    ret

Jump_013_51F8::
    ld hl, $0DC8 ; 'Lady Yuna has always been highly'
    call StartMessageCommand09HL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case53::
Jump_013_51FF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_520E
    ld hl, $0383 ; 'I haven't been seeing too many'
    call StartMessageCommand09HL_B13
    ret

Jump_013_520E::
    ld hl, $0A12 ; 'The harbor has been busy with'
    call StartMessageCommand09HL_B13
    ret

; entry 84 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case54::
Jump_013_5215:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5233
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_522C
    ld hl, $0384 ; 'Lady Yuna is said to be'
    call StartMessageCommand09HL_B13
    ret

Jump_013_522C::
    ld hl, $0AE0 ; 'Lady Yuna seems to be her'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5233::
    ld hl, $0D22 ; 'Out at the western castle, I'
    call StartMessageCommand09HL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case55::
Jump_013_523A:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5249
    ld hl, $0385 ; 'I e heard rumors that something'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5249::
    ld hl, $0DF3 ; 'Lady Yuna has come out of'
    call StartMessageCommand09HL_B13
    ret

; entry 86 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case56::
Jump_013_5250:: ; address name
    ld hl, $0386 ; 'The King dotes over Lady Yuna.'
    call StartMessageCommand09HL_B13
    ret

; entry 87 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case57::
Jump_013_5257:: ; address name
    ld hl, $0387 ; 'The road to the eastern kingdom'
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case58::
Jump_013_525E:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_526D
    ld hl, $0388 ; 'Lady Yuna locks herself in her'
    call StartMessageCommand09HL_B13
    ret

Jump_013_526D::
    ld hl, $0AE1 ; 'Lady Yuna tries to bolt from'
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case59::
Jump_013_5274:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5283
    ld hl, $0389 ; 'If you can cheer up the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5283::
    ld hl, $0AE2 ; 'All the people swarming to the'
    call StartMessageCommand09HL_B13
    ret

; entry 90 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case5A::
Jump_013_528A:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5299
    ld hl, $038A ; 'A woodsman came by a while'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5299::
    ld hl, $0D23 ; 'I just heard a rumor The'
    call StartMessageCommand09HL_B13
    ret

; entry 91 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case5B::
Jump_013_52A0:: ; address name
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 92 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case04_Case5C::
Jump_013_52A7:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01E7
    call StartMessageScriptDE_B13
    ret

; entry 93 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5E87: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case5D::
Jump_013_52B8:: ; address name
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5E87: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case5E::
Jump_013_52BF:: ; address name
    ld hl, Script_5E87
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case5F::
Jump_013_52CB:: ; address name
    ld a, $0B
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5E8E
    call StartScriptAtHL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case60::
Jump_013_52DC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_52EB
    ld hl, $038C ; 'The lake is frozen, so I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_52EB::
    ld hl, $0A13 ; 'The piled up ice floes disappeared'
    call StartMessageCommand09HL_B13
    ret

; entry 97 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case61::
Jump_013_52F2:: ; address name
    ld hl, $038D ; 'This is Westania Castle. Westania is'
    call StartMessageCommand09HL_B13
    ret

; entry 98 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case62::
Jump_013_52F9:: ; address name
    ld hl, $038E ; 'Nobody fails to be impressed when'
    call StartMessageCommand09HL_B13
    ret

; entry 99 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case63::
Jump_013_5300:: ; address name
    ld hl, $038F ; 'I e brought with me a'
    call StartMessageCommand09HL_B13
    ret

; entry 100 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case64::
Jump_013_5307:: ; address name
    ld hl, $0390 ; 'When I balance on my ball,'
    call StartMessageCommand09HL_B13
    ret

; entry 101 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case65::
Jump_013_530E:: ; address name
    ld hl, $0391 ; 'I hurl knives with incredible accuracy.'
    call StartMessageCommand09HL_B13
    ret

; entry 102 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case66::
Jump_013_5315:: ; address name
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_5333
    ld de, $0095
    call TestFlagBit
    jr c, Jump_013_532C
    ld hl, $0392 ; 'Please, line up! And quit pushing!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_532C::
    ld hl, $0AB9 ; 'If you e come to entertain'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5333::
    ld hl, $0ACB ; 'The crowds that flocked to the'
    call StartMessageCommand09HL_B13
    ret

; entry 103 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case67::
Jump_013_533A:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5358
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_5351
    ld hl, $0393 ; 'Oh Lady Yuna To think that'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5351::
    ld hl, $0D1E ; 'Oh Lady Yuna I miss you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5358::
    ld hl, $0ADE ; 'Lady Yuna is back to her'
    call StartMessageCommand09HL_B13
    ret

; entry 104 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case68::
Jump_013_535F:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_537D
    ld de, $0095
    call TestFlagBit
    jr c, Jump_013_5376
    ld hl, Script_5E95
    call StartScriptAtHL_B13
    ret

Jump_013_5376::
    ld hl, $0394 ; '0 read the sign. Come all'
    call StartMessageCommand09HL_B13
    ret

Jump_013_537D::
    ld hl, $0ADF ; '0 read the sign. Lady Yuna'
    call StartMessageCommand09HL_B13
    ret

; entry 105 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case69::
Jump_013_5384:: ; address name
    ld hl, $0397 ; 'The Castle is in an uproar.'
    call StartMessageCommand09HL_B13
    ret

; entry 106 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6A::
Jump_013_538B:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_539A
    ld hl, $0398 ; 'Lady Yuna used to be very'
    call StartMessageCommand09HL_B13
    ret

Jump_013_539A::
    ld hl, $0AD8 ; 'Lady Yuna has regained her usual'
    call StartMessageCommand09HL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6B::
Jump_013_53A1:: ; address name
    ld hl, $0399 ; 'In the east lives an old'
    call StartMessageCommand09HL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6C::
Jump_013_53A8:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53B7
    ld hl, $039A ; 'What happened to Lady Yuna? It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_53B7::
    ld hl, $0DE1 ; 'Seeing the liveliness of Lady Yuna'
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6D::
Jump_013_53BE:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53CD
    ld hl, $039B ; 'Before, Lady Yuna would be up'
    call StartMessageCommand09HL_B13
    ret

Jump_013_53CD::
    ld hl, $0AD9 ; 'Lady Yuna snuck out again. I'm'
    call StartMessageCommand09HL_B13
    ret

; entry 110 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
DispatchTalkEvent_Case04_Case6E::
Jump_013_53D4:: ; address name
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_013_53E1
    ld hl, $0ADA ; 'Oh? How did you get in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_53E1::
    ld hl, $039C ; 'This leads to Lady Yuna's room.'
    call StartMessageCommand09HL_B13
    ret

; entry 111 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wPartyCount, wStepArrived
DispatchTalkEvent_Case04_Case6F::
Jump_013_53E8:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5444
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_543D
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_5436
    ld a, [wSpriteSlots + $B]
    cp a, $50
    jr nz, Jump_013_540E
    ld hl, $039D ; 'You're here to cheer Lady Yuna.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_540E::
    ld a, [wPartyCount]
    cp a, $03
    jr nz, Jump_013_542F
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr nz, Jump_013_5428
    ld hl, Script_5EE6
    call StartScriptAtHL_B13
    ret

Jump_013_5428::
    ld hl, $039E ; 'You're here to cheer Lady Yuna.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_542F::
    ld hl, $039F ; 'You're here to cheer Lady Yuna.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5436::
    ld hl, $03A5 ; 'Many have tried to cheer Lady'
    call StartMessageCommand09HL_B13
    ret

Jump_013_543D::
    ld hl, $0ACD ; 'Lady Yuna locked herself in and'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5444::
    ld hl, $0ADB ; 'How could we ever thank you'
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5EF5: 'King Magnificent! Don't you agree?'
DispatchTalkEvent_Case04_Case70::
Jump_013_544B:: ; address name
    ld hl, Script_5EF5
    call StartScriptAtHL_B13
    ret

; entry 113 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case71::
Jump_013_5452:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5470
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_5469
    ld hl, $03A4 ; 'King Sigh Not even this You'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5469::
    ld hl, $0ACC ; 'King Yuna has locked herself away'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5470::
    ld hl, $0ADC ; 'King Yuna is back to being'
    call StartMessageCommand09HL_B13
    ret

; entry 114 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case04_Case72::
Jump_013_5477:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54C3
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_54BC
    ld de, $009C
    call TestFlagBit
    jr c, Jump_013_54B5
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_549E

Jump_013_5497::
    ld hl, $03A3
    call StartMessageCommand09HL_B13
    ret

Jump_013_549E::
    ld a, $33
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_5497
    ld hl, Script_5FA5
    call StartScriptAtHL_B13
    ret

Jump_013_54B5::
    ld hl, Script_5FAD
    call StartScriptAtHL_B13
    ret

Jump_013_54BC::
    ld hl, $0AD7 ; 'Yuna Their next target is Queen'
    call StartMessageCommand09HL_B13
    ret

Jump_013_54C3::
    ld hl, $0AC5 ; 'Yuna I heard that you saved'
    call StartMessageCommand09HL_B13
    ret

; entry 115 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case73::
Jump_013_54CA:: ; address name
    ld hl, $03A6 ; 'This is the Castle of Estria,'
    call StartMessageCommand09HL_B13
    ret

; entry 116 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case74::
Jump_013_54D1:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54E0
    ld hl, $03A7 ; 'Queen Helen came by a while'
    call StartMessageCommand09HL_B13
    ret

Jump_013_54E0::
    ld hl, $0AC6 ; 'Queen Helen came by the other'
    call StartMessageCommand09HL_B13
    ret

; entry 117 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case75::
Jump_013_54E7:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54F6
    ld hl, $03A8 ; 'The spirit's spring has frozen. The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_54F6::
    ld hl, $0A14 ; 'The warm weather melted the ice'
    call StartMessageCommand09HL_B13
    ret

; entry 118 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case76::
Jump_013_54FD:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_550C
    ld hl, $03A9 ; 'Queen Helen's dreams come true. If'
    call StartMessageCommand09HL_B13
    ret

Jump_013_550C::
    ld hl, $0AC7 ; 'Queen Helen's dreams come true more'
    call StartMessageCommand09HL_B13
    ret

; entry 119 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case77::
Jump_013_5513:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5522
    ld hl, $03AA ; 'Our Queen is a kind person'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5522::
    ld hl, $0DF4 ; 'The Queen's lost her scary look!'
    call StartMessageCommand09HL_B13
    ret

; entry 120 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case78::
Jump_013_5529:: ; address name
    ld hl, $03AB ; 'A teacher from the west lives'
    call StartMessageCommand09HL_B13
    ret

; entry 121 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case79::
Jump_013_5530:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_553F
    ld hl, $03AE ; 'The Queen looks haggard recently. Lack'
    call StartMessageCommand09HL_B13
    ret

Jump_013_553F::
    ld hl, $0A00 ; 'Queen Helen has become healthy.'
    call StartMessageCommand09HL_B13
    ret

; entry 122 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7A::
Jump_013_5546:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5555
    ld hl, $03AD ; 'I heard this on the sly'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5555::
    ld hl, $0AFF ; 'I heard from my sister who'
    call StartMessageCommand09HL_B13
    ret

; entry 123 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7B::
Jump_013_555C:: ; address name
    ld hl, $03AF ; 'Around these parts, there are times'
    call StartMessageCommand09HL_B13
    ret

; entry 124 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hPlayerX
; writes: hTemp0
DispatchTalkEvent_Case04_Case7C::
Jump_013_5563:: ; address name
    ld de, $0097
    call TestFlagBit
    jr c, Jump_013_5596
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5582
    ld hl, $03B0 ; 'This is no place for a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5582::
    ldh a, [hPlayerX]
    cp a, $41
    jr nc, Jump_013_558F
    ld hl, Script_5F26
    call StartScriptAtHL_B13
    ret

Jump_013_558F::
    ld hl, Script_5F38
    call StartScriptAtHL_B13
    ret

Jump_013_5596::
    ld hl, $03B2 ; 'I beg your pardon, please!'
    call StartMessageCommand09HL_B13
    ret

; entry 125 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case04_Case7D::
Jump_013_559D:: ; address name
    ld a, $0C
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5F0B
    call StartScriptAtHL_B13
    ret

; entry 126 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7E::
Jump_013_55AE:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_55BD
    ld hl, $03B4 ; 'A botanist does live here But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_55BD::
    ld hl, $0A15 ; 'The scholar came back finally from'
    call StartMessageCommand09HL_B13
    ret

; entry 127 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5F12: 'I retired as a teacher and'
DispatchTalkEvent_Case04_Case7F::
Jump_013_55C4:: ; address name
    ld hl, Script_5F12
    call StartScriptAtHL_B13
    ret

; entry 128 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5FD6: 'How may our church serve you?'
DispatchTalkEvent_Case04_Case80::
Jump_013_55CB:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5FD6
    call StartScriptAtHL_B13
    ret

; entry 129 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5FE6
DispatchTalkEvent_Case04_Case81::
Jump_013_55D7:: ; address name
    ld hl, Script_5FE6
    call StartScriptAtHL_B13
    ret

; entry 130 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5FD6: 'How may our church serve you?'
DispatchTalkEvent_Case04_Case82::
Jump_013_55DE:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5FD6
    call StartScriptAtHL_B13
    ret

; entry 131 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5FD6: 'How may our church serve you?'
DispatchTalkEvent_Case04_Case83::
Jump_013_55EA:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5FD6
    call StartScriptAtHL_B13
    ret

; entry 132 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case84::
Jump_013_55F6:: ; address name
    ld hl, $0313 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 133 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5F1F: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case85::
Jump_013_55FD:: ; address name
    ld hl, $0312 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 134 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5F1F: 'Welcome to our inn!'
DispatchTalkEvent_Case04_Case86::
Jump_013_5604:: ; address name
    ld hl, Script_5F1F
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 135 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case87::
Jump_013_5610:: ; address name
    ld hl, $03B8 ; 'I want to return to the'
    call StartMessageCommand09HL_B13
    ret

; entry 136 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case88::
Jump_013_5617:: ; address name
    ld hl, $03AC ; 'There is a spring in the'
    call StartMessageCommand09HL_B13
    ret

; entry 137 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case89::
Jump_013_561E:: ; address name
    ld hl, $0396 ; 'It's a mean old world out'
    call StartMessageCommand09HL_B13
    ret

; entry 138 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case8A::
Jump_013_5625:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5643
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_563C
    ld hl, $03B9 ; 'Queen Helen has been suffering from'
    call StartMessageCommand09HL_B13
    ret

Jump_013_563C::
    ld hl, $0AE3 ; 'Queen Helen had been suffering from'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5643::
    ld hl, $0AFB ; 'Queen Helen isn't bedridden by nightmares'
    call StartMessageCommand09HL_B13
    ret

; entry 139 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case8B::
Jump_013_564A:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5659
    ld hl, $0DD6 ; 'Nightmares so horrible that they keep'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5659::
    ld hl, $0AFC ; 'Queen Helen has had a good'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $01E2 set: jr to Jump_013_567E; flag $009D set: jr to Jump_013_5677); when none of them branches, starts message $0DD7 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our hearts are like the skies' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0DD7_OurHeartsAreLike::
Jump_013_5660:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_567E
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5677
    ld hl, $0DD7 ; 'Our hearts are like the skies'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5677::
    ld hl, $0DC9 ; 'How can we save Queen Helen?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_567E::
    ld hl, $0AFD ; 'The skies are clear, but my'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $0DD8, whose string begins 'Queen Helen is wracked by awful'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Talk0DD8_QueenHelenIsWracked::
Jump_013_5685:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_56E8
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_013_56E1
    ld de, $01F1
    call TestFlagBit
    jr c, Jump_013_56DA
    ld de, $009F
    call TestFlagBit
    jr c, Jump_013_56BB
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_56B4

Jump_013_56AD::
    ld hl, $0DD8 ; 'Queen Helen is wracked by awful'
    call StartMessageCommand09HL_B13
    ret

Jump_013_56B4::
    ld hl, $0AE4 ; 'You can't come in here. Queen'
    call StartMessageCommand09HL_B13
    ret

Jump_013_56BB::
    ld de, $009D
    call TestFlagBit
    jr nc, Jump_013_56AD
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_56B4
    ld hl, Script_5FB8
    call StartScriptAtHL_B13
    ret

Jump_013_56DA::
    ld hl, $0AF8 ; 'Quick, give the medicine to our'
    call StartMessageCommand09HL_B13
    ret

Jump_013_56E1::
    ld hl, $0AF9 ; 'Queen Helen is safe for now!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_56E8::
    ld hl, $0AFA ; 'You have restored peace. For this,'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0DD9, whose string begins 'The reception hall is beyond here.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0DD9_TheReceptionHallIs::
Jump_013_56EF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_56FF
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5706

Jump_013_56FF::
    ld hl, $0DD9 ; 'The reception hall is beyond here.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5706::
    ld hl, $0AE5 ; 'The reception hall is past here.'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $01E2 set: jr to Jump_013_572B; flag $009D set: jr to Jump_013_5724); when none of them branches, starts message $0DDA through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our Queen Helen's premonition made it' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0DDA_OurQueenHelensPremonition::
Jump_013_570D:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_572B
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5724
    ld hl, $0DDA ; 'Our Queen Helen's premonition made it'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5724::
    ld hl, $0D1F ; 'How can we help Queen Helen?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_572B::
    ld hl, $0AFE ; 'It has been getting warmer. The'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $01E5 set: jr to Jump_013_5770; flag $01E2 set: jr to Jump_013_5769; flag $01E1 set: jr to Jump_013_575E; flag $01F1 set: jr to Jump_013_5759); when none of them branches, starts message $0DDB through StartMessageCommand09HL_B13 (script command $09); that string begins 'What is it? Leave at once!' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
TalkMsg0DDB_WhatIsItLeave::
Jump_013_5732:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5770
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5769
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_013_575E
    ld de, $01F1
    call TestFlagBit
    jr c, Jump_013_5759
    ld hl, $0DDB ; 'What is it? Leave at once!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5759::
    xor a, a
    ld [wSpriteSlots + $7], a
    ret

Jump_013_575E::
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, Script_5FCB
    call StartScriptAtHL_B13
    ret

Jump_013_5769::
    ld hl, $0AF7 ; 'Helen Thank you so much. Please'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5770::
    ld hl, $0DE0 ; 'Helen I thank you from the'
    call StartMessageCommand09HL_B13
    ret

; entry 145 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case91::
Jump_013_5777:: ; address name
    ld hl, $00FF ; 'Composing'
    call StartMessageCommand09HL_B13
    ret

; entry 146 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case92::
Jump_013_577E:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_578D
    ld hl, $0DDC ; 'This happened when I was deep'
    call StartMessageCommand09HL_B13
    ret

Jump_013_578D::
    ld hl, $0D24 ; 'Now that I think about it,'
    call StartMessageCommand09HL_B13
    ret

; entry 147 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case93::
Jump_013_5794:: ; address name
    ld hl, $0DDD ; 'My father is so cowardly, getting'
    call StartMessageCommand09HL_B13
    ret

; entry 148 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case94::
Jump_013_579B:: ; address name
    ld hl, $0AC0 ; '0 checked the bookshelf. History of'
    call StartMessageCommand09HL_B13
    ret

; entry 150 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case96::
Jump_013_57A2:: ; address name
    ld hl, $0AC1 ; '0 checked the bookshelf. History of'
    call StartMessageCommand09HL_B13
    ret

; entry 151 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5F4A
DispatchTalkEvent_Case04_Case97::
Jump_013_57A9:: ; address name
    ld hl, $0ABC ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 152 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5F4A
DispatchTalkEvent_Case04_Case98::
Jump_013_57B0:: ; address name
    ld hl, Script_5F4A
    call StartScriptAtHL_B13
    ret

; entry 153 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case99::
Jump_013_57B7:: ; address name
    ld de, $009A
    call TestFlagBit
    jr c, Jump_013_57E1
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_57CE
    ld hl, Script_5F4C
    call StartScriptAtHL_B13
    ret

Jump_013_57CE::
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, Jump_013_57DA
    ld hl, Script_5F54
    call StartScriptAtHL_B13
    ret

Jump_013_57DA::
    ld hl, Script_5F6C
    call StartScriptAtHL_B13
    ret

Jump_013_57E1::
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_57F0
    ld hl, Script_5F7D
    call StartScriptAtHL_B13
    ret

Jump_013_57F0::
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, Jump_013_57FC
    ld hl, Script_5F82
    call StartScriptAtHL_B13
    ret

Jump_013_57FC::
    ld hl, Script_5F97
    call StartScriptAtHL_B13
    ret

; entry 154 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
DispatchTalkEvent_Case04_Case9A::
Jump_013_5803:: ; address name
    ld a, [wObject1 + $B]
    cp a, $80
    jr nz, Jump_013_5818
    ld a, [wObject1 + $C]
    cp a, $10
    jr nz, Jump_013_5818
    ld hl, $0ACE ; '0 checked the marionette. It sagged'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5818::
    ld hl, Script_5FAD
    call StartScriptAtHL_B13
    ret

; entry 155 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case9B::
Jump_013_581F:: ; address name
    ld hl, $0A16 ; 'My maid is angry that I'
    call StartMessageCommand09HL_B13
    ret

; entry 156 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case04_Case9C::
Jump_013_5826:: ; address name
    ld de, $009F
    call TestFlagBit
    jr c, Jump_013_5830
    jr Jump_013_5837

Jump_013_5830::
    ld hl, $0AE8 ; '0 checked the blue flower. The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5837::
    call InventoryHasFreeSlotCheck_Bank13
    jr nc, Jump_013_5853
    ld [hl], $34
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $0AE7 ; '0 checked the blue flower. It'
    call StartMessageCommand09HL_B13
    ld de, $009F
    call SetFlagBit
    ret

Jump_013_5853::
    ld hl, $0AE9 ; '0 checked the blue flower. It'
    call StartMessageCommand09HL_B13
    ret

; entry 157 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case04_Case9D::
Jump_013_585A:: ; address name
    ld a, $03
    ld [wScriptParam0], a
    ld a, $00
    ld [wScriptParam1], a
    ld de, $01E0
    call StartMessageScriptDE_B13
    ret

; entry 158 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; starts Script_5FD2
DispatchTalkEvent_Case04_Case9E::
Jump_013_586B:: ; address name
    xor a, a
    ld [wObject2 + $7], a
    ret

; entry 159 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5FD2
DispatchTalkEvent_Case04_Case9F::
Jump_013_5870:: ; address name
    ld hl, Script_5FD2
    call StartScriptAtHL_B13
    ret

; entry 160 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case04_CaseA0::
Jump_013_5877:: ; address name
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_5883
    ld hl, $0D27 ; '0 checked the treasure chest. The'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5883::
    ld [hl], $32
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_5FDD
    call StartScriptAtHL_B13
    ret

; entry 161 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
DispatchTalkEvent_Case04_CaseA1::
Jump_013_5894:: ; address name
    ld a, $32
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_5FD4
    call StartScriptAtHL_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 25, then StartMessageScriptDE_B13 with DE = $01E9: starts message group 1, string $E9; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01E9::
Jump_013_58AB:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $25
    ld [wScriptParam1], a
    ld de, $01E9
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 41, then StartMessageScriptDE_B13 with DE = $01EA: starts message group 1, string $EA; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01EA::
Jump_013_58BC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $41
    ld [wScriptParam1], a
    ld de, $01EA
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 52, then StartMessageScriptDE_B13 with DE = $01EB: starts message group 1, string $EB; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01EB::
Jump_013_58CD:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $01EB
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 17, then StartMessageScriptDE_B13 with DE = $01EC: starts message group 1, string $EC; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01EC::
Jump_013_58DE:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $17
    ld [wScriptParam1], a
    ld de, $01EC
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 23, then StartMessageScriptDE_B13 with DE = $01ED: starts message group 1, string $ED; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01ED::
Jump_013_58EF:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01ED
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 5D, then StartMessageScriptDE_B13 with DE = $01EE: starts message group 1, string $EE; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01EE::
Jump_013_5900:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5D
    ld [wScriptParam1], a
    ld de, $01EE
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 5B, then StartMessageScriptDE_B13 with DE = $01EF: starts message group 1, string $EF; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01EF::
Jump_013_5911:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5B
    ld [wScriptParam1], a
    ld de, $01EF
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 1E, then StartMessageScriptDE_B13 with DE = $01F0: starts message group 1, string $F0; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F0::
Jump_013_5922:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1E
    ld [wScriptParam1], a
    ld de, $01F0
    call StartMessageScriptDE_B13
    ret

; entry 170 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; starts Script_5FC9
DispatchTalkEvent_Case04_CaseAA::
Jump_013_5933:: ; address name
    ld hl, Script_5FC9
    call StartScriptAtHL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
; starts Script_512D
DispatchTalkEvent_Case08::
Jump_013_593A:: ; address name
    ld hl, Script_512D
    call StartScriptAtHL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wTalkEventGroup
DispatchTalkEvent_Case01::
Jump_013_5941:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case01_Case00
    dw DispatchTalkEvent_Case01_Case01
    dw DispatchTalkEvent_Case01_Case02
    dw DispatchTalkEvent_Case01_Case03
    dw DispatchTalkEvent_Case01_Case04
    dw DispatchTalkEvent_Case01_Case05
    dw DispatchTalkEvent_Case01_Case06
    dw DispatchTalkEvent_Case01_Case07
    dw DispatchTalkEvent_Case01_Case08
    dw DispatchTalkEvent_Case01_Case09
    dw DispatchTalkEvent_Case01_Case0A
    dw DispatchTalkEvent_Case01_Case0B
    dw DispatchTalkEvent_Case01_Case0C
    dw DispatchTalkEvent_Case01_Case0D
    dw DispatchTalkEvent_Case01_Case0E
    dw DispatchTalkEvent_Case01_Case0F
    dw DispatchTalkEvent_Case01_Case10
    dw DispatchTalkEvent_Case01_Case11
    dw DispatchTalkEvent_Case01_Case12
    dw DispatchTalkEvent_Case01_Case13
    dw DispatchTalkEvent_Case01_Case14
    dw DispatchTalkEvent_Case01_Case15
    dw DispatchTalkEvent_Case01_Case16
    dw DispatchTalkEvent_Case01_Case17
    dw DispatchTalkEvent_Case01_Case18
    dw DispatchTalkEvent_Case01_Case19
    dw DispatchTalkEvent_Case01_Case1A
    dw DispatchTalkEvent_Case01_Case1B
    dw DispatchTalkEvent_Case01_Case1C
    dw DispatchTalkEvent_Case01_Case1D
    dw DispatchTalkEvent_Case01_Case1E
    dw DispatchTalkEvent_Case01_Case1F
    dw DispatchTalkEvent_Case01_Case20
    dw DispatchTalkEvent_Case01_Case21
    dw DispatchTalkEvent_Case01_Case22
    dw DispatchTalkEvent_Case01_Case23
    dw DispatchTalkEvent_Case01_Case24
    dw DispatchTalkEvent_Case01_Case25
    dw DispatchTalkEvent_Case01_Case26
    dw DispatchTalkEvent_Case01_Case27
    dw DispatchTalkEvent_Case01_Case28
    dw DispatchTalkEvent_Case01_Case29
    dw DispatchTalkEvent_Case01_Case2A
    dw DispatchTalkEvent_Case01_Case2B
    dw DispatchTalkEvent_Case01_Case2C
    dw DispatchTalkEvent_Case01_Case2D
    dw DispatchTalkEvent_Case01_Case2E
    dw DispatchTalkEvent_Case01_Case2F
    dw DispatchTalkEvent_Case01_Case30
    dw DispatchTalkEvent_Case01_Case31
    dw DispatchTalkEvent_Case01_Case32
    dw DispatchTalkEvent_Case01_Case33
    dw DispatchTalkEvent_Case01_Case33
    dw DispatchTalkEvent_Case01_Case33
    dw DispatchTalkEvent_Case01_Case36
    dw DispatchTalkEvent_Case01_Case37
    dw DispatchTalkEvent_Case01_Case38
    dw DispatchTalkEvent_Case01_Case39
    dw DispatchTalkEvent_Case01_Case3A
    dw DispatchTalkEvent_Case01_Case3B
    dw DispatchTalkEvent_Case01_Case3C
    dw DispatchTalkEvent_Case01_Case3D
    dw DispatchTalkEvent_Case01_Case3E
    dw DispatchTalkEvent_Case01_Case3F
    dw DispatchTalkEvent_Case01_Case40
    dw DispatchTalkEvent_Case01_Case41
    dw DispatchTalkEvent_Case01_Case42
    dw DispatchTalkEvent_Case01_Case43
    dw DispatchTalkEvent_Case01_Case44
    dw DispatchTalkEvent_Case01_Case45
    dw DispatchTalkEvent_Case01_Case46
    dw DispatchTalkEvent_Case01_Case47
    dw DispatchTalkEvent_Case01_Case48
    dw DispatchTalkEvent_Case01_Case49
    dw DispatchTalkEvent_Case01_Case4A
    dw DispatchTalkEvent_Case01_Case4B
    dw DispatchTalkEvent_Case01_Case4C
    dw DispatchTalkEvent_Case01_Case4D
    dw DispatchTalkEvent_Case01_Case4E
    dw DispatchTalkEvent_Case01_Case4F
    dw DispatchTalkEvent_Case01_Case50
    dw DispatchTalkEvent_Case01_Case51
    dw DispatchTalkEvent_Case01_Case52
    dw DispatchTalkEvent_Case01_Case53
    dw DispatchTalkEvent_Case01_Case54
    dw DispatchTalkEvent_Case01_Case55
    dw DispatchTalkEvent_Case01_Case56
    dw DispatchTalkEvent_Case01_Case57
    dw DispatchTalkEvent_Case01_Case58
    dw DispatchTalkEvent_Case01_Case59
    dw DispatchTalkEvent_Case01_Case5A
    dw DispatchTalkEvent_Case01_Case5B
    dw DispatchTalkEvent_Case01_Case5C
    dw DispatchTalkEvent_Case01_Case5D
    dw DispatchTalkEvent_Case01_Case5E
    dw DispatchTalkEvent_Case01_Case5F
    dw DispatchTalkEvent_Case01_Case60
    dw DispatchTalkEvent_Case01_Case61
    dw DispatchTalkEvent_Case01_Case62
    dw DispatchTalkEvent_Case01_Case63
    dw DispatchTalkEvent_Case01_Case64
    dw DispatchTalkEvent_Case01_Case65
    dw DispatchTalkEvent_Case01_Case66
    dw DispatchTalkEvent_Case01_Case67
    dw DispatchTalkEvent_Case01_Case68
    dw DispatchTalkEvent_Case01_Case69
    dw DispatchTalkEvent_Case01_Case6A
    dw DispatchTalkEvent_Case01_Case6B
    dw DispatchTalkEvent_Case01_Case6C
    dw DispatchTalkEvent_Case01_Case6D
    dw DispatchTalkEvent_Case01_Case6E
    dw DispatchTalkEvent_Case01_Case6F
    dw DispatchTalkEvent_Case01_Case70
    dw DispatchTalkEvent_Case01_Case71
    dw DispatchTalkEvent_Case01_Case72
    dw DispatchTalkEvent_Case01_Case73
    dw DispatchTalkEvent_Case01_Case74
    dw DispatchTalkEvent_Case01_Case75
    dw DispatchTalkEvent_Case01_Case76
    dw DispatchTalkEvent_Case01_Case77
    dw DispatchTalkEvent_Case01_Case78
    dw DispatchTalkEvent_Case01_Case79
    dw DispatchTalkEvent_Case01_Case7A
    dw DispatchTalkEvent_Case01_Case7B
    dw DispatchTalkEvent_Case01_Case7C
    dw DispatchTalkEvent_Case01_Case7D
    dw DispatchTalkEvent_Case01_Case7E
    dw DispatchTalkEvent_Case01_Case7F
    dw DispatchTalkEvent_Case01_Case80
    dw TalkMsg0A3C_KingIfYouSee
    dw TalkMsg0A3E_YoureFreeToGo
    dw TalkMsg0A3F_TheKingAndPrinces
    dw Talk0A41_ThisIsGreatLogCastle
    dw DispatchTalkEvent_Case01_Case85
    dw DispatchTalkEvent_Case01_Case86
    dw DispatchTalkEvent_Case01_Case87
    dw DispatchTalkEvent_Case01_Case88
    dw Talk0A49_BreedingCouldResultIn
    dw TalkMsg0A4A_FromUpHerePeople
    dw Msg0126_WarubouThereYourPartys
    dw TalkMsg0A4C_GreatLogCastleWasMade
    dw TalkMsg0A4D_TheIslandUsedTo
    dw Talk04BA_IfYouGetAn
    dw Talk04CB_ThatKeyIUsed
    dw Talk04CE_HeroCheckedTheShelf
    dw DispatchTalkEvent_Case01_Case91
    dw DispatchTalkEvent_Case01_Case92
    dw DispatchTalkEvent_Case01_Case93
    dw DispatchTalkEvent_Case01_Case94
    dw DispatchTalkEvent_Case01_Case95
    dw DispatchTalkEvent_Case01_Case95
    dw DispatchTalkEvent_Case01_Case95
    dw TalkMsg0504_IfTheIslandSink
    dw TalkMsg0512_KamehaYo0Thanks
    dw Msg011B_HmAreYouA
    dw Msg011C_OhHiGoodTo
    dw Talk04C0_AllRightyWellDo
    dw Talk0276_IfYouWantTo
    dw StartScript5709Or56F5IfFlagD1
    dw DispatchTalkEvent_Case01_Case9F
    dw DispatchTalkEvent_Case01_CaseA0
    dw DispatchTalkEvent_Case01_CaseA1
    dw DispatchTalkEvent_Case01_CaseA2
    dw DispatchTalkEvent_Case01_CaseA3
    dw DispatchTalkEvent_Case01_CaseA4
    dw DispatchTalkEvent_Case01_CaseA5
    dw DispatchTalkEvent_Case01_CaseA6
    dw DispatchTalkEvent_Case01_CaseA7
    dw DispatchTalkEvent_Case01_CaseA8
    dw Talk0043_HeroCheckedTheOdd
    dw Talk0036_ThereWereManyWild
    dw Talk0037_HeroTriedToOpen
    dw StartScript5660WithBank0E
    dw TalkMsg0268_YepShesTakingGood
    dw DispatchTalkEvent_Case01_CaseAE
    dw DispatchTalkEvent_Case01_CaseAF
    dw DispatchTalkEvent_Case01_CaseB0
    dw DispatchTalkEvent_Case01_CaseB1
    dw DispatchTalkEvent_Case01_CaseB2
    dw DispatchTalkEvent_Case01_CaseB3
    dw DispatchTalkEvent_Case01_CaseB4
    dw DispatchTalkEvent_Case01_CaseB5
    dw DispatchTalkEvent_Case01_CaseB6
    dw Talk08D1_TheEvaluatorSaidI
    dw Talk04D2_UpAheadIsThe
    dw TalkMsg021F_DoYouKnowAbout
    dw TalkMsg0220_InOtherWorldsYoull
    dw TalkMsg027F_ItsNotEasyTo
    dw TalkMsg0280_MamaIsABig
    dw DispatchTalkEvent_Case01_CaseBD
    dw DispatchTalkEvent_Case01_CaseBE
    dw DispatchTalkEvent_Case01_CaseBF
    dw DispatchTalkEvent_Case01_CaseC0
    dw DispatchTalkEvent_Case01_CaseC1
    dw DispatchTalkEvent_Case01_CaseC2
    dw DispatchTalkEvent_Case01_CaseC3
    dw DispatchTalkEvent_Case01_CaseC4
    dw DispatchTalkEvent_Case01_CaseC5
    dw DispatchTalkEvent_Case01_CaseC6
    dw DispatchTalkEvent_Case01_CaseC7
    dw DispatchTalkEvent_Case01_CaseC8
    dw DispatchTalkEvent_Case01_CaseC9
    dw DispatchTalkEvent_Case01_CaseCA
    dw DispatchTalkEvent_Case01_CaseCB
    dw DispatchTalkEvent_Case01_CaseCC
    dw DispatchTalkEvent_Case01_CaseCD
    dw DispatchTalkEvent_Case01_CaseCE
    dw Talk00FC_YouHaveToEat
    dw TalkMsg0A74_TheMedalMasterWas
    dw IfFlag0023StartScript57A2
    dw Msg013C_ISawALake
    dw Msg013D_StrongMonstersAreIn
    dw TalkMsg0A35_ImABugSo
    dw DispatchTalkEvent_Case01_CaseD5
    dw TalkMsg0A68_MyEmyuIsVery
    dw TalkMsg0A6B_MonstersLookSoFrightening
    dw Talk0A40_PleaseEnterTheKing
    dw TalkMsg0A4B_OnTheHorizonYou
    dw DispatchTalkEvent_Case01_CaseDA
    dw DispatchTalkEvent_Case01_CaseDB
    dw DispatchTalkEvent_Case01_CaseDC
    dw DispatchTalkEvent_Case01_CaseDD
    dw DispatchTalkEvent_Case01_CaseDE
    dw DispatchTalkEvent_Case01_CaseDF
    dw DispatchTalkEvent_Case01_CaseE0
    dw DispatchTalkEvent_Case01_CaseE1
    dw DispatchTalkEvent_Case01_CaseE2
    dw DispatchTalkEvent_Case01_CaseE3
    dw DispatchTalkEvent_Case01_CaseE4
    dw DispatchTalkEvent_Case01_CaseE5
    dw DispatchTalkEvent_Case01_CaseE6
    dw DispatchTalkEvent_Case01_CaseE7
    dw $0000 ; unused index (E-0207)
    dw TalkMsg029B_IFoundAKey
    dw Talk0DE3_TheSeaIsHuge
    dw TalkMsg0220_InOtherWorldsYoull_7DC5
    dw Msg013E_OurKingHasBeen
    dw Msg013F_TheCircusMasterWas
    dw DispatchTalkEvent_Case01_CaseEE
    dw $0000 ; unused index (E-0207)
    dw Talk0B56_WhenYouBreedMonsters
    dw Talk0B6D_BreedingFireAndIce
    dw Talk0D90_HumphImTerry
    dw SetWCB8A30IfFlag25AndCountAtLeast50
    dw SetFlagsC9AndCAFrom32And33
    dw SetFlagsCBAndCCFrom35And36
    dw IfFlag0021StartScript5988

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5895
DispatchTalkEvent_Case01_Case00::
Jump_013_5B33:: ; address name
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5895
DispatchTalkEvent_Case01_Case01::
Jump_013_5B34:: ; address name
    ld hl, Script_5895
    call StartScriptAtHL_B13
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
DispatchTalkEvent_Case01_Case02::
Jump_013_5B3B:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5BDF
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_5BD8
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_5BD6
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_5BD4
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_5BD0
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_5BB3
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5B8D
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5B86
    ld hl, Script_4FA4
    call StartScriptAtHL_B13
    ret

Jump_013_5B86::
    ld hl, $0022 ; 'Go to the Vault and pick'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5B8D::
    ld de, $000D
    call TestFlagBit
    jr c, Jump_013_5BAC
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, Script_4FAF
    call StartScriptAtHL_B13
    ld de, $000D
    call SetFlagBit
    ret

Jump_013_5BAC::
    ld hl, $006C ; 'You can go out, but not'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5BB3::
    ld de, $01A7
    call TestFlagBit
    jr c, Jump_013_5BC0
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_5BC7

Jump_013_5BC0::
    ld hl, $0102 ; 'It's a beautiful day for laundry!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5BC7::
    ld [hl], $01
    ld hl, Script_5175
    call StartScriptAtHL_B13
    ret

Jump_013_5BD0::
    call DispatchTalkEvent_Case01_Case02_Sub01
    ret

Jump_013_5BD4::
    jr Jump_013_5BD0

Jump_013_5BD6::
    jr Jump_013_5BD0

Jump_013_5BD8::
    ld hl, $0500 ; '0 There have been frequent earthquakes'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5BDF::
    ld de, $018A
    call TestFlagBit
    jr c, Jump_013_5C04
    ld de, $0180
    call TestFlagBit
    jr nc, Jump_013_5C04
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_5C04
    ld hl, $0D91 ; '0, you were so busy saving'
    call StartMessageCommand09HL_B13
    ld de, $018A
    call SetFlagBit
    ret

Jump_013_5C04::
    ld hl, $0B00 ; 'The weather is beautiful again. If'
    call StartMessageCommand09HL_B13
    ret

; only called from DispatchTalkEvent_Case01_Case02 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case01_Case02)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case01_Case02_Sub01::
Func_013_5C0B:: ; address name
    ld de, $0182
    call TestFlagBit
    jr c, Jump_013_5C6D
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_5C60
    ld de, $0180
    call TestFlagBit
    jr c, Jump_013_5C36
    ld hl, Script_517F
    call StartScriptAtHL_B13
    ld de, $0104
    call SetFlagBit
    ld de, $0180
    call SetFlagBit
    ret

Jump_013_5C36::
    ld a, $02
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5C4D
    ld hl, $0202 ; 'Buy LoveWater for me, OK?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5C4D::
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_522B
    call StartScriptAtHL_B13
    ld de, $0181
    call SetFlagBit
    ret

Jump_013_5C60::
    ld hl, $0214 ; 'I'll get you to run more'
    call StartMessageCommand09HL_B13
    ld de, $0182
    call SetFlagBit
    ret

Jump_013_5C6D::
    ld de, $0184
    call TestFlagBit
    jr c, Jump_013_5CA8
    ld de, $0183
    call TestFlagBit
    jr c, Jump_013_5C84
    ld hl, Script_5189
    call StartScriptAtHL_B13
    ret

Jump_013_5C84::
    ld a, $04
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5C9B
    ld hl, $08A5 ; 'I need you to get me'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5C9B::
    ld hl, Script_519F
    call StartScriptAtHL_B13
    farcall RemoveInventorySlotShiftDown
    ret

Jump_013_5CA8::
    ld de, $0186
    call TestFlagBit
    jr c, Jump_013_5CE3
    ld de, $0185
    call TestFlagBit
    jr c, Jump_013_5CBF
    ld hl, Script_51A9
    call StartScriptAtHL_B13
    ret

Jump_013_5CBF::
    ld a, $1B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5CD6
    ld hl, $08AA ; 'I want you to buy me'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5CD6::
    ld hl, Script_51BF
    call StartScriptAtHL_B13
    farcall RemoveInventorySlotShiftDown
    ret

Jump_013_5CE3::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5CF2
    ld hl, $0205 ; 'I don't need any help today,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5CF2::
    ld de, $018C
    call TestFlagBit
    jr c, Jump_013_5D3C
    ld de, $018B
    call TestFlagBit
    jr c, Jump_013_5D18
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5D11
    ld hl, Script_51F5
    call StartScriptAtHL_B13
    ret

Jump_013_5D11::
    ld hl, Script_520B
    call StartScriptAtHL_B13
    ret

Jump_013_5D18::
    ld a, $1C
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5D2F
    ld hl, $0A27 ; 'Buy some Sirloin for our dinner.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5D2F::
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_5221
    call StartScriptAtHL_B13
    ret

Jump_013_5D3C::
    ld hl, $0A2A ; 'I don't have any errands right'
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case03::
Jump_013_5D43:: ; address name
    ld hl, $0023 ; '0 checked the bookshelf. Behavior of'
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case04::
Jump_013_5D4A:: ; address name
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5D59
    ld hl, $001B ; 'This hay is pretty good. Maybe'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5D59::
    ld de, $012A
    call TestFlagBit
    jr c, Jump_013_5D68
    ld hl, Script_596B
    call StartScriptAtHL_B13
    ret

Jump_013_5D68::
    ld hl, Script_597B
    call StartScriptAtHL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case05::
Jump_013_5D6F:: ; address name
    ld hl, $0026 ; '0 checked the oven. It smelled'
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case06::
Jump_013_5D76:: ; address name
    ld hl, $0027 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, hTemp1, hTemp0
DispatchTalkEvent_Case01_Case07::
Jump_013_5D7D:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5E7A
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_5E73
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_5E6C
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_5E68
    ld de, $0021
    call TestFlagBit
    jp c, Jump_013_5E61
    ld de, $0002
    call TestFlagBit
    jp c, Jump_013_5E14
    ld de, $000E
    call TestFlagBit
    jr c, Jump_013_5E0D
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5DF7
    ld de, $0014
    call TestFlagBit
    jr c, Jump_013_5DF0
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5DDA
    ld hl, $0016 ; 'It seems to me that the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5DDA::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5DE9
    ld hl, Script_4FB7
    call StartScriptAtHL_B13
    ret

Jump_013_5DE9::
    ld hl, Script_4FD0
    call StartScriptAtHL_B13
    ret

Jump_013_5DF0::
    ld hl, $002E ; 'Go help your mother now.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5DF7::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5E06
    ld hl, Script_4FE8
    call StartScriptAtHL_B13
    ret

Jump_013_5E06::
    ld hl, Script_4FF7
    call StartScriptAtHL_B13
    ret

Jump_013_5E0D::
    ld hl, $0064 ; 'The island's sinking, right. Not you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E14::
    ld de, $0100
    call TestFlagBit
    jr c, Jump_013_5E37
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_5E28
    ld hl, $0107 ; 'To win the trust of monsters,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E28::
    ld [hl], $1A
    ld hl, Script_52DC
    call StartScriptAtHL_B13
    ld de, $0100
    call SetFlagBit
    ret

Jump_013_5E37::
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_013_5E45
    ld hl, $0107 ; 'To win the trust of monsters,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E45::
    ld de, $0101
    call TestFlagBit
    jr c, Jump_013_5E5A
    ld hl, $0108 ; 'It looks like you e become'
    call StartMessageCommand09HL_B13
    ld de, $0101
    call SetFlagBit
    ret

Jump_013_5E5A::
    ld hl, $0109 ; 'Your monsters are your friends who'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E61::
    ld hl, $0204 ; 'A bridge to the island there'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E68::
    call DispatchTalkEvent_Case01_Case07_Sub01
    ret

Jump_013_5E6C::
    ld hl, $0A2B ; 'MadGopher helped me excavate. Look at'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E73::
    ld hl, $0501 ; 'People have been whispering that GreatLog'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E7A::
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jp nz, Jump_013_5EE7
    ldh a, [hTemp0]
    cp a, $14
    jr nc, Jump_013_5E93
    ld hl, $0B01 ; 'You and your monsters saved GreatLog'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E93::
    cp a, $1E
    jr nc, Jump_013_5E9E
    ld hl, $0DE7 ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E9E::
    cp a, $28
    jr nc, Jump_013_5EA9
    ld hl, $0DE8 ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EA9::
    cp a, $32
    jr nc, Jump_013_5EB4
    ld hl, $0DE9 ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EB4::
    cp a, $64
    jr nc, Jump_013_5EBF
    ld hl, $0DEA ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EBF::
    cp a, $96
    jr nc, Jump_013_5ECA
    ld hl, $0DEB ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5ECA::
    cp a, $C8
    jr nc, Jump_013_5ED5
    ld hl, $0DEC ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5ED5::
    cp a, $FA
    jr nc, Jump_013_5EE0
    ld hl, $0DED ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EE0::
    ld hl, $0DEE ; 'Hey, 0! You e befriended a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EE7::
    ldh a, [hTemp0]
    cp a, $38
    jr c, Jump_013_5EE0
    ld hl, $0DEF ; 'Congratulations, 0! You e cataloged every'
    call StartMessageCommand09HL_B13
    ret

; only called from DispatchTalkEvent_Case01_Case07 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case01_Case07)
; reads: hTemp0, wPartyCount, wInventory
; writes: hTemp0, hTemp1
DispatchTalkEvent_Case01_Case07_Sub01::
Func_013_5EF4:: ; address name
    ld de, $0191
    call TestFlagBit
    jp c, Jump_013_5F5C
    ld de, $0190
    call TestFlagBit
    jr c, Jump_013_5F0C
    ld hl, Script_52E3
    call StartScriptAtHL_B13
    ret

Jump_013_5F0C::
    ld hl, $005A
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5F28
    ld hl, Script_52E3
    call StartScriptAtHL_B13
    ret

Jump_013_5F28::
    ld a, [wPartyCount]
    dec a
    jr z, Jump_013_5F55
    ld de, $0134
    call TestFlagBit
    jr c, Jump_013_5F4E
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_013_5F47
    or a, a
    jr z, Jump_013_5F47
    ld hl, Script_530D
    call StartScriptAtHL_B13
    ret

Jump_013_5F47::
    ld hl, Script_5324
    call StartScriptAtHL_B13
    ret

Jump_013_5F4E::
    ld hl, Script_52F3
    call StartScriptAtHL_B13
    ret

Jump_013_5F55::
    ld hl, $08B2 ; 'A MadGopher joined you? Could you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5F5C::
    ld hl, $08B6 ; 'MadGopher's been a great help. The'
    call StartMessageCommand09HL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case08::
Jump_013_5F63:: ; address name
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5F87
    ld de, $0004
    call TestFlagBit
    jr c, Jump_013_5F80
    ld hl, $0017 ; 'Yo, did you enjoy the voyage?'
    call StartMessageCommand09HL_B13
    ld de, $0004
    call SetFlagBit
    ret

Jump_013_5F80::
    ld hl, $0018 ; 'Slash If you're in need of'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5F87::
    ld hl, $0065 ; 'Slash The island's going to sink?'
    call StartMessageCommand09HL_B13
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case09::
Jump_013_5F8E:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5FCB
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_5FC4
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5FBD
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5FB6
    ld hl, $0019 ; 'There aren't many friends here. It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FB6::
    ld hl, $002F ; 'If some monster masters keep their'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FBD::
    ld hl, $0066 ; 'This island is going to sink?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FC4::
    ld hl, $010A ; 'Off to another world! There are'
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FCB::
    ld hl, $0B08 ; 'The items you find in other'
    call StartMessageCommand09HL_B13
    ret

; entry 10 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case0A::
Jump_013_5FD2:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6041
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_603A
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6033
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_602C
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6025
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6009
    ld hl, $0032 ; 'Hello, there! You must be the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6009::
    ld de, $0010
    call TestFlagBit
    jr c, Jump_013_601E
    ld hl, $0068 ; 'Huh? The island is going to'
    call StartMessageCommand09HL_B13
    ld de, $0010
    call SetFlagBit
    ret

Jump_013_601E::
    ld hl, $0069 ; 'Prince Kameha was saying the same'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6025::
    ld hl, $010C ; 'Oh, that's cute! Hahahahaha! We have'
    call StartMessageCommand09HL_B13
    ret

Jump_013_602C::
    ld hl, $020B ; 'Take the ladder up ahead to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6033::
    ld hl, $0505 ; 'People have been saying that they'
    call StartMessageCommand09HL_B13
    ret

Jump_013_603A::
    ld hl, $053F ; 'I don't think I was anywhere'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6041::
    ld hl, $0B0D ; 'Hello, GreatLog's mighty hero! Are you'
    call StartMessageCommand09HL_B13
    ret

; entry 11 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case0B::
Jump_013_6048:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_60A8
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_60A1
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_609A
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6093
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6086
    ld de, $0007
    call TestFlagBit
    jr c, Jump_013_607F
    ld hl, $003C ; 'You're the kids from the new'
    call StartMessageCommand09HL_B13
    ret

Jump_013_607F::
    ld hl, Script_4F66
    call StartScriptAtHL_B13
    ret

Jump_013_6086::
    ld hl, $0073 ; 'Hm? Warubou wants you to find'
    call StartMessageCommand09HL_B13
    ld de, $000F
    call SetFlagBit
    ret

Jump_013_6093::
    ld hl, $011B ; 'Hm? Are you a master hopeful?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_609A::
    ld hl, $0D0D ; 'While I was on the way'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60A1::
    ld hl, $0D30 ; 'What if the island sinks, and'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60A8::
    ld hl, $0D88 ; 'I teased you as a cute'
    call StartMessageCommand09HL_B13
    ret

; entry 12 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case0C::
Jump_013_60AF:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6109
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_6102
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_60FB
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_60F4
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_60ED
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_60E6
    ld hl, $0040 ; 'On this island, every day goes'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60E6::
    ld hl, $0072 ; 'This island is sinking? If that's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60ED::
    ld hl, $011A ; 'Even the most ordinary of days'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60F4::
    ld hl, $08CE ; 'Many trees have submerged The island'
    call StartMessageCommand09HL_B13
    ret

Jump_013_60FB::
    ld hl, $050C ; 'My beloved island is sinking But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6102::
    ld hl, $0541 ; 'I hate myself for not doing'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6109::
    ld hl, $0B11 ; 'When you're traveling, you can experience'
    call StartMessageCommand09HL_B13
    ret

; entry 13 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case01_Case0D::
Jump_013_6110:: ; address name
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_6116
    ret

Jump_013_6116::
    ld [hl], $2C
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $00FD ; 'Hey, that's mine! 0 obtained a'
    call StartMessageCommand09HL_B13
    ret

; entry 14 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case0E::
Jump_013_6127:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6163
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_615C
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6155
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_614E
    ld hl, $0034 ; 'The horrid Prince and that elemental'
    call StartMessageCommand09HL_B13
    ret

Jump_013_614E::
    ld hl, $0074 ; 'You're after a monster master? I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6155::
    ld hl, $0114 ; 'I haven't seen Prince Kameha or'
    call StartMessageCommand09HL_B13
    ret

Jump_013_615C::
    ld hl, $020C ; 'The castle is in an uproar'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6163::
    ld hl, $0B19 ; 'Prince Kameha is in training to'
    call StartMessageCommand09HL_B13
    ret

; entry 15 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case0F::
Jump_013_616A:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6188
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6181
    ld hl, $020F ; 'There are some items that can'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6181::
    ld hl, $0507 ; 'Prince Kameha came back! What with'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6188::
    ld hl, $0B18 ; 'GreatLog's shops buy and sell items'
    call StartMessageCommand09HL_B13
    ret

; entry 16 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScreenTableIndex, wDataBank
DispatchTalkEvent_Case01_Case10::
Jump_013_618F:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_61FD
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_61F6
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_61DA
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_61B6
    ld hl, $003A ; 'That weird ape thing is Warubou,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_61B6::
    ld de, $0011
    call TestFlagBit
    jr c, Jump_013_61D3
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld hl, $0077 ; 'The island's sinking? That's hard to'
    call StartMessageCommand09HL_B13
    ld de, $0011
    call SetFlagBit
    ret

Jump_013_61D3::
    ld hl, $0078 ; 'It's pointless if you're dead. I'm'
    call StartMessageCommand09HL_B13
    ret

Jump_013_61DA::
    ld de, $010B
    call TestFlagBit
    jr c, Jump_013_61EF
    ld hl, $08C1 ; 'Hey! You're the kid who said'
    call StartMessageCommand09HL_B13
    ld de, $010B
    call SetFlagBit
    ret

Jump_013_61EF::
    ld hl, $08C2 ; 'I have nothing for a liar!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_61F6::
    ld hl, $0506 ; 'Hey! You're the kid who said'
    call StartMessageCommand09HL_B13
    ret

Jump_013_61FD::
    ld a, $02
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, $012C
    call TestFlagBit
    jr c, Jump_013_6216
    ld hl, Script_57ED
    call StartScriptAtHL_B13
    ret

Jump_013_6216::
    ld hl, Script_57F7
    call StartScriptAtHL_B13
    ret

; entry 17 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case01_Case11::
Jump_013_621D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_628A
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6252
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_624B
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6244
    ld hl, $0035 ; 'The King is too lenient on'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6244::
    ld hl, $0075 ; 'The island's going to sink? Don't'
    call StartMessageCommand09HL_B13
    ret

Jump_013_624B::
    ld hl, $0115 ; 'I am a dealer- a merchant'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6252::
    ld de, $0106
    call TestFlagBit
    jr c, Jump_013_6279
    ld de, $0104
    call TestFlagBit
    jr nc, Jump_013_624B
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_533E
    call StartScriptAtHL_B13
    ld de, $0106
    call SetFlagBit
    ret

Jump_013_6279::
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5345
    call StartScriptAtHL_B13
    ret

Jump_013_628A::
    ld de, $00CE
    call TestFlagBit
    jr c, Jump_013_6279
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_534C
    call StartScriptAtHL_B13
    ld de, $00CE
    call SetFlagBit
    ret

; entry 18 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case12::
Jump_013_62A9:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_62F4
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_62ED
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_62E6
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_62DF
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_62D8
    ld hl, $003B ; 'This palm tree is GreatLog. We'
    call StartMessageCommand09HL_B13
    ret

Jump_013_62D8::
    ld hl, $006D ; 'The island's going to sink? I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_62DF::
    ld hl, $0116 ; 'You have such cute monsters! Are'
    call StartMessageCommand09HL_B13
    ret

Jump_013_62E6::
    ld hl, $0D0E ; 'You're really trying to become a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_62ED::
    ld hl, $0540 ; 'Oh, wow! You're really famous!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_62F4::
    ld hl, $0B0F ; 'Have you found another world that'
    call StartMessageCommand09HL_B13
    ret

; entry 19 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case13::
Jump_013_62FB:: ; address name
    ld hl, $0038 ; '0 peered into the vase. A'
    call StartMessageCommand09HL_B13
    ret

; entry 20 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case14::
Jump_013_6302:: ; address name
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6320
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6319
    ld hl, $0041 ; 'Warubou is the island's spirit. So'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6319::
    ld hl, $0070 ; 'The island isn't sinking. If you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6320::
    ld hl, $0119 ; 'Monster masters are people who can'
    call StartMessageCommand09HL_B13
    ret

; entry 21 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case15::
Jump_013_6327:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6390
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_6389
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6382
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_637B
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6374
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_636D
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6366
    ld hl, $003D ; 'We live inside here. I'm keeping'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6366::
    ld hl, $006E ; 'The island is sinking? Prince Kameha'
    call StartMessageCommand09HL_B13
    ret

Jump_013_636D::
    ld hl, $0117 ; 'I haven't seen Prince Kameha or'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6374::
    ld hl, $0210 ; 'Oh, my Where did the shop'
    call StartMessageCommand09HL_B13
    ret

Jump_013_637B::
    ld hl, $08C3 ; 'To take off an accessory, just'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6382::
    ld hl, $0508 ; 'Hi! Have you heard? GreatLog is'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6389::
    ld hl, $0542 ; 'I'm sorry for doubting you. I'll'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6390::
    ld hl, $0B1A ; 'I heard that you're the hero!'
    call StartMessageCommand09HL_B13
    ret

; entry 22 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case16::
Jump_013_6397:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6400
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_63F9
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_63F2
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_63EB
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_63E4
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_63DD
    ld de, $000A
    call TestFlagBit
    jr c, Jump_013_63D6
    ld hl, $003F ; 'Inside the well is the Log's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63D6::
    ld hl, $0052 ; 'Oh my, the well isn't safe!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63DD::
    ld hl, $006F ; 'Oh, you kids! You shouldn't be'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63E4::
    ld hl, $0118 ; 'Warubou has gone down the well'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63EB::
    ld hl, $0211 ; 'I hear rumors that Prince Kameha'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63F2::
    ld hl, $08C4 ; 'The woman next to me, she'
    call StartMessageCommand09HL_B13
    ret

Jump_013_63F9::
    ld hl, $0509 ; 'My neighbor is buying all sorts'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6400::
    ld hl, $0B1B ; 'The woman next to me cries'
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX
; writes: hTemp0, wObject5
DispatchTalkEvent_Case01_Case17::
Jump_013_6407:: ; address name
    ld de, $0009
    call TestFlagBit
    jr c, Jump_013_641C
    ld hl, $004A ; 'I'm Warubou, GreatLog's spirit! Warooh, wa-hey!'
    call StartMessageCommand09HL_B13
    ld de, $0009
    call SetFlagBit
    ret

Jump_013_641C::
    ld de, $0008
    call TestFlagBit
    jr c, Jump_013_6438
    ldh a, [hMapScreenX]
    cp a, $02
    jr z, Jump_013_6431

Jump_013_642A::
    ld hl, $004B ; 'Warubou It's a dead end, warooh!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6431::
    ld hl, $004F ; 'Warubou Wa-hey! Give me something! Then,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6438::
    ldh a, [hMapScreenX]
    cp a, $02
    jr nz, Jump_013_642A
    ld hl, Script_4F8D
    call StartScriptAtHL_B13
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $50
    ld [wObject5 + $5], a
    ld de, $000A
    call SetFlagBit
    ret

; entry 24 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case18::
Jump_013_645F:: ; address name
    ld de, $0008
    call TestFlagBit
    jr c, Jump_013_6474
    ld hl, $0048 ; 'I'm Prince Kameha of GreatLog! You'
    call StartMessageCommand09HL_B13
    ld de, $0008
    call SetFlagBit
    ret

Jump_013_6474::
    ld hl, $0049 ; 'Kameha Wahahah! No going by me!'
    call StartMessageCommand09HL_B13
    ret

; entry 25 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveByte32, hTemp1, hTemp0
; writes: hTemp0
DispatchTalkEvent_Case01_Case19::
Jump_013_647B:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_659E
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_6577
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_6553
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_652F
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6504
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $001A
    call TestFlagBit
    jr c, Jump_013_64F6
    ld de, $000D
    call TestFlagBit
    jr nc, Jump_013_64CF
    ld de, $000F
    call TestFlagBit
    jr nc, Jump_013_64CF
    ld de, $0011
    call TestFlagBit
    jr c, Jump_013_64D6

Jump_013_64CF::
    ld hl, $005F ; 'Warubou A new plug for the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_64D6::
    ld a, $02
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, $0016
    call TestFlagBit
    jr c, Jump_013_64EF
    ld hl, Script_5006
    call StartScriptAtHL_B13
    ret

Jump_013_64EF::
    ld hl, Script_5029
    call StartScriptAtHL_B13
    ret

Jump_013_64F6::
    ld hl, $0082 ; 'Warubou Wa-hey! I trust you! Go!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_64FD::
    ld hl, Script_536E
    call StartScriptAtHL_B13
    ret

Jump_013_6504::
    ld de, $01A0
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $012F
    call TestFlagBit
    jr c, Jump_013_651B
    ld hl, $029E ; 'Warubou Wa-hey! This time, you'll have'
    call StartMessageCommand09HL_B13
    ret

Jump_013_651B::
    ld hl, $02A4 ; 'Warubou Wa-hey, 0 you're slow! Kameha'
    call StartMessageCommand09HL_B13
    ld de, $01A0
    call SetFlagBit
    ret
    db $21, $7B, $53, $CD, $49, $40, $C9

Jump_013_652F::
    ld de, $01A1
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $0135
    call TestFlagBit
    jr c, Jump_013_6546
    ld hl, $0D1A ; 'Warubou Wa-hey, find another Magic Key'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6546::
    ld hl, $0D1B ; 'Warubou Wa-hey, 0! Too slow! Kameha'
    call StartMessageCommand09HL_B13
    ld de, $01A1
    call SetFlagBit
    ret

Jump_013_6553::
    ld de, $01A2
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_656A
    ld hl, $0D2A ; 'Warubou Wa-hey, find another Magic Key'
    call StartMessageCommand09HL_B13
    ret

Jump_013_656A::
    ld hl, $0D2B ; 'Warubou Wa-hey, 0! You have the'
    call StartMessageCommand09HL_B13
    ld de, $01A2
    call SetFlagBit
    ret

Jump_013_6577::
    ld de, $013B
    call TestFlagBit
    jr c, Jump_013_6597
    ld a, [wSaveByte32]
    or a, a
    jr z, Jump_013_6590
    cp a, $FF
    jr z, Jump_013_6590
    ld hl, Script_53AD
    call StartScriptAtHL_B13
    ret

Jump_013_6590::
    ld hl, Script_53BA
    call StartScriptAtHL_B13
    ret

Jump_013_6597::
    ld hl, $0532 ; 'Warubou Wa-hey, you have to find'
    call StartMessageCommand09HL_B13
    ret

Jump_013_659E::
    ld de, $002A
    call TestFlagBit
    jr c, Jump_013_65DE
    ld de, $002B
    call TestFlagBit
    jr c, Jump_013_65E5
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr z, Jump_013_65CA
    cp a, $01
    jr nz, Jump_013_65C3
    ldh a, [hTemp0]
    cp a, $22
    jr c, Jump_013_65D0

Jump_013_65C3::
    ld hl, Script_53D0
    call StartScriptAtHL_B13
    ret

Jump_013_65CA::
    ldh a, [hTemp0]
    cp a, $FA
    jr c, Jump_013_65D7

Jump_013_65D0::
    ld hl, Script_53CE
    call StartScriptAtHL_B13
    ret

Jump_013_65D7::
    ld hl, $0B26 ; 'Warubou Wa-hey! How are you? Still'
    call StartMessageCommand09HL_B13
    ret

Jump_013_65DE::
    ld hl, $0B2D ; 'Warubou Wa-hey, the bond between human'
    call StartMessageCommand09HL_B13
    ret

Jump_013_65E5::
    ld hl, $0BA8 ; 'Petibou It's sort of boring guarding'
    call StartMessageCommand09HL_B13
    ret

; entry 26 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1A::
Jump_013_65EC:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6646
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6621
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_661A
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6613
    ld hl, $001A ; 'I accidentally went outside. People gave'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6613::
    ld hl, $0067 ; 'We're going to sink? I can't'
    call StartMessageCommand09HL_B13
    ret

Jump_013_661A::
    ld hl, $010B ; 'A tropical isle is too hot'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6621::
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_6630
    ld hl, $0203 ; 'I was taking a nap in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6630::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_663F
    ld hl, $0215 ; 'Aooh, LoveWater soothes sunburn'
    call StartMessageCommand09HL_B13
    ret

Jump_013_663F::
    ld hl, $08AE ; 'My father was a Slime and'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6646::
    ld hl, $0B04 ; 'I heard about a world of'
    call StartMessageCommand09HL_B13
    ret

; entry 27 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case1B::
Jump_013_664D:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_66DE
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_66CF
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_66C0
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_66B1
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_66A2
    ld de, $0020
    call TestFlagBit
    jr c, Jump_013_668C
    ld hl, $0103 ; 'Cobi 0, while you're gone, I'll'
    call StartMessageCommand09HL_B13
    ret

Jump_013_668C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_5256
    call StartScriptAtHL_B13
    ret

Jump_013_669B::
    ld hl, Script_5260
    call StartScriptAtHL_B13
    ret

Jump_013_66A2::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_5267
    call StartScriptAtHL_B13
    ret

Jump_013_66B1::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_5271
    call StartScriptAtHL_B13
    ret

Jump_013_66C0::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_527B
    call StartScriptAtHL_B13
    ret

Jump_013_66CF::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_5285
    call StartScriptAtHL_B13
    ret

Jump_013_66DE::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, Script_528F
    call StartScriptAtHL_B13
    ret

; entry 28 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case1C::
Jump_013_66ED:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_677E
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_676F
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_6760
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6751
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6742
    ld de, $0020
    call TestFlagBit
    jr c, Jump_013_672C
    ld hl, $0104 ; 'Tara Big brother, while you're in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_672C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_5299
    call StartScriptAtHL_B13
    ret

Jump_013_673B::
    ld hl, Script_52A3
    call StartScriptAtHL_B13
    ret

Jump_013_6742::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_52AA
    call StartScriptAtHL_B13
    ret

Jump_013_6751::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_52B4
    call StartScriptAtHL_B13
    ret

Jump_013_6760::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_52BE
    call StartScriptAtHL_B13
    ret

Jump_013_676F::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_52C8
    call StartScriptAtHL_B13
    ret

Jump_013_677E::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, Script_52D2
    call StartScriptAtHL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1D::
Jump_013_678D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_679C
    ld hl, $011E ; 'If your party is wiped out,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_679C::
    ld hl, $0B1D ; 'If you have a lot of'
    call StartMessageCommand09HL_B13
    ret

; entry 30 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1E::
Jump_013_67A3:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_67C2
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_67BB
    ld hl, $021F ; 'Do you know about LogTwig? It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_67BB::
    ld hl, $0DE5 ; 'The water flowed right over the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_67C2::
    ld hl, $0B14 ; 'You know how to commune with'
    call StartMessageCommand09HL_B13
    ret

; entry 31 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1F::
Jump_013_67C9:: ; address name
    ld hl, $04D0 ; '0 read the sign. Monster Arena,'
    call StartMessageCommand09HL_B13
    ret

; entry 32 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case20::
Jump_013_67D0:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6823
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_680D
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6806
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_67F8
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_67FF

Jump_013_67F8::
    ld hl, $003E ; 'GreatLog's major facilities are situated above'
    call StartMessageCommand09HL_B13
    ret

Jump_013_67FF::
    ld hl, $0071 ; 'Looking for a monster master? I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6806::
    ld hl, $021B ; 'This leads to GreatLog Castle! No'
    call StartMessageCommand09HL_B13
    ret

Jump_013_680D::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, Script_53D2
    call StartScriptAtHL_B13
    ret

Jump_013_681C::
    ld hl, $0A3D ; 'Prince Kameha wandered off like a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6823::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, Script_53FA
    call StartScriptAtHL_B13
    ret

; entry 33 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case21::
Jump_013_6832:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6856
    ld de, $0107
    call TestFlagBit
    jr c, Jump_013_684F
    ld hl, Script_5418
    call StartScriptAtHL_B13
    ld de, $0107
    call SetFlagBit
    ret

Jump_013_684F::
    ld hl, $021E ; 'It's easy to get down, but'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6856::
    ld hl, $0B10 ; 'The rope in the farm takes'
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case22::
Jump_013_685D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_686C
    ld hl, $021C ; 'Monsters hate being away from their'
    call StartMessageCommand09HL_B13
    ret

Jump_013_686C::
    ld hl, $0B0E ; 'I'm beginning to feel that people'
    call StartMessageCommand09HL_B13
    ret

; entry 35 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case23::
Jump_013_6873:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6891
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_688A
    ld hl, $0221 ; 'Hello there, youngster! Take these stairs'
    call StartMessageCommand09HL_B13
    ret

Jump_013_688A::
    ld hl, $0521 ; 'The Arena is closed under the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6891::
    ld hl, $0B2F ; 'Ah, GreatLog's great hero! How would'
    call StartMessageCommand09HL_B13
    ret

; entry 36 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case24::
Jump_013_6898:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_68B6
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_68AF
    ld hl, $0222 ; 'Hey, a little bitty master! Hi!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_68AF::
    ld hl, $0522 ; 'It's been decided to shut down'
    call StartMessageCommand09HL_B13
    ret

Jump_013_68B6::
    ld hl, $0B30 ; 'Well, well, it's GreatLog's savior! Masters'
    call StartMessageCommand09HL_B13
    ret

; entry 37 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case25::
Jump_013_68BD:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_68CD
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_68D4

Jump_013_68CD::
    ld hl, $0223 ; 'Well, you're a mighty lively kid.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_68D4::
    ld hl, $0543 ; 'I like my grandchildren to learn'
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case26::
Jump_013_68DB:: ; address name
    ld hl, $0224 ; 'Take care to find Tiny Medals.'
    call StartMessageCommand09HL_B13
    ret

; entry 39 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, hTemp0
; writes: hTemp0, hTemp1
DispatchTalkEvent_Case01_Case27::
Jump_013_68E2:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6940
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_692A
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6923
    ld a, [wPartyCount]
    dec a
    jr z, Jump_013_6915
    ld hl, $0002
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_691C

Jump_013_6915::
    ld hl, $0263 ; 'Oh You're so lucky to have'
    call StartMessageCommand09HL_B13
    ret

Jump_013_691C::
    ld hl, Script_5422
    call StartScriptAtHL_B13
    ret

Jump_013_6923::
    ld hl, $0267 ; 'What should I do with Butch'
    call StartMessageCommand09HL_B13
    ret

Jump_013_692A::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6939
    ld hl, $0D32 ; 'Do we have to leave GreatLog?'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6939::
    ld hl, $0528 ; 'I don't want to leave GreatLog!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6940::
    ld hl, Script_5433
    call StartScriptAtHL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case28::
Jump_013_6947:: ; address name
    ld hl, $0D8C ; 'Wata, wata. Terry battled in the'
    call StartMessageCommand09HL_B13
    ret

; entry 41 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case29::
Jump_013_694E:: ; address name
    ld hl, $0D8D ; 'Fwahahahaha! How amusing! Even I fell'
    call StartMessageCommand09HL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5476: 'Do you have any idea about'
DispatchTalkEvent_Case01_Case2A::
Jump_013_6955:: ; address name
    ld hl, $022D ; 'WarpWing returns you instantly to GreatLog,'
    call StartMessageCommand09HL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5476: 'Do you have any idea about'
DispatchTalkEvent_Case01_Case2B::
Jump_013_695C:: ; address name
    ld hl, Script_5476
    call StartScriptAtHL_B13
    ret

; entry 44 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2C::
Jump_013_6963:: ; address name
    ld hl, $022C ; 'There are books that change your'
    call StartMessageCommand09HL_B13
    ret

; entry 45 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2D::
Jump_013_696A:: ; address name
    ld hl, $0005 ; 'You folks run a monster farm?'
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2E::
Jump_013_6971:: ; address name
    ld hl, $0006 ; 'There's a spirit in GreatLog that's'
    call StartMessageCommand09HL_B13
    ret

; entry 47 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2F::
Jump_013_6978:: ; address name
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_6988
    ld l, $04
    ld h, $00
    call StartMessageCommand09HL_B13
    ret

Jump_013_6988::
    ld a, $01
    or a, a
    jr z, Jump_013_6994
    ld hl, Script_50DB
    call StartScriptAtHL_B13
    ret

Jump_013_6994::
    ld hl, Script_50F6
    call StartScriptAtHL_B13
    ret

; entry 48 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5120: 'Sailing is sure exhilarating. Right?'
DispatchTalkEvent_Case01_Case30::
Jump_013_699B:: ; address name
    ld hl, Script_5120
    call StartScriptAtHL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case31::
Jump_013_69A2:: ; address name
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_69B1
    ld hl, $000A ; 'We'll soon be reaching GreatLog. I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_69B1::
    ld hl, $000E ; 'Worried about your monsters? Don't be!'
    call StartMessageCommand09HL_B13
    ret

; entry 50 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case32::
Jump_013_69B8:: ; address name
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_69D3
    ld a, $02
    and a, $01
    add a, $0B
    ld l, a
    ld h, $00
    call StartMessageCommand09HL_B13
    ld de, $0013
    call SetFlagBit
    ret

Jump_013_69D3::
    ld hl, $000D ; 'When our farm gets established in'
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wTalkEventGroup
; writes: hTemp1, hTemp2, hTemp3
DispatchTalkEvent_Case01_Case33::
Jump_013_69DA:: ; address name
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_013_69EE
    ld hl, $0D62 ; 'The farm is full.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_69EE::
    ld a, [wTalkEventGroup]
    sub a, $33
    add a, $63
    ld l, a
    ld h, $0D
    call StartMessageCommand09HL_B13
    ld a, [wTalkEventGroup]
    sub a, $33
    add a, $06
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case36::
Jump_013_6A14:: ; address name
    ld hl, $0BAC ; 'You need to strike the right'
    call StartMessageCommand09HL_B13
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case37::
Jump_013_6A1B:: ; address name
    ld hl, $0D84 ; 'Some monsters may be tough, but'
    call StartMessageCommand09HL_B13
    ret

; entry 56 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case38::
Jump_013_6A22:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A40
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6A39
    ld hl, $023F ; 'I was on my way to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A39::
    ld hl, $0523 ; 'Don't be fooled by those rumors'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A40::
    ld hl, $0D8B ; 'You might know this already, but'
    call StartMessageCommand09HL_B13
    ret

; entry 57 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case39::
Jump_013_6A47:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A65
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6A5E
    ld hl, $0240 ; 'Pack properly if you're going off'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A5E::
    ld hl, $0524 ; 'He can talk tough now, but'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A65::
    ld hl, $0B31 ; 'Make sure you're fully prepared for'
    call StartMessageCommand09HL_B13
    ret

; entry 58 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3A::
Jump_013_6A6C:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A7B
    ld hl, $0241 ; 'Try the slide! It's a shortcut!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A7B::
    ld hl, $0B32 ; 'Have you used the rope already?'
    call StartMessageCommand09HL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3B::
Jump_013_6A82:: ; address name
    ld hl, $0243 ; '0 checked the bookshelf. Bookmark Place'
    call StartMessageCommand09HL_B13
    ret

; entry 60 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3C::
Jump_013_6A89:: ; address name
    ld hl, $0244 ; '0 checked the bookshelf. Journal A'
    call StartMessageCommand09HL_B13
    ret

; entry 61 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3D::
Jump_013_6A90:: ; address name
    ld hl, $0245 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 62 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3E::
Jump_013_6A97:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6AB5
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6AAE
    ld hl, Script_5483
    call StartScriptAtHL_B13
    ret

Jump_013_6AAE::
    ld hl, $0526 ; 'If GreatLog were to sink, we'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6AB5::
    ld hl, $0B42 ; 'The girl next door? Well, we'
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3F::
Jump_013_6ABC:: ; address name
    ld hl, $0249 ; '0 checked the bookshelf. Diary A'
    call StartMessageCommand09HL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case40::
Jump_013_6AC3:: ; address name
    ld hl, $0256 ; '0 checked the dresser. It was'
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case41::
Jump_013_6ACA:: ; address name
    ld hl, $02B0 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: hTemp1, hTemp2, hTemp3
DispatchTalkEvent_Case01_Case42::
Jump_013_6AD1:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6AEF
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6AE8
    ld hl, Script_5490
    call StartScriptAtHL_B13
    ret

Jump_013_6AE8::
    ld hl, $0525 ; 'Everyone's saying GreatLog'll sink!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6AEF::
    ld de, $00CD
    call TestFlagBit
    jr c, Jump_013_6B2B
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_013_6B0B
    ld hl, $0B44 ; 'The way you saved GreatLog was'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6B0B::
    ld a, $02
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, $0B43 ; 'The way you saved GreatLog was'
    call StartMessageCommand09HL_B13
    ld de, $00CD
    call SetFlagBit
    ret

Jump_013_6B2B::
    ld hl, $0B45 ; 'Our monsters left on a journey.'
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case43::
Jump_013_6B32:: ; address name
    ld hl, $025A ; '0 checked the dresser. It was'
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case44::
Jump_013_6B39:: ; address name
    ld hl, $025B ; '0 checked the bookshelf. This is'
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case45::
Jump_013_6B40:: ; address name
    ld de, $0134
    call TestFlagBit
    ret nc
    ld hl, $0314 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; entry 70 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case46::
Jump_013_6B4E:: ; address name
    ld a, $96
    ld [wDataBank], a
    ld de, $0111
    call TestFlagBit
    jr c, Jump_013_6B68
    ld hl, Script_549D
    call StartScriptAtHL_B13
    ld de, $0111
    call SetFlagBit
    ret

Jump_013_6B68::
    ld hl, Script_54A4
    call StartScriptAtHL_B13
    ret

; entry 71 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case47::
Jump_013_6B6F:: ; address name
    ld hl, $04C5 ; '0 checked the bookshelf. Handbook on'
    call StartMessageCommand09HL_B13
    ret

; entry 72 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case48::
Jump_013_6B76:: ; address name
    ld hl, $04C6 ; '0 checked the bookshelf. Handbook on'
    call StartMessageCommand09HL_B13
    ret

; entry 73 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case49::
Jump_013_6B7D:: ; address name
    ld hl, $04C7 ; '0 checked the bookshelf. Handbook on'
    call StartMessageCommand09HL_B13
    ret

; entry 74 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4A::
Jump_013_6B84:: ; address name
    ld hl, $08C0 ; 'We get more and more stubborn'
    call StartMessageCommand09HL_B13
    ret

; entry 75 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory
; writes: wStepPtrLo
DispatchTalkEvent_Case01_Case4B::
Jump_013_6B8B:: ; address name
    ld de, $01A3
    call TestFlagBit
    jr nc, Jump_013_6BBE
    ld de, $01A4
    call TestFlagBit
    jr c, Jump_013_6BBE
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_013_6BAC
    or a, a
    jr z, Jump_013_6BAC
    ld hl, $0D4A ; 'Here's that TinyMedal. Wait, you still'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6BAC::
    ld hl, Script_599F
    call StartScriptAtHL_B13
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

Jump_013_6BBE::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6BCD
    ld hl, $08BB ; 'You have to tamp the ground'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6BCD::
    ld hl, $0D87 ; 'GreatLog is a floating island? If'
    call StartMessageCommand09HL_B13
    ret

; entry 76 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_54AB: 'Hello, 0, welcome! This is the'
DispatchTalkEvent_Case01_Case4C::
Jump_013_6BD4:: ; address name
    ld de, $010A
    call TestFlagBit
    jr c, Jump_013_6BEE
    ld hl, Script_54AB
    call StartScriptAtHL_B13
    ld a, $1D
    ld [wDataBank], a
    ld de, $010A
    call SetFlagBit
    ret

Jump_013_6BEE::
    ld hl, Script_54B2
    call StartScriptAtHL_B13
    ld a, $1D
    ld [wDataBank], a
    ret

; entry 77 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4D::
Jump_013_6BFA:: ; address name
    ld hl, $0A50 ; 'Zzzz Yawn Huh? Is it morning'
    call StartMessageCommand09HL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4E::
Jump_013_6C01:: ; address name
    ld hl, $0A52 ; 'Our kind always stays near water.'
    call StartMessageCommand09HL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4F::
Jump_013_6C08:: ; address name
    ld hl, $0A53 ; 'Zzz Zzz Zzz Whoops! Was I'
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_54B9: '0 checked the casket.'
DispatchTalkEvent_Case01_Case50::
Jump_013_6C0F:: ; address name
    ld hl, $0A59 ; '0 read the sign. Ssh Monsters'
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_54B9: '0 checked the casket.'
DispatchTalkEvent_Case01_Case51::
Jump_013_6C16:: ; address name
    ld hl, Script_54B9
    call StartScriptAtHL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_54C0: '0 checked the casket.'
DispatchTalkEvent_Case01_Case52::
Jump_013_6C1D:: ; address name
    ld hl, Script_54C0
    call StartScriptAtHL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_54C7: '0 peered into the hole.'
DispatchTalkEvent_Case01_Case53::
Jump_013_6C24:: ; address name
    ld hl, $0A5D ; '0 read the sign. Watch your'
    call StartMessageCommand09HL_B13
    ret

; entry 84 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_54C7: '0 peered into the hole.'
DispatchTalkEvent_Case01_Case54::
Jump_013_6C2B:: ; address name
    ld hl, Script_54C7
    call StartScriptAtHL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case55::
Jump_013_6C32:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C41
    ld hl, $0292 ; 'They take entry fees from masters'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C41::
    ld hl, $0B79 ; 'You have to pay an entry'
    call StartMessageCommand09HL_B13
    ret

; entry 86 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case56::
Jump_013_6C48:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C57
    ld hl, $027D ; 'What do you suppose monsters are'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C57::
    ld hl, $0B75 ; 'I e learned how to tell'
    call StartMessageCommand09HL_B13
    ret

; entry 87 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case57::
Jump_013_6C5E:: ; address name
    ld hl, $027E ; 'GRAH, HUNGRY. LOOK DELICIOUS'
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case58::
Jump_013_6C65:: ; address name
    ld hl, $028C ; 'Listen, to win you need balance.'
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case59::
Jump_013_6C6C:: ; address name
    ld hl, $028D ; 'It's not all about winning. We'
    call StartMessageCommand09HL_B13
    ret

; entry 90 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5A::
Jump_013_6C73:: ; address name
    ld hl, $028E ; 'Arrrrroooh! My blood burns! I can'
    call StartMessageCommand09HL_B13
    ret

; entry 91 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5B::
Jump_013_6C7A:: ; address name
    ld hl, $0287 ; 'Monsters can grow only so much.'
    call StartMessageCommand09HL_B13
    ret

; entry 92 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5C::
Jump_013_6C81:: ; address name
    ld hl, $0286 ; 'The Arena is where masters can'
    call StartMessageCommand09HL_B13
    ret

; entry 93 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5D::
Jump_013_6C88:: ; address name
    ld hl, $028F ; 'If you come across a monster'
    call StartMessageCommand09HL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5E::
Jump_013_6C8F:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C9E
    ld hl, $0294 ; 'If you win an Arena tourney,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C9E::
    ld hl, $0B7A ; 'I e never heard of a'
    call StartMessageCommand09HL_B13
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5F::
Jump_013_6CA5:: ; address name
    ld hl, $0290 ; 'Sirloin is the tops, harrumph! It'
    call StartMessageCommand09HL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case60::
Jump_013_6CAC:: ; address name
    ld hl, $0291 ; 'I I didn't fall for any'
    call StartMessageCommand09HL_B13
    ret

; entry 97 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
DispatchTalkEvent_Case01_Case61::
Jump_013_6CB3:: ; address name
    ld a, [wArenaRank]
    or a, a
    jr nz, Jump_013_6CCF
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CC8
    ld hl, Script_54CE
    call StartScriptAtHL_B13
    ret

Jump_013_6CC8::
    ld hl, Script_550F
    call StartScriptAtHL_B13
    ret

Jump_013_6CCF::
    dec a
    jr nz, Jump_013_6CE8
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CE1
    ld hl, Script_54DB
    call StartScriptAtHL_B13
    ret

Jump_013_6CE1::
    ld hl, Script_551C
    call StartScriptAtHL_B13
    ret

Jump_013_6CE8::
    dec a
    jr nz, Jump_013_6D01
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CFA
    ld hl, Script_54E8
    call StartScriptAtHL_B13
    ret

Jump_013_6CFA::
    ld hl, Script_5529
    call StartScriptAtHL_B13
    ret

Jump_013_6D01::
    dec a
    jr nz, Jump_013_6D1A
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D13
    ld hl, Script_54F5
    call StartScriptAtHL_B13
    ret

Jump_013_6D13::
    ld hl, Script_5536
    call StartScriptAtHL_B13
    ret

Jump_013_6D1A::
    dec a
    jr nz, Jump_013_6D33
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D2C
    ld hl, Script_5502
    call StartScriptAtHL_B13
    ret

Jump_013_6D2C::
    ld hl, Script_5543
    call StartScriptAtHL_B13
    ret

Jump_013_6D33::
    ld hl, $0B78 ; 'You have to pay an entry'
    call StartMessageCommand09HL_B13
    ret

; entry 98 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case62::
Jump_013_6D3A:: ; address name
    ld hl, $0296 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 99 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case01_Case63::
Jump_013_6D41:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $010C
    call StartMessageScriptDE_B13
    ret

; entry 100 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case64::
Jump_013_6D52:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6D61
    ld hl, $027A ; 'Listen, this is a secret. There's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6D61::
    ld hl, $0B67 ; 'Listen, this is a secret. There's'
    call StartMessageCommand09HL_B13
    ret

; entry 101 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wTalkEventByte92, hTemp0
; writes: wDataBank, wScreenTableIndex, wTalkEventByte92
DispatchTalkEvent_Case01_Case65::
Jump_013_6D68:: ; address name
    ld a, $0C
    ld [wDataBank], a
    xor a, a
    ld [wScreenTableIndex], a
    farcall DispatchTalkEvent_Case01_Case65_Sub01
    ld a, [wArenaRank]
    or a, a
    jr z, Jump_013_6DAD
    cp a, $01
    jr z, Jump_013_6DB4
    cp a, $05
    jr z, Jump_013_6DCA
    ld a, [wTalkEventByte92]
    or a, a
    jr nz, Jump_013_6DA7
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    ld [wTalkEventByte92], a
    or a, a
    jr nz, Jump_013_6DA0
    ld hl, Script_5578
    call StartScriptAtHL_B13
    ret

Jump_013_6DA0::
    ld hl, Script_557F
    call StartScriptAtHL_B13
    ret

Jump_013_6DA7::
    ld a, [wArenaRank]
    or a, a
    jr nz, Jump_013_6DB4

Jump_013_6DAD::
    ld hl, Script_5550
    call StartScriptAtHL_B13
    ret

Jump_013_6DB4::
    ld de, $0189
    call TestFlagBit
    jr c, Jump_013_6DC3
    ld hl, Script_5560
    call StartScriptAtHL_B13
    ret

Jump_013_6DC3::
    ld hl, Script_556A
    call StartScriptAtHL_B13
    ret

Jump_013_6DCA::
    ld hl, Script_5571
    call StartScriptAtHL_B13
    ret

; entry 102 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case01_Case66::
Jump_013_6DD1:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $010E
    call TestFlagBit
    jr c, Jump_013_6E02
    ld a, $00
    ld [wScreenTableIndex], a
    ld a, $0E
    ld [wDataBank], a
    ld de, $010D
    call TestFlagBit
    jr c, Jump_013_6DFB
    ld hl, Script_5586
    call StartScriptAtHL_B13
    ret

Jump_013_6DFB::
    ld hl, Script_558B
    call StartScriptAtHL_B13
    ret

Jump_013_6E02::
    ld hl, $04B4 ; 'When you breed, the offspring inherit'
    call StartMessageCommand09HL_B13
    ret

; entry 103 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case67::
Jump_013_6E09:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E36
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_6E2F
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6E28
    ld hl, $04B5 ; 'Do you know all the kinds'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E28::
    ld hl, $04BB ; 'NoctoKing is my name! Darkness is'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E2F::
    ld hl, $04C1 ; 'Arr, matey! I'm CaptDead! A dashing'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E36::
    ld hl, $0B6E ; 'My frigid breath chills even souls.'
    call StartMessageCommand09HL_B13
    ret

; entry 104 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case68::
Jump_013_6E3D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E6A
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_6E63
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6E5C
    ld hl, $04B6 ; 'If you eat any BadMeat like'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E5C::
    ld hl, $04BC ; 'I learned how to Massacre! But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E63::
    ld hl, $04C2 ; 'I strike with my eight tentacles.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E6A::
    ld hl, $0B6F ; 'As I level up, my FrigidAir'
    call StartMessageCommand09HL_B13
    ret

; entry 105 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case69::
Jump_013_6E71:: ; address name
    ld a, $96
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E94
    ld de, $010F
    call TestFlagBit
    jr c, Jump_013_6E8D
    ld hl, Script_5598
    call StartScriptAtHL_B13
    ret

Jump_013_6E8D::
    ld hl, Script_55A2
    call StartScriptAtHL_B13
    ret

Jump_013_6E94::
    ld de, $0028
    call TestFlagBit
    jr c, Jump_013_6E8D
    ld hl, Script_55A9
    call StartScriptAtHL_B13
    ret

; entry 106 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case6A::
Jump_013_6EA3:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $15
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6ECF
    ld de, $0110
    call TestFlagBit
    jr c, Jump_013_6EC8
    ld hl, Script_55B3
    call StartScriptAtHL_B13
    ret

Jump_013_6EC8::
    ld hl, Script_55BD
    call StartScriptAtHL_B13
    ret

Jump_013_6ECF::
    ld de, $002C
    call TestFlagBit
    jr c, Jump_013_6EC8
    ld hl, Script_55C4
    call StartScriptAtHL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_55CE: 'I'm the Prof's assistant. Do you'
DispatchTalkEvent_Case01_Case6B::
Jump_013_6EDE:: ; address name
    ld hl, Script_55CE
    call StartScriptAtHL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6C::
Jump_013_6EE5:: ; address name
    ld hl, $08D8 ; '0 checked the bookshelf. Breeding Guide'
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6D::
Jump_013_6EEC:: ; address name
    ld hl, $08D9 ; '0 checked the bookshelf. Breeding Guide'
    call StartMessageCommand09HL_B13
    ret

; entry 110 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6E::
Jump_013_6EF3:: ; address name
    ld hl, $08CD ; '0 checked the door. The door'
    call StartMessageCommand09HL_B13
    ret

; entry 111 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6F::
Jump_013_6EFA:: ; address name
    ld hl, $02DC ; 'GreatLog's Starry Shrine wasn't in use'
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case70::
Jump_013_6F01:: ; address name
    ld hl, $0DD4 ; 'If you breed, the parents go'
    call StartMessageCommand09HL_B13
    ret

; entry 113 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case71::
Jump_013_6F08:: ; address name
    ld hl, $02DD ; 'Parents pass on abilities to their'
    call StartMessageCommand09HL_B13
    ret

; entry 114 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case72::
Jump_013_6F0F:: ; address name
    ld a, $0C
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6F32
    ld de, $0112
    call TestFlagBit
    jr c, Jump_013_6F2B
    ld hl, Script_55DB
    call StartScriptAtHL_B13
    ret

Jump_013_6F2B::
    ld hl, Script_55E5
    call StartScriptAtHL_B13
    ret

Jump_013_6F32::
    ld de, $0031
    call TestFlagBit
    jr c, Jump_013_6F2B
    ld hl, Script_55EC
    call StartScriptAtHL_B13
    ret

; entry 115 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case73::
Jump_013_6F41:: ; address name
    ld hl, $0A6F ; 'My husband loves to collect things'
    call StartMessageCommand09HL_B13
    ret

; entry 116 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case74::
Jump_013_6F48:: ; address name
    ld hl, $0A75 ; '0 checked the dresser. It overflowed'
    call StartMessageCommand09HL_B13
    ret

; entry 117 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case75::
Jump_013_6F4F:: ; address name
    ld hl, $0A76 ; '0 checked the dresser. It overflowed'
    call StartMessageCommand09HL_B13
    ret

; entry 118 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case76::
Jump_013_6F56:: ; address name
    ld hl, $0A77 ; '0 checked the oven. There was'
    call StartMessageCommand09HL_B13
    ret

; entry 119 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case01_Case77::
Jump_013_6F5D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6FBE
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6FA8
    ld de, $012E
    call TestFlagBit
    jr c, Jump_013_6FA1
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6F84
    ld hl, $025E ; 'My granddaughter is painfully shy. She'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6F84::
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_6F90
    ld hl, $0261 ; 'I e never seen my granddaughter'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6F90::
    ld [hl], $11
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_55F6
    call StartScriptAtHL_B13
    ret

Jump_013_6FA1::
    ld hl, $0262 ; 'My granddaughter now insists that she'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FA8::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6FB7
    ld hl, $0D31 ; 'For the sake of my grandchild,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FB7::
    ld hl, $0527 ; 'I'm an adult so I can'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FBE::
    ld hl, $0B46 ; 'My granddaughter became a master. She's'
    call StartMessageCommand09HL_B13
    ret

; entry 120 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case78::
Jump_013_6FC5:: ; address name
    ld hl, $0269 ; '0 checked the dresser. Girls clothes'
    call StartMessageCommand09HL_B13
    ret

; entry 121 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case01_Case79::
Jump_013_6FCC:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2E
    ld [wScriptParam1], a
    ld de, $0114
    call StartMessageScriptDE_B13
    ret

; entry 122 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7A::
Jump_013_6FDD:: ; address name
    ld hl, $026A ; '0 checked the plush doll. It'
    call StartMessageCommand09HL_B13
    ret

; entry 123 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7B::
Jump_013_6FE4:: ; address name
    ld hl, $0A32 ; 'There are powers that let you'
    call StartMessageCommand09HL_B13
    ret

; entry 124 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7C::
Jump_013_6FEB:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_6FFB
    ld hl, $0A33 ; 'Have you been to the Starry'
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FFB::
    ld hl, $0B06 ; 'Many kinds of monsters result from'
    call StartMessageCommand09HL_B13
    ret

; entry 125 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7D::
Jump_013_7002:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7012
    ld hl, $020A ; 'I'm chopping some trees down to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7012::
    ld hl, $0B0B ; 'Members of the dragon family, such'
    call StartMessageCommand09HL_B13
    ret

; entry 126 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7E::
Jump_013_7019:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7029
    ld hl, $08BF ; 'Master only makes me charge. It'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7029::
    ld hl, $0B0C ; 'The master's battle plan alters the'
    call StartMessageCommand09HL_B13
    ret

; entry 127 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wPartyCount, wInventory, wObject1
; writes: hTemp0, hTemp1, wScreenTableIndex, wDataBank
DispatchTalkEvent_Case01_Case7F::
Jump_013_7030:: ; address name
    ld de, $0134
    call TestFlagBit
    jr c, Jump_013_7096
    ld de, $0133
    call TestFlagBit
    jr c, Jump_013_704D
    ld de, $0133
    call SetFlagBit

Jump_013_7046::
    ld hl, $08C5 ; 'I want to open up a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_704D::
    ld hl, $00B9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_7046
    ld a, [wPartyCount]
    dec a
    jr z, Jump_013_708F
    ld de, $0191
    call TestFlagBit
    jr c, Jump_013_7088
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_013_7081
    or a, a
    jr z, Jump_013_7081
    ld hl, Script_561A
    call StartScriptAtHL_B13
    ret

Jump_013_7081::
    ld hl, Script_5631
    call StartScriptAtHL_B13
    ret

Jump_013_7088::
    ld hl, Script_5600
    call StartScriptAtHL_B13
    ret

Jump_013_708F::
    ld hl, $08C7 ; 'Wait! Could I get you to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7096::
    ld a, $01
    ld [wScreenTableIndex], a
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_70AA

Jump_013_70A3::
    ld hl, $0D25 ; 'ArmyAnt's help means I can open'
    call StartMessageCommand09HL_B13
    ret

Jump_013_70AA::
    ld a, [wObject1 + $B]
    cp a, $10
    jr nz, Jump_013_70A3
    ld a, $10
    ld [wDataBank], a
    ld de, $0116
    call TestFlagBit
    jr c, Jump_013_70CB
    ld hl, Script_564B
    call StartScriptAtHL_B13
    ld de, $0116
    call SetFlagBit
    ret

Jump_013_70CB::
    ld hl, Script_5652
    call StartScriptAtHL_B13
    ret

; entry 128 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case80::
Jump_013_70D2:: ; address name
    ld hl, $0A39 ; 'The man here has rare keys.'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7122; flag $00D1 set: jr to Jump_013_711B; flag $0024 set: jp to Jump_013_70F9); when none of them branches, starts message $0A3C through StartMessageCommand09HL_B13 (script command $09); that string begins 'King If you see Kameha again,' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: hTemp0, hTemp1
TalkMsg0A3C_KingIfYouSee::
Jump_013_70D9:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7122
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_711B
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_70F9
    ld hl, $0A3C ; 'King If you see Kameha again,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_70F9::
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_7114
    ld hl, $050E ; 'King Kameha came back safely from'
    call StartMessageCommand09HL_B13
    ld de, $0117
    call SetFlagBit
    ld de, $0122
    call SetFlagBit
    ret

Jump_013_7114::
    ld hl, $050F ; 'King There have been many quakes.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_711B::
    ld hl, $053D ; 'King GreatLog's crisis has passed. We'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7122::
    ld de, $0194
    call TestFlagBit
    jr c, Jump_013_7176
    ld de, $0193
    call TestFlagBit
    jr c, Jump_013_7160
    ld de, $0192
    call TestFlagBit
    jr c, Jump_013_7159
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_7152
    ldh a, [hTemp0]
    cp a, $64
    jr nc, Jump_013_7152
    ld hl, $0B7B ; 'King Oh? It's our savior 0!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7152::
    ld hl, Script_5903
    call StartScriptAtHL_B13
    ret

Jump_013_7159::
    ld hl, $0B7F ; 'King There is an evil master'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7160::
    ld hl, $2710
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_5913
    call StartScriptAtHL_B13
    ret

Jump_013_7176::
    ld de, $0197
    call TestFlagBit
    jr c, Jump_013_71CA
    ld de, $0196
    call TestFlagBit
    jr c, Jump_013_71B4
    ld de, $0195
    call TestFlagBit
    jr c, Jump_013_71AD
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_71A6
    ldh a, [hTemp0]
    cp a, $78
    jr nc, Jump_013_71A6
    ld hl, $0B82 ; 'King I was right to trust'
    call StartMessageCommand09HL_B13
    ret

Jump_013_71A6::
    ld hl, Script_591D
    call StartScriptAtHL_B13
    ret

Jump_013_71AD::
    ld hl, $0B85 ; 'King There is an evil master'
    call StartMessageCommand09HL_B13
    ret

Jump_013_71B4::
    ld hl, $4E20
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_592D
    call StartScriptAtHL_B13
    ret

Jump_013_71CA::
    ld de, $019A
    call TestFlagBit
    jr c, Jump_013_721E
    ld de, $0199
    call TestFlagBit
    jr c, Jump_013_7208
    ld de, $0198
    call TestFlagBit
    jr c, Jump_013_7201
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_71FA
    ldh a, [hTemp0]
    cp a, $8C
    jr nc, Jump_013_71FA
    ld hl, $0B82 ; 'King I was right to trust'
    call StartMessageCommand09HL_B13
    ret

Jump_013_71FA::
    ld hl, Script_5937
    call StartScriptAtHL_B13
    ret

Jump_013_7201::
    ld hl, $0B88 ; 'King There is an evil master'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7208::
    ld hl, $7530
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_5947
    call StartScriptAtHL_B13
    ret

Jump_013_721E::
    ld de, $019D
    call TestFlagBit
    jp c, Jump_013_7273
    ld de, $019C
    call TestFlagBit
    jr c, Jump_013_725D
    ld de, $019B
    call TestFlagBit
    jr c, Jump_013_7256
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_724F
    ldh a, [hTemp0]
    cp a, $A0
    jr nc, Jump_013_724F
    ld hl, $0B82 ; 'King I was right to trust'
    call StartMessageCommand09HL_B13
    ret

Jump_013_724F::
    ld hl, Script_5951
    call StartScriptAtHL_B13
    ret

Jump_013_7256::
    ld hl, $0B8B ; 'King There is an evil master'
    call StartMessageCommand09HL_B13
    ret

Jump_013_725D::
    ld hl, vBGMap1 + $40
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, Script_5961
    call StartScriptAtHL_B13
    ret

Jump_013_7273::
    ld hl, $0B8D ; 'King I was right to trust'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7299; flag $0024 set: jp to Jump_013_7292); when none of them branches, starts message $0A3E through StartMessageCommand09HL_B13 (script command $09); that string begins 'You're free to go anywhere in' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A3E_YoureFreeToGo::
Jump_013_727A:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7299
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7292
    ld hl, $0A3E ; 'You're free to go anywhere in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7292::
    ld hl, $0510 ; 'The frequent quakes have raised grave'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7299::
    ld de, $0192
    call TestFlagBit
    jr c, Jump_013_72A8
    ld hl, $0D93 ; 'We e had reports of rogue'
    call StartMessageCommand09HL_B13
    ret

Jump_013_72A8::
    ld de, $019C
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $019B
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0199
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $0198
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0196
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $0195
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0193
    call TestFlagBit
    jr c, Jump_013_72E7

Jump_013_72E0::
    ld hl, $0B8E ; 'It would be our Kingdom's shame'
    call StartMessageCommand09HL_B13
    ret

Jump_013_72E7::
    ld hl, $0D94 ; 'Ah, bless you! As GreatLog's hero,'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_730D; flag $00D1 set: jr to Jump_013_7314; flag $0122 set: jr to Jump_013_730D); when none of them branches, starts message $0A3F through StartMessageCommand09HL_B13 (script command $09); that string begins 'The King and Prince's chamber is' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A3F_TheKingAndPrinces::
Jump_013_72EE:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_730D
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7314
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_730D
    ld hl, $0A3F ; 'The King and Prince's chamber is'
    call StartMessageCommand09HL_B13
    ret

Jump_013_730D::
    ld hl, $0511 ; 'Beyond here is his Majesty and'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7314::
    ld hl, $0544 ; 'I can't eat another Zzz'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A41, whose string begins 'This is GreatLog Castle. The reception'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0A41_ThisIsGreatLogCastle::
Jump_013_731B:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_732B
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7332

Jump_013_732B::
    ld hl, $0A41 ; 'This is GreatLog Castle. The reception'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7332::
    ld hl, $0545 ; 'You're today's guest of honor! You'
    call StartMessageCommand09HL_B13
    ret

; entry 133 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case85::
Jump_013_7339:: ; address name
    ld hl, $0A42 ; 'The tavern just outside the Castle'
    call StartMessageCommand09HL_B13
    ret

; entry 134 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case86::
Jump_013_7340:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_734F
    ld hl, $0A43 ; 'Hey, welcome! All masters are welcome'
    call StartMessageCommand09HL_B13
    ret

Jump_013_734F::
    ld hl, $0B52 ; 'Ah, the savior of GreatLog! You're'
    call StartMessageCommand09HL_B13
    ret

; entry 135 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case87::
Jump_013_7356:: ; address name
    ld hl, $0A44 ; 'When you breed, notice a number'
    call StartMessageCommand09HL_B13
    ret

; entry 136 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case88::
Jump_013_735D:: ; address name
    ld hl, $0A45 ; 'If you want to make a'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A49, whose string begins 'Breeding could result in monsters with'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Talk0A49_BreedingCouldResultIn::
Jump_013_7364:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7396
    ld de, $0118
    call TestFlagBit
    jr c, Jump_013_738F
    ld a, $01
    ld [wScreenTableIndex], a
    ld hl, Script_5660
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_738F::
    ld hl, $0A49 ; 'Breeding could result in monsters with'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7396::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0125
    call TestFlagBit
    jr c, Jump_013_73B8
    ld a, $03
    ld [wScreenTableIndex], a
    ld hl, Script_5670
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_73B8::
    ld hl, $0516 ; 'Hm So that combination of parents'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_73DE; flag $0024 set: jp to Jump_013_73D7); when none of them branches, starts message $0A4A through StartMessageCommand09HL_B13 (script command $09); that string begins 'From up here people look like' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4A_FromUpHerePeople::
Jump_013_73BF:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_73DE
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_73D7
    ld hl, $0A4A ; 'From up here people look like'
    call StartMessageCommand09HL_B13
    ret

Jump_013_73D7::
    ld hl, $0517 ; 'GreatLog is sinking I heard, but'
    call StartMessageCommand09HL_B13
    ret

Jump_013_73DE::
    ld hl, $0BB9 ; 'GreatLog appears to have returned to'
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 01, wScriptParam1 = 47, then StartMessageScriptDE_B13 with DE = $0126: starts message group 1, string $26; on the normal ShowMessageHL path the string begins 'Warubou There, your party's fine! So,' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0126_WarubouThereYourPartys::
Jump_013_73E5:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $0126
    call StartMessageScriptDE_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7415; flag $0024 set: jp to Jump_013_740E); when none of them branches, starts message $0A4C through StartMessageCommand09HL_B13 (script command $09); that string begins 'GreatLog Castle was made by hollowing' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4C_GreatLogCastleWasMade::
Jump_013_73F6:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7415
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_740E
    ld hl, $0A4C ; 'GreatLog Castle was made by hollowing'
    call StartMessageCommand09HL_B13
    ret

Jump_013_740E::
    ld hl, $051F ; 'Right now, we are investigating what'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7415::
    ld hl, $0BBB ; 'Ah, GreatLog's savior! Are you taking'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_743A; flag $0024 set: jr to Jump_013_7433); when none of them branches, starts message $0A4D through StartMessageCommand09HL_B13 (script command $09); that string begins 'The island used to be lush' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4D_TheIslandUsedTo::
Jump_013_741C:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_743A
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7433
    ld hl, $0A4D ; 'The island used to be lush'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7433::
    ld hl, $0520 ; 'I e studied GreatLog over a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_743A::
    ld hl, $0BBC ; 'The island has become more lush'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $04BA, whose string begins 'If you get an EvilArmor, I'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Talk04BA_IfYouGetAn::
Jump_013_7441:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $011A
    call TestFlagBit
    jr c, Jump_013_7463
    ld hl, Script_5680
    call StartScriptAtHL_B13
    ld a, $02
    ld [wScreenTableIndex], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7463::
    ld hl, $04BA ; 'If you get an EvilArmor, I'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $04CB, whose string begins 'That key, I used on my'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
Talk04CB_ThatKeyIUsed::
Jump_013_746A:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7488
    ld de, $011D
    call TestFlagBit
    jr c, Jump_013_7481
    ld hl, Script_5690
    call StartScriptAtHL_B13
    ret

Jump_013_7481::
    ld hl, $04CB ; 'That key, I used on my'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7488::
    ld de, $00C8
    call TestFlagBit
    jr c, Jump_013_74EA
    ld de, $003D
    call TestFlagBit
    jr c, Jump_013_74C6
    ld de, $002E
    call TestFlagBit
    jr c, Jump_013_74AD
    ld hl, $0B4A ; 'I heard that you went on'
    call StartMessageCommand09HL_B13
    ld de, $002E
    call SetFlagBit
    ret

Jump_013_74AD::
    farcall Talk04CB_ThatKeyIUsed_Sub01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_74BF
    ld hl, $0B4B ; 'Those monsters don't surprise me. Bring'
    call StartMessageCommand09HL_B13
    ret

Jump_013_74BF::
    ld hl, Script_56A0
    call StartScriptAtHL_B13
    ret

Jump_013_74C6::
    ld de, $0206
    call TestFlagBit
    jr nc, Jump_013_74D6
    ld de, $0207
    call TestFlagBit
    jr c, Jump_013_74DD

Jump_013_74D6::
    ld hl, $0B4D ; 'Obtain the other key that doesn't'
    call StartMessageCommand09HL_B13
    ret

Jump_013_74DD::
    ld hl, Script_56A8
    call StartScriptAtHL_B13
    ld de, $003E
    call SetFlagBit
    ret

Jump_013_74EA::
    ld hl, $0BB4 ; 'There are still many things that'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $04CE, whose string begins '0 checked the shelf. 0 found'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
Talk04CE_HeroCheckedTheShelf::
Jump_013_74F1:: ; address name
    ld de, $011E
    call TestFlagBit
    jr c, Jump_013_7518
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_750B
    ld hl, $04CE ; '0 checked the shelf. 0 found'
    call StartMessageCommand09HL_B13
    ret

Jump_013_750B::
    ld hl, $04CD ; '0 checked the shelf. 0 obtained'
    call StartMessageCommand09HL_B13
    ld de, $011E
    call SetFlagBit
    ret

Jump_013_7518::
    ld hl, $04CC ; '0 checked the shelf. Souvenirs from'
    call StartMessageCommand09HL_B13
    ret

; entry 145 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case91::
Jump_013_751F:: ; address name
    ld hl, $04CF ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 146 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptByte68
; writes: wDataBank
DispatchTalkEvent_Case01_Case92::
Jump_013_7526:: ; address name
    ld a, [wScriptByte68]
    cp a, $01
    jr nz, Jump_013_7534
    ld hl, $0DC2 ; 'It's exciting to think where an'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7534::
    farcall SaveScreenBufferToBGMap1
    ld a, $0D
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7563
    ld de, $011F
    call TestFlagBit
    jr c, Jump_013_755C
    ld hl, Script_56AD
    call StartScriptAtHL_B13
    ld de, $011F
    call SetFlagBit
    ret

Jump_013_755C::
    ld hl, Script_56B7
    call StartScriptAtHL_B13
    ret

Jump_013_7563::
    ld de, $0113
    call TestFlagBit
    jr c, Jump_013_755C
    ld hl, Script_56BE
    call StartScriptAtHL_B13
    ret

; entry 147 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case93::
Jump_013_7572:: ; address name
    ld hl, $0299 ; 'I'm apprenticing under the boss. He'
    call StartMessageCommand09HL_B13
    ret

; entry 148 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case94::
Jump_013_7579:: ; address name
    ld hl, $029A ; 'Day after day, I examine keys.'
    call StartMessageCommand09HL_B13
    ret

; entry 149 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case95::
Jump_013_7580:: ; address name
    ret

; tests story flags in turn (flag $0025 set: jp to Jump_013_7591); when none of them branches, starts message $0504 through StartMessageCommand09HL_B13 (script command $09); that string begins 'If the island sink, is no' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0504_IfTheIslandSink::
Jump_013_7581:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7591
    ld hl, $0504 ; 'If the island sink, is no'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7591::
    ld hl, $0B05 ; 'This rope, it was not needed.'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_75B6; flag $00D1 set: jr to Jump_013_75AF); when none of them branches, starts message $0512 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Kameha Yo, 0. Thanks for coming.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: hTemp0, hTemp1
TalkMsg0512_KamehaYo0Thanks::
Jump_013_7598:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_75B6
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_75AF
    ld hl, $0512 ; 'Kameha Yo, 0. Thanks for coming.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_75AF::
    ld hl, $053E ; 'Kameha I couldn't do anything, so'
    call StartMessageCommand09HL_B13
    ret

Jump_013_75B6::
    ld de, $003A
    call TestFlagBit
    jr c, Jump_013_7636
    ld de, $0039
    call TestFlagBit
    jr c, Jump_013_75E5
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_75DE
    ldh a, [hTemp0]
    cp a, $32
    jr nc, Jump_013_75DE
    ld hl, $0D92 ; 'Kameha I think I have the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_75DE::
    ld hl, Script_58B5
    call StartScriptAtHL_B13
    ret

Jump_013_75E5::
    ld a, $07
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_7624
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7607

Jump_013_7600::
    ld hl, $0B96 ; 'Kameha What? Oh, it's 0. Did'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7607::
    ld a, $07
    ldh [hTemp1], a
    ld de, $0203
    call TestFlagBit
    jr nc, Jump_013_7617
    ld a, $47
    ldh [hTemp1], a

Jump_013_7617::
    farcall WriteKeyEntryTemp0
    ld hl, Script_58C3
    call StartScriptAtHL_B13
    ret

Jump_013_7624::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7600
    ld hl, Script_58CD
    call StartScriptAtHL_B13
    ret

Jump_013_7636::
    ld de, $003C
    call TestFlagBit
    jr c, Jump_013_76B6
    ld de, $003B
    call TestFlagBit
    jr c, Jump_013_7665
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_765E
    ldh a, [hTemp0]
    cp a, $96
    jr nc, Jump_013_765E
    ld hl, $0B98 ; 'Kameha Watch me, I'm going to'
    call StartMessageCommand09HL_B13
    ret

Jump_013_765E::
    ld hl, Script_58E1
    call StartScriptAtHL_B13
    ret

Jump_013_7665::
    ld a, $09
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_76A4
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7687

Jump_013_7680::
    ld hl, $0B96 ; 'Kameha What? Oh, it's 0. Did'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7687::
    ld a, $09
    ldh [hTemp1], a
    ld de, $0205
    call TestFlagBit
    jr nc, Jump_013_7697
    ld a, $49
    ldh [hTemp1], a

Jump_013_7697::
    farcall WriteKeyEntryTemp0
    ld hl, Script_58EF
    call StartScriptAtHL_B13
    ret

Jump_013_76A4::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7680
    ld hl, Script_58F9
    call StartScriptAtHL_B13
    ret

Jump_013_76B6::
    ld hl, $0B98 ; 'Kameha Watch me, I'm going to'
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 11, then StartMessageScriptDE_B13 with DE = $011B: starts message group 1, string $1B; on the normal ShowMessageHL path the string begins 'Hm? Are you a master hopeful?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg011B_HmAreYouA::
Jump_013_76BD:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $011B
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 13, then StartMessageScriptDE_B13 with DE = $011C: starts message group 1, string $1C; on the normal ShowMessageHL path the string begins 'Oh, hi! Good to see you' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg011C_OhHiGoodTo::
Jump_013_76CE:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $13
    ld [wScriptParam1], a
    ld de, $011C
    call StartMessageScriptDE_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $04C0, whose string begins 'All righty! We'll do this again'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Talk04C0_AllRightyWellDo::
Jump_013_76DF:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0129
    call TestFlagBit
    jr c, Jump_013_7701
    ld hl, Script_56C8
    call StartScriptAtHL_B13
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7701::
    ld hl, $04C0 ; 'All righty! We'll do this again'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0276, whose string begins 'If you want to enter, please'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
Talk0276_IfYouWantTo::
Jump_013_7708:: ; address name
    ld a, [wArenaRank]
    cp a, $05
    jr z, Jump_013_7720
    or a, a
    jr nz, Jump_013_7719
    ld hl, $0276 ; 'If you want to enter, please'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7719::
    ld hl, Script_56D8
    call StartScriptAtHL_B13
    ret

Jump_013_7720::
    ld hl, Script_56E5
    call StartScriptAtHL_B13
    ret

; entry 159 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_56F2
DispatchTalkEvent_Case01_Case9F::
Jump_013_7727:: ; address name
    ld hl, Script_56F2
    call StartScriptAtHL_B13
    ret

; map event: with story flag $D1 set, starts script $56F5 if flag 0 is set, else $5709 (E-0122)
; no direct call (reached through a table, a jump or a vector)
StartScript5709Or56F5IfFlagD1::
Jump_013_772E:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_7744
    ld hl, Script_5709
    call StartScriptAtHL_B13
    ret

Jump_013_7744::
    ld hl, Script_56F5
    call StartScriptAtHL_B13
    ret

; entry 160 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA0::
Jump_013_774B:: ; address name
    ld hl, $0024 ; '0 checked the dresser. Children's clothes'
    call StartMessageCommand09HL_B13
    ret

; entry 161 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA1::
Jump_013_7752:: ; address name
    ld hl, $0025 ; '0 checked the dresser. It smelled'
    call StartMessageCommand09HL_B13
    ret

; entry 162 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA2::
Jump_013_7759:: ; address name
    ld hl, $001D ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B13
    ret

; entry 163 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA3::
Jump_013_7760:: ; address name
    ld hl, $001C ; '0 checked the pump. It's rusted'
    call StartMessageCommand09HL_B13
    ret

; entry 164 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
DispatchTalkEvent_Case01_CaseA4::
Jump_013_7767:: ; address name
    farcall FullyHealParty
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; entry 165 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA5::
Jump_013_7788:: ; address name
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; entry 166 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case01_CaseA6::
Jump_013_778F:: ; address name
    ld a, $17
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_59B3
    call StartScriptAtHL_B13
    ret

; entry 167 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, hTemp1
DispatchTalkEvent_Case01_CaseA7::
Jump_013_77A0:: ; address name
    ld hl, $2710
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $00FE ; 'Terry Here, just take this. 0'
    call StartMessageCommand09HL_B13
    ret

; entry 168 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseA8::
Jump_013_77B6:: ; address name
    ld hl, $0D4E ; 'I'm digging here because I think'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0043, whose string begins '0 checked the odd object. It'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0043_HeroCheckedTheOdd::
Jump_013_77BD:: ; address name
    ld de, $000B
    call TestFlagBit
    jr nc, Jump_013_77CC
    ld de, $0025
    call TestFlagBit
    ret nc

Jump_013_77CC::
    ld hl, $0043 ; '0 checked the odd object. It'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $0036, whose string begins 'There were many wild monsters in'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0036_ThereWereManyWild::
Jump_013_77D3:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_77F3
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7808
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_7801
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_77FA

Jump_013_77F3::
    ld hl, $0036 ; 'There were many wild monsters in'
    call StartMessageCommand09HL_B13
    ret

Jump_013_77FA::
    ld hl, $0076 ; 'The island is sinking? Hahah, no'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7801::
    ld hl, $0D00 ; 'They say you use Magic Keys'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7808::
    ld hl, $050A ; 'When things are tough, you can't'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0037, whose string begins '0 tried to open the chest.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTileBuffer
Talk0037_HeroTriedToOpen::
Jump_013_780F:: ; address name
    ld a, [wScreenTileBuffer + $D2]
    cp a, $1A
    ret nz
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B13
    ret

; wD7FB = 1, StartScriptAtHL_B13 with HL = $5660, then wDataBank = $0E (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
; starts Script_5660: 'I'm a traveling merchant. I'm also'
StartScript5660WithBank0E::
Jump_013_781C:: ; address name
    ld a, $01
    ld [wScreenTableIndex], a
    ld hl, Script_5660
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_784B; flag $0024 set: jr to Jump_013_7844); when none of them branches, starts message $0268 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Yep, she's taking good care of' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0268_YepShesTakingGood::
Jump_013_782D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_784B
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7844
    ld hl, $0268 ; 'Yep, she's taking good care of'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7844::
    ld hl, $0529 ; 'Grandpa and the others are going'
    call StartMessageCommand09HL_B13
    ret

Jump_013_784B::
    ld hl, $0B48 ; 'My master has gotten good. You'll'
    call StartMessageCommand09HL_B13
    ret

; entry 174 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseAE::
Jump_013_7852:: ; address name
    ld hl, $022E ; 'Snivel This book is so sad'
    call StartMessageCommand09HL_B13
    ret

; entry 175 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseAF::
Jump_013_7859:: ; address name
    ld hl, $022F ; 'Even I can cast spells if'
    call StartMessageCommand09HL_B13
    ret

; entry 176 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseB0::
Jump_013_7860:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_786F
    ld hl, $0242 ; 'My dad's a famous monster master.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_786F::
    ld hl, $0B33 ; 'Papa is a famous monster master.'
    call StartMessageCommand09HL_B13
    ret

; entry 177 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseB1::
Jump_013_7876:: ; address name
    ld hl, $02B1 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 178 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseB2::
Jump_013_787D:: ; address name
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_789B
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_7894
    ld hl, Script_571D
    call StartScriptAtHL_B13
    ret

Jump_013_7894::
    ld hl, Script_572A
    call StartScriptAtHL_B13
    ret

Jump_013_789B::
    ld hl, Script_5737
    call StartScriptAtHL_B13
    ret

; entry 179 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseB3::
Jump_013_78A2:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_78B2
    ld hl, $02A6 ; 'Putting up a bridge is easy!'
    call StartMessageCommand09HL_B13
    ret

Jump_013_78B2::
    ld hl, $0B07 ; 'A world with lots of trees'
    call StartMessageCommand09HL_B13
    ret

; entry 180 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseB4::
Jump_013_78B9:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_78C9
    ld hl, $0209 ; 'Did you know? You can record'
    call StartMessageCommand09HL_B13
    ret

Jump_013_78C9::
    ld hl, $0B09 ; 'Listen, even in other worlds, you'
    call StartMessageCommand09HL_B13
    ret

; entry 181 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5744: 'Do you want to know how'
DispatchTalkEvent_Case01_CaseB5::
Jump_013_78D0:: ; address name
    ld hl, $0A51 ; 'When a appears by a monster's'
    call StartMessageCommand09HL_B13
    ret

; entry 182 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5744: 'Do you want to know how'
DispatchTalkEvent_Case01_CaseB6::
Jump_013_78D7:: ; address name
    ld hl, Script_5744
    call StartScriptAtHL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $08D1, whose string begins 'The Evaluator said I had an'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
Talk08D1_TheEvaluatorSaidI::
Jump_013_78DE:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_78ED

Jump_013_78E6::
    ld hl, $08D1 ; 'The Evaluator said I had an'
    call StartMessageCommand09HL_B13
    ret

Jump_013_78ED::
    ld de, $0029
    call TestFlagBit
    jr c, Jump_013_78E6
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_013_7909
    ld hl, Script_57FE
    call StartScriptAtHL_B13
    ret

Jump_013_7909::
    ld hl, Script_580B
    call StartScriptAtHL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $04D2, whose string begins 'Up ahead is the Starry Shrine'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
Talk04D2_UpAheadIsThe::
Jump_013_7910:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_793B
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7934
    ld a, [wArenaRank]
    or a, a
    jr nz, Jump_013_792D
    ld hl, $04D2 ; 'Up ahead is the Starry Shrine'
    call StartMessageCommand09HL_B13
    ret

Jump_013_792D::
    ld hl, $0D0C ; 'Up ahead is the Starry Shrine,'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7934::
    ld hl, $08D2 ; 'Go down these stairs to the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_793B::
    ld hl, $0B25 ; 'The Evaluator's singing is magic. You'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7951); when none of them branches, starts message $021F through StartMessageCommand09HL_B13 (script command $09); that string begins 'Do you know about LogTwig? It's' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg021F_DoYouKnowAbout::
Jump_013_7942:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7951
    ld hl, $021F ; 'Do you know about LogTwig? It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7951::
    ld hl, $0B12 ; 'A bard demanded to battle while'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7967); when none of them branches, starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins 'In other worlds, you'll meet other' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0220_InOtherWorldsYoull::
Jump_013_7958:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7967
    ld hl, $0220 ; 'In other worlds, you'll meet other'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7967::
    ld hl, $0B13 ; 'I just happened to come across'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_797D); when none of them branches, starts message $027F through StartMessageCommand09HL_B13 (script command $09); that string begins 'It's not easy to win right' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg027F_ItsNotEasyTo::
Jump_013_796E:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_797D
    ld hl, $027F ; 'It's not easy to win right'
    call StartMessageCommand09HL_B13
    ret

Jump_013_797D::
    ld hl, $0B76 ; 'Have you become a pro master?'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7993); when none of them branches, starts message $0280 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Mama is a big worrier But' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0280_MamaIsABig::
Jump_013_7984:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7993
    ld hl, $0280 ; 'Mama is a big worrier But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7993::
    ld hl, $0B77 ; 'My Mama gets so ahead of'
    call StartMessageCommand09HL_B13
    ret

; entry 189 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseBD::
Jump_013_799A:: ; address name
    ld hl, $0284 ; 'I come to watch every day.'
    call StartMessageCommand09HL_B13
    ret

; entry 190 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseBE::
Jump_013_79A1:: ; address name
    ld hl, $0285 ; 'Monsters mirror their masters. The plans'
    call StartMessageCommand09HL_B13
    ret

; entry 191 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5752: 'Hello there. Do you know about'
DispatchTalkEvent_Case01_CaseBF::
Jump_013_79A8:: ; address name
    ld hl, $0288 ; 'My husband is a master still.'
    call StartMessageCommand09HL_B13
    ret

; entry 192 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; starts Script_5752: 'Hello there. Do you know about'
DispatchTalkEvent_Case01_CaseC0::
Jump_013_79AF:: ; address name
    ld hl, Script_5752
    call StartScriptAtHL_B13
    ret

; entry 193 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC1::
Jump_013_79B6:: ; address name
    ld hl, $0293 ; 'If you win in the S'
    call StartMessageCommand09HL_B13
    ret

; entry 194 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC2::
Jump_013_79BD:: ; address name
    ld hl, $0295 ; 'In an Arena battle, you can't'
    call StartMessageCommand09HL_B13
    ret

; entry 195 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC3::
Jump_013_79C4:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_79D3
    ld hl, $027B ; 'Which to take? Monsters you e'
    call StartMessageCommand09HL_B13
    ret

Jump_013_79D3::
    ld hl, $0B68 ; 'Monsters that are caught at high'
    call StartMessageCommand09HL_B13
    ret

; entry 196 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC4::
Jump_013_79DA:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_79E9
    ld hl, $027C ; 'You need luck on your side'
    call StartMessageCommand09HL_B13
    ret

Jump_013_79E9::
    ld hl, $0B69 ; 'When you're at the pro level,'
    call StartMessageCommand09HL_B13
    ret

; entry 197 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC5::
Jump_013_79F0:: ; address name
    ld hl, $029C ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 198 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC6::
Jump_013_79F7:: ; address name
    ld hl, $029D ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; entry 199 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case01_CaseC7::
Jump_013_79FE:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0132
    call StartMessageScriptDE_B13
    ret

; entry 200 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC8::
Jump_013_7A0F:: ; address name
    ld hl, $02B1 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B13
    ret

; entry 201 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseC9::
Jump_013_7A16:: ; address name
    ld hl, $0225 ; '0 peered into the vase. There'
    call StartMessageCommand09HL_B13
    ret

; entry 202 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
DispatchTalkEvent_Case01_CaseCA::
Jump_013_7A1D:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0130
    call StartMessageScriptDE_B13
    ret

; entry 203 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseCB::
Jump_013_7A2E:: ; address name
    ld hl, $024A ; '0 checked the plush doll. It'
    call StartMessageCommand09HL_B13
    ret

; entry 204 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1
; writes: wFieldStateByte34
DispatchTalkEvent_Case01_CaseCC::
Jump_013_7A35:: ; address name
    farcall DispatchTalkEvent_Case01_CaseCC_Sub01
    ldh a, [hTemp1]
    bit 7, a
    ret nz
    ld [wFieldStateByte34], a
    ld hl, Script_575F
    call StartScriptAtHL_B13
    ret

; entry 205 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory
; writes: wStepPtrLo
DispatchTalkEvent_Case01_CaseCD::
Jump_013_7A4A:: ; address name
    ld de, $01A5
    call TestFlagBit
    jr nc, Jump_013_7A7D
    ld de, $01A6
    call TestFlagBit
    jr c, Jump_013_7A7D
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_013_7A6B
    or a, a
    jr z, Jump_013_7A6B
    ld hl, $0D45 ; 'Here it is-the TinyMedal. My master'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7A6B::
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld hl, Script_59A9
    call StartScriptAtHL_B13
    ret

Jump_013_7A7D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7A8C
    ld hl, $0D26 ; 'Hup, hup, hup! Heh, this stuff'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7A8C::
    ld hl, $0B15 ; 'When master's shop starts making money,'
    call StartMessageCommand09HL_B13
    ret

; entry 206 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseCE::
Jump_013_7A93:: ; address name
    ld hl, $0245 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $00FC, whose string begins 'You have to eat your vegetables!'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk00FC_YouHaveToEat::
Jump_013_7A9A:: ; address name
    farcall AddHundredToPartyINTCapped999
    ld hl, $00FC ; 'You have to eat your vegetables!'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7AB6); when none of them branches, starts message $0A74 through StartMessageCommand09HL_B13 (script command $09); that string begins 'The Medal Master was famous as' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A74_TheMedalMasterWas::
Jump_013_7AA7:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7AB6
    ld hl, $0A74 ; 'The Medal Master was famous as'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7AB6::
    ld hl, $0B51 ; 'If you find even more TinyMedals,'
    call StartMessageCommand09HL_B13
    ret

; when story flag $23 is set, StartScriptAtHL_B13 with HL = $57A2 (E-0119)
; no direct call (reached through a table, a jump or a vector)
; starts Script_57A2: 'Prince Kameha has been missing from'
IfFlag0023StartScript57A2::
Jump_013_7ABD:: ; address name
    ld de, $0023
    call TestFlagBit
    ret nc
    ld hl, Script_57A2
    call StartScriptAtHL_B13
    ret

; wScriptParam0 = 02, wScriptParam1 = 2C, then StartMessageScriptDE_B13 with DE = $013C: starts message group 1, string $3C; on the normal ShowMessageHL path the string begins 'I saw a lake like a' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013C_ISawALake::
Jump_013_7ACB:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $013C
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 01, wScriptParam1 = 1C, then StartMessageScriptDE_B13 with DE = $013D: starts message group 1, string $3D; on the normal ShowMessageHL path the string begins 'Strong monsters are in the well.' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013D_StrongMonstersAreIn::
Jump_013_7ADC:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1C
    ld [wScriptParam1], a
    ld de, $013D
    call StartMessageScriptDE_B13
    ret

; tests story flags in turn (flag $0025 set: jp to Jump_013_7AFD); when none of them branches, starts message $0A35 through StartMessageCommand09HL_B13 (script command $09); that string begins 'I'm a bug, so I'm not' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A35_ImABugSo::
Jump_013_7AED:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7AFD
    ld hl, $0A35 ; 'I'm a bug, so I'm not'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7AFD::
    ld hl, $0B0A ; 'Bugs like me grow super-quick! But'
    call StartMessageCommand09HL_B13
    ret

; entry 213 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseD5::
Jump_013_7B04:: ; address name
    ld hl, $0A34 ; 'Uheheheh, did you know this? Zombies'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B1A); when none of them branches, starts message $0A68 through StartMessageCommand09HL_B13 (script command $09); that string begins 'My Emyu is very timid. I' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A68_MyEmyuIsVery::
Jump_013_7B0B:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B1A
    ld hl, $0A68 ; 'My Emyu is very timid. I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B1A::
    ld hl, $0BBD ; 'There's something wrong with Emyu It's'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B3F; flag $0136 set: jr to Jump_013_7B38); when none of them branches, starts message $0A6B through StartMessageCommand09HL_B13 (script command $09); that string begins 'Monsters look so frightening Yes, I' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A6B_MonstersLookSoFrightening::
Jump_013_7B21:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B3F
    ld de, $0136
    call TestFlagBit
    jr c, Jump_013_7B38
    ld hl, $0A6B ; 'Monsters look so frightening Yes, I'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B38::
    ld hl, $0A6C ; 'I should be more assertive. It's'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B3F::
    ld hl, $0BBE ; 'Hey, hey, hey! We have to'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A40, whose string begins 'Please enter. The King awaits you'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0A40_PleaseEnterTheKing::
Jump_013_7B46:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B56
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7B5D

Jump_013_7B56::
    ld hl, $0A40 ; 'Please enter. The King awaits you'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B5D::
    ld hl, $0545 ; 'You're today's guest of honor! You'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B83; flag $0024 set: jp to Jump_013_7B7C); when none of them branches, starts message $0A4B through StartMessageCommand09HL_B13 (script command $09); that string begins 'On the horizon, you can see' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4B_OnTheHorizonYou::
Jump_013_7B64:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B83
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7B7C
    ld hl, $0A4B ; 'On the horizon, you can see'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B7C::
    ld hl, $0518 ; 'I e never once left the'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B83::
    ld hl, $0BBA ; 'I'm feeling invigorated too. I want'
    call StartMessageCommand09HL_B13
    ret

; entry 218 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseDA::
Jump_013_7B8A:: ; address name
    ld hl, $04D1 ; 'There are times when you have'
    call StartMessageCommand09HL_B13
    ret

; entry 219 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wGameFlags836
; writes: hTemp0, hTemp1, wGameFlags836
DispatchTalkEvent_Case01_CaseDB::
Jump_013_7B91:: ; address name
    ld de, $00C8
    call TestFlagBit
    ret c
    ld de, $003D
    call TestFlagBit
    jp c, Jump_013_7C82
    ld a, $01
    or a, a
    jr z, Jump_013_7C14
    ld a, $0A
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_7BED
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7BC8
    ld hl, $0B4F ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7BC8::
    ld a, $0A
    ldh [hTemp1], a
    ld de, $0206
    call TestFlagBit
    jr nc, Jump_013_7BD8
    ld a, $4A
    ldh [hTemp1], a

Jump_013_7BD8::
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_586C
    call StartScriptAtHL_B13
    ret

Jump_013_7BED::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7C0D
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_588D
    call StartScriptAtHL_B13
    ld de, $003D
    call SetFlagBit
    ret

Jump_013_7C0D::
    ld hl, $0B4F ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7C14::
    ld a, $0B
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_7C5B
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7C36
    ld hl, $0BB8 ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7C36::
    ld a, $0B
    ldh [hTemp1], a
    ld de, $0207
    call TestFlagBit
    jr nc, Jump_013_7C46
    ld a, $4B
    ldh [hTemp1], a

Jump_013_7C46::
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_5877
    call StartScriptAtHL_B13
    ret

Jump_013_7C5B::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7C7B
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_588D
    call StartScriptAtHL_B13
    ld de, $003D
    call SetFlagBit
    ret

Jump_013_7C7B::
    ld hl, $0B4F ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7C82::
    ld de, $003E
    call TestFlagBit
    ret nc
    ld a, $0C
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_7CD0
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7CAB
    ld hl, $0BB8 ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7CAB::
    ld a, $0C
    ldh [hTemp1], a
    ld de, $0208
    call TestFlagBit
    jr nc, Jump_013_7CBB
    ld a, $4C
    ldh [hTemp1], a

Jump_013_7CBB::
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_5882
    call StartScriptAtHL_B13
    ret

Jump_013_7CD0::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7CF0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_588D
    call StartScriptAtHL_B13
    ld de, $00C8
    call SetFlagBit
    ret

Jump_013_7CF0::
    ld hl, $0B4F ; '0 found a Magic Key. But'
    call StartMessageCommand09HL_B13
    ret

; entry 220 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseDC::
Jump_013_7CF7:: ; address name
    ld hl, $0519 ; 'This is a time we need'
    call StartMessageCommand09HL_B13
    ret

; entry 221 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseDD::
Jump_013_7CFE:: ; address name
    ld hl, $051A ; 'I didn't want to believe GreatLog'
    call StartMessageCommand09HL_B13
    ret

; entry 222 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseDE::
Jump_013_7D05:: ; address name
    ld hl, $051B ; 'I won't believe that GreatLog is'
    call StartMessageCommand09HL_B13
    ret

; entry 223 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseDF::
Jump_013_7D0C:: ; address name
    ld hl, $051C ; 'The King said that GreatLog will'
    call StartMessageCommand09HL_B13
    ret

; entry 224 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseE0::
Jump_013_7D13:: ; address name
    ld hl, $051D ; 'Everyone, please remain calm. Even if'
    call StartMessageCommand09HL_B13
    ret

; entry 225 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseE1::
Jump_013_7D1A:: ; address name
    ld hl, $051E ; 'The GreatLog tree appeared to be'
    call StartMessageCommand09HL_B13
    ret

; entry 226 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseE2::
Jump_013_7D21:: ; address name
    ld hl, $055E ; '0 checked the bookshelf. Magic Keys'
    call StartMessageCommand09HL_B13
    ret

; entry 227 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseE3::
Jump_013_7D28:: ; address name
    ld hl, $0DD5 ; 'Monster skills are passed on from'
    call StartMessageCommand09HL_B13
    ret

; entry 228 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wGM2Mode, wObject5
; writes: hTemp0
DispatchTalkEvent_Case01_CaseE4::
Jump_013_7D2F:: ; address name
    ld a, [wGM2Mode]
    cp a, $01
    ret nz
    ld a, [wObject5]
    or a, a
    ret nz
    ld a, $14
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ret

; entry 229 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wGM2Mode, wRollState
DispatchTalkEvent_Case01_CaseE5::
Jump_013_7D45:: ; address name
    ld a, [wGM2Mode]
    cp a, $01
    ret nz
    ld a, [wRollState]
    or a, a
    jr nz, Jump_013_7D58
    ld hl, Script_57E3
    call StartScriptAtHL_B13
    ret

Jump_013_7D58::
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld hl, Script_57E8
    call StartScriptAtHL_B13
    ret

; entry 230 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
DispatchTalkEvent_Case01_CaseE6::
Jump_013_7D65:: ; address name
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, Jump_013_7D72
    ld hl, $0D66
    ld c, $00
    jr Jump_013_7D82

Jump_013_7D72::
    cp a, $40
    jr nz, Jump_013_7D7D
    ld hl, $0D67
    ld c, $01
    jr Jump_013_7D82

Jump_013_7D7D::
    ld hl, $0D68
    ld c, $02

Jump_013_7D82::
    call StartMessageCommand09HL_B13
    farcall LoadSpeciesFlagsPresetC
    ret

; entry 231 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptByte68
DispatchTalkEvent_Case01_CaseE7::
Jump_013_7D8C:: ; address name
    xor a, a
    ld [wScriptByte68], a
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7DA0); when none of them branches, starts message $029B through StartMessageCommand09HL_B13 (script command $09); that string begins 'I found a key in another' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg029B_IFoundAKey::
Jump_013_7D91:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DA0
    ld hl, $029B ; 'I found a key in another'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DA0::
    ld hl, $0B1F ; 'My grandpa gave me a key,'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0DE3, whose string begins 'The sea is huge and mysterious.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0DE3_TheSeaIsHuge::
Jump_013_7DA7:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DB7
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7DBE

Jump_013_7DB7::
    ld hl, $0DE3 ; 'The sea is huge and mysterious.'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DBE::
    ld hl, $0DE4 ; 'Huh? Has the sea risen? Oh,'
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7DD4); when none of them branches, starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins 'In other worlds, you'll meet other' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0220_InOtherWorldsYoull_7DC5::
Jump_013_7DC5:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DD4
    ld hl, $0220 ; 'In other worlds, you'll meet other'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DD4::
    ld hl, $0B13 ; 'I just happened to come across'
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 26, then StartMessageScriptDE_B13 with DE = $013E: starts message group 1, string $3E; on the normal ShowMessageHL path the string begins 'Our King has been a fan' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013E_OurKingHasBeen::
Jump_013_7DDB:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $26
    ld [wScriptParam1], a
    ld de, $013E
    call StartMessageScriptDE_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 42, then StartMessageScriptDE_B13 with DE = $013F: starts message group 1, string $3F; on the normal ShowMessageHL path the string begins 'The circus master was trying to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013F_TheCircusMasterWas::
Jump_013_7DEC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $42
    ld [wScriptParam1], a
    ld de, $013F
    call StartMessageScriptDE_B13
    ret

; entry 238 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_CaseEE::
Jump_013_7DFD:: ; address name
    ld hl, $055F ; '0 checked the bookshelf. Magic Keys'
    call StartMessageCommand09HL_B13
    ret
    db $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $0B56, whose string begins 'When you breed monsters with another'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, hTemp1, hTemp0
; writes: wDataBank, wScreenTableIndex
Talk0B56_WhenYouBreedMonsters::
Jump_013_7E05:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0E
    ld [wDataBank], a
    ld a, [wSpriteSlots + $2]
    cp a, $17
    jr z, Jump_013_7E6C
    cp a, $13
    jr z, Jump_013_7E39
    ld de, $0032
    call TestFlagBit
    jr c, Jump_013_7E32
    ld a, $05
    ld [wScreenTableIndex], a
    ld hl, Script_581C
    call StartScriptAtHL_B13
    ret

Jump_013_7E32::
    ld hl, $0B56 ; 'When you breed monsters with another'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E39::
    ld de, $0033
    call TestFlagBit
    jr c, Jump_013_7E65
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_7E59
    ldh a, [hTemp0]
    cp a, $64
    jr nc, Jump_013_7E59
    ld hl, $0D8E ; 'I heard of a little hero'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E59::
    ld a, $06
    ld [wScreenTableIndex], a
    ld hl, Script_582C
    call StartScriptAtHL_B13
    ret

Jump_013_7E65::
    ld hl, $0B5A ; 'Generations of breeding passes on skills'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E6C::
    ld de, $0034
    call TestFlagBit
    jr c, Jump_013_7E98
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_7E8C
    ldh a, [hTemp0]
    cp a, $96
    jr nc, Jump_013_7E8C
    ld hl, $0D8F ; 'What a scruffy lot of masters'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E8C::
    ld a, $07
    ld [wScreenTableIndex], a
    ld hl, Script_583C
    call StartScriptAtHL_B13
    ret

Jump_013_7E98::
    ld hl, $0B5E ; 'Put accessories on your monsters. They'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $0B6D, whose string begins 'Breeding fire and ice together makes'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, hTemp1, hTemp0
; writes: wDataBank, wScreenTableIndex
Talk0B6D_BreedingFireAndIce::
Jump_013_7E9F:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0E
    ld [wDataBank], a
    ld a, [wSpriteSlots + $2]
    cp a, $14
    jr z, Jump_013_7ECF
    ld de, $0035
    call TestFlagBit
    jr c, Jump_013_7EC8
    ld a, $08
    ld [wScreenTableIndex], a
    ld hl, Script_584C
    call StartScriptAtHL_B13
    ret

Jump_013_7EC8::
    ld hl, $0B6D ; 'Breeding fire and ice together makes'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7ECF::
    ld de, $0036
    call TestFlagBit
    jr c, Jump_013_7EFB
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_7EEF
    ldh a, [hTemp0]
    cp a, $64
    jr nc, Jump_013_7EEF
    ld hl, $0D85 ; 'A master who can satisfy me'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7EEF::
    ld a, $09
    ld [wScreenTableIndex], a
    ld hl, Script_585C
    call StartScriptAtHL_B13
    ret

Jump_013_7EFB::
    ld hl, $0B73 ; 'Through breeding the number beside the'
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0D90, whose string begins 'Humph I'm Terry. Terry I'm a'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
Talk0D90_HumphImTerry::
Jump_013_7F02:: ; address name
    ld de, $0038
    call TestFlagBit
    jr c, Jump_013_7F2A
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    cp a, $01
    jr z, Jump_013_7F23
    ldh a, [hTemp0]
    cp a, $96
    jr nc, Jump_013_7F23
    ld hl, $0D90 ; 'Humph I'm Terry. Terry I'm a'
    call StartMessageCommand09HL_B13
    ret

Jump_013_7F23::
    ld hl, Script_5899
    call StartScriptAtHL_B13
    ret

Jump_013_7F2A::
    ld hl, $0BB3 ; 'Terry I hope you'll stay a'
    call StartMessageCommand09HL_B13
    ret

; map event: with story flag $25 set, sets wCB8A = $30 when the count from Func_085_5B04 is at least 50 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: wSpriteSlots
SetWCB8A30IfFlag25AndCountAtLeast50::
Jump_013_7F31:: ; address name
    ld de, $0025
    call TestFlagBit
    ret nc
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_013_7F48
    ldh a, [hTemp0]
    cp a, $32
    ret c

Jump_013_7F48::
    ld a, $30
    ld [wSpriteSlots + $B], a
    ret

; sets story flag $C9 if flag $32 is set and flag $CA if flag $33 is set (E-0122)
; no direct call (reached through a table, a jump or a vector)
SetFlagsC9AndCAFrom32And33::
Jump_013_7F4E:: ; address name
    ld de, $0032
    call TestFlagBit
    jr nc, Jump_013_7F5C
    ld de, $00C9
    call SetFlagBit

Jump_013_7F5C::
    ld de, $0033
    call TestFlagBit
    ret nc
    ld de, $00CA
    call SetFlagBit
    ret

; sets story flag $CB if flag $35 is set and flag $CC if flag $36 is set (E-0122)
; no direct call (reached through a table, a jump or a vector)
SetFlagsCBAndCCFrom35And36::
Jump_013_7F6A:: ; address name
    ld de, $0035
    call TestFlagBit
    jr nc, Jump_013_7F78
    ld de, $00CB
    call SetFlagBit

Jump_013_7F78::
    ld de, $0036
    call TestFlagBit
    ret nc
    ld de, $00CC
    call SetFlagBit
    ret

; when story flag $21 is set, StartScriptAtHL_B13 with HL = $5988 (E-0119)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5988: 'You're the child of the farmer?'
IfFlag0021StartScript5988::
Jump_013_7F86:: ; address name
    ld de, $0021
    call TestFlagBit
    ret nc
    ld hl, Script_5988
    call StartScriptAtHL_B13
    ret

; the same 28 bytes as InventoryHasFreeSlotCheck (04:7C37)
; 9 call sites from 8 routines (e.g. DispatchTalkEvent_Case01_Case77, DispatchTalkEvent_Case01_Case0D, DispatchTalkEvent_Case01_Case07, DispatchTalkEvent_Case01_Case02, ...)
; reads: wInventory
; points at: wInventory
InventoryHasFreeSlotCheck_Bank13::
Func_013_7F94:: ; address name
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_013_7FA0
    or a, a
    jr z, Jump_013_7FA0
    sub a, a
    ret

Jump_013_7FA0::
    ld hl, wInventory

Jump_013_7FA3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_013_7FAE
    or a, a
    jr z, Jump_013_7FAE
    inc hl
    jr Jump_013_7FA3

Jump_013_7FAE::
    scf
    ret

; copies wCB86, the player position and facing, wFollowerRecords and wC8F0-wC8FB fields into wC937-wC943 (E-0121)
; 8 call sites from 7 routines (e.g. Talk0B6D_BreedingFireAndIce, Talk0B56_WhenYouBreedMonsters, Talk04C0_AllRightyWellDo, Talk04BA_IfYouGetAn, ...)
; reads: wSpriteSlots, hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords
; writes: wSavedPlayerState
SavePlayerPositionState::
Func_013_7FB0:: ; address name
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
    ld a, [wFollowerRecords + $A]
    ld [wSavedPlayerState + $A], a
    ld a, [wFollowerRecords + $B]
    ld [wSavedPlayerState + $B], a
    ld a, [wFollowerRecords + $C]
    ld [wSavedPlayerState + $C], a
    ret
    db $00, $00, $00, $00
