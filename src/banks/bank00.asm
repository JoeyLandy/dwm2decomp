SECTION "Bank 00", ROM0[$0000]

; C2 static reading (E-0007): rst $00 pops its return address as the base of an inline word table, indexes it by A (entry = base + 2*A), preserves DE, and jumps to the entry.
; no direct call (reached through a table, a jump or a vector)
JumpTable::
Func_000_0000:: ; address name
    pop hl
    push de
    ld e, a
    ld d, $00
    sla e
    rl d
    add hl, de
    pop de

; HL = address of a word: HL = that word, then jumps to it (falls into JumpToHL); A = its low byte (E-0061)
; 7 call sites from 7 routines (e.g. CallFlagBitHandlerE, DispatchActionEffectTable, RunEffectHandlerForActionId, ChooseActionTarget, ...)
JumpToWordAtHL::
Func_000_000B:: ; address name
    deref_hl

; jp hl; the call target used by CallInBank
; 5 call sites from 5 routines (e.g. CallInBank, AIRunNextChoice, AIChooseActionResolveStep, AIChooseActionForActor, ...)
JumpToHL::
Func_000_000E:: ; address name
    jp hl
    db $00

; C2 static reading (E-0007): rst $10 selects ROM bank B, calls the code at HL, then restores the caller's bank (saved from $4000, which holds each bank's own number, E-0006).
; no direct call (reached through a table, a jump or a vector)
; writes: rROMB0
CallInBank::
Func_000_0010:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    call JumpToHL
    pop af
    ld [rROMB0], a
    ret
    ds $10, $00

; the rst $30 vector: a bare ret (unused restart) (E-0114)
; no direct call (reached through a table, a jump or a vector)
Rst30Vector::
Func_000_0030:: ; address name
    ret
    db $00, $00, $00, $00, $00, $00, $00

; the rst $38 vector: a bare ret (unused restart) (E-0114)
; no direct call (reached through a table, a jump or a vector)
Rst38Vector::
Func_000_0038:: ; address name
    ret
    db $00, $00, $00, $00, $00, $00, $00

; di; jp VBlankHandler (the interrupt vector at $0040)
; no direct call (reached through a table, a jump or a vector)
; reads: rSVBK, rVBK, wIsCGB, wFadeState, wBGPaletteUploadRequest, wOBJPaletteUploadRequest, wLinkMode, wTextFlags, ...
; writes: rSVBK, wBGPaletteUploadRequest, wOBJPaletteUploadRequest, wFrameCounterLo, wFrameCounterHi, rVBK, wVBlankLY, wGameMode, ...
; points at: wVBlankFlags, wBGPaletteUploadRequest, wGameMode, wScreenShakeTimer
VBlankVector::
Func_000_0040:: ; address name
    di
    jp VBlankHandler
    db $00, $00, $00, $00

; the LCD STAT interrupt vector ($0048): jumps to the handler at Jump_000_256A (E-0114)
; no direct call (reached through a table, a jump or a vector)
; reads: rSVBK, wSTATSplitEnable
; writes: rSVBK
StatInterruptVector::
Func_000_0048:: ; address name
    jp Jump_000_256A
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; the serial-transfer interrupt vector ($0058): jumps to the handler at Jump_000_255B (E-0114)
; no direct call (reached through a table, a jump or a vector)
SerialInterruptVector::
Func_000_0058:: ; address name
    jp Jump_000_255B
    db $D9
    ds $24, $00

; copies the 10 bytes at $008E (ld a,$C0 / ldh [rDMA],a / wait / ret) to HRAM at $FF80
; 1 call site from 1 routine (e.g. BootAndMainLoop)
InstallOamDmaRoutine::
Func_000_0080:: ; address name
    ld c, $80
    ld b, $0A
    ld hl, $008E

Jump_000_0087::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_0087
    ret

; the OAM DMA routine copied to HRAM: starts DMA from $C000 (ld a, $C0; ldh [rDMA], a) and waits $28 loop iterations; never called in place (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: rDMA
OamDmaRoutineTemplate:: ; heuristic: follows a terminator; C0
Func_000_008E:: ; address name
    ld a, $C0
    ldh [rDMA], a
    ld a, $28

Jump_000_0094::
    dec a
    jr nz, Jump_000_0094
    ret
    ds $68, $00

; the cartridge entry point ($0100): nop, then jp Func_000_0150 (E-0114)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wLinkMode, wModeChangeRequest, wFadeState
; writes: wIsCGB, rVBK, wGameMode, rRAMB, rRAMG, rROMB0, rROMB1, wSGBActive, ...
; points at: wGameMode, wScreenShakeTimer
ROMEntryPoint::
Func_000_0100:: ; address name
    nop
    jp BootAndMainLoop
    INCBIN "dwm2-cobi-us.gbc", $000104, $4C

; entry after the header jump: wIsCGB = 1 when A was $11 at power-on; disables interrupts, sets the stack, clears RAM, installs the OAM DMA routine, clears VRAM, sets game mode 5 and the MBC banks, then runs the main loop (E-0131)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wLinkMode, wModeChangeRequest, wFadeState
; writes: wIsCGB, rVBK, wGameMode, rRAMB, rRAMG, rROMB0, rROMB1, wSGBActive, ...
; points at: wGameMode, wScreenShakeTimer
BootAndMainLoop::
Func_000_0150:: ; address name
    cp a, $11
    ld a, $00
    jr nz, Jump_000_0157
    inc a

Jump_000_0157::
    ld [wIsCGB], a

Jump_000_015A::
    di
    ld sp, wStackTop
    call DisableVBlankTimerSerialJoypadInterrupts
    call ClearWRAMHRAMAndSRAMBanks0And2
    call InstallOamDmaRoutine
    ld hl, vTiles0
    ld bc, $1C00
    xor a, a
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_0189
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0800
    xor a, a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

Jump_000_0189::
    ld hl, wGameMode
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $05
    ld [wGameMode], a
    ld a, $00
    ld [rRAMB], a
    ld a, $00
    ld [rRAMG], a
    ld a, $01
    ld [rROMB0], a
    ld a, $00
    ld [rROMB1], a
    ld a, $01
    ld [wSGBActive], a
    ld a, $FF
    ld [wMusicRequest], a
    ld [wSoundEffectRequest], a
    call InitSoundHardware
    xor a, a
    ld [wLinkReady], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_01D3
    xor a, a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rRP], a
    farcall LoadPalette0FromData4322
    jr Jump_000_01D8

Jump_000_01D3::
    call DetectSGB
    jr c, Jump_000_01DF

Jump_000_01D8::
    xor a, a
    ld [wSGBActive], a
    jp Jump_000_02D1

Jump_000_01DF::
    ld bc, $000C
    call DelayBCWhenSGB
    ld a, $14
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $02
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $03
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $04
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $05
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $06
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $07
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $08
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $09
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $0C
    ld bc, $0800
    ld e, $6C
    ld d, $44
    ld h, $17
    call SGBTransferRaw
    call SpinDelay
    ld a, $0D
    ld e, LOW(Data_017_448C)
    ld d, HIGH(Data_017_448C)
    ld b, BANK(Data_017_448C)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $12
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $0A
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $13
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $0E
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $01
    ld [wSGBActive], a
    ld a, $FF
    ld [wSGBBorderSet], a
    xor a, a
    ld [wSGBPaletteSet], a
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

Jump_000_02D1::
    ei

Jump_000_02D2::
    call ClearBGMapOrFillWithC3
    call ClearShadowOAM
    call SetDefaultDMGPaletteBytes
    call ClearScrollPositions
    call ResetFadeFromDMGPaletteBGP
    xor a, a
    ld [wSerialReceived], a
    ld [wTextFlags], a
    ld [wTextWindowRows], a
    ld [wTextWindowWidth], a
    call RunGameModeInit
    xor a, a
    ld [wModeChangeRequest], a
    ld [wFieldInitStage], a
    ld [wBootFlagEE], a
    ld [wBGWriteDestLo], a
    ld [wBGWriteDestHi], a
    ld [wAttrWriteDestLo], a
    ld [wAttrWriteDestHi], a
    ld [wVBlankFlags], a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wLinkFrameCounterLo], a
    ld [wLinkFrameCounterHi], a
    ld hl, wScreenShakeTimer
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0324::
    ld a, [wLinkMode]
    or a, a
    call z, NextTableByte
    halt
    nop
    ld a, [wModeChangeRequest]
    or a, a
    jr z, Jump_000_0324
    ld a, [wFadeState]
    or a, a
    jr z, Jump_000_033D
    bit 7, a
    jr z, Jump_000_0324

Jump_000_033D::
    di
    call DisableVBlankTimerSerialJoypadInterrupts
    call SpinDelay
    ld a, $00
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    jp Jump_000_02D2

; jumps through a 9-entry table indexed by wGameMode to the mode's start-up routine (banks $01, $02, $03, none, $31, $07, $24, $A0, $F2); called from the main loop each time the mode changes
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wGameMode
RunGameModeInit::
Func_000_0355:: ; address name
    ld a, [wGameMode]
    rst $00
    dw RunGameModeInit_Case00
    dw RunGameModeInit_Case01
    dw RunGameModeInit_Case02
    dw RunGameModeInit_Case03
    dw RunGameModeInit_Case04
    dw RunGameModeInit_Case05
    dw RunGameModeInit_Case06
    dw RunGameModeInit_Case07
    dw RunGameModeInit_Case08

; entry 0 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case00::
Jump_000_036B:: ; address name
    farcall GameMode0_Init
    ret

; entry 1 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case01::
Jump_000_0372:: ; address name
    farcall GameMode1_Init
    ret

; entry 2 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case02::
Jump_000_0379:: ; address name
    farcall GameMode2_Init
    ret

; entry 3 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case03::
Jump_000_0380:: ; address name
    ret

; entry 4 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case04::
Jump_000_0381:: ; address name
    farcall GameMode4_Init
    ret

; entry 5 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case05::
Jump_000_0388:: ; address name
    farcall GameMode5_Init
    ret

; entry 6 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case06::
Jump_000_038F:: ; address name
    farcall GameMode6_Init
    ret

; entry 7 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case07::
Jump_000_0396:: ; address name
    farcall GameMode7_Init
    ret

; entry 8 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Case08::
Jump_000_039D:: ; address name
    farcall GameMode8_Init
    ret

; runs once per frame: saves registers and the VRAM and WRAM banks; skips everything but the sound tick when wC5ED bit 0 shows it was entered again; otherwise runs the OAM DMA routine at $FF80, uploads queued palettes on CGB, flushes the queued BG map write, restores the DMG palettes, scroll and LCDC, applies the screen shake, polls the joypad, runs SoundTick, advances the random seed, processes the sound queue, runs GameFrameUpdate, steps the string display when wC52B is set, steps the fade, and increments the 16-bit frame counter wC5F0/wC5F1; resets the game when all four buttons are held
; no direct call (reached through a table, a jump or a vector)
; reads: rSVBK, rVBK, wIsCGB, wFadeState, wBGPaletteUploadRequest, wOBJPaletteUploadRequest, wLinkMode, wTextFlags, ...
; writes: rSVBK, wBGPaletteUploadRequest, wOBJPaletteUploadRequest, wFrameCounterLo, wFrameCounterHi, rVBK, wVBlankLY, wGameMode, ...
; points at: wVBlankFlags, wBGPaletteUploadRequest, wGameMode, wScreenShakeTimer
VBlankHandler::
Jump_000_03A4:: ; address name
    push af
    push bc
    push de
    push hl
    ldh a, [rSVBK]
    ld b, a
    ld a, $00
    ldh [rSVBK], a
    push bc
    ldh a, [rVBK]
    push af
    ld hl, wVBlankFlags
    bit 0, [hl]
    jp nz, Jump_000_046B
    set 0, [hl]
    call $FF80
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_03EA
    ld a, [wFadeState]
    or a, a
    jr nz, Jump_000_03EA
    ld hl, wBGPaletteUploadRequest
    ld a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_000_03EA
    ld a, [wBGPaletteUploadRequest]
    or a, a
    call nz, UploadBGPalettes
    xor a, a
    ld [wBGPaletteUploadRequest], a
    ld a, [wOBJPaletteUploadRequest]
    or a, a
    call nz, VBlankHandler_Sub01
    xor a, a
    ld [wOBJPaletteUploadRequest], a

Jump_000_03EA::
    call FlushQueuedBGMapWrite
    call CopyDMGPalettesToHardware
    call CopyScrollToHardware
    call ApplyScreenShake
    call WriteLCDCShadow
    ld a, [wLinkMode]
    and a, a
    jr nz, Jump_000_042E
    ei
    call PollJoypad
    call UpdateJoypadPresses
    call SoundTick
    call NextRandomSeed
    call ProcessSoundQueue
    call GameFrameUpdate
    ld a, [wTextFlags]
    or a, a
    call nz, StepStringDisplayUntilDone
    call StepFade
    ld a, [wFrameCounterLo]
    add a, $01
    ld [wFrameCounterLo], a
    ld a, [wFrameCounterHi]
    adc a, $00
    ld [wFrameCounterHi], a
    jr Jump_000_043A

Jump_000_042E::
    call SoundTick
    ei
    call ProcessSoundQueue
    call GameFrameUpdate
    jr Jump_000_043A

Jump_000_043A::
    ld a, [wFadeState]
    or a, a
    jr nz, Jump_000_0456
    ld a, [wJoypadHeld]
    and a, $0F
    cp a, $0F
    jr nz, Jump_000_0450
    ld a, [wLinkMode]
    or a, a
    jp z, Jump_000_015A

Jump_000_0450::
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_000_0456

Jump_000_0456::
    ld hl, wVBlankFlags
    res 0, [hl]

Jump_000_045B::
    pop af
    ldh [rVBK], a
    ldh a, [rLY]
    ld [wVBlankLY], a
    pop af
    ldh [rSVBK], a
    pop hl
    pop de
    pop bc
    pop af
    reti

Jump_000_046B::
    call WriteLCDCShadow
    call SoundTick
    ei
    jr Jump_000_045B

; hOamNextEntry = 0, ComputeSpriteScrollOffsets, RunGameModeUpdate, and ClearUnusedOAMEntries unless a fade is running
; 2 call sites from 1 routine (e.g. VBlankHandler)
; reads: wFadeState
; writes: hOamNextEntry
GameFrameUpdate::
Func_000_0474:: ; address name
    xor a, a
    ldh [hOamNextEntry], a
    call ComputeSpriteScrollOffsets
    call RunGameModeUpdate
    ld a, [wFadeState]
    or a, a
    jr z, Jump_000_0486
    bit 7, a
    ret z

Jump_000_0486::
    call ClearUnusedOAMEntries
    ret

; unless wC5DF is non-zero or a fade is running: jumps through a 9-entry table indexed by wGameMode to the mode's per-frame routine (modes 0-8 in banks $01, $02, $03, none, $31, $07, $24, $A0, $F2)
; 1 call site from 1 routine (e.g. GameFrameUpdate)
; reads: wModeChangeRequest, wLinkMode, wFadeState, wGameMode
RunGameModeUpdate::
Func_000_048A:: ; address name
    ld a, [wModeChangeRequest]
    or a, a
    ret nz
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_000_049E
    ld a, [wFadeState]
    or a, a
    jr z, Jump_000_049E
    bit 7, a
    ret z

Jump_000_049E::
    ld a, [wGameMode]
    rst $00
    dw RunGameModeUpdate_Case00
    dw RunGameModeUpdate_Case01
    dw RunGameModeUpdate_Case02
    dw RunGameModeUpdate_Case03
    dw RunGameModeUpdate_Case04
    dw RunGameModeUpdate_Case05
    dw RunGameModeUpdate_Case06
    dw RunGameModeUpdate_Case07
    dw RunGameModeUpdate_Case08

; entry 0 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case00::
Jump_000_04B4:: ; address name
    farcall GameMode0_Update
    ret

; entry 1 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case01::
Jump_000_04BB:: ; address name
    farcall GameMode1_Update
    ret

; entry 2 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case02::
Jump_000_04C2:: ; address name
    farcall GameMode2_Update
    ret

; entry 3 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case03::
Jump_000_04C9:: ; address name
    ret

; entry 4 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case04::
Jump_000_04CA:: ; address name
    farcall GameMode4_Update
    ret

; entry 5 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case05::
Jump_000_04D1:: ; address name
    farcall GameMode5_Update
    ret

; entry 6 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case06::
Jump_000_04D8:: ; address name
    farcall GameMode6_Update
    ret

; entry 7 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case07::
Jump_000_04DF:: ; address name
    farcall GameMode7_Update
    ret

; entry 8 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Case08::
Jump_000_04E6:: ; address name
    farcall GameMode8_Update
    ret

; while wC604 or wC605 is non-zero, counts it down and adds an oscillating offset (from the counter's low bits) to rSCY or rSCX
; 1 call site from 1 routine (e.g. VBlankHandler)
; reads: wScreenShakeTimer, rSCY, wScreenShakeOffset, rSCX
; writes: wScreenShakeTimer, rSCY, wScreenShakeOffset, rSCX
; points at: wScreenShakeTimer
ApplyScreenShake::
Func_000_04ED:: ; address name
    ld hl, wScreenShakeTimer
    ld b, [hl]
    inc hl
    or a, [hl]
    ret z
    ld a, [wScreenShakeTimer]
    or a, a
    jr z, Jump_000_0511
    dec a
    ld [wScreenShakeTimer], a
    ldh a, [rSCY]
    ld b, a
    ld a, [wScreenShakeTimer]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_050E
    xor a, $07

Jump_000_050E::
    add a, b
    ldh [rSCY], a

Jump_000_0511::
    ld a, [wScreenShakeOffset]
    or a, a
    jr z, Jump_000_0530
    dec a
    ld [wScreenShakeOffset], a
    ldh a, [rSCX]
    ld b, a
    ld a, [wScreenShakeOffset]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_052B
    xor a, $07

Jump_000_052B::
    sub a, $04
    add a, b
    ldh [rSCX], a

Jump_000_0530::
    ret
    db $CD, $CC, $0B, $C9

; in link mode: counts frames (resetting the game after an overflow), saves the joypad state and starts the next serial transfer of the queued byte or the joypad (E-0128)
; 8 call sites from 8 routines (e.g. GameMode5_Update_Case04, GameMode5_Update_Case03, GameMode5_Update_Case02, RunLinkScreenState_6C12_Case08_Case04, ...)
; reads: wLinkMode, wLinkFrameCounterLo, wLinkFrameCounterHi, wLinkRole, wLinkSession, wVBlankFlags, wJoypadHeld, wJoypadHeldPrev, ...
; writes: wLinkFrameCounterLo, wLinkFrameCounterHi, wLinkSavedJoypadHeld, wLinkSavedJoypadHeldPrev, wLinkExchangeState, wLinkTimeoutLo, wLinkTimeoutHi, rVBK, ...
; points at: wLinkBufferCountLo, wGameMode, wScreenShakeTimer
LinkExchangeJoypadPerFrame::
Func_000_0535:: ; address name
    ld a, [wLinkMode]
    or a, a
    ret z
    ld a, [wLinkFrameCounterLo]
    add a, $01
    ld [wLinkFrameCounterLo], a
    ld a, [wLinkFrameCounterHi]
    adc a, $00
    ld [wLinkFrameCounterHi], a
    or a, a
    jp nz, Jump_000_015A
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld a, [wLinkSession]
    cp a, $05
    jr nz, Jump_000_0563
    ld a, [wVBlankFlags]
    bit 1, a
    ret nz
    jr Jump_000_057C

Jump_000_0563::
    ld a, [wVBlankFlags]
    bit 1, a
    jr nz, Jump_000_0574
    bit 2, a
    jr nz, Jump_000_0574
    bit 7, a
    jr nz, Jump_000_0574
    jr Jump_000_057C

Jump_000_0574::
    xor a, a
    ld [wLinkSavedJoypadHeld], a
    ld [wLinkSavedJoypadHeldPrev], a
    ret

Jump_000_057C::
    ld a, [wJoypadHeld]
    ld [wLinkSavedJoypadHeld], a
    ld a, [wJoypadHeldPrev]
    ld [wLinkSavedJoypadHeldPrev], a
    call PollJoypad
    ld a, [wLinkSendByte]
    cp a, $FF
    jr z, Jump_000_059D
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, [wLinkSendByte]
    jp StartSerialTransferInternalClock

Jump_000_059D::
    ld hl, wLinkBufferCountLo
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_000_05C7
    ld a, [wLinkTimeoutLo]
    ld l, a
    ld a, [wLinkTimeoutHi]
    ld h, a
    push hl
    ld a, [wLinkTimeoutLo]
    add a, $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    adc a, $00
    ld [wLinkTimeoutHi], a
    pop hl
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, [hl]
    jp StartSerialTransferInternalClock

Jump_000_05C7::
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, $F0
    jp StartSerialTransferInternalClock

; returns at once if wC524 is zero, otherwise counts DE from $1B58 to 0 with three nops per step
; 44 call sites from 15 routines (e.g. BootAndMainLoop, DetectSGB, StepFade_Sub01, ClearSGBPacketBuffer_Sub01, ...)
; reads: wSGBActive
SpinDelay::
Func_000_05D1:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld de, $1B58

Jump_000_05D9::
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, Jump_000_05D9
    ret

; sends packet set $0B, reads rP1 with two different line selections and returns carry set when the joypad lines change as a Super Game Boy makes them; sends packet set $0A afterwards in both outcomes
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: rP1
; writes: wSGBPacketIndex, rP1
DetectSGB::
Func_000_05E2:: ; address name
    ld a, $0B
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ldh a, [rP1]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ld a, $30
    ldh [rP1], a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ld a, $30
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $0A
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    sub a, a
    ret

Jump_000_0636::
    ld a, $0A
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    scf
    ret

; only called from PollJoypad (E-0047)
; 1 call site from 1 routine (e.g. PollJoypad)
; reads: rP1
; writes: rP1
; points at: wSGBJoypad1
PollJoypad_Sub01::
Func_000_0646:: ; address name
    ldh a, [rP1]
    ld b, $04
    ld c, a
    jr Jump_000_0651

Jump_000_064D::
    ldh a, [rP1]
    cp a, c
    ret z

Jump_000_0651::
    cpl
    and a, $03
    sla a
    ld d, $00
    ld e, a
    ld hl, wSGBJoypad1
    add hl, de
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    swap a
    ld d, a
    ld a, $30
    ldh [rP1], a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    or a, d
    ld d, a
    ld a, [hl+]
    xor a, d
    and a, d
    ld [hl-], a
    ld a, d
    ld [hl], a
    ld a, $30
    ldh [rP1], a
    dec b
    jr nz, Jump_000_064D
    ret

; returns at once when wSGBActive is 0; otherwise busy-waits BC times about $06D6 loop passes
; 5 call sites from 3 routines (e.g. BootAndMainLoop, SGBTransferCompressed, SGBTransferRaw)
; reads: wSGBActive
DelayBCWhenSGB::
Func_000_0692:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z

Jump_000_0697::
    ld de, $06D6

Jump_000_069A::
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, Jump_000_069A
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0697
    ret

; A = packet set index (stored in wSGBPacketIndex); returns at once when wSGBActive is 0; otherwise turns the LCD off, clears vTiles1, decompresses the stream at HL into vTiles1, fills the 20 x 13 corner of vBGMap0 with tiles $80, $81, ... in order, turns the LCD on, sends the packet set with SendSGBPacketSet and turns it off again; the tile data is thereby shown for the Super Game Boy to read
; 16 call sites from 2 routines (e.g. BootAndMainLoop, LoadSGBBorderForSetA)
; reads: wSGBActive
; writes: wSGBPacketIndex, rSCX, rSCY, rBGP, rLCDC, wLCDCShadow
SGBTransferCompressed::
Func_000_06A8:: ; address name
    ld [wSGBPacketIndex], a
    ld a, [wSGBActive]
    or a, a
    ret z
    push bc
    call TurnOffLCD
    call ClearScrollPositions
    xor a, a
    ldh [rSCX], a
    ldh [rSCY], a
    push de
    ld hl, vTiles1
    ld bc, $1000
    xor a, a
    call FillBytes
    pop de
    ld a, $E4
    ldh [rBGP], a
    pop bc
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vBGMap0
    ld de, $000C
    ld a, $80
    ld c, $0D

Jump_000_06DD::
    ld b, $14

Jump_000_06DF::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_000_06DF
    add hl, de
    dec c
    jr nz, Jump_000_06DD
    ld a, $81
    ldh [rLCDC], a
    ld [wLCDCShadow], a
    ld bc, $0005
    call DelayBCWhenSGB
    farcall SendSGBPacketSet
    ld bc, $0006
    call DelayBCWhenSGB
    call TurnOffLCD
    ret

; A = packet set index; H = ROM bank, DE = source, BC = byte count: the same as SGBTransferCompressed, but copies the bytes to vTiles1 instead of decompressing
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wSGBActive
; writes: wSGBPacketIndex, rSCX, rSCY, rBGP, rROMB0, rLCDC, wLCDCShadow
SGBTransferRaw::
Func_000_0705:: ; address name
    ld [wSGBPacketIndex], a
    ld a, [wSGBActive]
    or a, a
    ret z
    push hl
    push bc
    call TurnOffLCD
    call ClearScrollPositions
    xor a, a
    ldh [rSCX], a
    ldh [rSCY], a
    ld a, $E4
    ldh [rBGP], a
    pop bc
    pop hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    push bc
    ld a, h
    ld [rROMB0], a
    pop bc
    ld hl, vTiles1

Jump_000_072D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_072D
    ld hl, vBGMap0
    ld de, $000C
    ld a, $80
    ld c, $0D

Jump_000_073F::
    ld b, $14

Jump_000_0741::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_000_0741
    add hl, de
    dec c
    jr nz, Jump_000_073F
    ld a, $81
    ldh [rLCDC], a
    ld [wLCDCShadow], a
    ld bc, $0005
    call DelayBCWhenSGB
    farcall SendSGBPacketSet
    ld bc, $0006
    call DelayBCWhenSGB
    call TurnOffLCD
    pop af
    ld [rROMB0], a
    ret

; zero-fills the 16 bytes of wSGBPacketBuffer; BC, HL kept (E-0108)
; 5 call sites from 3 routines (e.g. StepFade_Sub01, StartPaletteFade, SendSGBPaletteSetPacket)
; points at: wSGBPacketBuffer
ClearSGBPacketBuffer::
Func_000_076B:: ; address name
    push hl
    push bc
    xor a, a
    ld hl, wSGBPacketBuffer
    ld c, $10

Jump_000_0773::
    ld [hl+], a
    dec c
    jr nz, Jump_000_0773
    pop bc
    pop hl
    ret

Jump_000_077A::
    push af
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_000_0784
    call ClearSGBPacketBuffer_Sub02

Jump_000_0784::
    call ClearSGBPacketBuffer_Sub01
    pop af
    call ClearSGBPacketBuffer_Shared01
    ei
    ret

; clears rIF and masks rIE with $E2 (keeps LCD STAT and the unused high bits); falls through (E-0122)
; 2 call sites from 1 routine (e.g. BootAndMainLoop)
; reads: rIE, rLY
; writes: rIF, rIE
; points at: wLCDCShadow
DisableVBlankTimerSerialJoypadInterrupts::
Func_000_078D:: ; address name
    xor a, a
    ldh [rIF], a
    ldh a, [rIE]
    and a, $E2
    ldh [rIE], a

; if rLCDC bit 7 is set, waits for rLY = $91, then clears rLCDC bit 7 and bit 7 of wC5EC
; 4 call sites from 2 routines (e.g. SGBTransferCompressed, SGBTransferRaw)
; reads: rLY
; points at: wLCDCShadow
TurnOffLCD::
Func_000_0796:: ; address name
    ld hl, rLCDC
    bit 7, [hl]
    ret z

Jump_000_079C::
    ldh a, [rLY]
    cp a, $91
    jr nz, Jump_000_079C
    res 7, [hl]
    ld hl, wLCDCShadow
    res 7, [hl]
    ret

; only called from ClearSGBPacketBuffer (E-0047)
; 1 call site from 1 routine (e.g. ClearSGBPacketBuffer)
; reads: wSGBActive
; writes: rLCDC, wSGBPacketIndex
; points at: wLCDCShadow
ClearSGBPacketBuffer_Sub01::
Func_000_07AA:: ; address name
    ld hl, wLCDCShadow
    set 7, [hl]
    ld a, [hl]
    ldh [rLCDC], a
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, $01
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ret
    db $C9, $AF, $E0, $0F, $F0, $FF, $E6, $F7, $E0, $FF, $C9

; waits until rSC bit 7 (transfer in progress) clears (E-0108)
; 3 call sites from 2 routines (e.g. ClearSGBPacketBuffer_Sub02, Func_01B_4001_Case00)
; reads: rSC
WaitSerialTransferDone::
Func_000_07D1:: ; address name
    ldh a, [rSC]
    bit 7, a
    jr nz, WaitSerialTransferDone
    ret

; only called from routines of ClearSGBPacketBuffer (E-0098)
; 2 call sites from 2 routines (e.g. ClearSGBPacketBuffer, ClearSGBPacketBuffer_Sub02)
; writes: rIF, rIE
ClearSGBPacketBuffer_Shared01::
Func_000_07D8:: ; address name
    ld b, a
    xor a, a
    ldh [rIF], a
    ld a, b
    ldh [rIE], a
    ret

; rSCX = hScrollX, rSCY = hScrollY
; 3 call sites from 3 routines (e.g. VBlankHandler, RunGameMode2State_Case04, RunGameMode2State_Case01)
; reads: hScrollX, hScrollY, hWindowX, hWindowY
; writes: rSCX, rSCY, rWX, rWY
CopyScrollToHardware::
Func_000_07E0:: ; address name
    ldh a, [hScrollX]
    ldh [rSCX], a
    ldh a, [hScrollY]
    ldh [rSCY], a
    ldh a, [hWindowX]
    ldh [rWX], a
    ldh a, [hWindowY]
    ldh [rWY], a
    ret

; waits until rSTAT mode bits are 0, then rLCDC = wC5EC
; 2 call sites from 1 routine (e.g. VBlankHandler)
; reads: rSTAT, wLCDCShadow
; writes: rLCDC
WriteLCDCShadow::
Func_000_07F1:: ; address name
    ldh a, [rSTAT]
    and a, $03
    jr nz, WriteLCDCShadow
    ld a, [wLCDCShadow]
    ldh [rLCDC], a
    ret

; rBGP, rOBP0, rOBP1 = wC5E9, wC5EA, wC5EB
; 1 call site from 1 routine (e.g. VBlankHandler)
; writes: rBGP, rOBP0, rOBP1
; points at: wDMGPaletteBGP
CopyDMGPalettesToHardware::
Func_000_07FD:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, [hl+]
    ldh [rBGP], a
    ld a, [hl+]
    ldh [rOBP0], a
    ld a, [hl]
    ldh [rOBP1], a
    ret

; on CGB only: copies $40 bytes from DE in ROM bank B to HL, then writes $7F at HL + BC (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rROMB0
CopyCGB40BytesFromBankAndMark7F:: ; heuristic: follows a terminator; C0
Func_000_080A:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld b, $40

Jump_000_0819::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_000_0819
    ld b, $00
    add hl, bc
    ld [hl], $7F
    pop af
    ld [rROMB0], a
    ret

; when bit 7 of wC526 is set, writes 8 bytes (one palette) from a buffer address derived by Func_000_0897 to rBGPD starting at index wC526; otherwise writes all 64 bytes from wC49F to rBGPD from index 0; each byte is written after waiting for VRAM access
; 18 call sites from 15 routines (e.g. VBlankHandler, PauseMenu_State4, DrawRecordMonsterPictureForMenuSelectedMember, ExitPauseMenuToField, ...)
; reads: wBGPaletteUploadRequest
; writes: rBGPI
; points at: wBGPaletteBuffer
UploadBGPalettes::
Func_000_0829:: ; address name
    ld a, [wBGPaletteUploadRequest]
    bit 7, a
    jr z, Jump_000_0841
    ldh [rBGPI], a
    call HLFromABits3To5
    ld a, l
    add a, $9F
    ld l, a
    ld a, h
    adc a, $C4
    ld h, a
    ld b, $08
    jr Jump_000_084F

Jump_000_0841::
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rBGPI], a
    ei
    ld b, $40
    ld hl, wBGPaletteBuffer

Jump_000_084F::
    ld c, $69

Jump_000_0851::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [c], a
    ei
    dec b
    jr nz, Jump_000_0851
    ret

; only called from VBlankHandler (E-0047)
; 1 call site from 1 routine (e.g. VBlankHandler)
; reads: wOBJPaletteUploadRequest, rSTAT
; writes: rOBPI
; points at: wOBJPaletteBuffer
VBlankHandler_Sub01::
Func_000_085C:: ; address name
    ld a, [wOBJPaletteUploadRequest]
    bit 7, a
    jr z, Jump_000_0876
    ldh [rOBPI], a
    call HLFromABits3To5
    ld a, l
    add a, $DF
    ld l, a
    ld a, h
    adc a, $C4
    ld h, a
    ld e, l
    ld d, h
    ld b, $08
    jr Jump_000_0884

Jump_000_0876::
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld b, $40
    ld de, wOBJPaletteBuffer

Jump_000_0884::
    ld hl, rOBPD

Jump_000_0887::
    ld a, [de]
    inc de
    ld c, a
    di

Jump_000_088B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_088B
    ld [hl], c
    ei
    dec b
    jr nz, Jump_000_0887
    ret

; HL = A & $38 (bits 3-5), H = 0 (E-0119)
; 2 call sites from 2 routines (e.g. VBlankHandler_Sub01, UploadBGPalettes)
HLFromABits3To5::
Func_000_0897:: ; address name
    res 7, a
    and a, $38
    ld l, a
    ld h, $00
    ret

; rSTAT |= $40: selects the LY = LYC coincidence as an LCD STAT interrupt source (E-0114)
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
; writes: rSTAT
EnableLYCInterruptSource:: ; heuristic: follows a terminator; C0
Func_000_089F:: ; address name
    ldh a, [rSTAT]
    or a, $40
    ldh [rSTAT], a
    ret

; rSTAT &= $07: clears the LCD-status interrupt source bits 3-6, keeping the mode and coincidence flags (E-0108)
; 4 call sites from 4 routines (e.g. GameMode1_Init, GameMode5_Init, GameMode4_Init, GameMode7_Init)
; reads: rSTAT
; writes: rSTAT
ClearSTATInterruptSources::
Func_000_08A6:: ; address name
    ldh a, [rSTAT]
    and a, $07
    ldh [rSTAT], a
    ret

; with interrupts off, LoadSerialByte, then sets rSC bits 0 (internal clock) and 7 (start transfer) (E-0073)
; 3 call sites from 3 routines (e.g. ClearSGBPacketBuffer_Sub02_Sub02, ClearSGBPacketBuffer_Sub02_Sub01, GameMode5_Update_Case01_Case00)
StartSerialTransferInternalClock::
Func_000_08AD:: ; address name
    di
    call LoadSerialByte
    ld hl, rSC
    set 0, [hl]
    set 7, [hl]
    ei
    ret

; A is stored in rSB and rSC becomes $80 (transfer start, external clock); interrupts are off during the write
; 32 call sites from 23 routines (e.g. ClearSGBPacketBuffer_Sub02, ClearSGBPacketBuffer_Sub02_Sub02, ClearSGBPacketBuffer_Sub02_Sub01, GameMode5_Update_Case01_Case08, ...)
SerialSendByte::
Func_000_08BA:: ; address name
    di
    call LoadSerialByte
    ld hl, rSC
    res 0, [hl]
    set 7, [hl]
    ei
    ret

; rSC = 0, rSB = A
; 2 call sites from 2 routines (e.g. StartSerialTransferInternalClock, SerialSendByte)
; writes: rSC, rSB
LoadSerialByte::
Func_000_08C7:: ; address name
    ld b, a
    ld a, $00
    ldh [rSC], a
    ld a, b
    ldh [rSB], a
    ret

; on CGB resets VBK, SVBK, HDMA and palette index registers; clears $1E00 bytes of WRAM from wC000 and $74 bytes of HRAM from hFF8A (keeping wIsCGB); clears SRAM banks 2 and 0 (E-0125)
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wIsCGB
; writes: rVBK, rSVBK, rHDMA1, rHDMA2, rHDMA3, rHDMA4, rHDMA5, rBGPI, ...
; points at: wShadowOAM, hPlayerSpriteVariant, sRecords
ClearWRAMHRAMAndSRAMBanks0And2::
Func_000_08D0:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_08EC
    xor a, a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rHDMA1], a
    ldh [rHDMA2], a
    ldh [rHDMA3], a
    ldh [rHDMA4], a
    ldh [rHDMA5], a
    ldh [rBGPI], a
    ldh [rOBPI], a
    ld a, [wIsCGB]

