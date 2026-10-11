SECTION "Bank 1F", ROMX[$4000], BANK[$1F]
    db $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; address loaded by GlyphCopyArgsForA, LoadSixteenGlyphTilesFromTable73BC
Data_01F_4010:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07C010, $D0

; address loaded by ScriptCommandE5_Run_Case01_Case03
Data_01F_40E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $F8, $FF, $84, $FF, $82, $FF, $82, $FF, $82, $FF, $84, $FF, $F8, $FF, $00
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $FE, $FF, $00
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00

; address loaded by ScriptCommandF6_Run_Case10_Case00
Data_01F_4110:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $3C, $FF, $42, $FF, $80, $FF, $9E, $FF, $82, $FF, $42, $FF, $3C, $FF, $00

; address loaded by LoadFourFrameTilesAndStep, ScriptCommandE8_Run_Case06_Case1D, ScriptCommandE8_Run_Case07_Case37, RunScreenStep_F0_5B50_Case08
Data_01F_4120:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $82, $FF, $FE, $FF, $82, $FF, $82, $FF, $82, $FF, $00

; address loaded by DebugMessageTest_Init, ScriptCommandEB_Run_Shared02, LoadThreeTilesAndDrawRows4603To460B
Data_01F_4130:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $7C, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $7C, $FF, $00
    db $FF, $7E, $FF, $08, $FF, $08, $FF, $08, $FF, $88, $FF, $88, $FF, $70, $FF, $00
    db $FF, $84, $FF, $88, $FF, $90, $FF, $B0, $FF, $C8, $FF, $84, $FF, $82, $FF, $00

; address loaded by DebugMessageTest_Init, DebugResultsDisplay_Init, ScriptCommandF6_Run_Case10_Case00
Data_01F_4160:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $FE, $FF, $00

; address loaded by DebugMessageTest_Init, ScriptCommandF6_Run_Case10_Case00, ScriptCommandF3_Run_Case03_Case00, ScriptCommandE8_Run_Case06_Case1D and 2 more
Data_01F_4170:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C6, $FF, $AA, $FF, $92, $FF, $82, $FF, $82, $FF, $82, $FF, $00

; address loaded by AcknowledgeTextPrompt_Sub01, DebugMessageTest_Init, ScriptCommandF2_Run_Case00, ScriptCommandF3_Run_Case03_Case00 and 7 more
Data_01F_4180:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00

; address loaded by DebugMessageTest_Init, LoadFourFrameTilesAndStep
Data_01F_4190:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $82, $FF, $44, $FF, $38, $FF, $00

; address loaded by ScriptCommandE8_Run_Case06_Case1D, ScriptCommandE8_Run_Case07_Case37, RunScreenStep_F0_5B50_Case08
Data_01F_41A0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $8A, $FF, $44, $FF, $3A, $FF, $00
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $88, $FF, $84, $FF, $82, $FF, $00

; address loaded by DebugMessageTest_Init, ScriptCommandF6_Run_Case10_Case00
Data_01F_41D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $78, $FF, $84, $FF, $80, $FF, $7C, $FF, $02, $FF, $82, $FF, $7C, $FF, $00
    db $FF, $FE, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $7C, $FF, $00
    db $FF, $82, $FF, $82, $FF, $44, $FF, $44, $FF, $28, $FF, $28, $FF, $10, $FF, $00

; address loaded by LoadFourFrameTilesAndStep
Data_01F_4210:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $92, $FF, $AA, $FF, $AA, $FF, $C6, $FF, $C6, $FF, $82, $FF, $00
    db $FF, $C6, $FF, $44, $FF, $28, $FF, $10, $FF, $28, $FF, $44, $FF, $C6, $FF, $00

; address loaded by ScriptCommandF4_Run_Case04_Case15, ScriptCommandEB_Run_Case05_Case10, RunNameEntryStateWhenNotFading_Case00_Case00, ScriptCommandEE_Run_Case02 and 5 more
Data_01F_4230:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $44, $FF, $28, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $FE, $FF, $04, $FF, $08, $FF, $10, $FF, $20, $FF, $40, $FF, $FE, $FF, $00

; address loaded by ScriptCommandF3_Run_Case03_Case00, DrawTileMap5E12AndLoadFrameTiles, RunScreenStep_F0_5DE8_Case00
Data_01F_4250:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $04, $FF, $7C, $FF, $84, $FF, $7E, $FF, $00

