; ROM bank $D0: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd0.asm.

SECTION "Bank D0", ROMX
; bank $D0: all $00 in the reference
DS $4000, $00