Jump_000_08EC::
    push af
    ld hl, wShadowOAM
    ld bc, $1E00
    ld a, $00
    call FillBytes
    ld hl, hPlayerSpriteVariant
    ld bc, $0074
    ld a, $00
    call FillBytes
    pop af
    ld [wIsCGB], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $02
    ld [rRAMB], a
    xor a, a
    ld hl, sRecords
    ld bc, $2000
    call FillBytes
    ld a, $00
    ld [rRAMB], a
    xor a, a
    ld hl, sRecords
    ld bc, $2000
    call FillBytes
    ld a, $00
    ld [rRAMG], a
    ret

; fills vBGMap0 with $800 zero bytes; if wD066 is set, clears it and fills only $400 bytes with $C3 (E-0122)
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wBGFillFlag
; writes: wBGFillFlag
ClearBGMapOrFillWithC3::
Func_000_0930:: ; address name
    ld hl, vBGMap0
    ld bc, $0800
    ld a, [wBGFillFlag]
    or a, a
    jr z, Jump_000_0945
    xor a, a
    ld [wBGFillFlag], a
    ld bc, $0400
    ld a, $C3

Jump_000_0945::
    call FillBytes
    ret

; A = value, HL = destination, BC = count; HL ends past the last byte (memset)
; 155 call sites from 92 routines (e.g. BootAndMainLoop, ClearBGMapOrFillWithC3, SGBTransferCompressed, ClearWRAMHRAMAndSRAMBanks0And2, ...)
FillBytes::
Func_000_0949:: ; address name
    ld d, a

Jump_000_094A::
    ld [hl], d
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_094A
    ret

; HL = source, DE = destination, BC = count (memcpy)
; 47 call sites from 42 routines (e.g. RestoreScreenBufferFromBGMap1, SaveScreenBufferToBGMap1, WritePlayerNameWithFlag0SuffixToTextBuf0, RunFieldEventFieldEventKind_Case08_Sub01, ...)
CopyBytes::
Func_000_0952:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytes
    ret

; wC5E8 = (wC5E8 + 1) & $7F; wC5E7 = the byte at $0973 + wC5E8
; 47 call sites from 41 routines (e.g. BootAndMainLoop, AdvanceRandom, NextTableByteSecondStream, CreateMonsterRecordOfKindTemp1_Sub01_Sub01, ...)
; reads: wRandomHi
; writes: wRandomHi, wRandomLo
NextTableByte::
Func_000_095B:: ; address name
    push hl
    ld a, [wRandomHi]
    inc a
    and a, $7F
    ld [wRandomHi], a
    ld hl, $0973
    add_a_to_hl
    ld a, [hl]
    ld [wRandomLo], a
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $000973, $80

; 16-bit seed in wCD03/wCD04 becomes seed * 5 + 11
; 81 call sites from 51 routines (e.g. VBlankHandler, PickRandomEncounterCountdownFromTable478F, TickRandomEncounterCounter, RunBattleIntroKindCase_Case06, ...)
; reads: wKeyRandomLo, wKeyRandomHi
; writes: wKeyRandomLo, wKeyRandomHi
NextRandomSeed::
Func_000_09F3:: ; address name
    push hl
    push bc
    ld a, [wKeyRandomLo]
    ld l, a
    ld a, [wKeyRandomHi]
    ld h, a
    ld c, l
    ld b, h
    sla l
    rl h
    sla l
    rl h
    add hl, bc
    ld a, $0B
    add a, l
    ld [wKeyRandomLo], a
    ld a, h
    adc a, $00
    ld [wKeyRandomHi], a
    pop bc
    pop hl
    ret

; shifts wJoypadHeld to wJoypadHeldPrev and reads the new state into wJoypadHeld (directly, or through the SGB path when wSGBActive)
; 6 call sites from 4 routines (e.g. VBlankHandler, LinkExchangeJoypadPerFrame, LinkSendStepWithBuffer, LinkExchangeJoypadByte)
; reads: wSGBActive, wJoypadHeld, wSGBJoypad1, wLinkJoypadHeld, wSGBJoypad2
; writes: wJoypadHeldPrev, wJoypadHeld, wLinkJoypadHeldPrev, wLinkJoypadHeld, wJoypadReadFlag, rP1
PollJoypad::
Func_000_0A17:: ; address name
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_000_0A39
    call PollJoypad_Sub01
    ld a, [wJoypadHeld]
    ld [wJoypadHeldPrev], a
    ld a, [wSGBJoypad1]
    ld [wJoypadHeld], a
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, [wSGBJoypad2]
    ld [wLinkJoypadHeld], a
    ret

Jump_000_0A39::
    xor a, a
    ld [wJoypadReadFlag], a
    call ReadJoypadDirect
    ld a, [wJoypadHeld]
    ld [wJoypadHeldPrev], a
    ld a, b
    ld [wJoypadHeld], a
    ld a, $30
    ldh [rP1], a
    ret

; ReadJoypadDirect, then wC561 = the old wC560 and wC560 = B (the new reading); finally rP1 = $30 (deselects both key groups) (E-0114)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkJoypadHeld
; writes: wLinkJoypadHeldPrev, wLinkJoypadHeld, rP1
ReadJoypadIntoLinkJoypadHeld:: ; heuristic: follows a terminator; C0
Func_000_0A4F:: ; address name
    call ReadJoypadDirect
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, b
    ld [wLinkJoypadHeld], a
    ld a, $30
    ldh [rP1], a
    ret

; B = the buttons: upper nibble D-pad (bit 7 down, 6 up, 5 left, 4 right), lower nibble A, B, Select, Start (bits 0-3), 1 = pressed; reads rP1 with each line group selected
; 2 call sites from 2 routines (e.g. PollJoypad, ReadJoypadIntoLinkJoypadHeld)
; reads: rP1
; writes: rP1
ReadJoypadDirect::
Func_000_0A61:: ; address name
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    swap a
    ld b, a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    or a, b
    ld b, a
    ret

; wJoypadPressed = buttons newly held since the last poll; wJoypadPressedRepeat = the same, plus an auto-repeat that fires after $14 frames and then every 6 (timer in wJoypadRepeatTimer)
; 9 call sites from 5 routines (e.g. VBlankHandler, LinkReceiveStepWithBuffer, LinkSendStepWithBuffer, LinkReceiveJoypadByte, ...)
; reads: wLinkMode, wJoypadReadFlag, wJoypadPressed, wLinkJoypadPressed, wLinkJoypadHeld, wJoypadHeld
; writes: wLinkJoypadHeld, wLinkJoypadHeldPrev, wJoypadPressedRepeat, wJoypadPressed, wJoypadRepeatTimer, wLinkJoypadPressedRepeat, wLinkJoypadPressed, wLinkJoypadRepeatTimer
; points at: wJoypadHeld, wLinkJoypadHeld, wLinkJoypadRepeatTimer, wJoypadRepeatTimer
UpdateJoypadPresses::
Func_000_0A8D:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_000_0AA0
    ld a, [wJoypadReadFlag]
    or a, a
    jr nz, Jump_000_0AA0
    xor a, a
    ld [wLinkJoypadHeld], a
    ld [wLinkJoypadHeldPrev], a

Jump_000_0AA0::
    xor a, a
    ld [wJoypadPressedRepeat], a
    ld hl, wJoypadHeld
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [wJoypadPressed], a
    ld hl, wJoypadHeld
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AB9
    cp a, [hl]
    jr z, Jump_000_0AC6

Jump_000_0AB9::
    ld a, [wJoypadPressed]
    ld [wJoypadPressedRepeat], a
    ld a, $14
    ld [wJoypadRepeatTimer], a
    jr Jump_000_0AD6

Jump_000_0AC6::
    ld hl, wJoypadRepeatTimer
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0AD5
    ld [hl], $06
    ld a, [wJoypadHeld]
    ld [wJoypadPressedRepeat], a

Jump_000_0AD5::
    dec [hl]

Jump_000_0AD6::
    xor a, a
    ld [wLinkJoypadPressedRepeat], a
    ld hl, wLinkJoypadHeld
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [wLinkJoypadPressed], a
    ld hl, wLinkJoypadHeld
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AEF
    cp a, [hl]
    jr z, Jump_000_0AFC

Jump_000_0AEF::
    ld a, [wLinkJoypadPressed]
    ld [wLinkJoypadPressedRepeat], a
    ld a, $14
    ld [wLinkJoypadRepeatTimer], a
    jr Jump_000_0B0C

Jump_000_0AFC::
    ld hl, wLinkJoypadRepeatTimer
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0B0B
    ld [hl], $06
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadPressedRepeat], a

Jump_000_0B0B::
    dec [hl]

Jump_000_0B0C::
    ret

; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
; 5 call sites from 4 routines (e.g. RunLinkScreenSubStateSubState_5B14_Case07, RunLinkScreenSubStateSubState_5B14_Case01, Func_0E0_5AD3_Table2_Case00, RunDebugState_E0_Case0D_Case02_Sub01)
ReadWordTableEntry_Bank00::
Func_000_0B0D:: ; address name
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    deref_hl
    ret

; C2 static reading (E-0014): selects ROM bank B and copies C bytes from [DE] to [HL] (C = 0 copies 256), then restores the caller's bank.
; 24 call sites from 18 routines (e.g. LoadMonsterPicture, LoadPlayerAndFollowerSpriteGraphics_Sub01, LoadBGPaletteBufferFromBank, DecompressGraphicsTemp0ToTemp4, ...)
; writes: rROMB0
CopyFromBank::
Func_000_0B18:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B20::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0B20
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): like Func_000_0B18, but before each byte waits for STAT ($FF41) bit 1 to clear with interrupts disabled, so HL can be VRAM.
; 232 call sites from 116 routines (e.g. AcknowledgeTextPrompt_Sub01, CopyMonsterNameToBuffer_B01, DebugMessageTest_Init, DebugResultsDisplay_Init, ...)
; reads: rSTAT
; writes: rROMB0
CopyFromBankWaitVRAM::
Func_000_0B2B:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B33::
    di

Jump_000_0B34::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B34
    ld a, [de]
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_000_0B33
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): selects ROM bank B; C times reads a byte from [DE] (advancing DE once), waits for STAT bit 1 to clear, ORs the byte into [HL] and advances HL; then restores the caller's bank. Clobbers B.
; 17 call sites from 12 routines (e.g. DebugResultsDisplay_Init, DrawNameGlyphBufGlyphsOverlaying8DAnd8E, RunNameEntryStateWhenNotFading_Case01_Case04, ScriptCommandEB_Run_Case05_Case03_Sub01_Sub01, ...)
; reads: rSTAT
; writes: rROMB0
OrFromBankWaitVRAM::
Func_000_0B46:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B4E::
    di

Jump_000_0B4F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B4F
    ld a, [de]
    ld b, a
    inc de
    ei
    di

Jump_000_0B5A::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B5A
    ld a, [hl]
    or a, b
    ld [hl+], a
    ei
    dec c
    jr nz, Jump_000_0B4E
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): switches to the ROM bank held in $D7FE, reads the word at [HL] into B (low address) and C (next address), leaves HL unchanged, restores the caller's bank. $D7FE is therefore the data-bank variable for reads through HL; 30 call sites.
; 31 call sites from 19 routines (e.g. CopyMonsterNameToBuffer_B01, DrawKeyListPageNames, CopyMonsterNameToBuffer_B0D, ScriptFetchF5, ...)
; reads: wDataBank
; writes: rROMB0
ReadWordFromDataBank::
Func_000_0B6C:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wDataBank]
    ld [rROMB0], a
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

; wC5E9, wC5EA, wC5EB = $D2, $D2, $E2 (the DMG palette bytes the fade routines start from), copied to wD040-wD042 as well (E-0117)
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1
; points at: wDMGPaletteBGP, wDMGPaletteBytes
SetDefaultDMGPaletteBytes::
Func_000_0B7F:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ret

; writes 0 to the four bytes at hScrollX (StoreAFourTimesAtHL); falls through (E-0122)
; 3 call sites from 3 routines (e.g. BootAndMainLoop, SGBTransferCompressed, SGBTransferRaw)
; points at: hScrollX
ClearScrollPositions::
Func_000_0B9B:: ; address name
    xor a, a
    ld hl, hScrollX
    call StoreAFourTimesAtHL

; stores A at HL, HL+1, HL+2, HL+3; HL += 4 (E-0114)
; 1 call site from 1 routine (e.g. ClearScrollPositions)
StoreAFourTimesAtHL::
Func_000_0BA2:: ; address name
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

; hOamNextEntry = 0 and clears the $A0 bytes of shadow OAM at wC000 (E-0122)
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; writes: hOamNextEntry
; points at: wShadowOAM
ClearShadowOAM::
Func_000_0BA7:: ; address name
    xor a, a
    ldh [hOamNextEntry], a
    ld hl, wShadowOAM
    ld b, $A0

Jump_000_0BAF::
    ld [hl+], a
    dec b
    jr nz, Jump_000_0BAF
    ret

; zeroes the first byte (Y) of every OAM shadow entry from hOamNextEntry up to 40
; 1 call site from 1 routine (e.g. GameFrameUpdate)
; reads: hOamNextEntry
ClearUnusedOAMEntries::
Func_000_0BB4:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    ret z
    ld l, a
    sla l
    sla l
    ld h, $C0
    sub a, $28
    ld b, a
    xor a, a

Jump_000_0BC4::
    ld [hl+], a
    inc l
    inc l
    inc l
    inc b
    jr nz, Jump_000_0BC4
    ret

; if wC0C0/wC0C1 (a VRAM address) is non-zero, writes wC0C3 bytes from wC0C4 there: along the row when wC0C2 is 0, down the column otherwise
; 1 call site from 1 routine (e.g. VBlankHandler)
; reads: wBGWriteDestLo, wBGWriteDestHi, wBGWriteCount, wBGWriteVertical, wIsCGB, wAttrWriteDestLo, wAttrWriteDestHi, wAttrWriteCount, ...
; writes: wBGWriteDestLo, wBGWriteDestHi, rVBK, wAttrWriteDestLo, wAttrWriteDestHi
; points at: wBGWriteData, wAttrWriteData
FlushQueuedBGMapWrite::
Func_000_0BCC:: ; address name
    ld a, [wBGWriteDestLo]
    ld e, a
    ld a, [wBGWriteDestHi]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0BD9
    ret

Jump_000_0BD9::
    ld a, [wBGWriteCount]
    ld b, a
    ld hl, wBGWriteData
    ld a, [wBGWriteVertical]
    or a, a
    jr nz, Jump_000_0BF7
    ld a, e
    and a, $E0
    ld c, a

Jump_000_0BEA::
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, Jump_000_0BEA
    jr Jump_000_0C05

Jump_000_0BF7::
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_000_0C00
    inc d

Jump_000_0C00::
    res 2, d
    dec b
    jr nz, Jump_000_0BF7

Jump_000_0C05::
    xor a, a
    ld [wBGWriteDestLo], a
    ld [wBGWriteDestHi], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, [wAttrWriteDestLo]
    ld e, a
    ld a, [wAttrWriteDestHi]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0C22
    ret

Jump_000_0C22::
    ld a, [wAttrWriteCount]
    ld b, a
    ld hl, wAttrWriteData
    ld a, [wAttrWriteVertical]
    or a, a
    jr nz, Jump_000_0C40
    ld a, e
    and a, $E0
    ld c, a

Jump_000_0C33::
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, Jump_000_0C33
    jr Jump_000_0C4E

Jump_000_0C40::
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_000_0C49
    inc d

Jump_000_0C49::
    res 2, d
    dec b
    jr nz, Jump_000_0C40

Jump_000_0C4E::
    ld a, $00
    ldh [rVBK], a
    xor a, a
    ld [wAttrWriteDestLo], a
    ld [wAttrWriteDestHi], a
    ret

; C2 static reading (E-0016): takes the lock byte $FFD6 (spins while it is non-zero), calls Func_000_0C69, then clears the lock.
; 34 call sites from 21 routines (e.g. SGBTransferCompressed, GameMode5_Init_Case06, GameMode5_Init_Case04, GameMode5_Init_Case03, ...)
; reads: hDecompressLock
; writes: hDecompressLock
DecompressToRAMLocked::
Func_000_0C5A:: ; address name
    ldh a, [hDecompressLock]
    or a, a
    jr nz, DecompressToRAMLocked
    inc a
    ldh [hDecompressLock], a
    call DecompressToRAM
    xor a, a
    ldh [hDecompressLock], a
    ret

; C2 (E-0016: static reading; 141 emulated calls matched tools/lzss_gfx.py byte for byte): expands the compressed stream at [DE] in ROM bank B into memory at [HL] with a plain store per byte (RAM destination). Header and format: see Func_000_0DA8. Restores the caller's bank on return.
; 1 call site from 1 routine (e.g. DecompressToRAMLocked)
; reads: hDecompressRunCount, hDecompressRunByte, hDecompressDestLo, hDecompressDestHi, hDecompressHeader2, hDecompressHeader4, hDecompressHeader3, hDecompressHeader1
; writes: rROMB0, hDecompressRunByte, hDecompressRunCount
; points at: hDecompressMarker
DecompressToRAM::
Func_000_0C69:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    call DecompressReadHeader

Jump_000_0C70::
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp a, [hl]
    jr z, Jump_000_0C83
    pop hl
    ld [hl], a
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0C70
    jr Jump_000_0CF0

Jump_000_0C83::
    pop hl
    ld a, [de]
    ldh [hDecompressRunByte], a
    inc de
    ld a, [de]
    ldh [hDecompressRunCount], a
    inc de
    ldh a, [hDecompressRunCount]
    push af
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0C9B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0C9B::
    ldh [hDecompressRunCount], a
    pop af
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [hDecompressRunByte]
    ld e, a
    push hl
    ldh a, [hDecompressDestLo]
    ld l, a
    ldh a, [hDecompressDestHi]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl

Jump_000_0CB2::
    ldh a, [hDecompressHeader2]
    cp a, d
    jr z, Jump_000_0CBB
    jr c, Jump_000_0CC2
    jr Jump_000_0CDD

Jump_000_0CBB::
    ldh a, [hDecompressHeader1]
    cp a, e
    jr z, Jump_000_0CC2
    jr nc, Jump_000_0CDD

Jump_000_0CC2::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp a, d
    jr z, Jump_000_0CCF
    jr nc, Jump_000_0CD6
    jr Jump_000_0CDD

Jump_000_0CCF::
    ldh a, [hDecompressHeader3]
    cp a, e
    jr z, Jump_000_0CDD
    jr c, Jump_000_0CDD

Jump_000_0CD6::
    ld a, $10
    add a, d
    ld d, a
    xor a, a
    jr Jump_000_0CDE

Jump_000_0CDD::
    ld a, [de]

Jump_000_0CDE::
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, Jump_000_0CEF
    ldh a, [hDecompressRunCount]
    dec a
    ldh [hDecompressRunCount], a
    jr nz, Jump_000_0CB2
    pop de
    jr Jump_000_0C70

Jump_000_0CEF::
    pop de

Jump_000_0CF0::
    pop af
    ld [rROMB0], a
    ret

; C2 (E-0016): the same expansion as Func_000_0C69 but for VRAM destinations: each store waits for STAT ($FF41) bit 1 to clear with interrupts disabled, back-references read the already-written VRAM, and the lock byte $FFD6 is taken on entry and cleared on exit.
; 126 call sites from 74 routines (e.g. LoadMonsterPicture, LoadPlayerAndFollowerSpriteGraphics_Sub01, LoadMapScreen, LoadMapHeader, ...)
; reads: hDecompressLock, rSTAT, hVRAMByteTemp, hDecompressRunCount, hDecompressRunByte, hDecompressDestLo, hDecompressDestHi, hDecompressHeader2, ...
; writes: hDecompressLock, hVRAMByteTemp, rROMB0, hDecompressRunByte, hDecompressRunCount
; points at: hDecompressMarker
DecompressToVRAM::
Func_000_0CF5:: ; address name
    ldh a, [hDecompressLock]
    or a, a
    jr nz, DecompressToVRAM
    inc a
    ldh [hDecompressLock], a
    ld a, [BANK_NUMBER_BYTE]
    push af
    call DecompressReadHeader

Jump_000_0D04::
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp a, [hl]
    jr z, Jump_000_0D22
    pop hl
    ldh [hVRAMByteTemp], a
    di

Jump_000_0D11::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0D11
    ldh a, [hVRAMByteTemp]
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0D04
    jr Jump_000_0DA0

Jump_000_0D22::
    pop hl
    ld a, [de]
    ldh [hDecompressRunByte], a
    inc de
    ld a, [de]
    ldh [hDecompressRunCount], a
    inc de
    ldh a, [hDecompressRunCount]
    ldh [hVRAMByteTemp], a
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0D3B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0D3B::
    ldh [hDecompressRunCount], a
    ldh a, [hVRAMByteTemp]
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [hDecompressRunByte]
    ld e, a
    ldh a, [hDecompressDestLo]
    add a, e
    ld e, a
    ldh a, [hDecompressDestHi]
    adc a, d
    ld d, a

Jump_000_0D50::
    ldh a, [hDecompressHeader2]
    cp a, d
    jr z, Jump_000_0D59
    jr c, Jump_000_0D60
    jr Jump_000_0D84

Jump_000_0D59::
    ldh a, [hDecompressHeader1]
    cp a, e
    jr z, Jump_000_0D60
    jr nc, Jump_000_0D84

Jump_000_0D60::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp a, d
    jr z, Jump_000_0D6D
    jr nc, Jump_000_0D74
    jr Jump_000_0D84

Jump_000_0D6D::
    ldh a, [hDecompressHeader3]
    cp a, e
    jr z, Jump_000_0D84
    jr c, Jump_000_0D84

Jump_000_0D74::
    ld a, $10
    add a, d
    ld d, a
    di

Jump_000_0D79::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0D79
    xor a, a
    ld [hl+], a
    ei
    jr Jump_000_0D8E

Jump_000_0D84::
    di

Jump_000_0D85::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0D85
    ld a, [de]
    ld [hl+], a
    ei

Jump_000_0D8E::
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, Jump_000_0D9F
    ldh a, [hDecompressRunCount]
    dec a
    ldh [hDecompressRunCount], a
    jr nz, Jump_000_0D50
    pop de
    jp Jump_000_0D04

Jump_000_0D9F::
    pop de

Jump_000_0DA0::
    pop af
    ld [rROMB0], a
    xor a, a
    ldh [hDecompressLock], a
    ret

; C2 static reading (E-0016): selects ROM bank B, then reads the compressed-stream header from [DE]: u16 output size into BC, a marker byte into $FFBB. Saves the destination start (HL) in $FFBC/$FFBD and $FFC3/$FFC4 and the destination end (HL + size) in $FFC1/$FFC2.
; 2 call sites from 2 routines (e.g. DecompressToRAM, DecompressToVRAM)
; writes: rROMB0, hDecompressMarker, hDecompressDestLo, hDecompressHeader3, hDecompressDestHi, hDecompressHeader4, hDecompressHeader1, hDecompressHeader2
DecompressReadHeader::
Func_000_0DA8:: ; address name
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ldh [hDecompressMarker], a
    inc de
    ld a, l
    ldh [hDecompressDestLo], a
    ldh [hDecompressHeader3], a
    ld a, h
    ldh [hDecompressDestHi], a
    ldh [hDecompressHeader4], a
    push hl
    add hl, bc
    ld a, l
    ldh [hDecompressHeader1], a
    ld a, h
    ldh [hDecompressHeader2], a
    pop hl
    ret

; wC56F-wC571 = wC5E9-wC5EB; then clears wFadeLevel and the four bytes after it and wFadeState, and sets wC56D = 7 and wC56E = $1F (E-0090)
; 4 call sites from 4 routines (e.g. BootAndMainLoop, SendSGBFieldPaletteSet, ResetLinkScreenPalettes, ResetScreenPalettes_E0)
; reads: wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1
; writes: wFadeState, wFadeMode, wFadeMask
; points at: wFadeDMGPalettes, wFadeLevel
ResetFadeFromDMGPaletteBGP::
Func_000_0DCA:: ; address name
    ld hl, wFadeDMGPalettes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    jr Jump_000_0DDB

Jump_000_0DDB::
    xor a, a
    ld hl, wFadeLevel
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld [wFadeState], a
    ld a, $07
    ld [wFadeMode], a
    ld a, $1F
    ld [wFadeMask], a
    ret

; A = level (bit 7 set selects the second form); on CGB it hands over to Func_002_4001; on DMG it rebuilds the palette copy at wC4FF from wC4DF and sets wC56C, wC572-wC574, with $7FFF (white) or $0000 (black) fill chosen by bit 7 of wC56D; observed writes only, the purpose is a palette fade by inference
; 92 call sites from 80 routines (e.g. GameMode0_Init, DebugBattleSetup_Update, SendSGBFieldPaletteSet, RunFieldReturnPhase_Case00, ...)
; reads: wIsCGB, wSGBActive, wFadeState, wFadeMode, wFadeMask, wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1
; writes: wFadeState, wFadeLevel, wFadeDelay, wFadeDelayCounter
; points at: wOBJPaletteBuffer, wSGBPacketBuffer, wFadeDMGPalettes, wDMGPaletteBGP
StartPaletteFade::
Func_000_0DF2:: ; address name
    ld b, a
    ld a, [wIsCGB]
    or a, a
    jp nz, Jump_000_0E9B
    ld a, [wSGBActive]
    or a, a
    jp z, Jump_000_0EA8
    bit 7, b
    jr nz, Jump_000_0E2C
    ld a, b
    ld [wFadeState], a
    ld hl, wOBJPaletteBuffer + $20
    ld de, wOBJPaletteBuffer
    ld c, $20

Jump_000_0E11::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E11
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    jp Jump_000_0F3D

Jump_000_0E2C::
    ld a, b
    ld [wFadeState], a
    ld a, $20
    ld [wFadeLevel], a
    ld a, [wFadeState]
    cpl
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ld hl, wOBJPaletteBuffer + $20
    ld de, wOBJPaletteBuffer
    ld c, $20

Jump_000_0E4B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E4B
    ld de, $7FFF
    ld a, [wFadeMode]
    bit 7, a
    jr z, Jump_000_0E5E
    ld de, $0000

Jump_000_0E5E::
    ld hl, wOBJPaletteBuffer
    ld c, $10

Jump_000_0E63::
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    dec c
    jr nz, Jump_000_0E63
    call ClearSGBPacketBuffer
    ld hl, wOBJPaletteBuffer
    ld de, wSGBPacketBuffer
    ld a, $01
    ld [de], a
    inc de
    call CopySGBPacketFieldsAndSend
    call SpinDelay
    ld a, [wFadeMask]
    bit 4, a
    jp z, Jump_000_0F3D
    call ClearSGBPacketBuffer
    ld hl, wOBJPaletteBuffer + $10
    ld de, wSGBPacketBuffer
    ld a, $09
    ld [de], a
    inc de
    call CopySGBPacketFieldsAndSend
    call SpinDelay
    jp Jump_000_0F3D

Jump_000_0E9B::
    ld a, b
    ld [wFadeState], a
    farcall StartPaletteFade_Sub01
    jp Jump_000_0F3D