; address loaded by RunScreenStep_F0_5B50_Case08
Data_01F_4260:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $00
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $80, $FF, $84, $FF, $78, $FF, $00

; address loaded by ScriptCommandF3_Run_Case03_Case00
Data_01F_4280:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $04, $FF, $04, $FF, $04, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $00

; address loaded by ScriptCommandF4_Run_Case04_Case15, ScriptCommandEB_Run_Case05_Case10, RunNameEntryStateWhenNotFading_Case00_Case00, ScriptCommandEE_Run_Case02 and 5 more
Data_01F_4290:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $FC, $FF, $80, $FF, $7C, $FF, $00
    db $FF, $18, $FF, $24, $FF, $20, $FF, $FC, $FF, $20, $FF, $20, $FF, $20, $FF, $00
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $F8
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $00

; address loaded by ScriptCommandED_Run_Case07_Case08, ScriptCommandED_Run_Case07_Case1E, ScriptCommandE8_Run_Case09_Case1B_Case00, ScriptCommandE8_Run_Case08_Case1B and 1 more
Data_01F_42D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $60
    db $FF, $80, $FF, $80, $FF, $8C, $FF, $B0, $FF, $C0, $FF, $B0, $FF, $8C, $FF, $00

; address loaded by ScriptCommandF3_Run_Case03_Case00, LoadThreeTilesAndDrawRows4603To460B
Data_01F_4300:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00

; address loaded by LoadThreeTilesAndDrawRows4603To460B
Data_01F_4310:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $EC, $FF, $92, $FF, $92, $FF, $92, $FF, $92, $FF, $00

; address loaded by ScriptCommandEB_Run_Shared02
Data_01F_4320:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $84, $FF, $00

; address loaded by AcknowledgeTextPrompt_Sub01, PauseMenu_State3_Case06_Case01, LoadFourFrameTilesAndStep, ScriptCommandF2_Run_Case00 and 9 more
Data_01F_4330:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00

; address loaded by ScriptCommandE5_Run_Case01_Case03
Data_01F_4340:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $80, $FF, $80
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $04
    db $FF, $00, $FF, $00, $FF, $9C, $FF, $A0, $FF, $C0, $FF, $80, $FF, $80, $FF, $00

; address loaded by ScriptCommandF4_Run_Case04_Case15, RunNameEntryStateWhenNotFading_Case00_Case00, ScriptCommandEE_Run_Case02, ScriptCommandED_Run_Case04_Case3D and 5 more
Data_01F_4370:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C370, $50

; address loaded by ScriptCommandED_Run_Case07_Case08, ScriptCommandED_Run_Case07_Case1E, ScriptCommandE5_Run_Case01_Case03
Data_01F_43C0:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C3C0, $90

; address loaded by ScriptCommandF4_Run_Case04_Case0C, ScriptCommandF4_Run_Case11_Case01, Func_037_4AFD_Case04_Case0C, RunScreenStateWhenNotFading_F1_Case04_Case0C and 1 more
Data_01F_4450:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $02, $FF, $3E, $FF, $42, $FF, $42, $FF, $3E, $FF, $00
    db $FF, $00, $FF, $20, $FF, $A8, $FF, $72, $FF, $70, $FF, $A8, $FF, $22, $FF, $00
    db $FF, $70, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $70, $FF, $00

; address loaded by DebugResultsDisplay_Init
Data_01F_4480:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C480, $80

; address loaded by ScriptCommandE5_Run_Case03_Case12
Data_01F_4500:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; address loaded by ScriptCommandF4_Run_Case04_Case0C, ScriptCommandF4_Run_Case11_Case01, Func_037_4AFD_Case04_Case0C, RunScreenStateWhenNotFading_F1_Case04_Case0C and 1 more
Data_01F_4510:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C510, $270

; address loaded by DebugResultsDisplay_Init
Data_01F_4780:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C780, $160

; address loaded by RunNameEntryStateWhenNotFading_Case01_Case04, RunScreenStep_F0_5DE8_Case02, RunScreenStep_F0_5DE8_Case0B
Data_01F_48E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $05, $FF, $05, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; address loaded by DebugResultsDisplay_Init
Data_01F_48F0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $02, $FF, $05, $FF, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $30, $FF, $48, $FF, $48, $FF, $30

