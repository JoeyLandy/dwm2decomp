SECTION "Bank 21", ROMX[$4000], BANK[$21]
    db $21

; compressed sprite graphics of monster id $05A (MadGopher) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 243 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadGopher:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084001, $F3

; compressed sprite graphics of monster id $05B (FairyRat) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 191 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FairyRat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_40F4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0840F4, $BF

; compressed sprite graphics of monster id $05C (Unicorn) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Unicorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_41B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0841B3, $E7

; compressed sprite graphics of monster id $05D (Goategon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 184 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Goategon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_429A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08429A, $B8

; compressed sprite graphics of monster id $05E (WildApe) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WildApe:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4352:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084352, $D5

; compressed sprite graphics of monster id $05F (Trumpeter) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 253 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Trumpeter:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4427:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084427, $FD

; compressed sprite graphics of monster id $060 (KingLeo) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 233 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_KingLeo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4524:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084524, $E9

; compressed sprite graphics of monster id $061 (DarkHorn) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DarkHorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_460D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08460D, $D7

; compressed sprite graphics of monster id $062 (MadCat) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 212 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadCat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_46E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0846E4, $D4

; compressed sprite graphics of monster id $063 (BigEye) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BigEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_47B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0847B8, $E2

; compressed sprite graphics of monster id $064 (Gorago) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gorago:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_489A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08489A, $F5

; compressed sprite graphics of monster id $065 (CatMage) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CatMage:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_498F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08498F, $DB

; compressed sprite graphics of monster id $066 (Dumbira) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Dumbira:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4A6A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084A6A, $EF

; compressed sprite graphics of monster id $06A (Picky) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 209 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Picky:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4B59:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084B59, $D1

; compressed sprite graphics of monster id $06B (Wyvern) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 188 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Wyvern:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4C2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084C2A, $BC

; compressed sprite graphics of monster id $06C (BullBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 248 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BullBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4CE6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084CE6, $F8

; compressed sprite graphics of monster id $06D (Florajay) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 242 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Florajay:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4DDE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084DDE, $F2

; compressed sprite graphics of monster id $06E (DuckKite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 130 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DuckKite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4ED0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084ED0, $82

; compressed sprite graphics of monster id $06F (MadPecker) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 237 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadPecker:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_4F52:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $084F52, $ED

; compressed sprite graphics of monster id $070 (MadRaven) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 186 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadRaven:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_503F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08503F, $BA

; compressed sprite graphics of monster id $071 (MistyWing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 115 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MistyWing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_50F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0850F9, $73

; compressed sprite graphics of monster id $072 (AquaHawk) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_AquaHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_516C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08516C, $DB

; compressed sprite graphics of monster id $073 (Dracky) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 193 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Dracky:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5247:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085247, $C1

; compressed sprite graphics of monster id $074 (KiteHawk) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 205 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_KiteHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5308:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085308, $CD

; compressed sprite graphics of monster id $075 (BigRoost) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BigRoost:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_53D5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0853D5, $DB

; compressed sprite graphics of monster id $076 (StubBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 205 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_StubBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_54B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0854B0, $CD

; compressed sprite graphics of monster id $077 (LandOwl) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 241 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LandOwl:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_557D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08557D, $F1

; compressed sprite graphics of monster id $078 (MadGoose) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadGoose:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_566E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08566E, $DC

; compressed sprite graphics of monster id $079 (MadCondor) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadCondor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_574A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08574A, $DC

; compressed sprite graphics of monster id $07A (Emyu) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 179 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Emyu:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5826:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085826, $B3

; compressed sprite graphics of monster id $07B (Blizzardy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 228 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Blizzardy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_58D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0858D9, $E4

; compressed sprite graphics of monster id $07C (Phoenix) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Phoenix:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_59BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0859BD, $E5

; compressed sprite graphics of monster id $07D (ZapBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 228 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ZapBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5AA2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085AA2, $E4

; compressed sprite graphics of monster id $07E (Garudian) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 200 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Garudian:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5B86:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085B86, $C8

; compressed sprite graphics of monster id $07F (WhipBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 243 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WhipBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5C4E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085C4E, $F3

; compressed sprite graphics of monster id $080 (FunkyBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FunkyBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5D41:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085D41, $E5

; compressed sprite graphics of monster id $081 (RainHawk) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 210 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RainHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5E26:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085E26, $D2

; compressed sprite graphics of monster id $082 (Azurile) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Azurile:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5EF8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085EF8, $D5

; compressed sprite graphics of monster id $083 (Shantak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Shantak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_5FCD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $085FCD, $D7

; compressed sprite graphics of monster id $084 (CragDevil) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 218 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CragDevil:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_60A4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0860A4, $DA

; compressed sprite graphics of monster id $08D (MadPlant) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadPlant:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_617E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08617E, $DC

; compressed sprite graphics of monster id $08E (FireWeed) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FireWeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_625A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08625A, $F7

; compressed sprite graphics of monster id $08F (FloraMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 169 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FloraMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6351:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086351, $A9

; compressed sprite graphics of monster id $090 (WingTree) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WingTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_63FA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0863FA, $E2

; compressed sprite graphics of monster id $091 (CactiBall) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CactiBall:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_64DC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0864DC, $E8

; compressed sprite graphics of monster id $092 (Gulpple) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 170 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gulpple:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_65C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0865C4, $AA

; compressed sprite graphics of monster id $093 (Toadstool) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 187 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Toadstool:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_666E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08666E, $BB

; compressed sprite graphics of monster id $094 (AmberWeed) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_AmberWeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6729:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086729, $F7

; compressed sprite graphics of monster id $095 (Slurperon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Slurperon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6820:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086820, $E2

; compressed sprite graphics of monster id $096 (Stubsuck) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Stubsuck:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6902:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086902, $E0

; compressed sprite graphics of monster id $097 (Oniono) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Oniono:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_69E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0869E2, $E5

; compressed sprite graphics of monster id $098 (DanceVegi) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DanceVegi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6AC7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086AC7, $E0

; compressed sprite graphics of monster id $099 (TreeBoy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 171 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_TreeBoy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6BA7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086BA7, $AB

; compressed sprite graphics of monster id $09A (Devipine) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 211 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Devipine:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6C52:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086C52, $D3

; compressed sprite graphics of monster id $09B (FaceTree) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 179 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FaceTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6D25:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086D25, $B3

; compressed sprite graphics of monster id $09C (HerbMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 192 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_HerbMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6DD8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086DD8, $C0

; compressed sprite graphics of monster id $09D (BeanMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 244 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BeanMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6E98:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086E98, $F4

; compressed sprite graphics of monster id $09E (EvilSeed) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 185 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilSeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_6F8C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $086F8C, $B9

; compressed sprite graphics of monster id $09F (ManEater) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 248 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ManEater:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7045:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087045, $F8

; compressed sprite graphics of monster id $0A0 (Snapper) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 171 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Snapper:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_713D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08713D, $AB

; compressed sprite graphics of monster id $0A1 (GhosTree) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 201 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GhosTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_71E8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0871E8, $C9

; compressed sprite graphics of monster id $0A2 (Rosevine) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Rosevine:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_72B1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0872B1, $DD

; compressed sprite graphics of monster id $0A3 (Egdracil) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Egdracil:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_738E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08738E, $E5

; compressed sprite graphics of monster id $0A4 (Warubou) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Warubou:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7473:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087473, $D5

; compressed sprite graphics of monster id $0A5 (Watabou) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; address loaded by DebugStaffRoll_Update_Sub01_Case02_DecompressToVRAM
; LZSS-compressed asset: 249 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Watabou:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_021_7548:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087548, $F9

; compressed sprite graphics of monster id $0A6 (Eggplaton) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 167 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Eggplaton:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7641:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087641, $A7

; compressed sprite graphics of monster id $0A7 (FooHero) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 228 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FooHero:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_76E8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0876E8, $E4

; compressed sprite graphics of monster id $0B0 (GiantSlug) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 230 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GiantSlug:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_77CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0877CC, $E6

; compressed sprite graphics of monster id $0B1 (Catapila) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 244 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Catapila:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_78B2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0878B2, $F4

; compressed sprite graphics of monster id $0B2 (Gophecada) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 187 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gophecada:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_79A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0879A6, $BB

; compressed sprite graphics of monster id $0B3 (Butterfly) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 187 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Butterfly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7A61:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087A61, $BB

; compressed sprite graphics of monster id $0B4 (WeedBug) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 160 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WeedBug:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7B1C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087B1C, $A0

; compressed sprite graphics of monster id $0B5 (GiantWorm) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 212 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GiantWorm:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7BBC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087BBC, $D4

; compressed sprite graphics of monster id $0B6 (Lipsy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 242 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Lipsy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7C90:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087C90, $F2

; compressed sprite graphics of monster id $0B7 (StagBug) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 214 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_StagBug:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_021_7D82:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $087D82, $D6
    ds $1A8, $00
