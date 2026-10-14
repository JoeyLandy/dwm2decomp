; ROM bank $A4: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banka4.asm.

SECTION "Bank A4", ROMX[$4000], BANK[$A4]
; bank $A4: all $00 in the reference
DS $4000, $00
