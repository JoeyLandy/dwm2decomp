SECTION "Bank 23", ROMX[$4000], BANK[$23]
    db $23

; compressed sprite graphics of monster id $109 (BoneSlave) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BoneSlave:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C001, $F7

; compressed sprite graphics of monster id $10A (Skeletor) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 210 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Skeletor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_40F8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C0F8, $D2

; compressed sprite graphics of monster id $10B (Servant) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 256 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Servant:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_41CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C1CA, $100

; compressed sprite graphics of monster id $10C (Lazamanus) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 216 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Lazamanus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_42CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C2CA, $D8

; compressed sprite graphics of monster id $10D (Copycat) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 253 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Copycat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_43A2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C3A2, $FD

; compressed sprite graphics of monster id $10E (MadSpirit) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadSpirit:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_449F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C49F, $E2

; compressed sprite graphics of monster id $10F (PomPomBom) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 207 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PomBom:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4581:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C581, $CF

; compressed sprite graphics of monster id $110 (Niterich) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Niterich:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4650:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C650, $F5

; compressed sprite graphics of monster id $119 (JewelBag) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 244 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_JewelBag:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4745:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C745, $F4

; compressed sprite graphics of monster id $11A (EvilWand) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 197 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilWand:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4839:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C839, $C5

; compressed sprite graphics of monster id $11B (MadCandle) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 218 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadCandle:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_48FE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C8FE, $DA

; compressed sprite graphics of monster id $11C (CoilBird) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 192 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CoilBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_49D8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08C9D8, $C0

; compressed sprite graphics of monster id $11D (Facer) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 180 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Facer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4A98:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CA98, $B4

