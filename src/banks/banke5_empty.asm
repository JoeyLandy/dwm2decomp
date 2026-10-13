; ROM bank $E5: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke5.asm.

SECTION "Bank E5", ROMX[$4000], BANK[$E5]
; bank $E5: all $00 in the reference
DS $4000, $00
