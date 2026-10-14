; ROM bank $D8: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd8.asm.

SECTION "Bank D8", ROMX[$4000], BANK[$D8]
; bank $D8: all $00 in the reference
DS $4000, $00
