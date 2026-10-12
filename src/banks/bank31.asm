SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

; start-up for wGameMode = 4, the battle: starts music 2, clears the BG map and builds the battle screen; reached from the debug battle setup (Start) and from encounters (E-0042)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case04)
; reads: wSGBActive, wIsCGB
; writes: wSGBPaletteSet, wSGBAttrFile, hScrollX, hScrollXHi, hScrollY, hScrollYHi, rVBK, wTextCursorLo, ...
GameMode4_Init::
Func_031_4001:: ; address name
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_031_401F
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

Jump_031_401F::
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $C3
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_031_404B
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a, a
    call FillBytes
    xor a, a
    ldh [rVBK], a

Jump_031_404B::
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    farcall GameMode4_Init_Sub01
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $FC
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0B
    jp Jump_000_077A

; per-frame routine for wGameMode = 4, the battle: in link mode (wC58A) it serves the serial link, otherwise IncrementPlayTime_Bank31 and the phase machine Func_031_40CC (wCFC8 = phase (1 fight, 2 after), wCFC9 = step)
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case04)
; reads: wLinkMode, wEffectId, wEffectAnimState, wBattlePhase
GameMode4_Update::
Func_031_40A5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_40C9
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp a, $FF
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp a, $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

Jump_031_40C9::
    call IncrementPlayTime_Bank31

; runs BattlePhase0, BattlePhaseFight or BattlePhaseEnd for wBattlePhase (E-0122)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_Case01)
; reads: wBattlePhase
RunBattlePhase::
Func_031_40CC:: ; address name
    ld a, [wBattlePhase]
    rst $00
    dw BattlePhase0
    dw BattlePhaseFight
    dw BattlePhaseEnd

; wBattlePhase = 0: the start of the battle (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhase0::
Jump_031_40D6:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw BattlePhase0_Step0
    dw BattlePhase0_Step1
    dw BattlePhase0_Step2
    dw BattlePhase0_Step3
    dw BattlePhase0_Step4

; wBattlePhase 0, wBattleStep 0 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wBattleStep
BattlePhase0_Step0::
Jump_031_40E4:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 0, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wBattleArg0, wArg1
; points at: wBattleStep
BattlePhase0_Step1::
Jump_031_40EE:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleArg0], a
    ld a, [wLinkMode]
    and a, a
    ret z
    xor a, a
    ld [wArg1], a
    ret

; wBattlePhase 0, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wArg1, wBattlePictureIds, wBattleFoeCount
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wTextBuf1, wTextBuf2, wBattleStep
BattlePhase0_Step2::
Jump_031_4106:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, Jump_031_418E
    ld a, [wArg1]
    rst $00
    dw BattlePhase0_Step2_Case00
    dw BattlePhase0_Step2_Case01
    dw BattlePhase0_Step2_Case02
    dw BattlePhase0_Step2_Case03

; entry 0 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1
; writes: wArg1, wLinkSendByte
BattlePhase0_Step2_Case00::
Jump_031_4119:: ; address name
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld a, $D2
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wArg1
; writes: wLinkSendByte, wArg1
BattlePhase0_Step2_Case01::
Jump_031_4126:: ; address name
    ld a, [wLinkMessage]
    cp a, $D2
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ret

; entry 2 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1
; writes: wArg1, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wPlayerName, wBattleByte58
BattlePhase0_Step2_Case02::
Jump_031_4138:: ; address name
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld hl, wPlayerName
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $000A
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wBattleByte58
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 3 of the `rst $00` table in BattlePhase0_Step2
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkReady, wArg1, wBattleByte62, wStringIndex, wStringCategory
; points at: wBattleByte58, wTextBuf0, wBattleStep
BattlePhase0_Step2_Case03::
Jump_031_416B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    xor a, a
    ld [wArg1], a
    ld a, $F0
    ld [wBattleByte62], a
    ld de, wBattleByte58
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    jp Jump_031_4213

Jump_031_418E::
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    ld h, a
    ld de, wTextBuf0
    call CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    ld h, a
    ld de, wTextBuf1
    ld a, [wBattleFoeCount]
    cp a, $01
    call nz, CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    ld h, a
    ld de, wTextBuf2
    ld a, [wBattleFoeCount]
    cp a, $03
    call z, CopyMonsterNameToDE_Bank31
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, Jump_031_420F
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattlePictureIds + $2]
    cp a, e
    jr nz, Jump_031_41F2
    ld a, [wBattlePictureIds + $3]
    cp a, d
    jr nz, Jump_031_41F2
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, Jump_031_4213
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, Jump_031_421A
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, Jump_031_421A
    jr Jump_031_4213

Jump_031_41F2::
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, Jump_031_421E
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, Jump_031_4222
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, Jump_031_4222
    jr Jump_031_4226

Jump_031_420F::
    ld a, $00
    jr Jump_031_4228

Jump_031_4213::
    ld hl, wTextBuf0
    ld a, $01
    jr Jump_031_4228

Jump_031_421A::
    ld a, $02
    jr Jump_031_4228

Jump_031_421E::
    ld a, $03
    jr Jump_031_4228

Jump_031_4222::
    ld a, $04
    jr Jump_031_4228

Jump_031_4226::
    ld a, $05

Jump_031_4228::
    ld [wStringIndex], a ; 'Monsters appear!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; HL = monster id: H += 2 (string categories 2 and 3 hold the monster names), then CopyStringHLToDE (E-0115)
; 3 call sites from 1 routine (e.g. BattlePhase0_Step2_Case03)
CopyMonsterNameToDE_Bank31::
Func_031_423B:: ; address name
    ld a, h
    add a, $02
    ld h, a
    call CopyStringHLToDE
    ret

; wBattlePhase 0, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMode, wBattleKind, wRandomLo, wRandomHi
; writes: wBattleStep, wBattleSubPhase, wStringIndex, wBattleArg0, wStringCategory, wBattleTurn
; points at: wBattlePhase, wSlotMarks
BattlePhase0_Step3::
Jump_031_4243:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a, a
    jp nz, Jump_031_42CF
    ld a, [wBattleKind]
    cp a, $02
    jp nc, Jump_031_42CF
    call NextTableByte
    ld a, [wRandomLo]
    cp a, $08
    jr nc, Jump_031_4280
    ld a, [wRandomHi]
    and a, $01
    add a, $0B
    ld [wStringIndex], a
    ld a, $00
    ld [wBattleArg0], a
    ld c, $04
    jr Jump_031_429B

Jump_031_4280::
    call NextTableByte
    ld a, [wRandomHi]
    cp a, $08
    jr nc, Jump_031_42CF
    ld a, [wRandomLo]
    and a, $01
    add a, $0D
    ld [wStringIndex], a
    ld a, $01
    ld [wBattleArg0], a
    ld c, $00

Jump_031_429B::
    ld b, $03

Jump_031_429D::
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, Jump_031_42B0
    ld [hl], $03
    jr Jump_031_42B2

Jump_031_42B0::
    ld [hl], $FF

Jump_031_42B2::
    inc c
    dec b
    jr nz, Jump_031_429D
    ld a, $00
    ld [wStringCategory], a
    call BattlePhase0_Step3_Sub01
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattlePhase
    dec [hl]
    ld a, $04
    ld [wBattleStep], a
    jr Jump_031_42D4

Jump_031_42CF::
    ld a, $01
    ld [wBattleTurn], a

Jump_031_42D4::
    ret

; only called from BattlePhase0_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattlePhase0_Step3)
; reads: wBattlePictureIds, wBattleFoeCount, wStringIndex
; points at: wTextBuf0
BattlePhase0_Step3_Sub01::
Func_031_42D5:: ; address name
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, Jump_031_4305
    ld a, [wBattlePictureIds + $2]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [wBattlePictureIds + $3]
    cp a, d
    jr nz, Jump_031_4329
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, Jump_031_430A
    ld a, [wBattlePictureIds + $4]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [wBattlePictureIds + $5]
    cp a, d
    jr nz, Jump_031_4329
    jr Jump_031_430A

Jump_031_4305::
    call BattlePhase0_Step3_Sub01_Sub01
    jr Jump_031_4364

Jump_031_430A::
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    jr Jump_031_4364

Jump_031_4329::
    ld hl, wTextBuf0
    ld de, Data_031_438E
    ld b, $09
    ld a, [wStringIndex]
    cp a, $0B
    jr nz, Jump_031_433F
    ld de, Data_031_4397
    ld b, $09
    jr Jump_031_435E

Jump_031_433F::
    cp a, $0C
    jr nz, Jump_031_434A
    ld de, Data_031_4397
    ld b, $0D
    jr Jump_031_435E

Jump_031_434A::
    cp a, $0D
    jr nz, Jump_031_4355
    ld de, Data_031_4397
    ld b, $0D
    jr Jump_031_435E

Jump_031_4355::
    cp a, $0E
    jr nz, Jump_031_435E
    ld b, $09
    ld de, Data_031_4397

Jump_031_435E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_435E

Jump_031_4364::
    ret

; only called from BattlePhase0_Step3_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattlePhase0_Step3_Sub01)
; reads: wStringCategory, wStringIndex
; writes: wStringCategory, wStringIndex
; points at: wTextBuf0
BattlePhase0_Step3_Sub01_Sub01::
Func_031_4365:: ; address name
    ld a, [wStringCategory]
    ld l, a
    ld a, [wStringIndex]
    ld h, a
    push hl
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld hl, wTextBuf0

Jump_031_437C::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_031_4384
    inc hl
    jr Jump_031_437C

Jump_031_4384::
    pop de
    ld a, e
    ld [wStringCategory], a
    ld a, d
    ld [wStringIndex], a
    ret

; address loaded by BattlePhase0_Step3_Sub01
Data_031_438E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $32, $31, $36, $37, $28, $35, $36, $F0

; address loaded by BattlePhase0_Step3_Sub01
Data_031_4397:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $16, $32, $31, $36, $37, $28, $35, $36, $F0

; wBattlePhase 0, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0
; writes: wBattleStep
; points at: wBattlePhase
BattlePhase0_Step4::
Jump_031_43A0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    ld a, [wBattleArg0]
    or a, a
    ret

; wBattlePhase = 1: the fight; steps: 1 set-up, 2 command entry, 3 executing the actions (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhaseFight::
Jump_031_43B2:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw BattleFight_Step0
    dw BattleFight_Step1
    dw BattleFight_Step2
    dw BattleFight_Step3
    dw BattleFight_Step4

; wBattlePhase 1, wBattleStep 0 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleStep
BattleFight_Step0::
Jump_031_43C0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call BattleFight_Step0_Sub01
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 1, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step1::
Jump_031_43CD:: ; address name
    call RunBattleSetup
    ret

; wBattlePhase 1, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step2::
Jump_031_43D1:: ; address name
    farcall RunBattleCommandEntry
    ret

; wBattlePhase 1, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step3::
Jump_031_43D8:: ; address name
    farcall RunBattleActions
    ret

; wBattlePhase 1, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
BattleFight_Step4::
Jump_031_43DF:: ; address name
    farcall RunBattleStep4
    ret

; wBattlePhase = 2: after the fight; steps 0-9 (result message, rewards, recruiting) (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
BattlePhaseEnd::
Jump_031_43E6:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw BattleEnd_Step0
    dw BattleEnd_Step1
    dw BattleEnd_Step2
    dw BattleEnd_Step3
    dw BattleEnd_Step4
    dw BattleEnd_Step5
    dw BattleEnd_Step6
    dw BattleEnd_Step7
    dw BattleEnd_Step7
    dw BattleEnd_Step9

; wBattlePhase 2, wBattleStep 0 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStep
BattleEnd_Step0::
Jump_031_43FE:: ; address name
    ld a, $02
    call QueueMusic
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wLinkMode, wBattleArg0
; writes: wBattleKindFlags, wStringIndex, wStringCategory
; points at: wBattleStep
BattleEnd_Step1::
Jump_031_440E:: ; address name
    ld a, $01
    ld [wBattleKindFlags], a
    call BattleEnd_Step1_Sub02
    ld a, [wBattleScene]
    and a, $01
    jr z, Jump_031_4421
    ld a, $06
    jr Jump_031_4448

Jump_031_4421::
    call BattleEnd_Step1_Sub01
    ld a, [wBattleScene]
    cp a, $02
    jr z, Jump_031_4443
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_031_4436
    ld a, $87
    jr Jump_031_4448

Jump_031_4436::
    ld a, [wBattleArg0]
    cp a, $01
    ld a, $07
    jr nc, Jump_031_4448
    ld a, $86
    jr Jump_031_4448

Jump_031_4443::
    ld a, [wBattleArg0]
    add a, $08

Jump_031_4448::
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots, wTextFlags
; writes: wBattleSubPhase
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5, wBattleStep
BattleEnd_Step2::
Jump_031_445B:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step2_Sub01
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; only called from BattleEnd_Step2 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step2)
; reads: wBattleEndTimer
; writes: wBattleEndTimer
BattleEnd_Step2_Sub01::
Func_031_4493:: ; address name
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleScene, wDisplaySlot
; writes: wBattleSubPhase
; points at: wBattleStep, wRecordBufA, wPlayerName
BattleEnd_Step3::
Jump_031_449C:: ; address name
    call BattleEnd_Step3_Sub07
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_44C4
    ld a, [wBattleScene]
    or a, a
    jr z, Jump_031_44D1
    cp a, $03
    jr z, Jump_031_44BB
    cp a, $02
    jr z, Jump_031_44BB

Jump_031_44BB::
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

Jump_031_44C4::
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

Jump_031_44D1::
    ld a, [wDisplaySlot]
    cp a, $FF
    ret z
    sub a, $04
    ret c
    cp a, $03
    ret nc
    ld a, [wLinkMode]
    or a, a
    call z, BattleEnd_Step3_Sub05
    call BattleEnd_Step3_Sub06
    ld a, [wDisplaySlot]
    dec a
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld e, a
    ld a, h
    adc a, $D0
    ld d, a
    ld hl, wRecordBufA
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $0E
    call CopyBBytesDEToHL_Bank31
    push de
    ld de, wPlayerName
    ld b, $0B
    call CopyBBytesDEToHL_Bank31
    pop de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $FF
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $FF
    ld [hl+], a
    ld b, $08
    call BattleEnd_Step3_Sub03
    ld a, $FF
    ld b, $19

Jump_031_452D::
    ld [hl+], a
    dec b
    jr nz, Jump_031_452D
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld [hl+], a
    ld b, $15
    call CopyBBytesDEToHL_Bank31
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld b, $1F
    call CopyBBytesDEToHL_Bank31
    call BattleEnd_Step3_Sub04
    ld a, $00
    ld [hl+], a
    call BattleEnd_Step3_Sub04
    ld a, $00
    ld [hl+], a
    ld a, [de]
    ld [hl+], a
    farcall BattleEnd_Step3_Sub02
    farcall BattleEnd_Step3_Sub01
    farcall LoadTable4E60EntryForWC991ToWC9DE
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 4 call sites from 1 routine (e.g. BattleEnd_Step3)
CopyBBytesDEToHL_Bank31::
Func_031_4566:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank31
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
BattleEnd_Step3_Sub03::
Func_031_456D:: ; address name
    push hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    push hl

Jump_031_457A::
    ld a, [de]
    inc de
    cp a, $C8
    jr z, Jump_031_4581
    ld [hl+], a

Jump_031_4581::
    dec b
    jr nz, Jump_031_457A
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3 (E-0047)
; 4 call sites from 1 routine (e.g. BattleEnd_Step3)
BattleEnd_Step3_Sub04::
Func_031_458E:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld b, $06

Jump_031_459E::
    ld [hl+], a
    dec b
    jr nz, Jump_031_459E
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wBattleFoeCount, wBattleExpAward
; writes: wBattleExpAward
; points at: wBattleSlotOut
BattleEnd_Step3_Sub05::
Func_031_45A3:: ; address name
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    xor a, a
    ld [wBattleExpAward], a
    ld [wBattleExpAward + $1], a
    ld [wBattleExpAward + $2], a

Jump_031_45B3::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_45E7
    ld a, c
    and a, $03
    ld hl, Data_031_45EC
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wBattleExpAward]
    add a, [hl]
    ld [wBattleExpAward], a
    inc hl
    ld a, [wBattleExpAward + $1]
    adc a, [hl]
    ld [wBattleExpAward + $1], a
    inc hl
    ld a, [wBattleExpAward + $2]
    adc a, [hl]
    ld [wBattleExpAward + $2], a

Jump_031_45E7::
    inc c
    dec b
    jr nz, Jump_031_45B3
    ret

; address loaded by BattleEnd_Step3_Sub05
Data_031_45EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $D1, $25, $D2, $73, $D2

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wBattleKind, wBattleFoeCount, wEncounterMonsters
; writes: hTemp0, hTemp1, wDisplaySlot, wScreenSavedFlag
; points at: wEncounterMonsters
BattleEnd_Step3_Sub06::
Func_031_45F2:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    ret nz
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, Jump_031_461B
    cp a, $02
    jr z, Jump_031_461B
    ld hl, wEncounterMonsters + $2
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, $05
    ld [wDisplaySlot], a
    ld a, [wEncounterMonsters + $2]
    ld l, a
    ld a, [wEncounterMonsters + $3]
    ld h, a
    jr Jump_031_4631

Jump_031_461B::
    ld hl, wEncounterMonsters
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wEncounterMonsters]
    ld l, a
    ld a, [wEncounterMonsters + $1]
    ld h, a
    ld a, $04
    ld [wDisplaySlot], a

Jump_031_4631::
    ld a, h
    or a, a
    jr nz, Jump_031_4650
    ld a, l
    cp a, $07
    jr z, Jump_031_4640
    cp a, $1A
    jr z, Jump_031_4648
    jr Jump_031_4680

Jump_031_4640::
    ld hl, $0008
    call BattleEnd_Step3_Sub06_Sub01
    jr Jump_031_4680

Jump_031_4648::
    ld hl, $001B
    call BattleEnd_Step3_Sub06_Sub01
    jr Jump_031_4680

Jump_031_4650::
    cp a, $01
    jr nz, Jump_031_4680
    ld a, l
    cp a, $82
    jr z, Jump_031_4663
    cp a, $AB
    jr z, Jump_031_466B
    cp a, $90
    jr z, Jump_031_4678
    jr Jump_031_4680

Jump_031_4663::
    ld hl, $0183
    call BattleEnd_Step3_Sub06_Sub01
    jr Jump_031_4680

Jump_031_466B::
    ld a, $02
    ld [wScreenSavedFlag], a
    ld hl, $01AC
    call BattleEnd_Step3_Sub06_Sub01
    jr Jump_031_4680

Jump_031_4678::
    ld hl, $01AF
    call BattleEnd_Step3_Sub06_Sub01
    jr Jump_031_4680

Jump_031_4680::
    ret

; only called from BattleEnd_Step3_Sub06 (E-0047)
; 5 call sites from 1 routine (e.g. BattleEnd_Step3_Sub06)
; reads: hTemp0, hTemp1
BattleEnd_Step3_Sub06_Sub01::
Func_031_4681:: ; address name
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    farcall BattleEnd_Step3_Sub06_Sub01_Sub01
    ret

; wBattlePhase 2, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
BattleEnd_Step4::
Jump_031_4693:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step4_Sub01
    call BattleEnd_Step4_Sub02
    ret

; only called from BattleEnd_Step4 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step4)
; reads: wBattleEndTimer
; writes: wBattleEndTimer
BattleEnd_Step4_Sub01::
Func_031_46C1:: ; address name
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 5 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step5::
Jump_031_46CA:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step5_Case00
    dw BattleEnd_Step5_Case01
    dw BattleEnd_Step5_Case02
    dw BattleEnd_Step5_Case03
    dw BattleEnd_Step5_Case04

; entry 0 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wDisplaySlot, wSpeciesIdLo, wSpeciesIdHi
; writes: wBattleSubPhase, wBattlePictureIds, wBattleResolveStep, wBattleSubStep
; points at: wBattleStep, wBattleSubPhase
BattleEnd_Step5_Case00::
Jump_031_46D8:: ; address name
    farcall BattleEnd_Step5_Case00_Sub01
    ld a, [wDisplaySlot]
    cp a, $FF
    jr nz, Jump_031_46EE
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

