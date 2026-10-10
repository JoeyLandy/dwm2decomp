SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

; start-up for wGameMode = 4, the battle: starts music 2, clears the BG map and builds the battle screen; reached from the debug battle setup (Start) and from encounters (E-0042)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case04)
; reads: wSGBActive, wIsCGB
; writes: wC51F, wC520, hScrollX, hScrollXHi, hScrollY, hScrollYHi, rVBK, wC554, ...
GameMode4_Init::
Func_031_4001:: ; address name
    call Func_000_08A6
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_031_401F
    ld a, $00
    ld [wC51F], a
    ld a, $00
    ld [wC520], a
    farcall Func_017_41CF

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
    ld [wC554], a
    ld a, h
    ld [wC555], a
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
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld a, $FC
    call StartPaletteFade
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wC5EC], a
    ld a, $0B
    jp Jump_000_077A

; per-frame routine for wGameMode = 4, the battle: in link mode (wC58A) it serves the serial link, otherwise IncrementPlayTime_Bank31 and the phase machine Func_031_40CC (wCFC8 = phase (1 fight, 2 after), wCFC9 = step)
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case04)
; reads: wC58A, wD802, wD800, wBattlePhase
GameMode4_Update::
Func_031_40A5:: ; address name
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_40C9
    call Func_000_0535
    ld a, [wD802]
    cp a, $FF
    ret z
    farcall Func_03A_4ADB
    ld a, [wD800]
    cp a, $02
    ret nz
    di
    farcall Func_032_4001
    ei
    ret

Jump_031_40C9::
    call IncrementPlayTime_Bank31

; 1 call site from 1 routine (e.g. Func_01B_43FA_Case01)
; reads: wBattlePhase
Func_031_40CC::
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
; reads: wC58A
; writes: wD868, wD7F1
; points at: wBattleStep
BattlePhase0_Step1::
Jump_031_40EE:: ; address name
    call Func_031_746F
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wD868], a
    ld a, [wC58A]
    and a, a
    ret z
    xor a, a
    ld [wD7F1], a
    ret

; wBattlePhase 0, wBattleStep 2 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wD7F1, wD960, wD961, wD962, wD963, wD890, wD964, ...
; writes: wStringIndex, wStringCategory
; points at: wC130, wC140, wC150, wBattleStep
BattlePhase0_Step2::
Jump_031_4106:: ; address name
    ld a, [wC58A]
    or a, a
    jp z, Jump_031_418E
    ld a, [wD7F1]
    rst $00
    dw Func_031_40CC_Table3_Case00
    dw Func_031_40CC_Table3_Case01
    dw Func_031_40CC_Table3_Case02
    dw Func_031_40CC_Table3_Case03

; entry 0 of the `rst $00` table in Func_031_40CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1
; writes: wD7F1, wC594
Func_031_40CC_Table3_Case00::
Jump_031_4119:: ; address name
    ld a, [wD7F1]
    inc a
    ld [wD7F1], a
    ld a, $D2
    ld [wC594], a
    ret

; entry 1 of the `rst $00` table in Func_031_40CC
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD7F1
; writes: wC594, wD7F1
Func_031_40CC_Table3_Case01::
Jump_031_4126:: ; address name
    ld a, [wC58F]
    cp a, $D2
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD7F1]
    inc a
    ld [wD7F1], a
    ret

; entry 2 of the `rst $00` table in Func_031_40CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1
; writes: wD7F1, wC595, wC596, wC592, wC593, wC590, wC591, wC594, ...
; points at: wC60C, wC958
Func_031_40CC_Table3_Case02::
Jump_031_4138:: ; address name
    ld a, [wD7F1]
    inc a
    ld [wD7F1], a
    ld hl, wC60C
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, $000A
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld hl, wC958
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

; entry 3 of the `rst $00` table in Func_031_40CC
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F
; writes: wC594, wC58C, wD7F1, wC962, wStringIndex, wStringCategory
; points at: wC958, wC130, wBattleStep
Func_031_40CC_Table3_Case03::
Jump_031_416B:: ; address name
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    xor a, a
    ld [wD7F1], a
    ld a, $F0
    ld [wC962], a
    ld de, wC958
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    jp Jump_031_4213

Jump_031_418E::
    ld a, [wD960]
    ld l, a
    ld a, [wD961]
    ld h, a
    ld de, wC130
    call Func_031_423B
    ld a, [wD962]
    ld l, a
    ld a, [wD963]
    ld h, a
    ld de, wC140
    ld a, [wD890]
    cp a, $01
    call nz, Func_031_423B
    ld a, [wD964]
    ld l, a
    ld a, [wD965]
    ld h, a
    ld de, wC150
    ld a, [wD890]
    cp a, $03
    call z, Func_031_423B
    ld a, [wD890]
    cp a, $01
    jr z, Jump_031_420F
    ld a, [wD960]
    ld e, a
    ld a, [wD961]
    ld d, a
    ld a, [wD962]
    cp a, e
    jr nz, Jump_031_41F2
    ld a, [wD963]
    cp a, d
    jr nz, Jump_031_41F2
    ld a, [wD890]
    cp a, $02
    jr z, Jump_031_4213
    ld a, [wD964]
    cp a, e
    jr nz, Jump_031_421A
    ld a, [wD965]
    cp a, d
    jr nz, Jump_031_421A
    jr Jump_031_4213

Jump_031_41F2::
    ld a, [wD890]
    cp a, $02
    jr z, Jump_031_421E
    ld a, [wD962]
    ld e, a
    ld a, [wD963]
    ld d, a
    ld a, [wD964]
    cp a, e
    jr nz, Jump_031_4222
    ld a, [wD965]
    cp a, d
    jr nz, Jump_031_4222
    jr Jump_031_4226

Jump_031_420F::
    ld a, $00
    jr Jump_031_4228

Jump_031_4213::
    ld hl, wC130
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
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; 3 call sites from 1 routine (e.g. Func_031_40CC_Table3_Case03)
Func_031_423B::
    ld a, h
    add a, $02
    ld h, a
    call CopyStringHLToDE
    ret

; wBattlePhase 0, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC58A, wCFC5, wC5E7, wC5E8
; writes: wBattleStep, wBattleSubPhase, wStringIndex, wD868, wStringCategory, wD891
; points at: wBattlePhase, wDA5B
BattlePhase0_Step3::
Jump_031_4243:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wC58A]
    or a, a
    jp nz, Jump_031_42CF
    ld a, [wCFC5]
    cp a, $02
    jp nc, Jump_031_42CF
    call NextTableByte
    ld a, [wC5E7]
    cp a, $08
    jr nc, Jump_031_4280
    ld a, [wC5E8]
    and a, $01
    add a, $0B
    ld [wStringIndex], a
    ld a, $00
    ld [wD868], a
    ld c, $04
    jr Jump_031_429B

Jump_031_4280::
    call NextTableByte
    ld a, [wC5E8]
    cp a, $08
    jr nc, Jump_031_42CF
    ld a, [wC5E7]
    and a, $01
    add a, $0D
    ld [wStringIndex], a
    ld a, $01
    ld [wD868], a
    ld c, $00

Jump_031_429B::
    ld b, $03

Jump_031_429D::
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld [wD891], a

Jump_031_42D4::
    ret

; only called from BattlePhase0_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattlePhase0_Step3)
; reads: wD960, wD961, wD890, wD962, wD963, wD964, wD965, wStringIndex
; points at: wC130
BattlePhase0_Step3_Sub01::
Func_031_42D5:: ; address name
    ld a, [wD960]
    ld e, a
    ld a, [wD961]
    ld d, a
    ld a, [wD890]
    cp a, $01
    jr z, Jump_031_4305
    ld a, [wD962]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [wD963]
    cp a, d
    jr nz, Jump_031_4329
    ld a, [wD890]
    cp a, $02
    jr z, Jump_031_430A
    ld a, [wD964]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [wD965]
    cp a, d
    jr nz, Jump_031_4329
    jr Jump_031_430A

Jump_031_4305::
    call BattlePhase0_Step3_Sub01_Sub01
    jr Jump_031_4364

Jump_031_430A::
    ld hl, wC130
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
    ld hl, wC130
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
; points at: wC130
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
    ld de, wC130
    call CopyStringHLToDE
    ld hl, wC130

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

Data_031_438E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $32, $31, $36, $37, $28, $35, $36, $F0

Data_031_4397:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $16, $32, $31, $36, $37, $28, $35, $36, $F0

; wBattlePhase 0, wBattleStep 4 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD868
; writes: wBattleStep
; points at: wBattlePhase
BattlePhase0_Step4::
Jump_031_43A0:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    ld a, [wD868]
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
; reads: wC52B
; points at: wBattleStep
BattleFight_Step0::
Jump_031_43C0:: ; address name
    ld a, [wC52B]
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
    call Func_031_746F
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    ret

; wBattlePhase 2, wBattleStep 1 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC58A, wD868
; writes: wC964, wStringIndex, wStringCategory
; points at: wBattleStep
BattleEnd_Step1::
Jump_031_440E:: ; address name
    ld a, $01
    ld [wC964], a
    call BattleEnd_Step1_Sub02
    ld a, [wD092]
    and a, $01
    jr z, Jump_031_4421
    ld a, $06
    jr Jump_031_4448

Jump_031_4421::
    call BattleEnd_Step1_Sub01
    ld a, [wD092]
    cp a, $02
    jr z, Jump_031_4443
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_031_4436
    ld a, $87
    jr Jump_031_4448

Jump_031_4436::
    ld a, [wD868]
    cp a, $01
    ld a, $07
    jr nc, Jump_031_4448
    ld a, $86
    jr Jump_031_4448

Jump_031_4443::
    ld a, [wD868]
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
; reads: wSoundChannelSlots, wC52B
; writes: wBattleSubPhase
; points at: wDC01, wDC20, wDC40, wDC60, wDC80, wDCA0, wBattleStep
BattleEnd_Step2::
Jump_031_445B:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step2_Sub01
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; only called from BattleEnd_Step2 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step2)
; reads: wD2CE
; writes: wD2CE
BattleEnd_Step2_Sub01::
Func_031_4493:: ; address name
    ld a, [wD2CE]
    dec a
    ld [wD2CE], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 3 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wD092, wDAAB
; writes: wBattleSubPhase
; points at: wBattleStep, wC986, wC60C
BattleEnd_Step3::
Jump_031_449C:: ; address name
    call BattleEnd_Step3_Sub07
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_44C4
    ld a, [wD092]
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
    ld a, [wDAAB]
    cp a, $FF
    ret z
    sub a, $04
    ret c
    cp a, $03
    ret nc
    ld a, [wC58A]
    or a, a
    call z, BattleEnd_Step3_Sub05
    call BattleEnd_Step3_Sub06
    ld a, [wDAAB]
    dec a
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld e, a
    ld a, h
    adc a, $D0
    ld d, a
    ld hl, wC986
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $0E
    call CopyBBytesDEToHL_Bank31
    push de
    ld de, wC60C
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
    farcall Func_019_73A2
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
; reads: wD890, wDA6B, wDA6C, wDA6D
; writes: wDA6B, wDA6C, wDA6D
; points at: wBattleSlotOut
BattleEnd_Step3_Sub05::
Func_031_45A3:: ; address name
    ld a, [wD890]
    ld b, a
    ld c, $04
    xor a, a
    ld [wDA6B], a
    ld [wDA6C], a
    ld [wDA6D], a

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
    ld a, [wDA6B]
    add a, [hl]
    ld [wDA6B], a
    inc hl
    ld a, [wDA6C]
    adc a, [hl]
    ld [wDA6C], a
    inc hl
    ld a, [wDA6D]
    adc a, [hl]
    ld [wDA6D], a

Jump_031_45E7::
    inc c
    dec b
    jr nz, Jump_031_45B3
    ret

Data_031_45EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $D1, $25, $D2, $73, $D2

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wCFC5, wD890, wCFDF, wCFE0, wCFDD, wCFDE
; writes: hFFC6, hFFC7, wDAAB, wCB7E
; points at: wCFDF, wCFDD
BattleEnd_Step3_Sub06::
Func_031_45F2:: ; address name
    ld a, [wCFC5]
    cp a, $02
    ret nz
    ld a, [wD890]
    cp a, $01
    jr z, Jump_031_461B
    cp a, $02
    jr z, Jump_031_461B
    ld hl, wCFDF
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, $05
    ld [wDAAB], a
    ld a, [wCFDF]
    ld l, a
    ld a, [wCFE0]
    ld h, a
    jr Jump_031_4631

Jump_031_461B::
    ld hl, wCFDD
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wCFDD]
    ld l, a
    ld a, [wCFDE]
    ld h, a
    ld a, $04
    ld [wDAAB], a

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
    ld [wCB7E], a
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
; reads: hFFC6, hFFC7
BattleEnd_Step3_Sub06_Sub01::
Func_031_4681:: ; address name
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
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
; points at: wDC01, wDC20, wDC40, wDC60, wDC80, wDCA0
BattleEnd_Step4::
Jump_031_4693:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, BattleEnd_Step4_Sub01
    call BattleEnd_Step4_Sub02
    ret

; only called from BattleEnd_Step4 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step4)
; reads: wD2CE
; writes: wD2CE
BattleEnd_Step4_Sub01::
Func_031_46C1:: ; address name
    ld a, [wD2CE]
    dec a
    ld [wD2CE], a
    ret nz
    ret

; wBattlePhase 2, wBattleStep 5 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step5::
Jump_031_46CA:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw Func_031_46C1_Case00
    dw Func_031_46C1_Case01
    dw Func_031_46C1_Case02
    dw Func_031_46C1_Case03
    dw Func_031_46C1_Case04

; entry 0 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; reads: wDAAB, wSpeciesIdLo, wSpeciesIdHi
; writes: wBattleSubPhase, wD960, wD961, wBattleResolveStep, wBattleSubStep
; points at: wBattleStep, wBattleSubPhase
Func_031_46C1_Case00::
Jump_031_46D8:: ; address name
    farcall Func_016_5B7E
    ld a, [wDAAB]
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
    ld [wD960], a
    ld a, h
    ld [wD961], a
    call Func_031_71F5
    call CopyRectRecordForWD88F_Bank31
    call Func_031_7389
    call Func_031_746F
    ld a, $6C
    call QueueSoundEffect
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 1 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
Func_031_46C1_Case01::
Jump_031_471C:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_031_46C1_Table2_Case00
    dw Func_031_46C1_Table2_Case01

; entry 0 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer, wC27F, wBattleResolveStep
Func_031_46C1_Table2_Case00::
Jump_031_4724:: ; address name
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRect32StrideToVRAM
    call Func_031_47DD
    call LayoutTileBlocksForWD890Count
    call Func_031_7321
    ld de, wC27F
    ld hl, vBGMap0 + $E7
    ld bc, $0606
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
Func_031_46C1_Table2_Case01::
Jump_031_474A:: ; address name
    farcall Func_016_5D13
    ret

