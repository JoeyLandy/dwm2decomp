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
; 7 call sites from 7 routines (e.g. CallFlagBitHandlerE, RunEffectHandlerForActionId, DispatchActionEffectTable, ChooseActionTarget, ...)
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

; the LCD STAT interrupt vector ($0048): jumps to the handler at ComputeSpriteScrollOffsets_Skip2 (E-0114)
; no direct call (reached through a table, a jump or a vector)
; reads: rSVBK, wSTATSplitEnable
; writes: rSVBK
StatInterruptVector::
Func_000_0048:: ; address name
    jp ComputeSpriteScrollOffsets_Skip2
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; the serial-transfer interrupt vector ($0058): jumps to the handler at ComputeSpriteScrollOffsets_Skip (E-0114)
; no direct call (reached through a table, a jump or a vector)
SerialInterruptVector::
Func_000_0058:: ; address name
    jp ComputeSpriteScrollOffsets_Skip
    db $D9
    ds $24, $00

; copies the 10 bytes at $008E (ld a,$C0 / ldh [rDMA],a / wait / ret) to HRAM at $FF80
; 1 call site from 1 routine (e.g. BootAndMainLoop)
InstallOamDmaRoutine::
Func_000_0080:: ; address name
    ld c, $80
    ld b, $0A
    ld hl, $008E

.loop:
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop
    ret

; the OAM DMA routine copied to HRAM: starts DMA from $C000 (ld a, $C0; ldh [rDMA], a) and waits $28 loop iterations; never called in place (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: rDMA
OamDmaRoutineTemplate:: ; heuristic: follows a terminator; C0
Func_000_008E:: ; address name
    ld a, $C0
    ldh [rDMA], a
    ld a, $28

.loop:
    dec a
    jr nz, .loop
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

; E-0239 (HARDWARE: the standard Game Boy cartridge header layout; the byte values are those of the reference ROM and are kept exactly, checksums included; ASCII fields are written as numbers because charmap.inc maps letters to the game's encoding).
; record: cartridge header $0104-$014F, one field per line: Nintendo logo (3 lines); title "DWM2-C" padded with $00; manufacturer "BQLE"; CGB flag $80; new licensee "B4"; SGB flag $03; cartridge type $1B (MBC5 + RAM + battery); ROM size $07 (4 MiB); RAM size $03 (32 KiB); destination $01 (overseas); old licensee $33 (use the new code); version $00; header checksum; global checksum (big-endian)
CartridgeHeader::
Data_000_0104:: ; address name
    db $CE, $ED, $66, $66, $CC, $0D, $00, $0B, $03, $73, $00, $83, $00, $0C, $00, $0D ; id 0: Nintendo logo bytes 0-15
    db $00, $08, $11, $1F, $88, $89, $00, $0E, $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99 ; Nintendo logo bytes 16-31
    db $BB, $BB, $67, $63, $6E, $0E, $EC, $CC, $DD, $DC, $99, $9F, $BB, $B9, $33, $3E ; Nintendo logo bytes 32-47
    db $44, $57, $4D, $32, $2D, $43, $00, $00, $00, $00, $00 ; title, ASCII "DWM2-C" padded with $00
    db $42, $51, $4C, $45 ; manufacturer code, ASCII "BQLE"
    db $80 ; CGB flag ($80 = CGB features, also runs on DMG)
    db $42, $34 ; new licensee code, ASCII "B4"
    db $03 ; SGB flag ($03 = SGB functions)
    db $1B ; cartridge type ($1B = MBC5 + RAM + battery)
    db $07 ; ROM size ($07 = 4 MiB, 256 banks)
    db $03 ; RAM size ($03 = 32 KiB)
    db $01 ; destination ($01 = overseas)
    db $33 ; old licensee ($33 = use the new licensee code)
    db $00 ; version ($00)
    db $E7 ; header checksum (as stored)
    db $85, $9E ; global checksum, big-endian (as stored)

; entry after the header jump: wIsCGB = 1 when A was $11 at power-on; disables interrupts, sets the stack, clears RAM, installs the OAM DMA routine, clears VRAM, sets game mode 5 and the MBC banks, then runs the main loop (E-0131)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wLinkMode, wModeChangeRequest, wFadeState
; writes: wIsCGB, rVBK, wGameMode, rRAMB, rRAMG, rROMB0, rROMB1, wSGBActive, ...
; points at: wGameMode, wScreenShakeTimer
BootAndMainLoop::
Func_000_0150:: ; address name
    cp a, $11
    ld a, $00
    jr nz, .set_is_cgb
    inc a

.set_is_cgb:
    ld [wIsCGB], a

BootAndMainLoop_CallDisableVBlankTimerSerialJoypadInterrupts::
Jump_000_015A:: ; address name
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
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0800
    xor a, a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
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
    jr z, .call_detect_sgb
    xor a, a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rRP], a
    farcall LoadPalette0FromData4322
    jr .clear_sgb_active

.call_detect_sgb:
    call DetectSGB
    jr c, .call_delay_bc_when_sgb

.clear_sgb_active:
    xor a, a
    ld [wSGBActive], a
    jp .call_clear_bg_map_or_fill_with_c3

.call_delay_bc_when_sgb:
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
    ld e, LOW(Gfx_17_448C)
    ld d, HIGH(Gfx_17_448C)
    ld b, BANK(Gfx_17_448C)
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

.call_clear_bg_map_or_fill_with_c3:
    ei

.call_clear_bg_map_or_fill_with_c32:
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

.loop:
    ld a, [wLinkMode]
    or a, a
    call z, NextTableByte
    halt
    nop
    ld a, [wModeChangeRequest]
    or a, a
    jr z, .loop
    ld a, [wFadeState]
    or a, a
    jr z, .call_disable_v_blank_timer_serial_joypad
    bit 7, a
    jr z, .loop

.call_disable_v_blank_timer_serial_joypad:
    di
    call DisableVBlankTimerSerialJoypadInterrupts
    call SpinDelay
    ld a, $00
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    jp .call_clear_bg_map_or_fill_with_c32

; jumps through a 9-entry table indexed by wGameMode to the mode's start-up routine (banks $01, $02, $03, none, $31, $07, $24, $A0, $F2); called from the main loop each time the mode changes
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wGameMode
RunGameModeInit::
Func_000_0355:: ; address name
    ld a, [wGameMode]
    rst $00
    dw RunGameModeInit_ToGameMode0_Init
    dw RunGameModeInit_ToGameMode1_Init
    dw RunGameModeInit_ToGameMode2_Init
    dw RunGameModeInit_Return
    dw RunGameModeInit_ToGameMode4_Init
    dw RunGameModeInit_ToGameMode5_Init
    dw RunGameModeInit_ToGameMode6_Init
    dw RunGameModeInit_ToGameMode7_Init
    dw RunGameModeInit_ToGameMode8_Init

; entry 0 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode0_Init::
Jump_000_036B:: ; address name
    farcall GameMode0_Init
    ret

; entry 1 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode1_Init::
Jump_000_0372:: ; address name
    farcall GameMode1_Init
    ret

; entry 2 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode2_Init::
Jump_000_0379:: ; address name
    farcall GameMode2_Init
    ret

; entry 3 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_Return::
Jump_000_0380:: ; address name
    ret

; entry 4 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode4_Init::
Jump_000_0381:: ; address name
    farcall GameMode4_Init
    ret

; entry 5 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode5_Init::
Jump_000_0388:: ; address name
    farcall GameMode5_Init
    ret

; entry 6 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode6_Init::
Jump_000_038F:: ; address name
    farcall GameMode6_Init
    ret

; entry 7 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode7_Init::
Jump_000_0396:: ; address name
    farcall GameMode7_Init
    ret

; entry 8 of the `rst $00` table in RunGameModeInit
; no direct call (reached through a table, a jump or a vector)
RunGameModeInit_ToGameMode8_Init::
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
    jp nz, .call_write_lcdc_shadow
    set 0, [hl]
    call $FF80
    ld a, [wIsCGB]
    or a, a
    jr z, .call_flush_queued_bg_map_write
    ld a, [wFadeState]
    or a, a
    jr nz, .call_flush_queued_bg_map_write
    ld hl, wBGPaletteUploadRequest
    ld a, [hl]
    inc hl
    or a, [hl]
    jr z, .call_flush_queued_bg_map_write
    ld a, [wBGPaletteUploadRequest]
    or a, a
    call nz, UploadBGPalettes
    xor a, a
    ld [wBGPaletteUploadRequest], a
    ld a, [wOBJPaletteUploadRequest]
    or a, a
    call nz, VBlankHandler_HLFromABits3To5
    xor a, a
    ld [wOBJPaletteUploadRequest], a

.call_flush_queued_bg_map_write:
    call FlushQueuedBGMapWrite
    call CopyDMGPalettesToHardware
    call CopyScrollToHardware
    call ApplyScreenShake
    call WriteLCDCShadow
    ld a, [wLinkMode]
    and a, a
    jr nz, .call_sound_tick
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
    jr .check_fade_state

.call_sound_tick:
    call SoundTick
    ei
    call ProcessSoundQueue
    call GameFrameUpdate
    jr .check_fade_state

.check_fade_state:
    ld a, [wFadeState]
    or a, a
    jr nz, .skip
    ld a, [wJoypadHeld]
    and a, $0F
    cp a, $0F
    jr nz, .check_link_mode
    ld a, [wLinkMode]
    or a, a
    jp z, BootAndMainLoop_CallDisableVBlankTimerSerialJoypadInterrupts

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr nz, .skip

.skip:
    ld hl, wVBlankFlags
    res 0, [hl]

.restore:
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

.call_write_lcdc_shadow:
    call WriteLCDCShadow
    call SoundTick
    ei
    jr .restore

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
    jr z, .call_clear_unused_oam_entries
    bit 7, a
    ret z

.call_clear_unused_oam_entries:
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
    jr nz, .read_game_mode
    ld a, [wFadeState]
    or a, a
    jr z, .read_game_mode
    bit 7, a
    ret z

.read_game_mode:
    ld a, [wGameMode]
    rst $00
    dw RunGameModeUpdate_ToGameMode0_Update
    dw RunGameModeUpdate_ToGameMode1_Update
    dw RunGameModeUpdate_ToGameMode2_Update
    dw RunGameModeUpdate_Return
    dw RunGameModeUpdate_ToGameMode4_Update
    dw RunGameModeUpdate_ToGameMode5_Update
    dw RunGameModeUpdate_ToGameMode6_Update
    dw RunGameModeUpdate_ToGameMode7_Update
    dw RunGameModeUpdate_ToGameMode8_Update

; entry 0 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode0_Update::
Jump_000_04B4:: ; address name
    farcall GameMode0_Update
    ret

; entry 1 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode1_Update::
Jump_000_04BB:: ; address name
    farcall GameMode1_Update
    ret

; entry 2 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode2_Update::
Jump_000_04C2:: ; address name
    farcall GameMode2_Update
    ret

; entry 3 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_Return::
Jump_000_04C9:: ; address name
    ret

; entry 4 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode4_Update::
Jump_000_04CA:: ; address name
    farcall GameMode4_Update
    ret

; entry 5 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode5_Update::
Jump_000_04D1:: ; address name
    farcall GameMode5_Update
    ret

; entry 6 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode6_Update::
Jump_000_04D8:: ; address name
    farcall GameMode6_Update
    ret

; entry 7 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode7_Update::
Jump_000_04DF:: ; address name
    farcall GameMode7_Update
    ret

; entry 8 of the `rst $00` table in RunGameModeUpdate
; no direct call (reached through a table, a jump or a vector)
RunGameModeUpdate_ToGameMode8_Update::
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
    jr z, .check_screen_shake_offset2
    dec a
    ld [wScreenShakeTimer], a
    ldh a, [rSCY]
    ld b, a
    ld a, [wScreenShakeTimer]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, .check_screen_shake_offset
    xor a, $07

.check_screen_shake_offset:
    add a, b
    ldh [rSCY], a

.check_screen_shake_offset2:
    ld a, [wScreenShakeOffset]
    or a, a
    jr z, .return
    dec a
    ld [wScreenShakeOffset], a
    ldh a, [rSCX]
    ld b, a
    ld a, [wScreenShakeOffset]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, .skip
    xor a, $07

.skip:
    sub a, $04
    add a, b
    ldh [rSCX], a

.return:
    ret
    db $CD, $CC, $0B, $C9

; in link mode: counts frames (resetting the game after an overflow), saves the joypad state and starts the next serial transfer of the queued byte or the joypad (E-0128)
; 8 call sites from 8 routines (e.g. GameMode5_Update_LinkExchangeJoypadPerFrame_Case04, GameMode5_Update_LinkExchangeJoypadPerFrame_Case03, GameMode5_Update_LinkExchangeJoypadPerFrame, RunLinkSession4ScreenState_Case08_SetLinkSendByte_Case04, ...)
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
    jp nz, BootAndMainLoop_CallDisableVBlankTimerSerialJoypadInterrupts
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld a, [wLinkSession]
    cp a, $05
    jr nz, .check_v_blank_flags
    ld a, [wVBlankFlags]
    bit 1, a
    ret nz
    jr .read_joypad_held

.check_v_blank_flags:
    ld a, [wVBlankFlags]
    bit 1, a
    jr nz, .clear_link_saved_joypad_held
    bit 2, a
    jr nz, .clear_link_saved_joypad_held
    bit 7, a
    jr nz, .clear_link_saved_joypad_held
    jr .read_joypad_held

.clear_link_saved_joypad_held:
    xor a, a
    ld [wLinkSavedJoypadHeld], a
    ld [wLinkSavedJoypadHeldPrev], a
    ret

.read_joypad_held:
    ld a, [wJoypadHeld]
    ld [wLinkSavedJoypadHeld], a
    ld a, [wJoypadHeldPrev]
    ld [wLinkSavedJoypadHeldPrev], a
    call PollJoypad
    ld a, [wLinkSendByte]
    cp a, $FF
    jr z, .skip
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, [wLinkSendByte]
    jp StartSerialTransferInternalClock

.skip:
    ld hl, wLinkBufferCountLo
    ld a, [hl+]
    or a, [hl]
    jr z, .set_link_exchange_state_to_00
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

.set_link_exchange_state_to_00:
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, $F0
    jp StartSerialTransferInternalClock

; returns at once if wC524 is zero, otherwise counts DE from $1B58 to 0 with three nops per step
; 44 call sites from 15 routines (e.g. BootAndMainLoop, DetectSGB, StepFade_ClearSGBPacketBuffer, ClearSGBPacketBuffer_SendSGBPacketSet, ...)
; reads: wSGBActive
SpinDelay::
Func_000_05D1:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld de, $1B58

.loop:
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, .loop
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
    jr nz, .set_sgb_packet_index_to_0A
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
    jr nz, .set_sgb_packet_index_to_0A
    ld a, $0A
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    sub a, a
    ret

.set_sgb_packet_index_to_0A:
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
PollJoypad_WriteP1::
Func_000_0646:: ; address name
    ldh a, [rP1]
    ld b, $04
    ld c, a
    jr .skip

.loop:
    ldh a, [rP1]
    cp a, c
    ret z

.skip:
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
    jr nz, .loop
    ret

; returns at once when wSGBActive is 0; otherwise busy-waits BC times about $06D6 loop passes
; 5 call sites from 3 routines (e.g. BootAndMainLoop, SGBTransferCompressed, SGBTransferRaw)
; reads: wSGBActive
DelayBCWhenSGB::
Func_000_0692:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z

.loop:
    ld de, $06D6

.loop2:
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, .loop2
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
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

.loop:
    ld b, $14

.loop2:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop2
    add hl, de
    dec c
    jr nz, .loop
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

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, vBGMap0
    ld de, $000C
    ld a, $80
    ld c, $0D

.loop2:
    ld b, $14

.loop3:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop3
    add hl, de
    dec c
    jr nz, .loop2
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
; 5 call sites from 3 routines (e.g. StepFade_ClearSGBPacketBuffer, StartPaletteFade, SendSGBPaletteSetPacket)
; points at: wSGBPacketBuffer
ClearSGBPacketBuffer::
Func_000_076B:: ; address name
    push hl
    push bc
    xor a, a
    ld hl, wSGBPacketBuffer
    ld c, $10

.loop:
    ld [hl+], a
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ret

ClearSGBPacketBuffer_CheckLinkMode::
Jump_000_077A:: ; address name
    push af
    ld a, [wLinkMode]
    or a, a
    jr z, .call_clear_sgb_packet_buffer_send_sgb_packet
    call ClearSGBPacketBuffer_WaitSerialTransferDone

.call_clear_sgb_packet_buffer_send_sgb_packet:
    call ClearSGBPacketBuffer_SendSGBPacketSet
    pop af
    call ClearSGBPacketBuffer_WriteIFAndIE
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

.loop:
    ldh a, [rLY]
    cp a, $91
    jr nz, .loop
    res 7, [hl]
    ld hl, wLCDCShadow
    res 7, [hl]
    ret

; only called from ClearSGBPacketBuffer (E-0047)
; 1 call site from 1 routine (e.g. ClearSGBPacketBuffer)
; reads: wSGBActive
; writes: rLCDC, wSGBPacketIndex
; points at: wLCDCShadow
ClearSGBPacketBuffer_SendSGBPacketSet::
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
; 3 call sites from 2 routines (e.g. ClearSGBPacketBuffer_WaitSerialTransferDone, RunLinkSession_WaitSerialTransferDone)
; reads: rSC
WaitSerialTransferDone::
Func_000_07D1:: ; address name
    ldh a, [rSC]
    bit 7, a
    jr nz, WaitSerialTransferDone
    ret

; only called from routines of ClearSGBPacketBuffer (E-0098)
; 2 call sites from 2 routines (e.g. ClearSGBPacketBuffer, ClearSGBPacketBuffer_WaitSerialTransferDone)
; writes: rIF, rIE
ClearSGBPacketBuffer_WriteIFAndIE::
Func_000_07D8:: ; address name
    ld b, a
    xor a, a
    ldh [rIF], a
    ld a, b
    ldh [rIE], a
    ret

; rSCX = hScrollX, rSCY = hScrollY
; 3 call sites from 3 routines (e.g. VBlankHandler, RunGameMode2State_CopyScrollToHardware_Case04, RunGameMode2State_CopyScrollToHardware)
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

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
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
    jr z, .call_wait_for_vram_access
    ldh [rBGPI], a
    call HLFromABits3To5
    ld a, l
    add a, $9F
    ld l, a
    ld a, h
    adc a, $C4
    ld h, a
    ld b, $08
    jr .call_wait_for_vram_access2

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rBGPI], a
    ei
    ld b, $40
    ld hl, wBGPaletteBuffer

.call_wait_for_vram_access2:
    ld c, $69

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [c], a
    ei
    dec b
    jr nz, .loop
    ret

; only called from VBlankHandler (E-0047)
; 1 call site from 1 routine (e.g. VBlankHandler)
; reads: wOBJPaletteUploadRequest, rSTAT
; writes: rOBPI
; points at: wOBJPaletteBuffer
VBlankHandler_HLFromABits3To5::
Func_000_085C:: ; address name
    ld a, [wOBJPaletteUploadRequest]
    bit 7, a
    jr z, .call_wait_for_vram_access
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
    jr .skip

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld b, $40
    ld de, wOBJPaletteBuffer

.skip:
    ld hl, rOBPD

.loop:
    ld a, [de]
    inc de
    ld c, a
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld [hl], c
    ei
    dec b
    jr nz, .loop
    ret

