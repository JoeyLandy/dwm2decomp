; RAM symbols referenced by the code. Names of the form wXXXX / hXXXX / sXXXX are
; address names (no meaning claimed); any other name cites its evidence.

; SRAM ($A000-$BFFF)
DEF sA000 EQU $A000
DEF sA00D EQU $A00D
DEF sA00F EQU $A00F
DEF sA01E EQU $A01E
DEF sA029 EQU $A029
DEF sA040 EQU $A040
DEF sA06F EQU $A06F
DEF sA070 EQU $A070
DEF sA08E EQU $A08E
DEF sA099 EQU $A099
DEF sA0A5 EQU $A0A5
DEF sAD71 EQU $AD71
DEF sAF36 EQU $AF36
DEF sAFAF EQU $AFAF
DEF sB356 EQU $B356
DEF sB3C5 EQU $B3C5
DEF sB535 EQU $B535
DEF sB58E EQU $B58E
DEF sB58F EQU $B58F
DEF sBA73 EQU $BA73
DEF sBB00 EQU $BB00
DEF sBB01 EQU $BB01
DEF sBB07 EQU $BB07
DEF sBB0F EQU $BB0F
DEF sBC00 EQU $BC00
DEF sBC01 EQU $BC01
DEF sBC02 EQU $BC02
DEF sBC03 EQU $BC03
DEF sBC0A EQU $BC0A
DEF sBD30 EQU $BD30
DEF sBD36 EQU $BD36
DEF sBD3A EQU $BD3A
DEF sBD97 EQU $BD97
DEF sBE0D EQU $BE0D
DEF sBEC0 EQU $BEC0
DEF sBEF3 EQU $BEF3
DEF sBF98 EQU $BF98
DEF sBF99 EQU $BF99

