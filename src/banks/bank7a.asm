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
    INCBIN "dwm2-cobi-us.gbc", $1E800E, $131

; LZSS-compressed asset: 487 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_413F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E813F, $1E7

; LZSS-compressed asset: 504 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_4326:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E8326, $1F8

; LZSS-compressed asset: 490 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_451E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E851E, $1EA

; LZSS-compressed asset: 456 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_4708:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E8708, $1C8

; LZSS-compressed asset: 400 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_48D0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E88D0, $190

; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_4A60:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E8A60, $1D6

; LZSS-compressed asset: 517 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_4C36:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E8C36, $205

; LZSS-compressed asset: 535 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_4E3B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E8E3B, $217

; LZSS-compressed asset: 493 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_5052:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E9052, $1ED

; LZSS-compressed asset: 538 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_523F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E923F, $21A

; LZSS-compressed asset: 278 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_5459:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E9459, $116

; LZSS-compressed asset: 240 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_556F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E956F, $F0

; LZSS-compressed asset: 432 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_565F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E965F, $1B0

; LZSS-compressed asset: 486 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_580F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E980F, $1E6

; LZSS-compressed asset: 526 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_59F5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E99F5, $20E

; LZSS-compressed asset: 431 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_5C03:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E9C03, $1AF

; LZSS-compressed asset: 536 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_5DB2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E9DB2, $218

; LZSS-compressed asset: 539 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_5FCA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1E9FCA, $21B

; LZSS-compressed asset: 425 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_61E5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EA1E5, $1A9

; LZSS-compressed asset: 497 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_638E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EA38E, $1F1

; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_657F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EA57F, $1D6

; LZSS-compressed asset: 558 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_6755:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EA755, $22E

; LZSS-compressed asset: 519 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_6983:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EA983, $207

; LZSS-compressed asset: 493 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_6B8A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EAB8A, $1ED

; LZSS-compressed asset: 386 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_6D77:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EAD77, $182

; LZSS-compressed asset: 561 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_6EF9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EAEF9, $231

; LZSS-compressed asset: 498 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_712A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EB12A, $1F2

; LZSS-compressed asset: 363 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_731C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EB31C, $16B

; LZSS-compressed asset: 560 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_7487:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EB487, $230

; LZSS-compressed asset: 425 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_76B7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EB6B7, $1A9

; LZSS-compressed asset: 431 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_7860:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EB860, $1AF

; LZSS-compressed asset: 309 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_7A0F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EBA0F, $135

; LZSS-compressed asset: 564 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_7B44:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EBB44, $234

; LZSS-compressed asset: 480 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07A_7D78:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1EBD78, $1E0
    ds $A8, $00