Jump_031_46EE::
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    ld [wBattlePictureIds], a
    ld a, h
    ld [wBattlePictureIds + $1], a
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call ClearWindowAndCopyRect7345Far
    ld a, $6C
    call QueueSoundEffect
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_Step5_Case01::
Jump_031_471C:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_Step5_Case01_Case00
    dw BattleEnd_Step5_Case01_Case01

; entry 0 of the `rst $00` table in BattleEnd_Step5_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer, wBattleResolveStep
BattleEnd_Step5_Case01_Case00::
Jump_031_4724:: ; address name
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM
    call LoadBattleMonsterPictureAndTitle
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    ld de, wScreenTileBuffer + $E7
    ld hl, vBGMap0 + $E7
    ld bc, $0606
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step5_Case01
; no direct call (reached through a table, a jump or a vector)
BattleEnd_Step5_Case01_Case01::
Jump_031_474A:: ; address name
    farcall BattleEnd_Step5_Case01_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wSavedSpriteClipMode, wSavedFieldDrawFlags, wSavedSpriteSlotCount
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wSpriteSlotCount
; points at: wBattleSubPhase, wBattleSubStep
BattleEnd_Step5_Case02::
Jump_031_4751:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    call BuildBattleScreenBuffer
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToVRAM
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep, wBattleScreenFlags
BattleEnd_Step5_Case03::
Jump_031_4793:: ; address name
    ld a, [wBattleSubStep]
    cp a, $03
    call z, BuildAndDrawBattleScreen
    farcall RunBattleSubStep_6A4E
    ld a, [wBattleScreenFlags]
    or a, a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; BuildBattleScreenBuffer, then copies the 20 x 18 wScreenTileBuffer to vBGMap0 (CopyRect32StrideToVRAM) (E-0115)
; 1 call site from 1 routine (e.g. BattleEnd_Step5_Case03)
; points at: wScreenTileBuffer
BuildAndDrawBattleScreen::
Func_031_47A9:: ; address name
    call BuildBattleScreenBuffer
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412
    call CopyRect32StrideToVRAM
    ret

; entry 4 of the `rst $00` table in BattleEnd_Step5
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScreenFlags
BattleEnd_Step5_Case04::
Jump_031_47B9:: ; address name
    farcall BattleEnd_Step5_Case04_Sub01
    ld a, [wBattleScreenFlags]
    or a, a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; runs Func_031_47DD, ClearAttributesAndScreenBuffer_Bank31, CopyRectRecordForBattlePartyCount_Bank31, Func_031_7389, LayoutTileBlocksForBattleFoeCount, Func_031_7321 and Func_031_746F in turn (E-0115)
; 2 call sites from 2 routines (e.g. BuildAndDrawBattleScreen, BattleEnd_Step5_Case02)
BuildBattleScreenBuffer::
Func_031_47C7:: ; address name
    call LoadBattleMonsterPictureAndTitle
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    call ClearWindowAndCopyRect7345Far
    ret

; loads the picture of battle monster wDAAB at vTiles2 + $140, uploads palettes, loads name tiles and shows string 5 of category 2 (bank 09) at vTiles1 + $6D0, then restores the default window (E-0121)
; 4 call sites from 4 routines (e.g. BattleEnd_Step5_Case04, BattleEnd_Step5_Case03, BuildBattleScreenBuffer, BattleEnd_Step5_Case01_Case00)
; reads: wDisplaySlot
; writes: wBattleScreenFlags, wBGPaletteUploadRequest, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wBattleMonsterId
LoadBattleMonsterPictureAndTitle::
Func_031_47DD:: ; address name
    xor a, a
    ld [wBattleScreenFlags], a
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    call LoadRecordListNameTiles
    ld hl, vTiles1 + $6D0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'InfoOKMonsterEgg'
    farcall ShowString_Bank09
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
    ret

; wBattlePhase 2, wBattleStep 6 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step6::
Jump_031_4840:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step6_Case00
    dw BattleEnd_Step6_Case01
    dw BattleEnd_Step6_Case02

; entry 0 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wCurrentMusic
; writes: hSpriteWindowClipMode, hSpriteHideTile
; points at: wTransitionByteCD, wBattleSubPhase
BattleEnd_Step6_Case00::
Jump_031_484A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wCurrentMusic]
    ld hl, wTransitionByteCD
    cp a, [hl]
    jr z, Jump_031_485D
    ld a, $02
    call QueueMusic

Jump_031_485D::
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, $04
    call StartPaletteFade
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wBattleSubPhase
BattleEnd_Step6_Case01::
Jump_031_486E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step6
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic, wBattleKind
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wNewRecordByte0D, wScreenState, wFieldInitStage
; points at: wTransitionByteCD, wBGFillFlag
BattleEnd_Step6_Case02::
Jump_031_4878:: ; address name
    ld a, [wCurrentMusic]
    ld hl, wTransitionByteCD
    cp a, [hl]
    jr z, Jump_031_4885
    ld a, [hl]
    call QueueMusic

Jump_031_4885::
    ld a, [wBattleKind]
    cp a, $02
    jr c, Jump_031_4893
    cp a, $04
    jr nc, Jump_031_4893
    call SetFollowersToPlayer

Jump_031_4893::
    ld a, $01
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wNewRecordByte0D], a
    ld [wScreenState], a
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ExitPauseMenuToField
    ld a, $02
    ld [wFieldInitStage], a
    ld hl, wBGFillFlag
    inc [hl]
    ret

; copies hPlayerFacing to the three follower directions and hPlayerX/hPlayerY to the three follower positions (the facing-preserving form of ResetFollowersToPlayer) (E-0118)
; 1 call site from 1 routine (e.g. BattleEnd_Step6_Case02)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wFollowerRecords
SetFollowersToPlayer::
Func_031_48C3:: ; address name
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ret

; wBattlePhase 2, wBattleStep 7 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step7::
Jump_031_48E5:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step7_Case00
    dw BattleEnd_Step7_Case01
    dw BattleEnd_Step7_Case02

; entry 0 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots, wTextFlags
; writes: wLinkSendByte
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5, wBattleSubPhase
BattleEnd_Step7_Case00::
Jump_031_48EF:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wBattleSubPhase
BattleEnd_Step7_Case01::
Jump_031_4926:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in BattleEnd_Step7
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, wLinkSession, wLinkExchangeState, wLinkRole, ...
; points at: wModeChangeRequest, wBGFillFlag
BattleEnd_Step7_Case02::
Jump_031_4931:: ; address name
    ld a, $04
    call StartPaletteFade
    farcall BattleEnd_Step7_Case02_Sub01
    ld a, $06
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkScreenStep], a
    ret

; wBattlePhase 2, wBattleStep 9 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; writes: wBattleStep
BattleEnd_Step9::
Jump_031_4975:: ; address name
    ld a, [wBattleScene]
    cp a, $04
    jr z, Jump_031_4983
    ld a, $42
    call QueueMusic
    jr Jump_031_4988

Jump_031_4983::
    ld a, $7E
    call QueueSoundEffect

Jump_031_4988::
    ld a, $07
    ld [wBattleStep], a
    ret

; only called from BattleEnd_Step1 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1)
; reads: wLinkMode, wBattleFoeCount
; writes: wBattleArg0
; points at: wBattlePictureIds, wTextBuf0, wBattleByte58
BattleEnd_Step1_Sub01::
Func_031_498E:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_49E5
    xor a, a
    ld [wBattleArg0], a
    ld hl, wBattlePictureIds
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, BattleEnd_Step1_Sub01_Sub01
    ld a, $01
    ld [wBattleArg0], a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_031_4A00
    ld a, [hl+]
    cp a, d
    jr nz, Jump_031_4A00
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, Jump_031_49C2
    ld a, [hl+]
    cp a, e
    jr nz, Jump_031_4A00
    ld a, [hl]
    cp a, d
    jr nz, Jump_031_4A00

Jump_031_49C2::
    call BattleEnd_Step1_Sub01_Sub01
    ld hl, wTextBuf0

Jump_031_49C8::
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_031_49C8
    dec hl
    ld a, $33
    ld [hl+], a
    ld a, $34
    ld [hl+], a
    ld [hl], $F0
    jr Jump_031_4A22

; only called from BattleEnd_Step1_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1_Sub01)
; points at: wTextBuf0
BattleEnd_Step1_Sub01_Sub01::
Func_031_49D8:: ; address name
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    jr Jump_031_4A22

Jump_031_49E5::
    ld de, wBattleByte58
    ld hl, wTextBuf0
    ld b, $0A

Jump_031_49ED::
    ld a, [de]
    cp a, $F0
    jr z, Jump_031_49F7
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_49ED

Jump_031_49F7::
    ld [hl], $F0
    ld a, $00
    ld [wBattleArg0], a
    jr Jump_031_4A22

Jump_031_4A00::
    ld hl, wTextBuf0
    ld a, $30
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $31
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $37
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld [hl], $F0
    ld a, $02
    ld [wBattleArg0], a

Jump_031_4A22::
    ret

; the same 66 bytes as IncrementPlayTime (02:5F59)
; 1 call site from 1 routine (e.g. GameMode4_Update)
; reads: wPlayHoursLo, wPlayHoursHi, wPlayMinutes
; points at: wPlayFrames
IncrementPlayTime_Bank31::
Func_031_4A23:: ; address name
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    or a, a
    jr nz, Jump_031_4A3F
    ld a, [wPlayMinutes]
    cp a, $3B
    ret z

Jump_031_4A3F::
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret

; only called from BattleFight_Step0 (E-0047)
; 1 call site from 1 routine (e.g. BattleFight_Step0)
; reads: wSide0Flag, wLinkMode, wLinkRole, wSide1Flag
; writes: wBattleFlag92, wBattleFlag93, wMenuState
; points at: wSideControl, wSlotFlags854, wActionQueue, wBattleActionChoice, wSlotMarks, wBattleStep, wBattleStatus3
BattleFight_Step0_Sub01::
Func_031_4A65:: ; address name
    ld hl, wSideControl
    ld b, $08

Jump_031_4A6A::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_031_4A6A
    ld hl, wSlotFlags854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld a, $00
    ld [wMenuState], a
    ld a, [wSide0Flag]
    ld b, a
    ld c, $00
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_4AB5
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_4AB5
    ld a, [wSide1Flag]
    ld b, a
    ld c, $04

Jump_031_4AB5::
    push bc
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld c, $00

Jump_031_4AC1::
    ld a, [hl+]
    or a, a
    jr nz, Jump_031_4AC6
    inc c

Jump_031_4AC6::
    dec b
    jr nz, Jump_031_4AC1
    ld a, c
    or a, a
    jr nz, Jump_031_4AD1
    ld hl, wBattleStep
    inc [hl]

Jump_031_4AD1::
    pop bc

Jump_031_4AD2::
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_4B01
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_031_4B01
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_4B01
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_031_4B01
    ld a, [hl+]
    and a, $30
    jr nz, Jump_031_4B01
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_031_4B01
    ld e, $00

Jump_031_4B01::
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], e
    inc c
    dec b
    jr nz, Jump_031_4AD2
    ret

; battle fight step 1: one sub-step per wBattleSubPhase (13 cases, 0-12 observed in the first battle) that builds the battle screen and loads the combatants
; 1 call site from 1 routine (e.g. BattleFight_Step1)
; reads: wBattleSubPhase
RunBattleSetup::
Func_031_4B10:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleSetup_Case00
    dw RunBattleSetup_Case01
    dw RunBattleSetup_Case02
    dw RunBattleSetup_Case03
    dw RunBattleSetup_Case04
    dw RunBattleSetup_Case05
    dw RunBattleSetup_Case06
    dw RunBattleSetup_Case07
    dw RunBattleSetup_Case08
    dw RunBattleSetup_Case09
    dw RunBattleSetup_Case0A
    dw RunBattleSetup_Case0B
    dw RunBattleSetup_Case0C

; entry 0 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_Case00::
Jump_031_4B2E:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_Case00_Case00
    dw RunBattleSetup_Case00_Case01
    dw RunBattleSetup_Case00_Case02
    dw RunBattleSetup_Case00_Case03
    dw RunBattleSetup_Case00_Case04
    dw RunBattleSetup_Case00_Case05
    dw RunBattleSetup_Case00_Case06
    dw RunBattleSetup_Case00_Case07
    dw RunBattleSetup_Case00_Case08
    dw RunBattleSetup_Case00_Case09
    dw RunBattleSetup_Case00_Case0A
    dw RunBattleSetup_Case00_Case0B
    dw RunBattleSetup_Case00_Case0C
    dw RunBattleSetup_Case00_Case0D
    dw RunBattleSetup_Case00_Case0E
    dw RunBattleSetup_Case00_Case0F
    dw RunBattleSetup_Case00_Case10

; entry 0 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
; points at: wBattleSetupF2, wSlotTactic, wBattleResolveStep
RunBattleSetup_Case00_Case00::
Jump_031_4B54:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_4B5E
    ld c, $00
    jr Jump_031_4B66

Jump_031_4B5E::
    ld a, [wLinkRole]
    and a, $02
    sla a
    ld c, a

Jump_031_4B66::
    ld de, wBattleSetupF2
    ld b, $03

Jump_031_4B6B::
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc c
    dec b
    jr nz, Jump_031_4B6B
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
; writes: wStringCategory, wStringIndex
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_Case00_Case01::
Jump_031_4B8F:: ; address name
    ld a, [wLinkRole]
    rlca
    and a, $04
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278RowsToBGMapRow7
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_Shared04
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case02::
Jump_031_4BCC:: ; address name
    call RunBattleSetup_Shared05
    ld hl, Data_031_639F
    ld a, [wMenuState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wMenuState, wMenuSubState, wBattleResolveStep
RunBattleSetup_Case00_Case03::
Jump_031_4BEE:: ; address name
    ld de, Data_031_639F
    ld hl, wMenuState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_4C18
    ld a, $69
    call QueueSoundEffect
    ld hl, wMenuSubState
    ld bc, $0007
    ld a, $00
    call FillBytes
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_4C18::
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case04::
Jump_031_4C19:: ; address name
    call RunBattleSetup_Shared05
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState, wLinkMode, wBattleKind, wLinkRole
; writes: wBattleSetupDB, wStringIndex, wStringCategory, wBattleSubPhase, wBattleResolveStep, wCommandMonster
; points at: wBattleResolveStep, wSlotMarks
RunBattleSetup_Case00_Case05::
Jump_031_4C21:: ; address name
    ld a, [wMenuState]
    and a, $03
    ld [wBattleSetupDB], a
    or a, a
    jr z, Jump_031_4C37
    cp a, $01
    jr z, Jump_031_4C49
    cp a, $02
    jr z, Jump_031_4C83
    jp Jump_031_4CBC

Jump_031_4C37::
    call RunBattleSetup_Case00_Case05_Sub01
    call RunBattleSetup_Case00_Case05_Sub02
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jp Jump_031_4CED

Jump_031_4C49::
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld c, a
    ld b, $03

Jump_031_4C53::
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_031_4C74
    inc c
    dec b
    jr nz, Jump_031_4C53
    ld a, $00
    ld [wStringCategory], a
    ld a, $2D
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_4CED

Jump_031_4C74::
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_4CED

Jump_031_4C83::
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_4CA2
    ld a, [wBattleKind]
    cp a, $04
    jr z, Jump_031_4CA2
    cp a, $05
    jr z, Jump_031_4CA2
    call RunBattleSetup_Case00_Case05_Sub01
    call RunBattleSetup_Case00_Case05_Sub03
    ld a, e
    or a, a
    jr nz, Jump_031_4CB1
    ld a, $1F
    jr Jump_031_4CA4

Jump_031_4CA2::
    ld a, $1D

Jump_031_4CA4::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_4CED

Jump_031_4CB1::
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_4CED

Jump_031_4CBC::
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_4CC6
    ld a, $20
    jr Jump_031_4CA4

Jump_031_4CC6::
    call RunBattleSetup_Case00_Case05_Sub01
    ld hl, wBattleResolveStep
    ld [hl], $08
    ld a, [wBattleKind]
    cp a, $02
    jr c, Jump_031_4CED
    ld [hl], $0F
    cp a, $02
    jr z, Jump_031_4CED
    cp a, $03
    jr z, Jump_031_4CED
    cp a, $05
    jr z, Jump_031_4CED
    cp a, $06
    jr z, Jump_031_4CED
    cp a, $07
    jr z, Jump_031_4CED
    ld [hl], $0B

Jump_031_4CED::
    ret

; only called from RunBattleSetup_Case00_Case05 (E-0047)
; 3 call sites from 1 routine (e.g. RunBattleSetup_Case00_Case05)
; reads: wLinkRole
; points at: wBattleActionChoice
RunBattleSetup_Case00_Case05_Sub01::
Func_031_4CEE:: ; address name
    ld a, [wLinkRole]
    and a, $02
    ld hl, wBattleActionChoice
    add a, a
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

; only called from RunBattleSetup_Case00_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case05)
; reads: wLinkMode, wLinkRole
; points at: wBattleSetupF2, wSlotTactic
RunBattleSetup_Case00_Case05_Sub02::
Func_031_4D06:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_4D10
    ld c, $00
    jr Jump_031_4D18

Jump_031_4D10::
    ld a, [wLinkRole]
    and a, $02
    sla a
    ld c, a

Jump_031_4D18::
    ld de, wBattleSetupF2
    ld b, $03

Jump_031_4D1D::
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc de
    inc c
    dec b
    jr nz, Jump_031_4D1D
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case06::
Jump_031_4D3D:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_Case00_Case07::
Jump_031_4D4E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC338RowsToBGMapRow13
    call RunBattleSetup_Shared04
    ld a, $02
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTextBuf0, wPlayerName, wBattleResolveStep
RunBattleSetup_Case00_Case08::
Jump_031_4D65:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0A

Jump_031_4D73::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_4D73
    ld [hl], $F0
    ld a, $01
    ld [wStringCategory], a
    ld a, $D8
    ld [wStringIndex], a ; '0 fled!'
    farcall BeginStringDisplay_Bank2F
    ld a, $82
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSoundChannelSlots, wBattleTurn, wBattlePartyCount, wBattleFoeCount, wRandomLo, wLinkMode, wDataBankSave
; writes: wStringCategory, wStringIndex, wBattleScene, wBattlePhase, wBattleStep, wBattleKindFlags, wDataBank, wDataBankSave
; points at: wSoundChannel1, wBattleLevel, wBattleResolveStep
RunBattleSetup_Case00_Case09::
Jump_031_4D95:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleTurn]
    or a, a
    jr z, Jump_031_4E16
    ld a, [wBattlePartyCount]
    ld b, a
    ld e, $00
    ld c, $00
    ld hl, wBattleLevel

Jump_031_4DB5::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_4DC0
    ld a, [hl]
    cp a, e
    jr c, Jump_031_4DC0
    ld e, a

Jump_031_4DC0::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4DB5
    ld a, [wBattleFoeCount]
    ld b, a
    ld d, $00
    ld c, $04
    ld hl, wBattleLevel + $4

Jump_031_4DD0::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_4DDB
    ld a, [hl]
    cp a, d
    jr c, Jump_031_4DDB
    ld d, a

Jump_031_4DDB::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4DD0
    ld a, d
    add a, $05
    cp a, e
    jr c, Jump_031_4E16
    call NextTableByte
    ld a, [wRandomLo]
    and a, $07
    inc a
    ld b, a
    ld a, [wBattleTurn]
    cp a, $04
    jr c, Jump_031_4DF9
    ld a, $07

Jump_031_4DF9::
    cp a, b
    jr nc, Jump_031_4E16
    call RunBattleSetup_Case00_Case09_Sub01
    jr z, Jump_031_4E16
    ld a, $00
    ld [wStringCategory], a
    ld a, $2C
    ld [wStringIndex], a ; 'But the escape route was cut'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_031_4E16::
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_4E1F
    call RunBattleSetup_Case00_Case09_Sub02

Jump_031_4E1F::
    ld a, $02
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $03
    ld [wBattleStep], a
    ld a, $01
    ld [wBattleKindFlags], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; only called from RunBattleSetup_Case00_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case09)
