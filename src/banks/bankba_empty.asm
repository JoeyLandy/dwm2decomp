; ROM bank $BA: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankba.asm.

SECTION "Bank BA", ROMX[$4000], BANK[$BA]
; bank $BA: all $00 in the reference
DS $4000, $00
