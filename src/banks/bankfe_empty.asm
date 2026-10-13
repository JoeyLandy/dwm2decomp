; ROM bank $FE: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankfe.asm.

SECTION "Bank FE", ROMX[$4000], BANK[$FE]
; bank $FE: all $00 in the reference
DS $4000, $00
