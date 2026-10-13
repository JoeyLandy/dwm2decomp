; ROM bank $E3: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke3.asm.

SECTION "Bank E3", ROMX[$4000], BANK[$E3]
; bank $E3: all $00 in the reference
DS $4000, $00