; HL = A & $38 (bits 3-5), H = 0 (E-0119)
; 2 call sites from 2 routines (e.g. VBlankHandler_HLFromABits3To5, UploadBGPalettes)
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
; 3 call sites from 3 routines (e.g. ClearSGBPacketBuffer_Sub02_SerialSendByte, ClearSGBPacketBuffer_Sub02_StartSerialTransferInternalClock, GameMode5_Update_Case01_RunGameMode5Case01SubStates)
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
; 32 call sites from 23 routines (e.g. ClearSGBPacketBuffer_WaitSerialTransferDone, ClearSGBPacketBuffer_Sub02_SerialSendByte, ClearSGBPacketBuffer_Sub02_StartSerialTransferInternalClock, GameMode5_Update_Case01_SerialSendByte_Case08, ...)
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
    jr z, .skip
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

.skip:
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
    jr z, .call_fill_bytes
    xor a, a
    ld [wBGFillFlag], a
    ld bc, $0400
    ld a, $C3

.call_fill_bytes:
    call FillBytes
    ret

; A = value, HL = destination, BC = count; HL ends past the last byte (memset)
; 155 call sites from 92 routines (e.g. BootAndMainLoop, ClearBGMapOrFillWithC3, SGBTransferCompressed, ClearWRAMHRAMAndSRAMBanks0And2, ...)
FillBytes::
Func_000_0949:: ; address name
    ld d, a

.loop:
    ld [hl], d
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; HL = source, DE = destination, BC = count (memcpy)
; 47 call sites from 42 routines (e.g. RestoreScreenBufferFromBGMap1, SaveScreenBufferToBGMap1, WritePlayerNameWithFlag0SuffixToTextBuf0, RunFieldEventFieldEventKind_Case08_CopyBytes, ...)
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
; 47 call sites from 41 routines (e.g. BootAndMainLoop, AdvanceRandom, NextTableByteSecondStream, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord, ...)
; reads: wRandomHi
; writes: wRandomHi, wRandomLo
NextTableByte::
Func_000_095B:: ; address name
    push hl
    ld a, [wRandomHi]
    inc a
    and a, $7F
    ld [wRandomHi], a
    ld hl, RandomByteTable
    add_a_to_hl
    ld a, [hl]
    ld [wRandomLo], a
    pop hl
    ret

; E-0220 (C1: NextTableByte steps wRandomHi through 0-$7F and loads wRandomLo from $0973 + wRandomHi; 128 bytes end at NextRandomSeed ($09F3)).
; record: 16 table bytes
RandomByteTable::
Data_000_0973:: ; address name
    db $7B, $FE, $22, $DC, $18, $C4, $6D, $FB, $CD, $27, $A0, $09, $6E, $38, $8A, $04 ; id 0
    db $7C, $56, $97, $5A, $A8, $4D, $78, $B5, $6C, $AA, $03, $1A, $4A, $0D, $26, $82 ; id 1
    db $AD, $02, $A1, $B9, $A3, $6B, $D8, $0C, $4C, $AE, $19, $45, $5B, $9C, $16, $07 ; id 2
    db $89, $51, $90, $29, $F5, $62, $F7, $CB, $F1, $53, $FF, $14, $65, $D0, $87, $35 ; id 3
    db $3E, $4E, $4F, $83, $0E, $C9, $7F, $5D, $FC, $E6, $BA, $01, $F8, $00, $F4, $0A ; id 4
    db $E5, $A9, $8D, $D1, $E8, $DB, $DE, $81, $95, $72, $08, $9A, $C7, $49, $C8, $23 ; id 5
    db $39, $37, $E0, $91, $C3, $33, $9B, $5F, $BE, $41, $EE, $74, $E2, $0B, $47, $7E ; id 6
    db $BF, $60, $BB, $20, $61, $05, $B2, $94, $B6, $E4, $3A, $21, $1E, $B4, $8C, $CE ; id 7

; 16-bit seed in wCD03/wCD04 becomes seed * 5 + 11
; 81 call sites from 51 routines (e.g. VBlankHandler, PickRandomEncounterCountdownFromTable478F, TickRandomEncounterCounter, RunBattleIntroKindCase_ComputePartyStrengthForKey, ...)
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
    jr z, .clear_joypad_read_flag
    call PollJoypad_WriteP1
    ld a, [wJoypadHeld]
    ld [wJoypadHeldPrev], a
    ld a, [wSGBJoypad1]
    ld [wJoypadHeld], a
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, [wSGBJoypad2]
    ld [wLinkJoypadHeld], a
    ret

.clear_joypad_read_flag:
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
    jr nz, .clear_joypad_pressed_repeat
    ld a, [wJoypadReadFlag]
    or a, a
    jr nz, .clear_joypad_pressed_repeat
    xor a, a
    ld [wLinkJoypadHeld], a
    ld [wLinkJoypadHeldPrev], a

.clear_joypad_pressed_repeat:
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
    jr z, .read_joypad_pressed
    cp a, [hl]
    jr z, .skip

.read_joypad_pressed:
    ld a, [wJoypadPressed]
    ld [wJoypadPressedRepeat], a
    ld a, $14
    ld [wJoypadRepeatTimer], a
    jr .clear_link_joypad_pressed_repeat2

.skip:
    ld hl, wJoypadRepeatTimer
    ld a, [hl]
    or a, a
    jr nz, .clear_link_joypad_pressed_repeat
    ld [hl], $06
    ld a, [wJoypadHeld]
    ld [wJoypadPressedRepeat], a

.clear_link_joypad_pressed_repeat:
    dec [hl]

.clear_link_joypad_pressed_repeat2:
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
    jr z, .read_link_joypad_pressed
    cp a, [hl]
    jr z, .skip2

.read_link_joypad_pressed:
    ld a, [wLinkJoypadPressed]
    ld [wLinkJoypadPressedRepeat], a
    ld a, $14
    ld [wLinkJoypadRepeatTimer], a
    jr .return

.skip2:
    ld hl, wLinkJoypadRepeatTimer
    ld a, [hl]
    or a, a
    jr nz, .done
    ld [hl], $06
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadPressedRepeat], a

.done:
    dec [hl]

.return:
    ret

; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
; 5 call sites from 4 routines (e.g. RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00, DebugStaffRoll_Update_Sub01_Table2_Case00, RunDebugState_E0_Case0D_Case02_DisplayedSlotOfActor)
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
; 24 call sites from 18 routines (e.g. LoadMonsterPicture, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte, LoadBGPaletteBufferFromBank, DecompressGraphicsTemp0ToTemp4, ...)
; writes: rROMB0
CopyFromBank::
Func_000_0B18:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): like Func_000_0B18, but before each byte waits for STAT ($FF41) bit 1 to clear with interrupts disabled, so HL can be VRAM.
; 232 call sites from 116 routines (e.g. AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0, CopyMonsterNameToBuffer_B01, DebugMessageTest_Init, DebugResultsDisplay_Init, ...)
; reads: rSTAT
; writes: rROMB0
CopyFromBankWaitVRAM::
Func_000_0B2B:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): selects ROM bank B; C times reads a byte from [DE] (advancing DE once), waits for STAT bit 1 to clear, ORs the byte into [HL] and advances HL; then restores the caller's bank. Clobbers B.
; 17 call sites from 12 routines (e.g. DebugResultsDisplay_Init, DrawNameGlyphBufGlyphsOverlaying8DAnd8E, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM, HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15, ...)
; reads: rSTAT
; writes: rROMB0
OrFromBankWaitVRAM::
Func_000_0B46:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld b, a
    inc de
    ei
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hl]
    or a, b
    ld [hl+], a
    ei
    dec c
    jr nz, .loop
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

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
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

.loop:
    ld [hl+], a
    inc l
    inc l
    inc l
    inc b
    jr nz, .loop
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
    jr nz, .read_bg_write_count
    ret

.read_bg_write_count:
    ld a, [wBGWriteCount]
    ld b, a
    ld hl, wBGWriteData
    ld a, [wBGWriteVertical]
    or a, a
    jr nz, .loop2
    ld a, e
    and a, $E0
    ld c, a

.loop:
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, .loop
    jr .clear_bg_write_dest_lo

.loop2:
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    res 2, d
    dec b
    jr nz, .loop2

.clear_bg_write_dest_lo:
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
    jr nz, .read_attr_write_count
    ret

.read_attr_write_count:
    ld a, [wAttrWriteCount]
    ld b, a
    ld hl, wAttrWriteData
    ld a, [wAttrWriteVertical]
    or a, a
    jr nz, .loop4
    ld a, e
    and a, $E0
    ld c, a

.loop3:
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, .loop3
    jr .skip3

.loop4:
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    res 2, d
    dec b
    jr nz, .loop4

.skip3:
    ld a, $00
    ldh [rVBK], a
    xor a, a
    ld [wAttrWriteDestLo], a
    ld [wAttrWriteDestHi], a
    ret

; C2 static reading (E-0016): takes the lock byte $FFD6 (spins while it is non-zero), calls Func_000_0C69, then clears the lock.
; 34 call sites from 21 routines (e.g. SGBTransferCompressed, GameMode5_Init_SendSGBPaletteSetPacket_Case06, GameMode5_Init_SendSGBPaletteSetPacket_Case04, GameMode5_Init_SendSGBPaletteSetPacket_Case03, ...)
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

.loop:
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp a, [hl]
    jr z, .set_decompress_run_byte
    pop hl
    ld [hl], a
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    jr .done

.set_decompress_run_byte:
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
    jr nz, .set_decompress_run_count
    ld a, [de]
    inc de
    add a, $13

.set_decompress_run_count:
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

.loop2:
    ldh a, [hDecompressHeader2]
    cp a, d
    jr z, .check_decompress_header1
    jr c, .skip
    jr .skip3

.check_decompress_header1:
    ldh a, [hDecompressHeader1]
    cp a, e
    jr z, .skip
    jr nc, .skip3

.skip:
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp a, d
    jr z, .check_decompress_header3
    jr nc, .skip2
    jr .skip3

.check_decompress_header3:
    ldh a, [hDecompressHeader3]
    cp a, e
    jr z, .skip3
    jr c, .skip3

.skip2:
    ld a, $10
    add a, d
    ld d, a
    xor a, a
    jr .skip4

.skip3:
    ld a, [de]

.skip4:
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, .restore
    ldh a, [hDecompressRunCount]
    dec a
    ldh [hDecompressRunCount], a
    jr nz, .loop2
    pop de
    jr .loop

.restore:
    pop de

.done:
    pop af
    ld [rROMB0], a
    ret

; C2 (E-0016): the same expansion as Func_000_0C69 but for VRAM destinations: each store waits for STAT ($FF41) bit 1 to clear with interrupts disabled, back-references read the already-written VRAM, and the lock byte $FFD6 is taken on entry and cleared on exit.
; 126 call sites from 74 routines (e.g. LoadMonsterPicture, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte, LoadMapScreen, LoadMapHeader, ...)
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

.loop:
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp a, [hl]
    jr z, .set_decompress_run_byte
    pop hl
    ldh [hVRAMByteTemp], a
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ldh a, [hVRAMByteTemp]
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    jr .restore2

.set_decompress_run_byte:
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
    jr nz, .set_decompress_run_count
    ld a, [de]
    inc de
    add a, $13

.set_decompress_run_count:
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

.loop3:
    ldh a, [hDecompressHeader2]
    cp a, d
    jr z, .check_decompress_header1
    jr c, .skip
    jr .skip3

.check_decompress_header1:
    ldh a, [hDecompressHeader1]
    cp a, e
    jr z, .skip
    jr nc, .skip3

.skip:
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp a, d
    jr z, .check_decompress_header3
    jr nc, .skip2
    jr .skip3

.check_decompress_header3:
    ldh a, [hDecompressHeader3]
    cp a, e
    jr z, .skip3
    jr c, .skip3

.skip2:
    ld a, $10
    add a, d
    ld d, a
    di

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    xor a, a
    ld [hl+], a
    ei
    jr .next

.skip3:
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, [de]
    ld [hl+], a
    ei

.next:
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, .restore
    ldh a, [hDecompressRunCount]
    dec a
    ldh [hDecompressRunCount], a
    jr nz, .loop3
    pop de
    jp .loop

.restore:
    pop de

.restore2:
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
    jr .skip

.skip:
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
; 93 call sites from 81 routines (e.g. GameMode0_Init, DebugBattleSetup_Update, SendSGBFieldPaletteSet, RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc, ...)
; reads: wIsCGB, wSGBActive, wFadeState, wFadeMode, wFadeMask, wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1
; writes: wFadeState, wFadeLevel, wFadeDelay, wFadeDelayCounter
; points at: wOBJPaletteBuffer, wSGBPacketBuffer, wFadeDMGPalettes, wDMGPaletteBGP
StartPaletteFade::
Func_000_0DF2:: ; address name
    ld b, a
    ld a, [wIsCGB]
    or a, a
    jp nz, .set_fade_state2
    ld a, [wSGBActive]
    or a, a
    jp z, .check_fade_mode
    bit 7, b
    jr nz, .set_fade_state
    ld a, b
    ld [wFadeState], a
    ld hl, wOBJPaletteBuffer + $20
    ld de, wOBJPaletteBuffer
    ld c, $20

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    jp .return

.set_fade_state:
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

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop2
    ld de, $7FFF
    ld a, [wFadeMode]
    bit 7, a
    jr z, .skip
    ld de, $0000

.skip:
    ld hl, wOBJPaletteBuffer
    ld c, $10

.loop3:
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    dec c
    jr nz, .loop3
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
    jp z, .return
    call ClearSGBPacketBuffer
    ld hl, wOBJPaletteBuffer + $10
    ld de, wSGBPacketBuffer
    ld a, $09
    ld [de], a
    inc de
    call CopySGBPacketFieldsAndSend
    call SpinDelay
    jp .return

.set_fade_state2:
    ld a, b
    ld [wFadeState], a
    farcall StartPaletteFade_WriteFadeLevelAndFadeDelayEtc
    jp .return

.check_fade_mode:
    ld a, [wFadeMode]
    bit 7, a
    jr nz, .skip2
    bit 7, b
    jr nz, .set_fade_state3
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
    jr .return

.set_fade_state3:
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
    jr .return

.skip2:
    bit 7, b
    jr nz, .set_fade_state4
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
    jr .return

.set_fade_state4:
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

.return:
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

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
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
    call z, StepFade_WriteSoundFadeTargetAndNR50Etc
    ld a, [wIsCGB]
    or a, a
    jp nz, AdjustColorChannelForFade_CallStepCGBFade
    ld a, [wSGBActive]
    or a, a
    jp z, AdjustColorChannelForFade_CheckFadeMode
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .read_fade_level
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level:
    ld a, [wFadeLevel]
    add a, $05
    cp a, $1F
    jr c, .set_fade_level
    ld a, $1F

.set_fade_level:
    ld [wFadeLevel], a
    call StepFade_ClearSGBPacketBuffer
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    cp a, $1F
    jp z, DarkenDMGShade_ClearFadeState
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .read_fade_level2
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level2:
    ld a, [wFadeLevel]
    sub a, $05
    bit 7, a
    jr z, .set_fade_level2
    xor a, a

.set_fade_level2:
    ld [wFadeLevel], a
    call StepFade_ClearSGBPacketBuffer
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    or a, a
    jp z, DarkenDMGShade_ClearFadeState
    ret

; only called from StepFade (E-0047)
; 2 call sites from 1 routine (e.g. StepFade)
; reads: wFadeMask
; writes: wFadeStepSize, wSGBPacketIndex
; points at: wOBJPaletteBuffer, wSGBPacketBuffer
StepFade_ClearSGBPacketBuffer::
Func_000_0FC1:: ; address name
    ld a, [wFadeMask]
    bit 0, a
    ld a, $00
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_WriteFadeStepSize
    ld a, [wFadeMask]
    bit 1, a
    ld a, $08
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_WriteFadeStepSize
    ld a, [wFadeMask]
    bit 4, a
    jr z, .call_clear_sgb_packet_buffer
    ld a, [wFadeMask]
    bit 2, a
    ld a, $10
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_WriteFadeStepSize
    ld a, [wFadeMask]
    bit 3, a
    ld a, $18
    ld [wFadeStepSize], a
    call nz, StepFade_Sub01_WriteFadeStepSize

.call_clear_sgb_packet_buffer:
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
; 3 call sites from 2 routines (e.g. StepFade_ClearSGBPacketBuffer, StartPaletteFade)
; writes: wSGBPacketIndex
CopySGBPacketFieldsAndSend::
Func_000_1022:: ; address name
    ld c, $08

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    inc hl
    inc hl
    ld c, $06

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop2
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    ret

; only called from StepFade_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. StepFade_ClearSGBPacketBuffer)
; reads: wFadeStepSize, wFadeLevel
; writes: wFadeStepSize
; points at: wOBJPaletteBuffer
StepFade_Sub01_WriteFadeStepSize::
Func_000_1040:: ; address name
    call StepFade_Sub01_Sub01_AdjustColorChannelForFade
    call StepFade_Sub01_Sub01_WriteFadeStepSize
    call StepFade_Sub01_Sub01_WriteFadeStepSize

; only called from StepFade_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. StepFade_Sub01_WriteFadeStepSize)
; reads: wFadeStepSize, wFadeLevel
; writes: wFadeStepSize
; points at: wOBJPaletteBuffer
StepFade_Sub01_Sub01_WriteFadeStepSize::
Func_000_1049:: ; address name
    ld a, [wFadeStepSize]
    add a, $02
    ld [wFadeStepSize], a

; only called from StepFade_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepFade_Sub01_WriteFadeStepSize)
; reads: wFadeStepSize, wFadeLevel
; points at: wOBJPaletteBuffer
StepFade_Sub01_Sub01_AdjustColorChannelForFade::
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
; 3 call sites from 1 routine (e.g. StepFade_Sub01_Sub01_AdjustColorChannelForFade)
; reads: wFadeMode
AdjustColorChannelForFade::
Func_000_10AB:: ; address name
    push af
    ld a, [wFadeMode]
    ld c, a
    pop af
    bit 7, c
    jr nz, .skip
    and a, $1F
    add a, b
    cp a, $1F
    jr c, .return
    ld a, $1F
    jr .return

.skip:
    and a, $1F
    sub a, b
    jr nc, .return
    xor a, a

.return:
    ret

AdjustColorChannelForFade_CallStepCGBFade::
Jump_000_10C7:: ; address name
    farcall StepCGBFade
    ret

AdjustColorChannelForFade_CheckFadeMode::
Jump_000_10CE:: ; address name
    ld a, [wFadeMode]
    bit 7, a
    jp nz, LightenDMGShade_CheckFadeState
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .call_lighten_selected_dmg_palettes
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_lighten_selected_dmg_palettes:
    call LightenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    inc a
    ld [wFadeLevel], a
    cp a, $04
    jp z, DarkenDMGShade_ClearFadeState
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .call_lighten_selected_dmg_palettes2
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_lighten_selected_dmg_palettes2:
    call LightenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    dec a
    ld [wFadeLevel], a
    cp a, $FF
    jp z, DarkenDMGShade_ClearFadeState
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
    jr nc, .skip
    xor a, a

.skip:
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

