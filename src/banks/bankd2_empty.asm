; ROM bank $D2: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd2.asm.

SECTION "Bank D2", ROMX[$4000], BANK[$D2]
; bank $D2: all $00 in the reference
DS $4000, $00
