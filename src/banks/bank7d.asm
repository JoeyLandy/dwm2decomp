SECTION "Bank 7D", ROMX[$4000], BANK[$7D]
    db $7D

; compressed sprite graphics number $00 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by DebugStaffRoll_Scene00_DecompressToVRAM, DebugStaffRoll_Scene01_DecompressToVRAM, DebugStaffRoll_Scene02_DecompressToVRAM, DebugStaffRoll_Scene03_DecompressToVRAM and 1 more
; LZSS-compressed asset: 249 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx00:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4001, $F9

; compressed sprite graphics number $01 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by DebugStaffRoll_Scene00_DecompressToVRAM, DebugStaffRoll_Scene01_DecompressToVRAM, DebugStaffRoll_Scene02_DecompressToVRAM, DebugStaffRoll_Scene03_DecompressToVRAM and 1 more
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx01:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_40FA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F40FA, $E7

; compressed sprite graphics number $02 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case06, DebugStaffRoll_Scene00_DecompressToVRAM, DebugStaffRoll_Scene01_DecompressToVRAM, DebugStaffRoll_Scene02_DecompressToVRAM and 2 more
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx02:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_41E1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F41E1, $DC

; compressed sprite graphics number $03 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by SceneMermaidKingdom_ShowKamehaIWasStupid, DebugStaffRoll_Scene02_DecompressToVRAM, DebugStaffRoll_Scene03_DecompressToVRAM, DebugStaffRoll_Scene04_DecompressToVRAM
; LZSS-compressed asset: 209 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx03:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_42BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F42BD, $D1

; compressed sprite graphics number $04 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 202 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx04:: ; heuristic: stream decompressed while the game ran on the emulator; C0
Data_07D_438E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F438E, $CA

; compressed sprite graphics number $05 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 198 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx05:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_4458:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4458, $C6

; compressed sprite graphics number $06 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 164 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx06:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_451E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F451E, $A4

; compressed sprite graphics number $07 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 186 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx07:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_45C2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F45C2, $BA

; compressed sprite graphics number $08 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 191 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx08:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_467C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F467C, $BF

; compressed sprite graphics number $09 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 188 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx09:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_473B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F473B, $BC

; compressed sprite graphics number $0A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 198 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_47F7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F47F7, $C6

; compressed sprite graphics number $0B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 215 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_48BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F48BD, $D7

; compressed sprite graphics number $0C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 235 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0C:: ; heuristic: stream decompressed while the game ran on the emulator; C0
Data_07D_4994:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4994, $EB

; compressed sprite graphics number $0D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 203 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_4A7F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4A7F, $CB

; compressed sprite graphics number $0E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by DebugStaffRoll_Scene03_DecompressToVRAM
; LZSS-compressed asset: 215 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_4B4A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4B4A, $D7

; compressed sprite graphics number $0F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by SceneShieldGuardian_ShowThatWasALovely
; LZSS-compressed asset: 225 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx0F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_4C21:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4C21, $E1

; compressed sprite graphics number $10 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 213 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx10:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_4D02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4D02, $D5

; compressed sprite graphics number $11 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 223 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx11:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_4DD7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4DD7, $DF

; compressed sprite graphics number $12 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by DebugStaffRoll_Scene03_DecompressToVRAM
; LZSS-compressed asset: 202 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx12:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_4EB6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4EB6, $CA

; compressed sprite graphics number $13 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 227 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx13:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_4F80:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F4F80, $E3

; compressed sprite graphics number $14 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 218 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx14:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5063:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5063, $DA

; compressed sprite graphics number $15 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 194 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx15:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_513D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F513D, $C2

; compressed sprite graphics number $16 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 211 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx16:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_51FF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F51FF, $D3

; compressed sprite graphics number $17 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 204 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx17:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_52D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F52D2, $CC

; compressed sprite graphics number $18 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 160 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx18:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_539E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F539E, $A0

; compressed sprite graphics number $19 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 175 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx19:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_543E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F543E, $AF

; compressed sprite graphics number $1A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 191 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_54ED:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F54ED, $BF

; compressed sprite graphics number $1B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 200 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_55AC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F55AC, $C8

; compressed sprite graphics number $1C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 205 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5674:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5674, $CD

; compressed sprite graphics number $1D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 206 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5741:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5741, $CE

; compressed sprite graphics number $1E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 218 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_580F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F580F, $DA

; compressed sprite graphics number $1F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 197 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx1F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_58E9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F58E9, $C5

; compressed sprite graphics number $20 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_59AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F59AE, $D7

; compressed sprite graphics number $21 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 218 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx21:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5A85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5A85, $DA

; compressed sprite graphics number $22 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by SceneRivalDefeated_StepObjectTowardCoord
; LZSS-compressed asset: 221 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx22:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_5B5F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5B5F, $DD

; compressed sprite graphics number $23 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 203 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx23:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5C3C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5C3C, $CB

