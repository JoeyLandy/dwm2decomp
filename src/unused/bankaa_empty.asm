; ROM bank $AA: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankaa.asm.

SECTION "Bank AA", ROMX[$4000], BANK[$AA]
; bank $AA: all $00 in the reference
DS $4000, $00
