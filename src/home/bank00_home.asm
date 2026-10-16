; ROM bank $00: home bank: boot, main loop, interrupts, bank switching, text printer, sound driver
; The annotated listing of this bank is build/listing/bank00.asm.

SECTION "Bank 00", ROM0[$0000]

; The rst $00 dispatcher behind the jumptable macro (507 uses in src/): pops the return address as
; the base of the dw list that follows the rst, adds 2 * A as a 16-bit offset (so all 256 values of
; A index the list), keeps DE, and falls into JumpToWordAtHL, which jumps to that entry with HL =
; the entry address and A = its low byte. There is no range check: an A past the end of the list
; reads whatever bytes follow. The dfar JumpTable entries of MonsterAttributeMapTable are zero
; pointers (no attribute map), not uses. (C1, E-0373)
JumpTable::
    pop hl
    push de
    ld e, a
    ld d, $00
    sla e
    rl d
    add hl, de
    pop de

; HL = address of a word: loads HL = that word (A = its low byte) and falls into JumpToHL, which
; jumps to it. JumpTable ends here, and 7 battle routines call it to run a handler read from a table
; so that the handler returns to them (CallFlagBitHandlerE, RunEffectHandlerForActionId,
; DispatchActionEffectTable, ChooseActionTarget and others). (C1, E-0373)
; HL = address of a word: HL = that word, then jumps to it (falls into JumpToHL); A = its low byte
; (E-0061)
JumpToWordAtHL::
    deref_hl

; jp hl. A call to it calls the routine at HL: CallInBank uses it that way, as do AIRunNextChoice,
; AIChooseActionResolveStep, AIChooseActionForActor and TargetFoeWithStatAboveOne. The $00 byte
; after it pads to CallInBank at $0010. (C1, E-0373)
; jp hl; the call target used by CallInBank
JumpToHL::
    jp hl
    db $00

; The rst $10 far call behind the farcall and farcall_b macros (B = ROM bank, HL = routine). Saves
; the number of the mapped switchable bank (read from BANK_NUMBER_BYTE, $4000), maps bank B, calls
; HL through JumpToHL, then maps the saved bank again. BC, DE and HL come back as the callee left
; them, but A and the flags do not: pop af returns A = the saved bank number and the flags as they
; were on entry. $10 zero bytes pad to $0030. (C1, E-0373)
CallInBank::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    call JumpToHL
    pop af
    ld [rROMB0], a
    ret
    ds $10, $00

; The rst $30 restart: a bare ret, then 7 zero bytes of padding to $0038. No rst $30 appears in
; src/. (C2, E-0373; probed E-0375)
; the rst $30 vector: a bare ret (unused restart) (E-0114)
Rst30Vector::
    ret
    db $00, $00, $00, $00, $00, $00, $00

; The rst $38 restart: a bare ret, then 7 zero bytes of padding to the VBlank vector at $0040. No
; rst $38 appears in src/. (C2, E-0373; probed E-0375)
; the rst $38 vector: a bare ret (unused restart) (E-0114)
Rst38Vector::
    ret
    db $00, $00, $00, $00, $00, $00, $00

; The VBlank interrupt vector ($0040): di, then jp VBlankHandler; 4 zero bytes pad to $0048.
; VBlankHandler turns interrupts back on part way through and returns with reti. (C1, E-0373)
; di; jp VBlankHandler (the interrupt vector at $0040)
VBlankVector::
    di
    jp VBlankHandler
    db $00, $00, $00, $00

; The LCD STAT interrupt vector ($0048): jp StatInterruptHandler, which runs the scroll split chosen
; by wSTATSplitEnable. 13 zero bytes pad to $0058; the timer vector $0050 lies inside them, so a
; timer interrupt would run them as nops into SerialInterruptVector. (C1, E-0373)
; the LCD STAT interrupt vector ($0048): jumps to the handler at StatInterruptHandler (E-0114)
StatInterruptVector::
    jp StatInterruptHandler
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; The serial interrupt vector ($0058): jp SerialInterruptHandler, which saves the registers,
; far-calls RunLinkSession and returns with reti. A $D9 byte (reti, never reached) and $24 zero
; bytes follow up to InstallOamDmaRoutine at $0080; the joypad vector $0060 lies inside that
; padding. (C1, E-0373)
; the serial-transfer interrupt vector ($0058): jumps to the handler at SerialInterruptHandler
; (E-0114)
SerialInterruptVector::
    jp SerialInterruptHandler
    db $d9
    ds $24, $00

; Copies the 10 bytes of OamDmaRoutineTemplate ($008E-$0097) to hOAMDMARoutine ($FF80-$FF89), one
; byte at a time with ldh [c], a; returns B = 0, C = $8A, HL = $0098. Called once by
; BootAndMainLoop_StartUp, after ClearWRAMHRAMAndSRAMBanks0And2. (Hardware: during an OAM DMA the
; CPU can only run code in HRAM, which is why the routine is copied there.) (C2, E-0373)
; copies the 10 bytes at $008E (ld a,$C0 / ldh [rDMA],a / wait / ret) to HRAM at $FF80
InstallOamDmaRoutine::
    ld c, $80
    ld b, $0a
    ld hl, $008e

.loop:
    ld a, [hli]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop
    ret

; The OAM DMA routine kept as bytes: ld a, $C0 / ldh [rDMA], a starts a DMA of $C000 (wShadowOAM) to
; OAM, a $28-pass dec a loop waits for it, then ret. It never runs here: InstallOamDmaRoutine copies
; it to hOAMDMARoutine, which VBlankHandler calls each frame. $68 zero bytes pad to the entry point
; at $0100. (C1, E-0373)
; the OAM DMA routine copied to HRAM: starts DMA from $C000 (ld a, $C0; ldh [rDMA], a) and waits $28
; loop iterations; never called in place (E-0122)
OamDmaRoutineTemplate::
    ld a, $c0
    ldh [rDMA], a
    ld a, $28

.loop:
    dec a
    jr nz, .loop
    ret
    ds $68, $00

; The cartridge entry point ($0100), where the boot ROM hands over: nop, then jp BootAndMainLoop.
; The cartridge header (CartridgeHeader) follows at $0104. (C1, E-0373)
; the cartridge entry point ($0100): nop, then jp BootAndMainLoop (E-0114)
ROMEntryPoint::
    nop
    jp BootAndMainLoop

; E-0239 (HARDWARE: the standard Game Boy cartridge header layout; the byte values are those of the
; reference ROM and are kept exactly, checksums included; ASCII fields are written as numbers
; because charmap.inc maps letters to the game's encoding).
; record: cartridge header $0104-$014F, one field per line: Nintendo logo (3 lines); title "DWM2-C"
; padded with $00; manufacturer "BQLE"; CGB flag $80; new licensee "B4"; SGB flag $03; cartridge
; type $1B (MBC5 + RAM + battery); ROM size $07 (4 MiB); RAM size $03 (32 KiB); destination $01
; (overseas); old licensee $33 (use the new code); version $00; header checksum; global checksum
; (big-endian)
CartridgeHeader::
    db $ce, $ed, $66, $66, $cc, $0d, $00, $0b, $03, $73, $00, $83, $00, $0c, $00, $0d ; id 0: Nintendo logo bytes 0-15
    db $00, $08, $11, $1f, $88, $89, $00, $0e, $dc, $cc, $6e, $e6, $dd, $dd, $d9, $99 ; Nintendo logo bytes 16-31
    db $bb, $bb, $67, $63, $6e, $0e, $ec, $cc, $dd, $dc, $99, $9f, $bb, $b9, $33, $3e ; Nintendo logo bytes 32-47
    db $44, $57, $4d, $32, $2d, $43, $00, $00, $00, $00, $00 ; title, ASCII "DWM2-C" padded with $00
    db $42, $51, $4c, $45 ; manufacturer code, ASCII "BQLE"
    db $80 ; CGB flag ($80 = CGB features, also runs on DMG)
    db $42, $34 ; new licensee code, ASCII "B4"
    db $03 ; SGB flag ($03 = SGB functions)
    db $1b ; cartridge type ($1B = MBC5 + RAM + battery)
    db $07 ; ROM size ($07 = 4 MiB, 256 banks)
    db $03 ; RAM size ($03 = 32 KiB)
    db $01 ; destination ($01 = overseas)
    db $33 ; old licensee ($33 = use the new licensee code)
    db $00 ; version ($00)
    db $e7 ; header checksum (as stored)
    db $85, $9e ; global checksum, big-endian (as stored)

; Where ROMEntryPoint jumps: wIsCGB = 1 when A was $11 on entry (the value the CGB boot ROM leaves
; in A, a hardware fact), else 0; then falls into BootAndMainLoop_StartUp, which masks interrupts,
; sets the stack, clears RAM, installs the OAM DMA routine, clears VRAM, sets game mode 5 and the
; MBC banks and runs the main loop. The resets (VBlankHandler, LinkExchangeJoypadPerFrame) jump to
; BootAndMainLoop_StartUp instead, and ClearWRAMHRAMAndSRAMBanks0And2 keeps wIsCGB, so it is set
; only here. (C1, E-0373)
; entry after the header jump: wIsCGB = 1 when A was $11 at power-on; disables interrupts, sets the
; stack, clears RAM, installs the OAM DMA routine, clears VRAM, sets game mode 5 and the MBC banks,
; then runs the main loop (E-0131)
BootAndMainLoop::
    cp $11
    ld a, $00
    jr nz, .set_is_cgb
    inc a

.set_is_cgb:
    ld [wIsCGB], a

; Power-on start-up, then the main loop. Start-up: masks interrupts, clears WRAM, HRAM and SRAM
; banks 0 and 2, installs the OAM DMA routine, clears the tile area (and on CGB the BG map
; attributes in VRAM bank 1), selects game mode 5 (the title screen) and maps ROM and SRAM bank
; defaults. On CGB it loads palette 0; otherwise DetectSGB, and on a Super Game Boy it sends the
; start-up packet sets, transfers the border tiles and map, and sets the palettes. Every mode then
; starts here: clear the screen, sprites, scroll and fade, run the mode's start-up routine
; (RunGameModeInit), reset the frame counters. The loop halts until each interrupt (advancing the
; random table with NextTableByte when not linked); the per-frame work runs in VBlankHandler. When
; wModeChangeRequest is set and no fade is in progress (wFadeState 0 or bit 7 set), it masks
; interrupts, sends SGB packet set 0 and restarts at the screen clear for the new mode. (C1, E-0357)
BootAndMainLoop_StartUp::
    di
    ld sp, wStackTop
    call DisableVBlankTimerSerialJoypadInterrupts
    call ClearWRAMHRAMAndSRAMBanks0And2
    call InstallOamDmaRoutine
    ld hl, vTiles0
    ld bc, $1c00
    xor a
    call FillBytes
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0800
    xor a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
    ld hl, wGameMode
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
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
    ld a, $ff
    ld [wMusicRequest], a
    ld [wSoundEffectRequest], a
    call InitSoundHardware
    xor a
    ld [wLinkReady], a
    ld a, [wIsCGB]
    or a
    jr z, .call_detect_sgb
    xor a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rRP], a
    farcall LoadPalette0FromData_Bank02
    jr .clear_sgb_active

.call_detect_sgb:
    call DetectSGB
    jr c, .call_delay_bc_when_sgb

.clear_sgb_active:
    xor a
    ld [wSGBActive], a
    jp .call_clear_bg_map_or_fill_with_c3

.call_delay_bc_when_sgb:
    ld bc, $000c
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
    ld a, $0c
    ld bc, $0800
    ld e, $6c
    ld d, $44
    ld h, $17
    call SGBTransferRaw
    call SpinDelay
    ld a, $0d
    ld e, LOW(BootAndMainLoop_StartUp_Gfx)
    ld d, HIGH(BootAndMainLoop_StartUp_Gfx)
    ld b, BANK(BootAndMainLoop_StartUp_Gfx)
    call SGBTransferCompressed
    call SpinDelay
    ld a, $12
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $0a
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $13
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $0e
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ld a, $01
    ld [wSGBActive], a
    ld a, $ff
    ld [wSGBBorderSet], a
    xor a
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
    xor a
    ld [wSerialReceived], a
    ld [wTextFlags], a
    ld [wTextWindowRows], a
    ld [wTextWindowWidth], a
    call RunGameModeInit
    xor a
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
    xor a
    ld [wLinkFrameCounterLo], a
    ld [wLinkFrameCounterHi], a
    ld hl, wScreenShakeTimer
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a

.loop:
    ld a, [wLinkMode]
    or a
    call z, NextTableByte
    halt
    nop
    ld a, [wModeChangeRequest]
    or a
    jr z, .loop
    ld a, [wFadeState]
    or a
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

; Called by BootAndMainLoop_StartUp each time a mode starts (power-on, a reset, and every
; wModeChangeRequest): jumps through a 9-entry table by wGameMode to the start-up routine of the
; mode: 0 RunGameModeInit_DebugMenu, 1 RunGameModeInit_Field, 2 RunGameModeInit_PauseMenu, 3
; RunGameModeInit_None (returns at once), 4 RunGameModeInit_Battle, 5 RunGameModeInit_Title, 6
; RunGameModeInit_EggAndSaveScreens, 7 RunGameModeInit_LinkBattle, 8 RunGameModeInit_EggHandOver.
; The others far-call GameMode0_Init (bank $01), GameMode1_Init ($02), GameMode2_Init ($03),
; GameMode4_Init ($31), GameMode5_Init ($07), GameMode6_Init ($24), GameMode7_Init ($A0) and
; GameMode8_Init ($F2). wGameMode is not range-checked. (C1, E-0373)
; jumps through a 9-entry table indexed by wGameMode to the mode's start-up routine (banks $01, $02,
; $03, none, $31, $07, $24, $A0, $F2); called from the main loop each time the mode changes
RunGameModeInit::
    ld a, [wGameMode]
    jumptable
    dw RunGameModeInit_DebugMenu
    dw RunGameModeInit_Field
    dw RunGameModeInit_PauseMenu
    dw RunGameModeInit_None
    dw RunGameModeInit_Battle
    dw RunGameModeInit_Title
    dw RunGameModeInit_EggAndSaveScreens
    dw RunGameModeInit_LinkBattle
    dw RunGameModeInit_EggHandOver

; Game mode 0's start-up (the debug menu): far-calls GameMode0_Init in bank $01. (C1, E-0357)
RunGameModeInit_DebugMenu::
    farcall GameMode0_Init
    ret

; Game mode 1's start-up (the field: a map with the player): far-calls GameMode1_Init in bank $02.
; (C1, E-0357)
RunGameModeInit_Field::
    farcall GameMode1_Init
    ret

; Game mode 2's start-up (the pause menu's monster pages): far-calls GameMode2_Init in bank $03.
; (C1, E-0357)
RunGameModeInit_PauseMenu::
    farcall GameMode2_Init
    ret

; Game mode 3 has no start-up routine: returns at once. (C2, E-0357; probed E-0374)
RunGameModeInit_None::
    ret

; Game mode 4's start-up (the battle): far-calls GameMode4_Init in bank $31. (C1, E-0357)
RunGameModeInit_Battle::
    farcall GameMode4_Init
    ret

; Game mode 5's start-up (the title screen): far-calls GameMode5_Init in bank $07. (C1, E-0357)
RunGameModeInit_Title::
    farcall GameMode5_Init
    ret

; Game mode 6's start-up (the egg and save screens after a link or the priest): far-calls
; GameMode6_Init in bank $24. (C1, E-0357)
RunGameModeInit_EggAndSaveScreens::
    farcall GameMode6_Init
    ret

; Game mode 7's start-up (the linked battle: RunLinkSession6Exchange_FightInfo_StartLinkBattle and
; HatchingScene_RunEggScreens switch to this mode, and GameMode7_Update runs
; LinkExchangeJoypadPerFrame and RunBattleEffectAnimation each frame): far-calls GameMode7_Init in
; bank $A0. (C1, E-0369)
RunGameModeInit_LinkBattle::
    farcall GameMode7_Init
    ret

; Game mode 8's start-up (the egg hand-over scene): far-calls GameMode8_Init in bank $F2. (C1,
; E-0357)
RunGameModeInit_EggHandOver::
    farcall GameMode8_Init
    ret

; The VBlank interrupt handler (entered from VBlankVector with interrupts off). Saves AF, BC, DE,
; HL, rSVBK and rVBK and writes 0 to rSVBK (WRAM bank 1). If bit 0 of wVBlankFlags is already set (a
; VBlank came while the previous handler was still running) it only runs WriteLCDCShadow and
; SoundTick. Otherwise it sets the bit, runs the OAM DMA (hOAMDMARoutine) and, on CGB with
; wFadeState 0, uploads the queued palettes (UploadBGPalettes when wBGPaletteUploadRequest is
; non-zero, VBlankHandler_UploadOBJPalettes when wOBJPaletteUploadRequest is, clearing both); then
; FlushQueuedBGMapWrite, CopyDMGPalettesToHardware, CopyScrollToHardware, ApplyScreenShake and
; WriteLCDCShadow. Not linked (wLinkMode 0) it re-enables interrupts and runs PollJoypad,
; UpdateJoypadPresses, SoundTick, NextRandomSeed, ProcessSoundQueue, GameFrameUpdate,
; StepTextPrinter (when wTextFlags is non-zero) and StepFade, and adds 1 to the 16-bit
; wFrameCounterLo/Hi; linked it runs only SoundTick, ProcessSoundQueue and GameFrameUpdate. Then,
; when wFadeState is 0, wLinkMode is 0 and A, B, Select and Start (the low nibble of wJoypadHeld)
; are all held, it resets by jumping to BootAndMainLoop_StartUp. Otherwise it clears bit 0 of
; wVBlankFlags, restores rVBK, saves rLY in wVBlankLY, restores rSVBK and the registers and returns
; with reti. (C1, E-0373)
; runs once per frame: saves registers and the VRAM and WRAM banks; skips everything but the sound
; tick when wVBlankFlags bit 0 shows it was entered again; otherwise runs the OAM DMA routine at
; $FF80, uploads queued palettes on CGB, flushes the queued BG map write, restores the DMG palettes,
; scroll and LCDC, applies the screen shake, polls the joypad, runs SoundTick, advances the random
; seed, processes the sound queue, runs GameFrameUpdate, steps the string display when wTextFlags is
; set, steps the fade, and increments the 16-bit frame counter wFrameCounterLo/wFrameCounterHi;
; resets the game when all four buttons are held
VBlankHandler::
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
    call hOAMDMARoutine
    ld a, [wIsCGB]
    or a
    jr z, .call_flush_queued_bg_map_write
    ld a, [wFadeState]
    or a
    jr nz, .call_flush_queued_bg_map_write
    ld hl, wBGPaletteUploadRequest
    ld a, [hl]
    inc hl
    or [hl]
    jr z, .call_flush_queued_bg_map_write
    ld a, [wBGPaletteUploadRequest]
    or a
    call nz, UploadBGPalettes
    xor a
    ld [wBGPaletteUploadRequest], a
    ld a, [wOBJPaletteUploadRequest]
    or a
    call nz, VBlankHandler_UploadOBJPalettes
    xor a
    ld [wOBJPaletteUploadRequest], a

.call_flush_queued_bg_map_write:
    call FlushQueuedBGMapWrite
    call CopyDMGPalettesToHardware
    call CopyScrollToHardware
    call ApplyScreenShake
    call WriteLCDCShadow
    ld a, [wLinkMode]
    and a
    jr nz, .call_sound_tick
    ei
    call PollJoypad
    call UpdateJoypadPresses
    call SoundTick
    call NextRandomSeed
    call ProcessSoundQueue
    call GameFrameUpdate
    ld a, [wTextFlags]
    or a
    call nz, StepTextPrinter
    call StepFade
    ld a, [wFrameCounterLo]
    add $01
    ld [wFrameCounterLo], a
    ld a, [wFrameCounterHi]
    adc $00
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
    or a
    jr nz, .skip
    ld a, [wJoypadHeld]
    and $0f
    cp $0f
    jr nz, .check_link_mode
    ld a, [wLinkMode]
    or a
    jp z, BootAndMainLoop_StartUp

.check_link_mode:
    ld a, [wLinkMode]
    or a
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

; The game work of one frame, called by VBlankHandler (in its linked and unlinked paths):
; hOamNextEntry = 0, ComputeSpriteScrollOffsets, RunGameModeUpdate, then ClearUnusedOAMEntries,
; except when wFadeState is non-zero with bit 7 clear (a fade in progress), when it returns without
; clearing the unused sprite entries. (C1, E-0373)
; hOamNextEntry = 0, ComputeSpriteScrollOffsets, RunGameModeUpdate, and ClearUnusedOAMEntries unless
; a fade is running
GameFrameUpdate::
    xor a
    ldh [hOamNextEntry], a
    call ComputeSpriteScrollOffsets
    call RunGameModeUpdate
    ld a, [wFadeState]
    or a
    jr z, .call_clear_unused_oam_entries
    bit 7, a
    ret z

.call_clear_unused_oam_entries:
    call ClearUnusedOAMEntries
    ret

; Called by GameFrameUpdate each frame. Returns at once when wModeChangeRequest is non-zero; not
; linked (wLinkMode 0) it also returns while wFadeState is non-zero with bit 7 clear, but when
; linked a fade does not stop it. Otherwise jumps through a 9-entry table by wGameMode to the frame
; routine of the mode: 0 RunGameModeUpdate_DebugMenu, 1 RunGameModeUpdate_Field, 2
; RunGameModeUpdate_PauseMenu, 3 RunGameModeUpdate_None (returns at once), 4
; RunGameModeUpdate_Battle, 5 RunGameModeUpdate_Title, 6 RunGameModeUpdate_EggAndSaveScreens, 7
; RunGameModeUpdate_LinkBattle, 8 RunGameModeUpdate_EggHandOver; the others far-call
; GameMode0_Update, GameMode1_Update, GameMode2_Update, GameMode4_Update, GameMode5_Update,
; GameMode6_Update, GameMode7_Update and GameMode8_Update. (C1, E-0373)
; unless wModeChangeRequest is non-zero or a fade is running: jumps through a 9-entry table indexed
; by wGameMode to the mode's per-frame routine (modes 0-8 in banks $01, $02, $03, none, $31, $07,
; $24, $A0, $F2)
RunGameModeUpdate::
    ld a, [wModeChangeRequest]
    or a
    ret nz
    ld a, [wLinkMode]
    or a
    jr nz, .read_game_mode
    ld a, [wFadeState]
    or a
    jr z, .read_game_mode
    bit 7, a
    ret z

.read_game_mode:
    ld a, [wGameMode]
    jumptable
    dw RunGameModeUpdate_DebugMenu
    dw RunGameModeUpdate_Field
    dw RunGameModeUpdate_PauseMenu
    dw RunGameModeUpdate_None
    dw RunGameModeUpdate_Battle
    dw RunGameModeUpdate_Title
    dw RunGameModeUpdate_EggAndSaveScreens
    dw RunGameModeUpdate_LinkBattle
    dw RunGameModeUpdate_EggHandOver

; Game mode 0's frame (the debug menu): far-calls GameMode0_Update. (C1, E-0357)
RunGameModeUpdate_DebugMenu::
    farcall GameMode0_Update
    ret

; Game mode 1's frame (the field): far-calls GameMode1_Update. (C1, E-0357)
RunGameModeUpdate_Field::
    farcall GameMode1_Update
    ret

; Game mode 2's frame (the pause menu): far-calls GameMode2_Update. (C1, E-0357)
RunGameModeUpdate_PauseMenu::
    farcall GameMode2_Update
    ret

; Game mode 3 has no per-frame routine: returns at once. (C2, E-0357; probed E-0374)
RunGameModeUpdate_None::
    ret

; Game mode 4's frame (the battle): far-calls GameMode4_Update. (C1, E-0357)
RunGameModeUpdate_Battle::
    farcall GameMode4_Update
    ret

; Game mode 5's frame (the title screen and link set-up): far-calls GameMode5_Update. (C1, E-0357)
RunGameModeUpdate_Title::
    farcall GameMode5_Update
    ret

; Game mode 6's frame (the egg and save screens): far-calls GameMode6_Update. (C1, E-0357)
RunGameModeUpdate_EggAndSaveScreens::
    farcall GameMode6_Update
    ret

; Game mode 7's frame (the linked battle; see RunGameModeInit_LinkBattle): far-calls
; GameMode7_Update. (C1, E-0369)
RunGameModeUpdate_LinkBattle::
    farcall GameMode7_Update
    ret

; Game mode 8's frame (the egg hand-over scene): far-calls GameMode8_Update. (C1, E-0357)
RunGameModeUpdate_EggHandOver::
    farcall GameMode8_Update
    ret