; reads: wBattleFoeCount
RunBattleSetup_Case00_Case09_Sub01::
Func_031_4E3E:: ; address name
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    ld e, $00

Jump_031_4E46::
    ld a, c
    call CheckSlotStatusBlockWide_Bank31
    jr c, Jump_031_4E4D
    inc e

Jump_031_4E4D::
    inc c
    dec b
    jr nz, Jump_031_4E46
    ld a, e
    or a, a
    ret

; only called from RunBattleSetup_Case00_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case09)
; reads: wBattlePartyCount
; points at: wBattleLevel, wSlotTrait, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
RunBattleSetup_Case00_Case09_Sub02::
Func_031_4E54:: ; address name
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

Jump_031_4E5A::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_4EB4
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    ld e, $00
    cp a, $0A
    jr c, Jump_031_4E7D
    ld e, $01
    cp a, $14
    jr c, Jump_031_4E7D
    ld e, $02
    cp a, $1E
    jr c, Jump_031_4E7D
    ld e, $03

Jump_031_4E7D::
    ld a, c
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp a, $97
    ld hl, Data_031_4EC6
    jr c, Jump_031_4E91
    ld hl, Data_031_4ED6

Jump_031_4E91::
    ld a, e
    add a, a
    add a, a
    add_a_to_hl
    ld de, wSlotPersonalityHi
    call RunBattleSetup_Case00_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityMid
    call RunBattleSetup_Case00_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityLo
    call RunBattleSetup_Case00_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotTrait
    call RunBattleSetup_Case00_Case09_Sub02_Sub01

Jump_031_4EB4::
    inc c
    dec b
    jr nz, Jump_031_4E5A
    ret

; only called from RunBattleSetup_Case00_Case09_Sub02 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleSetup_Case00_Case09_Sub02)
RunBattleSetup_Case00_Case09_Sub02_Sub01::
Func_031_4EB9:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_031_4EBF
    inc d

Jump_031_4EBF::
    ld a, [de]
    sub a, [hl]
    ld [de], a
    ret nc
    xor a, a
    ld [de], a
    ret

; address loaded by RunBattleSetup_Case00_Case09_Sub02
Data_031_4EC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $00, $00, $0A, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

; address loaded by RunBattleSetup_Case00_Case09_Sub02
Data_031_4ED6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $00, $00, $0F, $06, $00, $00, $0A, $04, $00, $00, $05, $02, $00, $00, $03

; entry 10 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePartyCount
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wSlotMarks
RunBattleSetup_Case00_Case0A::
Jump_031_4EE6:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotMarks

Jump_031_4EF4::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_4EFE
    ld [hl], $03
    jr Jump_031_4F00

Jump_031_4EFE::
    ld [hl], $FF

Jump_031_4F00::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4EF4
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case0B::
Jump_031_4F0F:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'Retire now?'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wWindowTileBuffer, wMenuSubState
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case0C::
Jump_031_4F2A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld a, $BB
    ld [wWindowTileBuffer + $7], a
    ld a, $01
    ld [wMenuSubState], a
    ld de, wScreenTileBuffer + $10E
    ld hl, vBGMap0 + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState
; writes: wBattleResolveStep, wBattleSubPhase, wStringCategory, wStringIndex
; points at: wMenuSubState, wBattleResolveStep
RunBattleSetup_Case00_Case0D::
Jump_031_4F50:: ; address name
    ld de, Data_031_63C5
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, [wMenuSubState]
    and a, $01
    ld hl, Data_031_4FA4
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld a, [wMenuSubState]
    and a, $01
    jr z, Jump_031_4F8F
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

Jump_031_4F8F::
    ld a, $00
    ld [wStringCategory], a
    ld a, $60
    ld [wStringIndex], a ; 'You threw in the towel!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; address loaded by RunBattleSetup_Case00_Case0D
Data_031_4FA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

; entry 14 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wDataBankSave
; writes: wBattleScene, wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wDataBank, wDataBankSave
RunBattleSetup_Case00_Case0E::
Jump_031_4FA8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $03
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $06
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case00_Case0F::
Jump_031_4FCE:: ; address name
    call ClearWindowAndCopyRect7345Far
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'No fleeing from this battle!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_Case00_Case10::
Jump_031_4FE9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_Case01::
Jump_031_4FF4:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_Case01_Case00
    dw RunBattleSetup_Case01_Case01
    dw RunBattleSetup_Case01_Case02
    dw RunBattleSetup_Case01_Case03
    dw RunBattleSetup_Case01_Case04
    dw RunBattleSetup_Case01_Case05
    dw RunBattleSetup_Case01_Case06
    dw RunBattleSetup_Case01_Case07
    dw RunBattleSetup_Case01_Case08
    dw RunBattleSetup_Case01_Case09
    dw RunBattleSetup_Case01_Case0A
    dw RunBattleSetup_Case01_Case0B
    dw RunBattleSetup_Case01_Case0C
    dw RunBattleSetup_Case01_Case0D
    dw RunBattleSetup_Case01_Case0E
    dw RunBattleSetup_Case01_Case0F
    dw RunBattleSetup_Case01_Case10
    dw RunBattleSetup_Case01_Case11
    dw RunBattleSetup_Case01_Case12
    dw RunBattleSetup_Case01_Case13
    dw RunBattleSetup_Case01_Case14
    dw RunBattleSetup_Case01_Case15
    dw RunBattleSetup_Case01_Case16
    dw RunBattleSetup_Case01_Case17
    dw RunBattleSetup_Case01_Case18
    dw RunBattleSetup_Case01_Case19
    dw RunBattleSetup_Case01_Case1A
    dw RunBattleSetup_Case01_Case1B
    dw RunBattleSetup_Case01_Case1C
    dw RunBattleSetup_Case01_Case1D
    dw RunBattleSetup_Case01_Case1E
    dw RunBattleSetup_Case01_Case1F
    dw RunBattleSetup_Case01_Case20
    dw RunBattleSetup_Case01_Case21
    dw RunBattleSetup_Case01_Case16
    dw RunBattleSetup_Case01_Case23

; entry 0 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSetupD7, wCommandMonster
; writes: wStringCategory, wStringIndex, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case00::
Jump_031_5040:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    ld a, [wBattleSetupD7]
    or a, a
    jr z, Jump_031_5067
    ld a, $07
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_Bank31

Jump_031_5067::
    xor a, a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    call CopyRectRecord73F7ToScreenBufferFar
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable6102
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster, wMenuSubState
; writes: wMenuSubState, wListLastPageSize
; points at: wBattleSetupD8, wBattleResolveStep
RunBattleSetup_Case01_Case01::
Jump_031_5087:: ; address name
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawWC278Rect12x11ToBGMapRow7
    ld hl, Data_031_63A7
    ld a, [wMenuSubState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSubState, wBattleSetupD7
; writes: wBattleResolveStep, wBattleArg1, wCommandMonster
; points at: wMenuSubState, wBattleSetupD8, wBattleActionChoice, wSideControl, wBattleResolveStep, wSlotMarks
RunBattleSetup_Case01_Case02::
Jump_031_50BF:: ; address name
    ld de, Data_031_63A7
    ld hl, wMenuSubState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_5118
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [wMenuSubState]
    and a, $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster
    cp a, $03
    jr nz, Jump_031_514E
    ld a, [wBattleSetupD7]
    or a, a
    jr z, Jump_031_5104
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld [hl], $00
    jr Jump_031_515E

Jump_031_5104::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wBattleArg1], a
    ret

Jump_031_5118::
    bit 1, a
    jr z, Jump_031_517C

Jump_031_511C::
    ld a, [wCommandMonster]
    and a, $03
    jr z, Jump_031_5147
    ld a, [wCommandMonster]
    dec a
    ld [wCommandMonster], a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_511C
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable6102
    ld hl, wBattleResolveStep
    dec [hl]
    jr Jump_031_517C

Jump_031_5147::
    ld a, $00
    ld [wBattleArg1], a
    jr Jump_031_5172

Jump_031_514E::
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_031_515E::
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    ld a, $20
    ld [wBattleResolveStep], a
    jr Jump_031_517C

Jump_031_5172::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_517C::
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_Case01_Case03::
Jump_031_517D:: ; address name
    call DrawWC278Rect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster
; writes: wBattleArg1, wStringCategory, wStringIndex, wMenuSelectedMember
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_Case01_Case04::
Jump_031_518A:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC278Rect12x11ToBGMapRow7
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecord755FToScreenBufferFar
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $141
    call WriteFiveTilesFromTable6102
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case05::
Jump_031_51CE:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld hl, Data_031_63AF
    ld a, [wMenuSelectedMember]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSelectedMember
; writes: wBattleArg1, wBattleResolveStep, wSubMenuCursor2
; points at: wMenuSelectedMember, wBattleResolveStep, wSideControl, wBattleActionChoice
RunBattleSetup_Case01_Case06::
Jump_031_51F0:: ; address name
    ld de, Data_031_63AF
    ld hl, wMenuSelectedMember
    call RunBattleSetup_Case01_Case06_Sub01
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5212
    ld a, $00
    ld [wBattleArg1], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_031_52B4

Jump_031_5212::
    bit 0, a
    jp z, Jump_031_52B4
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    or a, a
    jr z, Jump_031_5242
    cp a, $01
    jr z, Jump_031_526D
    jr Jump_031_5292

Jump_031_5242::
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_525C
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld [hl], e
    jr Jump_031_52A5

Jump_031_525C::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $0C
    ld [wBattleResolveStep], a
    xor a, a
    ld [wSubMenuCursor2], a
    jr Jump_031_52B4

Jump_031_526D::
    call RunBattleSetup_Case01_Case06_Sub02
    ld a, d
    or a, a
    jr nz, Jump_031_5281
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr Jump_031_52B4

Jump_031_5281::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    xor a, a
    ld [wBattleArg1], a
    ld a, $10
    ld [wBattleResolveStep], a
    jr Jump_031_52B4

Jump_031_5292::
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $AC
    ld [hl+], a
    ld a, [wCommandMonster]
    ld [hl], a

Jump_031_52A5::
    ld a, $01
    ld [wBattleArg1], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_52B4::
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case07::
Jump_031_52B5:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld a, [wBattleArg1]
    or a, a
    jr z, Jump_031_52C0
    ld a, $20

Jump_031_52C0::
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case08::
Jump_031_52C4:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case09::
Jump_031_52CF:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case0A::
Jump_031_52E7:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case0B::
Jump_031_52F7:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleArg1
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case0C::
Jump_031_5300:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call CopyRectRecord7750ToScreenBufferFar
    xor a, a
    ld [wBattleArg1], a
    farcall RunBattleSetup_Shared06
    xor a, a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case01_Case0D::
Jump_031_5319:: ; address name
    call DrawWC2F8RectToBGMapRow11
    xor a, a
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_Shared08
    ld hl, Data_031_63AF
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleActionChoice
RunBattleSetup_Case01_Case0E::
Jump_031_5350:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, Data_031_63AF
    call RunBattleSetup_Shared03
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_537B
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_53B9

Jump_031_537B::
    bit 0, a
    jr z, Jump_031_53B9
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_53B9::
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case0F::
Jump_031_53BA:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wBattleArg0]
    or a, a
    jr z, Jump_031_53C7
    ld a, $20
    jr Jump_031_53C9

Jump_031_53C7::
    ld a, $04

Jump_031_53C9::
    ld [wBattleResolveStep], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster, wBattleArg2, wBattleArg3, wCommandCursor, wMenuCursor
; writes: wBattleArg1, wMenuCursor, wCommandCursor, wStringCategory
; points at: wSideControl, wCommandCursor, wBattleResolveStep
RunBattleSetup_Case01_Case10::
Jump_031_53CD:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8LeftToBGMapRow9_74B4
    xor a, a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, Data_031_63A7
    call ShowSkillPageNames
    call RunBattleSetup_Shared01
    call CopyRectRecords7600And7734ToScreenBufferFar
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $03
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_Shared07
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuCursor
; writes: wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case11::
Jump_031_542A:: ; address name
    call DrawWC2A4AndWC2B8Rects
    ld hl, Data_031_63A7
    ld a, [wMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wRecordBufferData, wCommandMonster, wCommandCursor, wMenuCursor, wRecordBuffer
; writes: wBattleArg1, wStringIndex
; points at: wMenuCursor, wBattleMP, wSideControl, wBattleActionChoice, wBattleResolveStep
RunBattleSetup_Case01_Case12::
Jump_031_5454:: ; address name
    ld de, Data_031_63A7
    ld hl, wMenuCursor
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_031_557A
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_Bank31
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, Jump_031_5599
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp a, $FF
    jr nz, Jump_031_5499
    ld c, $01

Jump_031_5499::
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, Jump_031_55AD
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hl+], a
    cp a, $35
    jr z, Jump_031_5523
    ld a, [wRecordBufferData + $4]
    cp a, $FF
    jr z, Jump_031_54FF
    cp a, $14
    jr z, Jump_031_54FF
    cp a, $80
    jr z, Jump_031_5506
    cp a, $12
    jr z, Jump_031_5515
    cp a, $22
    jr z, Jump_031_5523
    cp a, $11
    jr z, Jump_031_552F
    cp a, $21
    jr z, Jump_031_5549
    cp a, $40
    jr z, Jump_031_5571
    jp Jump_031_5598

Jump_031_54FF::
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_031_5598

Jump_031_5506::
    ld a, [wCommandMonster]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_031_5598

Jump_031_5515::
    ld a, [wCommandMonster]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5523::
    ld a, [wCommandMonster]
    and a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_552F::
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_553E
    ld [hl], e
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_553E::
    ld a, $1C
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5549::
    call CountPresentSlotsOfLinkRoleSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_5566
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5566
    cp a, $1F
    jr z, Jump_031_5566
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5566::
    ld a, $18
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5571::
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_031_557A::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5592
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5592::
    call RunBattleSetup_Shared01
    call DrawInventoryPageIndicator

Jump_031_5598::
    ret

Jump_031_5599::
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_55AD::
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

; entry 19 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep, wBattleArg1
RunBattleSetup_Case01_Case13::
Jump_031_55C1:: ; address name
    call DrawWC2A4AndWC2B8Rects
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg1], a
    ret

; entry 20 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case14::
Jump_031_55CF:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case15::
Jump_031_55E0:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case16::
Jump_031_55F2:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case17::
Jump_031_5602:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $10
    ld [wBattleResolveStep], a
    ret

; entry 24 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wSubMenuCursor2
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case18::
Jump_031_560B:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_Case01_Case18_Sub01
    xor a, a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case01_Case19::
Jump_031_562A:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5639
    cp a, $1F
    jr z, Jump_031_5639
    xor a, a

Jump_031_5639::
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_Shared08
    ld hl, Data_031_63AF
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wRecordBuffer, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0, wStringIndex, wBattleResolveStep
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleTargetChoice
RunBattleSetup_Case01_Case1A::
Jump_031_566A:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, Data_031_63AF
    call RunBattleSetup_Shared03
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5693
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_56FD

Jump_031_5693::
    bit 0, a
    jr z, Jump_031_56FD
    ld a, $69
    call QueueSoundEffect
    ld a, [wRecordBuffer]
    cp a, $1B
    jr z, Jump_031_56AF
    cp a, $1C
    jr z, Jump_031_56AF
    cp a, $1D
    jr z, Jump_031_56AF
    cp a, $97
    jr nz, Jump_031_56D5

Jump_031_56AF::
    ld a, [wCommandMonster]
    and a, $03
    ld c, a
    ld a, [wSubMenuCursor2]
    and a, $03
    cp a, c
    jr nz, Jump_031_56D5
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects
    call ClearWindowAndCopyRect7345Far
    ld a, $65
    ld [wStringIndex], a
    ld a, $21
    ld [wBattleResolveStep], a
    jr Jump_031_56FD

Jump_031_56D5::
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wCommandMonster]
    and a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_56FD::
    ret

; entry 27 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case1B::
Jump_031_56FE:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; entry 28 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer
; writes: wBattleArg1, wSubMenuCursor2
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case1C::
Jump_031_5708:: ; address name
    call CopyRectRecord7750ToScreenBufferFar
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5717
    cp a, $1F
    jr z, Jump_031_5717
    xor a, a

Jump_031_5717::
    ld [wBattleArg1], a
    farcall RunBattleSetup_Shared06
    xor a, a
    ld [wBattleArg1], a
    xor a, a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case01_Case1D::
Jump_031_572D:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_573C
    cp a, $1F
    jr z, Jump_031_573C
    xor a, a

Jump_031_573C::
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_Shared08
    ld hl, Data_031_63AF
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wCommandMonster, wSubMenuCursor2
; writes: wBattleArg0
; points at: wSubMenuCursor2, wBattleResolveStep, wBattleTargetChoice
RunBattleSetup_Case01_Case1E::
Jump_031_576F:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, Data_031_63AF
    call RunBattleSetup_Shared03
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_579A
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_57D5

Jump_031_579A::
    bit 0, a
    jr z, Jump_031_57D5
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and a, $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_57D5::
    ret

; entry 31 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case1F::
Jump_031_57D6:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; entry 32 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster
; writes: wCommandMonster, wBattleResolveStep, wBattleSubPhase
; points at: wSlotMarks
RunBattleSetup_Case01_Case20::
Jump_031_57E0:: ; address name
    ld a, [wCommandMonster]
    and a, $04
    or a, $03
    ld b, a

Jump_031_57E8::
    ld a, [wCommandMonster]
    inc a
    ld [wCommandMonster], a
    cp a, b
    jr z, Jump_031_5804
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_57E8
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_580D

Jump_031_5804::
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a

Jump_031_580D::
    ret

; entry 33 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_Case01_Case21::
Jump_031_580E:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in RunBattleSetup_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_Case01_Case23::
Jump_031_5820:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $18
    ld [wBattleResolveStep], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_Case02::
Jump_031_5829:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_Case02_Case00
    dw RunBattleSetup_Case02_Case01
    dw RunBattleSetup_Case02_Case02
    dw RunBattleSetup_Case02_Case03
    dw RunBattleSetup_Case02_Case04
    dw RunBattleSetup_Case02_Case05
    dw RunBattleSetup_Case02_Case06
    dw RunBattleSetup_Case02_Case07
    dw RunBattleSetup_Case02_Case08
    dw RunBattleSetup_Case02_Case09
    dw RunBattleSetup_Case02_Case0A
    dw RunBattleSetup_Case02_Case0B
    dw RunBattleSetup_Case02_Case0C
    dw RunBattleSetup_Case02_Case0D
    dw RunBattleSetup_Case02_Case0E
    dw RunBattleSetup_Case02_Case0F
    dw RunBattleSetup_Case02_Case10
    dw RunBattleSetup_Case02_Case11
    dw RunBattleSetup_Case02_Case12
    dw RunBattleSetup_Case02_Case13

; entry 0 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandCursor, wMenuOption
; writes: wStringCategory, wStringIndex
; points at: wCommandCursor, wInventory, wBattleResolveStep
RunBattleSetup_Case02_Case00::
Jump_031_5855:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC278RowsToBGMapRow7
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, Data_031_63A7
    call ShowInventoryPageItemNames
    call RunBattleSetup_Shared02
    call CopyRectRecord7600ToScreenBufferFar
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuOption]
    and a, $03
    add a, c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wMenuOption
; writes: wBattleArg0, wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case01::
Jump_031_589C:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    ret z
    xor a, a
    ld [wBattleArg0], a
    ld hl, Data_031_63A7
    ld a, [wMenuOption]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wItemId, wItemRecord
; writes: wBattleArg1, wBattleFlag93, wBattleFlag92, wBattleSubPhase, wBattleResolveStep, wStringIndex
; points at: wMenuOption, wBattleResolveStep, wCommandCursor
RunBattleSetup_Case02_Case02::
Jump_031_58CF:: ; address name
    ld de, Data_031_63A7
    ld hl, wMenuOption
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_031_597D
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg1], a
    call LoadSelectedInventoryItemRecord
    ld a, [wItemId]
    ld [wBattleFlag93], a
    ld a, [wItemRecord + $4]
    bit 0, a
    jr nz, Jump_031_5921
    ld a, [wItemRecord + $6]
    or a, a
    jr z, Jump_031_5933
    cp a, $01
    jr z, Jump_031_5943
    cp a, $02
    jr z, Jump_031_5953
    cp a, $03
    jr z, Jump_031_595D
    cp a, $04
    jr z, Jump_031_596D
    cp a, $05
    jr z, Jump_031_596D
    cp a, $06
    jr z, Jump_031_5974
    jp Jump_031_595D

