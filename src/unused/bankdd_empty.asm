; ROM bank $DD: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankdd.asm.

SECTION "Bank DD", ROMX
; bank $DD: all $00 in the reference
DS $4000, $00
