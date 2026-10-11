SECTION "Bank 13", ROMX[$4000], BANK[$13]
    db $13

; starts a message through script command $09 (message word HL, shown by the same group dispatch as ShowMessageHL when wD7F0 = 0): HL is stored in wScriptParam0 (low) and wScriptParam1 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 697 call sites from 339 routines (e.g. DispatchTalkEvent_Case01_Case7F, DispatchTalkEvent_Case01_Case7E, DispatchTalkEvent_Case01_Case7D, DispatchTalkEvent_Case01_Case7C, ...)
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
; 33 call sites from 33 routines (e.g. DispatchTalkEvent_Case01_Case79, DispatchTalkEvent_Case01_Case63, DispatchTalkEvent_Case04_Case5C, DispatchTalkEvent_Case04_Case47, ...)
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
; 215 call sites from 113 routines (e.g. DispatchTalkEvent_Case08, DispatchTalkEvent_Case01_Case7F, DispatchTalkEvent_Case01_Case77, DispatchTalkEvent_Case01_Case72, ...)
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
; 39 call sites from 26 routines (e.g. RunWC8C7Phase_Case02, RunWC8C7Phase_Case01, FieldModeStateDispatch_Shared01_Sub02, FieldModeStateDispatch_Shared01_Sub03, ...)
; reads: wCC44, wC917, wCC45, wC916
; writes: wScriptStartRequest, wModeState, wC917, wC916, wScriptParam0, wScriptParam1, wScriptCommandType, wScriptRunning, ...
; points at: wCD89, wCDAE
DispatchTalkEvent::
Func_013_405C:: ; address name
    ld a, [wCC44]
    bit 7, a
    jp z, Jump_013_40E9
    ld a, [wC917]
    cp a, $09
    jp z, Jump_013_40E9
    ld a, [wCC44]
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
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr z, Jump_013_40E9

Jump_013_409E::
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, [wCC45]
    swap a
    ld hl, wCDAE
    add_a_to_hl
    ld a, [wC916]
    cp a, $FD
    jr nz, Jump_013_40C8
    ld a, $09
    ld [wC917], a
    ld a, $01
    ld [wC916], a
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
    ld a, [wC917]
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
; reads: wC916
DispatchTalkEvent_Case05::
Jump_013_4134:: ; address name
    ld a, [wC916]
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
    db $00, $00, $D5, $49

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case00::
Jump_013_421E:: ; address name
    ld hl, $0400
    call StartMessageCommand09HL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case01::
Jump_013_4225:: ; address name
    ld hl, $0401
    call StartMessageCommand09HL_B13
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case02::
Jump_013_422C:: ; address name
    ld hl, $0402
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case03::
Jump_013_4233:: ; address name
    ld hl, $0403
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case04::
Jump_013_423A:: ; address name
    ld hl, $0404
    call StartMessageCommand09HL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case05::
Jump_013_4241:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4250
    ld hl, $0405
    call StartMessageCommand09HL_B13
    ret

Jump_013_4250::
    ld hl, $0492
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case06::
Jump_013_4257:: ; address name
    ld hl, $0407
    call StartMessageCommand09HL_B13
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case07::
Jump_013_425E:: ; address name
    ld hl, $0406
    call StartMessageCommand09HL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case08::
Jump_013_4265:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_4274
    ld hl, $0408
    call StartMessageCommand09HL_B13
    ret

Jump_013_4274::
    ld hl, $0D2C
    call StartMessageCommand09HL_B13
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case09::
Jump_013_427B:: ; address name
    ld hl, $0409
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
    ld hl, $040A
    call StartMessageCommand09HL_B13
    ret

Jump_013_4299::
    ld hl, $0414
    call StartMessageCommand09HL_B13
    ret

Jump_013_42A0::
    ld hl, $0D2D
    call StartMessageCommand09HL_B13
    ret

; entry 11 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case0B::
Jump_013_42A7:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_5FE8
    call StartScriptAtHL_B13
    ret

; entry 12 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case0C::
Jump_013_42B3:: ; address name
    ld hl, $040E
    call StartMessageCommand09HL_B13
    ret

; entry 13 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case0D::
Jump_013_42BA:: ; address name
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_013_42C9
    ld hl, $5FEF
    call StartScriptAtHL_B13
    ret

Jump_013_42C9::
    ld hl, $5FF7
    call StartScriptAtHL_B13
    ret

; entry 14 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case0E::
Jump_013_42D0:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6003
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
    ld hl, $0410
    call StartMessageCommand09HL_B13
    ret

Jump_013_42F4::
    ld hl, $5FFC
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
    ld hl, $0413
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
DispatchTalkEvent_Case05_Case14::
Jump_013_4335:: ; address name
    ld hl, $600A
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
    ld hl, $041A
    call StartMessageCommand09HL_B13
    ld de, $00A7
    call SetFlagBit
    ret

Jump_013_4367::
    ld hl, $041B
    call StartMessageCommand09HL_B13
    ret

Jump_013_436E::
    ld hl, $04A2
    call StartMessageCommand09HL_B13
    ret

; entry 22 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerSpriteOverride, wCB8A
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
    ld hl, $041C
    call StartMessageCommand09HL_B13
    ret

Jump_013_438E::
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_013_43A2
    ld hl, $6015
    call StartScriptAtHL_B13
    ld de, $0209
    call SetFlagBit
    ret

Jump_013_43A2::
    ld hl, $041D
    call StartMessageCommand09HL_B13
    ret

Jump_013_43A9::
    ld hl, $0DF8
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case17::
Jump_013_43B0:: ; address name
    ld hl, $041E
    call StartMessageCommand09HL_B13
    ret

; entry 24 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case18::
Jump_013_43B7:: ; address name
    ld hl, $041F
    call StartMessageCommand09HL_B13
    ret

; entry 25 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case19::
Jump_013_43BE:: ; address name
    ld hl, $0420
    call StartMessageCommand09HL_B13
    ret

; entry 26 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1A::
Jump_013_43C5:: ; address name
    ld hl, $0421
    call StartMessageCommand09HL_B13
    ret

; entry 27 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1B::
Jump_013_43CC:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43DB
    ld hl, $0422
    call StartMessageCommand09HL_B13
    ret

Jump_013_43DB::
    ld hl, $0D2E
    call StartMessageCommand09HL_B13
    ret

; entry 28 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1C::
Jump_013_43E2:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43F1
    ld hl, $0423
    call StartMessageCommand09HL_B13
    ret

Jump_013_43F1::
    ld hl, $0D2F
    call StartMessageCommand09HL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1D::
Jump_013_43F8:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4407
    ld hl, $0424
    call StartMessageCommand09HL_B13
    ret

Jump_013_4407::
    ld hl, $0494
    call StartMessageCommand09HL_B13
    ret

; entry 30 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case1E::
Jump_013_440E:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_441D
    ld hl, $0425
    call StartMessageCommand09HL_B13
    ret

Jump_013_441D::
    ld hl, $0495
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
    ld hl, $6020
    call StartScriptAtHL_B13
    ret

Jump_013_4435::
    ld hl, $602D
    call StartScriptAtHL_B13
    ret

; entry 32 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case20::
Jump_013_443C:: ; address name
    ld hl, $042A
    call StartMessageCommand09HL_B13
    ret

; entry 33 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case21::
Jump_013_4443:: ; address name
    ld hl, $042B
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case22::
Jump_013_444A:: ; address name
    ld hl, $042C
    call StartMessageCommand09HL_B13
    ret

; entry 35 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case23::
Jump_013_4451:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_603A
    call StartScriptAtHL_B13
    ret

; entry 36 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case05_Case24::
Jump_013_445D:: ; address name
    ld a, $0D
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6041
    call StartScriptAtHL_B13
    ret

; entry 37 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case25::
Jump_013_446E:: ; address name
    ld hl, $0430
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case26::
Jump_013_4475:: ; address name
    ld hl, $04AA
    call StartMessageCommand09HL_B13
    ret

; entry 39 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case27::
Jump_013_447C:: ; address name
    ld hl, $0DD3
    call StartMessageCommand09HL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case28::
Jump_013_4483:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6048
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
    ld hl, $604F
    call StartScriptAtHL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2A::
Jump_013_44A7:: ; address name
    ld de, $00A9
    call TestFlagBit
    jr c, Jump_013_44BC
    ld hl, $0434
    call StartMessageCommand09HL_B13
    ld de, $00A9
    call SetFlagBit
    ret

Jump_013_44BC::
    ld hl, $0435
    call StartMessageCommand09HL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2B::
Jump_013_44C3:: ; address name
    ld hl, $0436
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
    ld hl, $0437
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2E::
Jump_013_44E2:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_44F1
    ld hl, $0438
    call StartMessageCommand09HL_B13
    ret

Jump_013_44F1::
    ld hl, $0496
    call StartMessageCommand09HL_B13
    ret

; entry 47 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case2F::
Jump_013_44F8:: ; address name
    ld hl, $6062
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
    ld hl, $043C
    call StartMessageCommand09HL_B13
    ret

Jump_013_4516::
    ld hl, $043D
    call StartMessageCommand09HL_B13
    ret

Jump_013_451D::
    ld hl, $0497
    call StartMessageCommand09HL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case31::
Jump_013_4524:: ; address name
    ld hl, $043E
    call StartMessageCommand09HL_B13
    ret

; entry 50 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case32::
Jump_013_452B:: ; address name
    ld hl, $043F
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case33::
Jump_013_4532:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4541
    ld hl, $0440
    call StartMessageCommand09HL_B13
    ret

Jump_013_4541::
    ld hl, $0498
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4582
    jr Jump_013_4598

Jump_013_4582::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4591
    ld hl, $0441
    call StartMessageCommand09HL_B13
    ret

Jump_013_4591::
    ld hl, $0442
    call StartMessageCommand09HL_B13
    ret

Jump_013_4598::
    ld hl, $6119
    call StartScriptAtHL_B13
    ret

Jump_013_459F::
    ld hl, $0499
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_45E8
    jr Jump_013_45FE

Jump_013_45E8::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_45F7
    ld hl, $0443
    call StartMessageCommand09HL_B13
    ret

Jump_013_45F7::
    ld hl, $0444
    call StartMessageCommand09HL_B13
    ret

Jump_013_45FE::
    ld hl, $046B
    call StartMessageCommand09HL_B13
    ld de, $00B7
    call SetFlagBit
    ret

Jump_013_460B::
    ld hl, $046C
    call StartMessageCommand09HL_B13
    ret

Jump_013_4612::
    ld hl, $049A
    call StartMessageCommand09HL_B13
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case36::
Jump_013_4619:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4628
    ld hl, $0445
    call StartMessageCommand09HL_B13
    ret

Jump_013_4628::
    ld hl, $04A3
    call StartMessageCommand09HL_B13
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case37::
Jump_013_462F:: ; address name
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_463E
    ld hl, $0446
    call StartMessageCommand09HL_B13
    ret

Jump_013_463E::
    ld hl, $049B
    call StartMessageCommand09HL_B13
    ret

; entry 56 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case38::
Jump_013_4645:: ; address name
    ld hl, $606F
    call StartScriptAtHL_B13
    ret

; entry 57 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case39::
Jump_013_464C:: ; address name
    ld hl, $044A
    call StartMessageCommand09HL_B13
    ret

; entry 58 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case05_Case3A::
Jump_013_4653:: ; address name
    ld a, $0E
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_607C
    call StartScriptAtHL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case3B::
Jump_013_4664:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_6083
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
    ld hl, $044D
    call StartMessageCommand09HL_B13
    ret

Jump_013_4687::
    ld hl, $044E
    call StartMessageCommand09HL_B13
    ret

Jump_013_468E::
    ld hl, $049C
    call StartMessageCommand09HL_B13
    ret

; entry 61 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case3D::
Jump_013_4695:: ; address name
    ld hl, $0450
    call StartMessageCommand09HL_B13
    ret

; entry 62 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case3E::
Jump_013_469C:: ; address name
    ld hl, $0314
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case05_Case3F::
Jump_013_46A3:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6048
    call StartScriptAtHL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case40::
Jump_013_46AF:: ; address name
    ld hl, $0452
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case41::
Jump_013_46B6:: ; address name
    ld hl, $0453
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case42::
Jump_013_46BD:: ; address name
    ld hl, $0454
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case43::
Jump_013_46C4:: ; address name
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_46D3
    ld hl, $0455
    call StartMessageCommand09HL_B13
    ret

Jump_013_46D3::
    ld hl, $0456
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case44::
Jump_013_46DA:: ; address name
    ld hl, $0457
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case45::
Jump_013_46E1:: ; address name
    ld hl, $0458
    call StartMessageCommand09HL_B13
    ret

; entry 70 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case46::
Jump_013_46E8:: ; address name
    ld hl, $0459
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
    ld hl, $045B
    call StartMessageCommand09HL_B13
    ret

Jump_013_4701::
    dec a
    jr nz, Jump_013_470B
    ld hl, $045C
    call StartMessageCommand09HL_B13
    ret

Jump_013_470B::
    ld hl, $6091
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
DispatchTalkEvent_Case05_Case4A::
Jump_013_4734:: ; address name
    ld de, $00AD
    call TestFlagBit
    jr c, Jump_013_4743
    ld hl, $6096
    call StartScriptAtHL_B13
    ret

Jump_013_4743::
    ld hl, $60B0
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
    ld hl, $60C7
    call StartScriptAtHL_B13
    ret

Jump_013_476D::
    ld hl, $0461
    call StartMessageCommand09HL_B13
    ret

; entry 77 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case4D::
Jump_013_4774:: ; address name
    ld hl, $0462
    call StartMessageCommand09HL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case4E::
Jump_013_477B:: ; address name
    ld hl, $60CE
    call StartScriptAtHL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case4F::
Jump_013_4782:: ; address name
    ld hl, $04A8
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case50::
Jump_013_4789:: ; address name
    ld hl, $04A9
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case51::
Jump_013_4790:: ; address name
    ld hl, $60D0
    call StartScriptAtHL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case52::
Jump_013_4797:: ; address name
    ld hl, $0463
    call StartMessageCommand09HL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case53::
Jump_013_479E:: ; address name
    ld hl, $040E
    call StartMessageCommand09HL_B13
    ret

; entry 84 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case54::
Jump_013_47A5:: ; address name
    ld de, $00B2
    call TestFlagBit
    jr c, Jump_013_47B4
    ld hl, $60D4
    call StartScriptAtHL_B13
    ret

Jump_013_47B4::
    ld hl, $040E
    call StartMessageCommand09HL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case55::
Jump_013_47BB:: ; address name
    ld de, $00B3
    call TestFlagBit
    jr c, Jump_013_47CA
    ld hl, $60EA
    call StartScriptAtHL_B13
    ret

Jump_013_47CA::
    ld hl, $6103
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
    ld hl, $046D
    call StartMessageCommand09HL_B13
    ret

Jump_013_47F1::
    ld hl, $049D
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case58::
Jump_013_47F8:: ; address name
    ld hl, $046E
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case59::
Jump_013_47FF:: ; address name
    ld hl, $046F
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4848
    jr Jump_013_484F

Jump_013_4848::
    ld hl, $0470
    call StartMessageCommand09HL_B13
    ret

Jump_013_484F::
    ld hl, $6126
    call StartScriptAtHL_B13
    ret

Jump_013_4856::
    ld hl, $0472
    call StartMessageCommand09HL_B13
    ret

Jump_013_485D::
    ld hl, $049E
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
DispatchTalkEvent_Case05_Case5C::
Jump_013_4875:: ; address name
    ld hl, $6131
    call StartScriptAtHL_B13
    ret

; entry 93 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case5D::
Jump_013_487C:: ; address name
    ld hl, $6059
    call StartScriptAtHL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case5E::
Jump_013_4883:: ; address name
    ld hl, $0DE2
    call StartMessageCommand09HL_B13
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case5F::
Jump_013_488A:: ; address name
    ld hl, $0476
    call StartMessageCommand09HL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case60::
Jump_013_4891:: ; address name
    ld hl, $0477
    call StartMessageCommand09HL_B13
    ret

; entry 97 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case61::
Jump_013_4898:: ; address name
    ld hl, $0478
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
    ld hl, $0450
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_4924
    jr Jump_013_492B

Jump_013_4924::
    ld hl, $0479
    call StartMessageCommand09HL_B13
    ret

Jump_013_492B::
    ld a, $39
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    farcall RemoveInventorySlotShiftDown
    ld a, $3A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    farcall RemoveInventorySlotShiftDown
    ld a, $3B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    farcall RemoveInventorySlotShiftDown
    ld hl, $6133
    call StartScriptAtHL_B13
    ret

Jump_013_4962::
    ld hl, $614A
    call StartScriptAtHL_B13
    ret

; entry 104 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case68::
Jump_013_4969:: ; address name
    ld hl, $6152
    call StartScriptAtHL_B13
    ret

; entry 105 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case69::
Jump_013_4970:: ; address name
    ld hl, $6198
    call StartScriptAtHL_B13
    ret

