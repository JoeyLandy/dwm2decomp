; ROM bank $A4: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banka4.asm.

SECTION "Bank A4", ROMX
; bank $A4: all $00 in the reference
DS $4000, $00