; entry 2 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD7BC, wD7BA, wD7BB
; writes: hFFB9, hFFBA, hFF8D, wSpriteSlotCount
; points at: wBattleSubPhase, wBattleSubStep
Func_031_46C1_Case02::
Jump_031_4751:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    ld a, [wD7BC]
    ldh [hFFB9], a
    ld a, $80
    ldh [hFFBA], a
    ld a, [wD7BA]
    ldh [hFF8D], a
    ld a, [wD7BB]
    ld [wSpriteSlotCount], a
    call Func_031_47C7
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

; entry 3 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep, wCFCF
Func_031_46C1_Case03::
Jump_031_4793:: ; address name
    ld a, [wBattleSubStep]
    cp a, $03
    call z, Func_031_47A9
    farcall Func_016_6A4E
    ld a, [wCFCF]
    or a, a
    call nz, Func_031_47DD
    ret

; 1 call site from 1 routine (e.g. Func_031_46C1_Case03)
; points at: wScreenTileBuffer
Func_031_47A9::
    call Func_031_47C7
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412
    call CopyRect32StrideToVRAM
    ret

; entry 4 of the `rst $00` table in Func_031_46C1
; no direct call (reached through a table, a jump or a vector)
; reads: wCFCF
Func_031_46C1_Case04::
Jump_031_47B9:: ; address name
    farcall Func_016_6C16
    ld a, [wCFCF]
    or a, a
    call nz, Func_031_47DD
    ret

; 2 call sites from 2 routines (e.g. Func_031_47A9, Func_031_46C1_Case02)
Func_031_47C7::
    call Func_031_47DD
    call Func_031_71F5
    call CopyRectRecordForWD88F_Bank31
    call Func_031_7389
    call LayoutTileBlocksForWD890Count
    call Func_031_7321
    call Func_031_746F
    ret

; 4 call sites from 4 routines (e.g. Func_031_46C1_Case04, Func_031_46C1_Case03, Func_031_47C7, Func_031_46C1_Table2_Case00)
; reads: wDAAB
; writes: wCFCF, wC526, wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
; points at: wBattleMonsterId
Func_031_47DD::
    xor a, a
    ld [wCFCF], a
    ld a, [wDAAB]
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
    ld [wC526], a
    call UploadBGPalettes
    call LoadRecordListNameTiles
    ld hl, vTiles1 + $6D0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; wBattlePhase 2, wBattleStep 6 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step6::
Jump_031_4840:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw Func_031_47DD_Case00
    dw Func_031_47DD_Case01
    dw Func_031_47DD_Case02

; entry 0 of the `rst $00` table in Func_031_47DD
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC608
; writes: hFFB9, hFFBA
; points at: wD2CD, wBattleSubPhase
Func_031_47DD_Case00::
Jump_031_484A:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC608]
    ld hl, wD2CD
    cp a, [hl]
    jr z, Jump_031_485D
    ld a, $02
    call QueueMusic

Jump_031_485D::
    xor a, a
    ldh [hFFB9], a
    ld a, $80
    ldh [hFFBA], a
    ld a, $04
    call StartPaletteFade
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_47DD
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wBattleSubPhase
Func_031_47DD_Case01::
Jump_031_486E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_031_47DD
; no direct call (reached through a table, a jump or a vector)
; reads: wC608, wCFC5
; writes: wGameMode, wModeState, wC5DD, wC5DE, wD068, wD780, wC5E0
; points at: wD2CD, wD066
Func_031_47DD_Case02::
Jump_031_4878:: ; address name
    ld a, [wC608]
    ld hl, wD2CD
    cp a, [hl]
    jr z, Jump_031_4885
    ld a, [hl]
    call QueueMusic

Jump_031_4885::
    ld a, [wCFC5]
    cp a, $02
    jr c, Jump_031_4893
    cp a, $04
    jr nc, Jump_031_4893
    call Func_031_48C3

Jump_031_4893::
    ld a, $01
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld [wD068], a
    ld [wD780], a
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall Func_003_4339
    ld a, $02
    ld [wC5E0], a
    ld hl, wD066
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_031_47DD_Case02)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wFollowerRecords, wC8F4, wC8F9, wC8F0, wC8F5, wC8FA, wC8F1, wC8F6, ...
Func_031_48C3::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ret

; wBattlePhase 2, wBattleStep 7 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
BattleEnd_Step7::
Jump_031_48E5:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw Func_031_48C3_Case00
    dw Func_031_48C3_Case01
    dw Func_031_48C3_Case02

; entry 0 of the `rst $00` table in Func_031_48C3
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots, wC52B
; writes: wC594
; points at: wDC01, wDC20, wDC40, wDC60, wDC80, wDCA0, wBattleSubPhase
Func_031_48C3_Case00::
Jump_031_48EF:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_48C3
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F
; points at: wBattleSubPhase
Func_031_48C3_Case01::
Jump_031_4926:: ; address name
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_031_48C3
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState, wC5DD, wC5DE, wD780, wC581, wC582, wC57F, ...
; points at: wModeChangeRequest, wD066
Func_031_48C3_Case02::
Jump_031_4931:: ; address name
    ld a, $04
    call StartPaletteFade
    farcall Func_0A3_4B0B
    ld a, $06
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld [wD780], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wD066
    inc [hl]
    xor a, a
    ld [wC581], a
    ld [wC582], a
    xor a, a
    ld [wC57F], a
    ld [wC580], a
    xor a, a
    ld [wC58A], a
    xor a, a
    ld [wC58F], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58B], a
    ret

; wBattlePhase 2, wBattleStep 9 (E-0044)
; no direct call (reached through a table, a jump or a vector)
; reads: wD092
; writes: wBattleStep
BattleEnd_Step9::
Jump_031_4975:: ; address name
    ld a, [wD092]
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
; reads: wC58A, wD890
; writes: wD868
; points at: wD960, wC130, wC958
BattleEnd_Step1_Sub01::
Func_031_498E:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_49E5
    xor a, a
    ld [wD868], a
    ld hl, wD960
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [wD890]
    cp a, $01
    jr z, BattleEnd_Step1_Sub01_Sub01
    ld a, $01
    ld [wD868], a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_031_4A00
    ld a, [hl+]
    cp a, d
    jr nz, Jump_031_4A00
    ld a, [wD890]
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
    ld hl, wC130

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
; points at: wC130
BattleEnd_Step1_Sub01_Sub01::
Func_031_49D8:: ; address name
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, wC130
    call CopyStringHLToDE
    jr Jump_031_4A22

Jump_031_49E5::
    ld de, wC958
    ld hl, wC130
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
    ld [wD868], a
    jr Jump_031_4A22

Jump_031_4A00::
    ld hl, wC130
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
    ld [wD868], a

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
; reads: wC984, wC58A, wC57F, wC985
; writes: wD892, wD893, wC46B
; points at: wDAD8, wD854, wD895, wBattleActionChoice, wDA5B, wBattleStep, wD80F
BattleFight_Step0_Sub01::
Func_031_4A65:: ; address name
    ld hl, wDAD8
    ld b, $08

Jump_031_4A6A::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_031_4A6A
    ld hl, wD854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wD895
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wD892], a
    ld [wD893], a
    ld a, $00
    ld [wC46B], a
    ld a, [wC984]
    ld b, a
    ld c, $00
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_4AB5
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_4AB5
    ld a, [wC985]
    ld b, a
    ld c, $04

Jump_031_4AB5::
    push bc
    ld a, c
    ld hl, wDA5B
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
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_031_4B01
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_031_4B01
    ld a, c
    ld hl, wD80F
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
    ld hl, wDA5B
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
    dw RunBattleSetup_Table2_Case00
    dw RunBattleSetup_Table2_Case01
    dw RunBattleSetup_Table2_Case02
    dw RunBattleSetup_Table2_Case03
    dw RunBattleSetup_Table2_Case04
    dw RunBattleSetup_Table2_Case05
    dw RunBattleSetup_Table2_Case06
    dw RunBattleSetup_Table2_Case07
    dw RunBattleSetup_Table2_Case08
    dw RunBattleSetup_Table2_Case09
    dw RunBattleSetup_Table2_Case0A
    dw RunBattleSetup_Table2_Case0B
    dw RunBattleSetup_Table2_Case0C
    dw RunBattleSetup_Table2_Case0D
    dw RunBattleSetup_Table2_Case0E
    dw RunBattleSetup_Table2_Case0F
    dw RunBattleSetup_Table2_Case10

; entry 0 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F
; points at: wDAF2, wDA43, wBattleResolveStep
RunBattleSetup_Table2_Case00::
Jump_031_4B54:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_4B5E
    ld c, $00
    jr Jump_031_4B66

Jump_031_4B5E::
    ld a, [wC57F]
    and a, $02
    sla a
    ld c, a

Jump_031_4B66::
    ld de, wDAF2
    ld b, $03

Jump_031_4B6B::
    ld a, c
    ld hl, wDA43
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

; entry 1 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F
; writes: wStringCategory, wStringIndex
; points at: wDAD8, wBattleResolveStep
RunBattleSetup_Table2_Case01::
Jump_031_4B8F:: ; address name
    ld a, [wC57F]
    rlca
    and a, $04
    ld hl, wDAD8
    add_a_to_hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call DrawWC278RowsToBGMapRow7
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_Shared01
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC46B
; points at: wBattleResolveStep
RunBattleSetup_Table2_Case02::
Jump_031_4BCC:: ; address name
    call RunBattleSetup_Shared02
    ld hl, Data_031_639F
    ld a, [wC46B]
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

; entry 3 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wC46B, wC46C, wBattleResolveStep
RunBattleSetup_Table2_Case03::
Jump_031_4BEE:: ; address name
    ld de, Data_031_639F
    ld hl, wC46B
    call Func_031_5F02
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_4C18
    ld a, $69
    call QueueSoundEffect
    ld hl, wC46C
    ld bc, $0007
    ld a, $00
    call FillBytes
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_4C18::
    ret

; entry 4 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Table2_Case04::
Jump_031_4C19:: ; address name
    call RunBattleSetup_Shared02
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC46B, wC58A, wCFC5, wC57F
; writes: wCFDB, wStringIndex, wStringCategory, wBattleSubPhase, wBattleResolveStep, wCFD4
; points at: wBattleResolveStep, wDA5B
RunBattleSetup_Table2_Case05::
Jump_031_4C21:: ; address name
    ld a, [wC46B]
    and a, $03
    ld [wCFDB], a
    or a, a
    jr z, Jump_031_4C37
    cp a, $01
    jr z, Jump_031_4C49
    cp a, $02
    jr z, Jump_031_4C83
    jp Jump_031_4CBC

Jump_031_4C37::
    call RunBattleSetup_Table2_Case05_Sub01
    call RunBattleSetup_Table2_Case05_Sub02
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jp Jump_031_4CED

Jump_031_4C49::
    ld a, [wC57F]
    sla a
    and a, $04
    ld c, a
    ld b, $03

Jump_031_4C53::
    ld a, c
    ld hl, wDA5B
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
    ld [wCFD4], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_4CED

Jump_031_4C83::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_4CA2
    ld a, [wCFC5]
    cp a, $04
    jr z, Jump_031_4CA2
    cp a, $05
    jr z, Jump_031_4CA2
    call RunBattleSetup_Table2_Case05_Sub01
    call RunBattleSetup_Table2_Case05_Sub03
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
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_4CC6
    ld a, $20
    jr Jump_031_4CA4

Jump_031_4CC6::
    call RunBattleSetup_Table2_Case05_Sub01
    ld hl, wBattleResolveStep
    ld [hl], $08
    ld a, [wCFC5]
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

; only called from RunBattleSetup_Table2_Case05 (E-0047)
; 3 call sites from 1 routine (e.g. RunBattleSetup_Table2_Case05)
; reads: wC57F
; points at: wBattleActionChoice
RunBattleSetup_Table2_Case05_Sub01::
Func_031_4CEE:: ; address name
    ld a, [wC57F]
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

; only called from RunBattleSetup_Table2_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case05)
; reads: wC58A, wC57F
; points at: wDAF2, wDA43
RunBattleSetup_Table2_Case05_Sub02::
Func_031_4D06:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_4D10
    ld c, $00
    jr Jump_031_4D18

Jump_031_4D10::
    ld a, [wC57F]
    and a, $02
    sla a
    ld c, a

Jump_031_4D18::
    ld de, wDAF2
    ld b, $03

Jump_031_4D1D::
    ld a, c
    ld hl, wDA43
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

; entry 6 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_Table2_Case06::
Jump_031_4D3D:: ; address name
    call Func_031_746F
    call DrawWC338RowsToBGMapRow13
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleResolveStep
RunBattleSetup_Table2_Case07::
Jump_031_4D4E:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call DrawWC338RowsToBGMapRow13
    call RunBattleSetup_Shared01
    ld a, $02
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC130, wC60C, wBattleResolveStep
RunBattleSetup_Table2_Case08::
Jump_031_4D65:: ; address name
    call Func_031_746F
    call DrawWC338RowsToBGMapRow13
    ld hl, wC130
    ld de, wC60C
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
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld a, $82
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wSoundChannelSlots, wD891, wD88F, wD890, wC5E7, wC58A, wDataBankSave
; writes: wStringCategory, wStringIndex, wD092, wBattlePhase, wBattleStep, wC964, wDataBank, wDataBankSave
; points at: wDC20, wD8B7, wD8BB, wBattleResolveStep
RunBattleSetup_Table2_Case09::
Jump_031_4D95:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wD891]
    or a, a
    jr z, Jump_031_4E16
    ld a, [wD88F]
    ld b, a
    ld e, $00
    ld c, $00
    ld hl, wD8B7

Jump_031_4DB5::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld a, [wD890]
    ld b, a
    ld d, $00
    ld c, $04
    ld hl, wD8BB

Jump_031_4DD0::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld a, [wC5E7]
    and a, $07
    inc a
    ld b, a
    ld a, [wD891]
    cp a, $04
    jr c, Jump_031_4DF9
    ld a, $07

Jump_031_4DF9::
    cp a, b
    jr nc, Jump_031_4E16
    call RunBattleSetup_Table2_Case09_Sub01
    jr z, Jump_031_4E16
    ld a, $00
    ld [wStringCategory], a
    ld a, $2C
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_031_4E16::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_4E1F
    call RunBattleSetup_Table2_Case09_Sub02

Jump_031_4E1F::
    ld a, $02
    ld [wD092], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $03
    ld [wBattleStep], a
    ld a, $01
    ld [wC964], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; only called from RunBattleSetup_Table2_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case09)
; reads: wD890
RunBattleSetup_Table2_Case09_Sub01::
Func_031_4E3E:: ; address name
    ld a, [wD890]
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

; only called from RunBattleSetup_Table2_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case09)
; reads: wD88F
; points at: wD8B7, wD980, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
RunBattleSetup_Table2_Case09_Sub02::
Func_031_4E54:: ; address name
    ld a, [wD88F]
    ld b, a
    ld c, $00

