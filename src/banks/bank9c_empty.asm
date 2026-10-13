; ROM bank $9C: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bank9c.asm.

SECTION "Bank 9C", ROMX[$4000], BANK[$9C]
; bank $9C: all $00 in the reference
DS $4000, $00
