; ROM bank $DB: empty (all bytes $00 or $FF)
; The annotated listing of this bank is build/listing/bankdb.asm.

SECTION "Bank DB", ROMX[$4000], BANK[$DB]
; bank $DB: all $00 in the reference
DS $4000, $00