LightenDMGShade_CheckFadeState::
Jump_000_116D:: ; address name
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .call_lighten_dmg_shade_darken_dmg_palette_by
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_lighten_dmg_shade_darken_dmg_palette_by:
    call LightenDMGShade_DarkenDMGPaletteByFadeLevel
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    inc a
    ld [wFadeLevel], a
    cp a, $04
    jr z, DarkenDMGShade_ClearFadeState
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, .call_lighten_dmg_shade_darken_dmg_palette_by2
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_lighten_dmg_shade_darken_dmg_palette_by2:
    call LightenDMGShade_DarkenDMGPaletteByFadeLevel
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    dec a
    ld [wFadeLevel], a
    cp a, $FF
    jr z, DarkenDMGShade_ClearFadeState
    ret

; only called from LightenDMGShade (E-0047)
; 2 call sites from 1 routine (e.g. LightenDMGShade)
; reads: wFadeMode, wFadeDMGPalettes, wFadeLevel
; points at: wDMGPaletteBGP
LightenDMGShade_DarkenDMGPaletteByFadeLevel::
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
; 2 call sites from 1 routine (e.g. LightenDMGShade_DarkenDMGPaletteByFadeLevel)
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
    jr c, .skip
    ld a, $03

.skip:
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

DarkenDMGShade_ClearFadeState::
Jump_000_1205:: ; address name
    xor a, a
    ld [wFadeState], a
    ret

; loops until STAT bit 1 is clear (modes 0 and 1); returns with Z set
; 252 call sites from 146 routines (e.g. VBlankHandler_HLFromABits3To5, UploadBGPalettes, StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc, CopyBBytesToVRAMFromDE, ...)
; reads: rSTAT
WaitForVRAMAccess::
Func_000_120A:: ; address name
    ldh a, [rSTAT]
    bit 1, a
    ret z
    jr WaitForVRAMAccess

; A = value, HL = address; disables interrupts, waits until VRAM is accessible, stores A at [HL]; clobbers hFFD1
; 171 call sites from 117 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, ShowTextContinueMark, AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0, StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc, ...)
; reads: rSTAT, hVRAMWriteByte
; writes: hVRAMWriteByte
WriteVRAMByte::
Func_000_1211:: ; address name
    ldh [hVRAMWriteByte], a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ldh a, [hVRAMWriteByte]
    ld [hl], a
    ei
    ret

; like WriteVRAMByte but stores at [HL] and increments HL
; 145 call sites from 81 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub02_WriteVRAMByte, LoadMonsterPictureAttributes, DrawFullScreenBufferToBGMap, CopyBBytesToVRAMFromDE, ...)
; reads: rSTAT, hVRAMWriteByte
; writes: hVRAMWriteByte
WriteVRAMByteInc::
Func_000_121F:: ; address name
    ldh [hVRAMWriteByte], a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ldh a, [hVRAMWriteByte]
    ld [hl+], a
    ei
    ret

; wMusicRequest = A
; 37 call sites from 35 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case09, StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case05, DebugSoundTest_Update, DebugStaffRoll_Init, ...)
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
    jr z, .done
    ld [wSoundId], a
    cp a, $02
    jr z, .call_start_music_start_sound
    cp a, $0F
    jr z, .call_start_music_start_sound
    cp a, $40
    jr z, .call_start_two_sound_tracks
    cp a, $42
    jr z, .call_start_two_sound_tracks
    cp a, $44
    jr z, .call_start_two_sound_tracks
    cp a, $46
    jr z, .call_start_two_sound_tracks
    cp a, $48
    jr z, .call_start_two_sound_tracks
    cp a, $50
    jr z, .call_start_two_sound_tracks
    cp a, $52
    jr z, .call_start_two_sound_tracks
    cp a, $58
    jr z, .call_start_music_start_sound
    call StartThreeSoundTracks
    ei
    ret

.call_start_music_start_sound:
    call StartMusic_StartSound
    ei
    ret

.call_start_two_sound_tracks:
    call StartTwoSoundTracks

.done:
    ei
    ret

; wSoundEffectRequest = A; ProcessSoundQueue starts it on the next frame
; 406 call sites from 293 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, ShowTextContinueMark, AcknowledgeTextPrompt, StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case09, ...)
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
    jr z, .call_start_two_sound_tracks
    cp a, $67
    jr z, .call_start_two_sound_tracks
    cp a, $6D
    jp z, .call_start_three_sound_tracks
    cp a, $70
    jr z, .call_start_two_sound_tracks
    cp a, $72
    jr z, .call_start_two_sound_tracks
    cp a, $74
    jr z, .call_start_two_sound_tracks
    cp a, $7E
    jr z, .call_start_two_sound_tracks
    cp a, $89
    jr z, .call_start_two_sound_tracks
    cp a, $8B
    jr z, .call_start_two_sound_tracks
    cp a, $8D
    jr z, .call_start_two_sound_tracks
    cp a, $91
    jr z, .call_start_two_sound_tracks
    cp a, $9F
    jr z, .call_start_two_sound_tracks
    cp a, $A5
    jr z, .call_start_two_sound_tracks
    cp a, $AC
    jr z, .call_start_two_sound_tracks
    cp a, $AE
    jr z, .call_start_two_sound_tracks
    cp a, $B2
    jr z, .call_start_two_sound_tracks
    cp a, $B6
    jr z, .call_start_two_sound_tracks
    cp a, $B8
    jr z, .call_start_two_sound_tracks
    cp a, $BA
    jr z, .call_start_two_sound_tracks
    cp a, $BD
    jr z, .call_start_two_sound_tracks
    cp a, $BF
    jr z, .call_start_two_sound_tracks
    cp a, $C1
    jr z, .call_start_two_sound_tracks
    cp a, $C3
    jr z, .call_start_two_sound_tracks
    cp a, $C5
    jr z, .call_start_two_sound_tracks
    cp a, $C7
    jr z, .call_start_two_sound_tracks
    cp a, $C9
    jr z, .call_start_two_sound_tracks
    cp a, $D2
    jr z, .call_start_two_sound_tracks
    cp a, $D4
    jr z, .call_start_two_sound_tracks
    cp a, $DA
    jr z, .call_start_two_sound_tracks
    cp a, $DD
    jr z, .call_start_two_sound_tracks
    di
    call StartSound
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

.call_start_two_sound_tracks:
    di
    call StartTwoSoundTracks
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

.call_start_three_sound_tracks:
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
    jr z, .check_sound_effect_request
    call StartMusic
    ld a, $FF
    ld [wMusicRequest], a

.check_sound_effect_request:
    ld a, [wSoundEffectRequest]
    cp a, $FF
    jr z, .return
    call StartSoundEffect
    ld a, $FF
    ld [wSoundEffectRequest], a

.return:
    ret

; a lone ret after the sound-effect request step's ret; nothing reaches it (E-0239)
; no direct call (reached through a table, a jump or a vector)
UnreferencedReturn_00_1339:: ; configured code entry (E-0239); C0
Func_000_1339:: ; address name
    ret

; with B = A: unless wFieldInitStage is set or A is 0 or has bit 7 set, stores A (halved when wSGBActive is 0) to wSoundFadeLevel and, when rNR50 bits 7 and 3 are clear and rNR50 is non-zero, sets wSoundFadeTarget to it, wSoundFadeTimer = 8 and wSoundFadeNR50 = rNR50; otherwise clears wSoundFadeLevel; no caller found (E-0239)
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldInitStage, wSGBActive, wSoundFadeLevel, rNR50
; writes: wSoundFadeLevel, wSoundFadeTarget, wSoundFadeTimer, wSoundFadeNR50
UnreferencedStartSoundFadeA:: ; configured code entry (E-0239); C0
Func_000_133A:: ; address name
    ld b, a
    ld a, [wFieldInitStage]
    or a, a
    jr nz, .clear_sound_fade_level
    ld a, b
    bit 7, a
    jr nz, .clear_sound_fade_level
    or a, a
    jr z, .clear_sound_fade_level
    ld [wSoundFadeLevel], a
    ld a, [wSGBActive]
    or a, a
    jr nz, .skip
    ld a, [wSoundFadeLevel]
    sra a
    ld [wSoundFadeLevel], a

.skip:
    ldh a, [rNR50]
    bit 7, a
    jr nz, .clear_sound_fade_level
    bit 3, a
    jr nz, .clear_sound_fade_level
    or a, a
    jr z, .clear_sound_fade_level
    ld a, [wSoundFadeLevel]
    ld [wSoundFadeTarget], a
    ld a, $08
    ld [wSoundFadeTimer], a
    ldh a, [rNR50]
    ld [wSoundFadeNR50], a
    ret

.clear_sound_fade_level:
    xor a, a
    ld [wSoundFadeLevel], a
    ret

; only called from StepFade (E-0047)
; 1 call site from 1 routine (e.g. StepFade)
; reads: wFieldInitStage, wSoundFadeLevel, wSoundFadeTarget, rNR50, wSoundFadeNR50, wSoundFadeTimer
; writes: wSoundFadeTarget, rNR50, wSoundFadeNR50, wSoundFadeTimer, wSoundFadeLevel
StepFade_WriteSoundFadeTargetAndNR50Etc::
Func_000_137D:: ; address name
    ld a, [wFieldInitStage]
    or a, a
    jr nz, .clear_sound_fade_level
    ld a, [wSoundFadeLevel]
    bit 7, a
    jr nz, .clear_sound_fade_level
    or a, a
    ret z
    ld a, [wSoundFadeTarget]
    or a, a
    jr z, .skip
    dec a
    ld [wSoundFadeTarget], a
    ret

.skip:
    ldh a, [rNR50]
    and a, $88
    cp a, $88
    jr z, .clear_sound_fade_level
    ld a, [wSoundFadeNR50]
    or a, a
    jr z, .clear_sound_fade_level
    ld b, a
    and a, $0F
    ld d, a
    ld a, b
    swap a
    and a, $0F
    ld c, a
    bit 3, c
    jr nz, .skip2
    ld a, c
    or a, a
    jr z, .skip2
    dec c

.skip2:
    bit 3, d
    jr nz, .skip3
    ld a, d
    or a, a
    jr z, .skip3
    dec d

.skip3:
    ld a, c
    swap a
    or a, d
    ldh [rNR50], a
    ld [wSoundFadeNR50], a
    or a, a
    jr z, .skip4
    ld a, [wSoundFadeTimer]
    or a, a
    jr z, .clear_sound_fade_level
    dec a
    ld [wSoundFadeTimer], a
    ld a, [wSoundFadeLevel]
    ld [wSoundFadeTarget], a
    ret

.skip4:
    di
    ei

.clear_sound_fade_level:
    xor a, a
    ld [wSoundFadeLevel], a
    ret

; when A differs from wC523: sends the Super Game Boy border tiles, map and palettes of set A through three compressed transfers (SGBTransferCompressed) (E-0130)
; 2 call sites from 2 routines (e.g. GameMode1_Init, GameMode5_Init_InitSoundHardware)
; points at: wSGBBorderSet
LoadSGBBorderForSetA::
Func_000_13E5:: ; address name
    ld hl, wSGBBorderSet
    cp a, [hl]
    ret z
    ld [hl], a
    cp a, $00
    jr nz, .cp_01
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
    jp .return

.cp_01:
    cp a, $01
    jr nz, .cp_02
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
    jp .return

.cp_02:
    cp a, $02
    jr nz, .cp_03
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
    jr .return

.cp_03:
    cp a, $03
    jr nz, .cp_04
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
    jr .return

.cp_04:
    cp a, $04
    jr nz, .return
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

.return:
    ret
    db $C9

; only called from ClearSGBPacketBuffer (E-0047)
; 1 call site from 1 routine (e.g. ClearSGBPacketBuffer)
; reads: wLinkMode, wLinkStatus, wLinkRole, wLinkSession, rSB, wIsCGB
; writes: wLinkStatus, wLinkExchangeState, wLinkRole
; points at: wJoypadHeld
ClearSGBPacketBuffer_WaitSerialTransferDone::
Func_000_14D1:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp z, .clear_link_exchange_state
    ld a, $08
    call ClearSGBPacketBuffer_WriteIFAndIE
    ld a, [wLinkStatus]
    set 7, a
    res 6, a
    ld [wLinkStatus], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_link_session
    ld hl, $6000

.loop:
    dec hl
    ld a, h
    or a, l
    jr nz, .loop

.check_link_session:
    ei
    ld a, [wLinkSession]
    cp a, $05
    jr nz, .call_clear_sgb_packet_buffer_sub02_start
    call ClearSGBPacketBuffer_Sub02_SerialSendByte
    call WaitSerialTransferDone
    ldh a, [rSB]
    cp a, $F5
    call nz, ClearSGBPacketBuffer_Sub02_SerialSendByte
    jr .read_link_status

.call_clear_sgb_packet_buffer_sub02_start:
    call ClearSGBPacketBuffer_Sub02_StartSerialTransferInternalClock
    cp a, $02
    jr z, .skip
    call WaitSerialTransferDone

.skip:
    ldh a, [rSB]
    cp a, $70
    jr z, .check_link_session2
    cp a, $71
    jr z, .check_link_session2
    call ClearSGBPacketBuffer_Sub02_StartSerialTransferInternalClock

.check_link_session2:
    ld b, a
    ld a, [wLinkSession]
    cp a, $05
    jr z, .read_link_status
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_is_cgb
    ld a, [wIsCGB]
    and a, a
    jr nz, .read_link_status
    ld a, b
    bit 0, a
    jr z, .read_link_status
    ld a, [wLinkRole]
    set 1, a
    jr .set_link_role

.check_is_cgb:
    ld a, [wIsCGB]
    and a, a
    jr z, .read_link_status
    ld a, b
    bit 0, a
    jr nz, .read_link_status
    ld a, [wLinkRole]
    res 1, a

.set_link_role:
    ld [wLinkRole], a

.read_link_status:
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

.clear_link_exchange_state:
    xor a, a
    ld [wLinkExchangeState], a
    ld hl, wJoypadHeld
    ld b, $0E

.loop2:
    ld [hl+], a
    dec b
    jr nz, .loop2
    ret

; only called from ClearSGBPacketBuffer_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ClearSGBPacketBuffer_WaitSerialTransferDone)
; reads: wLinkRole, wIsCGB, wLinkTimerLo, wLinkTimerHi, wLinkStatus
; writes: wLinkTimerLo, wLinkTimerHi, wLinkFrameCounterHi
ClearSGBPacketBuffer_Sub02_StartSerialTransferInternalClock::
Func_000_1583:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_is_cgb
    ld a, [wIsCGB]
    or a, $70
    call StartSerialTransferInternalClock
    jr .loop

.check_is_cgb:
    ld a, [wIsCGB]
    or a, $70
    call SerialSendByte

.loop:
    ld a, [wLinkTimerLo]
    add a, $01
    ld [wLinkTimerLo], a
    ld a, [wLinkTimerHi]
    adc a, $00
    ld [wLinkTimerHi], a
    ld a, [wLinkTimerHi]
    cp a, $FF
    jr nc, .set_link_frame_counter_hi_to_02
    ld a, [wLinkStatus]
    bit 6, a
    jr z, .loop
    xor a, a
    ret

.set_link_frame_counter_hi_to_02:
    ld a, $02
    ld [wLinkFrameCounterHi], a
    ret

; only called from ClearSGBPacketBuffer_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ClearSGBPacketBuffer_WaitSerialTransferDone)
; reads: wLinkRole, wLinkStatus
ClearSGBPacketBuffer_Sub02_SerialSendByte::
Func_000_15C2:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    ld a, $F5
    call nz, SerialSendByte
    ld a, [wLinkRole]
    bit 1, a
    ld a, $F5
    call z, StartSerialTransferInternalClock

.loop:
    ld a, [wLinkStatus]
    bit 6, a
    jr z, .loop
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

.skip:
    push hl
    push bc

.loop:
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .done
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr .skip

.done:
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

.skip:
    push hl
    push bc

.loop:
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .done
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr .skip

.done:
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

.loop:
    ld b, $20
    push hl

.loop2:
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
    jr nz, .loop2
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
    jr nz, .loop
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
; 120 call sites from 101 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case08, SRAMRecordAddress, BattlerRecordFieldAddress, Multiply8By16, ...)
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
    jr nc, .skip
    add hl, bc

.skip:
    sla c
    rl b
    rrca
    jr nc, .skip2
    add hl, bc

.skip2:
    sla c
    rl b
    rrca
    jr nc, .skip3
    add hl, bc

.skip3:
    sla c
    rl b
    rrca
    jr nc, .done
    add hl, bc

.done:
    sla c
    rl b
    ret

; E:H:L = A * BC (24-bit product); clobbers A, BC, HL, E
; 64 call sites from 53 routines (e.g. MultiplyHLByAPercent, FastestFoeAGLAbove31PercentOfActor, AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty, AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024, ...)
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
; 32 call sites from 32 routines (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord, DebugBattleSetupShowFieldString, SetupInventoryMenuPages_Bank03, ResistanceAverageGateForAISide, ...)
DivideBByA::
Func_000_16BF:: ; address name
    ld d, $08
    ld e, a
    xor a, a

.loop:
    sla b
    rla
    jr c, .skip
    cp a, e
    jr c, .next

.skip:
    sub a, e
    inc b

.next:
    dec d
    jr nz, .loop
    ret

; HL = HL / A (quotient in HL), A = remainder; clobbers D, E
; 88 call sites from 64 routines (e.g. DivideHLByBC, AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty, AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05, HPBandOfSlotTemp0, ...)
DivideHLByA::
Func_000_16D1:: ; address name
    ld d, $10
    ld e, a
    xor a, a

.loop:
    add hl, hl
    rla
    jr c, .skip
    cp a, e
    jr c, .next

.skip:
    sub a, e
    inc l

.next:
    dec d
    jr nz, .loop
    ret

; E:H:L = E:H:L / A (24-bit quotient), A = remainder; clobbers B, D
; 36 call sites from 30 routines (e.g. MultiplyHLByAPercent, FastestFoeAGLAbove31PercentOfActor, AIGateCompareAllyStatAverages, AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty, ...)
Divide24ByA::
Func_000_16E2:: ; address name
    ld d, $18
    ld b, a
    xor a, a

.loop:
    add hl, hl
    rl e
    rla
    jr c, .skip
    cp a, b
    jr c, .next

.skip:
    sub a, b
    inc l

.next:
    dec d
    jr nz, .loop
    ret

; HL (0-999) becomes three digits: wC8C0 = hundreds, wC8C1 = tens, wC8C2 = ones
; 116 call sites from 78 routines (e.g. DebugResultsDisplay_Update_HLToDecimalDigits, PackTwoDigitsOfCAsBCD, BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, ...)
; reads: wDigits
; writes: wDigits
HLToDecimalDigits::
Func_000_16F5:: ; address name
    xor a, a
    ld [wDigits], a
    ld [wDigits + $1], a
    ld [wDigits + $2], a

.loop:
    ld a, [wDigits]
    inc a
    ld [wDigits], a
    ld bc, $FF9C
    add hl, bc
    ld a, h
    rlc a
    jr nc, .loop
    ld bc, $0064
    add hl, bc
    ld a, [wDigits]
    dec a
    ld [wDigits], a

.loop2:
    ld a, [wDigits + $1]
    inc a
    ld [wDigits + $1], a
    ld bc, $FFF6
    add hl, bc
    ld a, h
    rlc a
    jr nc, .loop2
    ld bc, $000A
    add hl, bc
    ld a, [wDigits + $1]
    dec a
    ld [wDigits + $1], a
    ld a, l
    ld [wDigits + $2], a
    ret