; compressed sprite graphics number $24 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 208 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx24:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5D07:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5D07, $D0

; compressed sprite graphics number $25 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 204 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx25:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5DD7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5DD7, $CC

; compressed sprite graphics number $26 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 203 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx26:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_5EA3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5EA3, $CB

; compressed sprite graphics number $27 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by SceneRivalDefeated_DecompressToVRAM
; LZSS-compressed asset: 217 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx27:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_5F6E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F5F6E, $D9

; compressed sprite graphics number $28 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 225 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx28:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6047:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6047, $E1

; compressed sprite graphics number $29 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 217 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx29:: ; heuristic: stream decompressed while the game ran on the emulator; C0
Data_07D_6128:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6128, $D9

; compressed sprite graphics number $2A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 194 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6201:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6201, $C2

; compressed sprite graphics number $2B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 218 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_62C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F62C3, $DA

; compressed sprite graphics number $2C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_639D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F639D, $EC

; compressed sprite graphics number $2D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 199 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6489:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6489, $C7

; compressed sprite graphics number $2E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 206 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6550:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6550, $CE

; compressed sprite graphics number $2F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 208 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx2F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_661E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F661E, $D0

; compressed sprite graphics number $30 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 194 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx30:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_66EE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F66EE, $C2

; compressed sprite graphics number $31 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 164 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx31:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_67B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F67B0, $A4

; compressed sprite graphics number $32 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 180 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx32:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6854:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6854, $B4

; compressed sprite graphics number $33 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 191 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx33:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6908:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6908, $BF

; compressed sprite graphics number $34 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 212 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx34:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_69C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F69C7, $D4

; compressed sprite graphics number $35 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 192 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx35:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6A9B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6A9B, $C0

; compressed sprite graphics number $36 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 185 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx36:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6B5B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6B5B, $B9

; compressed sprite graphics number $37 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 192 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx37:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6C14:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6C14, $C0

; compressed sprite graphics number $38 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 207 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx38:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6CD4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6CD4, $CF

; compressed sprite graphics number $39 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 224 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx39:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6DA3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6DA3, $E0

; compressed sprite graphics number $3A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 222 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6E83:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6E83, $DE

; compressed sprite graphics number $3B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 184 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_6F61:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F6F61, $B8

; compressed sprite graphics number $3C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 171 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7019:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7019, $AB

; compressed sprite graphics number $3D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 212 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_70C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F70C4, $D4

; compressed sprite graphics number $3E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 182 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7198:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7198, $B6

; compressed sprite graphics number $3F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 187 bytes expand to 208 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx3F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_724E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F724E, $BB

; compressed sprite graphics number $40 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 229 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx40:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7309:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7309, $E5

; compressed sprite graphics number $41 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 202 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx41:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_73EE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F73EE, $CA

; compressed sprite graphics number $42 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 220 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_74B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F74B8, $DC

; compressed sprite graphics number $43 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 187 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx43:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7594:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7594, $BB

; compressed sprite graphics number $44 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 182 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx44:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_764F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F764F, $B6

; compressed sprite graphics number $45 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by SceneMermaidKingdom_SetBit2AtHL_B0F
; LZSS-compressed asset: 186 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx45:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_7705:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7705, $BA

; compressed sprite graphics number $46 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 61 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx46:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_77BF:: ; address name
    db $40, $00, $01, $1F, $1F, $7F, $77, $FF, $9A, $FF, $98, $7F, $7A, $FF, $DA, $DF
    db $B4, $FF, $D2, $1F, $1F, $E0, $FF, $DF, $60, $01, $14, $04, $CF, $F0, $FF, $F1
    db $FF, $90, $7F, $7C, $07, $06, $03, $03, $00, $01, $29, $00, $00, $C3, $FC, $C0
    db $FF, $C0, $7F, $C0, $EF, $C0, $EF, $40, $E6, $40, $E6, $40, $66

; compressed sprite graphics number $47 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 377 bytes expand to 432 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx47:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_77FC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F77FC, $179

; compressed sprite graphics number $48 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 351 bytes expand to 464 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx48:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7975:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7975, $15F

; compressed sprite graphics number $49 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; address loaded by RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F, SceneWarubouFood2_RunMessageBox
; LZSS-compressed asset: 185 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx49:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07D_7AD4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7AD4, $B9

; compressed sprite graphics number $4A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 67 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7B8D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7B8D, $43

; compressed sprite graphics number $4B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 180 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7BD0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7BD0, $B4

; compressed sprite graphics number $4C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 241 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7C84:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7C84, $F1

; compressed sprite graphics number $4D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 184 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7D75:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7D75, $B8

; compressed sprite graphics number $4E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 218 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7E2D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7E2D, $DA

; compressed sprite graphics number $4F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero)
; LZSS-compressed asset: 233 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx4F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07D_7F07:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F7F07, $E9
    ds $10, $00
