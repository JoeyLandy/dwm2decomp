; ROM bank $F4: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankf4.asm.

SECTION "Bank F4", ROMX[$4000], BANK[$F4]
; bank $F4: all $00 in the reference
DS $4000, $00