; the 24-bit value at wC8C0-wC8C2 (low byte first) becomes decimal digits: hFFC9 = millions, hFFC8 = hundred-thousands and ten-thousands, hFFC7 = thousands and hundreds, hFFC6 = tens and ones (two digits per byte, high digit in the upper nibble); wC8C0-wC8C2 are consumed
; 46 call sites from 39 routines (e.g. DebugShowMonsterRecord_Number24ToPackedBCD, DebugSkillViewer_Update_Number24ToPackedBCD, DrawGoldDigitsAtHLWrapped, WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03, ...)
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

.skip:
    ld a, c
    sub a, $40
    ld c, a
    ld a, b
    sbc a, $42
    ld b, a
    ld a, d
    sbc a, $0F
    ld d, a
    jr c, .set_temp3
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr .skip

.set_temp3:
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

.skip2:
    ld a, c
    sub a, $A0
    ld c, a
    ld a, b
    sbc a, $86
    ld b, a
    ld a, d
    sbc a, $01
    ld d, a
    jr c, .set_temp2
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr .skip2

.set_temp2:
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

.skip3:
    ld a, c
    sub a, $10
    ld c, a
    ld a, b
    sbc a, $27
    ld b, a
    ld a, d
    sbc a, $00
    ld d, a
    jr c, .read_temp2
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr .skip3

.read_temp2:
    ldh a, [hTemp2]
    add a, e
    ldh [hTemp2], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

.skip4:
    ld a, c
    sub a, $E8
    ld c, a
    ld a, b
    sbc a, $03
    ld b, a
    jr c, .set_temp1
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr .skip4

.set_temp1:
    ld a, e
    swap a
    ldh [hTemp1], a
    ld hl, wDigits
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

.skip5:
    ld a, c
    sub a, $64
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    jr c, .read_temp1
    ld hl, wDigits
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr .skip5

.read_temp1:
    ldh a, [hTemp1]
    add a, e
    ldh [hTemp1], a
    ld a, [wDigits]
    ld e, $00

.skip6:
    sub a, $0A
    jr c, .read_digits
    ld [wDigits], a
    inc e
    jr .skip6

.read_digits:
    swap e
    ld a, [wDigits]
    add a, e
    ldh [hTemp0], a
    ret

; DE = bit number; tests that bit of the bit array at wCBD7 (bit 0 of the first byte first); returns carry set when it is 1, A = 0 and carry clear otherwise; no range check
; 905 call sites from 435 routines (e.g. LoadMapScreen_TestFlagBit, SetFieldEventKindOnMap19IfFlagD1, WritePlayerNameWithFlag0SuffixToTextBuf0, MapMusicByFlag25, ...)
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
    jr z, .skip
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip:
    ld a, [de]
    and a, c
    jr nz, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; DE = bit number; sets that bit of the bit array at wCBD7; does nothing when DE >= $0300
; 167 call sites from 126 routines (e.g. RunFieldReturnPhase_OpenFieldMenuOnA, RunMenuStateMenuState_InitSoundHardware, PauseMenu_State4, Talk0046_ThanksForComingBy, ...)
SetFlagBit::
Func_000_1845:: ; address name
    ld a, d
    cp a, $03
    jr nc, .skip2
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
    jr z, .skip
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip:
    ld a, [de]
    or a, c
    ld [de], a
    ret

.skip2:
    jr .skip2

; B = ROM bank, DE = address; C = the byte at [DE] in that bank; the caller's bank is restored
; 73 call sites from 24 routines (e.g. DebugMonsterPictureViewer_Update, ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB, DecompressGraphicsArg1ToArg4, LoadSpeciesSpriteGraphicsAndPalette, ...)
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
; 103 call sites from 44 routines (e.g. EggServiceMenu_Case0F_FillTilesBxC, CloseHibernateMenu_FillTilesBxC, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C, HibernateMenu_ChooseRecords_FillTilesBxC, ...)
; reads: rSTAT, wTextWindowTileLo
; writes: wTextWindowTileLo
FillTilesBxC::
Func_000_1881:: ; address name
    ld a, b
    ld [wTextWindowTileLo], a

.loop:
    push bc
    ld de, $2940
    ld c, $10

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, .loop2
    pop bc
    dec b
    jr nz, .loop
    ld a, [wTextWindowTileLo]
    ld b, a
    dec c
    jr nz, .loop
    ret

; B = width, C = rows, DE = source, HL = BG map address: copies a B x C rectangle, wrapping columns inside each 32-entry row and rows inside $9800-$9BFF (H &= $9B). Each byte is written with interrupts off after rSTAT bit 1 clears. DE ends past the source, HL at the last row start, C = 0; B kept (E-0059)
; 24 call sites from 12 routines (e.g. DrawScreenBufferRect_Bank0C, DrawScreenBufferRect_Bank0D, DrawScreenBufferRect_Bank14, DrawScreenBufferRect_Bank15, ...)
; reads: rSTAT
CopyRectToBGMapWrapped::
Func_000_18A5:: ; address name
    push hl
    push bc

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
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
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr CopyRectToBGMapWrapped

.return:
    ret

; with ROM bank B mapped, reads three bytes at DE: HL = the word, B = the third byte (a far pointer: address then bank); DE += 3; restores the bank (E-0090)
; 10 call sites from 8 routines (e.g. ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB, ShopMenu_Buy_Case09_WriteThreeDigits, ShopMenu_Buy_ReadFarPointerAtDEInBankB, ReadF2FarPointerForScreenTableIndex, ...)
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
; 4 call sites from 4 routines (e.g. LoadMapScreen_Sub03_LoadMapScreenFromChunk, LoadMapScreen_Sub03_WriteTemp0, LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case03, LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case02)
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
    jr nz, .read_temp0
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr .done

.read_temp0:
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

.done:
    pop af
    ld [rROMB0], a
    ret

; loads the screen at (hMapScreenX, hMapScreenY) of map hMapId: finds the map record (MapRecordPointer), picks one of its variants by the highest set bit of the flag byte whose RAM address is stored in the record, decompresses that variant's tile-map stream (an array of far pointers, indexed by row * width + column) into wScreenTileBuffer and, on CGB, the attribute stream into wD000 (WRAM bank 2); then runs the map's tile-replacement table (Func_084_43B8) and two map-specific fix-ups (Func_000_1B6F, Func_000_1A73); hands over to Func_061_4472 when wCC44 bit 7 is set
; 4 call sites from 4 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_LoadMapScreenAndStep, SceneLandHo_StepScriptParam0Counter_Bank0F, BreedMenu_ReturnToMap_LoadMapHeader)
; reads: wMapType, wMapWidthScreens, hMapScreenY, hMapScreenX, wIsCGB, hTemp0, hTemp1, hTemp2, ...
; writes: rROMB0, hTemp0, hTemp1, hTemp2, hTemp3, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
LoadMapScreen::
Func_000_19A9:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall LoadMapScreen_ReadMapType
    ret

.skip:
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

.loop:
    sla a
    jr c, .set_temp0
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, .loop

.set_temp0:
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
    jr nz, .read_temp0
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr .call_apply_map_screen_flag_events

.read_temp0:
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

.call_apply_map_screen_flag_events:
    pop af
    ld [rROMB0], a
    farcall ApplyMapScreenFlagEvents
    call LoadMapScreen_TestFlagBit
    call LoadMapScreen_WriteTemp0
    ret

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey
; writes: hTemp0
; points at: wKeyWorldGoal
LoadMapScreen_WriteTemp0::
Func_000_1A73:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, .return
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, $1AB4

.skip:
    ld a, [hl]
    cp a, $FF
    jr nz, .skip2
    ret

.skip2:
    cp a, c
    jr z, .check_key_world_active
    inc hl
    inc hl
    inc hl
    inc b
    jr .skip

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .skip3
    ld a, [wKeyWorldKey]
    dec a
    cp a, b
    jr nz, .skip3
    ld de, wKeyWorldGoal
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_Sub01_WriteSVBK
    ret

.skip3:
    ld e, l
    ld d, h
    inc de
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_Sub01_WriteSVBK
    ret

.return:
    ret
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

; only called from LoadMapScreen_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. LoadMapScreen_WriteTemp0)
; reads: hMapScreenX, hMapScreenY, wIsCGB, hTemp0
; writes: rSVBK
LoadMapScreen_Sub01_WriteSVBK::
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
    jr z, .done
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
    jr z, .skip
    cp a, $0A
    jr z, .skip
    ld c, $05
    cp a, $05
    jr z, .skip
    cp a, $06
    jr z, .skip
    cp a, $07
    jr z, .skip
    ld c, $01

.skip:
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

.done:
    pop hl
    ret

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: hMapScreenX, hMapId
LoadMapScreen_TestFlagBit::
Func_000_1B6F:: ; address name
    ld de, $012B
    call TestFlagBit
    ret nc
    ldh a, [hMapScreenX]
    or a, a
    ret nz
    ldh a, [hMapId]
    cp a, $0D
    jr nz, .cp_05
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

.cp_05:
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
; 4 call sites from 4 routines (e.g. LoadMapHeaderByMapType_LoadSpecialMapHeader, LoadMapHeaderByMapType_WriteTemp0, LoadMapHeaderByMapType_LoadSpecialMapHeader_Case03, LoadMapHeaderByMapType_LoadSpecialMapHeader_Case02)
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

; loads the current map's graphics, palette, size (wMapWidthScreens/HeightScreens), wMaxBlockingTile and other header bytes from the bank-$11 map record (special maps use LoadMapHeaderByMapType) (E-0128)
; 3 call sites from 3 routines (e.g. InitFieldScreen, LibraryMenu_LoadMapHeader, BreedMenu_ReturnToMap_LoadMapHeader)
; reads: wMapType, hMapId
; writes: rROMB0, wMenuState, wMenuSubState, wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, ...
LoadMapHeader::
Func_000_1C0C:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall LoadMapHeaderByMapType
    ret

.skip:
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
    jr nz, .call_decompress_to_vram
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, Tiles2Gfx_48_7861
    ld b, $48
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    xor a, a
    ld [wMenuState], a
    ld [wMenuSubState], a
    jr .skip2

.call_decompress_to_vram:
    call DecompressToVRAM
    pop hl

.skip2:
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
    jr z, .call_set_map_sprite_kind_and_map_header
    and a, $0F
    jr z, .set_map_header_byte11
    ld a, [hl+]
    ld [wMapTallTileMin], a
    jr .call_set_map_sprite_kind_and_map_header

.set_map_header_byte11:
    ld a, [hl+]
    ld [wMapHeaderByte11], a

.call_set_map_sprite_kind_and_map_header:
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
    jr z, .skip
    cp a, $02
    jr z, .skip2
    ret

.skip:
    ld de, vTiles2 + $500
    ld hl, vTiles2 + $510
    ld b, $10
    call CopyBBytesToVRAMFromDE
    ld de, $1D07
    ld hl, vTiles2 + $120
    ld b, $40
    call CopyBBytesToVRAMFromDE
    ret

.skip2:
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
    jr z, .set_map_sprite_kind_to_11
    cp a, $B8
    jr nz, .cp_63

.set_map_sprite_kind_to_11:
    ld a, $11
    ld [wMapSpriteKind], a
    ld a, $2C
    ld [wMapHeaderByte11], a
    ret

.cp_63:
    cp a, $63
    jr c, .cp_70
    cp a, $67
    jr nc, .cp_70
    ld a, $22
    ld [wMapSpriteKind], a
    ld a, $30
    ld [wMapHeaderByte11], a
    ret

.cp_70:
    cp a, $70
    jr nz, .return
    ld a, $12
    ld [wMapSpriteKind], a
    ld a, $2C
    ld [wMapHeaderByte11], a
    ret

.return:
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
DebugMapEditor_Update_WriteROMB0AndTemp0::
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
    jr z, .loop
    jr nc, .read_debug_value3

.loop:
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

.read_debug_value3:
    ld a, [wDebugValue3]
    ld c, a
    ld a, [hl+]
    cp a, c
    jr z, .loop
    jr c, .loop
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

.loop2:
    sla a
    jr c, .skip
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, .loop2

.skip:
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
    jr nz, .restore
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

.restore:
    pop af
    ld [rROMB0], a
    xor a, a
    ret

; HL = BG map address: draws the 20 x 18 entries of wScreenTileBuffer, wrapping columns inside each 32-entry row and rows inside $9800-$9BFF; on CGB then draws the attribute bytes at wD000 (rSVBK = 2), masked to the palette bits (& $07), into VRAM bank 1; HL kept (E-0071)
; 16 call sites from 16 routines (e.g. InitFieldScreen, RedrawScreenBufferIfPartyWindowFlagsBit7, FieldModeStateDispatch_Case02_Sub01_WritePartyWindowFlagsAndPartyWindowTimer, GameMode5_Update_Case01_Case06_DrawFullScreenBufferToBGMap, ...)
; reads: wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawFullScreenBufferToBGMap::
Func_000_1E29:: ; address name
    push hl
    ld de, wScreenTileBuffer
    ld bc, $1412

.skip:
    push hl
    push bc

.loop:
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .check_is_cgb
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr .skip

.check_is_cgb:
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

.skip2:
    push hl
    push bc

.loop2:
    di
    ld a, [de]
    and a, $07
    call WriteVRAMByteInc
    ei
    ld a, l
    and a, $1F
    jr nz, .next2
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next2:
    inc de
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    dec c
    jr z, .skip3
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr .skip2

.skip3:
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; copies the 20 x 13 screen-buffer area (offset by bit 7 of wC8CB) to the BG map at HL, wrapping, and on CGB its attributes from WRAM bank 2 (E-0130)
; 2 call sites from 2 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, DrawScreenBufferAtScrollOrigin)
; reads: wTextWindowState, rSTAT, wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer
DrawScreenBufferToBGMapWithAttrs::
Func_000_1EA5:: ; address name
    ld de, wScreenTileBuffer
    ld a, [wTextWindowState]
    bit 7, a
    jr z, .skip2
    ld a, $64
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $A0
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a

.skip2:
    push de
    push hl
    ld bc, $140D

.skip3:
    push hl
    push bc

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .check_is_cgb
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr .skip3

.check_is_cgb:
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

.skip4:
    push hl
    push bc

.loop3:
    di

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [de]
    and a, $07
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, .next2
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next2:
    inc de
    dec b
    jr nz, .loop3
    pop bc
    pop hl
    dec c
    jr z, .skip5
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    jr .skip4

.skip5:
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; A is first passed through MapIndexViaPartyList; then HL = sA000 + A * $A5 + C as in SRAMRecordAddress
; 138 call sites from 100 routines (e.g. StoreTemp0ToSRAMRecordBytes, LoadSRAMRecordBytesToTemp0, DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped, ShowRecordSkillPageNames_Bank03, ...)
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

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
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

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    ret

; A = record, C = offset; hFFC6 = the byte at sA000 + A * $A5 + C; HL preserved
; 102 call sites from 78 routines (e.g. LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte, PersonalityIndexOfRecord, MoveIncapacitatedPartyMembersBack, BuildPartyStatusWindowRows, ...)
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
; 99 call sites from 55 routines (e.g. LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte, BuildPartyStatusWindowRows, PartyHasSpeciesLo3CTo5BWithHiSet, GameMode5_Init_Case06_LoadSRAMRecordWord, ...)
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
; 3 call sites from 2 routines (e.g. TriggerEventC9IfExpDigitsRepeat, SwapMonstersMenu_ShowMonsterDetails_Case13_LoadRecordThreeBytesToTemp0)
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
; 29 call sites from 25 routines (e.g. LoadRecordListNameTiles, YoldTalkEvents_TestFlagBit_Case13, PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc, HibernateMenu_ChooseRecords_Case32_CopyRecordNameToNameGlyphBuf, ...)
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
    jr z, .skip

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    sub a, a
    ret

.skip:
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
; 91 call sites from 60 routines (e.g. LoadSRAMRecordWord, CopyRecordNameToNameGlyphBuf, LoadRecordThreeBytesToTemp0, LoadSRAMRecordByte, ...)
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
; 19 call sites from 16 routines (e.g. DebugMonsterPictureViewer_Update, DrawRecordMonsterPictureForMenuSelectedMember, PauseMenu_Main_Case03_Case01_Sub01_LoadScreenBlockForPartySize, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params, ...)
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
; 2 call sites from 2 routines (e.g. DrawRecordMonsterPictureForMenuSelectedMember, PauseMenu_Main_Case03_Case01_Sub01_LoadScreenBlockForPartySize)
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
    jr z, .skip
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr .skip2

.skip:
    ld de, $20E9
    ld a, $00

.skip2:
    ld [rROMB0], a
    pop hl
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

.skip3:
    push hl
    push bc

.loop:
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
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .skip4
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr .skip3

.skip4:
    ld a, $00
    ldh [rSVBK], a
    pop af
    ld [rROMB0], a
    ret

; DE = monster id, HL = BG map address, hFFC6 = palette number: writes the 6 x 6 attribute bytes (plus hFFC6) of the id's MonsterAttributeMapTable entry to VRAM bank 1 (a default pattern when the entry is zero)
; 15 call sites from 13 routines (e.g. DebugMonsterPictureViewer_Update, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params, SwapMonstersMenu_Case0D_DrawRect6x6From651BAtScroll41, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E, ...)
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
    jr z, .skip
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr .skip2

.skip:
    ld de, $20E9
    ld a, $00

.skip2:
    ld [rROMB0], a
    ld a, $01
    ldh [rVBK], a
    pop hl
    ld bc, $0606

.skip3:
    push hl
    push bc

.loop:
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
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .skip4
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr .skip3

.skip4:
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop af
    ld [rROMB0], a
    ret
    ds $24, $00

; DE = destination: writes wC8C1 as tile $E0 + digit, or blank tile $C3 when it is 0, then wC8C2 as $E0 + digit; DE ends past the second tile; HL kept (E-0077)
; 7 call sites from 7 routines (e.g. BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, PauseMenu_State3_ShowStringBank08AtTilesHL_Bank03, WriteByteAAsTwoDigitTiles, ...)
WriteTwoDigitTilesFromWC8C1::
Func_000_210D:: ; address name
    push hl
    ld hl, wDigits + $1
    ld a, [hl+]
    or a, a
    jr z, .skip
    add a, $E0
    jr .skip2

.skip:
    ld a, $C3

.skip2:
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    pop hl
    ret

; DE = destination: writes three tile ids for the digits in wC8C0-wC8C2 (see HLToDecimalDigits): $E0 + digit, with leading zeros as $C3; DE ends past the third
; 36 call sites from 19 routines (e.g. BuildPartyStatusWindowRows, DrawRecordHPMPAndLevelForRowC, PauseMenu_State3_ShowStringBank08AtTilesHL_Bank03, PauseMenu_State3_Case05_LoadScreenBlock2D, ...)
; points at: wDigits
WriteDecimalDigitTiles::
Func_000_2123:: ; address name
    push hl
    ld c, $00
    ld hl, wDigits
    ld a, [hl+]
    or a, a
    jr z, .skip
    add a, $E0
    ld c, $01
    jr .skip2

.skip:
    ld a, $C3

.skip2:
    ld [de], a
    inc de
    ld a, [hl+]
    bit 0, c
    jr nz, .skip3
    or a, a
    jr z, .skip4

.skip3:
    add a, $E0
    ld c, $01
    jr .skip5

.skip4:
    ld a, $C3

.skip5:
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    pop hl
    ret

; only called from WithSRAMDraw4ACEAnd4BE8_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03)
; points at: hTemp3
WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01::
Func_000_214F:: ; address name
    push hl
    ld c, $00
    ld hl, hTemp3
    ld a, [hl-]
    and a, $0F
    jr z, .skip
    ld c, $01
    add a, $E0
    jr .skip2

.skip:
    ld a, $C3

