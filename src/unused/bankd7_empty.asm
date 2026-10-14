; ROM bank $D7: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd7.asm.

SECTION "Bank D7", ROMX[$4000], BANK[$D7]
; bank $D7: all $00 in the reference
DS $4000, $00
