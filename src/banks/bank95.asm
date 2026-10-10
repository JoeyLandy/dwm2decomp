SECTION "Bank 95", ROMX[$4000], BANK[$95]
    INCBIN "dwm2-cobi-us.gbc", $254000, $650

; only called from BeginStringDisplay_Bank08 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank08)
; reads: wStringCategory
; writes: wStringCategory
BeginStringDisplay_Bank08_Sub01::
Func_095_4650:: ; address name
    ld de, Data_095_4675
    ld a, [wStringCategory]
    sub a, $09
    ld [wStringCategory], a
    call BeginStringDisplay
    ret

; only called from CopyStringToBuffer_Bank08 (E-0047)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank08)
; reads: wStringCategory
; writes: wStringCategory
CopyStringToBuffer_Bank08_Sub01::
Func_095_465F:: ; address name
    ld de, Data_095_4675
    ld a, [wStringCategory]
    sub a, $09
    ld [wStringCategory], a
    call CopyStringToBuffer
    ret
    db $CD, $50, $46, $CD, $11, $26, $C9

Data_095_4675:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw StringTable95_Cat09_SkillDescriptions
    dw StringTable95_Cat0A
    dw StringTable95_Cat0B
    dw StringTable95_Cat0C_FieldActions
    dw StringTable95_Cat0D
    dw StringTable95_Cat0E_Tactics
    dw StringTable95_Cat0F
    dw StringTable95_Cat10
    dw StringTable95_Cat11_Targets
    dw StringTable95_Cat12_SkillFamilies
    dw StringTable95_Cat13_SkillTypes
    dw StringTable95_Cat14_Usable

