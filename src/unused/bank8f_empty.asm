; ROM bank $8F: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bank8f.asm.

SECTION "Bank 8F", ROMX[$4000], BANK[$8F]
; bank $8F: all $00 in the reference
DS $4000, $00