Jump_031_4E5A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_031_4EB4
    ld hl, wD8B7
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
    ld hl, wD980
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
    call RunBattleSetup_Table2_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityMid
    call RunBattleSetup_Table2_Case09_Sub02_Sub01
    inc hl
    ld de, wSlotPersonalityLo
    call RunBattleSetup_Table2_Case09_Sub02_Sub01
    inc hl
    ld de, wD980
    call RunBattleSetup_Table2_Case09_Sub02_Sub01

Jump_031_4EB4::
    inc c
    dec b
    jr nz, Jump_031_4E5A
    ret

; only called from RunBattleSetup_Table2_Case09_Sub02 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleSetup_Table2_Case09_Sub02)
RunBattleSetup_Table2_Case09_Sub02_Sub01::
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

Data_031_4EC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $00, $00, $0A, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

Data_031_4ED6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $00, $00, $0F, $06, $00, $00, $0A, $04, $00, $00, $05, $02, $00, $00, $03

; entry 10 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD88F
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wDA5B
RunBattleSetup_Table2_Case0A::
Jump_031_4EE6:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wDA5B

Jump_031_4EF4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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

; entry 11 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Table2_Case0B::
Jump_031_4F0F:: ; address name
    call Func_031_746F
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC307, wC46C
; points at: wC2A6, wBattleResolveStep
RunBattleSetup_Table2_Case0C::
Jump_031_4F2A:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_01A_72DB
    ld a, $BB
    ld [wC307], a
    ld a, $01
    ld [wC46C], a
    ld de, wC2A6
    ld hl, vBGMap0 + $10E
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46C
; writes: wBattleResolveStep, wBattleSubPhase, wStringCategory, wStringIndex
; points at: wC46C, wBattleResolveStep
RunBattleSetup_Table2_Case0D::
Jump_031_4F50:: ; address name
    ld de, Data_031_63C5
    ld hl, wC46C
    call Func_031_5F02
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, [wC46C]
    and a, $01
    ld hl, Data_031_4FA4
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld a, [wC46C]
    and a, $01
    jr z, Jump_031_4F8F
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call Func_031_74A0
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

Jump_031_4F8F::
    ld a, $00
    ld [wStringCategory], a
    ld a, $60
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Data_031_4FA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

; entry 14 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wDataBankSave
; writes: wD092, wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wDataBank, wDataBankSave
RunBattleSetup_Table2_Case0E::
Jump_031_4FA8:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $03
    ld [wD092], a
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

; entry 15 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_Table2_Case0F::
Jump_031_4FCE:: ; address name
    call Func_031_746F
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleResolveStep
RunBattleSetup_Table2_Case10::
Jump_031_4FE9:: ; address name
    ld a, [wC52B]
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
    dw Func_031_4EB9_Case00
    dw Func_031_4EB9_Case01
    dw Func_031_4EB9_Case02
    dw Func_031_4EB9_Case03
    dw Func_031_4EB9_Case04
    dw Func_031_4EB9_Case05
    dw Func_031_4EB9_Case06
    dw Func_031_4EB9_Case07
    dw Func_031_4EB9_Case08
    dw Func_031_4EB9_Case09
    dw Func_031_4EB9_Case0A
    dw Func_031_4EB9_Case0B
    dw Func_031_4EB9_Case0C
    dw Func_031_4EB9_Case0D
    dw Func_031_4EB9_Case0E
    dw Func_031_4EB9_Case0F
    dw Func_031_4EB9_Case10
    dw Func_031_4EB9_Case11
    dw Func_031_4EB9_Case12
    dw Func_031_4EB9_Case13
    dw Func_031_4EB9_Case14
    dw Func_031_4EB9_Case15
    dw Func_031_4EB9_Case16
    dw Func_031_4EB9_Case17
    dw Func_031_4EB9_Case18
    dw Func_031_4EB9_Case19
    dw Func_031_4EB9_Case1A
    dw Func_031_4EB9_Case1B
    dw Func_031_4EB9_Case1C
    dw Func_031_4EB9_Case1D
    dw Func_031_4EB9_Case1E
    dw Func_031_4EB9_Case1F
    dw Func_031_4EB9_Case20
    dw Func_031_4EB9_Case21
    dw Func_031_4EB9_Case16
    dw Func_031_4EB9_Case23

; entry 0 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD7, wCFD4
; writes: wStringCategory, wStringIndex, wCFD7, wCFD6, wCFD5
; points at: wC29B, wBattleResolveStep
Func_031_4EB9_Case00::
Jump_031_5040:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    ld a, [wDAD7]
    or a, a
    jr z, Jump_031_5067
    ld a, $07
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_Bank31

Jump_031_5067::
    xor a, a
    ld [wCFD7], a
    ld a, $03
    ld [wCFD6], a
    xor a, a
    ld [wCFD5], a
    call Func_031_7499
    ld a, [wCFD4]
    and a, $03
    ld hl, wC29B
    call Func_031_60EB
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wCFD4, wC46C
; writes: wC46C, wCFD3
; points at: wCFD8, wBattleResolveStep
Func_031_4EB9_Case01::
Jump_031_5087:: ; address name
    ld a, [wCFD4]
    and a, $03
    ld hl, wCFD8
    add_a_to_hl
    ld a, [hl]
    ld [wC46C], a
    call Func_031_74A0
    ld hl, Data_031_63A7
    ld a, [wC46C]
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
    ld [wCFD3], a
    ret

; entry 2 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCFD4, wC46C, wDAD7
; writes: wBattleResolveStep, wD869, wCFD4
; points at: wC46C, wCFD8, wBattleActionChoice, wDAD8, wBattleResolveStep, wDA5B, wC29B
Func_031_4EB9_Case02::
Jump_031_50BF:: ; address name
    ld de, Data_031_63A7
    ld hl, wC46C
    call Func_031_5F9E
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_5118
    ld a, $69
    call QueueSoundEffect
    ld a, [wCFD4]
    and a, $03
    ld hl, wCFD8
    add_a_to_hl
    ld a, [wC46C]
    and a, $03
    ld [hl], a
    call Func_031_63CD
    cp a, $03
    jr nz, Jump_031_514E
    ld a, [wDAD7]
    or a, a
    jr z, Jump_031_5104
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld [hl], $00
    jr Jump_031_515E

Jump_031_5104::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wD869], a
    ret

Jump_031_5118::
    bit 1, a
    jr z, Jump_031_517C

Jump_031_511C::
    ld a, [wCFD4]
    and a, $03
    jr z, Jump_031_5147
    ld a, [wCFD4]
    dec a
    ld [wCFD4], a
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_511C
    ld a, [wCFD4]
    and a, $03
    ld hl, wC29B
    call Func_031_60EB
    ld hl, wBattleResolveStep
    dec [hl]
    jr Jump_031_517C

Jump_031_5147::
    ld a, $00
    ld [wD869], a
    jr Jump_031_5172

Jump_031_514E::
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_031_515E::
    ld a, [wCFD4]
    ld hl, wDAD8
    add_a_to_hl
    set 7, [hl]
    ld a, $20
    ld [wBattleResolveStep], a
    jr Jump_031_517C

Jump_031_5172::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_517C::
    ret

; entry 3 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
Func_031_4EB9_Case03::
Jump_031_517D:: ; address name
    call Func_031_74A0
    ld a, $01
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD869, wCFD4
; writes: wD869, wStringCategory, wStringIndex, wC46D
; points at: wC2D9, wDAD8, wBattleResolveStep
Func_031_4EB9_Case04::
Jump_031_518A:: ; address name
    ld a, [wD869]
    or a, a
    call z, Func_031_74A0
    xor a, a
    ld [wD869], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call Func_031_74AD
    ld a, [wCFD4]
    and a, $03
    ld hl, wC2D9
    call Func_031_60EB
    ld a, [wCFD4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $03
    ld [wC46D], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
; points at: wBattleResolveStep
Func_031_4EB9_Case05::
Jump_031_51CE:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld hl, Data_031_63AF
    ld a, [wC46D]
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

; entry 6 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCFD4, wC46D
; writes: wD869, wBattleResolveStep, wC470
; points at: wC46D, wBattleResolveStep, wDAD8, wBattleActionChoice
Func_031_4EB9_Case06::
Jump_031_51F0:: ; address name
    ld de, Data_031_63AF
    ld hl, wC46D
    call Func_031_5F4E
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5212
    ld a, $00
    ld [wD869], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_031_52B4

Jump_031_5212::
    bit 0, a
    jp z, Jump_031_52B4
    ld a, $69
    call QueueSoundEffect
    ld a, [wCFD4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [wC46D]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wC46D]
    and a, $03
    or a, a
    jr z, Jump_031_5242
    cp a, $01
    jr z, Jump_031_526D
    jr Jump_031_5292

Jump_031_5242::
    call CountPresentFoesOfWC57FSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_525C
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld [hl], e
    jr Jump_031_52A5

Jump_031_525C::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $0C
    ld [wBattleResolveStep], a
    xor a, a
    ld [wC470], a
    jr Jump_031_52B4

Jump_031_526D::
    call Func_031_6105
    ld a, d
    or a, a
    jr nz, Jump_031_5281
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $08
    ld [wBattleResolveStep], a
    jr Jump_031_52B4

Jump_031_5281::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    xor a, a
    ld [wD869], a
    ld a, $10
    ld [wBattleResolveStep], a
    jr Jump_031_52B4

Jump_031_5292::
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $AC
    ld [hl+], a
    ld a, [wCFD4]
    ld [hl], a

Jump_031_52A5::
    ld a, $01
    ld [wD869], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_52B4::
    ret

; entry 7 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD869
; writes: wBattleResolveStep
Func_031_4EB9_Case07::
Jump_031_52B5:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    ld a, [wD869]
    or a, a
    jr z, Jump_031_52C0
    ld a, $20

Jump_031_52C0::
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_031_4EB9_Case08::
Jump_031_52C4:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call Func_031_746F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
Func_031_4EB9_Case09::
Jump_031_52CF:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; points at: wBattleResolveStep
Func_031_4EB9_Case0A::
Jump_031_52E7:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
Func_031_4EB9_Case0B::
Jump_031_52F7:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 12 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wD869
; points at: wBattleResolveStep
Func_031_4EB9_Case0C::
Jump_031_5300:: ; address name
    call DrawWC2B8LeftToBGMapRow9_74B4
    call Func_031_7522
    xor a, a
    ld [wD869], a
    farcall Func_03A_7BA0
    xor a, a
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F
; writes: wD86C
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Case0D::
Jump_031_5319:: ; address name
    call DrawWC2F8RectToBGMapRow11
    xor a, a
    ld [wD86C], a
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld e, $01
    ld a, $00
    call Func_031_64D8
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

; entry 14 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wJoypadPressed, wCFD4, wC470
; writes: wD868
; points at: wC470, wBattleResolveStep, wBattleActionChoice
Func_031_4EB9_Case0E::
Jump_031_5350:: ; address name
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld de, Data_031_63AF
    call Func_031_6518
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_537B
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $00
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_53B9

Jump_031_537B::
    bit 0, a
    jr z, Jump_031_53B9
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $00
    ld [hl+], a
    ld a, [wC470]
    and a, $03
    ld b, a
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $01
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_53B9::
    ret

; entry 15 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868
; writes: wBattleResolveStep
Func_031_4EB9_Case0F::
Jump_031_53BA:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wD868]
    or a, a
    jr z, Jump_031_53C7
    ld a, $20
    jr Jump_031_53C9

Jump_031_53C7::
    ld a, $04

Jump_031_53C9::
    ld [wBattleResolveStep], a
    ret

; entry 16 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD869, wCFD4, wD86A, wD86B, wCFD5, wC46E
; writes: wD869, wC46E, wCFD5, wStringCategory
; points at: wDAD8, wCFD5, wBattleResolveStep
Func_031_4EB9_Case10::
Jump_031_53CD:: ; address name
    ld a, [wD869]
    or a, a
    call z, DrawWC2B8LeftToBGMapRow9_74B4
    xor a, a
    ld [wD869], a
    ld a, [wCFD4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wC46E], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCFD5], a
    ld hl, wCFD5
    res 7, [hl]
    ld de, Data_031_63A7
    call Func_031_6153
    call Func_031_61A4
    call Func_031_7502
    ld a, $09
    ld [wStringCategory], a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, [wCFD5]
    add a, a
    add a, a
    ld c, a
    ld a, [wC46E]
    and a, $03
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call Func_031_6331
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC46E
; writes: wCFD3
; points at: wBattleResolveStep
Func_031_4EB9_Case11::
Jump_031_542A:: ; address name
    call Func_031_7509
    ld hl, Data_031_63A7
    ld a, [wC46E]
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
    call Func_031_6373
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wCFD3], a
    ret

; entry 18 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCFF1, wCFD4, wRecordBufferData, wCFD5, wC46E, wRecordBuffer, wCFF2
; writes: wD869, wStringIndex
; points at: wC46E, wBattleMP, wDAD8, wBattleActionChoice, wBattleResolveStep
Func_031_4EB9_Case12::
Jump_031_5454:: ; address name
    ld de, Data_031_63A7
    ld hl, wC46E
    call Func_031_5F9E
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_031_557A
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $20
    ld [wD869], a
    call Func_031_63ED
    ld a, [wCFF1]
    bit 0, a
    jp z, Jump_031_5599
    ld a, [wCFD4]
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
    ld a, [wCFD4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCFD5]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wC46E]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCFD4]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hl+], a
    cp a, $35
    jr z, Jump_031_5523
    ld a, [wCFF2]
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
    ld a, [wCFD4]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jp Jump_031_5598

Jump_031_5515::
    ld a, [wCFD4]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5523::
    ld a, [wCFD4]
    and a, $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_552F::
    call CountPresentFoesOfWC57FSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_553E
    ld [hl], e
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_553E::
    ld a, $1C
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5549::
    call CountPresentSlotsOfWC57FSide_Bank31
    ld a, d
    cp a, $01
    jr nz, Jump_031_5566
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5566
    cp a, $1F
    jr z, Jump_031_5566
    ld a, [wCFD4]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5566::
    ld a, $18
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5571::
    ld a, [wCFD4]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_031_557A::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5592
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $04
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_5592::
    call Func_031_61A4
    call Func_031_6373

Jump_031_5598::
    ret

Jump_031_5599::
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

Jump_031_55AD::
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5598

; entry 19 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD869
; writes: wBattleResolveStep, wD869
Func_031_4EB9_Case13::
Jump_031_55C1:: ; address name
    call Func_031_7509
    ld a, [wD869]
    ld [wBattleResolveStep], a
    xor a, a
    ld [wD869], a
    ret

; entry 20 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_031_4EB9_Case14::
Jump_031_55CF:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call Func_031_7509
    call Func_031_746F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
Func_031_4EB9_Case15::
Jump_031_55E0:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; points at: wBattleResolveStep
Func_031_4EB9_Case16::
Jump_031_55F2:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
Func_031_4EB9_Case17::
Jump_031_5602:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld a, $10
    ld [wBattleResolveStep], a
    ret