; string table of category $09 (the string database extension in bank $95, selected when wStringCategory is 9 or more): skill descriptions, for example 'Attacks an enemy with a fireball' (E-0033)
StringTable95_Cat09_SkillDescriptions:: ; heuristic: target of a monotone pointer table; C0
Data_095_468D:: ; address name
    dw Data_095_48CF
    dw Data_095_48CF
    dw Data_095_48F2
    dw Data_095_491A
    dw Data_095_4945
    dw Data_095_4971
    dw Data_095_499C
    dw Data_095_49CB
    dw Data_095_49F2
    dw Data_095_4A24
    dw Data_095_4A49
    dw Data_095_4A75
    dw Data_095_4A9A
    dw Data_095_4AC7
    dw Data_095_4AE9
    dw Data_095_4B19
    dw Data_095_4B45
    dw Data_095_4B75
    dw Data_095_4B96
    dw Data_095_4BC5
    dw Data_095_4BE0
    dw Data_095_4C00
    dw Data_095_4C34
    dw Data_095_4C4B
    dw Data_095_4C62
    dw Data_095_4C76
    dw Data_095_4C94
    dw Data_095_4CAE
    dw Data_095_4CCE
    dw Data_095_4CEE
    dw Data_095_4D0E
    dw Data_095_4D2A
    dw Data_095_4D43
    dw Data_095_4D76
    dw Data_095_4D94
    dw Data_095_4DBC
    dw Data_095_4DDE
    dw Data_095_4DF4
    dw Data_095_4E10
    dw Data_095_4E34
    dw Data_095_4E4E
    dw Data_095_4E71
    dw Data_095_4E8D
    dw Data_095_4EB1
    dw Data_095_4ECB
    dw Data_095_4EEE
    dw Data_095_4F0F
    dw Data_095_4F32
    dw Data_095_4F4F
    dw Data_095_4F69
    dw Data_095_4F9A
    dw Data_095_4FB4
    dw Data_095_4FDB
    dw Data_095_4FF2
    dw Data_095_5022
    dw Data_095_503E
    dw Data_095_505E
    dw Data_095_5088
    dw Data_095_50B6
    dw Data_095_50DF
    dw Data_095_510C
    dw Data_095_5131
    dw Data_095_514D
    dw Data_095_5172
    dw Data_095_519B
    dw Data_095_51C8
    dw Data_095_51F4
    dw Data_095_5225
    dw Data_095_5251
    dw Data_095_527D
    dw Data_095_52AB
    dw Data_095_52D9
    dw Data_095_5306
    dw Data_095_5336
    dw Data_095_5362
    dw Data_095_5383
    dw Data_095_53AA
    dw Data_095_53D5
    dw Data_095_53FD
    dw Data_095_5423
    dw Data_095_5454
    dw Data_095_546B
    dw Data_095_5492
    dw Data_095_54BD
    dw Data_095_54EF
    dw Data_095_551B
    dw Data_095_5548
    dw Data_095_5574
    dw Data_095_559F
    dw Data_095_55C9
    dw Data_095_55F5
    dw Data_095_5621
    dw Data_095_564E
    dw Data_095_567D
    dw Data_095_56A9
    dw Data_095_56CE
    dw Data_095_56FC
    dw Data_095_572C
    dw Data_095_5760
    dw Data_095_5784
    dw Data_095_57B8
    dw Data_095_57E3
    dw Data_095_580A
    dw Data_095_582E
    dw Data_095_584A
    dw Data_095_5873
    dw Data_095_58A2
    dw Data_095_58CF
    dw Data_095_58FB
    dw Data_095_5928
    dw Data_095_5959
    dw Data_095_598C
    dw Data_095_59B9
    dw Data_095_59EB
    dw Data_095_5A17
    dw Data_095_5A3C
    dw Data_095_5A5F
    dw Data_095_5A88
    dw Data_095_5AA6
    dw Data_095_5AC9
    dw Data_095_5AEB
    dw Data_095_5B0E
    dw Data_095_5B39
    dw Data_095_5B69
    dw Data_095_5B95
    dw Data_095_5BBE
    dw Data_095_5BE8
    dw Data_095_5C10
    dw Data_095_5C39
    dw Data_095_5C5E
    dw Data_095_5C8C
    dw Data_095_5CA7
    dw Data_095_5CD9
    dw Data_095_5D0C
    dw Data_095_5D26
    dw Data_095_5D40
    dw Data_095_5D5A
    dw Data_095_5D74
    dw Data_095_5DAA
    dw Data_095_5DCF
    dw Data_095_5DF8
    dw Data_095_5E1C
    dw Data_095_5E45
    dw Data_095_5E71
    dw Data_095_5E92
    dw Data_095_5EBB
    dw Data_095_5EE3
    dw Data_095_5F06
    dw Data_095_5F36
    dw Data_095_5F66
    dw Data_095_5F97
    dw Data_095_5FC2
    dw Data_095_5FEF
    dw Data_095_601B
    dw Data_095_6045
    dw Data_095_6075
    dw Data_095_609E
    dw Data_095_60C0
    dw Data_095_60F0
    dw Data_095_610C
    dw Data_095_612D
    dw Data_095_6158
    dw Data_095_6178
    dw Data_095_6192
    dw Data_095_61C2
    dw Data_095_61ED
    dw Data_095_6222
    dw Data_095_6249
    dw Data_095_6273
    dw Data_095_629C
    dw Data_095_62C2
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3

; string table of category $0A (the string database extension in bank $95, selected when wStringCategory is 9 or more): two-line names such as 'VIT Belt', 'Draco Belt', 'Stone Fang' (the table at $47EF is the same list one entry later) (E-0033)
StringTable95_Cat0A:: ; heuristic: target of a monotone pointer table; C0
Data_095_47ED:: ; address name
    dw Data_095_62E4

; string table of category $0B (the string database extension in bank $95, selected when wStringCategory is 9 or more): the same names as category $0A without the blank first entry (E-0033)
StringTable95_Cat0B:: ; heuristic: target of a monotone pointer table; C0
Data_095_47EF:: ; address name
    dw Data_095_62E5
    dw Data_095_62EB
    dw Data_095_62F4
    dw Data_095_62FF
    dw Data_095_630A
    dw Data_095_6313
    dw Data_095_631E
    dw Data_095_6329
    dw Data_095_6334
    dw Data_095_633F
    dw Data_095_634A
    dw Data_095_6358
    dw Data_095_6362
    dw Data_095_636B
    dw Data_095_6376
    dw Data_095_6381
    dw Data_095_638D
    dw Data_095_6397
    dw Data_095_63A2
    dw Data_095_63AC
    dw Data_095_63B7
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C2
    dw Data_095_63CC
    dw Data_095_63D8
    dw Data_095_63E1
    dw Data_095_63EB
    dw Data_095_63F6
    dw Data_095_6402
    dw Data_095_640D
    dw Data_095_6419

