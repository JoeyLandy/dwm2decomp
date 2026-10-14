; ROM bank $C7: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc7.asm.

SECTION "Bank C7", ROMX[$4000], BANK[$C7]
; bank $C7: all $00 in the reference
DS $4000, $00
