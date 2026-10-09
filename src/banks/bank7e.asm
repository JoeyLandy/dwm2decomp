SECTION "Bank 7E", ROMX[$4000], BANK[$7E]
    db $7E

Data_07E_4001:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8001, $80

Data_07E_4081:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8081, $A9C

Data_07E_4B1D:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $1F, $00, $00, $08, $00, $00, $FF, $6B, $53, $05, $00, $08

Data_07E_4B2D:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $00, $70, $00, $08, $00, $00, $FF, $6B, $E0, $03, $00, $08
    db $00, $00, $FF, $6B, $B4, $5A, $00, $08

Data_07E_4B45:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $17, $60, $00, $08

Data_07E_4B4D:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8B4D, $58

Data_07E_4BA5:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $A0, $7D, $00, $00

Data_07E_4BAD:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $0A, $2E, $00, $00, $00, $00, $FF, $6B, $C5, $7E, $00, $08

Data_07E_4BBD:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8BBD, $50

Data_07E_4C0D:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C0D, $58

Data_07E_4C65:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C65, $48

Data_07E_4CAD:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8CAD, $48B

Data_07E_5138:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9138, $183

Data_07E_52BB:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F92BB, $83B

Data_07E_5AF6:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9AF6, $C2

Data_07E_5BB8:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $7D, $3D, $11, $20
    ds $1C92, $00

Data_07E_7850:: ; heuristic: argument of a bank-switching copy helper; C0
    ds $7B0, $00
