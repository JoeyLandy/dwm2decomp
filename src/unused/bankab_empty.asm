; ROM bank $AB: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankab.asm.

SECTION "Bank AB", ROMX[$4000], BANK[$AB]
; bank $AB: all $00 in the reference
DS $4000, $00