.skip2:
    ld [de], a
    inc de
    ld b, $03

.loop:
    ld a, [hl]
    srl a
    srl a
    srl a
    srl a
    bit 0, c
    jr nz, .skip3
    and a, $0F
    jr z, .skip4

.skip3:
    ld c, $01
    add a, $E0
    jr .skip5

.skip4:
    ld a, $C3

.skip5:
    ld [de], a
    inc de
    dec b
    jr nz, .next
    ld c, $01

.next:
    inc b
    ld a, [hl-]
    and a, $0F
    bit 0, c
    jr nz, .skip6
    and a, $0F
    jr z, .skip7

.skip6:
    ld c, $01
    add a, $E0
    jr .skip8

.skip7:
    ld a, $C3

.skip8:
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop hl
    ret

; DE = VRAM destination: for each byte of the string at wC8CF (up to 11, stopping at $F0), copies the 16-byte tile at ROM bank $1F, $4010 + 16 * character to [DE]; the characters $8D and $8E also OR a 16-byte overlay from $48E0 or $48F0 into the previous tile
; 68 call sites from 31 routines (e.g. LoadRecordListNameTiles, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD, DrawMonsterNameForWordAtDE_Bank01, DebugAutomap_Update_CopyGlyphTilesToVRAM, ...)
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

.loop:
    push bc
    ld a, [hl+]
    cp a, $F0
    jr nz, .skip
    pop bc
    pop af
    ld [rROMB0], a
    ret

.skip:
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

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld a, [hl]
    cp a, $8D
    jr z, .next
    cp a, $8E
    jr z, .next2
    jr .restore

.next:
    inc hl
    push hl
    ld hl, $48E0
    jr .skip2

.next2:
    inc hl
    push hl
    ld hl, $48F0

.skip2:
    ld b, $10
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a

.loop4:
    ld a, [hl+]
    ld c, a
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, [de]
    ei
    or a, c
    push af
    ld a, b
    cp a, $0D
    jr nz, .skip3
    pop af
    and a, $FD
    push af

.skip3:
    di

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    pop af
    ld [de], a
    ei
    inc de
    dec b
    jr nz, .loop4
    pop hl

.restore:
    pop bc
    dec c
    jp nz, .loop
    pop af
    ld [rROMB0], a
    ret

; fills wC8CF with five $90 glyphs and an $F0 terminator and draws it at vTiles1 + $500, $550 and $5A0 (three blank 5-tile slots); enables SRAM (rRAMG = $0A); then for each of the wC6FD record numbers listed at wC6FE copies that record's name (CopyRecordNameToNameGlyphBuf, C = 1) and draws it into the next slot ($50 bytes apart); disables SRAM after the loop. With wC6FD = 0 it returns with SRAM still enabled (E-0059)
; 24 call sites from 24 routines (e.g. InitFieldScreen, RunFieldReturnPhase_ResetLeadRecordFields55And5B, PauseMenu_State3_Case00_LoadScreenBlock21, RefreshRecordListAndNameTiles, ...)
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

.loop:
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, MON_NAME
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
    jr nc, .restore
    inc d

.restore:
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ret

; only called from LoadPlayerAndFollowerSpriteGraphics (E-0047)
; 2 call sites from 1 routine (e.g. LoadPlayerAndFollowerSpriteGraphics)
; reads: wPartyCount, hTemp0, hTemp4, hTemp5, hTemp2, hTemp3, wIsCGB, hTemp1
; writes: hTemp4, hTemp5, hTemp2, hTemp3, rRAMG, rROMB0
; points at: wPartyList, wOBJPaletteBuffer
LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte::
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

.loop:
    push bc
    push de
    ld a, $0A
    ld [rRAMG], a
    push de
    ld a, [de]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop de
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_load_sram_record_word
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
    ld de, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_Data
    ld b, $7E
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jp z, .check_temp3
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
    ld de, OBJPaletteBufferData_7E_4BBD
    add a, e
    ld e, a
    jr nc, .call_copy_from_bank
    inc d

.call_copy_from_bank:
    ld b, $7E
    ld c, $08
    call CopyFromBank
    jr .check_temp3

.call_load_sram_record_word:
    ld a, [de]
    ld c, MON_SPECIES
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
    jr z, .check_temp3
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

.check_temp3:
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
    jp nz, .loop
    ret

; A = SRAM record number: grades the record's bytes at offsets $6F, $72 and $70 with GradeTemp0 (g1, g2, g3, each 0-2) and returns A = 9 * g1 + 3 * g2 + g3, a number from 0 to 26. The status screen passes this to the string database as a personality-name index (category 7, 27 names), so it is the monster's personality index (E-0031)
; 4 call sites from 4 routines (e.g. DrawItemTargetStatPreview, PersonalityMessage_LoadSRAMRecordByte, ShowRecordPersonalityName, BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; reads: hTemp6
; writes: hTemp6
PersonalityIndexOfRecord::
Func_000_2391:: ; address name
    ldh [hTemp6], a
    ld c, MON_PERSONALITY
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
; 10 call sites from 8 routines (e.g. RandomGoldOrItem_Number24ToPackedBCD, StepTriggerReward_CopyItemNameToDE, AddRewardToCounterCappedAt999, GoldItemOrLoss_Case01_ShowTaraThereYouAre, ...)
; reads: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp2
WritePackedBCDNoLeadingZeros::
Func_000_23CA:: ; address name
    ldh a, [hTemp0]
    or a, a
    jr nz, .check_temp3
    ldh a, [hTemp1]
    or a, a
    jr nz, .check_temp3
    ldh a, [hTemp2]
    or a, a
    jr nz, .check_temp3
    ldh a, [hTemp3]
    or a, a
    jr nz, .check_temp3
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ret

.check_temp3:
    ld c, $00
    ldh a, [hTemp3]
    or a, a
    jr z, .skip
    ld [de], a
    inc de
    ld c, $01

.skip:
    ld b, $03
    ld hl, hTemp2

.loop:
    ld a, [hl]
    swap a
    and a, $0F
    bit 0, c
    jr nz, .skip2
    or a, a
    jr z, .skip3

.skip2:
    ld [de], a
    inc de
    ld c, $01

.skip3:
    ld a, [hl]
    and a, $0F
    bit 0, c
    jr nz, .skip4
    or a, a
    jr z, .next

.skip4:
    ld [de], a
    inc de
    ld c, $01

.next:
    dec hl
    dec b
    jr nz, .loop
    ld a, $F0
    ld [de], a
    ret

; HL = $4558 + 2 * A, switches to ROM bank 8 and continues with the shared read at CopyItemNameToDE_Skip (E-0126)
; 1 call site from 1 routine (e.g. YoldTalkEvents_TestFlagBit_Case13)
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
    jr CopyItemNameToDE_Skip

; A = item number: with ROM bank $08 mapped, copies that string of StringTable_ItemNames, including its $F0 terminator, to DE; restores the bank (E-0071)
; 17 call sites from 13 routines (e.g. KeyWorldDoorItem_StartMessageA, RandomGoldOrItem_Number24ToPackedBCD, AreaItemEvent_StartMessageA, StepTriggerReward_CopyItemNameToDE, ...)
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

CopyItemNameToDE_Skip::
Jump_000_2447:: ; address name
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; A = key slot, or $FE: writes 'Magic Key' to DE; otherwise writes the name of key A in wKeyList (4-byte entries from $C708): the word numbered byte 0 + 1, then the word numbered byte 1 + $11 (CopyKeyNameWordToDE), then $F0 (E-0090)
; 7 call sites from 7 routines (e.g. DebugAutomap_Update_CopyGlyphTilesToVRAM, PauseMenu_State3_WriteTextWindowRowsAndTextWindowWidthEtc, PauseMenu_State3_Case01_UpdateMenuCursor_Case03, PauseMenu_State3_WaitPauseListCount, ...)
WriteKeyNameToDE::
Func_000_2458:: ; address name
    cp a, $FE
    jr nz, .skip
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
    jr .done

.skip:
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

.done:
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

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; returns A unchanged when wC58A is non-zero and wC5DB is 4; otherwise A = the byte at wC6FE + (A & $7F); HL is clobbered in that case
; 4 call sites from 4 routines (e.g. SRAMRecordAddressMapped, DrawItemTargetStatPreview, MapIndexViaPartyListKeepHL, BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; reads: wLinkMode, wGameMode
; points at: wPartyList
MapIndexViaPartyList::
Func_000_24C5:: ; address name
    push bc
    ld b, a
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    ld a, [wGameMode]
    cp a, $04
    jr nz, .skip
    ld a, b
    pop bc
    ret

.skip:
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
; 73 call sites from 57 routines (e.g. ArenaMenu_Case12_ReadGridCursorX_Sub03, ArenaMenu_Case02_ReadGridCursorX_Sub03, DrawC5BEC6AtScrollOffsetDE_Bank15, BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap, ...)
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
    jr nz, .restore
    pop hl
    push hl
    ld d, a
    ld a, l
    and a, $1F
    cp a, d
    jr nc, .restore
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

.restore:
    pop hl
    pop de
    pop bc
    xor a, a
    ret

; hFFD2/hFFD3 = -(hScrollX - 9) - 1 and hFFD4/hFFD5 = -(hScrollY - $11) - 1 as 16-bit values; returns early in game mode 1 when wC5DC & $0F = 6
; 11 call sites from 3 routines (e.g. GameFrameUpdate, RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY, SceneLandHo_ComputeSpriteScrollOffsets)
; reads: wGameMode, wModeState
; writes: hSpriteScrollXLo, hSpriteScrollXHi, hSpriteScrollYLo, hSpriteScrollYHi
; points at: hScrollX, hScrollY
ComputeSpriteScrollOffsets::
Func_000_252D:: ; address name
    ld a, [wGameMode]
    cp a, $01
    jr nz, .skip
    ld a, [wModeState]
    and a, $0F
    cp a, $06
    ret z

.skip:
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

ComputeSpriteScrollOffsets_Skip::
Jump_000_255B:: ; address name
    push af
    push bc
    push de
    push hl
    farcall RunLinkSession
    pop hl
    pop de
    pop bc
    pop af
    reti

ComputeSpriteScrollOffsets_Skip2::
Jump_000_256A:: ; address name
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
    dw ComputeSpriteScrollOffsets_WriteSVBK
    dw ComputeSpriteScrollOffsets_WriteSVBK_Case01
    dw ComputeSpriteScrollOffsets_WriteSCXAndLYCEtc
    dw ComputeSpriteScrollOffsets_WriteSCYAndLYCEtc

; entry 0 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; writes: rSVBK
ComputeSpriteScrollOffsets_WriteSVBK::
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
ComputeSpriteScrollOffsets_WriteSVBK_Case01::
Jump_000_2589:: ; address name
    jr ComputeSpriteScrollOffsets_WriteSVBK

; entry 2 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; reads: rLY, rLYC, hScrollX
; writes: rSCX, rLYC, rSVBK
; points at: wBGPaletteCopy
ComputeSpriteScrollOffsets_WriteSCXAndLYCEtc::
Jump_000_258B:: ; address name
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCX], a
    ldh a, [rLYC]
    add a, $02
    cp a, $90
    jr c, .skip
    ldh a, [hScrollX]
    ldh [rSCX], a
    ld a, $00

.skip:
    ldh [rLYC], a
    jr ComputeSpriteScrollOffsets_WriteSVBK

; entry 3 of the `rst $00` table in ComputeSpriteScrollOffsets
; no direct call (reached through a table, a jump or a vector)
; reads: rLY, rLYC, hScrollY
; writes: rSCY, rLYC, rSVBK
; points at: wBGPaletteCopy
ComputeSpriteScrollOffsets_WriteSCYAndLYCEtc::
Jump_000_25AA:: ; address name
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCY], a
    ldh a, [rLYC]
    add a, $02
    cp a, $81
    jr c, .skip
    ldh a, [hScrollY]
    ldh [rSCY], a
    ld a, $00

.skip:
    ldh [rLYC], a
    jr ComputeSpriteScrollOffsets_WriteSVBK

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

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $F0
    jr nz, .loop
    ret

; sets bit 1 of wC52B, then runs the display step at $2620 until wC52B is zero
; 17 call sites from 17 routines (e.g. ShowString_Bank07, ShowString_Bank08, ShowString_Bank09, ShowString_Bank0B, ...)
; reads: wTextFlags
; points at: wTextFlags
RunStringDisplayToEnd::
Func_000_2611:: ; address name
    ld hl, wTextFlags
    set 1, [hl]

.loop:
    call StepStringDisplayUntilDone
    ld a, [wTextFlags]
    or a, a
    jr nz, .loop
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
    jr z, StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo

.loop:
    ld hl, wTextFlags
    set 1, [hl]
    call StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo
    ld a, [wTextControl]
    bit 7, a
    jr nz, .loop
    ret

; only called from StepStringDisplayUntilDone (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone)
; reads: wStringBank, wTextControl, wTextFlags, wFrameCounterLo, wTextLastChar, wJoypadPressedRepeat, wLinkJoypadPressedRepeat, wTextYesNoResult, ...
; writes: rROMB0, wTextYesNoResult, wTextRepeatCount, wTextDelayCounter, wTextLineCount, wTextPosLo, wTextPosHi
; points at: wTextFlags, wTextLineCount, wTextControl, wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo::
Func_000_2637:: ; address name
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wStringBank]
    ld [rROMB0], a
    ld a, [wTextControl]
    bit 2, a
    jp nz, .read_sound_channel_slots
    ld a, [wTextFlags]
    or a, a
    jp z, .skip2
    bit 5, a
    jr z, .check_text_flags
    ld c, $BD
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_add_hl_to_text_cursor_text_cursor_lo
    ld c, $B4

.call_add_hl_to_text_cursor_text_cursor_lo:
    ld hl, $0060
    call AddHLToTextCursorTextCursorLo
    ld b, $09
    call AdvanceBGMapColumnsByB
    ld a, c
    call WriteVRAMByte

.check_text_flags:
    ld a, [wTextFlags]
    bit 2, a
    jp z, .check_bit6
    ld a, [wTextLastChar]
    cp a, $E6
    jr z, .read_joypad_pressed_repeat
    ld a, [wTextLastChar]
    cp a, $FF
    jp nz, .read_joypad_pressed

.read_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    ld b, a
    ld a, [wLinkJoypadPressedRepeat]
    or a, b
    bit 6, a
    jr z, .check_bit7
    ld a, [wTextYesNoResult]
    and a, $01
    xor a, $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect
    jr .check_text_yes_no_result

.check_bit7:
    bit 7, a
    jr z, .check_text_yes_no_result
    ld a, [wTextYesNoResult]
    and a, $01
    xor a, $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect

.check_text_yes_no_result:
    ld c, $BB
    ld b, $C3
    ld a, [wTextYesNoResult]
    or a, a
    jr z, .check_frame_counter_lo
    ld c, $C3
    ld b, $BB

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_bg_map_address_at_scroll_plus_hl
    ld c, $C3
    ld b, $C3

.call_bg_map_address_at_scroll_plus_hl:
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
    jr z, .check_bit1
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .set_text_yes_no_result_to_01
    ld a, [wTextLastChar]
    cp a, $E6
    jp z, .skip
    ld a, $69
    call QueueSoundEffect
    jr .skip

.check_bit1:
    bit 1, a
    jp z, .skip2

.set_text_yes_no_result_to_01:
    ld a, $01
    ld [wTextYesNoResult], a

.skip:
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
    jp .skip2

.read_joypad_pressed:
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jp z, .skip2
    ld hl, wTextFlags
    res 2, [hl]
    res 1, [hl]
    call ShowTextContinueMark
    jp .skip2

.check_bit6:
    bit 6, a
    jr z, .check_bit72
    ld a, [wTextRepeatCount]
    dec a
    ld [wTextRepeatCount], a
    or a, a
    jp z, .call_show_text_continue_mark
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jp z, .skip2

.call_show_text_continue_mark:
    ld hl, wTextFlags
    res 6, [hl]
    call ShowTextContinueMark
    jp .skip2

.check_bit72:
    bit 7, a
    jr z, .read_text_pos_lo
    ld a, [wTextDelayCounter]
    dec a
    ld [wTextDelayCounter], a
    or a, a
    jp nz, .skip2
    ld hl, wTextFlags
    res 7, [hl]
    jp .skip2

.read_text_pos_lo:
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, [hl]
    cp a, $8D
    jr z, .read_text_pos_lo2
    cp a, $8E
    jr z, .read_text_pos_lo2
    cp a, $E0
    jr nc, .read_text_pos_lo3
    ld a, [wTextFlags]
    bit 1, a
    jr nz, .clear_text_line_count
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or a, b
    and a, $F7
    jr z, .read_battle_kind_flags
    ld hl, wTextControl
    set 7, [hl]

.read_battle_kind_flags:
    ld a, [wBattleKindFlags]
    ld b, a
    ld a, [wTextFlags]
    bit 3, a
    jr z, .check_text_line_count
    ld a, [wTextControlArg]
    ld b, a

.check_text_line_count:
    ld a, [wTextLineCount]
    cp a, b
    jp c, .skip2

.clear_text_line_count:
    xor a, a
    ld [wTextLineCount], a
    ld hl, wTextControl
    res 1, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    cp a, $E0
    jr nc, .read_text_pos_lo3
    call StepStringDisplayUntilDone_Sub01_GlyphTileSourceForL
    ld a, [wTextControl]
    bit 0, a
    jr z, .skip2
    ld a, b
    cp a, $90
    jr z, .skip2
    cp a, $9A
    jr z, .skip2
    ld a, [wTextBeepSound]
    call QueueSoundEffect
    ld hl, wTextControl
    set 1, [hl]
    jr .skip2

.read_text_pos_lo2:
    ld a, [wTextPosLo]
    add a, $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc a, $00
    ld [wTextPosHi], a
    ld a, [hl]
    call CallFunc28BDInBank1F
    jr .skip2

.read_text_pos_lo3:
    ld a, [wTextPosLo]
    add a, $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc a, $00
    ld [wTextPosHi], a
    ld a, [hl]
    call StepStringDisplayUntilDone_Sub01_WriteTextLastChar
    ld hl, wTextControl
    res 1, [hl]
    jr .skip2

.read_sound_channel_slots:
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
    jr nz, .skip2
    ld hl, wTextControl
    res 2, [hl]

.skip2:
    ld hl, wTextLineCount
    inc [hl]
    pop af
    ld [rROMB0], a
    ret

; only called from StepStringDisplayUntilDone_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo)
; reads: rSTAT
; writes: rROMB0, wTextGlyphDestLo, wTextGlyphDestHi
StepStringDisplayUntilDone_Sub01_GlyphTileSourceForL::
Func_000_287E:: ; address name
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call GlyphTileSourceForL
    ld c, $08

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, .loop
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    pop af
    ld [rROMB0], a
    ret

; L = A; switches to ROM bank $1F, calls Func_000_28BD and restores the bank (E-0122)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo)
; writes: rROMB0
CallFunc28BDInBank1F::
Func_000_28AB:: ; address name
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call CallFunc28BDInBank1F_GlyphTileSourceForL
    pop af
    ld [rROMB0], a
    ret

; only called from CallFunc28BDInBank1F (E-0047)
; 1 call site from 1 routine (e.g. CallFunc28BDInBank1F)
; reads: rSTAT
; writes: wTextGlyphDestLo, wTextGlyphDestHi
CallFunc28BDInBank1F_GlyphTileSourceForL::
Func_000_28BD:: ; address name
    call GlyphTileSourceForL
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld b, $10

