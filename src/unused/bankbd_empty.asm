; ROM bank $BD: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankbd.asm.

SECTION "Bank BD", ROMX[$4000], BANK[$BD]
; bank $BD: all $00 in the reference
DS $4000, $00
