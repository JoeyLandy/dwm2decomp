; ROM bank $B2: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb2.asm.

SECTION "Bank B2", ROMX[$4000], BANK[$B2]
; bank $B2: all $00 in the reference
DS $4000, $00
