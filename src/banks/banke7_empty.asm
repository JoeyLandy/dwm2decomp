; ROM bank $E7: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke7.asm.

SECTION "Bank E7", ROMX[$4000], BANK[$E7]
; bank $E7: all $00 in the reference
DS $4000, $00
