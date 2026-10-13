; ROM bank $C0: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankc0.asm.

SECTION "Bank C0", ROMX[$4000], BANK[$C0]
; bank $C0: all $00 in the reference
DS $4000, $00
