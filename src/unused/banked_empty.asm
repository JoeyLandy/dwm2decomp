; ROM bank $ED: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/banked.asm.

SECTION "Bank ED", ROMX[$4000], BANK[$ED]
; bank $ED: all $00 in the reference
DS $4000, $00
