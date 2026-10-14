; ROM bank $B3: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankb3.asm.

SECTION "Bank B3", ROMX[$4000], BANK[$B3]
; bank $B3: all $00 in the reference
DS $4000, $00
