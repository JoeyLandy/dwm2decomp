; ROM bank $CB: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankcb.asm.

SECTION "Bank CB", ROMX[$4000], BANK[$CB]
; bank $CB: all $00 in the reference
DS $4000, $00