; entry 106 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wCB96
DispatchTalkEvent_Case05_Case6A::
Jump_013_4977:: ; address name
    xor a, a
    ld [wCB96], a
    ldh a, [hPlayerY]
    cp a, $70
    ret z
    ld hl, $618B
    call StartScriptAtHL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6B::
Jump_013_4987:: ; address name
    ld hl, $04A6
    call StartMessageCommand09HL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6C::
Jump_013_498E:: ; address name
    ld hl, $04A4
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case6D::
Jump_013_4995:: ; address name
    ld hl, $04A5
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
    ld hl, $60C7
    call StartScriptAtHL_B13
    ret

Jump_013_49AE::
    ld hl, $04A0
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
    ld hl, $60C7
    call StartScriptAtHL_B13
    ret

Jump_013_49C7::
    ld hl, $04A1
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case05
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case05_Case70::
Jump_013_49CE:: ; address name
    ld hl, $0413
    call StartMessageCommand09HL_B13
    ret

; when wC955 is set: clears it and warps between map $7F and $92 (position $40, $40 or $40, $10) through mode state 6 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wC955, hMapId
; writes: wC955, hMapId, wC8C8, wC8C9, wJoypadHeld, wJoypadPressed, wC8CA, wC914, ...
ToggleMapBetween7FAnd92:: ; heuristic: follows a terminator; C0
Func_013_49D5:: ; address name
    ld a, [wC955]
    or a, a
    ret z
    xor a, a
    ld [wC955], a
    ldh a, [hMapId]
    cp a, $7F
    jr nz, Jump_013_49F4
    ld a, $92
    ldh [hMapId], a
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    jr Jump_013_4A02

Jump_013_49F4::
    ld a, $7F
    ldh [hMapId], a
    ld a, $40
    ld [wC8C8], a
    ld a, $10
    ld [wC8C9], a

Jump_013_4A02::
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a, a
    ld [wC8CA], a
    xor a, a
    ld [wC914], a
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
; reads: wC916
DispatchTalkEvent_Case04::
Jump_013_4A23:: ; address name
    ld a, [wC916]
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
    dw Data_013_55CB
    dw Data_013_55D7
    dw Data_013_55DE
    dw Data_013_55EA
    dw Data_013_55F6
    dw Data_013_55FD
    dw Data_013_5604
    dw Data_013_5610
    dw Data_013_5617
    dw Data_013_561E
    dw Data_013_5625
    dw Data_013_564A
    dw TalkMsg0DD7_OurHeartsAreLike
    dw Talk0DD8_QueenHelenIsWracked
    dw Talk0DD9_TheReceptionHallIs
    dw TalkMsg0DDA_OurQueenHelensPremonition
    dw TalkMsg0DDB_WhatIsItLeave
    dw Data_013_5777
    dw Data_013_577E
    dw Data_013_5794
    dw Data_013_579B
    dw Data_013_579B
    dw Data_013_57A2
    dw Data_013_57A9
    dw Data_013_57B0
    dw Data_013_57B7
    dw Data_013_5803
    dw Data_013_581F
    dw Data_013_5826
    dw Data_013_585A
    dw Data_013_586B
    dw Data_013_5870
    dw Data_013_5877
    dw Data_013_5894
    dw Msg01E9
    dw Msg01EA
    dw Msg01EB
    dw Msg01EC
    dw Msg01ED
    dw Msg01EE
    dw Msg01EF
    dw Msg01F0
    db $33, $59

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case00::
Jump_013_4B7D:: ; address name
    ld hl, $0300
    call StartMessageCommand09HL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case01::
Jump_013_4B84:: ; address name
    ld hl, $0301
    call StartMessageCommand09HL_B13
    ret

; entry 2 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case02::
Jump_013_4B8B:: ; address name
    ld hl, $0302
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case03::
Jump_013_4B92:: ; address name
    ld hl, $0303
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case04::
Jump_013_4B99:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BA8
    ld hl, $0304
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BA8::
    ld hl, $0355
    call StartMessageCommand09HL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case05::
Jump_013_4BAF:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BBE
    ld hl, $0305
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BBE::
    ld hl, $0356
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case06::
Jump_013_4BC5:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BD4
    ld hl, $0306
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BD4::
    ld hl, $0357
    call StartMessageCommand09HL_B13
    ret

; entry 7 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case07::
Jump_013_4BDB:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4BEA
    ld hl, $0307
    call StartMessageCommand09HL_B13
    ret

Jump_013_4BEA::
    ld hl, $0A0B
    call StartMessageCommand09HL_B13
    ret

; entry 8 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case08::
Jump_013_4BF1:: ; address name
    ld hl, $5D5B
    call StartScriptAtHL_B13
    ret

; entry 9 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case09::
Jump_013_4BF8:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C07
    ld hl, $030B
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C07::
    ld hl, $0D21
    call StartMessageCommand09HL_B13
    ret

; entry 10 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0A::
Jump_013_4C0E:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C1D
    ld hl, $030C
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C1D::
    ld hl, $0DF2
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_4C43
    ld hl, $030E
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C43::
    ld hl, $5D8A
    call StartScriptAtHL_B13
    ret

Jump_013_4C4A::
    ld hl, $031D
    call StartMessageCommand09HL_B13
    ret

; entry 12 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0C::
Jump_013_4C51:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4C60
    ld hl, $030F
    call StartMessageCommand09HL_B13
    ret

Jump_013_4C60::
    ld hl, $037A
    call StartMessageCommand09HL_B13
    ret

; entry 13 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case0D::
Jump_013_4C67:: ; address name
    ld a, $07
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5D68
    call StartScriptAtHL_B13
    ret

; entry 14 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case0E::
Jump_013_4C78:: ; address name
    ld hl, $0311
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
    ld hl, $0313
    call StartMessageCommand09HL_B13
    ret

; entry 17 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case11::
Jump_013_4C97:: ; address name
    ld hl, $0314
    call StartMessageCommand09HL_B13
    ret

; entry 18 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case04_Case12::
Jump_013_4C9E:: ; address name
    ld hl, $5D6F
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 19 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case13::
Jump_013_4CAA:: ; address name
    ld hl, $0315
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
    ld hl, $5D76
    call StartScriptAtHL_B13
    ret

Jump_013_4CD0::
    ld hl, $031B
    call StartMessageCommand09HL_B13
    ret

Jump_013_4CD7::
    ld de, $01E3
    call TestFlagBit
    jr c, Jump_013_4CE6
    ld hl, $5FCD
    call StartScriptAtHL_B13
    ret

Jump_013_4CE6::
    ld hl, $5FD2
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
    ld hl, $031E
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D16::
    ld hl, $0358
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D1D::
    ld hl, $0ABA
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D24::
    ld hl, $0379
    call StartMessageCommand09HL_B13
    ret

; entry 22 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case16::
Jump_013_4D2B:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D3A
    ld hl, $031F
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D3A::
    ld hl, $0377
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case17::
Jump_013_4D41:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D50
    ld hl, $0320
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D50::
    ld hl, $0378
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
    ld hl, $5D97
    call StartScriptAtHL_B13
    ret

Jump_013_4D7E::
    ld hl, $0323
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D85::
    ld hl, $5DA6
    call StartScriptAtHL_B13
    ret

Jump_013_4D8C::
    ld hl, $0ABB
    call StartMessageCommand09HL_B13
    ret

Jump_013_4D93::
    ld hl, $0376
    call StartMessageCommand09HL_B13
    ret

; entry 25 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case19::
Jump_013_4D9A:: ; address name
    ld hl, $0ABD
    call StartMessageCommand09HL_B13
    ret

; entry 26 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1A::
Jump_013_4DA1:: ; address name
    ld hl, $0ABE
    call StartMessageCommand09HL_B13
    ret

; entry 27 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1B::
Jump_013_4DA8:: ; address name
    ld hl, $0ABC
    call StartMessageCommand09HL_B13
    ret

; entry 28 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1C::
Jump_013_4DAF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DBE
    ld hl, $0324
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DBE::
    ld hl, $0AC3
    call StartMessageCommand09HL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1D::
Jump_013_4DC5:: ; address name
    ld hl, $0325
    call StartMessageCommand09HL_B13
    ret

; entry 30 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1E::
Jump_013_4DCC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DDB
    ld hl, $0326
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DDB::
    ld hl, $0A0C
    call StartMessageCommand09HL_B13
    ret

; entry 31 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case1F::
Jump_013_4DE2:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DF1
    ld hl, $0327
    call StartMessageCommand09HL_B13
    ret

Jump_013_4DF1::
    ld hl, $0AC4
    call StartMessageCommand09HL_B13
    ret

; entry 32 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case20::
Jump_013_4DF8:: ; address name
    ld hl, $0328
    call StartMessageCommand09HL_B13
    ret

; entry 33 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case21::
Jump_013_4DFF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E0E
    ld hl, $0329
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E0E::
    ld hl, $0A0D
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case22::
Jump_013_4E15:: ; address name
    ld hl, $032A
    call StartMessageCommand09HL_B13
    ret

; entry 35 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case23::
Jump_013_4E1C:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E2B
    ld hl, $032B
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E2B::
    ld hl, $0A0E
    call StartMessageCommand09HL_B13
    ret

; entry 36 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case24::
Jump_013_4E32:: ; address name
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4E41
    ld hl, $032C
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E41::
    ld hl, $037B
    call StartMessageCommand09HL_B13
    ret

; entry 37 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case25::
Jump_013_4E48:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E57
    ld hl, $032D
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E57::
    ld hl, $0DF5
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case26::
Jump_013_4E5E:: ; address name
    ld hl, $032E
    call StartMessageCommand09HL_B13
    ret

; entry 39 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case27::
Jump_013_4E65:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E74
    ld hl, $032F
    call StartMessageCommand09HL_B13
    ret

Jump_013_4E74::
    ld hl, $0DF6
    call StartMessageCommand09HL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case28::
Jump_013_4E7B:: ; address name
    ld hl, $0330
    call StartMessageCommand09HL_B13
    ret

; entry 41 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case29::
Jump_013_4E82:: ; address name
    ld a, $0A
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DB0
    call StartScriptAtHL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case2A::
Jump_013_4E93:: ; address name
    ld a, $08
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DB7
    call StartScriptAtHL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case2B::
Jump_013_4EA4:: ; address name
    ld a, $09
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DBE
    call StartScriptAtHL_B13
    ret

; entry 44 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case04_Case2C::
Jump_013_4EB5:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, $5DCC
    call StartScriptAtHL_B13
    ret

; entry 45 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2D::
Jump_013_4EC1:: ; address name
    ld hl, $0312
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2E::
Jump_013_4EC8:: ; address name
    ld hl, $0D3B
    call StartMessageCommand09HL_B13
    ret

; entry 47 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case2F::
Jump_013_4ECF:: ; address name
    ld hl, $0314
    call StartMessageCommand09HL_B13
    ret

; entry 48 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case30::
Jump_013_4ED6:: ; address name
    ld hl, $0313
    call StartMessageCommand09HL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case31::
Jump_013_4EDD:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4EEC
    ld hl, $0334
    call StartMessageCommand09HL_B13
    ret

Jump_013_4EEC::
    ld hl, $0A0F
    call StartMessageCommand09HL_B13
    ret

; entry 50 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case32::
Jump_013_4EF3:: ; address name
    ld hl, $0335
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case33::
Jump_013_4EFA:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4F09
    ld hl, $0336
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F09::
    ld hl, $0A10
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
    ld hl, $0337
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F1F::
    ld a, $34
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_4F3C
    ld hl, $0AE6
    call StartMessageCommand09HL_B13
    ld de, $009E
    call SetFlagBit
    ret

Jump_013_4F3C::
    ld hl, $0D20
    call StartMessageCommand09HL_B13
    ret

; entry 53 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case35::
Jump_013_4F43:: ; address name
    ld hl, $0ABF
    call StartMessageCommand09HL_B13
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case04_Case36::
Jump_013_4F4A:: ; address name
    ld hl, $5DC5
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case37::
Jump_013_4F56:: ; address name
    ld hl, $0338
    call StartMessageCommand09HL_B13
    ret

; entry 56 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case38::
Jump_013_4F5D:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4F6C
    ld hl, $0339
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F6C::
    ld hl, $034E
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
    ld hl, $033A
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F8A::
    ld hl, $034F
    call StartMessageCommand09HL_B13
    ret

Jump_013_4F91::
    ld hl, $037C
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
    ld hl, $033B
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FAF::
    ld hl, $0350
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FB6::
    ld hl, $037D
    call StartMessageCommand09HL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3B::
Jump_013_4FBD:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FCC
    ld hl, $033C
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FCC::
    ld hl, $0351
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
    ld hl, $033D
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FEA::
    ld hl, $0352
    call StartMessageCommand09HL_B13
    ret

Jump_013_4FF1::
    ld hl, $0D1C
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
    ld hl, $033E
    call StartMessageCommand09HL_B13
    ret

Jump_013_500F::
    ld hl, $0353
    call StartMessageCommand09HL_B13
    ret

Jump_013_5016::
    ld hl, $0D1D
    call StartMessageCommand09HL_B13
    ret

; entry 62 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3E::
Jump_013_501D:: ; address name
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_502C
    ld hl, $033F
    call StartMessageCommand09HL_B13
    ret

Jump_013_502C::
    ld hl, $0354
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case3F::
Jump_013_5033:: ; address name
    ld hl, $0340
    call StartMessageCommand09HL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case40::
Jump_013_503A:: ; address name
    ld hl, $0345
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case41::
Jump_013_5041:: ; address name
    ld hl, $0341
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case42::
Jump_013_5048:: ; address name
    ld hl, $0342
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case43::
Jump_013_504F:: ; address name
    ld hl, $0344
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case44::
Jump_013_5056:: ; address name
    ld hl, $0343
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case45::
Jump_013_505D:: ; address name
    ld hl, $5DD3
    call StartScriptAtHL_B13
    ret

; entry 70 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case46::
Jump_013_5064:: ; address name
    ld hl, $5E02
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
    ld hl, $035C
    call StartMessageCommand09HL_B13
    ld de, $0088
    call SetFlagBit
    ret

Jump_013_50CA::
    ld hl, $035D
    call StartMessageCommand09HL_B13
    ret

Jump_013_50D1::
    ld hl, $0367
    call StartMessageCommand09HL_B13
    ld de, $008C
    call SetFlagBit
    ret

Jump_013_50DE::
    ld hl, $0368
    call StartMessageCommand09HL_B13
    ld de, $008D
    call SetFlagBit
    ret

Jump_013_50EB::
    ld hl, $0369
    call StartMessageCommand09HL_B13
    ld de, $008E
    call SetFlagBit
    ret

Jump_013_50F8::
    ld hl, $036A
    call StartMessageCommand09HL_B13
    ret

Jump_013_50FF::
    ld hl, $0373
    call StartMessageCommand09HL_B13
    ret

Jump_013_5106::
    ld hl, $0375
    call StartMessageCommand09HL_B13
    ret

Jump_013_510D::
    ld hl, $0AC2
    call StartMessageCommand09HL_B13
    ret

; entry 73 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case49::
Jump_013_5114:: ; address name
    ld de, $0089
    call TestFlagBit
    jr c, Jump_013_5129
    ld hl, $035E
    call StartMessageCommand09HL_B13
    ld de, $0089
    call SetFlagBit
    ret

Jump_013_5129::
    ld hl, $035F
    call StartMessageCommand09HL_B13
    ret

; entry 74 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4A::
Jump_013_5130:: ; address name
    ld hl, $5E2F
    call StartScriptAtHL_B13
    ret

; entry 75 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4B::
Jump_013_5137:: ; address name
    ld hl, $5E37
    call StartScriptAtHL_B13
    ret

; entry 76 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4C::
Jump_013_513E:: ; address name
    ld hl, $5E5A
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
    ld hl, $036C
    call StartMessageCommand09HL_B13
    ld de, $008F
    call SetFlagBit
    ret

Jump_013_517A::
    ld hl, $036D
    call StartMessageCommand09HL_B13
    ld de, $0090
    call SetFlagBit
    ret

Jump_013_5187::
    ld hl, $036E
    call StartMessageCommand09HL_B13
    ld de, $0091
    call SetFlagBit
    ret

Jump_013_5194::
    ld hl, $036F
    call StartMessageCommand09HL_B13
    ld de, $0092
    call SetFlagBit
    ret

Jump_013_51A1::
    ld hl, $5E67
    call StartScriptAtHL_B13
    ret

Jump_013_51A8::
    ld hl, $5E77
    call StartScriptAtHL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4E::
Jump_013_51AF:: ; address name
    ld hl, $037E
    call StartMessageCommand09HL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case4F::
Jump_013_51B6:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51C5
    ld hl, $037F
    call StartMessageCommand09HL_B13
    ret

Jump_013_51C5::
    ld hl, $0D3D
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case50::
Jump_013_51CC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51DB
    ld hl, $0380
    call StartMessageCommand09HL_B13
    ret

