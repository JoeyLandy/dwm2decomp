; ROM bank $B6: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb6.asm.

SECTION "Bank B6", ROMX[$4000], BANK[$B6]
; bank $B6: all $00 in the reference
DS $4000, $00
