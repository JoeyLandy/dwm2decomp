; ROM bank $EA: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankea.asm.

SECTION "Bank EA", ROMX[$4000], BANK[$EA]
; bank $EA: all $00 in the reference
DS $4000, $00
