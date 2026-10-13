; ROM bank $9F: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bank9f.asm.

SECTION "Bank 9F", ROMX[$4000], BANK[$9F]
; bank $9F: all $00 in the reference
DS $4000, $00