Jump_031_5921::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleResolveStep], a
    ld a, $1E
    ld [wStringIndex], a
    jr Jump_031_59AF

Jump_031_5933::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call DrawWC2B8RowsToBGMapRow9
    ld a, $08
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_5943::
    ld a, $10
    ld [wBattleFlag92], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_5953::
    call DrawWC2B8RowsToBGMapRow9
    ld a, $0C
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_595D::
    ld a, $20
    ld [wBattleFlag92], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_596D::
    ld a, $04
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_5974::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a

Jump_031_597D::
    bit 1, a
    jr z, Jump_031_5995
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_59AF

Jump_031_5995::
    bit 2, a
    jr z, Jump_031_59A7
    farcall SortInventory
    ld de, Data_031_63A7
    ld hl, wCommandCursor
    set 7, [hl]

Jump_031_59A7::
    call RunBattleSetup_Shared02
    call DrawInventoryPageIndicator
    jr Jump_031_59AF

Jump_031_59AF::
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_Case02_Case03::
Jump_031_59B0:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor, wBattleArg1
; writes: wSubMenuCursor, wBattleArg1, wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case04::
Jump_031_59BC:: ; address name
    ld a, [wSubMenuCursor]
    and a, $01
    ld [wSubMenuCursor], a
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call CopyRectRecord76F8ToScreenBufferFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case05::
Jump_031_59EA:: ; address name
    call DrawWC2F8Rect8x7ToBGMapRow11
    ld hl, Data_031_639F
    ld a, [wSubMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wItemRecord, wItemId, wSubMenuCursor, wBattleSlotOut
; writes: wBattleFlag92, wBattleSubPhase, wBattleResolveStep, wBattleArg0, wSubMenuCursor
; points at: wSubMenuCursor, wBattleResolveStep
RunBattleSetup_Case02_Case06::
Jump_031_5A0C:: ; address name
    ld de, Data_031_63B5
    ld hl, wSubMenuCursor
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_5A78
    ld a, $69
    call QueueSoundEffect
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    and a, $01
    jr nz, Jump_031_5A5B
    ld a, [wItemId]
    cp a, $19
    jr c, Jump_031_5A71
    cp a, $1F
    jr nc, Jump_031_5A71
    ld a, [wSubMenuCursor]
    and a, $01
    jr z, Jump_031_5A71
    ld b, $04
    ld a, [wBattleSlotOut + $4]
    or a, a
    jr z, Jump_031_5A55
    ld b, $05
    ld a, [wBattleSlotOut + $5]
    or a, a
    jr z, Jump_031_5A55
    ld b, $06
    ld a, [wBattleSlotOut + $6]
    or a, a
    jr nz, Jump_031_5A8F

Jump_031_5A55::
    ld a, b
    ld [wBattleFlag92], a
    jr Jump_031_5A66

Jump_031_5A5B::
    ld a, [wSubMenuCursor]
    and a, $01
    inc a
    swap a
    ld [wBattleFlag92], a

Jump_031_5A66::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5A8F

Jump_031_5A71::
    ld a, $01
    ld [wBattleArg0], a
    jr Jump_031_5A85

Jump_031_5A78::
    bit 1, a
    jr z, Jump_031_5A8F
    xor a, a
    ld [wSubMenuCursor], a
    ld a, $00
    ld [wBattleArg0], a

Jump_031_5A85::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_5A8F::
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wSubMenuCursor
; writes: wBattleResolveStep
RunBattleSetup_Case02_Case07::
Jump_031_5A90:: ; address name
    call DrawWC2F8Rect8x7ToBGMapRow11
    ld a, [wBattleArg0]
    or a, a
    jr z, Jump_031_5AA2
    ld a, [wSubMenuCursor]
    and a, $01
    add a, a
    add a, a
    add a, $08

Jump_031_5AA2::
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case08::
Jump_031_5AA6:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_Case02_Case08_Sub01
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_Case09::
Jump_031_5AC1:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5ACC
    xor a, a

Jump_031_5ACC::
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_Shared08
    ld hl, Data_031_63AF
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wSubMenuCursor2
; writes: wBattleArg0, wBattleFlag92
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_Case0A::
Jump_031_5AFD:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, Data_031_63AF
    call RunBattleSetup_Shared03
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5B26
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B26::
    bit 0, a
    jr z, Jump_031_5B48
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and a, $03
    ld [wBattleFlag92], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B48::
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wItemRecord
; writes: wBattleResolveStep, wBattleArg0, wBattleSubPhase
RunBattleSetup_Case02_Case0B::
Jump_031_5B49:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    jr nz, Jump_031_5B66
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp a, $04
    jr z, Jump_031_5B71
    cp a, $05
    jr z, Jump_031_5B71
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5B76

Jump_031_5B66::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5B76

Jump_031_5B71::
    ld a, $04
    ld [wBattleResolveStep], a

Jump_031_5B76::
    xor a, a
    ld [wBattleArg0], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wBattleArg1
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case0C::
Jump_031_5B7B:: ; address name
    call CopyRectRecord7750ToScreenBufferFar
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5B86
    xor a, a

Jump_031_5B86::
    ld [wBattleArg1], a
    farcall RunBattleSetup_Shared06
    xor a, a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wLinkRole
; writes: wNameSlot
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_Case0D::
Jump_031_5B98:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5BA3
    xor a, a

Jump_031_5BA3::
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call RunBattleSetup_Shared08
    ld hl, Data_031_63AF
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wJoypadPressed, wSubMenuCursor2
; writes: wBattleArg0, wBattleFlag92
; points at: wSubMenuCursor2, wBattleResolveStep
RunBattleSetup_Case02_Case0E::
Jump_031_5BD6:: ; address name
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, Data_031_63AF
    call RunBattleSetup_Shared03
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5C01
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C01::
    bit 0, a
    jr z, Jump_031_5C25
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and a, $03
    set 2, a
    ld [wBattleFlag92], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C25::
    ret

; entry 15 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0, wItemRecord
; writes: wBattleResolveStep, wBattleArg0, wBattleSubPhase
RunBattleSetup_Case02_Case0F::
Jump_031_5C26:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wBattleArg0]
    or a, a
    jr nz, Jump_031_5C43
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp a, $04
    jr z, Jump_031_5C4E
    cp a, $05
    jr z, Jump_031_5C4E
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5C53

Jump_031_5C43::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5C53

Jump_031_5C4E::
    ld a, $04
    ld [wBattleResolveStep], a

Jump_031_5C53::
    xor a, a
    ld [wBattleArg0], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case10::
Jump_031_5C58:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    call ClearWindowAndCopyRect7345Far
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case11::
Jump_031_5C63:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_Case02_Case12::
Jump_031_5C6B:: ; address name
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ret

; entry 19 of the `rst $00` table in RunBattleSetup_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_Case02_Case13::
Jump_031_5C80:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 3 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wLinkSendByte
; points at: wSlotMarks, wBattleSubPhase
RunBattleSetup_Case03::
Jump_031_5C8D:: ; address name
    ld b, $08
    ld hl, wSlotMarks

Jump_031_5C92::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_5C98
    ld [hl], $01

Jump_031_5C98::
    inc hl
    dec b
    jr nz, Jump_031_5C92
    xor a, a
    ld [wBattleActor], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call ClearWindowAndCopyRect7345Far
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wStringCategory, wStringIndex, wLinkSendByte
; points at: wBattleByte58, wTextBuf0, wBattleSubPhase
RunBattleSetup_Case04::
Jump_031_5CB5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_5CD8
    ld de, wBattleByte58
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move'
    farcall BeginStringDisplay_Bank2F
    xor a, a
    ld [wLinkSendByte], a

Jump_031_5CD8::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_Case05::
Jump_031_5CDD:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_5CE8
    ld a, $01
    ld [wLinkSendByte], a

Jump_031_5CE8::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wMenuState
; writes: wLinkSendByte, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi
; points at: wSlotTactic, wLinkRecvBuffer, wBattleActionChoice, wSlotMarks, wSideControl, wLinkPartnerName, wBattleSubPhase
RunBattleSetup_Case06::
Jump_031_5CED:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, Jump_031_5D8D
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld de, wSlotTactic
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5D0B
    ld de, wSlotTactic + $4

Jump_031_5D0B::
    ld hl, wLinkRecvBuffer
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wRandomLo]
    ld [hl+], a
    ld a, [wRandomHi]
    ld [hl+], a
    ld a, [wMenuState]
    ld [hl+], a
    ld a, [wMenuState]
    ld [hl+], a
    ld de, wBattleActionChoice
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5D33
    ld de, wBattleActionChoice + $8

Jump_031_5D33::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, wSlotMarks
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5D51
    ld de, wSlotMarks + $4

Jump_031_5D51::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, wSideControl
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5D66
    ld de, wSideControl + $4

Jump_031_5D66::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $13
    ld [wLinkBufferCountLo], a
    xor a, a
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

Jump_031_5D8D::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode
; writes: wLinkSendByte, wLinkReady
; points at: wBattleSubPhase
RunBattleSetup_Case07::
Jump_031_5D92:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_031_5DA6
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a

Jump_031_5DA6::
    ret

; entry 8 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wMenuState, wRandomSeed2Lo, wRandomSeed2Hi
; writes: wLinkSendByte, wLinkReady, wCommandBytesE9, wCommandByteEA, wRandomSeed2Lo, wRandomSeed2Hi, wBattleSetupByteBC, wRandomLo, ...
; points at: wSlotTactic, wLinkPartnerName, wBattleActionChoice, wSlotMarks, wSideControl, wBattleSubPhase, wSlotLastTactic
RunBattleSetup_Case08::
Jump_031_5DA7:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, Jump_031_5E78
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld de, wSlotTactic + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5DC9
    ld de, wSlotTactic

Jump_031_5DC9::
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl+]
    ld [wCommandByteEA], a
    ld de, wBattleActionChoice + $8
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5DEB
    ld de, wBattleActionChoice

Jump_031_5DEB::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, wSlotMarks + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5E09
    ld de, wSlotMarks

Jump_031_5E09::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, wSideControl + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_5E1E
    ld de, wSideControl

Jump_031_5E1E::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_031_5E4D
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    ld a, [wMenuState]
    ld [wBattleSetupByteBC], a
    ld a, [wMenuState]
    ld [wCommandBytesE9], a
    ld hl, wSlotTactic + $4
    ld de, wSlotLastTactic + $4
    jr Jump_031_5E6B

Jump_031_5E4D::
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a
    ld a, [wMenuState]
    ld [wBattleSetupByteBD], a
    ld a, [wMenuState]
    ld [wCommandByteEA], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

Jump_031_5E6B::
    ld b, $03

Jump_031_5E6D::
    ld a, [hl]
    cp a, $03
    jr z, Jump_031_5E73
    ld [de], a

Jump_031_5E73::
    inc hl
    inc de
    dec b
    jr nz, Jump_031_5E6D

Jump_031_5E78::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wRandomLo, wRandomSeed2Lo, wRandomHi, wRandomSeed2Hi
; writes: wLinkSendByte, wCounterPtr0Lo
; points at: wBattleSubPhase, wBattleSetupFlagsLo
RunBattleSetup_Case09::
Jump_031_5E7D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, Jump_031_5E85
    jr Jump_031_5EB2

Jump_031_5E85::
    ld hl, wBattleSetupFlagsLo
    ld a, [hl+]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    ld a, [wRandomSeed2Lo]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp a, b
    ld a, [wRandomSeed2Hi]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, $22
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a
    jr Jump_031_5EB2

Jump_031_5EAA::
    ld a, $33
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a

Jump_031_5EB2::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkMessage
; writes: wCounterPtr0Hi, wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_Case0A::
Jump_031_5EB7:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_031_5ED0
    ld a, [wLinkMessage]
    cp a, $22
    jr z, Jump_031_5EC9
    cp a, $33
    jr z, Jump_031_5EC9
    ret

Jump_031_5EC9::
    ld [wCounterPtr0Hi], a
    xor a, a
    ld [wLinkSendByte], a

Jump_031_5ED0::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wCounterPtr0Lo, wCounterPtr0Hi
; writes: wBattleSubPhase
; points at: wBattleSubPhase
RunBattleSetup_Case0B::
Jump_031_5ED5:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_031_5EF1
    ld a, [wCounterPtr0Lo]
    cp a, $22
    jr nz, Jump_031_5EEB
    ld a, [wCounterPtr0Hi]
    cp a, $22
    jr nz, Jump_031_5EEB
    jr Jump_031_5EF1

Jump_031_5EEB::
    ld a, $05
    ld [wBattleSubPhase], a
    ret

Jump_031_5EF1::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase
; points at: wBattleStep
RunBattleSetup_Case0C::
Jump_031_5EF6:: ; address name
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; up/down toggles bit 0 and left/right bit 1 of [HL] (sound $69); otherwise blinks the entry every 16 frames through bit 6 (E-0125)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case00_Case0D, RunBattleSetup_Case00_Case03, RunBattleSetup_Case02_Case06, RunBattleSubStep_6E67_Case05)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
ToggleEntryBitsByJoypadAndBlink::
Func_031_5F02:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_031_5F1A
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_5F45

Jump_031_5F1A::
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_031_5F32
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_5F45

Jump_031_5F32::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_031_5F4D
    bit 6, [hl]
    jr z, Jump_031_5F42
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_5F45

Jump_031_5F42::
    call SetBit6AndBlankEntryTile_Bank31

Jump_031_5F45::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_031_5F4D::
    ret

; only called from RunBattleSetup_Case01_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case06)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_Case01_Case06_Sub01::
Func_031_5F4E:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_031_5F64
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, Jump_031_5F77
    ld a, $02
    jr Jump_031_5F77

Jump_031_5F64::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_031_5F82
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, Jump_031_5F77
    xor a, a

Jump_031_5F77::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_5F95

Jump_031_5F82::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_031_5F9D
    bit 6, [hl]
    jr z, Jump_031_5F92
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_5F95

Jump_031_5F92::
    call SetBit6AndBlankEntryTile_Bank31

Jump_031_5F95::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_031_5F9D::
    ret

; up/down/left/right move the battle command cursor entry wCFD5 within wCFD3, wCFD6, wCFD7, blinking it, with sound $69 (E-0131)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case01_Case12, RunBattleSetup_Case01_Case02, RunBattleSetup_Case02_Case02, RunBattleSubStep_6E67_Case02)
; reads: wJoypadPressedRepeat, wCommandCursor, wCommandPageCount, wCommandCursorMax, wFrameCounterLo, wListLastPageSize
; writes: wFrameCounterLo, wCommandCursor
MoveBattleCommandCursor::
Func_031_5F9E:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_031_5FE2
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, Jump_031_5FC6
    ld a, [wCommandCursorMax]
    or a, a
    jp z, Jump_031_60A4
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [wCommandCursorMax]
    jr Jump_031_5FD4

Jump_031_5FC6::
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [wListLastPageSize]

Jump_031_5FD4::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jp Jump_031_60A4

Jump_031_5FE2::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_031_6027
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, Jump_031_600A
    ld a, [wCommandCursorMax]
    or a, a
    jp z, Jump_031_60A4
    ld b, a
    call SetBit6AndBlankEntryTile_Bank31
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_031_601A
    ld a, $00
    jr Jump_031_601A

Jump_031_600A::
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_031_601A
    xor a, a

Jump_031_601A::
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_60A4

Jump_031_6027::
    ld a, [wCommandPageCount]
    or a, a
    jr z, Jump_031_6068
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_031_604B
    ld a, [wCommandCursor]
    or a, a
    jr nz, Jump_031_603E
    ld a, b
    jr Jump_031_603F

Jump_031_603E::
    dec a

Jump_031_603F::
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_607D

Jump_031_604B::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_031_6068
    ld a, [wCommandCursor]
    cp a, b
    jr nz, Jump_031_605B
    xor a, a
    jr Jump_031_605C

Jump_031_605B::
    inc a

Jump_031_605C::
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_607D

Jump_031_6068::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_031_60AC
    bit 6, [hl]
    jr z, Jump_031_6078
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_60A4

Jump_031_6078::
    call SetBit6AndBlankEntryTile_Bank31
    jr Jump_031_60A4

Jump_031_607D::
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wCommandPageCount]
    ld b, a
    ld a, [wCommandCursor]
    res 7, a
    cp a, b
    jr nz, Jump_031_60A4
    ld a, [wCommandCursorMax]
    or a, a
    jr nz, Jump_031_6095
    xor a, a
    jr Jump_031_60A1

Jump_031_6095::
    ld b, a

Jump_031_6096::
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_031_60A1
    jr c, Jump_031_60A4
    dec [hl]
    jr Jump_031_6096

Jump_031_60A1::
    set 7, a
    ld [hl], a

Jump_031_60A4::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_031_60AC::
    ret

; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 15 call sites from 4 routines (e.g. ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_Shared03, MoveBattleCommandCursor, RunBattleSetup_Case01_Case06_Sub01)
SetBit6AndBlankEntryTile_Bank31::
Func_031_60AD:: ; address name
    set 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $C3
    call WriteVRAMByte
    pop hl
    ret

; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 13 call sites from 6 routines (e.g. ToggleEntryBitsByJoypadAndBlink, RunBattleSetup_Shared03, RunBattleSetup_Shared01, MoveBattleCommandCursor, ...)
ClearBit6AndCursorEntryTile_Bank31::
Func_031_60CC:: ; address name
    res 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $BB
    call WriteVRAMByte
    pop hl
    ret

; clears wC46C and writes five consecutive tile numbers starting at Data_031_6102[A] to HL (E-0122)
; 3 call sites from 3 routines (e.g. RunBattleSetup_Case01_Case04, RunBattleSetup_Case01_Case02, RunBattleSetup_Case01_Case00)
; writes: wMenuSubState
WriteFiveTilesFromTable6102::
Func_031_60EB:: ; address name
    push hl
    ld hl, Data_031_6102
    add_a_to_hl
    xor a, a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_031_60FC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_031_60FC
    ret

; address loaded by WriteFiveTilesFromTable6102
Data_031_6102:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; only called from RunBattleSetup_Case01_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case06)
; reads: wCommandMonster
; writes: wBattleArg2, wBattleArg3, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleSkills
RunBattleSetup_Case01_Case06_Sub02::
Func_031_6105:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

Jump_031_6121::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_6137
    or a, a
    jr z, Jump_031_6137
    cp a, $A2
    jr c, Jump_031_6131
    cp a, $AA
    jr c, Jump_031_6132

Jump_031_6131::
    inc d

Jump_031_6132::
    inc c
    inc hl
    dec b
    jr nz, Jump_031_6121

Jump_031_6137::
    ld a, c
    cp a, $05
    ld a, $00
    jr c, Jump_031_613F
    inc a

Jump_031_613F::
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, Jump_031_614B
    and a, $03
    dec a
    and a, $03

Jump_031_614B::
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; shows the four skill names (category 4) of page wCFD5 of monster wCFD4's skills (wD989 + 16 * wCFD4) in the four tile rows; $FF shows string 0 (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Shared01, RunBattleSetup_Case01_Case10)
; reads: wCommandMonster, wCommandCursor
; writes: wStringCategory, wBattleArg2, wBattleArg3
; points at: wBattleSkills
ShowSkillPageNames::
Func_031_6153:: ; address name
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles16D0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles1760
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_61A2
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110)
; 4 call sites from 1 routine (e.g. ShowSkillPageNames)
ReturnZero_61A2::
Func_031_61A2:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case01_Case12, RunBattleSetup_Case01_Case10)
; reads: wCommandCursor, wMenuCursor, wBattleArg2, wBattleArg3
; writes: wCommandCursor, wMenuCursor, wStringCategory
; points at: wMenuCursor
RunBattleSetup_Shared01::
Func_031_61A4:: ; address name
    ld a, [wCommandCursor]
    bit 7, a
    jr z, Jump_031_61BE
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuCursor
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowSkillPageNames
    ld hl, wMenuCursor
    set 7, [hl]

