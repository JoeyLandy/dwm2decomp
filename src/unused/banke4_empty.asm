; ROM bank $E4: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banke4.asm.

SECTION "Bank E4", ROMX
; bank $E4: all $00 in the reference
DS $4000, $00
