; ROM bank $F5: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankf5.asm.

SECTION "Bank F5", ROMX[$4000], BANK[$F5]
; bank $F5: all $00 in the reference
DS $4000, $00