Jump_031_61BE::
    ld a, [wMenuCursor]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuCursor], a
    and a, $0F
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_Shared07
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1F0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; only called from RunBattleSetup_Case00_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case05)
; writes: wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wInventory
RunBattleSetup_Case00_Case05_Sub03::
Func_031_6200:: ; address name
    ld hl, wInventory
    ld bc, $1800
    ld e, $00

Jump_031_6208::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_6229
    or a, a
    jr z, Jump_031_6229
    inc c
    cp a, $0D
    jr c, Jump_031_6225
    cp a, $19
    jr c, Jump_031_6226
    cp a, $20
    jr c, Jump_031_6225
    cp a, $22
    jr c, Jump_031_6226
    cp a, $28
    jr nc, Jump_031_6226

Jump_031_6225::
    inc e

Jump_031_6226::
    dec b
    jr nz, Jump_031_6208

Jump_031_6229::
    ld a, c
    and a, $FC
    rrca
    rrca
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, Jump_031_623D
    and a, $03
    call z, RunBattleSetup_Case00_Case05_Sub03_Sub01
    dec a
    and a, $03

Jump_031_623D::
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; only called from RunBattleSetup_Case00_Case05_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case05_Sub03)
; reads: wCommandPageCount
; writes: wCommandPageCount
RunBattleSetup_Case00_Case05_Sub03_Sub01::
Func_031_6245:: ; address name
    push af
    ld a, [wCommandPageCount]
    dec a
    ld [wCommandPageCount], a
    pop af
    ret

; shows the four item names of inventory page wCFD5 (category 5) in the four tile rows of ShowStringAAtTiles16D0 ... 2080; an empty slot ($FF) shows string 0 (E-0120)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Shared02, RunBattleSetup_Case02_Case00)
; reads: wCommandCursor
; writes: wStringCategory
; points at: wInventory
ShowInventoryPageItemNames::
Func_031_624F:: ; address name
    ld a, $05
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles16D0
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles1760
    ld a, [hl+]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_6286
    call ShowStringAAtTiles2080
    ret

; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110)
; 4 call sites from 1 routine (e.g. ShowInventoryPageItemNames)
ReturnZero_6286::
Func_031_6286:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case02_Case02, RunBattleSetup_Case02_Case00)
; reads: wCommandCursor, wMenuOption
; writes: wCommandCursor, wMenuOption, wStringCategory, wStringIndex
; points at: wMenuOption, wInventory
RunBattleSetup_Shared02::
Func_031_6288:: ; address name
    ld a, [wCommandCursor]
    bit 7, a
    jr z, Jump_031_62A2
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuOption
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowInventoryPageItemNames
    ld hl, wMenuOption
    set 7, [hl]

Jump_031_62A2::
    ld a, [wMenuOption]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuOption], a
    and a, $0F
    push af
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ret

; wItemId = wInventory[(wCFD5 & $0F) * 4 + (wC471 & 3)], then far-calls LoadItemRecord (E-0118)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case02_Case0F, RunBattleSetup_Case02_Case0B, RunBattleSetup_Case02_Case06, RunBattleSetup_Case02_Case02)
; reads: wCommandCursor, wMenuOption
; writes: wItemId
; points at: wInventory
LoadSelectedInventoryItemRecord::
Func_031_62D3:: ; address name
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld hl, wInventory
    add_a_to_hl
    ld a, [wMenuOption]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    farcall LoadItemRecord
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $6D0 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles16D0::
Func_031_62F7:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $760 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles1760::
Func_031_6306:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $7F0 with size $0901; HL kept (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles17F0::
Func_031_6315:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles2 + $80 with size $0901 (E-0115)
; 2 call sites from 2 routines (e.g. ShowSkillPageNames, ShowInventoryPageItemNames)
; writes: wStringIndex
ShowStringAAtTiles2080::
Func_031_6324:: ; address name
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Shared01, RunBattleSetup_Case01_Case10)
; reads: wRecordBufferData, wCommandMonster
; writes: wStringIndex, wRecordBuffer
; points at: wBattleMP
RunBattleSetup_Shared07::
Func_031_6331:: ; address name
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_031_6364
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    jr Jump_031_6369

Jump_031_6364::
    ld l, a
    ld h, $00
    jr Jump_031_6369

Jump_031_6369::
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $88
    call WriteDecimalDigitTiles
    ret

; when wCFD7 is non-zero writes tiles $C5, $E0 + (wCFD5 & 7) + 1, $BE, $E0 + wCFD7 + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0120)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case01_Case12, RunBattleSetup_Case01_Case11, RunBattleSetup_Case02_Case02, RunBattleSetup_Case02_Case01)
; reads: wCommandPageCount, wCommandCursor
DrawInventoryPageIndicator::
Func_031_6373:: ; address name
    ld a, [wCommandPageCount]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

; address loaded by RunBattleSetup_Case00_Case02, RunBattleSetup_Case00_Case03, RunBattleSetup_Case02_Case05
Data_031_639F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C8, $01, $08, $02

; address loaded by RunBattleSetup_Case01_Case01, RunBattleSetup_Case01_Case02, RunBattleSetup_Case01_Case10, RunBattleSetup_Case01_Case11 and 4 more
Data_031_63A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $01, $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_Case01_Case05, RunBattleSetup_Case01_Case06, RunBattleSetup_Case01_Case0D, RunBattleSetup_Case01_Case0E and 8 more
Data_031_63AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_Case02_Case06
Data_031_63B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C1, $01, $01, $02

; address loaded by RunBattleSubStep_6E67_Case02, RunBattleSubStep_6E67_Case03
Data_031_63BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00

; address loaded by RunBattleSetup_Case00_Case0D, RunBattleSubStep_6E67_Case05
Data_031_63C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01, $2F, $01, $6F, $01

; A = value: stores A in wDA43[wCFD4], and also in wDA4B[wCFD4] unless A is 3 (E-0118)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case02)
; reads: wCommandMonster
; points at: wSlotTactic, wSlotLastTactic
SetSlotTacticAndSlotLastTacticForCommandMonster::
Func_031_63CD:: ; address name
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; wRecordBuffer = the skill at wD989 + 16 * wCFD4 + 2 * (4 * (wCFD5 & 1) + (wC46E & 3)), wCFED = 0, then far-calls LoadSkillRecord (E-0120) (the same 48 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case12)
; reads: wMenuCursor, wCommandCursor, wCommandMonster
; writes: wRecordBuffer
; points at: wBattleSkills
LoadSelectedSkillRecord_Bank31::
Func_031_63ED:: ; address name
    ld a, [wMenuCursor]
    and a, $03
    ld b, a
    ld a, [wCommandCursor]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; side base = ((wC57F << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A, BC (E-0067) (the same 28 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case01_Case12, RunBattleSetup_Case01_Case06)
; reads: wLinkRole
CountPresentFoesOfLinkRoleSide_Bank31::
Func_031_641D:: ; address name
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_031_642C::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_6434
    inc d
    ld e, c

Jump_031_6434::
    inc c
    dec b
    jr nz, Jump_031_642C
    ret

; side base = (wC57F << 1) & 4: D = how many of its three slots are present; clobbers A, BC (E-0067) (the same 24 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case12)
; reads: wLinkRole
CountPresentSlotsOfLinkRoleSide_Bank31::
Func_031_6439:: ; address name
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld c, a

Jump_031_6445::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_644C
    inc d

Jump_031_644C::
    inc c
    dec b
    jr nz, Jump_031_6445
    ret

; only called from RunBattleSetup_Case01_Case18 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case18)
; reads: wRecordBuffer, wLinkRole, wSlotChoices
; points at: wBattleSlotOut, wSlotChoices
RunBattleSetup_Case01_Case18_Sub01::
Func_031_6451:: ; address name
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_6465
    cp a, $1F
    jr z, Jump_031_6465
    jr Jump_031_6486

; only called from RunBattleSetup_Case02_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_Case08)
; reads: wItemId, wLinkRole, wSlotChoices
; points at: wBattleSlotOut, wSlotChoices
RunBattleSetup_Case02_Case08_Sub01::
Func_031_645E:: ; address name
    ld a, [wItemId]
    cp a, $0C
    jr nz, Jump_031_6486

Jump_031_6465::
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_031_6474
    inc d

Jump_031_6474::
    ld b, $03
    ld hl, wSlotChoices

Jump_031_6479::
    ld a, [de]
    cp a, $FF
    jr z, Jump_031_647F
    xor a, a

Jump_031_647F::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6479
    jr Jump_031_64A2

Jump_031_6486::
    ld a, [wLinkRole]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_031_6495
    inc d

Jump_031_6495::
    ld b, $03
    ld hl, wSlotChoices

Jump_031_649A::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_649A
    jr Jump_031_64A2

Jump_031_64A2::
    call CopyRectRecord76ACToScreenBufferFar
    ld hl, wWindowTileBuffer + $1A
    ld a, [wSlotChoices]
    or a, a
    call nz, FillFiveC3AtHL
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSlotChoices + $1]
    or a, a
    call nz, FillFiveC3AtHL
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSlotChoices + $2]
    or a, a
    call nz, FillFiveC3AtHL
    ret

; stores tile $C3 in the five bytes from HL; HL kept (E-0118)
; 3 call sites from 1 routine (e.g. RunBattleSetup_Case02_Case08_Sub01)
FillFiveC3AtHL::
Func_031_64CE:: ; address name
    push hl
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from routines of RunBattleSetup (E-0098)
; 7 call sites from 6 routines (e.g. RunBattleSetup_Shared03, RunBattleSetup_Case01_Case1D, RunBattleSetup_Case01_Case19, RunBattleSetup_Case01_Case0D, ...)
; reads: wNameSlot
RunBattleSetup_Shared08::
Func_031_64D8:: ; address name
    or a, a
    jr nz, Jump_031_64EB
    ld a, [wNameSlot]
    or a, a
    jr z, Jump_031_64E5
    ld c, $00
    jr Jump_031_6513

Jump_031_64E5::
    ld a, [hl]
    and a, $03
    dec a
    jr Jump_031_64EE

Jump_031_64EB::
    ld a, [hl]
    and a, $03

Jump_031_64EE::
    add a, e
    and a, $03
    or a, b
    ld c, a
    ld d, $04

Jump_031_64F5::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_031_650A
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_031_6513
    jr z, Jump_031_650A
    ld a, [wNameSlot]
    or a, a
    jr nz, Jump_031_6513

Jump_031_650A::
    ld a, c
    add a, e
    and a, $03
    or a, b
    ld c, a
    dec d
    jr nz, Jump_031_64F5

Jump_031_6513::
    ld a, c
    and a, $03
    ld [hl], a
    ret

; only called from routines of RunBattleSetup (E-0098)
; 5 call sites from 5 routines (e.g. RunBattleSetup_Case01_Case1E, RunBattleSetup_Case01_Case1A, RunBattleSetup_Case01_Case0E, RunBattleSetup_Case02_Case0E, ...)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_Shared03::
Func_031_6518:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_031_6530
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $FF
    ld a, $01
    call RunBattleSetup_Shared08
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_655B

Jump_031_6530::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_031_6548
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $01
    ld a, $01
    call RunBattleSetup_Shared08
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_655B

Jump_031_6548::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_031_6563
    bit 6, [hl]
    jr z, Jump_031_6558
    call ClearBit6AndCursorEntryTile_Bank31
    jr Jump_031_655B

Jump_031_6558::
    call SetBit6AndBlankEntryTile_Bank31

Jump_031_655B::
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

Jump_031_6563::
    ret

; far-calls Func_0E0_443B (E-0122)
; no direct call (reached through a table, a jump or a vector)
CallFunc443BInBankE0:: ; heuristic: follows a terminator; C0
Func_031_6564:: ; address name
    farcall RunDebugState_E0
    ret

; only called from BattleEnd_Step1 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1)
; reads: wDataBankSave, wBattleKind, wBattleScene, wLinkRole
; writes: wDataBank, wDataBankSave, wBattleScene
BattleEnd_Step1_Sub02::
Func_031_656B:: ; address name
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ld a, [wBattleKind]
    cp a, $08
    jr nc, Jump_031_65A0
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr c, Jump_031_659C
    ld bc, $0304
    ld de, $0000
    call BattleEnd_Step1_Sub02_Sub02
    jr nc, Jump_031_659C
    ld a, d
    or a, a
    jr z, Jump_031_6598
    xor a, a
    jr Jump_031_65FB

Jump_031_6598::
    ld a, $02
    jr Jump_031_65FB

Jump_031_659C::
    ld a, $01
    jr Jump_031_65FB

Jump_031_65A0::
    ld a, [wBattleScene]
    or a, a
    jr nz, Jump_031_65FB
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_031_65CF
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr nc, Jump_031_65C3
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr c, Jump_031_65F9
    jr Jump_031_65F5

Jump_031_65C3::
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr c, Jump_031_65F1
    jr Jump_031_65F9

Jump_031_65CF::
    ld bc, $0304
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr nc, Jump_031_65E5
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr c, Jump_031_65F9
    jr Jump_031_65F5

Jump_031_65E5::
    ld bc, $0300
    ld e, $00
    call BattleEnd_Step1_Sub02_Sub01
    jr c, Jump_031_65F1
    jr Jump_031_65F9

Jump_031_65F1::
    ld a, $04
    jr Jump_031_65FB

Jump_031_65F5::
    ld a, $05
    jr Jump_031_65FB

Jump_031_65F9::
    ld a, $80

Jump_031_65FB::
    ld [wBattleScene], a
    ret

; only called from BattleEnd_Step1_Sub02 (E-0047)
; 7 call sites from 1 routine (e.g. BattleEnd_Step1_Sub02)
; points at: wBattleSlotOut, wBattleStatus
BattleEnd_Step1_Sub02_Sub01::
Func_031_65FF:: ; address name
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_6618
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_031_6618
    inc e

Jump_031_6618::
    inc c
    dec b
    jr nz, BattleEnd_Step1_Sub02_Sub01
    ld a, e
    cp a, $01
    ret

; only called from BattleEnd_Step1_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1_Sub02)
; points at: wBattleSlotOut
BattleEnd_Step1_Sub02_Sub02::
Func_031_6620:: ; address name
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_031_6635
    or a, a
    jr nz, Jump_031_6634
    inc e
    jr Jump_031_6635

Jump_031_6634::
    inc d

Jump_031_6635::
    inc c
    dec b
    jr nz, BattleEnd_Step1_Sub02_Sub02
    ld a, e
    cp a, $01
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wLinkMode, wBattlePartyCount
; writes: rRAMG, rRAMB
BattleEnd_Step3_Sub07::
Func_031_663D:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_031_6677
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

Jump_031_6653::
    push bc
    call BattleEnd_Step3_Sub07_Sub01
    ld a, c
    push bc
    ld c, $55
    call SRAMRecordAddressMapped
    pop bc
    call BattleEnd_Step3_Sub07_Sub02
    call BattleEnd_Step3_Sub07_Sub03
    call BattleEnd_Step3_Sub07_Sub04
    call BattleEnd_Step3_Sub07_Sub05
    call BattleEnd_Step3_Sub07_Sub06
    pop bc
    inc c
    dec b
    jr nz, Jump_031_6653
    xor a, a
    ld [rRAMG], a

Jump_031_6677::
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; reads: wMenuState
; writes: wBattleResultByte
; points at: wSlotTactic, wSlotLastTactic
BattleEnd_Step3_Sub07_Sub01::
Func_031_6678:: ; address name
    push bc
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld b, a
    ld a, c
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    rlca
    rlca
    and a, $0C
    or a, b
    swap a
    push af
    ld a, c
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    ld a, [wMenuState]
    and a, $03
    ld [wBattleResultByte], a
    pop bc
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; reads: wBattleKind
; points at: wBattleSlotOut, wBattleStatus
BattleEnd_Step3_Sub07_Sub02::
Func_031_66AE:: ; address name
    ld [hl], $00
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_031_66B9
    inc d

Jump_031_66B9::
    ld a, [de]
    cp a, $01
    jr z, Jump_031_66D9
    ld a, [wBattleKind]
    cp a, $04
    ret z
    ld a, c
    push hl
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 5, a
    call nz, BattleEnd_Step3_Sub07_Sub02_Sub01
    and a, $03
    call nz, BattleEnd_Step3_Sub07_Sub02_Sub02
    ret

Jump_031_66D9::
    set 7, [hl]
    ret

; only called from BattleEnd_Step3_Sub07_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07_Sub02)
BattleEnd_Step3_Sub07_Sub02_Sub01::
Func_031_66DC:: ; address name
    set 0, [hl]
    ret

; only called from BattleEnd_Step3_Sub07_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07_Sub02)
BattleEnd_Step3_Sub07_Sub02_Sub02::
Func_031_66DF:: ; address name
    set 2, [hl]
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; writes: wBattleArg0
; points at: wBattleHP
BattleEnd_Step3_Sub07_Sub03::
Func_031_66E2:: ; address name
    ld a, [hl]
    ld [wBattleArg0], a
    bit 7, [hl]
    push af
    ld a, l
    add a, $06
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop af
    jr nz, Jump_031_6719
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_031_6716
    add hl, de
    ld d, h
    ld e, l

Jump_031_6716::
    pop hl
    jr Jump_031_671C

Jump_031_6719::
    ld de, $0000

Jump_031_671C::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc hl
    inc hl
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; points at: wBattleMP
BattleEnd_Step3_Sub07_Sub04::
Func_031_6723:: ; address name
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    bit 7, d
    jr nz, Jump_031_6747
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_031_6749
    add hl, de

Jump_031_6747::
    ld d, h
    ld e, l

Jump_031_6749::
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; reads: wBattleArg0
; points at: wBattleWordArray3F
BattleEnd_Step3_Sub07_Sub05::
Func_031_6757:: ; address name
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, Jump_031_676D
    ld a, c
    ld de, wBattleWordArray3F
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_031_6768
    inc d

Jump_031_6768::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl-], a

Jump_031_676D::
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; reads: wBattleArg0
; points at: wSlotPersonalityHi, wSlotPersonalityLo, wSlotTrait, wSlotPersonalityMid
BattleEnd_Step3_Sub07_Sub06::
Func_031_6776:: ; address name
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, Jump_031_67A9
    ld a, c
    ld de, wSlotPersonalityHi
    add a, e
    ld e, a
    jr nc, Jump_031_6786
    inc d

Jump_031_6786::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotPersonalityLo
    add a, e
    ld e, a
    jr nc, Jump_031_6791
    inc d

Jump_031_6791::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotTrait
    add a, e
    ld e, a
    jr nc, Jump_031_679C
    inc d

Jump_031_679C::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, wSlotPersonalityMid
    add a, e
    ld e, a
    jr nc, Jump_031_67A7
    inc d

Jump_031_67A7::
    ld a, [de]
    ld [hl], a

Jump_031_67A9::
    ret

; only called from BattleEnd_Step4 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step4)
; reads: wBattleSubPhase
BattleEnd_Step4_Sub02::
Func_031_67AA:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw BattleEnd_Step4_Sub02_Case00
    dw BattleEnd_Step4_Sub02_Case01
    dw BattleEnd_Step4_Sub02_Case02
    dw BattleEnd_Step4_Sub02_Case03
    dw BattleEnd_Step4_Sub02_Case04
    dw BattleEnd_Step4_Sub02_Case05
    dw BattleEnd_Step4_Sub02_Case06
    dw BattleEnd_Step4_Sub02_Case07
    dw BattleEnd_Step4_Sub02_Case08
    dw BattleEnd_Step4_Sub02_Case09

; entry 0 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKind, wLinkMode, wBattleExpAward
; writes: wBattleResolveStep, wBattleSubPhase, hTemp0, wBattleExpAward, hTemp1, hTemp2
; points at: wBattleSlotOut, wTextBuf0, wBattleSubPhase
BattleEnd_Step4_Sub02_Case00::
Jump_031_67C2:: ; address name
    ld a, [wBattleKind]
    cp a, $04
    jr c, Jump_031_67E4
    cp a, $06
    jr z, Jump_031_67E4
    cp a, $07
    jr z, Jump_031_67E4
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $09
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    ret z
    ld a, $08
    ld [wBattleSubPhase], a
    ret

