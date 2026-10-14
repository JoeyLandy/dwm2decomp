; ROM bank $E6: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke6.asm.

SECTION "Bank E6", ROMX[$4000], BANK[$E6]
; bank $E6: all $00 in the reference
DS $4000, $00
