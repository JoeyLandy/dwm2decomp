; ROM bank $DF: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankdf.asm.

SECTION "Bank DF", ROMX[$4000], BANK[$DF]
; bank $DF: all $00 in the reference
DS $4000, $00