Jump_000_0EA8::
    ld a, [wFadeMode]
    bit 7, a
    jr nz, Jump_000_0EF7
    bit 7, b
    jr nz, Jump_000_0ED8
    ld a, b
    ld [wFadeState], a
    ld hl, wFadeDMGPalettes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    add a, $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    jr Jump_000_0F3D

Jump_000_0ED8::
    ld a, b
    ld [wFadeState], a
    ld a, $04
    ld [wFadeLevel], a
    ld a, [wFadeState]
    cpl
    add a, $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ld a, $00
    ld hl, wDMGPaletteBGP
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr Jump_000_0F3D

Jump_000_0EF7::
    bit 7, b
    jr nz, Jump_000_0F20
    ld a, b
    ld [wFadeState], a
    ld hl, wFadeDMGPalettes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    add a, $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    jr Jump_000_0F3D

Jump_000_0F20::
    ld a, b
    ld [wFadeState], a
    ld a, $04
    ld [wFadeLevel], a
    ld a, [wFadeState]
    cpl
    add a, $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ld a, $FF
    ld hl, wDMGPaletteBGP
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0F3D::
    ret

; copies the 8 bytes at vTiles1 + 8 * HL to DE (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyEightBytesFromTiles1Entry:: ; heuristic: follows a terminator; C0
Func_000_0F3E:: ; address name
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, vTiles1
    add hl, bc
    ld c, $08

Jump_000_0F47::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_0F47
    ret

; does nothing when wFadeState is 0; otherwise advances the palette fade by one step per call (CGB, SGB and DMG paths)
; 2 call sites from 2 routines (e.g. VBlankHandler, RunFrameTickFadeAndCounter_Bank1B)
; reads: wFadeState, wIsCGB, wSGBActive, wFadeDelayCounter, wFadeLevel, wFadeDelay, wFadeMode
; writes: wFadeDelayCounter, wFadeLevel, wFadeState
StepFade::
Func_000_0F4E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret z
    bit 7, a
    call z, StepFade_Sub02
    ld a, [wIsCGB]
    or a, a
    jp nz, Jump_000_10C7
    ld a, [wSGBActive]
    or a, a
    jp z, Jump_000_10CE
    ld a, [wFadeState]
    bit 7, a
    jr nz, Jump_000_0F98
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_0F78
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_0F78::
    ld a, [wFadeLevel]
    add a, $05
    cp a, $1F
    jr c, Jump_000_0F83
    ld a, $1F

Jump_000_0F83::
    ld [wFadeLevel], a
    call StepFade_Sub01
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    cp a, $1F
    jp z, Jump_000_1205
    ret

Jump_000_0F98::
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_0FA3
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_0FA3::
    ld a, [wFadeLevel]
    sub a, $05
    bit 7, a
    jr z, Jump_000_0FAD
    xor a, a

Jump_000_0FAD::
    ld [wFadeLevel], a
    call StepFade_Sub01
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    or a, a
    jp z, Jump_000_1205
    ret

; only called from StepFade (E-0047)
; 2 call sites from 1 routine (e.g. StepFade)
; reads: wFadeMask
; writes: wFadeStepSize, wSGBPacketIndex
; points at: wOBJPaletteBuffer, wSGBPacketBuffer
StepFade_Sub01::
Func_000_0FC1:: ; address name
    ld a, [wFadeMask]
    bit 0, a
    ld a, $00
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_Sub01
    ld a, [wFadeMask]
    bit 1, a
    ld a, $08
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_Sub01
    ld a, [wFadeMask]
    bit 4, a
    jr z, Jump_000_0FFC
    ld a, [wFadeMask]
    bit 2, a
    ld a, $10
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_Sub01
    ld a, [wFadeMask]
    bit 3, a
    ld a, $18
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_Sub01

Jump_000_0FFC::
    call ClearSGBPacketBuffer
    ld hl, wOBJPaletteBuffer
    ld de, wSGBPacketBuffer
    ld a, $01
    ld [de], a
    inc de
    call CopySGBPacketFieldsAndSend
    ld a, [wFadeMask]
    bit 4, a
    ret z
    call SpinDelay
    call ClearSGBPacketBuffer
    ld hl, wOBJPaletteBuffer + $10
    ld de, wSGBPacketBuffer
    ld a, $09
    ld [de], a
    inc de

; copies 8 bytes from HL to DE, skips 2 source bytes, copies 6 more, then wSGBPacketIndex = $FF and far-calls SendSGBPacketSet (E-0108)
; 3 call sites from 2 routines (e.g. StepFade_Sub01, StartPaletteFade)
; writes: wSGBPacketIndex
CopySGBPacketFieldsAndSend::
Func_000_1022:: ; address name
    ld c, $08

Jump_000_1024::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_1024
    inc hl
    inc hl
    ld c, $06

Jump_000_102E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_102E
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    ret

; only called from StepFade_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. StepFade_Sub01)
; reads: wFadeStepSize, wFadeLevel
; writes: wFadeStepSize
; points at: wOBJPaletteBuffer
StepFade_Sub01_Sub01::
Func_000_1040:: ; address name
    call StepFade_Sub01_Sub01_Sub02
    call StepFade_Sub01_Sub01_Sub01
    call StepFade_Sub01_Sub01_Sub01

; only called from StepFade_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. StepFade_Sub01_Sub01)
; reads: wFadeStepSize, wFadeLevel
; writes: wFadeStepSize
; points at: wOBJPaletteBuffer
StepFade_Sub01_Sub01_Sub01::
Func_000_1049:: ; address name
    ld a, [wFadeStepSize]
    add a, $02
    ld [wFadeStepSize], a

; only called from StepFade_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepFade_Sub01_Sub01)
; reads: wFadeStepSize, wFadeLevel
; points at: wOBJPaletteBuffer
StepFade_Sub01_Sub01_Sub02::
Func_000_1051:: ; address name
    ld hl, wOBJPaletteBuffer + $20
    ld a, [wFadeStepSize]
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld hl, $0000
    ld a, [wFadeLevel]
    ld b, a
    ld a, e
    call AdjustColorChannelForFade
    ld l, a
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, d
    call AdjustColorChannelForFade
    ld d, a
    ld e, $00
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop de
    ld a, d
    srl a
    srl a
    call AdjustColorChannelForFade
    sla a
    sla a
    add a, h
    ld h, a
    push hl
    pop de
    ld hl, wOBJPaletteBuffer
    ld b, $00
    ld a, [wFadeStepSize]
    ld c, a
    add hl, bc
    ld [hl], e
    inc hl
    ld [hl], d
    ret

; A = the 5-bit colour channel A moved by B toward white or black (bit 7 of wC56D), clamped; the following entries step the CGB and DMG fades (E-0128)
; 3 call sites from 1 routine (e.g. StepFade_Sub01_Sub01_Sub02)
; reads: wFadeMode
AdjustColorChannelForFade::
Func_000_10AB:: ; address name
    push af
    ld a, [wFadeMode]
    ld c, a
    pop af
    bit 7, c
    jr nz, Jump_000_10C0
    and a, $1F
    add a, b
    cp a, $1F
    jr c, Jump_000_10C6
    ld a, $1F
    jr Jump_000_10C6

Jump_000_10C0::
    and a, $1F
    sub a, b
    jr nc, Jump_000_10C6
    xor a, a

Jump_000_10C6::
    ret

Jump_000_10C7::
    farcall StepCGBFade
    ret

Jump_000_10CE::
    ld a, [wFadeMode]
    bit 7, a
    jp nz, Jump_000_116D
    ld a, [wFadeState]
    bit 7, a
    jr nz, Jump_000_10FE
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_10E8
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_10E8::
    call LightenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    inc a
    ld [wFadeLevel], a
    cp a, $04
    jp z, Jump_000_1205
    ret

Jump_000_10FE::
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_1109
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_1109::
    call LightenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    dec a
    ld [wFadeLevel], a
    cp a, $FF
    jp z, Jump_000_1205
    ret

; for each of bits 0, 1, 2 of wC56D that is set, lightens wC56F, wC570 or wC571 by wFadeLevel into wC5E9, wC5EA or wC5EB (LightenDMGPaletteByFadeLevel) (E-0117)
; 2 call sites from 1 routine (e.g. AdjustColorChannelForFade)
; reads: wFadeMode, wFadeDMGPalettes, wFadeLevel
; points at: wDMGPaletteBGP
LightenSelectedDMGPalettes::
Func_000_111F:: ; address name
    ld a, [wFadeMode]
    bit 0, a
    ld a, [wFadeDMGPalettes]
    ld hl, wDMGPaletteBGP
    call nz, LightenDMGPaletteByFadeLevel
    ld a, [wFadeMode]
    bit 1, a
    ld a, [wFadeDMGPalettes + $1]
    inc hl
    call nz, LightenDMGPaletteByFadeLevel
    ld a, [wFadeMode]
    bit 2, a
    ld a, [wFadeDMGPalettes + $2]
    inc hl
    jr nz, LightenDMGPaletteByFadeLevel
    ret

; A = a DMG palette byte: each 2-bit shade - wFadeLevel, at least 0 (white), is packed back and stored at [HL] (LightenDMGShade and LightenDMGShadeNext) (E-0108)
; 2 call sites from 1 routine (e.g. LightenSelectedDMGPalettes)
; reads: wFadeLevel
LightenDMGPaletteByFadeLevel::
Func_000_1145:: ; address name
    ld d, a
    ld a, [wFadeLevel]
    ld b, a
    ld c, $00
    ld a, d
    call LightenDMGShade
    call LightenDMGShadeNext
    call LightenDMGShadeNext
    call LightenDMGShadeNext
    ld [hl], c
    ret

; rotates D right by 2 to bring the next shade down, then LightenDMGShade (E-0108)
; 3 call sites from 1 routine (e.g. LightenDMGPaletteByFadeLevel)
LightenDMGShadeNext::
Func_000_115B:: ; address name
    rrc d
    rrc d
    ld a, d

; subtracts B (the level) from the 2-bit shade in A & 3 (at least 0), ORs it into C and rotates C right by 2 (E-0108)
; 1 call site from 1 routine (e.g. LightenDMGPaletteByFadeLevel)
LightenDMGShade::
Func_000_1160:: ; address name
    and a, $03
    sub a, b
    jr nc, Jump_000_1166
    xor a, a

Jump_000_1166::
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

Jump_000_116D::
    ld a, [wFadeState]
    bit 7, a
    jr nz, Jump_000_1194
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_117F
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_117F::
    call LightenDMGShade_Sub01
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    inc a
    ld [wFadeLevel], a
    cp a, $04
    jr z, Jump_000_1205
    ret

Jump_000_1194::
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_000_119F
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_000_119F::
    call LightenDMGShade_Sub01
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    dec a
    ld [wFadeLevel], a
    cp a, $FF
    jr z, Jump_000_1205
    ret

; only called from LightenDMGShade (E-0047)
; 2 call sites from 1 routine (e.g. LightenDMGShade)
; reads: wFadeMode, wFadeDMGPalettes, wFadeLevel
; points at: wDMGPaletteBGP
LightenDMGShade_Sub01::
Func_000_11B4:: ; address name
    ld a, [wFadeMode]
    bit 0, a
    ld a, [wFadeDMGPalettes]
    ld hl, wDMGPaletteBGP
    call nz, DarkenDMGPaletteByFadeLevel
    ld a, [wFadeMode]
    bit 1, a
    ld a, [wFadeDMGPalettes + $1]
    inc hl
    call nz, DarkenDMGPaletteByFadeLevel
    ld a, [wFadeMode]
    bit 2, a
    ld a, [wFadeDMGPalettes + $2]
    inc hl
    jr nz, DarkenDMGPaletteByFadeLevel
    ret

; A = a DMG palette byte (four 2-bit shades): each shade + wFadeLevel, capped at 3 (black), is packed back and stored at [HL] (DarkenDMGShade and DarkenDMGShadeNext) (E-0108)
; 2 call sites from 1 routine (e.g. LightenDMGShade_Sub01)
; reads: wFadeLevel
DarkenDMGPaletteByFadeLevel::
Func_000_11DA:: ; address name
    ld d, a
    ld a, [wFadeLevel]
    ld b, a
    ld c, $00
    ld a, d
    call DarkenDMGShade
    call DarkenDMGShadeNext
    call DarkenDMGShadeNext
    call DarkenDMGShadeNext
    ld [hl], c
    ret

; rotates D right by 2 to bring the next shade down, then DarkenDMGShade (E-0108)
; 3 call sites from 1 routine (e.g. DarkenDMGPaletteByFadeLevel)
DarkenDMGShadeNext::
Func_000_11F0:: ; address name
    rrc d
    rrc d
    ld a, d

; adds B (the level) to the 2-bit shade in A & 3, caps it at 3, ORs it into C and rotates C right by 2 (E-0108)
; 1 call site from 1 routine (e.g. DarkenDMGPaletteByFadeLevel)
DarkenDMGShade::
Func_000_11F5:: ; address name
    and a, $03
    add a, b
    cp a, $03
    jr c, Jump_000_11FE
    ld a, $03

Jump_000_11FE::
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

Jump_000_1205::
    xor a, a
    ld [wFadeState], a
    ret

; loops until STAT bit 1 is clear (modes 0 and 1); returns with Z set
; 251 call sites from 145 routines (e.g. VBlankHandler_Sub01, UploadBGPalettes, Func_000_2950_Case0F, CopyBBytesToVRAMFromDE, ...)
; reads: rSTAT
WaitForVRAMAccess::
Func_000_120A:: ; address name
    ldh a, [rSTAT]
    bit 1, a
    ret z
    jr WaitForVRAMAccess

; A = value, HL = address; disables interrupts, waits until VRAM is accessible, stores A at [HL]; clobbers hFFD1
; 171 call sites from 117 routines (e.g. StepStringDisplayUntilDone_Sub01, ShowTextContinueMark, AcknowledgeTextPrompt_Sub01, Func_000_2950_Case0F, ...)
; reads: rSTAT, hVRAMWriteByte
; writes: hVRAMWriteByte
WriteVRAMByte::
Func_000_1211:: ; address name
    ldh [hVRAMWriteByte], a
    di

Jump_000_1214::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1214
    ldh a, [hVRAMWriteByte]
    ld [hl], a
    ei
    ret

; like WriteVRAMByte but stores at [HL] and increments HL
; 145 call sites from 81 routines (e.g. Func_000_2950_Case0E, LoadMonsterPictureAttributes, DrawFullScreenBufferToBGMap, CopyBBytesToVRAMFromDE, ...)
; reads: rSTAT, hVRAMWriteByte
; writes: hVRAMWriteByte
WriteVRAMByteInc::
Func_000_121F:: ; address name
    ldh [hVRAMWriteByte], a
    di

Jump_000_1222::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1222
    ldh a, [hVRAMWriteByte]
    ld [hl+], a
    ei
    ret

; wMusicRequest = A
; 37 call sites from 35 routines (e.g. Func_000_2950_Case09, Func_000_2950_Case05, DebugSoundTest_Update, DebugStaffRoll_Init, ...)
; writes: wMusicRequest
QueueMusic::
Func_000_122D:: ; address name
    ld [wMusicRequest], a
    ret

; A = sound id (0 = none): stores it in wC608, calls InitSoundHardware (silencing every channel), stores A in wSoundId and starts the track with Func_000_334E unless the id is one of a list that is handled separately
; 1 call site from 1 routine (e.g. ProcessSoundQueue)
; reads: wCurrentMusic
; writes: wCurrentMusic, wSoundId
StartMusic::
Func_000_1231:: ; address name
    ld [wCurrentMusic], a
    di
    call InitSoundHardware
    ld a, [wCurrentMusic]
    or a, a
    jr z, Jump_000_1276
    ld [wSoundId], a
    cp a, $02
    jr z, Jump_000_126E
    cp a, $0F
    jr z, Jump_000_126E
    cp a, $40
    jr z, Jump_000_1273
    cp a, $42
    jr z, Jump_000_1273
    cp a, $44
    jr z, Jump_000_1273
    cp a, $46
    jr z, Jump_000_1273
    cp a, $48
    jr z, Jump_000_1273
    cp a, $50
    jr z, Jump_000_1273
    cp a, $52
    jr z, Jump_000_1273
    cp a, $58
    jr z, Jump_000_126E
    call StartThreeSoundTracks
    ei
    ret

Jump_000_126E::
    call StartMusic_Sub01
    ei
    ret

Jump_000_1273::
    call StartTwoSoundTracks

Jump_000_1276::
    ei
    ret

; wSoundEffectRequest = A; ProcessSoundQueue starts it on the next frame
; 405 call sites from 292 routines (e.g. StepStringDisplayUntilDone_Sub01, ShowTextContinueMark, AcknowledgeTextPrompt, Func_000_2950_Case09, ...)
; writes: wSoundEffectRequest
QueueSoundEffect::
Func_000_1278:: ; address name
    ld [wSoundEffectRequest], a
    ret

; A = sound id: stores it in wSoundId and starts the effect (ids in a fixed list take a separate path)
; 1 call site from 1 routine (e.g. ProcessSoundQueue)
; writes: wSoundId
StartSoundEffect::
Func_000_127C:: ; address name
    push af
    push bc
    push de
    push hl
    ld [wSoundId], a
    cp a, $63
    jr z, Jump_000_1306
    cp a, $67
    jr z, Jump_000_1306
    cp a, $6D
    jp z, Jump_000_1310
    cp a, $70
    jr z, Jump_000_1306
    cp a, $72
    jr z, Jump_000_1306
    cp a, $74
    jr z, Jump_000_1306
    cp a, $7E
    jr z, Jump_000_1306
    cp a, $89
    jr z, Jump_000_1306
    cp a, $8B
    jr z, Jump_000_1306
    cp a, $8D
    jr z, Jump_000_1306
    cp a, $91
    jr z, Jump_000_1306
    cp a, $9F
    jr z, Jump_000_1306
    cp a, $A5
    jr z, Jump_000_1306
    cp a, $AC
    jr z, Jump_000_1306
    cp a, $AE
    jr z, Jump_000_1306
    cp a, $B2
    jr z, Jump_000_1306
    cp a, $B6
    jr z, Jump_000_1306
    cp a, $B8
    jr z, Jump_000_1306
    cp a, $BA
    jr z, Jump_000_1306
    cp a, $BD
    jr z, Jump_000_1306
    cp a, $BF
    jr z, Jump_000_1306
    cp a, $C1
    jr z, Jump_000_1306
    cp a, $C3
    jr z, Jump_000_1306
    cp a, $C5
    jr z, Jump_000_1306
    cp a, $C7
    jr z, Jump_000_1306
    cp a, $C9
    jr z, Jump_000_1306
    cp a, $D2
    jr z, Jump_000_1306
    cp a, $D4
    jr z, Jump_000_1306
    cp a, $DA
    jr z, Jump_000_1306
    cp a, $DD
    jr z, Jump_000_1306
    di
    call StartSound
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_000_1306::
    di
    call StartTwoSoundTracks
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_000_1310::
    di
    call StartThreeSoundTracks
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

; starts the music requested in wMusicRequest and the effect requested in wSoundEffectRequest (StartMusic / StartSoundEffect), then sets each request to $FF
; 2 call sites from 1 routine (e.g. VBlankHandler)
; reads: wMusicRequest, wSoundEffectRequest
; writes: wMusicRequest, wSoundEffectRequest
ProcessSoundQueue::
Func_000_131A:: ; address name
    ld a, [wMusicRequest]
    cp a, $FF
    jr z, Jump_000_1329
    call StartMusic
    ld a, $FF
    ld [wMusicRequest], a

Jump_000_1329::
    ld a, [wSoundEffectRequest]
    cp a, $FF
    jr z, Jump_000_1338
    call StartSoundEffect
    ld a, $FF
    ld [wSoundEffectRequest], a

Jump_000_1338::
    ret
    INCBIN "dwm2-cobi-us.gbc", $001339, $44

; only called from StepFade (E-0047)
; 1 call site from 1 routine (e.g. StepFade)
; reads: wFieldInitStage, wSoundFadeLevel, wSoundFadeTarget, rNR50, wSoundFadeNR50, wSoundFadeTimer
; writes: wSoundFadeTarget, rNR50, wSoundFadeNR50, wSoundFadeTimer, wSoundFadeLevel
StepFade_Sub02::
Func_000_137D:: ; address name
    ld a, [wFieldInitStage]
    or a, a
    jr nz, Jump_000_13E0
    ld a, [wSoundFadeLevel]
    bit 7, a
    jr nz, Jump_000_13E0
    or a, a
    ret z
    ld a, [wSoundFadeTarget]
    or a, a
    jr z, Jump_000_1397
    dec a
    ld [wSoundFadeTarget], a
    ret

Jump_000_1397::
    ldh a, [rNR50]
    and a, $88
    cp a, $88
    jr z, Jump_000_13E0
    ld a, [wSoundFadeNR50]
    or a, a
    jr z, Jump_000_13E0
    ld b, a
    and a, $0F
    ld d, a
    ld a, b
    swap a
    and a, $0F
    ld c, a
    bit 3, c
    jr nz, Jump_000_13B8
    ld a, c
    or a, a
    jr z, Jump_000_13B8
    dec c

Jump_000_13B8::
    bit 3, d
    jr nz, Jump_000_13C1
    ld a, d
    or a, a
    jr z, Jump_000_13C1
    dec d

Jump_000_13C1::
    ld a, c
    swap a
    or a, d
    ldh [rNR50], a
    ld [wSoundFadeNR50], a
    or a, a
    jr z, Jump_000_13DE
    ld a, [wSoundFadeTimer]
    or a, a
    jr z, Jump_000_13E0
    dec a
    ld [wSoundFadeTimer], a
    ld a, [wSoundFadeLevel]
    ld [wSoundFadeTarget], a
    ret

Jump_000_13DE::
    di
    ei

Jump_000_13E0::
    xor a, a
    ld [wSoundFadeLevel], a
    ret

; when A differs from wC523: sends the Super Game Boy border tiles, map and palettes of set A through three compressed transfers (SGBTransferCompressed) (E-0130)
; 2 call sites from 2 routines (e.g. GameMode1_Init, GameMode5_Init_Case01)
; points at: wSGBBorderSet
LoadSGBBorderForSetA::
Func_000_13E5:: ; address name
    ld hl, wSGBBorderSet
    cp a, [hl]
    ret z
    ld [hl], a
    cp a, $00
    jr nz, Jump_000_1419
    ld a, $10
    ld e, LOW(SGBBorder0TilesA)
    ld d, HIGH(SGBBorder0TilesA)
    ld b, BANK(SGBBorder0TilesA)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $11
    ld e, LOW(SGBBorder0TilesB)
    ld d, HIGH(SGBBorder0TilesB)
    ld b, BANK(SGBBorder0TilesB)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $0F
    ld e, LOW(SGBBorder0MapAndPalettes)
    ld d, HIGH(SGBBorder0MapAndPalettes)
    ld b, BANK(SGBBorder0MapAndPalettes)
    call SGBTransferCompressed
    jp Jump_000_14CF

Jump_000_1419::
    cp a, $01
    jr nz, Jump_000_1447
    ld a, $10
    ld e, LOW(SGBBorder1TilesA)
    ld d, HIGH(SGBBorder1TilesA)
    ld b, BANK(SGBBorder1TilesA)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $11
    ld e, LOW(SGBBorder1TilesB)
    ld d, HIGH(SGBBorder1TilesB)
    ld b, BANK(SGBBorder1TilesB)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $0F
    ld e, LOW(SGBBorder1MapAndPalettes)
    ld d, HIGH(SGBBorder1MapAndPalettes)
    ld b, BANK(SGBBorder1MapAndPalettes)
    call SGBTransferCompressed
    jp Jump_000_14CF

Jump_000_1447::
    cp a, $02
    jr nz, Jump_000_1474
    ld a, $10
    ld e, LOW(SGBBorder2TilesA)
    ld d, HIGH(SGBBorder2TilesA)
    ld b, BANK(SGBBorder2TilesA)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $11
    ld e, LOW(SGBBorder2TilesB)
    ld d, HIGH(SGBBorder2TilesB)
    ld b, BANK(SGBBorder2TilesB)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $0F
    ld e, LOW(SGBBorder2MapAndPalettes)
    ld d, HIGH(SGBBorder2MapAndPalettes)
    ld b, BANK(SGBBorder2MapAndPalettes)
    call SGBTransferCompressed
    jr Jump_000_14CF

Jump_000_1474::
    cp a, $03
    jr nz, Jump_000_14A1
    ld a, $10
    ld e, LOW(SGBBorder3TilesA)
    ld d, HIGH(SGBBorder3TilesA)
    ld b, BANK(SGBBorder3TilesA)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $11
    ld e, LOW(SGBBorder3TilesB)
    ld d, HIGH(SGBBorder3TilesB)
    ld b, BANK(SGBBorder3TilesB)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $0F
    ld e, LOW(SGBBorder3MapAndPalettes)
    ld d, HIGH(SGBBorder3MapAndPalettes)
    ld b, BANK(SGBBorder3MapAndPalettes)
    call SGBTransferCompressed
    jr Jump_000_14CF

Jump_000_14A1::
    cp a, $04
    jr nz, Jump_000_14CF
    ld a, $10
    ld e, LOW(SGBBorder4TilesA)
    ld d, HIGH(SGBBorder4TilesA)
    ld b, BANK(SGBBorder4TilesA)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $11
    ld e, LOW(SGBBorder4TilesB)
    ld d, HIGH(SGBBorder4TilesB)
    ld b, BANK(SGBBorder4TilesB)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $0F
    ld e, LOW(SGBBorder4MapAndPalettes)
    ld d, HIGH(SGBBorder4MapAndPalettes)
    ld b, BANK(SGBBorder4MapAndPalettes)
    call SGBTransferCompressed
    call SpinDelay

Jump_000_14CF::
    ret
    db $C9

; only called from ClearSGBPacketBuffer (E-0047)
; 1 call site from 1 routine (e.g. ClearSGBPacketBuffer)
; reads: wLinkMode, wLinkStatus, wLinkRole, wLinkSession, rSB, wIsCGB
; writes: wLinkStatus, wLinkExchangeState, wLinkRole
; points at: wJoypadHeld
ClearSGBPacketBuffer_Sub02::
Func_000_14D1:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, Jump_000_1575
    ld a, $08
    call ClearSGBPacketBuffer_Shared01
    ld a, [wLinkStatus]
    set 7, a
    res 6, a
    ld [wLinkStatus], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_000_14F6
    ld hl, $6000

Jump_000_14F1::
    dec hl
    ld a, h
    or a, l
    jr nz, Jump_000_14F1

Jump_000_14F6::
    ei
    ld a, [wLinkSession]
    cp a, $05
    jr nz, Jump_000_150D
    call ClearSGBPacketBuffer_Sub02_Sub02
    call WaitSerialTransferDone
    ldh a, [rSB]
    cp a, $F5
    call nz, ClearSGBPacketBuffer_Sub02_Sub02
    jr Jump_000_1558

Jump_000_150D::
    call ClearSGBPacketBuffer_Sub02_Sub01
    cp a, $02
    jr z, Jump_000_1517
    call WaitSerialTransferDone

Jump_000_1517::
    ldh a, [rSB]
    cp a, $70
    jr z, Jump_000_1524
    cp a, $71
    jr z, Jump_000_1524
    call ClearSGBPacketBuffer_Sub02_Sub01

Jump_000_1524::
    ld b, a
    ld a, [wLinkSession]
    cp a, $05
    jr z, Jump_000_1558
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_000_1545
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_000_1558
    ld a, b
    bit 0, a
    jr z, Jump_000_1558
    ld a, [wLinkRole]
    set 1, a
    jr Jump_000_1555

Jump_000_1545::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_000_1558
    ld a, b
    bit 0, a
    jr nz, Jump_000_1558
    ld a, [wLinkRole]
    res 1, a

Jump_000_1555::
    ld [wLinkRole], a

Jump_000_1558::
    di
    ld a, [wLinkStatus]
    res 7, a
    ld [wLinkStatus], a
    ld a, [wLinkStatus]
    res 0, a
    res 1, a
    ld [wLinkStatus], a
    ld a, [wLinkRole]
    bit 1, a
    ld a, $F8
    call nz, SerialSendByte

Jump_000_1575::
    xor a, a
    ld [wLinkExchangeState], a
    ld hl, wJoypadHeld
    ld b, $0E

Jump_000_157E::
    ld [hl+], a
    dec b
    jr nz, Jump_000_157E
    ret

; only called from ClearSGBPacketBuffer_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ClearSGBPacketBuffer_Sub02)
; reads: wLinkRole, wIsCGB, wLinkTimerLo, wLinkTimerHi, wLinkStatus
; writes: wLinkTimerLo, wLinkTimerHi, wLinkFrameCounterHi
ClearSGBPacketBuffer_Sub02_Sub01::
Func_000_1583:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_000_1594
    ld a, [wIsCGB]
    or a, $70
    call StartSerialTransferInternalClock
    jr Jump_000_159C

Jump_000_1594::
    ld a, [wIsCGB]
    or a, $70
    call SerialSendByte

Jump_000_159C::
    ld a, [wLinkTimerLo]
    add a, $01
    ld [wLinkTimerLo], a
    ld a, [wLinkTimerHi]
    adc a, $00
    ld [wLinkTimerHi], a
    ld a, [wLinkTimerHi]
    cp a, $FF
    jr nc, Jump_000_15BC
    ld a, [wLinkStatus]
    bit 6, a
    jr z, Jump_000_159C
    xor a, a
    ret

Jump_000_15BC::
    ld a, $02
    ld [wLinkFrameCounterHi], a
    ret

; only called from ClearSGBPacketBuffer_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ClearSGBPacketBuffer_Sub02)
; reads: wLinkRole, wLinkStatus
ClearSGBPacketBuffer_Sub02_Sub02::
Func_000_15C2:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    ld a, $F5
    call nz, SerialSendByte
    ld a, [wLinkRole]
    bit 1, a
    ld a, $F5
    call z, StartSerialTransferInternalClock

Jump_000_15D6::
    ld a, [wLinkStatus]
    bit 6, a
    jr z, Jump_000_15D6
    ret

; A = ROM bank, DE = source in that bank, B = width, C = rows, HL = VRAM with rows 32 bytes apart: switches to the bank, copies the rectangle with WriteVRAMByteInc (interrupts off per byte; source rows packed), then restores the bank; B kept (E-0071)
; 16 call sites from 15 routines (e.g. DebugMessageTest_Init, DebugMonsterRecordViewer_Init, DebugSkillViewer_Init, DebugBattleSetup_Init, ...)
; writes: rROMB0
CopyRectFromBankToVRAM::
Func_000_15DE:: ; address name
    push bc
    ld b, a
    ld a, [BANK_NUMBER_BYTE]
    ld c, a
    ld a, b
    ld [rROMB0], a
    ld a, c
    pop bc
    push af

Jump_000_15EB::
    push hl
    push bc

Jump_000_15ED::
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, Jump_000_15ED
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1606
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_15EB

Jump_000_1606::
    pop af
    ld [rROMB0], a
    ret

; A = ROM bank, DE = source in that bank, B = width, C = rows, HL = BG map address: switches to the bank and copies the rectangle with WriteVRAMByteInc (interrupts off per byte), wrapping columns inside each 32-entry row and rows inside $9800-$9BFF (H &= $9B); restores the bank (E-0090)
; 8 call sites from 4 routines (e.g. CopyScreenRectToBGMapSetTextCursorLo, DrawBottomWindowWC364AtScroll, DrawScreenBufferRectToBGMap_33, DrawScreenBufferRectToBGMap_37)
; writes: rROMB0
CopyRectFromBankToBGMapWrapped::
Func_000_160B:: ; address name
    push bc
    ld b, a
    ld a, [BANK_NUMBER_BYTE]
    ld c, a
    ld a, b
    ld [rROMB0], a
    ld a, c
    pop bc
    push af

Jump_000_1618::
    push hl
    push bc

Jump_000_161A::
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_162D
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_162D::
    inc de
    dec b
    jr nz, Jump_000_161A
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1644
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1618