; Shakes the screen; called by VBlankHandler right after CopyScrollToHardware. Its early exit ORs
; wScreenShakeOffset with A as it arrives (hWindowY, left by CopyScrollToHardware), not with
; wScreenShakeTimer, which it loads into B and never uses: it returns at once when both are 0. When
; wScreenShakeTimer is non-zero it decrements it and adds to rSCY an offset from the new count t: 2t
; & 7, XORed with 7 when bit 2 of t is clear (so 7, 5, 3, 1 or 0, 2, 4, 6). When wScreenShakeOffset
; is non-zero it decrements it and adds the same kind of offset minus 4 to rSCX. The offsets go on
; top of the scroll just written, for this frame only. The 4 bytes after its ret (call
; FlushQueuedBGMapWrite / ret) are never reached. (C1, E-0373)
; while wScreenShakeTimer or wScreenShakeOffset is non-zero, counts it down and adds an oscillating
; offset (from the counter's low bits) to rSCY or rSCX
ApplyScreenShake::
    ld hl, wScreenShakeTimer
    ld b, [hl]
    inc hl
    or [hl]
    ret z
    ld a, [wScreenShakeTimer]
    or a
    jr z, .check_screen_shake_offset2
    dec a
    ld [wScreenShakeTimer], a
    ldh a, [rSCY]
    ld b, a
    ld a, [wScreenShakeTimer]
    add a
    ld c, a
    and $07
    bit 3, c
    jr nz, .check_screen_shake_offset
    xor $07

.check_screen_shake_offset:
    add b
    ldh [rSCY], a

.check_screen_shake_offset2:
    ld a, [wScreenShakeOffset]
    or a
    jr z, .return
    dec a
    ld [wScreenShakeOffset], a
    ldh a, [rSCX]
    ld b, a
    ld a, [wScreenShakeOffset]
    add a
    ld c, a
    and $07
    bit 3, c
    jr nz, .skip
    xor $07

.skip:
    sub $04
    add b
    ldh [rSCX], a

.return:
    ret
    db $cd, $cc, $0b, $c9

; The per-frame link step of the link modes (8 call sites: GameMode5_Update_ExchangeJoypadOnRecords,
; GameMode5_Update_ExchangeJoypad, GameMode5_Update_LinkSession and another bank $07 step,
; GameMode4_Update, GameMode7_Update, ExchangeJoypadAndDrawMonsters, ExchangeJoypadAndDrawSprites).
; Returns at once when wLinkMode is 0. Adds 1 to the 16-bit wLinkFrameCounterLo/Hi and resets the
; game (jp BootAndMainLoop_StartUp) once the high byte is non-zero, that is after 256 calls without
; the counter being cleared (RunFrameTickFadeAndCounter_Bank1B clears it). Returns when bit 1 of
; wLinkRole is set. With wLinkSession 5 it returns while bit 1 of wVBlankFlags is set; with other
; sessions, bit 1, 2 or 7 of wVBlankFlags set clears wLinkSavedJoypadHeld and
; wLinkSavedJoypadHeldPrev and returns. Otherwise it copies wJoypadHeld and wJoypadHeldPrev to
; wLinkSavedJoypadHeld/Prev, runs PollJoypad, sets wLinkExchangeState = 0 and starts an
; internal-clock transfer (StartSerialTransferInternalClock) of: wLinkSendByte when it is not $FF;
; else, while the 16-bit count wLinkBufferCountLo/Hi is non-zero, the byte at the address held in
; wLinkTimeoutLo/Hi, which it then advances by 1 (the count is not changed here); else $F0. (C1,
; E-0373)
; in link mode: counts frames (resetting the game after an overflow), saves the joypad state and
; starts the next serial transfer of the queued byte or the joypad (E-0128)
LinkExchangeJoypadPerFrame::
    ld a, [wLinkMode]
    or a
    ret z
    ld a, [wLinkFrameCounterLo]
    add $01
    ld [wLinkFrameCounterLo], a
    ld a, [wLinkFrameCounterHi]
    adc $00
    ld [wLinkFrameCounterHi], a
    or a
    jp nz, BootAndMainLoop_StartUp
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld a, [wLinkSession]
    cp $05
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
    xor a
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
    cp $ff
    jr z, .skip
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, [wLinkSendByte]
    jp StartSerialTransferInternalClock

.skip:
    ld hl, wLinkBufferCountLo
    ld a, [hli]
    or [hl]
    jr z, .set_link_exchange_state_to_00
    ld a, [wLinkTimeoutLo]
    ld l, a
    ld a, [wLinkTimeoutHi]
    ld h, a
    push hl
    ld a, [wLinkTimeoutLo]
    add $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    adc $00
    ld [wLinkTimeoutHi], a
    pop hl
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, [hl]
    jp StartSerialTransferInternalClock

.set_link_exchange_state_to_00:
    ld a, $00
    ld [wLinkExchangeState], a
    ld a, $f0
    jp StartSerialTransferInternalClock

; A fixed busy wait used after Super Game Boy packets (44 call sites: after each SendSGBPacketSet in
; BootAndMainLoop_StartUp, DetectSGB, ResumeAfterModeChange_TurnOnLCD, StepFade_SGB and others).
; Returns at once when wSGBActive is 0 (A = 0, DE untouched); otherwise counts DE down from $1B58 to
; 0 with three nops a step and returns A = 0, DE = 0. (C2, E-0373)
; returns at once if wSGBActive is zero, otherwise counts DE from $1B58 to 0 with three nops per
; step
SpinDelay::
    ld a, [wSGBActive]
    or a
    ret z
    ld de, $1b58

.loop:
    nop
    nop
    nop
    dec de
    ld a, d
    or e
    jr nz, .loop
    ret

; Called once by BootAndMainLoop_StartUp on a unit that is not a CGB, with wSGBActive still 1: sends
; SGB packet set $0B (SendSGBPacketSet, then SpinDelay), then reads the joypad lines of rP1 (bits
; 0-1) twice, the second time after writing the line selects $20, $30, $10, $30. Returns carry set
; when either read shows bits 0-1 not both 1, and carry clear with A = 0 when both read 3; either
; way it then sends packet set $0A. On carry set the start-up goes on to send the SGB packet sets
; and the border; on carry clear it clears wSGBActive. (C1, E-0373)
; sends packet set $0B, reads rP1 with two different line selections and returns carry set when the
; joypad lines change as a Super Game Boy makes them; sends packet set $0A afterwards in both
; outcomes
DetectSGB::
    ld a, $0b
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ldh a, [rP1]
    and $03
    cp $03
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
    and $03
    cp $03
    jr nz, .set_sgb_packet_index_to_0A
    ld a, $0a
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    sub a
    ret

.set_sgb_packet_index_to_0A:
    ld a, $0a
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    scf
    ret

; Reads the joypad of each Super Game Boy player, up to four (B = 4). Each pass reads the player
; number from rP1, selects the button lines ($20) and the direction lines ($10) and combines them
; into one byte; that player's 2-byte slot of wSGBJoypad1 gets the held buttons in its first byte
; and the newly pressed ones (held now, not before) in its second. It stops early when rP1 reads
; back the value it started with, which is when the SGB has cycled through the connected players.
; (C1, E-0357)
PollJoypad_ReadSGBPlayers::
    ldh a, [rP1]
    ld b, $04
    ld c, a
    jr .skip

.loop:
    ldh a, [rP1]
    cp c
    ret z

.skip:
    cpl
    and $03
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
    and $0f
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
    and $0f
    or d
    ld d, a
    ld a, [hli]
    xor d
    and d
    ld [hld], a
    ld a, d
    ld [hl], a
    ld a, $30
    ldh [rP1], a
    dec b
    jr nz, .loop
    ret

; A longer busy wait for Super Game Boy transfers, BC = number of passes. Returns at once when
; wSGBActive is 0 (BC and DE untouched); otherwise runs BC passes of a count of DE from $06D6 down
; to 0 (three nops a step) and returns BC = 0, DE = 0, A = 0 (BC = 0 would run 65536 passes).
; Callers: BootAndMainLoop_StartUp (BC = $0C), SGBTransferCompressed and SGBTransferRaw (5 before
; the packet, 6 after). (C2, E-0373)
; returns at once when wSGBActive is 0; otherwise busy-waits BC times about $06D6 loop passes
DelayBCWhenSGB::
    ld a, [wSGBActive]
    or a
    ret z

.loop:
    ld de, $06d6

.loop2:
    nop
    nop
    nop
    dec de
    ld a, d
    or e
    jr nz, .loop2
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Sends a Super Game Boy VRAM transfer built from compressed data. A = packet set (stored in
; wSGBPacketIndex even when nothing follows), B = ROM bank, DE = compressed stream. Returns at once
; when wSGBActive is 0. Otherwise: TurnOffLCD; ClearScrollPositions and rSCX = rSCY = 0; zeroes the
; $1000 bytes from vTiles1 ($8800-$97FF); rBGP = $E4; DecompressToRAMLocked expands the stream into
; vTiles1; fills 13 rows of 20 tiles at the top left of vBGMap0 with tile numbers $80, $81, ... (260
; in all, wrapping past $FF to $00-$83); turns the LCD on with rLCDC = wLCDCShadow = $81; waits
; (DelayBCWhenSGB 5), sends the packet set with SendSGBPacketSet, waits (6) and turns the LCD off.
; Callers: BootAndMainLoop_StartUp (set $0D with BootAndMainLoop_StartUp_Gfx) and
; LoadSGBBorderForSetA (15 calls). (C1, E-0373)
; A = packet set index (stored in wSGBPacketIndex); returns at once when wSGBActive is 0; otherwise
; turns the LCD off, clears vTiles1, decompresses the stream at HL into vTiles1, fills the 20 x 13
; corner of vBGMap0 with tiles $80, $81, ... in order, turns the LCD on, sends the packet set with
; SendSGBPacketSet and turns it off again; the tile data is thereby shown for the Super Game Boy to
; read
SGBTransferCompressed::
    ld [wSGBPacketIndex], a
    ld a, [wSGBActive]
    or a
    ret z
    push bc
    call TurnOffLCD
    call ClearScrollPositions
    xor a
    ldh [rSCX], a
    ldh [rSCY], a
    push de
    ld hl, vTiles1
    ld bc, $1000
    xor a
    call FillBytes
    pop de
    ld a, $e4
    ldh [rBGP], a
    pop bc
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vBGMap0
    ld de, $000c
    ld a, $80
    ld c, $0d

.loop:
    ld b, $14

.loop2:
    ld [hli], a
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

; The uncompressed form of SGBTransferCompressed, used once by BootAndMainLoop_StartUp (A = $0C, H =
; $17, DE = $446C, BC = $0800). A = packet set (stored in wSGBPacketIndex), H = ROM bank, DE =
; source, BC = byte count. Returns at once when wSGBActive is 0. Otherwise TurnOffLCD,
; ClearScrollPositions, rSCX = rSCY = 0, rBGP = $E4; maps bank H and copies BC bytes from DE to
; vTiles1 (which it does not clear first); fills the same 20 x 13 tile map in vBGMap0; turns the LCD
; on ($81); waits, sends the packet set, waits, turns the LCD off and maps the calling bank back.
; (C1, E-0373)
; A = packet set index; H = ROM bank, DE = source, BC = byte count: the same as
; SGBTransferCompressed, but copies the bytes to vTiles1 instead of decompressing
SGBTransferRaw::
    ld [wSGBPacketIndex], a
    ld a, [wSGBActive]
    or a
    ret z
    push hl
    push bc
    call TurnOffLCD
    call ClearScrollPositions
    xor a
    ldh [rSCX], a
    ldh [rSCY], a
    ld a, $e4
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
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, vBGMap0
    ld de, $000c
    ld a, $80
    ld c, $0d

.loop2:
    ld b, $14

.loop3:
    ld [hli], a
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

; Zero-fills the 16 bytes of wSGBPacketBuffer, the packet SendSGBPacketSet sends when
; wSGBPacketIndex is $FF; keeps BC and HL and returns A = 0. Callers: StepFade_SGB, StartPaletteFade
; and SendSGBPaletteSetPacket (5 call sites). (C2, E-0373)
; zero-fills the 16 bytes of wSGBPacketBuffer; BC, HL kept (E-0108)
ClearSGBPacketBuffer::
    push hl
    push bc
    xor a
    ld hl, wSGBPacketBuffer
    ld c, $10

.loop:
    ld [hli], a
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ret

; Turns the screen back on after a mode change and re-enables interrupts with the mask in A; the
; game modes' start-up routines (GameMode0_Init, GameMode4_Init, GameMode7_Init and others) end by
; jumping here. When linked (wLinkMode) it first re-synchronises with the partner
; (ResumeAfterModeChange_ResyncLink), then turns the LCD on and sends SGB packet set 1
; (ResumeAfterModeChange_TurnOnLCD), clears rIF, writes rIE and enables interrupts. Not part of
; ClearSGBPacketBuffer; it only follows it in the ROM. (C1, E-0369)
ResumeAfterModeChange::
    push af
    ld a, [wLinkMode]
    or a
    jr z, .call_resume_after_mode_change_turn_on_lcd
    call ResumeAfterModeChange_ResyncLink

.call_resume_after_mode_change_turn_on_lcd:
    call ResumeAfterModeChange_TurnOnLCD
    pop af
    call SetInterruptEnable
    ei
    ret

; Clears pending interrupts (rIF = 0) and masks rIE with $E2, which clears the VBlank, timer, serial
; and joypad enables (bits 0, 2, 3, 4) and keeps the LCD STAT enable (bit 1) and bits 5-7; then
; falls into TurnOffLCD. BootAndMainLoop_StartUp calls it at start-up and before each mode change,
; with interrupts already off. (C1, E-0373)
; clears rIF and masks rIE with $E2 (keeps LCD STAT and the unused high bits); falls through
; (E-0122)
DisableVBlankTimerSerialJoypadInterrupts::
    xor a
    ldh [rIF], a
    ldh a, [rIE]
    and $e2
    ldh [rIE], a

; If the LCD is on (rLCDC bit 7), waits until rLY reads $91 (line 145, inside VBlank), then clears
; bit 7 of rLCDC and of wLCDCShadow, so that the per-frame WriteLCDCShadow keeps it off; returns at
; once when it is already off. Reached by falling out of DisableVBlankTimerSerialJoypadInterrupts
; and called by SGBTransferCompressed and SGBTransferRaw. (C1, E-0373)
; if rLCDC bit 7 is set, waits for rLY = $91, then clears rLCDC bit 7 and bit 7 of wLCDCShadow
TurnOffLCD::
    ld hl, rLCDC
    bit 7, [hl]
    ret z

.loop:
    ldh a, [rLY]
    cp $91
    jr nz, .loop
    res 7, [hl]
    ld hl, wLCDCShadow
    res 7, [hl]
    ret

; Switches the LCD on (sets bit 7 of wLCDCShadow and copies it to rLCDC); on a Super Game Boy it
; also sends packet set 1 and waits. The 11 bytes after its ret are never reached; as code they
; would be ret / xor a / ldh [rIF], a / ldh a, [rIE] / and $F7 / ldh [rIE], a / ret (clear the
; serial interrupt enable). (C1, E-0357)
ResumeAfterModeChange_TurnOnLCD::
    ld hl, wLCDCShadow
    set 7, [hl]
    ld a, [hl]
    ldh [rLCDC], a
    ld a, [wSGBActive]
    or a
    ret z
    ld a, $01
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    ret
    db $c9, $af, $e0, $0f, $f0, $ff, $e6, $f7, $e0, $ff, $c9

; Spins until bit 7 of rSC (transfer in progress) is clear; there is no time limit. Callers:
; ResumeAfterModeChange_ResyncLink and RunLinkSession_FindPartner (3 call sites). (C1, E-0373)
; waits until rSC bit 7 (transfer in progress) clears (E-0108)
WaitSerialTransferDone::
    ldh a, [rSC]
    bit 7, a
    jr nz, WaitSerialTransferDone
    ret

; Clears pending interrupts (rIF = 0) and enables those in A (rIE = A). (C1, E-0357)
SetInterruptEnable::
    ld b, a
    xor a
    ldh [rIF], a
    ld a, b
    ldh [rIE], a
    ret

; rSCX = hScrollX, rSCY = hScrollY, rWX = hWindowX, rWY = hWindowY; returns A = hWindowY, which
; ApplyScreenShake (run next by VBlankHandler) tests. Callers: VBlankHandler each frame,
; RunWorldMapState_DrawCloseUp and RunWorldMapState_DrawOverview. (C1, E-0373)
; rSCX = hScrollX, rSCY = hScrollY, rWX = hWindowX, rWY = hWindowY (E-0353: corrected; was: rSCX =
; hScrollX, rSCY = hScrollY)
CopyScrollToHardware::
    ldh a, [hScrollX]
    ldh [rSCX], a
    ldh a, [hScrollY]
    ldh [rSCY], a
    ldh a, [hWindowX]
    ldh [rWX], a
    ldh a, [hWindowY]
    ldh [rWY], a
    ret

; Waits until the rSTAT mode bits read 0 (HBlank, or the LCD off), then writes wLCDCShadow to rLCDC.
; Mode 1 (VBlank) does not end the wait. VBlankHandler calls it each frame, also on its re-entered
; path. (C1, E-0373)
; waits until rSTAT mode bits are 0, then rLCDC = wLCDCShadow
WriteLCDCShadow::
    ldh a, [rSTAT]
    and $03
    jr nz, WriteLCDCShadow
    ld a, [wLCDCShadow]
    ldh [rLCDC], a
    ret

; rBGP, rOBP0, rOBP1 = wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1; called by VBlankHandler
; each frame. (C1, E-0373)
; rBGP, rOBP0, rOBP1 = wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1
CopyDMGPalettesToHardware::
    ld hl, wDMGPaletteBGP
    ld a, [hli]
    ldh [rBGP], a
    ld a, [hli]
    ldh [rOBP0], a
    ld a, [hl]
    ldh [rOBP1], a
    ret

; No caller in src/ (no call, jump or pointer found). On CGB (wIsCGB non-zero) it maps ROM bank B,
; copies $40 bytes from DE to HL, writes $7F at the address it reached plus C (B, reused as the
; counter, is 0 by then, so the address is the original HL + $40 + C) and maps the calling bank
; back; on DMG it returns at once. (C2, E-0373)
; on CGB only: copies $40 bytes from DE in ROM bank B to HL, then writes $7F at HL + BC (E-0124)
CopyCGB40BytesFromBankAndMark7F::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld b, $40

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld b, $00
    add hl, bc
    ld [hl], $7f
    pop af
    ld [rROMB0], a
    ret

; Writes CGB background palettes from wBGPaletteBuffer to rBGPD. When bit 7 of
; wBGPaletteUploadRequest is set it uploads one palette: the request goes to rBGPI as it is (start
; index, auto-increment), and its bits 3-5 pick the 8 bytes at wBGPaletteBuffer + 8 * palette
; (HLFromABits3To5). Otherwise (the callers write $7F) it sets rBGPI = $80 and uploads all 64 bytes.
; Each byte waits for WaitForVRAMAccess with interrupts off. It does not clear the request:
; VBlankHandler calls it on CGB with no fade when the request is non-zero and clears it after; 17
; other call sites (GameMode2_Update_OpenPage, ExitPauseMenuToField and others) write $7F to the
; request and call it directly. (C1, E-0373)
; when bit 7 of wBGPaletteUploadRequest is set, writes 8 bytes (one palette) from a buffer address
; derived by HLFromABits3To5 to rBGPD starting at index wBGPaletteUploadRequest; otherwise writes
; all 64 bytes from wBGPaletteBuffer to rBGPD from index 0; each byte is written after waiting for
; VRAM access
UploadBGPalettes::
    ld a, [wBGPaletteUploadRequest]
    bit 7, a
    jr z, .call_wait_for_vram_access
    ldh [rBGPI], a
    call HLFromABits3To5
    ld a, l
    add $9f
    ld l, a
    ld a, h
    adc $c4
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
    ld a, [hli]
    ldh [c], a
    ei
    dec b
    jr nz, .loop
    ret

; VBlank step that uploads sprite palettes on CGB. If bit 7 of wOBJPaletteUploadRequest is set, it
; uploads one palette (8 bytes; bits 3-5 of the request choose it, and the request also goes to
; rOBPI) from wOBJPaletteBuffer; otherwise all eight (64 bytes) from wOBJPaletteBuffer. Each byte
; waits for rSTAT mode below 2 with interrupts off before it goes to rOBPD. (C1, E-0357)
VBlankHandler_UploadOBJPalettes::
    ld a, [wOBJPaletteUploadRequest]
    bit 7, a
    jr z, .call_wait_for_vram_access
    ldh [rOBPI], a
    call HLFromABits3To5
    ld a, l
    add $df
    ld l, a
    ld a, h
    adc $c4
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

; HL = A & $38 (bits 3-5 of A, a palette number times 8), H = 0; A is left as A & $38.
; UploadBGPalettes and VBlankHandler_UploadOBJPalettes use it to find one palette in
; wBGPaletteBuffer or wOBJPaletteBuffer from an upload request. The res 7, a before the and changes
; nothing. (C2, E-0373)
; HL = A & $38 (bits 3-5), H = 0 (E-0119)
HLFromABits3To5::
    res 7, a
    and $38
    ld l, a
    ld h, $00
    ret

; rSTAT |= $40: enables the LY = LYC coincidence as an LCD STAT interrupt source. No caller in src/
; (no call, jump or pointer found). (C1, E-0373)
; rSTAT |= $40: selects the LY = LYC coincidence as an LCD STAT interrupt source (E-0114)
EnableLYCInterruptSource::
    ldh a, [rSTAT]
    or $40
    ldh [rSTAT], a
    ret

; rSTAT &= $07: clears the LCD STAT interrupt source bits 3-6 and keeps the mode and coincidence
; bits. Called by GameMode1_Init, GameMode4_Init, GameMode5_Init and GameMode7_Init. (C1, E-0373)
; rSTAT &= $07: clears the LCD-status interrupt source bits 3-6, keeping the mode and coincidence
; flags (E-0108)
ClearSTATInterruptSources::
    ldh a, [rSTAT]
    and $07
    ldh [rSTAT], a
    ret

; A = byte to send: with interrupts off, LoadSerialByte (rSC = 0, rSB = A), then sets rSC bit 0
; (internal clock) and bit 7 (start), so this Game Boy clocks the transfer; then ei. Returns B = the
; byte, HL = rSC. Callers: LinkExchangeJoypadPerFrame, ResumeAfterModeChange_ResyncLink_SendAck,
; ResumeAfterModeChange_ResyncLink_SendGreeting, GameMode5_Update_TitleMenu and link routines in
; bank $1B. (C1, E-0373)
; with interrupts off, LoadSerialByte, then sets rSC bits 0 (internal clock) and 7 (start transfer)
; (E-0073)
StartSerialTransferInternalClock::
    di
    call LoadSerialByte
    ld hl, rSC
    set 0, [hl]
    set 7, [hl]
    ei
    ret

; A = byte to send: with interrupts off, LoadSerialByte (rSC = 0, rSB = A), then clears rSC bit 0
; and sets bit 7, so rSC = $80 and the byte waits for the partner to clock the transfer (external
; clock); then ei. Returns B = the byte, HL = rSC. 32 call sites in the link code
; (ResumeAfterModeChange_ResyncLink, GameMode5_Update_DuoSetup and others). (C1, E-0373)
; A is stored in rSB and rSC becomes $80 (transfer start, external clock); interrupts are off during
; the write
SerialSendByte::
    di
    call LoadSerialByte
    ld hl, rSC
    res 0, [hl]
    set 7, [hl]
    ei
    ret

; rSC = 0 (stops any transfer), then rSB = A; B = A. Shared by StartSerialTransferInternalClock and
; SerialSendByte, which then start the transfer. (C1, E-0373)
; rSC = 0, rSB = A
LoadSerialByte::
    ld b, a
    ld a, $00
    ldh [rSC], a
    ld a, b
    ldh [rSB], a
    ret

; The memory clear of BootAndMainLoop_StartUp, so it runs at power-on and at every reset that jumps
; there. On CGB it first zeroes rVBK, rSVBK, rHDMA1-rHDMA5, rBGPI and rOBPI. It zeroes $1E00 bytes
; from wShadowOAM ($C000-$DDFF, with WRAM bank 1 at $D000) and $74 bytes from hPlayerSpriteVariant
; ($FF8A-$FFFD), then puts wIsCGB back. It enables SRAM ($0A to rRAMG), zeroes $2000 bytes from
; sRecords in SRAM bank 2 and then in bank 0, and disables SRAM again. SRAM bank 1, which holds the
; save (sSaveSignature, sSaveData), is not touched. (C1, E-0373)
; on CGB resets VBK, SVBK, HDMA and palette index registers; clears $1E00 bytes of WRAM from
; wShadowOAM and $74 bytes of HRAM from hPlayerSpriteVariant (keeping wIsCGB); clears SRAM banks 2
; and 0 (E-0125)
ClearWRAMHRAMAndSRAMBanks0And2::
    ld a, [wIsCGB]
    or a
    jr z, .skip
    xor a
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
    ld bc, $1e00
    ld a, $00
    call FillBytes
    ld hl, hPlayerSpriteVariant
    ld bc, $0074
    ld a, $00
    call FillBytes
    pop af
    ld [wIsCGB], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $02
    ld [rRAMB], a
    xor a
    ld hl, sRecords
    ld bc, $2000
    call FillBytes
    ld a, $00
    ld [rRAMB], a
    xor a
    ld hl, sRecords
    ld bc, $2000
    call FillBytes
    ld a, $00
    ld [rRAMG], a
    ret

; Called by BootAndMainLoop_StartUp at the start of every mode: zeroes the $800 bytes from vBGMap0
; (both BG maps, $9800-$9FFF); but when wBGFillFlag is non-zero it clears the flag and fills only
; the $400 bytes of vBGMap0 with tile $C3. (C1, E-0373)
; fills vBGMap0 with $800 zero bytes; if wBGFillFlag is set, clears it and fills only $400 bytes
; with $C3 (E-0122)
ClearBGMapOrFillWithC3::
    ld hl, vBGMap0
    ld bc, $0800
    ld a, [wBGFillFlag]
    or a
    jr z, .call_fill_bytes
    xor a
    ld [wBGFillFlag], a
    ld bc, $0400
    ld a, $c3

.call_fill_bytes:
    call FillBytes
    ret

; Stores A in BC bytes from HL (memset); returns HL just past them, BC = 0, D = the value, A = 0. BC
; is a full 16-bit count, and BC = 0 fills 65536 bytes. 155 call sites. (C2, E-0373)
; A = value, HL = destination, BC = count; HL ends past the last byte (memset)
FillBytes::
    ld d, a

.loop:
    ld [hl], d
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Copies BC bytes from HL to DE (memcpy, upward); returns HL and DE just past them, BC = 0, A = 0.
; BC = 0 copies 65536 bytes. 47 call sites. (C2, E-0373)
; HL = source, DE = destination, BC = count (memcpy)
CopyBytes::
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyBytes
    ret

; Steps the table random number: wRandomHi = (wRandomHi + 1) & $7F, then wRandomLo = A =
; RandomByteTable[wRandomHi]; HL is kept. The main loop in BootAndMainLoop_StartUp calls it on every
; pass while not linked (each wake from halt), and 46 other call sites take a value from it
; (AdvanceRandom, NextTableByteSecondStream, CreateMonsterRecordInSlot_Build and others). (C2,
; E-0373)
; wRandomHi = (wRandomHi + 1) & $7F; wRandomLo = the byte at RandomByteTable + wRandomHi
NextTableByte::
    push hl
    ld a, [wRandomHi]
    inc a
    and $7f
    ld [wRandomHi], a
    ld hl, RandomByteTable
    add_a_to_hl
    ld a, [hl]
    ld [wRandomLo], a
    pop hl
    ret

; NextTableByte steps wRandomHi through 0-$7F and loads wRandomLo from $0973 + wRandomHi; 128 bytes
; end at NextRandomSeed ($09F3) (E-0220, C1)
; record: 16 table bytes
RandomByteTable::
    db $7b, $fe, $22, $dc, $18, $c4, $6d, $fb, $cd, $27, $a0, $09, $6e, $38, $8a, $04 ; id 0
    db $7c, $56, $97, $5a, $a8, $4d, $78, $b5, $6c, $aa, $03, $1a, $4a, $0d, $26, $82 ; id 1
    db $ad, $02, $a1, $b9, $a3, $6b, $d8, $0c, $4c, $ae, $19, $45, $5b, $9c, $16, $07 ; id 2
    db $89, $51, $90, $29, $f5, $62, $f7, $cb, $f1, $53, $ff, $14, $65, $d0, $87, $35 ; id 3
    db $3e, $4e, $4f, $83, $0e, $c9, $7f, $5d, $fc, $e6, $ba, $01, $f8, $00, $f4, $0a ; id 4
    db $e5, $a9, $8d, $d1, $e8, $db, $de, $81, $95, $72, $08, $9a, $c7, $49, $c8, $23 ; id 5
    db $39, $37, $e0, $91, $c3, $33, $9b, $5f, $be, $41, $ee, $74, $e2, $0b, $47, $7e ; id 6
    db $bf, $60, $bb, $20, $61, $05, $b2, $94, $b6, $e4, $3a, $21, $1e, $b4, $8c, $ce ; id 7

; Update the little-endian wKeyRandomLo/Hi word to (5*seed + 11) modulo 65536 using two shifts, word
; addition and low-byte add/high-byte carry. Preserve HL and BC on the stack; A and flags are
; working outputs. PlayerSpriteFlash samples low three bits of the resulting high byte, while other
; callers consume the same shared state. The recurrence does not by itself establish a uniform
; sprite selection or independent draws. (C2, E-0362; probed E-0374)
NextRandomSeed::
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
    ld a, $0b
    add l
    ld [wKeyRandomLo], a
    ld a, h
    adc $00
    ld [wKeyRandomHi], a
    pop bc
    pop hl
    ret

; Reads the joypad. With wSGBActive set it runs PollJoypad_ReadSGBPlayers, then wJoypadHeldPrev =
; the old wJoypadHeld, wJoypadHeld = wSGBJoypad1, wLinkJoypadHeldPrev = the old wLinkJoypadHeld and
; wLinkJoypadHeld = wSGBJoypad2 (the second SGB pad). Otherwise it clears wJoypadReadFlag, reads the
; pad with ReadJoypadDirect, sets wJoypadHeldPrev = the old wJoypadHeld and wJoypadHeld = the
; reading, and deselects both key groups (rP1 = $30). Called by VBlankHandler when not linked, by
; LinkExchangeJoypadPerFrame and by the bank $1B link routines (LinkSendStepWithBuffer,
; LinkExchangeJoypadByte). (C1, E-0373)
; shifts wJoypadHeld to wJoypadHeldPrev and reads the new state into wJoypadHeld (directly, or
; through the SGB path when wSGBActive)
PollJoypad::
    ld a, [wSGBActive]
    or a
    jr z, .clear_joypad_read_flag
    call PollJoypad_ReadSGBPlayers
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
    xor a
    ld [wJoypadReadFlag], a
    call ReadJoypadDirect
    ld a, [wJoypadHeld]
    ld [wJoypadHeldPrev], a
    ld a, b
    ld [wJoypadHeld], a
    ld a, $30
    ldh [rP1], a
    ret

; No caller in src/ (no call, jump or pointer found). Reads this pad with ReadJoypadDirect into the
; other-player bytes: wLinkJoypadHeldPrev = the old wLinkJoypadHeld, wLinkJoypadHeld = the reading
; (B); then rP1 = $30 (both key groups deselected). (C1, E-0373)
; ReadJoypadDirect, then wLinkJoypadHeldPrev = the old wLinkJoypadHeld and wLinkJoypadHeld = B (the
; new reading); finally rP1 = $30 (deselects both key groups) (E-0114)
ReadJoypadIntoLinkJoypadHeld::
    call ReadJoypadDirect
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, b
    ld [wLinkJoypadHeld], a
    ld a, $30
    ldh [rP1], a
    ret

; Reads this pad from rP1: selects the direction lines ($20) and reads twice, then the button lines
; ($10) and reads 10 times, and returns B = A = the pressed buttons, 1 = pressed: bits 4-7 Right,
; Left, Up, Down and bits 0-3 A, B, Select, Start. It leaves the button lines selected; its callers
; PollJoypad and ReadJoypadIntoLinkJoypadHeld then write rP1 = $30. (C1, E-0373)
; B = the buttons: upper nibble D-pad (bit 7 down, 6 up, 5 left, 4 right), lower nibble A, B,
; Select, Start (bits 0-3), 1 = pressed; reads rP1 with each line group selected
ReadJoypadDirect::
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and $0f
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
    and $0f
    or b
    ld b, a
    ret

; Turns held buttons into presses, for this pad and for the other player. When not linked (wLinkMode
; 0) and wJoypadReadFlag is 0 it first clears wLinkJoypadHeld and wLinkJoypadHeldPrev.
; wJoypadPressed = the buttons in wJoypadHeld that were not in wJoypadHeldPrev. When the held
; buttons are 0 or have changed, wJoypadPressedRepeat = wJoypadPressed and wJoypadRepeatTimer = $14;
; while the same non-zero buttons stay held, wJoypadPressedRepeat = 0 and the timer counts down, and
; when it is found at 0, wJoypadPressedRepeat = wJoypadHeld and the timer restarts at 6 (counted
; once that frame), so a held button repeats 21 calls after the press and every 6 calls after that.
; wLinkJoypadPressed, wLinkJoypadPressedRepeat and wLinkJoypadRepeatTimer are made from
; wLinkJoypadHeld/Prev the same way. Called by VBlankHandler when not linked and by the bank $1B
; link routines (9 call sites). (C2, E-0373)
; wJoypadPressed = buttons newly held since the last poll; wJoypadPressedRepeat = the same, plus an
; auto-repeat that fires after $14 frames and then every 6 (timer in wJoypadRepeatTimer)
UpdateJoypadPresses::
    ld a, [wLinkMode]
    or a
    jr nz, .clear_joypad_pressed_repeat
    ld a, [wJoypadReadFlag]
    or a
    jr nz, .clear_joypad_pressed_repeat
    xor a
    ld [wLinkJoypadHeld], a
    ld [wLinkJoypadHeldPrev], a

.clear_joypad_pressed_repeat:
    xor a
    ld [wJoypadPressedRepeat], a
    ld hl, wJoypadHeld
    ld a, [hl]
    inc hl
    xor [hl]
    dec hl
    and [hl]
    ld [wJoypadPressed], a
    ld hl, wJoypadHeld
    ld a, [hli]
    or a
    jr z, .read_joypad_pressed
    cp [hl]
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
    or a
    jr nz, .clear_link_joypad_pressed_repeat
    ld [hl], $06
    ld a, [wJoypadHeld]
    ld [wJoypadPressedRepeat], a

.clear_link_joypad_pressed_repeat:
    dec [hl]

.clear_link_joypad_pressed_repeat2:
    xor a
    ld [wLinkJoypadPressedRepeat], a
    ld hl, wLinkJoypadHeld
    ld a, [hl]
    inc hl
    xor [hl]
    dec hl
    and [hl]
    ld [wLinkJoypadPressed], a
    ld hl, wLinkJoypadHeld
    ld a, [hli]
    or a
    jr z, .read_link_joypad_pressed
    cp [hl]
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
    or a
    jr nz, .done
    ld [hl], $06
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadPressedRepeat], a

.done:
    dec [hl]

.return:
    ret

; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so an index
; above $7F wraps; the add carries into H); A = the low byte of the word. The bank $00 copy of a
; per-bank helper; callers: TitleOpening_ScrollWithSparkles, TitleOpening_StartSparkles,
; DebugStaffRoll_Credits_ShowLines and RunDebugState_E0_ChooseActionTargets_DrawDetails. (C2,
; E-0373)
; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps
; above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
ReadWordTableEntry_Bank00::
    add a
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    deref_hl
    ret

; B = ROM bank, DE = source, HL = destination, C = count (0 means 256): maps bank B, copies C bytes
; from DE to HL, then maps the calling bank back (saved from BANK_NUMBER_BYTE). Returns DE and HL
; just past the bytes, C = 0, B unchanged, A = the calling bank number. 24 call sites
; (LoadMonsterPicture, LoadBGPaletteBufferFromBank and others). (C2, E-0373)
CopyFromBank::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; The interface of CopyFromBank (B = ROM bank, DE = source, HL = destination, C = count, 0 means
; 256) with a wait for VRAM: before each byte it disables interrupts and waits until rSTAT bit 1 is
; clear (mode 0 or 1, when VRAM can be written), stores the byte, then re-enables interrupts. Maps
; the calling bank back. 232 call sites (OpenTextChoice_DrawWindow, CopyMonsterNameToBuffer_B01 and
; others). (C1, E-0373)
CopyFromBankWaitVRAM::
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
    ld [hli], a
    inc de
    ei
    dec c
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; B = ROM bank, DE = source, HL = destination, C = count (0 means 256): maps bank B; for each byte
; it waits for rSTAT bit 1 clear with interrupts off and reads [DE], then waits again and ORs the
; byte into [HL], advancing both; maps the calling bank back. B is clobbered (it ends as the last
; byte read). 17 call sites (DrawNameGlyphBufGlyphsOverlaying8DAnd8E,
; HibernateMenu_DrawSleeperPage_FifthNameGlyphs and others). (C1, E-0373)
OrFromBankWaitVRAM::
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
    or b
    ld [hli], a
    ei
    dec c
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; HL = address in the ROM bank held in wDataBank: maps that bank, reads B = [HL] and C = [HL + 1]
; (the first byte goes to B), leaves HL unchanged and maps the calling bank back; A = the calling
; bank number. 31 call sites (CopyMonsterNameToBuffer_B01, DrawKeyListPageNames,
; ScriptFetchMessageByScreen and others). (C2, E-0373)
ReadWordFromDataBank::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wDataBank]
    ld [rROMB0], a
    ld a, [hli]
    ld b, a
    ld a, [hld]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

; Sets wDMGPaletteBGP, wDMGPaletteOBP0 and wDMGPaletteOBP1 to $D2, $D2, $E2 and copies the three to
; wDMGPaletteBytes. Called by BootAndMainLoop_StartUp at the start of every mode, before
; ResetFadeFromDMGPaletteBGP copies them to wFadeDMGPalettes. (C2, E-0373)
; wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1 = $D2, $D2, $E2 (the DMG palette bytes the fade
; routines start from), copied to wDMGPaletteBytes-wDMGPaletteBytes + $2 as well (E-0117)
SetDefaultDMGPaletteBytes::
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ret

; Zeroes the 8 bytes $FFA1-$FFA8 (hScrollX, hScrollXHi, $FFA3, $FFA4, hScrollY, hScrollYHi, $FFA7,
; $FFA8): it calls StoreAFourTimesAtHL and then falls into it for 4 more. Returns HL = $FFA9, A = 0.
; Callers: BootAndMainLoop_StartUp at the start of every mode, SGBTransferCompressed and
; SGBTransferRaw. (C2, E-0373)
; writes 0 to the four bytes at hScrollX (StoreAFourTimesAtHL); falls through (E-0122)
ClearScrollPositions::
    xor a
    ld hl, hScrollX
    call StoreAFourTimesAtHL

; Stores A at HL, HL + 1, HL + 2 and HL + 3; returns HL + 4. ClearScrollPositions calls it and then
; falls into it. (C2, E-0373)
; stores A at HL, HL+1, HL+2, HL+3; HL += 4 (E-0114)
StoreAFourTimesAtHL::
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ret

; hOamNextEntry = 0 and zeroes the $A0 bytes of wShadowOAM (all 40 sprite entries); HL ends at
; $C0A0. Called by BootAndMainLoop_StartUp at the start of every mode. (C2, E-0373)
; hOamNextEntry = 0 and clears the $A0 bytes of shadow OAM at wShadowOAM (E-0122)
ClearShadowOAM::
    xor a
    ldh [hOamNextEntry], a
    ld hl, wShadowOAM
    ld b, $a0

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Called by GameFrameUpdate after the frame routine of the mode: zeroes the first byte (Y) of each
; wShadowOAM entry from index hOamNextEntry to 39, leaving the other bytes and the earlier entries;
; returns at once when hOamNextEntry is $28 (all 40 in use). (Hardware: a sprite with Y = 0 is off
; screen.) (C2, E-0373)
; zeroes the first byte (Y) of every OAM shadow entry from hOamNextEntry up to 40
ClearUnusedOAMEntries::
    ldh a, [hOamNextEntry]
    cp $28
    ret z
    ld l, a
    sla l
    sla l
    ld h, $c0
    sub $28
    ld b, a
    xor a

.loop:
    ld [hli], a
    inc l
    inc l
    inc l
    inc b
    jr nz, .loop
    ret

; Called by VBlankHandler each frame. When wBGWriteDestLo/Hi (a BG map address) is non-zero it
; copies wBGWriteCount bytes from wBGWriteData there: along the row when wBGWriteVertical is 0 (the
; column wraps within the 32-tile row), else down the column ($20 a step, clearing bit 2 of the high
; byte each step, so the column wraps from the bottom of vBGMap0 to its top); then clears the
; destination. On CGB it then does the same for the attribute queue (wAttrWriteDestLo/Hi,
; wAttrWriteCount, wAttrWriteData, wAttrWriteVertical) in VRAM bank 1, selects bank 0 and clears
; that destination. It does not wait for VRAM access. (C1, E-0373)
; if wBGWriteDestLo/wBGWriteDestHi (a VRAM address) is non-zero, writes wBGWriteCount bytes from
; wBGWriteData there: along the row when wBGWriteVertical is 0, down the column otherwise
FlushQueuedBGMapWrite::
    ld a, [wBGWriteDestLo]
    ld e, a
    ld a, [wBGWriteDestHi]
    ld d, a
    ld a, d
    or e
    jr nz, .read_bg_write_count
    ret

.read_bg_write_count:
    ld a, [wBGWriteCount]
    ld b, a
    ld hl, wBGWriteData
    ld a, [wBGWriteVertical]
    or a
    jr nz, .loop2
    ld a, e
    and $e0
    ld c, a

.loop:
    ld a, [hli]
    ld [de], a
    inc e
    ld a, e
    and $1f
    or c
    ld e, a
    dec b
    jr nz, .loop
    jr .clear_bg_write_dest_lo

.loop2:
    ld a, [hli]
    ld [de], a
    ld a, $20
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    res 2, d
    dec b
    jr nz, .loop2

.clear_bg_write_dest_lo:
    xor a
    ld [wBGWriteDestLo], a
    ld [wBGWriteDestHi], a
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, [wAttrWriteDestLo]
    ld e, a
    ld a, [wAttrWriteDestHi]
    ld d, a
    ld a, d
    or e
    jr nz, .read_attr_write_count
    ret

.read_attr_write_count:
    ld a, [wAttrWriteCount]
    ld b, a
    ld hl, wAttrWriteData
    ld a, [wAttrWriteVertical]
    or a
    jr nz, .loop4
    ld a, e
    and $e0
    ld c, a

.loop3:
    ld a, [hli]
    ld [de], a
    inc e
    ld a, e
    and $1f
    or c
    ld e, a
    dec b
    jr nz, .loop3
    jr .skip3

.loop4:
    ld a, [hli]
    ld [de], a
    ld a, $20
    add e
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
    xor a
    ld [wAttrWriteDestLo], a
    ld [wAttrWriteDestHi], a
    ret

; B = ROM bank, DE = compressed stream, HL = destination: waits while hDecompressLock is non-zero
; (with no time limit), sets it to 1, runs DecompressToRAM (which maps bank B and maps the calling
; bank back), then clears it. 34 call sites (SGBTransferCompressed, GameMode5_Init_AfterLinkBattle
; and others). (C2, E-0373)
DecompressToRAMLocked::
    ldh a, [hDecompressLock]
    or a
    jr nz, DecompressToRAMLocked
    inc a
    ldh [hDecompressLock], a
    call DecompressToRAM
    xor a
    ldh [hDecompressLock], a
    ret

; Expands the compressed stream at DE in ROM bank B into memory at HL with plain stores (a RAM
; destination), then maps the calling bank back. After the header (DecompressReadHeader: size,
; marker) every byte other than the marker is stored as it is; the marker is followed by a position
; byte and a count byte: the length is the count low nibble + 4, or the next byte + $13 when that
; nibble is $F, and the source is the destination start + (count high nibble << 8 | position). A
; source at or past the destination end moves back $1000, and one then before the destination start
; reads as 0; an overlapping copy repeats bytes just written. It stops once the header size has been
; written. Only DecompressToRAMLocked calls it. Earlier reading (E-0016): 141 emulated calls matched
; tools/lzss_gfx.py byte for byte. (C2, E-0373)
DecompressToRAM::
    ld a, [BANK_NUMBER_BYTE]
    push af
    call DecompressReadHeader

.loop:
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp [hl]
    jr z, .set_decompress_run_byte
    pop hl
    ld [hl], a
    inc hl
    dec bc
    ld a, b
    or c
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
    and $0f
    add $04
    cp $13
    jr nz, .set_decompress_run_count
    ld a, [de]
    inc de
    add $13

.set_decompress_run_count:
    ldh [hDecompressRunCount], a
    pop af
    push de
    swap a
    and $0f
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
    cp d
    jr z, .check_decompress_header1
    jr c, .skip
    jr .skip3

.check_decompress_header1:
    ldh a, [hDecompressHeader1]
    cp e
    jr z, .skip
    jr nc, .skip3

.skip:
    ld a, $f0
    add d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp d
    jr z, .check_decompress_header3
    jr nc, .skip2
    jr .skip3

.check_decompress_header3:
    ldh a, [hDecompressHeader3]
    cp e
    jr z, .skip3
    jr c, .skip3

.skip2:
    ld a, $10
    add d
    ld d, a
    xor a
    jr .skip4

.skip3:
    ld a, [de]

.skip4:
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
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

; The same expansion as DecompressToRAM (format there) for destinations that may be VRAM: it spins
; while hDecompressLock is non-zero and then takes it, waits for rSTAT bit 1 to clear with
; interrupts disabled before every store (re-enabling them after), reads back-references from the
; destination itself, and on return maps the calling bank back and clears hDecompressLock. Callers
; also use it for WRAM buffers (LoadMapScreen expands into wScreenTileBuffer and wScreenAttrBuffer).
; (C1, E-0373)
DecompressToVRAM::
    ldh a, [hDecompressLock]
    or a
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
    cp [hl]
    jr z, .set_decompress_run_byte
    pop hl
    ldh [hVRAMByteTemp], a
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ldh a, [hVRAMByteTemp]
    ld [hli], a
    ei
    dec bc
    ld a, b
    or c
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
    and $0f
    add $04
    cp $13
    jr nz, .set_decompress_run_count
    ld a, [de]
    inc de
    add $13

.set_decompress_run_count:
    ldh [hDecompressRunCount], a
    ldh a, [hVRAMByteTemp]
    push de
    swap a
    and $0f
    ld d, a
    ldh a, [hDecompressRunByte]
    ld e, a
    ldh a, [hDecompressDestLo]
    add e
    ld e, a
    ldh a, [hDecompressDestHi]
    adc d
    ld d, a

.loop3:
    ldh a, [hDecompressHeader2]
    cp d
    jr z, .check_decompress_header1
    jr c, .skip
    jr .skip3

.check_decompress_header1:
    ldh a, [hDecompressHeader1]
    cp e
    jr z, .skip
    jr nc, .skip3

.skip:
    ld a, $f0
    add d
    ld d, a
    ldh a, [hDecompressHeader4]
    cp d
    jr z, .check_decompress_header3
    jr nc, .skip2
    jr .skip3

.check_decompress_header3:
    ldh a, [hDecompressHeader3]
    cp e
    jr z, .skip3
    jr c, .skip3

.skip2:
    ld a, $10
    add d
    ld d, a
    di

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    xor a
    ld [hli], a
    ei
    jr .next

.skip3:
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, [de]
    ld [hli], a
    ei

.next:
    inc de
    dec bc
    ld a, b
    or c
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
    xor a
    ldh [hDecompressLock], a
    ret

; Maps ROM bank B and reads the 3-byte header of the compressed stream at DE: BC = the output size
; (low byte first) and hDecompressMarker = the marker byte, leaving DE past the header. Stores the
; destination start HL in hDecompressDestLo/Hi and in hDecompressHeader3/4, and the destination end
; HL + size in hDecompressHeader1/2; HL is kept. Shared start of DecompressToRAM and
; DecompressToVRAM, which save the calling bank first. (C2, E-0373)
DecompressReadHeader::
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

; Resets the palette fade: copies wDMGPaletteBGP, wDMGPaletteOBP0 and wDMGPaletteOBP1 to the three
; wFadeDMGPalettes bytes, clears wFadeLevel and the four bytes after it (wFadeDelay,
; wFadeDelayCounter, one unnamed byte, wFadeStepSize) and wFadeState, and sets wFadeMode = 7 and
; wFadeMask = $1F (all palettes). Called by BootAndMainLoop_StartUp after SetDefaultDMGPaletteBytes,
; by GameMode1_Update_FinishFieldSetup before its StartPaletteFade with A = $FD, by
; ResetLinkScreenPalettes and from bank $E0. (C2, E-0373)
; wFadeDMGPalettes-wFadeDMGPalettes + $2 = wDMGPaletteBGP-wDMGPaletteOBP1; then clears wFadeLevel
; and the four bytes after it and wFadeState, and sets wFadeMode = 7 and wFadeMask = $1F (E-0090)
ResetFadeFromDMGPaletteBGP::
    ld hl, wFadeDMGPalettes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    jr .skip

.skip:
    xor a
    ld hl, wFadeLevel
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld [wFadeState], a
    ld a, $07
    ld [wFadeMode], a
    ld a, $1f
    ld [wFadeMask], a
    ret

