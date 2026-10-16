; ROM bank $C1: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc1.asm.

SECTION "Bank C1", ROMX
; bank $C1: all $00 in the reference
DS $4000, $00
