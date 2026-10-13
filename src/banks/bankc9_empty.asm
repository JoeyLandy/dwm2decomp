; ROM bank $C9: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc9.asm.

SECTION "Bank C9", ROMX[$4000], BANK[$C9]
; bank $C9: all $00 in the reference
DS $4000, $00