; A = fade state, stored in wFadeState; on the SGB and DMG paths bit 7 clear fades from the current
; colours toward white (black when wFadeMode bit 7 is set) and bit 7 set starts at white or black
; and fades back, and the value also sets the step delay. CGB: far-calls
; StartPaletteFade_SetUpTiming. Super Game Boy (wSGBActive): copies the 32 bytes of
; wOBJPaletteBuffer to wOBJPaletteBuffer + $20; bit 7 clear sets wFadeLevel = 0 and wFadeDelay =
; wFadeDelayCounter = A >> 2; bit 7 set sets wFadeLevel = $20 and the delay (NOT A) >> 2, fills the
; 16 colours of wOBJPaletteBuffer with PAL_WHITE ($0000 when wFadeMode bit 7 is set) and sends them
; as SGB packet $01 and, when wFadeMask bit 4 is set, $09 (CopySGBPacketFieldsAndSend, SpinDelay).
; DMG: bit 7 clear saves wDMGPaletteBGP, OBP0 and OBP1 in wFadeDMGPalettes with wFadeLevel = 0 and
; delay A + 2; bit 7 set sets wFadeLevel = 4, delay (NOT A) + 2, and the three DMG palette bytes to
; $00 ($FF when wFadeMode bit 7 is set). StepFade then runs the fade once per frame. (C1, E-0373)
; A = fade state (bit 7 selects the reverse direction): on CGB it stores it and far-calls the CGB
; fade set-up; with the Super Game Boy active it copies wOBJPaletteBuffer to wOBJPaletteBuffer +
; $20, sets wFadeLevel and the delays, fills the palettes with PAL_WHITE or black ($0000, wFadeMode
; bit 7) and sends them as SGB packets ($01, and $09 when wFadeMask bit 4 is set); a DMG takes the
; separate wFadeMode path (E-0353: corrected; was: A = level (bit 7 set selects the second form); on
; CGB it hands over to StartPaletteFade_SetUpTiming; on DMG it rebuilds the palette copy at
; wOBJPaletteBuffer + $20 from wOBJPaletteBuffer and sets wFadeState, wFadeLevel-wFadeDelayCounter,
; with $7FFF (white) or $0000 (black) fill chosen by bit 7 of wFadeMode; observed writes only, the
; purpose is a palette fade by inference)
StartPaletteFade::
    ld b, a
    ld a, [wIsCGB]
    or a
    jp nz, .set_fade_state2
    ld a, [wSGBActive]
    or a
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
    ld [hli], a
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
    ld [hli], a
    inc de
    dec c
    jr nz, .loop2
    ld de, PAL_WHITE
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
    farcall StartPaletteFade_SetUpTiming
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
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    add $02
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
    add $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ld a, $00
    ld hl, wDMGPaletteBGP
    ld [hli], a
    ld [hli], a
    ld [hl], a
    jr .return

.skip2:
    bit 7, b
    jr nz, .set_fade_state4
    ld a, b
    ld [wFadeState], a
    ld hl, wFadeDMGPalettes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    add $02
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
    add $02
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ld a, $ff
    ld hl, wDMGPaletteBGP
    ld [hli], a
    ld [hli], a
    ld [hl], a

.return:
    ret

; Copies the 8 bytes at vTiles1 + 8 * HL to DE, without waiting for VRAM access; DE and HL end past
; the copy, B = HIGH(vTiles1) and C = 0. No caller was found in src/ or the listing. (C1, E-0373)
; copies the 8 bytes at vTiles1 + 8 * HL to DE (E-0122)
CopyEightBytesFromTiles1Entry::
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, vTiles1
    add hl, bc
    ld c, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; One frame of the palette fade, run from VBlankHandler and RunFrameTickFadeAndCounter_Bank1B:
; returns at once when wFadeState is 0; when wFadeState bit 7 is clear it first runs
; StepMusicVolumeFade. CGB goes to StepFade_CGB and DMG (wSGBActive 0) to StepFade_DMG. The Super
; Game Boy path waits until wFadeDelayCounter is 0 (decrementing it each frame), then moves
; wFadeLevel up by 5, capped at $1F (wFadeState bit 7 clear), or down by 5, at least 0 (bit 7 set),
; redraws the colours with StepFade_SGB, reloads wFadeDelayCounter from wFadeDelay, and ends the
; fade (StepFade_End) when the level reaches $1F or 0. (C1, E-0373)
; does nothing when wFadeState is 0; otherwise advances the palette fade by one step per call (CGB,
; SGB and DMG paths)
StepFade::
    ld a, [wFadeState]
    or a
    ret z
    bit 7, a
    call z, StepMusicVolumeFade
    ld a, [wIsCGB]
    or a
    jp nz, StepFade_CGB
    ld a, [wSGBActive]
    or a
    jp z, StepFade_DMG
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a
    jr z, .read_fade_level
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level:
    ld a, [wFadeLevel]
    add $05
    cp $1f
    jr c, .set_fade_level
    ld a, $1f

.set_fade_level:
    ld [wFadeLevel], a
    call StepFade_SGB
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    cp $1f
    jp z, StepFade_End
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a
    jr z, .read_fade_level2
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level2:
    ld a, [wFadeLevel]
    sub $05
    bit 7, a
    jr z, .set_fade_level2
    xor a

.set_fade_level2:
    ld [wFadeLevel], a
    call StepFade_SGB
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    or a
    jp z, StepFade_End
    ret

; Super Game Boy step of the palette fade: fades the colour groups chosen by bits 0-3 of wFadeMask
; (8 bytes each, StepFade_SGBColorGroup; groups 2 and 3 only when bit 4 is set), then sends the
; colours at wOBJPaletteBuffer as SGB packet $01 (PAL01); when bit 4 is set it also sends
; wOBJPaletteBuffer + $10 as packet $09 (PAL23). (C2, E-0369; probed E-0374)
StepFade_SGB::
    ld a, [wFadeMask]
    bit 0, a
    ld a, $00
    ld [wFadeStepSize], a
    call nz, StepFade_SGBColorGroup
    ld a, [wFadeMask]
    bit 1, a
    ld a, $08
    ld [wFadeStepSize], a
    call nz, StepFade_SGBColorGroup
    ld a, [wFadeMask]
    bit 4, a
    jr z, .call_clear_sgb_packet_buffer
    ld a, [wFadeMask]
    bit 2, a
    ld a, $10
    ld [wFadeStepSize], a
    call nz, StepFade_SGBColorGroup
    ld a, [wFadeMask]
    bit 3, a
    ld a, $18
    ld [wFadeStepSize], a
    call nz, StepFade_SGBColorGroup

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

; Copies 8 bytes from HL to DE, skips 2 source bytes, copies 6 more, sets wSGBPacketIndex = $FF
; (send wSGBPacketBuffer) and far-calls SendSGBPacketSet, which returns at once when wSGBActive is
; 0. With DE one past the command byte of wSGBPacketBuffer and HL at 8 colours, this makes an SGB
; palette packet of colours 0-3 and 5-7 (the first colour of the second palette is skipped). Used by
; StartPaletteFade and StepFade_SGB (packets $01 and $09), the second time by falling through from
; StepFade_SGB. (C2, E-0373)
; copies 8 bytes from HL to DE, skips 2 source bytes, copies 6 more, then wSGBPacketIndex = $FF and
; far-calls SendSGBPacketSet (E-0108)
CopySGBPacketFieldsAndSend::
    ld c, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    inc hl
    inc hl
    ld c, $06

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop2
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    ret

; Fades one SGB palette group of four colours: StepFade_SGBColor for the colour at the current
; offset (wFadeStepSize), then StepFade_NextSGBColor three times (twice by call, once by falling
; through), each moving the offset on by 2 bytes and fading that colour. (C2, E-0369; probed E-0374)
StepFade_SGBColorGroup::
    call StepFade_SGBColor
    call StepFade_NextSGBColor
    call StepFade_NextSGBColor

; Moves the fade offset wFadeStepSize to the next colour (2 bytes) and falls through to fade it.
; (C2, E-0357; probed E-0374)
StepFade_NextSGBColor::
    ld a, [wFadeStepSize]
    add $02
    ld [wFadeStepSize], a

; Fades one 15-bit colour for the SGB path: takes the target colour from wOBJPaletteBuffer + $20 +
; wFadeStepSize, moves each of its red, green and blue channels by wFadeLevel with
; AdjustColorChannelForFade, packs them back and stores the result at the same offset of
; wOBJPaletteBuffer. (C2, E-0357; probed E-0374)
StepFade_SGBColor::
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
    add h
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

; A = a colour channel (the low 5 bits are used), B = wFadeLevel: when wFadeMode bit 7 is clear
; returns A = (A & $1F) + B capped at $1F (toward white), when it is set A = (A & $1F) - B, at least
; 0 (toward black). C = wFadeMode. Used three times per colour by StepFade_SGBColor. (C2, E-0373)
; A = the 5-bit colour channel A moved by B toward white or black (bit 7 of wFadeMode), clamped; the
; following entries step the CGB and DMG fades (E-0128)
AdjustColorChannelForFade::
    push af
    ld a, [wFadeMode]
    ld c, a
    pop af
    bit 7, c
    jr nz, .skip
    and $1f
    add b
    cp $1f
    jr c, .return
    ld a, $1f
    jr .return

.skip:
    and $1f
    sub b
    jr nc, .return
    xor a

.return:
    ret

; CGB path of the fade: far-calls StepCGBFade, which moves every palette one level toward the fade
; target. (C1, E-0357)
StepFade_CGB::
    farcall StepCGBFade
    ret

; DMG fade step toward white (wFadeMode bit 7 clear; set means toward black, StepFade_DMGToBlack).
; Waits wFadeDelay frames per step; each step redraws the chosen DMG palettes
; (LightenSelectedDMGPalettes) and moves wFadeLevel up (fading out) or down (fading in, wFadeState
; bit 7); the fade ends (StepFade_End, wFadeState = 0) when the level reaches 4 or wraps below 0.
; (C2, E-0369; probed E-0374)
StepFade_DMG::
    ld a, [wFadeMode]
    bit 7, a
    jp nz, StepFade_DMGToBlack
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a
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
    cp $04
    jp z, StepFade_End
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a
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
    cp $ff
    jp z, StepFade_End
    ret

; For each of bits 0, 1 and 2 of wFadeMode that is set, lightens the saved palette wFadeDMGPalettes,
; + 1 or + 2 by wFadeLevel (LightenDMGPaletteByFadeLevel) into wDMGPaletteBGP, wDMGPaletteOBP0 or
; wDMGPaletteOBP1; an unselected palette byte is left alone. HL ends at wDMGPaletteOBP1. Called by
; StepFade_DMG on each fade step. (C2, E-0373)
; for each of bits 0, 1, 2 of wFadeMode that is set, lightens wFadeDMGPalettes, wFadeDMGPalettes +
; $1 or wFadeDMGPalettes + $2 by wFadeLevel into wDMGPaletteBGP, wDMGPaletteOBP0 or wDMGPaletteOBP1
; (LightenDMGPaletteByFadeLevel) (E-0117)
LightenSelectedDMGPalettes::
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

; A = a DMG palette byte (four 2-bit shades): each shade minus wFadeLevel, at least 0 (white), is
; packed back in the same place and the result is stored at [HL] and left in C; B = wFadeLevel, HL
; kept. Built from LightenDMGShade and three LightenDMGShadeNext calls. (C2, E-0373)
; A = a DMG palette byte: each 2-bit shade - wFadeLevel, at least 0 (white), is packed back and
; stored at [HL] (LightenDMGShade and LightenDMGShadeNext) (E-0108)
LightenDMGPaletteByFadeLevel::
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

; Rotates D right by 2 to bring the next shade into bits 0-1, then falls into LightenDMGShade with A
; = D. (C2, E-0373)
; rotates D right by 2 to bring the next shade down, then LightenDMGShade (E-0108)
LightenDMGShadeNext::
    rrc d
    rrc d
    ld a, d

; Subtracts B (the fade level) from the shade A & 3, at least 0, ORs it into C and rotates C right
; by 2, so after four shades C holds them back in their places; A = the ORed value. (C2, E-0373)
; subtracts B (the level) from the 2-bit shade in A & 3 (at least 0), ORs it into C and rotates C
; right by 2 (E-0108)
LightenDMGShade::
    and $03
    sub b
    jr nc, .skip
    xor a

.skip:
    or c
    ld c, a
    rrc c
    rrc c
    ret

; DMG fade step toward black (wFadeMode bit 7 set): the same timing as the fade toward white, but
; each step redraws the palettes with DarkenDMGPaletteByFadeLevel; the fade ends at level 4 or below
; 0. (C2, E-0357; probed E-0374)
StepFade_DMGToBlack::
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a
    jr z, .call_darken_selected_dmg_palettes
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_darken_selected_dmg_palettes:
    call DarkenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    inc a
    ld [wFadeLevel], a
    cp $04
    jr z, StepFade_End
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a
    jr z, .call_darken_selected_dmg_palettes2
    dec a
    ld [wFadeDelayCounter], a
    ret

.call_darken_selected_dmg_palettes2:
    call DarkenSelectedDMGPalettes
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    dec a
    ld [wFadeLevel], a
    cp $ff
    jr z, StepFade_End
    ret

; Redraws the DMG palettes the fade affects: for each of bits 0-2 of wFadeMode it darkens the
; matching saved palette in wFadeDMGPalettes (BGP, OBP0, OBP1) by wFadeLevel into wDMGPaletteBGP and
; the bytes after it. (C2, E-0357; probed E-0374)
DarkenSelectedDMGPalettes::
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

; A = a DMG palette byte (four 2-bit shades): each shade plus wFadeLevel, capped at 3 (black), is
; packed back in the same place and the result is stored at [HL] and left in C; B = wFadeLevel, HL
; kept. Built from DarkenDMGShade and three DarkenDMGShadeNext calls; DarkenSelectedDMGPalettes uses
; it. (C2, E-0373)
; A = a DMG palette byte (four 2-bit shades): each shade + wFadeLevel, capped at 3 (black), is
; packed back and stored at [HL] (DarkenDMGShade and DarkenDMGShadeNext) (E-0108)
DarkenDMGPaletteByFadeLevel::
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

; Rotates D right by 2 to bring the next shade into bits 0-1, then falls into DarkenDMGShade with A
; = D. (C2, E-0373)
; rotates D right by 2 to bring the next shade down, then DarkenDMGShade (E-0108)
DarkenDMGShadeNext::
    rrc d
    rrc d
    ld a, d

; Adds B (the fade level) to the shade A & 3, caps it at 3, ORs it into C and rotates C right by 2,
; so after four shades C holds them back in their places. (C2, E-0373)
; adds B (the level) to the 2-bit shade in A & 3, caps it at 3, ORs it into C and rotates C right by
; 2 (E-0108)
DarkenDMGShade::
    and $03
    add b
    cp $03
    jr c, .skip
    ld a, $03

.skip:
    or c
    ld c, a
    rrc c
    rrc c
    ret

; Ends a fade: wFadeState = 0. (C2, E-0357; probed E-0374)
StepFade_End::
    xor a
    ld [wFadeState], a
    ret

; Loops until rSTAT bit 1 is clear (LCD modes 0 and 1, when VRAM can be accessed) and returns with Z
; set and A = rSTAT. Callers usually disable interrupts first so the window does not pass before
; their access. (C1, E-0373)
; loops until STAT bit 1 is clear (modes 0 and 1); returns with Z set
WaitForVRAMAccess::
    ldh a, [rSTAT]
    bit 1, a
    ret z
    jr WaitForVRAMAccess

; A = value, HL = VRAM address: saves A in hVRAMWriteByte, disables interrupts, waits until rSTAT
; bit 1 is clear, stores the byte at [HL] and enables interrupts again; HL is not changed. (C1,
; E-0373)
; A = value, HL = address; disables interrupts, waits until VRAM is accessible, stores A at [HL];
; clobbers hVRAMWriteByte
WriteVRAMByte::
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

; The same as WriteVRAMByte but stores with [HL+], so HL ends one past the byte. (C1, E-0373)
; like WriteVRAMByte but stores at [HL] and increments HL
WriteVRAMByteInc::
    ldh [hVRAMWriteByte], a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ldh a, [hVRAMWriteByte]
    ld [hli], a
    ei
    ret

; wMusicRequest = A: ProcessSoundQueue starts that music (StartMusic) in the next VBlank and sets
; the request back to $FF. (C2, E-0373)
; wMusicRequest = A
QueueMusic::
    ld [wMusicRequest], a
    ret

; A = music id, stored in wCurrentMusic. With interrupts disabled it resets the sound hardware and
; every channel (InitSoundHardware); id 0 stops there. Otherwise it stores the id in wSoundId and
; starts the tracks: four (A to A + 3, StartFourSoundTracks) for $02, $0F and $58, two
; (StartTwoSoundTracks) for $40, $42, $44, $46, $48, $50 and $52, and three (StartThreeSoundTracks)
; for every other id; interrupts are enabled again on return. Called only by ProcessSoundQueue. (C1,
; E-0373)
; A = sound id (0 = none): stores it in wCurrentMusic, calls InitSoundHardware (silencing every
; channel), stores A in wSoundId and starts the track with StartThreeSoundTracks unless the id is
; one of a list that is handled separately
StartMusic::
    ld [wCurrentMusic], a
    di
    call InitSoundHardware
    ld a, [wCurrentMusic]
    or a
    jr z, .done
    ld [wSoundId], a
    cp $02
    jr z, .call_start_four_sound_tracks
    cp $0f
    jr z, .call_start_four_sound_tracks
    cp $40
    jr z, .call_start_two_sound_tracks
    cp $42
    jr z, .call_start_two_sound_tracks
    cp $44
    jr z, .call_start_two_sound_tracks
    cp $46
    jr z, .call_start_two_sound_tracks
    cp $48
    jr z, .call_start_two_sound_tracks
    cp $50
    jr z, .call_start_two_sound_tracks
    cp $52
    jr z, .call_start_two_sound_tracks
    cp $58
    jr z, .call_start_four_sound_tracks
    call StartThreeSoundTracks
    ei
    ret

.call_start_four_sound_tracks:
    call StartFourSoundTracks
    ei
    ret

.call_start_two_sound_tracks:
    call StartTwoSoundTracks

.done:
    ei
    ret

; wSoundEffectRequest = A: ProcessSoundQueue starts that sound effect (StartSoundEffect) in the next
; VBlank and sets the request back to $FF. (C2, E-0373)
; wSoundEffectRequest = A; ProcessSoundQueue starts it on the next frame
QueueSoundEffect::
    ld [wSoundEffectRequest], a
    ret

; A = sound effect id, stored in wSoundId; every register is kept. With interrupts disabled it
; starts one track (StartSound) for most ids, two (A and A + 1, StartTwoSoundTracks) for $63, $67,
; $70, $72, $74, $7E, $89, $8B, $8D, $91, $9F, $A5, $AC, $AE, $B2, $B6, $B8, $BA, $BD, $BF, $C1,
; $C3, $C5, $C7, $C9, $D2, $D4, $DA and $DD, and three (StartThreeSoundTracks) for $6D. Unlike
; StartMusic it does not reset the sound hardware. Called only by ProcessSoundQueue. (C1, E-0373)
; A = sound id: stores it in wSoundId and starts the effect (ids in a fixed list take a separate
; path)
StartSoundEffect::
    push af
    push bc
    push de
    push hl
    ld [wSoundId], a
    cp $63
    jr z, .call_start_two_sound_tracks
    cp $67
    jr z, .call_start_two_sound_tracks
    cp $6d
    jp z, .call_start_three_sound_tracks
    cp $70
    jr z, .call_start_two_sound_tracks
    cp $72
    jr z, .call_start_two_sound_tracks
    cp $74
    jr z, .call_start_two_sound_tracks
    cp $7e
    jr z, .call_start_two_sound_tracks
    cp $89
    jr z, .call_start_two_sound_tracks
    cp $8b
    jr z, .call_start_two_sound_tracks
    cp $8d
    jr z, .call_start_two_sound_tracks
    cp $91
    jr z, .call_start_two_sound_tracks
    cp $9f
    jr z, .call_start_two_sound_tracks
    cp $a5
    jr z, .call_start_two_sound_tracks
    cp $ac
    jr z, .call_start_two_sound_tracks
    cp $ae
    jr z, .call_start_two_sound_tracks
    cp $b2
    jr z, .call_start_two_sound_tracks
    cp $b6
    jr z, .call_start_two_sound_tracks
    cp $b8
    jr z, .call_start_two_sound_tracks
    cp $ba
    jr z, .call_start_two_sound_tracks
    cp $bd
    jr z, .call_start_two_sound_tracks
    cp $bf
    jr z, .call_start_two_sound_tracks
    cp $c1
    jr z, .call_start_two_sound_tracks
    cp $c3
    jr z, .call_start_two_sound_tracks
    cp $c5
    jr z, .call_start_two_sound_tracks
    cp $c7
    jr z, .call_start_two_sound_tracks
    cp $c9
    jr z, .call_start_two_sound_tracks
    cp $d2
    jr z, .call_start_two_sound_tracks
    cp $d4
    jr z, .call_start_two_sound_tracks
    cp $da
    jr z, .call_start_two_sound_tracks
    cp $dd
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

; Called from both branches of VBlankHandler: when wMusicRequest is not $FF it starts that music
; (StartMusic) and sets the request to $FF, then when wSoundEffectRequest is not $FF it starts that
; effect (StartSoundEffect) and sets it to $FF. QueueMusic and QueueSoundEffect fill the requests.
; (C1, E-0373)
; starts the music requested in wMusicRequest and the effect requested in wSoundEffectRequest
; (StartMusic / StartSoundEffect), then sets each request to $FF
ProcessSoundQueue::
    ld a, [wMusicRequest]
    cp $ff
    jr z, .check_sound_effect_request
    call StartMusic
    ld a, $ff
    ld [wMusicRequest], a

.check_sound_effect_request:
    ld a, [wSoundEffectRequest]
    cp $ff
    jr z, .return
    call StartSoundEffect
    ld a, $ff
    ld [wSoundEffectRequest], a

.return:
    ret

; A lone ret after the end of ProcessSoundQueue; it returns with every register unchanged. Nothing
; calls or jumps to it. (C2, E-0373)
; a lone ret after the sound-effect request step's ret; nothing reaches it (E-0239)
UnreferencedReturn_00_1339:: ; configured code entry (E-0239); C0
    ret

; A = fade level: clears wSoundFadeLevel and returns when wFieldInitStage is non-zero or A is 0 or
; has bit 7 set. Otherwise wSoundFadeLevel = A (halved with sra when wSGBActive is 0); then, unless
; rNR50 has bit 7 or bit 3 set or is 0 (which clear wSoundFadeLevel), it copies that level to
; wSoundFadeTarget and sets wSoundFadeTimer = 8 and wSoundFadeVolume = rNR50: the state
; StepMusicVolumeFade counts down. No caller was found. (C1, E-0373)
; with B = A: unless wFieldInitStage is set or A is 0 or has bit 7 set, stores A (halved when
; wSGBActive is 0) to wSoundFadeLevel and, when rNR50 bits 7 and 3 are clear and rNR50 is non-zero,
; sets wSoundFadeTarget to it, wSoundFadeTimer = 8 and wSoundFadeVolume = rNR50; otherwise clears
; wSoundFadeLevel; no caller found (E-0239)
UnreferencedStartSoundFadeA:: ; configured code entry (E-0239); C0
    ld b, a
    ld a, [wFieldInitStage]
    or a
    jr nz, .clear_sound_fade_level
    ld a, b
    bit 7, a
    jr nz, .clear_sound_fade_level
    or a
    jr z, .clear_sound_fade_level
    ld [wSoundFadeLevel], a
    ld a, [wSGBActive]
    or a
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
    or a
    jr z, .clear_sound_fade_level
    ld a, [wSoundFadeLevel]
    ld [wSoundFadeTarget], a
    ld a, $08
    ld [wSoundFadeTimer], a
    ldh a, [rNR50]
    ld [wSoundFadeVolume], a
    ret

.clear_sound_fade_level:
    xor a
    ld [wSoundFadeLevel], a
    ret

; Music volume fade, run once per frame from StepFade. When wSoundFadeLevel is set (and not bit 7,
; and no field set-up is in progress) it waits wSoundFadeTarget frames per step, then lowers each
; stereo side of the master volume (rNR50) by one, keeping the left/right enable bits; when the
; volume reaches 0, or wSoundFadeTimer steps have passed, the fade stops (wSoundFadeLevel = 0). (C1,
; E-0357)
StepMusicVolumeFade::
    ld a, [wFieldInitStage]
    or a
    jr nz, .clear_sound_fade_level
    ld a, [wSoundFadeLevel]
    bit 7, a
    jr nz, .clear_sound_fade_level
    or a
    ret z
    ld a, [wSoundFadeTarget]
    or a
    jr z, .skip
    dec a
    ld [wSoundFadeTarget], a
    ret

.skip:
    ldh a, [rNR50]
    and $88
    cp $88
    jr z, .clear_sound_fade_level
    ld a, [wSoundFadeVolume]
    or a
    jr z, .clear_sound_fade_level
    ld b, a
    and $0f
    ld d, a
    ld a, b
    swap a
    and $0f
    ld c, a
    bit 3, c
    jr nz, .skip2
    ld a, c
    or a
    jr z, .skip2
    dec c

.skip2:
    bit 3, d
    jr nz, .skip3
    ld a, d
    or a
    jr z, .skip3
    dec d

.skip3:
    ld a, c
    swap a
    or d
    ldh [rNR50], a
    ld [wSoundFadeVolume], a
    or a
    jr z, .skip4
    ld a, [wSoundFadeTimer]
    or a
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
    xor a
    ld [wSoundFadeLevel], a
    ret

; A = Super Game Boy border set: returns when A equals wSGBBorderSet; otherwise stores it there and,
; for sets 0-4, sends the border with three SGBTransferCompressed transfers, packet sets $10, $11
; and $0F with SGBBorder0TilesA, SGBBorder0TilesB and SGBBorder0MapAndPalettes (or the set 1-4
; copies), with a SpinDelay between them (and after the last for set 4). Any other set is only
; stored. Called by GameMode1_Init and by GameMode5_Init_TitleMenu (set 2, only when wSGBActive is
; set). (C1, E-0373)
; when A differs from wSGBBorderSet: sends the Super Game Boy border tiles, map and palettes of set
; A through three compressed transfers (SGBTransferCompressed) (E-0130)
LoadSGBBorderForSetA::
    ld hl, wSGBBorderSet
    cp [hl]
    ret z
    ld [hl], a
    cp $00
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
    ld a, $0f
    ld e, LOW(SGBBorder0MapAndPalettes)
    ld d, HIGH(SGBBorder0MapAndPalettes)
    ld b, BANK(SGBBorder0MapAndPalettes)
    call SGBTransferCompressed
    jp .return

.cp_01:
    cp $01
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
    ld a, $0f
    ld e, LOW(SGBBorder1MapAndPalettes)
    ld d, HIGH(SGBBorder1MapAndPalettes)
    ld b, BANK(SGBBorder1MapAndPalettes)
    call SGBTransferCompressed
    jp .return

.cp_02:
    cp $02
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
    ld a, $0f
    ld e, LOW(SGBBorder2MapAndPalettes)
    ld d, HIGH(SGBBorder2MapAndPalettes)
    ld b, BANK(SGBBorder2MapAndPalettes)
    call SGBTransferCompressed
    jr .return

.cp_03:
    cp $03
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
    ld a, $0f
    ld e, LOW(SGBBorder3MapAndPalettes)
    ld d, HIGH(SGBBorder3MapAndPalettes)
    ld b, BANK(SGBBorder3MapAndPalettes)
    call SGBTransferCompressed
    jr .return

.cp_04:
    cp $04
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
    ld a, $0f
    ld e, LOW(SGBBorder4MapAndPalettes)
    ld d, HIGH(SGBBorder4MapAndPalettes)
    ld b, BANK(SGBBorder4MapAndPalettes)
    call SGBTransferCompressed
    call SpinDelay

.return:
    ret
    db $c9

; Serial link re-synchronisation after a mode change (only when wLinkMode is set; otherwise it just
; clears the link state). With only the serial interrupt enabled it marks the link busy, lets the
; clock-receiving side wait about 24,576 loop passes, then exchanges a greeting: $F5 in link session
; 5, otherwise $70 | wIsCGB, expecting $70 or $71 back. It settles which side drives the clock
; (wLinkRole bit 1) from the two consoles' CGB flags, clears the busy bits, and resets
; wLinkExchangeState and the 14 joypad bytes from wJoypadHeld. (C1, E-0357)
ResumeAfterModeChange_ResyncLink::
    ld a, [wLinkMode]
    or a
    jp z, .clear_link_exchange_state
    ld a, $08
    call SetInterruptEnable
    ld a, [wLinkStatus]
    set 7, a
    res 6, a
    ld [wLinkStatus], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_link_session
    ld hl, 24576

.loop:
    dec hl
    ld a, h
    or l
    jr nz, .loop

.check_link_session:
    ei
    ld a, [wLinkSession]
    cp $05
    jr nz, .call_resume_after_mode_change_resync_link
    call ResumeAfterModeChange_ResyncLink_SendAck
    call WaitSerialTransferDone
    ldh a, [rSB]
    cp $f5
    call nz, ResumeAfterModeChange_ResyncLink_SendAck
    jr .read_link_status

.call_resume_after_mode_change_resync_link:
    call ResumeAfterModeChange_ResyncLink_SendGreeting
    cp $02
    jr z, .skip
    call WaitSerialTransferDone

.skip:
    ldh a, [rSB]
    cp $70
    jr z, .check_link_session2
    cp $71
    jr z, .check_link_session2
    call ResumeAfterModeChange_ResyncLink_SendGreeting

.check_link_session2:
    ld b, a
    ld a, [wLinkSession]
    cp $05
    jr z, .read_link_status
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_is_cgb
    ld a, [wIsCGB]
    and a
    jr nz, .read_link_status
    ld a, b
    bit 0, a
    jr z, .read_link_status
    ld a, [wLinkRole]
    set 1, a
    jr .set_link_role

.check_is_cgb:
    ld a, [wIsCGB]
    and a
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
    ld a, $f8
    call nz, SerialSendByte

.clear_link_exchange_state:
    xor a
    ld [wLinkExchangeState], a
    ld hl, wJoypadHeld
    ld b, $0e

.loop2:
    ld [hli], a
    dec b
    jr nz, .loop2
    ret