Jump_013_51DB::
    ld hl, $0A11
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case51::
Jump_013_51E2:: ; address name
    ld hl, $0381
    call StartMessageCommand09HL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case52::
Jump_013_51E9:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_51F8
    ld hl, $0382
    call StartMessageCommand09HL_B13
    ret

Jump_013_51F8::
    ld hl, $0DC8
    call StartMessageCommand09HL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case53::
Jump_013_51FF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_520E
    ld hl, $0383
    call StartMessageCommand09HL_B13
    ret

Jump_013_520E::
    ld hl, $0A12
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
    ld hl, $0384
    call StartMessageCommand09HL_B13
    ret

Jump_013_522C::
    ld hl, $0AE0
    call StartMessageCommand09HL_B13
    ret

Jump_013_5233::
    ld hl, $0D22
    call StartMessageCommand09HL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case55::
Jump_013_523A:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5249
    ld hl, $0385
    call StartMessageCommand09HL_B13
    ret

Jump_013_5249::
    ld hl, $0DF3
    call StartMessageCommand09HL_B13
    ret

; entry 86 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case56::
Jump_013_5250:: ; address name
    ld hl, $0386
    call StartMessageCommand09HL_B13
    ret

; entry 87 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case57::
Jump_013_5257:: ; address name
    ld hl, $0387
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case58::
Jump_013_525E:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_526D
    ld hl, $0388
    call StartMessageCommand09HL_B13
    ret

Jump_013_526D::
    ld hl, $0AE1
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case59::
Jump_013_5274:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5283
    ld hl, $0389
    call StartMessageCommand09HL_B13
    ret

Jump_013_5283::
    ld hl, $0AE2
    call StartMessageCommand09HL_B13
    ret

; entry 90 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case5A::
Jump_013_528A:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5299
    ld hl, $038A
    call StartMessageCommand09HL_B13
    ret

Jump_013_5299::
    ld hl, $0D23
    call StartMessageCommand09HL_B13
    ret

; entry 91 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case5B::
Jump_013_52A0:: ; address name
    ld hl, $0312
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
DispatchTalkEvent_Case04_Case5D::
Jump_013_52B8:: ; address name
    ld hl, $0313
    call StartMessageCommand09HL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case04_Case5E::
Jump_013_52BF:: ; address name
    ld hl, $5E87
    call StartScriptAtHL_B13
    ld a, $10
    ld [wDataBank], a
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case5F::
Jump_013_52CB:: ; address name
    ld a, $0B
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5E8E
    call StartScriptAtHL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case60::
Jump_013_52DC:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_52EB
    ld hl, $038C
    call StartMessageCommand09HL_B13
    ret

Jump_013_52EB::
    ld hl, $0A13
    call StartMessageCommand09HL_B13
    ret

; entry 97 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case61::
Jump_013_52F2:: ; address name
    ld hl, $038D
    call StartMessageCommand09HL_B13
    ret

; entry 98 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case62::
Jump_013_52F9:: ; address name
    ld hl, $038E
    call StartMessageCommand09HL_B13
    ret

; entry 99 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case63::
Jump_013_5300:: ; address name
    ld hl, $038F
    call StartMessageCommand09HL_B13
    ret

; entry 100 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case64::
Jump_013_5307:: ; address name
    ld hl, $0390
    call StartMessageCommand09HL_B13
    ret

; entry 101 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case65::
Jump_013_530E:: ; address name
    ld hl, $0391
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
    ld hl, $0392
    call StartMessageCommand09HL_B13
    ret

Jump_013_532C::
    ld hl, $0AB9
    call StartMessageCommand09HL_B13
    ret

Jump_013_5333::
    ld hl, $0ACB
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
    ld hl, $0393
    call StartMessageCommand09HL_B13
    ret

Jump_013_5351::
    ld hl, $0D1E
    call StartMessageCommand09HL_B13
    ret

Jump_013_5358::
    ld hl, $0ADE
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
    ld hl, $5E95
    call StartScriptAtHL_B13
    ret

Jump_013_5376::
    ld hl, $0394
    call StartMessageCommand09HL_B13
    ret

Jump_013_537D::
    ld hl, $0ADF
    call StartMessageCommand09HL_B13
    ret

; entry 105 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case69::
Jump_013_5384:: ; address name
    ld hl, $0397
    call StartMessageCommand09HL_B13
    ret

; entry 106 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6A::
Jump_013_538B:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_539A
    ld hl, $0398
    call StartMessageCommand09HL_B13
    ret

Jump_013_539A::
    ld hl, $0AD8
    call StartMessageCommand09HL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6B::
Jump_013_53A1:: ; address name
    ld hl, $0399
    call StartMessageCommand09HL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6C::
Jump_013_53A8:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53B7
    ld hl, $039A
    call StartMessageCommand09HL_B13
    ret

Jump_013_53B7::
    ld hl, $0DE1
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case6D::
Jump_013_53BE:: ; address name
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53CD
    ld hl, $039B
    call StartMessageCommand09HL_B13
    ret

Jump_013_53CD::
    ld hl, $0AD9
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
    ld hl, $0ADA
    call StartMessageCommand09HL_B13
    ret

Jump_013_53E1::
    ld hl, $039C
    call StartMessageCommand09HL_B13
    ret

; entry 111 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A, wPartyCount, wStepArrived
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
    ld a, [wCB8A]
    cp a, $50
    jr nz, Jump_013_540E
    ld hl, $039D
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
    ld hl, $5EE6
    call StartScriptAtHL_B13
    ret

Jump_013_5428::
    ld hl, $039E
    call StartMessageCommand09HL_B13
    ret

Jump_013_542F::
    ld hl, $039F
    call StartMessageCommand09HL_B13
    ret

Jump_013_5436::
    ld hl, $03A5
    call StartMessageCommand09HL_B13
    ret

Jump_013_543D::
    ld hl, $0ACD
    call StartMessageCommand09HL_B13
    ret

Jump_013_5444::
    ld hl, $0ADB
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case70::
Jump_013_544B:: ; address name
    ld hl, $5EF5
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
    ld hl, $03A4
    call StartMessageCommand09HL_B13
    ret

Jump_013_5469::
    ld hl, $0ACC
    call StartMessageCommand09HL_B13
    ret

Jump_013_5470::
    ld hl, $0ADC
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_5497
    ld hl, $5FA5
    call StartScriptAtHL_B13
    ret

Jump_013_54B5::
    ld hl, $5FAD
    call StartScriptAtHL_B13
    ret

Jump_013_54BC::
    ld hl, $0AD7
    call StartMessageCommand09HL_B13
    ret

Jump_013_54C3::
    ld hl, $0AC5
    call StartMessageCommand09HL_B13
    ret

; entry 115 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case73::
Jump_013_54CA:: ; address name
    ld hl, $03A6
    call StartMessageCommand09HL_B13
    ret

; entry 116 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case74::
Jump_013_54D1:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54E0
    ld hl, $03A7
    call StartMessageCommand09HL_B13
    ret

Jump_013_54E0::
    ld hl, $0AC6
    call StartMessageCommand09HL_B13
    ret

; entry 117 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case75::
Jump_013_54E7:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54F6
    ld hl, $03A8
    call StartMessageCommand09HL_B13
    ret

Jump_013_54F6::
    ld hl, $0A14
    call StartMessageCommand09HL_B13
    ret

; entry 118 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case76::
Jump_013_54FD:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_550C
    ld hl, $03A9
    call StartMessageCommand09HL_B13
    ret

Jump_013_550C::
    ld hl, $0AC7
    call StartMessageCommand09HL_B13
    ret

; entry 119 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case77::
Jump_013_5513:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5522
    ld hl, $03AA
    call StartMessageCommand09HL_B13
    ret

Jump_013_5522::
    ld hl, $0DF4
    call StartMessageCommand09HL_B13
    ret

; entry 120 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case78::
Jump_013_5529:: ; address name
    ld hl, $03AB
    call StartMessageCommand09HL_B13
    ret

; entry 121 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case79::
Jump_013_5530:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_553F
    ld hl, $03AE
    call StartMessageCommand09HL_B13
    ret

Jump_013_553F::
    ld hl, $0A00
    call StartMessageCommand09HL_B13
    ret

; entry 122 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7A::
Jump_013_5546:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5555
    ld hl, $03AD
    call StartMessageCommand09HL_B13
    ret

Jump_013_5555::
    ld hl, $0AFF
    call StartMessageCommand09HL_B13
    ret

; entry 123 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7B::
Jump_013_555C:: ; address name
    ld hl, $03AF
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
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5582
    ld hl, $03B0
    call StartMessageCommand09HL_B13
    ret

Jump_013_5582::
    ldh a, [hPlayerX]
    cp a, $41
    jr nc, Jump_013_558F
    ld hl, $5F26
    call StartScriptAtHL_B13
    ret

Jump_013_558F::
    ld hl, $5F38
    call StartScriptAtHL_B13
    ret

Jump_013_5596::
    ld hl, $03B2
    call StartMessageCommand09HL_B13
    ret

; entry 125 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case04_Case7D::
Jump_013_559D:: ; address name
    ld a, $0C
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5F0B
    call StartScriptAtHL_B13
    ret

; entry 126 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7E::
Jump_013_55AE:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_55BD
    ld hl, $03B4
    call StartMessageCommand09HL_B13
    ret

Jump_013_55BD::
    ld hl, $0A15
    call StartMessageCommand09HL_B13
    ret

; entry 127 of the `rst $00` table in DispatchTalkEvent_Case04
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case04_Case7F::
Jump_013_55C4:: ; address name
    ld hl, $5F12
    call StartScriptAtHL_B13
    ret

Data_013_55CB:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55D7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $E6, $5F, $CD, $49, $40, $C9

Data_013_55DE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55EA:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55F6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $13, $03, $CD, $01, $40, $C9

Data_013_55FD:: ; heuristic: target of a monotone pointer table; C0
    db $21, $12, $03, $CD, $01, $40, $C9

Data_013_5604:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1F, $5F, $CD, $49, $40, $3E, $10, $EA, $FE, $D7, $C9

Data_013_5610:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B8, $03, $CD, $01, $40, $C9

Data_013_5617:: ; heuristic: target of a monotone pointer table; C0
    db $21, $AC, $03, $CD, $01, $40, $C9

Data_013_561E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $96, $03, $CD, $01, $40, $C9

Data_013_5625:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E2, $01, $CD, $1B, $18, $38, $16, $11, $9D, $00, $CD, $1B, $18, $38, $07
    db $21, $B9, $03, $CD, $01, $40, $C9, $21, $E3, $0A, $CD, $01, $40, $C9, $21, $FB
    db $0A, $CD, $01, $40, $C9

Data_013_564A:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E2, $01, $CD, $1B, $18, $38, $07, $21, $D6, $0D, $CD, $01, $40, $C9, $21
    db $FC, $0A, $CD, $01, $40, $C9

; tests story flags in turn (flag $01E2 set: jr to Jump_013_567E; flag $009D set: jr to Jump_013_5677); when none of them branches, starts message $0DD7 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our hearts are like the skies' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0DD7_OurHeartsAreLike:: ; heuristic: target of a pointer table; C0
Func_013_5660:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_567E
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5677
    ld hl, $0DD7
    call StartMessageCommand09HL_B13
    ret

Jump_013_5677::
    ld hl, $0DC9
    call StartMessageCommand09HL_B13
    ret

Jump_013_567E::
    ld hl, $0AFD
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $0DD8, whose string begins 'Queen Helen is wracked by awful'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Talk0DD8_QueenHelenIsWracked:: ; heuristic: target of a pointer table; C0
Func_013_5685:: ; address name
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
    ld hl, $0DD8
    call StartMessageCommand09HL_B13
    ret

Jump_013_56B4::
    ld hl, $0AE4
    call StartMessageCommand09HL_B13
    ret

Jump_013_56BB::
    ld de, $009D
    call TestFlagBit
    jr nc, Jump_013_56AD
    ld a, $34
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_013_56B4
    ld hl, $5FB8
    call StartScriptAtHL_B13
    ret

Jump_013_56DA::
    ld hl, $0AF8
    call StartMessageCommand09HL_B13
    ret

Jump_013_56E1::
    ld hl, $0AF9
    call StartMessageCommand09HL_B13
    ret

Jump_013_56E8::
    ld hl, $0AFA
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0DD9, whose string begins 'The reception hall is beyond here.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0DD9_TheReceptionHallIs:: ; heuristic: target of a pointer table; C0
Func_013_56EF:: ; address name
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_56FF
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5706

Jump_013_56FF::
    ld hl, $0DD9
    call StartMessageCommand09HL_B13
    ret

Jump_013_5706::
    ld hl, $0AE5
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $01E2 set: jr to Jump_013_572B; flag $009D set: jr to Jump_013_5724); when none of them branches, starts message $0DDA through StartMessageCommand09HL_B13 (script command $09); that string begins 'Our Queen Helen's premonition made it' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0DDA_OurQueenHelensPremonition:: ; heuristic: target of a pointer table; C0
Func_013_570D:: ; address name
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_572B
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5724
    ld hl, $0DDA
    call StartMessageCommand09HL_B13
    ret

Jump_013_5724::
    ld hl, $0D1F
    call StartMessageCommand09HL_B13
    ret

Jump_013_572B::
    ld hl, $0AFE
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $01E5 set: jr to Jump_013_5770; flag $01E2 set: jr to Jump_013_5769; flag $01E1 set: jr to Jump_013_575E; flag $01F1 set: jr to Jump_013_5759); when none of them branches, starts message $0DDB through StartMessageCommand09HL_B13 (script command $09); that string begins 'What is it? Leave at once!' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; writes: wCB86
TalkMsg0DDB_WhatIsItLeave:: ; heuristic: target of a pointer table; C0
Func_013_5732:: ; address name
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
    ld hl, $0DDB
    call StartMessageCommand09HL_B13
    ret

Jump_013_5759::
    xor a, a
    ld [wCB86], a
    ret

Jump_013_575E::
    xor a, a
    ld [wCB86], a
    ld hl, $5FCB
    call StartScriptAtHL_B13
    ret

Jump_013_5769::
    ld hl, $0AF7
    call StartMessageCommand09HL_B13
    ret

Jump_013_5770::
    ld hl, $0DE0
    call StartMessageCommand09HL_B13
    ret

Data_013_5777:: ; heuristic: target of a monotone pointer table; C0
    db $21, $FF, $00, $CD, $01, $40, $C9

Data_013_577E:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E5, $01, $CD, $1B, $18, $38, $07, $21, $DC, $0D, $CD, $01, $40, $C9, $21
    db $24, $0D, $CD, $01, $40, $C9

Data_013_5794:: ; heuristic: target of a monotone pointer table; C0
    db $21, $DD, $0D, $CD, $01, $40, $C9

Data_013_579B:: ; heuristic: target of a monotone pointer table; C0
    db $21, $C0, $0A, $CD, $01, $40, $C9

Data_013_57A2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $C1, $0A, $CD, $01, $40, $C9

Data_013_57A9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $BC, $0A, $CD, $01, $40, $C9

Data_013_57B0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4A, $5F, $CD, $49, $40, $C9

Data_013_57B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04D7B7, $4C

Data_013_5803:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $9A, $CB, $FE, $80, $20, $0E, $FA, $9B, $CB, $FE, $10, $20, $07, $21, $CE
    db $0A, $CD, $01, $40, $C9, $21, $AD, $5F, $CD, $49, $40, $C9

Data_013_581F:: ; heuristic: target of a monotone pointer table; C0
    db $21, $16, $0A, $CD, $01, $40, $C9

Data_013_5826:: ; heuristic: target of a monotone pointer table; C0
    db $11, $9F, $00, $CD, $1B, $18, $38, $02, $18, $07, $21, $E8, $0A, $CD, $01, $40
    db $C9, $CD, $94, $7F, $30, $17, $36, $34, $FA, $36, $C8, $CB, $F7, $EA, $36, $C8
    db $21, $E7, $0A, $CD, $01, $40, $11, $9F, $00, $CD, $45, $18, $C9, $21, $E9, $0A
    db $CD, $01, $40, $C9

Data_013_585A:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $03, $EA, $21, $C9, $3E, $00, $EA, $22, $C9, $11, $E0, $01, $CD, $25, $40
    db $C9

Data_013_586B:: ; heuristic: target of a monotone pointer table; C0
    db $AF, $EA, $A6, $CB, $C9

Data_013_5870:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D2, $5F, $CD, $49, $40, $C9

Data_013_5877:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $94, $7F, $38, $07, $21, $27, $0D, $CD, $01, $40, $C9, $36, $32, $FA, $36
    db $C8, $CB, $F7, $EA, $36, $C8, $21, $DD, $5F, $CD, $49, $40, $C9

Data_013_5894:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $32, $E0, $C6, $21, $CE, $7D, $06, $12, $D7, $21, $F1, $7D, $06, $12, $D7
    db $21, $D4, $5F, $CD, $49, $40, $C9

