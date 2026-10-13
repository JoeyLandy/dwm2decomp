; ROM bank $B7: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb7.asm.

SECTION "Bank B7", ROMX[$4000], BANK[$B7]
; bank $B7: all $00 in the reference
DS $4000, $00