Jump_031_67E4::
    ld bc, $0300
    ld d, $00

Jump_031_67E9::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_67F7
    inc d

Jump_031_67F7::
    inc c
    dec b
    jr nz, Jump_031_67E9
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, d
    push af
    call Divide24ByA
    pop af
    ld a, l
    ldh [hTemp0], a
    ld [wBattleExpAward], a
    ld a, h
    ldh [hTemp1], a
    ld [wBattleExpAward + $1], a
    ld a, e
    ldh [hTemp2], a
    ld [wBattleExpAward + $2], a
    ld hl, wTextBuf0
    call WriteNumber24AsDecimalString
    ld hl, $0500
    call ShowStringHL_Bank31
    ld hl, wBattleSubPhase
    inc [hl]
    ret
    db $FE, $02, $C8, $FE, $03, $28, $0D, $7D, $D6, $01, $6F, $7C, $DE, $00, $67, $7B
    db $DE, $00, $5F, $C9, $7D, $C6, $01, $6F, $7C, $CE, $00, $67, $7B, $CE, $00, $5F
    db $C9

; entry 1 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rRAMG, rRAMB, wBattleResolveStep, wBattleArg0
; points at: wBattleSlotOut, wBattleSubPhase
BattleEnd_Step4_Sub02_Case01::
Jump_031_6851:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld bc, $0300

Jump_031_6862::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    call z, AddExpToRecordCCapped
    inc c
    dec b
    jr nz, Jump_031_6862
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg0], a
    ret

; adds the 24-bit wDA6B-wDA6D to the 3-byte field $58 of record C, capped at 9,999,999 ($98967F) (E-0125)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case01)
; reads: wBattleExpAward
AddExpToRecordCCapped::
Func_031_6885:: ; address name
    push bc
    ld a, c
    ld c, $58
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add a, c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc a, b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, Jump_031_68B1
    ld c, $7F
    ld b, $96
    ld d, $98

Jump_031_68B1::
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop bc
    ret

; entry 2 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_Step4_Sub02_Case02::
Jump_031_68B8:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_Step4_Sub02_Case02_Case00
    dw BattleEnd_Step4_Sub02_Case02_Case01

; entry 0 of the `rst $00` table in Func_031_67AA_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0, wPartyCount
; writes: wBattleArg0, wBattleEndTimer
; points at: wBattleSlotOut, wPartyList, wBattleSubPhase, wBattleLevel, wBattleResolveStep
BattleEnd_Step4_Sub02_Case02_Case00::
Jump_031_68C0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleArg0]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_68E7
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    call RecordReachedNextLevelExp
    bit 0, c
    jr nz, Jump_031_6901

Jump_031_68E7::
    ld a, [wPartyCount]
    ld b, a
    ld a, [wBattleArg0]
    inc a
    ld [wBattleArg0], a
    cp a, b
    ret c
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_031_6901::
    ld a, $3C
    ld [wBattleEndTimer], a
    ld a, [wBattleArg0]
    ld hl, wBattleLevel
    add_a_to_hl
    inc [hl]
    ld a, [wBattleArg0]
    ld c, a
    call DrawSlotStatusMarks
    ld a, [wBattleArg0]
    ld c, a
    call CopySlotPanelRowToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_67AA_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg0
; writes: rRAMG, rRAMB, wBattleArg1, wBattleResolveStep
; points at: wPartyList, wBattleSubPhase
BattleEnd_Step4_Sub02_Case02_Case01::
Jump_031_6925:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, $01
    call SRAMRecordAddressMapped
    call CopyTenByteNameToTextBuf0
    push hl
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wBattleArg1], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    pop hl
    call WriteRecordField4BAndStatsDecimal
    ld hl, $0501
    call ShowStringHL_Bank31
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 3 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_Step4_Sub02_Case03::
Jump_031_6966:: ; address name
    call CountDownBattleEndTimerWhenSoundIdle
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_Step4_Sub02_Case03_Case00
    dw BattleEnd_Step4_Sub02_Case03_Case01
    dw BattleEnd_Step4_Sub02_Case03_Case02

; entry 0 of the `rst $00` table in Func_031_67AA_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0
; writes: rRAMG, rRAMB
; points at: wWorkBuf, wBattleResolveStep
BattleEnd_Step4_Sub02_Case03_Case00::
Jump_031_6973:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wWorkBuf
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, $34
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

Jump_031_6999::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6999
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_67AA_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, hTemp3, hTemp4, hTemp5
; writes: wBattleSubStep
; points at: wTextBuf2, wTextBuf3, wWorkBuf, wBattleResolveStep
BattleEnd_Step4_Sub02_Case03_Case01::
Jump_031_69A4:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall FindNewlyLearnableSkills
    ldh a, [hTemp3]
    cp a, $FF
    jr z, Jump_031_69FA
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld c, $FF
    ld hl, $0503
    ldh a, [hTemp4]
    or a, a
    jr z, Jump_031_69E2
    ld hl, $0505
    ldh a, [hTemp4]
    cp a, $02
    jr z, Jump_031_69E2
    ldh a, [hTemp5]
    ld l, a
    ld h, $04
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld hl, $0504
    ldh a, [hTemp5]
    ld c, a

Jump_031_69E2::
    push bc
    call ShowStringHL_Bank31
    pop bc
    ld hl, wWorkBuf
    ld b, $38

Jump_031_69EC::
    ld a, [hl]
    cp a, c
    jr nz, Jump_031_69F5
    ldh a, [hTemp3]
    ld [hl], a
    jr Jump_031_69F9

Jump_031_69F5::
    inc hl
    dec b
    jr nz, Jump_031_69EC

Jump_031_69F9::
    ret

Jump_031_69FA::
    call ForEachSRAMRecordRun6E18
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_031_67AA_Case03
; no direct call (reached through a table, a jump or a vector)
BattleEnd_Step4_Sub02_Case03_Case02::
Jump_031_6A06:: ; address name
    call RunBattleSubStep_6E67
    ret

; entry 4 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB, wBattleResolveStep
; points at: wBattleSubPhase
BattleEnd_Step4_Sub02_Case04::
Jump_031_6A0A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call StoreWorkBufToRecordSkills
    call ApplyLevelUpToRecordBattleArg0
    call ShowString0ACat5IfField56AtLeast57
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubPhase
    dec [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; record wD868: level (field $56) += 1 and the gains wD095-wD09A are added to its six stat words (E-0127)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case04)
; reads: wBattleArg0, wLevelUpGains
ApplyLevelUpToRecordBattleArg0::
Func_031_6A2D:: ; address name
    ld a, [wBattleArg0]
    ld c, $56
    call SRAMRecordAddressMapped
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31_6A8B
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. ApplyLevelUpToRecordBattleArg0)
AddAToWordAtHL_Bank31_6A8B::
Func_031_6A8B:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; for record wD868: if field $56 (level) >= field $57, begins showing string $0A of category 5 (BeginStringDisplay_Bank2F) (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case04)
; reads: wBattleArg0
; writes: wStringIndex, wStringCategory
ShowString0ACat5IfField56AtLeast57::
Func_031_6A92:: ; address name
    ld a, [wBattleArg0]
    ld c, $56
    call SRAMRecordAddressMapped
    ld a, [hl+]
    cp a, [hl]
    ret c
    ld a, $0A
    ld [wStringIndex], a ; 'It has reached the limit for'
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; copies the 8 bytes at wD09D to the skill list (field $34) of record wD868 (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case04)
; reads: wBattleArg0
; points at: wWorkBuf
StoreWorkBufToRecordSkills::
Func_031_6AAE:: ; address name
    ld a, [wBattleArg0]
    ld c, $34
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

Jump_031_6ABB::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6ABB
    ret

; entry 5 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB
; points at: sRecords, wBattleSubPhase
BattleEnd_Step4_Sub02_Case05::
Jump_031_6AC2:: ; address name
    call DivideBattleExpAwardByModeFactor
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $1E
    ld c, $00

Jump_031_6AD5::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_6AE9
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    and a, a
    pop hl
    call z, AddExpToRecordHLCapped

Jump_031_6AE9::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_031_6AD5
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; divides the 24-bit wDA6B-wDA6D by 20, 15 or 10 for wC7C7 = 0, 1 or other (E-0124)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case05)
; reads: wBattleExpAward, wFarmLevel
; writes: wBattleExpAward
DivideBattleExpAwardByModeFactor::
Func_031_6AFE:: ; address name
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, [wFarmLevel]
    or a, a
    jr z, Jump_031_6B18
    cp a, $01
    jr z, Jump_031_6B1C
    ld a, $0A
    jr Jump_031_6B1E

Jump_031_6B18::
    ld a, $14
    jr Jump_031_6B1E

Jump_031_6B1C::
    ld a, $0F

Jump_031_6B1E::
    call Divide24ByA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    ld a, e
    ld [wBattleExpAward + $2], a
    ret

; adds the 24-bit wDA6B-wDA6D to the 3-byte field $58 of the record at HL, capped at 9,999,999 ($98967F) (E-0125)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case05)
; reads: wBattleExpAward
AddExpToRecordHLCapped::
Func_031_6B2E:: ; address name
    push bc
    push hl
    ld a, l
    add a, $58
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add a, c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc a, b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, Jump_031_6B5D
    ld c, $7F
    ld b, $96
    ld d, $98

Jump_031_6B5D::
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop hl
    pop bc
    ret

; entry 6 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB, wBattleArg1
; points at: sRecords, wBattleSubPhase
BattleEnd_Step4_Sub02_Case06::
Jump_031_6B65:: ; address name
    ld hl, sRecords
    ld b, $1E
    ld c, $00

Jump_031_6B6C::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_6B86
    push hl
    push bc
    ld a, c
    call RecordReachedNextLevelExp
    bit 0, c
    pop bc
    pop hl
    jr nz, Jump_031_6B9F

Jump_031_6B86::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_031_6B6C
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_031_6B9F::
    xor a, a
    ld [rRAMG], a
    ld a, c
    ld [wBattleArg1], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB
; points at: wBattleSubPhase
BattleEnd_Step4_Sub02_Case07::
Jump_031_6BAC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    call ApplyLevelUpToRecordBattleArg1
    call CopyRecordFields5DTo5BAnd61To5F
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ret

; record wD869: level (field $56) += 1 and the gains wD095-wD09A are added to its six stat words (E-0127)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case07)
; reads: wBattleArg1, wLevelUpGains
ApplyLevelUpToRecordBattleArg1::
Func_031_6BCA:: ; address name
    ld a, [wBattleArg1]
    ld c, $56
    call SRAMRecordAddress
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. ApplyLevelUpToRecordBattleArg1)
AddAToWordAtHL_Bank31::
Func_031_6C28:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; for SRAM record wD869: field $5B = word field $5D, field $5F = word field $61, field $55 = 0 (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case07)
; reads: wBattleArg1
CopyRecordFields5DTo5BAnd61To5F::
Func_031_6C2F:: ; address name
    ld a, [wBattleArg1]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    ld a, l
    add a, $FC
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    pop hl
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld [hl], $00
    ret

; entry 8 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase
; points at: wBattleStep
BattleEnd_Step4_Sub02_Case08::
Jump_031_6C5E:: ; address name
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 9 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
BattleEnd_Step4_Sub02_Case09::
Jump_031_6C67:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw BattleEnd_Step4_Sub02_Case09_Case00
    dw BattleEnd_Step4_Sub02_Case09_Case01
    dw BattleEnd_Step4_Sub02_Case09_Case02

; entry 0 of the `rst $00` table in Func_031_67AA_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wBattlePartyCount, wBattleByte93
; writes: wBattleByte93, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep, wBattleStep
BattleEnd_Step4_Sub02_Case09_Case00::
Jump_031_6C71:: ; address name
    ld a, [wArenaRank]
    cp a, $05
    jr c, Jump_031_6C93
    ld a, [wBattlePartyCount]
    cp a, $01
    jr nz, Jump_031_6C93
    ld a, [wBattleByte93]
    or a, a
    jr z, Jump_031_6C93
    cp a, $AA
    jr nz, Jump_031_6C8E
    ld a, $8F
    ld [wBattleByte93], a

Jump_031_6C8E::
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_031_6C93::
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in Func_031_67AA_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleByte93, wPartyList, hTemp0
; writes: hTemp0, rRAMG, rRAMB, wBattleSubPhase, wBattleResolveStep, wStringCategory, wStringIndex
; points at: wWorkBuf, wBattleStep, wTextBuf1, wTextBuf0, wBattleResolveStep
BattleEnd_Step4_Sub02_Case09_Case01::
Jump_031_6CA0:: ; address name
    ld a, [wBattleByte93]
    ldh [hTemp0], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, $34
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

Jump_031_6CBB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6CBB
    farcall ClearTemp0AndA
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_031_6CD2
    xor a, a
    ld [rRAMG], a
    jr Jump_031_6C93

Jump_031_6CD2::
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, [wPartyList]
    ld c, $01
    call SRAMRecordAddress
    ld d, h
    ld e, l
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, [wPartyList]
    ld c, $34
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

Jump_031_6CF8::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6CF8
    xor a, a
    ld [rRAMG], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a ; '0 learned G!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_031_67AA_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleStep
BattleEnd_Step4_Sub02_Case09_Case02::
Jump_031_6D17:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    jp Jump_031_6C93

; HL += A * $4E (the battler-record size, Multiply8); clobbers BC (E-0115)
; no direct call (reached through a table, a jump or a vector)
AddAx4EToHL:: ; heuristic: follows a terminator; C0
Func_031_6D1F:: ; address name
    push hl
    ld c, $4E
    call Multiply8
    pop bc
    add hl, bc
    ret

; record A below its level cap: C = 1 when its EXP (field $58) has reached the next level's total from the species growth table, else 0 (E-0127)
; 2 call sites from 2 routines (e.g. BattleEnd_Step4_Sub02_Case06, BattleEnd_Step4_Sub02_Case02_Case00)
; reads: wSpeciesExpCurve, hTemp2, hTemp3, hTemp4
; writes: rRAMG, rRAMB, hTemp1, wSpeciesIdLo, wSpeciesIdHi, hTemp0
RecordReachedNextLevelExp::
Func_031_6D28:: ; address name
    push af
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    pop af
    ld c, $56
    call SRAMRecordAddress
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_031_6D80
    ldh [hTemp1], a
    ld a, l
    add a, $B4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl+]
    ld [wSpeciesIdHi], a
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    farcall LoadTable4E60EntryToTemp2
    pop hl
    ldh a, [hTemp2]
    sub a, [hl]
    ld e, a
    inc hl
    ldh a, [hTemp3]
    sbc a, [hl]
    ld d, a
    inc hl
    ldh a, [hTemp4]
    sbc a, [hl]
    jr c, Jump_031_6D7C
    or a, d
    or a, e
    jr nz, Jump_031_6D80

Jump_031_6D7C::
    ld c, $01
    jr Jump_031_6D82

Jump_031_6D80::
    ld c, $00

Jump_031_6D82::
    xor a, a
    ld [rRAMG], a
    ret

; copies 10 bytes from HL to wC130 and appends a $F0 terminator (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case02_Case01)
; points at: wTextBuf0
CopyTenByteNameToTextBuf0::
Func_031_6D87:: ; address name
    ld de, wTextBuf0
    ld b, $0A

Jump_031_6D8C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6D8C
    ld a, $F0
    ld [de], a
    ret

; writes [HL + $4B] + 1 to wC140 and wD095-wD09A to wC150-wC164 as decimal strings (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case02_Case01)
; reads: wLevelUpGains
; points at: wTextBuf1, wTextBuf2, wTextBuf3
WriteRecordField4BAndStatsDecimal::
Func_031_6D96:: ; address name
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    inc a
    ld hl, wTextBuf1
    call WriteDecimalByteString
    ld a, [wLevelUpGains]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $1]
    ld hl, wTextBuf2 + $4
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $2]
    ld hl, wTextBuf2 + $8
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $3]
    ld hl, wTextBuf2 + $C
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $4]
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $5]
    ld hl, wTextBuf3 + $4
    call WriteDecimalByteString
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank2F (E-0110)
; 6 call sites from 6 routines (e.g. BattleEnd_Step4_Sub02_Case00, BattleEnd_Step4_Sub02_Case02_Case01, BattleEnd_Step4_Sub02_Case03_Case01, RunBattleSubStep_6E67_Case05, ...)
; writes: wStringCategory, wStringIndex
ShowStringHL_Bank31::
Func_031_6DDD:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ret

; with SRAM enabled runs Func_031_6E18 for each of the 30 records ($A5 bytes from sA000) whose first byte is non-zero (E-0124)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case03_Case01)
; writes: rRAMG, rRAMB
; points at: sRecords
ForEachSRAMRecordRun6E18::
Func_031_6DEC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $00

Jump_031_6DFA::
    ld a, [hl]
    or a, a
    jr z, Jump_031_6E05
    push hl
    push bc
    call ForEachSkillOfRecordBRun6E30
    pop bc
    pop hl

Jump_031_6E05::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $1E
    jr nz, Jump_031_6DFA
    xor a, a
    ld [rRAMG], a
    ret

; runs Func_031_6E30 for each of the eight skills (field $34) of record B that is not $FF (E-0124)
; 1 call site from 1 routine (e.g. ForEachSRAMRecordRun6E18)
ForEachSkillOfRecordBRun6E30::
Func_031_6E18:: ; address name
    push bc
    ld a, b
    ld c, $34
    call SRAMRecordAddress
    pop bc
    ld c, $08

Jump_031_6E22::
    ld a, [hl+]
    cp a, $FF
    push hl
    push bc
    call nz, ForEachSkillOfRecordBRun6E30_Sub01
    pop bc
    pop hl
    dec c
    jr nz, Jump_031_6E22
    ret

; only called from ForEachSkillOfRecordBRun6E30 (E-0047)
; 1 call site from 1 routine (e.g. ForEachSkillOfRecordBRun6E30)
ForEachSkillOfRecordBRun6E30_Sub01::
Func_031_6E30:: ; address name
    ld d, a
    push de
    ld a, b
    ld c, $3C
    call SRAMRecordAddress
    pop de
    push hl
    ld c, $19

Jump_031_6E3C::
    ld a, [hl]
    cp a, d
    jr nz, Jump_031_6E42
    ld [hl], $FF

Jump_031_6E42::
    inc hl
    dec c
    jr nz, Jump_031_6E3C
    pop hl
    push hl
    ld de, wBattlerRecords + $4
    ld b, $19

Jump_031_6E4D::
    ld a, [hl]
    ld [de], a
    ld a, $FF
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6E4D
    pop hl
    ld de, wBattlerRecords + $4
    ld b, $19

Jump_031_6E5C::
    ld a, [de]
    cp a, $FF
    jr z, Jump_031_6E62
    ld [hl+], a

Jump_031_6E62::
    inc de
    dec b
    jr nz, Jump_031_6E5C
    ret

; runs the routine for wBattleSubStep (jump table of seven) (E-0122)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case03_Case02)
; reads: wBattleSubStep
RunBattleSubStep_6E67::
Func_031_6E67:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleSubStep_6E67_Case00
    dw RunBattleSubStep_6E67_Case01
    dw RunBattleSubStep_6E67_Case02
    dw RunBattleSubStep_6E67_Case03
    dw RunBattleSubStep_6E67_Case04
    dw RunBattleSubStep_6E67_Case05
    dw RunBattleSubStep_6E67_Case06

; entry 0 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wCommandCursorMax, wCommandPageCount, wCommandCursor, wListLastPageSize, wMenuState
; points at: wBattleSubPhase, wScreenTileBuffer, wBattleSubStep
RunBattleSubStep_6E67_Case00::
Jump_031_6E79:: ; address name
    call RunBattleSubStep_6E67_Case00_Sub01
    cp a, $09
    jr nc, Jump_031_6ECA
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer

Jump_031_6EAC::
    push bc

Jump_031_6EAD::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_031_6EAD
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $0C
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Jump_031_6EAC
    ret

