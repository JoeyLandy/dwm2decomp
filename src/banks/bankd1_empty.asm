; ROM bank $D1: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd1.asm.

SECTION "Bank D1", ROMX[$4000], BANK[$D1]
; bank $D1: all $00 in the reference
DS $4000, $00