; wScriptParam0 = 00, wScriptParam1 = 25, then StartMessageScriptDE_B13 with DE = $01E9: starts message group 1, string $E9; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01E9:: ; heuristic: target of a pointer table; C0
Func_013_58AB:: ; address name
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
Msg01EA:: ; heuristic: target of a pointer table; C0
Func_013_58BC:: ; address name
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
Msg01EB:: ; heuristic: target of a pointer table; C0
Func_013_58CD:: ; address name
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
Msg01EC:: ; heuristic: target of a pointer table; C0
Func_013_58DE:: ; address name
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
Msg01ED:: ; heuristic: target of a pointer table; C0
Func_013_58EF:: ; address name
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
Msg01EE:: ; heuristic: target of a pointer table; C0
Func_013_5900:: ; address name
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
Msg01EF:: ; heuristic: target of a pointer table; C0
Func_013_5911:: ; address name
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
Msg01F0:: ; heuristic: target of a pointer table; C0
Func_013_5922:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1E
    ld [wScriptParam1], a
    ld de, $01F0
    call StartMessageScriptDE_B13
    ret
    db $21, $C9, $5F, $CD, $49, $40, $C9

; entry 8 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case08::
Jump_013_593A:: ; address name
    ld hl, $512D
    call StartScriptAtHL_B13
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wC916
DispatchTalkEvent_Case01::
Jump_013_5941:: ; address name
    ld a, [wC916]
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
    db $D2, $70
    dw TalkMsg0A3C_KingIfYouSee
    dw TalkMsg0A3E_YoureFreeToGo
    dw TalkMsg0A3F_TheKingAndPrinces
    dw Talk0A41_ThisIsGreatLogCastle
    db $39, $73, $40, $73, $56, $73, $5D, $73
    dw Talk0A49_BreedingCouldResultIn
    dw TalkMsg0A4A_FromUpHerePeople
    dw Msg0126_WarubouThereYourPartys
    dw TalkMsg0A4C_GreatLogCastleWasMade
    dw TalkMsg0A4D_TheIslandUsedTo
    dw Talk04BA_IfYouGetAn
    dw Talk04CB_ThatKeyIUsed
    dw Talk04CE_HeroCheckedTheShelf
    db $1F, $75, $26, $75, $72, $75, $79, $75, $80, $75, $80, $75, $80, $75
    dw TalkMsg0504_IfTheIslandSink
    dw TalkMsg0512_KamehaYo0Thanks
    dw Msg011B_HmAreYouA
    dw Msg011C_OhHiGoodTo
    dw Talk04C0_AllRightyWellDo
    dw Talk0276_IfYouWantTo
    dw StartScript5709Or56F5IfFlagD1
    dw Data_013_7727
    dw Data_013_774B
    dw Data_013_7752
    dw Data_013_7759
    dw Data_013_7760
    dw Data_013_7767
    dw Data_013_7788
    dw Data_013_778F
    dw Data_013_77A0
    dw Data_013_77B6
    dw Talk0043_HeroCheckedTheOdd
    dw Talk0036_ThereWereManyWild
    dw Talk0037_HeroTriedToOpen
    dw StartScript5660WithBank0E
    dw TalkMsg0268_YepShesTakingGood
    dw Data_013_7852
    dw Data_013_7859
    dw Data_013_7860
    dw Data_013_7876
    dw Data_013_787D
    dw Data_013_78A2
    dw Data_013_78B9
    dw Data_013_78D0
    dw Data_013_78D7
    dw Talk08D1_TheEvaluatorSaidI
    dw Talk04D2_UpAheadIsThe
    dw TalkMsg021F_DoYouKnowAbout
    dw TalkMsg0220_InOtherWorldsYoull
    dw TalkMsg027F_ItsNotEasyTo
    dw TalkMsg0280_MamaIsABig
    dw Data_013_799A
    dw Data_013_79A1
    dw Data_013_79A8
    dw Data_013_79AF
    dw Data_013_79B6
    dw Data_013_79BD
    dw Data_013_79C4
    dw Data_013_79DA
    dw Data_013_79F0
    dw Data_013_79F7
    dw Data_013_79FE
    dw Data_013_7A0F
    dw Data_013_7A16
    dw Data_013_7A1D
    dw Data_013_7A2E
    dw Data_013_7A35
    dw Data_013_7A4A
    dw Data_013_7A93
    dw Talk00FC_YouHaveToEat
    dw TalkMsg0A74_TheMedalMasterWas
    dw IfFlag0023StartScript57A2
    dw Msg013C_ISawALake
    dw Msg013D_StrongMonstersAreIn
    dw TalkMsg0A35_ImABugSo
    db $04, $7B
    dw TalkMsg0A68_MyEmyuIsVery
    dw TalkMsg0A6B_MonstersLookSoFrightening
    dw Talk0A40_PleaseEnterTheKing
    dw TalkMsg0A4B_OnTheHorizonYou
    dw Data_013_7B8A
    dw Data_013_7B91
    dw Data_013_7CF7
    dw Data_013_7CFE
    dw Data_013_7D05
    dw Data_013_7D0C
    dw Data_013_7D13
    dw Data_013_7D1A
    dw Data_013_7D21
    dw Data_013_7D28
    dw Data_013_7D2F
    dw Data_013_7D45
    dw Data_013_7D65
    dw Data_013_7D8C
    db $00, $00
    dw TalkMsg029B_IFoundAKey
    dw Talk0DE3_TheSeaIsHuge
    dw TalkMsg0220_InOtherWorldsYoull_7DC5
    dw Msg013E_OurKingHasBeen
    dw Msg013F_TheCircusMasterWas
    db $FD, $7D, $00, $00
    dw Talk0B56_WhenYouBreedMonsters
    dw Talk0B6D_BreedingFireAndIce
    dw Talk0D90_HumphImTerryTerry
    dw SetWCB8A30IfFlag25AndCountAtLeast50
    dw SetFlagsC9AndCAFrom32And33
    dw SetFlagsCBAndCCFrom35And36
    dw IfFlag0021StartScript5988

; entry 0 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case00::
Jump_013_5B33:: ; address name
    ret

; entry 1 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case01::
Jump_013_5B34:: ; address name
    ld hl, $5895
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
    ld hl, $4FA4
    call StartScriptAtHL_B13
    ret

Jump_013_5B86::
    ld hl, $0022
    call StartMessageCommand09HL_B13
    ret

Jump_013_5B8D::
    ld de, $000D
    call TestFlagBit
    jr c, Jump_013_5BAC
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ld hl, $4FAF
    call StartScriptAtHL_B13
    ld de, $000D
    call SetFlagBit
    ret

Jump_013_5BAC::
    ld hl, $006C
    call StartMessageCommand09HL_B13
    ret

Jump_013_5BB3::
    ld de, $01A7
    call TestFlagBit
    jr c, Jump_013_5BC0
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_5BC7

Jump_013_5BC0::
    ld hl, $0102
    call StartMessageCommand09HL_B13
    ret

Jump_013_5BC7::
    ld [hl], $01
    ld hl, $5175
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
    ld hl, $0500
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
    ld hl, $0D91
    call StartMessageCommand09HL_B13
    ld de, $018A
    call SetFlagBit
    ret

Jump_013_5C04::
    ld hl, $0B00
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
    ld hl, $517F
    call StartScriptAtHL_B13
    ld de, $0104
    call SetFlagBit
    ld de, $0180
    call SetFlagBit
    ret

Jump_013_5C36::
    ld a, $02
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5C4D
    ld hl, $0202
    call StartMessageCommand09HL_B13
    ret

Jump_013_5C4D::
    farcall RemoveInventorySlotShiftDown
    ld hl, $522B
    call StartScriptAtHL_B13
    ld de, $0181
    call SetFlagBit
    ret

Jump_013_5C60::
    ld hl, $0214
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
    ld hl, $5189
    call StartScriptAtHL_B13
    ret

Jump_013_5C84::
    ld a, $04
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5C9B
    ld hl, $08A5
    call StartMessageCommand09HL_B13
    ret

Jump_013_5C9B::
    ld hl, $519F
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
    ld hl, $51A9
    call StartScriptAtHL_B13
    ret

Jump_013_5CBF::
    ld a, $1B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5CD6
    ld hl, $08AA
    call StartMessageCommand09HL_B13
    ret

Jump_013_5CD6::
    ld hl, $51BF
    call StartScriptAtHL_B13
    farcall RemoveInventorySlotShiftDown
    ret

Jump_013_5CE3::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5CF2
    ld hl, $0205
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
    ld hl, $51F5
    call StartScriptAtHL_B13
    ret

Jump_013_5D11::
    ld hl, $520B
    call StartScriptAtHL_B13
    ret

Jump_013_5D18::
    ld a, $1C
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5D2F
    ld hl, $0A27
    call StartMessageCommand09HL_B13
    ret

Jump_013_5D2F::
    farcall RemoveInventorySlotShiftDown
    ld hl, $5221
    call StartScriptAtHL_B13
    ret

Jump_013_5D3C::
    ld hl, $0A2A
    call StartMessageCommand09HL_B13
    ret

; entry 3 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case03::
Jump_013_5D43:: ; address name
    ld hl, $0023
    call StartMessageCommand09HL_B13
    ret

; entry 4 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case04::
Jump_013_5D4A:: ; address name
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5D59
    ld hl, $001B
    call StartMessageCommand09HL_B13
    ret

Jump_013_5D59::
    ld de, $012A
    call TestFlagBit
    jr c, Jump_013_5D68
    ld hl, $596B
    call StartScriptAtHL_B13
    ret

Jump_013_5D68::
    ld hl, $597B
    call StartScriptAtHL_B13
    ret

; entry 5 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case05::
Jump_013_5D6F:: ; address name
    ld hl, $0026
    call StartMessageCommand09HL_B13
    ret

; entry 6 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case06::
Jump_013_5D76:: ; address name
    ld hl, $0027
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
    ld hl, $0016
    call StartMessageCommand09HL_B13
    ret

Jump_013_5DDA::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5DE9
    ld hl, $4FB7
    call StartScriptAtHL_B13
    ret

Jump_013_5DE9::
    ld hl, $4FD0
    call StartScriptAtHL_B13
    ret

Jump_013_5DF0::
    ld hl, $002E
    call StartMessageCommand09HL_B13
    ret

Jump_013_5DF7::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5E06
    ld hl, $4FE8
    call StartScriptAtHL_B13
    ret

Jump_013_5E06::
    ld hl, $4FF7
    call StartScriptAtHL_B13
    ret

Jump_013_5E0D::
    ld hl, $0064
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E14::
    ld de, $0100
    call TestFlagBit
    jr c, Jump_013_5E37
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_5E28
    ld hl, $0107
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E28::
    ld [hl], $1A
    ld hl, $52DC
    call StartScriptAtHL_B13
    ld de, $0100
    call SetFlagBit
    ret

Jump_013_5E37::
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_013_5E45
    ld hl, $0107
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E45::
    ld de, $0101
    call TestFlagBit
    jr c, Jump_013_5E5A
    ld hl, $0108
    call StartMessageCommand09HL_B13
    ld de, $0101
    call SetFlagBit
    ret

Jump_013_5E5A::
    ld hl, $0109
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E61::
    ld hl, $0204
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E68::
    call DispatchTalkEvent_Case01_Case07_Sub01
    ret

Jump_013_5E6C::
    ld hl, $0A2B
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E73::
    ld hl, $0501
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
    ld hl, $0B01
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E93::
    cp a, $1E
    jr nc, Jump_013_5E9E
    ld hl, $0DE7
    call StartMessageCommand09HL_B13
    ret

Jump_013_5E9E::
    cp a, $28
    jr nc, Jump_013_5EA9
    ld hl, $0DE8
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EA9::
    cp a, $32
    jr nc, Jump_013_5EB4
    ld hl, $0DE9
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EB4::
    cp a, $64
    jr nc, Jump_013_5EBF
    ld hl, $0DEA
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EBF::
    cp a, $96
    jr nc, Jump_013_5ECA
    ld hl, $0DEB
    call StartMessageCommand09HL_B13
    ret

Jump_013_5ECA::
    cp a, $C8
    jr nc, Jump_013_5ED5
    ld hl, $0DEC
    call StartMessageCommand09HL_B13
    ret

Jump_013_5ED5::
    cp a, $FA
    jr nc, Jump_013_5EE0
    ld hl, $0DED
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EE0::
    ld hl, $0DEE
    call StartMessageCommand09HL_B13
    ret

Jump_013_5EE7::
    ldh a, [hTemp0]
    cp a, $38
    jr c, Jump_013_5EE0
    ld hl, $0DEF
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
    ld hl, $52E3
    call StartScriptAtHL_B13
    ret

Jump_013_5F0C::
    ld hl, $005A
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesHFFC6
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_5F28
    ld hl, $52E3
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
    ld hl, $530D
    call StartScriptAtHL_B13
    ret

Jump_013_5F47::
    ld hl, $5324
    call StartScriptAtHL_B13
    ret

Jump_013_5F4E::
    ld hl, $52F3
    call StartScriptAtHL_B13
    ret

Jump_013_5F55::
    ld hl, $08B2
    call StartMessageCommand09HL_B13
    ret

Jump_013_5F5C::
    ld hl, $08B6
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
    ld hl, $0017
    call StartMessageCommand09HL_B13
    ld de, $0004
    call SetFlagBit
    ret

Jump_013_5F80::
    ld hl, $0018
    call StartMessageCommand09HL_B13
    ret

Jump_013_5F87::
    ld hl, $0065
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
    ld hl, $0019
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FB6::
    ld hl, $002F
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FBD::
    ld hl, $0066
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FC4::
    ld hl, $010A
    call StartMessageCommand09HL_B13
    ret

Jump_013_5FCB::
    ld hl, $0B08
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
    ld hl, $0032
    call StartMessageCommand09HL_B13
    ret

Jump_013_6009::
    ld de, $0010
    call TestFlagBit
    jr c, Jump_013_601E
    ld hl, $0068
    call StartMessageCommand09HL_B13
    ld de, $0010
    call SetFlagBit
    ret

Jump_013_601E::
    ld hl, $0069
    call StartMessageCommand09HL_B13
    ret

Jump_013_6025::
    ld hl, $010C
    call StartMessageCommand09HL_B13
    ret

Jump_013_602C::
    ld hl, $020B
    call StartMessageCommand09HL_B13
    ret

Jump_013_6033::
    ld hl, $0505
    call StartMessageCommand09HL_B13
    ret

Jump_013_603A::
    ld hl, $053F
    call StartMessageCommand09HL_B13
    ret

Jump_013_6041::
    ld hl, $0B0D
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
    ld hl, $003C
    call StartMessageCommand09HL_B13
    ret

Jump_013_607F::
    ld hl, $4F66
    call StartScriptAtHL_B13
    ret

Jump_013_6086::
    ld hl, $0073
    call StartMessageCommand09HL_B13
    ld de, $000F
    call SetFlagBit
    ret

Jump_013_6093::
    ld hl, $011B
    call StartMessageCommand09HL_B13
    ret

Jump_013_609A::
    ld hl, $0D0D
    call StartMessageCommand09HL_B13
    ret

Jump_013_60A1::
    ld hl, $0D30
    call StartMessageCommand09HL_B13
    ret

Jump_013_60A8::
    ld hl, $0D88
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
    ld hl, $0040
    call StartMessageCommand09HL_B13
    ret

Jump_013_60E6::
    ld hl, $0072
    call StartMessageCommand09HL_B13
    ret

Jump_013_60ED::
    ld hl, $011A
    call StartMessageCommand09HL_B13
    ret

Jump_013_60F4::
    ld hl, $08CE
    call StartMessageCommand09HL_B13
    ret

Jump_013_60FB::
    ld hl, $050C
    call StartMessageCommand09HL_B13
    ret

Jump_013_6102::
    ld hl, $0541
    call StartMessageCommand09HL_B13
    ret

Jump_013_6109::
    ld hl, $0B11
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
    ld hl, $00FD
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
    ld hl, $0034
    call StartMessageCommand09HL_B13
    ret

Jump_013_614E::
    ld hl, $0074
    call StartMessageCommand09HL_B13
    ret

Jump_013_6155::
    ld hl, $0114
    call StartMessageCommand09HL_B13
    ret

Jump_013_615C::
    ld hl, $020C
    call StartMessageCommand09HL_B13
    ret

Jump_013_6163::
    ld hl, $0B19
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
    ld hl, $020F
    call StartMessageCommand09HL_B13
    ret

Jump_013_6181::
    ld hl, $0507
    call StartMessageCommand09HL_B13
    ret

Jump_013_6188::
    ld hl, $0B18
    call StartMessageCommand09HL_B13
    ret

; entry 16 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wCC37
; writes: wCC37, wD7FB, wDataBank
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
    ld hl, $003A
    call StartMessageCommand09HL_B13
    ret

Jump_013_61B6::
    ld de, $0011
    call TestFlagBit
    jr c, Jump_013_61D3
    ld a, [wCC37]
    set 0, a
    ld [wCC37], a
    ld hl, $0077
    call StartMessageCommand09HL_B13
    ld de, $0011
    call SetFlagBit
    ret