Jump_000_1644::
    pop af
    ld [rROMB0], a
    ret

; copies the 32 x 32 wScreenTileBuffer to vBGMap0, wrapping columns and rows (E-0125)
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer
CopyScreenTileBufferToBGMapWrapped:: ; heuristic: follows a terminator; C0
Func_000_1649:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld c, $20

Jump_000_1651::
    ld b, $20
    push hl

Jump_000_1654::
    ld a, [de]
    call WriteVRAMByte
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    inc de
    dec b
    jr nz, Jump_000_1654
    pop hl
    push bc
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    pop bc
    dec c
    jr nz, Jump_000_1651
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 5 call sites from 3 routines (e.g. LoadPalette0FromData4ACC, LoadPalette0FromData4322, LoadPalette0FromData53C6)
CopyBytesDEToHL_Bank00::
Func_000_1679:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank00
    ret

; HL = A * C (8 x 8 bit); clobbers A, B and C
; 116 call sites from 99 routines (e.g. Func_000_2950_Case08, BattlerRecordFieldAddress, Multiply8By16, SRAMRecordAddressMapped, ...)
Multiply8::
Func_000_1682:: ; address name
    ld b, $00
    ld h, b
    ld l, b
    call Multiply8_Sub01

; only called from Multiply8 (E-0047)
; 1 call site from 1 routine (e.g. Multiply8)
Multiply8_Sub01::
Func_000_1689:: ; address name
    rrca
    jr nc, Jump_000_168D
    add hl, bc

Jump_000_168D::
    sla c
    rl b
    rrca
    jr nc, Jump_000_1695
    add hl, bc

Jump_000_1695::
    sla c
    rl b
    rrca
    jr nc, Jump_000_169D
    add hl, bc

Jump_000_169D::
    sla c
    rl b
    rrca
    jr nc, Jump_000_16A5
    add hl, bc

Jump_000_16A5::
    sla c
    rl b
    ret

; E:H:L = A * BC (24-bit product); clobbers A, BC, HL, E
; 64 call sites from 53 routines (e.g. MultiplyHLByAPercent, FastestFoeAGLAbove31PercentOfActor, AIScore_BiAttack_Sub01, AIScore_Berserker_Sub01, ...)
Multiply8By16::
Func_000_16AA:: ; address name
    push af
    push bc
    ld c, b
    call Multiply8
    pop bc
    pop af
    push hl
    call Multiply8
    pop bc
    ld a, c
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    ret

; B = B / A (quotient), A = remainder; clobbers D, E
; 32 call sites from 32 routines (e.g. CreateMonsterRecordOfKindTemp1_Sub01_Sub01, DebugBattleSetupShowFieldString, SetupInventoryMenuPages_Bank03, ResistanceAverageGateForAISide, ...)
DivideBByA::
Func_000_16BF:: ; address name
    ld d, $08
    ld e, a
    xor a, a

Jump_000_16C3::
    sla b
    rla
    jr c, Jump_000_16CB
    cp a, e
    jr c, Jump_000_16CD

Jump_000_16CB::
    sub a, e
    inc b

Jump_000_16CD::
    dec d
    jr nz, Jump_000_16C3
    ret

; HL = HL / A (quotient in HL), A = remainder; clobbers D, E
; 88 call sites from 64 routines (e.g. DivideHLByBC, AIScore_BiAttack_Sub02_Sub01, AIScore_Meditate_Sub01_Sub01, HPBandOfSlotTemp0, ...)
DivideHLByA::
Func_000_16D1:: ; address name
    ld d, $10
    ld e, a
    xor a, a

Jump_000_16D5::
    add hl, hl
    rla
    jr c, Jump_000_16DC
    cp a, e
    jr c, Jump_000_16DE

Jump_000_16DC::
    sub a, e
    inc l

Jump_000_16DE::
    dec d
    jr nz, Jump_000_16D5
    ret

; E:H:L = E:H:L / A (24-bit quotient), A = remainder; clobbers B, D
; 36 call sites from 30 routines (e.g. MultiplyHLByAPercent, FastestFoeAGLAbove31PercentOfActor, AIGateCompareAllyStatAverages, AIScore_BiAttack_Sub01, ...)
Divide24ByA::
Func_000_16E2:: ; address name
    ld d, $18
    ld b, a
    xor a, a

Jump_000_16E6::
    add hl, hl
    rl e
    rla
    jr c, Jump_000_16EF
    cp a, b
    jr c, Jump_000_16F1

Jump_000_16EF::
    sub a, b
    inc l

Jump_000_16F1::
    dec d
    jr nz, Jump_000_16E6
    ret

; HL (0-999) becomes three digits: wC8C0 = hundreds, wC8C1 = tens, wC8C2 = ones
; 116 call sites from 78 routines (e.g. DebugResultsDisplay_Update_Sub02, PackTwoDigitsOfCAsBCD, BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, ...)
; reads: wDigits
; writes: wDigits
HLToDecimalDigits::
Func_000_16F5:: ; address name
    xor a, a
    ld [wDigits], a
    ld [wDigits + $1], a
    ld [wDigits + $2], a

Jump_000_16FF::
    ld a, [wDigits]
    inc a
    ld [wDigits], a
    ld bc, $FF9C
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_16FF
    ld bc, $0064
    add hl, bc
    ld a, [wDigits]
    dec a
    ld [wDigits], a

Jump_000_171A::
    ld a, [wDigits + $1]
    inc a
    ld [wDigits + $1], a
    ld bc, $FFF6
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_171A
    ld bc, $000A
    add hl, bc
    ld a, [wDigits + $1]
    dec a
    ld [wDigits + $1], a
    ld a, l
    ld [wDigits + $2], a
    ret

; the 24-bit value at wC8C0-wC8C2 (low byte first) becomes decimal digits: hFFC9 = millions, hFFC8 = hundred-thousands and ten-thousands, hFFC7 = thousands and hundreds, hFFC6 = tens and ones (two digits per byte, high digit in the upper nibble); wC8C0-wC8C2 are consumed
; 45 call sites from 38 routines (e.g. DebugShowMonsterRecord_Sub01, DebugSkillViewer_Update_Sub01, DrawGoldDigitsAtHLWrapped, WithSRAMDraw4ACEAnd4BE8_Sub01, ...)
; reads: hTemp2, hTemp1, wDigits
; writes: hTemp3, hTemp2, hTemp1, hTemp0, wDigits
; points at: wDigits
Number24ToPackedBCD::
Func_000_173A:: ; address name
    xor a, a
    ldh [hTemp3], a
    ldh [hTemp2], a
    ldh [hTemp1], a
    ldh [hTemp0], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_174E::
    ld a, c
    sub a, $40
    ld c, a
    ld a, b
    sbc a, $42
    ld b, a
    ld a, d
    sbc a, $0F
    ld d, a
    jr c, Jump_000_1768
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_174E

Jump_000_1768::
    ld a, e
    ldh [hTemp3], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_1776::
    ld a, c
    sub a, $A0
    ld c, a
    ld a, b
    sbc a, $86
    ld b, a
    ld a, d
    sbc a, $01
    ld d, a
    jr c, Jump_000_1790
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_1776

Jump_000_1790::
    ld a, e
    swap a
    ldh [hTemp2], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_17A0::
    ld a, c
    sub a, $10
    ld c, a
    ld a, b
    sbc a, $27
    ld b, a
    ld a, d
    sbc a, $00
    ld d, a
    jr c, Jump_000_17BA
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_17A0

Jump_000_17BA::
    ldh a, [hTemp2]
    add a, e
    ldh [hTemp2], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

Jump_000_17C8::
    ld a, c
    sub a, $E8
    ld c, a
    ld a, b
    sbc a, $03
    ld b, a
    jr c, Jump_000_17DC
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17C8

Jump_000_17DC::
    ld a, e
    swap a
    ldh [hTemp1], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

Jump_000_17EA::
    ld a, c
    sub a, $64
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    jr c, Jump_000_17FE
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17EA

Jump_000_17FE::
    ldh a, [hTemp1]
    add a, e
    ldh [hTemp1], a
    ld a, [wDigits]
    ld e, $00

Jump_000_1808::
    sub a, $0A
    jr c, Jump_000_1812
    ld [wDigits], a
    inc e
    jr Jump_000_1808

Jump_000_1812::
    swap e
    ld a, [wDigits]
    add a, e
    ldh [hTemp0], a
    ret

; DE = bit number; tests that bit of the bit array at wCBD7 (bit 0 of the first byte first); returns carry set when it is 1, A = 0 and carry clear otherwise; no range check
; 864 call sites from 412 routines (e.g. LoadMapScreen_Sub02, SetFieldEventKindOnMap19IfFlagD1, WritePlayerNameWithFlag0SuffixToTextBuf0, PlayMapMusic_Case05, ...)
TestFlagBit::
Func_000_181B:: ; address name
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add a, $D7
    ld e, a
    ld a, d
    adc a, $CB
    ld d, a
    ld c, $01
    ld a, b
    and a, $07
    jr z, Jump_000_183D
    ld b, a

Jump_000_1838::
    sla c
    dec b
    jr nz, Jump_000_1838

Jump_000_183D::
    ld a, [de]
    and a, c
    jr nz, Jump_000_1843
    sub a, a
    ret

Jump_000_1843::
    scf
    ret

; DE = bit number; sets that bit of the bit array at wCBD7; does nothing when DE >= $0300
; 158 call sites from 119 routines (e.g. RunFieldReturnPhase_Case01, RunMenuStateMenuState_Case05, PauseMenu_State4, Func_004_6A35_Case12, ...)
SetFlagBit::
Func_000_1845:: ; address name
    ld a, d
    cp a, $03
    jr nc, Jump_000_1870
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add a, $D7
    ld e, a
    ld a, d
    adc a, $CB
    ld d, a
    ld c, $01
    ld a, b
    and a, $07
    jr z, Jump_000_186C
    ld b, a

Jump_000_1867::
    sla c
    dec b
    jr nz, Jump_000_1867

Jump_000_186C::
    ld a, [de]
    or a, c
    ld [de], a
    ret

Jump_000_1870::
    jr Jump_000_1870

; B = ROM bank, DE = address; C = the byte at [DE] in that bank; the caller's bank is restored
; 73 call sites from 24 routines (e.g. DebugMonsterPictureViewer_Update, ScriptCommandF7_Run_Case27_Sub02_Sub01, DecompressGraphicsArg1ToArg4, LoadSpeciesSpriteGraphicsAndPalette, ...)
; writes: rROMB0
ReadByteInBank::
Func_000_1872:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

; HL = destination, B = width, C = height: writes the 16-byte pattern at $2940 B * C times, each byte after waiting for VRAM access; wC52D holds B between rows
; 103 call sites from 44 routines (e.g. ScriptCommandEF_Run_Case0F_Case02, ScriptCommandEC_Run_Case02, ScriptCommandEB_Run_Case05_Case3C, ScriptCommandEB_Run_Case05_Case05, ...)
; reads: rSTAT, wTextWindowTileLo
; writes: wTextWindowTileLo
FillTilesBxC::
Func_000_1881:: ; address name
    ld a, b
    ld [wTextWindowTileLo], a

Jump_000_1885::
    push bc
    ld de, $2940
    ld c, $10

Jump_000_188B::
    di

Jump_000_188C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_188C
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, Jump_000_188B
    pop bc
    dec b
    jr nz, Jump_000_1885
    ld a, [wTextWindowTileLo]
    ld b, a
    dec c
    jr nz, Jump_000_1885
    ret

; B = width, C = rows, DE = source, HL = BG map address: copies a B x C rectangle, wrapping columns inside each 32-entry row and rows inside $9800-$9BFF (H &= $9B). Each byte is written with interrupts off after rSTAT bit 1 clears. DE ends past the source, HL at the last row start, C = 0; B kept (E-0059)
; 24 call sites from 12 routines (e.g. DrawScreenBufferRect_Bank0C, DrawScreenBufferRect_Bank0D, DrawScreenBufferRect_Bank14, DrawScreenBufferRect_Bank15, ...)
; reads: rSTAT
CopyRectToBGMapWrapped::
Func_000_18A5:: ; address name
    push hl
    push bc

Jump_000_18A7::
    di

Jump_000_18A8::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_18A8
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_18BE
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_18BE::
    inc de
    dec b
    jr nz, Jump_000_18A7
    pop bc
    pop hl
    dec c
    jr z, Jump_000_18D5
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr CopyRectToBGMapWrapped

Jump_000_18D5::
    ret

; with ROM bank B mapped, reads three bytes at DE: HL = the word, B = the third byte (a far pointer: address then bank); DE += 3; restores the bank (E-0090)
; 10 call sites from 8 routines (e.g. ScriptCommandF7_Run_Case27_Sub02_Sub01, ScriptCommandE2_Run_Case03_Case09_Sub02, ScriptCommandE2_Run_Shared02, ReadF2FarPointerForScreenTableIndex, ...)
; writes: rROMB0
ReadFarPointerAtDEInBankB::
Func_000_18D6:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld b, a
    pop af
    ld [rROMB0], a
    ret
    db $FA, $00, $40, $F5, $3E, $61, $EA, $00, $21, $F0, $C6, $6F, $26, $00, $29, $7D
    db $C6, $05, $6F, $7C, $CE, $67, $67, $3E, $02, $18, $19

; for the current map screen decompresses its tile block (chunk table in bank $61, indexed by hFFC6 and the screen position) into wScreenTileBuffer, and on CGB its attributes (E-0130)
; 4 call sites from 4 routines (e.g. Func_061_4472_Case07, Func_061_4472_Case06, Func_061_4472_Case03, Func_061_4472_Case02)
; reads: hTemp0, wMapWidthScreens, hMapScreenY, hMapScreenX, wIsCGB, hTemp1, hTemp2, hTemp3
; writes: rROMB0, hTemp0, hTemp1, hTemp2, hTemp3, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
LoadMapScreenFromChunk::
Func_000_1906:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $61
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $D8
    ld l, a
    ld a, h
    adc a, $60
    ld h, a
    ld a, $14
    push af
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop af
    add a, l
    ld l, a
    ldh [hTemp0], a
    ld a, h
    adc a, $00
    ld h, a
    ldh [hTemp1], a
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [hl]
    ld [rROMB0], a
    ld a, [wMapWidthScreens]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    ld c, a
    add a, a
    add a, c
    add_a_to_hl
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop af
    ld [rROMB0], a
    ld a, [wIsCGB]
    or a, a
    jr nz, Jump_000_1978
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_19A4

Jump_000_1978::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

Jump_000_19A4::
    pop af
    ld [rROMB0], a
    ret

; loads the screen at (hMapScreenX, hMapScreenY) of map hMapId: finds the map record (MapRecordPointer), picks one of its variants by the highest set bit of the flag byte whose RAM address is stored in the record, decompresses that variant's tile-map stream (an array of far pointers, indexed by row * width + column) into wScreenTileBuffer and, on CGB, the attribute stream into wD000 (WRAM bank 2); then runs the map's tile-replacement table (Func_084_43B8) and two map-specific fix-ups (Func_000_1B6F, Func_000_1A73); hands over to Func_061_4472 when wCC44 bit 7 is set
; 4 call sites from 4 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_Case00, ScriptCommand77_Run_Case01, ScriptCommandED_Run_Case07_Case02)
; reads: wMapType, wMapWidthScreens, hMapScreenY, hMapScreenX, wIsCGB, hTemp0, hTemp1, hTemp2, ...
; writes: rROMB0, hTemp0, hTemp1, hTemp2, hTemp3, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
LoadMapScreen::
Func_000_19A9:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_000_19B7
    farcall LoadMapScreen_Sub03
    ret

Jump_000_19B7::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    call MapRecordPointer
    ld a, $10
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [de]
    ld b, $08

Jump_000_19D9::
    sla a
    jr c, Jump_000_19E6
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, Jump_000_19D9

Jump_000_19E6::
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [hl]
    ld [rROMB0], a
    ld a, [wMapWidthScreens]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    ld c, a
    add a, a
    add a, c
    add_a_to_hl
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop af
    ld [rROMB0], a
    ld a, [wIsCGB]
    or a, a
    jr nz, Jump_000_1A36
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_1A62

Jump_000_1A36::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

Jump_000_1A62::
    pop af
    ld [rROMB0], a
    farcall ApplyMapScreenFlagEvents
    call LoadMapScreen_Sub02
    call LoadMapScreen_Sub01
    ret

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey
; writes: hTemp0
; points at: wKeyWorldGoal
LoadMapScreen_Sub01::
Func_000_1A73:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_000_1AB3
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, $1AB4

Jump_000_1A83::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_000_1A89
    ret

Jump_000_1A89::
    cp a, c
    jr z, Jump_000_1A92
    inc hl
    inc hl
    inc hl
    inc b
    jr Jump_000_1A83

Jump_000_1A92::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_000_1AA9
    ld a, [wKeyWorldKey]
    dec a
    cp a, b
    jr nz, Jump_000_1AA9
    ld de, wKeyWorldGoal
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_Sub01_Sub01
    ret

Jump_000_1AA9::
    ld e, l
    ld d, h
    inc de
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_Sub01_Sub01
    ret

Jump_000_1AB3::
    ret
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

; only called from LoadMapScreen_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. LoadMapScreen_Sub01)
; reads: hMapScreenX, hMapScreenY, wIsCGB, hTemp0
; writes: rSVBK
LoadMapScreen_Sub01_Sub01::
Func_000_1AD6:: ; address name
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    ret nz
    dec de
    push hl
    ld a, [de]
    and a, $0F
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    and a, $0F
    add_a_to_hl
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    swap a
    and a, $0F
    sla a
    add_a_to_hl
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, $46
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, $56
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_1B6D
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    ld c, $03
    ldh a, [hTemp0]
    cp a, $04
    jr z, Jump_000_1B5C
    cp a, $0A
    jr z, Jump_000_1B5C
    ld c, $05
    cp a, $05
    jr z, Jump_000_1B5C
    cp a, $06
    jr z, Jump_000_1B5C
    cp a, $07
    jr z, Jump_000_1B5C
    ld c, $01

Jump_000_1B5C::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

Jump_000_1B6D::
    pop hl
    ret

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: hMapScreenX, hMapId
LoadMapScreen_Sub02::
Func_000_1B6F:: ; address name
    ld de, $012B
    call TestFlagBit
    ret nc
    ldh a, [hMapScreenX]
    or a, a
    ret nz
    ldh a, [hMapId]
    cp a, $0D
    jr nz, Jump_000_1B95
    ld hl, wScreenTileBuffer + $14A
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add_a_to_hl
    ld [hl], $46
    inc hl
    ld [hl], $47
    ret

Jump_000_1B95::
    cp a, $05
    ret nz
    ld hl, wScreenTileBuffer + $32
    ld [hl], $78
    inc hl
    ld [hl], $79
    ld a, $13
    add_a_to_hl
    ld [hl], $7A
    inc hl
    ld [hl], $7B
    ret

; hFFC6 = index into a table at bank $61 $60D8 of special map records: decompresses the first far-pointer stream to vTiles2, handles the second with Func_000_24E5, then stores the next five bytes in wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wC193 and wC90D and clears wC901, wC194-wC196
; 4 call sites from 4 routines (e.g. RunMapType_420D_Case07, RunMapType_420D_Case06, RunMapType_420D_Case03, RunMapType_420D_Case02)
; reads: hTemp0
; writes: rROMB0, wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, wEncounterRate, wMapMoveType, ...
LoadSpecialMapHeader::
Func_000_1BAD:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $61
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    sla l
    rl h
    ld a, l
    add a, $D8
    ld l, a
    ld a, h
    adc a, $60
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    call LoadBGPaletteBufferFromBank
    pop hl
    ld a, [hl+]
    ld [wMapWidthScreens], a
    ld a, [hl+]
    ld [wMapHeightScreens], a
    ld a, [hl+]
    ld [wMaxBlockingTile], a
    ld a, [hl+]
    ld [wMapHeaderByte7], a
    ld a, [hl+]
    ld [wFieldEventKind], a
    xor a, a
    ld [wEncounterRate], a
    ld [wMapMoveType], a
    ld [wMapSpriteKind], a
    ld [wMapTallTileMin], a
    pop af
    ld [rROMB0], a
    ret

; loads the current map's graphics, palette, size (wMapWidthScreens/HeightScreens), wMaxBlockingTile and other header bytes from the bank-$11 map record (special maps use RunMapType_420D) (E-0128)
; 3 call sites from 3 routines (e.g. InitFieldScreen, ScriptCommandF6_Run_Case06, ScriptCommandED_Run_Case07_Case02)
; reads: wMapType, hMapId
; writes: rROMB0, wMenuState, wMenuSubState, wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, ...
LoadMapHeader::
Func_000_1C0C:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_000_1C1A
    farcall RunMapType_420D
    ret

Jump_000_1C1A::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    call MapRecordPointer
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    ldh a, [hMapId]
    cp a, $14
    jr nz, Jump_000_1C51
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, Data_048_7861
    ld b, $48
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    xor a, a
    ld [wMenuState], a
    ld [wMenuSubState], a
    jr Jump_000_1C55

Jump_000_1C51::
    call DecompressToVRAM
    pop hl

Jump_000_1C55::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    call LoadBGPaletteBufferFromBank
    pop hl
    ld a, [hl+]
    ld [wMapWidthScreens], a
    ld a, [hl+]
    ld [wMapHeightScreens], a
    ld a, [hl+]
    ld [wMaxBlockingTile], a
    ld a, [hl+]
    ld [wMapHeaderByte7], a
    ld a, [hl+]
    ld [wFieldEventKind], a
    ld a, [hl+]
    or a, $80
    ld [wEncounterRate], a
    ld a, [hl+]
    ld [wMapMoveType], a
    ld a, [hl+]
    ld [wMapSpriteKind], a
    or a, a
    jr z, Jump_000_1C93
    and a, $0F
    jr z, Jump_000_1C8F
    ld a, [hl+]
    ld [wMapTallTileMin], a
    jr Jump_000_1C93

Jump_000_1C8F::
    ld a, [hl+]
    ld [wMapHeaderByte11], a

Jump_000_1C93::
    call SetMapSpriteKindAndMapHeaderByte11ForSpecialMaps
    call ShiftAnimatedTilesOnMap1Or2
    call SetFieldEventKindOnMap19IfFlagD1
    pop af
    ld [rROMB0], a
    ret

; on map $19, if story flag $D1 is set, wFieldEventKind = $0B; its `ld a, [wStoryFlags + $60] / ret nz` tests the flags of the map compare, so that byte never stops it (executed with the byte $00 and $FF, test Map19StoryByteCheckNeverReturns) (E-0122, E-0154)
; 1 call site from 1 routine (e.g. LoadMapHeader)
; reads: hMapId, wStoryFlags
; writes: wFieldEventKind
SetFieldEventKindOnMap19IfFlagD1::
Func_000_1CA1:: ; address name
    ldh a, [hMapId]
    cp a, $19
    ret nz
    ld a, [wStoryFlags + $60]
    ret nz
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld a, $0B
    ld [wFieldEventKind], a
    ret

; when bit 1 of wCC37 is set (and bit 5 clear) on map 1 or 2, shifts a tile row in vTiles2 and copies $40 bytes from $1D07 (tile animation) (E-0125)
; 1 call site from 1 routine (e.g. LoadMapHeader)
; reads: wStoryFlags, hMapId
ShiftAnimatedTilesOnMap1Or2::
Func_000_1CB7:: ; address name
    ld a, [wStoryFlags + $60]
    bit 5, a
    ret nz
    bit 1, a
    ret z
    ldh a, [hMapId]
    cp a, $01
    jr z, Jump_000_1CCB
    cp a, $02
    jr z, Jump_000_1CE2
    ret

Jump_000_1CCB::
    ld de, vTiles2 + $500
    ld hl, vTiles2 + $510
    ld b, $10
    call CopyBBytesToVRAMFromDE
    ld de, $1D07
    ld hl, vTiles2 + $120
    ld b, $40
    call CopyBBytesToVRAMFromDE
    ret

Jump_000_1CE2::
    ld de, vTiles2 + $400
    ld hl, vTiles2 + $410
    ld b, $10
    call CopyBBytesToVRAMFromDE
    ld de, $1D07
    ld hl, vTiles2 + $2A0
    ld b, $40
    call CopyBBytesToVRAMFromDE
    ret

; copies B bytes from DE to VRAM at HL, each read after WaitForVRAMAccess with interrupts off and written with WriteVRAMByteInc (E-0117)
; 4 call sites from 1 routine (e.g. ShiftAnimatedTilesOnMap1Or2)
CopyBBytesToVRAMFromDE::
Func_000_1CF9:: ; address name
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, CopyBBytesToVRAMFromDE
    ret

; E-0168 (derived: 64 bytes copied into vTiles uncompressed)
; record: one 16-byte tile (2bpp) per line
Tiles_00_1D07::
Data_000_1D07:: ; address name
    db $FF, $1E, $E1, $21, $DF, $5F, $E2, $62, $9C, $9C, $A4, $A4, $C4, $C4, $CE, $4E ; id 0
    db $FF, $78, $87, $84, $FB, $FA, $67, $66, $39, $39, $25, $25, $23, $23, $33, $32 ; id 1
    db $DF, $53, $FF, $62, $F6, $0A, $FF, $04, $FC, $04, $BF, $48, $FF, $10, $FF, $0F ; id 2
    db $7B, $6A, $BF, $E6, $FF, $22, $9F, $10, $FD, $12, $8F, $08, $FF, $04, $FF, $F8 ; id 3

; sets wC195/wC197 to $11/$2C on maps $30 and $B8, $22/$30 on maps $63-$66, $12/$2C on map $70 (E-0125)
; 1 call site from 1 routine (e.g. LoadMapHeader)
; reads: hMapId
; writes: wMapSpriteKind, wMapHeaderByte11
SetMapSpriteKindAndMapHeaderByte11ForSpecialMaps::
Func_000_1D47:: ; address name
    ldh a, [hMapId]
    cp a, $30
    jr z, Jump_000_1D51
    cp a, $B8
    jr nz, Jump_000_1D5C

Jump_000_1D51::
    ld a, $11
    ld [wMapSpriteKind], a
    ld a, $2C
    ld [wMapHeaderByte11], a
    ret

Jump_000_1D5C::
    cp a, $63
    jr c, Jump_000_1D6F
    cp a, $67
    jr nc, Jump_000_1D6F
    ld a, $22
    ld [wMapSpriteKind], a
    ld a, $30
    ld [wMapHeaderByte11], a
    ret

Jump_000_1D6F::
    cp a, $70
    jr nz, Jump_000_1D7E
    ld a, $12
    ld [wMapSpriteKind], a
    ld a, $2C
    ld [wMapHeaderByte11], a
    ret

Jump_000_1D7E::
    ret

; HL = the word at MapTable + 2 * hMapId (bank $11)
; 2 call sites from 2 routines (e.g. LoadMapScreen, LoadMapHeader)
; reads: hMapId
MapRecordPointer::
Func_000_1D7F:: ; address name
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, $44B8
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ret

; only called from DebugMapEditor_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugMapEditor_Update)
; reads: hTemp0, wDebugValue1, wDebugValue3
; writes: rROMB0, hTemp0
DebugMapEditor_Update_Sub01::
Func_000_1D90:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $B8
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, $06
    add_a_to_hl
    ld a, [wDebugValue1]
    ld c, a
    ld a, [hl+]
    ldh [hTemp0], a
    cp a, c
    jr z, Jump_000_1DC0
    jr nc, Jump_000_1DC7

Jump_000_1DC0::
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

Jump_000_1DC7::
    ld a, [wDebugValue3]
    ld c, a
    ld a, [hl+]
    cp a, c
    jr z, Jump_000_1DC0
    jr c, Jump_000_1DC0
    ld a, $08
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [de]
    ld b, $08

Jump_000_1DE7::
    sla a
    jr c, Jump_000_1DF4
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, Jump_000_1DE7

Jump_000_1DF4::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld c, a
    sla a
    add a, c
    ld c, a
    ld a, [wDebugValue3]
    call Multiply8
    ld a, [wDebugValue1]
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    or a, c
    jr nz, Jump_000_1E23
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

Jump_000_1E23::
    pop af
    ld [rROMB0], a
    xor a, a
    ret

; HL = BG map address: draws the 20 x 18 entries of wScreenTileBuffer, wrapping columns inside each 32-entry row and rows inside $9800-$9BFF; on CGB then draws the attribute bytes at wD000 (rSVBK = 2), masked to the palette bits (& $07), into VRAM bank 1; HL kept (E-0071)
; 16 call sites from 16 routines (e.g. InitFieldScreen, RedrawScreenBufferIfPartyWindowFlagsBit7, FieldModeStateDispatch_Case02_Sub01_Sub02, GameMode5_Update_Case01_Case06_Case01, ...)
; reads: wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawFullScreenBufferToBGMap::
Func_000_1E29:: ; address name
    push hl
    ld de, wScreenTileBuffer
    ld bc, $1412

Jump_000_1E30::
    push hl
    push bc

Jump_000_1E32::
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1E45
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1E45::
    inc de
    dec b
    jr nz, Jump_000_1E32
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1E5B
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1E30

Jump_000_1E5B::
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wScreenAttrBuffer
    ld bc, $1412

Jump_000_1E6F::
    push hl
    push bc

Jump_000_1E71::
    di
    ld a, [de]
    and a, $07
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1E86
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1E86::
    inc de
    dec b
    jr nz, Jump_000_1E71
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1E9C
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1E6F

Jump_000_1E9C::
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; copies the 20 x 13 screen-buffer area (offset by bit 7 of wC8CB) to the BG map at HL, wrapping, and on CGB its attributes from WRAM bank 2 (E-0130)
; 2 call sites from 2 routines (e.g. StepStringDisplayUntilDone_Sub01, DrawScreenBufferAtScrollOrigin)
; reads: wTextWindowState, rSTAT, wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer
DrawScreenBufferToBGMapWithAttrs::
Func_000_1EA5:: ; address name
    ld de, wScreenTileBuffer
    ld a, [wTextWindowState]
    bit 7, a
    jr z, Jump_000_1EC1
    ld a, $64
    add a, e
    ld e, a
    jr nc, Jump_000_1EB6
    inc d

Jump_000_1EB6::
    ld a, $A0
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a

Jump_000_1EC1::
    push de
    push hl
    ld bc, $140D

Jump_000_1EC6::
    push hl
    push bc

Jump_000_1EC8::
    di

Jump_000_1EC9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1EC9
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1EDF
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1EDF::
    inc de
    dec b
    jr nz, Jump_000_1EC8
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1EF5
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1EC6

Jump_000_1EF5::
    pop hl
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld bc, $140D

Jump_000_1F0F::
    push hl
    push bc

Jump_000_1F11::
    di

Jump_000_1F12::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1F12
    ld a, [de]
    and a, $07
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1F2A
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1F2A::
    inc de
    dec b
    jr nz, Jump_000_1F11
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1F40
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1F0F

Jump_000_1F40::
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; A is first passed through MapIndexViaPartyList; then HL = sA000 + A * $A5 + C as in SRAMRecordAddress
; 138 call sites from 100 routines (e.g. StoreTemp0ToSRAMRecordBytes, LoadSRAMRecordBytesToTemp0, DebugBattleSetup_Update_Sub01_Sub01, ShowRecordSkillPageNames_Bank03, ...)
; points at: sRecords
SRAMRecordAddressMapped::
Func_000_1F49:: ; address name
    push bc
    call MapIndexViaPartyList
    ld c, $A5
    call Multiply8
    ld bc, sRecords
    add hl, bc
    pop bc
    ld a, c
    add_a_to_hl
    ret

; copies B bytes from hFFC6 to field C of SRAM record A (SRAMRecordAddressMapped); HL and DE preserved (E-0122)
; no direct call (reached through a table, a jump or a vector)
; points at: hTemp0
StoreTemp0ToSRAMRecordBytes:: ; heuristic: follows a terminator; C0
Func_000_1F5E:: ; address name
    push hl
    push de
    call SRAMRecordAddressMapped
    ld de, hTemp0