; Link greeting exchange: sends $70 | wIsCGB (driving the clock when wLinkRole bit 1 is clear,
; otherwise waiting for the partner's clock) and counts in wLinkTimer until the transfer completes
; (wLinkStatus bit 6). If the 16-bit count reaches $FF00 it gives up and sets wLinkFrameCounterHi to
; 2; otherwise returns A = 0. (C1, E-0357)
ResumeAfterModeChange_ResyncLink_SendGreeting::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_is_cgb
    ld a, [wIsCGB]
    or $70
    call StartSerialTransferInternalClock
    jr .loop

.check_is_cgb:
    ld a, [wIsCGB]
    or $70
    call SerialSendByte

.loop:
    ld a, [wLinkTimerLo]
    add $01
    ld [wLinkTimerLo], a
    ld a, [wLinkTimerHi]
    adc $00
    ld [wLinkTimerHi], a
    ld a, [wLinkTimerHi]
    cp $ff
    jr nc, .set_link_frame_counter_hi_to_02
    ld a, [wLinkStatus]
    bit 6, a
    jr z, .loop
    xor a
    ret

.set_link_frame_counter_hi_to_02:
    ld a, $02
    ld [wLinkFrameCounterHi], a
    ret

; Sends the link acknowledgement byte $F5 (as clock receiver or driver, by wLinkRole bit 1) and
; waits until the transfer completes (wLinkStatus bit 6). (C1, E-0357)
ResumeAfterModeChange_ResyncLink_SendAck::
    ld a, [wLinkRole]
    bit 1, a
    ld a, $f5
    call nz, SerialSendByte
    ld a, [wLinkRole]
    bit 1, a
    ld a, $f5
    call z, StartSerialTransferInternalClock

.loop:
    ld a, [wLinkStatus]
    bit 6, a
    jr z, .loop
    ret

; A = ROM bank, DE = source in that bank (rows packed, B bytes each), B = width, C = rows, HL = VRAM
; destination with rows 32 bytes apart (no wrap): maps the bank and copies the rectangle a byte at a
; time with WriteVRAMByteInc, then maps the calling bank back. DE ends past the source, HL at the
; start of the last row, B kept and C = 0. (C1, E-0373)
; A = ROM bank, DE = source in that bank, B = width, C = rows, HL = VRAM with rows 32 bytes apart:
; switches to the bank, copies the rectangle with WriteVRAMByteInc (interrupts off per byte; source
; rows packed), then restores the bank; B kept (E-0071)
CopyRectFromBankToVRAM::
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
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    jr .skip

.done:
    pop af
    ld [rROMB0], a
    ret

; A = ROM bank, DE = source in that bank (rows packed), B = width, C = rows, HL = BG map address:
; maps the bank and copies the rectangle with WriteVRAMByteInc, wrapping each row back to its own
; 32-entry line when it crosses column 31 and the rows inside $9800-$9BFF (H &= $9B); maps the
; calling bank back. B kept, C = 0. (C1, E-0373)
; A = ROM bank, DE = source in that bank, B = width, C = rows, HL = BG map address: switches to the
; bank and copies the rectangle with WriteVRAMByteInc (interrupts off per byte), wrapping columns
; inside each 32-entry row and rows inside $9800-$9BFF (H &= $9B); restores the bank (E-0090)
CopyRectFromBankToBGMapWrapped::
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
    and $1f
    jr nz, .next
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
    jr z, .done
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $9b
    ld h, a
    jr .skip

.done:
    pop af
    ld [rROMB0], a
    ret

; Copies $400 bytes, 32 rows of 32, from wScreenTileBuffer to vBGMap0 with WriteVRAMByte, wrapping
; the column inside each row and the rows inside $9800-$9BFF. Reads past the $240-byte buffer
; described in src/ram.asm. No caller was found. (C1, E-0373)
; copies the 32 x 32 wScreenTileBuffer to vBGMap0, wrapping columns and rows (E-0125)
CopyScreenTileBufferToBGMapWrapped::
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
    and $e0
    push af
    ld a, l
    inc a
    and $1f
    ld l, a
    pop af
    or l
    ld l, a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    push bc
    ld bc, $0020
    add hl, bc
    ld a, h
    and $03
    or $98
    ld h, a
    pop bc
    dec c
    jr nz, .loop
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy, BC = 0 and A = 0. The same 9 bytes appear in 13 banks. (C2, E-0373)
; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank00::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank00
    ret

; HL = A * C (8 x 8 bits), by two passes of Multiply8_AddFourBits (the second by falling through). A
; ends unchanged (rotated 8 times), B = the old C and C = 0. (C2, E-0373)
; HL = A * C (8 x 8 bit); clobbers A, B and C
Multiply8::
    ld b, $00
    ld h, b
    ld l, b
    call Multiply8_AddFourBits

; Four steps of the shift-and-add multiply: for each of the low four bits of A, rotated out with
; rrca, adds BC to HL when the bit is set and then doubles BC. A ends rotated right by 4 and BC
; multiplied by 16. (C2, E-0373)
; for four bits of A (rrca): adds BC to HL when the bit is set, doubling BC each time
Multiply8_AddFourBits::
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

; E:H:L = A * BC (a 24-bit product, E the high byte), from two Multiply8 calls (A * B and A * C); BC
; ends as A * the old B, and A = E. D is kept. (C2, E-0373)
; E:H:L = A * BC (24-bit product); clobbers A, BC, HL, E
Multiply8By16::
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
    add h
    ld h, a
    ld a, b
    adc $00
    ld e, a
    ret

; B = B / A (the quotient), A = the remainder, by 8 shift-and-subtract steps that also handle a
; divisor above $80; D = 0 and E = the divisor on return. (C2, E-0373)
; B = B / A (quotient), A = remainder; clobbers D, E
DivideBByA::
    ld d, $08
    ld e, a
    xor a

.loop:
    sla b
    rla
    jr c, .skip
    cp e
    jr c, .next

.skip:
    sub e
    inc b

.next:
    dec d
    jr nz, .loop
    ret

; HL = HL / A (the quotient), A = the remainder, by 16 shift-and-subtract steps; D = 0 and E = the
; divisor on return. (C2, E-0373)
; HL = HL / A (quotient in HL), A = remainder; clobbers D, E
DivideHLByA::
    ld d, $10
    ld e, a
    xor a

.loop:
    add hl, hl
    rla
    jr c, .skip
    cp e
    jr c, .next

.skip:
    sub e
    inc l

.next:
    dec d
    jr nz, .loop
    ret

; E:H:L = E:H:L / A (a 24-bit quotient, E the high byte), A = the remainder, by 24
; shift-and-subtract steps; B = the divisor and D = 0 on return. (C2, E-0373)
; E:H:L = E:H:L / A (24-bit quotient), A = remainder; clobbers B, D
Divide24ByA::
    ld d, $18
    ld b, a
    xor a

.loop:
    add hl, hl
    rl e
    rla
    jr c, .skip
    cp b
    jr c, .next

.skip:
    sub b
    inc l

.next:
    dec d
    jr nz, .loop
    ret

; Splits HL into decimal digits: wDigits = hundreds, wDigits + 1 = tens, wDigits + 2 = ones (for HL
; above 999 the first byte is HL / 100). HL ends as the ones value. (C2, E-0373)
; HL (0-999) becomes three digits: wDigits = hundreds, wDigits + $1 = tens, wDigits + $2 = ones
HLToDecimalDigits::
    xor a
    ld [wDigits], a
    ld [wDigits + $1], a
    ld [wDigits + $2], a

.loop:
    ld a, [wDigits]
    inc a
    ld [wDigits], a
    ld bc, -100
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
    ld bc, -10
    add hl, bc
    ld a, h
    rlc a
    jr nc, .loop2
    ld bc, $000a
    add hl, bc
    ld a, [wDigits + $1]
    dec a
    ld [wDigits + $1], a
    ld a, l
    ld [wDigits + $2], a
    ret

; Converts the 24-bit value at wDigits (low byte first) by repeated subtraction: hTemp3 = the count
; of millions (a binary number, up to 16), hTemp2 = hundred-thousands and ten-thousands, hTemp1 =
; thousands and hundreds, hTemp0 = tens and ones (two digits per byte, the higher digit in the upper
; nibble). wDigits is used as the remainder and ends as the ones digit, 0, 0. (C2, E-0373)
; the 24-bit value at wDigits-wDigits + $2 (low byte first) becomes decimal digits: hTemp3 =
; millions, hTemp2 = hundred-thousands and ten-thousands, hTemp1 = thousands and hundreds, hTemp0 =
; tens and ones (two digits per byte, high digit in the upper nibble); wDigits-wDigits + $2 are
; consumed
Number24ToPackedBCD::
    xor a
    ldh [hTemp3], a
    ldh [hTemp2], a
    ldh [hTemp1], a
    ldh [hTemp0], a
    ld hl, wDigits
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld d, a
    ld e, $00

.skip:
    ld a, c
    sub $40
    ld c, a
    ld a, b
    sbc $42
    ld b, a
    ld a, d
    sbc $0f
    ld d, a
    jr c, .set_temp3
    ld hl, wDigits
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, d
    ld [hli], a
    inc e
    jr .skip

.set_temp3:
    ld a, e
    ldh [hTemp3], a
    ld hl, wDigits
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld d, a
    ld e, $00

.skip2:
    ld a, c
    sub $a0
    ld c, a
    ld a, b
    sbc $86
    ld b, a
    ld a, d
    sbc $01
    ld d, a
    jr c, .set_temp2
    ld hl, wDigits
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, d
    ld [hli], a
    inc e
    jr .skip2

.set_temp2:
    ld a, e
    swap a
    ldh [hTemp2], a
    ld hl, wDigits
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld d, a
    ld e, $00

.skip3:
    ld a, c
    sub $10
    ld c, a
    ld a, b
    sbc $27
    ld b, a
    ld a, d
    sbc $00
    ld d, a
    jr c, .read_temp2
    ld hl, wDigits
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, d
    ld [hli], a
    inc e
    jr .skip3

.read_temp2:
    ldh a, [hTemp2]
    add e
    ldh [hTemp2], a
    ld hl, wDigits
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld e, $00

.skip4:
    ld a, c
    sub $e8
    ld c, a
    ld a, b
    sbc $03
    ld b, a
    jr c, .set_temp1
    ld hl, wDigits
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    inc e
    jr .skip4

.set_temp1:
    ld a, e
    swap a
    ldh [hTemp1], a
    ld hl, wDigits
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld e, $00

.skip5:
    ld a, c
    sub $64
    ld c, a
    ld a, b
    sbc $00
    ld b, a
    jr c, .read_temp1
    ld hl, wDigits
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    inc e
    jr .skip5

.read_temp1:
    ldh a, [hTemp1]
    add e
    ldh [hTemp1], a
    ld a, [wDigits]
    ld e, $00

.skip6:
    sub $0a
    jr c, .read_digits
    ld [wDigits], a
    inc e
    jr .skip6

.read_digits:
    swap e
    ld a, [wDigits]
    add e
    ldh [hTemp0], a
    ret

; DE = flag number: tests bit DE & 7 of the byte wStoryFlags + DE / 8 (DE shifted right
; arithmetically, no range check). Returns carry set and A = the masked bit when the flag is set, A
; = 0 with carry clear and Z set otherwise; B and C are clobbered. (C2, E-0373)
; DE = bit number; tests that bit of the bit array at wStoryFlags (bit 0 of the first byte first);
; returns carry set when it is 1, A = 0 and carry clear otherwise; no range check
TestFlagBit::
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add $d7
    ld e, a
    ld a, d
    adc $cb
    ld d, a
    ld c, $01
    ld a, b
    and $07
    jr z, .skip
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip:
    ld a, [de]
    and c
    jr nz, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; DE = flag number: sets bit DE & 7 of the byte wStoryFlags + DE / 8. When DE is $0300 or more (D >=
; 3) it never returns: the branch it takes is a jr to itself. (C2, E-0373)
; DE = bit number; sets that bit of the bit array at wStoryFlags; when DE >= $0300 (D >= 3) it never
; returns: the branch target `.skip2` is a `jr` to itself (E-0353: corrected; was: DE = bit number;
; sets that bit of the bit array at wStoryFlags; does nothing when DE >= $0300)
SetFlagBit::
    ld a, d
    cp $03
    jr nc, .skip2
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add $d7
    ld e, a
    ld a, d
    adc $cb
    ld d, a
    ld c, $01
    ld a, b
    and $07
    jr z, .skip
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip:
    ld a, [de]
    or c
    ld [de], a
    ret

.skip2:
    jr .skip2

; B = ROM bank, DE = address: C = the byte at [DE] with that bank mapped; the calling bank is mapped
; back (A ends as its number). (C2, E-0373)
; B = ROM bank, DE = address; C = the byte at [DE] in that bank; the caller's bank is restored
ReadByteInBank::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

; HL = VRAM destination, B = width, C = height in tiles: writes B * C copies of the 16-byte tile
; pattern at SolidColor1Tile ($FF, $00 repeated: every pixel colour 1, the bytes after
; FillTilesFromRequest) one after another from HL, each byte with interrupts disabled after rSTAT
; bit 1 clears. Keeps B in wTextWindowTileLo between rows and leaves it there. HL ends past the last
; tile. (C1, E-0373)
; HL = destination, B = width, C = height: writes the 16-byte pattern at SolidColor1Tile B * C
; times, each byte after waiting for VRAM access; wTextWindowTileLo holds B between rows
FillTilesBxC::
    ld a, b
    ld [wTextWindowTileLo], a

.loop:
    push bc
    ld de, SolidColor1Tile
    ld c, $10

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    ld [hli], a
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

; B = width, C = rows, DE = source (rows packed), HL = BG map address: copies the B x C rectangle in
; the current bank, wrapping each row back to its own 32-entry line when it crosses column 31 and
; the rows inside $9800-$9BFF (H &= $9B). Each byte is written with interrupts disabled after rSTAT
; bit 1 clears. DE ends past the source, HL at the start of the last row, C = 0 and B kept. (C1,
; E-0373)
; B = width, C = rows, DE = source, HL = BG map address: copies a B x C rectangle, wrapping columns
; inside each 32-entry row and rows inside $9800-$9BFF (H &= $9B). Each byte is written with
; interrupts off after rSTAT bit 1 clears. DE ends past the source, HL at the last row start, C = 0;
; B kept (E-0059)
CopyRectToBGMapWrapped::
    push hl
    push bc

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next
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
    jr CopyRectToBGMapWrapped

.return:
    ret

; With ROM bank B mapped, reads a far pointer at DE: HL = the word, B = the byte after it (its
; bank). DE ends at that third byte (DE + 2, not past it); the calling bank is mapped back (A = its
; number). The 27 bytes after the ret are not reached from it. (C2, E-0373)
; with ROM bank B mapped, reads three bytes at DE: HL = the word, B = the third byte (a far pointer:
; address then bank); DE += 3; restores the bank (E-0090)
ReadFarPointerAtDEInBankB::
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
    db $fa, $00, $40, $f5, $3e, $61, $ea, $00, $21, $f0, $c6, $6f, $26, $00, $29, $7d
    db $c6, $05, $6f, $7c, $ce, $67, $67, $3e, $02, $18, $19

; hTemp0 = special map number: loads the screen (hMapScreenX, hMapScreenY) of a special map. With
; bank $61 mapped it follows SpecialMapTable entry hTemp0 to the 26-byte record and takes the far
; pointer at record + $14 (the screen tile-map array); entry 3 * (hMapScreenY * wMapWidthScreens +
; hMapScreenX) of that array is a far pointer to a stream that DecompressToVRAM expands into
; wScreenTileBuffer. On CGB the array at record + $17 gives the attribute stream, expanded into
; wScreenAttrBuffer with rSVBK = 2 (then 0). Leaves hTemp0/hTemp1 = the address record + $14 and
; hTemp2/hTemp3 = the array offset; maps the calling bank back. C is not read (LoadMapScreen_Type6
; sets it before calling). (C1, E-0373)
; for the current map screen decompresses its tile block (chunk table in bank $61, indexed by hTemp0
; and the screen position) into wScreenTileBuffer, and on CGB its attributes (E-0130)
LoadSpecialMapScreen::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $61
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add $d8
    ld l, a
    ld a, h
    adc $60
    ld h, a
    ld a, $14
    push af
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop af
    add l
    ld l, a
    ldh [hTemp0], a
    ld a, h
    adc $00
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
    add a
    add c
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    ld c, a
    add a
    add c
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
    or a
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
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

; Loads the screen (hMapScreenX, hMapScreenY) of map hMapId into wScreenTileBuffer (and
; wScreenAttrBuffer on CGB). Special maps (wMapType bit 7) go to LoadMapScreen_SpecialMap.
; Otherwise, with bank $11 mapped, it takes the record (MapRecordPointer) and the RAM address at
; record + $10 (wStoryFlags + $60 on map 1); the highest set bit n of that byte picks the 6-byte
; variant at record + $18 + 6 * n, or record + $12 when no bit is set. The variant holds two far
; pointers to arrays of 3-byte far pointers indexed by hMapScreenY * wMapWidthScreens + hMapScreenX:
; the tile-map stream, expanded with DecompressToVRAM into wScreenTileBuffer, and on CGB the
; attribute stream into wScreenAttrBuffer (rSVBK 2, then 0). Then it runs ApplyMapScreenFlagEvents,
; LoadMapScreen_PatchStrongestMasterTiles and LoadMapScreen_DrawMarker and maps the calling bank
; back. (C1, E-0373)
; loads the screen at (hMapScreenX, hMapScreenY) of map hMapId: finds the map record
; (MapRecordPointer), picks one of its variants by the highest set bit of the flag byte whose RAM
; address is stored in the record, decompresses that variant's tile-map stream (an array of far
; pointers, indexed by row * width + column) into wScreenTileBuffer and, on CGB, the attribute
; stream into wScreenAttrBuffer (WRAM bank 2); then runs the map's tile-replacement table
; (ApplyMapScreenFlagEvents) and two map-specific fix-ups (LoadMapScreen_PatchStrongestMasterTiles,
; LoadMapScreen_DrawMarker); hands over to LoadMapScreen_SpecialMap when wMapType bit 7 is set
LoadMapScreen::
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall LoadMapScreen_SpecialMap
    ret

.skip:
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    call MapRecordPointer
    ld a, $10
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, l
    add $30
    ld l, a
    ld a, h
    adc $00
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [hl]
    ld [rROMB0], a
    ld a, [wMapWidthScreens]
    ld c, a
    add a
    add c
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    ld c, a
    add a
    add c
    add_a_to_hl
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop af
    ld [rROMB0], a
    ld a, [wIsCGB]
    or a
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
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
    call LoadMapScreen_PatchStrongestMasterTiles
    call LoadMapScreen_DrawMarker
    ret

; Draws a map's special 2x2 marker, unless wMapType bit 7 is set. The table after the routine (code
; at MapMarkerRecords) holds 3-byte entries (map id, position, screen) for 11 maps ending with $FF;
; for the entry matching hMapId it draws the marker with LoadMapScreen_DrawMarker_IfOnScreen,
; passing the entry's index in hTemp0. In a key world (wKeyWorldActive) whose key (wKeyWorldKey) is
; that index + 1, the position comes from wKeyWorldGoal instead. What the marker shows in play is
; not yet confirmed. (C2, E-0369; probed E-0374)
LoadMapScreen_DrawMarker::
    ld a, [wMapType]
    bit 7, a
    jp nz, .return
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, MapMarkerRecords

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .skip2
    ret

.skip2:
    cp c
    jr z, .check_key_world_active
    inc hl
    inc hl
    inc hl
    inc b
    jr .skip

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a
    jr z, .skip3
    ld a, [wKeyWorldKey]
    dec a
    cp b
    jr nz, .skip3
    ld de, wKeyWorldGoal
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_DrawMarker_IfOnScreen
    ret

.skip3:
    ld e, l
    ld d, h
    inc de
    ld a, b
    ldh [hTemp0], a
    call LoadMapScreen_DrawMarker_IfOnScreen
    ret

.return:
    ret

; Map marker records of 3 bytes up to $FF: the map id, the marker position (column in the high
; nibble, metatile row in the low) and its screen (screen X in the high nibble, Y in the low).
; LoadMapScreen_DrawMarker walks them comparing the first byte with hMapId;
; LoadMapScreen_DrawMarker_IfOnScreen compares the third byte with the current screen and draws the
; marker at the position. (C1, E-0389)
MapMarkerRecords::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00, $ff

; Draws the marker of LoadMapScreen_DrawMarker when its screen byte (screen X in the high nibble, Y
; in the low) matches the current screen (hMapScreenX, hMapScreenY). DE points at the position byte,
; whose low nibble gives the metatile row and high nibble the column; tiles $46 $47 over $56 $57 go
; into wScreenTileBuffer, and on CGB the same cells of wScreenAttrBuffer (WRAM bank 2) get palette 3
; (entries 4 and 10), 5 (entries 5-7) or 1 (others), by the entry index in hTemp0. (C2, E-0369;
; probed E-0374)
LoadMapScreen_DrawMarker_IfOnScreen::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    inc de
    ld a, [de]
    cp c
    ret nz
    dec de
    push hl
    ld a, [de]
    and $0f
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    and $0f
    add_a_to_hl
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    swap a
    and $0f
    sla a
    add_a_to_hl
    push hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld a, $46
    ld [hli], a
    inc a
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, $56
    ld [hli], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    ld c, $03
    ldh a, [hTemp0]
    cp $04
    jr z, .skip
    cp $0a
    jr z, .skip
    ld c, $05
    cp $05
    jr z, .skip
    cp $06
    jr z, .skip
    cp $07
    jr z, .skip
    ld c, $01

.skip:
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.done:
    pop hl
    ret

; After the story flag EVENT_SCENE_STRONGEST_MASTER is set, patches two map screens at screen X 0:
; map $0D gets tiles $44 $45 over $46 $47 at wScreenTileBuffer + $14A, and map $05 gets $78 $79 over
; $7A $7B at wScreenTileBuffer + $32. What the changed tiles show is not yet confirmed. (C2, E-0357;
; probed E-0374)
LoadMapScreen_PatchStrongestMasterTiles::
    ld de, EVENT_SCENE_STRONGEST_MASTER
    call TestFlagBit
    ret nc
    ldh a, [hMapScreenX]
    or a
    ret nz
    ldh a, [hMapId]
    cp $0d
    jr nz, .cp_05
    ld hl, wScreenTileBuffer + $14a
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
    cp $05
    ret nz
    ld hl, wScreenTileBuffer + $32
    ld [hl], $78
    inc hl
    ld [hl], $79
    ld a, $13
    add_a_to_hl
    ld [hl], $7a
    inc hl
    ld [hl], $7b
    ret

; hTemp0 = special map number: with bank $61 mapped it follows SpecialMapTable entry hTemp0 to the
; record, expands its first far-pointer stream (the tileset) into vTiles2 with DecompressToVRAM,
; loads the palettes of the second with LoadBGPaletteBufferFromBank, then stores the next five bytes
; in wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wMapHeaderByte7 and wFieldEventKind and
; clears wEncounterRate, wMapMoveType, wMapSpriteKind and wMapTallTileMin. Maps the calling bank
; back. The special-map counterpart of LoadMapHeader, called by LoadMapHeaderByMapType_Type7, _Type6
; and others in bank $61. (C1, E-0373)
; hTemp0 = index into a table at bank $61 $60D8 of special map records: decompresses the first
; far-pointer stream to vTiles2, handles the second with LoadBGPaletteBufferFromBank, then stores
; the next five bytes in wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wMapHeaderByte7 and
; wFieldEventKind and clears wEncounterRate, wMapMoveType-wMapTallTileMin
LoadSpecialMapHeader::
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
    add $d8
    ld l, a
    ld a, h
    adc $60
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    call LoadBGPaletteBufferFromBank
    pop hl
    ld a, [hli]
    ld [wMapWidthScreens], a
    ld a, [hli]
    ld [wMapHeightScreens], a
    ld a, [hli]
    ld [wMaxBlockingTile], a
    ld a, [hli]
    ld [wMapHeaderByte7], a
    ld a, [hli]
    ld [wFieldEventKind], a
    xor a
    ld [wEncounterRate], a
    ld [wMapMoveType], a
    ld [wMapSpriteKind], a
    ld [wMapTallTileMin], a
    pop af
    ld [rROMB0], a
    ret

; Loads the header of map hMapId; special maps (wMapType bit 7) go to LoadMapHeaderByMapType.
; Otherwise, with bank $11 mapped, it reads the record (MapRecordPointer): the tileset far pointer
; is expanded into vTiles2 (map $14 expands it into vTiles1, then MonsterSceneBackdropTiles into
; vTiles2, and clears wMenuState and wMenuSubState); the palette far pointer goes to
; LoadBGPaletteBufferFromBank; then wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile,
; wMapHeaderByte7, wFieldEventKind, wEncounterRate (with bit 7 set), wMapMoveType and
; wMapSpriteKind. When wMapSpriteKind is non-zero the next byte goes to wMapTallTileMin (low nibble
; non-zero) or wMapEventTile (low nibble 0). It ends with the map-specific fix-ups
; SetMapSpriteKindAndEventTileForSpecialMaps, PatchTilesOnMap1Or2 and
; SetFieldEventKindOnMap19IfFlagD1, and maps the calling bank back. (C1, E-0373)
; loads the current map's graphics, palette, size (wMapWidthScreens/HeightScreens), wMaxBlockingTile
; and other header bytes from the bank-$11 map record (special maps use LoadMapHeaderByMapType)
; (E-0128)
LoadMapHeader::
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    ld hl, vTiles2
    ldh a, [hMapId]
    cp $14
    jr nz, .call_decompress_to_vram
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, MonsterSceneBackdropTiles
    ld b, $48
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    xor a
    ld [wMenuState], a
    ld [wMenuSubState], a
    jr .skip2

.call_decompress_to_vram:
    call DecompressToVRAM
    pop hl

.skip2:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    call LoadBGPaletteBufferFromBank
    pop hl
    ld a, [hli]
    ld [wMapWidthScreens], a
    ld a, [hli]
    ld [wMapHeightScreens], a
    ld a, [hli]
    ld [wMaxBlockingTile], a
    ld a, [hli]
    ld [wMapHeaderByte7], a
    ld a, [hli]
    ld [wFieldEventKind], a
    ld a, [hli]
    or $80
    ld [wEncounterRate], a
    ld a, [hli]
    ld [wMapMoveType], a
    ld a, [hli]
    ld [wMapSpriteKind], a
    or a
    jr z, .call_set_map_sprite_kind_and_event_tile_for
    and $0f
    jr z, .set_map_event_tile
    ld a, [hli]
    ld [wMapTallTileMin], a
    jr .call_set_map_sprite_kind_and_event_tile_for

.set_map_event_tile:
    ld a, [hli]
    ld [wMapEventTile], a

.call_set_map_sprite_kind_and_event_tile_for:
    call SetMapSpriteKindAndEventTileForSpecialMaps
    call PatchTilesOnMap1Or2
    call SetFieldEventKindOnMap19IfFlagD1
    pop af
    ld [rROMB0], a
    ret

; On map $19 (hMapId), when EVENT_SCENE_DARCK_DEFEATED is set, sets wFieldEventKind = $0B. Its ld a,
; [wStoryFlags + $60] / ret nz tests the Z flag left by the map compare, so that byte never stops
; it. Run at the end of LoadMapHeader. (C2, E-0373)
; on map $19, if story flag $D1 is set, wFieldEventKind = $0B; its `ld a, [wStoryFlags + $60] / ret
; nz` tests the flags of the map compare, so that byte never stops it (executed with the byte $00
; and $FF, test Map19StoryByteCheckNeverReturns) (E-0122, E-0154)
SetFieldEventKindOnMap19IfFlagD1::
    ldh a, [hMapId]
    cp $19
    ret nz
    ld a, [wStoryFlags + $60]
    ret nz
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld a, $0b
    ld [wFieldEventKind], a
    ret

; Run at the end of LoadMapHeader. When bit 1 of wStoryFlags + $60 is set
; (SceneRivalDefeated_GiveKey sets it) and bit 5 is clear (SceneDarckDefeated_WarpToKing sets it):
; on map 1 it copies tile $50 of vTiles2 over tile $51 and the four tiles Tiles_00_1D07 over tiles
; $12-$15; on map 2 tile $40 over $41 and Tiles_00_1D07 over tiles $2A-$2D (CopyBBytesToVRAMFromDE).
; Other maps are left alone. (C1, E-0373)
; when bit 1 of wStoryFlags + $60 is set (and bit 5 clear) on map 1 or 2, shifts a tile row in
; vTiles2 and copies $40 bytes from $1D07 (tile animation) (E-0125)
PatchTilesOnMap1Or2::
    ld a, [wStoryFlags + $60]
    bit 5, a
    ret nz
    bit 1, a
    ret z
    ldh a, [hMapId]
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip2
    ret

.skip:
    ld de, vTiles2 + $500
    ld hl, vTiles2 + $510
    ld b, $10
    call CopyBBytesToVRAMFromDE
    ld de, Tiles_00_1D07
    ld hl, vTiles2 + $120
    ld b, $40
    call CopyBBytesToVRAMFromDE
    ret

.skip2:
    ld de, vTiles2 + $400
    ld hl, vTiles2 + $410
    ld b, $10
    call CopyBBytesToVRAMFromDE
    ld de, Tiles_00_1D07
    ld hl, vTiles2 + $2a0
    ld b, $40
    call CopyBBytesToVRAMFromDE
    ret

; Copies B bytes from DE to HL (both may be VRAM): each byte is read with interrupts disabled after
; WaitForVRAMAccess and written with WriteVRAMByteInc. DE and HL end past the copy, B = 0. (C1,
; E-0373)
; copies B bytes from DE to VRAM at HL, each read after WaitForVRAMAccess with interrupts off and
; written with WriteVRAMByteInc (E-0117)
CopyBBytesToVRAMFromDE::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, CopyBBytesToVRAMFromDE
    ret

; 64 bytes copied into vTiles uncompressed (E-0168)
; record: one 16-byte tile (2bpp) per line
Tiles_00_1D07::
    db $ff, $1e, $e1, $21, $df, $5f, $e2, $62, $9c, $9c, $a4, $a4, $c4, $c4, $ce, $4e ; id 0
    db $ff, $78, $87, $84, $fb, $fa, $67, $66, $39, $39, $25, $25, $23, $23, $33, $32 ; id 1
    db $df, $53, $ff, $62, $f6, $0a, $ff, $04, $fc, $04, $bf, $48, $ff, $10, $ff, $0f ; id 2
    db $7b, $6a, $bf, $e6, $ff, $22, $9f, $10, $fd, $12, $8f, $08, $ff, $04, $ff, $f8 ; id 3

; Run at the end of LoadMapHeader: overrides the header bytes wMapSpriteKind and wMapEventTile on
; some maps: $11 and $2C on maps $30 and $B8, $22 and $30 on maps $63-$66, $12 and $2C on map $70.
; Other maps are left alone. (C2, E-0373)
; sets wMapSpriteKind/wMapEventTile to $11/$2C on maps $30 and $B8, $22/$30 on maps $63-$66, $12/$2C
; on map $70 (E-0125) (E-0345: header byte $11 is wMapEventTile; was
; SetMapSpriteKindAndEventTileForSpecialMaps)
SetMapSpriteKindAndEventTileForSpecialMaps::
    ldh a, [hMapId]
    cp $30
    jr z, .set_map_sprite_kind_to_11
    cp $b8
    jr nz, .cp_63

.set_map_sprite_kind_to_11:
    ld a, $11
    ld [wMapSpriteKind], a
    ld a, $2c
    ld [wMapEventTile], a
    ret

.cp_63:
    cp $63
    jr c, .cp_70
    cp $67
    jr nc, .cp_70
    ld a, $22
    ld [wMapSpriteKind], a
    ld a, $30
    ld [wMapEventTile], a
    ret

.cp_70:
    cp $70
    jr nz, .return
    ld a, $12
    ld [wMapSpriteKind], a
    ld a, $2c
    ld [wMapEventTile], a
    ret

.return:
    ret

; HL = DE = the word at MapTable + 2 * hMapId: the map record of the current map. The caller maps
; bank $11 (MapTable) first, as LoadMapScreen and LoadMapHeader do. (C2, E-0373)
; HL = the word at MapTable + 2 * hMapId (bank $11)
MapRecordPointer::
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, MapTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ret

; Debug map editor check of the edit position. With bank $11 mapped it follows entry hTemp0 of the
; pointer table at $44B8 to a map record and returns A = 1 when the position is outside it:
; wDebugValue1 not below the record byte 6 (its width) or wDebugValue3 not below byte 7 (its
; height). Otherwise it picks a cell table by the byte at the record pointer at offset 16 (a RAM
; byte such as $CC37 in the records read): the highest set bit N chooses the 6-byte entry at offset
; $18 + 6 * N (bit 7 first), and no set bit the entry at offset $12; the entry starts with a table
; address and its ROM bank, which is mapped. It returns A = 1 when the 3-byte cell at row
; wDebugValue3, column wDebugValue1 (row size = width * 3, computed in 8 bits) holds a zero word,
; otherwise A = 0, and restores the ROM bank. (C2, E-0374)
DebugMapEditor_CheckPosition::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add $b8
    ld l, a
    ld a, h
    adc $44
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, $06
    add_a_to_hl
    ld a, [wDebugValue1]
    ld c, a
    ld a, [hli]
    ldh [hTemp0], a
    cp c
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
    ld a, [hli]
    cp c
    jr z, .loop
    jr c, .loop
    ld a, $08
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, l
    add $30
    ld l, a
    ld a, h
    adc $00
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hTemp0]
    ld c, a
    sla a
    add c
    ld c, a
    ld a, [wDebugValue3]
    call Multiply8
    ld a, [wDebugValue1]
    ld c, a
    sla a
    add c
    add_a_to_hl
    add hl, de
    ld a, [hli]
    ld c, a
    ld a, [hl]
    or c
    jr nz, .restore
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

.restore:
    pop af
    ld [rROMB0], a
    xor a
    ret

; HL = BG map address: draws the 20 x 18 entries of wScreenTileBuffer (rows of 20) with
; WriteVRAMByteInc, wrapping each row back to its own 32-entry line and the rows inside $9800-$9BFF.
; On CGB it then draws the same cells of wScreenAttrBuffer (rSVBK = 2), masked to the palette bits
; (& $07), into VRAM bank 1, and sets rSVBK and rVBK back to 0. HL is kept on DMG; on CGB it ends at
; the start of the last row. (C1, E-0373)
; HL = BG map address: draws the 20 x 18 entries of wScreenTileBuffer, wrapping columns inside each
; 32-entry row and rows inside $9800-$9BFF; on CGB then draws the attribute bytes at
; wScreenAttrBuffer (rSVBK = 2), masked to the palette bits (& $07), into VRAM bank 1; HL kept
; (E-0071)
DrawFullScreenBufferToBGMap::
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
    and $1f
    jr nz, .next
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
    jr z, .check_is_cgb
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    jr .skip

.check_is_cgb:
    pop hl
    ld a, [wIsCGB]
    or a
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
    and $07
    call WriteVRAMByteInc
    ei
    ld a, l
    and $1f
    jr nz, .next2
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
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
    and $9b
    ld h, a
    jr .skip2

.skip3:
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; HL = BG map address: draws 20 x 13 entries of wScreenTileBuffer (rows of 20) to the BG map with
; the same wrapping as DrawFullScreenBufferToBGMap, each byte written with interrupts disabled after
; rSTAT bit 1 clears. When wTextWindowState bit 7 is set it starts 5 rows lower in both (source +
; $64, BG map + $A0 kept inside $9800-$9BFF). On CGB it then draws the same cells of
; wScreenAttrBuffer ($E68 after the tile source, rSVBK = 2) & $07 into VRAM bank 1, and sets rSVBK
; and rVBK back to 0. PrintTextStep calls it after a yes/no choice with HL at the scroll origin in
; vBGMap0, and DrawScreenBufferAtScrollOrigin (bank $85) calls it too. (C1, E-0373)
; copies the 20 x 13 screen-buffer area (offset by bit 7 of wTextWindowState) to the BG map at HL,
; wrapping, and on CGB its attributes from WRAM bank 2 (E-0130)
DrawScreenBufferToBGMapWithAttrs::
    ld de, wScreenTileBuffer
    ld a, [wTextWindowState]
    bit 7, a
    jr z, .skip2
    ld a, $64
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $a0
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a

.skip2:
    push de
    push hl
    ld bc, $140d

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
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next
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
    jr z, .check_is_cgb
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    jr .skip3

.check_is_cgb:
    pop hl
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add $68
    ld e, a
    ld a, d
    adc $0e
    ld d, a
    ld bc, $140d

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
    and $07
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next2
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
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
    and $9b
    ld h, a
    jr .skip4

.skip5:
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; A = party slot, C = field offset: maps A through MapIndexViaPartyList (the record number
; wPartyList + (A & $7F), or A itself when wLinkMode is non-zero and wGameMode is 4) and returns HL
; = sRecords + record * $A5 + C. BC is kept; it maps no SRAM bank (the caller does). (C2, E-0373)
; A is first passed through MapIndexViaPartyList; then HL = sRecords + A * $A5 + C as in
; SRAMRecordAddress
SRAMRecordAddressMapped::
    push bc
    call MapIndexViaPartyList
    ld c, $a5
    call Multiply8
    ld bc, sRecords
    add hl, bc
    pop bc
    ld a, c
    add_a_to_hl
    ret

; Copies B bytes from hTemp0 on to field C of the record for party slot A (SRAMRecordAddressMapped),
; in the SRAM bank already mapped; HL and DE are kept. No caller was found. (C2, E-0373)
; copies B bytes from hTemp0 to field C of SRAM record A (SRAMRecordAddressMapped); HL and DE
; preserved (E-0122)
StoreTemp0ToSRAMRecordBytes::
    push hl
    push de
    call SRAMRecordAddressMapped
    ld de, hTemp0

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop de
    pop hl
    ret

; Copies B bytes of field C of the record for party slot A (SRAMRecordAddressMapped), in the SRAM
; bank already mapped, to hTemp0 on; HL and DE are kept. No caller was found. (C2, E-0373)
; copies B bytes of field C of SRAM record A to hTemp0; HL and DE preserved (E-0122)
LoadSRAMRecordBytesToTemp0::
    push hl
    push de
    call SRAMRecordAddressMapped
    ld de, hTemp0

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    ret

; A = record number (used directly, not mapped through wPartyList), C = field offset: hTemp0 = A =
; the byte at sRecords + A * $A5 + C (SRAMRecordAddress) in the SRAM bank already mapped; HL is
; kept. (C2, E-0373)
; A = record, C = offset; hTemp0 = the byte at sRecords + A * $A5 + C; HL preserved
LoadSRAMRecordByte::
    push hl
    call SRAMRecordAddress
    ld a, [hl]
    ldh [hTemp0], a
    pop hl
    ret

; A = record number, C = field offset: loads the word at sRecords + A * $A5 + C (SRAMRecordAddress,
; no party mapping) into hTemp0 (low byte) and hTemp1 (high byte) and returns A = the high byte; HL
; kept. The caller enables SRAM first (rRAMG = $0A); callers read words such as MON_SPECIES, MON_HP
; and MON_MAX_HP. (C2, E-0373)
; like LoadSRAMRecordByte but loads the word into hTemp0 (low) and hTemp1 (high)
LoadSRAMRecordWord::
    push hl
    call SRAMRecordAddress
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    pop hl
    ret

; A = record number, C = field offset: copies the three bytes at sRecords + A * $A5 + C
; (SRAMRecordAddress) to hTemp0-hTemp2, low byte first; HL kept. All three callers pass C = MON_EXP,
; so it loads the 24-bit experience (DrawRecordExperience twice and a party loop in bank $12). (C2,
; E-0373)
; A = record, C = field offset (SRAMRecordAddress): copies three bytes from the record to
; hTemp0-hTemp2; HL kept (E-0108)
LoadRecordThreeBytesToTemp0::
    push hl
    call SRAMRecordAddress
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hli]
    ldh [hTemp2], a
    pop hl
    ret

; A = record number, C = field offset (callers pass MON_NAME, once MON_MASTER_NAME): copies the 10
; bytes at sRecords + A * $A5 + C to wNameGlyphBuf and returns A = 0 with carry clear (Z set). When
; the first byte is $FF it writes '???' and two spaces ($98, $98, $98, $90, $90) to wNameGlyphBuf
; instead, leaves the bytes after them, and returns A = $FF with carry set. DE and HL kept; B is
; clobbered (0 after a copy). The caller enables SRAM. (C2, E-0373)
; A = record number, C = offset (see SRAMRecordAddress): copies 10 bytes from the SRAM record to
; wNameGlyphBuf; when the first byte is $FF it writes $98,$98,$98,$90,$90 instead and sets carry; DE
; and HL are preserved
CopyRecordNameToNameGlyphBuf::
    push hl
    push de
    call SRAMRecordAddress
    ld de, wNameGlyphBuf
    ld b, $0a
    ld a, [hl]
    cp $ff
    jr z, .skip

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    sub a
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

; A = record number, C = field offset: returns HL = sRecords + A * $A5 + C (records are $A5 bytes;
; Multiply8) with no party mapping (SRAMRecordAddressMapped maps A through wPartyList first). BC
; kept; A is clobbered. It does not enable SRAM or pick its bank. (C2, E-0373)
; A = record, C = offset; HL = sRecords + A * $A5 + C (records are $A5 bytes)
SRAMRecordAddress::
    push bc
    ld c, $a5
    call Multiply8
    ld bc, sRecords
    add hl, bc
    pop bc
    ld a, c
    add_a_to_hl
    ret

; DE = monster id, HL = VRAM destination, C = palette number: reads the 3-byte far pointer at
; MonsterPictureTable + 3 * DE (bank $38) and decompresses that picture stream to HL
; (DecompressToVRAM); the caller ROM bank is restored. On CGB it then copies the 16 bytes at
; MonsterPaletteTable + 16 * DE (bank $7B), two 4-colour palettes, to wBGPaletteBuffer + 8 * C
; (palettes C and C + 1) with CopyFromBank; it does not set wBGPaletteUploadRequest (callers such as
; the status page set it and call UploadBGPalettes). (C1, E-0373)
; DE = monster id, HL = VRAM destination, C = palette slot: decompresses the id's picture stream
; (MonsterPictureTable, bank $38) to HL; on CGB also copies the 16-byte palette from
; MonsterPaletteTable (bank $7B) to slot C of wBGPaletteBuffer
LoadMonsterPicture::
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
    ld de, MonsterPictureTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, [hl]
    pop af
    ld [rROMB0], a
    pop hl
    call DecompressToVRAM
    pop de
    pop bc
    ld a, [wIsCGB]
    or a
    ret z
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, MonsterPaletteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $7b
    ld a, c
    sla a
    sla a
    sla a
    ld hl, wBGPaletteBuffer
    add_a_to_hl
    ld c, $10
    call CopyFromBank
    ret

; DE = monster id, HL = destination in WRAM bank 2 (callers pass wScreenAttrBuffer), hTemp0 =
; palette number: reads the far pointer at MonsterAttributeMapTable + 3 * DE (bank $38; $447E), maps
; the bank it names, and writes its 6 x 6 attribute bytes plus hTemp0 to HL in rows 20 bytes apart
; (the 20-wide buffer layout), with rSVBK = 2. An entry whose address word is 0 uses the 36 zero
; bytes at $20E9 (the padding after LoadMonsterPictureAttributes), so every attribute is hTemp0. It
; ends with rSVBK = 0 and the caller ROM bank restored. (C1, E-0373)
; copies the 6 x 6 picture attribute block of species DE (table $447E in bank $38, default $20E9)
; plus hTemp0 to HL in WRAM bank 2 (E-0128)
LoadMonsterPictureAttributeBlock::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, MonsterAttributeMapTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    jr z, .skip
    ld a, [hli]
    ld d, a
    ld l, [hl]
    ld a, l
    jr .skip2

.skip:
    ld de, $20e9
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
    add c
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
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    jr .skip3

.skip4:
    ld a, $00
    ldh [rSVBK], a
    pop af
    ld [rROMB0], a
    ret

; DE = monster id, HL = BG map address, hTemp0 = palette number: reads the far pointer at
; MonsterAttributeMapTable + 3 * DE (bank $38), maps the bank it names, and writes its 6 x 6
; attribute bytes plus hTemp0 to VRAM bank 1 at HL, rows $20 apart (each byte through
; WriteVRAMByteInc). An entry whose address word is 0 uses the 36 zero bytes at $20E9 (the padding
; after this routine), so every attribute is hTemp0. It ends with rVBK = 0 and the caller ROM bank
; restored. (C1, E-0373)
; DE = monster id, HL = BG map address, hTemp0 = palette number: writes the 6 x 6 attribute bytes
; (plus hTemp0) of the id's MonsterAttributeMapTable entry to VRAM bank 1 (a default pattern when
; the entry is zero)
LoadMonsterPictureAttributes::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, MonsterAttributeMapTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    jr z, .skip
    ld a, [hli]
    ld d, a
    ld l, [hl]
    ld a, l
    jr .skip2

.skip:
    ld de, $20e9
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
    add c
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
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    jr .skip3

.skip4:
    ld c, $4f
    ld a, $00
    ldh [c], a
    pop af
    ld [rROMB0], a
    ret
    ds $24, $00

; DE = destination: writes the tens digit wDigits + $1 as tile $E0 + digit, or the blank tile $C3
; when it is 0, then the ones digit wDigits + $2 as $E0 + digit; the hundreds digit wDigits is
; ignored. DE ends at the second tile (not past it); HL kept. Callers draw a level this way after
; HLToDecimalDigits. (C2, E-0373)
; DE = destination: writes wDigits + $1 as tile $E0 + digit, or blank tile $C3 when it is 0, then
; wDigits + $2 as $E0 + digit; DE ends past the second tile; HL kept (E-0077) (E-0340: the address
; in its name read as its RAM name; was WriteTwoDigitTilesFromDigits1)
WriteTwoDigitTilesFromDigits1::
    push hl
    ld hl, wDigits + $1
    ld a, [hli]
    or a
    jr z, .skip
    add $e0
    jr .skip2

.skip:
    ld a, $c3

.skip2:
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    pop hl
    ret

