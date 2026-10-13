; ROM bank $BE: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankbe.asm.

SECTION "Bank BE", ROMX[$4000], BANK[$BE]
; bank $BE: all $00 in the reference
DS $4000, $00
