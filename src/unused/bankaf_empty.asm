; ROM bank $AF: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankaf.asm.

SECTION "Bank AF", ROMX[$4000], BANK[$AF]
; bank $AF: all $00 in the reference
DS $4000, $00
