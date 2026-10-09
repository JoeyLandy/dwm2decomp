SECTION "Bank 7A", ROMX[$4000], BANK[$7A]
    db $7A

; no direct call (reached through a table, a jump or a vector)
Func_07A_4001:: ; heuristic: follows a terminator; C0
    ld b, b
    ld [bc], a
    ld [bc], a
    rst $38
    ld [bc], a
    rst $38
    rst $38
    ld c, l

Jump_07A_4009::
    ld [bc], a
    dec hl
    rrca
    jr Jump_07A_4009
    INCBIN "dwm2-cobi-us.gbc", $1E800E, $3F4A
    ds $A8, $00
