; ROM bank $D3: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankd3.asm.

SECTION "Bank D3", ROMX[$4000], BANK[$D3]
; bank $D3: all $00 in the reference
DS $4000, $00
