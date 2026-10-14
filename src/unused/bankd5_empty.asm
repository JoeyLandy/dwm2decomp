; ROM bank $D5: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd5.asm.

SECTION "Bank D5", ROMX[$4000], BANK[$D5]
; bank $D5: all $00 in the reference
DS $4000, $00
