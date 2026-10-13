; ROM bank $FF: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankff.asm.

SECTION "Bank FF", ROMX[$4000], BANK[$FF]
; bank $FF: all $00 in the reference
DS $4000, $00