; entry 24 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wC470
; points at: wBattleResolveStep
Func_031_4EB9_Case18::
Jump_031_560B:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call Func_031_6451
    xor a, a
    ld [wC470], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wC57F
; writes: wD86C
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Case19::
Jump_031_562A:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5639
    cp a, $1F
    jr z, Jump_031_5639
    xor a, a

Jump_031_5639::
    ld [wD86C], a
    ld a, [wC57F]
    sla a
    and a, $04
    ld b, a
    ld hl, wC470
    ld e, $01
    ld a, $00
    call Func_031_64D8
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

; entry 26 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wJoypadPressed, wRecordBuffer, wCFD4, wC470
; writes: wD868, wStringIndex, wBattleResolveStep
; points at: wC470, wBattleResolveStep, wBattleTargetChoice
Func_031_4EB9_Case1A::
Jump_031_566A:: ; address name
    ld a, [wC57F]
    sla a
    and a, $04
    ld b, a
    ld hl, wC470
    ld de, Data_031_63AF
    call Func_031_6518
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5693
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $10
    ld [wD868], a
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
    ld a, [wCFD4]
    and a, $03
    ld c, a
    ld a, [wC470]
    and a, $03
    cp a, c
    jr nz, Jump_031_56D5
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call Func_031_7509
    call Func_031_746F
    ld a, $65
    ld [wStringIndex], a
    ld a, $21
    ld [wBattleResolveStep], a
    jr Jump_031_56FD

Jump_031_56D5::
    ld a, [wCFD4]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wC470]
    and a, $03
    ld b, a
    ld a, [wCFD4]
    and a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $20
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_56FD::
    ret

; entry 27 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868
; writes: wBattleResolveStep
Func_031_4EB9_Case1B::
Jump_031_56FE:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wD868]
    ld [wBattleResolveStep], a
    ret

; entry 28 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer
; writes: wD869, wC470
; points at: wBattleResolveStep
Func_031_4EB9_Case1C::
Jump_031_5708:: ; address name
    call Func_031_7522
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_5717
    cp a, $1F
    jr z, Jump_031_5717
    xor a, a

Jump_031_5717::
    ld [wD869], a
    farcall Func_03A_7BA0
    xor a, a
    ld [wD869], a
    xor a, a
    ld [wC470], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wC57F
; writes: wD86C
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Case1D::
Jump_031_572D:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_573C
    cp a, $1F
    jr z, Jump_031_573C
    xor a, a

Jump_031_573C::
    ld [wD86C], a
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld e, $01
    ld a, $00
    call Func_031_64D8
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

; entry 30 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wJoypadPressed, wCFD4, wC470
; writes: wD868
; points at: wC470, wBattleResolveStep, wBattleTargetChoice
Func_031_4EB9_Case1E::
Jump_031_576F:: ; address name
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld de, Data_031_63AF
    call Func_031_6518
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_579A
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $10
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_57D5

Jump_031_579A::
    bit 0, a
    jr z, Jump_031_57D5
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, [wCFD4]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wC470]
    and a, $03
    ld b, a
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $20
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_57D5::
    ret

; entry 31 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868
; writes: wBattleResolveStep
Func_031_4EB9_Case1F::
Jump_031_57D6:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wD868]
    ld [wBattleResolveStep], a
    ret

; entry 32 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wCFD4
; writes: wCFD4, wBattleResolveStep, wBattleSubPhase
; points at: wDA5B
Func_031_4EB9_Case20::
Jump_031_57E0:: ; address name
    ld a, [wCFD4]
    and a, $04
    or a, $03
    ld b, a

Jump_031_57E8::
    ld a, [wCFD4]
    inc a
    ld [wCFD4], a
    cp a, b
    jr z, Jump_031_5804
    ld hl, wDA5B
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

; entry 33 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
Func_031_4EB9_Case21::
Jump_031_580E:: ; address name
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
Func_031_4EB9_Case23::
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
    dw Func_031_4EB9_Table2_Case00
    dw Func_031_4EB9_Table2_Case01
    dw Func_031_4EB9_Table2_Case02
    dw Func_031_4EB9_Table2_Case03
    dw Func_031_4EB9_Table2_Case04
    dw Func_031_4EB9_Table2_Case05
    dw Func_031_4EB9_Table2_Case06
    dw Func_031_4EB9_Table2_Case07
    dw Func_031_4EB9_Table2_Case08
    dw Func_031_4EB9_Table2_Case09
    dw Func_031_4EB9_Table2_Case0A
    dw Func_031_4EB9_Table2_Case0B
    dw Func_031_4EB9_Table2_Case0C
    dw Func_031_4EB9_Table2_Case0D
    dw Func_031_4EB9_Table2_Case0E
    dw Func_031_4EB9_Table2_Case0F
    dw Func_031_4EB9_Table2_Case10
    dw Func_031_4EB9_Table2_Case11
    dw Func_031_4EB9_Table2_Case12
    dw Func_031_4EB9_Table2_Case13

; entry 0 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wCFD5, wC471
; writes: wStringCategory, wStringIndex
; points at: wCFD5, wInventory, wBattleResolveStep
Func_031_4EB9_Table2_Case00::
Jump_031_5855:: ; address name
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call DrawWC278RowsToBGMapRow7
    ld hl, wCFD5
    res 7, [hl]
    ld de, Data_031_63A7
    call Func_031_624F
    call Func_031_6288
    call Func_031_74C1
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wC471]
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

; entry 1 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868, wC471
; writes: wD868, wCFD3
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case01::
Jump_031_589C:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    ld a, [wD868]
    or a, a
    ret z
    xor a, a
    ld [wD868], a
    ld hl, Data_031_63A7
    ld a, [wC471]
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
    call Func_031_6373
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wCFD3], a
    ret

; entry 2 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wItemId, wD088, wD08A
; writes: wD869, wD893, wD892, wBattleSubPhase, wBattleResolveStep, wStringIndex
; points at: wC471, wBattleResolveStep, wCFD5
Func_031_4EB9_Table2_Case02::
Jump_031_58CF:: ; address name
    ld de, Data_031_63A7
    ld hl, wC471
    call Func_031_5F9E
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_031_597D
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $00
    ld [wD869], a
    call Func_031_62D3
    ld a, [wItemId]
    ld [wD893], a
    ld a, [wD088]
    bit 0, a
    jr nz, Jump_031_5921
    ld a, [wD08A]
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
    call LayoutTileBlocksForWD890Count
    ld a, $10
    ld [wBattleResolveStep], a
    ld a, $1E
    ld [wStringIndex], a
    jr Jump_031_59AF

Jump_031_5933::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    call DrawWC2B8RowsToBGMapRow9
    ld a, $08
    ld [wBattleResolveStep], a
    jr Jump_031_59AF

Jump_031_5943::
    ld a, $10
    ld [wD892], a
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
    ld [wD892], a
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
    call LayoutTileBlocksForWD890Count
    ld a, $FF
    ld [wD892], a
    ld [wD893], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_59AF

Jump_031_5995::
    bit 2, a
    jr z, Jump_031_59A7
    farcall Func_016_590C
    ld de, Data_031_63A7
    ld hl, wCFD5
    set 7, [hl]

Jump_031_59A7::
    call Func_031_6288
    call Func_031_6373
    jr Jump_031_59AF

Jump_031_59AF::
    ret

; entry 3 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
Func_031_4EB9_Table2_Case03::
Jump_031_59B0:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC46F, wD869
; writes: wC46F, wD869, wStringCategory, wStringIndex
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case04::
Jump_031_59BC:: ; address name
    ld a, [wC46F]
    and a, $01
    ld [wC46F], a
    ld a, [wD869]
    or a, a
    call z, DrawWC2B8RowsToBGMapRow9
    xor a, a
    ld [wD869], a
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call Func_031_74EE
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC46F
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case05::
Jump_031_59EA:: ; address name
    call Func_031_74F5
    ld hl, Data_031_639F
    ld a, [wC46F]
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

; entry 6 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wD08A, wItemId, wC46F, wDA67, wDA68, wDA69
; writes: wD892, wBattleSubPhase, wBattleResolveStep, wD868, wC46F
; points at: wC46F, wBattleResolveStep
Func_031_4EB9_Table2_Case06::
Jump_031_5A0C:: ; address name
    ld de, Data_031_63B5
    ld hl, wC46F
    call Func_031_5F02
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_031_5A78
    ld a, $69
    call QueueSoundEffect
    call Func_031_62D3
    ld a, [wD08A]
    and a, $01
    jr nz, Jump_031_5A5B
    ld a, [wItemId]
    cp a, $19
    jr c, Jump_031_5A71
    cp a, $1F
    jr nc, Jump_031_5A71
    ld a, [wC46F]
    and a, $01
    jr z, Jump_031_5A71
    ld b, $04
    ld a, [wDA67]
    or a, a
    jr z, Jump_031_5A55
    ld b, $05
    ld a, [wDA68]
    or a, a
    jr z, Jump_031_5A55
    ld b, $06
    ld a, [wDA69]
    or a, a
    jr nz, Jump_031_5A8F

Jump_031_5A55::
    ld a, b
    ld [wD892], a
    jr Jump_031_5A66

Jump_031_5A5B::
    ld a, [wC46F]
    and a, $01
    inc a
    swap a
    ld [wD892], a

Jump_031_5A66::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_031_5A8F

Jump_031_5A71::
    ld a, $01
    ld [wD868], a
    jr Jump_031_5A85

Jump_031_5A78::
    bit 1, a
    jr z, Jump_031_5A8F
    xor a, a
    ld [wC46F], a
    ld a, $00
    ld [wD868], a

Jump_031_5A85::
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld hl, wBattleResolveStep
    inc [hl]

Jump_031_5A8F::
    ret

; entry 7 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868, wC46F
; writes: wBattleResolveStep
Func_031_4EB9_Table2_Case07::
Jump_031_5A90:: ; address name
    call Func_031_74F5
    ld a, [wD868]
    or a, a
    jr z, Jump_031_5AA2
    ld a, [wC46F]
    and a, $01
    add a, a
    add a, a
    add a, $08

Jump_031_5AA2::
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case08::
Jump_031_5AA6:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call Func_031_645E
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wC57F
; writes: wD86C
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Table2_Case09::
Jump_031_5AC1:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5ACC
    xor a, a

Jump_031_5ACC::
    ld [wD86C], a
    ld a, [wC57F]
    sla a
    and a, $04
    ld b, a
    ld hl, wC470
    ld e, $01
    ld a, $00
    call Func_031_64D8
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

; entry 10 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wJoypadPressed, wC470
; writes: wD868, wD892
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Table2_Case0A::
Jump_031_5AFD:: ; address name
    ld a, [wC57F]
    sla a
    and a, $04
    ld b, a
    ld hl, wC470
    ld de, Data_031_63AF
    call Func_031_6518
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5B26
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $00
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B26::
    bit 0, a
    jr z, Jump_031_5B48
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, [wC470]
    and a, $03
    ld [wD892], a
    ld a, $01
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B48::
    ret

; entry 11 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868, wD08A
; writes: wBattleResolveStep, wD868, wBattleSubPhase
Func_031_4EB9_Table2_Case0B::
Jump_031_5B49:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wD868]
    or a, a
    jr nz, Jump_031_5B66
    call Func_031_62D3
    ld a, [wD08A]
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
    ld [wD868], a
    ret

; entry 12 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wD869
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case0C::
Jump_031_5B7B:: ; address name
    call Func_031_7522
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5B86
    xor a, a

Jump_031_5B86::
    ld [wD869], a
    farcall Func_03A_7BA0
    xor a, a
    ld [wD869], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wC57F
; writes: wD86C
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Table2_Case0D::
Jump_031_5B98:: ; address name
    call DrawWC2F8RectToBGMapRow11
    ld a, [wItemId]
    cp a, $0C
    jr z, Jump_031_5BA3
    xor a, a

Jump_031_5BA3::
    ld [wD86C], a
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld e, $01
    ld a, $00
    call Func_031_64D8
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

; entry 14 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wJoypadPressed, wC470
; writes: wD868, wD892
; points at: wC470, wBattleResolveStep
Func_031_4EB9_Table2_Case0E::
Jump_031_5BD6:: ; address name
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, wC470
    ld de, Data_031_63AF
    call Func_031_6518
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_031_5C01
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, $00
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C01::
    bit 0, a
    jr z, Jump_031_5C25
    ld a, $69
    call QueueSoundEffect
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ld a, [wC470]
    and a, $03
    set 2, a
    ld [wD892], a
    ld a, $01
    ld [wD868], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C25::
    ret

; entry 15 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wD868, wD08A
; writes: wBattleResolveStep, wD868, wBattleSubPhase
Func_031_4EB9_Table2_Case0F::
Jump_031_5C26:: ; address name
    call DrawWC2B8LeftToBGMapRow9
    ld a, [wD868]
    or a, a
    jr nz, Jump_031_5C43
    call Func_031_62D3
    ld a, [wD08A]
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
    ld [wD868], a
    ret

; entry 16 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case10::
Jump_031_5C58:: ; address name
    call DrawWC2B8RowsToBGMapRow9
    call Func_031_746F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case11::
Jump_031_5C63:: ; address name
    call DrawWC338RowsToBGMapRow13
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
Func_031_4EB9_Table2_Case12::
Jump_031_5C6B:: ; address name
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    call FillWC278WithC3_Bank31
    call LayoutTileBlocksForWD890Count
    ret

; entry 19 of the `rst $00` table in Func_031_4EB9
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleResolveStep
Func_031_4EB9_Table2_Case13::
Jump_031_5C80:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call DrawWC338RowsToBGMapRow13
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 3 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wC594
; points at: wDA5B, wBattleSubPhase
RunBattleSetup_Case03::
Jump_031_5C8D:: ; address name
    ld b, $08
    ld hl, wDA5B

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
    call LayoutTileBlocksForWD890Count
    call Func_031_746F
    call DrawWC278RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A
; writes: wStringCategory, wStringIndex, wC594
; points at: wC958, wC130, wBattleSubPhase
RunBattleSetup_Case04::
Jump_031_5CB5:: ; address name
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_5CD8
    ld de, wC958
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    xor a, a
    ld [wC594], a

Jump_031_5CD8::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A
; writes: wC594
; points at: wBattleSubPhase
RunBattleSetup_Case05::
Jump_031_5CDD:: ; address name
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_5CE8
    ld a, $01
    ld [wC594], a

Jump_031_5CE8::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC58F, wC57F, wC5E7, wC5E8, wC46B
; writes: wC594, wC592, wC593, wC595, wC596, wC590, wC591
; points at: wDA43, wDA47, wC597, wBattleActionChoice, wDA24, wDA5B, wDA5F, wDAD8, ...
RunBattleSetup_Case06::
Jump_031_5CED:: ; address name
    ld a, [wC58A]
    or a, a
    jp z, Jump_031_5D8D
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld de, wDA43
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5D0B
    ld de, wDA47