.loop:
    di
    ld a, b
    cp a, $0D
    jr z, .loop3

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    or a, [hl]
    ld [hl+], a
    jr .skip

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    or a, [hl]
    and a, $FD
    ld [hl+], a

.skip:
    ei
    inc de
    dec b
    jr nz, .loop
    ld a, l
    ld [wTextGlyphDestLo], a
    ld a, h
    ld [wTextGlyphDestHi], a
    ret

; DE = $4010 + 16 * L (the 16-byte tile of glyph L in the font bank); HL = the word at wC531/wC532 (E-0120)
; 2 call sites from 2 routines (e.g. StepStringDisplayUntilDone_Sub01_GlyphTileSourceForL, CallFunc28BDInBank1F_GlyphTileSourceForL)
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
; 110 call sites from 74 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark_Case12, FillTilesRequest, BeginStringDisplay, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD, ...)
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

.loop:
    ld a, [wTextWindowRows]
    ld b, a

.loop2:
    push bc
    ld b, $10
    ld de, $2940

.loop3:
    di

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec b
    jr nz, .loop3
    pop bc
    dec b
    jr nz, .loop2
    dec c
    jr nz, .loop
    ret
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; only called from StepStringDisplayUntilDone_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo)
; writes: wTextLastChar
StepStringDisplayUntilDone_Sub01_WriteTextLastChar::
Func_000_2950:: ; address name
    ld [wTextLastChar], a
    sub a, $E0
    rst $00
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case05
    dw StepStringDisplayUntilDone_Sub01_Sub02_ToAcknowledgeTextPrompt
    dw StepStringDisplayUntilDone_Sub01_Sub02_AcknowledgeTextPrompt
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case08
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case09
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextBeepSound
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextBeepSound_Case0B
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextDelayCounter
    dw StepStringDisplayUntilDone_Sub01_Sub02_SetTextControlBit7
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteVRAMByte
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc
    dw StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc_Case11
    dw StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark_Case12
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc_Case13
    dw ClearStringDisplayFlags
    dw StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit1
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextStartPosLoAndTextStartPosHiEtc
    dw StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit2Etc
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case18
    dw StepStringDisplayUntilDone_Sub01_Sub02_WriteTextStartPosLoAndTextStartPosHiEtc_Case19
    dw StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit5
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1B
    dw StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1C
    dw StepStringDisplayUntilDone_Sub01_Sub02_SetTextControlBit0
    dw StepStringDisplayUntilDone_Sub01_Sub02_ClearTextControlBit0
    dw AcknowledgeTextPrompt

; entry 0 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord::
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
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case05::
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
StepStringDisplayUntilDone_Sub01_Sub02_ToAcknowledgeTextPrompt::
Jump_000_29BA:: ; address name
    jp AcknowledgeTextPrompt

; entry 7 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextYesNoResult, wTextLastChar
StepStringDisplayUntilDone_Sub01_Sub02_AcknowledgeTextPrompt::
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
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case08::
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
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case09::
Jump_000_29FA:: ; address name
    call IncrementTextPosLoWord
    ld a, [hl]
    cp a, $FF
    jr z, .call_restart_map_music
    cp a, $60
    jr c, .call_queue_music
    cp a, $CC
    jr z, .call_queue_music
    cp a, $CF
    jr z, .call_queue_music
    cp a, $D6
    jr z, .call_queue_music
    call QueueSoundEffect
    ret

.call_queue_music:
    call QueueMusic
    ret

.call_restart_map_music:
    farcall RestartMapMusic
    ret
    db $CD, $78, $12, $C9

; entry 10 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextBeepSound
; points at: wTextControl
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextBeepSound::
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
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextBeepSound_Case0B::
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
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextDelayCounter::
Jump_000_2A3B:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    ld a, [wBattleKindFlags]
    cp a, $07
    jr z, .skip
    ld hl, $2A66
    add_a_to_hl
    ld a, [hl]
    ld [wTextDelayCounter], a
    ld hl, wTextFlags
    set 7, [hl]
    ret

.skip:
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
StepStringDisplayUntilDone_Sub01_Sub02_SetTextControlBit7::
Jump_000_2A6D:: ; address name
    ld hl, wTextControl
    set 7, [hl]
    ret

; entry 14 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTextCursorLo, wTextCursorHi, wTextLineStartLo, wTextLineStartHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi
; points at: wTextFlags
StepStringDisplayUntilDone_Sub01_Sub02_WriteVRAMByte::
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

.loop:
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, .loop
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

.loop2:
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec bc
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    pop bc
    ld hl, $0040
    call AddHLToTextCursorTextCursorLo

.loop3:
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, .loop3
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
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc::
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
    jr z, .read_text_cursor_lo
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

.read_text_cursor_lo:
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

.loop:
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, .loop
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

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ei
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld hl, wTextFlags
    set 7, [hl]
    ld a, $04
    ld [wTextDelayCounter], a
    ret

; entry 16 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wTextStartPosLo, wTextStartPosHi
; writes: wTextFlags, wTextPosLo, wTextPosHi, wTextControl
StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark::
Jump_000_2BCD:: ; address name
    ld a, [wTextFlags]
    bit 4, a
    jp z, .clear_text_flags
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

.clear_text_flags:
    xor a, a
    ld [wTextFlags], a
    xor a, a
    ld [wTextControl], a
    ret

; when wC52B bit 5 is set: clears it, moves to the text cursor + $60 and 9 columns right, and writes tile $B4 there (probably the continue mark); plays sound $69 unless wGameMode is 4 (E-0120)
; 4 call sites from 3 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark_Case12, StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark)
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
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc_Case11::
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
StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark_Case12::
Jump_000_2C48:: ; address name
    call ShowTextContinueMark
    call ClearStringDisplayFlags
    call FillTilesFromRequest

; entry 19 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi
; writes: wTextGlyphDestLo, wTextGlyphDestHi, wTextLineStartLo, wTextLineStartHi
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc_Case13::
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
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_Sub01_Sub02_ShowTextContinueMark_Case12)
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
StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit1::
Jump_000_2C75:: ; address name
    ld hl, wTextFlags
    set 1, [hl]
    ret

; entry 22 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; reads: wTextPosLo, wTextPosHi
; writes: wTextStartPosLo, wTextStartPosHi, wTextPosLo, wTextPosHi
; points at: wPlayerName, wPlayerNameText, wTextFlags
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextStartPosLoAndTextStartPosHiEtc::
Jump_000_2C7B:: ; address name
    ld hl, wPlayerName
    ld de, wPlayerNameText
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
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
StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit2Etc::
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
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case18::
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
StepStringDisplayUntilDone_Sub01_Sub02_WriteTextStartPosLoAndTextStartPosHiEtc_Case19::
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
StepStringDisplayUntilDone_Sub01_Sub02_SetTextFlagsBit5::
Jump_000_2CFD:: ; address name
    ld hl, wTextFlags
    set 5, [hl]
    ret

; entry 27 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; writes: wTextRepeatCount
; points at: wTextFlags, wTextControl
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1B::
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
StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1C::
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
StepStringDisplayUntilDone_Sub01_Sub02_SetTextControlBit0::
Jump_000_2D27:: ; address name
    ld hl, wTextControl
    set 0, [hl]
    ret

; entry 30 of the `rst $00` table in Func_000_2950
; no direct call (reached through a table, a jump or a vector)
; points at: wTextControl
StepStringDisplayUntilDone_Sub01_Sub02_ClearTextControlBit0::
Jump_000_2D2D:: ; address name
    ld hl, wTextControl
    res 0, [hl]
    ret

; clears bit 7 of wC52C, plays sound $6C, runs Func_000_2D4A, sets bit 2 of wC52B and clears wC552 (E-0122)
; 1 call site from 1 routine (e.g. StepStringDisplayUntilDone_Sub01_Sub02_AcknowledgeTextPrompt)
; writes: wTextYesNoResult
; points at: wTextControl, wTextFlags
AcknowledgeTextPrompt::
Func_000_2D33:: ; address name
    ld hl, wTextControl
    res 7, [hl]
    ld a, $6C
    call QueueSoundEffect
    call AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0
    ld hl, wTextFlags
    set 2, [hl]
    xor a, a
    ld [wTextYesNoResult], a
    ret

; only called from AcknowledgeTextPrompt (E-0047)
; 1 call site from 1 routine (e.g. AcknowledgeTextPrompt)
; reads: wIsCGB
; writes: rVBK
AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0::
Func_000_2D4A:: ; address name
    call UploadTwoTilesFromScriptTileBuf0
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, $0100
    call BGMapAddressAtScrollPlusHL
    ld b, $0E
    call AdvanceBGMapColumnsByB
    push hl
    ld de, TextPromptWindowTiles

.skip:
    push hl

.skip2:
    ld a, [de]
    inc de
    cp a, $FE
    jr z, .check_is_cgb
    cp a, $FD
    jr nz, .call_write_vram_byte
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
    jr .skip

.call_write_vram_byte:
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    jr .skip2

.check_is_cgb:
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, TextPromptWindowAttrs
    push bc
    ld a, $01
    ldh [rVBK], a
    pop bc

.skip3:
    push hl

.skip4:
    ld a, [de]
    inc de
    cp a, $FE
    jr z, .skip5
    cp a, $FD
    jr nz, .call_write_vram_byte2
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
    jr .skip3

.call_write_vram_byte2:
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    jr .skip4

.skip5:
    push bc
    ld a, $00
    ldh [rVBK], a
    pop bc
    pop hl
    ret

; copies the 16-byte tiles at wC89E and wC8AE to vTiles1 + $6E0 and + $6F0 (CopyCBytesToVRAMWaitSTAT) (E-0117)
; 1 call site from 1 routine (e.g. AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0)
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

; E-0239 (C1: AcknowledgeTextPrompt_Sub01 writes these bytes to the BG map (WriteVRAMByte) from 14 columns right of scroll + $100, moving to the next 32-byte row at $FD and stopping at $FE; 5 rows of 6).
; record: one 6-tile row and its separator
TextPromptWindowTiles::
Data_000_2DFA:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2, $FD ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7, $FD ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7, $FD ; id 2
    db $B6, $C3, $EE, $EF, $C3, $B7, $FD ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5, $FE ; id 4

; E-0239 (C1: AcknowledgeTextPrompt_Sub01 writes these bytes to the BG map in VRAM bank 1 (CGB only) from 14 columns right of scroll + $100, moving to the next 32-byte row at $FD and stopping at $FE; 5 rows of 6).
; record: one 6-tile row and its separator
TextPromptWindowAttrs::
Data_000_2E1D:: ; address name
    db $00, $00, $00, $00, $00, $00, $FD ; id 0
    db $00, $00, $00, $00, $00, $00, $FD ; id 1
    db $00, $00, $00, $00, $00, $00, $FD ; id 2
    db $00, $00, $00, $00, $00, $00, $FD ; id 3
    db $00, $00, $00, $00, $00, $00, $FE ; id 4

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
; 10 call sites from 9 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1C, StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case1B, StepStringDisplayUntilDone_Sub01_Sub02_IncrementTextPosLoWord_Case18, ...)
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
; 24 call sites from 23 routines (e.g. PauseMenu_Skills_UseFieldSkill_CopyStringHLToDE, PauseMenu_Skills_UseFieldSkill_CopyTileBufferToBGMap, PauseMenu_Items_Case00_UpdateMenuCursor, PauseMenu_Skills_UseFieldSkill_Case07_Sub01_NextTableByte, ...)
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
; 47 call sites from 30 routines (e.g. GameMode0_Init, DebugSkillViewer_Update, PauseMenu_State4, GameMode5_Init_SendSGBPaletteSetPacket_Case06, ...)
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
; 10 call sites from 4 routines (e.g. ShowRaiseAmountOrRefuse, WriteRecordField4BAndStatsDecimal, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1)
WriteDecimalByteString::
Func_000_2EAC:: ; address name
    cp a, $64
    jr nc, .call_write_decimal_digit_for_e
    cp a, $0A
    jr nc, .call_write_decimal_digit_for_e2
    jr .skip

.call_write_decimal_digit_for_e:
    ld e, $64
    call WriteDecimalDigitForE

.call_write_decimal_digit_for_e2:
    ld e, $0A
    call WriteDecimalDigitForE

.skip:
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; D = A / E by repeated subtraction, stored at HL; HL += 1; A = the remainder (E-0074)
; 2 call sites from 1 routine (e.g. WriteDecimalByteString)
WriteDecimalDigitForE::
Func_000_2EC5:: ; address name
    ld d, $FF

.loop:
    inc d
    sub a, e
    jr nc, .loop
    add a, e
    ld [hl], d
    inc hl
    ret

; writes the 24-bit number in hFFC6-hFFC8 as decimal digits from the millions down (dividing by 1,000,000, 100,000 and 10,000), then the 16-bit remainder through the shared writer (E-0127)
; 2 call sites from 2 routines (e.g. BattleEnd_GainExperience_WriteBattleResolveStepAndBattleSubPhaseEtc, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowReceivedWG)
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
    jp nz, .set_temp6_to_0F
    ld a, $01
    ldh [hTemp6], a
    ld e, $A0
    ld d, $86
    call Quotient24ByHFFCCDE
    or a, a
    jr nz, .set_temp6_to_01
    ld a, $00
    ldh [hTemp6], a
    ld e, $10
    ld d, $27
    call Quotient24ByHFFCCDE
    or a, a
    jr nz, .set_temp6_to_00
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    jp WriteBCAsDecimalString

.set_temp6_to_0F:
    ld a, $0F
    ldh [hTemp6], a
    ld e, $40
    ld d, $42
    call Divide24ByHFFCCDE
    call StoreAThenTerminator

.set_temp6_to_01:
    ld a, $01
    ldh [hTemp6], a
    ld e, $A0
    ld d, $86
    call Divide24ByHFFCCDE
    call StoreAThenTerminator

.set_temp6_to_00:
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
    jp WriteBCAsDecimalString_CallDivideBCByDE

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

.loop:
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
    jr nc, .loop
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
; 2 call sites from 2 routines (e.g. WriteBattleDamageToTextBuf1, RunBattleActions_Case09_CarryUnlessBattleSlotOutSlotEmpty)
WriteBCAsDecimalString::
Func_000_2F84:: ; address name
    ld de, $03E8
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE
    ld de, $0064
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE2
    ld de, $000A
    push bc
    call DivideBCByDE
    pop bc
    or a, a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE3
    jr WriteBCAsDecimalString_CallStoreAThenTerminator

WriteBCAsDecimalString_CallDivideBCByDE::
Jump_000_2FA7:: ; address name
    ld de, $03E8
    call DivideBCByDE
    call StoreAThenTerminator

WriteBCAsDecimalString_CallDivideBCByDE2::
Jump_000_2FB0:: ; address name
    ld de, $0064
    call DivideBCByDE
    call StoreAThenTerminator

WriteBCAsDecimalString_CallDivideBCByDE3::
Jump_000_2FB9:: ; address name
    ld de, $000A
    call DivideBCByDE
    call StoreAThenTerminator

WriteBCAsDecimalString_CallStoreAThenTerminator::
Jump_000_2FC2:: ; address name
    ld a, c
    call StoreAThenTerminator
    ret

; A = BC / DE by repeated subtraction (the quotient must fit in 8 bits), BC = the remainder; HL kept (E-0078)
; 6 call sites from 1 routine (e.g. WriteBCAsDecimalString)
DivideBCByDE::
Func_000_2FC7:: ; address name
    push hl
    ld h, $FF

.loop:
    inc h
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    jr nc, .loop
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
; 16 call sites from 16 routines (e.g. PauseMenu_Skills_Case02_UpdateMenuCursor, PauseMenu_Skills_UseFieldSkill_CopyTileBufferToBGMap, PauseMenu_Items_Case00_UpdateMenuCursor, PauseMenu_Items_UseItem_UpdateMenuCursor, ...)
CopyFiveGlyphsPlusMarks::
Func_000_2FE1:: ; address name
    ld b, $05

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $8D
    jr z, .loop
    cp a, $8E
    jr z, .loop
    dec b
    jr nz, .loop
    ld a, [de]
    cp a, $8D
    jr z, .done
    cp a, $8E
    jr z, .done
    ld [hl], $F0
    ret

.done:
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

.loop:
    push bc

.loop2:
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, .loop2
    pop bc
    ld hl, $0040
    call AddHLToTextCursorTextCursorLo
    dec c
    jr nz, .loop
    ret

; moves HL B entries to the right inside its 32-entry BG map row, wrapping at the row end (NextBGMapColumn B times); B = 0 (E-0078)
; 5 call sites from 3 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, ShowTextContinueMark, AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0)
AdvanceBGMapColumnsByB::
Func_000_3048:: ; address name
    call NextBGMapColumn_Bank00
    dec b
    jr nz, AdvanceBGMapColumnsByB
    ret

; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping at the row end; keeps AF (the same 15 bytes appear in 2 banks)
; 8 call sites from 6 routines (e.g. AdvanceBGMapColumnsByB, AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0, StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc, BlankBGMapEntriesRight, ...)
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
; 7 call sites from 5 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, ShowTextContinueMark, StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc, StepStringDisplayUntilDone_Sub01_Sub02_WriteVRAMByte, ...)
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
; 3 call sites from 2 routines (e.g. StepStringDisplayUntilDone_AddHLToTextCursorTextCursorLo, AcknowledgeTextPrompt_UploadTwoTilesFromScriptTileBuf0)
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
; 3 call sites from 2 routines (e.g. StepStringDisplayUntilDone_Sub01_Sub02_WriteTextGlyphDestLoAndTextGlyphDestHiEtc, StepStringDisplayUntilDone_Sub01_Sub02_WriteVRAMByte)
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

.loop:
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; E-0189 (C1: StartChannelFromTrackHeader.set_sound_event_byte17 indexes it by (hSndA8Param >> 4) * 2; only entry 0 exists, and the wave set follows it directly).
; record: wave set
SoundWaveSetTable::
Data_000_30CC:: ; address name
    dw SoundWaveSet0 ; id 0

; E-0189 (C1: StartChannelFromTrackHeader.set_sound_event_byte17 clears rNR30, then copies the 16 bytes at the set + wave number * 16 (wave number from hSndSweepOrWave or the track, swapped into the high nibble) to $FF30-$FF3F; wave 0 is a sine, 1 a triangle, 2 a square, 3 a sawtooth).
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

; E-0189 (C1: SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05_CheckSndVibratoDelay indexes it by (hSndA8Param & $0F) * 2; only entry 0 exists, and its rows follow it directly).
; record: modulation rows
SoundModulationTable::
Data_000_31CE:: ; address name
    dw SoundModulationRows0 ; id 0

; E-0189 (C1: SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05_CheckSndVibratoDelay reads the byte at the rows - $10 + (hSndVibratoDepth | phase), where the phase is 4 bits computed from hSndVibratoCounter and hSndVibratoDelay, so row 1 is the first; 12 rows end at the routine at $3290; what each step does to the pitch or volume is not read).
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
; 10 call sites from 8 routines (e.g. BootAndMainLoop, StartMusic, DebugSoundTest_Update, GameMode1_Init, ...)
; writes: rNR52, rNR51, wSoundEngineMode, rNR50, wSoundEngineState, wSoundInitByte19
; points at: wSoundChannelSlots, wSoundLabelSlots
InitSoundHardware::
Func_000_3290:: ; address name
    ld bc, $0000
    call InitSoundHardware_WriteSoundTimer12AndSoundTimer13Etc
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