; address loaded by PauseMenu_State3_Case01_Case00, ScriptCommandF1_Run_Case01, RunNameEntryStateWhenNotFading_Case00_Case00, ScriptCommandE2_Run_Case03_Case03 and 2 more
Data_01F_4910:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C910, $80

; address loaded by ScriptCommandF6_Run_Case10_Case05, ScriptCommandF6_Run_Case10_Case06_Sub02, ScriptCommandEF_Run_Case05_Case11, ScriptCommandEF_Run_Case0F_Case05 and 9 more
Data_01F_4990:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C990, $B0

; address loaded by ScriptCommandF3_Run_Case03_Case00, ScriptCommandE8_Run_Case0D_Case03, Func_0F0_4CA0_Table4_Case00, RunScreenStep_F0_5DE8_Case03
Data_01F_4A40:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $18, $FF, $18, $FF, $00, $FF, $00, $FF, $18, $FF, $18, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $92, $FF, $00

; address loaded by Func_0F0_4CA0_Table4_Case00
Data_01F_4A60:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $80, $FF, $80, $FF, $80, $FF, $8A, $FF, $8A, $FF, $84, $FF, $F4

; address loaded by ScriptCommandE8_Run_Case06_Case03, ScriptCommandE8_Run_Case0E_Case00, DrawTileMap5E12AndLoadFrameTiles, RunScreenStep_F0_5DE8_Case00
Data_01F_4A70:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $E0, $FF, $80, $FF, $80, $FF, $EA, $FF, $84, $FF, $84, $FF, $EA

; address loaded by DebugResultsDisplay_Init, RunNameEntryStateWhenNotFading_Case00_Case00
Data_01F_4A80:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $1E, $FF, $06, $FF, $0A, $FF, $72, $FF, $90, $FF, $90, $FF, $60

; address loaded by DebugResultsDisplay_Init, RunNameEntryStateWhenNotFading_Case00_Case00
Data_01F_4A90:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $38, $FF, $44, $FF, $44, $FF, $38, $FF, $10, $FF, $7C, $FF, $10

; address loaded by ScriptCommandE8_Run_Case0D_Case05, RunScreenStep_F0_5DE8_Case05
Data_01F_4AA0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $38, $FF, $7C, $FF, $FE, $FF, $38, $FF, $38, $FF, $38
    db $FF, $00, $FF, $6C, $FF, $6C, $FF, $24, $FF, $48, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $60, $FF, $60, $FF, $20, $FF, $40

; address loaded by ScriptCommandF2_Run_Case00, RunScreenStateWhenNotFading_1B_Case00_Case00, ScriptCommandE8_Run_Case09_Case1D, DrawTileMap5E12AndLoadFrameTiles and 2 more
Data_01F_4AD0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6

; address loaded by ScriptCommandE8_Run_Case0D_Case05, RunScreenStep_F0_5DE8_Case05
Data_01F_4AE0:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07CAE0, $C0
    ds $470, $00
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; returns at once when wSGBActive is 0; otherwise sends the packet set chosen by wSGBPacketIndex ($FF = the buffer at wSGBPacketBuffer, else the pointer in the table at $5094): the packet count is the first byte's low 3 bits, each 16-byte packet is sent through rP1 as a $00/$30 reset pulse, 128 bits (a 1 bit is written as $10, a 0 bit as $20, each followed by $30) and a stop bit
; 25 call sites from 10 routines (e.g. BootAndMainLoop, DetectSGB, SGBTransferCompressed, SGBTransferRaw, ...)
; reads: wSGBActive, wSGBPacketIndex
; points at: wSGBPacketBuffer
SendSGBPacketSet::
Func_01F_5040:: ; address name
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wSGBPacketIndex]
    cp a, $FF
    jr nz, Jump_01F_5051
    ld hl, wSGBPacketBuffer
    jr Jump_01F_505E

Jump_01F_5051::
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_01F_5094
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

Jump_01F_505E::
    ld a, [hl]
    and a, $07
    ret z
    ld b, a
    ld c, $00

Jump_01F_5065::
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

Jump_01F_506E::
    ld e, $08
    ld a, [hl+]
    ld d, a

Jump_01F_5072::
    bit 0, d
    ld a, $10
    jr nz, Jump_01F_507A
    ld a, $20

Jump_01F_507A::
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, Jump_01F_5072
    dec b
    jr nz, Jump_01F_506E
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call SpinDelay
    jr Jump_01F_5065

