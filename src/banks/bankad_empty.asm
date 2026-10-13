; ROM bank $AD: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankad.asm.

SECTION "Bank AD", ROMX[$4000], BANK[$AD]
; bank $AD: all $00 in the reference
DS $4000, $00
