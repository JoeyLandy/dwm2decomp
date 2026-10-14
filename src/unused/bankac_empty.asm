; ROM bank $AC: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankac.asm.

SECTION "Bank AC", ROMX[$4000], BANK[$AC]
; bank $AC: all $00 in the reference
DS $4000, $00
