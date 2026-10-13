; ROM bank $44: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bank44.asm.

SECTION "Bank 44", ROMX[$4000], BANK[$44]
; bank $44: all $00 in the reference
DS $4000, $00