Jump_000_1F66::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_000_1F66
    pop de
    pop hl
    ret

; copies B bytes of field C of SRAM record A to hFFC6; HL and DE preserved (E-0122)
; no direct call (reached through a table, a jump or a vector)
; points at: hTemp0
LoadSRAMRecordBytesToTemp0:: ; heuristic: follows a terminator; C0
Func_000_1F6F:: ; address name
    push hl
    push de
    call SRAMRecordAddressMapped
    ld de, hTemp0

Jump_000_1F77::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_1F77
    pop de
    pop hl
    ret

; A = record, C = offset; hFFC6 = the byte at sA000 + A * $A5 + C; HL preserved
; 102 call sites from 78 routines (e.g. LoadPlayerAndFollowerSpriteGraphics_Sub01, PersonalityIndexOfRecord, MoveIncapacitatedPartyMembersBack, BuildPartyStatusWindowRows, ...)
; writes: hTemp0
LoadSRAMRecordByte::
Func_000_1F80:: ; address name
    push hl
    call SRAMRecordAddress
    ld a, [hl]
    ldh [hTemp0], a
    pop hl
    ret

; like LoadSRAMRecordByte but loads the word into hFFC6 (low) and hFFC7 (high)
; 98 call sites from 54 routines (e.g. LoadPlayerAndFollowerSpriteGraphics_Sub01, BuildPartyStatusWindowRows, PartyHasSpeciesLo3CTo5BWithHiSet, GameMode5_Init_Case06_Sub01, ...)
; writes: hTemp0, hTemp1
LoadSRAMRecordWord::
Func_000_1F89:: ; address name
    push hl
    call SRAMRecordAddress
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    pop hl
    ret

; A = record, C = field offset (SRAMRecordAddress): copies three bytes from the record to hFFC6-hFFC8; HL kept (E-0108)
; 3 call sites from 2 routines (e.g. TriggerEventC9IfExpDigitsRepeat, ScriptCommandE8_Run_Case09_Case13_Sub01)
; writes: hTemp0, hTemp1, hTemp2
LoadRecordThreeBytesToTemp0::
Func_000_1F95:: ; address name
    push hl
    call SRAMRecordAddress
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl+]
    ldh [hTemp2], a
    pop hl
    ret

; A = record number, C = offset (see SRAMRecordAddress): copies 10 bytes from the SRAM record to wC8CF; when the first byte is $FF it writes $98,$98,$98,$90,$90 instead and sets carry; DE and HL are preserved
; 29 call sites from 25 routines (e.g. LoadRecordListNameTiles, Func_004_58C2_Case13, ScriptCommand87_Run_Case01, ScriptCommandEB_Run_Case05_Case32_Sub01, ...)
; points at: wNameGlyphBuf
CopyRecordNameToNameGlyphBuf::
Func_000_1FA4:: ; address name
    push hl
    push de
    call SRAMRecordAddress
    ld de, wNameGlyphBuf
    ld b, $0A
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_1FBD

Jump_000_1FB3::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_1FB3
    pop de
    pop hl
    sub a, a
    ret

Jump_000_1FBD::
    ld l, e
    ld h, d
    ld [hl], $98
    inc hl
    ld [hl], $98
    inc hl
    ld [hl], $98
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $90
    pop de
    pop hl
    scf
    ret

; A = record, C = offset; HL = sA000 + A * $A5 + C (records are $A5 bytes)
; 90 call sites from 59 routines (e.g. CopyRecordNameToNameGlyphBuf, LoadSRAMRecordWord, LoadRecordThreeBytesToTemp0, LoadSRAMRecordByte, ...)
; points at: sRecords
SRAMRecordAddress::
Func_000_1FD1:: ; address name
    push bc
    ld c, $A5
    call Multiply8
    ld bc, sRecords
    add hl, bc
    pop bc
    ld a, c
    add_a_to_hl
    ret

; DE = monster id, HL = VRAM destination, C = palette slot: decompresses the id's picture stream (MonsterPictureTable, bank $38) to HL; on CGB also copies the 16-byte palette from MonsterPaletteTable (bank $7B) to slot C of wC49F
; 19 call sites from 16 routines (e.g. DebugMonsterPictureViewer_Update, DrawRecordMonsterPictureForMenuSelectedMember, Func_003_4FBB_Case01, ScriptCommandF6_Run_Case10_Case02, ...)
; reads: wIsCGB
; writes: rROMB0
; points at: wBGPaletteBuffer
LoadMonsterPicture::
Func_000_1FE3:: ; address name
    push bc
    push de
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    ld de, $4001
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    pop af
    ld [rROMB0], a
    pop hl
    call DecompressToVRAM
    pop de
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, $4209
    add hl, de
    ld e, l
    ld d, h
    ld b, $7B
    ld a, c
    sla a
    sla a
    sla a
    ld hl, wBGPaletteBuffer
    add_a_to_hl
    ld c, $10
    call CopyFromBank
    ret

; copies the 6 x 6 picture attribute block of species DE (table $447E in bank $38, default $20E9) plus hFFC6 to HL in WRAM bank 2 (E-0128)
; 2 call sites from 2 routines (e.g. DrawRecordMonsterPictureForMenuSelectedMember, Func_003_4FBB_Case01)
; reads: hTemp0
; writes: rROMB0, rSVBK
LoadMonsterPictureAttributeBlock::
Func_000_2038:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, $447E
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr z, Jump_000_2056
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr Jump_000_205B

Jump_000_2056::
    ld de, $20E9
    ld a, $00

Jump_000_205B::
    ld [rROMB0], a
    pop hl
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

Jump_000_2066::
    push hl
    push bc

Jump_000_2068::
    di
    ld a, [de]
    push bc
    ld c, a
    ldh a, [hTemp0]
    add a, c
    pop bc
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, Jump_000_2068
    pop bc
    pop hl
    dec c
    jr z, Jump_000_2087
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_2066

Jump_000_2087::
    ld a, $00
    ldh [rSVBK], a
    pop af
    ld [rROMB0], a
    ret

; DE = monster id, HL = BG map address, hFFC6 = palette number: writes the 6 x 6 attribute bytes (plus hFFC6) of the id's MonsterAttributeMapTable entry to VRAM bank 1 (a default pattern when the entry is zero)
; 15 call sites from 13 routines (e.g. DebugMonsterPictureViewer_Update, ScriptCommandF6_Run_Case10_Case02, ScriptCommandE8_Run_Case0D_Case06, ScriptCommandE8_Run_Case09_Case05, ...)
; reads: hTemp0
; writes: rROMB0, rVBK
LoadMonsterPictureAttributes::
Func_000_2090:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, $447E
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr z, Jump_000_20AE
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr Jump_000_20B3

Jump_000_20AE::
    ld de, $20E9
    ld a, $00

Jump_000_20B3::
    ld [rROMB0], a
    ld a, $01
    ldh [rVBK], a
    pop hl
    ld bc, $0606

Jump_000_20BE::
    push hl
    push bc

Jump_000_20C0::
    di
    ld a, [de]
    push bc
    ld c, a
    ldh a, [hTemp0]
    add a, c
    pop bc
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, Jump_000_20C0
    pop bc
    pop hl
    dec c
    jr z, Jump_000_20DF
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_20BE

Jump_000_20DF::
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop af
    ld [rROMB0], a
    ret
    ds $24, $00

; DE = destination: writes wC8C1 as tile $E0 + digit, or blank tile $C3 when it is 0, then wC8C2 as $E0 + digit; DE ends past the second tile; HL kept (E-0077)
; 7 call sites from 7 routines (e.g. BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, PauseMenu_State3_Shared02, WriteByteAAsTwoDigitTiles, ...)
WriteTwoDigitTilesFromWC8C1::
Func_000_210D:: ; address name
    push hl
    ld hl, wDigits + $1
    ld a, [hl+]
    or a, a
    jr z, Jump_000_2119
    add a, $E0
    jr Jump_000_211B

Jump_000_2119::
    ld a, $C3

Jump_000_211B::
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    pop hl
    ret

; DE = destination: writes three tile ids for the digits in wC8C0-wC8C2 (see HLToDecimalDigits): $E0 + digit, with leading zeros as $C3; DE ends past the third
; 36 call sites from 19 routines (e.g. BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, PauseMenu_State3_Shared02, PauseMenu_State3_Case05_Case00, ...)
; points at: wDigits
WriteDecimalDigitTiles::
Func_000_2123:: ; address name
    push hl
    ld c, $00
    ld hl, wDigits
    ld a, [hl+]
    or a, a
    jr z, Jump_000_2133
    add a, $E0
    ld c, $01
    jr Jump_000_2135

Jump_000_2133::
    ld a, $C3

Jump_000_2135::
    ld [de], a
    inc de
    ld a, [hl+]
    bit 0, c
    jr nz, Jump_000_213F
    or a, a
    jr z, Jump_000_2145

Jump_000_213F::
    add a, $E0
    ld c, $01
    jr Jump_000_2147

Jump_000_2145::
    ld a, $C3

Jump_000_2147::
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    pop hl
    ret

; only called from WithSRAMDraw4ACEAnd4BE8_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMDraw4ACEAnd4BE8_Sub01)
; points at: hTemp3
WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01::
Func_000_214F:: ; address name
    push hl
    ld c, $00
    ld hl, hTemp3
    ld a, [hl-]
    and a, $0F
    jr z, Jump_000_2160
    ld c, $01
    add a, $E0
    jr Jump_000_2162

Jump_000_2160::
    ld a, $C3

Jump_000_2162::
    ld [de], a
    inc de
    ld b, $03

Jump_000_2166::
    ld a, [hl]
    srl a
    srl a
    srl a
    srl a
    bit 0, c
    jr nz, Jump_000_2177
    and a, $0F
    jr z, Jump_000_217D

Jump_000_2177::
    ld c, $01
    add a, $E0
    jr Jump_000_217F

Jump_000_217D::
    ld a, $C3

Jump_000_217F::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2186
    ld c, $01

Jump_000_2186::
    inc b
    ld a, [hl-]
    and a, $0F
    bit 0, c
    jr nz, Jump_000_2192
    and a, $0F
    jr z, Jump_000_2198

Jump_000_2192::
    ld c, $01
    add a, $E0
    jr Jump_000_219A

Jump_000_2198::
    ld a, $C3

Jump_000_219A::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2166
    pop hl
    ret

; DE = VRAM destination: for each byte of the string at wC8CF (up to 11, stopping at $F0), copies the 16-byte tile at ROM bank $1F, $4010 + 16 * character to [DE]; the characters $8D and $8E also OR a 16-byte overlay from $48E0 or $48F0 into the previous tile
; 68 call sites from 31 routines (e.g. LoadRecordListNameTiles, DebugResultsDisplay_Update_Sub02_Sub01, DrawMonsterNameForWordAtDE_Bank01, DebugAutomap_Update_Sub03, ...)
; reads: rSTAT
; writes: rROMB0
; points at: wNameGlyphBuf
CopyGlyphTilesToVRAM::
Func_000_21A1:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    ld hl, wNameGlyphBuf
    ld c, $0B

Jump_000_21AF::
    push bc
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_000_21BB
    pop bc
    pop af
    ld [rROMB0], a
    ret

Jump_000_21BB::
    push hl
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld bc, $4010
    add hl, bc
    ld b, $10

Jump_000_21CC::
    di

Jump_000_21CD::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_21CD
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_000_21CC
    pop hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_000_21E6
    cp a, $8E
    jr z, Jump_000_21ED
    jr Jump_000_2221

Jump_000_21E6::
    inc hl
    push hl
    ld hl, $48E0
    jr Jump_000_21F2

Jump_000_21ED::
    inc hl
    push hl
    ld hl, $48F0

Jump_000_21F2::
    ld b, $10
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a

Jump_000_21FC::
    ld a, [hl+]
    ld c, a
    di

Jump_000_21FF::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_21FF
    ld a, [de]
    ei
    or a, c
    push af
    ld a, b
    cp a, $0D
    jr nz, Jump_000_2212
    pop af
    and a, $FD
    push af

Jump_000_2212::
    di

Jump_000_2213::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_2213
    pop af
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_000_21FC
    pop hl

Jump_000_2221::
    pop bc
    dec c
    jp nz, Jump_000_21AF
    pop af
    ld [rROMB0], a
    ret

; fills wC8CF with five $90 glyphs and an $F0 terminator and draws it at vTiles1 + $500, $550 and $5A0 (three blank 5-tile slots); enables SRAM (rRAMG = $0A); then for each of the wC6FD record numbers listed at wC6FE copies that record's name (CopyRecordNameToNameGlyphBuf, C = 1) and draws it into the next slot ($50 bytes apart); disables SRAM after the loop. With wC6FD = 0 it returns with SRAM still enabled (E-0059)
; 22 call sites from 22 routines (e.g. InitFieldScreen, RunFieldReturnPhase_Case02, PauseMenu_State3_Case00_Case00, RefreshRecordListAndNameTiles, ...)
; reads: wPartyCount
; writes: wNameGlyphBuf, rRAMG
; points at: wPartyList
LoadRecordListNameTiles::
Func_000_222B:: ; address name
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
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
    ret z
    ld b, a
    ld hl, wPartyList
    ld de, vTiles1 + $500

Jump_000_2264::
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop de
    push de
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $50
    add a, e
    ld e, a
    jr nc, Jump_000_227F
    inc d

Jump_000_227F::
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_000_2264
    xor a, a
    ld [rRAMG], a
    ret

; only called from LoadPlayerAndFollowerSpriteGraphics (E-0047)
; 2 call sites from 1 routine (e.g. LoadPlayerAndFollowerSpriteGraphics)
; reads: wPartyCount, hTemp0, hTemp4, hTemp5, hTemp2, hTemp3, wIsCGB, hTemp1
; writes: hTemp4, hTemp5, hTemp2, hTemp3, rRAMG, rROMB0
; points at: wPartyList, wOBJPaletteBuffer
LoadPlayerAndFollowerSpriteGraphics_Sub01::
Func_000_228A:: ; address name
    ld a, [wPartyCount]
    or a, a
    ret z
    ld b, a
    ld hl, wPartyList + $3
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld hl, vTiles0 + $100
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld de, wPartyList

Jump_000_22A5::
    push bc
    push de
    ld a, $0A
    ld [rRAMG], a
    push de
    ld a, [de]
    ld c, $55
    call LoadSRAMRecordByte
    pop de
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_000_2304
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp4]
    ld c, a
    ldh a, [hTemp5]
    ld b, a
    ld a, $FF
    ld [bc], a
    inc bc
    ld [bc], a
    ld de, Data_07E_545E
    ld b, $7E
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jp z, Jump_000_2378
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub a, b
    inc a
    add a, a
    add a, a
    add a, a
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld a, $C8
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_000_22FB
    inc d

Jump_000_22FB::
    ld b, $7E
    ld c, $08
    call CopyFromBank
    jr Jump_000_2378

Jump_000_2304::
    ld a, [de]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld l, e
    ld h, d
    ldh a, [hTemp4]
    ld c, a
    ldh a, [hTemp5]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    add hl, hl
    add hl, de
    ld de, $4EAA
    add hl, de
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $04
    ld [rROMB0], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    pop af
    ld [rROMB0], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_2378
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub a, b
    inc a
    add a, a
    add a, a
    add a, a
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    pop hl
    ld c, $08
    call CopyFromBank

Jump_000_2378::
    ldh a, [hTemp3]
    inc a
    ldh [hTemp3], a
    ldh a, [hTemp4]
    add a, $02
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, $00
    ldh [hTemp5], a
    pop de
    inc de
    pop bc
    dec b
    jp nz, Jump_000_22A5
    ret

; A = SRAM record number: grades the record's bytes at offsets $6F, $72 and $70 with GradeTemp0 (g1, g2, g3, each 0-2) and returns A = 9 * g1 + 3 * g2 + g3, a number from 0 to 26. The status screen passes this to the string database as a personality-name index (category 7, 27 names), so it is the monster's personality index (E-0031)
; 4 call sites from 4 routines (e.g. DrawItemTargetStatPreview, ScriptCommand62_Run_Case00, ShowRecordPersonalityName, BuildItemScreenForWItemId_BankF1_Sub01)
; reads: hTemp6
; writes: hTemp6
PersonalityIndexOfRecord::
Func_000_2391:: ; address name
    ldh [hTemp6], a
    ld c, $6F
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, $09
    call Multiply8
    ld b, l
    ldh a, [hTemp6]
    ld c, $72
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ldh a, [hTemp6]
    ld c, $70
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, c
    add a, b
    ret

; C = 0 when hFFC6 >= $C0, 1 when hFFC6 >= $40, otherwise 2
; 3 call sites from 1 routine (e.g. PersonalityIndexOfRecord)
; reads: hTemp0
GradeTemp0::
Func_000_23BD:: ; address name
    ldh a, [hTemp0]
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

; writes the packed BCD number in hFFC6-hFFC9 (most significant byte last) as digits at DE without leading zeros, then $F0; zero writes a single 0 (E-0127)
; 9 call sites from 7 routines (e.g. ScriptCommand84_Run_Case06, ScriptCommand80_Run_Case00, ScriptCommand82_Run_Case01_Case00, ScriptCommand82_Run_Case03_Case00, ...)
; reads: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp2
WritePackedBCDNoLeadingZeros::
Func_000_23CA:: ; address name
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hTemp1]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hTemp2]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hTemp3]
    or a, a
    jr nz, Jump_000_23E4
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ret

Jump_000_23E4::
    ld c, $00
    ldh a, [hTemp3]
    or a, a
    jr z, Jump_000_23EF
    ld [de], a
    inc de
    ld c, $01

Jump_000_23EF::
    ld b, $03
    ld hl, hTemp2

Jump_000_23F4::
    ld a, [hl]
    swap a
    and a, $0F
    bit 0, c
    jr nz, Jump_000_2400
    or a, a
    jr z, Jump_000_2404

Jump_000_2400::
    ld [de], a
    inc de
    ld c, $01

Jump_000_2404::
    ld a, [hl]
    and a, $0F
    bit 0, c
    jr nz, Jump_000_240E
    or a, a
    jr z, Jump_000_2412

Jump_000_240E::
    ld [de], a
    inc de
    ld c, $01

Jump_000_2412::
    dec hl
    dec b
    jr nz, Jump_000_23F4
    ld a, $F0
    ld [de], a
    ret

; HL = $4558 + 2 * A, switches to ROM bank 8 and continues with the shared read at Jump_000_2447 (E-0126)
; 1 call site from 1 routine (e.g. Func_004_58C2_Case13)
; writes: rROMB0
ReadBank08Table4558WordForA::
Func_000_241A:: ; address name
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $58
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a
    jr Jump_000_2447

; A = item number: with ROM bank $08 mapped, copies that string of StringTable_ItemNames, including its $F0 terminator, to DE; restores the bank (E-0071)
; 15 call sites from 11 routines (e.g. ScriptCommand86_Run_Case00, ScriptCommand84_Run_Case06, ScriptCommand81_Run_Case00, ScriptCommand80_Run_Case00, ...)
; writes: rROMB0
CopyItemNameToDE::
Func_000_2431:: ; address name
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $47
    ld h, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a

Jump_000_2447::
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

Jump_000_244C::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_000_244C
    pop af
    ld [rROMB0], a
    ret

; A = key slot, or $FE: writes 'Magic Key' to DE; otherwise writes the name of key A in wKeyList (4-byte entries from $C708): the word numbered byte 0 + 1, then the word numbered byte 1 + $11 (CopyKeyNameWordToDE), then $F0 (E-0090)
; 7 call sites from 7 routines (e.g. DebugAutomap_Update_Sub03, PauseMenu_State3_Shared06, PauseMenu_State3_Case01_Case03, PauseMenu_State3_Shared07, ...)
WriteKeyNameToDE::
Func_000_2458:: ; address name
    cp a, $FE
    jr nz, Jump_000_2482
    ld a, $16
    ld [de], a
    inc de
    ld a, $24
    ld [de], a
    inc de
    ld a, $2A
    ld [de], a
    inc de
    ld a, $2C
    ld [de], a
    inc de
    ld a, $26
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    ld a, $14
    ld [de], a
    inc de
    ld a, $28
    ld [de], a
    inc de
    ld a, $3C
    ld [de], a
    inc de
    jr Jump_000_249E

Jump_000_2482::
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl+]
    inc a
    push hl
    call CopyKeyNameWordToDE
    pop hl
    dec de
    ld a, [hl]
    add a, $11
    call CopyKeyNameWordToDE
    dec de

Jump_000_249E::
    ld a, $F0
    ld [de], a
    ret

; A = word number: with ROM bank $09 mapped, copies that string of the bank-$09 database's category 3 (Data_009_4078: Ylw, Plain, Green, ... then Slime, Draco, Beast, ... Cave, Isle) with its $F0 to DE; restores the bank (E-0090)
; 5 call sites from 3 routines (e.g. WriteKeyNameToDE, ShowSaveFileInfoWindow, CopyKeyNameWordToDE_Bank16)
; writes: rROMB0
CopyKeyNameWordToDE::
Func_000_24A2:: ; address name
    add a, a
    ld hl, $4078
    add_a_to_hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $09
    ld [rROMB0], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

Jump_000_24B9::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_000_24B9
    pop af
    ld [rROMB0], a
    ret

; returns A unchanged when wC58A is non-zero and wC5DB is 4; otherwise A = the byte at wC6FE + (A & $7F); HL is clobbered in that case
; 4 call sites from 4 routines (e.g. SRAMRecordAddressMapped, DrawItemTargetStatPreview, MapIndexViaPartyListKeepHL, BuildItemScreenForWItemId_BankF1_Sub01)
; reads: wLinkMode, wGameMode
; points at: wPartyList
MapIndexViaPartyList::
Func_000_24C5:: ; address name
    push bc
    ld b, a
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_000_24D7
    ld a, [wGameMode]
    cp a, $04
    jr nz, Jump_000_24D7
    ld a, b
    pop bc
    ret

Jump_000_24D7::
    ld a, b
    pop bc
    ld hl, wPartyList
    and a, $7F
    add_a_to_hl
    ld a, [hl]
    ret

; on CGB copies $40 bytes from DE in bank B (CopyFromBank) into wBGPaletteBuffer and sets wC526 = $7F (upload request) (E-0117)
; 2 call sites from 2 routines (e.g. LoadMapHeader, LoadSpecialMapHeader)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest
; points at: wBGPaletteBuffer
LoadBGPaletteBufferFromBank::
Func_000_24E5:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; HL = BG map address. With col = (hScrollX / 8) & $1F: when col >= 12 and (L & $1F) < col - 12 (a column of the 20-column view that wrapped past entry 31), HL -= $20 and A = $FF; otherwise HL is unchanged and A = 0. BC and DE kept (E-0059)
; 73 call sites from 57 routines (e.g. ScriptCommandF7_Run_Case12_Sub03, ScriptCommandF7_Run_Case02_Sub03, DrawC5BEC6AtScrollOffsetDE_Bank15, ScriptCommandED_Run_Case04_Case0E_Sub01, ...)
; reads: hScrollX
StepBGMapAddressBackOnScrollWrap::
Func_000_24F8:: ; address name
    push bc
    push de
    push hl
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    and a, $1F
    ld b, a
    ld a, $20
    sub a, b
    ld b, a
    ld a, $14
    sub a, b
    bit 7, a
    jr nz, Jump_000_2528
    pop hl
    push hl
    ld d, a
    ld a, l
    and a, $1F
    cp a, d
    jr nc, Jump_000_2528
    pop hl
    pop de
    pop bc
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, $FF
    ret

Jump_000_2528::
    pop hl
    pop de
    pop bc
    xor a, a
    ret

; hFFD2/hFFD3 = -(hScrollX - 9) - 1 and hFFD4/hFFD5 = -(hScrollY - $11) - 1 as 16-bit values; returns early in game mode 1 when wC5DC & $0F = 6
; 11 call sites from 3 routines (e.g. GameFrameUpdate, RunFieldActionRequestActionIfBit7_Case01, ScriptCommand77_Run_Case03)
; reads: wGameMode, wModeState
; writes: hSpriteScrollXLo, hSpriteScrollXHi, hSpriteScrollYLo, hSpriteScrollYHi
; points at: hScrollX, hScrollY
ComputeSpriteScrollOffsets::
Func_000_252D:: ; address name
    ld a, [wGameMode]
    cp a, $01
    jr nz, Jump_000_253C
    ld a, [wModeState]
    and a, $0F
    cp a, $06
    ret z

Jump_000_253C::
    ld hl, hScrollX
    ld a, [hl+]
    sub a, $09
    cpl
    ldh [hSpriteScrollXLo], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [hSpriteScrollXHi], a
    ld hl, hScrollY
    ld a, [hl+]
    sub a, $11
    cpl
    ldh [hSpriteScrollYLo], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [hSpriteScrollYHi], a
    ret

Jump_000_255B::
    push af
    push bc
    push de
    push hl
    farcall ComputeSpriteScrollOffsets_Sub01
    pop hl
    pop de
    pop bc
    pop af
    reti

Jump_000_256A::
    push af
    push hl
    push de
    ldh a, [rSVBK]
    ld d, a
    xor a, a
    ldh [rSVBK], a
    push de
    ld a, [wSTATSplitEnable]
    and a, $03
    rst $00
    dw ComputeSpriteScrollOffsets_Case00
    dw ComputeSpriteScrollOffsets_Case01
    dw ComputeSpriteScrollOffsets_Case02
    dw ComputeSpriteScrollOffsets_Case03

; entry 0 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; writes: rSVBK
ComputeSpriteScrollOffsets_Case00::
Jump_000_2582:: ; address name
    pop af
    ldh [rSVBK], a
    pop de
    pop hl
    pop af
    reti

; entry 1 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; writes: rSVBK
ComputeSpriteScrollOffsets_Case01::
Jump_000_2589:: ; address name
    jr ComputeSpriteScrollOffsets_Case00

; entry 2 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; reads: rLY, rLYC, hScrollX
; writes: rSCX, rLYC, rSVBK
; points at: wBGPaletteCopy
ComputeSpriteScrollOffsets_Case02::
Jump_000_258B:: ; address name
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCX], a
    ldh a, [rLYC]
    add a, $02
    cp a, $90
    jr c, Jump_000_25A6
    ldh a, [hScrollX]
    ldh [rSCX], a
    ld a, $00

Jump_000_25A6::
    ldh [rLYC], a
    jr ComputeSpriteScrollOffsets_Case00

; entry 3 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; reads: rLY, rLYC, hScrollY
; writes: rSCY, rLYC, rSVBK
; points at: wBGPaletteCopy
ComputeSpriteScrollOffsets_Case03::
Jump_000_25AA:: ; address name
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCY], a
    ldh a, [rLYC]
    add a, $02
    cp a, $81
    jr c, Jump_000_25C5
    ldh a, [hScrollY]
    ldh [rSCY], a
    ld a, $00

Jump_000_25C5::
    ldh [rLYC], a
    jr ComputeSpriteScrollOffsets_Case00

; DE = string table (see LookupString); clears the request area with FillTilesFromRequest, copies the position wC52D/wC52E to wC531/wC532 and wC535/wC536, points wC533/wC534 and wC537/wC538 at the string, sets wC52B = 1 and clears wC52C and wC54F; the string is drawn later by the routine at $2620
; 51 call sites from 51 routines (e.g. BeginStringDisplay_Bank07, BeginStringDisplay_Bank08, BeginStringDisplay_Bank09, BeginStringDisplay_Bank0B, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi
; writes: wTextGlyphDestLo, wTextLineStartLo, wTextGlyphDestHi, wTextLineStartHi, wTextPosLo, wTextStartPosLo, wTextPosHi, wTextStartPosHi, ...
BeginStringDisplay::
Func_000_25C9:: ; address name
    push de
    call FillTilesFromRequest
    ld a, [wTextWindowTileLo]
    ld [wTextGlyphDestLo], a
    ld [wTextLineStartLo], a
    ld a, [wTextWindowTileHi]
    ld [wTextGlyphDestHi], a
    ld [wTextLineStartHi], a
    pop de
    call LookupString
    ld a, e
    ld [wTextPosLo], a
    ld [wTextStartPosLo], a
    ld a, d
    ld [wTextPosHi], a
    ld [wTextStartPosHi], a
    ld a, $01
    ld [wTextFlags], a
    xor a, a
    ld [wTextControl], a
    ld [wTextLineCount], a
    ret

; DE = string table (see LookupString); copies the string, including its $F0 terminator, to the address in wC53D/wC53E
; 29 call sites from 29 routines (e.g. CopyStringToBuffer_Bank08, CopyStringToBuffer_Bank09, CopyStringToBuffer_Bank0E, CopyStringToBuffer_Bank28, ...)
; reads: wStringDestLo, wStringDestHi
CopyStringToBuffer::
Func_000_25FE:: ; address name
    call LookupString
    ld a, [wStringDestLo]
    ld l, a
    ld a, [wStringDestHi]
    ld h, a

Jump_000_2609::
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $F0
    jr nz, Jump_000_2609
    ret

; sets bit 1 of wC52B, then runs the display step at $2620 until wC52B is zero
; 17 call sites from 17 routines (e.g. ShowString_Bank07, ShowString_Bank08, ShowString_Bank09, ShowString_Bank0B, ...)
; reads: wTextFlags
; points at: wTextFlags
RunStringDisplayToEnd::
Func_000_2611:: ; address name
    ld hl, wTextFlags
    set 1, [hl]

Jump_000_2616::
    call StepStringDisplayUntilDone
    ld a, [wTextFlags]
    or a, a
    jr nz, Jump_000_2616
    ret

; runs the string display step (Func_000_2637) repeatedly while bit 7 of wC52C stays set, setting bit 1 of wC52B each time (E-0122)
; 3 call sites from 3 routines (e.g. VBlankHandler, RunStringDisplayToEnd, RunFrameTickFadeAndCounter_Bank1B)
; reads: wTextControl, wStringBank, wTextFlags, wFrameCounterLo, wTextLastChar, wJoypadPressedRepeat, wLinkJoypadPressedRepeat, wTextYesNoResult, ...
; writes: rROMB0, wTextYesNoResult, wTextRepeatCount, wTextDelayCounter, wTextLineCount, wTextPosLo, wTextPosHi
; points at: wTextFlags, wTextLineCount, wTextControl, wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
StepStringDisplayUntilDone::
Func_000_2620:: ; address name
    ld a, [wTextControl]
    bit 7, a
    jr z, StepStringDisplayUntilDone_Sub01

Jump_000_2627::
    ld hl, wTextFlags
    set 1, [hl]
    call StepStringDisplayUntilDone_Sub01
    ld a, [wTextControl]
    bit 7, a
    jr nz, Jump_000_2627
    ret

; only called from StepStringDisplayUntilDone (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone)
; reads: wStringBank, wTextControl, wTextFlags, wFrameCounterLo, wTextLastChar, wJoypadPressedRepeat, wLinkJoypadPressedRepeat, wTextYesNoResult, ...
; writes: rROMB0, wTextYesNoResult, wTextRepeatCount, wTextDelayCounter, wTextLineCount, wTextPosLo, wTextPosHi
; points at: wTextFlags, wTextLineCount, wTextControl, wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
StepStringDisplayUntilDone_Sub01::
Func_000_2637:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wStringBank]
    ld [rROMB0], a
    ld a, [wTextControl]
    bit 2, a
    jp nz, Jump_000_2847
    ld a, [wTextFlags]
    or a, a
    jp z, Jump_000_2875
    bit 5, a
    jr z, Jump_000_266E
    ld c, $BD
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, Jump_000_265F
    ld c, $B4

Jump_000_265F::
    ld hl, $0060
    call AddHLToTextCursorTextCursorLo
    ld b, $09
    call AdvanceBGMapColumnsByB
    ld a, c
    call WriteVRAMByte

Jump_000_266E::
    ld a, [wTextFlags]
    bit 2, a
    jp z, Jump_000_2764
    ld a, [wTextLastChar]
    cp a, $E6
    jr z, Jump_000_2685
    ld a, [wTextLastChar]
    cp a, $FF
    jp nz, Jump_000_274A

