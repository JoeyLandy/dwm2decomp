; ROM bank $B9: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb9.asm.

SECTION "Bank B9", ROMX[$4000], BANK[$B9]
; bank $B9: all $00 in the reference
DS $4000, $00