Jump_013_61D3::
    ld hl, $0078
    call StartMessageCommand09HL_B13
    ret

Jump_013_61DA::
    ld de, $010B
    call TestFlagBit
    jr c, Jump_013_61EF
    ld hl, $08C1
    call StartMessageCommand09HL_B13
    ld de, $010B
    call SetFlagBit
    ret

Jump_013_61EF::
    ld hl, $08C2
    call StartMessageCommand09HL_B13
    ret

Jump_013_61F6::
    ld hl, $0506
    call StartMessageCommand09HL_B13
    ret

Jump_013_61FD::
    ld a, $02
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld de, $012C
    call TestFlagBit
    jr c, Jump_013_6216
    ld hl, Data_010_57ED
    call StartScriptAtHL_B13
    ret

Jump_013_6216::
    ld hl, $57F7
    call StartScriptAtHL_B13
    ret

; entry 17 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
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
    ld hl, $0035
    call StartMessageCommand09HL_B13
    ret

Jump_013_6244::
    ld hl, $0075
    call StartMessageCommand09HL_B13
    ret

Jump_013_624B::
    ld hl, $0115
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
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_533E
    call StartScriptAtHL_B13
    ld de, $0106
    call SetFlagBit
    ret

Jump_013_6279::
    ld a, $00
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5345
    call StartScriptAtHL_B13
    ret

Jump_013_628A::
    ld de, $00CE
    call TestFlagBit
    jr c, Jump_013_6279
    ld a, $00
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_534C
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
    ld hl, $003B
    call StartMessageCommand09HL_B13
    ret

Jump_013_62D8::
    ld hl, $006D
    call StartMessageCommand09HL_B13
    ret

Jump_013_62DF::
    ld hl, $0116
    call StartMessageCommand09HL_B13
    ret

Jump_013_62E6::
    ld hl, $0D0E
    call StartMessageCommand09HL_B13
    ret

Jump_013_62ED::
    ld hl, $0540
    call StartMessageCommand09HL_B13
    ret

Jump_013_62F4::
    ld hl, $0B0F
    call StartMessageCommand09HL_B13
    ret

; entry 19 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case13::
Jump_013_62FB:: ; address name
    ld hl, $0038
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
    ld hl, $0041
    call StartMessageCommand09HL_B13
    ret

Jump_013_6319::
    ld hl, $0070
    call StartMessageCommand09HL_B13
    ret

Jump_013_6320::
    ld hl, $0119
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
    ld hl, $003D
    call StartMessageCommand09HL_B13
    ret

Jump_013_6366::
    ld hl, $006E
    call StartMessageCommand09HL_B13
    ret

Jump_013_636D::
    ld hl, $0117
    call StartMessageCommand09HL_B13
    ret

Jump_013_6374::
    ld hl, $0210
    call StartMessageCommand09HL_B13
    ret

Jump_013_637B::
    ld hl, $08C3
    call StartMessageCommand09HL_B13
    ret

Jump_013_6382::
    ld hl, $0508
    call StartMessageCommand09HL_B13
    ret

Jump_013_6389::
    ld hl, $0542
    call StartMessageCommand09HL_B13
    ret

Jump_013_6390::
    ld hl, $0B1A
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
    ld hl, $003F
    call StartMessageCommand09HL_B13
    ret

Jump_013_63D6::
    ld hl, $0052
    call StartMessageCommand09HL_B13
    ret

Jump_013_63DD::
    ld hl, $006F
    call StartMessageCommand09HL_B13
    ret

Jump_013_63E4::
    ld hl, $0118
    call StartMessageCommand09HL_B13
    ret

Jump_013_63EB::
    ld hl, $0211
    call StartMessageCommand09HL_B13
    ret

Jump_013_63F2::
    ld hl, $08C4
    call StartMessageCommand09HL_B13
    ret

Jump_013_63F9::
    ld hl, $0509
    call StartMessageCommand09HL_B13
    ret

Jump_013_6400::
    ld hl, $0B1B
    call StartMessageCommand09HL_B13
    ret

; entry 23 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX
; writes: hTemp0, wCBD3, wCBD4
DispatchTalkEvent_Case01_Case17::
Jump_013_6407:: ; address name
    ld de, $0009
    call TestFlagBit
    jr c, Jump_013_641C
    ld hl, $004A
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
    ld hl, $004B
    call StartMessageCommand09HL_B13
    ret

Jump_013_6431::
    ld hl, $004F
    call StartMessageCommand09HL_B13
    ret

Jump_013_6438::
    ldh a, [hMapScreenX]
    cp a, $02
    jr nz, Jump_013_642A
    ld hl, $4F8D
    call StartScriptAtHL_B13
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ld a, $20
    ld [wCBD3], a
    ld a, $50
    ld [wCBD4], a
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
    ld hl, $0048
    call StartMessageCommand09HL_B13
    ld de, $0008
    call SetFlagBit
    ret

Jump_013_6474::
    ld hl, $0049
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
    ld hl, $005F
    call StartMessageCommand09HL_B13
    ret

Jump_013_64D6::
    ld a, $02
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ld de, $0016
    call TestFlagBit
    jr c, Jump_013_64EF
    ld hl, $5006
    call StartScriptAtHL_B13
    ret

Jump_013_64EF::
    ld hl, $5029
    call StartScriptAtHL_B13
    ret

Jump_013_64F6::
    ld hl, $0082
    call StartMessageCommand09HL_B13
    ret

Jump_013_64FD::
    ld hl, $536E
    call StartScriptAtHL_B13
    ret

Jump_013_6504::
    ld de, $01A0
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $012F
    call TestFlagBit
    jr c, Jump_013_651B
    ld hl, $029E
    call StartMessageCommand09HL_B13
    ret

Jump_013_651B::
    ld hl, $02A4
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
    ld hl, $0D1A
    call StartMessageCommand09HL_B13
    ret

Jump_013_6546::
    ld hl, $0D1B
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
    ld hl, $0D2A
    call StartMessageCommand09HL_B13
    ret

Jump_013_656A::
    ld hl, $0D2B
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
    ld hl, $53AD
    call StartScriptAtHL_B13
    ret

Jump_013_6590::
    ld hl, $53BA
    call StartScriptAtHL_B13
    ret

Jump_013_6597::
    ld hl, $0532
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
    ld hl, $53D0
    call StartScriptAtHL_B13
    ret

Jump_013_65CA::
    ldh a, [hTemp0]
    cp a, $FA
    jr c, Jump_013_65D7

Jump_013_65D0::
    ld hl, $53CE
    call StartScriptAtHL_B13
    ret

Jump_013_65D7::
    ld hl, $0B26
    call StartMessageCommand09HL_B13
    ret

Jump_013_65DE::
    ld hl, $0B2D
    call StartMessageCommand09HL_B13
    ret

Jump_013_65E5::
    ld hl, $0BA8
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
    ld hl, $001A
    call StartMessageCommand09HL_B13
    ret

Jump_013_6613::
    ld hl, $0067
    call StartMessageCommand09HL_B13
    ret

Jump_013_661A::
    ld hl, $010B
    call StartMessageCommand09HL_B13
    ret

Jump_013_6621::
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_6630
    ld hl, $0203
    call StartMessageCommand09HL_B13
    ret

Jump_013_6630::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_663F
    ld hl, $0215
    call StartMessageCommand09HL_B13
    ret

Jump_013_663F::
    ld hl, $08AE
    call StartMessageCommand09HL_B13
    ret

Jump_013_6646::
    ld hl, $0B04
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
    ld hl, $0103
    call StartMessageCommand09HL_B13
    ret

Jump_013_668C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5256
    call StartScriptAtHL_B13
    ret

Jump_013_669B::
    ld hl, $5260
    call StartScriptAtHL_B13
    ret

Jump_013_66A2::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5267
    call StartScriptAtHL_B13
    ret

Jump_013_66B1::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5271
    call StartScriptAtHL_B13
    ret

Jump_013_66C0::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $527B
    call StartScriptAtHL_B13
    ret

Jump_013_66CF::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5285
    call StartScriptAtHL_B13
    ret

Jump_013_66DE::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $528F
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
    ld hl, $0104
    call StartMessageCommand09HL_B13
    ret

Jump_013_672C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $5299
    call StartScriptAtHL_B13
    ret

Jump_013_673B::
    ld hl, $52A3
    call StartScriptAtHL_B13
    ret

Jump_013_6742::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52AA
    call StartScriptAtHL_B13
    ret

Jump_013_6751::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52B4
    call StartScriptAtHL_B13
    ret

Jump_013_6760::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52BE
    call StartScriptAtHL_B13
    ret

Jump_013_676F::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52C8
    call StartScriptAtHL_B13
    ret

Jump_013_677E::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52D2
    call StartScriptAtHL_B13
    ret

; entry 29 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1D::
Jump_013_678D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_679C
    ld hl, $011E
    call StartMessageCommand09HL_B13
    ret

Jump_013_679C::
    ld hl, $0B1D
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
    ld hl, $021F
    call StartMessageCommand09HL_B13
    ret

Jump_013_67BB::
    ld hl, $0DE5
    call StartMessageCommand09HL_B13
    ret

Jump_013_67C2::
    ld hl, $0B14
    call StartMessageCommand09HL_B13
    ret

; entry 31 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case1F::
Jump_013_67C9:: ; address name
    ld hl, $04D0
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
    ld hl, $003E
    call StartMessageCommand09HL_B13
    ret

Jump_013_67FF::
    ld hl, $0071
    call StartMessageCommand09HL_B13
    ret

Jump_013_6806::
    ld hl, $021B
    call StartMessageCommand09HL_B13
    ret

Jump_013_680D::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, $53D2
    call StartScriptAtHL_B13
    ret

Jump_013_681C::
    ld hl, $0A3D
    call StartMessageCommand09HL_B13
    ret

Jump_013_6823::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, $53FA
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
    ld hl, $5418
    call StartScriptAtHL_B13
    ld de, $0107
    call SetFlagBit
    ret

Jump_013_684F::
    ld hl, $021E
    call StartMessageCommand09HL_B13
    ret

Jump_013_6856::
    ld hl, $0B10
    call StartMessageCommand09HL_B13
    ret

; entry 34 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case22::
Jump_013_685D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_686C
    ld hl, $021C
    call StartMessageCommand09HL_B13
    ret

Jump_013_686C::
    ld hl, $0B0E
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
    ld hl, $0221
    call StartMessageCommand09HL_B13
    ret

Jump_013_688A::
    ld hl, $0521
    call StartMessageCommand09HL_B13
    ret

Jump_013_6891::
    ld hl, $0B2F
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
    ld hl, $0222
    call StartMessageCommand09HL_B13
    ret

Jump_013_68AF::
    ld hl, $0522
    call StartMessageCommand09HL_B13
    ret

Jump_013_68B6::
    ld hl, $0B30
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
    ld hl, $0223
    call StartMessageCommand09HL_B13
    ret

Jump_013_68D4::
    ld hl, $0543
    call StartMessageCommand09HL_B13
    ret

; entry 38 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case26::
Jump_013_68DB:: ; address name
    ld hl, $0224
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
    farcall FindPartyIndexOfSpeciesHFFC6
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_691C

Jump_013_6915::
    ld hl, $0263
    call StartMessageCommand09HL_B13
    ret

Jump_013_691C::
    ld hl, $5422
    call StartScriptAtHL_B13
    ret

Jump_013_6923::
    ld hl, $0267
    call StartMessageCommand09HL_B13
    ret

Jump_013_692A::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6939
    ld hl, $0D32
    call StartMessageCommand09HL_B13
    ret

Jump_013_6939::
    ld hl, $0528
    call StartMessageCommand09HL_B13
    ret

Jump_013_6940::
    ld hl, $5433
    call StartScriptAtHL_B13
    ret

; entry 40 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case28::
Jump_013_6947:: ; address name
    ld hl, $0D8C
    call StartMessageCommand09HL_B13
    ret

; entry 41 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case29::
Jump_013_694E:: ; address name
    ld hl, $0D8D
    call StartMessageCommand09HL_B13
    ret

; entry 42 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2A::
Jump_013_6955:: ; address name
    ld hl, $022D
    call StartMessageCommand09HL_B13
    ret

; entry 43 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2B::
Jump_013_695C:: ; address name
    ld hl, $5476
    call StartScriptAtHL_B13
    ret

; entry 44 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2C::
Jump_013_6963:: ; address name
    ld hl, $022C
    call StartMessageCommand09HL_B13
    ret

; entry 45 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2D::
Jump_013_696A:: ; address name
    ld hl, $0005
    call StartMessageCommand09HL_B13
    ret

; entry 46 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case2E::
Jump_013_6971:: ; address name
    ld hl, $0006
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
    ld hl, $50DB
    call StartScriptAtHL_B13
    ret

Jump_013_6994::
    ld hl, $50F6
    call StartScriptAtHL_B13
    ret

; entry 48 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case30::
Jump_013_699B:: ; address name
    ld hl, $5120
    call StartScriptAtHL_B13
    ret

; entry 49 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case31::
Jump_013_69A2:: ; address name
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_69B1
    ld hl, $000A
    call StartMessageCommand09HL_B13
    ret

Jump_013_69B1::
    ld hl, $000E
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
    ld hl, $000D
    call StartMessageCommand09HL_B13
    ret

; entry 51 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wC916
; writes: hTemp1, hTemp2, hTemp3
DispatchTalkEvent_Case01_Case33::
Jump_013_69DA:: ; address name
    farcall ClearWD7F5IfAtOrAboveLimitForWC7C7
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_69EE
    ld hl, $0D62
    call StartMessageCommand09HL_B13
    ret

