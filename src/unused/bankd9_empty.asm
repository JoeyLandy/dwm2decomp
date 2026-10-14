; ROM bank $D9: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd9.asm.

SECTION "Bank D9", ROMX[$4000], BANK[$D9]
; bank $D9: all $00 in the reference
DS $4000, $00