Jump_031_6ECA::
    ld b, a
    dec a
    and a, $03
    ld [wCommandCursorMax], a
    ld a, $04
    call DivideBByA
    cp a, $00
    jr nz, Jump_031_6EDB
    dec b

Jump_031_6EDB::
    ld a, b
    ld [wCommandPageCount], a
    xor a, a
    ld [wCommandCursor], a
    ld a, $03
    ld [wListLastPageSize], a
    ld hl, $0506
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wMenuState], a
    ret

; entry 1 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleArg0, wCommandPageCount
; writes: rRAMG, rRAMB, wScreenTileBuffer
; points at: wBattleSubStep
RunBattleSubStep_6E67_Case01::
Jump_031_6EF7:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call DrawWC278RowsToBGMapRow7
    call RunBattleSubStep_6E67_Shared01
    farcall CopyRectRecords77B6And79CBAndPlaySound6C
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A2
    call WriteDecimalDigitTiles
    xor a, a
    ld [rRAMG], a
    ld a, [wCommandPageCount]
    add a, $E1
    ld [wScreenTileBuffer + $111], a
    call ShowSelectedSkillNameAndCost
    ld de, wScreenTileBuffer + $8
    ld hl, vBGMap0 + $8
    ld bc, $0C09
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    call DrawCommandCursorPageNumber
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandCursor, wMenuState, wJoypadPressedRepeat
; points at: wMenuState, wWorkBuf, wTextBuf2, wBattleSubStep, wCommandCursor
RunBattleSubStep_6E67_Case02::
Jump_031_6F57:: ; address name
    ld de, Data_031_63BD
    ld hl, wMenuState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_031_6F91
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_031_6F91::
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_031_6F9C
    call DrawWC39EThreeTilesAtBGMap206
    ret

Jump_031_6F9C::
    ld a, [wJoypadPressedRepeat]
    and a, $30
    ret z
    ld hl, wCommandCursor
    res 7, [hl]
    call RunBattleSubStep_6E67_Shared01
    call DrawWC39EThreeTilesAtBGMap206
    call DrawCommandCursorPageNumber
    ret

; entry 3 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleSubStep
RunBattleSubStep_6E67_Case03::
Jump_031_6FB1:: ; address name
    ld a, [wMenuState]
    and a, $0F
    ld hl, Data_031_63BD
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld [hl], $BC
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ld hl, $0508
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wWindowTileBuffer, wMenuSubState
; points at: wBattleSubStep
RunBattleSubStep_6E67_Case04::
Jump_031_6FE9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall LoadCursorTileAndRect7826
    ld a, $BB
    ld [wWindowTileBuffer + $7], a
    ld hl, vBGMap0 + $10E
    ld de, wScreenTileBuffer + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wMenuSubState], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState, wCommandCursor, wMenuState
; writes: wBattleSubStep
; points at: wMenuSubState, wWorkBuf, wBattleSubStep
RunBattleSubStep_6E67_Case05::
Jump_031_700F:: ; address name
    ld de, Data_031_63C5
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_031_704E
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    bit 0, a
    jr nz, Jump_031_7054
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
    ld hl, wWorkBuf
    add_a_to_hl
    ld [hl], $FF
    ld hl, $0509
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_031_704E::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_031_7054::
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 6 of the `rst $00` table in RunBattleSubStep_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleSubStep
RunBattleSubStep_6E67_Case06::
Jump_031_705A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wBattleSubStep], a
    ret

; only called from RunBattleSubStep_6E67_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSubStep_6E67_Case00)
; points at: wWorkBuf
RunBattleSubStep_6E67_Case00_Sub01::
Func_031_7064:: ; address name
    ld hl, wBattlerRecords + $4
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38
    ld c, $00

Jump_031_7079::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_7081
    ld [de], a
    inc de
    inc c

Jump_031_7081::
    dec b
    jr nz, Jump_031_7079
    ld a, c
    push af
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38

Jump_031_708E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_708E
    pop af
    ret

; only called from routines of RunBattleSubStep_6E67 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSubStep_6E67_Case02, RunBattleSubStep_6E67_Case01)
; reads: wCommandCursor
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi, wStringIndex, wStringCategory
; points at: wWorkBuf
RunBattleSubStep_6E67_Shared01::
Func_031_7096:: ; address name
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld hl, wWorkBuf
    add_a_to_hl
    ld bc, $0400

Jump_031_70B3::
    push bc
    push hl
    ld a, c
    ld hl, Data_031_70FD
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    pop hl
    ld a, [hl+]
    push hl
    cp a, $FF
    jr nz, Jump_031_70D2
    xor a, a

Jump_031_70D2::
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop hl
    pop bc
    inc c
    dec b
    jr nz, Jump_031_70B3
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; address loaded by RunBattleSubStep_6E67_Shared01
Data_031_70FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $95, $50, $96, $E0, $96, $70, $97

; shows the name (category 9) of skill wD09D[4 * page + row] at vTiles2 + $260, loads its record and writes its MP cost (or the record's MP for skills $3D, $20, $7B) as digits at wC39E (E-0128)
; 2 call sites from 2 routines (e.g. DrawWC39EThreeTilesAtBGMap206, RunBattleSubStep_6E67_Case01)
; reads: wCommandCursor, wMenuState, wRecordBuffer, wBattleArg0, wRecordBufferData
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wRecordBuffer, rRAMG, ...
; points at: wWorkBuf
ShowSelectedSkillNameAndCost::
Func_031_7105:: ; address name
    ld hl, vTiles2 + $260
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1203
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuState]
    and a, $0F
    add a, b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    push af
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBuffer]
    cp a, $3D
    jr z, Jump_031_715E
    cp a, $20
    jr z, Jump_031_715E
    cp a, $7B
    jr nz, Jump_031_7178

Jump_031_715E::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    xor a, a
    ld [rRAMG], a
    jr Jump_031_717E

Jump_031_7178::
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00

Jump_031_717E::
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9E
    call WriteDecimalDigitTiles
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; runs Func_031_7105, then writes the three bytes at wC39E to vBGMap0 + $206 (E-0122)
; 2 call sites from 1 routine (e.g. RunBattleSubStep_6E67_Case02)
DrawWC39EThreeTilesAtBGMap206::
Func_031_719E:: ; address name
    call ShowSelectedSkillNameAndCost
    ld hl, vBGMap0 + $206
    ld de, wWindowTileBuffer + $9E
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; writes tile $E1 + (wCFD5 & $0F) at vBGMap0 + $10F (E-0115)
; 2 call sites from 2 routines (e.g. RunBattleSubStep_6E67_Case02, RunBattleSubStep_6E67_Case01)
; reads: wCommandCursor
DrawCommandCursorPageNumber::
Func_031_71B6:: ; address name
    ld a, [wCommandCursor]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte
    ret

; when every sound channel slot flag is $FF (all idle), decrements wD2CE (E-0121)
; 1 call site from 1 routine (e.g. BattleEnd_Step4_Sub02_Case03)
; reads: wSoundChannelSlots, wBattleEndTimer
; writes: wBattleEndTimer
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
CountDownBattleEndTimerWhenSoundIdle::
Func_031_71C4:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and a, [hl]
    ld hl, wSoundChannel1
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel2
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel3
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; on CGB writes 0 to the 20 x 18 visible attributes of vBGMap0 in VRAM bank 1 (rows 32 apart, WriteVRAMByteInc); then fills the $240 bytes of wScreenTileBuffer with $C3; what follows is not read (E-0110)
; 6 call sites from 6 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_Case00, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wIsCGB
; writes: rVBK
; points at: wScreenTileBuffer
ClearAttributesAndScreenBuffer_Bank31::
Func_031_71F5:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_031_721B
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

Jump_031_7205::
    push bc
    push hl

Jump_031_7207::
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_031_7207
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_031_7205
    ld a, $00
    ldh [rVBK], a

Jump_031_721B::
    ld hl, wScreenTileBuffer
    ld bc, $0240

Jump_031_7221::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_031_7221
    ret

; Fills the $160 bytes at wC278 with $C3; clobbers A, BC, HL (the same 15 bytes appear in 2 banks)
; 39 call sites from 22 routines (e.g. RunBattleSetup_Case03, RunBattleSetup_Case00_Case0D, RunBattleSetup_Case00_Case07, RunBattleSetup_Case00_Case03, ...)
FillWC278WithC3_Bank31::
Func_031_722A:: ; address name
    ld hl, wScreenTileBuffer + $E0
    ld bc, $0160

Jump_031_7230::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_031_7230
    ret

; only called from GameMode4_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub02)
; reads: wBattlePartyCount, wLinkRole
; writes: wNameGlyphBuf
; points at: wNameGlyphBuf
GameMode4_Init_Sub01_Sub02_Sub01::
Func_031_7239:: ; address name
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $F0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7270
    ld c, $03

Jump_031_7270::
    push bc
    ld a, c
    ld bc, $004E
    call Multiply8By16
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, wNameGlyphBuf
    ld b, $0A

Jump_031_7285::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_7285
    pop bc
    push bc
    ld b, $00
    ld hl, $72A0
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    dec b
    jr nz, Jump_031_7270
    ret
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8D, $50, $8D, $A0, $8D

; picks record wD88F - 1 from Data_031_72C3 and copies it into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31) (E-0078)
; 5 call sites from 5 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_Case00, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wBattlePartyCount
CopyRectRecordForBattlePartyCount_Bank31::
Func_031_72AC:: ; address name
    ld a, [wBattlePartyCount]
    dec a
    ld hl, PartyCountRects
    add a, a
    add_a_to_hl
    deref_hl
    call ReadScreenBufferRectHeader_Bank31
    call CopyRectToStride32_Bank31
    ret

; E-0221 (C1: CopyRectRecordForBattlePartyCount_Bank31 reads word wD88F - 1 of $72C3 and copies that record into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31); three records, for 1-3 party monsters).
; record: rectangle record for this party count
PartyCountRects::
Data_031_72C3:: ; address name
    dw TileRect_31_757C ; id 1
    dw TileRect_31_75B8 ; id 2
    dw TileRect_31_761E ; id 3

; FillWC278WithC3_Bank31, then falls into LayoutTileBlocksForBattleFoeCount (E-0071)
; 16 call sites from 10 routines (e.g. RunBattleSetup_BankA0_Case00_Case00, RunBattleSetup_BankA0_Case00_Case02, RunBattleSetup_BankA0_Case00_Case07, RunBattleSetup_BankA0_Case01_Case02, ...)
; reads: wBattleFoeCount
ClearAndLayoutTileBlocksForBattleFoeCount::
Func_031_72C9:: ; address name
    call FillWC278WithC3_Bank31

; wD890 = count 1-3: writes that many 6 x 6 blocks of consecutive tile numbers, starting at $14 ($24 per block), into the 32-byte-wide buffer at wC278 (row 0); left columns are 7 for one block, 4 and 10 for two, 1, 7 and 13 for three (centred in a 20-column view). Clobbers A, BC, D, HL (E-0060)
; 41 call sites from 24 routines (e.g. BuildBattleScreenBuffer, RunBattleSetup_Case03, RunBattleSetup_Case00_Case0D, RunBattleSetup_Case00_Case07, ...)
; reads: wBattleFoeCount
LayoutTileBlocksForBattleFoeCount::
Func_031_72CC:: ; address name
    ld d, $14
    ld a, [wBattleFoeCount]
    dec a
    ld hl, Data_031_7317
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_Sub01
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, Jump_031_7316
    dec a
    dec a
    ld hl, Data_031_731D
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_Sub01
    ld a, [wBattleFoeCount]
    cp a, $03
    jr nz, Jump_031_7316
    ld hl, wScreenTileBuffer + $ED
    jr Jump_031_7302

; only called from LayoutTileBlocksForBattleFoeCount (E-0047)
; 2 call sites from 1 routine (e.g. LayoutTileBlocksForBattleFoeCount)
LayoutTileBlocksForBattleFoeCount_Sub01::
Func_031_72FF:: ; address name
    deref_hl

Jump_031_7302::
    ld bc, $0606

Jump_031_7305::
    push bc
    push hl

Jump_031_7307::
    ld a, d
    inc d
    ld [hl+], a
    dec b
    jr nz, Jump_031_7307
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_031_7305

Jump_031_7316::
    ret

; address loaded by LayoutTileBlocksForBattleFoeCount
Data_031_7317:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $C2, $7C, $C2, $79, $C2

; address loaded by LayoutTileBlocksForBattleFoeCount
Data_031_731D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $C2, $7F, $C2

; on CGB loads the picture attribute blocks for one, two or three battle monsters (wD960, or wBattleMonsterId when bit 1 of wC57F is set) at vBGMap0 + $E1-$ED (E-0125)
; 4 call sites from 4 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_Case01_Case00, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_Sub02)
; reads: wIsCGB, wLinkRole, wBattleFoeCount
; points at: wBattlePictureIds, wBattleMonsterId
LoadBattleMonsterPictureAttributes::
Func_031_7321:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [wLinkRole]
    bit 1, a
    ld de, wBattlePictureIds
    jr z, Jump_031_7333
    ld de, wBattleMonsterId

Jump_031_7333::
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, Jump_031_7340
    cp a, $02
    jr z, Jump_031_7349
    jr Jump_031_735C

Jump_031_7340::
    ld c, $01
    ld hl, vBGMap0 + $E7
    call LoadMonsterPictureAttributesFromDE
    ret

Jump_031_7349::
    ld c, $01
    ld hl, vBGMap0 + $E4
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $EA
    call LoadMonsterPictureAttributesFromDE
    ret

Jump_031_735C::
    ld c, $01
    ld hl, vBGMap0 + $E1
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $E7
    call LoadMonsterPictureAttributesFromDE
    ld c, $05
    inc de
    inc de
    ld hl, vBGMap0 + $ED
    call LoadMonsterPictureAttributesFromDE
    ret

; hFFC6 = C (palette number), DE = the monster id word stored at [DE], then LoadMonsterPictureAttributes (HL = BG map address from the caller); DE kept (E-0110)
; 6 call sites from 1 routine (e.g. LoadBattleMonsterPictureAttributes)
; writes: hTemp0
LoadMonsterPictureAttributesFromDE::
Func_031_7379:: ; address name
    push de
    ld a, c
    ldh [hTemp0], a
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPictureAttributes
    pop de
    ret

; draws the HP, MP and status of the first one, two or three slots (by wD88F) (E-0122)
; 5 call sites from 5 routines (e.g. BuildBattleScreenBuffer, BattleEnd_Step5_Case00, BuildBattleMenuScreen_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wBattlePartyCount
DrawPartySlotStatusPanels::
Func_031_7389:: ; address name
    call DrawSlotPanelStats0
    ld a, [wBattlePartyCount]
    cp a, $01
    ret z
    call DrawSlotPanelStats1
    ld a, [wBattlePartyCount]
    cp a, $02
    ret z
    call DrawSlotPanelStats2
    ret

; draws HP, MP and status marks of slot 0 (slot 4 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats0::
Func_031_739F:: ; address name
    ld c, $00
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_73B4
    cp a, $02
    jr z, Jump_031_73B4
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_73B4
    ld c, $04

Jump_031_73B4::
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; draws HP, MP and status marks of slot 1 (slot 5 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats1::
Func_031_73BE:: ; address name
    ld c, $01
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_73D3
    cp a, $02
    jr z, Jump_031_73D3
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_73D3
    ld c, $05

Jump_031_73D3::
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; draws HP, MP and status marks of slot 2 (slot 6 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. DrawPartySlotStatusPanels)
; reads: wLinkMode, wLinkRole
DrawSlotPanelStats2::
Func_031_73DD:: ; address name
    ld c, $02
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_73F2
    cp a, $02
    jr z, Jump_031_73F2
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_73F2
    ld c, $06

Jump_031_73F2::
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; copies the panels of the first one, two or three slots (by wD88F) to VRAM (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePartyCount
CopyPartySlotPanelsToVRAM:: ; heuristic: follows a terminator; C0
Func_031_73FC:: ; address name
    call CopySlotPanel0ToVRAM
    ld a, [wBattlePartyCount]
    cp a, $01
    ret z
    call CopySlotPanel1ToVRAM
    ld a, [wBattlePartyCount]
    cp a, $02
    ret z
    call CopySlotPanel2ToVRAM
    ret

; builds and copies the panel row of slot 0 (slot 4 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel0ToVRAM::
Func_031_7412:: ; address name
    ld c, $00
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_7427
    cp a, $02
    jr z, Jump_031_7427
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7427
    ld c, $04

Jump_031_7427::
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 1 (slot 5 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel1ToVRAM::
Func_031_7431:: ; address name
    ld c, $01
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_7446
    cp a, $02
    jr z, Jump_031_7446
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7446
    ld c, $05

Jump_031_7446::
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; builds and copies the panel row of slot 2 (slot 6 when wC58A is 1 and bit 1 of wC57F is set) (E-0122)
; 1 call site from 1 routine (e.g. CopyPartySlotPanelsToVRAM)
; reads: wLinkMode, wLinkRole
CopySlotPanel2ToVRAM::
Func_031_7450:: ; address name
    ld c, $02
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_7465
    cp a, $02
    jr z, Jump_031_7465
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7465
    ld c, $06

Jump_031_7465::
    call CopySlotPanelPart7AC8ToVRAM
    call CopySlotPanelPart7ACEToVRAM
    call CopySlotPanelRowToVRAM
    ret

; FillTilesFromRequest, then far-calls CopyRectRecord7345ToScreenBuffer (E-0119)
; 13 call sites from 13 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, BuildBattleScreenBuffer, BattleEnd_Step5_Case00, ...)
ClearWindowAndCopyRect7345Far::
Func_031_746F:: ; address name
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ret

; copies a 20 x 5 rectangle from wC338 (rows 32 bytes apart) to vBGMap0 + $1A0 (row 13) with CopyRect32StrideToVRAM (E-0073)
; 13 call sites from 13 routines (e.g. RunBattleSetup_Case00_Case0F, RunBattleSetup_Case00_Case0B, RunBattleSetup_Case00_Case08, RunBattleSetup_Case00_Case07, ...)
DrawWC338RowsToBGMapRow13::
Func_031_7479:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case00_Case07, RunBattleSetup_Case00_Case01)
RunBattleSetup_Shared04::
Func_031_7486:: ; address name
    farcall CopyRectRecord73ADToScreenBuffer

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case00_Case04, RunBattleSetup_Case00_Case02)
RunBattleSetup_Shared05::
Func_031_748C:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord73F7ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case00)
CopyRectRecord73F7ToScreenBufferFar::
Func_031_7499:: ; address name
    farcall CopyRectRecord73F7ToScreenBuffer
    ret

; copies a 12 x 11 rectangle from wC278 (rows 32 bytes apart) to vBGMap0 + $E0 (row 7) with CopyRect32StrideToVRAM (E-0110)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case00_Case0D, RunBattleSetup_Case01_Case04, RunBattleSetup_Case01_Case03, RunBattleSetup_Case01_Case01)
DrawWC278Rect12x11ToBGMapRow7::
Func_031_74A0:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $0C0B
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord755FToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case04)
CopyRectRecord755FToScreenBufferFar::
Func_031_74AD:: ; address name
    farcall CopyRectRecord755FToScreenBuffer
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (identical to DrawWC2B8LeftToBGMapRow9 at $74E1) (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_Case01_Case10, RunBattleSetup_Case01_Case0C, RunBattleSetup_Case01_Case08, RunBattleSetup_Case01_Case07, ...)
DrawWC2B8LeftToBGMapRow9_74B4::
Func_031_74B4:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7600ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_Case00)
CopyRectRecord7600ToScreenBufferFar::
Func_031_74C1:: ; address name
    farcall CopyRectRecord7600ToScreenBuffer
    ret

; copies a 20 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9) with CopyRect32StrideToVRAM, then wD868 = 1 (E-0077)
; 6 call sites from 5 routines (e.g. RunBattleSetup_Case02_Case10, RunBattleSetup_Case02_Case04, RunBattleSetup_Case02_Case03, RunBattleSetup_Case02_Case02, ...)
; writes: wBattleArg0
DrawWC2B8RowsToBGMapRow9::
Func_031_74C8:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wBattleArg0], a
    ret