Jump_013_69EE::
    ld a, [wC916]
    sub a, $33
    add a, $63
    ld l, a
    ld h, $0D
    call StartMessageCommand09HL_B13
    ld a, [wC916]
    sub a, $33
    add a, $06
    ldh [hTemp1], a
    ld a, [wD7F5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindHFFC7
    ret

; entry 54 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case36::
Jump_013_6A14:: ; address name
    ld hl, $0BAC
    call StartMessageCommand09HL_B13
    ret

; entry 55 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case37::
Jump_013_6A1B:: ; address name
    ld hl, $0D84
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
    ld hl, $023F
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A39::
    ld hl, $0523
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A40::
    ld hl, $0D8B
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
    ld hl, $0240
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A5E::
    ld hl, $0524
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A65::
    ld hl, $0B31
    call StartMessageCommand09HL_B13
    ret

; entry 58 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3A::
Jump_013_6A6C:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A7B
    ld hl, $0241
    call StartMessageCommand09HL_B13
    ret

Jump_013_6A7B::
    ld hl, $0B32
    call StartMessageCommand09HL_B13
    ret

; entry 59 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3B::
Jump_013_6A82:: ; address name
    ld hl, $0243
    call StartMessageCommand09HL_B13
    ret

; entry 60 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3C::
Jump_013_6A89:: ; address name
    ld hl, $0244
    call StartMessageCommand09HL_B13
    ret

; entry 61 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3D::
Jump_013_6A90:: ; address name
    ld hl, $0245
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
    ld hl, $5483
    call StartScriptAtHL_B13
    ret

Jump_013_6AAE::
    ld hl, $0526
    call StartMessageCommand09HL_B13
    ret

Jump_013_6AB5::
    ld hl, $0B42
    call StartMessageCommand09HL_B13
    ret

; entry 63 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case3F::
Jump_013_6ABC:: ; address name
    ld hl, $0249
    call StartMessageCommand09HL_B13
    ret

; entry 64 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case40::
Jump_013_6AC3:: ; address name
    ld hl, $0256
    call StartMessageCommand09HL_B13
    ret

; entry 65 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case41::
Jump_013_6ACA:: ; address name
    ld hl, $02B0
    call StartMessageCommand09HL_B13
    ret

; entry 66 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5
; writes: hTemp1, hTemp2, hTemp3
DispatchTalkEvent_Case01_Case42::
Jump_013_6AD1:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6AEF
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6AE8
    ld hl, $5490
    call StartScriptAtHL_B13
    ret

Jump_013_6AE8::
    ld hl, $0525
    call StartMessageCommand09HL_B13
    ret

Jump_013_6AEF::
    ld de, $00CD
    call TestFlagBit
    jr c, Jump_013_6B2B
    farcall ClearWD7F5IfAtOrAboveLimitForWC7C7
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_6B0B
    ld hl, $0B44
    call StartMessageCommand09HL_B13
    ret

Jump_013_6B0B::
    ld a, $02
    ldh [hTemp1], a
    ld a, [wD7F5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindHFFC7
    ld hl, $0B43
    call StartMessageCommand09HL_B13
    ld de, $00CD
    call SetFlagBit
    ret

Jump_013_6B2B::
    ld hl, $0B45
    call StartMessageCommand09HL_B13
    ret

; entry 67 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case43::
Jump_013_6B32:: ; address name
    ld hl, $025A
    call StartMessageCommand09HL_B13
    ret

; entry 68 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case44::
Jump_013_6B39:: ; address name
    ld hl, $025B
    call StartMessageCommand09HL_B13
    ret

; entry 69 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case45::
Jump_013_6B40:: ; address name
    ld de, $0134
    call TestFlagBit
    ret nc
    ld hl, $0314
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
    ld hl, Data_096_549D
    call StartScriptAtHL_B13
    ld de, $0111
    call SetFlagBit
    ret

Jump_013_6B68::
    ld hl, $54A4
    call StartScriptAtHL_B13
    ret

; entry 71 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case47::
Jump_013_6B6F:: ; address name
    ld hl, $04C5
    call StartMessageCommand09HL_B13
    ret

; entry 72 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case48::
Jump_013_6B76:: ; address name
    ld hl, $04C6
    call StartMessageCommand09HL_B13
    ret

; entry 73 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case49::
Jump_013_6B7D:: ; address name
    ld hl, $04C7
    call StartMessageCommand09HL_B13
    ret

; entry 74 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4A::
Jump_013_6B84:: ; address name
    ld hl, $08C0
    call StartMessageCommand09HL_B13
    ret

; entry 75 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory
; writes: wC928
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
    ld hl, $0D4A
    call StartMessageCommand09HL_B13
    ret

Jump_013_6BAC::
    ld hl, $599F
    call StartScriptAtHL_B13
    ld a, $2C
    ld [wC928], a
    farcall AppendItemWC928ToInventory
    ret

Jump_013_6BBE::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6BCD
    ld hl, $08BB
    call StartMessageCommand09HL_B13
    ret

Jump_013_6BCD::
    ld hl, $0D87
    call StartMessageCommand09HL_B13
    ret

; entry 76 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case01_Case4C::
Jump_013_6BD4:: ; address name
    ld de, $010A
    call TestFlagBit
    jr c, Jump_013_6BEE
    ld hl, $54AB
    call StartScriptAtHL_B13
    ld a, $1D
    ld [wDataBank], a
    ld de, $010A
    call SetFlagBit
    ret

Jump_013_6BEE::
    ld hl, $54B2
    call StartScriptAtHL_B13
    ld a, $1D
    ld [wDataBank], a
    ret

; entry 77 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4D::
Jump_013_6BFA:: ; address name
    ld hl, $0A50
    call StartMessageCommand09HL_B13
    ret

; entry 78 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4E::
Jump_013_6C01:: ; address name
    ld hl, $0A52
    call StartMessageCommand09HL_B13
    ret

; entry 79 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case4F::
Jump_013_6C08:: ; address name
    ld hl, $0A53
    call StartMessageCommand09HL_B13
    ret

; entry 80 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case50::
Jump_013_6C0F:: ; address name
    ld hl, $0A59
    call StartMessageCommand09HL_B13
    ret

; entry 81 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case51::
Jump_013_6C16:: ; address name
    ld hl, $54B9
    call StartScriptAtHL_B13
    ret

; entry 82 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case52::
Jump_013_6C1D:: ; address name
    ld hl, $54C0
    call StartScriptAtHL_B13
    ret

; entry 83 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case53::
Jump_013_6C24:: ; address name
    ld hl, $0A5D
    call StartMessageCommand09HL_B13
    ret

; entry 84 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case54::
Jump_013_6C2B:: ; address name
    ld hl, $54C7
    call StartScriptAtHL_B13
    ret

; entry 85 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case55::
Jump_013_6C32:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C41
    ld hl, $0292
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C41::
    ld hl, $0B79
    call StartMessageCommand09HL_B13
    ret

; entry 86 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case56::
Jump_013_6C48:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C57
    ld hl, $027D
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C57::
    ld hl, $0B75
    call StartMessageCommand09HL_B13
    ret

; entry 87 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case57::
Jump_013_6C5E:: ; address name
    ld hl, $027E
    call StartMessageCommand09HL_B13
    ret

; entry 88 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case58::
Jump_013_6C65:: ; address name
    ld hl, $028C
    call StartMessageCommand09HL_B13
    ret

; entry 89 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case59::
Jump_013_6C6C:: ; address name
    ld hl, $028D
    call StartMessageCommand09HL_B13
    ret

; entry 90 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5A::
Jump_013_6C73:: ; address name
    ld hl, $028E
    call StartMessageCommand09HL_B13
    ret

; entry 91 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5B::
Jump_013_6C7A:: ; address name
    ld hl, $0287
    call StartMessageCommand09HL_B13
    ret

; entry 92 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5C::
Jump_013_6C81:: ; address name
    ld hl, $0286
    call StartMessageCommand09HL_B13
    ret

; entry 93 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5D::
Jump_013_6C88:: ; address name
    ld hl, $028F
    call StartMessageCommand09HL_B13
    ret

; entry 94 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5E::
Jump_013_6C8F:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C9E
    ld hl, $0294
    call StartMessageCommand09HL_B13
    ret

Jump_013_6C9E::
    ld hl, $0B7A
    call StartMessageCommand09HL_B13
    ret

; entry 95 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case5F::
Jump_013_6CA5:: ; address name
    ld hl, $0290
    call StartMessageCommand09HL_B13
    ret

; entry 96 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case60::
Jump_013_6CAC:: ; address name
    ld hl, $0291
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
    ld hl, $54CE
    call StartScriptAtHL_B13
    ret

Jump_013_6CC8::
    ld hl, $550F
    call StartScriptAtHL_B13
    ret

Jump_013_6CCF::
    dec a
    jr nz, Jump_013_6CE8
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CE1
    ld hl, $54DB
    call StartScriptAtHL_B13
    ret

Jump_013_6CE1::
    ld hl, $551C
    call StartScriptAtHL_B13
    ret

Jump_013_6CE8::
    dec a
    jr nz, Jump_013_6D01
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CFA
    ld hl, $54E8
    call StartScriptAtHL_B13
    ret

Jump_013_6CFA::
    ld hl, $5529
    call StartScriptAtHL_B13
    ret

Jump_013_6D01::
    dec a
    jr nz, Jump_013_6D1A
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D13
    ld hl, $54F5
    call StartScriptAtHL_B13
    ret

Jump_013_6D13::
    ld hl, $5536
    call StartScriptAtHL_B13
    ret

Jump_013_6D1A::
    dec a
    jr nz, Jump_013_6D33
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D2C
    ld hl, $5502
    call StartScriptAtHL_B13
    ret

Jump_013_6D2C::
    ld hl, $5543
    call StartScriptAtHL_B13
    ret

Jump_013_6D33::
    ld hl, $0B78
    call StartMessageCommand09HL_B13
    ret

; entry 98 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case62::
Jump_013_6D3A:: ; address name
    ld hl, $0296
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
    ld hl, $027A
    call StartMessageCommand09HL_B13
    ret

Jump_013_6D61::
    ld hl, $0B67
    call StartMessageCommand09HL_B13
    ret

; entry 101 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wTalkEventByte92, hTemp0
; writes: wDataBank, wD7FB, wTalkEventByte92
DispatchTalkEvent_Case01_Case65::
Jump_013_6D68:: ; address name
    ld a, $0C
    ld [wDataBank], a
    xor a, a
    ld [wD7FB], a
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
    ld hl, $5578
    call StartScriptAtHL_B13
    ret

Jump_013_6DA0::
    ld hl, $557F
    call StartScriptAtHL_B13
    ret

Jump_013_6DA7::
    ld a, [wArenaRank]
    or a, a
    jr nz, Jump_013_6DB4

Jump_013_6DAD::
    ld hl, $5550
    call StartScriptAtHL_B13
    ret

Jump_013_6DB4::
    ld de, $0189
    call TestFlagBit
    jr c, Jump_013_6DC3
    ld hl, $5560
    call StartScriptAtHL_B13
    ret

Jump_013_6DC3::
    ld hl, $556A
    call StartScriptAtHL_B13
    ret

Jump_013_6DCA::
    ld hl, $5571
    call StartScriptAtHL_B13
    ret

; entry 102 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
DispatchTalkEvent_Case01_Case66::
Jump_013_6DD1:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $010E
    call TestFlagBit
    jr c, Jump_013_6E02
    ld a, $00
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ld de, $010D
    call TestFlagBit
    jr c, Jump_013_6DFB
    ld hl, Data_00E_5586
    call StartScriptAtHL_B13
    ret

Jump_013_6DFB::
    ld hl, $558B
    call StartScriptAtHL_B13
    ret

Jump_013_6E02::
    ld hl, $04B4
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
    ld hl, $04B5
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E28::
    ld hl, $04BB
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E2F::
    ld hl, $04C1
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E36::
    ld hl, $0B6E
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
    ld hl, $04B6
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E5C::
    ld hl, $04BC
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E63::
    ld hl, $04C2
    call StartMessageCommand09HL_B13
    ret

Jump_013_6E6A::
    ld hl, $0B6F
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
    ld hl, Data_096_5598
    call StartScriptAtHL_B13
    ret

Jump_013_6E8D::
    ld hl, $55A2
    call StartScriptAtHL_B13
    ret

Jump_013_6E94::
    ld de, $0028
    call TestFlagBit
    jr c, Jump_013_6E8D
    ld hl, $55A9
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
    ld hl, $55B3
    call StartScriptAtHL_B13
    ret

Jump_013_6EC8::
    ld hl, $55BD
    call StartScriptAtHL_B13
    ret

Jump_013_6ECF::
    ld de, $002C
    call TestFlagBit
    jr c, Jump_013_6EC8
    ld hl, $55C4
    call StartScriptAtHL_B13
    ret

; entry 107 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6B::
Jump_013_6EDE:: ; address name
    ld hl, $55CE
    call StartScriptAtHL_B13
    ret

; entry 108 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6C::
Jump_013_6EE5:: ; address name
    ld hl, $08D8
    call StartMessageCommand09HL_B13
    ret

; entry 109 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6D::
Jump_013_6EEC:: ; address name
    ld hl, $08D9
    call StartMessageCommand09HL_B13
    ret

; entry 110 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6E::
Jump_013_6EF3:: ; address name
    ld hl, $08CD
    call StartMessageCommand09HL_B13
    ret

; entry 111 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case6F::
Jump_013_6EFA:: ; address name
    ld hl, $02DC
    call StartMessageCommand09HL_B13
    ret

; entry 112 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case70::
Jump_013_6F01:: ; address name
    ld hl, $0DD4
    call StartMessageCommand09HL_B13
    ret

; entry 113 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case71::
Jump_013_6F08:: ; address name
    ld hl, $02DD
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
    ld hl, Data_00C_55DB
    call StartScriptAtHL_B13
    ret

Jump_013_6F2B::
    ld hl, $55E5
    call StartScriptAtHL_B13
    ret

Jump_013_6F32::
    ld de, $0031
    call TestFlagBit
    jr c, Jump_013_6F2B
    ld hl, $55EC
    call StartScriptAtHL_B13
    ret

; entry 115 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case73::
Jump_013_6F41:: ; address name
    ld hl, $0A6F
    call StartMessageCommand09HL_B13
    ret

; entry 116 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case74::
Jump_013_6F48:: ; address name
    ld hl, $0A75
    call StartMessageCommand09HL_B13
    ret

; entry 117 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case75::
Jump_013_6F4F:: ; address name
    ld hl, $0A76
    call StartMessageCommand09HL_B13
    ret

; entry 118 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case76::
Jump_013_6F56:: ; address name
    ld hl, $0A77
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
    ld hl, $025E
    call StartMessageCommand09HL_B13
    ret

Jump_013_6F84::
    call InventoryHasFreeSlotCheck_Bank13
    jr c, Jump_013_6F90
    ld hl, $0261
    call StartMessageCommand09HL_B13
    ret

Jump_013_6F90::
    ld [hl], $11
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $55F6
    call StartScriptAtHL_B13
    ret

Jump_013_6FA1::
    ld hl, $0262
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FA8::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6FB7
    ld hl, $0D31
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FB7::
    ld hl, $0527
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FBE::
    ld hl, $0B46
    call StartMessageCommand09HL_B13
    ret

; entry 120 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case78::
Jump_013_6FC5:: ; address name
    ld hl, $0269
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
    ld hl, $026A
    call StartMessageCommand09HL_B13
    ret

; entry 123 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7B::
Jump_013_6FE4:: ; address name
    ld hl, $0A32
    call StartMessageCommand09HL_B13
    ret

; entry 124 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7C::
Jump_013_6FEB:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_6FFB
    ld hl, $0A33
    call StartMessageCommand09HL_B13
    ret

Jump_013_6FFB::
    ld hl, $0B06
    call StartMessageCommand09HL_B13
    ret

; entry 125 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7D::
Jump_013_7002:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7012
    ld hl, $020A
    call StartMessageCommand09HL_B13
    ret

Jump_013_7012::
    ld hl, $0B0B
    call StartMessageCommand09HL_B13
    ret

; entry 126 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case01_Case7E::
Jump_013_7019:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7029
    ld hl, $08BF
    call StartMessageCommand09HL_B13
    ret

Jump_013_7029::
    ld hl, $0B0C
    call StartMessageCommand09HL_B13
    ret

; entry 127 of the `rst $00` table in DispatchTalkEvent_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wPartyCount, wInventory, wCB9A
; writes: hTemp0, hTemp1, wD7FB, wDataBank
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
    ld hl, $08C5
    call StartMessageCommand09HL_B13
    ret

Jump_013_704D::
    ld hl, $00B9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesHFFC6
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
    ld hl, $561A
    call StartScriptAtHL_B13
    ret

Jump_013_7081::
    ld hl, $5631
    call StartScriptAtHL_B13
    ret

Jump_013_7088::
    ld hl, $5600
    call StartScriptAtHL_B13
    ret

Jump_013_708F::
    ld hl, $08C7
    call StartMessageCommand09HL_B13
    ret

Jump_013_7096::
    ld a, $01
    ld [wD7FB], a
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_70AA

Jump_013_70A3::
    ld hl, $0D25
    call StartMessageCommand09HL_B13
    ret

Jump_013_70AA::
    ld a, [wCB9A]
    cp a, $10
    jr nz, Jump_013_70A3
    ld a, $10
    ld [wDataBank], a
    ld de, $0116
    call TestFlagBit
    jr c, Jump_013_70CB
    ld hl, Data_010_564B
    call StartScriptAtHL_B13
    ld de, $0116
    call SetFlagBit
    ret

Jump_013_70CB::
    ld hl, $5652
    call StartScriptAtHL_B13
    ret
    db $21, $39, $0A, $CD, $01, $40, $C9

; tests story flags in turn (flag $0025 set: jr to Jump_013_7122; flag $00D1 set: jr to Jump_013_711B; flag $0024 set: jp to Jump_013_70F9); when none of them branches, starts message $0A3C through StartMessageCommand09HL_B13 (script command $09); that string begins 'King If you see Kameha again,' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: hTemp0, hTemp1
TalkMsg0A3C_KingIfYouSee:: ; heuristic: target of a pointer table; C0
Func_013_70D9:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7122
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_711B
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_70F9
    ld hl, $0A3C
    call StartMessageCommand09HL_B13
    ret

Jump_013_70F9::
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_7114
    ld hl, $050E
    call StartMessageCommand09HL_B13
    ld de, $0117
    call SetFlagBit
    ld de, $0122
    call SetFlagBit
    ret

Jump_013_7114::
    ld hl, $050F
    call StartMessageCommand09HL_B13
    ret

Jump_013_711B::
    ld hl, $053D
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
    ld hl, $0B7B
    call StartMessageCommand09HL_B13
    ret

Jump_013_7152::
    ld hl, $5903
    call StartScriptAtHL_B13
    ret

Jump_013_7159::
    ld hl, $0B7F
    call StartMessageCommand09HL_B13
    ret

Jump_013_7160::
    ld hl, $2710
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $5913
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
    ld hl, $0B82
    call StartMessageCommand09HL_B13
    ret

Jump_013_71A6::
    ld hl, $591D
    call StartScriptAtHL_B13
    ret

Jump_013_71AD::
    ld hl, $0B85
    call StartMessageCommand09HL_B13
    ret

Jump_013_71B4::
    ld hl, $4E20
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $592D
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
    ld hl, $0B82
    call StartMessageCommand09HL_B13
    ret

Jump_013_71FA::
    ld hl, $5937
    call StartScriptAtHL_B13
    ret

Jump_013_7201::
    ld hl, $0B88
    call StartMessageCommand09HL_B13
    ret

Jump_013_7208::
    ld hl, $7530
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $5947
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
    ld hl, $0B82
    call StartMessageCommand09HL_B13
    ret

Jump_013_724F::
    ld hl, $5951
    call StartScriptAtHL_B13
    ret

Jump_013_7256::
    ld hl, $0B8B
    call StartMessageCommand09HL_B13
    ret

Jump_013_725D::
    ld hl, vBGMap1 + $40
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ld hl, $5961
    call StartScriptAtHL_B13
    ret

Jump_013_7273::
    ld hl, $0B8D
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7299; flag $0024 set: jp to Jump_013_7292); when none of them branches, starts message $0A3E through StartMessageCommand09HL_B13 (script command $09); that string begins 'You're free to go anywhere in' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A3E_YoureFreeToGo:: ; heuristic: target of a pointer table; C0
Func_013_727A:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7299
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7292
    ld hl, $0A3E
    call StartMessageCommand09HL_B13
    ret

Jump_013_7292::
    ld hl, $0510
    call StartMessageCommand09HL_B13
    ret

Jump_013_7299::
    ld de, $0192
    call TestFlagBit
    jr c, Jump_013_72A8
    ld hl, $0D93
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
    ld hl, $0B8E
    call StartMessageCommand09HL_B13
    ret

Jump_013_72E7::
    ld hl, $0D94
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_730D; flag $00D1 set: jr to Jump_013_7314; flag $0122 set: jr to Jump_013_730D); when none of them branches, starts message $0A3F through StartMessageCommand09HL_B13 (script command $09); that string begins 'The King and Prince's chamber is' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A3F_TheKingAndPrinces:: ; heuristic: target of a pointer table; C0
Func_013_72EE:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_730D
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7314
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_730D
    ld hl, $0A3F
    call StartMessageCommand09HL_B13
    ret