; address loaded by SendSGBPacketSet
Data_01F_5094:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07D094, $17A

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case17)
BeginStringDisplay_Bank1F::
Func_01F_520E:: ; address name
    ld de, Data_01F_5223
    call BeginStringDisplay
    ret
    db $11, $23, $52, $CD, $FE, $25, $C9, $CD, $0E, $52, $CD, $11, $26, $C9

; address loaded by BeginStringDisplay_Bank1F
Data_01F_5223:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01F_5225

Data_01F_5225:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01F_52A5
    dw Data_01F_52A5
    dw Data_01F_52E3
    dw Data_01F_5303
    dw Data_01F_5327
    dw Data_01F_534B
    dw Data_01F_536D
    dw Data_01F_5394
    dw Data_01F_53B8
    dw Data_01F_53DA
    dw Data_01F_53F9
    dw Data_01F_5410
    dw Data_01F_5433
    dw Data_01F_5455
    dw Data_01F_5475
    dw Data_01F_5498
    dw Data_01F_54B5
    dw Data_01F_54D7
    dw Data_01F_54F7
    dw Data_01F_5519
    dw Data_01F_5540
    dw Data_01F_5540
    dw Data_01F_5561
    dw Data_01F_5582
    dw Data_01F_55A7
    dw Data_01F_55CA
    dw Data_01F_55ED
    dw Data_01F_5610
    dw Data_01F_5627
    dw Data_01F_5644
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5696
    dw Data_01F_56B6
    dw Data_01F_56DA
    dw Data_01F_56FD
    dw Data_01F_571F
    dw Data_01F_5740
    dw Data_01F_5764
    dw Data_01F_5786
    dw Data_01F_57A5
    dw Data_01F_57BC
    dw Data_01F_57DD
    dw Data_01F_57FF
    dw Data_01F_581F
    dw Data_01F_5842
    dw Data_01F_5864
    dw Data_01F_5886
    dw Data_01F_58A6
    dw Data_01F_58C8
    dw Data_01F_58EF
    dw Data_01F_58EF
    dw Data_01F_5910
    dw Data_01F_5931
    dw Data_01F_5956
    dw Data_01F_5979
    dw Data_01F_599C
    dw Data_01F_59BD
    dw Data_01F_59D4
    dw Data_01F_59F2
    dw Data_01F_5A3A
    dw Data_01F_5A3A

Data_01F_52A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is your", $F1
    db "adventure done?", $FA, $F7
    db $EF, $EE, "Or do you need", $EF, $EE, "something?", $F7
    db $F0

Data_01F_52E3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_5303:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_5327:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Check up on", $F1
    db "the others too.", $F7
    db $F0

Data_01F_534B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_536D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " No, you can't", $F1
    db "go off all alone.", $F7
    db $F0

Data_01F_5394:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_53B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_53DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_53F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_5410:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " The farm has", $F1
    db "no more room.", $F7
    db $F0

Data_01F_5433:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5455:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_5475:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5498:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It's eager", $F1
    db "to go, ", $F9, "0.", $F7
    db $F0

Data_01F_54B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_54D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_54F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_5519:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_5540:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5561:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5582:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_55A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_55CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_55ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It'll be gone", $F1
    db "forever. Sure?", $F0

Data_01F_5610:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "released.", $F7
    db $F0

Data_01F_5627:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F0

Data_01F_5644:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Come back", $F1
    db "anytime, sis!", $F7
    db $F0

Data_01F_5664:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hi, big", $F1
    db "brother!", $FA, $F7
    db $EF, $EE, "Do you need", $EF, $EE, "anything?", $F0

Data_01F_5696:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_56B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_56DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Say bye to", $F1
    db $F9, "0 for a while.", $F7
    db $F0

Data_01F_56FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_571F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You'll be", $F1
    db "left all alone!", $F7
    db $F0

Data_01F_5740:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_5764:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5786:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_57A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_57BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " The farm is", $F1
    db "out of room.", $F7
    db $F0

Data_01F_57DD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_57FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_581F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5842:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, it", $F1
    db "really missed you.", $F7
    db $F0

Data_01F_5864:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_5886:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_58A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_58C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_58EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5910:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5931:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_5956:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_5979:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_599C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " It'll be gone", $F1
    db "forever. OK?", $F0

Data_01F_59BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "released.", $F7
    db $F0

Data_01F_59D4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F7
    db $F0