; DE = destination: writes the three digits wDigits, wDigits + $1 and wDigits + $2 (from
; HLToDecimalDigits) as tiles $E0 + digit, with leading zeros as the blank tile $C3; the ones digit
; is always drawn. DE ends at the third tile (not past it); HL kept; C = 1 when a hundreds or tens
; tile was drawn, else 0. Callers draw HP and MP this way. (C2, E-0373)
; DE = destination: writes three tile ids for the digits in wDigits-wDigits + $2 (see
; HLToDecimalDigits): $E0 + digit, with leading zeros as $C3; DE ends past the third
WriteDecimalDigitTiles::
    push hl
    ld c, $00
    ld hl, wDigits
    ld a, [hli]
    or a
    jr z, .skip
    add $e0
    ld c, $01
    jr .skip2

.skip:
    ld a, $c3

.skip2:
    ld [de], a
    inc de
    ld a, [hli]
    bit 0, c
    jr nz, .skip3
    or a
    jr z, .skip4

.skip3:
    add $e0
    ld c, $01
    jr .skip5

.skip4:
    ld a, $c3

.skip5:
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    pop hl
    ret

; DE = destination: writes seven digit tiles ($E0 + digit) for the packed BCD number from
; Number24ToPackedBCD: the low nibble of hTemp3, then the high and low nibbles of hTemp2, hTemp1 and
; hTemp0. Leading zeros are the blank tile $C3; the last digit is always drawn. DE ends past the
; seventh tile; HL kept. PauseMenu_Info_Page2_DrawDetails draws the experience and the experience
; still needed with it. (C2, E-0373)
; writes the nibbles at hTemp3 downward as digit tiles ($E0 + n), a leading zero as the blank tile
; $C3 (E-0344: the address in its name dropped or read as the label there; was
; WritePackedBCDAsSevenDigitTiles)
WritePackedBCDAsSevenDigitTiles::
    push hl
    ld c, $00
    ld hl, hTemp3
    ld a, [hld]
    and $0f
    jr z, .skip
    ld c, $01
    add $e0
    jr .skip2

.skip:
    ld a, $c3

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
    and $0f
    jr z, .skip4

.skip3:
    ld c, $01
    add $e0
    jr .skip5

.skip4:
    ld a, $c3

.skip5:
    ld [de], a
    inc de
    dec b
    jr nz, .next
    ld c, $01

.next:
    inc b
    ld a, [hld]
    and $0f
    bit 0, c
    jr nz, .skip6
    and $0f
    jr z, .skip7

.skip6:
    ld c, $01
    add $e0
    jr .skip8

.skip7:
    ld a, $c3

.skip8:
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop hl
    ret

; DE = VRAM destination: with ROM bank $1F mapped, takes the characters of wNameGlyphBuf until $F0
; or 11 characters and copies each one 16-byte font tile (GlyphFont + 16 * character) to DE, waiting
; for VRAM access before each byte. A character followed by the mark $8D or $8E also gets that mark
; tile (CopyGlyphTilesToVRAM_Data1 or _Data2, which are glyphs $8D and $8E of the font) ORed into
; it, with bit 1 of its fourth byte cleared; the mark byte is skipped and does not count. Restores
; the caller ROM bank. (C1, E-0373)
; DE = VRAM destination: for each byte of the string at wNameGlyphBuf (up to 11, stopping at $F0),
; copies the 16-byte tile at ROM bank $1F, $4010 + 16 * character to [DE]; the characters $8D and
; $8E also OR a 16-byte overlay from $48E0 or $48F0 into the previous tile
CopyGlyphTilesToVRAM::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1f
    ld [rROMB0], a
    ld hl, wNameGlyphBuf
    ld c, $0b

.loop:
    push bc
    ld a, [hli]
    cp $f0
    jr nz, .skip
    pop bc
    pop af
    ld [rROMB0], a
    ret

.skip:
    push hl
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    ld h, a
    ld bc, GlyphFont
    add hl, bc
    ld b, $10

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hli]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld a, [hl]
    cp $8d
    jr z, .next
    cp $8e
    jr z, .next2
    jr .restore

.next:
    inc hl
    push hl
    ld hl, CopyGlyphTilesToVRAM_Data1
    jr .skip2

.next2:
    inc hl
    push hl
    ld hl, CopyGlyphTilesToVRAM_Data2

.skip2:
    ld b, $10
    ld a, e
    sub $10
    ld e, a
    ld a, d
    sbc $00
    ld d, a

.loop4:
    ld a, [hli]
    ld c, a
    di

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, [de]
    ei
    or c
    push af
    ld a, b
    cp $0d
    jr nz, .skip3
    pop af
    and $fd
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

; Fills wNameGlyphBuf with five spaces ($90) and an $F0 and draws it (CopyGlyphTilesToVRAM) at
; vTiles1 + $500, $550 and $5A0, three blank 5-tile slots; enables SRAM (rRAMG = $0A); then for each
; of the wPartyCount record numbers at wPartyList copies the MON_NAME of that record
; (CopyRecordNameToNameGlyphBuf), puts $F0 at wNameGlyphBuf + $A and draws it into the next slot
; ($50 bytes apart), and disables SRAM after the loop. With wPartyCount = 0 it returns with SRAM
; still enabled. It draws the names of the party members. (C1, E-0373)
; fills wNameGlyphBuf with five $90 glyphs and an $F0 terminator and draws it at vTiles1 + $500,
; $550 and $5A0 (three blank 5-tile slots); enables SRAM (rRAMG = $0A); then for each of the
; wPartyCount record numbers listed at wPartyList copies that record's name
; (CopyRecordNameToNameGlyphBuf, C = 1) and draws it into the next slot ($50 bytes apart); disables
; SRAM after the loop. With wPartyCount = 0 it returns with SRAM still enabled (E-0059)
LoadRecordListNameTiles::
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
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
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    pop de
    push de
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $50
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; Loads the sprite tiles and palettes of the party members who follow the player in the field. For
; each member of wPartyList it writes the species word to a list from wPartyList + 3 and
; decompresses the species' sprite (MonsterSpriteTable, bank $04) to VRAM, $100 bytes apart from
; vTiles0 + $100; on CGB it copies the species' 8-byte palette from bank $27 ($7328 + species * 8)
; to the member's object palette in wOBJPaletteBuffer (member index + 1). A member whose MON_STATUS
; has bit 7 set (the dead bit, see MON_STATUS) gets $FFFF in the list and a fixed graphic and
; palette from bank $7E instead. (C1, E-0369)
LoadPlayerAndFollowerSpriteGraphics_Followers::
    ld a, [wPartyCount]
    or a
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
    ld a, $0a
    ld [rRAMG], a
    push de
    ld a, [de]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop de
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_load_sram_record_word
    xor a
    ld [rRAMG], a
    ldh a, [hTemp4]
    ld c, a
    ldh a, [hTemp5]
    ld b, a
    ld a, $ff
    ld [bc], a
    inc bc
    ld [bc], a
    ld de, FallenFollowerCoffinTiles
    ld b, $7e
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jp z, .check_temp3
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub b
    inc a
    add a
    add a
    add a
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld a, $c8
    ld de, SharedOBJPalettes
    add e
    ld e, a
    jr nc, .call_copy_from_bank
    inc d

.call_copy_from_bank:
    ld b, $7e
    ld c, $08
    call CopyFromBank
    jr .check_temp3

.call_load_sram_record_word:
    ld a, [de]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a
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
    ld de, MonsterSpriteTable
    add hl, de
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $04
    ld [rROMB0], a
    ld a, [hli]
    ld e, a
    ld a, [hli]
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
    or a
    jr z, .check_temp3
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub b
    inc a
    add a
    add a
    add a
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
    add LOW(MonsterSpritePalettes)
    ld l, a
    ld a, h
    adc HIGH(MonsterSpritePalettes)
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
    add $02
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc $00
    ldh [hTemp5], a
    pop de
    inc de
    pop bc
    dec b
    jp nz, .loop
    ret

; A = SRAM record number (no party mapping; two callers first map a party slot with
; MapIndexViaPartyList, two pass a record number from a list): grades the record bytes
; MON_PERSONALITY ($6F), MON_PERSONALITY + 3 ($72) and MON_PERSONALITY + 1 ($70) with GradeTemp0
; (g1, g2, g3, each 0-2) and returns A = 9 * g1 + 3 * g2 + g3, a number from 0 to 26; the byte at
; $71 is not used. Keeps the record number in hTemp6. The status screen passes this to the string
; database as a personality-name index (category 7, 27 names), so it is the personality index of the
; monster. The caller enables SRAM. (C2, E-0373)
; A = SRAM record number: grades the record's bytes at offsets $6F, $72 and $70 with GradeTemp0 (g1,
; g2, g3, each 0-2) and returns A = 9 * g1 + 3 * g2 + g3, a number from 0 to 26. The status screen
; passes this to the string database as a personality-name index (category 7, 27 names), so it is
; the monster's personality index (E-0031)
PersonalityIndexOfRecord::
    ldh [hTemp6], a
    ld c, MON_PERSONALITY
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, $09
    call Multiply8
    ld b, l
    ldh a, [hTemp6]
    ld c, MON_PERSONALITY + 3
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, c
    add a
    add c
    add b
    ld b, a
    ldh a, [hTemp6]
    ld c, MON_PERSONALITY + 1
    call LoadSRAMRecordByte
    call GradeTemp0
    ld a, c
    add b
    ret

; Grades hTemp0 into C: C = 0 when hTemp0 >= $C0, 1 when $40 <= hTemp0 < $C0, otherwise 2 (carry set
; then, clear in the other cases). A = hTemp0. PersonalityIndexOfRecord grades three personality
; bytes with it. (C2, E-0373)
; C = 0 when hTemp0 >= $C0, 1 when hTemp0 >= $40, otherwise 2
GradeTemp0::
    ldh a, [hTemp0]
    ld c, $00
    cp $c0
    ret nc
    inc c
    cp $40
    ret nc
    inc c
    ret

; DE = destination: writes the number from Number24ToPackedBCD in hTemp0-hTemp3 as digit characters
; 0-9 (not tiles) without leading zeros, then $F0: hTemp3 (the millions, written as a whole byte)
; when non-zero, then the high and low nibbles of hTemp2, hTemp1 and hTemp0. Zero writes a single 0.
; DE ends at the $F0. (C2, E-0373)
; writes the packed BCD number in hTemp0-hTemp3 (most significant byte last) as digits at DE without
; leading zeros, then $F0; zero writes a single 0 (E-0127)
WritePackedBCDNoLeadingZeros::
    ldh a, [hTemp0]
    or a
    jr nz, .check_temp3
    ldh a, [hTemp1]
    or a
    jr nz, .check_temp3
    ldh a, [hTemp2]
    or a
    jr nz, .check_temp3
    ldh a, [hTemp3]
    or a
    jr nz, .check_temp3
    ld [de], a
    inc de
    ld a, $f0
    ld [de], a
    ret

.check_temp3:
    ld c, $00
    ldh a, [hTemp3]
    or a
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
    and $0f
    bit 0, c
    jr nz, .skip2
    or a
    jr z, .skip3

.skip2:
    ld [de], a
    inc de
    ld c, $01

.skip3:
    ld a, [hl]
    and $0f
    bit 0, c
    jr nz, .skip4
    or a
    jr z, .next

.skip4:
    ld [de], a
    inc de
    ld c, $01

.next:
    dec hl
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    ret

; A = skill number, DE = destination: with ROM bank $08 mapped, copies string A of
; StringTable_SkillNames (the word at $4558 + 2 * A, a 16-bit index) including its $F0 to DE,
; through the shared tail CopyItemNameToDE_CopyString; DE ends past the $F0 and the caller ROM bank
; is restored. Its one caller, a talk in bank $04 (Script_InThePastMermaids), puts the skill name
; into wTextBuf2 + $2. (C2, E-0373)
; HL = $4558 + 2 * A, switches to ROM bank 8 and continues with the shared read at
; CopyItemNameToDE_CopyString (E-0126) (E-0344: the address in its name dropped or read as the label
; there; was CopySkillNameToDE)
CopySkillNameToDE::
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add LOW(StringTable_SkillNames)
    ld l, a
    ld a, h
    adc HIGH(StringTable_SkillNames)
    ld h, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a
    jr CopyItemNameToDE_CopyString

; A = item number, DE = destination: with ROM bank $08 mapped, copies string A of
; StringTable_ItemNames ($4716 + 2 * A) including its $F0 to DE and restores the caller bank (falls
; into CopyItemNameToDE_CopyString). A is doubled in 8 bits, so A and A + $80 give the same name. DE
; ends past the $F0. (C2, E-0373)
; A = item number: with ROM bank $08 mapped, copies that string of StringTable_ItemNames, including
; its $F0 terminator, to DE; restores the bank (E-0071)
CopyItemNameToDE::
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add LOW(StringTable_ItemNames)
    ld l, a
    ld a, h
    adc HIGH(StringTable_ItemNames)
    ld h, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a

; The shared tail of CopyItemNameToDE and CopySkillNameToDE: with ROM bank $08 mapped and the
; caller's bank pushed, HL points at a string pointer; it follows the pointer, copies the string up
; to and including its $F0 terminator to DE, and restores the caller's ROM bank. (C2, E-0369; probed
; E-0374)
CopyItemNameToDE_CopyString::
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    cp $f0
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; A = key slot, or $FE: for $FE writes 'Magic Key' to DE; otherwise writes the name of entry A of
; wKeyList (4-byte entries; it reads bytes 1 and 2 from $C708 + 4 * A): word (byte 1) + 1, then word
; (byte 2) + $11 of CopyKeyNameWordToDE_StringList, run together (CopyKeyNameWordToDE). Then $F0; DE
; ends at the $F0. (C2, E-0373)
; A = key slot, or $FE: writes 'Magic Key' to DE; otherwise writes the name of key A in wKeyList
; (4-byte entries from $C708): the word numbered byte 0 + 1, then the word numbered byte 1 + $11
; (CopyKeyNameWordToDE), then $F0 (E-0090)
WriteKeyNameToDE::
    cp $fe
    jr nz, .skip
    ld a, $16
    ld [de], a
    inc de
    ld a, $24
    ld [de], a
    inc de
    ld a, $2a
    ld [de], a
    inc de
    ld a, $2c
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
    ld a, $3c
    ld [de], a
    inc de
    jr .done

.skip:
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hli]
    inc a
    push hl
    call CopyKeyNameWordToDE
    pop hl
    dec de
    ld a, [hl]
    add $11
    call CopyKeyNameWordToDE
    dec de

.done:
    ld a, $f0
    ld [de], a
    ret

; A = word number (below $80; it is doubled in 8 bits), DE = destination: with ROM bank $09 mapped,
; copies that string of CopyKeyNameWordToDE_StringList (category 3 of the bank-$09 strings: Ylw,
; Plain, Green, ... then Slime, Draco, Beast, ... Cave, Isle) with its $F0 to DE and restores the
; bank; DE ends past the $F0. (C2, E-0373)
; A = word number: with ROM bank $09 mapped, copies that string of the bank-$09 database's category
; 3 (CopyKeyNameWordToDE_StringList: Ylw, Plain, Green, ... then Slime, Draco, Beast, ... Cave,
; Isle) with its $F0 to DE; restores the bank (E-0090)
CopyKeyNameWordToDE::
    add a
    ld hl, CopyKeyNameWordToDE_StringList
    add_a_to_hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $09
    ld [rROMB0], a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    cp $f0
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; A = party slot (bit 7 ignored): returns A = the byte at wPartyList + (A & $7F), the record number
; of that member, with HL pointing there. In a link battle (wLinkMode non-zero and wGameMode 4) it
; returns A unchanged and HL kept. BC kept. (C2, E-0373)
; returns A unchanged when wLinkMode is non-zero and wGameMode is 4; otherwise A = the byte at
; wPartyList + (A & $7F); HL is clobbered in that case
MapIndexViaPartyList::
    push bc
    ld b, a
    ld a, [wLinkMode]
    or a
    jr z, .skip
    ld a, [wGameMode]
    cp $04
    jr nz, .skip
    ld a, b
    pop bc
    ret

.skip:
    ld a, b
    pop bc
    ld hl, wPartyList
    and $7f
    add_a_to_hl
    ld a, [hl]
    ret

; B = ROM bank, DE = source: on CGB copies $40 bytes (eight palettes) from DE in bank B into
; wBGPaletteBuffer (CopyFromBank, caller bank restored) and sets wBGPaletteUploadRequest = $7F;
; returns at once when wIsCGB is 0. Two screen loaders in bank 0 call it with the palette pointer
; from their table. (C2, E-0373)
; on CGB copies $40 bytes from DE in bank B (CopyFromBank) into wBGPaletteBuffer and sets
; wBGPaletteUploadRequest = $7F (upload request) (E-0117)
LoadBGPaletteBufferFromBank::
    ld a, [wIsCGB]
    or a
    ret z
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; HL = BG map address built by adding an offset to the scroll origin: with col = (hScrollX / 8) &
; $1F, when col >= 12 and (L & $1F) < col - 12 the entry ran past column 31 into the next row, so HL
; -= $20 and A = $FF; otherwise HL is unchanged and A = 0. BC and DE kept. Menus call it before
; writing a cursor or digit tile. (C2, E-0373)
; HL = BG map address. With col = (hScrollX / 8) & $1F: when col >= 12 and (L & $1F) < col - 12 (a
; column of the 20-column view that wrapped past entry 31), HL -= $20 and A = $FF; otherwise HL is
; unchanged and A = 0. BC and DE kept (E-0059)
StepBGMapAddressBackOnScrollWrap::
    push bc
    push de
    push hl
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    and $1f
    ld b, a
    ld a, $20
    sub b
    ld b, a
    ld a, $14
    sub b
    bit 7, a
    jr nz, .restore
    pop hl
    push hl
    ld d, a
    ld a, l
    and $1f
    cp d
    jr nc, .restore
    pop hl
    pop de
    pop bc
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, $ff
    ret

.restore:
    pop hl
    pop de
    pop bc
    xor a
    ret

; Sets hSpriteScrollXLo/Hi = 8 - the 16-bit scroll hScrollX/hScrollXHi and hSpriteScrollYLo/Hi = $10
; - hScrollY/hScrollYHi (computed as -(scroll - 9) - 1 and -(scroll - $11) - 1). In game mode 1 with
; wModeState & $0F = 6 (FieldState_FieldMenu) it returns early and leaves them. GameFrameUpdate
; calls it every frame; field and scene code call it after moving the scroll. (C2, E-0373)
; hSpriteScrollXLo/hSpriteScrollXHi = -(hScrollX - 9) - 1 and hSpriteScrollYLo/hSpriteScrollYHi =
; -(hScrollY - $11) - 1 as 16-bit values; returns early in game mode 1 when wModeState & $0F = 6
ComputeSpriteScrollOffsets::
    ld a, [wGameMode]
    cp $01
    jr nz, .skip
    ld a, [wModeState]
    and $0f
    cp $06
    ret z

.skip:
    ld hl, hScrollX
    ld a, [hli]
    sub $09
    cpl
    ldh [hSpriteScrollXLo], a
    ld a, [hl]
    sbc $00
    cpl
    ldh [hSpriteScrollXHi], a
    ld hl, hScrollY
    ld a, [hli]
    sub $11
    cpl
    ldh [hSpriteScrollYLo], a
    ld a, [hl]
    sbc $00
    cpl
    ldh [hSpriteScrollYHi], a
    ret

; The serial interrupt (vector $0058): saves AF, BC, DE and HL, far-calls RunLinkSession (a step of
; the link session) and returns with reti. (C1, E-0373)
; the serial interrupt (vector $0058): saves AF, BC, DE and HL, runs a step of the link session
; (RunLinkSession) and returns with reti (E-0341; was SerialInterruptHandler)
SerialInterruptHandler::
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

; The LCD STAT interrupt (vector $0048): saves AF, HL and DE and the WRAM bank (rSVBK, then sets it
; to 0), and runs entry wSTATSplitEnable & 3 of its table: 0 StatInterruptHandler_Exit and 1
; StatInterruptHandler_NoSplit do nothing; 2 StatInterruptHandler_HorizontalWave and 3
; StatInterruptHandler_VerticalWave set rSCX or rSCY per line from wBGPaletteCopy + rLY and move
; rLYC on. Every entry ends at StatInterruptHandler_Exit, which restores the WRAM bank and registers
; and returns with reti. (C1, E-0373)
; the LCD STAT interrupt (vector $0048): with WRAM bank 0 mapped, runs the split chosen by
; wSTATSplitEnable & 3 (0 none; 2 and 3 rewrite SCX or SCY and LYC for a scroll split) and returns
; with reti (E-0341; was StatInterruptHandler)
StatInterruptHandler::
    push af
    push hl
    push de
    ldh a, [rSVBK]
    ld d, a
    xor a
    ldh [rSVBK], a
    push de
    ld a, [wSTATSplitEnable]
    and $03
    jumptable
    dw StatInterruptHandler_Exit
    dw StatInterruptHandler_NoSplit
    dw StatInterruptHandler_HorizontalWave
    dw StatInterruptHandler_VerticalWave

; The common exit of StatInterruptHandler: restores the WRAM bank and the saved registers and
; returns from the interrupt. It is also split 0 (no split). (C1, E-0357)
StatInterruptHandler_Exit::
    pop af
    ldh [rSVBK], a
    pop de
    pop hl
    pop af
    reti

; STAT split 1: does nothing (jumps to the common exit). (C1, E-0357)
StatInterruptHandler_NoSplit::
    jr StatInterruptHandler_Exit

; STAT split 2, a horizontal wave: on each interrupt sets rSCX to the byte at wBGPaletteCopy + rLY
; (the buffer here holds per-line scroll values) and moves the LYC line on by 2; after line $8F it
; restores rSCX from hScrollX and restarts at line 0. (C1, E-0357)
StatInterruptHandler_HorizontalWave::
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCX], a
    ldh a, [rLYC]
    add $02
    cp $90
    jr c, .skip
    ldh a, [hScrollX]
    ldh [rSCX], a
    ld a, $00

.skip:
    ldh [rLYC], a
    jr StatInterruptHandler_Exit

; STAT split 3, a vertical wave: on each interrupt sets rSCY to the byte at wBGPaletteCopy + rLY and
; moves the LYC line on by 2; after line $80 it restores rSCY from hScrollY and restarts at line 0.
; (C1, E-0357)
StatInterruptHandler_VerticalWave::
    ldh a, [rLY]
    ld hl, wBGPaletteCopy
    add_a_to_hl
    ld a, [hl]
    ldh [rSCY], a
    ldh a, [rLYC]
    add $02
    cp $81
    jr c, .skip
    ldh a, [hScrollY]
    ldh [rSCY], a
    ld a, $00

.skip:
    ldh [rLYC], a
    jr StatInterruptHandler_Exit

; DE = string table (see LookupString): clears the text window tiles (FillTilesFromRequest), copies
; wTextWindowTileLo/Hi to wTextGlyphDestLo/Hi and wTextLineStartLo/Hi, looks up string wStringIndex
; of category wStringCategory (LookupString, which also stores the current ROM bank in wStringBank),
; points wTextPosLo/Hi and wTextStartPosLo/Hi at it, sets wTextFlags = 1 and clears wTextControl and
; wTextGlyphTimer. The VBlank handler then prints it a glyph at a time (StepTextPrinter) while
; wTextFlags is non-zero. (C1, E-0373)
; DE = string table (see LookupString); clears the request area with FillTilesFromRequest, copies
; the position wTextWindowTileLo/wTextWindowTileHi to wTextGlyphDestLo/wTextGlyphDestHi and
; wTextLineStartLo/wTextLineStartHi, points wTextPosLo/wTextPosHi and
; wTextStartPosLo/wTextStartPosHi at the string, sets wTextFlags = 1 and clears wTextControl and
; wTextGlyphTimer; the string is drawn later by the routine at StepTextPrinter
BeginStringDisplay::
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
    xor a
    ld [wTextControl], a
    ld [wTextGlyphTimer], a
    ret

; DE = string table: looks up string wStringIndex of category wStringCategory (LookupString, which
; stores the current ROM bank in wStringBank) and copies it, including its $F0 terminator, to the
; address in wStringDestLo/wStringDestHi. Called by the string-bank wrappers such as
; CopyStringToBuffer_Bank08 (reached from CopyStringHLToDE). (C2, E-0373)
; DE = string table (see LookupString); copies the string, including its $F0 terminator, to the
; address in wStringDestLo/wStringDestHi
CopyStringToBuffer::
    call LookupString
    ld a, [wStringDestLo]
    ld l, a
    ld a, [wStringDestHi]
    ld h, a

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    cp $f0
    jr nz, .loop
    ret

; Sets wTextFlags bit 1 (<FAST>), then calls StepTextPrinter in a loop until wTextFlags is 0,
; printing the whole string begun by BeginStringDisplay at once instead of one glyph per frame. (C1,
; E-0373)
; sets bit 1 of wTextFlags, then runs the display step at StepTextPrinter until wTextFlags is zero
RunStringDisplayToEnd::
    ld hl, wTextFlags
    set 1, [hl]

.loop:
    call StepTextPrinter
    ld a, [wTextFlags]
    or a
    jr nz, .loop
    ret

; One step of the text printer: when wTextControl bit 7 (<INSTANT>) is clear it runs PrintTextStep
; once; otherwise it runs PrintTextStep repeatedly, setting wTextFlags bit 1 before each, until bit
; 7 is cleared (by a wait command or ClearStringDisplayFlags). The VBlank handler calls it each
; frame while wTextFlags is non-zero. (C1, E-0373)
; runs PrintTextStep repeatedly while bit 7 of wTextControl (<INSTANT>) stays set, setting bit 1 of
; wTextFlags each time; otherwise once (E-0122, E-0336)
StepTextPrinter::
    ld a, [wTextControl]
    bit 7, a
    jr z, PrintTextStep

.loop:
    ld hl, wTextFlags
    set 1, [hl]
    call PrintTextStep
    ld a, [wTextControl]
    bit 7, a
    jr nz, .loop
    ret

; One frame of the text printer, with ROM bank wStringBank mapped (the caller bank is restored and
; wTextGlyphTimer += 1 on every exit). In order: while wTextControl bit 2 is set (<SFX_WAIT>,
; <MUSIC_WAIT>) it only clears that bit once every byte of wSoundChannelSlots and wSoundChannel1-5
; it checks is $FF; with wTextFlags = 0 it does nothing; with bit 5 it blinks the arrow (tile $BD or
; $B4 by wFrameCounterLo bit 4, three rows below wTextCursorLo/Hi, 9 columns in). With bit 2 it
; waits: after <CHOICE> or <CHOICE_E6> (wTextLastChar $FF or $E6) up or down toggles
; wTextYesNoResult with sound $69, the cursor tile $BB blinks beside the chosen line, and A or B (B
; sets the result to 1) ends the choice, plays $69 for yes unless the command was $E6, and redraws
; the screen (DrawScreenBufferToBGMapWithAttrs); otherwise any newly pressed button except bit 3
; ends the wait (HideTextArrow). Bit 6 counts wTextRepeatCount down or ends on a button; bit 7
; counts wTextDelayCounter down. Otherwise it takes the next string byte: $8D/$8E marks are drawn at
; once (DrawTextMarkGlyph), $E0-$FF run RunTextCommand, and a glyph waits until wTextGlyphTimer
; reaches wTextSpeed (or wTextControlArg after <SPEED>; not under <FAST>), then is drawn
; (DrawTextGlyph) with the beep wTextBeepSound when wTextControl bit 0 is set. A button press while
; waiting for a glyph sets <INSTANT> (wTextControl bit 7). C2 from E-0336: glyphs follow each other
; about wTextSpeed frames apart (0 acts as 1). (C1, E-0373)
; one frame of the text printer, with the string's bank wStringBank mapped: waits for a sound
; (<SFX_WAIT>), a yes/no choice or a button (<WAIT>), a delay or a timeout; otherwise, once
; wTextGlyphTimer reaches the text speed wTextSpeed, takes the next string byte: a glyph is drawn
; (DrawTextGlyph), $8D/$8E marks go to DrawTextMarkGlyph, and $E0-$FF run RunTextCommand. C2 from
; E-0336: glyphs follow each other about wTextSpeed frames apart (0 acts as 1)
PrintTextStep::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wStringBank]
    ld [rROMB0], a
    ld a, [wTextControl]
    bit 2, a
    jp nz, .read_sound_channel_slots
    ld a, [wTextFlags]
    or a
    jp z, .skip2
    bit 5, a
    jr z, .check_text_flags
    ld c, $bd
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_add_text_cursor_to_hl
    ld c, $b4

.call_add_text_cursor_to_hl:
    ld hl, $0060
    call AddTextCursorToHL
    ld b, $09
    call AdvanceBGMapColumnsByB
    ld a, c
    call WriteVRAMByte

.check_text_flags:
    ld a, [wTextFlags]
    bit 2, a
    jp z, .check_bit6
    ld a, [wTextLastChar]
    cp $e6
    jr z, .read_joypad_pressed_repeat
    ld a, [wTextLastChar]
    cp $ff
    jp nz, .read_joypad_pressed

.read_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    ld b, a
    ld a, [wLinkJoypadPressedRepeat]
    or b
    bit 6, a
    jr z, .check_bit7
    ld a, [wTextYesNoResult]
    and $01
    xor $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect
    jr .check_text_yes_no_result

.check_bit7:
    bit 7, a
    jr z, .check_text_yes_no_result
    ld a, [wTextYesNoResult]
    and $01
    xor $01
    ld [wTextYesNoResult], a
    ld a, $69
    call QueueSoundEffect

.check_text_yes_no_result:
    ld c, $bb
    ld b, $c3
    ld a, [wTextYesNoResult]
    or a
    jr z, .check_frame_counter_lo
    ld c, $c3
    ld b, $bb

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_bg_map_address_at_scroll_plus_hl
    ld c, $c3
    ld b, $c3

.call_bg_map_address_at_scroll_plus_hl:
    push bc
    ld hl, $0120
    call BGMapAddressAtScrollPlusHL
    ld b, $0f
    call AdvanceBGMapColumnsByB
    pop bc
    ld a, c
    call WriteVRAMByte
    push bc
    ld hl, $0160
    call BGMapAddressAtScrollPlusHL
    ld b, $0f
    call AdvanceBGMapColumnsByB
    pop bc
    ld a, b
    call WriteVRAMByte
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or b
    bit 0, a
    jr z, .check_bit1
    ld a, [wTextYesNoResult]
    or a
    jr nz, .set_text_yes_no_result_to_01
    ld a, [wTextLastChar]
    cp $e6
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
    pop de
    call DrawScreenBufferToBGMapWithAttrs
    jp .skip2

.read_joypad_pressed:
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or b
    and $f7
    jp z, .skip2
    ld hl, wTextFlags
    res 2, [hl]
    res 1, [hl]
    call HideTextArrow
    jp .skip2

.check_bit6:
    bit 6, a
    jr z, .check_bit72
    ld a, [wTextRepeatCount]
    dec a
    ld [wTextRepeatCount], a
    or a
    jp z, .call_hide_text_arrow
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or b
    and $f7
    jp z, .skip2

.call_hide_text_arrow:
    ld hl, wTextFlags
    res 6, [hl]
    call HideTextArrow
    jp .skip2

.check_bit72:
    bit 7, a
    jr z, .read_text_pos_lo
    ld a, [wTextDelayCounter]
    dec a
    ld [wTextDelayCounter], a
    or a
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
    cp $8d
    jr z, .read_text_pos_lo2
    cp $8e
    jr z, .read_text_pos_lo2
    cp $e0
    jr nc, .read_text_pos_lo3
    ld a, [wTextFlags]
    bit 1, a
    jr nz, .clear_text_glyph_timer
    ld a, [wJoypadPressed]
    ld b, a
    ld a, [wLinkJoypadPressed]
    or b
    and $f7
    jr z, .read_text_speed
    ld hl, wTextControl
    set 7, [hl]

.read_text_speed:
    ld a, [wTextSpeed]
    ld b, a
    ld a, [wTextFlags]
    bit 3, a
    jr z, .check_text_glyph_timer
    ld a, [wTextControlArg]
    ld b, a

.check_text_glyph_timer:
    ld a, [wTextGlyphTimer]
    cp b
    jp c, .skip2

.clear_text_glyph_timer:
    xor a
    ld [wTextGlyphTimer], a
    ld hl, wTextControl
    res 1, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    cp $e0
    jr nc, .read_text_pos_lo3
    call DrawTextGlyph
    ld a, [wTextControl]
    bit 0, a
    jr z, .skip2
    ld a, b
    cp $90
    jr z, .skip2
    cp $9a
    jr z, .skip2
    ld a, [wTextBeepSound]
    call QueueSoundEffect
    ld hl, wTextControl
    set 1, [hl]
    jr .skip2

.read_text_pos_lo2:
    ld a, [wTextPosLo]
    add $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc $00
    ld [wTextPosHi], a
    ld a, [hl]
    call DrawTextMarkGlyph
    jr .skip2

.read_text_pos_lo3:
    ld a, [wTextPosLo]
    add $01
    ld [wTextPosLo], a
    ld a, [wTextPosHi]
    adc $00
    ld [wTextPosHi], a
    ld a, [hl]
    call RunTextCommand
    ld hl, wTextControl
    res 1, [hl]
    jr .skip2

.read_sound_channel_slots:
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    jr nz, .skip2
    ld hl, wTextControl
    res 2, [hl]

.skip2:
    ld hl, wTextGlyphTimer
    inc [hl]
    pop af
    ld [rROMB0], a
    ret

; A = glyph: with ROM bank $1F mapped, copies the 16-byte font tile of the glyph
; (GlyphTileSourceForL: GlyphFont + 16 * A) to the address in wTextGlyphDestLo/Hi, waiting for VRAM
; access before each pair of bytes, stores the address after it back in wTextGlyphDestLo/Hi and
; restores the caller ROM bank. B is kept. (C1, E-0373)
; draws glyph A at wTextGlyphDest (its 8 font rows from bank $1F, GlyphTileSourceForL) and advances
; the destination (E-0336)
DrawTextGlyph::
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1f
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
    ld [hli], a
    inc e
    ld a, [de]
    ld [hli], a
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

; A = mark glyph ($8D or $8E): with ROM bank $1F mapped, runs CallFunc28BDInBank1F_OverlayGlyph,
; which ORs the 16-byte font tile of the mark into the tile just drawn (wTextGlyphDestLo/Hi - $10),
; clearing bit 1 of its fourth byte, and leaves wTextGlyphDestLo/Hi where it was; restores the
; caller ROM bank. PrintTextStep sends the $8D and $8E string bytes here at once, without the glyph
; timer. (C1, E-0373)
; L = A; switches to ROM bank $1F, calls CallFunc28BDInBank1F_OverlayGlyph and restores the bank
; (E-0122)
DrawTextMarkGlyph::
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1f
    ld [rROMB0], a
    call CallFunc28BDInBank1F_OverlayGlyph
    pop af
    ld [rROMB0], a
    ret

; Draws one glyph of text over the tile being built: finds glyph L's 16-byte font tile
; (GlyphTileSourceForL), backs the destination up one tile and ORs the 16 bytes into VRAM, waiting
; for VRAM access before each byte; in the fourth byte (offset 3, when B = $0D) it also clears bit
; 1. Stores the end address in wTextGlyphDestLo/Hi for the next glyph. (C1, E-0369)
CallFunc28BDInBank1F_OverlayGlyph::
    call GlyphTileSourceForL
    ld a, l
    sub $10
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld b, $10

.loop:
    di
    ld a, b
    cp $0d
    jr z, .loop3

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    or [hl]
    ld [hli], a
    jr .skip

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [de]
    or [hl]
    and $fd
    ld [hli], a

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

; L = glyph: returns DE = GlyphFont + 16 * L ($4010 + 16 * L, the 16-byte font tile in bank $1F) and
; HL = the word at wTextGlyphDestLo/wTextGlyphDestHi (A = its high byte). BC kept. The caller maps
; bank $1F. (C2, E-0373)
; DE = $4010 + 16 * L (the 16-byte tile of glyph L in the font bank); HL = the word at
; wTextGlyphDestLo/wTextGlyphDestHi (E-0120)
GlyphTileSourceForL::
    ld de, GlyphFont
    ld a, l
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    ld a, [wTextGlyphDestLo]
    ld l, a
    ld a, [wTextGlyphDestHi]
    ld h, a
    ret

; Fills the text window tiles at wTextWindowTileLo/Hi with the 16-byte pattern at SolidColor1Tile
; (eight $FF, $00 pairs, right after this routine): wTextWindowWidth passes of wTextWindowRows
; tiles, one after another, waiting for VRAM access before each byte. It returns at once only when
; both counts are 0; a 0 in just one of them counts as 256. FillTilesRequest sets the counts and
; calls it; BeginStringDisplay and TextCmd_Clear use it to blank the window. (C1, E-0373)
; fills a block of tiles at wTextWindowTileLo/wTextWindowTileHi with the 16-byte pattern at
; SolidColor1Tile: width wTextWindowRows, height wTextWindowWidth tiles (each byte waits for VRAM
; access); returns at once if either is zero
FillTilesFromRequest::
    ld hl, wTextWindowRows
    ld a, [hli]
    or [hl]
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
    ld de, SolidColor1Tile

.loop3:
    di

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [de]
    ld [hli], a
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

; One 2bpp tile, 16 bytes $FF, $00: eight rows of colour 1. FillTilesBxC and FillTilesFromRequest
; copy it into each tile they fill, and LibraryMenu_LeaveReloadNames copies it with
; CopyTileBytesToVRAM_Bank0C. (C1, E-0389)
SolidColor1Tile::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00

