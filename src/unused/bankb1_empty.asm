; ROM bank $B1: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb1.asm.

SECTION "Bank B1", ROMX
; bank $B1: all $00 in the reference
DS $4000, $00