Data_01F_59F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Please tell", $F1
    db "me about your", $FA, $F7
    db $EF, $EE, "adventure next", $EF, $EE, "time, big brother!", $F7
    db $F0

Data_01F_5A3A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $07DA3A, $1DB

; for the visible entries of record-list page wD7AF draws each record name at Data_01F_5C9C[n] (the fifth through the mark-overlay drawer) (E-0128)
; 8 call sites from 8 routines (e.g. ScriptCommandEB_Run_Case05_Case20, ScriptCommandED_Run_Case04_Case03, ScriptCommandED_Run_Case07_Case0E, ScriptCommandED_Run_Case12_Case06, ...)
; reads: wListPageIndex, wListLastRow, wListCount, wScreenStep, wListPages
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep
; points at: wListEntries
DrawRecordListPageNames::
Func_01F_5C15:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    ld b, a
    add a, a
    add a, a
    add a, b
    add_a_to_hl
    ld c, $00

Jump_01F_5C2F::
    ld a, [wListLastRow]
    cp a, $04
    jr c, Jump_01F_5C3B
    ld a, [wListCount]
    jr Jump_01F_5C4A

Jump_01F_5C3B::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_01F_5C47
    ld a, [wListCount]
    jr Jump_01F_5C4A

Jump_01F_5C47::
    ld a, [wListCount]

Jump_01F_5C4A::
    ld b, a
    ld a, [wListPageIndex]
    push bc
    ld c, a
    add a, a
    add a, a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, Jump_01F_5C90
    push hl
    push bc
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_01F_5C71
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F
    jr Jump_01F_5C81

Jump_01F_5C71::
    ld a, c
    add a, a
    ld hl, Data_01F_5C9C
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM

Jump_01F_5C81::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_01F_5C90
    ld a, c
    cp a, $05
    jr c, Jump_01F_5C2F

Jump_01F_5C90::
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by DrawRecordListPageNames
Data_01F_5C9C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; draws the $F0-terminated text at wC8CF glyph by glyph; marks $8D and $8E are ORed onto the previous tile (E-0125)
; 1 call site from 1 routine (e.g. DrawRecordListPageNames)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F::
Func_01F_5CA6:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

Jump_01F_5CB0::
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01F_5CEF
    cp a, $8D
    jr z, Jump_01F_5CCF
    cp a, $8E
    jr z, Jump_01F_5CCF
    call GlyphCopyArgsForA
    call CopyFromBankWaitVRAM
    jr Jump_01F_5CDE

Jump_01F_5CCF::
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    call GlyphCopyArgsForA
    call OrFromBankWaitVRAM

Jump_01F_5CDE::
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr Jump_01F_5CB0

