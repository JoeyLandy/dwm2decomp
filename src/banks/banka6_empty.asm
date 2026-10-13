; ROM bank $A6: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banka6.asm.

SECTION "Bank A6", ROMX[$4000], BANK[$A6]
; bank $A6: all $00 in the reference
DS $4000, $00
