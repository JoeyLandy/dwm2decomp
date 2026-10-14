; ROM bank $CA: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankca.asm.

SECTION "Bank CA", ROMX[$4000], BANK[$CA]
; bank $CA: all $00 in the reference
DS $4000, $00
