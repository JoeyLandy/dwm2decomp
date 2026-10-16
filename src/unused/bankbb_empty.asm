; ROM bank $BB: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankbb.asm.

SECTION "Bank BB", ROMX
; bank $BB: all $00 in the reference
DS $4000, $00