; far-calls CopyRectRecord76ACToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_Case08_Sub01)
CopyRectRecord76ACToScreenBufferFar::
Func_031_74DA:: ; address name
    farcall CopyRectRecord76ACToScreenBuffer
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_Case01_Case1B, RunBattleSetup_Case01_Case19, RunBattleSetup_Case02_Case0F, RunBattleSetup_Case02_Case0B, ...)
DrawWC2B8LeftToBGMapRow9::
Func_031_74E1:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord76F8ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case02_Case04)
CopyRectRecord76F8ToScreenBufferFar::
Func_031_74EE:: ; address name
    farcall CopyRectRecord76F8ToScreenBuffer
    ret

; copies an 8 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) with CopyRect32StrideToVRAM (E-0115)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Case02_Case07, RunBattleSetup_Case02_Case05)
DrawWC2F8Rect8x7ToBGMapRow11::
Func_031_74F5:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0807
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecords7600And7734ToScreenBuffer in bank $1A (E-0115)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case01_Case10)
CopyRectRecords7600And7734ToScreenBufferFar::
Func_031_7502:: ; address name
    farcall CopyRectRecords7600And7734ToScreenBuffer
    ret

; copies a 7 x 1 rectangle from wC2A4 to vBGMap0 + $10C (row 8, column 12) and a 20 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9), both with CopyRect32StrideToVRAM (E-0110)
; 4 call sites from 4 routines (e.g. RunBattleSetup_Case01_Case1A, RunBattleSetup_Case01_Case14, RunBattleSetup_Case01_Case13, RunBattleSetup_Case01_Case11)
DrawWC2A4AndWC2B8Rects::
Func_031_7509:: ; address name
    ld de, wScreenTileBuffer + $10C
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ret

; far-calls CopyRectRecord7750ToScreenBuffer in bank $1A (E-0115)
; 3 call sites from 3 routines (e.g. RunBattleSetup_Case01_Case1C, RunBattleSetup_Case01_Case0C, RunBattleSetup_Case02_Case0C)
CopyRectRecord7750ToScreenBufferFar::
Func_031_7522:: ; address name
    farcall CopyRectRecord7750ToScreenBuffer
    ret

; copies a 14 x 7 rectangle from wC2F8 (rows 32 bytes apart) to vBGMap0 + $160 (row 11) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. RunBattleSetup_Case01_Case1F, RunBattleSetup_Case01_Case1D, RunBattleSetup_Case01_Case0F, RunBattleSetup_Case01_Case0D, ...)
DrawWC2F8RectToBGMapRow11::
Func_031_7529:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0E07
    call CopyRect32StrideToVRAM
    ret

; copies a 20 x 11 rectangle from wC278 (rows 32 bytes apart) to vBGMap0 + $E0 (row 7), falling into CopyRect32StrideToVRAM (E-0075)
; 8 call sites from 8 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, RunBattleSetup_Case03, RunBattleSetup_Case00_Case01, ...)
DrawWC278RowsToBGMapRow7::
Func_031_7536:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $140B

; B = width, C = rows, DE = source with 32-byte rows, HL = VRAM address with 32-byte rows: copies a B x C rectangle with WriteVRAMByteInc. DE ends 32 * C past its start and HL at the start of the row below; B kept, C = 0 (E-0060)
; 18 call sites from 15 routines (e.g. BuildAndDrawBattleScreen, DrawWC338RowsToBGMapRow13, DrawWC278Rect12x11ToBGMapRow7, RunBattleSetup_Case00_Case0C, ...)
CopyRect32StrideToVRAM::
Func_031_753F:: ; address name
    push bc
    push hl

Jump_031_7541::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_031_7541
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_031_7557
    inc d

Jump_031_7557::
    dec c
    jr nz, CopyRect32StrideToVRAM
    ret

; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. CopyRectRecordForBattlePartyCount_Bank31)
; points at: wScreenTileBuffer
ReadScreenBufferRectHeader_Bank31::
Func_031_755B:: ; address name
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de
    ret

; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0 (E-0065) (the same 18 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. CopyRectRecordForBattlePartyCount_Bank31)
CopyRectToStride32_Bank31::
Func_031_756A:: ; address name
    push bc
    push hl

Jump_031_756C::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_756C
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_Bank31
    ret

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 8 x 7 tiles
TileRect_31_757C::
Data_031_757C:: ; address name
    dw $0000 ; entry 0
    db $08, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 14 x 7 tiles
TileRect_31_75B8::
Data_031_75B8:: ; address name
    dw $0000 ; entry 0
    db $0E, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0221 (C1: a rectangle record of PartyCountRects (offset, width, rows, tiles)).
; record: offset $0000; 20 x 7 tiles
TileRect_31_761E::
Data_031_761E:: ; address name
    dw $0000 ; entry 0
    db $14, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB, $DC, $DD, $DE, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: draws the slot's status markers from its status bytes (the per-status part is not read to its end) (E-0111)
; 7 call sites from 6 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, BattleEnd_Step4_Sub02_Case02_Case00, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleStatus
DrawSlotStatusMarks::
Func_031_76AE:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, Jump_031_76BC
    farcall DrawSlotStatusMarks_BankA0
    ret

Jump_031_76BC::
    push bc
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_76D1
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_76D1
    ld a, c
    cp a, $04
    jr c, Jump_031_773A
    jr Jump_031_76D6

Jump_031_76D1::
    ld a, c
    cp a, $04
    jr nc, Jump_031_773A

Jump_031_76D6::
    and a, $03
    cp a, $03
    jr z, Jump_031_773A
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_031_7726
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a, a
    jr z, Jump_031_7710
    call DrawSlotStatusMarks_Sub01
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_Sub03
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_Sub04
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_Sub06
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_Sub02
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_Sub07
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_Sub05
    jr Jump_031_773A

Jump_031_7710::
    call DrawSlotStatusMarks_Sub08
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $C3
    jr Jump_031_773A

Jump_031_7726::
    call DrawSlotStatusMarks_Sub08
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $C2

Jump_031_773A::
    pop bc
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub01::
Func_031_773C:: ; address name
    push hl
    ld hl, Data_031_779B
    call ReadWordTableEntryForSlotC
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub02::
Func_031_774C:: ; address name
    push hl
    ld hl, Data_031_779B
    call ReadWordTableEntryForSlotC
    ld [hl], $C0
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub03::
Func_031_7757:: ; address name
    push hl
    ld hl, Data_031_77A7
    call ReadWordTableEntryForSlotC
    ld [hl], $C1
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub04::
Func_031_7762:: ; address name
    push hl
    ld hl, Data_031_77A7
    call ReadWordTableEntryForSlotC
    ld [hl], $C7
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub05::
Func_031_776D:: ; address name
    push hl
    ld hl, Data_031_77AD
    call ReadWordTableEntryForSlotC
    ld [hl], $C8
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub06::
Func_031_7778:: ; address name
    push hl
    ld hl, Data_031_77A1
    call ReadWordTableEntryForSlotC
    ld [hl], $C9
    pop hl
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks)
DrawSlotStatusMarks_Sub07::
Func_031_7783:: ; address name
    push hl
    ld hl, Data_031_77B3
    call ReadWordTableEntryForSlotC
    ld [hl], $CA
    pop hl
    ret

; HL = table: HL = the word at HL + 2 * (C & 3) (falls into DerefHL_Bank31) (E-0110)
; 7 call sites from 7 routines (e.g. DrawSlotStatusMarks_Sub05, DrawSlotStatusMarks_Sub07, DrawSlotStatusMarks_Sub02, DrawSlotStatusMarks_Sub06, ...)
ReadWordTableEntryForSlotC::
Func_031_778E:: ; address name
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, DerefHL_Bank31
    inc h

; HL = the word at HL; A = its low byte (E-0110)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks)
DerefHL_Bank31::
Func_031_7797:: ; address name
    deref_hl
    ret

; address loaded by DrawSlotStatusMarks_Sub01, DrawSlotStatusMarks_Sub02
Data_031_779B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $39, $C2, $3F, $C2, $45, $C2

; address loaded by DrawSlotStatusMarks_Sub06
Data_031_77A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $C2, $40, $C2, $46, $C2

; address loaded by DrawSlotStatusMarks_Sub03, DrawSlotStatusMarks_Sub04
Data_031_77A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3B, $C2, $41, $C2, $47, $C2

; address loaded by DrawSlotStatusMarks_Sub05
Data_031_77AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $C2, $42, $C2, $48, $C2

; address loaded by DrawSlotStatusMarks, DrawSlotStatusMarks_Sub07
Data_031_77B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3D, $C2, $43, $C2, $49, $C2

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: copies the slot's 5-tile panel row from wScreenTileBuffer to the same position of vBGMap0 (offset from Data_031_7ADA, WriteVRAMByteInc) (E-0111)
; 7 call sites from 6 routines (e.g. BattleEnd_Step4_Sub02_Case02_Case00, CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelRowToVRAM::
Func_031_77B9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_77D8
    cp a, $02
    jr nz, Jump_031_77CA
    farcall CopySlotPanelRowToVRAM_BankA0
    ret

Jump_031_77CA::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_77D8
    ld a, c
    cp a, $04
    jr c, Jump_031_7805
    jr Jump_031_77DD

Jump_031_77D8::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7805

Jump_031_77DD::
    and a, $03
    cp a, $03
    jr z, Jump_031_7805
    ld hl, SlotPanelRowOffsets
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

Jump_031_77FD::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_031_77FD

Jump_031_7805::
    ret

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: writes the slot's HP (wBattleHP) as decimal digit tiles (HLToDecimalDigits) into wScreenTileBuffer at the position from Data_031_7AC8 (E-0111)
; 6 call sites from 5 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleHP, wScreenTileBuffer
DrawSlotHPDigits::
Func_031_7806:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, Jump_031_7814
    farcall DrawSlotHPDigits_BankA0
    ret

Jump_031_7814::
    push bc
    or a, a
    jr z, Jump_031_7826
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7826
    ld a, c
    cp a, $04
    jr c, Jump_031_785D
    jr Jump_031_782B

Jump_031_7826::
    ld a, c
    cp a, $04
    jr nc, Jump_031_785D

Jump_031_782B::
    and a, $03
    cp a, $03
    jr z, Jump_031_785D
    ld a, c
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_031_7AC8
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

Jump_031_785D::
    pop bc
    ret

; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wC58A = 1 and wC57F bit 1 is set; slots 3 and 7 never); with wC58A = 2 the bank-$A0 version is far-called instead: writes the slot's MP (wBattleMP) as decimal digit tiles into wScreenTileBuffer at the slot's position (E-0111)
; 6 call sites from 5 routines (e.g. DrawSlotPanelStats2, DrawSlotPanelStats1, DrawSlotPanelStats0, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wBattleMP, wScreenTileBuffer
DrawSlotMPDigits::
Func_031_785F:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, Jump_031_786D
    farcall DrawSlotMPDigits_BankA0
    ret

Jump_031_786D::
    push bc
    or a, a
    jr z, Jump_031_787F
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_787F
    ld a, c
    cp a, $04
    jr c, Jump_031_78B6
    jr Jump_031_7884

Jump_031_787F::
    ld a, c
    cp a, $04
    jr nc, Jump_031_78B6

Jump_031_7884::
    and a, $03
    cp a, $03
    jr z, Jump_031_78B6
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_031_7ACE
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

Jump_031_78B6::
    pop bc
    ret

; only called from DrawSlotStatusMarks (E-0047)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer, wBattleLevel
DrawSlotStatusMarks_Sub08::
Func_031_78B8:: ; address name
    ld a, [wLinkMode]
    cp a, $02
    jr nz, Jump_031_78C6
    farcall DrawSlotLevel_BankA0
    ret

Jump_031_78C6::
    push bc
    or a, a
    jr z, Jump_031_78D8
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_78D8
    ld a, c
    cp a, $04
    jr c, Jump_031_7912
    jr Jump_031_78DD

Jump_031_78D8::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7912

Jump_031_78DD::
    and a, $03
    cp a, $03
    jr z, Jump_031_7912
    ld a, c
    and a, $03
    ld hl, Data_031_7AD4
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
    inc hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    pop de
    call WriteTwoDigitTilesFromWC8C1

Jump_031_7912::
    pop bc
    ret

; copies three tiles at offset Data_031_7AC8[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D47ToVRAM in mode 2) (E-0125)
; 6 call sites from 5 routines (e.g. CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7AC8ToVRAM::
Func_031_7914:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_7933
    cp a, $02
    jr nz, Jump_031_7925
    farcall CopySlotPanelPart6D47ToVRAM
    ret

Jump_031_7925::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7933
    ld a, c
    cp a, $04
    jr c, Jump_031_7964
    jr Jump_031_7938

Jump_031_7933::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7964

Jump_031_7938::
    and a, $03
    cp a, $03
    jr z, Jump_031_7964
    ld hl, Data_031_7AC8
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_031_7964::
    ret

; copies three tiles at offset Data_031_7ACE[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D4BToVRAM in mode 2) (E-0125)
; 6 call sites from 5 routines (e.g. CopySlotPanel2ToVRAM, CopySlotPanel1ToVRAM, CopySlotPanel0ToVRAM, RedrawChangedSlotPanels, ...)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7ACEToVRAM::
Func_031_7965:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_7984
    cp a, $02
    jr nz, Jump_031_7976
    farcall CopySlotPanelPart6D4BToVRAM
    ret

Jump_031_7976::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7984
    ld a, c
    cp a, $04
    jr c, Jump_031_79B5
    jr Jump_031_7989

Jump_031_7984::
    ld a, c
    cp a, $04
    jr nc, Jump_031_79B5

Jump_031_7989::
    and a, $03
    cp a, $03
    jr z, Jump_031_79B5
    ld hl, Data_031_7ACE
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_031_79B5::
    ret

; copies two tiles at offset Data_031_7AD4[slot] from the screen buffer to vBGMap0 for the shown side (CopySlotPanelPart6D4FToVRAM in mode 2) (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
; points at: wScreenTileBuffer
CopySlotPanelPart7AD4ToVRAM:: ; heuristic: follows a terminator; C0
Func_031_79B6:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_031_79D5
    cp a, $02
    jr nz, Jump_031_79C7
    farcall CopySlotPanelPart6D4FToVRAM
    ret

Jump_031_79C7::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_79D5
    ld a, c
    cp a, $04
    jr c, Jump_031_7A01
    jr Jump_031_79DA

Jump_031_79D5::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7A01

Jump_031_79DA::
    and a, $03
    cp a, $03
    jr z, Jump_031_7A01
    ld hl, Data_031_7AD4
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_031_7A01::
    ret

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes appear in 3 banks)
; 7 call sites from 6 routines (e.g. RunBattleSetup_Case00_Case01, RunBattleSetup_Case01_Case18, RunBattleSetup_Case01_Case04, RunBattleSetup_Case01_Case00, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtTilesHL_Bank31::
Func_031_7A02:: ; address name
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes appear in 2 banks)
; 7 call sites from 7 routines (e.g. RunBattleSetup_Shared07, ShowStringAAtTiles2080, ShowStringAAtTiles17F0, ShowStringAAtTiles1760, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_Bank31::
Func_031_7A3D:: ; address name
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; the same 80 bytes as UnreferencedShowFiveGlyphsAtTilesHL_BankA0; no caller found (E-0238)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wTextBuf0
UnreferencedShowFiveGlyphsAtTilesHL_Bank31:: ; configured code entry (E-0238); C0
Func_031_7A78:: ; address name
    push hl
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    pop hl
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld de, $0501
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; address loaded by DrawSlotHPDigits, CopySlotPanelPart7AC8ToVRAM
Data_031_7AC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $00, $68, $00, $6E, $00

; address loaded by DrawSlotMPDigits, CopySlotPanelPart7ACEToVRAM
Data_031_7ACE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $00, $88, $00, $8E, $00

; address loaded by DrawSlotStatusMarks_Sub08, CopySlotPanelPart7AD4ToVRAM
Data_031_7AD4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $A7, $00, $AD, $00

; E-0212 (C1: CopySlotPanelRowToVRAM reads the word at $7ADA + 2 * (slot & 3) and copies 5 tiles from wScreenTileBuffer + offset to the same offset of vBGMap0; three words for slots 0-2).
; record: offset of the slot's panel row in the screen buffer / BG map
SlotPanelRowOffsets::
Data_031_7ADA:: ; address name
    dw $00A1 ; id 0
    dw $00A7 ; id 1
    dw $00AD ; id 2

; the same 55 bytes as GetBattleATK_Bank39 (39:71E5)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AE0:: ; address name
    ld hl, wBattleATK
    jr Jump_031_7B0D

; the same 50 bytes as GetBattleDEF_Bank39 (39:71EA)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AE5:: ; address name
    ld hl, wBattleDEF
    jr Jump_031_7B0D

; the same 45 bytes as GetBattleMaxHP_Bank39 (39:71EF)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AEA:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_031_7B0D

; the same 40 bytes as GetBattleMaxMP_Bank39 (39:71F4)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AEF:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_031_7B0D

; the same 35 bytes as GetBattleHP_Bank39 (39:71F9)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AF4:: ; address name
    ld hl, wBattleHP
    jr Jump_031_7B0D

; the same 30 bytes as GetBattleMP_Bank39 (39:71FE)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AF9:: ; address name
    ld hl, wBattleMP
    jr Jump_031_7B0D

; the same 25 bytes as GetBattleAGL_Bank39 (39:7203)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleAGL
GetBattleAGL_Bank31:: ; configured code entry (E-0212); C0
Func_031_7AFE:: ; address name
    ld hl, wBattleAGL
    jr Jump_031_7B0D

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B03:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

Jump_031_7B0D::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B17:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B1E:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_031_7B33
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7B33
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_031_7B33::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7B39:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_031_7B4E
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_031_7B4E
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_031_7B4E::
    ld a, [wBattleTarget]
    cp a, $04
    ret

; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank31[D] (AddAx9ToHL); not reached from traced code (E-0212)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B54:: ; address name
    ld a, d
    ld hl, ClearBitMaskTable_Bank31
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; E-0212 (C1: the copy in bank $31 of ClearBitMaskTable (E-0205), read by the routine at $7B54; the block $7B54-$7BEE has the same bytes as $4075-$410F in banks $05, $A1 and $A3, apart from the table address).
; record: AND mask
ClearBitMaskTable_Bank31::
Data_031_7B69:: ; address name
    db $DF ; id 0
    db $FE ; id 1
    db $00 ; id 2
    db $FD ; id 3
    db $73 ; id 4
    db $EF ; id 5
    db $BF ; id 6

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B70:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B7D:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B8A:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank31:: ; configured code entry (E-0212); C0
Func_031_7B97:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_031_7BB3
    ld l, $09
    cp a, $40
    jr nc, Jump_031_7BB3
    ld l, $12

Jump_031_7BB3::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_031_7BCE
    ld l, $03
    cp a, $40
    jr nc, Jump_031_7BCE
    ld l, $06

Jump_031_7BCE::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_031_7BE9
    ld l, $01
    cp a, $40
    jr nc, Jump_031_7BE9
    ld l, $02

Jump_031_7BE9::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_Case00_Case09_Sub01)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank31::
Func_031_7BEE:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_7C08
    ld a, [hl]
    and a, $0C
    jr nz, Jump_031_7C08
    xor a, a
    jr Jump_031_7C09

Jump_031_7C08::
    scf

Jump_031_7C09::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7C0D:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_7C1C
    ld a, [hl]
    and a, $0C

Jump_031_7C1C::
    pop hl
    ret

; address loaded by GameMode5_Init_Case04, RunBattleSubStep_6A4E_Case02, BattleEnd_Step5_Case04_Sub01_Case0E, GameMode4_Init and 2 more
; LZSS-compressed asset: 477 bytes expand to 704 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_031_7C1E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $0C7C1E, $1DD

; address loaded by GameMode5_Init_Case04, RunBattleSubStep_6A4E_Case02, BattleEnd_Step5_Case04_Sub01_Case0E, GameMode4_Init and 2 more
; LZSS-compressed asset: 151 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_031_7DFB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $0C7DFB, $97
    ds $16E, $00
