; Text encoding (E-0024). Letters, digits, space and the punctuation and contraction
; glyphs below are the characters used in db strings. The font glyphs …()+~/★© are read from
; the font in bank $1F (E-0336); icon glyphs such as the house ($57) and globe ($5C) stay $XX.

CHARMAP "0", $00
CHARMAP "1", $01
CHARMAP "2", $02
CHARMAP "3", $03
CHARMAP "4", $04
CHARMAP "5", $05
CHARMAP "6", $06
CHARMAP "7", $07
CHARMAP "8", $08
CHARMAP "9", $09
CHARMAP "A", $0A
CHARMAP "B", $0B
CHARMAP "C", $0C
CHARMAP "D", $0D
CHARMAP "E", $0E
CHARMAP "F", $0F
CHARMAP "G", $10
CHARMAP "H", $11
CHARMAP "I", $12
CHARMAP "J", $13
CHARMAP "K", $14
CHARMAP "L", $15
CHARMAP "M", $16
CHARMAP "N", $17
CHARMAP "O", $18
CHARMAP "P", $19
CHARMAP "Q", $1A
CHARMAP "R", $1B
CHARMAP "S", $1C
CHARMAP "T", $1D
CHARMAP "U", $1E
CHARMAP "V", $1F
CHARMAP "W", $20
CHARMAP "X", $21
CHARMAP "Y", $22
CHARMAP "Z", $23
CHARMAP "a", $24
CHARMAP "b", $25
CHARMAP "c", $26
CHARMAP "d", $27
CHARMAP "e", $28
CHARMAP "f", $29
CHARMAP "g", $2A
CHARMAP "h", $2B
CHARMAP "i", $2C
CHARMAP "j", $2D
CHARMAP "k", $2E
CHARMAP "l", $2F
CHARMAP "m", $30
CHARMAP "n", $31
CHARMAP "o", $32
CHARMAP "p", $33
CHARMAP "q", $34
CHARMAP "r", $35
CHARMAP "s", $36
CHARMAP "t", $37
CHARMAP "u", $38
CHARMAP "v", $39
CHARMAP "w", $3A
CHARMAP "x", $3B
CHARMAP "y", $3C
CHARMAP "z", $3D
CHARMAP "'s", $3E
CHARMAP "'m", $3F
CHARMAP "'r", $40
CHARMAP "'t", $41
CHARMAP "'v", $42
CHARMAP "'l", $43
CHARMAP "*:", $45
CHARMAP " ", $90
CHARMAP "'", $95
CHARMAP "?", $98
CHARMAP "!", $99
CHARMAP "-", $9C
CHARMAP "~", $9D
CHARMAP "/", $9E
CHARMAP "(", $A0
CHARMAP ")", $A1
CHARMAP "+", $A2
CHARMAP ":", $A3
CHARMAP "…", $A4
CHARMAP ",", $AB
CHARMAP "★", $AC
CHARMAP ".", $B5
CHARMAP "©", $B8

; Text printer commands, bytes $E0-$FF (E-0336): StepStringDisplayUntilDone runs entry
; byte - $E0 of the table in StepStringDisplayUntilDone_Sub01_WriteTextLastChar. A command
; with an argument takes the byte(s) after it, written as $XX after the string. (C2) marks
; what tools/text_check.py observed; the rest is a reading of the handler (C1).

CHARMAP "<NEXT>", $EF, $EE ; next line: on the first line moves to the second; on the second scrolls it up, waits 4 frames and clears it (C2)
CHARMAP "<PROMPT>", $FA, $F7 ; blinking arrow, then wait for a button (C2)
CHARMAP "<BUF0>", $F9, $00 ; the text in wTextBuf0 (a name; C2)
CHARMAP "<BUF1>", $F9, $10 ; the text in wTextBuf1 (C2)
CHARMAP "<BUF2>", $F9, $20 ; the text in wTextBuf2 (C2)
CHARMAP "<BUF3>", $F9, $30 ; the text in wTextBuf3 (C2)
CHARMAP "<MAP_MUSIC>", $E9, $FF ; restart the map's music (RestartMapMusic)
CHARMAP "<SFX_WAIT_E0>", $E0 ; play sound effect $XX and wait until every sound channel is idle
CHARMAP "<SFX_WAIT_E1>", $E1 ; the same as $E0
CHARMAP "<SFX_WAIT_E2>", $E2 ; the same as $E0
CHARMAP "<SFX_WAIT_E3>", $E3 ; the same as $E0
CHARMAP "<SFX_WAIT>", $E4 ; the same as $E0 (the one the text uses)
CHARMAP "<MUSIC_WAIT>", $E5 ; play music $XX and wait until every sound channel is idle
CHARMAP "<CHOICE_E6>", $E6 ; yes/no choice (AcknowledgeTextPrompt), no sound on confirming yes; the answer is wTextYesNoResult (0 yes, 1 no)
CHARMAP "<CHOICE_NO>", $E7 ; yes/no choice with the cursor starting on no
CHARMAP "<CURSOR>", $E8 ; move the glyph cursor to column $XX, row $YY of the text window
CHARMAP "<SOUND>", $E9 ; play sound $XX (music for ids below $60 and $CC, $CF, $D6), without waiting
CHARMAP "<VOICE1>", $EA ; speech beep on, with sound $6B (before a speaker's words)
CHARMAP "<VOICE2>", $EB ; speech beep on, with sound $6A
CHARMAP "<PAUSE>", $EC ; pause for a time set by the text speed; at speed 7 wait for a button instead
CHARMAP "<INSTANT>", $ED ; print the following text at once (wTextControl bit 7) until the next wait
CHARMAP "<CLEAR_LINE>", $EE ; clear the second line and go back to the start of the current line
CHARMAP "<NEXT_LINE>", $EF ; the first half of <NEXT>: on the first line it skips the byte after it
CHARMAP "@", $F0 ; end of the text, or of an inserted text (<BUF0>, <PLAYER>): back to the caller's text (C2)
CHARMAP "<LINE>", $F1 ; start the next line, without scrolling (C2)
CHARMAP "<CLEAR>", $F2 ; clear the window (FillTilesFromRequest) and go back to its first line
CHARMAP "<HOME>", $F3 ; go back to the window's first line
CHARMAP "<NORMAL>", $F4 ; end <INSTANT> and <FAST> (ClearStringDisplayFlags)
CHARMAP "<FAST>", $F5 ; print without the per-glyph wait (wTextFlags bit 1)
CHARMAP "<PLAYER>", $F6 ; the player's name (wPlayerName, copied to wPlayerNameText)
CHARMAP "<WAIT>", $F7 ; wait for a button (C2)
CHARMAP "<SPEED>", $F8 ; frames per glyph from here on: $XX instead of the text speed
CHARMAP "<BUF>", $F9 ; the text at wTextBuf0 + $XX (C2 for $00, $10, $20, $30)
CHARMAP "<ARROW>", $FA ; show the blinking arrow while waiting (C2 with <WAIT>)
CHARMAP "<WAIT_OR_BUTTON>", $FB ; wait $XX frames or until a button
CHARMAP "<DELAY>", $FC ; wait $XX frames
CHARMAP "<BEEP_ON>", $FD ; speech beep on, with the current sound
CHARMAP "<BEEP_OFF>", $FE ; speech beep off
CHARMAP "<CHOICE>", $FF ; yes/no choice with the cursor starting on yes