; A = command byte $E0-$FF: stores it in wTextLastChar and jumps to entry A - $E0 of its 32-entry
; table: $E0-$E4 TextCmd_SfxWait, $E5 TextCmd_MusicWait, $E6 TextCmd_ChoiceE6, $E7 TextCmd_ChoiceNo,
; $E8 TextCmd_Cursor, $E9 TextCmd_Sound, $EA-$EB TextCmd_Voice1/2, $EC TextCmd_Pause, $ED
; TextCmd_Instant, $EE TextCmd_ClearLine, $EF TextCmd_NextLine, $F0 TextCmd_End, $F1 TextCmd_Line,
; $F2 TextCmd_Clear, $F3 TextCmd_Home, $F4 ClearStringDisplayFlags, $F5 TextCmd_Fast, $F6
; TextCmd_Player, $F7 TextCmd_Wait, $F8 TextCmd_Speed, $F9 TextCmd_Buf, $FA TextCmd_Arrow, $FB
; TextCmd_WaitOrButton, $FC TextCmd_Delay, $FD TextCmd_BeepOn, $FE TextCmd_BeepOff, $FF
; OpenTextChoice. charmap.inc names the commands (<LINE>, <WAIT>, @, ...). (C1, E-0373)
; stores the command byte A ($E0-$FF) in wTextLastChar and jumps to entry A - $E0 of the table after
; it; charmap.inc names the commands (<LINE>, <WAIT>, @, ...) (E-0336)
RunTextCommand::
    ld [wTextLastChar], a
    sub $e0
    jumptable
    dw TextCmd_SfxWait
    dw TextCmd_SfxWait
    dw TextCmd_SfxWait
    dw TextCmd_SfxWait
    dw TextCmd_SfxWait
    dw TextCmd_MusicWait
    dw TextCmd_ChoiceE6
    dw TextCmd_ChoiceNo
    dw TextCmd_Cursor
    dw TextCmd_Sound
    dw TextCmd_Voice1
    dw TextCmd_Voice2
    dw TextCmd_Pause
    dw TextCmd_Instant
    dw TextCmd_ClearLine
    dw TextCmd_NextLine
    dw TextCmd_End
    dw TextCmd_Line
    dw TextCmd_Clear
    dw TextCmd_Home
    dw ClearStringDisplayFlags
    dw TextCmd_Fast
    dw TextCmd_Player
    dw TextCmd_Wait
    dw TextCmd_Speed
    dw TextCmd_Buf
    dw TextCmd_Arrow
    dw TextCmd_WaitOrButton
    dw TextCmd_Delay
    dw TextCmd_BeepOn
    dw TextCmd_BeepOff
    dw OpenTextChoice

; <SFX_WAIT> ($E0-$E4): clears wTextControl bit 7, queues the next string byte as a sound effect
; (QueueSoundEffect, wSoundEffectRequest), moves wTextPosLo/Hi past it and sets wTextControl bit 2,
; which holds the text until every sound channel is idle (PrintTextStep). (C2, E-0373)
; <SFX_WAIT> ($E0-$E4): plays the sound effect in the next byte and sets wTextControl bit 2, which
; holds the text until every sound channel is idle (E-0336)
TextCmd_SfxWait::
    ld hl, wTextControl
    res 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    call QueueSoundEffect
    ld hl, wTextControl
    set 2, [hl]
    ret

; <MUSIC_WAIT> ($E5): clears wTextControl bit 7, queues the next string byte as music (QueueMusic,
; wMusicRequest), moves wTextPosLo/Hi past it and sets wTextControl bit 2, which holds the text
; until every sound channel is idle. (C2, E-0373)
; <MUSIC_WAIT> ($E5): plays the music in the next byte and holds the text until every sound channel
; is idle (E-0336)
TextCmd_MusicWait::
    ld hl, wTextControl
    res 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    call QueueMusic
    ld hl, wTextControl
    set 2, [hl]
    ret

; <CHOICE_E6> ($E6): opens the yes/no choice (jumps to OpenTextChoice). wTextLastChar stays $E6, so
; PrintTextStep plays no sound when yes is confirmed. (C1, E-0373)
; <CHOICE_E6> ($E6): the yes/no choice (OpenTextChoice) (E-0336)
TextCmd_ChoiceE6::
    jp OpenTextChoice

; <CHOICE_NO> ($E7): opens the yes/no choice (OpenTextChoice), then puts the cursor on no
; (wTextYesNoResult = 1) and sets wTextLastChar = $FF, so PrintTextStep handles it like <CHOICE>.
; (C1, E-0373)
; <CHOICE_NO> ($E7): the yes/no choice with the cursor on no (wTextYesNoResult = 1) (E-0336)
TextCmd_ChoiceNo::
    call OpenTextChoice
    ld a, $01
    ld [wTextYesNoResult], a
    ld a, $ff
    ld [wTextLastChar], a
    ret

; <CURSOR> ($E8): reads the column (next byte) and row (the byte after), moving wTextPosLo/Hi past
; both, and sets wTextGlyphDestLo/Hi and wTextLineStartLo/Hi = wTextWindowTileLo/Hi + 16 * (row *
; wTextWindowWidth + column). (C2, E-0373)
; <CURSOR> ($E8): moves the glyph cursor to column (next byte), row (byte after) of the text window:
; wTextGlyphDest = wTextWindowTile + 16 * (row * wTextWindowWidth + column) (E-0336)
TextCmd_Cursor::
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

; <SOUND> ($E9): plays the id in the next byte without waiting (wTextPosLo/Hi moves past it): $FF
; far-calls RestartMapMusic (<MAP_MUSIC>); ids below $60 and $CC, $CF, $D6 go to QueueMusic; every
; other id to QueueSoundEffect. The 4 bytes after it ($CD, $78, $12, $C9: call QueueSoundEffect,
; ret) are never reached. (C1, E-0373)
; <SOUND> ($E9): plays the id in the next byte without waiting, as music for ids below $60 and $CC,
; $CF, $D6, otherwise as a sound effect; $FF restarts the map music (E-0336)
TextCmd_Sound::
    call IncrementTextPosLoWord
    ld a, [hl]
    cp $ff
    jr z, .call_restart_map_music
    cp $60
    jr c, .call_queue_music
    cp $cc
    jr z, .call_queue_music
    cp $cf
    jr z, .call_queue_music
    cp $d6
    jr z, .call_queue_music
    call QueueSoundEffect
    ret

.call_queue_music:
    call QueueMusic
    ret

.call_restart_map_music:
    farcall RestartMapMusic
    ret
    db $cd, $78, $12, $c9

; <VOICE1> ($EA): turns the speech beep on (wTextControl bit 0) with sound $6B (wTextBeepSound).
; (C2, E-0373)
; <VOICE1> ($EA): speech beep on (wTextControl bit 0) with sound $6B (E-0336)
TextCmd_Voice1::
    ld hl, wTextControl
    set 0, [hl]
    ld a, $6b
    ld [wTextBeepSound], a
    ret

; <VOICE2> ($EB): turns the speech beep on (wTextControl bit 0) with sound $6A (wTextBeepSound).
; (C2, E-0373)
; <VOICE2> ($EB): speech beep on with sound $6A (E-0336)
TextCmd_Voice2::
    ld hl, wTextControl
    set 0, [hl]
    ld a, $6a
    ld [wTextBeepSound], a
    ret

; <PAUSE> ($EC): clears wTextControl bit 7; below text speed 7 it sets wTextDelayCounter from the
; 7-byte table after it at $2A66, indexed by wTextSpeed (6, 12, 20, 26, 32, 40, 48 frames), and sets
; wTextFlags bit 7 (a delay); at speed 7 it sets wTextFlags bits 2 and 5 instead, waiting for a
; button with the arrow. Speeds above 7 would read past the table. (C2, E-0373)
; <PAUSE> ($EC): waits the frames in the 7-byte table at $2A66 for the text speed wTextSpeed (6, 12,
; 20, 26, 32, 40, 48); at speed 7 waits for a button with the arrow instead (E-0336)
TextCmd_Pause::
    ld hl, wTextControl
    res 7, [hl]
    ld a, [wTextSpeed]
    cp $07
    jr z, .skip
    ld hl, $2a66
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
    db $06, $0c, $14, $1a, $20, $28, $30

; <INSTANT> ($ED): sets wTextControl bit 7, so StepTextPrinter prints on at once until a wait
; command or ClearStringDisplayFlags clears it. (C2, E-0373)
; <INSTANT> ($ED): sets wTextControl bit 7, so StepTextPrinter prints on at once until a wait clears
; it (E-0336)
TextCmd_Instant::
    ld hl, wTextControl
    set 7, [hl]
    ret

; <CLEAR_LINE> ($EE), the second half of <NEXT>: writes the first line tile numbers
; (wTextWindowTileLo/Hi / 16 onward, wTextWindowWidth of them) to the BG map row at
; wTextCursorLo/Hi, blanks the row below ($20, BlankBGMapEntriesRight), fills the second line tiles
; (16 * wTextWindowWidth bytes from wTextWindowTileLo/Hi + 16 * wTextWindowWidth) with the blank
; $FF, $00 pattern, writes the second line tile numbers to the row at wTextCursorLo/Hi + $40, then
; sets wTextGlyphDestLo/Hi = wTextLineStartLo/Hi (start of the current line) and clears wTextFlags
; bit 1. C2 from E-0336. (C1, E-0373)
; <CLEAR_LINE> ($EE): redraws the window's tile rows, clears the second line's tiles and puts the
; glyph cursor back at the start of the current line; the second half of <NEXT> (C2 from E-0336)
TextCmd_ClearLine::
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
    call AddTextCursorToHL
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    call BlankBGMapEntriesRight
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
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
    ld a, $ff
    call WriteVRAMByteInc
    xor a
    call WriteVRAMByteInc
    dec bc
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    pop bc
    ld hl, $0040
    call AddTextCursorToHL

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

; <NEXT_LINE> ($EF), the first half of <NEXT>: when wTextLineStartLo/Hi is not yet the second line
; (wTextWindowTileLo/Hi + 16 * wTextWindowWidth), it moves wTextGlyphDestLo/Hi and
; wTextLineStartLo/Hi there and skips the byte after it (the <CLEAR_LINE>). On the second line it
; scrolls: blanks the BG rows at wTextCursorLo/Hi and wTextCursorLo/Hi + $40, shows the second line
; tiles in the row between (+$20), copies the 16 * wTextWindowWidth tile bytes of the second line
; over the first, and waits 4 frames (wTextFlags bit 7, wTextDelayCounter = 4) before the
; <CLEAR_LINE> runs. C2 from E-0336: <NEXT> takes those frames between its two bytes. (C1, E-0373)
; <NEXT_LINE> ($EF): on the first line moves to the second and skips the byte after it (the
; <CLEAR_LINE> of <NEXT>); on the second copies its tiles up to the first and waits 4 frames (C2
; from E-0336: <NEXT> takes those frames between its two bytes)
TextCmd_NextLine::
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
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
    sub l
    ld e, a
    ld a, d
    sbc h
    ld d, a
    ld a, d
    or e
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
    call AddTextCursorToHL
    ld a, e
    add b
    ld e, a

.loop:
    ld a, e
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    inc e
    dec b
    jr nz, .loop
    ld hl, $0040
    call AddTextCursorToHL
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    call BlankBGMapEntriesRight
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
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
    ld a, [hli]
    ei
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld hl, wTextFlags
    set 7, [hl]
    ld a, $04
    ld [wTextDelayCounter], a
    ret

; @ ($F0): at the end of an inserted text (<BUF0>-<BUF3>, <PLAYER>; wTextFlags bit 4) it clears bit
; 4, hides the arrow (HideTextArrow) and returns wTextPosLo/Hi to the position saved in
; wTextStartPosLo/Hi; otherwise it clears wTextFlags and wTextControl, which ends the text. C2 from
; E-0336. (C1, E-0373)
; @ ($F0): after an inserted text (<BUF0>, <PLAYER>; wTextFlags bit 4) returns to the position saved
; in wTextStartPos; otherwise clears wTextFlags and wTextControl, ending the text (C2 from E-0336)
TextCmd_End::
    ld a, [wTextFlags]
    bit 4, a
    jp z, .clear_text_flags
    ld a, [wTextFlags]
    res 4, a
    ld [wTextFlags], a
    call HideTextArrow
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
    xor a
    ld [wTextFlags], a
    xor a
    ld [wTextControl], a
    ret

; When the arrow is shown (wTextFlags bit 5): clears that bit, writes tile $B4 where the blinking
; arrow is drawn (three rows below wTextCursorLo/Hi, 9 columns in) and plays sound $69 unless
; wGameMode is 4 (battle). Otherwise it does nothing. (C1, E-0373)
; when the arrow is shown (wTextFlags bit 5): clears that bit, writes tile $B4 where the blinking
; arrow is drawn and plays sound $69 unless wGameMode is 4 (E-0120, E-0336; was HideTextArrow)
HideTextArrow::
    ld a, [wTextFlags]
    bit 5, a
    ret z
    res 5, a
    ld [wTextFlags], a
    ld hl, $0060
    call AddTextCursorToHL
    ld b, $09
    call AdvanceBGMapColumnsByB
    ld a, $b4
    call WriteVRAMByte
    ld a, [wGameMode]
    cp $04
    ret z
    ld a, $69
    call QueueSoundEffect
    ret

; <LINE> ($F1): moves the glyph cursor to the start of the next line without scrolling:
; wTextGlyphDestLo/Hi and wTextLineStartLo/Hi = wTextLineStartLo/Hi + 16 * wTextWindowWidth. C2 from
; E-0336. (C2, E-0373)
; <LINE> ($F1): moves the glyph cursor to the start of the next line, without scrolling (C2 from
; E-0336)
TextCmd_Line::
    ld a, [wTextWindowWidth]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
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

; <CLEAR> ($F2): hides the arrow (HideTextArrow), ends <INSTANT> and <FAST>
; (ClearStringDisplayFlags), fills the window tiles with the blank pattern (FillTilesFromRequest)
; and falls into TextCmd_Home, which puts the glyph cursor on the first line. (C1, E-0373)
; <CLEAR> ($F2): hides the arrow, ends <INSTANT>/<FAST>, fills the window tiles with the blank
; pattern (FillTilesFromRequest) and falls into TextCmd_Home (E-0336)
TextCmd_Clear::
    call HideTextArrow
    call ClearStringDisplayFlags
    call FillTilesFromRequest

; <HOME> ($F3): moves the glyph cursor to the first line of the window: wTextGlyphDestLo/Hi and
; wTextLineStartLo/Hi = wTextWindowTileLo/Hi. Also the tail of TextCmd_Clear. (C2, E-0373)
; <HOME> ($F3): moves the glyph cursor to the window's first line (E-0336)
TextCmd_Home::
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

; <NORMAL> ($F4) and a helper: clears wTextControl bit 7 (<INSTANT>) and wTextFlags bit 1 (<FAST>),
; nothing else. (C2, E-0373)
; <NORMAL> ($F4) and a helper: clears bit 7 of wTextControl (<INSTANT>) and bit 1 of wTextFlags
; (<FAST>) (E-0114, E-0336)
ClearStringDisplayFlags::
    ld hl, wTextControl
    res 7, [hl]
    ld hl, wTextFlags
    res 1, [hl]
    ret

; <FAST> ($F5): sets wTextFlags bit 1, so glyphs are drawn without waiting for the text speed. (C2,
; E-0373)
; <FAST> ($F5): sets wTextFlags bit 1, so glyphs are drawn without waiting for the text speed
; (E-0336)
TextCmd_Fast::
    ld hl, wTextFlags
    set 1, [hl]
    ret

; <PLAYER> ($F6): copies the 10 bytes of wPlayerName to wPlayerNameText with a $F0 after them, sets
; wTextFlags bit 4, saves wTextPosLo/Hi in wTextStartPosLo/Hi and points wTextPosLo/Hi at
; wPlayerNameText, so the name prints next and its @ (TextCmd_End) returns to the text. (C2, E-0373)
; <PLAYER> ($F6): copies wPlayerName to wPlayerNameText with a $F0, saves the position and prints
; the name, then returns (TextCmd_End) (E-0336)
TextCmd_Player::
    ld hl, wPlayerName
    ld de, wPlayerNameText
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
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

; <WAIT> ($F7): sets wTextFlags bit 2 and clears wTextControl bit 7: the text waits for a button. C2
; from E-0336: it holds until A is pressed. (C2, E-0373)
; <WAIT> ($F7): sets wTextFlags bit 2: the text waits for a button (C2 from E-0336: it holds until A
; is pressed)
TextCmd_Wait::
    ld hl, wTextFlags
    set 2, [hl]
    ld hl, wTextControl
    res 7, [hl]
    ret

; <SPEED> ($F8): sets wTextFlags bit 3 and stores the next byte in wTextControlArg (wTextPosLo/Hi
; moves past it); from here on glyphs wait that many frames instead of wTextSpeed. (C2, E-0373)
; <SPEED> ($F8): from here on glyphs wait the frames in the next byte (wTextControlArg, wTextFlags
; bit 3) instead of wTextSpeed (E-0336)
TextCmd_Speed::
    ld hl, wTextFlags
    set 3, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextControlArg], a
    ret

; <BUF> ($F9): sets wTextFlags bit 4, saves wTextPosLo/Hi + 1 (past the argument byte) in
; wTextStartPosLo/Hi and points wTextPosLo/Hi at wTextBuf0 + the argument byte, so that
; $F0-terminated text prints next and its @ returns. C2 from E-0336: offsets $00, $10, $20 and $30
; are wTextBuf0-3; charmap.inc names them <BUF0>-<BUF3>. (C2, E-0373)
; <BUF> ($F9): saves the position after the argument byte and prints the $F0-terminated text at
; wTextBuf0 + that byte, then returns (C2 from E-0336: offsets $00, $10, $20 and $30 are
; wTextBuf0-3; charmap.inc names them <BUF0>-<BUF3>)
TextCmd_Buf::
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
    add $01
    ld [wTextStartPosLo], a
    ld a, [wTextStartPosHi]
    adc $00
    ld [wTextStartPosHi], a
    ld de, wTextBuf0
    ld a, [hl]
    add e
    ld l, a
    ld a, $00
    adc d
    ld h, a
    ld a, l
    ld [wTextPosLo], a
    ld a, h
    ld [wTextPosHi], a
    ret

; <ARROW> ($FA): sets wTextFlags bit 5: PrintTextStep blinks the arrow (tiles $BD and $B4) while the
; text waits. (C2, E-0373)
; <ARROW> ($FA): sets wTextFlags bit 5: PrintTextStep blinks the arrow (tiles $BD and $B4) while the
; text waits (E-0336)
TextCmd_Arrow::
    ld hl, wTextFlags
    set 5, [hl]
    ret

; <WAIT_OR_BUTTON> ($FB): sets wTextFlags bit 6, stores the next byte in wTextRepeatCount
; (wTextPosLo/Hi moves past it) and clears wTextControl bit 7: the text waits that many frames or
; until a button. (C2, E-0373)
; <WAIT_OR_BUTTON> ($FB): waits the frames in the next byte (wTextRepeatCount) or until a button
; (E-0336)
TextCmd_WaitOrButton::
    ld hl, wTextFlags
    set 6, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextRepeatCount], a
    ld hl, wTextControl
    res 7, [hl]
    ret

; <DELAY> ($FC): sets wTextFlags bit 7, stores the next byte in wTextDelayCounter (wTextPosLo/Hi
; moves past it) and clears wTextControl bit 7: the text waits that many frames. (C2, E-0373)
; <DELAY> ($FC): waits the frames in the next byte (wTextDelayCounter) (E-0336)
TextCmd_Delay::
    ld hl, wTextFlags
    set 7, [hl]
    call IncrementTextPosLoWord
    ld a, [hl]
    ld [wTextDelayCounter], a
    ld hl, wTextControl
    res 7, [hl]
    ret

; <BEEP_ON> ($FD): turns the speech beep on (wTextControl bit 0) with the current wTextBeepSound.
; (C2, E-0373)
; <BEEP_ON> ($FD): speech beep on with the current sound (E-0336)
TextCmd_BeepOn::
    ld hl, wTextControl
    set 0, [hl]
    ret

; <BEEP_OFF> ($FE): turns the speech beep off (clears wTextControl bit 0). (C2, E-0373)
; <BEEP_OFF> ($FE): speech beep off (E-0336)
TextCmd_BeepOff::
    ld hl, wTextControl
    res 0, [hl]
    ret

; The yes/no choice of the text printer: entry $FF (<CHOICE>) of the RunTextCommand table, also run
; by TextCmd_ChoiceE6 and TextCmd_ChoiceNo (which then sets wTextYesNoResult = 1). It clears
; wTextControl bit 7, queues sound effect $6C, draws the window (OpenTextChoice_DrawWindow, which
; first saves the two tiles under it in wScriptTileBuf0/1), sets wTextFlags bit 2 and clears
; wTextYesNoResult (0 = yes). PrintTextStep then toggles the answer with up or down (sound $69) and
; takes A, or B for no. (C1, E-0373)
; <CHOICE> ($FF) and the other choices: plays sound $6C, draws the yes/no window
; (TextPromptWindowTiles), sets wTextFlags bit 2 and clears wTextYesNoResult (0 = yes);
; PrintTextStep then moves the cursor with up/down and takes A or B (B answers no) (E-0122, E-0336;
; was OpenTextChoice)
OpenTextChoice::
    ld hl, wTextControl
    res 7, [hl]
    ld a, $6c
    call QueueSoundEffect
    call OpenTextChoice_DrawWindow
    ld hl, wTextFlags
    set 2, [hl]
    xor a
    ld [wTextYesNoResult], a
    ret

; Draws the yes/no choice window: uploads the two choice tiles from wScriptTileBuf0/1 and two more
; from bank $1F, then writes the window from TextPromptWindowTiles to the BG map 14 columns right of
; the scroll position ($FD starts a new row, $FE ends); on CGB it writes the attributes from
; TextPromptWindowAttrs to VRAM bank 1 in the same way. (C1, E-0357)
OpenTextChoice_DrawWindow::
    call SaveTwoTilesToScriptTileBuf
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, $0100
    call BGMapAddressAtScrollPlusHL
    ld b, $0e
    call AdvanceBGMapColumnsByB
    push hl
    ld de, TextPromptWindowTiles

.skip:
    push hl

.skip2:
    ld a, [de]
    inc de
    cp $fe
    jr z, .check_is_cgb
    cp $fd
    jr nz, .call_write_vram_byte
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $03
    or $98
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
    or a
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
    cp $fe
    jr z, .skip5
    cp $fd
    jr nz, .call_write_vram_byte2
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $03
    or $98
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

; Saves the two tiles at vTiles1 + $6E0 and + $6F0 into wScriptTileBuf0 and wScriptTileBuf1 (16
; bytes each, CopyCBytesToVRAMWaitSTAT copies from HL = VRAM to DE = the buffer). Only caller:
; OpenTextChoice_DrawWindow, which then loads the choice tiles from bank $1F over those two tiles;
; ScriptFetchSkipIfNo copies the saved tiles back to VRAM. The earlier reading (tiles copied from
; the buffers to VRAM) had the direction reversed. (C2, E-0373)
; copies the 16-byte tiles at wScriptTileBuf0 and wScriptTileBuf1 to vTiles1 + $6E0 and + $6F0
; (CopyCBytesToVRAMWaitSTAT) (E-0117)
SaveTwoTilesToScriptTileBuf::
    ld hl, vTiles1 + $6e0
    ld de, wScriptTileBuf0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT
    ld hl, vTiles1 + $6f0
    ld de, wScriptTileBuf1
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT
    ret

; Copies C bytes from HL to DE, waiting before each byte until rSTAT bit 1 is clear (hardware: LCD
; mode 0 or 1, when VRAM can be accessed); interrupts are left as they are. HL and DE end past the
; copied bytes, C = 0. Its only user, SaveTwoTilesToScriptTileBuf, copies from VRAM into WRAM with
; it. (C1, E-0373)
; copies C bytes from HL to DE, waiting for rSTAT bit 1 to clear before each (interrupts stay on);
; HL and DE advance, C = 0 (E-0090)
CopyCBytesToVRAMWaitSTAT::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, CopyCBytesToVRAMWaitSTAT
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, CopyCBytesToVRAMWaitSTAT
    ret

; OpenTextChoice writes these bytes to the BG map (WriteVRAMByte) from 14 columns right of scroll +
; $100, moving to the next 32-byte row at $FD and stopping at $FE; 5 rows of 6 (E-0239, C1)
; record: one 6-tile row and its separator
TextPromptWindowTiles::
    db $b0, $b1, $b1, $b1, $b1, $b2, $fd ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7, $fd ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7, $fd ; id 2
    db $b6, $c3, $ee, $ef, $c3, $b7, $fd ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5, $fe ; id 4

; OpenTextChoice writes these bytes to the BG map in VRAM bank 1 (CGB only) from 14 columns right of
; scroll + $100, moving to the next 32-byte row at $FD and stopping at $FE; 5 rows of 6 (E-0239, C1)
TextPromptWindowAttrs::
    db $00, $00, $00, $00, $00, $00, $fd ; id 0
    db $00, $00, $00, $00, $00, $00, $fd ; id 1
    db $00, $00, $00, $00, $00, $00, $fd ; id 2
    db $00, $00, $00, $00, $00, $00, $fd ; id 3
    db $00, $00, $00, $00, $00, $00, $fe ; id 4

; DE = table of word pointers, one list per string category: returns DE = word wStringIndex of the
; list that word wStringCategory of the table points at (both indexes doubled in 16 bits), with HL
; on the high byte of that word. It also stores the bank mapped at $4000 (its first byte,
; BANK_NUMBER_BYTE) in wStringBank, which the printer maps later. Callers: BeginStringDisplay and
; CopyStringToBuffer. (C2, E-0373)
; DE = table of 16-bit pointers, one per category; wStringCategory = category, wStringIndex = index;
; returns DE = the string pointer; stores the current ROM bank in wStringBank
LookupString::
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

; Returns HL = the text pointer wTextPosLo/wTextPosHi and then increments that stored word (with
; carry), so [HL] is the current string byte and the next call reads the one after; A ends as the
; new high byte. The text commands use it to fetch their argument bytes (TextCmd_SfxWait,
; TextCmd_Cursor and others). (C2, E-0373)
; HL = the word at wTextPosLo/wTextPosHi, then that word += 1 (E-0090)
IncrementTextPosLoWord::
    ld a, [wTextPosLo]
    ld l, a
    ld a, [wTextPosHi]
    ld h, a
    ld a, l
    add $01
    ld [wTextPosLo], a
    ld a, h
    adc $00
    ld [wTextPosHi], a
    ret

; H = string category, L = string index: stores them in wStringCategory and wStringIndex and
; far-calls BeginStringDisplay_Bank08, which starts the text printer on that string of
; StringDatabase (categories 9 and above go to BeginStringDisplay_Bank08_Overflow). Unlike
; ShowString_Bank08 it does not run the display to its end. No call or jump to it was found. (C1,
; E-0373)
; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank08 (E-0114)
ShowStringHL_Bank08::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ret

; H = string category, L = string index, DE = destination: stores them in wStringCategory,
; wStringIndex and wStringDestLo/Hi and far-calls CopyStringToBuffer_Bank08, which copies the string
; with its $F0 terminator to DE. wStringBank ends as the bank of the string list: $08, or $95 for
; categories 9 and above, where CopyStringToBuffer_Bank08_Overflow also leaves wStringCategory
; reduced by 9. 25 call sites in banks $03, $16, $31 and others. (C2, E-0373)
; H = string category, L = string index, DE = destination: stores them in wStringDestLo/Hi,
; wStringCategory and wStringIndex and far-calls CopyStringToBuffer_Bank08, which copies the string
; with its $F0 terminator to DE (categories 9 and above go to CopyStringToBuffer_Bank08_Overflow)
; (E-0059)
CopyStringHLToDE::
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

; HL = first tile address, D = width, E = rows: stores HL in wTextWindowTileLo/Hi, E in
; wTextWindowRows and D in wTextWindowWidth (the text window layout the printer also uses), then
; FillTilesFromRequest fills D * E consecutive tiles from HL with the 16-byte pattern at
; SolidColor1Tile ($FF, $00 repeated: every pixel color 1), each byte waiting for VRAM access.
; FillTilesFromRequest returns at once only when both counts are 0. GameMode0_Init clears 112 tiles
; at vTiles1 and at vTiles2 with DE = $1007. (C1, E-0373)
; HL = tile destination, DE = size: E goes to wTextWindowRows (the tiles FillTilesFromRequest fills
; in each pass) and D to wTextWindowWidth (the number of passes); then calls FillTilesFromRequest
; (E-0353: corrected; was: HL = destination, DE = size (E = width, D = height); stores them and
; calls FillTilesFromRequest)
FillTilesRequest::
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

; HL = destination, A = value (0-255): writes the decimal digits of A as bytes 0-9 (the font codes
; of '0'-'9') without leading zeros, then $F0; HL ends on the terminator. The hundreds and tens come
; from WriteDecimalDigitForE (inner zeros are written: 100 gives 1, 0, 0); clobbers A, D and E. (C2,
; E-0373)
; HL = destination: writes A (0-255) as 1-3 decimal digit glyphs (charmap '0' = $00) without leading
; zeros, then $F0; HL ends on the terminator; clobbers A, D, E (E-0074)
WriteDecimalByteString::
    cp $64
    jr nc, .call_write_decimal_digit_for_e
    cp $0a
    jr nc, .call_write_decimal_digit_for_e2
    jr .skip

.call_write_decimal_digit_for_e:
    ld e, $64
    call WriteDecimalDigitForE

.call_write_decimal_digit_for_e2:
    ld e, $0a
    call WriteDecimalDigitForE

.skip:
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

; Digit step of WriteDecimalByteString: D = A / E by repeated subtraction (counted in 8 bits),
; stored at HL, HL += 1, and A = A mod E (A is kept when it is below E, with digit 0). (C2, E-0373)
; D = A / E by repeated subtraction, stored at HL; HL += 1; A = the remainder (E-0074)
WriteDecimalDigitForE::
    ld d, $ff

.loop:
    inc d
    sub e
    jr nc, .loop
    add e
    ld [hl], d
    inc hl
    ret

; HL = destination, hTemp0-hTemp2 = a 24-bit number (low byte first): writes its decimal digits as
; bytes without leading zeros, then $F0, HL on the terminator. It tests the places 1,000,000,
; 100,000 and 10,000 with Quotient24ByTemp6DE (divisor in hTemp6:D:E), and from the first non-zero
; one writes every place with Divide24ByTemp6DE and StoreAThenTerminator, then the last four digits
; through WriteBCAsDecimalString (all four once a higher digit was written). The millions digit is
; not limited to 9: $FFFFFF gives the byte $10 first. hTemp6 ends 0, hTemp0-hTemp2 hold the number
; mod 10,000 when it was 10,000 or more, and wTemp0, wTemp1 and wMenuRowCount are overwritten. (C2,
; E-0373)
; writes the 24-bit number in hTemp0-hTemp2 as decimal digits from the millions down (dividing by
; 1,000,000, 100,000 and 10,000), then the 16-bit remainder through the shared writer (E-0127)
WriteNumber24AsDecimalString::
    ld a, $0f
    ldh [hTemp6], a
    ld e, $40
    ld d, $42
    call Quotient24ByTemp6DE
    or a
    jp nz, .set_temp6_to_0F
    ld a, $01
    ldh [hTemp6], a
    ld e, $a0
    ld d, $86
    call Quotient24ByTemp6DE
    or a
    jr nz, .set_temp6_to_01
    ld a, $00
    ldh [hTemp6], a
    ld e, $10
    ld d, $27
    call Quotient24ByTemp6DE
    or a
    jr nz, .set_temp6_to_00
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    jp WriteBCAsDecimalString

.set_temp6_to_0F:
    ld a, $0f
    ldh [hTemp6], a
    ld e, $40
    ld d, $42
    call Divide24ByTemp6DE
    call StoreAThenTerminator

.set_temp6_to_01:
    ld a, $01
    ldh [hTemp6], a
    ld e, $a0
    ld d, $86
    call Divide24ByTemp6DE
    call StoreAThenTerminator

.set_temp6_to_00:
    ld a, $00
    ldh [hTemp6], a
    ld e, $10
    ld d, $27
    call Divide24ByTemp6DE
    call StoreAThenTerminator
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    jp WriteBCAsDecimalString_CallDivideBCByDE

; Divide24ByTemp6DE without consuming the dividend: A = hTemp2:hTemp1:hTemp0 / hTemp6:D:E, then
; hTemp0-hTemp2 are restored from the copies it kept in wTemp0, wTemp1 and wMenuRowCount (which keep
; them, so wMenuRowCount is overwritten). WriteNumber24AsDecimalString uses it to find the first
; non-zero digit. (C2, E-0373)
; Divide24ByTemp6DE with hTemp0-hTemp2 restored afterwards (A = the quotient); uses wTemp0, wTemp1
; and wMenuRowCount as scratch, so wMenuRowCount is overwritten (E-0090)
Quotient24ByTemp6DE::
    ldh a, [hTemp0]
    ld [wTemp0], a
    ldh a, [hTemp1]
    ld [wTemp1], a
    ldh a, [hTemp2]
    ld [wMenuRowCount], a
    call Divide24ByTemp6DE
    push af
    ld a, [wTemp0]
    ldh [hTemp0], a
    ld a, [wTemp1]
    ldh [hTemp1], a
    ld a, [wMenuRowCount]
    ldh [hTemp2], a
    pop af
    ret

; A = the 24-bit hTemp2:hTemp1:hTemp0 divided by the 24-bit hTemp6:D:E by repeated subtraction; the
; remainder is left in hTemp0-hTemp2. The quotient is counted in 8 bits and wraps (a quotient of 256
; gives 0); HL is kept and D and E are not changed. (C2, E-0373)
; A = the 24-bit hTemp2:hTemp1:hTemp0 divided by the 24-bit hTemp6:D:E (repeated subtraction; the
; quotient must fit in 8 bits); the remainder is left in hTemp0-hTemp2; HL kept (E-0090)
Divide24ByTemp6DE::
    push hl
    ldh a, [hTemp6]
    ld l, a
    ld h, $ff

.loop:
    inc h
    ldh a, [hTemp0]
    sub e
    ldh [hTemp0], a
    ldh a, [hTemp1]
    sbc d
    ldh [hTemp1], a
    ldh a, [hTemp2]
    sbc l
    ldh [hTemp2], a
    jr nc, .loop
    ldh a, [hTemp0]
    add e
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc d
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc l
    ldh [hTemp2], a
    ld a, h
    pop hl
    ret

; HL = destination, BC = number: writes its decimal digits as bytes without leading zeros, each
; followed by a $F0 that the next digit overwrites, so HL ends on the final terminator. It finds the
; first non-zero place among 1000, 100 and 10 (DivideBCByDE on a copy of BC) and enters the matching
; step (WriteBCAsDecimalString_CallDivideBCByDE, WriteBCAsDecimalString_CallDivideBCByDE2,
; WriteBCAsDecimalString_CallDivideBCByDE3 or WriteBCAsDecimalString_Ones), which write every later
; place, inner zeros included. A number of 10,000 or more gives a first byte above 9 (12345 gives
; $0C, 3, 4, 5). (C2, E-0373)
; writes BC (below 10,000) as decimal digit bytes at HL without leading zeros, each followed by a
; $F0 terminator that the next digit overwrites (DivideBCByDE by 1000, 100, 10, then the remainder)
; (E-0180)
WriteBCAsDecimalString::
    ld de, $03e8
    push bc
    call DivideBCByDE
    pop bc
    or a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE
    ld de, $0064
    push bc
    call DivideBCByDE
    pop bc
    or a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE2
    ld de, $000a
    push bc
    call DivideBCByDE
    pop bc
    or a
    jr nz, WriteBCAsDecimalString_CallDivideBCByDE3
    jr WriteBCAsDecimalString_Ones

; The thousands digit of WriteBCAsDecimalString: BC / 1000 is stored as a digit and BC keeps the
; remainder. (C2, E-0357; probed E-0374)
WriteBCAsDecimalString_CallDivideBCByDE::
    ld de, $03e8
    call DivideBCByDE
    call StoreAThenTerminator

; The hundreds digit of WriteBCAsDecimalString: BC / 100. (C2, E-0357; probed E-0374)
WriteBCAsDecimalString_CallDivideBCByDE2::
    ld de, $0064
    call DivideBCByDE
    call StoreAThenTerminator

; The tens digit of WriteBCAsDecimalString: BC / 10. (C2, E-0357; probed E-0374)
WriteBCAsDecimalString_CallDivideBCByDE3::
    ld de, $000a
    call DivideBCByDE
    call StoreAThenTerminator

; The ones digit of WriteBCAsDecimalString: stores what is left in C. (C2, E-0357; probed E-0374)
WriteBCAsDecimalString_Ones::
    ld a, c
    call StoreAThenTerminator
    ret

; A = BC / DE by repeated subtraction (the quotient counted in 8 bits), BC = the remainder; HL is
; kept and DE is not changed. BC below DE gives A = 0 with BC unchanged. (C2, E-0373)
; A = BC / DE by repeated subtraction (the quotient must fit in 8 bits), BC = the remainder; HL kept
; (E-0078)
DivideBCByDE::
    push hl
    ld h, $ff

.loop:
    inc h
    ld a, c
    sub e
    ld c, a
    ld a, b
    sbc d
    ld b, a
    jr nc, .loop
    ld a, c
    add e
    ld c, a
    ld a, b
    adc d
    ld b, a
    ld a, h
    pop hl
    ret

; [HL] = A, HL += 1, [HL] = $F0 (the string terminator); A ends as $F0. The digit writers call it
; once per digit, so each digit overwrites the terminator before it. (C2, E-0373)
; [HL] = A, HL += 1, [HL] = $F0 (string terminator) (E-0077)
StoreAThenTerminator::
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

