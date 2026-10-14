; ROM bank $A7: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banka7.asm.

SECTION "Bank A7", ROMX[$4000], BANK[$A7]
; bank $A7: all $00 in the reference
DS $4000, $00