Jump_000_2685::
    ld a, [wJoypadPressedRepeat]
    ld b, a
    ld a, [wLinkJoypadPressedRepeat]
    or a, b
    bit 6, a
    jr z, Jump_000_26A2
    ld a, [wTextYesNoResult]
    and a, $01
    xor a, $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_000_26B5

Jump_000_26A2::
    bit 7, a
    jr z, Jump_000_26B5
    ld a, [wTextYesNoResult]
    and a, $01
    xor a, $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect

Jump_000_26B5::
    ld c, $BB
    ld b, $C3
    ld a, [wTextYesNoResult]
    or a, a
    jr z, Jump_000_26C3
    ld c, $C3
    ld b, $BB

Jump_000_26C3::
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, Jump_000_26CE
    ld c, $C3
    ld b, $C3

Jump_000_26CE::
    push bc
    ld hl, $0120
    call BGMapAddressAtScrollPlusHL
    ld b, $0F
    call AdvanceBGMapColumnsByB
    pop bc
    ld a, c
    call WriteVRAMByte
    push bc
    ld hl, $0160
    call BGMapAddressAtScrollPlusHL
    ld b, $0F
    call AdvanceBGMapColumnsByB
    pop bc
    ld a, b
    call WriteVRAMByte
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    bit 0, a
    jr z, Jump_000_2711
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_000_2716
    ld a, [wTextLastChar]
    cp a, $E6
    jp z, Jump_000_271B
    ld a, $69
    call QueueSoundEffect
    jr Jump_000_271B

Jump_000_2711::
    bit 1, a
    jp z, Jump_000_2875

Jump_000_2716::
    ld a, $01
    ld [wTextYesNoResult], a

Jump_000_271B::
    ld hl, wTextFlags
    res 2, [hl]
    res 1, [hl]
    push de
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
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
    pop de
    call DrawScreenBufferToBGMapWithAttrs
    jp Jump_000_2875

Jump_000_274A::
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jp z, Jump_000_2875
    ld hl, wTextFlags
    res 2, [hl]
    res 1, [hl]
    call ShowTextContinueMark
    jp Jump_000_2875

Jump_000_2764::
    bit 6, a
    jr z, Jump_000_278B
    ld a, [wTextRepeatCount]
    dec a
    ld [wTextRepeatCount], a
    or a, a
    jp z, Jump_000_2780
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jp z, Jump_000_2875

Jump_000_2780::
    ld hl, wTextFlags
    res 6, [hl]
    call ShowTextContinueMark
    jp Jump_000_2875

Jump_000_278B::
    bit 7, a
    jr z, Jump_000_27A2
    ld a, [wTextDelayCounter]
    dec a
    ld [wTextDelayCounter], a
    or a, a
    jp nz, Jump_000_2875
    ld hl, wTextFlags
    res 7, [hl]
    jp Jump_000_2875

Jump_000_27A2::
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, [hl]
    cp a, $8D
    jr z, Jump_000_2816
    cp a, $8E
    jr z, Jump_000_2816
    cp a, $E0
    jr nc, Jump_000_282C
    ld a, [wTextFlags]
    bit 1, a
    jr nz, Jump_000_27E5
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jr z, Jump_000_27CF
    ld hl, wTextControl
    set 7, [hl]

Jump_000_27CF::
    ld a, [wBattleKindFlags]
    ld b, a
    ld a, [wTextFlags]
    bit 3, a
    jr z, Jump_000_27DE
    ld a, [wTextControlArg]
    ld b, a

Jump_000_27DE::
    ld a, [wTextLineCount]
    cp a, b
    jp c, Jump_000_2875

Jump_000_27E5::
    xor a, a
    ld [wTextLineCount], a
    ld hl, wTextControl
    res 1, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    cp a, $E0
    jr nc, Jump_000_282C
    call StepStringDisplayUntilDone_Sub01_Sub01
    ld a, [wTextControl]
    bit 0, a
    jr z, Jump_000_2875
    ld a, b
    cp a, $90
    jr z, Jump_000_2875
    cp a, $9A
    jr z, Jump_000_2875
    ld a, [wTextBeepSound]
    call QueueSoundEffect
    ld hl, wTextControl
    set 1, [hl]
    jr Jump_000_2875

Jump_000_2816::
    ld a, [wTextPosLo]
    add a, $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc a, $00
    ld [wTextPosHi], a
    ld a, [hl]
    call CallFunc28BDInBank1F
    jr Jump_000_2875

Jump_000_282C::
    ld a, [wTextPosLo]
    add a, $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc a, $00
    ld [wTextPosHi], a
    ld a, [hl]
    call StepStringDisplayUntilDone_Sub01_Sub02
    ld hl, wTextControl
    res 1, [hl]
    jr Jump_000_2875

Jump_000_2847::
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
    jr nz, Jump_000_2875
    ld hl, wTextControl
    res 2, [hl]

Jump_000_2875::
    ld hl, wTextLineCount
    inc [hl]
    pop af
    ld [rROMB0], a
    ret

; only called from StepStringDisplayUntilDone_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_Sub01)
; reads: rSTAT
; writes: rROMB0, wTextGlyphDestLo, wTextGlyphDestHi
StepStringDisplayUntilDone_Sub01_Sub01::
Func_000_287E:: ; address name
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call GlyphTileSourceForL
    ld c, $08

Jump_000_288D::
    di

Jump_000_288E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_288E
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, Jump_000_288D
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    pop af
    ld [rROMB0], a
    ret

; L = A; switches to ROM bank $1F, calls Func_000_28BD and restores the bank (E-0122)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_Sub01)
; writes: rROMB0
CallFunc28BDInBank1F::
Func_000_28AB:: ; address name
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call CallFunc28BDInBank1F_Sub01
    pop af
    ld [rROMB0], a
    ret

; only called from CallFunc28BDInBank1F (E-0047)
; 1 call site from 1 routine (e.g. CallFunc28BDInBank1F)
; reads: rSTAT
; writes: wTextGlyphDestLo, wTextGlyphDestHi
CallFunc28BDInBank1F_Sub01::
Func_000_28BD:: ; address name
    call GlyphTileSourceForL
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld b, $10

Jump_000_28CA::
    di
    ld a, b
    cp a, $0D
    jr z, Jump_000_28DB

Jump_000_28D0::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_28D0
    ld a, [de]
    or a, [hl]
    ld [hl+], a
    jr Jump_000_28E6

Jump_000_28DB::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_28DB
    ld a, [de]
    or a, [hl]
    and a, $FD
    ld [hl+], a

Jump_000_28E6::
    ei
    inc de
    dec b
    jr nz, Jump_000_28CA
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ret

; DE = $4010 + 16 * L (the 16-byte tile of glyph L in the font bank); HL = the word at wC531/wC532 (E-0120)
; 2 call sites from 2 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub01, CallFunc28BDInBank1F_Sub01)
; reads: wTextGlyphDestLo, wTextGlyphDestHi
GlyphTileSourceForL::
Func_000_28F4:: ; address name
    ld de, $4010
    ld a, l
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    ld a, [wTextGlyphDestLo]
    ld l, a
    ld a, [wTextGlyphDestHi]
    ld h, a
    ret

; fills a block of tiles at wC52D/wC52E with the 16-byte pattern at $2940: width wC52F, height wC530 tiles (each byte waits for VRAM access); returns at once if either is zero
; 110 call sites from 74 routines (e.g. Func_000_2950_Case12, FillTilesRequest, BeginStringDisplay, DebugResultsDisplay_Update_Sub02_Sub01, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowWidth, wTextWindowRows, rSTAT
; points at: wTextWindowRows
FillTilesFromRequest::
Func_000_290E:: ; address name
    ld hl, wTextWindowRows
    ld a, [hl+]
    or a, [hl]
    ret z
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    ld a, [wTextWindowWidth]
    ld c, a

Jump_000_2920::
    ld a, [wTextWindowRows]
    ld b, a

Jump_000_2924::
    push bc
    ld b, $10
    ld de, $2940

Jump_000_292A::
    di

Jump_000_292B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_292B
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec b
    jr nz, Jump_000_292A
    pop bc
    dec b
    jr nz, Jump_000_2924
    dec c
    jr nz, Jump_000_2920
    ret
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; only called from StepStringDisplayUntilDone_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_Sub01)
; writes: wTextLastChar
StepStringDisplayUntilDone_Sub01_Sub02::
Func_000_2950:: ; address name
    ld [wTextLastChar], a
    sub a, $E0
    rst $00
    dw Func_000_2950_Case00
    dw Func_000_2950_Case00
    dw Func_000_2950_Case00
    dw Func_000_2950_Case00
    dw Func_000_2950_Case00
    dw Func_000_2950_Case05
    dw Func_000_2950_Case06
    dw Func_000_2950_Case07
    dw Func_000_2950_Case08
    dw Func_000_2950_Case09
    dw Func_000_2950_Case0A
    dw Func_000_2950_Case0B
    dw Func_000_2950_Case0C
    dw Func_000_2950_Case0D
    dw Func_000_2950_Case0E
    dw Func_000_2950_Case0F
    dw Func_000_2950_Case10
    dw Func_000_2950_Case11
    dw Func_000_2950_Case12
    dw Func_000_2950_Case13
    dw ClearStringDisplayFlags
    dw Func_000_2950_Case15
    dw Func_000_2950_Case16
    dw Func_000_2950_Case17
    dw Func_000_2950_Case18
    dw Func_000_2950_Case19
    dw Func_000_2950_Case1A
    dw Func_000_2950_Case1B
    dw Func_000_2950_Case1C
    dw Func_000_2950_Case1D
    dw Func_000_2950_Case1E
    dw AcknowledgeTextPrompt

; entry 0 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
Func_000_2950_Case00::
Jump_000_2996:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    call QueueSoundEffect
    ld hl, wTextControl
    set 2, [hl]
    ret

; entry 5 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
Func_000_2950_Case05::
Jump_000_29A8:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    call QueueMusic
    ld hl, wTextControl
    set 2, [hl]
    ret

; entry 6 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextYesNoResult
; points at: wTextControl, wTextFlags
Func_000_2950_Case06::
Jump_000_29BA:: ; address name
    jp AcknowledgeTextPrompt

; entry 7 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextYesNoResult, wTextLastChar
Func_000_2950_Case07::
Jump_000_29BD:: ; address name
    call AcknowledgeTextPrompt
    ld a, $01
    ld [wTextYesNoResult], a
    ld a, $FF
    ld [wTextLastChar], a
    ret

; entry 8 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi
Func_000_2950_Case08::
Jump_000_29CB:: ; address name
    call IncrementTextPosLoWord
    ld d, $00
    ld e, [hl]
    call IncrementTextPosLoWord
    ld c, [hl]
    ld a, [wTextWindowWidth]
    call Multiply8
    add hl, de
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    add hl, de
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ld a, l
    ld [wTextLineStartLo], a
    ld a, h
    ld [wTextLineStartHi], a
    ret

; entry 9 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
Func_000_2950_Case09::
Jump_000_29FA:: ; address name
    call IncrementTextPosLoWord
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_2A1A
    cp a, $60
    jr c, Jump_000_2A16
    cp a, $CC
    jr z, Jump_000_2A16
    cp a, $CF
    jr z, Jump_000_2A16
    cp a, $D6
    jr z, Jump_000_2A16
    call QueueSoundEffect
    ret

Jump_000_2A16::
    call QueueMusic
    ret

Jump_000_2A1A::
    farcall RestartMapMusic
    ret
    db $CD, $78, $12, $C9

; entry 10 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextBeepSound
; points at: wTextControl
Func_000_2950_Case0A::
Jump_000_2A25:: ; address name
    ld hl, wTextControl
    set 0, [hl]
    ld a, $6B
    ld [wTextBeepSound], a
    ret

; entry 11 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextBeepSound
; points at: wTextControl
Func_000_2950_Case0B::
Jump_000_2A30:: ; address name
    ld hl, wTextControl
    set 0, [hl]
    ld a, $6A
    ld [wTextBeepSound], a
    ret

; entry 12 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKindFlags
; writes: wTextDelayCounter
; points at: wTextControl, wTextFlags
Func_000_2950_Case0C::
Jump_000_2A3B:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    ld a, [wBattleKindFlags]
    cp a, $07
    jr z, Jump_000_2A59
    ld hl, $2A66
    add_a_to_hl
    ld a, [hl]
    ld [wTextDelayCounter], a
    ld hl, wTextFlags
    set 7, [hl]
    ret

Jump_000_2A59::
    ld hl, wTextControl
    res 7, [hl]
    ld hl, wTextFlags
    set 2, [hl]
    set 5, [hl]
    ret
    db $06, $0C, $14, $1A, $20, $28, $30

; entry 13 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
Func_000_2950_Case0D::
Jump_000_2A6D:: ; address name
    ld hl, wTextControl
    set 7, [hl]
    ret

; entry 14 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTextCursorLo, wTextCursorHi, wTextLineStartLo, wTextLineStartHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi
; points at: wTextFlags
Func_000_2950_Case0E::
Jump_000_2A73:: ; address name
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    ld a, [wTextCursorLo]
    ld l, a
    ld a, [wTextCursorHi]
    ld h, a
    push bc

Jump_000_2A9C::
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, Jump_000_2A9C
    ld hl, $0020
    call AddHLToTextCursorTextCursorLo
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    call BlankBGMapEntriesRight
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld c, l
    ld b, h
    push de
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    add hl, de
    pop de

Jump_000_2AD2::
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_2AD2
    pop bc
    ld hl, $0040
    call AddHLToTextCursorTextCursorLo

Jump_000_2AE8::
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, Jump_000_2AE8
    ld a, [wTextLineStartLo]
    ld l, a
    ld a, [wTextLineStartHi]
    ld h, a
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ld hl, wTextFlags
    res 1, [hl]
    ret

; entry 15 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi, wTextLineStartLo, wTextLineStartHi, wTextCursorLo, wTextCursorHi, wTextWindowRows
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi, wTextDelayCounter
; points at: wTextFlags
Func_000_2950_Case0F::
Jump_000_2B09:: ; address name
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    add hl, de
    ld a, [wTextLineStartLo]
    ld e, a
    ld a, [wTextLineStartHi]
    ld d, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, d
    or a, e
    jr z, Jump_000_2B45
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ld a, l
    ld [wTextLineStartLo], a
    ld a, h
    ld [wTextLineStartHi], a
    call IncrementTextPosLoWord
    ret

Jump_000_2B45::
    ld a, [wTextCursorLo]
    ld l, a
    ld a, [wTextCursorHi]
    ld h, a
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    call BlankBGMapEntriesRight
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    ld hl, $0020
    call AddHLToTextCursorTextCursorLo
    ld a, e
    add a, b
    ld e, a

Jump_000_2B81::
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, Jump_000_2B81
    ld hl, $0040
    call AddHLToTextCursorTextCursorLo
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    call BlankBGMapEntriesRight
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    ld c, l
    ld b, h
    add hl, de

Jump_000_2BB5::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ei
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_2BB5
    ld hl, wTextFlags
    set 7, [hl]
    ld a, $04
    ld [wTextDelayCounter], a
    ret

; entry 16 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wTextStartPosLo, wTextStartPosHi
; writes: wTextFlags, wTextPosLo, wTextPosHi, wTextControl
Func_000_2950_Case10::
Jump_000_2BCD:: ; address name
    ld a, [wTextFlags]
    bit 4, a
    jp z, Jump_000_2BF1
    ld a, [wTextFlags]
    res 4, a
    ld [wTextFlags], a
    call ShowTextContinueMark
    ld a, [wTextStartPosLo]
    ld l, a
    ld a, [wTextStartPosHi]
    ld h, a
    ld a, l
    ld [wTextPosLo], a
    ld a, h
    ld [wTextPosHi], a
    ret

Jump_000_2BF1::
    xor a, a
    ld [wTextFlags], a
    xor a, a
    ld [wTextControl], a
    ret

; when wC52B bit 5 is set: clears it, moves to the text cursor + $60 and 9 columns right, and writes tile $B4 there (probably the continue mark); plays sound $69 unless wGameMode is 4 (E-0120)
; 4 call sites from 3 routines (e.g. StepStringDisplayUntilDone_Sub01, Func_000_2950_Case12, Func_000_2950_Case10)
; reads: wTextFlags, wGameMode
; writes: wTextFlags
ShowTextContinueMark::
Func_000_2BFA:: ; address name
    ld a, [wTextFlags]
    bit 5, a
    ret z
    res 5, a
    ld [wTextFlags], a
    ld hl, $0060
    call AddHLToTextCursorTextCursorLo
    ld b, $09
    call AdvanceBGMapColumnsByB
    ld a, $B4
    call WriteVRAMByte
    ld a, [wGameMode]
    cp a, $04
    ret z
    ld a, $69
    call QueueSoundEffect
    ret

; entry 17 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowWidth, wTextLineStartLo, wTextLineStartHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi
Func_000_2950_Case11::
Jump_000_2C21:: ; address name
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wTextLineStartLo]
    ld e, a
    ld a, [wTextLineStartHi]
    ld d, a
    add hl, de
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ld a, l
    ld [wTextLineStartLo], a
    ld a, h
    ld [wTextLineStartHi], a
    ret

; entry 18 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi
Func_000_2950_Case12::
Jump_000_2C48:: ; address name
    call ShowTextContinueMark
    call ClearStringDisplayFlags
    call FillTilesFromRequest

; entry 19 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi
Func_000_2950_Case13::
Jump_000_2C51:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ld a, l
    ld [wTextLineStartLo], a
    ld a, h
    ld [wTextLineStartHi], a
    ret

; clears bit 7 of wC52C and bit 1 of wC52B (E-0114)
; 1 call site from 1 routine (e.g. Func_000_2950_Case12)
; points at: wTextControl, wTextFlags
ClearStringDisplayFlags::
Func_000_2C6A:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    ld hl, wTextFlags
    res 1, [hl]
    ret

; entry 21 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextFlags
Func_000_2950_Case15::
Jump_000_2C75:: ; address name
    ld hl, wTextFlags
    set 1, [hl]
    ret

; entry 22 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextPosLo, wTextPosHi
; writes: wTextStartPosLo, wTextStartPosHi, wTextPosLo, wTextPosHi
; points at: wPlayerName, wPlayerNameText, wTextFlags
Func_000_2950_Case16::
Jump_000_2C7B:: ; address name
    ld hl, wPlayerName
    ld de, wPlayerNameText
    ld b, $0A

Jump_000_2C83::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2C83
    ld a, $F0
    ld [de], a
    ld hl, wTextFlags
    set 4, [hl]
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, l
    ld [wTextStartPosLo], a
    ld a, h
    ld [wTextStartPosHi], a
    ld hl, wPlayerNameText
    ld a, l
    ld [wTextPosLo], a
    ld a, h
    ld [wTextPosHi], a
    ret

; entry 23 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextFlags, wTextControl
Func_000_2950_Case17::
Jump_000_2CAD:: ; address name
    ld hl, wTextFlags
    set 2, [hl]
    ld hl, wTextControl
    res 7, [hl]
    ret

; entry 24 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextControlArg
; points at: wTextFlags
Func_000_2950_Case18::
Jump_000_2CB8:: ; address name
    ld hl, wTextFlags
    set 3, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextControlArg], a
    ret

; entry 25 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextPosLo, wTextPosHi, wTextStartPosLo, wTextStartPosHi
; writes: wTextStartPosLo, wTextStartPosHi, wTextPosLo, wTextPosHi
; points at: wTextFlags, wTextBuf0
Func_000_2950_Case19::
Jump_000_2CC5:: ; address name
    ld hl, wTextFlags
    set 4, [hl]
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, l
    ld [wTextStartPosLo], a
    ld a, h
    ld [wTextStartPosHi], a
    ld a, [wTextStartPosLo]
    add a, $01
    ld [wTextStartPosLo], a
    ld a, [wTextStartPosHi]
    adc a, $00
    ld [wTextStartPosHi], a
    ld de, wTextBuf0
    ld a, [hl]
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, l
    ld [wTextPosLo], a
    ld a, h
    ld [wTextPosHi], a
    ret

; entry 26 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextFlags
Func_000_2950_Case1A::
Jump_000_2CFD:: ; address name
    ld hl, wTextFlags
    set 5, [hl]
    ret

; entry 27 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextRepeatCount
; points at: wTextFlags, wTextControl
Func_000_2950_Case1B::
Jump_000_2D03:: ; address name
    ld hl, wTextFlags
    set 6, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextRepeatCount], a
    ld hl, wTextControl
    res 7, [hl]
    ret

; entry 28 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextDelayCounter
; points at: wTextFlags, wTextControl
Func_000_2950_Case1C::
Jump_000_2D15:: ; address name
    ld hl, wTextFlags
    set 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextDelayCounter], a
    ld hl, wTextControl
    res 7, [hl]
    ret

; entry 29 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
Func_000_2950_Case1D::
Jump_000_2D27:: ; address name
    ld hl, wTextControl
    set 0, [hl]
    ret

; entry 30 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
Func_000_2950_Case1E::
Jump_000_2D2D:: ; address name
    ld hl, wTextControl
    res 0, [hl]
    ret

; clears bit 7 of wC52C, plays sound $6C, runs Func_000_2D4A, sets bit 2 of wC52B and clears wC552 (E-0122)
; 1 call site from 1 routine (e.g. Func_000_2950_Case07)
; writes: wTextYesNoResult
; points at: wTextControl, wTextFlags
AcknowledgeTextPrompt::
Func_000_2D33:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    ld a, $6C
    call QueueSoundEffect
    call AcknowledgeTextPrompt_Sub01
    ld hl, wTextFlags
    set 2, [hl]
    xor a, a
    ld [wTextYesNoResult], a
    ret

; only called from AcknowledgeTextPrompt (E-0047)
; 1 call site from 1 routine (e.g. AcknowledgeTextPrompt)
; reads: wIsCGB
; writes: rVBK
AcknowledgeTextPrompt_Sub01::
Func_000_2D4A:: ; address name
    call UploadTwoTilesFromScriptTileBuf0
    ld de, Data_01F_4180
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, $0100
    call BGMapAddressAtScrollPlusHL
    ld b, $0E
    call AdvanceBGMapColumnsByB
    push hl
    ld de, $2DFA

Jump_000_2D76::
    push hl

Jump_000_2D77::
    ld a, [de]
    inc de
    cp a, $FE
    jr z, Jump_000_2D9A
    cp a, $FD
    jr nz, Jump_000_2D92
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    jr Jump_000_2D76

Jump_000_2D92::
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    jr Jump_000_2D77

Jump_000_2D9A::
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, $2E1D
    push bc
    ld a, $01
    ldh [rVBK], a
    pop bc

Jump_000_2DAA::
    push hl

Jump_000_2DAB::
    ld a, [de]
    inc de
    cp a, $FE
    jr z, Jump_000_2DCE
    cp a, $FD
    jr nz, Jump_000_2DC6
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    jr Jump_000_2DAA

Jump_000_2DC6::
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    jr Jump_000_2DAB

Jump_000_2DCE::
    push bc
    ld a, $00
    ldh [rVBK], a
    pop bc
    pop hl
    ret

; copies the 16-byte tiles at wC89E and wC8AE to vTiles1 + $6E0 and + $6F0 (CopyCBytesToVRAMWaitSTAT) (E-0117)
; 1 call site from 1 routine (e.g. AcknowledgeTextPrompt_Sub01)
; points at: wScriptTileBuf0, wScriptTileBuf1
UploadTwoTilesFromScriptTileBuf0::
Func_000_2DD6:: ; address name
    ld hl, vTiles1 + $6E0
    ld de, wScriptTileBuf0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT
    ld hl, vTiles1 + $6F0
    ld de, wScriptTileBuf1
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT
    ret

; copies C bytes from HL to DE, waiting for rSTAT bit 1 to clear before each (interrupts stay on); HL and DE advance, C = 0 (E-0090)
; 2 call sites from 1 routine (e.g. UploadTwoTilesFromScriptTileBuf0)
; reads: rSTAT
CopyCBytesToVRAMWaitSTAT::
Func_000_2DED:: ; address name
    ldh a, [rSTAT]
    bit 1, a
    jr nz, CopyCBytesToVRAMWaitSTAT
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, CopyCBytesToVRAMWaitSTAT
    ret
    INCBIN "dwm2-cobi-us.gbc", $002DFA, $46

; DE = table of 16-bit pointers, one per category; wC528 = category, wC529 = index; returns DE = the string pointer; stores the current ROM bank in wC52A
; 2 call sites from 2 routines (e.g. BeginStringDisplay, CopyStringToBuffer)
; reads: wStringCategory, wStringIndex
; writes: wStringBank
LookupString::
Func_000_2E40:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    ld [wStringBank], a
    ld a, [wStringCategory]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wStringIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ret

; HL = the word at wC533/wC534, then that word += 1 (E-0090)
; 10 call sites from 9 routines (e.g. StepStringDisplayUntilDone_Sub01, Func_000_2950_Case1C, Func_000_2950_Case1B, Func_000_2950_Case18, ...)
; reads: wTextPosLo, wTextPosHi
; writes: wTextPosLo, wTextPosHi
IncrementTextPosLoWord::
Func_000_2E5D:: ; address name
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, l
    add a, $01
    ld [wTextPosLo], a
    ld a, h
    adc a, $00
    ld [wTextPosHi], a
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank08 (E-0114)
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
ShowStringHL_Bank08:: ; heuristic: follows a terminator; C0
Func_000_2E72:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ret

; H = string category, L = string index, DE = destination: stores them in wStringDestLo/Hi, wStringCategory and wStringIndex and far-calls CopyStringToBuffer_Bank08, which copies the string with its $F0 terminator to DE (categories 9 and above go to Func_095_465F) (E-0059)
; 24 call sites from 23 routines (e.g. PauseMenu_Skills_Case03_Case09, PauseMenu_Skills_Case03_Case00, PauseMenu_Items_Case00_Case01, Func_016_53E6_Case11, ...)
; writes: wStringDestLo, wStringDestHi, wStringCategory, wStringIndex
CopyStringHLToDE::
Func_000_2E81:: ; address name
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall CopyStringToBuffer_Bank08
    ret

; HL = destination, DE = size (E = width, D = height); stores them and calls FillTilesFromRequest
; 47 call sites from 30 routines (e.g. GameMode0_Init, DebugSkillViewer_Update, PauseMenu_State4, GameMode5_Init_Case06, ...)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
FillTilesRequest::
Func_000_2E98:: ; address name
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; HL = destination: writes A (0-255) as 1-3 decimal digit glyphs (charmap '0' = $00) without leading zeros, then $F0; HL ends on the terminator; clobbers A, D, E (E-0074)
; 10 call sites from 4 routines (e.g. ShowRaiseAmountOrRefuse, WriteRecordField4BAndStatsDecimal, RunBattlePhaseWhenTextIdle_A0_Case03_Case07, RunBattlePhaseWhenTextIdle_A0_Case03_Case06)
WriteDecimalByteString::
Func_000_2EAC:: ; address name
    cp a, $64
    jr nc, Jump_000_2EB6
    cp a, $0A
    jr nc, Jump_000_2EBB
    jr Jump_000_2EC0

Jump_000_2EB6::
    ld e, $64
    call WriteDecimalDigitForE

Jump_000_2EBB::
    ld e, $0A
    call WriteDecimalDigitForE

Jump_000_2EC0::
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; D = A / E by repeated subtraction, stored at HL; HL += 1; A = the remainder (E-0074)
; 2 call sites from 1 routine (e.g. WriteDecimalByteString)
WriteDecimalDigitForE::
Func_000_2EC5:: ; address name
    ld d, $FF

Jump_000_2EC7::
    inc d
    sub a, e
    jr nc, Jump_000_2EC7
    add a, e
    ld [hl], d
    inc hl
    ret

; writes the 24-bit number in hFFC6-hFFC8 as decimal digits from the millions down (dividing by 1,000,000, 100,000 and 10,000), then the 16-bit remainder through the shared writer (E-0127)
; 2 call sites from 2 routines (e.g. Func_031_67AA_Case00, RunBattlePhaseWhenTextIdle_A0_Case03_Case08)
; reads: hTemp0, hTemp1
; writes: hTemp6
WriteNumber24AsDecimalString::
Func_000_2ECF:: ; address name
    ld a, $0F
    ldh [hTemp6], a
    ld e, $40
    ld d, $42
    call Quotient24ByHFFCCDE
    or a, a
    jp nz, Jump_000_2F03
    ld a, $01
    ldh [hTemp6], a
    ld e, $A0
    ld d, $86
    call Quotient24ByHFFCCDE
    or a, a
    jr nz, Jump_000_2F11
    ld a, $00
    ldh [hTemp6], a
    ld e, $10
    ld d, $27
    call Quotient24ByHFFCCDE
    or a, a
    jr nz, Jump_000_2F1F
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    jp WriteBCAsDecimalString

Jump_000_2F03::
    ld a, $0F
    ldh [hTemp6], a
    ld e, $40
    ld d, $42
    call Divide24ByHFFCCDE
    call StoreAThenTerminator

Jump_000_2F11::
    ld a, $01
    ldh [hTemp6], a
    ld e, $A0
    ld d, $86
    call Divide24ByHFFCCDE
    call StoreAThenTerminator

Jump_000_2F1F::
    ld a, $00
    ldh [hTemp6], a
    ld e, $10
    ld d, $27
    call Divide24ByHFFCCDE
    call StoreAThenTerminator
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    jp Jump_000_2FA7

; Divide24ByHFFCCDE with hFFC6-hFFC8 restored afterwards (A = the quotient); uses wC0A0, wC0A1 and wMenuRowCount as scratch, so wMenuRowCount is overwritten (E-0090)
; 3 call sites from 1 routine (e.g. WriteNumber24AsDecimalString)
; reads: hTemp0, hTemp1, hTemp2, wTemp0, wTemp1, wMenuRowCount
; writes: wTemp0, wTemp1, wMenuRowCount, hTemp0, hTemp1, hTemp2
Quotient24ByHFFCCDE::
Func_000_2F36:: ; address name
    ldh a, [hTemp0]
    ld [wTemp0], a
    ldh a, [hTemp1]
    ld [wTemp1], a
    ldh a, [hTemp2]
    ld [wMenuRowCount], a
    call Divide24ByHFFCCDE
    push af
    ld a, [wTemp0]
    ldh [hTemp0], a
    ld a, [wTemp1]
    ldh [hTemp1], a
    ld a, [wMenuRowCount]
    ldh [hTemp2], a
    pop af
    ret

; A = the 24-bit hFFC8:hFFC7:hFFC6 divided by the 24-bit hFFCC:D:E (repeated subtraction; the quotient must fit in 8 bits); the remainder is left in hFFC6-hFFC8; HL kept (E-0090)
; 4 call sites from 2 routines (e.g. WriteNumber24AsDecimalString, Quotient24ByHFFCCDE)
; reads: hTemp6, hTemp0, hTemp1, hTemp2
; writes: hTemp0, hTemp1, hTemp2
Divide24ByHFFCCDE::
Func_000_2F5A:: ; address name
    push hl
    ldh a, [hTemp6]
    ld l, a
    ld h, $FF

Jump_000_2F60::
    inc h
    ldh a, [hTemp0]
    sub a, e
    ldh [hTemp0], a
    ldh a, [hTemp1]
    sbc a, d
    ldh [hTemp1], a
    ldh a, [hTemp2]
    sbc a, l
    ldh [hTemp2], a
    jr nc, Jump_000_2F60
    ldh a, [hTemp0]
    add a, e
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, d
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, l
    ldh [hTemp2], a
    ld a, h
    pop hl
    ret

; writes BC (below 10,000) as decimal digit bytes at HL without leading zeros, each followed by a $F0 terminator that the next digit overwrites (DivideBCByDE by 1000, 100, 10, then the remainder) (E-0180)
; 2 call sites from 2 routines (e.g. BattleTextPrep35_Sub01, RunBattleActions_Case09_Case04)
WriteBCAsDecimalString::
Func_000_2F84:: ; address name
    ld de, $03E8
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, Jump_000_2FA7
    ld de, $0064
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, Jump_000_2FB0
    ld de, $000A
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, Jump_000_2FB9
    jr Jump_000_2FC2