; string table of category $0C (the string database extension in bank $95, selected when wStringCategory is 9 or more): short two-line phrases such as 'Call ship', 'Call cloud', 'Smash rock', 'Burn', 'Cut', 'Open door' (E-0033)
StringTable95_Cat0C_FieldActions:: ; heuristic: target of a monotone pointer table; C0
Data_095_4837:: ; address name
    dw Data_095_641B

; string table of category $0D (the string database extension in bank $95, selected when wStringCategory is 9 or more): the same phrases as category $0C without the blank first entry (E-0033)
StringTable95_Cat0D:: ; heuristic: target of a monotone pointer table; C0
Data_095_4839:: ; address name
    dw Data_095_641C
    dw Data_095_6422
    dw Data_095_642C
    dw Data_095_6437
    dw Data_095_6442
    dw Data_095_6448
    dw Data_095_644D

; string table of category $0E (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'Attack', 'Charge', 'Mixed', 'Cautious', 'Command' (E-0033)
StringTable95_Cat0E_Tactics:: ; heuristic: target of a monotone pointer table; C0
Data_095_4847:: ; address name
    dw Data_095_6457
    dw Data_095_6457
    dw Data_095_645E
    dw Data_095_6465
    dw Data_095_646B
    dw Data_095_6474

; string table of category $0F (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'Charge', 'Mixed', 'Cautious', 'ZoneOut' (overlaps category $0E) (E-0033)
StringTable95_Cat0F:: ; heuristic: target of a monotone pointer table; C0
Data_095_4853:: ; address name
    dw Data_095_647C
    dw Data_095_647C

; string table of category $10 (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'Charge', 'Mixed', 'Cautious', 'ZoneOut', 'Chance', 'Confusion', shown for the high nibble of a skill record's byte 3 (E-0033)
StringTable95_Cat10:: ; heuristic: target of a monotone pointer table; C0
Data_095_4857:: ; address name
    dw Data_095_647C
    dw Data_095_647D
    dw Data_095_6484
    dw Data_095_648A
    dw Data_095_6493
    dw Data_095_649B
    dw Data_095_64A2
    dw Data_095_64AC
    dw Data_095_64B1

; string table of category $11 (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'No area', '1 enemy', 'All enemies', 'Foes multi-hit', '1 friend', 'All friends', 'Choose 1' (E-0033)
StringTable95_Cat11_Targets:: ; heuristic: target of a monotone pointer table; C0
Data_095_4869:: ; address name
    dw Data_095_64B6
    dw Data_095_64BE
    dw Data_095_64C6
    dw Data_095_64D2
    dw Data_095_64E1
    dw Data_095_64EA
    dw Data_095_64F6
    dw Data_095_64FF
    dw Data_095_650A
    dw Data_095_650F
    dw Data_095_6513

; string table of category $12 (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'None', 'Blaze', 'Firebal', 'Bang', 'Infernos', 'Bolt', 'IceBolt' (E-0033)
StringTable95_Cat12_SkillFamilies:: ; heuristic: target of a monotone pointer table; C0
Data_095_487F:: ; address name
    dw Data_095_651A
    dw Data_095_651F
    dw Data_095_6525
    dw Data_095_652D
    dw Data_095_6532
    dw Data_095_653B
    dw Data_095_6540
    dw Data_095_6548
    dw Data_095_6551
    dw Data_095_6557
    dw Data_095_655C
    dw Data_095_6565
    dw Data_095_656F
    dw Data_095_6578
    dw Data_095_657C
    dw Data_095_6584
    dw Data_095_658E
    dw Data_095_6598
    dw Data_095_659D
    dw Data_095_65A6
    dw Data_095_65AD
    dw Data_095_65B7
    dw Data_095_65BD
    dw Data_095_65C2
    dw Data_095_65C8
    dw Data_095_65CF
    dw Data_095_65D6
    dw Data_095_65DB

; string table of category $13 (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'Type A' ... 'Type G' (E-0033)
StringTable95_Cat13_SkillTypes:: ; heuristic: target of a monotone pointer table; C0
Data_095_48B7:: ; address name
    dw Data_095_65E1
    dw Data_095_65E8
    dw Data_095_65EF
    dw Data_095_65F6
    dw Data_095_65FD
    dw Data_095_6604
    dw Data_095_660B
    dw Data_095_6612

; string table of category $14 (the string database extension in bank $95, selected when wStringCategory is 9 or more): 'None', 'Battle', 'Field', 'Anytime' (E-0033)
StringTable95_Cat14_Usable:: ; heuristic: target of a monotone pointer table; C0
Data_095_48C7:: ; address name
    dw Data_095_6619
    dw Data_095_661E
    dw Data_095_6625
    dw Data_095_662B

Data_095_48CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks an enemy", $F1
    db "with a fireball.", $F1
    db $F0

Data_095_48F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks an enemy", $F1
    db "with a large", $F1
    db "fireball.", $F0

Data_095_491A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A towering pillar", $F1
    db "of fire roasts an", $F1
    db "enemy.", $F0

Data_095_4945:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks enemies", $F1
    db "with a blast of", $F1
    db "fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4971:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks enemies", $F1
    db "with a wall of", $F1
    db "fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_499C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A huge wall of", $F1
    db "fire incinerates", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_49CB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $36
    db $F1, $36, $37, $35, $2C, $2E, $28, $90, $28, $31, $28, $30, $2C, $28, $36, $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_49F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A succession of", $F1
    db "explosions strikes", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4A24:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Huge explosions", $F1
    db "blast enemies", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4A49:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Razor sharp", $F1
    db "whirlwinds slash", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4A75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Twisters tear", $F1
    db "through enemies", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4A9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A huge tornado", $F1
    db "roars through", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0, $90

Data_095_4AC7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lightning strikes", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4AE9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Powerful bolts of", $F1
    db "lightning lash", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Huge shards of", $F1
    db "lightning rip", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B45:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small chunks of", $F1
    db "ice hail down on", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enemies are flash", $F1
    db "frozen "
    db $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4B96:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wicked blizzard", $F1
    db "howls through", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4BC5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly slays an", $F1
    db "enemy.", $F1
    db $F0

Data_095_4BE0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly slays", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4C00:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The user explodes", $F1
    db "to inflict damage", $F1
    db "on all enemies.", $F0

Data_095_4C34:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by", $F1
    db $03, $00, $9D, $04, $00, $B5, $F1, $F0

Data_095_4C4B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $F1, $07
    db $05, $9D, $09, $00, $B5, $F1, $F0

Data_095_4C62:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores", $F1
    db "HP.", $F1
    db $F0

Data_095_4C76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by", $F1
    db $09, $00, $9D, $01, $02, $00, $90, $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4C94:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $2F, $2F, $3C, $90, $35, $28, $36, $37, $32, $35, $28, $36, $90, $11
    db $19, $F1, $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4CAE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 15MP to a", $F1
    db "party monster.", $F1
    db $F0

Data_095_4CCE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 30MP to a", $F1
    db "party monster.", $F1
    db $F0

Data_095_4CEE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gives 80MP to a", $F1
    db "party monster.", $F1
    db $F0

Data_095_4D0E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "May revive a dead", $F1
    db "monster.", $F1
    db $F0

Data_095_4D2A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F1
    db $F0

Data_095_4D43:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives dead mates", $F1
    db "in exchange for", $F1
    db "own life "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4D76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures one monster", $F1
    db "of poison.", $F1
    db $F0

Data_095_4D94:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clears confusion", $F1
    db "in all party", $F1
    db "monsters.", $F0

Data_095_4DBC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis", $F1
    db "and sleep "
    db $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4DDE:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $37, $36, $90, $24, $90, $26, $38, $35, $36, $28, $F1, $A0, $24
    db $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4DF4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF of one", $F1
    db "monster.", $F1
    db $F0

Data_095_4E10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF of", $F1
    db "party monsters", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4E34:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers DEF of one", $F1
    db "enemy.", $F1
    db $F0

Data_095_4E4E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers DEF of all", $F1
    db "enemy monsters.", $F1
    db $F0

Data_095_4E71:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL of one", $F1
    db "monster.", $F1
    db $F0

Data_095_4E8D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL of", $F1
    db "party monsters", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4EB1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers AGL of one", $F1
    db "enemy.", $F1
    db $F0

Data_095_4ECB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lowers AGL of all", $F1
    db "enemy monsters.", $F1
    db $F0

Data_095_4EEE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles the ATK of", $F1
    db "one monster.", $F1
    db $F0

Data_095_4F0F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surrounds all", $F1
    db "enemies in a", $F1
    db "mirage.", $F0

Data_095_4F32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes a single", $F1
    db "enemy sleep.", $F1
    db $F0

Data_095_4F4F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes all enemies", $F1
    db "sleep.", $F1
    db $F0

Data_095_4F69:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Absorbs the MP of", $F1
    db "a spell cast", $F1
    db "against the user.", $F0

Data_095_4F9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Steals MP from an", $F1
    db "enemy.", $F1
    db $F0

Data_095_4FB4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents spell", $F1
    db "casting by all", $F1
    db "enemies.", $F0

Data_095_4FDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confuses all", $F1
    db "enemies.", $F1
    db $F0

Data_095_4FF2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Changes all party", $F1
    db "monsters into", $F1
    db "chunks of iron.", $F0

Data_095_5022:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back a", $F1
    db "spell once.", $F1
    db $F0

Data_095_503E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back all", $F1
    db "enemy spells.", $F1
    db $F0

Data_095_505E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reduces damage", $F1
    db "from breath", $F1
    db "attacks "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5088:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises protection", $F1
    db "against magic", $F1
    db "spells "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_50B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms the", $F1
    db "user into a chosen", $F1
    db "enemy.", $F0

Data_095_50DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms the", $F1
    db "user into a", $F1
    db "ferocious dragon.", $F0

Data_095_510C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no", $F1
    db "telling what may", $F1
    db "happen.", $F0

Data_095_5131:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ultimate", $F1
    db "attack spell.", $F1
    db $F0

Data_095_514D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates an", $F1
    db "enormous explosion", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5172:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes all", $F1
    db "enemies with huge", $F1
    db "lightning.", $F0

Data_095_519B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a breath of", $F1
    db "fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_51C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a blast of", $F1
    db "fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_51F4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a huge blast", $F1
    db "of fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5225:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with incredible", $F1
    db "fire "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5251:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a breath of", $F1
    db "ice "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_527D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "with a freezing", $F1
    db "breath "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_52AB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage by", $F1
    db "exhaling a", $F1
    db "blizzard "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_52D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Looses a white,", $F1
    db "shining breath of", $F1
    db "ice "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5306:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slashes a single", $F1
    db "monster with sharp", $F1
    db "whirlwinds.", $F0

Data_095_5336:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a tornado", $F1
    db "with vicious winds", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5362:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a", $F1
    db "lightning storm", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5383:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hurls giant", $F1
    db "boulders at", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_53AA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shoots a high", $F1
    db "volume of water at", $F1
    db "an enemy.", $F0

Data_095_53D5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a towering", $F1
    db "wall of water", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_53FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons friends", $F1
    db "who attack in", $F1
    db "droves.", $F0

Data_095_5423:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a mass of", $F1
    db "friends that", $F1
    db "attack in droves.", $F0

Data_095_5454:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fiery sword", $F1
    db "attack.", $F1
    db $F0

Data_095_546B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "enhanced by", $F1
    db "whirlwinds.", $F0

Data_095_5492:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "made stronger by", $F1
    db "lightning.", $F0

Data_095_54BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "made stronger by", $F1
    db "the power of ice.", $F0

Data_095_54EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "slime family.", $F0

Data_095_551B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "dragon family.", $F0

Data_095_5548:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "beast family.", $F0

Data_095_5574:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "bird family.", $F0

Data_095_559F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "bug family.", $F0

Data_095_55C9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "plant family.", $F0

Data_095_55F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "devil family.", $F0

Data_095_5621:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "zombie family.", $F0

Data_095_564E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "material family.", $F0

Data_095_567D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the", $F1
    db "water family.", $F0

Data_095_56A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts damage", $F1
    db "on a high DEF", $F1
    db "enemy.", $F0

Data_095_56CE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may poison", $F1
    db "the target.", $F0

Data_095_56FC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may paralyze", $F1
    db "the target.", $F0

Data_095_572C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that may put the", $F1
    db "target to sleep.", $F0

Data_095_5760:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that hits first.", $F1
    db $F0

Data_095_5784:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that strikes twice", $F1
    db "in succession.", $F0

Data_095_57B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A physical attack", $F1
    db "that strikes four", $F1
    db "times.", $F0

Data_095_57E3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sword attack", $F1
    db "that hits all", $F1
    db "enemies.", $F0, $F0

Data_095_580A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cross-cutting", $F1
    db "sword attack", $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_582E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The ultimate sword", $F1
    db "attack.", $F1
    db $F0

Data_095_584A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on the next", $F1
    db "turn.", $F0

Data_095_5873:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage at the end", $F1
    db "of the turn.", $F0

Data_095_58A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The user leaps and", $F1
    db "attacks in the", $F1
    db "next turn.", $F0

Data_095_58CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A powerful, but", $F1
    db "wildly aimed,", $F1
    db "sword attack.", $F0

Data_095_58FB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage on one", $F1
    db "friend or foe.", $F0

Data_095_5928:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inflicts severe", $F1
    db "damage, but also", $F1
    db "hurts the user.", $F0

Data_095_5959:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A powerful attack", $F1
    db "that leaves the", $F1
    db "user vulnerable.", $F0

Data_095_598C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A full-body tackle", $F1
    db "that also hurts", $F1
    db "the user.", $F0

Data_095_59B9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leaves the user", $F1
    db "and target on the", $F1
    db "verge of death.", $F0

Data_095_59EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "induces sleep in", $F1
    db "all enemies.", $F0

Data_095_5A17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "paralyzes all", $F1
    db "enemies.", $F0

Data_095_5A3C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "poisons all", $F1
    db "enemies.", $F0

Data_095_5A5F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A breath that", $F1
    db "badly poisons all", $F1
    db "enemies.", $F0

Data_095_5A88:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lays a curse on", $F1
    db "all enemies.", $F1
    db $F0

Data_095_5AA6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "reduces an enemy's", $F1
    db "MP.", $F0

Data_095_5AC9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "steals an enemy's", $F1
    db "MP.", $F0

Data_095_5AEB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "confuses all", $F1
    db "enemies.", $F0

Data_095_5B0E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "induces death in", $F1
    db "all enemies.", $F0

Data_095_5B39:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that makes", $F1
    db "all enemies want", $F1
    db "to join in.", $F0

Data_095_5B69:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A sacrificial", $F1
    db "dance to revive", $F1
    db "dead friends.", $F0

Data_095_5B95:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A dance that", $F1
    db "restores HP by", $F1
    db $07, $00, $9D, $08, $00, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5BBE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A quick-footed", $F1
    db "skill for dodging", $F1
    db "attacks.", $F0

Data_095_5BE8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Obscures the", $F1
    db "visibility of all", $F1
    db "enemies.", $F0

Data_095_5C10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blast of light", $F1
    db "blinds all the", $F1
    db "enemies.", $F0

Data_095_5C39:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weakens all", $F1
    db "enemies to magic", $F1
    db "spells.", $F0

Data_095_5C5E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eliminates all", $F1
    db "status problems", $F1
    db "among friends.", $F0

Data_095_5C8C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Greatly weakens an", $F1
    db "enemy.", $F1
    db $F0

Data_095_5CA7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts the effects", $F1
    db "of all spells on", $F1
    db "enemies "
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5CD9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a fog that", $F1
    db "prevents the use", $F1
    db "of all spells.", $F0

Data_095_5D0C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Tatsu to", $F1
    db "battle.", $F1
    db $F0

Data_095_5D26:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Diago to", $F1
    db "battle.", $F1
    db $F0

Data_095_5D40:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Samsi to", $F1
    db "battle.", $F1
    db $F0

Data_095_5D5A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons Bazoo to", $F1
    db "battle.", $F1
    db $F0

Data_095_5D74:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Holds in a breath", $F1
    db "to inflict severe", $F1
    db "damage next turn.", $F0

Data_095_5DAA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables two moves", $F1
    db "in the next turn.", $F1
    db $F0

Data_095_5DCF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Licks one enemy to", $F1
    db "stop it for one", $F1
    db "turn.", $F0

Data_095_5DF8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Licks one enemy to", $F1
    db "reduce its DEF.", $F1
    db $F0

Data_095_5E1C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sweeps the leg out", $F1
    db "from under one", $F1
    db "enemy.", $F0

Data_095_5E45:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sweeps the legs", $F1
    db "out from under all", $F1
    db "enemies.", $F0

Data_095_5E71:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soft, plushy and", $F1
    db "very pleasant.", $F1
    db $F0

Data_095_5E92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A terrifying cry", $F1
    db "that stops all", $F1
    db "enemies.", $F0

Data_095_5EBB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Opens a geyser to", $F1
    db "send an enemy", $F1
    db "flying.", $F0

Data_095_5EE3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents all", $F1
    db "enemies from", $F1
    db "dancing.", $F0

Data_095_5F06:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents all", $F1
    db "enemies from using", $F1
    db "breath attacks.", $F0

Data_095_5F36:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strongly protects", $F1
    db "the user against", $F1
    db "all attacks.", $F0

Data_095_5F66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Deflects any", $F1
    db "physical attack to", $F1
    db "another monster.", $F0

Data_095_5F97:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects the user", $F1
    db "and enables", $F1
    db "retaliation.", $F0

Data_095_5FC2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Takes all attacks", $F1
    db "meant for another", $F1
    db "monster.", $F0

Data_095_5FEF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Takes all attacks", $F1
    db "meant for party", $F1
    db "monsters.", $F0

Data_095_601B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back a", $F1
    db "breath attack to", $F1
    db "an enemy.", $F0

Data_095_6045:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounces back all", $F1
    db "breath attacks to", $F1
    db "all enemies.", $F0

Data_095_6075:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Creates a barrier", $F1
    db "that blocks an", $F1
    db "attack.", $F0

Data_095_609E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seals a skill used", $F1
    db "by the enemy.", $F1
    db $F0

Data_095_60C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inhales all breath", $F1
    db "attacks meant for", $F1
    db "the party.", $F0

Data_095_60F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Imitates the", $F1
    db "enemy's moves.", $F1
    db $F0

Data_095_610C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Meditates to", $F1
    db "restore HP by 500.", $F1
    db $F0

Data_095_612D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives all dead", $F1
    db "friends in the", $F1
    db "next turn.", $F0

Data_095_6158:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons rain that", $F1
    db "restores HP.", $F1
    db $F0

Data_095_6178:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts enemy", $F1
    db "monsters.", $F1
    db $F0

Data_095_6192:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts enemy", $F1
    db "monsters of the", $F1
    db "opposite gender.", $F0

Data_095_61C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects the party", $F1
    db "from injurious", $F1
    db "terrain.", $F0

Data_095_61ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps", $F1
    db "the party out from", $F1
    db "caves and towers.", $F0

Data_095_6222:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Use to obtain", $F1
    db "information on", $F1
    db "monsters.", $F0

Data_095_6249:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the monster", $F1
    db "run an errand for", $F1
    db "100G.", $F0

Data_095_6273:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Determines the", $F1
    db "presence of items", $F1
    db "nearby.", $F0

Data_095_629C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks the", $F1
    db "surrounding area's", $F1
    db "terrain.", $F0

Data_095_62C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soft, plushy and", $F1
    db "very pleasant.", $F1
    db $F0

Data_095_62E3:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_62E4:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_62E5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F1
    db $F0

Data_095_62EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "VIT", $F1
    db "Belt", $F0

Data_095_62F4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F1
    db "Belt", $F0

Data_095_62FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Belt", $F0

Data_095_630A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Odd", $F1
    db "Belt", $F0

Data_095_6313:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stone", $F1
    db "Fang", $F0

Data_095_631E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Steel", $F1
    db "Fang", $F0

Data_095_6329:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Merm", $F1
    db "Scale", $F0

Data_095_6334:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drak", $F1
    db "Scale", $F0

Data_095_633F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGL", $F1
    db "Bangle", $F0

Data_095_634A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry", $F1
    db "Bangle", $F0

Data_095_6358:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smart", $F1
    db "Hat", $F0

Data_095_6362:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wise", $F1
    db "Hat", $F0

Data_095_636B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Cape", $F0

Data_095_6376:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F1
    db "Cape", $F0

Data_095_6381:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Silver", $F1
    db "Cape", $F0

Data_095_638D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gold", $F1
    db "Cape", $F0

Data_095_6397:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pltnm", $F1
    db "Cape", $F0

Data_095_63A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orca", $F1
    db "Cape", $F0

Data_095_63AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brave", $F1
    db "Cape", $F0

Data_095_63B7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "D-", $F1
    db "Scale", $F0

Data_095_63C0:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F0

Data_095_63C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Life", $F1
    db "Ring", $F0

Data_095_63CC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divine", $F1
    db "Ring", $F0

Data_095_63D8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "War", $F1
    db "Ring", $F0

Data_095_63E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mage", $F1
    db "Ring", $F0

Data_095_63EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fight", $F1
    db "Ring", $F0

Data_095_63F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sailor", $F1
    db "Ring", $F0

Data_095_6402:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thief", $F1
    db "Ring", $F0

Data_095_640D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cleric", $F1
    db "Ring", $F0

Data_095_6419:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F0

Data_095_641B:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_641C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F1
    db $F0

Data_095_6422:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Call", $F1
    db "ship", $F0

Data_095_642C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Call", $F1
    db "cloud", $F0

Data_095_6437:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smash", $F1
    db "rock", $F0

Data_095_6442:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Burn", $F1
    db $F0

Data_095_6448:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cut", $F1
    db $F0

Data_095_644D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Open", $F1
    db "door", $F0

Data_095_6457:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attack", $F0

Data_095_645E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Charge", $F0

Data_095_6465:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mixed", $F0

Data_095_646B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cautious", $F0

Data_095_6474:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Command", $F0

Data_095_647C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_647D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Charge", $F0

Data_095_6484:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mixed", $F0

Data_095_648A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cautious", $F0

Data_095_6493:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZoneOut", $F0

Data_095_649B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chance", $F0

Data_095_64A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confusion", $F0

Data_095_64AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

Data_095_64B1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Item", $F0

Data_095_64B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No area", $F0

Data_095_64BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1 enemy", $F0

Data_095_64C6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All enemies", $F0

Data_095_64D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Foes multi-hit", $F0

Data_095_64E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1 friend", $F0

Data_095_64EA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All friends", $F0

Data_095_64F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose 1", $F0

Data_095_64FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose all", $F0

Data_095_650A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Self", $F0

Data_095_650F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "All", $F0

Data_095_6513:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Random", $F0

Data_095_651A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

Data_095_651F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blaze", $F0

Data_095_6525:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Firebal", $F0

Data_095_652D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bang", $F0

Data_095_6532:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Infernos", $F0

Data_095_653B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bolt", $F0

Data_095_6540:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceBolt", $F0

Data_095_6548:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surround", $F0

Data_095_6551:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sleep", $F0

Data_095_6557:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beat", $F0

Data_095_655C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RobMagic", $F0

Data_095_6565:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StopSpell", $F0

Data_095_656F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PanicAll", $F0

Data_095_6578:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sap", $F0

Data_095_657C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlowAll", $F0

Data_095_6584:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sacrifice", $F0

Data_095_658E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MegaMagic", $F0

Data_095_6598:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fire", $F0

Data_095_659D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blizzard", $F0

Data_095_65A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poison", $F0

Data_095_65AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Paralysis", $F0

Data_095_65B7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Curse", $F0

Data_095_65BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rest", $F0

Data_095_65C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dance", $F0

Data_095_65C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breath", $F0

Data_095_65CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Friend", $F0

Data_095_65D6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bash", $F0

Data_095_65DB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

Data_095_65E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type A", $F0

Data_095_65E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type B", $F0

Data_095_65EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type C", $F0

Data_095_65F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type D", $F0

Data_095_65FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type E", $F0

Data_095_6604:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type F", $F0

Data_095_660B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type G", $F0

Data_095_6612:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Type H", $F0

Data_095_6619:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

Data_095_661E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battle", $F0

Data_095_6625:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Field", $F0

Data_095_662B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anytime", $F0
    ds $19CD, $00