Jump_031_5D0B::
    ld hl, wC597
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wC5E7]
    ld [hl+], a
    ld a, [wC5E8]
    ld [hl+], a
    ld a, [wC46B]
    ld [hl+], a
    ld a, [wC46B]
    ld [hl+], a
    ld de, wBattleActionChoice
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5D33
    ld de, wDA24

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
    ld de, wDA5B
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5D51
    ld de, wDA5F

Jump_031_5D51::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, wDAD8
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5D66
    ld de, wDADC

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
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a

Jump_031_5D8D::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A
; writes: wC594, wC58C
; points at: wBattleSubPhase
RunBattleSetup_Case07::
Jump_031_5D92:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wC58A]
    and a, a
    jr z, Jump_031_5DA6
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a

Jump_031_5DA6::
    ret

; entry 8 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC58F, wC57F, wC5E7, wC5E8, wC46B, wC5BA, wC5BB
; writes: wC594, wC58C, wDAE9, wDAEA, wC5BA, wC5BB, wC5BC, wC5E7, ...
; points at: wDA47, wDA43, wC5B7, wDA24, wBattleActionChoice, wDA5F, wDA5B, wDADC, ...
RunBattleSetup_Case08::
Jump_031_5DA7:: ; address name
    ld a, [wC58A]
    or a, a
    jp z, Jump_031_5E78
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld de, wDA47
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5DC9
    ld de, wDA43

Jump_031_5DC9::
    ld hl, wC5B7
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
    ld [wDAE9], a
    ld a, [hl+]
    ld [wDAEA], a
    ld de, wDA24
    ld a, [wC57F]
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
    ld de, wDA5F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5E09
    ld de, wDA5B

Jump_031_5E09::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, wDADC
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_5E1E
    ld de, wDAD8

Jump_031_5E1E::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_031_5E4D
    ld a, [wC5E7]
    ld [wC5BA], a
    ld a, [wC5E8]
    ld [wC5BB], a
    ld a, [wC46B]
    ld [wC5BC], a
    ld a, [wC46B]
    ld [wDAE9], a
    ld hl, wDA47
    ld de, wDA4F
    jr Jump_031_5E6B

Jump_031_5E4D::
    ld a, [wC5BA]
    ld [wC5E7], a
    ld a, [wC5BB]
    ld [wC5E8], a
    ld a, [wC46B]
    ld [wC5BD], a
    ld a, [wC46B]
    ld [wDAEA], a
    ld hl, wDA43
    ld de, wDA4B

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
; reads: wC58A, wC5E7, wC5BA, wC5E8, wC5BB
; writes: wC594, wCF8B
; points at: wBattleSubPhase, wC59A
RunBattleSetup_Case09::
Jump_031_5E7D:: ; address name
    ld a, [wC58A]
    and a, a
    jr nz, Jump_031_5E85
    jr Jump_031_5EB2

Jump_031_5E85::
    ld hl, wC59A
    ld a, [hl+]
    ld b, a
    ld a, [wC5E7]
    cp a, b
    ld a, [wC5BA]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, [hl]
    ld b, a
    ld a, [wC5E8]
    cp a, b
    ld a, [wC5BB]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, $22
    ld [wC594], a
    ld [wCF8B], a
    jr Jump_031_5EB2

Jump_031_5EAA::
    ld a, $33
    ld [wC594], a
    ld [wCF8B], a

Jump_031_5EB2::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC58F
; writes: wCF8C, wC594
; points at: wBattleSubPhase
RunBattleSetup_Case0A::
Jump_031_5EB7:: ; address name
    ld a, [wC58A]
    and a, a
    jr z, Jump_031_5ED0
    ld a, [wC58F]
    cp a, $22
    jr z, Jump_031_5EC9
    cp a, $33
    jr z, Jump_031_5EC9
    ret

Jump_031_5EC9::
    ld [wCF8C], a
    xor a, a
    ld [wC594], a

Jump_031_5ED0::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wCF8B, wCF8C
; writes: wBattleSubPhase
; points at: wBattleSubPhase
RunBattleSetup_Case0B::
Jump_031_5ED5:: ; address name
    ld a, [wC58A]
    and a, a
    jr z, Jump_031_5EF1
    ld a, [wCF8B]
    cp a, $22
    jr nz, Jump_031_5EEB
    ld a, [wCF8C]
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

; 4 call sites from 4 routines (e.g. RunBattleSetup_Table2_Case0D, RunBattleSetup_Table2_Case03, Func_031_4EB9_Table2_Case06, Func_031_6E67_Case05)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
Func_031_5F02::
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

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case06)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
Func_031_5F4E::
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

; 4 call sites from 4 routines (e.g. Func_031_4EB9_Case12, Func_031_4EB9_Case02, Func_031_4EB9_Table2_Case02, Func_031_6E67_Case02)
; reads: wJoypadPressedRepeat, wCFD5, wCFD7, wCFD6, wFrameCounterLo, wCFD3
; writes: wFrameCounterLo, wCFD5
Func_031_5F9E::
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_031_5FE2
    ld a, [wCFD5]
    ld b, a
    ld a, [wCFD7]
    cp a, b
    jr nz, Jump_031_5FC6
    ld a, [wCFD6]
    or a, a
    jp z, Jump_031_60A4
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [wCFD6]
    jr Jump_031_5FD4

Jump_031_5FC6::
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [wCFD3]

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
    ld a, [wCFD5]
    ld b, a
    ld a, [wCFD7]
    cp a, b
    jr nz, Jump_031_600A
    ld a, [wCFD6]
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
    ld a, [wCFD3]
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
    ld a, [wCFD7]
    or a, a
    jr z, Jump_031_6068
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_031_604B
    ld a, [wCFD5]
    or a, a
    jr nz, Jump_031_603E
    ld a, b
    jr Jump_031_603F

Jump_031_603E::
    dec a

Jump_031_603F::
    or a, $80
    ld [wCFD5], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_031_607D

Jump_031_604B::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_031_6068
    ld a, [wCFD5]
    cp a, b
    jr nz, Jump_031_605B
    xor a, a
    jr Jump_031_605C

Jump_031_605B::
    inc a

Jump_031_605C::
    or a, $80
    ld [wCFD5], a
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
    ld a, [wCFD7]
    ld b, a
    ld a, [wCFD5]
    res 7, a
    cp a, b
    jr nz, Jump_031_60A4
    ld a, [wCFD6]
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
; 15 call sites from 4 routines (e.g. Func_031_5F02, Func_031_6518, Func_031_5F9E, Func_031_5F4E)
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
; 13 call sites from 6 routines (e.g. Func_031_5F02, Func_031_6518, Func_031_61A4, Func_031_5F9E, ...)
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

; 3 call sites from 3 routines (e.g. Func_031_4EB9_Case04, Func_031_4EB9_Case02, Func_031_4EB9_Case00)
; writes: wC46C
Func_031_60EB::
    push hl
    ld hl, Data_031_6102
    add_a_to_hl
    xor a, a
    ld [wC46C], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_031_60FC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_031_60FC
    ret

Data_031_6102:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case06)
; reads: wCFD4
; writes: wD86A, wD86B, wCFD7, wCFD6, wCFD5
; points at: wD989
Func_031_6105::
    ld a, [wCFD4]
    ld hl, wD989
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
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
    ld [wCFD7], a
    ld a, c
    or a, a
    jr z, Jump_031_614B
    and a, $03
    dec a
    and a, $03

Jump_031_614B::
    ld [wCFD6], a
    xor a, a
    ld [wCFD5], a
    ret

; 2 call sites from 2 routines (e.g. Func_031_61A4, Func_031_4EB9_Case10)
; reads: wCFD4, wCFD5
; writes: wStringCategory, wD86A, wD86B
; points at: wD989
Func_031_6153::
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCFD4]
    ld hl, wD989
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, [wCFD5]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_62F7
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6306
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6315
    ld a, [hl]
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6324
    ret

; 4 call sites from 1 routine (e.g. Func_031_6153)
Func_031_61A2::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. Func_031_4EB9_Case12, Func_031_4EB9_Case10)
; reads: wCFD5, wC46E, wD86A, wD86B
; writes: wCFD5, wC46E, wStringCategory
; points at: wC46E, wC388
Func_031_61A4::
    ld a, [wCFD5]
    bit 7, a
    jr z, Jump_031_61BE
    res 7, a
    ld [wCFD5], a
    ld hl, wC46E
    call ClearBit6AndCursorEntryTile_Bank31
    call Func_031_6153
    ld hl, wC46E
    set 7, [hl]

Jump_031_61BE::
    ld a, [wC46E]
    bit 7, a
    ret z
    res 7, a
    ld [wC46E], a
    and a, $0F
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, [wCFD5]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call Func_031_6331
    ld de, wC388
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

; only called from RunBattleSetup_Table2_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case05)
; writes: wCFD7, wCFD6, wCFD5
; points at: wInventory
RunBattleSetup_Table2_Case05_Sub03::
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
    ld [wCFD7], a
    ld a, c
    or a, a
    jr z, Jump_031_623D
    and a, $03
    call z, RunBattleSetup_Table2_Case05_Sub03_Sub01
    dec a
    and a, $03

Jump_031_623D::
    ld [wCFD6], a
    xor a, a
    ld [wCFD5], a
    ret

; only called from RunBattleSetup_Table2_Case05_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case05_Sub03)
; reads: wCFD7
; writes: wCFD7
RunBattleSetup_Table2_Case05_Sub03_Sub01::
Func_031_6245:: ; address name
    push af
    ld a, [wCFD7]
    dec a
    ld [wCFD7], a
    pop af
    ret

; 2 call sites from 2 routines (e.g. Func_031_6288, Func_031_4EB9_Table2_Case00)
; reads: wCFD5
; writes: wStringCategory
; points at: wInventory
Func_031_624F::
    ld a, $05
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCFD5]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_62F7
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6306
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6315
    ld a, [hl]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6324
    ret

; 4 call sites from 1 routine (e.g. Func_031_624F)
Func_031_6286::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. Func_031_4EB9_Table2_Case02, Func_031_4EB9_Table2_Case00)
; reads: wCFD5, wC471
; writes: wCFD5, wC471, wStringCategory, wStringIndex
; points at: wC471, wInventory
Func_031_6288::
    ld a, [wCFD5]
    bit 7, a
    jr z, Jump_031_62A2
    res 7, a
    ld [wCFD5], a
    ld hl, wC471
    call ClearBit6AndCursorEntryTile_Bank31
    call Func_031_624F
    ld hl, wC471
    set 7, [hl]

Jump_031_62A2::
    ld a, [wC471]
    bit 7, a
    ret z
    res 7, a
    ld [wC471], a
    and a, $0F
    push af
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCFD5]
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

; 4 call sites from 4 routines (e.g. Func_031_4EB9_Table2_Case0F, Func_031_4EB9_Table2_Case0B, Func_031_4EB9_Table2_Case06, Func_031_4EB9_Table2_Case02)
; reads: wCFD5, wC471
; writes: wItemId
; points at: wInventory
Func_031_62D3::
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld hl, wInventory
    add_a_to_hl
    ld a, [wC471]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    farcall LoadItemRecord
    ret

; 2 call sites from 2 routines (e.g. Func_031_6153, Func_031_624F)
; writes: wStringIndex
Func_031_62F7::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_031_6153, Func_031_624F)
; writes: wStringIndex
Func_031_6306::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_031_6153, Func_031_624F)
; writes: wStringIndex
Func_031_6315::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_031_6153, Func_031_624F)
; writes: wStringIndex
Func_031_6324::
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    ret

; 2 call sites from 2 routines (e.g. Func_031_61A4, Func_031_4EB9_Case10)
; reads: wRecordBufferData, wCFD4
; writes: wStringIndex, wRecordBuffer, wCFED
; points at: wBattleMP, wC388
Func_031_6331::
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_031_6364
    ld a, [wCFD4]
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
    ld de, wC388
    call WriteDecimalDigitTiles
    ret

; 4 call sites from 4 routines (e.g. Func_031_4EB9_Case12, Func_031_4EB9_Case11, Func_031_4EB9_Table2_Case02, Func_031_4EB9_Table2_Case01)
; reads: wCFD7, wCFD5
Func_031_6373::
    ld a, [wCFD7]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCFD5]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCFD7]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

Data_031_639F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C8, $01, $08, $02

Data_031_63A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $01, $81, $01, $C1, $01, $01, $02

Data_031_63AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $01, $C1, $01, $01, $02

Data_031_63B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C1, $01, $01, $02

Data_031_63BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00

Data_031_63C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01, $2F, $01, $6F, $01

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case02)
; reads: wCFD4
; points at: wDA43, wDA4B
Func_031_63CD::
    push af
    ld a, [wCFD4]
    ld hl, wDA43
    add_a_to_hl
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [wCFD4]
    ld hl, wDA4B
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case12)
; reads: wC46E, wCFD5, wCFD4
; writes: wRecordBuffer, wCFED
; points at: wD989
Func_031_63ED::
    ld a, [wC46E]
    and a, $03
    ld b, a
    ld a, [wCFD5]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wD989
    add_a_to_hl
    ld a, [wCFD4]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    ret

; side base = ((wC57F << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfWC57FSide; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A, BC (E-0067) (the same 28 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. Func_031_4EB9_Case12, Func_031_4EB9_Case06)
; reads: wC57F
CountPresentFoesOfWC57FSide_Bank31::
Func_031_641D:: ; address name
    ld de, $0000
    ld b, $03
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_031_642C::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_031_6434
    inc d
    ld e, c

Jump_031_6434::
    inc c
    dec b
    jr nz, Jump_031_642C
    ret

; side base = (wC57F << 1) & 4: D = how many of its three slots are present; clobbers A, BC (E-0067) (the same 24 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_031_4EB9_Case12)
; reads: wC57F
CountPresentSlotsOfWC57FSide_Bank31::
Func_031_6439:: ; address name
    ld d, $00
    ld b, $03
    ld a, [wC57F]
    sla a
    and a, $04
    ld c, a

Jump_031_6445::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_031_644C
    inc d

Jump_031_644C::
    inc c
    dec b
    jr nz, Jump_031_6445
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case18)
; reads: wRecordBuffer, wC57F, wD86D, wD86E, wD86F
; points at: wBattleSlotOut, wD86D, wC31A
Func_031_6451::
    ld a, [wRecordBuffer]
    cp a, $1E
    jr z, Jump_031_6465
    cp a, $1F
    jr z, Jump_031_6465
    jr Jump_031_6486

; 1 call site from 1 routine (e.g. Func_031_4EB9_Table2_Case08)
; reads: wItemId, wC57F, wD86D, wD86E, wD86F
; points at: wBattleSlotOut, wD86D, wC31A
Func_031_645E::
    ld a, [wItemId]
    cp a, $0C
    jr nz, Jump_031_6486

Jump_031_6465::
    ld a, [wC57F]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_031_6474
    inc d

Jump_031_6474::
    ld b, $03
    ld hl, wD86D

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
    ld a, [wC57F]
    sla a
    and a, $04
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_031_6495
    inc d

Jump_031_6495::
    ld b, $03
    ld hl, wD86D

Jump_031_649A::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_649A
    jr Jump_031_64A2

Jump_031_64A2::
    call Func_031_74DA
    ld hl, wC31A
    ld a, [wD86D]
    or a, a
    call nz, Func_031_64CE
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD86E]
    or a, a
    call nz, Func_031_64CE
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD86F]
    or a, a
    call nz, Func_031_64CE
    ret