Jump_000_2FA7::
    ld de, $03E8
    call DivideBCByDE
    call StoreAThenTerminator

Jump_000_2FB0::
    ld de, $0064
    call DivideBCByDE
    call StoreAThenTerminator

Jump_000_2FB9::
    ld de, $000A
    call DivideBCByDE
    call StoreAThenTerminator

Jump_000_2FC2::
    ld a, c
    call StoreAThenTerminator
    ret

; A = BC / DE by repeated subtraction (the quotient must fit in 8 bits), BC = the remainder; HL kept (E-0078)
; 6 call sites from 1 routine (e.g. WriteBCAsDecimalString)
DivideBCByDE::
Func_000_2FC7:: ; address name
    push hl
    ld h, $FF

Jump_000_2FCA::
    inc h
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    jr nc, Jump_000_2FCA
    ld a, c
    add a, e
    ld c, a
    ld a, b
    adc a, d
    ld b, a
    ld a, h
    pop hl
    ret

; [HL] = A, HL += 1, [HL] = $F0 (string terminator) (E-0077)
; 7 call sites from 2 routines (e.g. WriteBCAsDecimalString, WriteNumber24AsDecimalString)
StoreAThenTerminator::
Func_000_2FDC:: ; address name
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; copies from DE to HL until 5 glyphs other than $8D and $8E have been copied ($8D/$8E, which have no charmap entry, are copied without counting); a $8D or $8E right after the fifth glyph is copied too; then writes $F0. Clobbers A, B; DE and HL advance (E-0072)
; 14 call sites from 14 routines (e.g. PauseMenu_Skills_Case02_Case02, PauseMenu_Skills_Case03_Case00, PauseMenu_Items_Case00_Case01, PauseMenu_Items_Case02_Case05, ...)
CopyFiveGlyphsPlusMarks::
Func_000_2FE1:: ; address name
    ld b, $05

Jump_000_2FE3::
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $8D
    jr z, Jump_000_2FE3
    cp a, $8E
    jr z, Jump_000_2FE3
    dec b
    jr nz, Jump_000_2FE3
    ld a, [de]
    cp a, $8D
    jr z, Jump_000_2FFD
    cp a, $8E
    jr z, Jump_000_2FFD
    ld [hl], $F0
    ret

Jump_000_2FFD::
    ld [hl+], a
    ld [hl], $F0
    ret

; text cursor wC554 = HL; writes consecutive tile numbers starting at wC52D / 16 over the wC52F x wC530 window, rows two map rows apart (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTextCursorLo, wTextCursorHi
; writes: wTextCursorLo, wTextCursorHi
WriteWindowTileNumbersAtHL:: ; heuristic: follows a terminator; C0
Func_000_3001:: ; address name
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, [wTextWindowTileLo]
    ld e, a
    ld a, [wTextWindowTileHi]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    ld a, [wTextCursorLo]
    ld l, a
    ld a, [wTextCursorHi]
    ld h, a

Jump_000_3031::
    push bc

Jump_000_3032::
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, Jump_000_3032
    pop bc
    ld hl, $0040
    call AddHLToTextCursorTextCursorLo
    dec c
    jr nz, Jump_000_3031
    ret

; moves HL B entries to the right inside its 32-entry BG map row, wrapping at the row end (NextBGMapColumn B times); B = 0 (E-0078)
; 5 call sites from 3 routines (e.g. StepStringDisplayUntilDone_Sub01, ShowTextContinueMark, AcknowledgeTextPrompt_Sub01)
AdvanceBGMapColumnsByB::
Func_000_3048:: ; address name
    call NextBGMapColumn_Bank00
    dec b
    jr nz, AdvanceBGMapColumnsByB
    ret

; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping at the row end; keeps AF (the same 15 bytes appear in 2 banks)
; 8 call sites from 6 routines (e.g. AdvanceBGMapColumnsByB, AcknowledgeTextPrompt_Sub01, Func_000_2950_Case0F, BlankBGMapEntriesRight, ...)
NextBGMapColumn_Bank00::
Func_000_304F:: ; address name
    push af
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    pop af
    ret

; HL = wC554/wC555 + HL, with the high byte's low 2 bits wrapped and its upper 6 bits kept from wC555 (stays inside one 1 KB BG map) (E-0090)
; 7 call sites from 5 routines (e.g. StepStringDisplayUntilDone_Sub01, ShowTextContinueMark, Func_000_2950_Case0F, Func_000_2950_Case0E, ...)
; reads: wTextCursorLo, wTextCursorHi
AddHLToTextCursorTextCursorLo::
Func_000_305E:: ; address name
    ld a, [wTextCursorLo]
    add a, l
    ld l, a
    ld a, [wTextCursorHi]
    adc a, h
    and a, $03
    ld h, a
    ld a, [wTextCursorHi]
    and a, $FC
    or a, h
    ld h, a
    ret

; HL = offset in a 32 x 32 BG map: returns HL = $9800 + ((HL + (hScrollY & $F8) * 4 + hScrollX / 8) & $3FF), the entry that offset points at from the scroll origin, wrapping inside the map (E-0090)
; 3 call sites from 2 routines (e.g. StepStringDisplayUntilDone_Sub01, AcknowledgeTextPrompt_Sub01)
; reads: hScrollY, hScrollX
BGMapAddressAtScrollPlusHL::
Func_000_3072:: ; address name
    push hl
    ldh a, [hScrollY]
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld c, a
    ld b, h
    pop hl
    ld a, c
    add a, l
    ld l, a
    ld a, b
    adc a, h
    and a, $03
    ld h, a
    and a, $03
    or a, $98
    ld h, a
    ret

; writes tile $C3 (WriteVRAMByte) to B BG map entries from HL rightward, wrapping inside the 32-entry row (NextBGMapColumn); B = 0 (E-0090)
; 3 call sites from 2 routines (e.g. Func_000_2950_Case0F, Func_000_2950_Case0E)
BlankBGMapEntriesRight::
Func_000_3095:: ; address name
    ld a, $C3
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    dec b
    jr nz, BlankBGMapEntriesRight
    ret

; copies glyph A (8 one-bit rows at $4010 + 16 * A in bank $1F) to HL as a 2bpp tile, each row byte written twice (E-0125)
; no direct call (reached through a table, a jump or a vector)
; writes: rROMB0
ExpandGlyphTileToHL:: ; heuristic: follows a terminator; C0
Func_000_30A1:: ; address name
    push hl
    ld de, $4010
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    ld b, $08

Jump_000_30BE::
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_000_30BE
    pop af
    ld [rROMB0], a
    ret

; E-0189 (C1: Jump_000_35A8 indexes it by (hSndA8Param >> 4) * 2; only entry 0 exists, and the wave set follows it directly).
; record: wave set
SoundWaveSetTable::
Data_000_30CC:: ; address name
    dw SoundWaveSet0 ; id 0

; E-0189 (C1: Jump_000_35A8 clears rNR30, then copies the 16 bytes at the set + wave number * 16 (wave number from hSndSweepOrWave or the track, swapped into the high nibble) to $FF30-$FF3F; wave 0 is a sine, 1 a triangle, 2 a square, 3 a sawtooth).
; record: one wave RAM image: 32 4-bit samples, two per byte
SoundWaveSet0::
Data_000_30CE:: ; address name
    db $00, $01, $12, $35, $8A, $CD, $EE, $FF, $FF, $FE, $ED, $CA, $85, $32, $11, $00 ; id 0
    db $01, $23, $45, $67, $89, $AB, $CD, $EF, $FE, $DC, $BA, $98, $76, $54, $32, $10 ; id 1
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $FF, $EE, $DD, $CC, $BB, $AA, $99, $88, $77, $66, $55, $44, $33, $22, $11, $00 ; id 3
    db $FF, $FF, $DE, $BD, $24, $12, $00, $00, $00, $00, $21, $42, $DB, $ED, $FF, $FF ; id 4
    db $FF, $FF, $EE, $CA, $53, $11, $00, $00, $00, $00, $11, $35, $AC, $EE, $FF, $FF ; id 5
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $FF, $00 ; id 6
    db $00, $00, $66, $AA, $BB, $DD, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 7
    db $FF, $FF, $EE, $ED, $DD, $CC, $CB, $BA, $A9, $98, $87, $65, $54, $43, $31, $10 ; id 8
    db $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $AA, $BB, $CC, $DD, $EE, $FF, $FF ; id 9
    db $00, $00, $00, $00, $AA, $AA, $BB, $CC, $DD, $DD, $FF, $FF, $FF, $FF, $00, $FF ; id 10
    db $00, $00, $00, $00, $AA, $AA, $BB, $CC, $DD, $DD, $FF, $FF, $FF, $FF, $AA, $FF ; id 11
    db $01, $12, $22, $33, $35, $55, $77, $99, $55, $99, $AA, $BB, $CC, $DD, $EE, $FF ; id 12
    db $FC, $DC, $BA, $90, $70, $50, $30, $15, $15, $15, $15, $22, $55, $77, $AA, $CC ; id 13
    db $EE, $EE, $CD, $AC, $35, $23, $11, $11, $11, $11, $32, $53, $CA, $DC, $EE, $EE ; id 14
    db $DD, $DD, $DD, $DD, $DD, $DD, $DD, $DD, $22, $22, $22, $22, $22, $22, $22, $22 ; id 15

; E-0189 (C1: Jump_000_3A94 indexes it by (hSndA8Param & $0F) * 2; only entry 0 exists, and its rows follow it directly).
; record: modulation rows
SoundModulationTable::
Data_000_31CE:: ; address name
    dw SoundModulationRows0 ; id 0

; E-0189 (C1: Jump_000_3A94 reads the byte at the rows - $10 + (hSndVibratoDepth | phase), where the phase is 4 bits computed from hSndVibratoCounter and hSndVibratoDelay, so row 1 is the first; 12 rows end at the routine at $3290; what each step does to the pitch or volume is not read).
; record: 16 steps for one depth value: high nibble is combined with hSndEnvelope, bit 2 selects a branch
SoundModulationRows0::
Data_000_31D0:: ; address name
    db $F1, $D0, $B0, $90, $70, $50, $30, $15, $15, $15, $15, $15, $15, $15, $15, $15 ; id 1
    db $F3, $D0, $B0, $90, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $15 ; id 2
    db $89, $98, $A8, $B8, $C8, $D8, $E8, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5, $F5 ; id 3
    db $B9, $C8, $D8, $E8, $F1, $D0, $B0, $90, $70, $50, $30, $15, $15, $15, $15, $15 ; id 4
    db $99, $A8, $B8, $C8, $D8, $E8, $F4, $F4, $F0, $E0, $D0, $B0, $90, $70, $50, $35 ; id 5
    db $DB, $F3, $D0, $B0, $90, $81, $70, $60, $50, $40, $30, $20, $15, $15, $15, $15 ; id 6
    db $F1, $E0, $D0, $C0, $B0, $A0, $90, $80, $70, $60, $50, $40, $30, $20, $10, $05 ; id 7
    db $F1, $70, $50, $30, $20, $15, $15, $15, $15, $05, $05, $05, $05, $05, $05, $05 ; id 8
    db $F1, $B0, $70, $50, $30, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $05 ; id 9
    db $F1, $B0, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $15, $15, $05 ; id 10
    db $F3, $D0, $B0, $90, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $05 ; id 11
    db $09, $18, $28, $38, $48, $58, $68, $78, $88, $98, $A8, $B8, $C8, $D8, $E8, $F5 ; id 12

; rNR52 = $80, rNR51 = 0, rNR50 = $77; sets the first two bytes of each of the 6 channel slots at wSoundChannelSlots to $FF; clears the 72 bytes at wSoundLabelSlots, wDD15 and wDD19; calls Func_000_32DB with BC = 0
; 9 call sites from 7 routines (e.g. BootAndMainLoop, StartMusic, DebugSoundTest_Update, GameMode1_Init, ...)
; writes: rNR52, rNR51, wSoundEngineMode, rNR50, wSoundEngineState, wSoundInitByte19
; points at: wSoundChannelSlots, wSoundLabelSlots
InitSoundHardware::
Func_000_3290:: ; address name
    ld bc, $0000
    call InitSoundHardware_Sub01
    ld a, $80
    ldh [rNR52], a
    xor a, a
    ldh [rNR51], a
    ld [wSoundEngineMode], a
    ld a, $77
    ldh [rNR50], a
    ld hl, wSoundChannelSlots
    ld de, $0020
    ld b, $06
    ld a, $FF

Jump_000_32AE::
    ld [hl+], a
    ld [hl-], a
    add hl, de
    dec b
    jr nz, Jump_000_32AE
    ld hl, wSoundLabelSlots
    ld b, $48
    xor a, a

Jump_000_32BA::
    ld [hl+], a
    dec b
    jr nz, Jump_000_32BA
    xor a, a
    ld [wSoundEngineState], a
    ld [wSoundInitByte19], a
    ret

; wDD15 = 0, wDD09 = wDD16 (sound engine state) (E-0119)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundSavedMode
; writes: wSoundEngineState, wSoundEngineMode
SetSoundEngineStateTo0AndSoundEngineModeFromSoundSavedMode:: ; heuristic: follows a terminator; C0
Func_000_32C6:: ; address name
    xor a, a
    ld [wSoundEngineState], a
    ld a, [wSoundSavedMode]
    ld [wSoundEngineMode], a
    ret

; wDD15 = 4, wDD09 = 0 (sound engine state) (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: wSoundEngineState, wSoundEngineMode
SetSoundEngineStateTo4AndClearSoundEngineMode:: ; heuristic: follows a terminator; C0
Func_000_32D1:: ; address name
    ld a, $04
    ld [wSoundEngineState], a
    xor a, a
    ld [wSoundEngineMode], a
    ret

; only called from InitSoundHardware (E-0047)
; 1 call site from 1 routine (e.g. InitSoundHardware)
; writes: wSoundTimer12, wSoundTimer13, wSoundTimer14
InitSoundHardware_Sub01::
Func_000_32DB:: ; address name
    ld a, b
    ld [wSoundTimer12], a
    ld a, c
    ld [wSoundTimer13], a
    xor a, a
    ld [wSoundTimer14], a
    ret

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: wSoundChannelIndex, wSoundTimer14
; writes: wSoundTimer14
SoundTick_Sub01::
Func_000_32E8:: ; address name
    ld a, [wSoundChannelIndex]
    inc a
    ld b, a
    ld a, $01

Jump_000_32EF::
    dec b
    jr z, Jump_000_32F5
    add a, a
    jr Jump_000_32EF

Jump_000_32F5::
    ld b, a
    ld a, [wSoundTimer14]
    or a, b
    ld [wSoundTimer14], a
    ret

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: wSoundTimer14, wSoundTimer13, wSoundTimer12
; writes: wSoundTimer14, wSoundTimer12
; points at: wSoundTimer12
SoundTick_Sub02::
Func_000_32FE:: ; address name
    ld a, [wSoundTimer14]
    ld hl, wSoundTimer12
    and a, [hl]
    cp a, [hl]
    jr nz, Jump_000_3332
    ld hl, wSoundChannelSlots + $6
    ld a, [wSoundTimer13]
    and a, $0F
    ld b, a
    ld a, [wSoundTimer12]

Jump_000_3314::
    srl a
    ld [wSoundTimer14], a
    jr nc, Jump_000_3320
    ld a, [hl]
    and a, $F0
    or a, b
    ld [hl], a

Jump_000_3320::
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSoundTimer14]
    and a, a
    jr nz, Jump_000_3314
    xor a, a
    ld [wSoundTimer12], a

Jump_000_3332::
    xor a, a
    ld [wSoundTimer14], a
    ret

; runs RunSoundTable3E24ForA three times and falls into it once more (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
RunSoundTable3E24FourTimes:: ; heuristic: follows a terminator; C0
Func_000_3337:: ; address name
    call RunSoundTable3E24ForA
    call RunSoundTable3E24ForA
    call RunSoundTable3E24ForA

; wSoundId = A, then runs the sound entry from table $3E24 (registers saved) (E-0122)
; 3 call sites from 1 routine (e.g. RunSoundTable3E24FourTimes)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
RunSoundTable3E24ForA::
Func_000_3340:: ; address name
    push bc
    push de
    push hl
    ld [wSoundId], a
    ld hl, $3E24
    jr Jump_000_335D

; only called from StartMusic (E-0047)
; 1 call site from 1 routine (e.g. StartMusic)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
StartMusic_Sub01::
Func_000_334B:: ; address name
    call StartSound

; calls StartSound (which returns A + 1) and falls into StartTwoSoundTracks, so sound ids A, A + 1 and A + 2 start (E-0126)
; 2 call sites from 2 routines (e.g. StartSoundEffect, StartMusic)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
StartThreeSoundTracks::
Func_000_334E:: ; address name
    call StartSound

; calls StartSound and falls into it once more, so sound ids A and A + 1 start (E-0126)
; 2 call sites from 2 routines (e.g. StartSoundEffect, StartMusic)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
StartTwoSoundTracks::
Func_000_3351:: ; address name
    call StartSound

; C2 static reading, and 495 emulated sound starts agree (E-0018): starts sound id A (kept in $DD10). Finds A's range in SoundBankTable, switches to that bank, takes the 4-byte record at (array + 4*(A - first id)), and copies it into the channel-state slot at $DC00 + record byte 0 (record byte 1 to slot +2, the track pointer to +3/+4, this bank to +5). Returns A + 1.
; 4 call sites from 4 routines (e.g. StartSoundEffect, StartThreeSoundTracks, StartTwoSoundTracks, StartMusic_Sub01)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
StartSound::
Func_000_3354:: ; address name
    push bc
    push de
    push hl
    ld [wSoundId], a
    ld hl, SoundBankTable

Jump_000_335D::
    cp a, [hl]
    jr c, Jump_000_3366
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_000_335D

Jump_000_3366::
    ld a, [BANK_NUMBER_BYTE]
    push af
    dec hl
    ld a, [hl-]
    ld [rROMB0], a
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec hl
    ld a, [wSoundId]
    sub a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, de
    push hl
    pop de
    ld a, [de]
    inc de
    ld c, a
    ld b, $00
    ld hl, wSoundChannelSlots
    add hl, bc
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_33AA
    inc hl
    ld a, [hl-]
    ld b, $EE
    and a, $03
    jr z, Jump_000_33A3
    ld b, $DD
    cp a, $01
    jr z, Jump_000_33A3
    ld b, $BB
    cp a, $02
    jr z, Jump_000_33A3
    ld b, $77

Jump_000_33A3::
    ld a, [wSoundEngineMode]
    and a, b
    ld [wSoundEngineMode], a

Jump_000_33AA::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [BANK_NUMBER_BYTE]
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, $FF
    ld [hl+], a
    xor a, a
    push de
    ld de, $000E
    add hl, de
    pop de
    push hl
    ld [hl+], a
    ld [hl+], a
    ld [hl-], a
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], a
    pop hl
    inc hl
    inc hl
    inc hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    pop af
    ld [rROMB0], a
    ld a, [wSoundId]
    inc a
    pop hl
    pop de
    pop bc
    ret

; C1 (E-0018): appears to be the sound engine's update routine. It switches to the bank in $FFDD, walks the channel-state slots at $DC00 and writes the sound registers (including $FF1A). Identified from those writes and from the banks it reads at runtime ($40-$43 via the tables above); not decoded further.
; for each of the 6 channel slots at wSoundChannelSlots: copies the slot into HRAM $FFD8-$FFF7, reads events from the track in bank hSoundBank and writes the channel's sound registers (the per-frame sound engine; called from VBlankHandler)
; 3 call sites from 1 routine (e.g. VBlankHandler)
; reads: wSoundEngineState, hSoundBank, hSndChanFlags, hTrackPosLo, hTrackPosHi, hSndVibratoDelay, hSndVibratoCounter, hSndDutyAndTempo, ...
; writes: wSoundChannelIndex, wSoundSkipMaskA, rROMB0, wSoundHwChannel, wSoundRegBase, wSoundSkipMaskB, wSoundTickByte0C, hSndVibratoCounter, ...
; points at: wSoundTickBuf0E, wSoundChannelSlots, hSndTickAccum, hSndEnvTimer
SoundTick::
Func_000_33E8:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wSoundEngineState]
    ld [wSoundChannelIndex], a
    xor a, a
    ld [wSoundSkipMaskA], a
    ld hl, wSoundTickBuf0E
    inc [hl]
    ld hl, wSoundChannelSlots

Jump_000_33FD::
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    and a, b
    cp a, $FF
    jp z, Jump_000_352F
    push hl
    ld c, $D8
    ld b, $04

Jump_000_340B::
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_340B
    ldh a, [hSoundBank]
    ld [rROMB0], a
    ldh a, [hSndChanFlags]
    and a, $03
    ld [wSoundHwChannel], a
    ld b, a
    add a, a
    add a, a
    add a, b
    ld [wSoundRegBase], a
    inc b
    ld a, $88

Jump_000_343C::
    rlca
    dec b
    jr nz, Jump_000_343C
    ld [wSoundSkipMaskB], a
    ld [wSoundTickByte0C], a
    ldh a, [hTrackPosLo]
    ld b, a
    ldh a, [hTrackPosHi]
    or a, b
    and a, a
    jp z, Jump_000_3554
    call SoundTick_Sub04
    call SoundTick_Sub05
    ldh a, [hSndVibratoDelay]
    ld b, a
    ldh a, [hSndVibratoCounter]
    inc a
    cp a, b
    jr c, Jump_000_3460
    ld a, b

Jump_000_3460::
    ldh [hSndVibratoCounter], a
    ld hl, hSndTickAccum
    ldh a, [hSndDutyAndTempo]
    and a, $0F
    add a, [hl]
    cp a, $10
    jr c, Jump_000_3473
    sub a, $10
    ld [hl], a
    jr Jump_000_34C7

Jump_000_3473::
    ld [hl], a
    call SoundTick_Sub03
    ldh a, [hSndNoteTimer]
    and a, a
    jr z, Jump_000_347F
    dec a
    ldh [hSndNoteTimer], a

Jump_000_347F::
    ldh a, [hSndWaitTicks]
    and a, a
    jr nz, Jump_000_34BA
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr z, Jump_000_349C
    ld hl, hSndEnvTimer
    dec [hl]
    jr nz, Jump_000_34A8
    ldh a, [hSndEnvelopeReload]
    and a, $F0
    ld c, a
    ldh a, [hSndEnvelope]
    and a, $0F
    or a, c
    ldh [hSndEnvelope], a

Jump_000_349C::
    call SoundTick_Sub01

Jump_000_349F::
    ldh a, [hSndNoteLength]
    ldh [hSndNoteTimer], a
    call SoundNextEvent
    jr Jump_000_34C7

Jump_000_34A8::
    ldh a, [hSndEnvFlags]
    and a, $0F
    dec a
    cp a, [hl]
    jr nz, Jump_000_34C7
    call SoundTick_Sub07
    ldh a, [hSndEnvelope]
    call WriteChannelEnvelopeIfChanged
    jr Jump_000_34C7

Jump_000_34BA::
    dec a
    ldh [hSndWaitTicks], a
    jr nz, Jump_000_34C7
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr nz, Jump_000_34C7
    jr Jump_000_349C

Jump_000_34C7::
    ld a, [wSoundInitByte19]
    and a, a
    jr z, Jump_000_3502
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_3502
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr c, Jump_000_3502
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jr nz, Jump_000_3502
    ld a, [wSoundEventByte17]
    ld b, a
    ldh a, [hSndSweepOrWave]
    cp a, b
    jr z, Jump_000_3502
    ld e, a
    ld [wSoundEventByte17], a
    swap e
    xor a, a
    ld [wSoundInitByte19], a
    ldh [rNR30], a
    ld d, a
    call SoundTick_Sub06
    ld a, $80
    ldh [rNR30], a

Jump_000_3502::
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    or a, b
    ld [wSoundSkipMaskA], a
    pop hl
    push hl
    ld c, $D8
    ld b, $04

Jump_000_3513::
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    dec b
    jr nz, Jump_000_3513
    pop hl

Jump_000_352F::
    ld de, $0020
    add hl, de
    ld a, [wSoundChannelIndex]
    inc a
    ld [wSoundChannelIndex], a
    cp a, $06
    jp c, Jump_000_33FD
    ld a, [wSoundSkipMaskA]
    ld b, a
    ld a, [wSoundEngineMode]
    and a, b
    ld [wSoundEngineMode], a
    ldh [rNR51], a
    pop af
    ld [rROMB0], a
    call SoundTick_Sub02
    ret

; C2 static reading (E-0019): channel start. Reads the 4-byte track header (byte 0 low nibble -> $FFDF, byte 1 -> duty bits of $FFDE (wave: $FFE6), byte 2 swapped -> $FFE0, byte 3 -> $FFE2) and begins playback at event 2 ($FFD8 = 2).
Jump_000_3554::
    ldh a, [hTrackBaseLo]
    ld l, a
    ldh a, [hTrackBaseHi]
    ld h, a
    ld a, [hl+]
    and a, $0F
    ld d, a
    ldh [hSndTickAccum], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3593
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    or a, d

Jump_000_356D::
    ldh [hSndDutyAndTempo], a
    ld a, [hl+]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3599
    ld a, [hl+]
    ldh [hSndSweepOrWave], a

Jump_000_357E::
    xor a, a
    ldh [hSndChanByteE3], a
    ldh [hSndBranchIndex], a
    ldh [hSndVibratoDepth], a
    ldh [hSndPitchSlide], a
    ldh [hTrackPosHi], a
    dec a
    ldh [hSndPanning], a
    ld a, $02
    ldh [hTrackPosLo], a
    jp Jump_000_349F

Jump_000_3593::
    ld a, [hl+]
    ldh [hSndVibratoDelay], a
    ld a, d
    jr Jump_000_356D

Jump_000_3599::
    xor a, a
    ldh [rNR30], a
    ld d, a
    ldh a, [hSndSweepOrWave]
    ld e, a
    cp a, $FF
    jr nz, Jump_000_35A8
    ld e, [hl]
    ld a, e
    ldh [hSndSweepOrWave], a

Jump_000_35A8::
    ld [wSoundEventByte17], a
    swap e
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndA8Param]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld c, $30
    ld b, $10

Jump_000_35C5::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_35C5
    jr Jump_000_357E

; C2 static reading and 5,154 emulated fetches agree (E-0019): fetches the next track event of the current channel. The position in $FFD8/$FFD9 counts 2-byte events from the track start ($FFDB/$FFDC), the event address is base + 2*position, and the first byte selects the command (see tools/sound_tracks.py).
; 1 call site from 1 routine (e.g. SoundTick)
; reads: hTrackPosLo, hTrackPosHi, hTrackBaseLo, hTrackBaseHi, hSndEnvFlags, wSoundHwChannel, hSndSweepOrWave, hSndDutyAndTempo, ...
; writes: hTrackPosLo, hTrackPosHi, hSndEnvTimer, hSndWaitTicks, hSndVibratoCounter, rNR30, hSndFreqLo, hSndFreqHi, ...
SoundNextEvent::
Func_000_35CD:: ; address name
    ldh a, [hTrackPosLo]
    ld l, a
    ldh a, [hTrackPosHi]
    ld h, a
    add hl, hl
    ldh a, [hTrackBaseLo]
    ld e, a
    ldh a, [hTrackBaseHi]
    ld d, a
    add hl, de

Jump_000_35DB::
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
    ld a, [hl+]
    cp a, $D0
    jr nc, Jump_000_362E
    cp a, $B0
    jr nc, Jump_000_366D
    cp a, $A0
    jp nc, Jump_000_36A9
    jp Jump_000_38C9

Jump_000_35F8::
    cp a, $FD
    jr z, Jump_000_3602
    cp a, $FF
    jr z, Jump_000_3613
    jr Jump_000_3610

Jump_000_3602::
    push hl
    ld b, [hl]
    call SoundLabelSlot
    xor a, a
    ld [hl+], a
    ldh a, [hTrackPosLo]
    ld [hl+], a
    ldh a, [hTrackPosHi]
    ld [hl], a
    pop hl

Jump_000_3610::
    inc hl
    jr Jump_000_35DB

Jump_000_3613::
    ldh [hTrackPosLo], a
    ldh [hTrackPosHi], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_362A
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr nc, Jump_000_362A
    ld a, $FF
    ld [wSoundInitByte19], a

Jump_000_362A::
    call SoundNextEvent_Sub03
    ret

Jump_000_362E::
    cp a, $F0
    jr nc, Jump_000_35F8
    cp a, $E0
    jr nc, Jump_000_363A
    and a, $0F
    jr Jump_000_363E

Jump_000_363A::
    and a, $0F
    cpl
    inc a

Jump_000_363E::
    ld b, a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_364E
    ld a, b
    ldh [hSndPitchSlide], a
    ld a, [hl]
    ldh [hSndPitchSlideTime], a
    ldh [hSndPitchSlideCounter], a

Jump_000_364E::
    inc hl
    jr Jump_000_35DB

Jump_000_3651::
    and a, $0F
    ld b, a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3669
    ldh a, [hSndEnvelope]
    and a, $0F
    jr nz, Jump_000_3669
    ld a, [hl]
    ldh [hSndVibratoDelay], a
    ld a, b
    swap a
    ldh [hSndVibratoDepth], a

Jump_000_3669::
    inc hl
    jp Jump_000_35DB

Jump_000_366D::
    cp a, $C0
    jr nc, Jump_000_3651
    and a, $0F
    jp z, Jump_000_368C
    ld e, a
    ld b, [hl]
    push hl
    call SoundLabelSlot
    inc [hl]
    ld a, [hl+]
    inc e
    cp a, e
    jr nc, Jump_000_3688
    ld a, [hl+]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a

Jump_000_3688::
    pop hl
    jp SoundNextEvent

Jump_000_368C::
    ld a, [hl]
    ld b, a
    and a, $F0
    cp a, $F0
    jp nz, Jump_000_36A5
    ld b, [hl]
    push hl
    call SoundLabelSlot
    inc hl
    ld a, [hl+]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
    pop hl
    jp SoundNextEvent

Jump_000_36A5::
    inc hl
    jp Jump_000_35DB

Jump_000_36A9::
    cp a, $A0
    jr nz, Jump_000_36C3
    ld a, [hl+]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jp nz, Jump_000_35DB
    call WriteChannelEnvelopeIfChanged
    jp Jump_000_35DB

Jump_000_36C3::
    cp a, $A1
    jr nz, Jump_000_3712
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_36D4
    ld a, [hl+]
    ldh [hSndSweepOrWave], a
    jp Jump_000_35DB

Jump_000_36D4::
    ld a, [hl+]
    ld e, a
    ldh [hSndSweepOrWave], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jr z, Jump_000_36E5
    jp Jump_000_35DB

Jump_000_36E5::
    xor a, a
    ldh [rNR30], a
    ld d, a
    push hl
    ld a, e
    ld [wSoundEventByte17], a
    swap e
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndA8Param]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld c, $30
    ld b, $10

Jump_000_3708::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_3708
    pop hl
    jp Jump_000_35DB

Jump_000_3712::
    cp a, $A2
    jr nz, Jump_000_3733
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_372D
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    ld d, a
    ldh a, [hSndDutyAndTempo]
    and a, $3F
    or a, d
    ldh [hSndDutyAndTempo], a
    jp Jump_000_35DB

Jump_000_372D::
    ld a, [hl+]
    ldh [hSndVibratoDelay], a
    jp Jump_000_35DB

Jump_000_3733::
    cp a, $A3
    cp a, $A3
    jr nz, Jump_000_375C
    ld a, [hl+]
    cp a, $FE
    jr z, Jump_000_3756
    ld b, a
    and a, $0F
    add a, a
    ldh [hSndNoteLength], a
    ldh [hSndNoteTimer], a
    ld a, b
    add a, $10
    and a, $F0
    ld e, a
    ldh a, [hSndChanFlags]
    and a, $0F
    or a, e