Jump_01F_5CEF::
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DE = Data_01F_4010 + 16 * A (the glyph's tile), HL = the VRAM address from Data_01F_5D20 + 2 * wD785, B = $1F (bank), C = 16 (bytes) (E-0120)
; 2 call sites from 1 routine (e.g. DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1F)
; reads: wGlyphListStart
GlyphCopyArgsForA::
Func_01F_5CF8:: ; address name
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, Data_01F_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, Data_01F_5D20
    ld a, [wGlyphListStart]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

; address loaded by GlyphCopyArgsForA
Data_01F_5D20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; parameters wD7F1/wD7F2 = source (high, low), wD7F3 = width, wD7F4 = rows, wD7F5/wD7F6 = BG map destination (high, low): copies each row of tiles to the BG map with interrupts off after rSTAT bit 1 clears, wrapping columns inside the 32-entry row; on CGB, when wD7F7 is 0, also zero-fills the same entries in VRAM bank 1 (attributes); the row loop is not read to its end (E-0093)
; 25 call sites from 18 routines (e.g. DrawWCA36MonsterPictureInTwoSteps, DrawRects662BAnd653F, DrawRects6B4FAnd6C27, ClearTilesAndDrawRects6C5FAnd6D37, ...)
; reads: wArg6, rSTAT, wIsCGB, wArg7
; writes: rVBK
; points at: wArg1
DrawTileRectFromArg1Params::
Func_01F_5D2A:: ; address name
    ld hl, wArg1
    ld d, [hl]
    inc hl
    ld e, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld a, [wArg6]
    ld l, a

Jump_01F_5D3B::
    push hl
    push bc

Jump_01F_5D3D::
    di

Jump_01F_5D3E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D3E
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D54
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D54::
    inc de
    dec b
    jr nz, Jump_01F_5D3D
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5D89
    ld a, [wArg7]
    and a, a
    jr nz, Jump_01F_5D89
    ld a, $01
    ldh [rVBK], a

Jump_01F_5D6C::
    di

Jump_01F_5D6D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D6D
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D83
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D83::
    dec b
    jr nz, Jump_01F_5D6C
    xor a, a
    ldh [rVBK], a

Jump_01F_5D89::
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec c
    jr nz, Jump_01F_5D3B
    ret

; writes a wD7F3 x wD7F4 tile rectangle from wD7F1/2 to the BG map at wD7F5/6 (wrapping); on CGB, unless wD7F7 is set, clears its attributes (E-0129)
; 10 call sites from 10 routines (e.g. DrawTileMap5E12AndLoadFrameTiles, ScriptCommandF6_Run_Shared06, RunNameEntryStateWhenNotFading_Case00_Case00, RunNameEntryStateWhenNotFading_Case06_Case00, ...)
; reads: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, rSTAT, wIsCGB, ...
; writes: rVBK
DrawTileRectAndClearAttrs_5D9A::
Func_01F_5D9A:: ; address name
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    ld a, [wArg3]
    ld b, a
    ld a, [wArg4]
    ld c, a
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a

Jump_01F_5DB2::
    push hl
    push bc

Jump_01F_5DB4::
    di

Jump_01F_5DB5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DB5
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DCB
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DCB::
    dec b
    jr nz, Jump_01F_5DB4
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5DFF
    ld a, [wArg7]
    and a, a
    jr nz, Jump_01F_5DFF
    ld a, $01
    ldh [rVBK], a

Jump_01F_5DE2::
    di

Jump_01F_5DE3::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DE3
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DF9
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DF9::
    dec b
    jr nz, Jump_01F_5DE2
    xor a, a
    ldh [rVBK], a

Jump_01F_5DFF::
    pop bc
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec c
    ld a, c
    and a, a
    jr nz, Jump_01F_5DB2
    ret

; address loaded by DrawTileMap5E12AndLoadFrameTiles
Data_01F_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3

; address loaded by DrawRects5E13And66DF
Data_01F_5E13:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07DE13, $69C

; address loaded by DrawWCA36MonsterPictureInTwoSteps
Data_01F_64AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E4AF, $6C

; address loaded by DrawWCA36MonsterPictureInTwoSteps
Data_01F_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $C3

; address loaded by DrawRects662BAnd653F
Data_01F_653F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3
    INCBIN "dwm2-cobi-us.gbc", $07E577, $B4

; address loaded by DrawRects662BAnd653F
Data_01F_662B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E62B, $B4

; address loaded by DrawRects5E13And66DF
Data_01F_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E6DF, $470

; address loaded by DrawRects6B4FAnd6C27
Data_01F_6B4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07EB4F, $D8

; address loaded by DrawRects6B4FAnd6C27
Data_01F_6C27:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3

; address loaded by ClearTilesAndDrawRects6C5FAnd6D37
Data_01F_6C5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07EC5F, $D8

; address loaded by ClearTilesAndDrawRects6C5FAnd6D37
Data_01F_6D37:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3

; address loaded by DrawSummaryFrames6E47And6D6F
Data_01F_6D6F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07ED6F, $D8

; address loaded by DrawSummaryFrames6E47And6D6F
Data_01F_6E47:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $7C, $C3, $C3, $C3
    db $C3, $C3, $C3, $6E, $7E, $C3, $C3, $C3, $C3, $C3, $C3, $6F, $7E, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $7D
    ds $1B, $C3
    INCBIN "dwm2-cobi-us.gbc", $07EE87, $1B1
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $06, $35, $3B, $28, $39, $C3, $13, $24, $30, $28
    db $C3, $C3, $C3, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $C3
    db $0F, $10, $11, $12, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $C3
    db $20, $21, $22, $23, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $C3
    db $31, $32, $33, $34, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $C3
    db $42, $43, $44, $45, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $46, $47, $48, $49, $4A, $4B, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $06, $13, $05, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69
    db $6A, $6B, $6C, $6D, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $6E, $6F, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B
    db $7C, $7D, $7E, $7F, $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69
    db $6A, $6B, $6C, $6D, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $07F1EE, $187

; copies 16 glyph tiles (Data_01F_73BC) from bank $1F to the VRAM addresses in Data_01F_73CC (E-0127)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case01, RunScreenStateWhenNotFading_F1_Case0D_Case01)
LoadSixteenGlyphTilesFromTable73BC::
Func_01F_7375:: ; address name
    ld c, $00

