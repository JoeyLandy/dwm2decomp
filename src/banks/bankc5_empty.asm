; ROM bank $C5: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc5.asm.

SECTION "Bank C5", ROMX[$4000], BANK[$C5]
; bank $C5: all $00 in the reference
DS $4000, $00