.loop:
    ld [hl+], a
    ld [hl-], a
    add hl, de
    dec b
    jr nz, .loop
    ld hl, wSoundLabelSlots
    ld b, $48
    xor a, a

.loop2:
    ld [hl+], a
    dec b
    jr nz, .loop2
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
InitSoundHardware_WriteSoundTimer12AndSoundTimer13Etc::
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
SoundTick_WriteSoundTimer14::
Func_000_32E8:: ; address name
    ld a, [wSoundChannelIndex]
    inc a
    ld b, a
    ld a, $01

.next:
    dec b
    jr z, .check_sound_timer14
    add a, a
    jr .next

.check_sound_timer14:
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
SoundTick_WriteSoundTimer14AndSoundTimer12::
Func_000_32FE:: ; address name
    ld a, [wSoundTimer14]
    ld hl, wSoundTimer12
    and a, [hl]
    cp a, [hl]
    jr nz, .clear_sound_timer14
    ld hl, wSoundChannelSlots + $6
    ld a, [wSoundTimer13]
    and a, $0F
    ld b, a
    ld a, [wSoundTimer12]

.loop:
    srl a
    ld [wSoundTimer14], a
    jr nc, .skip
    ld a, [hl]
    and a, $F0
    or a, b
    ld [hl], a

.skip:
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSoundTimer14]
    and a, a
    jr nz, .loop
    xor a, a
    ld [wSoundTimer12], a

.clear_sound_timer14:
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
    jr StartSound_Skip

; only called from StartMusic (E-0047)
; 1 call site from 1 routine (e.g. StartMusic)
; reads: wSoundId, wSoundEngineMode
; writes: wSoundId, rROMB0, wSoundEngineMode
; points at: wSoundChannelSlots
StartMusic_StartSound::
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
; 4 call sites from 4 routines (e.g. StartSoundEffect, StartThreeSoundTracks, StartTwoSoundTracks, StartMusic_StartSound)
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

StartSound_Skip::
Jump_000_335D:: ; address name
    cp a, [hl]
    jr c, .skip
    inc hl
    inc hl
    inc hl
    inc hl
    jr StartSound_Skip

.skip:
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
    jr z, .skip2
    inc hl
    ld a, [hl-]
    ld b, $EE
    and a, $03
    jr z, .check_sound_engine_mode
    ld b, $DD
    cp a, $01
    jr z, .check_sound_engine_mode
    ld b, $BB
    cp a, $02
    jr z, .check_sound_engine_mode
    ld b, $77

.check_sound_engine_mode:
    ld a, [wSoundEngineMode]
    and a, b
    ld [wSoundEngineMode], a

.skip2:
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

SoundTick_Loop::
Jump_000_33FD:: ; address name
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    and a, b
    cp a, $FF
    jp z, SoundTick_CheckSoundChannelIndex
    push hl
    ld c, $D8
    ld b, $04

.loop:
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
    jr nz, .loop
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

.loop2:
    rlca
    dec b
    jr nz, .loop2
    ld [wSoundSkipMaskB], a
    ld [wSoundTickByte0C], a
    ldh a, [hTrackPosLo]
    ld b, a
    ldh a, [hTrackPosHi]
    or a, b
    and a, a
    jp z, StartChannelFromTrackHeader
    call SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    call SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05
    ldh a, [hSndVibratoDelay]
    ld b, a
    ldh a, [hSndVibratoCounter]
    inc a
    cp a, b
    jr c, .set_snd_vibrato_counter
    ld a, b

.set_snd_vibrato_counter:
    ldh [hSndVibratoCounter], a
    ld hl, hSndTickAccum
    ldh a, [hSndDutyAndTempo]
    and a, $0F
    add a, [hl]
    cp a, $10
    jr c, .call_sound_tick_wait_sound_hw_channel
    sub a, $10
    ld [hl], a
    jr SoundTick_CheckSoundInitByte19

.call_sound_tick_wait_sound_hw_channel:
    ld [hl], a
    call SoundTick_WaitSoundHwChannel
    ldh a, [hSndNoteTimer]
    and a, a
    jr z, .check_snd_wait_ticks
    dec a
    ldh [hSndNoteTimer], a

.check_snd_wait_ticks:
    ldh a, [hSndWaitTicks]
    and a, a
    jr nz, SoundTick_SetSndWaitTicks
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr z, SoundTick_CallSoundTick_WriteSoundTimer14
    ld hl, hSndEnvTimer
    dec [hl]
    jr nz, SoundTick_CheckSndEnvFlags
    ldh a, [hSndEnvelopeReload]
    and a, $F0
    ld c, a
    ldh a, [hSndEnvelope]
    and a, $0F
    or a, c
    ldh [hSndEnvelope], a

SoundTick_CallSoundTick_WriteSoundTimer14::
Jump_000_349C:: ; address name
    call SoundTick_WriteSoundTimer14

SoundTick_ReadSndNoteLength::
Jump_000_349F:: ; address name
    ldh a, [hSndNoteLength]
    ldh [hSndNoteTimer], a
    call SoundNextEvent
    jr SoundTick_CheckSoundInitByte19

SoundTick_CheckSndEnvFlags::
Jump_000_34A8:: ; address name
    ldh a, [hSndEnvFlags]
    and a, $0F
    dec a
    cp a, [hl]
    jr nz, SoundTick_CheckSoundInitByte19
    call SoundTick_WriteSndEnvelopeReloadAndSndEnvelope
    ldh a, [hSndEnvelope]
    call WriteChannelEnvelopeIfChanged
    jr SoundTick_CheckSoundInitByte19

SoundTick_SetSndWaitTicks::
Jump_000_34BA:: ; address name
    dec a
    ldh [hSndWaitTicks], a
    jr nz, SoundTick_CheckSoundInitByte19
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr nz, SoundTick_CheckSoundInitByte19
    jr SoundTick_CallSoundTick_WriteSoundTimer14

SoundTick_CheckSoundInitByte19::
Jump_000_34C7:: ; address name
    ld a, [wSoundInitByte19]
    and a, a
    jr z, .read_sound_skip_mask_b
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, .read_sound_skip_mask_b
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr c, .read_sound_skip_mask_b
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jr nz, .read_sound_skip_mask_b
    ld a, [wSoundEventByte17]
    ld b, a
    ldh a, [hSndSweepOrWave]
    cp a, b
    jr z, .read_sound_skip_mask_b
    ld e, a
    ld [wSoundEventByte17], a
    swap e
    xor a, a
    ld [wSoundInitByte19], a
    ldh [rNR30], a
    ld d, a
    call SoundTick_ReadSndA8Param
    ld a, $80
    ldh [rNR30], a

.read_sound_skip_mask_b:
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    or a, b
    ld [wSoundSkipMaskA], a
    pop hl
    push hl
    ld c, $D8
    ld b, $04

.loop:
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
    jr nz, .loop
    pop hl

SoundTick_CheckSoundChannelIndex::
Jump_000_352F:: ; address name
    ld de, $0020
    add hl, de
    ld a, [wSoundChannelIndex]
    inc a
    ld [wSoundChannelIndex], a
    cp a, $06
    jp c, SoundTick_Loop
    ld a, [wSoundSkipMaskA]
    ld b, a
    ld a, [wSoundEngineMode]
    and a, b
    ld [wSoundEngineMode], a
    ldh [rNR51], a
    pop af
    ld [rROMB0], a
    call SoundTick_WriteSoundTimer14AndSoundTimer12
    ret

; C2 static reading (E-0019): channel start. Reads the 4-byte track header (byte 0 low nibble -> $FFDF, byte 1 -> duty bits of $FFDE (wave: $FFE6), byte 2 swapped -> $FFE0, byte 3 -> $FFE2) and begins playback at event 2 ($FFD8 = 2).
; the channel start: reads the 4-byte track header and begins playback at event 2 (see the annotation above)
; no direct call (reached through a table, a jump or a vector)
; reads: hTrackBaseLo, hTrackBaseHi, wSoundHwChannel, hSndNoteLength, wSoundInitByte19, wSoundChannelIndex, wSoundSkipMaskB, wSoundSkipMaskA, ...
; writes: hSndTickAccum, hSndDutyAndTempo, hSndEnvelope, hSndSweepOrWave, hSndChanByteE3, hSndBranchIndex, hSndVibratoDepth, hSndPitchSlide, ...
; points at: hSndTickAccum, hSndEnvTimer
StartChannelFromTrackHeader::
Jump_000_3554:: ; address name
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
    jr z, .set_snd_vibrato_delay
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    or a, d

.set_snd_duty_and_tempo:
    ldh [hSndDutyAndTempo], a
    ld a, [hl+]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .skip
    ld a, [hl+]
    ldh [hSndSweepOrWave], a

.clear_snd_chan_byte_e3:
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
    jp SoundTick_ReadSndNoteLength

.set_snd_vibrato_delay:
    ld a, [hl+]
    ldh [hSndVibratoDelay], a
    ld a, d
    jr .set_snd_duty_and_tempo

.skip:
    xor a, a
    ldh [rNR30], a
    ld d, a
    ldh a, [hSndSweepOrWave]
    ld e, a
    cp a, $FF
    jr nz, .set_sound_event_byte17
    ld e, [hl]
    ld a, e
    ldh [hSndSweepOrWave], a

.set_sound_event_byte17:
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

.loop:
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop
    jr .clear_snd_chan_byte_e3

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

.loop:
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
    ld a, [hl+]
    cp a, $D0
    jr nc, .cp_F0
    cp a, $B0
    jr nc, .cp_C0
    cp a, $A0
    jp nc, .cp_A0
    jp .check_snd_env_flags

.loop2:
    cp a, $FD
    jr z, .call_sound_label_slot
    cp a, $FF
    jr z, .set_track_pos_lo
    jr .next

.call_sound_label_slot:
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

.next:
    inc hl
    jr .loop

.set_track_pos_lo:
    ldh [hTrackPosLo], a
    ldh [hTrackPosHi], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, .call_sound_next_event_return_twice_if_sound
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr nc, .call_sound_next_event_return_twice_if_sound
    ld a, $FF
    ld [wSoundInitByte19], a

.call_sound_next_event_return_twice_if_sound:
    call SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ret

.cp_F0:
    cp a, $F0
    jr nc, .loop2
    cp a, $E0
    jr nc, .skip
    and a, $0F
    jr .check_sound_hw_channel

.skip:
    and a, $0F
    cpl
    inc a

.check_sound_hw_channel:
    ld b, a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .next2
    ld a, b
    ldh [hSndPitchSlide], a
    ld a, [hl]
    ldh [hSndPitchSlideTime], a
    ldh [hSndPitchSlideCounter], a

.next2:
    inc hl
    jr .loop

.loop3:
    and a, $0F
    ld b, a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .next3
    ldh a, [hSndEnvelope]
    and a, $0F
    jr nz, .next3
    ld a, [hl]
    ldh [hSndVibratoDelay], a
    ld a, b
    swap a
    ldh [hSndVibratoDepth], a

.next3:
    inc hl
    jp .loop

.cp_C0:
    cp a, $C0
    jr nc, .loop3
    and a, $0F
    jp z, .skip2
    ld e, a
    ld b, [hl]
    push hl
    call SoundLabelSlot
    inc [hl]
    ld a, [hl+]
    inc e
    cp a, e
    jr nc, .restore
    ld a, [hl+]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a

.restore:
    pop hl
    jp SoundNextEvent

.skip2:
    ld a, [hl]
    ld b, a
    and a, $F0
    cp a, $F0
    jp nz, .next4
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

.next4:
    inc hl
    jp .loop

.cp_A0:
    cp a, $A0
    jr nz, .cp_A1
    ld a, [hl+]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jp nz, .loop
    call WriteChannelEnvelopeIfChanged
    jp .loop

.cp_A1:
    cp a, $A1
    jr nz, .cp_A2
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .set_snd_sweep_or_wave
    ld a, [hl+]
    ldh [hSndSweepOrWave], a
    jp .loop

.set_snd_sweep_or_wave:
    ld a, [hl+]
    ld e, a
    ldh [hSndSweepOrWave], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and a, b
    jr z, .skip3
    jp .loop

.skip3:
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

.loop4:
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop4
    pop hl
    jp .loop

.cp_A2:
    cp a, $A2
    jr nz, .cp_A3
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .set_snd_vibrato_delay
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    ld d, a
    ldh a, [hSndDutyAndTempo]
    and a, $3F
    or a, d
    ldh [hSndDutyAndTempo], a
    jp .loop

.set_snd_vibrato_delay:
    ld a, [hl+]
    ldh [hSndVibratoDelay], a
    jp .loop

.cp_A3:
    cp a, $A3
    cp a, $A3
    jr nz, .cp_A5
    ld a, [hl+]
    cp a, $FE
    jr z, .check_snd_chan_flags
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

.set_snd_chan_flags:
    ldh [hSndChanFlags], a
    jp .loop

.check_snd_chan_flags:
    ldh a, [hSndChanFlags]
    and a, $0F
    jr .set_snd_chan_flags

.cp_A5:
    cp a, $A5
    jr nz, .cp_A6
    ld a, [hl+]
    cp a, $01
    jr nz, .set_snd_panning
    ldh a, [hSndPanning]
    swap a

.set_snd_panning:
    ldh [hSndPanning], a
    jp .loop

.cp_A6:
    cp a, $A6
    jr nz, .cp_A7
    ld a, [hl+]
    ldh [rNR50], a
    jp .loop

.cp_A7:
    cp a, $A7
    jr nz, .cp_A8
    ld a, [hl]
    ldh [hSndWaitTicks], a
    jp ComputeNotePitch_ReadSoundTickByte0C

.cp_A8:
    cp a, $A8
    jr nz, .cp_A9
    ld a, [hl+]
    ld c, a
    and a, $0F
    ld b, a
    ld a, c
    and a, $F0
    or a, b
    ldh [hSndA8Param], a
    jp .loop

.cp_A9:
    cp a, $A9
    jp nz, .cp_AA
    ld a, [hl+]
    cp a, $F0
    jr z, .check_snd_branch_index
    cp a, $F1
    jr z, .check_snd_branch_index2
    cp a, $F2
    jr z, .check_sound_event_byte18
    cp a, $F3
    jr z, .check_sound_event_byte182
    cp a, $FE
    jr z, .read_sound_event_byte18
    cp a, $FF
    jr nz, .cp_80
    ldh a, [hSndBranchIndex]
    jr .skip4

.read_sound_event_byte18:
    ld a, [wSoundEventByte18]

.skip4:
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

.cp_80:
    cp a, $80
    jr nc, .set_sound_event_byte18
    ldh [hSndBranchIndex], a
    jp .loop

.set_sound_event_byte18:
    sub a, $80
    ld [wSoundEventByte18], a
    jp .loop

.check_snd_branch_index:
    ldh a, [hSndBranchIndex]
    inc a
    ldh [hSndBranchIndex], a
    jp .loop

.check_snd_branch_index2:
    ldh a, [hSndBranchIndex]
    dec a
    ldh [hSndBranchIndex], a
    jp .loop

.check_sound_event_byte18:
    ld a, [wSoundEventByte18]
    inc a
    ld [wSoundEventByte18], a
    jp .loop

.check_sound_event_byte182:
    ld a, [wSoundEventByte18]
    dec a
    ld [wSoundEventByte18], a
    jp .loop

.cp_AA:
    cp a, $AA
    jr nz, .cp_AC
    ld a, [hl+]
    ld c, a
    and a, $F0
    jr z, .clear_snd_env_timer
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
    jp .loop

.clear_snd_env_timer:
    xor a, a
    ldh [hSndEnvTimer], a
    ldh [hSndEnvelopeReload], a
    ldh [hSndEnvFlags], a
    jp .loop

.cp_AC:
    cp a, $AC
    jr nz, .cp_AD
    ldh a, [hSndLoopCount]
    sub a, $01
    jr z, .clear_snd_loop_count
    jr nc, .set_snd_loop_count
    ld a, [hl]

.set_snd_loop_count:
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

.clear_snd_loop_count:
    xor a, a
    ldh [hSndLoopCount], a
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
    jp SoundNextEvent

.cp_AD:
    cp a, $AD
    jr nz, .cp_AE
    ldh a, [hSndReturnPosLo]
    ldh [hTrackPosLo], a
    ldh a, [hSndReturnPosHi]
    ldh [hTrackPosHi], a
    jp SoundNextEvent

.cp_AE:
    cp a, $AE
    jr nz, .cp_AF
    ld a, [hl+]
    and a, $10
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and a, $EF
    or a, b
    ldh [hSndDutyAndTempo], a
    jp .loop

.cp_AF:
    cp a, $AF
    jr nz, .next5
    ld a, [hl+]
    and a, $0F
    ldh [hSndTickAccum], a
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and a, $F0
    or a, b
    ldh [hSndDutyAndTempo], a
    jp .loop

.next5:
    inc hl
    jp .loop
    db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62

.loop5:
    xor a, a
    ldh [hSndFreqLo], a
    ld a, $80
    ldh [hSndFreqHi], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, .call_return_twice_if_sound_skip_mask_a_and
    call SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub01
    ret

.call_return_twice_if_sound_skip_mask_a_and:
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    xor a, a
    ldh [rNR30], a
    ret

.check_snd_env_flags:
    ld b, a
    ldh a, [hSndEnvFlags]
    and a, $F0
    jr z, .set_snd_wait_ticks
    push de
    ldh a, [hSndEnvFlags]
    and a, $0F
    ldh [hSndEnvTimer], a
    ld c, a
    ld a, [hl]
    sub a, c
    ldh [hSndWaitTicks], a
    pop de
    jr .check_sound_hw_channel2

.set_snd_wait_ticks:
    ld a, [hl]
    ldh [hSndWaitTicks], a

.check_sound_hw_channel2:
    ld a, [wSoundHwChannel]
    cp a, $03
    jr nz, .skip6
    ld a, b
    cp a, $1F
    jr z, .loop5
    cp a, $10
    jr nc, .skip5
    ld hl, $38A0
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld l, [hl]
    ld h, $00
    jr ComputeNotePitch

.skip5:
    ld l, a
    ld h, $00
    jr ComputeNotePitch

.skip6:
    ld a, b
    and a, $0F
    cp a, $0C
    jr nc, .loop5
    add a, a
    ld e, a
    ldh a, [hSndDutyAndTempo]
    and a, $10
    jr z, .skip7
    ld a, e
    add a, $18
    ld e, a

.skip7:
    ld d, $00
    ld hl, SoundNotePeriodTable
    add hl, de
    deref_hl
    ld a, b
    swap a
    and a, $0F
    jr z, .skip8
    ld b, a

.loop6:
    srl h
    rr l
    dec b
    jr nz, .loop6

.skip8:
    ld a, $00
    sub a, l
    ld l, a
    ld a, $08
    sbc a, h
    ld h, a

; C2 (E-0019: formula matched 1,928 of 1,928 emulated notes): pitch for a note event. The semitone (low nibble of the first byte, 0-11) indexes the period table at $3B5C ($3B74 when $FFDE bit 4 is set), the value is shifted right by the octave (high nibble) and subtracted from $0800 to give the frequency register value in HL. Noise-channel notes use $38A0.
; pitch for a note event: semitone and octave to the frequency register value in HL (see the annotation above)
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundHwChannel, hSndSweepOrWave, hSndDutyAndTempo, wSoundTickByte0C, hSndPanning, wSoundEngineMode, rNR52
; writes: hSndVibratoCounter, rNR30, hSndFreqLo, hSndFreqHi, wSoundEngineMode, rNR31
ComputeNotePitch::
Jump_000_3938:: ; address name
    xor a, a
    ldh [hSndVibratoCounter], a
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, .call_compute_note_pitch_write_nr32
    call ComputeNotePitch_WriteSoundEventByte17AndNR30
    ld a, $80
    ldh [rNR30], a

