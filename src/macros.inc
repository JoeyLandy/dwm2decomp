; Macros that name instruction idioms found in the ROM (E-0007). They expand to exactly
; the instructions the ROM contains, so the bytes do not change.

; A far call: `rst $10` calls the code at HL with ROM bank B mapped, then restores the caller's
; bank (Func_000_0010). The ROM loads the two registers in either order, hence two macros.
MACRO farcall
    ld hl, \1
    ld b, BANK(\1)
    rst $10
ENDM

MACRO farcall_b
    ld b, BANK(\1)
    ld hl, \1
    rst $10
ENDM

; A far pointer in data: the address, then its ROM bank (E-0141).
MACRO dfar
    dw \1
    db BANK(\1)
ENDM

; Event script commands (E-0152). FetchScriptCommand (bank $10) reads one opcode byte and
; the inline bytes of the dedicated opcodes; any other opcode is a command type with no
; inline bytes. Relative targets are forward offsets from the byte after the offset
; (in a db list, @ is the address of the byte being assembled).
MACRO script_end
    db $FF
ENDM

MACRO script_message
    db $00
    dw \1
ENDM

MACRO script_skip_if_no
    db $06, (\1) - @ - 1 ; in a db list, @ is the address of the byte being assembled
ENDM

MACRO script_jump
    db $07
    dw \1
ENDM

MACRO script_set_flag
    db $0A
    dw \1
ENDM

MACRO script_add_gold
    db $0E
    dw \1
ENDM

MACRO script_sound
    db $0F, \1
ENDM

MACRO script_choice_jump
    db $E4
    REPT _NARG
        db (\1) - @ - 1
        SHIFT
    ENDR
ENDM

MACRO script_jump_data_bank
    db $E7
    dw \1
ENDM

; E-0242: the dedicated opcodes with inline bytes, named from their fetch handlers and the
; command types they start (ScriptStepObject, ScriptWaitFrames, ScriptCommand05_Run,
; ScriptSetDirection, ScriptSlideObjectY, ScriptCommand0E_Run).
; script_walk object, direction (0 down, 1 right, 2 up, 3 left), tiles: 16 frames per tile
MACRO script_walk
    db $01, \1, \2, \3
ENDM

; the same at two pixels per frame (command type 03 runs ScriptStepObject twice)
MACRO script_walk_fast
    db $02, \1, \2, \3
ENDM

; script_wait frames (a 16-bit count)
MACRO script_wait
    db $03
    dw \1
ENDM

; script_hold_dpad direction (0 down, 1 right, 2 up, 3 left), frames: sets that D-pad bit in wJoypadHeld
MACRO script_hold_dpad
    db $04, \1, \2
ENDM

; script_face target (0 player, n follower record n, $80 + n object n), direction
MACRO script_face
    db $05, \1, \2
ENDM

; script_slide_y target (as script_face): 32 frames of Y steps from Data_05F_7959
MACRO script_slide_y
    db $0B, \1
ENDM

; script_hide_object n: byte $C of sprite slot n = $E0, at once
MACRO script_hide_object
    db $0C, \1
ENDM

; script_encounter n: StartScriptedEncounterTemp0 with ScriptedEncounterTable record n
MACRO script_encounter
    db $0D, \1
ENDM

; a message whose index gets + $20 unless story flag 0 is set
MACRO script_message_unless_flag0
    db $EA
    dw \1
ENDM

; a message whose index gets + 16 * wScreenTableIndex
MACRO script_message_by_screen
    db $F5
    dw \1
ENDM

MACRO script_op
    db \#
ENDM

MACRO script_command
    db \1
ENDM

; Map object selectors (E-0163): entries tried in order by LoadMapObjectsForScreen.
MACRO objsel_none
    dw $FFFF
ENDM

MACRO objsel_list
    dw $FFFE, \1
ENDM

MACRO objsel_unless_flag
    dw \1, \2
ENDM

MACRO objsel_unless_flags
    dw $FFFD, \1, \2, \3
ENDM

MACRO objsel_skip_if_clear
    dw $FFFC, \1
    db \2, \3
ENDM

MACRO objsel_skip_if_set
    dw $FFFB, \1
    db \2, \3
ENDM

; 24-bit little-endian values in data (E-0148).
MACRO d24
    REPT _NARG
        db LOW(\1), HIGH(\1), LOW((\1) >> 16)
        SHIFT
    ENDR
ENDM

; HL += A, the way the ROM spells it: add into L, carry into H.
MACRO add_a_to_hl
    add a, l
    ld l, a
    jr nc, .skip\@
    inc h
.skip\@:
ENDM

; HL = the word at [HL]: low byte first, then the high byte.
MACRO deref_hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
ENDM