; 3 call sites from 1 routine (e.g. Func_031_645E)
Func_031_64CE::
    push hl
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; 7 call sites from 6 routines (e.g. Func_031_6518, Func_031_4EB9_Case1D, Func_031_4EB9_Case19, Func_031_4EB9_Case0D, ...)
; reads: wD86C
Func_031_64D8::
    or a, a
    jr nz, Jump_031_64EB
    ld a, [wD86C]
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
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_031_6513
    jr z, Jump_031_650A
    ld a, [wD86C]
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

; 5 call sites from 5 routines (e.g. Func_031_4EB9_Case1E, Func_031_4EB9_Case1A, Func_031_4EB9_Case0E, Func_031_4EB9_Table2_Case0E, ...)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
Func_031_6518::
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_031_6530
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $FF
    ld a, $01
    call Func_031_64D8
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
    call Func_031_64D8
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

; no direct call (reached through a table, a jump or a vector)
Func_031_6564:: ; heuristic: follows a terminator; C0
    farcall Func_0E0_443B
    ret

; only called from BattleEnd_Step1 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step1)
; reads: wDataBankSave, wCFC5, wD092, wC57F
; writes: wDataBank, wDataBankSave, wD092
BattleEnd_Step1_Sub02::
Func_031_656B:: ; address name
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ld a, [wCFC5]
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
    ld a, [wD092]
    or a, a
    jr nz, Jump_031_65FB
    ld a, [wC57F]
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
    ld [wD092], a
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
; reads: wC58A, wD88F
; writes: rRAMG, rRAMB
BattleEnd_Step3_Sub07::
Func_031_663D:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Jump_031_6677
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wD88F]
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
; reads: wC46B
; writes: wC835
; points at: wDA43, wDA4B
BattleEnd_Step3_Sub07_Sub01::
Func_031_6678:: ; address name
    push bc
    ld a, c
    ld hl, wDA43
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld b, a
    ld a, c
    ld hl, wDA4B
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
    ld a, [wC46B]
    and a, $03
    ld [wC835], a
    pop bc
    ret

; only called from BattleEnd_Step3_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub07)
; reads: wCFC5
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
    ld a, [wCFC5]
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
; writes: wD868
; points at: wBattleHP
BattleEnd_Step3_Sub07_Sub03::
Func_031_66E2:: ; address name
    ld a, [hl]
    ld [wD868], a
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
; reads: wD868
; points at: wD93F
BattleEnd_Step3_Sub07_Sub05::
Func_031_6757:: ; address name
    ld a, [wD868]
    bit 7, a
    jr nz, Jump_031_676D
    ld a, c
    ld de, wD93F
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
; reads: wD868
; points at: wSlotPersonalityHi, wSlotPersonalityLo, wD980, wSlotPersonalityMid
BattleEnd_Step3_Sub07_Sub06::
Func_031_6776:: ; address name
    ld a, [wD868]
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
    ld de, wD980
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
    dw Func_031_67AA_Case00
    dw Func_031_67AA_Case01
    dw Func_031_67AA_Case02
    dw Func_031_67AA_Case03
    dw Func_031_67AA_Case04
    dw Func_031_67AA_Case05
    dw Func_031_67AA_Case06
    dw Func_031_67AA_Case07
    dw Func_031_67AA_Case08
    dw Func_031_67AA_Case09

; entry 0 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wCFC5, wC58A, wDA6B, wDA6C, wDA6D
; writes: wBattleResolveStep, wBattleSubPhase, hFFC6, wDA6B, hFFC7, wDA6C, hFFC8, wDA6D
; points at: wBattleSlotOut, wC130, wBattleSubPhase
Func_031_67AA_Case00::
Jump_031_67C2:: ; address name
    ld a, [wCFC5]
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
    ld a, [wC58A]
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
    ld a, [wDA6B]
    ld l, a
    ld a, [wDA6C]
    ld h, a
    ld a, [wDA6D]
    ld e, a
    ld a, d
    push af
    call Divide24ByA
    pop af
    ld a, l
    ldh [hFFC6], a
    ld [wDA6B], a
    ld a, h
    ldh [hFFC7], a
    ld [wDA6C], a
    ld a, e
    ldh [hFFC8], a
    ld [wDA6D], a
    ld hl, wC130
    call Func_000_2ECF
    ld hl, $0500
    call Func_031_6DDD
    ld hl, wBattleSubPhase
    inc [hl]
    ret
    db $FE, $02, $C8, $FE, $03, $28, $0D, $7D, $D6, $01, $6F, $7C, $DE, $00, $67, $7B
    db $DE, $00, $5F, $C9, $7D, $C6, $01, $6F, $7C, $CE, $00, $67, $7B, $CE, $00, $5F
    db $C9

; entry 1 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: rRAMG, rRAMB, wBattleResolveStep, wD868
; points at: wBattleSlotOut, wBattleSubPhase
Func_031_67AA_Case01::
Jump_031_6851:: ; address name
    ld a, [wC52B]
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
    call z, Func_031_6885
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
    ld [wD868], a
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case01)
; reads: wDA6B, wDA6C, wDA6D
Func_031_6885::
    push bc
    ld a, c
    ld c, $58
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [wDA6B]
    add a, c
    ld c, a
    ld a, [wDA6C]
    adc a, b
    ld b, a
    ld a, [wDA6D]
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
Func_031_67AA_Case02::
Jump_031_68B8:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_031_6885_Case00
    dw Func_031_6885_Case01

; entry 0 of the `rst $00` table in Func_031_6885
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD868, wC6FD
; writes: wD868, wD2CE
; points at: wBattleSlotOut, wC6FE, wBattleSubPhase, wD8B7, wBattleResolveStep
Func_031_6885_Case00::
Jump_031_68C0:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD868]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_031_68E7
    ld a, [wD868]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    call Func_031_6D28
    bit 0, c
    jr nz, Jump_031_6901

Jump_031_68E7::
    ld a, [wC6FD]
    ld b, a
    ld a, [wD868]
    inc a
    ld [wD868], a
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
    ld [wD2CE], a
    ld a, [wD868]
    ld hl, wD8B7
    add_a_to_hl
    inc [hl]
    ld a, [wD868]
    ld c, a
    call Func_031_76AE
    ld a, [wD868]
    ld c, a
    call Func_031_77B9
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_031_6885
; no direct call (reached through a table, a jump or a vector)
; reads: wD868
; writes: rRAMG, rRAMB, wD869, wBattleResolveStep
; points at: wC6FE, wBattleSubPhase
Func_031_6885_Case01::
Jump_031_6925:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD868]
    ld c, $01
    call SRAMRecordAddressMapped
    call Func_031_6D87
    push hl
    ld a, [wD868]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld [wD869], a
    farcall Func_01A_6418
    pop hl
    call Func_031_6D96
    ld hl, $0501
    call Func_031_6DDD
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
Func_031_67AA_Case03::
Jump_031_6966:: ; address name
    call Func_031_71C4
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_031_6885_Table2_Case00
    dw Func_031_6885_Table2_Case01
    dw Func_031_6885_Table2_Case02

; entry 0 of the `rst $00` table in Func_031_6885
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD868
; writes: rRAMG, rRAMB
; points at: wD09D, wBattleResolveStep
Func_031_6885_Table2_Case00::
Jump_031_6973:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wD09D
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD868]
    ld c, $34
    call SRAMRecordAddressMapped
    ld de, wD09D
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

; entry 1 of the `rst $00` table in Func_031_6885
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, hFFC9, hFFCA, hFFCB
; writes: wBattleSubStep
; points at: wC150, wC160, wD09D, wBattleResolveStep
Func_031_6885_Table2_Case01::
Jump_031_69A4:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_01A_60F1
    ldh a, [hFFC9]
    cp a, $FF
    jr z, Jump_031_69FA
    ld l, a
    ld h, $04
    ld de, wC150
    call CopyStringHLToDE
    ld c, $FF
    ld hl, $0503
    ldh a, [hFFCA]
    or a, a
    jr z, Jump_031_69E2
    ld hl, $0505
    ldh a, [hFFCA]
    cp a, $02
    jr z, Jump_031_69E2
    ldh a, [hFFCB]
    ld l, a
    ld h, $04
    ld de, wC160
    call CopyStringHLToDE
    ld hl, $0504
    ldh a, [hFFCB]
    ld c, a

Jump_031_69E2::
    push bc
    call Func_031_6DDD
    pop bc
    ld hl, wD09D
    ld b, $38

Jump_031_69EC::
    ld a, [hl]
    cp a, c
    jr nz, Jump_031_69F5
    ldh a, [hFFC9]
    ld [hl], a
    jr Jump_031_69F9

Jump_031_69F5::
    inc hl
    dec b
    jr nz, Jump_031_69EC

Jump_031_69F9::
    ret

Jump_031_69FA::
    call Func_031_6DEC
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_031_6885
; no direct call (reached through a table, a jump or a vector)
Func_031_6885_Table2_Case02::
Jump_031_6A06:: ; address name
    call Func_031_6E67
    ret

; entry 4 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB, wBattleResolveStep
; points at: wBattleSubPhase
Func_031_67AA_Case04::
Jump_031_6A0A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call Func_031_6AAE
    call Func_031_6A2D
    call Func_031_6A92
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubPhase
    dec [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case04)
; reads: wD868, wD095, wD096, wD097, wD098, wD099, wD09A
Func_031_6A2D::
    ld a, [wD868]
    ld c, $56
    call SRAMRecordAddressMapped
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD095]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD096]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD097]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD098]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD099]
    call AddAToWordAtHL_Bank31_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD09A]
    call AddAToWordAtHL_Bank31_6A8B
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. Func_031_6A2D)
AddAToWordAtHL_Bank31_6A8B::
Func_031_6A8B:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case04)
; reads: wD868
; writes: wStringIndex, wStringCategory
Func_031_6A92::
    ld a, [wD868]
    ld c, $56
    call SRAMRecordAddressMapped
    ld a, [hl+]
    cp a, [hl]
    ret c
    ld a, $0A
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case04)
; reads: wD868
; points at: wD09D
Func_031_6AAE::
    ld a, [wD868]
    ld c, $34
    call SRAMRecordAddressMapped
    ld de, wD09D
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
; points at: sA000, wBattleSubPhase
Func_031_67AA_Case05::
Jump_031_6AC2:: ; address name
    call Func_031_6AFE
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
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
    call z, Func_031_6B2E

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

; 1 call site from 1 routine (e.g. Func_031_67AA_Case05)
; reads: wDA6B, wDA6C, wDA6D, wC7C7
; writes: wDA6B, wDA6C, wDA6D
Func_031_6AFE::
    ld a, [wDA6B]
    ld l, a
    ld a, [wDA6C]
    ld h, a
    ld a, [wDA6D]
    ld e, a
    ld a, [wC7C7]
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
    ld [wDA6B], a
    ld a, h
    ld [wDA6C], a
    ld a, e
    ld [wDA6D], a
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case05)
; reads: wDA6B, wDA6C, wDA6D
Func_031_6B2E::
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
    ld a, [wDA6B]
    add a, c
    ld c, a
    ld a, [wDA6C]
    adc a, b
    ld b, a
    ld a, [wDA6D]
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
; writes: rRAMG, rRAMB, wD869
; points at: sA000, wBattleSubPhase
Func_031_67AA_Case06::
Jump_031_6B65:: ; address name
    ld hl, sA000
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
    call Func_031_6D28
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
    ld [wD869], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG, rRAMB
; points at: wBattleSubPhase
Func_031_67AA_Case07::
Jump_031_6BAC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    farcall Func_01A_6418
    call Func_031_6BCA
    call Func_031_6C2F
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case07)
; reads: wD869, wD095, wD096, wD097, wD098, wD099, wD09A
Func_031_6BCA::
    ld a, [wD869]
    ld c, $56
    call SRAMRecordAddress
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD095]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD096]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD097]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD098]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD099]
    call AddAToWordAtHL_Bank31
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD09A]
    call AddAToWordAtHL_Bank31
    ret

; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. Func_031_6BCA)
AddAToWordAtHL_Bank31::
Func_031_6C28:: ; address name
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case07)
; reads: wD869
Func_031_6C2F::
    ld a, [wD869]
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
Func_031_67AA_Case08::
Jump_031_6C5E:: ; address name
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 9 of the `rst $00` table in Func_031_67AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
Func_031_67AA_Case09::
Jump_031_6C67:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_031_6C2F_Case00
    dw Func_031_6C2F_Case01
    dw Func_031_6C2F_Case02

; entry 0 of the `rst $00` table in Func_031_6C2F
; no direct call (reached through a table, a jump or a vector)
; reads: wC82C, wD88F, wD093
; writes: wD093, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep, wBattleStep
Func_031_6C2F_Case00::
Jump_031_6C71:: ; address name
    ld a, [wC82C]
    cp a, $05
    jr c, Jump_031_6C93
    ld a, [wD88F]
    cp a, $01
    jr nz, Jump_031_6C93
    ld a, [wD093]
    or a, a
    jr z, Jump_031_6C93
    cp a, $AA
    jr nz, Jump_031_6C8E
    ld a, $8F
    ld [wD093], a

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

; entry 1 of the `rst $00` table in Func_031_6C2F
; no direct call (reached through a table, a jump or a vector)
; reads: wD093, wC6FE, hFFC6
; writes: hFFC6, rRAMG, rRAMB, wBattleSubPhase, wBattleResolveStep, wStringCategory, wStringIndex
; points at: wD09D, wBattleStep, wC140, wC130, wBattleResolveStep
Func_031_6C2F_Case01::
Jump_031_6CA0:: ; address name
    ld a, [wD093]
    ldh [hFFC6], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC6FE]
    ld c, $34
    call SRAMRecordAddress
    ld de, wD09D
    ld b, $08

Jump_031_6CBB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6CBB
    farcall Func_01A_631A
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_031_6CD2
    xor a, a
    ld [rRAMG], a
    jr Jump_031_6C93

Jump_031_6CD2::
    ld l, a
    ld h, $04
    ld de, wC140
    call CopyStringHLToDE
    ld a, [wC6FE]
    ld c, $01
    call SRAMRecordAddress
    ld d, h
    ld e, l
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    ld a, [wC6FE]
    ld c, $34
    call SRAMRecordAddress
    ld de, wD09D
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
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_031_6C2F
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleStep
Func_031_6C2F_Case02::
Jump_031_6D17:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    jp Jump_031_6C93

; no direct call (reached through a table, a jump or a vector)
Func_031_6D1F:: ; heuristic: follows a terminator; C0
    push hl
    ld c, $4E
    call Multiply8
    pop bc
    add hl, bc
    ret

