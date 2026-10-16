; ROM bank $B0: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb0.asm.

SECTION "Bank B0", ROMX
; bank $B0: all $00 in the reference
DS $4000, $00
