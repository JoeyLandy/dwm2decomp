; ROM bank $E9: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke9.asm.

SECTION "Bank E9", ROMX[$4000], BANK[$E9]
; bank $E9: all $00 in the reference
DS $4000, $00