; 2 call sites from 2 routines (e.g. Func_031_67AA_Case06, Func_031_6885_Case00)
; reads: wD00F, hFFC8, hFFC9, hFFCA
; writes: rRAMG, rRAMB, hFFC7, wSpeciesIdLo, wSpeciesIdHi, hFFC6
Func_031_6D28::
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
    ldh [hFFC7], a
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
    ld a, [wD00F]
    ldh [hFFC6], a
    farcall Func_019_7380
    pop hl
    ldh a, [hFFC8]
    sub a, [hl]
    ld e, a
    inc hl
    ldh a, [hFFC9]
    sbc a, [hl]
    ld d, a
    inc hl
    ldh a, [hFFCA]
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

; 1 call site from 1 routine (e.g. Func_031_6885_Case01)
; points at: wC130
Func_031_6D87::
    ld de, wC130
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

; 1 call site from 1 routine (e.g. Func_031_6885_Case01)
; reads: wD095, wD096, wD097, wD098, wD099, wD09A
; points at: wC140, wC150, wC154, wC158, wC15C, wC160, wC164
Func_031_6D96::
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    inc a
    ld hl, wC140
    call WriteDecimalByteString
    ld a, [wD095]
    ld hl, wC150
    call WriteDecimalByteString
    ld a, [wD096]
    ld hl, wC154
    call WriteDecimalByteString
    ld a, [wD097]
    ld hl, wC158
    call WriteDecimalByteString
    ld a, [wD098]
    ld hl, wC15C
    call WriteDecimalByteString
    ld a, [wD099]
    ld hl, wC160
    call WriteDecimalByteString
    ld a, [wD09A]
    ld hl, wC164
    call WriteDecimalByteString
    ret

; 6 call sites from 6 routines (e.g. Func_031_67AA_Case00, Func_031_6885_Case01, Func_031_6885_Table2_Case01, Func_031_6E67_Case05, ...)
; writes: wStringCategory, wStringIndex
Func_031_6DDD::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ret

; 1 call site from 1 routine (e.g. Func_031_6885_Table2_Case01)
; writes: rRAMG, rRAMB
; points at: sA000
Func_031_6DEC::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld b, $00

Jump_031_6DFA::
    ld a, [hl]
    or a, a
    jr z, Jump_031_6E05
    push hl
    push bc
    call Func_031_6E18
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

; 1 call site from 1 routine (e.g. Func_031_6DEC)
Func_031_6E18::
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
    call nz, Func_031_6E30
    pop bc
    pop hl
    dec c
    jr nz, Jump_031_6E22
    ret

; 1 call site from 1 routine (e.g. Func_031_6E18)
; points at: wD0D9
Func_031_6E30::
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
    ld de, wD0D9
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
    ld de, wD0D9
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

; 1 call site from 1 routine (e.g. Func_031_6885_Table2_Case02)
; reads: wBattleSubStep
Func_031_6E67::
    ld a, [wBattleSubStep]
    rst $00
    dw Func_031_6E67_Case00
    dw Func_031_6E67_Case01
    dw Func_031_6E67_Case02
    dw Func_031_6E67_Case03
    dw Func_031_6E67_Case04
    dw Func_031_6E67_Case05
    dw Func_031_6E67_Case06

; entry 0 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wCFD6, wCFD7, wCFD5, wCFD3, wC46B
; points at: wBattleSubPhase, wScreenTileBuffer, wBattleSubStep
Func_031_6E67_Case00::
Jump_031_6E79:: ; address name
    call Func_031_7064
    cp a, $09
    jr nc, Jump_031_6ECA
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    farcall Func_031_71F5
    farcall CopyRectRecordForWD88F_Bank31
    farcall Func_031_7389
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
    ld [wCFD6], a
    ld a, $04
    call DivideBByA
    cp a, $00
    jr nz, Jump_031_6EDB
    dec b

Jump_031_6EDB::
    ld a, b
    ld [wCFD7], a
    xor a, a
    ld [wCFD5], a
    ld a, $03
    ld [wCFD3], a
    ld hl, $0506
    call Func_031_6DDD
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wC46B], a
    ret

; entry 1 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD868, wCFD7
; writes: rRAMG, rRAMB, wC2A9
; points at: wC3A2, wC1A0, wC2B8, wBattleSubStep
Func_031_6E67_Case01::
Jump_031_6EF7:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call FillWC278WithC3_Bank31
    call DrawWC278RowsToBGMapRow7
    call Func_031_7096
    farcall Func_01A_72C9
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD868]
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wC3A2
    call WriteDecimalDigitTiles
    xor a, a
    ld [rRAMG], a
    ld a, [wCFD7]
    add a, $E1
    ld [wC2A9], a
    call Func_031_7105
    ld de, wC1A0
    ld hl, vBGMap0 + $8
    ld bc, $0C09
    call CopyRect32StrideToVRAM
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    call Func_031_71B6
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCFD5, wC46B, wJoypadPressedRepeat
; points at: wC46B, wD09D, wC150, wBattleSubStep, wCFD5
Func_031_6E67_Case02::
Jump_031_6F57:: ; address name
    ld de, Data_031_63BD
    ld hl, wC46B
    call Func_031_5F9E
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_031_6F91
    ld a, $69
    call QueueSoundEffect
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wC46B]
    and a, $0F
    add a, b
    ld hl, wD09D
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $04
    ld de, wC150
    call CopyStringHLToDE
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_031_6F91::
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_031_6F9C
    call Func_031_719E
    ret

Jump_031_6F9C::
    ld a, [wJoypadPressedRepeat]
    and a, $30
    ret z
    ld hl, wCFD5
    res 7, [hl]
    call Func_031_7096
    call Func_031_719E
    call Func_031_71B6
    ret

; entry 3 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wC46B
; points at: wC338, wBattleSubStep
Func_031_6E67_Case03::
Jump_031_6FB1:: ; address name
    ld a, [wC46B]
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
    ld de, wC338
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ld hl, $0508
    call Func_031_6DDD
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC307, wC46C
; points at: wC2A6, wBattleSubStep
Func_031_6E67_Case04::
Jump_031_6FE9:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_01A_72DB
    ld a, $BB
    ld [wC307], a
    ld hl, vBGMap0 + $10E
    ld de, wC2A6
    ld bc, $0605
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wC46C], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46C, wCFD5, wC46B
; writes: wBattleSubStep
; points at: wC46C, wD09D, wBattleSubStep
Func_031_6E67_Case05::
Jump_031_700F:: ; address name
    ld de, Data_031_63C5
    ld hl, wC46C
    call Func_031_5F02
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_031_704E
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46C]
    bit 0, a
    jr nz, Jump_031_7054
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wC46B]
    and a, $0F
    add a, b
    ld hl, wD09D
    add_a_to_hl
    ld [hl], $FF
    ld hl, $0509
    call Func_031_6DDD
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

; entry 6 of the `rst $00` table in Func_031_6E67
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleSubStep
Func_031_6E67_Case06::
Jump_031_705A:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wBattleSubStep], a
    ret

; 1 call site from 1 routine (e.g. Func_031_6E67_Case00)
; points at: wD0D9, wD09D
Func_031_7064::
    ld hl, wD0D9
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld hl, wD09D
    ld de, wD0D9
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
    ld hl, wD09D
    ld de, wD0D9
    ld b, $38

Jump_031_708E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_708E
    pop af
    ret

; 2 call sites from 2 routines (e.g. Func_031_6E67_Case02, Func_031_6E67_Case01)
; reads: wCFD5
; writes: wC52F, wC530, wC52D, wC52E, wStringIndex, wStringCategory
; points at: wD09D
Func_031_7096::
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld hl, wD09D
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret

Data_031_70FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $95, $50, $96, $E0, $96, $70, $97

; 2 call sites from 2 routines (e.g. Func_031_719E, Func_031_6E67_Case01)
; reads: wCFD5, wC46B, wRecordBuffer, wD868, wRecordBufferData
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory, wRecordBuffer, wCFED, ...
; points at: wD09D, wC39E
Func_031_7105::
    ld hl, vTiles2 + $260
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1203
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wCFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [wC46B]
    and a, $0F
    add a, b
    ld hl, wD09D
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
    ld [wCFED], a
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
    ld a, [wD868]
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
    ld de, wC39E
    call WriteDecimalDigitTiles
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret

; 2 call sites from 1 routine (e.g. Func_031_6E67_Case02)
; points at: wC39E
Func_031_719E::
    call Func_031_7105
    ld hl, vBGMap0 + $206
    ld de, wC39E
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; 2 call sites from 2 routines (e.g. Func_031_6E67_Case02, Func_031_6E67_Case01)
; reads: wCFD5
Func_031_71B6::
    ld a, [wCFD5]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte
    ret

; 1 call site from 1 routine (e.g. Func_031_67AA_Case03)
; reads: wSoundChannelSlots, wD2CE
; writes: wD2CE
; points at: wDC01, wDC20, wDC40, wDC60, wDC80, wDCA0
Func_031_71C4::
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wD2CE]
    dec a
    ld [wD2CE], a
    ret nz
    ret

; 6 call sites from 6 routines (e.g. Func_031_47C7, Func_031_46C1_Case00, Func_016_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wIsCGB
; writes: rVBK
; points at: wScreenTileBuffer
Func_031_71F5::
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
; 39 call sites from 22 routines (e.g. RunBattleSetup_Case03, RunBattleSetup_Table2_Case0D, RunBattleSetup_Table2_Case07, RunBattleSetup_Table2_Case03, ...)
; points at: wC278
FillWC278WithC3_Bank31::
Func_031_722A:: ; address name
    ld hl, wC278
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
; reads: wD88F, wC57F
; writes: wC8CF, wC8D0, wC8D1, wC8D2, wC8D3, wC8D4
; points at: wC8CF
GameMode4_Init_Sub01_Sub02_Sub02::
Func_031_7239:: ; address name
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld [wC8D2], a
    ld [wC8D3], a
    ld a, $F0
    ld [wC8D4], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld a, [wC57F]
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
    ld de, wC8CF
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
; 5 call sites from 5 routines (e.g. Func_031_47C7, Func_031_46C1_Case00, Func_016_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wD88F
CopyRectRecordForWD88F_Bank31::
Func_031_72AC:: ; address name
    ld a, [wD88F]
    dec a
    ld hl, Data_031_72C3
    add a, a
    add_a_to_hl
    deref_hl
    call ReadScreenBufferRectHeader_Bank31
    call CopyRectToStride32_Bank31
    ret

Data_031_72C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7C, $75, $B8, $75, $1E, $76

; FillWC278WithC3_Bank31, then falls into LayoutTileBlocksForWD890Count (E-0071)
; 16 call sites from 10 routines (e.g. RunBattleSetup_BankA0_Table2_Case00, RunBattleSetup_BankA0_Table2_Case02, RunBattleSetup_BankA0_Table2_Case07, Func_0A0_5F2E_Case02, ...)
; reads: wD890
; points at: wC285
ClearAndLayoutTileBlocksForWD890Count::
Func_031_72C9:: ; address name
    call FillWC278WithC3_Bank31

; wD890 = count 1-3: writes that many 6 x 6 blocks of consecutive tile numbers, starting at $14 ($24 per block), into the 32-byte-wide buffer at wC278 (row 0); left columns are 7 for one block, 4 and 10 for two, 1, 7 and 13 for three (centred in a 20-column view). Clobbers A, BC, D, HL (E-0060)
; 41 call sites from 24 routines (e.g. Func_031_47C7, RunBattleSetup_Case03, RunBattleSetup_Table2_Case0D, RunBattleSetup_Table2_Case07, ...)
; reads: wD890
; points at: wC285
LayoutTileBlocksForWD890Count::
Func_031_72CC:: ; address name
    ld d, $14
    ld a, [wD890]
    dec a
    ld hl, Data_031_7317
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForWD890Count_Sub01
    ld a, [wD890]
    cp a, $01
    jr z, Jump_031_7316
    dec a
    dec a
    ld hl, Data_031_731D
    add a, a
    add_a_to_hl
    call LayoutTileBlocksForWD890Count_Sub01
    ld a, [wD890]
    cp a, $03
    jr nz, Jump_031_7316
    ld hl, wC285
    jr Jump_031_7302

; only called from LayoutTileBlocksForWD890Count (E-0047)
; 2 call sites from 1 routine (e.g. LayoutTileBlocksForWD890Count)
LayoutTileBlocksForWD890Count_Sub01::
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

Data_031_7317:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $C2, $7C, $C2, $79, $C2

Data_031_731D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $C2, $7F, $C2

; 4 call sites from 4 routines (e.g. Func_031_47C7, Func_031_46C1_Table2_Case00, Func_016_733F, GameMode4_Init_Sub01_Sub02)
; reads: wIsCGB, wC57F, wD890
; points at: wD960, wBattleMonsterId
Func_031_7321::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [wC57F]
    bit 1, a
    ld de, wD960
    jr z, Jump_031_7333
    ld de, wBattleMonsterId

Jump_031_7333::
    ld a, [wD890]
    cp a, $01
    jr z, Jump_031_7340
    cp a, $02
    jr z, Jump_031_7349
    jr Jump_031_735C

Jump_031_7340::
    ld c, $01
    ld hl, vBGMap0 + $E7
    call Func_031_7379
    ret

Jump_031_7349::
    ld c, $01
    ld hl, vBGMap0 + $E4
    call Func_031_7379
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $EA
    call Func_031_7379
    ret

Jump_031_735C::
    ld c, $01
    ld hl, vBGMap0 + $E1
    call Func_031_7379
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $E7
    call Func_031_7379
    ld c, $05
    inc de
    inc de
    ld hl, vBGMap0 + $ED
    call Func_031_7379
    ret

; 6 call sites from 1 routine (e.g. Func_031_7321)
; writes: hFFC6
Func_031_7379::
    push de
    ld a, c
    ldh [hFFC6], a
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

; 5 call sites from 5 routines (e.g. Func_031_47C7, Func_031_46C1_Case00, Func_016_733F, GameMode4_Init_Sub01_Sub02, ...)
; reads: wD88F
Func_031_7389::
    call Func_031_739F
    ld a, [wD88F]
    cp a, $01
    ret z
    call Func_031_73BE
    ld a, [wD88F]
    cp a, $02
    ret z
    call Func_031_73DD
    ret

; 1 call site from 1 routine (e.g. Func_031_7389)
; reads: wC58A, wC57F
Func_031_739F::
    ld c, $00
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_73B4
    cp a, $02
    jr z, Jump_031_73B4
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_73B4
    ld c, $04

Jump_031_73B4::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

; 1 call site from 1 routine (e.g. Func_031_7389)
; reads: wC58A, wC57F
Func_031_73BE::
    ld c, $01
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_73D3
    cp a, $02
    jr z, Jump_031_73D3
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_73D3
    ld c, $05

Jump_031_73D3::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

; 1 call site from 1 routine (e.g. Func_031_7389)
; reads: wC58A, wC57F
Func_031_73DD::
    ld c, $02
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_73F2
    cp a, $02
    jr z, Jump_031_73F2
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_73F2
    ld c, $06

Jump_031_73F2::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD88F
Func_031_73FC:: ; heuristic: follows a terminator; C0
    call Func_031_7412
    ld a, [wD88F]
    cp a, $01
    ret z
    call Func_031_7431
    ld a, [wD88F]
    cp a, $02
    ret z
    call Func_031_7450
    ret

; 1 call site from 1 routine (e.g. Func_031_73FC)
; reads: wC58A, wC57F
Func_031_7412::
    ld c, $00
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_7427
    cp a, $02
    jr z, Jump_031_7427
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_7427
    ld c, $04

Jump_031_7427::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

; 1 call site from 1 routine (e.g. Func_031_73FC)
; reads: wC58A, wC57F
Func_031_7431::
    ld c, $01
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_7446
    cp a, $02
    jr z, Jump_031_7446
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_7446
    ld c, $05

Jump_031_7446::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

; 1 call site from 1 routine (e.g. Func_031_73FC)
; reads: wC58A, wC57F
Func_031_7450::
    ld c, $02
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_7465
    cp a, $02
    jr z, Jump_031_7465
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_031_7465
    ld c, $06

Jump_031_7465::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

; 13 call sites from 13 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, Func_031_47C7, Func_031_46C1_Case00, ...)
Func_031_746F::
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ret

; copies a 20 x 5 rectangle from wC338 (rows 32 bytes apart) to vBGMap0 + $1A0 (row 13) with CopyRect32StrideToVRAM (E-0073)
; 13 call sites from 13 routines (e.g. RunBattleSetup_Table2_Case0F, RunBattleSetup_Table2_Case0B, RunBattleSetup_Table2_Case08, RunBattleSetup_Table2_Case07, ...)
; points at: wC338
DrawWC338RowsToBGMapRow13::
Func_031_7479:: ; address name
    ld de, wC338
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call CopyRect32StrideToVRAM
    ret

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Table2_Case07, RunBattleSetup_Table2_Case01)
; points at: wC338
RunBattleSetup_Shared01::
Func_031_7486:: ; address name
    farcall Func_01A_727D

