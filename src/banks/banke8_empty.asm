; ROM bank $E8: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke8.asm.

SECTION "Bank E8", ROMX[$4000], BANK[$E8]
; bank $E8: all $00 in the reference
DS $4000, $00