; WRAM ($C000-$DFFF)
DEF wShadowOAM EQU $C000 ; shadow OAM: 40 four-byte sprite entries that the OAM DMA routine copies from $C000 (OamDmaRoutineTemplate starts DMA with source $C0); ClearShadowOAM clears its $A0 bytes (E-0132)
DEF wTemp0 EQU $C0A0 ; general scratch byte used by many menus and helpers (for example Quotient24ByHFFCCDE, menu cursor work, list counts) (E-0133)
DEF wTemp1 EQU $C0A1 ; general scratch byte next to wTemp0 (often the high byte of a word kept in wTemp0) (E-0133)
DEF wMenuRowCount EQU $C0A2 ; number of cursor rows UpdateMenuCursor wraps over (E-0060) (reading (E-0060))
DEF wMenuPageCount EQU $C0A3 ; number of pages UpdateMenuCursor steps through with Left/Right; 0 or 1 disables paging (E-0060) (reading (E-0060))
DEF wPauseMenuScreen EQU $C0A4 ; screen index of the pause menu (RunWC0A4Screen dispatches on it; PauseMenu_Main cases set it) (E-0133)
DEF wMenuLastPageRows EQU $C0A5 ; rows on the last page; UpdateMenuCursor clamps the row to this minus 1 there (E-0060) (reading (E-0060))
DEF wMenuPage EQU $C0A6 ; current page index set by UpdateMenuCursor (E-0060) (reading (E-0060))
DEF wMenuItemCount EQU $C0A7 ; number of entries of the current item or skill list (SetupInventoryMenuPages, BuildInventoryScreenBase) (E-0133)
DEF wPauseMenuStep EQU $C0A8 ; step counter of the pause menu sub-screens (PauseMenu_State3 cases) (E-0133)
DEF wBGWriteDestLo EQU $C0C0 ; queued BG map write for VBlank: destination low byte; FlushQueuedBGMapWrite writes when the destination is non-zero and then clears it (E-0133)
DEF wBGWriteDestHi EQU $C0C1 ; queued BG map write: destination high byte (E-0133)
DEF wBGWriteVertical EQU $C0C2 ; queued BG map write: 0 writes along a row (wrapping in 32), non-zero down a column (E-0133)
DEF wBGWriteCount EQU $C0C3 ; queued BG map write: number of tiles (E-0133)
DEF wBGWriteData EQU $C0C4 ; tiles of the queued BG map write (up to 20) (E-0133)
DEF wAttrWriteDestLo EQU $C0D8 ; queued CGB attribute write (VRAM bank 1) for VBlank: destination low byte (E-0133)
DEF wAttrWriteDestHi EQU $C0D9 ; queued attribute write: destination high byte (E-0133)
DEF wAttrWriteVertical EQU $C0DA ; queued attribute write: 0 along a row, non-zero down a column (E-0133)
DEF wAttrWriteCount EQU $C0DB ; queued attribute write: number of bytes (E-0133)
DEF wAttrWriteData EQU $C0DC ; bytes of the queued attribute write (up to 20) (E-0133)
DEF wBGPaletteCopy EQU $C0F0 ; a 64-byte copy of the eight CGB background palettes; ScriptStepFlashScreenNegative copies it back to wBGPaletteBuffer (or its inverse) (E-0132)
DEF wTextBuf0 EQU $C130 ; 16-byte text slot filled before a message: the actor or player name (CopyActorNameToWC130, WritePlayerNameWithFlag0SuffixToWC130); $F0-terminated (E-0132)
DEF wTextBuf1 EQU $C140 ; 16-byte text slot: the skill or second name of a message (CopyActionSkillNameToWC140, CopyMappedSlotNameToWC140) (E-0132)
DEF wTextBuf2 EQU $C150 ; 16-byte text slot: the target or item name of a message (CopyActionItemNameToWC150, BuildActionMessageNames) (E-0132)
DEF wTextBuf3 EQU $C160 ; 16-byte text slot: a further name (CopyEligibleRecordNameToWC160Row, EquipItemOnRecordWD083) (E-0132)
DEF wTextNumber EQU $C17E ; digit string of a number shown in a message (DeductGoldPenaltyAndFormatLoss writes the gold lost here as packed BCD through Func_000_23CA) (E-0132)
DEF wMapWidthScreens EQU $C190 ; map width in screens, from the map record (2 for the ship deck, 4 for map 56) (reading + execution (E-0037))
DEF wMapHeightScreens EQU $C191 ; map height in screens, from the map record (reading + execution (E-0037))
DEF wMaxBlockingTile EQU $C192 ; highest tile id that blocks the player (TileBlockedAtPixel compares tile ids with it); from the map record (55 for the ship deck) (reading + execution (E-0037))
DEF wMapHeaderByte7 EQU $C193 ; map header byte after wMaxBlockingTile (LoadMapHeader); CheckInteractionInFront reads it (E-0133)
DEF wMapMoveType EQU $C194 ; map header byte selecting the player movement routine (RunPlayerMoveTypeWC194) (E-0133)
DEF wMapSpriteKind EQU $C195 ; map header byte: high nibble picks the script sprite set ($23 + n - 1), low nibble 1 selects the follower-style sprite; set for special maps by SetWC195AndWC197ForSpecialMaps (E-0133)
DEF wMapTallTileMin EQU $C196 ; map header byte: tiles at or above it count as tall tiles for field events and blocking (RollFieldEventOnTallTiles, TileBlockedAtPixel) (E-0133)
DEF wMapHeaderByte11 EQU $C197 ; map header byte ($2C or $30 on the special maps; read by FieldModeStateDispatch_Shared01_Sub02) (E-0133)
DEF wScreenTileBuffer EQU $C198 ; screen tile buffer: the $240 bytes are cleared with $C3; CopyTileBufferToBGMap and CopyBlockToTileBuffer use rows of 32 bytes, while field mode (Func_002_59CD) indexes it with rows of 20 and 260 of its 360 visible entries equal the BG map on the emulator (E-0030) (reading)
DEF wWindowTileBuffer EQU $C300 ; 20 x 18 tile buffer for windows and menus in field mode: OpenFieldMenuOnA saves screen rows here, CopyRectTo20ByteRows draws boxes into it (the two-choice box at row 13, column 14 = +$112), and it ends right before wFieldActionRequest ($C468); its CGB attributes are at $D168 in WRAM bank 2 (E-0133)
DEF wFieldActionRequest EQU $C468 ; bit 7 set requests a field action; RunWC468ActionIfBit7 runs the routine for bits 0-1 (UpdatePlayerMovement sets $80 for a screen scroll) (E-0133)
DEF wFieldActionStep EQU $C469 ; step of the requested field action (E-0133)
DEF wScreenScrollDir EQU $C46A ; direction of the requested screen scroll (1 left, 2 right, ...) set by UpdatePlayerMovement (E-0133)
DEF wMenuState EQU $C46B ; state of the current menu or debug screen (RunWC46BMenuState dispatches on it); cleared by LoadMapHeader (E-0133)
DEF wMenuSubState EQU $C46C ; sub-state or flag of the current menu; cleared by LoadMapHeader (E-0133)
DEF wMenuSelectedMember EQU $C46D ; selected party member or list entry of the menus (record wC46D & $0F or & 3) (E-0133)
DEF wMenuCursor EQU $C46E ; main cursor position of the menus (cursor marks drawn for wC46E & 7) (E-0133)
DEF wSubMenuCursor EQU $C46F ; cursor of a sub-menu or second list (E-0133)
DEF wSubMenuCursor2 EQU $C470 ; cursor of a further sub-menu (record list rows, item targets) (E-0133)
DEF wMenuOption EQU $C471 ; selected option of a menu (also the link menu choice sent by SendLinkByteForWC471) (E-0133)
DEF wMenuOption2 EQU $C472 ; second option byte cleared with the menu cursors (E-0133)
DEF wSGBJoypad1 EQU $C474 ; joypad byte read from the Super Game Boy for player 1 (PollJoypad) (E-0133)
DEF wSGBJoypad2 EQU $C476 ; joypad byte read from the Super Game Boy for player 2 (copied to wLinkJoypadHeld) (E-0133)
DEF wSGBPacketIndex EQU $C47C ; packet set number for SendSGBPacketSet; $FF selects wSGBPacketBuffer (reading)
DEF wSGBPacketBuffer EQU $C47F ; packet data used by SendSGBPacketSet when wSGBPacketIndex is $FF (reading)
DEF wBGPaletteBuffer EQU $C49F ; 8 CGB background palettes (4 RGB555 colours each, 64 bytes) that the fade routines read and write to rBGPD (WriteAllFadedPalettesFloor/Add) (E-0076) (reading (E-0076))
DEF wOBJPaletteBuffer EQU $C4DF ; 8 CGB object palettes (64 bytes) that the fade routines write to rOBPD (E-0076) (reading (E-0076))
DEF wSGBPaletteSet EQU $C51F ; Super Game Boy palette set number; PAL_SET packets use 4 * it + 0-3 (E-0133)
DEF wSGBAttrFile EQU $C520 ; Super Game Boy attribute file number sent with PAL_SET (E-0133)
DEF wSGBBorderSet EQU $C523 ; border set last sent to the Super Game Boy (LoadSGBBorderForSetA skips a repeat) (E-0133)
DEF wSGBActive EQU $C524 ; set to 1 at boot, cleared on CGB and when DetectSGB finds no Super Game Boy; SendSGBPacketSet, DelayBCWhenSGB and SpinDelay return at once when it is 0 (reading)
DEF wIsCGB EQU $C525 ; 1 when the boot code found A = $11 (CGB), else 0; set at $0150 (E-0020)
DEF wBGPaletteUploadRequest EQU $C526 ; non-zero asks the VBlank handler to upload wBGPaletteBuffer (UploadBGPalettes); cleared after (E-0133)
DEF wOBJPaletteUploadRequest EQU $C527 ; non-zero asks the VBlank handler to upload wOBJPaletteBuffer; cleared after (E-0133)
DEF wStringCategory EQU $C528 ; category index LookupString uses in the table of tables (reading)
DEF wStringIndex EQU $C529 ; index within the category table that LookupString uses (reading)
DEF wStringBank EQU $C52A ; ROM bank number LookupString stores; the string printer maps it into the ROM bank window (reading)
DEF wTextFlags EQU $C52B ; string display flags: non-zero makes the VBlank handler step the text (StepStringDisplayUntilDone); bit 1 and bit 2 mark stages (E-0133)
DEF wTextControl EQU $C52C ; string display control bits (bit 7 continues the display, bit 0 set at a prompt) (E-0133)
DEF wTextWindowTileLo EQU $C52D ; text window: low byte of the VRAM tile address the glyphs are drawn at (default vTiles1 = $8800) (E-0133)
DEF wTextWindowTileHi EQU $C52E ; text window: high byte of that address (E-0133)
DEF wTextWindowRows EQU $C52F ; text window: number of rows (default 2) (E-0133)
DEF wTextWindowWidth EQU $C530 ; text window: width in tiles (default $12 = 18) (E-0133)
DEF wTextGlyphDestLo EQU $C531 ; current glyph destination, low byte (copied from wTextWindowTile at BeginStringDisplay) (E-0133)
DEF wTextGlyphDestHi EQU $C532 ; current glyph destination, high byte (E-0133)
DEF wTextPosLo EQU $C533 ; pointer to the next string byte, low byte (IncrementWC533Word) (E-0133)
DEF wTextPosHi EQU $C534 ; pointer to the next string byte, high byte (E-0133)
DEF wTextLineStartLo EQU $C535 ; glyph destination at the start of the line, low byte (E-0133)
DEF wTextLineStartHi EQU $C536 ; glyph destination at the start of the line, high byte (E-0133)
DEF wTextStartPosLo EQU $C537 ; string position at BeginStringDisplay, low byte (used when a prompt is acknowledged) (E-0133)
DEF wTextStartPosHi EQU $C538 ; string position at BeginStringDisplay, high byte (E-0133)
DEF wTextControlArg EQU $C539 ; argument byte read after a text control code (E-0133)
DEF wTextRepeatCount EQU $C53B ; countdown of a repeated text control (E-0133)
DEF wTextDelayCounter EQU $C53C ; countdown before the next glyph is drawn (E-0133)
DEF wStringDestLo EQU $C53D ; low byte of the destination CopyStringToBuffer writes the string to (E-0059) (reading (E-0059))
DEF wStringDestHi EQU $C53E ; high byte of the destination CopyStringToBuffer writes the string to (E-0059) (reading (E-0059))
DEF wC53F EQU $C53F
DEF wTextLineCount EQU $C54F ; lines drawn since the window was cleared (E-0133)
DEF wTextLastChar EQU $C550 ; last string byte handled ($E6 and $FF are special) (E-0133)
DEF wTextYesNoResult EQU $C552 ; result of a text yes/no prompt (0 = first choice); AcknowledgeTextPrompt clears it, StartChoiceMessageByWC552 branches on it (E-0133)
DEF wTextCursorLo EQU $C554 ; BG map address where the next text row starts, low byte (AddHLToTextCursorWC554) (E-0133)
DEF wTextCursorHi EQU $C555 ; BG map address where the next text row starts, high byte (E-0133)
DEF wTextBeepSound EQU $C556 ; sound effect played for text output ($6B) (E-0133)
DEF wJoypadReadFlag EQU $C55D ; cleared before a direct joypad read (PollJoypad); tested by UpdateJoypadPresses (E-0133)
DEF wJoypadHeld EQU $C55E ; buttons held at the latest PollJoypad (layout of ReadJoypadDirect) (reading)
DEF wJoypadHeldPrev EQU $C55F ; wJoypadHeld from the previous poll (reading)
DEF wLinkJoypadHeld EQU $C560 ; the other player's buttons: received over the link or from the second Super Game Boy pad (E-0133)
DEF wLinkJoypadHeldPrev EQU $C561 ; the previous value of wLinkJoypadHeld (E-0133)
DEF wJoypadPressed EQU $C562 ; buttons newly held since the previous poll (reading)
DEF wJoypadPressedRepeat EQU $C563 ; newly held buttons plus auto-repeat (UpdateJoypadPresses) (reading)
DEF wJoypadRepeatTimer EQU $C564 ; auto-repeat countdown: $14 after a new press, then 6 (reading)
DEF wFieldFrameFlag EQU $C565 ; cleared with the joypad state before the field mode states run (E-0133)
DEF wLinkJoypadPressed EQU $C566 ; newly pressed buttons of the other player (UpdateJoypadPresses) (E-0133)
DEF wLinkJoypadPressedRepeat EQU $C567 ; newly pressed buttons plus auto-repeat for the other player (E-0133)
DEF wLinkJoypadRepeatTimer EQU $C568 ; auto-repeat countdown for the other player ($14, then shorter) (E-0133)
DEF wLinkSavedJoypadHeld EQU $C56A ; wJoypadHeld saved by LinkExchangeJoypadPerFrame (E-0133)
DEF wLinkSavedJoypadHeldPrev EQU $C56B ; wJoypadHeldPrev saved by LinkExchangeJoypadPerFrame (E-0133)
DEF wFadeState EQU $C56C ; palette fade state set by StartPaletteFade; GameFrameUpdate and the VBlank handler skip normal work while it is non-zero (bit 7 clear) (reading)
DEF wFadeMode EQU $C56D ; fade mode bits: bit 7 = toward black, bits 0-2 select which palettes fade (7 = all) (E-0133)
DEF wFadeMask EQU $C56E ; fade selection bits ($1F = all); bit 1 also picks the step size (E-0133)
DEF wFadeDMGPalettes EQU $C56F ; three DMG palette bytes the fade lightens (LightenSelectedDMGPalettes) (E-0133)
DEF wC570 EQU $C570
DEF wC571 EQU $C571
DEF wFadeLevel EQU $C572 ; the 5-bit level the fade routines apply to each colour component (E-0076) (reading (E-0076))
DEF wFadeDelay EQU $C573 ; frames between CGB fade steps minus 1, set from wFadeState / 4 by StartPaletteFade_Sub01 and reloaded by StepCGBFade (E-0077) (reading (E-0077))
DEF wFadeDelayCounter EQU $C574 ; counts down to the next CGB fade step (StepCGBFade) (E-0077) (reading (E-0077))
DEF wFadeStepSize EQU $C576 ; CGB fade step chosen for this frame (0 or 8) (E-0133)
DEF wSGBPaletteNum0Lo EQU $C577 ; Super Game Boy palette number 0 for PAL_SET (4 * wSGBPaletteSet), low byte (E-0133)
DEF wSGBPaletteNum0Hi EQU $C578 ; palette number 0, high byte (E-0133)
DEF wSGBPaletteNum1Lo EQU $C579 ; palette number 1, low byte (E-0133)
DEF wSGBPaletteNum1Hi EQU $C57A ; palette number 1, high byte (E-0133)
DEF wSGBPaletteNum2Lo EQU $C57B ; palette number 2, low byte (E-0133)
DEF wSGBPaletteNum2Hi EQU $C57C ; palette number 2, high byte (E-0133)
DEF wSGBPaletteNum3Lo EQU $C57D ; palette number 3, low byte (E-0133)
DEF wSGBPaletteNum3Hi EQU $C57E ; palette number 3, high byte (E-0133)
DEF wLinkRole EQU $C57F ; link flags: bit 1 = this Game Boy drives the clock (the side that sends first) (E-0133)
DEF wLinkStatus EQU $C580 ; link status bits (bit 7 set, bit 6 cleared when the connection is set up) (E-0133)
DEF wLinkSession EQU $C581 ; kind of link session (5 = a battle session in LinkExchangeJoypadPerFrame) (E-0133)
DEF wLinkExchangeState EQU $C582 ; state of the per-frame link exchange (RunWC582State dispatches on it) (E-0133)
DEF wLinkStateByte EQU $C583 ; cleared at the start of the link mode loop (E-0133)
DEF wSerialReceived EQU $C586 ; byte last received over the serial port (E-0133)
DEF wLinkTimerLo EQU $C588 ; link wait counter, low byte (E-0133)
DEF wLinkTimerHi EQU $C589 ; link wait counter, high byte (E-0133)
DEF wLinkMode EQU $C58A ; 0 outside link play, 1 in a link battle, 2 in another link mode; many routines branch on it (E-0133)
DEF wLinkScreenStep EQU $C58B ; step of the link screens (GameMode5) (E-0133)
DEF wLinkReady EQU $C58C ; set when both sides are ready; LinkReceive routines branch on it (E-0133)
DEF wLinkFrameCounterLo EQU $C58D ; link frame counter, low byte; an overflow resets the game (E-0133)
DEF wLinkFrameCounterHi EQU $C58E ; link frame counter, high byte (E-0133)
DEF wLinkMessage EQU $C58F ; last link command byte received or sent (E-0133)
DEF wLinkBufferPtrLo EQU $C590 ; link transfer buffer pointer, low byte (E-0133)
DEF wLinkBufferPtrHi EQU $C591 ; link transfer buffer pointer, high byte (E-0133)
DEF wLinkBufferCountLo EQU $C592 ; link transfer bytes left, low byte (E-0133)
DEF wLinkBufferCountHi EQU $C593 ; link transfer bytes left, high byte (E-0133)
DEF wLinkSendByte EQU $C594 ; byte queued to send over the link ($FF = none) (E-0133)
DEF wLinkTimeoutLo EQU $C595 ; link timeout counter, low byte (E-0133)
DEF wLinkTimeoutHi EQU $C596 ; link timeout counter, high byte (E-0133)
DEF wLinkRecvBuffer EQU $C597 ; start of the link receive area (RunWD06AState_6C12 points the transfer buffer here) (E-0133)
DEF wBattleSetupByte98 EQU $C598 ; set by the battle setup (RunBattlePhaseWhenTextIdle_A0) and the bank-$F0 screens (E-0133)
DEF wBankF0Byte99 EQU $C599 ; byte set and read by the bank-$F0 screen routines (Func_0F0_4CA0 tables) (E-0133)
DEF wBattleSetupFlagsLo EQU $C59A ; battle setup word read by RunBattleSetup (set by the bank-$33 screens), low byte (E-0133)
DEF wBattleSetupFlagsHi EQU $C59B ; battle setup word, high byte (E-0133)
DEF wBankF0ByteA3 EQU $C5A3 ; byte set by the bank-$F0 screens (E-0133)
DEF wBankF0BlockA7 EQU $C5A7 ; work bytes of the bank-$F0 screens ($C5A7-$C5AB) (E-0133)
DEF wBankF0ByteA8 EQU $C5A8 ; work byte of the bank-$F0 screens (read by Run67EEWithWD7F1ForWD7EC) (E-0133)
DEF wBankF0ByteA9 EQU $C5A9 ; work byte of the bank-$F0 screens (read by Run67EEWithWD7F1ForWD7EC) (E-0133)
DEF wBankF0ByteAA EQU $C5AA ; work byte of the bank-$F0 screens (E-0133)
DEF wBankF0BlockAB EQU $C5AB ; work bytes of the bank-$F0 screens (E-0133)
DEF wLinkPartnerName EQU $C5B7 ; the link partner's data block (name and record bytes) received during link setup (E-0133)
DEF wLinkPartnerByte1 EQU $C5B8 ; byte of the link partner block (E-0133)
DEF wLinkPartnerByte2 EQU $C5B9 ; byte of the link partner block (E-0133)
DEF wRandomSeed2Lo EQU $C5BA ; second random/table stream position, low byte (NextTableByteSecondStream, AdvanceRandom); shared in link battles (E-0133)
DEF wRandomSeed2Hi EQU $C5BB ; second random stream position, high byte (E-0133)
DEF wBattleSetupByteBC EQU $C5BC ; set by RunBattleSetup_Case08 and read by the link screens (E-0133)
DEF wBattleSetupByteBD EQU $C5BD ; set by RunBattleSetup_Case08 (E-0133)
DEF wLinkTradeByte EQU $C5C6 ; link trade byte (RunWD06AState_6C12_Shared04) (E-0133)
DEF wBankF0BlockC7 EQU $C5C7 ; work bytes of the bank-$F0 screens and game mode 8 (E-0133)
DEF wBankF0ByteC8 EQU $C5C8 ; work byte of the bank-$F0 screens (E-0133)
DEF wBankF0ByteC9 EQU $C5C9 ; work byte of the bank-$F0 screens (E-0133)
DEF wBankF0BlockCB EQU $C5CB ; work block of the bank-$F0 screens (E-0133)
DEF wVBlankLY EQU $C5D7 ; rLY value saved at the end of the VBlank handler (E-0133)
DEF wGameMode EQU $C5DB ; index into the 9-entry tables RunGameModeInit and RunGameModeUpdate use; 5 at boot (reading)
DEF wModeState EQU $C5DC ; per-mode sub-state; low nibble indexes the jump table in GameMode1_Update (E-0030) (reading)
DEF wGameMode2State EQU $C5DD ; state of game mode 2 (RunWC5DDState); CheckInteractionInFront sets it (E-0133)
DEF wGameMode2Arg EQU $C5DE ; argument for game mode 2 set before entering it (E-0133)
DEF wModeChangeRequest EQU $C5DF ; non-zero makes the main loop leave its wait and run RunGameModeInit again (reading)
DEF wFieldInitStage EQU $C5E0 ; field set-up stage (GameMode1_Init / InitFieldScreen; 1 becomes 2 after the Super Game Boy palettes) (E-0133)
DEF wSTATSplitEnable EQU $C5E1 ; enables the LCD STAT split effect (read by the STAT handler and ComputeSpriteScrollOffsets) (E-0133)
DEF wSoundFadeLevel EQU $C5E2 ; sound volume fade level (StepFade_Sub02 shifts it and writes rNR50) (E-0133)
DEF wSoundFadeTarget EQU $C5E3 ; sound fade target level (E-0133)
DEF wSoundFadeTimer EQU $C5E4 ; sound fade step timer (E-0133)
DEF wSoundFadeNR50 EQU $C5E5 ; saved rNR50 for the sound fade (E-0133)
DEF wRandomLo EQU $C5E7 ; current random value, low byte (NextTableByte, AdvanceRandom, RandomInRange) (E-0133)
DEF wRandomHi EQU $C5E8 ; current random value, high byte (E-0133)
DEF wDMGPaletteBGP EQU $C5E9 ; DMG background palette byte copied to rBGP each VBlank (E-0133)
DEF wDMGPaletteOBP0 EQU $C5EA ; DMG object palette 0 byte copied to rOBP0 (E-0133)
DEF wDMGPaletteOBP1 EQU $C5EB ; DMG object palette 1 byte copied to rOBP1 (E-0133)
DEF wLCDCShadow EQU $C5EC ; value WriteLCDCShadow writes to rLCDC each VBlank (E-0133)
DEF wVBlankFlags EQU $C5ED ; bit 0 = VBlank handler running; bits 1, 2, 7 are link exchange flags (E-0133)
DEF wBootFlagEE EQU $C5EE ; cleared at boot (E-0133)
DEF wFrameCounterLo EQU $C5F0 ; low byte of the 16-bit frame counter the VBlank handler increments (reading)
DEF wFrameCounterHi EQU $C5F1 ; high byte of the 16-bit frame counter (reading)
DEF wDebugByteF6 EQU $C5F6 ; cleared by GameMode0_Init (debug menu) (E-0133)
DEF wDebugByteF7 EQU $C5F7 ; cleared by GameMode0_Init (debug menu) (E-0133)
DEF wDebugCursor EQU $C5F8 ; debug screens: selected field or cursor (E-0133)
DEF wDebugValue0 EQU $C5F9 ; debug screens: first edited value (E-0133)
DEF wDebugValue1 EQU $C5FA ; debug screens: second edited value (E-0133)
DEF wDebugValue2 EQU $C5FB ; debug screens: third edited value (E-0133)
DEF wDebugValue3 EQU $C5FC ; debug screens: fourth edited value (E-0133)
DEF wDebugState EQU $C5FD ; debug screens: state (RunWC5FDState_E0); also loaded with key entry fields (E-0133)
DEF wDebugSubState EQU $C5FE ; debug screens: sub-state (RunWC5FEState_E0) (E-0133)
DEF wDebugCounter EQU $C5FF ; debug screens: cursor blink and position counter (StepDebugCursorWC5FF) (E-0133)
DEF wDebugMenuFlag0 EQU $C600 ; read by DebugMainMenu_Update (E-0133)
DEF wDebugMenuFlag1 EQU $C601 ; read by DebugMainMenu_Update (E-0133)
DEF wDebugMenuFlag2 EQU $C602 ; read by DebugMainMenu_Update (E-0133)
DEF wDebugMenuFlag3 EQU $C603 ; read by DebugMainMenu_Update (E-0133)
DEF wScreenShakeTimer EQU $C604 ; screen shake countdown (ApplyScreenShake) (E-0133)
DEF wScreenShakeOffset EQU $C605 ; current screen shake offset (E-0133)
DEF wCurrentMusic EQU $C608 ; music now playing; PlayMapMusic skips a request for the same id; $FF forces a restart (E-0133)
DEF wMusicRequest EQU $C60A ; music id waiting for ProcessSoundQueue; $FF = none (reading)
DEF wSoundEffectRequest EQU $C60B ; sound effect id waiting for ProcessSoundQueue; $FF = none (reading)
DEF wPlayerName EQU $C60C ; the player name (10 bytes): copied to wTextBuf0, wCADF, the name tiles; first part of the $291-byte save block that starts here (SaveGameToSRAMWithChecksum) (E-0133)
DEF wSaveByte16 EQU $C616 ; save-data byte before the gold; set in link mode, read by ComputeBreedingChild (E-0133)
DEF wGoldLo EQU $C617 ; low byte of the 24-bit gold amount: the new-game setup sets 100 (InitGoldAndClearInventory), AddGoldCapped caps it at 99,999 and DrawGoldPanel_Bank24 shows it in decimal (E-0074) (reading (E-0074))
DEF wGoldMid EQU $C618 ; middle byte of the gold amount (E-0074) (reading (E-0074))
DEF wGoldHi EQU $C619 ; high byte of the gold amount (E-0074) (reading (E-0074))
DEF wBankedGoldLo EQU $C61A ; second 24-bit amount kept with the gold (shop/bank script command $E5), low byte (E-0133)
DEF wBankedGoldMid EQU $C61B ; second amount, middle byte (E-0133)
DEF wBankedGoldHi EQU $C61C ; second amount, high byte (E-0133)
DEF wInventory EQU $C61D ; 24-slot bag of item ids (searched by FindHFFC6InWC61DList; empty at the start of a new game) (reading)
DEF wEventItemSlot EQU $C627 ; save byte tested before the gold events ($FF or 0 allows them) (E-0133)
DEF wSaveByte32 EQU $C632 ; save-data byte read by talk event 1/$19 (E-0133)
DEF wItemStorage EQU $C635 ; 100 two-byte entries (WC635HasNonZeroEntry); ends right before wPartyCount; item storage of the save data (E-0133)
DEF wPartyCount EQU $C6FD ; number of party monsters (0-3) (E-0133)
DEF wPartyList EQU $C6FE ; record indexes of the party members (up to 3, then $FF); MoveIncapacitatedPartyMembersBack reorders it (E-0133)
DEF wKeyList EQU $C707 ; up to 32 4-byte key entries ($FF ends the list; CountKeysOrFull); bytes 1-2 of an entry pick the two words of its name (WriteKeyNameToDE reads from $C708) (E-0090) (reading + data (E-0090))
DEF wKeySeeds EQU $C787 ; two bytes per key entry: the random seed saved when a key is generated (GenerateNewKeyEntry, DeleteKeyEntryHFFC6) (E-0133)
DEF wFarmLevel EQU $C7C7 ; storage level: Data_016_75EB[it] is how many SRAM records the farm holds (E-0133)
DEF wStepCounterLo EQU $C7C9 ; field step counter for stored-record updates (wraps at 1000), low byte (E-0133)
DEF wStepCounterHi EQU $C7CA ; field step counter, high byte (E-0133)
DEF wSpeciesFlags EQU $C7CC ; one bit per monster id (bit id & 7 of byte id / 8; TestSpeciesFlag, SetSpeciesFlag); counted per family by CountSpeciesPerFamilyFlaggedOrListed. What the bit records (for example a library entry) is not checked (E-0070) (reading (E-0070))
DEF wSpeciesFlagCount EQU $C7FB ; count kept by SetSpeciesFlag (monsters recorded) (E-0133)
DEF wMonsterLibraryBuf EQU $C7FC ; buffer at $C7FC used by the record screens and script command $F6 (E-0133)
DEF wArenaRank EQU $C82C ; arena class or rank index (script command $F7 indexes message tables with it) (E-0133)
DEF wPlayFrames EQU $C82D ; frame count 0-59 of the play-time counter (reading)
DEF wPlaySeconds EQU $C82E ; seconds 0-59 of the play-time counter (reading)
DEF wPlayMinutes EQU $C82F ; minutes 0-59 of the play-time counter (reading)
DEF wPlayHoursLo EQU $C830 ; low byte of the 16-bit play-time hours (reading)
DEF wPlayHoursHi EQU $C831 ; high byte of the 16-bit play-time hours (reading)
DEF wTownEventTimer EQU $C832 ; counts 0-99 for RunPeriodicFieldEventChecks; set to 99 to force a check (E-0133)
DEF wCurrentKeyIndex EQU $C833 ; index of the key entry in use (key world) (E-0133)
DEF wMenuSaveByte34 EQU $C834 ; pause-menu byte kept in the save data (E-0133)
DEF wBattleResultByte EQU $C835 ; set at the end of a battle, read by the next battle set-up (E-0133)
DEF wGameFlags836 EQU $C836 ; flag byte: bit 7 set by key events, low bit toggles the inventory sort order (E-0133)
DEF wArenaByte37 EQU $C837 ; read by script command $F3 (E-0133)
DEF wArenaWinsLo EQU $C838 ; 16-bit count shown by DrawWC838CountBoxAndStep (script command $F3), low byte (E-0133)
DEF wArenaWinsHi EQU $C839 ; that count, high byte (E-0133)
DEF wSpriteSnapshotCount EQU $C83A ; sprite slot count saved by SnapshotSpritesForSave (E-0133)
DEF wSpriteSnapshot EQU $C83B ; sprite slot snapshot area saved with the game ($C83B onward) (E-0133)
DEF wSnapshotByte3C EQU $C83C ; byte of the snapshot area (set by the Log Twig item) (E-0133)
DEF wSnapshotByte3D EQU $C83D ; byte of the snapshot area (set by the Log Twig item) (E-0133)
DEF wSnapshotByte3E EQU $C83E ; byte of the snapshot area (set by the Log Twig item) (E-0133)
DEF wSnapshotSlot1 EQU $C848 ; snapshot slot 1 flags (E-0133)
DEF wSnapshotSlot2 EQU $C858 ; snapshot slot 2 flags (E-0133)
DEF wSnapshotSlot3 EQU $C868 ; snapshot slot 3 flags (E-0133)
DEF wSnapshotSlot4 EQU $C878 ; snapshot slot 4 flags (E-0133)
DEF wSnapshotSlot5 EQU $C888 ; snapshot slot 5 flags (E-0133)
DEF wLastWarpIndex EQU $C88B ; index of the last warp taken (CheckWarpAtPlayer) (E-0133)
DEF wStatusStepFlags EQU $C88C ; bit 7 and bit 0 used by the field status-effect state (EnterStatusEffectFieldState, ToggleWC88CLowBitOnce) (E-0133)
DEF wSaveStateFlag EQU $C88D ; set when the save blocks are copied; read by GameMode1_Init (E-0133)
DEF wKeyWorldActive EQU $C88E ; non-zero while a key world is active (E-0133)
DEF wKeyWorldGoal EQU $C88F ; key-world goal position/warp bytes ($C88F-$C890) (E-0133)
DEF wKeyWorldGoalCell EQU $C890 ; key-world goal cell (screen x/y nibbles) (E-0133)
DEF wKeyWorldKey EQU $C891 ; key in use: bit 7 set, low bits = key index + 1 (E-0133)
DEF wTalkEventByte92 EQU $C892 ; set by script command $F7 and read by talk event 1/$65 (E-0133)
DEF wKeyWorldRefresh EQU $C893 ; bit 7 asks for the key/town objects to be rebuilt on entry (E-0133)
DEF wLinkByte94 EQU $C894 ; link setting byte (GameMode5_Init, script command $7C) (E-0133)
DEF wKeyNameBuf EQU $C895 ; buffer for key display rows (bank-$33 screens) (E-0133)
DEF wBattleRewardByte97 EQU $C897 ; read by the battle results (E-0133)
DEF wBattleRewardByte98 EQU $C898 ; read by the battle results (E-0133)
DEF wBattleResultStep EQU $C899 ; step of the battle results screen (E-0133)
DEF wBattleResultCounter EQU $C89A ; counter of the battle results screen (E-0133)
DEF wBattleResultByte9B EQU $C89B ; set by the battle results screen (E-0133)
DEF wBattleResultByte9C EQU $C89C ; set by the battle results screen (E-0133)
DEF wThreeOptionResult EQU $C89D ; choice of HandleThreeOptionMenuInput_15 (E-0133)
DEF wScriptTileBuf0 EQU $C89E ; 16-byte tile uploaded by UploadTwoTilesFromWC89E (filled by script fetch 6) (E-0133)
DEF wScriptTileBuf1 EQU $C8AE ; second 16-byte tile uploaded by UploadTwoTilesFromWC89E (E-0133)
DEF wFieldStepFlags EQU $C8BF ; field flags: bit 7 set by SetWC8BFBit7; $C0 blocks step triggers (E-0133)
DEF wDigits EQU $C8C0 ; three decimal digits (hundreds, tens, ones) from HLToDecimalDigits; also a 24-bit input of Number24ToPackedBCD (E-0133)
DEF wSaveStep EQU $C8C3 ; save-routine stage (RunSaveGameSteps); bit 7 marks the end (E-0133)
DEF wSaveRecordIndex EQU $C8C4 ; record index of the save-record steps (E-0133)
DEF wFieldTransitionStep EQU $C8C5 ; step of the field transition (mode state 4) (E-0133)
DEF wFieldTransitionKind EQU $C8C6 ; kind of field transition (warp, fade, special) (E-0133)
DEF wFieldReturnPhase EQU $C8C7 ; phase used when returning to the field (RunWC8C7Phase); non-zero keeps the screen (E-0133)
DEF wC8C8 EQU $C8C8
DEF wC8C9 EQU $C8C9
DEF wC8CA EQU $C8CA
DEF wC8CB EQU $C8CB
DEF wC8CC EQU $C8CC
DEF wC8CD EQU $C8CD
DEF wC8CE EQU $C8CE
DEF wC8CF EQU $C8CF
DEF wC8D0 EQU $C8D0
DEF wC8D1 EQU $C8D1
DEF wC8D2 EQU $C8D2
DEF wC8D3 EQU $C8D3
DEF wC8D4 EQU $C8D4
DEF wC8D5 EQU $C8D5
DEF wC8D6 EQU $C8D6
DEF wC8D7 EQU $C8D7
DEF wC8D8 EQU $C8D8
DEF wC8D9 EQU $C8D9
DEF wC8DA EQU $C8DA
DEF wC8DB EQU $C8DB
DEF wC8DC EQU $C8DC
DEF wC8DD EQU $C8DD
DEF wC8DE EQU $C8DE
DEF wFollowerRecords EQU $C8EF ; three 5-byte records for the monsters following the player: direction, X, Y, target X, target Y (SetFollowerTargetsFromLeader, StepFollowersTowardTargets; ScriptSetDirection and ScriptSlideObjectY address the same records) (E-0093) (reading (E-0093))
DEF wC8F0 EQU $C8F0
DEF wC8F1 EQU $C8F1
DEF wC8F2 EQU $C8F2
DEF wC8F3 EQU $C8F3
DEF wC8F4 EQU $C8F4
DEF wC8F5 EQU $C8F5
DEF wC8F6 EQU $C8F6
DEF wC8F7 EQU $C8F7
DEF wC8F8 EQU $C8F8
DEF wC8F9 EQU $C8F9
DEF wC8FA EQU $C8FA
DEF wC8FB EQU $C8FB
DEF wC8FC EQU $C8FC
DEF wC8FD EQU $C8FD
DEF wC8FE EQU $C8FE
DEF wC8FF EQU $C8FF
DEF wC900 EQU $C900
DEF wC901 EQU $C901
DEF wC902 EQU $C902
DEF wC903 EQU $C903
DEF wC904 EQU $C904
DEF wC905 EQU $C905
DEF wC906 EQU $C906
DEF wC907 EQU $C907
DEF wC908 EQU $C908
DEF wC909 EQU $C909
DEF wC90A EQU $C90A
DEF wC90B EQU $C90B
DEF wC90C EQU $C90C
DEF wC90D EQU $C90D
DEF wC90E EQU $C90E
DEF wC90F EQU $C90F
DEF wC910 EQU $C910
DEF wC911 EQU $C911
DEF wC912 EQU $C912
DEF wC913 EQU $C913
DEF wC914 EQU $C914
DEF wC915 EQU $C915
DEF wC916 EQU $C916
DEF wC917 EQU $C917
DEF wC918 EQU $C918
DEF wScriptStartRequest EQU $C919 ; bit 7 set asks FetchScriptCommand to begin running the script at wScriptPointer (reading + execution (E-0038))
DEF wScriptPointerLo EQU $C91A ; low byte of the address of the next script byte (wC91B is the high byte; the bytes are in the current bank, or in wDataBank when wScriptInDataBank is set) (reading + execution (E-0038))
DEF wScriptPointerHi EQU $C91B ; high byte of the script pointer (reading + execution (E-0038))
DEF wC91C EQU $C91C
DEF wC91D EQU $C91D
DEF wC91E EQU $C91E
DEF wScriptRunning EQU $C91F ; non-zero while a script runs (reading + execution (E-0038))
DEF wScriptCommandType EQU $C920 ; the script command being run, 0 = none; indexes ScriptCommandHandlers (minus 1) (reading + execution (E-0038))
DEF wScriptParam0 EQU $C921 ; first parameter of the current script command (reading + execution (E-0038))
DEF wScriptParam1 EQU $C922 ; second parameter of the current script command (reading + execution (E-0038))
DEF wScriptStep EQU $C923 ; step counter of the current script command (reading + execution (E-0038))
DEF wMessageIndex EQU $C924 ; string index of the message RunMessageBox shows (low byte of the message word) (E-0079) (reading (E-0079))
DEF wMessageGroup EQU $C925 ; message word high byte: bits 0-5 select the message group (ShowMessageHL), bit 7 skips opening the window, bit 6 skips closing it (E-0079) (reading (E-0079))
DEF wMessageState EQU $C926 ; RunMessageBox state: 0-3 while a message runs, $FF when idle; StartMessageA sets 0 (E-0079) (reading (E-0079))
DEF wC927 EQU $C927
DEF wC928 EQU $C928
DEF wC929 EQU $C929
DEF wC92A EQU $C92A
DEF wStepArrived EQU $C92C ; 1 when the last StepObjectTowardCoord or StepPlayer*TowardWC928 step reached the target coordinate in wC928, else 0 (E-0071) (reading (E-0071))
DEF wC92D EQU $C92D
DEF wC92E EQU $C92E
DEF wC92F EQU $C92F
DEF wC930 EQU $C930
DEF wC931 EQU $C931
DEF wC932 EQU $C932
DEF wC933 EQU $C933
DEF wC934 EQU $C934
DEF wC935 EQU $C935
DEF wC936 EQU $C936
DEF wC937 EQU $C937
DEF wC938 EQU $C938
DEF wC939 EQU $C939
DEF wC93A EQU $C93A
DEF wC93B EQU $C93B
DEF wC93C EQU $C93C
DEF wC93D EQU $C93D
DEF wC93E EQU $C93E
DEF wC93F EQU $C93F
DEF wC940 EQU $C940
DEF wC941 EQU $C941
DEF wC942 EQU $C942
DEF wC943 EQU $C943
DEF wC944 EQU $C944
DEF wC945 EQU $C945
DEF wC946 EQU $C946
DEF wC947 EQU $C947
DEF wC948 EQU $C948
DEF wC949 EQU $C949
DEF wC94A EQU $C94A
DEF wC94B EQU $C94B
DEF wC94C EQU $C94C
DEF wC94D EQU $C94D
DEF wC94E EQU $C94E
DEF wC94F EQU $C94F
DEF wC950 EQU $C950
DEF wC951 EQU $C951
DEF wC952 EQU $C952
DEF wC953 EQU $C953
DEF wC954 EQU $C954
DEF wC955 EQU $C955
DEF wC956 EQU $C956
DEF wC957 EQU $C957
DEF wC958 EQU $C958
DEF wC962 EQU $C962
DEF wC963 EQU $C963
DEF wC964 EQU $C964
DEF wC965 EQU $C965
DEF wC966 EQU $C966
DEF wC967 EQU $C967
DEF wC968 EQU $C968
DEF wC969 EQU $C969
DEF wC96A EQU $C96A
DEF wC96B EQU $C96B
DEF wC96C EQU $C96C
DEF wC96D EQU $C96D
DEF wC96E EQU $C96E
DEF wC96F EQU $C96F
DEF wC970 EQU $C970
DEF wC971 EQU $C971
DEF wC972 EQU $C972
DEF wC981 EQU $C981
DEF wC982 EQU $C982
DEF wC983 EQU $C983
DEF wC984 EQU $C984
DEF wC985 EQU $C985
DEF wC986 EQU $C986
DEF wC987 EQU $C987
DEF wC991 EQU $C991
DEF wC992 EQU $C992
DEF wC993 EQU $C993
DEF wC994 EQU $C994
DEF wC995 EQU $C995
DEF wC9BA EQU $C9BA
DEF wC9C2 EQU $C9C2
DEF wC9DC EQU $C9DC
DEF wC9DD EQU $C9DD
DEF wC9DE EQU $C9DE
DEF wC9DF EQU $C9DF
DEF wC9E0 EQU $C9E0
DEF wC9E1 EQU $C9E1
DEF wC9E2 EQU $C9E2
DEF wC9E3 EQU $C9E3
DEF wC9E4 EQU $C9E4
DEF wC9E5 EQU $C9E5
DEF wC9E6 EQU $C9E6
DEF wC9E7 EQU $C9E7
DEF wC9E8 EQU $C9E8
DEF wC9E9 EQU $C9E9
DEF wC9EA EQU $C9EA
DEF wC9EB EQU $C9EB
DEF wC9EC EQU $C9EC
DEF wC9ED EQU $C9ED
DEF wC9EE EQU $C9EE
DEF wC9EF EQU $C9EF
DEF wC9F0 EQU $C9F0
DEF wC9F1 EQU $C9F1
DEF wC9F2 EQU $C9F2
DEF wC9F3 EQU $C9F3
DEF wC9F7 EQU $C9F7
DEF wC9F9 EQU $C9F9
DEF wCA2A EQU $CA2A
DEF wCA2B EQU $CA2B
DEF wCA2C EQU $CA2C
DEF wCA36 EQU $CA36
DEF wCA37 EQU $CA37
DEF wCA38 EQU $CA38
DEF wCA39 EQU $CA39
DEF wCA3A EQU $CA3A
DEF wCA45 EQU $CA45
DEF wCA46 EQU $CA46
DEF wCA47 EQU $CA47
DEF wCA48 EQU $CA48
DEF wCA49 EQU $CA49
DEF wCA53 EQU $CA53
DEF wCA54 EQU $CA54
DEF wCA55 EQU $CA55
DEF wCA56 EQU $CA56
DEF wCA5E EQU $CA5E
DEF wCA5F EQU $CA5F
DEF wCA67 EQU $CA67
DEF wCA80 EQU $CA80
DEF wCA81 EQU $CA81
DEF wCA82 EQU $CA82
DEF wCA83 EQU $CA83
DEF wCA84 EQU $CA84
DEF wCA85 EQU $CA85
DEF wCA86 EQU $CA86
DEF wCA87 EQU $CA87
DEF wCA88 EQU $CA88
DEF wCA89 EQU $CA89
DEF wCA8A EQU $CA8A
DEF wCA8B EQU $CA8B
DEF wCA8C EQU $CA8C
DEF wCA8D EQU $CA8D
DEF wCA8E EQU $CA8E
DEF wCA8F EQU $CA8F
DEF wCA90 EQU $CA90
DEF wCA91 EQU $CA91
DEF wCA92 EQU $CA92
DEF wCA93 EQU $CA93
DEF wCA94 EQU $CA94
DEF wCA95 EQU $CA95
DEF wCA96 EQU $CA96
DEF wCA97 EQU $CA97
DEF wCA98 EQU $CA98
DEF wCA99 EQU $CA99
DEF wCA9A EQU $CA9A
DEF wCA9B EQU $CA9B
DEF wCA9D EQU $CA9D
DEF wCA9E EQU $CA9E
DEF wCAB9 EQU $CAB9
DEF wCAC3 EQU $CAC3
DEF wCAC4 EQU $CAC4
DEF wCACE EQU $CACE
DEF wCACF EQU $CACF
DEF wCAD0 EQU $CAD0
DEF wCADB EQU $CADB
DEF wCADC EQU $CADC
DEF wCADD EQU $CADD
DEF wCADE EQU $CADE
DEF wCADF EQU $CADF
DEF wCAE9 EQU $CAE9
DEF wCB04 EQU $CB04
DEF wCB0C EQU $CB0C
DEF wCB25 EQU $CB25
DEF wCB26 EQU $CB26
DEF wCB27 EQU $CB27
DEF wCB28 EQU $CB28
DEF wCB2B EQU $CB2B
DEF wCB3D EQU $CB3D
DEF wCB3E EQU $CB3E
DEF wCB3F EQU $CB3F
DEF wCB43 EQU $CB43
DEF wCB74 EQU $CB74
DEF wCB75 EQU $CB75
DEF wCB76 EQU $CB76
DEF wSpriteSlotCount EQU $CB7D ; number of 8-byte slots DrawSpriteSlots draws (reading)
DEF wCB7E EQU $CB7E
DEF wSpriteSlots EQU $CB7F ; start of an array of objects: 8-byte slots in the bank $E0 intro (DrawSpriteSlots), 16-byte entries in field mode (the script commands, ScriptStepObject) (reading)
DEF wCB80 EQU $CB80
DEF wCB81 EQU $CB81
DEF wCB82 EQU $CB82
DEF wCB83 EQU $CB83
DEF wCB84 EQU $CB84
DEF wCB85 EQU $CB85
DEF wCB86 EQU $CB86
DEF wCB87 EQU $CB87
DEF wCB88 EQU $CB88
DEF wCB89 EQU $CB89
DEF wCB8A EQU $CB8A
DEF wCB8B EQU $CB8B
DEF wCB8C EQU $CB8C
DEF wCB8D EQU $CB8D
DEF wCB8E EQU $CB8E
DEF wCB8F EQU $CB8F
DEF wCB90 EQU $CB90
DEF wCB91 EQU $CB91
DEF wCB92 EQU $CB92
DEF wCB93 EQU $CB93
DEF wCB96 EQU $CB96
DEF wCB98 EQU $CB98
DEF wCB9A EQU $CB9A
DEF wCB9B EQU $CB9B
DEF wCB9C EQU $CB9C
DEF wCB9F EQU $CB9F
DEF wCBA1 EQU $CBA1
DEF wCBA2 EQU $CBA2
DEF wCBA3 EQU $CBA3
DEF wCBA4 EQU $CBA4
DEF wCBA6 EQU $CBA6
DEF wCBA8 EQU $CBA8
DEF wCBAA EQU $CBAA
DEF wCBAB EQU $CBAB
DEF wCBAC EQU $CBAC
DEF wCBB6 EQU $CBB6
DEF wCBBA EQU $CBBA
DEF wCBBB EQU $CBBB
DEF wCBBC EQU $CBBC
DEF wCBC6 EQU $CBC6
DEF wCBCA EQU $CBCA
DEF wCBCC EQU $CBCC
DEF wCBCF EQU $CBCF
DEF wCBD0 EQU $CBD0
DEF wCBD3 EQU $CBD3
DEF wCBD4 EQU $CBD4
DEF wCBD5 EQU $CBD5
DEF wCBD6 EQU $CBD6
DEF wCBD7 EQU $CBD7
DEF wCC37 EQU $CC37
DEF wCC38 EQU $CC38
DEF wCC39 EQU $CC39
DEF wCC3A EQU $CC3A
DEF wCC3B EQU $CC3B
DEF wCC3C EQU $CC3C
DEF wCC3F EQU $CC3F
DEF wCC42 EQU $CC42
DEF wCC43 EQU $CC43
DEF wCC44 EQU $CC44
DEF wCC45 EQU $CC45
DEF wCC46 EQU $CC46
DEF wCC47 EQU $CC47
DEF wCC48 EQU $CC48
DEF wCC4C EQU $CC4C
DEF wCCCD EQU $CCCD
DEF wCCE9 EQU $CCE9
DEF wCCEA EQU $CCEA
DEF wCCEB EQU $CCEB
DEF wCCED EQU $CCED
DEF wCCEE EQU $CCEE
DEF wCCF1 EQU $CCF1
DEF wCCF2 EQU $CCF2
DEF wCCF7 EQU $CCF7
DEF wCD02 EQU $CD02
DEF wCD03 EQU $CD03
DEF wCD04 EQU $CD04
DEF wCD05 EQU $CD05
DEF wCD06 EQU $CD06
DEF wCD07 EQU $CD07
DEF wCD08 EQU $CD08
DEF wCD09 EQU $CD09
DEF wCD0A EQU $CD0A
DEF wCD0B EQU $CD0B
DEF wCD0C EQU $CD0C
DEF wCD0D EQU $CD0D
DEF wCD0E EQU $CD0E
DEF wCD0F EQU $CD0F
DEF wCD10 EQU $CD10
DEF wCD11 EQU $CD11
DEF wCD56 EQU $CD56
DEF wCD60 EQU $CD60
DEF wCD63 EQU $CD63
DEF wCD70 EQU $CD70
DEF wCD74 EQU $CD74
DEF wCD78 EQU $CD78
DEF wCD7A EQU $CD7A
DEF wCD7B EQU $CD7B
DEF wCD88 EQU $CD88
DEF wCD89 EQU $CD89
DEF wCD8B EQU $CD8B
DEF wCDAC EQU $CDAC
DEF wCDAD EQU $CDAD
DEF wCDAE EQU $CDAE
DEF wCDAF EQU $CDAF
DEF wCDB0 EQU $CDB0
DEF wCDCC EQU $CDCC
DEF wCE2C EQU $CE2C
DEF wCE2D EQU $CE2D
DEF wCE72 EQU $CE72
DEF wCE73 EQU $CE73
DEF wCE74 EQU $CE74
DEF wCE75 EQU $CE75
DEF wCE76 EQU $CE76
DEF wCE77 EQU $CE77
DEF wCE78 EQU $CE78
DEF wCE79 EQU $CE79
DEF wCE7A EQU $CE7A
DEF wCE7B EQU $CE7B
DEF wCE7E EQU $CE7E
DEF wCE8B EQU $CE8B
DEF wCE93 EQU $CE93
DEF wCE94 EQU $CE94
DEF wCE95 EQU $CE95
DEF wCE96 EQU $CE96
DEF wCE97 EQU $CE97
DEF wCE98 EQU $CE98
DEF wCE99 EQU $CE99
DEF wCE9A EQU $CE9A
DEF wCE9B EQU $CE9B
DEF wCE9C EQU $CE9C
DEF wCE9D EQU $CE9D
DEF wCE9E EQU $CE9E
DEF wCE9F EQU $CE9F
DEF wCEBF EQU $CEBF
DEF wCEC0 EQU $CEC0
DEF wCEC1 EQU $CEC1
DEF wCEC2 EQU $CEC2
DEF wCEC3 EQU $CEC3
DEF wCEC4 EQU $CEC4
DEF wCEC5 EQU $CEC5
DEF wCEC6 EQU $CEC6
DEF wCEC7 EQU $CEC7
DEF wCEC8 EQU $CEC8
DEF wCEC9 EQU $CEC9
DEF wCECA EQU $CECA
DEF wCECB EQU $CECB
DEF wCECC EQU $CECC
DEF wCECD EQU $CECD
DEF wCECE EQU $CECE
DEF wCECF EQU $CECF
DEF wCED9 EQU $CED9
DEF wCEDA EQU $CEDA
DEF wCEDB EQU $CEDB
DEF wCEDC EQU $CEDC
DEF wCEE7 EQU $CEE7
DEF wCF0A EQU $CF0A
DEF wCF0B EQU $CF0B
DEF wCF0C EQU $CF0C
DEF wCF29 EQU $CF29
DEF wCF2B EQU $CF2B
DEF wCF2D EQU $CF2D
DEF wCF2F EQU $CF2F
DEF wCF31 EQU $CF31
DEF wCF33 EQU $CF33
DEF wCF35 EQU $CF35
DEF wCF37 EQU $CF37
DEF wCF41 EQU $CF41
DEF wCF73 EQU $CF73
DEF wCF7E EQU $CF7E
DEF wCF89 EQU $CF89
DEF wCF8A EQU $CF8A
DEF wCF8B EQU $CF8B
DEF wCF8C EQU $CF8C
DEF wCF8D EQU $CF8D
DEF wCF8E EQU $CF8E
DEF wCF8F EQU $CF8F
DEF wCF90 EQU $CF90
DEF wCFA7 EQU $CFA7
DEF wCFA8 EQU $CFA8
DEF wCFA9 EQU $CFA9
DEF wCFAA EQU $CFAA
DEF wCFAB EQU $CFAB
DEF wCFAC EQU $CFAC
DEF wCFAD EQU $CFAD
DEF wCFBC EQU $CFBC
DEF wCFBD EQU $CFBD
DEF wCFBE EQU $CFBE
DEF wCFBF EQU $CFBF
DEF wCFC0 EQU $CFC0
DEF wCFC1 EQU $CFC1
DEF wCFC2 EQU $CFC2
DEF wCFC3 EQU $CFC3
DEF wCFC4 EQU $CFC4
DEF wCFC5 EQU $CFC5
DEF wBattlePhase EQU $CFC8 ; battle phase, a 3-entry dispatch in Func_031_40CC: 1 = the fight, 2 = after the fight (victory message, rewards, recruiting); 0 at start (E-0044) (execution (E-0042))
DEF wBattleStep EQU $CFC9 ; step within the battle phase: in phase 1, 1 = set-up, 2 = command entry (a loop over the party), 3 = executing the chosen actions; in phase 2, 0-5 = the end-of-battle sequence (E-0044) (execution (E-0042))
DEF wBattleSubPhase EQU $CFCA ; index within the battle step: during step 3 of phase 1 it counts the actions being executed (0, 1, 2, ...); during command entry it alternates 1 and 2 (E-0044) (reading (E-0043))
DEF wBattleResolveStep EQU $CFCB ; step of RunBattleResolveStep (16 cases, 0-15) for the action wBattleSubPhase is executing; ApplyDamageToTarget advances or rewinds it (E-0044) (reading (E-0043))
DEF wBattleSubStep EQU $CFCC ; nested step used by Func_032_5EAB (10 cases) and cleared by ApplyDamageToTarget (reading (E-0043))
DEF wBattleSubStep2 EQU $CFCD ; nested step used by Func_032_5A3A (3 cases) (reading (E-0043))
DEF wCFCE EQU $CFCE
DEF wCFCF EQU $CFCF
DEF wCFD0 EQU $CFD0
DEF wCFD1 EQU $CFD1
DEF wCFD2 EQU $CFD2
DEF wCFD3 EQU $CFD3
DEF wCFD4 EQU $CFD4
DEF wCFD5 EQU $CFD5
DEF wCFD6 EQU $CFD6
DEF wCFD7 EQU $CFD7
DEF wCFD8 EQU $CFD8
DEF wCFD9 EQU $CFD9
DEF wCFDA EQU $CFDA
DEF wCFDB EQU $CFDB
DEF wCFDC EQU $CFDC
DEF wCFDD EQU $CFDD
DEF wCFDE EQU $CFDE
DEF wCFDF EQU $CFDF
DEF wCFE0 EQU $CFE0
DEF wCFE1 EQU $CFE1
DEF wCFE2 EQU $CFE2
DEF wCFE3 EQU $CFE3
DEF wCFE4 EQU $CFE4
DEF wCFE5 EQU $CFE5
DEF wMonsterId EQU $CFE6 ; 16-bit monster id (wCFE7 is the high byte) that LoadMonsterRecord reads (reading)
DEF wCFE7 EQU $CFE7
DEF wRecordBuffer EQU $CFEC ; scratch buffer shared by the record loaders: LoadSkillRecord reads its first word as the skill number and writes 17 bytes after it; LoadMonsterRecord stores a 26-byte monster record here (reading)
DEF wCFED EQU $CFED
DEF wRecordBufferData EQU $CFEE ; where LoadSkillRecord puts the 17 bytes of a skill record (byte 2 of the buffer) (reading)
DEF wCFEF EQU $CFEF
DEF wCFF0 EQU $CFF0
DEF wCFF1 EQU $CFF1
DEF wCFF2 EQU $CFF2
DEF wCFF3 EQU $CFF3
DEF wCFF4 EQU $CFF4
DEF wCFF5 EQU $CFF5
DEF wCFF6 EQU $CFF6
DEF wCFF7 EQU $CFF7
DEF wCFF8 EQU $CFF8
DEF wCFF9 EQU $CFF9
DEF wCFFA EQU $CFFA
DEF wCFFB EQU $CFFB
DEF wCFFC EQU $CFFC
DEF wCFFD EQU $CFFD
DEF wCFFE EQU $CFFE
DEF wCFFF EQU $CFFF
DEF wD000 EQU $D000
DEF wD001 EQU $D001
DEF wD002 EQU $D002
DEF wD003 EQU $D003
DEF wD004 EQU $D004
DEF wD005 EQU $D005
DEF wSpeciesIdLo EQU $D006 ; low byte of the monster id whose species record LoadSpeciesRecord loads (E-0069) (reading + data (E-0069))
DEF wSpeciesIdHi EQU $D007 ; high byte of that monster id (E-0069) (reading + data (E-0069))
DEF wSpeciesRecord EQU $D008 ; 47-byte copy of a species record (LoadSpeciesRecord); byte 0 is the family (E-0069) (reading + data (E-0069))
DEF wD009 EQU $D009
DEF wD00A EQU $D00A
DEF wD00B EQU $D00B
DEF wD00C EQU $D00C
DEF wD00E EQU $D00E
DEF wD00F EQU $D00F
DEF wD010 EQU $D010
DEF wD011 EQU $D011
DEF wD012 EQU $D012
DEF wD013 EQU $D013
DEF wD014 EQU $D014
DEF wD015 EQU $D015
DEF wD016 EQU $D016
DEF wD017 EQU $D017
DEF wD018 EQU $D018
DEF wD019 EQU $D019
DEF wD01A EQU $D01A
DEF wD034 EQU $D034
DEF wD035 EQU $D035
DEF wD036 EQU $D036
DEF wD040 EQU $D040
DEF wD041 EQU $D041
DEF wD043 EQU $D043
DEF wD044 EQU $D044
DEF wD045 EQU $D045
DEF wD046 EQU $D046
DEF wD047 EQU $D047
DEF wD048 EQU $D048
DEF wD049 EQU $D049
DEF wD04A EQU $D04A
DEF wD04B EQU $D04B
DEF wD04C EQU $D04C
DEF wD04D EQU $D04D
DEF wD057 EQU $D057
DEF wD058 EQU $D058
DEF wD059 EQU $D059
DEF wD05A EQU $D05A
DEF wD064 EQU $D064
DEF wD065 EQU $D065
DEF wD066 EQU $D066
DEF wDataBankSave EQU $D067 ; spare slot some code copies wDataBank to and restores it from (E-0014)
DEF wD068 EQU $D068
DEF wD069 EQU $D069
DEF wD06A EQU $D06A
DEF wD06B EQU $D06B
DEF wD06C EQU $D06C
DEF wD080 EQU $D080
DEF wItemId EQU $D081 ; item id used by LoadItemRecord and RunItemEffect; $FF = none (reading)
DEF wD082 EQU $D082
DEF wD083 EQU $D083
DEF wItemRecord EQU $D084 ; 13-byte copy of an ItemTable record (reading)
DEF wD087 EQU $D087
DEF wD088 EQU $D088
DEF wD08A EQU $D08A
DEF wD08C EQU $D08C
DEF wD08D EQU $D08D
DEF wD08E EQU $D08E
DEF wD08F EQU $D08F
DEF wD090 EQU $D090
DEF wD091 EQU $D091
DEF wD092 EQU $D092
DEF wD093 EQU $D093
DEF wD095 EQU $D095
DEF wD096 EQU $D096
DEF wD097 EQU $D097
DEF wD098 EQU $D098
DEF wD099 EQU $D099
DEF wD09A EQU $D09A
DEF wD09B EQU $D09B
DEF wD09C EQU $D09C
DEF wD09D EQU $D09D
DEF wD09E EQU $D09E
DEF wD09F EQU $D09F
DEF wD0A0 EQU $D0A0
DEF wD0A1 EQU $D0A1
DEF wD0A2 EQU $D0A2
DEF wD0A3 EQU $D0A3
DEF wD0A4 EQU $D0A4
DEF wD0A5 EQU $D0A5
DEF wD0A6 EQU $D0A6
DEF wD0A7 EQU $D0A7
DEF wD0A8 EQU $D0A8
DEF wD0A9 EQU $D0A9
DEF wD0AA EQU $D0AA
DEF wD0AB EQU $D0AB
DEF wD0AC EQU $D0AC
DEF wD0AD EQU $D0AD
DEF wD0AE EQU $D0AE
DEF wD0BD EQU $D0BD
DEF wD0C7 EQU $D0C7
DEF wD0CD EQU $D0CD
DEF wBattlerRecords EQU $D0D5 ; six 78-byte ($4E) battler records for slots 0-2 and 4-6 (BattlerRecordFieldAddress); GetBaseHP reads the HP word at offset $1D (E-0062) (reading (E-0062))
DEF wD0D6 EQU $D0D6
DEF wD0D9 EQU $D0D9
DEF wD0DF EQU $D0DF
DEF wD0E0 EQU $D0E0
DEF wD0E2 EQU $D0E2
DEF wD0E3 EQU $D0E3
DEF wD0E4 EQU $D0E4
DEF wD0E5 EQU $D0E5
DEF wD0E6 EQU $D0E6
DEF wD0E7 EQU $D0E7
DEF wD0E8 EQU $D0E8
DEF wD0EA EQU $D0EA
DEF wD0EC EQU $D0EC
DEF wD0ED EQU $D0ED
DEF wD0F2 EQU $D0F2
DEF wD0F6 EQU $D0F6
DEF wD0F8 EQU $D0F8
DEF wD0FA EQU $D0FA
DEF wD0FC EQU $D0FC
DEF wD0FE EQU $D0FE
DEF wD100 EQU $D100
DEF wD104 EQU $D104
DEF wD10A EQU $D10A
DEF wD10B EQU $D10B
DEF wD10C EQU $D10C
DEF wD10D EQU $D10D
DEF wD10E EQU $D10E
DEF wD10F EQU $D10F
DEF wD110 EQU $D110
DEF wD11E EQU $D11E
DEF wD123 EQU $D123
DEF wD12D EQU $D12D
DEF wD132 EQU $D132
DEF wD136 EQU $D136
DEF wD13A EQU $D13A
DEF wD140 EQU $D140
DEF wD144 EQU $D144
DEF wD146 EQU $D146
DEF wD148 EQU $D148
DEF wD14A EQU $D14A
DEF wD14C EQU $D14C
DEF wD15E EQU $D15E
DEF wD168 EQU $D168
DEF wD17B EQU $D17B
DEF wD1BF EQU $D1BF
DEF wD1C9 EQU $D1C9
DEF wD1CC EQU $D1CC
DEF wD1D6 EQU $D1D6
DEF wD1E3 EQU $D1E3
DEF wD200 EQU $D200
DEF wD201 EQU $D201
DEF wD208 EQU $D208
DEF wD20C EQU $D20C
DEF wD20D EQU $D20D
DEF wD217 EQU $D217
DEF wD21D EQU $D21D
DEF wD225 EQU $D225
DEF wD235 EQU $D235
DEF wD25A EQU $D25A
DEF wD25F EQU $D25F
DEF wD265 EQU $D265
DEF wD27A EQU $D27A
DEF wD298 EQU $D298
DEF wD2A8 EQU $D2A8
DEF wD2AD EQU $D2AD
DEF wD2AE EQU $D2AE
DEF wD2AF EQU $D2AF
DEF wD2B0 EQU $D2B0
DEF wD2B1 EQU $D2B1
DEF wD2B2 EQU $D2B2
DEF wD2B3 EQU $D2B3
DEF wD2B4 EQU $D2B4
DEF wD2B5 EQU $D2B5
DEF wD2BD EQU $D2BD
DEF wD2C1 EQU $D2C1
DEF wPersonalityIndex EQU $D2C7 ; column index (0-26) into the bank-6 table; set from PersonalityIndexOfSlot in banks $30 and $E0 before ReadBank6TableWord (reading)
DEF wD2C8 EQU $D2C8
DEF wD2C9 EQU $D2C9
DEF wD2CA EQU $D2CA
DEF wD2CB EQU $D2CB
DEF wD2CC EQU $D2CC
DEF wD2CD EQU $D2CD
DEF wD2CE EQU $D2CE
DEF wD2D0 EQU $D2D0
DEF wD580 EQU $D580
DEF wD581 EQU $D581
DEF wD582 EQU $D582
DEF wD586 EQU $D586
DEF wD587 EQU $D587
DEF wD588 EQU $D588
DEF wD589 EQU $D589
DEF wD5B1 EQU $D5B1
DEF wD780 EQU $D780
DEF wD781 EQU $D781
DEF wD782 EQU $D782
DEF wD783 EQU $D783
DEF wD784 EQU $D784
DEF wD785 EQU $D785
DEF wD786 EQU $D786
DEF wD787 EQU $D787
DEF wD788 EQU $D788
DEF wD789 EQU $D789
DEF wD78A EQU $D78A
DEF wD78B EQU $D78B
DEF wD78C EQU $D78C
DEF wD78D EQU $D78D
DEF wD78E EQU $D78E
DEF wD790 EQU $D790
DEF wD791 EQU $D791
DEF wD792 EQU $D792
DEF wD793 EQU $D793
DEF wD794 EQU $D794
DEF wD799 EQU $D799
DEF wD79A EQU $D79A
DEF wD79C EQU $D79C
DEF wD7A2 EQU $D7A2
DEF wD7A5 EQU $D7A5
DEF wD7A6 EQU $D7A6
DEF wD7A9 EQU $D7A9
DEF wD7AA EQU $D7AA
DEF wD7AB EQU $D7AB
DEF wD7AC EQU $D7AC
DEF wD7AD EQU $D7AD
DEF wD7AE EQU $D7AE
DEF wD7AF EQU $D7AF
DEF wD7B0 EQU $D7B0
DEF wD7B1 EQU $D7B1
DEF wD7B2 EQU $D7B2
DEF wD7B3 EQU $D7B3
DEF wD7B4 EQU $D7B4
DEF wD7B5 EQU $D7B5
DEF wD7B6 EQU $D7B6
DEF wD7B7 EQU $D7B7
DEF wD7B8 EQU $D7B8
DEF wD7B9 EQU $D7B9
DEF wD7BA EQU $D7BA
DEF wD7BB EQU $D7BB
DEF wD7BC EQU $D7BC
DEF wD7BD EQU $D7BD
DEF wD7BE EQU $D7BE
DEF wD7BF EQU $D7BF
DEF wD7C0 EQU $D7C0
DEF wD7C1 EQU $D7C1
DEF wD7C2 EQU $D7C2
DEF wD7C3 EQU $D7C3
DEF wD7C4 EQU $D7C4
DEF wD7C5 EQU $D7C5
DEF wD7C6 EQU $D7C6
DEF wD7C7 EQU $D7C7
DEF wD7C8 EQU $D7C8
DEF wD7C9 EQU $D7C9
DEF wD7CA EQU $D7CA
DEF wD7CB EQU $D7CB
DEF wD7CC EQU $D7CC
DEF wD7CD EQU $D7CD
DEF wD7CE EQU $D7CE
DEF wD7CF EQU $D7CF
DEF wD7D0 EQU $D7D0
DEF wD7D1 EQU $D7D1
DEF wD7D2 EQU $D7D2
DEF wD7D3 EQU $D7D3
DEF wD7D4 EQU $D7D4
DEF wD7D5 EQU $D7D5
DEF wD7DC EQU $D7DC
DEF wD7DD EQU $D7DD
DEF wD7E0 EQU $D7E0
DEF wD7E1 EQU $D7E1
DEF wD7E2 EQU $D7E2
DEF wD7E3 EQU $D7E3
DEF wD7E4 EQU $D7E4
DEF wD7E5 EQU $D7E5
DEF wD7E6 EQU $D7E6
DEF wD7E8 EQU $D7E8
DEF wD7E9 EQU $D7E9
DEF wD7EA EQU $D7EA
DEF wD7EB EQU $D7EB
DEF wD7EC EQU $D7EC
DEF wD7ED EQU $D7ED
DEF wD7EE EQU $D7EE
DEF wD7EF EQU $D7EF
DEF wD7F0 EQU $D7F0
DEF wD7F1 EQU $D7F1
DEF wD7F2 EQU $D7F2
DEF wD7F3 EQU $D7F3
DEF wD7F4 EQU $D7F4
DEF wD7F5 EQU $D7F5
DEF wD7F6 EQU $D7F6
DEF wD7F7 EQU $D7F7
DEF wD7F8 EQU $D7F8
DEF wMenuInputResult EQU $D7F9 ; result of the bank-$1B/$1D menu cursor routines: $FF confirmed (A), $FE cancelled (B), $FD row moved, $FB page moved, 0 nothing (E-0068) (reading (E-0068))
DEF wTwoChoiceCursor EQU $D7FA ; 0 or 1, the selected entry of UpdateTwoChoiceCursor (E-0068) (reading (E-0068))
DEF wD7FB EQU $D7FB
DEF wD7FC EQU $D7FC
DEF wScriptInDataBank EQU $D7FD ; non-zero when the script bytes are read from the bank in wDataBank (reading + execution (E-0038))
DEF wDataBank EQU $D7FE ; ROM bank used by Func_000_0B6C when reading a word through HL (E-0014)
DEF wD7FF EQU $D7FF
DEF wD800 EQU $D800
DEF wD801 EQU $D801
DEF wD802 EQU $D802
DEF wD803 EQU $D803
DEF wD804 EQU $D804
DEF wD805 EQU $D805
DEF wD806 EQU $D806
DEF wD807 EQU $D807
DEF wD808 EQU $D808
DEF wD80A EQU $D80A
DEF wD80B EQU $D80B
DEF wBattleStatus EQU $D80C ; 9-byte status record per slot (AddAx9ToHL), cleared when the battler is defeated (reading (E-0043))
DEF wD80D EQU $D80D
DEF wD80E EQU $D80E
DEF wD80F EQU $D80F
DEF wD810 EQU $D810
DEF wD811 EQU $D811
DEF wD812 EQU $D812
DEF wD813 EQU $D813
DEF wD814 EQU $D814
DEF wD815 EQU $D815
DEF wD854 EQU $D854
DEF wD864 EQU $D864
DEF wD866 EQU $D866
DEF wD867 EQU $D867
DEF wD868 EQU $D868
DEF wD869 EQU $D869
DEF wD86A EQU $D86A
DEF wD86B EQU $D86B
DEF wD86C EQU $D86C
DEF wD86D EQU $D86D
DEF wD86E EQU $D86E
DEF wD86F EQU $D86F
DEF wD871 EQU $D871
DEF wBattleDamageLo EQU $D872 ; low byte of the damage ApplyDamageToTarget subtracts (wD873 is the high byte) (reading (E-0043))
DEF wD873 EQU $D873
DEF wD874 EQU $D874
DEF wD875 EQU $D875
DEF wD876 EQU $D876
DEF wD877 EQU $D877
DEF wD878 EQU $D878
DEF wD879 EQU $D879
DEF wD87A EQU $D87A
DEF wD87B EQU $D87B
DEF wD87C EQU $D87C
DEF wD87D EQU $D87D
DEF wD87E EQU $D87E
DEF wD87F EQU $D87F
DEF wD880 EQU $D880
DEF wD88B EQU $D88B
DEF wD88C EQU $D88C
DEF wD88D EQU $D88D
DEF wD88F EQU $D88F
DEF wD890 EQU $D890
DEF wD891 EQU $D891
DEF wD892 EQU $D892
DEF wD893 EQU $D893
DEF wD894 EQU $D894
DEF wD895 EQU $D895
DEF wD89E EQU $D89E
DEF wD89F EQU $D89F
DEF wD8A0 EQU $D8A0
DEF wD8A1 EQU $D8A1
DEF wD8A2 EQU $D8A2
DEF wD8A3 EQU $D8A3
DEF wBattleActor EQU $D8A4 ; slot number of the battler whose turn it is: indexes MP arrays and status records in the battle code (reading (E-0043))
DEF wBattleTarget EQU $D8A5 ; slot number of the battler an action is applied to (ApplyDamageToTarget, DefeatTarget) (reading (E-0043))
DEF wBattleActionId EQU $D8A6 ; id of the action being resolved; the resolve steps compare it with fixed values ($13-$15, $79, $91, $D6, $D7, $DC), some above the SkillTable range of 175, so it is an action number rather than a skill index (reading (E-0045))
DEF wD8A7 EQU $D8A7
DEF wD8AF EQU $D8AF
DEF wD8B7 EQU $D8B7
DEF wD8BB EQU $D8BB
DEF wBattleHP EQU $D8BF ; current HP of the 8 battle slots as 16-bit words (party in slots 0-2, a foe in slot 4); the first value of the party panels; a defeated foe's word fell from 20 to 0 on the emulator (execution (E-0042))
DEF wBattleMaxHP EQU $D8CF ; maximum HP of the 8 battle slots (the foe's word stayed 25 when its current HP fell to 0) (execution (E-0042))
DEF wBattleMP EQU $D8DF ; current MP of the 8 battle slots (the values the party panels show as M) (execution (E-0042))
DEF wBattleMaxMP EQU $D8EF ; maximum MP of the 8 battle slots, by symmetry with wBattleMaxHP (execution (E-0042))
DEF wD8F0 EQU $D8F0
DEF wBattleATK EQU $D8FF ; attack of the 8 battle slots: ComputeBasicDamage reads the actor's word from it and the defence array for the target; 8 words, party in slots 0-2 (reading (E-0043))
DEF wBattleDEF EQU $D90F ; defence of the 8 battle slots; RecomputeBattler (Func_032_5BE8) fills it from GetBaseDEF (reading (E-0043))
DEF wBattleAGL EQU $D91F ; agility of the 8 battle slots; Func_032_5BE8 fills it from GetBaseAGL (reading (E-0043))
DEF wBattleINT EQU $D92F ; intelligence of the 8 battle slots, the array after wBattleAGL (assumed) (reading (E-0043))
DEF wD93F EQU $D93F
DEF wD94F EQU $D94F
DEF wBattleMonsterId EQU $D958 ; word per battle slot: the monster id (the species-record and monster-name number; CopyMonsterNameOfWDAABSlotToDE, GetSlotSpeciesFamily) (E-0069) (reading + data (E-0069))
DEF wD960 EQU $D960
DEF wD961 EQU $D961
DEF wD962 EQU $D962
DEF wD963 EQU $D963
DEF wD964 EQU $D964
DEF wD965 EQU $D965
DEF wSlotPersonalityHi EQU $D968 ; first of three byte arrays (8 slots each) graded into the personality index with weight 9 by PersonalityIndexOfSlot (reading)
DEF wSlotPersonalityMid EQU $D970 ; second array, weight 3 (reading)
DEF wSlotPersonalityLo EQU $D978 ; third array, weight 1 (reading)
DEF wD980 EQU $D980
DEF wD981 EQU $D981
DEF wD982 EQU $D982
DEF wD988 EQU $D988
DEF wD989 EQU $D989
DEF wD999 EQU $D999
DEF wD9A9 EQU $D9A9
DEF wD9C9 EQU $D9C9
DEF wD9D9 EQU $D9D9
DEF wD9E9 EQU $D9E9
DEF wDA08 EQU $DA08
DEF wBattleActionChoice EQU $DA1C ; word per slot: byte 0 is the chosen action id, which ChooseActionTarget copies to wBattleActionId; byte 1 is wBattleTargetChoice (E-0061) (reading (E-0061))
DEF wBattleTargetChoice EQU $DA1D ; byte 1 of each slot word in wBattleActionChoice: the target slot the per-action target routines write (E-0061) (reading (E-0061))
DEF wDA1E EQU $DA1E
DEF wDA1F EQU $DA1F
DEF wDA24 EQU $DA24
DEF wDA2C EQU $DA2C
DEF wDA2D EQU $DA2D
DEF wDA3C EQU $DA3C
DEF wDA3D EQU $DA3D
DEF wDA3E EQU $DA3E
DEF wDA3F EQU $DA3F
DEF wDA40 EQU $DA40
DEF wDA41 EQU $DA41
DEF wDA42 EQU $DA42
DEF wDA43 EQU $DA43
DEF wDA44 EQU $DA44
DEF wDA47 EQU $DA47
DEF wDA4B EQU $DA4B
DEF wDA4C EQU $DA4C
DEF wDA4F EQU $DA4F
DEF wDA53 EQU $DA53
DEF wDA5B EQU $DA5B
DEF wDA5F EQU $DA5F
DEF wBattleSlotOut EQU $DA63 ; one byte per slot: 1 when the battler is defeated or absent (DefeatTarget sets it; CarryUnlessWDA63SlotEmpty reads it) (reading (E-0043))
DEF wDA64 EQU $DA64
DEF wDA65 EQU $DA65
DEF wDA67 EQU $DA67
DEF wDA68 EQU $DA68
DEF wDA69 EQU $DA69
DEF wDA6B EQU $DA6B
DEF wDA6C EQU $DA6C
DEF wDA6D EQU $DA6D
DEF wDA6E EQU $DA6E
DEF wDA6F EQU $DA6F
DEF wDA70 EQU $DA70
DEF wDA71 EQU $DA71
DEF wDA72 EQU $DA72
DEF wDA73 EQU $DA73
DEF wDA74 EQU $DA74
DEF wDA75 EQU $DA75
DEF wDA76 EQU $DA76
DEF wDA77 EQU $DA77
DEF wDA78 EQU $DA78
DEF wDA79 EQU $DA79
DEF wDA80 EQU $DA80
DEF wDA8E EQU $DA8E
DEF wDA95 EQU $DA95
DEF wDA9C EQU $DA9C
DEF wDAAA EQU $DAAA
DEF wDAAB EQU $DAAB
DEF wQueuedActionId EQU $DAAC ; queued action id. One writer read so far stores $FF when a target's pending bit 4 (wD814 + 9 * target) is consumed (Func_036_4A38_Case04); banks $19 and $A0 also write it and are not read yet; read by QueuedActionMatches (E-0049) (reading (E-0049))
DEF wDAAD EQU $DAAD
DEF wDAAE EQU $DAAE
DEF wDAB2 EQU $DAB2
DEF wDAB3 EQU $DAB3
DEF wDAB5 EQU $DAB5
DEF wDAB7 EQU $DAB7
DEF wDAB9 EQU $DAB9
DEF wDABA EQU $DABA
DEF wDABD EQU $DABD
DEF wDABE EQU $DABE
DEF wDABF EQU $DABF
DEF wDAC0 EQU $DAC0
DEF wDAC1 EQU $DAC1
DEF wDAC2 EQU $DAC2
DEF wDAC3 EQU $DAC3
DEF wBattleStatResultLo EQU $DAC4 ; low byte of the 16-bit result of the GetBase* routines (wDAC5 is the high byte) (reading (E-0043))
DEF wBattleStatResultHi EQU $DAC5 ; high byte of the 16-bit result of the GetBase* routines (reading (E-0043))
DEF wDAC9 EQU $DAC9
DEF wDAD1 EQU $DAD1
DEF wDAD2 EQU $DAD2
DEF wDAD3 EQU $DAD3
DEF wDAD4 EQU $DAD4
DEF wDAD7 EQU $DAD7
DEF wDAD8 EQU $DAD8
DEF wDAD9 EQU $DAD9
DEF wDADC EQU $DADC
DEF wDAE0 EQU $DAE0
DEF wDAE8 EQU $DAE8
DEF wDAE9 EQU $DAE9
DEF wDAEA EQU $DAEA
DEF wDAF1 EQU $DAF1
DEF wDAF2 EQU $DAF2
DEF wDAFA EQU $DAFA
DEF wSoundChannelSlots EQU $DC00 ; channel-state slots; the record's first byte is added to this address (E-0018)
DEF wDC01 EQU $DC01
DEF wDC06 EQU $DC06
DEF wDC20 EQU $DC20
DEF wDC21 EQU $DC21
DEF wDC40 EQU $DC40
DEF wDC41 EQU $DC41
DEF wDC60 EQU $DC60
DEF wDC61 EQU $DC61
DEF wDC80 EQU $DC80
DEF wDC81 EQU $DC81
DEF wDCA0 EQU $DCA0
DEF wDCA1 EQU $DCA1
DEF wSoundLabelSlots EQU $DCC0 ; per-channel label slots: 3 bytes each, 16 per channel (E-0019)
DEF wDD08 EQU $DD08
DEF wDD09 EQU $DD09
DEF wSoundHwChannel EQU $DD0A ; hardware channel of the current slot: 2 selects the wave channel, 3 noise (E-0019)
DEF wDD0B EQU $DD0B
DEF wDD0C EQU $DD0C
DEF wDD0D EQU $DD0D
DEF wDD0E EQU $DD0E
DEF wSoundChannelIndex EQU $DD0F ; slot number of the channel the sound engine is processing (E-0019)
DEF wSoundId EQU $DD10 ; sound id passed to the start-sound routine (E-0018)
DEF wDD12 EQU $DD12
DEF wDD13 EQU $DD13
DEF wDD14 EQU $DD14
DEF wDD15 EQU $DD15
DEF wDD16 EQU $DD16
DEF wDD17 EQU $DD17
DEF wDD18 EQU $DD18
DEF wDD19 EQU $DD19
DEF wDFFF EQU $DFFF

; HRAM ($FF80-$FFFE)
DEF hFF80 EQU $FF80
DEF hPlayerSpriteVariant EQU $FF8A ; first byte of the 14 HRAM bytes saved with the game (SaveGameToSRAMWithChecksum); LoadPlayerSpriteGraphics sets it to 0 or 1 by story flag 0 and picks the player graphics with it (E-0132)
DEF hPlayerSpriteMode EQU $FF8B ; sprite mode 0-2 chosen from story flags $19F, $25, 2 and bit 3 of hPlayerStateFlags (LoadPlayerAndFollowerSpriteGraphics); AdvanceHFF99AndRunHFF8BMode dispatches on it (E-0132)
DEF hPlayerStateFlags EQU $FF8C ; player state bits: bit 0 = a step is in progress, bit 2 = moving, bit 1 freezes the animation counter, bits 3, 5, 6, 7 are field-state flags tested before moving, menus and warps (E-0132)
DEF hFieldDrawFlags EQU $FF8D ; field draw flags: InitFieldScreen sets $0F; routines set and clear bits 1-3 around record-list redraws; saved and restored with the sprite state (wD7BA) (E-0132)
DEF hPlayerX EQU $FF8E ; position along the axis that facings 1 and 3 change in CheckInteractionInFront (reading)
DEF hMapScreenX EQU $FF8F ; column of the current screen in the map: LoadMapScreen indexes the map's array of screen streams with hMapScreenY * width + hMapScreenX (1 on the opening ship deck, a map 2 screens wide) (reading + execution (E-0037))
DEF hMapId EQU $FF90 ; map number: indexes MapTable (bank $11); 29 on the opening ship deck; the map's name is the system string at index 10 + number ('Deck' for 29, 'NO' for the unused 30, 31, 39) (reading + execution (E-0036))
DEF hPlayerY EQU $FF91 ; position along the axis that facings 0 and 2 change in CheckInteractionInFront (reading)
DEF hMapScreenY EQU $FF92 ; row of the current screen in the map (0 on the opening ship deck) (reading + execution (E-0037))
DEF hPlayerSpriteOverride EQU $FF93 ; bit 7 set: the player uses the graphics stream in hPlayerSpriteStream and a countdown (hPlayerSpriteTimer) runs; set by script commands $A0/$A1 (E-0132)
DEF hPlayerSpriteStreamLo EQU $FF94 ; low byte of the compressed stream used for the player graphics when bit 7 of hPlayerSpriteOverride is set (E-0132)
DEF hPlayerSpriteStreamHi EQU $FF95 ; high byte of that stream (E-0132)
DEF hPlayerSpriteTimerLo EQU $FF96 ; low byte of a countdown decremented each field update while the sprite override is on; when it goes negative, talk event $0A is dispatched (UpdatePlayerMovement_Sub01_Sub03) (E-0132)
DEF hPlayerSpriteTimerHi EQU $FF97 ; high byte of that countdown (E-0132)
DEF hPlayerFacing EQU $FF98 ; 0, 1, 2, 3: CheckInteractionInFront adds +16 to hFF91, +16 to hFF8E, -16 to hFF91, -16 to hFF8E for these values (reading)
DEF hPlayerAnimCounter EQU $FF99 ; animation counter: +1 per field frame (+3 more while moving) unless bit 1 of hPlayerStateFlags is set (E-0132)
DEF hPlayerTurnDelay EQU $FF9A ; frames to wait after turning in place (set to 4) before the player can step (UpdatePlayerMovement) (E-0132)
DEF hPlayerStepDXLo EQU $FF9B ; low byte of the 16-bit horizontal step delta per frame (+$10, -$10, or screen-scroll values) set when a step starts (E-0132)
DEF hPlayerStepDXHi EQU $FF9C ; high byte of the horizontal step delta (E-0132)
DEF hPlayerStepDYLo EQU $FF9D ; low byte of the 16-bit vertical step delta (for example $FF80 when scrolling up a screen) (E-0132)
DEF hPlayerStepDYHi EQU $FF9E ; high byte of the vertical step delta (E-0132)
DEF hWindowX EQU $FF9F ; copied to rWX by CopyScrollToHardware; 7 in the field (InitFieldScreen) (E-0132)
DEF hWindowY EQU $FFA0 ; copied to rWY by CopyScrollToHardware; $80 (off screen) in the field (E-0132)
DEF hScrollX EQU $FFA1 ; copied to rSCX by Func_000_07E0 and by the LCD handler (reading)
DEF hScrollXHi EQU $FFA2 ; high byte of the 16-bit horizontal scroll that starts at hScrollX (reading)
DEF hScrollY EQU $FFA5 ; copied to rSCY by Func_000_07E0 and by the LCD handler (reading)
DEF hScrollYHi EQU $FFA6 ; high byte of the 16-bit vertical scroll that starts at hScrollY (reading)
DEF hSpriteOriginX EQU $FFA9 ; added to each entry's X (+8) by BuildOamFromSpriteTable (reading)
DEF hSpriteOriginXHi EQU $FFAA ; high byte of the 16-bit sprite X position (hSpriteOriginX is the low byte) (reading)
DEF hSpriteOriginY EQU $FFAB ; added to each entry's Y (+$10) by BuildOamFromSpriteTable (reading)
DEF hSpriteOriginYHi EQU $FFAC ; high byte of the 16-bit sprite Y position (hSpriteOriginY is the low byte) (reading)
DEF hSpriteSetIndex EQU $FFAD ; first-level index into the table BuildOamFromSpriteTable reads (reading)
DEF hSpriteSubIndex EQU $FFAE ; second-level index into the table BuildOamFromSpriteTable reads (reading)
DEF hSpriteTileOffset EQU $FFAF ; added to each entry's tile number by BuildOamFromSpriteTable (reading)
DEF hSpriteAttrXor EQU $FFB0 ; XORed into each entry's attribute byte by BuildOamFromSpriteTable (reading)
DEF hOamNextEntry EQU $FFB1 ; index of the next 4-byte entry BuildOamFromSpriteTable writes at $C000; it stops at $28 (reading)
DEF hMetaSpriteYLo EQU $FFB3 ; metasprite builder: low byte of origin Y plus the scroll offset, added to each entry's Y (E-0132)
DEF hMetaSpriteYHi EQU $FFB4 ; metasprite builder: high byte of that Y, used to drop entries outside the screen (E-0132)
DEF hMetaSpriteXLo EQU $FFB5 ; metasprite builder: low byte of origin X plus the scroll offset (E-0132)
DEF hMetaSpriteXHi EQU $FFB6 ; metasprite builder: high byte of that X (E-0132)
DEF hMetaSpriteXFlipLo EQU $FFB7 ; metasprite builder: X minus 8, low byte, used for horizontally flipped sets (E-0132)
DEF hMetaSpriteXFlipHi EQU $FFB8 ; metasprite builder: high byte of X minus 8 (E-0132)
DEF hSpriteWindowClipMode EQU $FFB9 ; non-zero makes the metasprite builders take the clipping path; set to 2 or 3 while a text window or menu is open and 0 when it closes (E-0132)
DEF hSpriteHideTile EQU $FFBA ; BG tile id compared with the tile under a sprite point (BGTileUnderPointIsHFFBA_*); sprite parts over this tile are hidden; usually $80 (E-0132)
DEF hDecompressMarker EQU $FFBB ; marker byte from the stream header (E-0016)
DEF hDecompressDestLo EQU $FFBC ; destination start, low byte (E-0016)
DEF hDecompressDestHi EQU $FFBD ; destination start, high byte (E-0016)
DEF hDecompressRunCount EQU $FFBF ; decompressor: count of the current run or copy (DecompressToRAM / DecompressToVRAM) (E-0132)
DEF hDecompressRunByte EQU $FFC0 ; decompressor: byte being repeated or the current control byte (E-0132)
DEF hDecompressHeader1 EQU $FFC1 ; decompressor: stream header byte 1 (DecompressReadHeader) (E-0132)
DEF hDecompressHeader2 EQU $FFC2 ; decompressor: stream header byte 2 (E-0132)
DEF hDecompressHeader3 EQU $FFC3 ; decompressor: stream header byte 3 (E-0132)
DEF hDecompressHeader4 EQU $FFC4 ; decompressor: stream header byte 4 (E-0132)
DEF hVRAMByteTemp EQU $FFC5 ; byte held while waiting for VRAM access (DecompressToVRAM, CopyRectToBGMapWrapped_1C) (E-0132)
DEF hTemp0 EQU $FFC6 ; general argument and result byte: SRAM record loads return here, field commands and many helpers take their argument here (used in 54 bank files) (E-0132)
DEF hTemp1 EQU $FFC7 ; general argument/result byte after hTemp0 (high byte of word results) (E-0132)
DEF hTemp2 EQU $FFC8 ; general argument/result byte (third byte of 24-bit and BCD results) (E-0132)
DEF hTemp3 EQU $FFC9 ; general argument/result byte (E-0132)
DEF hTemp4 EQU $FFCA ; general argument/result byte (also a VRAM destination low byte for DecompressGraphicsHFFC6ToHFFCA) (E-0132)
DEF hTemp5 EQU $FFCB ; general argument/result byte (destination high byte for DecompressGraphicsHFFC6ToHFFCA) (E-0132)
DEF hTemp6 EQU $FFCC ; general argument/result byte (divisor for Divide24ByHFFCCDE) (E-0132)
DEF hTemp7 EQU $FFCD ; general scratch byte (E-0132)
DEF hTemp8 EQU $FFCE ; general scratch byte (E-0132)
DEF hTemp9 EQU $FFCF ; general scratch byte (E-0132)
DEF hTempA EQU $FFD0 ; general scratch byte (E-0132)
DEF hVRAMWriteByte EQU $FFD1 ; A saved by WriteVRAMByte / WriteVRAMByteInc while waiting for VRAM access (E-0132)
DEF hSpriteScrollXLo EQU $FFD2 ; low byte of -(scroll X - 9) - 1, computed each frame by ComputeSpriteScrollOffsets (reading)
DEF hSpriteScrollXHi EQU $FFD3 ; high byte of that value (reading)
DEF hSpriteScrollYLo EQU $FFD4 ; low byte of -(scroll Y - $11) - 1 (reading)
DEF hSpriteScrollYHi EQU $FFD5 ; high byte of that value (reading)
DEF hDecompressLock EQU $FFD6 ; non-zero while the decompressor is running (E-0016)
DEF hTrackPosLo EQU $FFD8 ; low byte of the current track position, counted in 2-byte events (E-0019)
DEF hTrackPosHi EQU $FFD9 ; high byte of the current track position (E-0019)
DEF hSndChanFlags EQU $FFDA ; sound channel copy (the 32-byte slot is copied to $FFD8): low 2 bits = hardware channel, high nibble set by track command $A3 (E-0132)
DEF hTrackBaseLo EQU $FFDB ; low byte of the current track's start address (E-0019)
DEF hTrackBaseHi EQU $FFDC ; high byte of the current track's start address (E-0019)
DEF hSoundBank EQU $FFDD ; ROM bank the sound engine reads tracks from (E-0018)
DEF hSndDutyAndTempo EQU $FFDE ; sound channel copy: bits 6-7 = duty (command $A2 / track header), low nibble = tempo step added to hSndTickAccum each tick (E-0132)
DEF hSndTickAccum EQU $FFDF ; sound channel copy: tick accumulator; the channel advances when it passes 16 (E-0132)
DEF hSndEnvelope EQU $FFE0 ; sound channel copy: volume envelope written to NRx2 (command $A0, track header) (E-0132)
DEF hSndWaitTicks EQU $FFE1 ; sound channel copy: ticks left before the next event (set by notes and command $A7) (E-0132)
DEF hSndSweepOrWave EQU $FFE2 ; sound channel copy: NR10 sweep value for channel 1, wave index for channel 3 (command $A1) (E-0132)
DEF hSndChanByteE3 EQU $FFE3 ; sound channel copy: cleared when a track starts; no other use found (E-0132)
DEF hSndBranchIndex EQU $FFE4 ; sound channel copy: index used by command $A9 (set, increment, decrement, or jump through a table by it) (E-0132)
DEF hSndVibratoDepth EQU $FFE5 ; sound channel copy: depth nibble from commands $Cx (E-0132)
DEF hSndVibratoDelay EQU $FFE6 ; sound channel copy: delay value from commands $Cx (and $A2 on channel 3) (E-0132)
DEF hSndVibratoCounter EQU $FFE7 ; sound channel copy: counts up to hSndVibratoDelay after each note (E-0132)
DEF hSndPitchSlide EQU $FFE8 ; sound channel copy: signed pitch slide per step (commands $Dx/$Ex) (E-0132)
DEF hSndPitchSlideTime EQU $FFE9 ; sound channel copy: slide interval reload (E-0132)
DEF hSndPitchSlideCounter EQU $FFEA ; sound channel copy: slide interval counter (E-0132)
DEF hSndFreqLo EQU $FFEB ; sound channel copy: frequency low byte written to NRx3 (E-0132)
DEF hSndFreqHi EQU $FFEC ; sound channel copy: frequency high byte (with the trigger bit) written to NRx4 (E-0132)
DEF hSndEnvelopeReload EQU $FFED ; sound channel copy: high nibble = envelope restored when the envelope timer expires (command $AA) (E-0132)
DEF hSndPanning EQU $FFEE ; sound channel copy: panning bits merged into NR51 for this channel (command $A5) (E-0132)
DEF hSndNoteLength EQU $FFEF ; sound channel copy: note length reload (command $A3, low nibble x 2) (E-0132)
DEF hSndNoteTimer EQU $FFF0 ; sound channel copy: note length counter (E-0132)
DEF hSndA8Param EQU $FFF1 ; sound channel copy: parameter of command $A8 (its high nibble picks the wave table set) (E-0132)
DEF hSndEnvTimer EQU $FFF2 ; sound channel copy: envelope timer (command $AA) (E-0132)
DEF hSndEnvFlags EQU $FFF3 ; sound channel copy: envelope timer flags and reload (command $AA) (E-0132)
DEF hSndLoopCount EQU $FFF4 ; sound channel copy: repeat counter of command $AC (E-0132)
DEF hSndReturnPosLo EQU $FFF5 ; sound channel copy: track position to return to (command $AD), low byte (E-0132)
DEF hSndReturnPosHi EQU $FFF6 ; sound channel copy: return position, high byte (E-0132)
DEF hFFF8 EQU $FFF8