; only called from routines of RunBattleSetup (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_Table2_Case04, RunBattleSetup_Table2_Case02)
; points at: wC338
RunBattleSetup_Shared02::
Func_031_748C:: ; address name
    ld de, wC338
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call CopyRect32StrideToVRAM
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case00)
Func_031_7499::
    farcall Func_01A_7284
    ret

; 4 call sites from 4 routines (e.g. RunBattleSetup_Table2_Case0D, Func_031_4EB9_Case04, Func_031_4EB9_Case03, Func_031_4EB9_Case01)
; points at: wC278
Func_031_74A0::
    ld de, wC278
    ld hl, vBGMap0 + $E0
    ld bc, $0C0B
    call CopyRect32StrideToVRAM
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case04)
Func_031_74AD::
    farcall Func_01A_7292
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (identical to DrawWC2B8LeftToBGMapRow9 at $74E1) (E-0078)
; 5 call sites from 5 routines (e.g. Func_031_4EB9_Case10, Func_031_4EB9_Case0C, Func_031_4EB9_Case08, Func_031_4EB9_Case07, ...)
; points at: wC2B8
DrawWC2B8LeftToBGMapRow9_74B4::
Func_031_74B4:: ; address name
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Table2_Case00)
Func_031_74C1::
    farcall Func_01A_72A0
    ret

; copies a 20 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9) with CopyRect32StrideToVRAM, then wD868 = 1 (E-0077)
; 6 call sites from 5 routines (e.g. Func_031_4EB9_Table2_Case10, Func_031_4EB9_Table2_Case04, Func_031_4EB9_Table2_Case03, Func_031_4EB9_Table2_Case02, ...)
; writes: wD868
; points at: wC2B8
DrawWC2B8RowsToBGMapRow9::
Func_031_74C8:: ; address name
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wD868], a
    ret

; 1 call site from 1 routine (e.g. Func_031_645E)
Func_031_74DA::
    farcall Func_01A_72A7
    ret

; copies an 8 x 9 rectangle from wC2B8 (rows 32 bytes apart) to vBGMap0 + $120 (row 9, column 0) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. Func_031_4EB9_Case1B, Func_031_4EB9_Case19, Func_031_4EB9_Table2_Case0F, Func_031_4EB9_Table2_Case0B, ...)
; points at: wC2B8
DrawWC2B8LeftToBGMapRow9::
Func_031_74E1:: ; address name
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Table2_Case04)
Func_031_74EE::
    farcall Func_01A_72AE
    ret

; 2 call sites from 2 routines (e.g. Func_031_4EB9_Table2_Case07, Func_031_4EB9_Table2_Case05)
; points at: wC2F8
Func_031_74F5::
    ld de, wC2F8
    ld hl, vBGMap0 + $160
    ld bc, $0807
    call CopyRect32StrideToVRAM
    ret

; 1 call site from 1 routine (e.g. Func_031_4EB9_Case10)
Func_031_7502::
    farcall Func_01A_72B5
    ret

; 4 call sites from 4 routines (e.g. Func_031_4EB9_Case1A, Func_031_4EB9_Case14, Func_031_4EB9_Case13, Func_031_4EB9_Case11)
; points at: wC2A4, wC2B8
Func_031_7509::
    ld de, wC2A4
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call CopyRect32StrideToVRAM
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM
    ret

; 3 call sites from 3 routines (e.g. Func_031_4EB9_Case1C, Func_031_4EB9_Case0C, Func_031_4EB9_Table2_Case0C)
Func_031_7522::
    farcall Func_01A_72C2
    ret

; copies a 14 x 7 rectangle from wC2F8 (rows 32 bytes apart) to vBGMap0 + $160 (row 11) with CopyRect32StrideToVRAM (E-0078)
; 5 call sites from 5 routines (e.g. Func_031_4EB9_Case1F, Func_031_4EB9_Case1D, Func_031_4EB9_Case0F, Func_031_4EB9_Case0D, ...)
; points at: wC2F8
DrawWC2F8RectToBGMapRow11::
Func_031_7529:: ; address name
    ld de, wC2F8
    ld hl, vBGMap0 + $160
    ld bc, $0E07
    call CopyRect32StrideToVRAM
    ret

; copies a 20 x 11 rectangle from wC278 (rows 32 bytes apart) to vBGMap0 + $E0 (row 7), falling into CopyRect32StrideToVRAM (E-0075)
; 8 call sites from 8 routines (e.g. BattlePhase0_Step1, BattleEnd_Step0, RunBattleSetup_Case03, RunBattleSetup_Table2_Case01, ...)
; points at: wC278
DrawWC278RowsToBGMapRow7::
Func_031_7536:: ; address name
    ld de, wC278
    ld hl, vBGMap0 + $E0
    ld bc, $140B

; B = width, C = rows, DE = source with 32-byte rows, HL = VRAM address with 32-byte rows: copies a B x C rectangle with WriteVRAMByteInc. DE ends 32 * C past its start and HL at the start of the row below; B kept, C = 0 (E-0060)
; 18 call sites from 15 routines (e.g. Func_031_47A9, DrawWC338RowsToBGMapRow13, Func_031_74A0, RunBattleSetup_Table2_Case0C, ...)
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
; 1 call site from 1 routine (e.g. CopyRectRecordForWD88F_Bank31)
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
; 1 call site from 1 routine (e.g. CopyRectRecordForWD88F_Bank31)
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
    INCBIN "dwm2-cobi-us.gbc", $0C757C, $A7
    ds $12, $B1
    db $B2, $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB
    db $DC, $DD, $DE, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3
    db $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $EA, $AF, $C3, $C3, $C3, $C3
    db $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

; 7 call sites from 6 routines (e.g. Func_031_73DD, Func_031_73BE, Func_031_739F, Func_031_6885_Case00, ...)
; reads: wC58A, wC57F
; points at: wBattleStatus
Func_031_76AE::
    ld a, [wC58A]
    cp a, $02
    jr nz, Jump_031_76BC
    farcall Func_0A0_6A45
    ret

Jump_031_76BC::
    push bc
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_76D1
    ld a, [wC57F]
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
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_031_7726
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a, a
    jr z, Jump_031_7710
    call Func_031_773C
    bit 0, [hl]
    call nz, Func_031_7757
    bit 1, [hl]
    call nz, Func_031_7762
    bit 4, [hl]
    call nz, Func_031_7778
    bit 5, [hl]
    call nz, Func_031_774C
    bit 6, [hl]
    call nz, Func_031_7783
    bit 7, [hl]
    call nz, Func_031_776D
    jr Jump_031_773A

Jump_031_7710::
    call Func_031_78B8
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add_a_to_hl
    call Func_031_7797
    ld [hl], $C3
    jr Jump_031_773A

Jump_031_7726::
    call Func_031_78B8
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add_a_to_hl
    call Func_031_7797
    ld [hl], $C2

Jump_031_773A::
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_773C::
    push hl
    ld hl, Data_031_779B
    call Func_031_778E
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_774C::
    push hl
    ld hl, Data_031_779B
    call Func_031_778E
    ld [hl], $C0
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_7757::
    push hl
    ld hl, Data_031_77A7
    call Func_031_778E
    ld [hl], $C1
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_7762::
    push hl
    ld hl, Data_031_77A7
    call Func_031_778E
    ld [hl], $C7
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_776D::
    push hl
    ld hl, Data_031_77AD
    call Func_031_778E
    ld [hl], $C8
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_7778::
    push hl
    ld hl, Data_031_77A1
    call Func_031_778E
    ld [hl], $C9
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_031_76AE)
Func_031_7783::
    push hl
    ld hl, Data_031_77B3
    call Func_031_778E
    ld [hl], $CA
    pop hl
    ret

; 7 call sites from 7 routines (e.g. Func_031_776D, Func_031_7783, Func_031_774C, Func_031_7778, ...)
Func_031_778E::
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Func_031_7797
    inc h

; 2 call sites from 1 routine (e.g. Func_031_76AE)
Func_031_7797::
    deref_hl
    ret

Data_031_779B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $39, $C2, $3F, $C2, $45, $C2

Data_031_77A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $C2, $40, $C2, $46, $C2

Data_031_77A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3B, $C2, $41, $C2, $47, $C2

Data_031_77AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $C2, $42, $C2, $48, $C2

Data_031_77B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3D, $C2, $43, $C2, $49, $C2

; 7 call sites from 6 routines (e.g. Func_031_6885_Case00, Func_031_7450, Func_031_7431, Func_031_7412, ...)
; reads: wC58A, wC57F
; points at: wScreenTileBuffer
Func_031_77B9::
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_77D8
    cp a, $02
    jr nz, Jump_031_77CA
    farcall Func_0A0_6B1E
    ret

Jump_031_77CA::
    ld a, [wC57F]
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
    ld hl, Data_031_7ADA
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

; 6 call sites from 5 routines (e.g. Func_031_73DD, Func_031_73BE, Func_031_739F, Func_03A_66A9, ...)
; reads: wC58A, wC57F
; points at: wBattleHP, wScreenTileBuffer
Func_031_7806::
    ld a, [wC58A]
    cp a, $02
    jr nz, Jump_031_7814
    farcall Func_0A0_6B46
    ret

Jump_031_7814::
    push bc
    or a, a
    jr z, Jump_031_7826
    ld a, [wC57F]
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

; 6 call sites from 5 routines (e.g. Func_031_73DD, Func_031_73BE, Func_031_739F, Func_03A_66A9, ...)
; reads: wC58A, wC57F
; points at: wBattleMP, wScreenTileBuffer
Func_031_785F::
    ld a, [wC58A]
    cp a, $02
    jr nz, Jump_031_786D
    farcall Func_0A0_6B79
    ret

Jump_031_786D::
    push bc
    or a, a
    jr z, Jump_031_787F
    ld a, [wC57F]
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

; 2 call sites from 1 routine (e.g. Func_031_76AE)
; reads: wC58A, wC57F
; points at: wScreenTileBuffer, wD8B7
Func_031_78B8::
    ld a, [wC58A]
    cp a, $02
    jr nz, Jump_031_78C6
    farcall Func_0A0_6BB3
    ret

Jump_031_78C6::
    push bc
    or a, a
    jr z, Jump_031_78D8
    ld a, [wC57F]
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
    ld hl, wD8B7
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

; 6 call sites from 5 routines (e.g. Func_031_7450, Func_031_7431, Func_031_7412, Func_03A_66A9, ...)
; reads: wC58A, wC57F
; points at: wScreenTileBuffer
Func_031_7914::
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_7933
    cp a, $02
    jr nz, Jump_031_7925
    farcall Func_0A0_6BF0
    ret

Jump_031_7925::
    ld a, [wC57F]
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

; 6 call sites from 5 routines (e.g. Func_031_7450, Func_031_7431, Func_031_7412, Func_03A_66A9, ...)
; reads: wC58A, wC57F
; points at: wScreenTileBuffer
Func_031_7965::
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_7984
    cp a, $02
    jr nz, Jump_031_7976
    farcall Func_0A0_6C22
    ret

Jump_031_7976::
    ld a, [wC57F]
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

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F
; points at: wScreenTileBuffer
Func_031_79B6:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    or a, a
    jr z, Jump_031_79D5
    cp a, $02
    jr nz, Jump_031_79C7
    farcall Func_0A0_6C54
    ret

Jump_031_79C7::
    ld a, [wC57F]
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
; 7 call sites from 6 routines (e.g. RunBattleSetup_Table2_Case01, Func_031_4EB9_Case18, Func_031_4EB9_Case04, Func_031_4EB9_Case00, ...)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
ShowStringBank09AtTilesHL_Bank31::
Func_031_7A02:: ; address name
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes appear in 2 banks)
; 7 call sites from 7 routines (e.g. Func_031_6331, Func_031_6324, Func_031_6315, Func_031_6306, ...)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
ShowStringBank08AtTilesHL_Bank31::
Func_031_7A3D:: ; address name
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0C7A78, $50

Data_031_7AC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $00, $68, $00, $6E, $00

Data_031_7ACE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $00, $88, $00, $8E, $00

Data_031_7AD4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $A7, $00, $AD, $00

Data_031_7ADA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C7ADA, $114

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 7 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_Table2_Case09_Sub01)
; points at: wD80F
CheckSlotStatusBlockWide_Bank31::
Func_031_7BEE:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
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

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
SlotHasStatus3Or4Bits_Bank31:: ; heuristic: follows a terminator; C0
Func_031_7C0D:: ; address name
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_7C1C
    ld a, [hl]
    and a, $0C

Jump_031_7C1C::
    pop hl
    ret

; LZSS-compressed asset: 477 bytes expand to 704 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_031_7C1E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $0C7C1E, $1DD

; LZSS-compressed asset: 151 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_031_7DFB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $0C7DFB, $97
    ds $16E, $00
