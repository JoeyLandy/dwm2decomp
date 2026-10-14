; ROM bank $9E: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bank9e.asm.

SECTION "Bank 9E", ROMX[$4000], BANK[$9E]
; bank $9E: all $00 in the reference
DS $4000, $00