Jump_013_730D::
    ld hl, $0511
    call StartMessageCommand09HL_B13
    ret

Jump_013_7314::
    ld hl, $0544
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A41, whose string begins 'This is GreatLog Castle. The reception'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0A41_ThisIsGreatLogCastle:: ; heuristic: target of a pointer table; C0
Func_013_731B:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_732B
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7332

Jump_013_732B::
    ld hl, $0A41
    call StartMessageCommand09HL_B13
    ret

Jump_013_7332::
    ld hl, $0545
    call StartMessageCommand09HL_B13
    ret
    db $21, $42, $0A, $CD, $01, $40, $C9, $11, $25, $00, $CD, $1B, $18, $38, $07, $21
    db $43, $0A, $CD, $01, $40, $C9, $21, $52, $0B, $CD, $01, $40, $C9, $21, $44, $0A
    db $CD, $01, $40, $C9, $21, $45, $0A, $CD, $01, $40, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A49, whose string begins 'Breeding could result in monsters with'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Talk0A49_BreedingCouldResultIn:: ; heuristic: target of a pointer table; C0
Func_013_7364:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7396
    ld de, $0118
    call TestFlagBit
    jr c, Jump_013_738F
    ld a, $01
    ld [wD7FB], a
    ld hl, $5660
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_738F::
    ld hl, $0A49
    call StartMessageCommand09HL_B13
    ret

Jump_013_7396::
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0125
    call TestFlagBit
    jr c, Jump_013_73B8
    ld a, $03
    ld [wD7FB], a
    ld hl, $5670
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_73B8::
    ld hl, $0516
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_73DE; flag $0024 set: jp to Jump_013_73D7); when none of them branches, starts message $0A4A through StartMessageCommand09HL_B13 (script command $09); that string begins 'From up here people look like' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4A_FromUpHerePeople:: ; heuristic: target of a pointer table; C0
Func_013_73BF:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_73DE
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_73D7
    ld hl, $0A4A
    call StartMessageCommand09HL_B13
    ret

Jump_013_73D7::
    ld hl, $0517
    call StartMessageCommand09HL_B13
    ret

Jump_013_73DE::
    ld hl, $0BB9
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 01, wScriptParam1 = 47, then StartMessageScriptDE_B13 with DE = $0126: starts message group 1, string $26; on the normal ShowMessageHL path the string begins 'Warubou There, your party's fine! So,' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0126_WarubouThereYourPartys:: ; heuristic: target of a pointer table; C0
Func_013_73E5:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $0126
    call StartMessageScriptDE_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7415; flag $0024 set: jp to Jump_013_740E); when none of them branches, starts message $0A4C through StartMessageCommand09HL_B13 (script command $09); that string begins 'GreatLog Castle was made by hollowing' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4C_GreatLogCastleWasMade:: ; heuristic: target of a pointer table; C0
Func_013_73F6:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7415
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_740E
    ld hl, $0A4C
    call StartMessageCommand09HL_B13
    ret

Jump_013_740E::
    ld hl, $051F
    call StartMessageCommand09HL_B13
    ret

Jump_013_7415::
    ld hl, $0BBB
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_743A; flag $0024 set: jr to Jump_013_7433); when none of them branches, starts message $0A4D through StartMessageCommand09HL_B13 (script command $09); that string begins 'The island used to be lush' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4D_TheIslandUsedTo:: ; heuristic: target of a pointer table; C0
Func_013_741C:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_743A
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7433
    ld hl, $0A4D
    call StartMessageCommand09HL_B13
    ret

Jump_013_7433::
    ld hl, $0520
    call StartMessageCommand09HL_B13
    ret

Jump_013_743A::
    ld hl, $0BBC
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $04BA, whose string begins 'If you get an EvilArmor, I'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Talk04BA_IfYouGetAn:: ; heuristic: target of a pointer table; C0
Func_013_7441:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $011A
    call TestFlagBit
    jr c, Jump_013_7463
    ld hl, $5680
    call StartScriptAtHL_B13
    ld a, $02
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7463::
    ld hl, $04BA
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $04CB, whose string begins 'That key, I used on my'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
Talk04CB_ThatKeyIUsed:: ; heuristic: target of a pointer table; C0
Func_013_746A:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7488
    ld de, $011D
    call TestFlagBit
    jr c, Jump_013_7481
    ld hl, $5690
    call StartScriptAtHL_B13
    ret

Jump_013_7481::
    ld hl, $04CB
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
    ld hl, $0B4A
    call StartMessageCommand09HL_B13
    ld de, $002E
    call SetFlagBit
    ret

Jump_013_74AD::
    farcall Talk04CB_ThatKeyIUsed_Sub01
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_74BF
    ld hl, $0B4B
    call StartMessageCommand09HL_B13
    ret

Jump_013_74BF::
    ld hl, $56A0
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
    ld hl, $0B4D
    call StartMessageCommand09HL_B13
    ret

Jump_013_74DD::
    ld hl, $56A8
    call StartScriptAtHL_B13
    ld de, $003E
    call SetFlagBit
    ret

Jump_013_74EA::
    ld hl, $0BB4
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $04CE, whose string begins '0 checked the shelf. 0 found'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
Talk04CE_HeroCheckedTheShelf:: ; heuristic: target of a pointer table; C0
Func_013_74F1:: ; address name
    ld de, $011E
    call TestFlagBit
    jr c, Jump_013_7518
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_750B
    ld hl, $04CE
    call StartMessageCommand09HL_B13
    ret

Jump_013_750B::
    ld hl, $04CD
    call StartMessageCommand09HL_B13
    ld de, $011E
    call SetFlagBit
    ret

Jump_013_7518::
    ld hl, $04CC
    call StartMessageCommand09HL_B13
    ret
    INCBIN "dwm2-cobi-us.gbc", $04F51F, $62

; tests story flags in turn (flag $0025 set: jp to Jump_013_7591); when none of them branches, starts message $0504 through StartMessageCommand09HL_B13 (script command $09); that string begins 'If the island sink, is no' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0504_IfTheIslandSink:: ; heuristic: target of a pointer table; C0
Func_013_7581:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7591
    ld hl, $0504
    call StartMessageCommand09HL_B13
    ret

Jump_013_7591::
    ld hl, $0B05
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_75B6; flag $00D1 set: jr to Jump_013_75AF); when none of them branches, starts message $0512 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Kameha Yo, 0. Thanks for coming.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: hTemp0, hTemp1
TalkMsg0512_KamehaYo0Thanks:: ; heuristic: target of a pointer table; C0
Func_013_7598:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_75B6
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_75AF
    ld hl, $0512
    call StartMessageCommand09HL_B13
    ret

Jump_013_75AF::
    ld hl, $053E
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
    ld hl, $0D92
    call StartMessageCommand09HL_B13
    ret

Jump_013_75DE::
    ld hl, $58B5
    call StartScriptAtHL_B13
    ret

Jump_013_75E5::
    ld a, $07
    ldh [hTemp0], a
    farcall KeyListHasKindHFFC6
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_7624
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7607

Jump_013_7600::
    ld hl, $0B96
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
    farcall WriteKeyEntryHFFC6
    ld hl, $58C3
    call StartScriptAtHL_B13
    ret

Jump_013_7624::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7600
    ld hl, $58CD
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
    ld hl, $0B98
    call StartMessageCommand09HL_B13
    ret

Jump_013_765E::
    ld hl, $58E1
    call StartScriptAtHL_B13
    ret

Jump_013_7665::
    ld a, $09
    ldh [hTemp0], a
    farcall KeyListHasKindHFFC6
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_013_76A4
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_013_7687

Jump_013_7680::
    ld hl, $0B96
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
    farcall WriteKeyEntryHFFC6
    ld hl, $58EF
    call StartScriptAtHL_B13
    ret

Jump_013_76A4::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_013_7680
    ld hl, $58F9
    call StartScriptAtHL_B13
    ret

Jump_013_76B6::
    ld hl, $0B98
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 11, then StartMessageScriptDE_B13 with DE = $011B: starts message group 1, string $1B; on the normal ShowMessageHL path the string begins 'Hm? Are you a master hopeful?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg011B_HmAreYouA:: ; heuristic: target of a pointer table; C0
Func_013_76BD:: ; address name
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
Msg011C_OhHiGoodTo:: ; heuristic: target of a pointer table; C0
Func_013_76CE:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $13
    ld [wScriptParam1], a
    ld de, $011C
    call StartMessageScriptDE_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $04C0, whose string begins 'All righty! We'll do this again'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Talk04C0_AllRightyWellDo:: ; heuristic: target of a pointer table; C0
Func_013_76DF:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld de, $0129
    call TestFlagBit
    jr c, Jump_013_7701
    ld hl, $56C8
    call StartScriptAtHL_B13
    ld a, $04
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7701::
    ld hl, $04C0
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0276, whose string begins 'If you want to enter, please'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
Talk0276_IfYouWantTo:: ; heuristic: target of a pointer table; C0
Func_013_7708:: ; address name
    ld a, [wArenaRank]
    cp a, $05
    jr z, Jump_013_7720
    or a, a
    jr nz, Jump_013_7719
    ld hl, $0276
    call StartMessageCommand09HL_B13
    ret

Jump_013_7719::
    ld hl, $56D8
    call StartScriptAtHL_B13
    ret

Jump_013_7720::
    ld hl, $56E5
    call StartScriptAtHL_B13
    ret

Data_013_7727:: ; heuristic: target of a monotone pointer table; C0
    db $21, $F2, $56, $CD, $49, $40, $C9

; map event: with story flag $D1 set, starts script $56F5 if flag 0 is set, else $5709 (E-0122)
; no direct call (reached through a table, a jump or a vector)
StartScript5709Or56F5IfFlagD1:: ; heuristic: target of a pointer table; C0
Func_013_772E:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_7744
    ld hl, $5709
    call StartScriptAtHL_B13
    ret

Jump_013_7744::
    ld hl, $56F5
    call StartScriptAtHL_B13
    ret

Data_013_774B:: ; heuristic: target of a monotone pointer table; C0
    db $21, $24, $00, $CD, $01, $40, $C9

Data_013_7752:: ; heuristic: target of a monotone pointer table; C0
    db $21, $25, $00, $CD, $01, $40, $C9

Data_013_7759:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1D, $00, $CD, $01, $40, $C9

Data_013_7760:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1C, $00, $CD, $01, $40, $C9

Data_013_7767:: ; heuristic: target of a monotone pointer table; C0
    db $21, $F8, $64, $06, $12, $D7, $21, $85, $5E, $06, $02, $D7, $21, $85, $5E, $06
    db $02, $D7, $CD, $2B, $22, $21, $A8, $4A, $06, $04, $D7, $3E, $7F, $EA, $27, $C5
    db $C9

Data_013_7788:: ; heuristic: target of a monotone pointer table; C0
    db $21, $37, $00, $CD, $01, $40, $C9

Data_013_778F:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $17, $EA, $FB, $D7, $3E, $10, $EA, $FE, $D7, $21, $B3, $59, $CD, $49, $40
    db $C9

Data_013_77A0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $10, $27, $7D, $E0, $C6, $7C, $E0, $C7, $21, $C2, $7E, $06, $12, $D7, $21
    db $FE, $00, $CD, $01, $40, $C9

Data_013_77B6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4E, $0D, $CD, $01, $40, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0043, whose string begins '0 checked the odd object. It'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0043_HeroCheckedTheOdd:: ; heuristic: target of a pointer table; C0
Func_013_77BD:: ; address name
    ld de, $000B
    call TestFlagBit
    jr nc, Jump_013_77CC
    ld de, $0025
    call TestFlagBit
    ret nc

Jump_013_77CC::
    ld hl, $0043
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $0036, whose string begins 'There were many wild monsters in'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0036_ThereWereManyWild:: ; heuristic: target of a pointer table; C0
Func_013_77D3:: ; address name
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
    ld hl, $0036
    call StartMessageCommand09HL_B13
    ret

Jump_013_77FA::
    ld hl, $0076
    call StartMessageCommand09HL_B13
    ret

Jump_013_7801::
    ld hl, $0D00
    call StartMessageCommand09HL_B13
    ret

Jump_013_7808::
    ld hl, $050A
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0037, whose string begins '0 tried to open the chest.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTileBuffer
Talk0037_HeroTriedToOpen:: ; heuristic: target of a pointer table; C0
Func_013_780F:: ; address name
    ld a, [wScreenTileBuffer + $D2]
    cp a, $1A
    ret nz
    ld hl, $0037
    call StartMessageCommand09HL_B13
    ret

; wD7FB = 1, StartScriptAtHL_B13 with HL = $5660, then wDataBank = $0E (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
StartScript5660WithBank0E:: ; heuristic: target of a pointer table; C0
Func_013_781C:: ; address name
    ld a, $01
    ld [wD7FB], a
    ld hl, $5660
    call StartScriptAtHL_B13
    ld a, $0E
    ld [wDataBank], a
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_784B; flag $0024 set: jr to Jump_013_7844); when none of them branches, starts message $0268 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Yep, she's taking good care of' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0268_YepShesTakingGood:: ; heuristic: target of a pointer table; C0
Func_013_782D:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_784B
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7844
    ld hl, $0268
    call StartMessageCommand09HL_B13
    ret

Jump_013_7844::
    ld hl, $0529
    call StartMessageCommand09HL_B13
    ret

Jump_013_784B::
    ld hl, $0B48
    call StartMessageCommand09HL_B13
    ret

Data_013_7852:: ; heuristic: target of a monotone pointer table; C0
    db $21, $2E, $02, $CD, $01, $40, $C9

Data_013_7859:: ; heuristic: target of a monotone pointer table; C0
    db $21, $2F, $02, $CD, $01, $40, $C9

Data_013_7860:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $42, $02, $CD, $01, $40, $C9, $21
    db $33, $0B, $CD, $01, $40, $C9

Data_013_7876:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B1, $02, $CD, $01, $40, $C9

Data_013_787D:: ; heuristic: target of a monotone pointer table; C0
    db $11, $22, $00, $CD, $1B, $18, $38, $16, $11, $21, $00, $CD, $1B, $18, $38, $07
    db $21, $1D, $57, $CD, $49, $40, $C9, $21, $2A, $57, $CD, $49, $40, $C9, $21, $37
    db $57, $CD, $49, $40, $C9

Data_013_78A2:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $DA, $B2, $78, $21, $A6, $02, $CD, $01, $40, $C9
    db $21, $07, $0B, $CD, $01, $40, $C9

Data_013_78B9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $DA, $C9, $78, $21, $09, $02, $CD, $01, $40, $C9
    db $21, $09, $0B, $CD, $01, $40, $C9

Data_013_78D0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $51, $0A, $CD, $01, $40, $C9

Data_013_78D7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $44, $57, $CD, $49, $40, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $08D1, whose string begins 'The Evaluator said I had an'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5
Talk08D1_TheEvaluatorSaidI:: ; heuristic: target of a pointer table; C0
Func_013_78DE:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_78ED

Jump_013_78E6::
    ld hl, $08D1
    call StartMessageCommand09HL_B13
    ret

Jump_013_78ED::
    ld de, $0029
    call TestFlagBit
    jr c, Jump_013_78E6
    farcall ClearWD7F5IfAtOrAboveLimitForWC7C7
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_7909
    ld hl, $57FE
    call StartScriptAtHL_B13
    ret

Jump_013_7909::
    ld hl, $580B
    call StartScriptAtHL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $04D2, whose string begins 'Up ahead is the Starry Shrine'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
Talk04D2_UpAheadIsThe:: ; heuristic: target of a pointer table; C0
Func_013_7910:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_793B
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7934
    ld a, [wArenaRank]
    or a, a
    jr nz, Jump_013_792D
    ld hl, $04D2
    call StartMessageCommand09HL_B13
    ret