Jump_01F_7377::
    push bc
    ld a, c
    ld de, Data_01F_73BC
    add a, e
    ld e, a
    jr nc, Jump_01F_7381
    inc d

Jump_01F_7381::
    ld a, [de]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, Data_01F_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    sla a
    ld de, Data_01F_73CC
    add a, e
    ld e, a
    jr nc, Jump_01F_73A7
    inc d

Jump_01F_73A7::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_01F_7377
    ret

; address loaded by LoadSixteenGlyphTilesFromTable73BC
Data_01F_73BC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

; address loaded by LoadSixteenGlyphTilesFromTable73BC
Data_01F_73CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; first call: draws the 6 x 6 frame Data_01F_651B and loads the picture of species wCA36 at vTiles2 + $200; second call: loads its CGB attributes and draws the picture (E-0128)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case05, RunScreenStateWhenNotFading_F1_Case0D_Case05)
; reads: wScreenSubStep, wRecordBufB, wIsCGB, wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenSubStep, ...
DrawWCA36MonsterPictureInTwoSteps::
Func_01F_73EC:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_01F_7436
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_651B
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld a, [wRecordBufB + $B]
    ld e, a
    ld a, [wRecordBufB + $C]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01F_7436::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_745C
    ld a, [wRecordBufB + $B]
    ld e, a
    ld a, [wRecordBufB + $C]
    ld d, a
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_01F_745C::
    call BGMapAddressAtScroll_Bank1F
    ld de, $0161
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_64AF
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws the 32 x 32 tile map Data_01F_5E12 at the scroll origin, then copies three tiles from bank $1F to vTiles1 + $7E0, + $7F0 and vTiles2 + $6F0 (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case00, RunScreenStateWhenNotFading_F1_Case0D_Case00)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawTileMap5E12AndLoadFrameTiles::
Func_01F_7494:: ; address name
    call BGMapAddressAtScroll_Bank1F
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_5E12
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAndClearAttrs_5D9A
    ld de, Data_01F_4250
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; draws the tile rectangles Data_01F_662B (12 x 15 at scroll + $68) and Data_01F_653F (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case15, RunScreenStateWhenNotFading_F1_Case0D_Case15)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects662BAnd653F::
Func_01F_74E3:: ; address name
    call BGMapAddressAtScroll_Bank1F
    ld de, $0068
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_662B
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_653F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; draws the tile rectangles Data_01F_6B4F (12 x 18 at scroll + 8) and Data_01F_6C27 (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case17, RunScreenStateWhenNotFading_F1_Case0D_Case17)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects6B4FAnd6C27::
Func_01F_753A:: ; address name
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6B4F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6C27
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; clears 21 x 4 tiles at vTiles2 + $200 and draws the tile rectangles Data_01F_6C5F (12 x 18) and Data_01F_6D37 (8 x 7) (E-0127)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case18, RunScreenStateWhenNotFading_F1_Case0D_Case18)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wArg5, wArg6, wArg1, wArg2, ...
ClearTilesAndDrawRects6C5FAnd6D37::
Func_01F_7591:: ; address name
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6C5F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6D37
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; shows the eight skill names of the record at wCA2B (field $34) in rows from vTiles2 + $200, or string $0E of category 8 when it has none (E-0129)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case19, RunScreenStateWhenNotFading_F1_Case0D_Case19)
; reads: wRecordBufB
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
; points at: wRecordBufB
ShowRecordBufBSkillNamesOrNone::
Func_01F_7601:: ; address name
    ld a, [wRecordBufB + $34]
    cp a, $FF
    jr z, Jump_01F_760D
    and a, a
    jr z, Jump_01F_760D
    jr Jump_01F_764E

Jump_01F_760D::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0E
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr Jump_01F_769E

Jump_01F_764E::
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08

Jump_01F_7655::
    push bc
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, wRecordBufB
    ld a, c
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_01F_767D
    cp a, $FF
    jr z, Jump_01F_767D
    jr Jump_01F_7682

Jump_01F_767D::
    call FillTilesFromRequest
    jr Jump_01F_7690