; Copies from DE to HL until 5 bytes other than $8D and $8E have been copied; the $8D/$8E marks
; (which PrintTextStep hands to DrawTextMarkGlyph rather than drawing) are copied without counting,
; and one right after the fifth byte is copied too. Then writes $F0 with HL on it; DE ends past the
; last byte copied, B = 0. 16 call sites in banks $03, $16, $31, $3A and others. (C2, E-0373)
; copies from DE to HL until 5 glyphs other than $8D and $8E have been copied ($8D/$8E, which have
; no charmap entry, are copied without counting); a $8D or $8E right after the fifth glyph is copied
; too; then writes $F0. Clobbers A, B; DE and HL advance (E-0072)
CopyFiveGlyphsPlusMarks::
    ld b, $05

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    cp $8d
    jr z, .loop
    cp $8e
    jr z, .loop
    dec b
    jr nz, .loop
    ld a, [de]
    cp $8d
    jr z, .done
    cp $8e
    jr z, .done
    ld [hl], $f0
    ret

.done:
    ld [hli], a
    ld [hl], $f0
    ret

; HL = BG map address: stores it in wTextCursorLo/Hi and writes consecutive tile numbers, starting
; at the low byte of (wTextWindowTileLo/Hi) / 16, as rows of wTextWindowWidth entries
; (WriteVRAMByte, wrapping inside the 32-entry map row with NextBGMapColumn_Bank00), wTextWindowRows
; rows in all. Every row after the first goes to wTextCursorLo/Hi + $40 (AddTextCursorToHL does not
; move the cursor), so from the third row on each row overwrites the second. No call or jump to it
; was found. (C1, E-0373)
; text cursor wTextCursorLo = HL; writes consecutive tile numbers starting at wTextWindowTileLo / 16
; over the wTextWindowRows x wTextWindowWidth window, rows two map rows apart (E-0125)
WriteWindowTileNumbersAtHL::
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
    call AddTextCursorToHL
    dec c
    jr nz, .loop
    ret

; Moves HL B entries to the right inside its 32-entry BG map row, wrapping at the row end
; (NextBGMapColumn_Bank00 B times); B ends 0, and B = 0 on entry means 256 moves, which leave HL
; where it was. The text printer and OpenTextChoice_DrawWindow use it to reach a column of the text
; window. (C2, E-0373)
; moves HL B entries to the right inside its 32-entry BG map row, wrapping at the row end
; (NextBGMapColumn_Bank00 B times); B = 0 (E-0078)
AdvanceBGMapColumnsByB::
    call NextBGMapColumn_Bank00
    dec b
    jr nz, AdvanceBGMapColumnsByB
    ret

; Moves HL one BG map entry to the right inside its 32-entry row: L = (L & $E0) | ((L + 1) & $1F),
; so the last entry of a row wraps to its first; H, AF and the other registers are kept (the same 15
; bytes appear in 2 banks). (C2, E-0373)
; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping
; at the row end; keeps AF (the same 15 bytes appear in 2 banks)
NextBGMapColumn_Bank00::
    push af
    ld a, l
    and $e0
    push af
    ld a, l
    inc a
    and $1f
    ld l, a
    pop af
    or l
    ld l, a
    pop af
    ret

; Returns HL = wTextCursorLo/Hi + HL, wrapping inside the 1 KB BG map the cursor is in: the high
; byte keeps the upper 6 bits of wTextCursorHi and takes only the low 2 bits of the sum ($9BE0 + $40
; gives $9820). wTextCursorLo/Hi are not changed. The text printer uses it to address rows below the
; cursor. (C2, E-0373)
; HL = wTextCursorLo/wTextCursorHi + HL, with the high byte's low 2 bits wrapped and its upper 6
; bits kept from wTextCursorHi (stays inside one 1 KB BG map) (E-0090)
AddTextCursorToHL::
    ld a, [wTextCursorLo]
    add l
    ld l, a
    ld a, [wTextCursorHi]
    adc h
    and $03
    ld h, a
    ld a, [wTextCursorHi]
    and $fc
    or h
    ld h, a
    ret

; HL = offset in a 32 x 32 BG map: returns HL = $9800 + ((HL + (hScrollY & $F8) * 4 + hScrollX / 8)
; & $3FF), the entry that offset points at counted from the tile at the scroll origin, wrapping
; inside the map; BC ends as the scroll offset. PrintTextStep and OpenTextChoice_DrawWindow use it
; to place the window on the visible screen. (C2, E-0373)
; HL = offset in a 32 x 32 BG map: returns HL = $9800 + ((HL + (hScrollY & $F8) * 4 + hScrollX / 8)
; & $3FF), the entry that offset points at from the scroll origin, wrapping inside the map (E-0090)
BGMapAddressAtScrollPlusHL::
    push hl
    ldh a, [hScrollY]
    and $f8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    and $f8
    rrca
    rrca
    rrca
    add l
    ld c, a
    ld b, h
    pop hl
    ld a, c
    add l
    ld l, a
    ld a, b
    adc h
    and $03
    ld h, a
    and $03
    or $98
    ld h, a
    ret

; Writes tile $C3, the blank interior tile of the text windows (TextPromptWindowTiles), to B BG map
; entries from HL rightward (WriteVRAMByte), wrapping inside the 32-entry row
; (NextBGMapColumn_Bank00); B ends 0. TextCmd_ClearLine and TextCmd_NextLine use it to clear a row
; of the window. (C1, E-0373)
; writes tile $C3 (WriteVRAMByte) to B BG map entries from HL rightward, wrapping inside the
; 32-entry row (NextBGMapColumn_Bank00); B = 0 (E-0090)
BlankBGMapEntriesRight::
    ld a, $c3
    call WriteVRAMByte
    call NextBGMapColumn_Bank00
    dec b
    jr nz, BlankBGMapEntriesRight
    ret

; A = glyph (character code), HL = destination: copies the 16 bytes of that glyph from GlyphFont
; (bank $1F, $4010 + 16 * A) to HL unchanged, mapping bank $1F through rROMB0 and mapping the
; previous bank back; HL ends 16 bytes on. The earlier reading (8 one-bit rows, each byte written
; twice) was wrong: the font is stored as 2bpp tiles and the bytes are copied as they are. No call
; or jump to it was found. (C2, E-0373)
; copies glyph A (8 one-bit rows at $4010 + 16 * A in bank $1F) to HL as a 2bpp tile, each row byte
; written twice (E-0125)
CopyGlyphTileToHL::
    push hl
    ld de, GlyphFont
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1f
    ld [rROMB0], a
    ld b, $08

.loop:
    ld a, [de]
    ld [hli], a
    inc e
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    pop af
    ld [rROMB0], a
    ret

; StartChannelFromTrackHeader.set_sound_event_arg indexes it by (hSndA8Param >> 4) * 2; only entry 0
; exists, and the wave set follows it directly (E-0189, C1)
; record: wave set
SoundWaveSetTable::
    dw SoundWaveSet0 ; id 0

; StartChannelFromTrackHeader.set_sound_event_arg clears rNR30, then copies the 16 bytes at the set
; + wave number * 16 (wave number from hSndSweepOrWave or the track, swapped into the high nibble)
; to $FF30-$FF3F; wave 0 is a sine, 1 a triangle, 2 a square, 3 a sawtooth (E-0189, C1)
; record: one wave RAM image: 32 4-bit samples, two per byte
SoundWaveSet0::
    db $00, $01, $12, $35, $8a, $cd, $ee, $ff, $ff, $fe, $ed, $ca, $85, $32, $11, $00 ; id 0
    db $01, $23, $45, $67, $89, $ab, $cd, $ef, $fe, $dc, $ba, $98, $76, $54, $32, $10 ; id 1
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $ff, $ee, $dd, $cc, $bb, $aa, $99, $88, $77, $66, $55, $44, $33, $22, $11, $00 ; id 3
    db $ff, $ff, $de, $bd, $24, $12, $00, $00, $00, $00, $21, $42, $db, $ed, $ff, $ff ; id 4
    db $ff, $ff, $ee, $ca, $53, $11, $00, $00, $00, $00, $11, $35, $ac, $ee, $ff, $ff ; id 5
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $ff, $00 ; id 6
    db $00, $00, $66, $aa, $bb, $dd, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; id 7
    db $ff, $ff, $ee, $ed, $dd, $cc, $cb, $ba, $a9, $98, $87, $65, $54, $43, $31, $10 ; id 8
    db $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $aa, $bb, $cc, $dd, $ee, $ff, $ff ; id 9
    db $00, $00, $00, $00, $aa, $aa, $bb, $cc, $dd, $dd, $ff, $ff, $ff, $ff, $00, $ff ; id 10
    db $00, $00, $00, $00, $aa, $aa, $bb, $cc, $dd, $dd, $ff, $ff, $ff, $ff, $aa, $ff ; id 11
    db $01, $12, $22, $33, $35, $55, $77, $99, $55, $99, $aa, $bb, $cc, $dd, $ee, $ff ; id 12
    db $fc, $dc, $ba, $90, $70, $50, $30, $15, $15, $15, $15, $22, $55, $77, $aa, $cc ; id 13
    db $ee, $ee, $cd, $ac, $35, $23, $11, $11, $11, $11, $32, $53, $ca, $dc, $ee, $ee ; id 14
    db $dd, $dd, $dd, $dd, $dd, $dd, $dd, $dd, $22, $22, $22, $22, $22, $22, $22, $22 ; id 15

; SoundTick_VolumeModulation indexes it by (hSndA8Param & $0F) * 2; only entry 0 exists, and its
; rows follow it directly (E-0189, C1)
; record: modulation rows
SoundModulationTable::
    dw SoundModulationRows0 ; id 0

; SoundTick_VolumeModulation reads the byte at the rows - $10 + (hSndVibratoDepth | phase), where
; the phase is 4 bits computed from hSndVibratoCounter and hSndVibratoDelay, so row 1 is the first;
; 12 rows end at the routine at InitSoundHardware; what each step does to the pitch or volume is not
; read (E-0189, C1)
; record: 16 steps for one depth value: high nibble is combined with hSndEnvelope, bit 2 selects a
; branch
SoundModulationRows0::
    db $f1, $d0, $b0, $90, $70, $50, $30, $15, $15, $15, $15, $15, $15, $15, $15, $15 ; id 1
    db $f3, $d0, $b0, $90, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $15 ; id 2
    db $89, $98, $a8, $b8, $c8, $d8, $e8, $f5, $f5, $f5, $f5, $f5, $f5, $f5, $f5, $f5 ; id 3
    db $b9, $c8, $d8, $e8, $f1, $d0, $b0, $90, $70, $50, $30, $15, $15, $15, $15, $15 ; id 4
    db $99, $a8, $b8, $c8, $d8, $e8, $f4, $f4, $f0, $e0, $d0, $b0, $90, $70, $50, $35 ; id 5
    db $db, $f3, $d0, $b0, $90, $81, $70, $60, $50, $40, $30, $20, $15, $15, $15, $15 ; id 6
    db $f1, $e0, $d0, $c0, $b0, $a0, $90, $80, $70, $60, $50, $40, $30, $20, $10, $05 ; id 7
    db $f1, $70, $50, $30, $20, $15, $15, $15, $15, $05, $05, $05, $05, $05, $05, $05 ; id 8
    db $f1, $b0, $70, $50, $30, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $05 ; id 9
    db $f1, $b0, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $15, $15, $05 ; id 10
    db $f3, $d0, $b0, $90, $70, $50, $30, $10, $51, $40, $30, $20, $15, $15, $15, $05 ; id 11
    db $09, $18, $28, $38, $48, $58, $68, $78, $88, $98, $a8, $b8, $c8, $d8, $e8, $f5 ; id 12

; Resets the sound engine: SetSoundChannelsToWaitFor with BC = 0 (clears wSoundChannelMask,
; wSoundChannelMaskCount and wSoundChannelsDone), rNR52 = $80 (sound on), rNR51 = 0 and
; wSoundEngineMode = 0, rNR50 = $77. It writes $FF to the first two bytes of each of the 6 slots of
; wSoundChannelSlots ($20 apart), the mark StartSound and SoundTick_ChannelPass read as a free slot,
; clears the 72 label-slot bytes at wSoundLabelSlots, and sets wSoundEngineState = 0 and
; wSoundWaveReload = 0. StartMusic calls it before starting a track. (C1, E-0373)
; first resets the channel masks (the helper called with BC = 0); then rNR52 = $80, rNR51 = 0 and
; wSoundEngineMode = 0, rNR50 = $77; sets the first two bytes of each of the 6 channel slots at
; wSoundChannelSlots ($20 apart) to $FF; clears the 72 bytes at wSoundLabelSlots, wSoundEngineState
; and wSoundWaveReload (E-0353: corrected; was: rNR52 = $80, rNR51 = 0, rNR50 = $77; sets the first
; two bytes of each of the 6 channel slots at wSoundChannelSlots to $FF; clears the 72 bytes at
; wSoundLabelSlots, wSoundEngineState and wSoundWaveReload; calls SetSoundChannelsToWaitFor with BC
; = 0)
InitSoundHardware::
    ld bc, $0000
    call SetSoundChannelsToWaitFor
    ld a, $80
    ldh [rNR52], a
    xor a
    ldh [rNR51], a
    ld [wSoundEngineMode], a
    ld a, $77
    ldh [rNR50], a
    ld hl, wSoundChannelSlots
    ld de, $0020
    ld b, $06
    ld a, $ff

.loop:
    ld [hli], a
    ld [hld], a
    add hl, de
    dec b
    jr nz, .loop
    ld hl, wSoundLabelSlots
    ld b, $48
    xor a

.loop2:
    ld [hli], a
    dec b
    jr nz, .loop2
    xor a
    ld [wSoundEngineState], a
    ld [wSoundWaveReload], a
    ret

; Sets wSoundEngineState = 0, the channel slot SoundTick starts its pass at, so all six slots of
; wSoundChannelSlots are processed again, and copies wSoundSavedMode back into wSoundEngineMode, the
; stereo mask SoundTick_NextChannel writes to rNR51; clobbers A. Its neighbour
; SetSoundEngineStateTo4AndClearSoundEngineMode does the opposite (start at slot 4, mask 0). No
; caller and no code that writes wSoundSavedMode was found. (C2, E-0372; probed E-0374)
; wSoundEngineState = 0, wSoundEngineMode = wSoundSavedMode (sound engine state) (E-0119)
SoundRunAllSlotsRestoreMode::
    xor a
    ld [wSoundEngineState], a
    ld a, [wSoundSavedMode]
    ld [wSoundEngineMode], a
    ret

; Sets wSoundEngineState = 4 and wSoundEngineMode = 0. SoundTick copies wSoundEngineState into
; wSoundChannelIndex and stops at index 6, so it then makes only two passes, numbered 4 and 5, over
; the first two slots of wSoundChannelSlots (its slot pointer always starts at slot 0);
; wSoundEngineMode is the stereo mask written to rNR51. The opposite of SoundRunAllSlotsRestoreMode;
; no call or jump to it was found. (C2, E-0373)
; wSoundEngineState = 4, wSoundEngineMode = 0 (sound engine state) (E-0119)
SetSoundEngineStateTo4AndClearSoundEngineMode::
    ld a, $04
    ld [wSoundEngineState], a
    xor a
    ld [wSoundEngineMode], a
    ret

; Sets which sound channels to wait for (wSoundChannelMask = B, and C into wSoundChannelMaskCount)
; and clears the set of channels that have finished. InitSoundHardware calls it with BC = 0. (C2,
; E-0357; probed E-0374)
SetSoundChannelsToWaitFor::
    ld a, b
    ld [wSoundChannelMask], a
    ld a, c
    ld [wSoundChannelMaskCount], a
    xor a
    ld [wSoundChannelsDone], a
    ret

; Marks the current sound channel (wSoundChannelIndex) as finished: ORs bit (index) into
; wSoundChannelsDone. (C2, E-0357; probed E-0374)
SoundTick_MarkChannelDone::
    ld a, [wSoundChannelIndex]
    inc a
    ld b, a
    ld a, $01

.next:
    dec b
    jr z, .check_sound_channels_done
    add a
    jr .next

.check_sound_channels_done:
    ld b, a
    ld a, [wSoundChannelsDone]
    or b
    ld [wSoundChannelsDone], a
    ret

; When every channel in wSoundChannelMask has finished, writes the low nibble of
; wSoundChannelMaskCount into the low nibble of byte 6 of each of those channels' 32-byte slots in
; wSoundChannelSlots, then clears the mask; it always clears wSoundChannelsDone. What byte 6
; controls is not yet known. (C2, E-0357; probed E-0374)
SoundTick_CheckChannelsDone::
    ld a, [wSoundChannelsDone]
    ld hl, wSoundChannelMask
    and [hl]
    cp [hl]
    jr nz, .clear_sound_channels_done
    ld hl, wSoundChannelSlots + $6
    ld a, [wSoundChannelMaskCount]
    and $0f
    ld b, a
    ld a, [wSoundChannelMask]

.loop:
    srl a
    ld [wSoundChannelsDone], a
    jr nc, .skip
    ld a, [hl]
    and $f0
    or b
    ld [hl], a

.skip:
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSoundChannelsDone]
    and a
    jr nz, .loop
    xor a
    ld [wSoundChannelMask], a

.clear_sound_channels_done:
    xor a
    ld [wSoundChannelsDone], a
    ret

; Runs StartSoundAfterBankTable for A, A + 1 and A + 2 and falls into it for A + 3, returning A + 4
; with wSoundId = A + 3. Every id lands in slot 0 of wSoundChannelSlots (see
; StartSoundAfterBankTable). No call or jump to it was found. (C2, E-0373)
; runs StartSoundAfterBankTable three times and falls into it once more (E-0122)
StartFourSoundsAfterBankTable::
    call StartSoundAfterBankTable
    call StartSoundAfterBankTable
    call StartSoundAfterBankTable

; StartSound with HL = $3E24, the second $FF after SoundBankTable, instead of the table: it saves
; BC, DE and HL, stores A in wSoundId and enters StartSound_FromTable. For any A below $FF the walk
; stops at once and reads the 4 bytes before $3E24 as the range: bank $FF, records at $4340, first
; id 1. Bank $FF is empty (all zero), so every id fills slot 0 of wSoundChannelSlots from a zero
; record (track pointer $0000, bank byte 0, $FF at byte 10), clearing stereo bits of
; wSoundEngineMode first if the slot was in use; returns A + 1. Only StartFourSoundsAfterBankTable
; reaches it, and neither has a caller. (C2, E-0373)
; wSoundId = A, then runs the sound entry from table $3E24 (registers saved) (E-0122)
StartSoundAfterBankTable::
    push bc
    push de
    push hl
    ld [wSoundId], a
    ld hl, $3e24
    jr StartSound_FromTable

; Calls StartSound and falls into StartThreeSoundTracks, so four sound ids start together: A, A + 1,
; A + 2 and A + 3. StartMusic uses it for music ids $02, $0F and $58. (C2, E-0369; probed E-0374)
StartFourSoundTracks::
    call StartSound

; Calls StartSound (which returns A + 1) and falls into StartTwoSoundTracks, so sound ids A, A + 1
; and A + 2 start and it returns A + 3. StartMusic uses it for most music ids, and StartSoundEffect
; for some effect ids. (C2, E-0373)
; calls StartSound (which returns A + 1) and falls into StartTwoSoundTracks, so sound ids A, A + 1
; and A + 2 start (E-0126)
StartThreeSoundTracks::
    call StartSound

; Calls StartSound and falls into it once more, so sound ids A and A + 1 start and it returns A + 2.
; StartMusic uses it for music ids $40, $42, $44, $46, $48, $50 and $52, and StartSoundEffect for
; some effect ids. (C2, E-0373)
; calls StartSound and falls into it once more, so sound ids A and A + 1 start (E-0126)
StartTwoSoundTracks::
    call StartSound

; A = sound id: starts it and returns A + 1 with BC, DE and HL kept. It stores A in wSoundId, walks
; SoundBankTable to the range holding it (ranges start at ids 0, $1C, $31 and $A8, banks $40-$43),
; maps that bank and reads the 4-byte record at the range array + 4 * (id - first id): a slot offset
; into wSoundChannelSlots, a flags byte and the track pointer. If the slot is in use (byte 0 not
; $FF), the low two bits of its byte 1 pick the stereo bits of wSoundEngineMode to clear ($EE, $DD,
; $BB or $77). The 32-byte slot then gets 0, 0, the flags, the track pointer, the bank, $FF at byte
; 10 and zeros at bytes 21 and 25-31, and the ROM bank is restored. An earlier emulation of 495
; sound starts agreed with this reading. (C2, E-0373)
StartSound::
    push bc
    push de
    push hl
    ld [wSoundId], a
    ld hl, SoundBankTable

; The body of StartSound (and of StartSoundAfterBankTable), entered with BC, DE and HL pushed and HL
; at the table. It walks SoundBankTable (4-byte entries) to the range that holds wSoundId, maps that
; range bank and reads the sound record at the range array + 4 * (id - first id): a slot offset into
; wSoundChannelSlots, a flags byte and the track pointer. If the slot is in use (its byte 0 is not
; $FF), the low two bits of the slot old byte 1 pick the stereo bits of wSoundEngineMode to clear
; ($EE, $DD, $BB or $77). The 32-byte slot then gets 0, 0, the flags, the track pointer, the bank,
; $FF at byte 10 and zeros at bytes 21 and 25-31. It restores the ROM bank, returns A = wSoundId + 1
; and pops HL, DE and BC. (C2, E-0374)
StartSound_FromTable::
    cp [hl]
    jr c, .skip
    inc hl
    inc hl
    inc hl
    inc hl
    jr StartSound_FromTable

.skip:
    ld a, [BANK_NUMBER_BYTE]
    push af
    dec hl
    ld a, [hld]
    ld [rROMB0], a
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec hl
    ld a, [wSoundId]
    sub [hl]
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
    cp $ff
    jr z, .skip2
    inc hl
    ld a, [hld]
    ld b, $ee
    and $03
    jr z, .check_sound_engine_mode
    ld b, $dd
    cp $01
    jr z, .check_sound_engine_mode
    ld b, $bb
    cp $02
    jr z, .check_sound_engine_mode
    ld b, $77

.check_sound_engine_mode:
    ld a, [wSoundEngineMode]
    and b
    ld [wSoundEngineMode], a

.skip2:
    xor a
    ld [hli], a
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [BANK_NUMBER_BYTE]
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, $ff
    ld [hli], a
    xor a
    push de
    ld de, $000e
    add hl, de
    pop de
    push hl
    ld [hli], a
    ld [hli], a
    ld [hld], a
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
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    pop af
    ld [rROMB0], a
    ld a, [wSoundId]
    inc a
    pop hl
    pop de
    pop bc
    ret

; The sound engine's frame step (from VBlankHandler; E-0018 identified it from its sound register
; writes): saves the ROM bank, starts at channel wSoundEngineState, clears wSoundSkipMaskA, counts
; the frame in wSoundTickBuf and goes on with the per-slot pass from wSoundChannelSlots. (C1,
; E-0357)
; for each of the 6 channel slots at wSoundChannelSlots: copies the slot into HRAM $FFD8-$FFF7,
; reads events from the track in bank hSoundBank and writes the channel's sound registers (the
; per-frame sound engine; called from VBlankHandler)
SoundTick::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wSoundEngineState]
    ld [wSoundChannelIndex], a
    xor a
    ld [wSoundSkipMaskA], a
    ld hl, wSoundTickBuf
    inc [hl]
    ld hl, wSoundChannelSlots

; One pass of SoundTick for the current channel slot (HL). An unused slot (both first bytes $FF) is
; skipped. Otherwise the slot's 32 bytes are copied into the HRAM work area from $FFD8 (hTrackPosLo
; and the bytes after it), the track's bank is mapped, and the channel's hardware number (flags & 3)
; gives its register base (5 bytes per channel) and its bit in the stereo mask. A slot whose track
; position is 0 starts from its track header (StartChannelFromTrackHeader). Otherwise it runs the
; vibrato counter, adds the tempo nibble to a tick accumulator (a tick happens when it passes $10),
; counts down the note and wait timers, steps the envelope, and fetches the next event when the note
; ends. (C1, E-0357)
SoundTick_ChannelPass::
    ld a, [hli]
    ld b, a
    ld a, [hld]
    and b
    cp $ff
    jp z, SoundTick_NextChannel
    push hl
    ld c, $d8
    ld b, $04

.loop:
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    ld a, [hli]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hSoundBank]
    ld [rROMB0], a
    ldh a, [hSndChanFlags]
    and $03
    ld [wSoundHwChannel], a
    ld b, a
    add a
    add a
    add b
    ld [wSoundRegBase], a
    inc b
    ld a, $88

.loop2:
    rlca
    dec b
    jr nz, .loop2
    ld [wSoundSkipMaskB], a
    ld [wSoundNoteWork], a
    ldh a, [hTrackPosLo]
    ld b, a
    ldh a, [hTrackPosHi]
    or b
    and a
    jp z, StartChannelFromTrackHeader
    call SoundTick_PitchOffset
    call SoundTick_PlayingNote
    ldh a, [hSndVibratoDelay]
    ld b, a
    ldh a, [hSndVibratoCounter]
    inc a
    cp b
    jr c, .set_snd_vibrato_counter
    ld a, b

.set_snd_vibrato_counter:
    ldh [hSndVibratoCounter], a
    ld hl, hSndTickAccum
    ldh a, [hSndDutyAndTempo]
    and $0f
    add [hl]
    cp $10
    jr c, .call_sound_tick_volume_slide
    sub $10
    ld [hl], a
    jr SoundTick_EndChannelPass

.call_sound_tick_volume_slide:
    ld [hl], a
    call SoundTick_VolumeSlide
    ldh a, [hSndNoteTimer]
    and a
    jr z, .check_snd_wait_ticks
    dec a
    ldh [hSndNoteTimer], a

.check_snd_wait_ticks:
    ldh a, [hSndWaitTicks]
    and a
    jr nz, SoundTick_WaitCountdown
    ldh a, [hSndEnvFlags]
    and $f0
    jr z, SoundTick_EndNote
    ld hl, hSndEnvTimer
    dec [hl]
    jr nz, SoundTick_EnvelopeCountdown
    ldh a, [hSndEnvelopeReload]
    and $f0
    ld c, a
    ldh a, [hSndEnvelope]
    and $0f
    or c
    ldh [hSndEnvelope], a

; A channel's current note or wait has ended: marks the channel as finished this frame
; (SoundTick_MarkChannelDone) and falls into SoundTick_NextNote. (C1, E-0369)
SoundTick_EndNote::
    call SoundTick_MarkChannelDone

; Starts the next note: reloads the note timer from hSndNoteLength and fetches the next track event
; (SoundNextEvent). (C1, E-0357)
SoundTick_NextNote::
    ldh a, [hSndNoteLength]
    ldh [hSndNoteTimer], a
    call SoundNextEvent
    jr SoundTick_EndChannelPass

; Envelope step: when the envelope counter reaches the value in the low nibble of hSndEnvFlags - 1,
; it recomputes the envelope (SoundTick_StepEnvelope) and writes it to the channel if it changed.
; (C1, E-0357)
SoundTick_EnvelopeCountdown::
    ldh a, [hSndEnvFlags]
    and $0f
    dec a
    cp [hl]
    jr nz, SoundTick_EndChannelPass
    call SoundTick_StepEnvelope
    ldh a, [hSndEnvelope]
    call WriteChannelEnvelopeIfChanged
    jr SoundTick_EndChannelPass

; Counts down hSndWaitTicks; when it reaches 0 and the channel has no envelope steps (hSndEnvFlags
; high nibble 0) the channel is marked finished. (C1, E-0357)
SoundTick_WaitCountdown::
    dec a
    ldh [hSndWaitTicks], a
    jr nz, SoundTick_EndChannelPass
    ldh a, [hSndEnvFlags]
    and $f0
    jr nz, SoundTick_EndChannelPass
    jr SoundTick_EndNote

; End of a channel's pass. For the wave channel (hardware channel 2, slot 2 or later, not muted)
; whose wave set changed (wSoundWaveReload and hSndSweepOrWave different from the last one), it
; switches the wave channel off, loads the new 16-byte wave pattern and switches it back on. It adds
; the channel to the mask of channels this frame has handled (wSoundSkipMaskA), then copies the 32
; HRAM work bytes back into the channel's slot. (C1, E-0357)
SoundTick_EndChannelPass::
    ld a, [wSoundWaveReload]
    and a
    jr z, .read_sound_skip_mask_b
    ld a, [wSoundHwChannel]
    cp $02
    jr nz, .read_sound_skip_mask_b
    ld a, [wSoundChannelIndex]
    cp $02
    jr c, .read_sound_skip_mask_b
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and b
    jr nz, .read_sound_skip_mask_b
    ld a, [wSoundEventArg]
    ld b, a
    ldh a, [hSndSweepOrWave]
    cp b
    jr z, .read_sound_skip_mask_b
    ld e, a
    ld [wSoundEventArg], a
    swap e
    xor a
    ld [wSoundWaveReload], a
    ldh [rNR30], a
    ld d, a
    call LoadWavePattern
    ld a, $80
    ldh [rNR30], a

.read_sound_skip_mask_b:
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    or b
    ld [wSoundSkipMaskA], a
    pop hl
    push hl
    ld c, $d8
    ld b, $04

.loop:
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    ldh a, [c]
    ld [hli], a
    inc c
    dec b
    jr nz, .loop
    pop hl

; Moves to the next of the 6 channel slots (32 bytes on); after the last it applies the stereo mask:
; wSoundEngineMode keeps only the channels that played (wSoundSkipMaskA) and goes to rNR51. Restores
; the ROM bank and checks whether a waited-for group of channels has finished
; (SoundTick_CheckChannelsDone). (C1, E-0357)
SoundTick_NextChannel::
    ld de, $0020
    add hl, de
    ld a, [wSoundChannelIndex]
    inc a
    ld [wSoundChannelIndex], a
    cp $06
    jp c, SoundTick_ChannelPass
    ld a, [wSoundSkipMaskA]
    ld b, a
    ld a, [wSoundEngineMode]
    and b
    ld [wSoundEngineMode], a
    ldh [rNR51], a
    pop af
    ld [rROMB0], a
    call SoundTick_CheckChannelsDone
    ret

; Starts a channel whose track position is 0 (jumped to from SoundTick_ChannelPass): reads the
; 4-byte track header at hTrackBaseLo/Hi. Byte 0 low nibble goes to hSndTickAccum and the tempo
; nibble of hSndDutyAndTempo; byte 1 gives the duty bits (bits 0-1 to 6-7), or hSndVibratoDelay on
; the wave channel (wSoundHwChannel = 2); byte 2, nibbles swapped, goes to hSndEnvelope; byte 3 goes
; to hSndSweepOrWave. On the wave channel it clears rNR30, takes byte 3 as the wave number only when
; hSndSweepOrWave is $FF, stores it in wSoundEventArg and copies that wave (SoundWaveSetTable set
; chosen by hSndWaveParam) to $FF30-$FF3F. Then it clears hSndChanUnused, hSndBranchIndex,
; hSndVibratoDepth, hSndPitchSlide and hTrackPosHi, sets hSndPanning = $FF and hTrackPosLo = 2 (the
; first event after the header) and jumps to SoundTick_NextNote. (C1, E-0373)
; the channel start: reads the 4-byte track header and begins playback at event 2 (see the
; annotation above)
StartChannelFromTrackHeader::
    ldh a, [hTrackBaseLo]
    ld l, a
    ldh a, [hTrackBaseHi]
    ld h, a
    ld a, [hli]
    and $0f
    ld d, a
    ldh [hSndTickAccum], a
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .set_snd_vibrato_delay
    ld a, [hli]
    rrca
    rrca
    and $c0
    or d

.set_snd_duty_and_tempo:
    ldh [hSndDutyAndTempo], a
    ld a, [hli]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .skip
    ld a, [hli]
    ldh [hSndSweepOrWave], a

.clear_snd_chan_unused:
    xor a
    ldh [hSndChanUnused], a
    ldh [hSndBranchIndex], a
    ldh [hSndVibratoDepth], a
    ldh [hSndPitchSlide], a
    ldh [hTrackPosHi], a
    dec a
    ldh [hSndPanning], a
    ld a, $02
    ldh [hTrackPosLo], a
    jp SoundTick_NextNote

.set_snd_vibrato_delay:
    ld a, [hli]
    ldh [hSndVibratoDelay], a
    ld a, d
    jr .set_snd_duty_and_tempo

.skip:
    xor a
    ldh [rNR30], a
    ld d, a
    ldh a, [hSndSweepOrWave]
    ld e, a
    cp $ff
    jr nz, .set_sound_event_arg
    ld e, [hl]
    ld a, e
    ldh [hSndSweepOrWave], a

.set_sound_event_arg:
    ld [wSoundEventArg], a
    swap e
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndWaveParam]
    swap a
    and $0f
    add a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld c, $30
    ld b, $10

.loop:
    ld a, [hli]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop
    jr .clear_snd_chan_unused

; Fetches the next 2-byte event of the current channel: the address is hTrackBaseLo/Hi + 2 *
; hTrackPosLo/Hi, and the position is incremented before the event runs. Bytes $00-$9F are notes:
; the second byte gives hSndWaitTicks (less hSndEnvFlags low nibble when its high nibble is set); a
; semitone of $0C or more (noise channel: $1F) is a rest, otherwise the period comes from
; SoundNotePeriodTable (second row when hSndDutyAndTempo bit 4 is set) shifted right by the octave
; nibble and subtracted from $0800, or for a noise byte below $10 from the table at $38A0 (other
; noise bytes are used as they are), and it falls into ComputeNotePitch. $A0-$AF set channel values
; (envelope, sweep or wave, duty, note length, panning, rNR50, wave set, branch index, envelope
; timer, tuning, tempo, and the loop $AC and return $AD, which move the position first) and go on to
; the next event, except $A7, which sets the wait and ends the fetch; $B0-$BF jump to or repeat from
; a label slot (SoundLabelSlot), $C0-$CF set vibrato, $D0-$EF set the slide, $FD saves the position
; in a label slot and $FF ends the track (position $FFFF; wSoundWaveReload is set when slot 0 or 1
; plays the wave channel; SoundNextEvent_MuteChannel clears its stereo bits). An earlier emulation
; of 5,154 fetches agreed with the address rule. (C1, E-0373)
SoundNextEvent::
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
    add $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc $00
    ldh [hTrackPosHi], a
    ld a, [hli]
    cp $d0
    jr nc, .cp_F0
    cp $b0
    jr nc, .cp_C0
    cp $a0
    jp nc, .cp_A0
    jp .check_snd_env_flags

.loop2:
    cp $fd
    jr z, .call_sound_label_slot
    cp $ff
    jr z, .set_track_pos_lo
    jr .next

.call_sound_label_slot:
    push hl
    ld b, [hl]
    call SoundLabelSlot
    xor a
    ld [hli], a
    ldh a, [hTrackPosLo]
    ld [hli], a
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
    cp $02
    jr nz, .call_sound_next_event_mute_channel
    ld a, [wSoundChannelIndex]
    cp $02
    jr nc, .call_sound_next_event_mute_channel
    ld a, $ff
    ld [wSoundWaveReload], a

.call_sound_next_event_mute_channel:
    call SoundNextEvent_MuteChannel
    ret

.cp_F0:
    cp $f0
    jr nc, .loop2
    cp $e0
    jr nc, .skip
    and $0f
    jr .check_sound_hw_channel

.skip:
    and $0f
    cpl
    inc a

.check_sound_hw_channel:
    ld b, a
    ld a, [wSoundHwChannel]
    cp $02
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
    and $0f
    ld b, a
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .next3
    ldh a, [hSndEnvelope]
    and $0f
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
    cp $c0
    jr nc, .loop3
    and $0f
    jp z, .skip2
    ld e, a
    ld b, [hl]
    push hl
    call SoundLabelSlot
    inc [hl]
    ld a, [hli]
    inc e
    cp e
    jr nc, .restore
    ld a, [hli]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a

.restore:
    pop hl
    jp SoundNextEvent

.skip2:
    ld a, [hl]
    ld b, a
    and $f0
    cp $f0
    jp nz, .next4
    ld b, [hl]
    push hl
    call SoundLabelSlot
    inc hl
    ld a, [hli]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
    pop hl
    jp SoundNextEvent

.next4:
    inc hl
    jp .loop

.cp_A0:
    cp $a0
    jr nz, .cp_A1
    ld a, [hli]
    swap a
    ldh [hSndEnvelope], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and b
    jp nz, .loop
    call WriteChannelEnvelopeIfChanged
    jp .loop

.cp_A1:
    cp $a1
    jr nz, .cp_A2
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .set_snd_sweep_or_wave
    ld a, [hli]
    ldh [hSndSweepOrWave], a
    jp .loop

.set_snd_sweep_or_wave:
    ld a, [hli]
    ld e, a
    ldh [hSndSweepOrWave], a
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and b
    jr z, .skip3
    jp .loop

.skip3:
    xor a
    ldh [rNR30], a
    ld d, a
    push hl
    ld a, e
    ld [wSoundEventArg], a
    swap e
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndWaveParam]
    swap a
    and $0f
    add a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld c, $30
    ld b, $10

.loop4:
    ld a, [hli]
    ldh [c], a
    inc c
    dec b
    jr nz, .loop4
    pop hl
    jp .loop

.cp_A2:
    cp $a2
    jr nz, .cp_A3
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .set_snd_vibrato_delay
    ld a, [hli]
    rrca
    rrca
    and $c0
    ld d, a
    ldh a, [hSndDutyAndTempo]
    and $3f
    or d
    ldh [hSndDutyAndTempo], a
    jp .loop

.set_snd_vibrato_delay:
    ld a, [hli]
    ldh [hSndVibratoDelay], a
    jp .loop

