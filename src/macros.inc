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
    db $E4, (\1) - @ - 1, (\2) - @ - 1
ENDM

MACRO script_jump_data_bank
    db $E7
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
