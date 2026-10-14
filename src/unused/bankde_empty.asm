; ROM bank $DE: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankde.asm.

SECTION "Bank DE", ROMX[$4000], BANK[$DE]
; bank $DE: all $00 in the reference
DS $4000, $00