Jump_000_3751::
    ldh [hSndChanFlags], a
    jp Jump_000_35DB

Jump_000_3756::
    ldh a, [hSndChanFlags]
    and a, $0F
    jr Jump_000_3751

Jump_000_375C::
    cp a, $A5
    jr nz, Jump_000_376E
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_000_3769
    ldh a, [hSndPanning]
    swap a

Jump_000_3769::
    ldh [hSndPanning], a
    jp Jump_000_35DB

Jump_000_376E::
    cp a, $A6
    jr nz, Jump_000_3778
    ld a, [hl+]
    ldh [rNR50], a
    jp Jump_000_35DB

Jump_000_3778::
    cp a, $A7
    jr nz, Jump_000_3782
    ld a, [hl]
    ldh [hSndWaitTicks], a
    jp Jump_000_3998

Jump_000_3782::
    cp a, $A8
    jr nz, Jump_000_3794
    ld a, [hl+]
    ld c, a
    and a, $0F
    ld b, a
    ld a, c
    and a, $F0
    or a, b
    ldh [hSndA8Param], a
    jp Jump_000_35DB

Jump_000_3794::
    cp a, $A9
    jp nz, Jump_000_37FF
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_000_37DB
    cp a, $F1
    jr z, Jump_000_37E3
    cp a, $F2
    jr z, Jump_000_37EB
    cp a, $F3
    jr z, Jump_000_37F5
    cp a, $FE
    jr z, Jump_000_37B6
    cp a, $FF
    jr nz, Jump_000_37CA
    ldh a, [hSndBranchIndex]
    jr Jump_000_37B9

Jump_000_37B6::
    ld a, [wSoundEventByte18]

Jump_000_37B9::
    sla a
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
    jp SoundNextEvent

Jump_000_37CA::
    cp a, $80
    jr nc, Jump_000_37D3
    ldh [hSndBranchIndex], a
    jp Jump_000_35DB

Jump_000_37D3::
    sub a, $80
    ld [wSoundEventByte18], a
    jp Jump_000_35DB

Jump_000_37DB::
    ldh a, [hSndBranchIndex]
    inc a
    ldh [hSndBranchIndex], a
    jp Jump_000_35DB

Jump_000_37E3::
    ldh a, [hSndBranchIndex]
    dec a
    ldh [hSndBranchIndex], a
    jp Jump_000_35DB

Jump_000_37EB::
    ld a, [wSoundEventByte18]
    inc a
    ld [wSoundEventByte18], a
    jp Jump_000_35DB

Jump_000_37F5::
    ld a, [wSoundEventByte18]
    dec a
    ld [wSoundEventByte18], a
    jp Jump_000_35DB

Jump_000_37FF::
    cp a, $AA
    jr nz, Jump_000_3829
    ld a, [hl+]
    ld c, a
    and a, $F0
    jr z, Jump_000_381F
    swap a
    ldh [hSndEnvTimer], a
    or a, $F0
    ldh [hSndEnvFlags], a
    ld a, c
    and a, $0F
    ld c, a
    ldh a, [hSndEnvelopeReload]
    and a, $F0
    or a, c
    ldh [hSndEnvelopeReload], a
    jp Jump_000_35DB

Jump_000_381F::
    xor a, a
    ldh [hSndEnvTimer], a
    ldh [hSndEnvelopeReload], a
    ldh [hSndEnvFlags], a
    jp Jump_000_35DB

Jump_000_3829::
    cp a, $AC
    jr nz, Jump_000_3867
    ldh a, [hSndLoopCount]
    sub a, $01
    jr z, Jump_000_3855
    jr nc, Jump_000_3836
    ld a, [hl]

Jump_000_3836::
    ldh [hSndLoopCount], a
    ldh a, [hTrackPosLo]
    sub a, $01
    ldh [hSndReturnPosLo], a
    ldh a, [hTrackPosHi]
    sbc a, $00
    ldh [hSndReturnPosHi], a
    inc hl
    deref_hl
    srl h
    rr l
    ld a, l
    ldh [hTrackPosLo], a
    ld a, h
    ldh [hTrackPosHi], a
    jp SoundNextEvent

Jump_000_3855::
    xor a, a
    ldh [hSndLoopCount], a
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
    jp SoundNextEvent

Jump_000_3867::
    cp a, $AD
    jr nz, Jump_000_3876
    ldh a, [hSndReturnPosLo]
    ldh [hTrackPosLo], a
    ldh a, [hSndReturnPosHi]
    ldh [hTrackPosHi], a
    jp SoundNextEvent

Jump_000_3876::
    cp a, $AE
    jr nz, Jump_000_3888
    ld a, [hl+]
    and a, $10
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and a, $EF
    or a, b
    ldh [hSndDutyAndTempo], a
    jp Jump_000_35DB

Jump_000_3888::
    cp a, $AF
    jr nz, Jump_000_389C
    ld a, [hl+]
    and a, $0F
    ldh [hSndTickAccum], a
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and a, $F0
    or a, b
    ldh [hSndDutyAndTempo], a
    jp Jump_000_35DB

Jump_000_389C::
    inc hl
    jp Jump_000_35DB
    db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62

Jump_000_38B0::
    xor a, a
    ldh [hSndFreqLo], a
    ld a, $80
    ldh [hSndFreqHi], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_38C2
    call SoundNextEvent_Sub02
    ret

Jump_000_38C2::
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    xor a, a
    ldh [rNR30], a
    ret

Jump_000_38C9::
    ld b, a
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr z, Jump_000_38DF
    push de
    ldh a, [hSndEnvFlags]
    and a, $0F
    ldh [hSndEnvTimer], a
    ld c, a
    ld a, [hl]
    sub a, c
    ldh [hSndWaitTicks], a
    pop de
    jr Jump_000_38E2

Jump_000_38DF::
    ld a, [hl]
    ldh [hSndWaitTicks], a

Jump_000_38E2::
    ld a, [wSoundHwChannel]
    cp a, $03
    jr nz, Jump_000_3905
    ld a, b
    cp a, $1F
    jr z, Jump_000_38B0
    cp a, $10
    jr nc, Jump_000_3900
    ld hl, $38A0
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld l, [hl]
    ld h, $00
    jr Jump_000_3938

Jump_000_3900::
    ld l, a
    ld h, $00
    jr Jump_000_3938

Jump_000_3905::
    ld a, b
    and a, $0F
    cp a, $0C
    jr nc, Jump_000_38B0
    add a, a
    ld e, a
    ldh a, [hSndDutyAndTempo]
    and a, $10
    jr z, Jump_000_3918
    ld a, e
    add a, $18
    ld e, a

Jump_000_3918::
    ld d, $00
    ld hl, $3B5C
    add hl, de
    deref_hl
    ld a, b
    swap a
    and a, $0F
    jr z, Jump_000_3930
    ld b, a

Jump_000_3929::
    srl h
    rr l
    dec b
    jr nz, Jump_000_3929

Jump_000_3930::
    ld a, $00
    sub a, l
    ld l, a
    ld a, $08
    sbc a, h
    ld h, a

; C2 (E-0019: formula matched 1,928 of 1,928 emulated notes): pitch for a note event. The semitone (low nibble of the first byte, 0-11) indexes the period table at $3B5C ($3B74 when $FFDE bit 4 is set), the value is shifted right by the octave (high nibble) and subtracted from $0800 to give the frequency register value in HL. Noise-channel notes use $38A0.
Jump_000_3938::
    xor a, a
    ldh [hSndVibratoCounter], a
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_394C
    call SoundNextEvent_Sub04
    ld a, $80
    ldh [rNR30], a

Jump_000_394C::
    push hl
    call SoundNextEvent_Sub01
    pop hl
    ld a, [wSoundHwChannel]
    and a, a
    ldh a, [hSndSweepOrWave]
    ld c, $10
    call z, WriteChannelRegisterC
    ld a, l
    ld c, $13
    call WriteChannelRegisterC
    ld a, l
    cp a, $02
    jr c, Jump_000_396F
    cp a, $FE
    jr c, Jump_000_3971
    ld a, $FD
    jr Jump_000_3971

Jump_000_396F::
    ld a, $02

Jump_000_3971::
    ldh [hSndFreqLo], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_39AB
    cp a, $02
    jr nc, Jump_000_3989
    ldh a, [hSndDutyAndTempo]
    and a, $C0
    or a, $3F
    ld c, $11
    call WriteChannelRegisterC

Jump_000_3989::
    ld a, h
    and a, $07
    or a, $80

Jump_000_398E::
    ldh [hSndFreqHi], a
    ld c, $14
    call WriteChannelRegisterC
    call ClearChannelLengthBits

Jump_000_3998::
    ld a, [wSoundTickByte0C]
    ld b, a
    cpl
    ld c, a
    ldh a, [hSndPanning]
    and a, b
    ld b, a
    ld a, [wSoundEngineMode]
    and a, c
    or a, b
    ld [wSoundEngineMode], a
    ret

Jump_000_39AB::
    xor a, a
    ldh [rNR31], a
    ldh a, [rNR52]
    and a, $04
    jr z, Jump_000_3989
    ld a, h
    and a, $07
    jr Jump_000_398E

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: wSoundHwChannel, hSndPitchSlide, hSndEnvelope, hSndPitchSlideTime, wSoundRegBase, hSndFreqHi
; writes: hSndPitchSlideCounter, hSndEnvelope
; points at: hSndPitchSlideCounter, hSndPitchSlide
SoundTick_Sub03::
Func_000_39B9:: ; address name
    ld a, [wSoundHwChannel]
    cp a, $02
    ret z
    ldh a, [hSndPitchSlide]
    and a, a
    ret z
    ld hl, hSndPitchSlideCounter
    dec [hl]
    ret nz
    ldh a, [hSndEnvelope]
    swap a
    cp a, $10
    ret nc
    and a, $0F
    ld b, a
    ldh a, [hSndPitchSlideTime]
    ldh [hSndPitchSlideCounter], a
    ld hl, hSndPitchSlide
    ld a, [hl]
    bit 7, a
    jr nz, Jump_000_39EC
    dec [hl]
    ld a, b
    cp a, $0F
    ret z
    ldh a, [hSndEnvelope]
    add a, $10
    ldh [hSndEnvelope], a
    jp WriteChannelEnvelopeIfChanged

Jump_000_39EC::
    inc [hl]
    ld a, b
    and a, a
    ret z
    ldh a, [hSndEnvelope]
    sub a, $10
    ldh [hSndEnvelope], a
    jr WriteChannelEnvelopeIfChanged

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: wSoundHwChannel, hSndNoteTimer, hSndChanFlags, wSoundTickBuf0E, hSndFreqLo, wSoundRegBase
SoundTick_Sub04::
Func_000_39F8:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundHwChannel]
    cp a, $03
    ret z
    ldh a, [hSndNoteTimer]
    and a, a
    ret nz
    ldh a, [hSndChanFlags]
    and a, $F0
    ret z
    sub a, $10
    ld b, a
    ld a, [wSoundTickBuf0E]
    and a, $0F
    or a, b
    ld e, a
    ld d, $00
    ld hl, $3C8C
    add hl, de
    ldh a, [hSndFreqLo]
    add a, [hl]
    ld c, $13
    jr WriteChannelRegisterC

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundHwChannel, hSndVibratoDepth, hSndEnvelope, wSoundRegBase, hSndFreqHi, hSndVibratoDelay, hSndVibratoCounter, hSndA8Param
; writes: rNR32
; points at: hSndEnvelope
SoundNextEvent_Sub01::
Func_000_3A21:: ; address name
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A57
    ldh a, [hSndVibratoDepth]
    and a, a
    jr nz, Jump_000_3A94
    ldh a, [hSndEnvelope]

; B = A (bit 3 set when the low three bits are 0); writes it to the channel envelope register (wDD0D + $12) only if it differs, then restarts the channel (E-0124)
; 2 call sites from 2 routines (e.g. SoundNextEvent, SoundTick)
; reads: wSoundRegBase, hSndFreqHi
WriteChannelEnvelopeIfChanged::
Func_000_3A2F:: ; address name
    ld b, a
    and a, $07
    jr nz, Jump_000_3A38
    ld a, b
    or a, $08
    ld b, a

Jump_000_3A38::
    ld a, [wSoundRegBase]
    add a, $12
    ld c, a
    ldh a, [c]
    cp a, b
    ret z
    ld a, b
    ldh [c], a
    ldh a, [hSndFreqHi]
    ld c, $14
    call WriteChannelRegisterC
    call ClearChannelLengthBits
    ret

; A = value, C = register offset: writes A to $FF00 + wDD0D + C (wDD0D holds the current sound channel's register base); B = A (E-0077)
; 5 call sites from 2 routines (e.g. SoundNextEvent, WriteChannelEnvelopeIfChanged)
; reads: wSoundRegBase
WriteChannelRegisterC::
Func_000_3A4E:: ; address name
    ld b, a
    ld a, [wSoundRegBase]
    add a, c
    ld c, a
    ld a, b
    ldh [c], a
    ret

Jump_000_3A57::
    ldh a, [hSndEnvelope]
    ld c, $12
    jr WriteChannelRegisterC

; [$FF00 + wDD0D + $11] &= $C0: keeps the duty bits of the current channel's length/duty register and clears its length (E-0114)
; 2 call sites from 2 routines (e.g. SoundNextEvent, WriteChannelEnvelopeIfChanged)
; reads: wSoundRegBase
ClearChannelLengthBits::
Func_000_3A5D:: ; address name
    ld c, $11
    ld a, [wSoundRegBase]
    add a, c
    ld c, a
    ldh a, [c]
    and a, $C0
    ldh [c], a
    ret

Jump_000_3A69::
    ld a, e
    srl a
    add a, $02
    swap a
    ld hl, hSndEnvelope
    cp a, [hl]
    ret c
    and a, $60
    ldh [rNR32], a
    ret

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: hSndFreqLo, hSndFreqHi, wSoundHwChannel, hSndVibratoDepth, hSndVibratoDelay, hSndVibratoCounter, hSndA8Param, hSndEnvelope, ...
; writes: rNR32
; points at: hSndEnvelope
SoundTick_Sub05::
Func_000_3A7A:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ldh a, [hSndFreqLo]
    and a, a
    jr nz, Jump_000_3A89
    ldh a, [hSndFreqHi]
    and a, $7F
    jp z, SoundNextEvent_Sub02

Jump_000_3A89::
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A94
    ldh a, [hSndVibratoDepth]
    and a, a
    ret z

Jump_000_3A94::
    ldh a, [hSndVibratoDelay]
    and a, a
    ret z
    ld e, $00
    ld c, a
    ldh a, [hSndVibratoCounter]
    ld b, $04

Jump_000_3A9F::
    add a, a
    cp a, c
    jr c, Jump_000_3AA4
    sub a, c

Jump_000_3AA4::
    ccf
    rl e
    dec b
    jr nz, Jump_000_3A9F
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A69
    ldh a, [hSndVibratoDepth]
    or a, e
    ld e, a
    ld d, $00
    push de
    ldh a, [hSndA8Param]
    and a, $0F
    ld de, SoundModulationTable
    sla a
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    add hl, de
    ldh a, [hSndEnvelope]
    swap a
    ld e, a
    ld a, [hl]
    ld h, a
    and a, $F0
    or a, e
    ld e, a
    bit 2, h
    jr nz, Jump_000_3B05
    inc b
    ld a, c
    swap a
    and a, $0F
    jr z, Jump_000_3B05
    ld b, a
    bit 3, e
    jr nz, Jump_000_3AFE
    sla b
    bit 2, e
    jr nz, Jump_000_3AFE
    sla b
    bit 1, e
    jr z, Jump_000_3B03

Jump_000_3AFE::
    ld a, b
    cp a, $08
    jr c, Jump_000_3B05

Jump_000_3B03::
    ld b, $00

Jump_000_3B05::
    bit 1, h
    jr z, Jump_000_3B0E
    ld a, b
    jr z, Jump_000_3B0E
    srl b

Jump_000_3B0E::
    ld a, h
    and a, $08
    or a, b
    ld b, a
    bit 0, h
    jr z, Jump_000_3B20
    ld hl, $3B8C
    add hl, de
    ld a, [hl]
    or a, b
    jp WriteChannelEnvelopeIfChanged

Jump_000_3B20::
    ld c, $12
    ld a, [wSoundRegBase]
    add a, c
    ld c, a
    ldh a, [c]
    and a, $08
    ld l, a
    ld a, h
    and a, $08
    cp a, l
    ret z
    ld hl, $3B8C
    add hl, de
    ld a, [hl]
    or a, b
    jp WriteChannelEnvelopeIfChanged

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundRegBase, hSndFreqHi
SoundNextEvent_Sub02::
Func_000_3B39:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, $00
    jp WriteChannelEnvelopeIfChanged

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundSkipMaskB, wSoundEngineMode
; writes: wSoundEngineMode
SoundNextEvent_Sub03::
Func_000_3B41:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundSkipMaskB]
    cpl
    ld b, a
    ld a, [wSoundEngineMode]
    and a, b
    ld [wSoundEngineMode], a
    ret

; when wDD08 & wDD0B is non-zero, drops the caller's return address (pop af) so it returns to the caller's caller; otherwise returns normally with Z set (E-0119)
; 6 call sites from 5 routines (e.g. SoundNextEvent, SoundNextEvent_Sub02, SoundNextEvent_Sub03, SoundTick_Sub05, ...)
; reads: wSoundSkipMaskB, wSoundSkipMaskA
ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB::
Func_000_3B51:: ; address name
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    ret z
    pop af
    ret
    db $D4, $07, $64, $07, $F9, $06, $95, $06, $37, $06, $DD, $05, $89, $05, $3A, $05
    db $F0, $04, $A8, $04, $65, $04, $26, $04, $9C, $07, $2E, $07, $C7, $06, $66, $06
    db $0A, $06, $B3, $05, $61, $05, $15, $05, $CC, $04, $86, $04, $45, $04, $08, $04
    ds $18, $00
    INCBIN "dwm2-cobi-us.gbc", $003BA4, $126
    ds $12, $FF
    ds $10, $FE
    ds $10, $01
    ds $10, $02
    ds $70, $00

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundEventByte17, hSndSweepOrWave, hSndA8Param
; writes: wSoundEventByte17, rNR30
SoundNextEvent_Sub04::
Func_000_3D7C:: ; address name
    ld a, [wSoundEventByte17]
    ld b, a
    ldh a, [hSndSweepOrWave]
    cp a, b
    ret z
    ld [wSoundEventByte17], a
    ld e, a
    swap e
    xor a, a
    ldh [rNR30], a

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: hSndA8Param
SoundTick_Sub06::
Func_000_3D8D:: ; address name
    ld d, a
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndA8Param]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld de, rWAVE
    ld b, $10

Jump_000_3DA7::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_3DA7
    ret

; C2 static reading (E-0019): address of a label slot: HL = $DCC0 + channel*12 + (B & $0F)*3. A slot holds a repeat counter and a saved position (2 bytes); used by the FD, B0 and B1-BF commands.
; 3 call sites from 1 routine (e.g. SoundNextEvent)
; reads: wSoundChannelIndex
; points at: wSoundLabelSlots
SoundLabelSlot::
Func_000_3DAE:: ; address name
    ld a, [wSoundChannelIndex]
    add a, a
    ld c, a
    add a, a
    add a, c
    add a, a
    ld c, a
    ld a, b
    and a, $0F
    ld b, a
    add a, a
    add a, b
    add a, c
    ld hl, wSoundLabelSlots
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ret

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: hSndEnvelopeReload, hSndEnvelope
; writes: hSndEnvelopeReload, hSndEnvelope
SoundTick_Sub07::
Func_000_3DC8:: ; address name
    push de
    push bc
    ldh a, [hSndEnvelopeReload]
    and a, $0F
    inc a
    ld d, a
    ld bc, $0000
    ldh a, [hSndEnvelope]
    swap a
    and a, $0F
    inc a
    ld e, a

Jump_000_3DDB::
    ld a, e
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    dec d
    jr nz, Jump_000_3DDB
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld a, c
    and a, a
    jr nz, Jump_000_3DFB
    ld c, $01

Jump_000_3DFB::
    swap c
    ldh a, [hSndEnvelope]
    ld d, a
    and a, $F0
    ld e, a
    ldh a, [hSndEnvelopeReload]
    and a, $0F
    or a, e
    ldh [hSndEnvelopeReload], a
    ld a, d
    and a, $0F
    or a, c
    ldh [hSndEnvelope], a
    pop bc
    pop de
    ret

; E-0018 (C2: static reading of Func_000_3354, and 495 emulated sound starts read exactly the banks this table names). Func_000_3354 takes the first entry whose first byte is greater than the sound id; the PREVIOUS entry gives the base id, record array and bank. A first byte of $FF ends the table.
; record: first sound id of this range; record array in that bank; ROM bank holding the records and tracks
SoundBankTable::
Data_000_3E13:: ; address name
    db $00 ; entry 0
    dfar SoundRecords_Bank40
    db $1C ; entry 1
    dfar SoundRecords_Bank41
    db $31 ; entry 2
    dfar SoundRecords_Bank42
    db $A8 ; entry 3
    dfar SoundRecords_Bank43
    db $FF, $FF

; A = slot: returns carry set when the slot is absent (CarryUnlessBattleSlotOutSlotEmpty) or when status +0 & $D0, +3 & $3F, +5 & $C0 or +8 bit 3 is set (wBattleStatus + 9 * slot); otherwise carry clear; A, BC, HL kept (E-0058)
; 34 call sites from 31 routines (e.g. CheckSlotStatusBlockWide_Bank05, FailIfAbleAllyKnowsSkillList6D1A, FailIfAllyLacksMPForSkillList5AF8, FailIfAllyLacksMPForHealSkill, ...)
; points at: wBattleStatus
CheckSlotStatusBlock::
Func_000_3E25:: ; address name
    push hl
    push bc
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_000_3E50
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $D0
    jr nz, Jump_000_3E4F
    inc hl
    inc hl
    ld a, [hl+]
    and a, $3F
    jr nz, Jump_000_3E4F
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_000_3E4F
    inc hl
    inc hl
    bit 3, [hl]
    jr nz, Jump_000_3E4F
    xor a, a
    jr Jump_000_3E50

Jump_000_3E4F::
    scf

Jump_000_3E50::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot number; returns with carry clear only when A < 8 and wDA63[A] is zero (carry set for A >= 8, for $FF and for any other non-zero value); A, BC and HL are preserved
; 289 call sites from 243 routines (e.g. CheckSlotStatusBlock, FoeHPCheckReadsWrongSlot, CheckFoeStatus7Bit2, CheckLoneFoeHPNotBelowAIDamageEstimates, ...)
; points at: wBattleSlotOut
CarryUnlessBattleSlotOutSlotEmpty::
Func_000_3E54:: ; address name
    push hl
    push bc
    ld c, a
    cp a, $08
    jr nc, Jump_000_3E6E
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_000_3E72
    cp a, $FF
    jr z, Jump_000_3E6E
    scf
    jr Jump_000_3E76

Jump_000_3E6E::
    xor a, a
    scf
    jr Jump_000_3E76

Jump_000_3E72::
    ld a, $0A
    cp a, $01

Jump_000_3E76::
    ld a, c
    pop bc
    pop hl
    ret

; Z set when HL == BC; A is clobbered
; 179 call sites from 117 routines (e.g. RandomInRange, DebugMonsterRecordViewer_Update, ClampDebugValueToTableLimit, FoeHPCheckReadsWrongSlot, ...)
CompareHLToBC::
Func_000_3E7A:: ; address name
    ld a, h
    cp a, b
    ret nz
    ld a, l
    cp a, c
    ret

; CompareHLToBC with shortcuts when BC or HL is zero: equal zeros give A = 0 and NC, HL = 0 < BC gives carry (E-0124)
; 5 call sites from 4 routines (e.g. AIGateCompareAllyStatAverages, ChooseTarget_MegaMagic, ChooseTarget_Blaze, ChooseTarget_Beat)
CompareHLToBCFastZero:: ; heuristic: follows a terminator; C0
Func_000_3E80:: ; address name
    ld a, b
    or a, c
    jr nz, Jump_000_3E8F
    ld a, h
    or a, l
    jr nz, Jump_000_3E8C
    xor a, a
    scf
    ccf
    ret

Jump_000_3E8C::
    scf
    ccf
    ret

Jump_000_3E8F::
    ld a, h
    or a, l
    jr nz, CompareHLToBC
    ld a, $01
    or a, a
    scf
    ret

; HL = minimum, BC = maximum: returns DE = minimum + (random mod (maximum - minimum + 1)), the random value being wC5E8:wC5E7 after AdvanceRandom; DE = HL when the two are equal (73 call sites)
; 19 call sites from 16 routines (e.g. RunBattleCommandEntry_Case04_Sub01, AddRandomWeightByValueBand, RollDamageBaseToBasePlusBattleArg2, ComputeBasicDamage, ...)
; reads: wRandomLo, wRandomHi
RandomInRange::
Func_000_3E98:: ; address name
    call CompareHLToBC
    jr z, Jump_000_3ED1
    ld a, h
    or a, l
    jr z, Jump_000_3EB1
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    ld a, c
    add a, l
    ld c, a
    ld a, b
    adc a, h
    ld b, a

Jump_000_3EB1::
    ld a, c
    add a, $01
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    push hl
    call AdvanceRandom
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    call DivideHLByBC
    pop hl
    ld a, c
    sub a, l
    ld e, a
    ld a, b
    sbc a, h
    ld d, a
    jr Jump_000_3ED3

Jump_000_3ED1::
    ld e, a
    ld d, h

Jump_000_3ED3::
    ret

; when wC58A is 0 calls NextTableByte (wC5E8 = index, wC5E7 = table byte); in link mode runs the same step on the synchronised copy in wC5BA/wC5BB
; 76 call sites from 60 routines (e.g. RandomInRange, ChooseHighestWeightedAction, AddSkillBaseWeightAndLoadSkill_Sub01, AIPickRandomSkillOfKind3, ...)
; reads: wLinkMode, wRandomSeed2Lo, wRandomSeed2Hi, wRandomLo, wRandomHi
; writes: wRandomLo, wRandomHi, wRandomSeed2Lo, wRandomSeed2Hi
AdvanceRandom::
Func_000_3ED4:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, NextTableByteSecondStream
    call NextTableByte
    ret

; advances a second random stream: loads the state in wC5BA/wC5BB into wC5E7/wC5E8, runs NextTableByte and stores the result back in wC5BA/wC5BB (wC5E7/wC5E8 keep the new value); HL kept (E-0090)
; 4 call sites from 4 routines (e.g. RunBattleCommandEntry_Case01, RunBattleCommandEntry_BankA1_Case04_Sub02, RunBattleCommandEntry_BankA1_Case04_Sub01, RunBattleCommandEntry_BankA1_Case01)
; reads: wRandomSeed2Lo, wRandomSeed2Hi, wRandomLo, wRandomHi
; writes: wRandomLo, wRandomHi, wRandomSeed2Lo, wRandomSeed2Hi
NextTableByteSecondStream::
Func_000_3EDE:: ; address name
    push hl
    ld a, [wRandomSeed2Lo]
    ld l, a
    ld a, [wRandomSeed2Hi]
    ld h, a
    ld a, l
    ld [wRandomLo], a
    ld a, h
    ld [wRandomHi], a
    call NextTableByte
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    ld a, l
    ld [wRandomSeed2Lo], a
    ld a, h
    ld [wRandomSeed2Hi], a
    pop hl
    ret

; HL = HL / BC (quotient), BC = HL mod BC; clobbers A, DE
; 8 call sites from 8 routines (e.g. RandomInRange, DivideHLBy3, RandomWithin5PercentOfHL, ChooseTarget_Heal, ...)
DivideHLByBC::
Func_000_3F04:: ; address name
    ld de, $0000
    ld a, b
    or a, a
    jr z, Jump_000_3F16

Jump_000_3F0B::
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_000_3F1F
    inc de
    jr Jump_000_3F0B

Jump_000_3F16::
    ld a, c
    call DivideHLByA
    ld c, a
    ld b, $00
    jr Jump_000_3F24

Jump_000_3F1F::
    add hl, bc
    ld b, h
    ld c, l
    ld h, d
    ld l, e

Jump_000_3F24::
    ret

; HL += (A * 9) & $FF (the product is computed in 8 bits and wraps); A is clobbered, other registers preserved
; 305 call sites from 250 routines (e.g. CheckSlotStatusBlock, SlotHasStatus3Or4Bits_Bank05, CheckSlotStatusBlockWide_Bank05, Func_005_4075, ...)
AddAx9ToHL::
Func_000_3F25:: ; address name
    push de
    ld d, a
    add a, a
    add a, a
    add a, a
    add a, d
    pop de
    add_a_to_hl
    ret

; A = battle slot, E = field offset: HL = wBattlerRecords + $4E * A' + E, where A' = A - 1 for A >= 3, so slots 0-2 and 4-6 map to records 0-5 (slots 3 and 7 have no record here; GetBaseHP handles them separately); clobbers A, BC (E-0059, E-0062)
; 17 call sites from 17 routines (e.g. RecomputeTargetMaxHPAndMP, ActionEffect_Transform_Sub01_Sub04, ActionEffect_Transform_Sub01_Sub03, RecomputeTargetStatsFromRecord, ...)
; points at: wBattlerRecords
BattlerRecordFieldAddress::
Func_000_3F32:: ; address name
    cp a, $03
    jr c, Jump_000_3F37
    dec a

Jump_000_3F37::
    ld c, $4E
    call Multiply8
    ld bc, wBattlerRecords
    add hl, bc
    ld a, e
    add_a_to_hl
    ret

; Z set when A equals the queued action (wQueuedActionId, wDAAC) or is its partner in one of the pairs $34-$AD, $35-$AE, $6A-$CC, $A1-$CF, $8F-$AA (the pairs are symmetric); Z clear otherwise. A and BC are kept (E-0049)
; 3 call sites from 3 routines (e.g. SkillPassesRepeatCheck, CheckSkillMPCost, Func_032_4ADC_Case01_Case03)
; reads: wQueuedActionId
QueuedActionMatches::
Func_000_3F47:: ; address name
    push bc
    push af
    ld a, [wQueuedActionId]
    ld c, a
    pop af
    cp a, c
    jr nz, Jump_000_3F53

Jump_000_3F51::
    pop bc
    ret

Jump_000_3F53::
    cp a, $34
    jr nz, Jump_000_3F5C
    ld a, $AD
    cp a, c
    jr Jump_000_3F51

Jump_000_3F5C::
    cp a, $AD
    jr nz, Jump_000_3F65
    ld a, $34
    cp a, c
    jr Jump_000_3F51

Jump_000_3F65::
    cp a, $35
    jr nz, Jump_000_3F6E
    ld a, $AE
    cp a, c
    jr Jump_000_3F51

Jump_000_3F6E::
    cp a, $AE
    jr nz, Jump_000_3F77
    ld a, $35
    cp a, c
    jr Jump_000_3F51

Jump_000_3F77::
    cp a, $6A
    jr nz, Jump_000_3F80
    ld a, $CC
    cp a, c
    jr Jump_000_3F51

Jump_000_3F80::
    cp a, $CC
    jr nz, Jump_000_3F89
    ld a, $6A
    cp a, c
    jr Jump_000_3F51

Jump_000_3F89::
    cp a, $A1
    jr nz, Jump_000_3F92
    ld a, $CF
    cp a, c
    jr Jump_000_3F51

Jump_000_3F92::
    cp a, $CF
    jr nz, Jump_000_3F9B
    ld a, $A1
    cp a, c
    jr Jump_000_3F51

Jump_000_3F9B::
    cp a, $8F
    jr nz, Jump_000_3FA4
    ld a, $AA
    cp a, c
    jr Jump_000_3F51

Jump_000_3FA4::
    cp a, $AA
    jr nz, Jump_000_3F51
    ld a, $8F
    cp a, c
    jr Jump_000_3F51
    ds $53, $00
