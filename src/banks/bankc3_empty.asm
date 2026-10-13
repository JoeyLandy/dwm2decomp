; ROM bank $C3: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc3.asm.

SECTION "Bank C3", ROMX[$4000], BANK[$C3]
; bank $C3: all $00 in the reference
DS $4000, $00