.cp_A3:
    cp $a3
    cp $a3
    jr nz, .cp_A5
    ld a, [hli]
    cp $fe
    jr z, .check_snd_chan_flags
    ld b, a
    and $0f
    add a
    ldh [hSndNoteLength], a
    ldh [hSndNoteTimer], a
    ld a, b
    add $10
    and $f0
    ld e, a
    ldh a, [hSndChanFlags]
    and $0f
    or e

.set_snd_chan_flags:
    ldh [hSndChanFlags], a
    jp .loop

.check_snd_chan_flags:
    ldh a, [hSndChanFlags]
    and $0f
    jr .set_snd_chan_flags

.cp_A5:
    cp $a5
    jr nz, .cp_A6
    ld a, [hli]
    cp $01
    jr nz, .set_snd_panning
    ldh a, [hSndPanning]
    swap a

.set_snd_panning:
    ldh [hSndPanning], a
    jp .loop

.cp_A6:
    cp $a6
    jr nz, .cp_A7
    ld a, [hli]
    ldh [rNR50], a
    jp .loop

.cp_A7:
    cp $a7
    jr nz, .cp_A8
    ld a, [hl]
    ldh [hSndWaitTicks], a
    jp ComputeNotePitch_ApplyPanning

.cp_A8:
    cp $a8
    jr nz, .cp_A9
    ld a, [hli]
    ld c, a
    and $0f
    ld b, a
    ld a, c
    and $f0
    or b
    ldh [hSndWaveParam], a
    jp .loop

.cp_A9:
    cp $a9
    jp nz, .cp_AA
    ld a, [hli]
    cp $f0
    jr z, .check_snd_branch_index
    cp $f1
    jr z, .check_snd_branch_index2
    cp $f2
    jr z, .check_sound_branch_arg
    cp $f3
    jr z, .check_sound_branch_arg2
    cp $fe
    jr z, .read_sound_branch_arg
    cp $ff
    jr nz, .cp_80
    ldh a, [hSndBranchIndex]
    jr .skip4

.read_sound_branch_arg:
    ld a, [wSoundBranchArg]

.skip4:
    sla a
    add l
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
    jp SoundNextEvent

.cp_80:
    cp $80
    jr nc, .set_sound_branch_arg
    ldh [hSndBranchIndex], a
    jp .loop

.set_sound_branch_arg:
    sub $80
    ld [wSoundBranchArg], a
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

.check_sound_branch_arg:
    ld a, [wSoundBranchArg]
    inc a
    ld [wSoundBranchArg], a
    jp .loop

.check_sound_branch_arg2:
    ld a, [wSoundBranchArg]
    dec a
    ld [wSoundBranchArg], a
    jp .loop

.cp_AA:
    cp $aa
    jr nz, .cp_AC
    ld a, [hli]
    ld c, a
    and $f0
    jr z, .clear_snd_env_timer
    swap a
    ldh [hSndEnvTimer], a
    or $f0
    ldh [hSndEnvFlags], a
    ld a, c
    and $0f
    ld c, a
    ldh a, [hSndEnvelopeReload]
    and $f0
    or c
    ldh [hSndEnvelopeReload], a
    jp .loop

.clear_snd_env_timer:
    xor a
    ldh [hSndEnvTimer], a
    ldh [hSndEnvelopeReload], a
    ldh [hSndEnvFlags], a
    jp .loop

.cp_AC:
    cp $ac
    jr nz, .cp_AD
    ldh a, [hSndLoopCount]
    sub $01
    jr z, .clear_snd_loop_count
    jr nc, .set_snd_loop_count
    ld a, [hl]

.set_snd_loop_count:
    ldh [hSndLoopCount], a
    ldh a, [hTrackPosLo]
    sub $01
    ldh [hSndReturnPosLo], a
    ldh a, [hTrackPosHi]
    sbc $00
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
    xor a
    ldh [hSndLoopCount], a
    ldh a, [hTrackPosLo]
    add $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc $00
    ldh [hTrackPosHi], a
    jp SoundNextEvent

.cp_AD:
    cp $ad
    jr nz, .cp_AE
    ldh a, [hSndReturnPosLo]
    ldh [hTrackPosLo], a
    ldh a, [hSndReturnPosHi]
    ldh [hTrackPosHi], a
    jp SoundNextEvent

.cp_AE:
    cp $ae
    jr nz, .cp_AF
    ld a, [hli]
    and $10
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and $ef
    or b
    ldh [hSndDutyAndTempo], a
    jp .loop

.cp_AF:
    cp $af
    jr nz, .next5
    ld a, [hli]
    and $0f
    ldh [hSndTickAccum], a
    ld b, a
    ldh a, [hSndDutyAndTempo]
    and $f0
    or b
    ldh [hSndDutyAndTempo], a
    jp .loop

.next5:
    inc hl
    jp .loop
    db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62

.loop5:
    xor a
    ldh [hSndFreqLo], a
    ld a, $80
    ldh [hSndFreqHi], a
    ld a, [wSoundHwChannel]
    cp $02
    jr z, .call_return_twice_if_sound_skip_mask_a_and
    call SoundNextEvent_SilenceNote
    ret

.call_return_twice_if_sound_skip_mask_a_and:
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    xor a
    ldh [rNR30], a
    ret

.check_snd_env_flags:
    ld b, a
    ldh a, [hSndEnvFlags]
    and $f0
    jr z, .set_snd_wait_ticks
    push de
    ldh a, [hSndEnvFlags]
    and $0f
    ldh [hSndEnvTimer], a
    ld c, a
    ld a, [hl]
    sub c
    ldh [hSndWaitTicks], a
    pop de
    jr .check_sound_hw_channel2

.set_snd_wait_ticks:
    ld a, [hl]
    ldh [hSndWaitTicks], a

.check_sound_hw_channel2:
    ld a, [wSoundHwChannel]
    cp $03
    jr nz, .skip6
    ld a, b
    cp $1f
    jr z, .loop5
    cp $10
    jr nc, .skip5
    ld hl, $38a0
    add l
    ld l, a
    ld a, h
    adc $00
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
    and $0f
    cp $0c
    jr nc, .loop5
    add a
    ld e, a
    ldh a, [hSndDutyAndTempo]
    and $10
    jr z, .skip7
    ld a, e
    add $18
    ld e, a

.skip7:
    ld d, $00
    ld hl, SoundNotePeriodTable
    add hl, de
    deref_hl
    ld a, b
    swap a
    and $0f
    jr z, .skip8
    ld b, a

.loop6:
    srl h
    rr l
    dec b
    jr nz, .loop6

.skip8:
    ld a, $00
    sub l
    ld l, a
    ld a, $08
    sbc h
    ld h, a

; HL = the frequency register value of a note (from SoundNextEvent): clears hSndVibratoCounter and
; returns to the caller of its caller when ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB says the
; channel is skipped. On the wave channel it loads the wave pattern if it changed and sets rNR30 =
; $80. It writes the volume (ComputeNotePitch_WriteNR32), the sweep hSndSweepOrWave on channel 1,
; and L to register + $13, keeping L clamped to $02-$FD in hSndFreqLo. Channels 1 and 2 also get the
; duty bits with length $3F in register + $11; then the high byte (H & 7, bit 7 restarts the note
; except on a wave channel that is still playing) goes to register + $14 and hSndFreqHi, and the
; stereo bits are set from hSndPanning (ComputeNotePitch_ApplyPanning). (C1, E-0373)
; pitch for a note event: semitone and octave to the frequency register value in HL (see the
; annotation above)
ComputeNotePitch::
    xor a
    ldh [hSndVibratoCounter], a
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundHwChannel]
    cp $02
    jr nz, .call_compute_note_pitch_write_nr32
    call LoadWavePatternIfChanged
    ld a, $80
    ldh [rNR30], a

.call_compute_note_pitch_write_nr32:
    push hl
    call ComputeNotePitch_WriteNR32
    pop hl
    ld a, [wSoundHwChannel]
    and a
    ldh a, [hSndSweepOrWave]
    ld c, $10
    call z, WriteChannelRegisterC
    ld a, l
    ld c, $13
    call WriteChannelRegisterC
    ld a, l
    cp $02
    jr c, .set_snd_freq_lo_to_02
    cp $fe
    jr c, .set_snd_freq_lo
    ld a, $fd
    jr .set_snd_freq_lo

.set_snd_freq_lo_to_02:
    ld a, $02

.set_snd_freq_lo:
    ldh [hSndFreqLo], a
    ld a, [wSoundHwChannel]
    cp $02
    jr z, ComputeNotePitch_WaveChannel
    cp $02
    jr nc, ComputeNotePitch_TriggerChannel
    ldh a, [hSndDutyAndTempo]
    and $c0
    or $3f
    ld c, $11
    call WriteChannelRegisterC

; The high byte of a note's frequency: H & 7 with bit 7 set (restart the channel). (C2, E-0357;
; probed E-0374)
ComputeNotePitch_TriggerChannel::
    ld a, h
    and $07
    or $80

; Writes the frequency high byte (register offset 4, $14) for the current channel, keeping it in
; hSndFreqHi, and clears the length bits of the duty register so the note plays without a length
; cut-off. (C2, E-0357; probed E-0374)
ComputeNotePitch_UpdateFrequency::
    ldh [hSndFreqHi], a
    ld c, $14
    call WriteChannelRegisterC
    call ClearChannelLengthBits

; Sets the current channel's stereo bits in wSoundEngineMode from hSndPanning: the channel's bits
; (wSoundNoteWork) are replaced by the matching bits of hSndPanning. (C2, E-0357; probed E-0374)
ComputeNotePitch_ApplyPanning::
    ld a, [wSoundNoteWork]
    ld b, a
    cpl
    ld c, a
    ldh a, [hSndPanning]
    and b
    ld b, a
    ld a, [wSoundEngineMode]
    and c
    or b
    ld [wSoundEngineMode], a
    ret

; Restarts the wave channel's note: clears rNR31 (the sound length); if the wave channel is not
; running (rNR52 bit 2 clear) it writes the high frequency byte with the restart bit, otherwise
; without it. (C1, E-0357)
ComputeNotePitch_WaveChannel::
    xor a
    ldh [rNR31], a
    ldh a, [rNR52]
    and $04
    jr z, ComputeNotePitch_TriggerChannel
    ld a, h
    and $07
    jr ComputeNotePitch_UpdateFrequency

; The volume slide of a note (not on the wave channel, wSoundHwChannel = 2, and not while
; hSndPitchSlide is 0). Each call counts hSndPitchSlideCounter down; when it reaches 0 and the low
; nibble of hSndEnvelope is 0 it reloads the counter from hSndPitchSlideTime and moves the start
; volume (high nibble of hSndEnvelope) one step: up while hSndPitchSlide is positive (counting it
; down toward 0), down while it is negative (bit 7, counting it up), and writes the new envelope
; with WriteChannelEnvelopeIfChanged. At volume 15 (up) or 0 (down) the slide count still moves but
; the envelope stays. With a non-zero low nibble the counter is left at 0 and not reloaded. The
; names of these HRAM bytes say pitch; the code changes the volume. (C2, E-0374)
SoundTick_VolumeSlide::
    ld a, [wSoundHwChannel]
    cp $02
    ret z
    ldh a, [hSndPitchSlide]
    and a
    ret z
    ld hl, hSndPitchSlideCounter
    dec [hl]
    ret nz
    ldh a, [hSndEnvelope]
    swap a
    cp $10
    ret nc
    and $0f
    ld b, a
    ldh a, [hSndPitchSlideTime]
    ldh [hSndPitchSlideCounter], a
    ld hl, hSndPitchSlide
    ld a, [hl]
    bit 7, a
    jr nz, .skip
    dec [hl]
    ld a, b
    cp $0f
    ret z
    ldh a, [hSndEnvelope]
    add $10
    ldh [hSndEnvelope], a
    jp WriteChannelEnvelopeIfChanged

.skip:
    inc [hl]
    ld a, b
    and a
    ret z
    ldh a, [hSndEnvelope]
    sub $10
    ldh [hSndEnvelope], a
    jr WriteChannelEnvelopeIfChanged

; The pitch offset of a note in progress (not on the noise channel), applied when the note timer has
; run out and the channel flags' high nibble is not 0: adds the entry of SoundPitchOffsetRows chosen
; by that nibble and the low nibble of wSoundTickBuf to the frequency low byte and writes it
; (register offset 3). Skipped when the channel is muted this frame. (C2, E-0357; probed E-0374)
SoundTick_PitchOffset::
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundHwChannel]
    cp $03
    ret z
    ldh a, [hSndNoteTimer]
    and a
    ret nz
    ldh a, [hSndChanFlags]
    and $f0
    ret z
    sub $10
    ld b, a
    ld a, [wSoundTickBuf]
    and $0f
    or b
    ld e, a
    ld d, $00
    ld hl, SoundPitchOffsetRows
    add hl, de
    ldh a, [hSndFreqLo]
    add [hl]
    ld c, $13
    jr WriteChannelRegisterC

; After a note's pitch is set: the wave channel goes to its volume write
; (ComputeNotePitch_WaveLevel); a channel with vibrato depth goes to SoundTick_VolumeModulation;
; otherwise the envelope is written. (C1, E-0357)
ComputeNotePitch_WriteNR32::
    ld a, [wSoundHwChannel]
    cp $02
    jr z, ComputeNotePitch_WaveLevel
    ldh a, [hSndVibratoDepth]
    and a
    jr nz, SoundTick_VolumeModulation
    ldh a, [hSndEnvelope]

; A = envelope: B = A, with bit 3 set when its low three bits are 0 (hardware: an NRx2 value with
; bits 3-7 all 0 switches the channel DAC off). When B differs from the envelope register ($FF00 +
; wSoundRegBase + $12) it writes B there, writes hSndFreqHi to register + $14 (restarting the note)
; and clears the length bits of register + $11 (ClearChannelLengthBits); when equal it returns with
; Z set and writes nothing. B ends as the last value written. Callers: SoundNextEvent_SilenceNote (A
; = 0), ComputeNotePitch_WriteNR32 and the envelope and volume steps. (C2, E-0373)
; B = A (bit 3 set when the low three bits are 0); writes it to the channel envelope register
; (wSoundRegBase + $12) only if it differs, then restarts the channel (E-0124)
WriteChannelEnvelopeIfChanged::
    ld b, a
    and $07
    jr nz, .read_sound_reg_base
    ld a, b
    or $08
    ld b, a

.read_sound_reg_base:
    ld a, [wSoundRegBase]
    add $12
    ld c, a
    ldh a, [c]
    cp b
    ret z
    ld a, b
    ldh [c], a
    ldh a, [hSndFreqHi]
    ld c, $14
    call WriteChannelRegisterC
    call ClearChannelLengthBits
    ret

; A = value, C = register offset: writes A to $FF00 + wSoundRegBase + C, the register of the channel
; being processed (wSoundRegBase is 0 for the first channel, so offset $12 is rNR12); B = A and C
; ends as the register address low byte. (C2, E-0373)
; A = value, C = register offset: writes A to $FF00 + wSoundRegBase + C (wSoundRegBase holds the
; current sound channel's register base); B = A (E-0077)
WriteChannelRegisterC::
    ld b, a
    ld a, [wSoundRegBase]
    add c
    ld c, a
    ld a, b
    ldh [c], a
    ret

; Writes hSndEnvelope to the channel's envelope register (offset 2, $12); for the wave channel this
; is its output level. (C2, E-0357; probed E-0374)
ComputeNotePitch_WaveLevel::
    ldh a, [hSndEnvelope]
    ld c, $12
    jr WriteChannelRegisterC

; [$FF00 + wSoundRegBase + $11] &= $C0: keeps the duty bits of the current channel length/duty
; register and clears its length bits; A ends as the new value and C as the register address low
; byte. Called after each frequency write (ComputeNotePitch_UpdateFrequency,
; WriteChannelEnvelopeIfChanged). (C2, E-0373)
; [$FF00 + wSoundRegBase + $11] &= $C0: keeps the duty bits of the current channel's length/duty
; register and clears its length (E-0114)
ClearChannelLengthBits::
    ld c, $11
    ld a, [wSoundRegBase]
    add c
    ld c, a
    ldh a, [c]
    and $c0
    ldh [c], a
    ret

; Wave-channel volume from the modulation step E: the level (E / 2 + 2) in the high nibble is
; written only when it is at least hSndEnvelope; its level bits ($60) go to rNR32. (C1, E-0357)
SoundTick_VolumeModulation_Wave::
    ld a, e
    srl a
    add $02
    swap a
    ld hl, hSndEnvelope
    cp [hl]
    ret c
    and $60
    ldh [rNR32], a
    ret

; Per-tick checks of a playing note: skipped when the channel is muted this frame; a note with
; frequency 0 (a rest) silences the channel's envelope (SoundNextEvent_SilenceNote); the wave
; channel goes on to SoundTick_VolumeModulation; other channels only when they have vibrato depth
; (hSndVibratoDepth). (C1, E-0369)
SoundTick_PlayingNote::
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ldh a, [hSndFreqLo]
    and a
    jr nz, .check_sound_hw_channel
    ldh a, [hSndFreqHi]
    and $7f
    jp z, SoundNextEvent_SilenceNote

.check_sound_hw_channel:
    ld a, [wSoundHwChannel]
    cp $02
    jr z, SoundTick_VolumeModulation
    ldh a, [hSndVibratoDepth]
    and a
    ret z

; The volume modulation step of a note. From hSndVibratoCounter and the delay hSndVibratoDelay it
; builds a 4-bit position, looks up the modulation row chosen by hSndWaveParam in
; SoundModulationTable, combines the entry with the envelope's start volume through
; SoundEnvelopeScaleTable and writes the result to the channel's envelope register (or, for the wave
; channel, its output level). Called vibrato by the HRAM names; what it changes is the volume. (C1,
; E-0357)
SoundTick_VolumeModulation::
    ldh a, [hSndVibratoDelay]
    and a
    ret z
    ld e, $00
    ld c, a
    ldh a, [hSndVibratoCounter]
    ld b, $04

.loop:
    add a
    cp c
    jr c, .skip
    sub c

.skip:
    ccf
    rl e
    dec b
    jr nz, .loop
    ld a, [wSoundHwChannel]
    cp $02
    jr z, SoundTick_VolumeModulation_Wave
    ldh a, [hSndVibratoDepth]
    or e
    ld e, a
    ld d, $00
    push de
    ldh a, [hSndWaveParam]
    and $0f
    ld de, SoundModulationTable
    sla a
    add e
    ld e, a
    ld a, $00
    adc d
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, l
    sub $10
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    add hl, de
    ldh a, [hSndEnvelope]
    swap a
    ld e, a
    ld a, [hl]
    ld h, a
    and $f0
    or e
    ld e, a
    bit 2, h
    jr nz, .skip4
    inc b
    ld a, c
    swap a
    and $0f
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
    cp $08
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
    and $08
    or b
    ld b, a
    bit 0, h
    jr z, .read_sound_reg_base
    ld hl, SoundEnvelopeScaleTable
    add hl, de
    ld a, [hl]
    or b
    jp WriteChannelEnvelopeIfChanged

.read_sound_reg_base:
    ld c, $12
    ld a, [wSoundRegBase]
    add c
    ld c, a
    ldh a, [c]
    and $08
    ld l, a
    ld a, h
    and $08
    cp l
    ret z
    ld hl, SoundEnvelopeScaleTable
    add hl, de
    ld a, [hl]
    or b
    jp WriteChannelEnvelopeIfChanged

; A rest: unless the channel is muted this frame, writes envelope 0 (silence) to the channel. (C2,
; E-0357; probed E-0374)
SoundNextEvent_SilenceNote::
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, $00
    jp WriteChannelEnvelopeIfChanged

; Unless the channel is muted this frame, clears the channel's stereo bits (wSoundSkipMaskB) in
; wSoundEngineMode, silencing it on both sides. (C2, E-0357; probed E-0374)
SoundNextEvent_MuteChannel::
    call ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB
    ld a, [wSoundSkipMaskB]
    cpl
    ld b, a
    ld a, [wSoundEngineMode]
    and b
    ld [wSoundEngineMode], a
    ret

; When wSoundSkipMaskA & wSoundSkipMaskB is non-zero it pops its return address (into AF), so its
; ret goes back to the caller of its caller and the rest of the caller is skipped; otherwise it
; returns normally with A = 0 and Z set. Clobbers B. Sound routines that write channel registers
; (ComputeNotePitch, SoundNextEvent_SilenceNote, SoundNextEvent_MuteChannel and others) start with
; it. (C2, E-0373)
; when wSoundSkipMaskA & wSoundSkipMaskB is non-zero, drops the caller's return address (pop af) so
; it returns to the caller's caller; otherwise returns normally with Z set (E-0119)
ReturnTwiceIfSoundSkipMaskAAndSoundSkipMaskB::
    ld a, [wSoundSkipMaskB]
    ld b, a
    ld a, [wSoundSkipMaskA]
    and b
    ret z
    pop af
    ret

; E-0209 (C2 for the use, from E-0019's matched formula: the note routine indexes $3B5C by the
; semitone, or $3B74 when $FFDE bit 4 is set; row 1 is the alternative tuning).
; record: 12 semitone periods (shifted right by the octave and subtracted from $0800)
SoundNotePeriodTable::
    dw $07d4, $0764, $06f9, $0695, $0637, $05dd, $0589, $053a, $04f0, $04a8, $0465, $0426 ; id 0
    dw $079c, $072e, $06c7, $0666, $060a, $05b3, $0561, $0515, $04cc, $0486, $0445, $0408 ; id 1

; SoundTick_VolumeModulation.skip5 reads the byte at SoundEnvelopeScaleTable + DE (DE = level row *
; 16 + input) and ORs it into the envelope written by WriteChannelEnvelopeIfChanged; the rows rise
; from all $10 to $00-$F0 (E-0209, C1)
; record: 16 scaled volumes (high nibble) for one level
SoundEnvelopeScaleTable::
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
    db $00, $10, $10, $20, $30, $30, $40, $50, $50, $60, $70, $70, $80, $90, $90, $a0 ; id 10
    db $00, $10, $10, $20, $30, $40, $40, $50, $60, $70, $70, $80, $90, $a0, $a0, $b0 ; id 11
    db $00, $10, $20, $20, $30, $40, $50, $60, $60, $70, $80, $90, $a0, $a0, $b0, $c0 ; id 12
    db $00, $10, $20, $30, $30, $40, $50, $60, $70, $80, $90, $a0, $a0, $b0, $c0, $d0 ; id 13
    db $00, $10, $20, $30, $40, $50, $60, $70, $70, $80, $90, $a0, $b0, $c0, $d0, $e0 ; id 14
    db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90, $a0, $b0, $c0, $d0, $e0, $f0 ; id 15

; the routine before ComputeNotePitch_WriteNR32 adds the byte at SoundPitchOffsetRows +
; ((hSndChanFlags & $F0) - $10) + (wSoundTickBuf0E & $0F) to hSndFreqLo and writes it to register
; $13 of the channel; row 1 is the first; 15 rows end at LoadWavePatternIfChanged ($3D7C) (E-0209,
; C1)
; record: 16 signed frequency offsets, one per tick phase
SoundPitchOffsetRows::
    db $00, $00, $01, $01, $00, $00, $ff, $ff, $00, $00, $01, $01, $00, $00, $ff, $ff ; id 1
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $ff, $ff, $ff, $ff ; id 2
    db $00, $01, $02, $01, $00, $ff, $fe, $ff, $00, $01, $02, $01, $00, $ff, $fe, $ff ; id 3
    db $00, $00, $01, $01, $02, $02, $01, $01, $00, $00, $ff, $ff, $fe, $fe, $ff, $ff ; id 4
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; id 5
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 6
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; id 7
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02 ; id 8
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15

; Loads a new wave pattern when hSndSweepOrWave differs from the last one used (wSoundEventArg):
; records it and switches the wave channel off before the pattern is written. (C1, E-0357)
LoadWavePatternIfChanged::
    ld a, [wSoundEventArg]
    ld b, a
    ldh a, [hSndSweepOrWave]
    cp b
    ret z
    ld [wSoundEventArg], a
    ld e, a
    swap e
    xor a
    ldh [rNR30], a

; A = high byte and E = low byte of an offset (D is replaced by A): copies 16 bytes to wave RAM
; (rWAVE) from the wave set chosen by the high nibble of hSndWaveParam in SoundWaveSetTable plus
; that offset. Its caller passes A = 0 and E = the wave number * 16 (hSndSweepOrWave swapped), with
; rNR30 cleared around the copy. SoundWaveSetTable has one entry, so a non-zero high nibble of
; hSndWaveParam would read past it. (C2, E-0374)
LoadWavePattern::
    ld d, a
    ld hl, SoundWaveSetTable
    push de
    ldh a, [hSndWaveParam]
    swap a
    and $0f
    add a
    ld e, a
    ld d, $00
    add hl, de
    deref_hl
    pop de
    add hl, de
    ld de, rWAVE
    ld b, $10

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; B = label number: returns HL = wSoundLabelSlots + wSoundChannelIndex * 12 + (B & $0F) * 3, the
; 3-byte label slot (a repeat counter and a saved track position) used by the track events $FD (save
; the position), $B0 (jump to it) and $B1-$BF (repeat). B ends as B & $0F and C as the channel * 12.
; The 12 bytes per channel hold 4 slots, so numbers 4-15 reach the slots of later channels. (C2,
; E-0373)
SoundLabelSlot::
    ld a, [wSoundChannelIndex]
    add a
    ld c, a
    add a
    add c
    add a
    ld c, a
    ld a, b
    and $0f
    ld b, a
    add a
    add b
    add c
    ld hl, wSoundLabelSlots
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ret

; Recomputes the envelope for an envelope step: (reload nibble + 1) * (start volume + 1) / 16, at
; least 1, becomes the new start volume (high nibble of hSndEnvelope, low nibble kept);
; hSndEnvelopeReload keeps its low nibble and takes the old start volume as its high nibble. Keeps
; BC and DE. When both nibbles are 15 the result 16 does not fit: the high nibble becomes 0 and bit
; 0 of the low nibble is set. (C2, E-0374)
SoundTick_StepEnvelope::
    push de
    push bc
    ldh a, [hSndEnvelopeReload]
    and $0f
    inc a
    ld d, a
    ld bc, $0000
    ldh a, [hSndEnvelope]
    swap a
    and $0f
    inc a
    ld e, a

.loop:
    ld a, e
    add c
    ld c, a
    ld a, $00
    adc b
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
    and a
    jr nz, .read_snd_envelope
    ld c, $01

.read_snd_envelope:
    swap c
    ldh a, [hSndEnvelope]
    ld d, a
    and $f0
    ld e, a
    ldh a, [hSndEnvelopeReload]
    and $0f
    or e
    ldh [hSndEnvelopeReload], a
    ld a, d
    and $0f
    or c
    ldh [hSndEnvelope], a
    pop bc
    pop de
    ret

; E-0018 (C2: static reading of StartSound, and 495 emulated sound starts read exactly the banks
; this table names). StartSound takes the first entry whose first byte is greater than the sound id;
; the PREVIOUS entry gives the base id, record array and bank. A first byte of $FF ends the table.
; record: first sound id of this range; record array in that bank; ROM bank holding the records and
; tracks
SoundBankTable::
    db $00 ; entry 0: first sound id of this range
    dfar SoundRecords_Bank40 ; record array in that bank
    db $1c ; entry 1: first sound id of this range
    dfar SoundRecords_Bank41 ; record array in that bank
    db $31 ; entry 2: first sound id of this range
    dfar SoundRecords_Bank42 ; record array in that bank
    db $a8 ; entry 3: first sound id of this range
    dfar SoundRecords_Bank43 ; record array in that bank
    db $ff, $ff

; A = battle slot: carry set when the slot is out (CarryUnlessBattleSlotOutSlotEmpty) or its status
; record (wBattleStatus + 9 * slot) has any of: BSTAT0_ASLEEP, BSTAT0_PARALYZED or BSTAT0_CONFUSED
; (byte 0 & $D0), BSTAT3_FROZEN to BSTAT3_VACANT (byte 3 & $3F), BSTAT5_IRONIZED or
; BSTAT5_IRONIZE_TURNS_HI (byte 5 & $C0), or bit 3 of byte 8 (BSTAT8_UNUSED_8_3); otherwise carry
; clear. A, BC and HL are kept. Called by the battle AI (bank $05) and battle helpers in banks $3B
; and $A3. (C2, E-0373)
; A = slot: returns carry set when the slot is absent (CarryUnlessBattleSlotOutSlotEmpty) or when
; status +0 & $D0, +3 & $3F, +5 & $C0 or +8 bit 3 is set (wBattleStatus + 9 * slot); otherwise carry
; clear; A, BC, HL kept (E-0058)
CheckSlotStatusBlock::
    push hl
    push bc
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $d0
    jr nz, .set_carry
    inc hl
    inc hl
    ld a, [hli]
    and $3f
    jr nz, .set_carry
    inc hl
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    inc hl
    inc hl
    bit 3, [hl]
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = battle slot: carry clear only when A < 8 and wBattleSlotOut[A] is 0; carry set for A >= 8 and
; for any non-zero byte ($FF included). A, BC and HL are kept. By the wBattleSlotOut note (1 for a
; defeated or absent battler), carry means the slot has no battler in play. (C2, E-0373)
; A = slot number; returns with carry clear only when A < 8 and wBattleSlotOut[A] is zero (carry set
; for A >= 8, for $FF and for any other non-zero value); A, BC and HL are preserved
CarryUnlessBattleSlotOutSlotEmpty::
    push hl
    push bc
    ld c, a
    cp $08
    jr nc, .skip
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    and a
    jr z, .skip2
    cp $ff
    jr z, .skip
    scf
    jr .skip3

.skip:
    xor a
    scf
    jr .skip3

.skip2:
    ld a, $0a
    cp $01

.skip3:
    ld a, c
    pop bc
    pop hl
    ret

; Compares HL with BC as unsigned 16-bit numbers: Z set when they are equal, carry set when HL < BC
; (decided by the high bytes, or by the low bytes when the high bytes match). A is clobbered. (C2,
; E-0373)
; Z set when HL == BC; A is clobbered
CompareHLToBC::
    ld a, h
    cp b
    ret nz
    ld a, l
    cp c
    ret

; Like CompareHLToBC (Z = equal, carry = HL < BC), with a separate path when BC or HL is 0: BC = HL
; = 0 gives A = 0, Z and no carry; BC = 0 with HL non-zero gives NZ and no carry; HL = 0 with BC
; non-zero gives A = 1, NZ and carry. (C2, E-0373)
; CompareHLToBC with shortcuts when BC or HL is zero: equal zeros give A = 0 and NC, HL = 0 < BC
; gives carry (E-0124)
CompareHLToBCFastZero::
    ld a, b
    or c
    jr nz, .skip
    ld a, h
    or l
    jr nz, .done
    xor a
    scf
    ccf
    ret

.done:
    scf
    ccf
    ret

.skip:
    ld a, h
    or l
    jr nz, CompareHLToBC
    ld a, $01
    or a
    scf
    ret

; HL = minimum, BC = maximum: returns DE = minimum + (R mod (maximum - minimum + 1)), where R is the
; word wRandomHi:wRandomLo after AdvanceRandom (DivideHLByBC); when the two are equal it returns DE
; = HL without advancing the random state. HL is not kept: it ends as the negated minimum ($10000 -
; minimum) when the minimum is not 0, and BC as R mod the range. 73 call sites. (C2, E-0373)
; HL = minimum, BC = maximum: returns DE = minimum + (random mod (maximum - minimum + 1)), the
; random value being wRandomHi:wRandomLo after AdvanceRandom; DE = HL when the two are equal (73
; call sites)
RandomInRange::
    call CompareHLToBC
    jr z, .done
    ld a, h
    or l
    jr z, .skip
    ld a, l
    cpl
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
    ld h, a
    ld a, c
    add l
    ld c, a
    ld a, b
    adc h
    ld b, a

.skip:
    ld a, c
    add $01
    ld c, a
    ld a, b
    adc $00
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
    sub l
    ld e, a
    ld a, b
    sbc h
    ld d, a
    jr .return

.done:
    ld e, a
    ld d, h

.return:
    ret

; Advances the random state: outside link play (wLinkMode = 0) NextTableByte steps wRandomHi through
; 0-$7F and loads wRandomLo from RandomByteTable; in link play NextTableByteSecondStream runs the
; same step on the copy in wRandomSeed2Lo/Hi (shared in link battles), leaving the result in both
; places. (C2, E-0373)
; when wLinkMode is 0 calls NextTableByte (wRandomHi = index, wRandomLo = table byte); in link mode
; runs the same step on the synchronised copy in wRandomSeed2Lo/wRandomSeed2Hi
AdvanceRandom::
    ld a, [wLinkMode]
    or a
    jr nz, NextTableByteSecondStream
    call NextTableByte
    ret

; Loads the second random state wRandomSeed2Lo/Hi into wRandomLo/Hi, runs NextTableByte (wRandomHi =
; (wRandomHi + 1) & $7F, wRandomLo = RandomByteTable[wRandomHi]) and stores the result back in
; wRandomSeed2Lo/Hi; wRandomLo/Hi keep it too. HL is kept. AdvanceRandom uses it in link play. (C2,
; E-0373)
; advances a second random stream: loads the state in wRandomSeed2Lo/wRandomSeed2Hi into
; wRandomLo/wRandomHi, runs NextTableByte and stores the result back in
; wRandomSeed2Lo/wRandomSeed2Hi (wRandomLo/wRandomHi keep the new value); HL kept (E-0090)
NextTableByteSecondStream::
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

; HL = HL / BC (quotient), BC = HL mod BC. When B = 0 it uses DivideHLByA with A = C (D ends 0 and E
; = C); otherwise it counts repeated subtractions in DE, so DE also ends as the quotient. A is
; clobbered. (C2, E-0373)
; HL = HL / BC (quotient), BC = HL mod BC; clobbers A, DE
DivideHLByBC::
    ld de, $0000
    ld a, b
    or a
    jr z, .call_divide_hl_by_a

.skip:
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
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

; HL += (A * 9) & $FF: the product is computed in 8 bits and wraps, and the addition to HL carries
; into H. A is clobbered; BC and DE are kept. Used to index 9-byte records such as wBattleStatus
; (CheckSlotStatusBlock). (C2, E-0373)
; HL += (A * 9) & $FF (the product is computed in 8 bits and wraps); A is clobbered, other registers
; preserved
AddAx9ToHL::
    push de
    ld d, a
    add a
    add a
    add a
    add d
    pop de
    add_a_to_hl
    ret

; A = battle slot, E = field offset: returns HL = wBattlerRecords + $4E * A' + E, where A' = A - 1
; for A >= 3, so slots 0-2 and 4-6 map to records 0-5 (slot 3 gives record 2 again and slot 7 record
; 6, past the six records; GetBaseHP handles those slots separately). Clobbers A and BC (Multiply8);
; DE is kept. (C2, E-0373)
; A = battle slot, E = field offset: HL = wBattlerRecords + $4E * A' + E, where A' = A - 1 for A >=
; 3, so slots 0-2 and 4-6 map to records 0-5 (slots 3 and 7 have no record here; GetBaseHP handles
; them separately); clobbers A, BC (E-0059, E-0062)
BattlerRecordFieldAddress::
    cp $03
    jr c, .call_multiply8
    dec a

.call_multiply8:
    ld c, $4e
    call Multiply8
    ld bc, wBattlerRecords
    add hl, bc
    ld a, e
    add_a_to_hl
    ret

; A = action id: Z set when A equals wQueuedActionId, or when A is one id of a pair that names the
; same skill and the queued id is the other: SKILL_PANICALL / SKILL_PANICALL_AD, SKILL_IRONIZE /
; SKILL_IRONIZE_AE, SKILL_HIGHJUMP / ACTION_CC, SKILL_LOVERAIN / ACTION_CF, SKILL_AHHH /
; SKILL_AHHH_AA; Z clear otherwise. BC is kept; A is kept unless it is one of those ten ids, in
; which case it returns as the partner id. Callers: the AI scorer in bank $05 and the action checks
; in bank $32 (RunBattleActions_StatusChecks_CheckAction_SealPray). (C2, E-0373)
; Z set when A equals the queued action (wQueuedActionId, wQueuedActionId) or is its partner in one
; of the pairs $34-$AD, $35-$AE, $6A-$CC, $A1-$CF, $8F-$AA (the pairs are symmetric); Z clear
; otherwise. A and BC are kept (E-0049)
QueuedActionMatches::
    push bc
    push af
    ld a, [wQueuedActionId]
    ld c, a
    pop af
    cp c
    jr nz, .cp_34

.loop:
    pop bc
    ret

.cp_34:
    cp $34
    jr nz, .cp_AD
    ld a, $ad
    cp c
    jr .loop

.cp_AD:
    cp $ad
    jr nz, .cp_35
    ld a, $34
    cp c
    jr .loop

.cp_35:
    cp $35
    jr nz, .cp_AE
    ld a, $ae
    cp c
    jr .loop

.cp_AE:
    cp $ae
    jr nz, .cp_6A
    ld a, $35
    cp c
    jr .loop

.cp_6A:
    cp $6a
    jr nz, .cp_CC
    ld a, $cc
    cp c
    jr .loop

.cp_CC:
    cp $cc
    jr nz, .cp_A1
    ld a, $6a
    cp c
    jr .loop

.cp_A1:
    cp $a1
    jr nz, .cp_CF
    ld a, $cf
    cp c
    jr .loop

.cp_CF:
    cp $cf
    jr nz, .cp_8F
    ld a, $a1
    cp c
    jr .loop

.cp_8F:
    cp $8f
    jr nz, .cp_AA
    ld a, $aa
    cp c
    jr .loop

.cp_AA:
    cp $aa
    jr nz, .loop
    ld a, $8f
    cp c
    jr .loop
    ds $53, $00
