; ROM bank $FB: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankfb.asm.

SECTION "Bank FB", ROMX[$4000], BANK[$FB]
; bank $FB: all $00 in the reference
DS $4000, $00