; compressed sprite graphics of monster id $11E (SpikyBoy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 210 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SpikyBoy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4B4C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CB4C, $D2

; compressed sprite graphics of monster id $11F (MadMirror) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 203 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadMirror:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4C1E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CC1E, $CB

; compressed sprite graphics of monster id $120 (RogueNite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RogueNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4CE9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CCE9, $DB

; compressed sprite graphics of monster id $121 (Puppetor) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 177 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Puppetor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4DC4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CDC4, $B1

; compressed sprite graphics of monster id $122 (Goopi) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Goopi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4E75:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CE75, $E0

; compressed sprite graphics of monster id $123 (Voodoll) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 144 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Voodoll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4F55:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CF55, $90

; compressed sprite graphics of monster id $124 (MetalDrak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MetalDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_4FE5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08CFE5, $DE

; compressed sprite graphics of monster id $125 (Balzak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 240 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Balzak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_50C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D0C3, $F0

; compressed sprite graphics of monster id $126 (SabreMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 202 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SabreMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_51B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D1B3, $CA

; compressed sprite graphics of monster id $127 (CurseLamp) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 144 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CurseLamp:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_527D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D27D, $90

; compressed sprite graphics of monster id $128 (Brushead) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 243 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Brushead:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_530D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D30D, $F3

; compressed sprite graphics of monster id $129 (Roboster) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 203 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Roboster:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5400:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D400, $CB

; compressed sprite graphics of monster id $12A (Roboster2) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 183 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Roboster2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_54CB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D4CB, $B7

; compressed sprite graphics of monster id $12B (EvilPot) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 141 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilPot:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5582:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D582, $8D

; compressed sprite graphics of monster id $12C (Gismo) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 202 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gismo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_560F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D60F, $CA

; compressed sprite graphics of monster id $12D (LavaMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 204 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LavaMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_56D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D6D9, $CC

; compressed sprite graphics of monster id $12E (IceMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 204 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_IceMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_57A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D7A5, $CC

; compressed sprite graphics of monster id $12F (Mimic) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 199 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mimic:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5871:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D871, $C7

; compressed sprite graphics of monster id $130 (Exaucers) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 242 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Exaucers:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5938:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08D938, $F2

; compressed sprite graphics of monster id $131 (MudDoll) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MudDoll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5A2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DA2A, $E3

; compressed sprite graphics of monster id $132 (Golem) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Golem:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5B0D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DB0D, $EC

; compressed sprite graphics of monster id $133 (StoneMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 259 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_StoneMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5BF9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DBF9, $103

; compressed sprite graphics of monster id $134 (BombCrag) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 134 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BombCrag:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5CFC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DCFC, $86

; compressed sprite graphics of monster id $135 (GoldGolem) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GoldGolem:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5D82:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DD82, $F7

; compressed sprite graphics of monster id $136 (DarkMate) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 133 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DarkMate:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5E79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DE79, $85

; compressed sprite graphics of monster id $137 (ProtoMech) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ProtoMech:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5EFE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DEFE, $DD

; compressed sprite graphics of monster id $138 (CloudKing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 211 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CloudKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_5FDB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08DFDB, $D3

; compressed sprite graphics of monster id $13C (Petiteel) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 225 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Petiteel:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_60AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E0AE, $E1

; compressed sprite graphics of monster id $13D (Moray) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 223 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Moray:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_618F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E18F, $DF

; compressed sprite graphics of monster id $13E (WalrusMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WalrusMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_626E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E26E, $E0

; compressed sprite graphics of monster id $13F (RayGigas) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RayGigas:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_634E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E34E, $EF

; compressed sprite graphics of monster id $140 (Anemon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 194 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Anemon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_643D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E43D, $C2

; compressed sprite graphics of monster id $141 (Aquarella) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 190 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Aquarella:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_64FF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E4FF, $BE

; compressed sprite graphics of monster id $142 (Merman) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 217 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Merman:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_65BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E5BD, $D9

; compressed sprite graphics of monster id $143 (Octokid) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 151 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Octokid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6696:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E696, $97

; compressed sprite graphics of monster id $144 (PutreFish) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 233 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PutreFish:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_672D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E72D, $E9

; compressed sprite graphics of monster id $145 (Octoreach) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 133 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Octoreach:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6816:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E816, $85

; compressed sprite graphics of monster id $146 (Angleron) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 207 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Angleron:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_689B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E89B, $CF

; compressed sprite graphics of monster id $147 (FishRider) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 253 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FishRider:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_696A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08E96A, $FD

; compressed sprite graphics of monster id $148 (RushFish) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RushFish:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6A67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EA67, $DC

; compressed sprite graphics of monster id $149 (Gamanian) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gamanian:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6B43:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EB43, $DD

; compressed sprite graphics of monster id $14A (Clawster) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 234 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Clawster:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6C20:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EC20, $EA

; compressed sprite graphics of monster id $14B (CancerMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CancerMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6D0A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08ED0A, $D7

; compressed sprite graphics of monster id $14C (RogueWave) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 251 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RogueWave:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6DE1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EDE1, $FB

; compressed sprite graphics of monster id $14D (Scallopa) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 204 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Scallopa:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6EDC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EEDC, $CC

; compressed sprite graphics of monster id $14E (SeaHorse) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 218 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SeaHorse:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_6FA8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08EFA8, $DA

; compressed sprite graphics of monster id $14F (HoodSquid) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_HoodSquid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7082:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F082, $F7

; compressed sprite graphics of monster id $150 (MerTiger) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 230 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MerTiger:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7179:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F179, $E6

; compressed sprite graphics of monster id $151 (AxeShark) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 191 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_AxeShark:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_725F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F25F, $BF

; compressed sprite graphics of monster id $152 (Octogon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Octogon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_731E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F31E, $E8

; compressed sprite graphics of monster id $153 (KingSquid) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_KingSquid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7406:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F406, $E3

; compressed sprite graphics of monster id $154 (Digong) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Digong:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_74E9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F4E9, $F5

; compressed sprite graphics of monster id $155 (WhaleMage) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 157 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WhaleMage:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_75DE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F5DE, $9D

; compressed sprite graphics of monster id $156 (Aquadon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Aquadon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_767B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F67B, $DC

; compressed sprite graphics of monster id $157 (Octoraid) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Octoraid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7757:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F757, $DE

; compressed sprite graphics of monster id $158 (Grakos) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 240 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Grakos:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7835:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F835, $F0

; compressed sprite graphics of monster id $159 (Poseidon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Poseidon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7925:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08F925, $E8

; compressed sprite graphics of monster id $15A (Pumpoise) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Pumpoise:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7A0D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08FA0D, $E3

; compressed sprite graphics of monster id $15B (Starfish) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Starfish:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_023_7AF0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08FAF0, $E3
    ds $42D, $00