.call_compute_note_pitch_write_nr32:
    push hl
    call ComputeNotePitch_WriteNR32
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
    jr c, .set_snd_freq_lo_to_02
    cp a, $FE
    jr c, .set_snd_freq_lo
    ld a, $FD
    jr .set_snd_freq_lo

.set_snd_freq_lo_to_02:
    ld a, $02

.set_snd_freq_lo:
    ldh [hSndFreqLo], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, ComputeNotePitch_Skip
    cp a, $02
    jr nc, ComputeNotePitch_Loop
    ldh a, [hSndDutyAndTempo]
    and a, $C0
    or a, $3F
    ld c, $11
    call WriteChannelRegisterC

ComputeNotePitch_Loop::
Jump_000_3989:: ; address name
    ld a, h
    and a, $07
    or a, $80

ComputeNotePitch_SetSndFreqHi::
Jump_000_398E:: ; address name
    ldh [hSndFreqHi], a
    ld c, $14
    call WriteChannelRegisterC
    call ClearChannelLengthBits

ComputeNotePitch_ReadSoundTickByte0C::
Jump_000_3998:: ; address name
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

ComputeNotePitch_Skip::
Jump_000_39AB:: ; address name
    xor a, a
    ldh [rNR31], a
    ldh a, [rNR52]
    and a, $04
    jr z, ComputeNotePitch_Loop
    ld a, h
    and a, $07
    jr ComputeNotePitch_SetSndFreqHi

; only called from SoundTick (E-0047)
; 1 call site from 1 routine (e.g. SoundTick)
; reads: wSoundHwChannel, hSndPitchSlide, hSndEnvelope, hSndPitchSlideTime, wSoundRegBase, hSndFreqHi
; writes: hSndPitchSlideCounter, hSndEnvelope
; points at: hSndPitchSlideCounter, hSndPitchSlide
SoundTick_WaitSoundHwChannel::
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
    jr nz, .skip
    dec [hl]
    ld a, b
    cp a, $0F
    ret z
    ldh a, [hSndEnvelope]
    add a, $10
    ldh [hSndEnvelope], a
    jp WriteChannelEnvelopeIfChanged

.skip:
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
SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB::
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
    ld hl, SoundPitchOffsetRows
    add hl, de
    ldh a, [hSndFreqLo]
    add a, [hl]
    ld c, $13
    jr WriteChannelRegisterC

; only called from ComputeNotePitch (E-0047)
; 1 call site from 1 routine (e.g. ComputeNotePitch)
; reads: wSoundHwChannel, hSndVibratoDepth, hSndEnvelope, wSoundRegBase, hSndFreqHi, hSndVibratoDelay, hSndVibratoCounter, hSndA8Param
; writes: rNR32
; points at: hSndEnvelope
ComputeNotePitch_WriteNR32::
Func_000_3A21:: ; address name
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, WriteChannelRegisterC_ReadSndEnvelope
    ldh a, [hSndVibratoDepth]
    and a, a
    jr nz, SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05_CheckSndVibratoDelay
    ldh a, [hSndEnvelope]

; B = A (bit 3 set when the low three bits are 0); writes it to the channel envelope register (wDD0D + $12) only if it differs, then restarts the channel (E-0124)
; 2 call sites from 2 routines (e.g. SoundNextEvent, SoundTick)
; reads: wSoundRegBase, hSndFreqHi
WriteChannelEnvelopeIfChanged::
Func_000_3A2F:: ; address name
    ld b, a
    and a, $07
    jr nz, .read_sound_reg_base
    ld a, b
    or a, $08
    ld b, a

.read_sound_reg_base:
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
; 5 call sites from 2 routines (e.g. ComputeNotePitch, WriteChannelEnvelopeIfChanged)
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

WriteChannelRegisterC_ReadSndEnvelope::
Jump_000_3A57:: ; address name
    ldh a, [hSndEnvelope]
    ld c, $12
    jr WriteChannelRegisterC

; [$FF00 + wDD0D + $11] &= $C0: keeps the duty bits of the current channel's length/duty register and clears its length (E-0114)
; 2 call sites from 2 routines (e.g. ComputeNotePitch, WriteChannelEnvelopeIfChanged)
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

ClearChannelLengthBits_Skip::
Jump_000_3A69:: ; address name
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
SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05::
Func_000_3A7A:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ldh a, [hSndFreqLo]
    and a, a
    jr nz, .check_sound_hw_channel
    ldh a, [hSndFreqHi]
    and a, $7F
    jp z, SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub01

.check_sound_hw_channel:
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05_CheckSndVibratoDelay
    ldh a, [hSndVibratoDepth]
    and a, a
    ret z

SoundTick_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub05_CheckSndVibratoDelay::
Jump_000_3A94:: ; address name
    ldh a, [hSndVibratoDelay]
    and a, a
    ret z
    ld e, $00
    ld c, a
    ldh a, [hSndVibratoCounter]
    ld b, $04

.loop:
    add a, a
    cp a, c
    jr c, .skip
    sub a, c

.skip:
    ccf
    rl e
    dec b
    jr nz, .loop
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, ClearChannelLengthBits_Skip
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
    jr nz, .skip4
    inc b
    ld a, c
    swap a
    and a, $0F
    jr z, .skip4
    ld b, a
    bit 3, e
    jr nz, .skip2
    sla b
    bit 2, e
    jr nz, .skip2
    sla b
    bit 1, e
    jr z, .skip3

.skip2:
    ld a, b
    cp a, $08
    jr c, .skip4

.skip3:
    ld b, $00

.skip4:
    bit 1, h
    jr z, .skip5
    ld a, b
    jr z, .skip5
    srl b

.skip5:
    ld a, h
    and a, $08
    or a, b
    ld b, a
    bit 0, h
    jr z, .read_sound_reg_base
    ld hl, SoundEnvelopeScaleTable
    add hl, de
    ld a, [hl]
    or a, b
    jp WriteChannelEnvelopeIfChanged

.read_sound_reg_base:
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
    ld hl, SoundEnvelopeScaleTable
    add hl, de
    ld a, [hl]
    or a, b
    jp WriteChannelEnvelopeIfChanged

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundRegBase, hSndFreqHi
SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub01::
Func_000_3B39:: ; address name
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, $00
    jp WriteChannelEnvelopeIfChanged

; only called from SoundNextEvent (E-0047)
; 1 call site from 1 routine (e.g. SoundNextEvent)
; reads: wSoundSkipMaskB, wSoundEngineMode
; writes: wSoundEngineMode
SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB::
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
; 6 call sites from 6 routines (e.g. ComputeNotePitch, SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB_Sub01, SoundNextEvent, SoundNextEvent_ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB, ...)
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

; E-0209 (C2 for the use, from E-0019's matched formula: the note routine indexes $3B5C by the semitone, or $3B74 when $FFDE bit 4 is set; row 1 is the alternative tuning).
; record: 12 semitone periods (shifted right by the octave and subtracted from $0800)
SoundNotePeriodTable::
Data_000_3B5C:: ; address name
    dw $07D4, $0764, $06F9, $0695, $0637, $05DD, $0589, $053A, $04F0, $04A8, $0465, $0426 ; id 0
    dw $079C, $072E, $06C7, $0666, $060A, $05B3, $0561, $0515, $04CC, $0486, $0445, $0408 ; id 1

; E-0209 (C1: Jump_000_3A94.skip5 reads the byte at $3B8C + DE (DE = level row * 16 + input) and ORs it into the envelope written by WriteChannelEnvelopeIfChanged; the rows rise from all $10 to $00-$F0).
; record: 16 scaled volumes (high nibble) for one level
SoundEnvelopeScaleTable::
Data_000_3B8C:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $10, $10, $10, $10, $10, $10, $10, $10 ; id 1
    db $00, $00, $00, $00, $10, $10, $10, $10, $10, $10, $10, $10, $20, $20, $20, $20 ; id 2
    db $00, $00, $00, $10, $10, $10, $10, $10, $20, $20, $20, $20, $20, $30, $30, $30 ; id 3
    db $00, $00, $10, $10, $10, $10, $20, $20, $20, $20, $30, $30, $30, $30, $40, $40 ; id 4
    db $00, $00, $10, $10, $10, $20, $20, $20, $30, $30, $30, $40, $40, $40, $50, $50 ; id 5
    db $00, $00, $10, $10, $20, $20, $20, $30, $30, $40, $40, $40, $50, $50, $60, $60 ; id 6
    db $00, $00, $10, $10, $20, $20, $30, $30, $40, $40, $50, $50, $60, $60, $70, $70 ; id 7
    db $00, $10, $10, $20, $20, $30, $30, $40, $40, $50, $50, $60, $60, $70, $70, $80 ; id 8
    db $00, $10, $10, $20, $20, $30, $40, $40, $50, $50, $60, $70, $70, $80, $80, $90 ; id 9
    db $00, $10, $10, $20, $30, $30, $40, $50, $50, $60, $70, $70, $80, $90, $90, $A0 ; id 10
    db $00, $10, $10, $20, $30, $40, $40, $50, $60, $70, $70, $80, $90, $A0, $A0, $B0 ; id 11
    db $00, $10, $20, $20, $30, $40, $50, $60, $60, $70, $80, $90, $A0, $A0, $B0, $C0 ; id 12
    db $00, $10, $20, $30, $30, $40, $50, $60, $70, $80, $90, $A0, $A0, $B0, $C0, $D0 ; id 13
    db $00, $10, $20, $30, $40, $50, $60, $70, $70, $80, $90, $A0, $B0, $C0, $D0, $E0 ; id 14
    db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0 ; id 15

; E-0209 (C1: the routine before SoundNextEvent_Sub01 adds the byte at $3C8C + ((hSndChanFlags & $F0) - $10) + (wSoundTickBuf0E & $0F) to hSndFreqLo and writes it to register $13 of the channel; row 1 is the first; 15 rows end at SoundNextEvent_Sub04 ($3D7C)).
; record: 16 signed frequency offsets, one per tick phase
SoundPitchOffsetRows::
Data_000_3C8C:: ; address name
    db $00, $00, $01, $01, $00, $00, $FF, $FF, $00, $00, $01, $01, $00, $00, $FF, $FF ; id 1
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $FF, $FF, $FF, $FF ; id 2
    db $00, $01, $02, $01, $00, $FF, $FE, $FF, $00, $01, $02, $01, $00, $FF, $FE, $FF ; id 3
    db $00, $00, $01, $01, $02, $02, $01, $01, $00, $00, $FF, $FF, $FE, $FE, $FF, $FF ; id 4
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 5
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE ; id 6
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; id 7
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02 ; id 8
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15

; only called from ComputeNotePitch (E-0047)
; 1 call site from 1 routine (e.g. ComputeNotePitch)
; reads: wSoundEventByte17, hSndSweepOrWave, hSndA8Param
; writes: wSoundEventByte17, rNR30
ComputeNotePitch_WriteSoundEventByte17AndNR30::
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
SoundTick_ReadSndA8Param::
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

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
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
SoundTick_WriteSndEnvelopeReloadAndSndEnvelope::
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

.loop:
    ld a, e
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    dec d
    jr nz, .loop
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
    jr nz, .read_snd_envelope
    ld c, $01

.read_snd_envelope:
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
    db $00 ; entry 0: first sound id of this range
    dfar SoundRecords_Bank40 ; record array in that bank
    db $1C ; entry 1: first sound id of this range
    dfar SoundRecords_Bank41 ; record array in that bank
    db $31 ; entry 2: first sound id of this range
    dfar SoundRecords_Bank42 ; record array in that bank
    db $A8 ; entry 3: first sound id of this range
    dfar SoundRecords_Bank43 ; record array in that bank
    db $FF, $FF

; A = slot: returns carry set when the slot is absent (CarryUnlessBattleSlotOutSlotEmpty) or when status +0 & $D0, +3 & $3F, +5 & $C0 or +8 bit 3 is set (wBattleStatus + 9 * slot); otherwise carry clear; A, BC, HL kept (E-0058)
; 39 call sites from 36 routines (e.g. UnreferencedEstimateStrongestFoeHit, FailIfAbleAllyKnowsSkill42To47, CheckSlotStatusBlockWide_Bank05, FailIfAbleAllyKnowsSkillList6D1A, ...)
; points at: wBattleStatus
CheckSlotStatusBlock::
Func_000_3E25:: ; address name
    push hl
    push bc
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $D0
    jr nz, .set_carry
    inc hl
    inc hl
    ld a, [hl+]
    and a, $3F
    jr nz, .set_carry
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, .set_carry
    inc hl
    inc hl
    bit 3, [hl]
    jr nz, .set_carry
    xor a, a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot number; returns with carry clear only when A < 8 and wDA63[A] is zero (carry set for A >= 8, for $FF and for any other non-zero value); A, BC and HL are preserved
; 290 call sites from 244 routines (e.g. CheckSlotStatusBlock, AnySlotLacksStatusMask, FoeHPCheckReadsWrongSlot, CheckFoeStatus7Bit2, ...)
; points at: wBattleSlotOut
CarryUnlessBattleSlotOutSlotEmpty::
Func_000_3E54:: ; address name
    push hl
    push bc
    ld c, a
    cp a, $08
    jr nc, .skip
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, .skip2
    cp a, $FF
    jr z, .skip
    scf
    jr .skip3

.skip:
    xor a, a
    scf
    jr .skip3

.skip2:
    ld a, $0A
    cp a, $01

.skip3:
    ld a, c
    pop bc
    pop hl
    ret

; Z set when HL == BC; A is clobbered
; 181 call sites from 119 routines (e.g. RandomInRange, DebugMonsterRecordViewer_Update, ClampDebugValueToTableLimit, UnreferencedEstimateStrongestFoeHit, ...)
CompareHLToBC::
Func_000_3E7A:: ; address name
    ld a, h
    cp a, b
    ret nz
    ld a, l
    cp a, c
    ret

; CompareHLToBC with shortcuts when BC or HL is zero: equal zeros give A = 0 and NC, HL = 0 < BC gives carry (E-0124)
; 5 call sites from 4 routines (e.g. AIGateCompareAllyStatAverages, ChooseTarget_MegaMagic, ChooseTarget_Beat, ChooseTarget_Blaze)
CompareHLToBCFastZero::
Func_000_3E80:: ; address name
    ld a, b
    or a, c
    jr nz, .skip
    ld a, h
    or a, l
    jr nz, .done
    xor a, a
    scf
    ccf
    ret

.done:
    scf
    ccf
    ret

.skip:
    ld a, h
    or a, l
    jr nz, CompareHLToBC
    ld a, $01
    or a, a
    scf
    ret

; HL = minimum, BC = maximum: returns DE = minimum + (random mod (maximum - minimum + 1)), the random value being wC5E8:wC5E7 after AdvanceRandom; DE = HL when the two are equal (73 call sites)
; 19 call sites from 16 routines (e.g. RunBattleCommandEntry_Case04_AdvanceRandom, AddRandomWeightByValueBand, RollDamageBaseToBasePlusBattleArg2, ComputeBasicDamage, ...)
; reads: wRandomLo, wRandomHi
RandomInRange::
Func_000_3E98:: ; address name
    call CompareHLToBC
    jr z, .done
    ld a, h
    or a, l
    jr z, .skip
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

.skip:
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
    jr .return

.done:
    ld e, a
    ld d, h

.return:
    ret

; when wC58A is 0 calls NextTableByte (wC5E8 = index, wC5E7 = table byte); in link mode runs the same step on the synchronised copy in wC5BA/wC5BB
; 77 call sites from 61 routines (e.g. RandomInRange, ChooseHighestWeightedAction, AddSkillBaseWeightAndLoadSkill_AdvanceRandom, AIPickRandomSkillOfKind3, ...)
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
; 4 call sites from 4 routines (e.g. RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty, RunBattleCommandEntry_BankA1_Case04_WriteRecordBufferAndBattleArg0Etc, RunBattleCommandEntry_BankA1_Case04_RandomInRange, RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case01)
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
    jr z, .call_divide_hl_by_a

.skip:
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, .skip2
    inc de
    jr .skip

.call_divide_hl_by_a:
    ld a, c
    call DivideHLByA
    ld c, a
    ld b, $00
    jr .return

.skip2:
    add hl, bc
    ld b, h
    ld c, l
    ld h, d
    ld l, e

.return:
    ret

; HL += (A * 9) & $FF (the product is computed in 8 bits and wraps); A is clobbered, other registers preserved
; 320 call sites from 265 routines (e.g. CheckSlotStatusBlock, FailIfAbleAllyKnowsSkill42To47, SlotHasStatus3Or4Bits_Bank05, CheckSlotStatusBlockWide_Bank05, ...)
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
; 17 call sites from 17 routines (e.g. RecomputeTargetMaxHPAndMP, ActionEffect_Transform_Sub01_BattlerRecordFieldAddress_Sub04, ActionEffect_Transform_Sub01_BattlerRecordFieldAddress, RecomputeTargetStatsFromRecord, ...)
; points at: wBattlerRecords
BattlerRecordFieldAddress::
Func_000_3F32:: ; address name
    cp a, $03
    jr c, .call_multiply8
    dec a

.call_multiply8:
    ld c, $4E
    call Multiply8
    ld bc, wBattlerRecords
    add hl, bc
    ld a, e
    add_a_to_hl
    ret

; Z set when A equals the queued action (wQueuedActionId, wDAAC) or is its partner in one of the pairs $34-$AD, $35-$AE, $6A-$CC, $A1-$CF, $8F-$AA (the pairs are symmetric); Z clear otherwise. A and BC are kept (E-0049)
; 3 call sites from 3 routines (e.g. SkillPassesRepeatCheck, CheckSkillMPCost, RunBattleActions_StatusChecks_Case01_QueuedActionMatches)
; reads: wQueuedActionId
QueuedActionMatches::
Func_000_3F47:: ; address name
    push bc
    push af
    ld a, [wQueuedActionId]
    ld c, a
    pop af
    cp a, c
    jr nz, .cp_34

.loop:
    pop bc
    ret

.cp_34:
    cp a, $34
    jr nz, .cp_AD
    ld a, $AD
    cp a, c
    jr .loop

.cp_AD:
    cp a, $AD
    jr nz, .cp_35
    ld a, $34
    cp a, c
    jr .loop

.cp_35:
    cp a, $35
    jr nz, .cp_AE
    ld a, $AE
    cp a, c
    jr .loop

.cp_AE:
    cp a, $AE
    jr nz, .cp_6A
    ld a, $35
    cp a, c
    jr .loop

.cp_6A:
    cp a, $6A
    jr nz, .cp_CC
    ld a, $CC
    cp a, c
    jr .loop

.cp_CC:
    cp a, $CC
    jr nz, .cp_A1
    ld a, $6A
    cp a, c
    jr .loop

.cp_A1:
    cp a, $A1
    jr nz, .cp_CF
    ld a, $CF
    cp a, c
    jr .loop

.cp_CF:
    cp a, $CF
    jr nz, .cp_8F
    ld a, $A1
    cp a, c
    jr .loop

.cp_8F:
    cp a, $8F
    jr nz, .cp_AA
    ld a, $AA
    cp a, c
    jr .loop

.cp_AA:
    cp a, $AA
    jr nz, .loop
    ld a, $8F
    cp a, c
    jr .loop
    ds $53, $00
