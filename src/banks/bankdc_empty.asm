; ROM bank $DC: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankdc.asm.

SECTION "Bank DC", ROMX[$4000], BANK[$DC]
; bank $DC: all $00 in the reference
DS $4000, $00
