; ROM bank $A5: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banka5.asm.

SECTION "Bank A5", ROMX[$4000], BANK[$A5]
; bank $A5: all $00 in the reference
DS $4000, $00