Jump_013_792D::
    ld hl, $0D0C
    call StartMessageCommand09HL_B13
    ret

Jump_013_7934::
    ld hl, $08D2
    call StartMessageCommand09HL_B13
    ret

Jump_013_793B::
    ld hl, $0B25
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7951); when none of them branches, starts message $021F through StartMessageCommand09HL_B13 (script command $09); that string begins 'Do you know about LogTwig? It's' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg021F_DoYouKnowAbout:: ; heuristic: target of a pointer table; C0
Func_013_7942:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7951
    ld hl, $021F
    call StartMessageCommand09HL_B13
    ret

Jump_013_7951::
    ld hl, $0B12
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7967); when none of them branches, starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins 'In other worlds, you'll meet other' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0220_InOtherWorldsYoull:: ; heuristic: target of a pointer table; C0
Func_013_7958:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7967
    ld hl, $0220
    call StartMessageCommand09HL_B13
    ret

Jump_013_7967::
    ld hl, $0B13
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_797D); when none of them branches, starts message $027F through StartMessageCommand09HL_B13 (script command $09); that string begins 'It's not easy to win right' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg027F_ItsNotEasyTo:: ; heuristic: target of a pointer table; C0
Func_013_796E:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_797D
    ld hl, $027F
    call StartMessageCommand09HL_B13
    ret

Jump_013_797D::
    ld hl, $0B76
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7993); when none of them branches, starts message $0280 through StartMessageCommand09HL_B13 (script command $09); that string begins 'Mama is a big worrier But' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0280_MamaIsABig:: ; heuristic: target of a pointer table; C0
Func_013_7984:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7993
    ld hl, $0280
    call StartMessageCommand09HL_B13
    ret

Jump_013_7993::
    ld hl, $0B77
    call StartMessageCommand09HL_B13
    ret

Data_013_799A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $84, $02, $CD, $01, $40, $C9

Data_013_79A1:: ; heuristic: target of a monotone pointer table; C0
    db $21, $85, $02, $CD, $01, $40, $C9

Data_013_79A8:: ; heuristic: target of a monotone pointer table; C0
    db $21, $88, $02, $CD, $01, $40, $C9

Data_013_79AF:: ; heuristic: target of a monotone pointer table; C0
    db $21, $52, $57, $CD, $49, $40, $C9

Data_013_79B6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $93, $02, $CD, $01, $40, $C9

Data_013_79BD:: ; heuristic: target of a monotone pointer table; C0
    db $21, $95, $02, $CD, $01, $40, $C9

Data_013_79C4:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $7B, $02, $CD, $01, $40, $C9, $21
    db $68, $0B, $CD, $01, $40, $C9

Data_013_79DA:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $7C, $02, $CD, $01, $40, $C9, $21
    db $69, $0B, $CD, $01, $40, $C9

Data_013_79F0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $9C, $02, $CD, $01, $40, $C9

Data_013_79F7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $9D, $02, $CD, $01, $40, $C9

Data_013_79FE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $32, $01, $CD, $25, $40
    db $C9

Data_013_7A0F:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B1, $02, $CD, $01, $40, $C9

Data_013_7A16:: ; heuristic: target of a monotone pointer table; C0
    db $21, $25, $02, $CD, $01, $40, $C9

Data_013_7A1D:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $30, $01, $CD, $25, $40
    db $C9

Data_013_7A2E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4A, $02, $CD, $01, $40, $C9

Data_013_7A35:: ; heuristic: target of a monotone pointer table; C0
    db $21, $80, $7E, $06, $12, $D7, $F0, $C7, $CB, $7F, $C0, $EA, $34, $C9, $21, $5F
    db $57, $CD, $49, $40, $C9

Data_013_7A4A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04FA4A, $49

Data_013_7A93:: ; heuristic: target of a monotone pointer table; C0
    db $21, $45, $02, $CD, $01, $40, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $00FC, whose string begins 'You have to eat your vegetables!'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk00FC_YouHaveToEat:: ; heuristic: target of a pointer table; C0
Func_013_7A9A:: ; address name
    farcall AddHundredToPartyINTCapped999
    ld hl, $00FC
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7AB6); when none of them branches, starts message $0A74 through StartMessageCommand09HL_B13 (script command $09); that string begins 'The Medal Master was famous as' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A74_TheMedalMasterWas:: ; heuristic: target of a pointer table; C0
Func_013_7AA7:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7AB6
    ld hl, $0A74
    call StartMessageCommand09HL_B13
    ret

Jump_013_7AB6::
    ld hl, $0B51
    call StartMessageCommand09HL_B13
    ret

; when story flag $23 is set, StartScriptAtHL_B13 with HL = $57A2 (E-0119)
; no direct call (reached through a table, a jump or a vector)
IfFlag0023StartScript57A2:: ; heuristic: target of a pointer table; C0
Func_013_7ABD:: ; address name
    ld de, $0023
    call TestFlagBit
    ret nc
    ld hl, $57A2
    call StartScriptAtHL_B13
    ret

; wScriptParam0 = 02, wScriptParam1 = 2C, then StartMessageScriptDE_B13 with DE = $013C: starts message group 1, string $3C; on the normal ShowMessageHL path the string begins 'I saw a lake like a' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013C_ISawALake:: ; heuristic: target of a pointer table; C0
Func_013_7ACB:: ; address name
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
Msg013D_StrongMonstersAreIn:: ; heuristic: target of a pointer table; C0
Func_013_7ADC:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1C
    ld [wScriptParam1], a
    ld de, $013D
    call StartMessageScriptDE_B13
    ret

; tests story flags in turn (flag $0025 set: jp to Jump_013_7AFD); when none of them branches, starts message $0A35 through StartMessageCommand09HL_B13 (script command $09); that string begins 'I'm a bug, so I'm not' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A35_ImABugSo:: ; heuristic: target of a pointer table; C0
Func_013_7AED:: ; address name
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7AFD
    ld hl, $0A35
    call StartMessageCommand09HL_B13
    ret

Jump_013_7AFD::
    ld hl, $0B0A
    call StartMessageCommand09HL_B13
    ret
    db $21, $34, $0A, $CD, $01, $40, $C9

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B1A); when none of them branches, starts message $0A68 through StartMessageCommand09HL_B13 (script command $09); that string begins 'My Emyu is very timid. I' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A68_MyEmyuIsVery:: ; heuristic: target of a pointer table; C0
Func_013_7B0B:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B1A
    ld hl, $0A68
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B1A::
    ld hl, $0BBD
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B3F; flag $0136 set: jr to Jump_013_7B38); when none of them branches, starts message $0A6B through StartMessageCommand09HL_B13 (script command $09); that string begins 'Monsters look so frightening Yes, I' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A6B_MonstersLookSoFrightening:: ; heuristic: target of a pointer table; C0
Func_013_7B21:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B3F
    ld de, $0136
    call TestFlagBit
    jr c, Jump_013_7B38
    ld hl, $0A6B
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B38::
    ld hl, $0A6C
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B3F::
    ld hl, $0BBE
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0A40, whose string begins 'Please enter. The King awaits you'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0A40_PleaseEnterTheKing:: ; heuristic: target of a pointer table; C0
Func_013_7B46:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B56
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7B5D

Jump_013_7B56::
    ld hl, $0A40
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B5D::
    ld hl, $0545
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7B83; flag $0024 set: jp to Jump_013_7B7C); when none of them branches, starts message $0A4B through StartMessageCommand09HL_B13 (script command $09); that string begins 'On the horizon, you can see' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0A4B_OnTheHorizonYou:: ; heuristic: target of a pointer table; C0
Func_013_7B64:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B83
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7B7C
    ld hl, $0A4B
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B7C::
    ld hl, $0518
    call StartMessageCommand09HL_B13
    ret

Jump_013_7B83::
    ld hl, $0BBA
    call StartMessageCommand09HL_B13
    ret

Data_013_7B8A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D1, $04, $CD, $01, $40, $C9

Data_013_7B91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04FB91, $166

Data_013_7CF7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $19, $05, $CD, $01, $40, $C9

Data_013_7CFE:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1A, $05, $CD, $01, $40, $C9

Data_013_7D05:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1B, $05, $CD, $01, $40, $C9

Data_013_7D0C:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1C, $05, $CD, $01, $40, $C9

Data_013_7D13:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1D, $05, $CD, $01, $40, $C9

Data_013_7D1A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1E, $05, $CD, $01, $40, $C9

Data_013_7D21:: ; heuristic: target of a monotone pointer table; C0
    db $21, $5E, $05, $CD, $01, $40, $C9

Data_013_7D28:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D5, $0D, $CD, $01, $40, $C9

Data_013_7D2F:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $CE, $CE, $FE, $01, $C0, $FA, $CF, $CB, $B7, $C0, $3E, $14, $E0, $C6, $21
    db $98, $6B, $06, $12, $D7, $C9

Data_013_7D45:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $CE, $CE, $FE, $01, $C0, $FA, $C1, $CE, $B7, $20, $07, $21, $E3, $57, $CD
    db $49, $40, $C9, $11, $52, $C1, $CD, $31, $24, $21, $E8, $57, $CD, $49, $40, $C9

Data_013_7D65:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $8E, $FE, $30, $20, $07, $21, $66, $0D, $0E, $00, $18, $10, $FE, $40, $20
    db $07, $21, $67, $0D, $0E, $01, $18, $05, $21, $68, $0D, $0E, $02, $CD, $01, $40
    db $21, $F5, $5D, $06, $85, $D7, $C9

Data_013_7D8C:: ; heuristic: target of a monotone pointer table; C0
    db $AF, $EA, $68, $C9, $C9

; tests story flags in turn (flag $0025 set: jr to Jump_013_7DA0); when none of them branches, starts message $029B through StartMessageCommand09HL_B13 (script command $09); that string begins 'I found a key in another' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg029B_IFoundAKey:: ; heuristic: target of a pointer table; C0
Func_013_7D91:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DA0
    ld hl, $029B
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DA0::
    ld hl, $0B1F
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0DE3, whose string begins 'The sea is huge and mysterious.'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0DE3_TheSeaIsHuge:: ; heuristic: target of a pointer table; C0
Func_013_7DA7:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DB7
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7DBE

Jump_013_7DB7::
    ld hl, $0DE3
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DBE::
    ld hl, $0DE4
    call StartMessageCommand09HL_B13
    ret

; tests story flags in turn (flag $0025 set: jr to Jump_013_7DD4); when none of them branches, starts message $0220 through StartMessageCommand09HL_B13 (script command $09); that string begins 'In other worlds, you'll meet other' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0220_InOtherWorldsYoull_7DC5:: ; heuristic: target of a pointer table; C0
Func_013_7DC5:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DD4
    ld hl, $0220
    call StartMessageCommand09HL_B13
    ret

Jump_013_7DD4::
    ld hl, $0B13
    call StartMessageCommand09HL_B13
    ret

; wScriptParam0 = 00, wScriptParam1 = 26, then StartMessageScriptDE_B13 with DE = $013E: starts message group 1, string $3E; on the normal ShowMessageHL path the string begins 'Our King has been a fan' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg013E_OurKingHasBeen:: ; heuristic: target of a pointer table; C0
Func_013_7DDB:: ; address name
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
Msg013F_TheCircusMasterWas:: ; heuristic: target of a pointer table; C0
Func_013_7DEC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $42
    ld [wScriptParam1], a
    ld de, $013F
    call StartMessageScriptDE_B13
    ret
    db $21, $5F, $05, $CD, $01, $40, $C9, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story flags and state; the first one in the code is $0B56, whose string begins 'When you breed monsters with another'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wCB81, hTemp1, hTemp0
; writes: wDataBank, wD7FB
Talk0B56_WhenYouBreedMonsters:: ; heuristic: target of a pointer table; C0
Func_013_7E05:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0E
    ld [wDataBank], a
    ld a, [wCB81]
    cp a, $17
    jr z, Jump_013_7E6C
    cp a, $13
    jr z, Jump_013_7E39
    ld de, $0032
    call TestFlagBit
    jr c, Jump_013_7E32
    ld a, $05
    ld [wD7FB], a
    ld hl, $581C
    call StartScriptAtHL_B13
    ret

Jump_013_7E32::
    ld hl, $0B56
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
    ld hl, $0D8E
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E59::
    ld a, $06
    ld [wD7FB], a
    ld hl, $582C
    call StartScriptAtHL_B13
    ret

Jump_013_7E65::
    ld hl, $0B5A
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
    ld hl, $0D8F
    call StartMessageCommand09HL_B13
    ret

Jump_013_7E8C::
    ld a, $07
    ld [wD7FB], a
    ld hl, $583C
    call StartScriptAtHL_B13
    ret

Jump_013_7E98::
    ld hl, $0B5E
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $0B6D, whose string begins 'Breeding fire and ice together makes'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wCB81, hTemp1, hTemp0
; writes: wDataBank, wD7FB
Talk0B6D_BreedingFireAndIce:: ; heuristic: target of a pointer table; C0
Func_013_7E9F:: ; address name
    farcall SaveScreenBufferToBGMap1
    call SavePlayerPositionState
    ld a, $0E
    ld [wDataBank], a
    ld a, [wCB81]
    cp a, $14
    jr z, Jump_013_7ECF
    ld de, $0035
    call TestFlagBit
    jr c, Jump_013_7EC8
    ld a, $08
    ld [wD7FB], a
    ld hl, $584C
    call StartScriptAtHL_B13
    ret

Jump_013_7EC8::
    ld hl, $0B6D
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
    ld hl, $0D85
    call StartMessageCommand09HL_B13
    ret

Jump_013_7EEF::
    ld a, $09
    ld [wD7FB], a
    ld hl, $585C
    call StartScriptAtHL_B13
    ret

Jump_013_7EFB::
    ld hl, $0B73
    call StartMessageCommand09HL_B13
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0D90, whose string begins 'Humph I'm Terry. Terry I'm a'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
Talk0D90_HumphImTerryTerry:: ; heuristic: target of a pointer table; C0
Func_013_7F02:: ; address name
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
    ld hl, $0D90
    call StartMessageCommand09HL_B13
    ret

Jump_013_7F23::
    ld hl, $5899
    call StartScriptAtHL_B13
    ret

Jump_013_7F2A::
    ld hl, $0BB3
    call StartMessageCommand09HL_B13
    ret

; map event: with story flag $25 set, sets wCB8A = $30 when the count from Func_085_5B04 is at least 50 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, hTemp0
; writes: wCB8A
SetWCB8A30IfFlag25AndCountAtLeast50:: ; heuristic: target of a pointer table; C0
Func_013_7F31:: ; address name
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
    ld [wCB8A], a
    ret

; sets story flag $C9 if flag $32 is set and flag $CA if flag $33 is set (E-0122)
; no direct call (reached through a table, a jump or a vector)
SetFlagsC9AndCAFrom32And33:: ; heuristic: target of a pointer table; C0
Func_013_7F4E:: ; address name
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
SetFlagsCBAndCCFrom35And36:: ; heuristic: target of a pointer table; C0
Func_013_7F6A:: ; address name
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
IfFlag0021StartScript5988:: ; heuristic: target of a pointer table; C0
Func_013_7F86:: ; address name
    ld de, $0021
    call TestFlagBit
    ret nc
    ld hl, $5988
    call StartScriptAtHL_B13
    ret

; the same 28 bytes as InventoryHasFreeSlotCheck (04:7C37)
; 5 call sites from 5 routines (e.g. DispatchTalkEvent_Case01_Case77, DispatchTalkEvent_Case01_Case0D, DispatchTalkEvent_Case01_Case07, DispatchTalkEvent_Case01_Case02, ...)
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
; 8 call sites from 7 routines (e.g. DispatchTalkEvent_Case01_Case6A, DispatchTalkEvent_Case01_Case66, Talk0B6D_BreedingFireAndIce, Talk0B56_WhenYouBreedMonsters, ...)
; reads: wCB86, hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords, wC8F0, wC8F1, wC8F4, ...
; writes: wC937, wC938, wC939, wC93A, wC93B, wC93C, wC93D, wC93E, ...
SavePlayerPositionState::
Func_013_7FB0:: ; address name
    ld a, [wCB86]
    ld [wC937], a
    ldh a, [hPlayerX]
    ld [wC938], a
    ldh a, [hPlayerY]
    ld [wC939], a
    ldh a, [hPlayerFacing]
    ld [wC93A], a
    ld a, [wFollowerRecords]
    ld [wC93B], a
    ld a, [wC8F0]
    ld [wC93C], a
    ld a, [wC8F1]
    ld [wC93D], a
    ld a, [wC8F4]
    ld [wC93E], a
    ld a, [wC8F5]
    ld [wC93F], a
    ld a, [wC8F6]
    ld [wC940], a
    ld a, [wC8F9]
    ld [wC941], a
    ld a, [wC8FA]
    ld [wC942], a
    ld a, [wC8FB]
    ld [wC943], a
    ret
    db $00, $00, $00, $00
