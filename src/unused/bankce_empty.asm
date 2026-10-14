; ROM bank $CE: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankce.asm.

SECTION "Bank CE", ROMX[$4000], BANK[$CE]
; bank $CE: all $00 in the reference
DS $4000, $00
