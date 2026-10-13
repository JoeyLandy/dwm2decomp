; ROM bank $AE: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankae.asm.

SECTION "Bank AE", ROMX[$4000], BANK[$AE]
; bank $AE: all $00 in the reference
DS $4000, $00