Jump_01F_7682::
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08

Jump_01F_7690::
    pop hl
    ld a, l
    add a, $90
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    inc c
    dec b
    jr nz, Jump_01F_7655

Jump_01F_769E::
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; draws the tile rectangles Data_01F_6E47 and Data_01F_6D6F, clears tile rows and sets up the summary text window (E-0128)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1B, RunScreenStateWhenNotFading_F1_Case0D_Case1B)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wTextWindowTileLo, ...
DrawSummaryFrames6E47And6D6F::
Func_01F_76B5:: ; address name
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6E47
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld hl, vTiles2 + $6C0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_6D6F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0805
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; draws the tile rectangles Data_01F_5E13 (12 x 3 at scroll + 8) and Data_01F_66DF (8 x 7 at scroll + $160) (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1C, RunScreenStateWhenNotFading_F1_Case0D_Case1C)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
DrawRects5E13And66DF::
Func_01F_7754:: ; address name
    call BGMapAddressAtScroll_Bank1F
    ld de, $0008
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_5E13
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $0C
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank1F
    ld de, $0160
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_66DF
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectFromArg1Params
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 14 call sites from 7 routines (e.g. DrawTileMap5E12AndLoadFrameTiles, DrawWCA36MonsterPictureInTwoSteps, DrawRects662BAnd653F, DrawRects6B4FAnd6C27, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1F::
Func_01F_77AB:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_01F_77CF
    inc d

Jump_01F_77CF::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_77D4:: ; heuristic: event script entry or jump target; C0
    script_command $F8
Script_1F_77D5:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_77F4, Script_1F_77EE
    db $0E, $07, $00, $EE, $00, $05, $80, $EE, $FF, $00, $03, $C0, $07, $F7, $77, $00
    db $02, $C0, $07, $F7, $77

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_77EE:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'In the middle of the sea'
    script_jump Script_1F_77F7
Script_1F_77F4:: ; heuristic: event script entry or jump target; C0
    script_jump Script_1F_77FD
Script_1F_77F7:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_jump Script_1F_77D5
Script_1F_77FD:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_780E, Script_1F_7808
    db $00, $00, $08, $C0, $07, $11, $78

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_7808:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'There's a spirit in GreatLog that's'
    script_jump Script_1F_7811
Script_1F_780E:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'You folks run a monster farm?'
Script_1F_7811:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7819, Script_1F_7815
Script_1F_7815:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_jump Script_1F_77F7
Script_1F_7819:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7831, Script_1F_782B
    db $07, $00, $00, $0B, $C0, $07, $FD, $77, $00, $0A, $C0, $07, $FD, $77

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_782B:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Good. That's good to hear! You'
    script_jump Script_1F_77FD
Script_1F_7831:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_message $C00C ; 'GreatLog's King asked us to settle'
    script_command $F8
    script_choice_jump Script_1F_7845, Script_1F_783E
    db $00, $F8, $07, $FD, $77

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_783E:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'Tara Big brother! GreatLog will be'
    script_command $F8
    script_jump Script_1F_77F7
Script_1F_7845:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7856, Script_1F_7850
    db $00, $00, $0F, $C0, $07, $59, $78

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_7850:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'When our farm gets established in'
    script_jump Script_1F_7859
Script_1F_7856:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'GreatLog's King asked us to settle'
Script_1F_7859:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_786A, Script_1F_7864
    db $00, $00, $12, $C0, $07, $6D, $78

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_1F_7864:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '0 peered into the vase. Freshly'
    script_jump Script_1F_786D
Script_1F_786A:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '0 peered into the barrel. It'
Script_1F_786D:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_choice_jump Script_1F_7877, Script_1F_7871
Script_1F_7871:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8013 ; 'Land ho! There's GreatLog!'
    script_command $EE
    script_end
Script_1F_7877:: ; heuristic: event script entry or jump target; C0
    script_command $F8
    script_jump Script_1F_77F7
    db $F6, $F6, $E4, $11, $07, $00, $F6, $00, $02, $80, $F6, $FF, $00, $05, $C0, $00
    db $04, $C0, $07, $7C, $78, $00, $03, $C0, $F6, $E4, $09, $00, $F6, $00, $04, $C0
    db $F6, $07, $7C, $78, $F6, $00, $03, $C0, $F6, $07, $93, $78
    ds $759, $00
