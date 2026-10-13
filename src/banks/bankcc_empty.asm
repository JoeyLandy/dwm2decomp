; ROM bank $CC: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankcc.asm.

SECTION "Bank CC", ROMX[$4000], BANK[$CC]
; bank $CC: all $00 in the reference
DS $4000, $00
