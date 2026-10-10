SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2F

; ld de, this bank's string table / BeginStringDisplay
; 31 call sites from 31 routines (e.g. ShowString_Bank2F, DebugMessageTest_Update_Case0F, ShowStringCategory5_Bank16, BattlePhase0_Step2_Case03, ...)
BeginStringDisplay_Bank2F::
Func_02F_4001:: ; address name
    ld de, Data_02F_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_02F_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. DebugBattleSetupShowFieldString, ShowStringCategory5Immediate_Bank16)
ShowString_Bank2F::
Func_02F_400F:: ; address name
    call BeginStringDisplay_Bank2F
    call RunStringDisplayToEnd
    ret

Data_02F_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_02F_4022
    dw Data_02F_4134
    dw Data_02F_4334
    dw Data_02F_433C
    dw Data_02F_433E
    dw Data_02F_4340

Data_02F_4022:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_4384
    dw Data_02F_4393
    dw Data_02F_43A7
    dw Data_02F_43BB
    dw Data_02F_43CF
    dw Data_02F_43E3
    dw Data_02F_43F7
    dw Data_02F_4412
    dw Data_02F_442F
    dw Data_02F_4444
    dw Data_02F_4463
    dw Data_02F_4482
    dw Data_02F_4496
    dw Data_02F_44AD
    dw Data_02F_44C5
    dw Data_02F_44E2
    dw Data_02F_4502
    dw Data_02F_4522
    dw Data_02F_4542
    dw Data_02F_4568
    dw Data_02F_4578
    dw Data_02F_458A
    dw Data_02F_45A2
    dw Data_02F_45B8
    dw Data_02F_45CB
    dw Data_02F_45E2
    dw Data_02F_45F5
    dw Data_02F_460C
    dw Data_02F_4626
    dw Data_02F_4642
    dw Data_02F_4665
    dw Data_02F_4689
    dw Data_02F_46A6
    dw Data_02F_46C5
    dw Data_02F_46E0
    dw Data_02F_46F5
    dw Data_02F_4713
    dw Data_02F_4732
    dw Data_02F_4757
    dw Data_02F_4769
    dw Data_02F_4777
    dw Data_02F_478C
    dw Data_02F_47AE
    dw Data_02F_47C2
    dw Data_02F_47DA
    dw Data_02F_47FE
    dw Data_02F_481E
    dw Data_02F_4839
    dw Data_02F_4856
    dw Data_02F_4869
    dw Data_02F_4884
    dw Data_02F_489F
    dw Data_02F_48B6
    dw Data_02F_48CD
    dw Data_02F_48E9
    dw Data_02F_4915
    dw Data_02F_4941
    dw Data_02F_4973
    dw Data_02F_49AA
    dw Data_02F_49E5
    dw Data_02F_4A20
    dw Data_02F_4A5C
    dw Data_02F_4A96
    dw Data_02F_4ACE
    dw Data_02F_4AFC
    dw Data_02F_4B2E
    dw Data_02F_4B6A
    dw Data_02F_4BA4
    dw Data_02F_4BDB
    dw Data_02F_4C14
    dw Data_02F_4C46
    dw Data_02F_4C7A
    dw Data_02F_4CAE
    dw Data_02F_4CE6
    dw Data_02F_4D11
    dw Data_02F_4D49
    dw Data_02F_4D79
    dw Data_02F_4DA6
    dw Data_02F_4DD4
    dw Data_02F_4E0A
    dw Data_02F_4E38
    dw Data_02F_4E6F
    dw Data_02F_4EAD
    dw Data_02F_4EEB
    dw Data_02F_4F27
    dw Data_02F_4F66
    dw Data_02F_4FA0
    dw Data_02F_4FD5
    dw Data_02F_5010
    dw Data_02F_5041
    dw Data_02F_5080
    dw Data_02F_50BB
    dw Data_02F_50F0
    dw Data_02F_512D
    dw Data_02F_5169
    dw Data_02F_519E
    dw Data_02F_51D6
    dw Data_02F_51F0
    dw Data_02F_5202
    dw Data_02F_5225
    dw Data_02F_524D
    dw Data_02F_5277
    dw Data_02F_5296
    dw Data_02F_52CA
    dw Data_02F_52FC
    dw Data_02F_532D
    dw Data_02F_5361
    dw Data_02F_5393
    dw Data_02F_53C4
    dw Data_02F_5408
    dw Data_02F_5453
    dw Data_02F_54A2
    dw Data_02F_54F0
    dw Data_02F_5534
    dw Data_02F_557F
    dw Data_02F_55CF
    dw Data_02F_5622
    dw Data_02F_5671
    dw Data_02F_56BD
    dw Data_02F_5709
    dw Data_02F_5758
    dw Data_02F_57A4
    dw Data_02F_57F3
    dw Data_02F_583D
    dw Data_02F_5859
    dw Data_02F_587A
    dw Data_02F_5892
    dw Data_02F_58A7
    dw Data_02F_58C8
    dw Data_02F_590E
    dw Data_02F_5958
    dw Data_02F_599F
    dw Data_02F_59EC
    dw Data_02F_5A35
    dw Data_02F_5A82
    dw Data_02F_5A9C
    dw Data_02F_5AB8

Data_02F_4134:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_5AC9
    dw Data_02F_5AD8
    dw Data_02F_5AE6
    dw Data_02F_5AF6
    dw Data_02F_5B04
    dw Data_02F_5B18
    dw Data_02F_5B2B
    dw Data_02F_5B41
    dw Data_02F_5B55
    dw Data_02F_5B6F
    dw Data_02F_5B80
    dw Data_02F_5B94
    dw Data_02F_5BA5
    dw Data_02F_5BB6
    dw Data_02F_5BD0
    dw Data_02F_5BE5
    dw Data_02F_5C19
    dw Data_02F_5C2F
    dw Data_02F_5C45
    dw Data_02F_5C58
    dw Data_02F_5C73
    dw Data_02F_5C89
    dw Data_02F_5CA8
    dw Data_02F_5CC6
    dw Data_02F_5CE1
    dw Data_02F_5D1E
    dw Data_02F_5D5B
    dw Data_02F_5D99
    dw Data_02F_5DAF
    dw Data_02F_5DCB
    dw Data_02F_5DE7
    dw Data_02F_5E10
    dw Data_02F_5E26
    dw Data_02F_5E3A
    dw Data_02F_5E54
    dw Data_02F_5E6F
    dw Data_02F_5E89
    dw Data_02F_5E9D
    dw Data_02F_5EAE
    dw Data_02F_5EDB
    dw Data_02F_5EEF
    dw Data_02F_5F01
    dw Data_02F_5F1E
    dw Data_02F_5F37
    dw Data_02F_5F48
    dw Data_02F_5F63
    dw Data_02F_5F7B
    dw Data_02F_5F98
    dw Data_02F_5FB0
    dw Data_02F_5FCB
    dw Data_02F_5FE7
    dw Data_02F_6023
    dw Data_02F_6034
    dw Data_02F_6054
    dw Data_02F_6069
    dw Data_02F_607E
    dw Data_02F_6096
    dw Data_02F_60AB
    dw Data_02F_60C1
    dw Data_02F_60D7
    dw Data_02F_60F1
    dw Data_02F_610B
    dw Data_02F_6126
    dw Data_02F_6141
    dw Data_02F_6157
    dw Data_02F_6168
    dw Data_02F_617F
    dw Data_02F_6195
    dw Data_02F_61A8
    dw Data_02F_61C3
    dw Data_02F_61D9
    dw Data_02F_61F7
    dw Data_02F_620E
    dw Data_02F_6227
    dw Data_02F_623D
    dw Data_02F_6255
    dw Data_02F_627C
    dw Data_02F_62A3
    dw Data_02F_62C2
    dw Data_02F_62DC
    dw Data_02F_62F9
    dw Data_02F_6311
    dw Data_02F_6324
    dw Data_02F_633B
    dw Data_02F_6362
    dw Data_02F_637C
    dw Data_02F_6395
    dw Data_02F_63B1
    dw Data_02F_63C1
    dw Data_02F_63DA
    dw Data_02F_63EE
    dw Data_02F_6404
    dw Data_02F_6434
    dw Data_02F_6446
    dw Data_02F_6456
    dw Data_02F_6473
    dw Data_02F_648F
    dw Data_02F_64A5
    dw Data_02F_64BD
    dw Data_02F_64D6
    dw Data_02F_64EF
    dw Data_02F_6507
    dw Data_02F_651F
    dw Data_02F_6537
    dw Data_02F_6557
    dw Data_02F_6574
    dw Data_02F_6591
    dw Data_02F_65A9
    dw Data_02F_65C8
    dw Data_02F_65E1
    dw Data_02F_65FF
    dw Data_02F_661F
    dw Data_02F_6634
    dw Data_02F_664E
    dw Data_02F_6661
    dw Data_02F_6683
    dw Data_02F_669A
    dw Data_02F_66AC
    dw Data_02F_66BF
    dw Data_02F_66D6
    dw Data_02F_66F2
    dw Data_02F_6704
    dw Data_02F_671E
    dw Data_02F_6730
    dw Data_02F_674A
    dw Data_02F_675F
    dw Data_02F_6777
    dw Data_02F_678A
    dw Data_02F_679A
    dw Data_02F_67B5
    dw Data_02F_67CB
    dw Data_02F_67D9
    dw Data_02F_67F8
    dw Data_02F_6810
    dw Data_02F_682B
    dw Data_02F_684B
    dw Data_02F_685F
    dw Data_02F_6889
    dw Data_02F_68B4
    dw Data_02F_68C0
    dw Data_02F_68D3
    dw Data_02F_68EB
    dw Data_02F_68FE
    dw Data_02F_6918
    dw Data_02F_692C
    dw Data_02F_693F
    dw Data_02F_695D
    dw Data_02F_6974
    dw Data_02F_6992
    dw Data_02F_69AF
    dw Data_02F_69E0
    dw Data_02F_6A10
    dw Data_02F_6A28
    dw Data_02F_6A4B
    dw Data_02F_6A67
    dw Data_02F_6A87
    dw Data_02F_6A9B
    dw Data_02F_6AAC
    dw Data_02F_6ABD
    dw Data_02F_6AEC
    dw Data_02F_6AFE
    dw Data_02F_6B1B
    dw Data_02F_6B39
    dw Data_02F_6B56
    dw Data_02F_6B8F
    dw Data_02F_6BC7
    dw Data_02F_6BFB
    dw Data_02F_6C34
    dw Data_02F_6C69
    dw Data_02F_6C89
    dw Data_02F_6CA3
    dw Data_02F_6CCB
    dw Data_02F_6CF8
    dw Data_02F_6D1E
    dw Data_02F_6D4A
    dw Data_02F_6D76
    dw Data_02F_6D8A
    dw Data_02F_6D9E
    dw Data_02F_6DB1
    dw Data_02F_6DD8
    dw Data_02F_6DF5
    dw Data_02F_6E1A
    dw Data_02F_6E33
    dw Data_02F_6E6E
    dw Data_02F_6E87
    dw Data_02F_6EB8
    dw Data_02F_6ECF
    dw Data_02F_6F03
    dw Data_02F_6F17
    dw Data_02F_6F34
    dw Data_02F_6F50
    dw Data_02F_6F68
    dw Data_02F_6F7E
    dw Data_02F_6FBB
    dw Data_02F_6FED
    dw Data_02F_700C
    dw Data_02F_7023
    dw Data_02F_7046
    dw Data_02F_706D
    dw Data_02F_7094
    dw Data_02F_70C0
    dw Data_02F_70D9
    dw Data_02F_70F6
    dw Data_02F_7107
    dw Data_02F_7120
    dw Data_02F_7138
    dw Data_02F_714E
    dw Data_02F_7166
    dw Data_02F_7181
    dw Data_02F_719A
    dw Data_02F_71B5
    dw Data_02F_71D0
    dw Data_02F_71E9
    dw Data_02F_7201
    dw Data_02F_721D
    dw Data_02F_7233
    dw Data_02F_724E
    dw Data_02F_725A
    dw Data_02F_726B
    dw Data_02F_7283
    dw Data_02F_72A0
    dw Data_02F_72C9
    dw Data_02F_72E2
    dw Data_02F_72FB
    dw Data_02F_730D
    dw Data_02F_7329
    dw Data_02F_7342
    dw Data_02F_735B
    dw Data_02F_7377
    dw Data_02F_7392
    dw Data_02F_73A9
    dw Data_02F_73CA
    dw Data_02F_73E5
    dw Data_02F_7400
    dw Data_02F_741D
    dw Data_02F_743A
    dw Data_02F_7466
    dw Data_02F_74A3
    dw Data_02F_74EB
    dw Data_02F_752D
    dw Data_02F_7574
    dw Data_02F_75A9
    dw Data_02F_75DA
    dw Data_02F_7607
    dw Data_02F_763A
    dw Data_02F_768F
    dw Data_02F_76C1
    dw Data_02F_76F0
    dw Data_02F_7719
    dw Data_02F_7752
    dw Data_02F_7781
    dw Data_02F_77B0
    dw Data_02F_77C1
    dw Data_02F_77D2
    dw Data_02F_7818
    dw Data_02F_7854

Data_02F_4334:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_7877
    dw Data_02F_787D
    dw Data_02F_7882
    dw Data_02F_7888

Data_02F_433C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_788D

Data_02F_433E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_788D

Data_02F_4340:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_7897
    dw Data_02F_78B7
    dw Data_02F_7942
    dw Data_02F_7942
    dw Data_02F_795E
    dw Data_02F_7973
    dw Data_02F_79A1
    dw Data_02F_79E7
    dw Data_02F_7A0B
    dw Data_02F_7A25
    dw Data_02F_7A3B
    dw Data_02F_7A63
    dw Data_02F_7A9A
    dw Data_02F_7AB0
    dw Data_02F_7AEF
    dw Data_02F_7B07
    dw Data_02F_7B1C
    dw Data_02F_7B40
    dw Data_02F_7B5E
    dw Data_02F_7B7A
    dw Data_02F_7B9A
    dw Data_02F_7BAD
    dw Data_02F_7BCB
    dw Data_02F_7BE6
    dw Data_02F_7BF8
    dw Data_02F_7C12
    dw Data_02F_7C2E
    dw Data_02F_7C51
    dw Data_02F_7C6B
    dw Data_02F_7C8D
    dw Data_02F_7CA8
    dw Data_02F_7CE2
    dw Data_02F_7CF3
    dw Data_02F_7D11

Data_02F_4384:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $33, $33, $28, $24, $35, $36, $99, $F1, $EC, $F0

Data_02F_4393:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43A7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43BB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43CF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43E3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43F7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F6, $3E, $90, $33, $24, $35, $37, $3C, $90, $3A, $24, $36, $F1, $3A, $2C
    db $33, $28, $27, $90, $32, $38, $37, $99, $E5, $42, $F0

Data_02F_4412:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $3A, $28, $35, $28, $F1, $27
    db $28, $29, $28, $24, $37, $28, $27, $99, $E4, $7E, $FA, $F7, $F0

Data_02F_442F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 left", $F1
    db "the scene.", $EC, $F0

Data_02F_4444:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

Data_02F_4463:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

Data_02F_4482:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "couldn't react!", $EC, $F0

Data_02F_4496:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "appeared stunned!", $EC, $F0

Data_02F_44AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "suddenly attacked!", $EC, $F0

Data_02F_44C5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "without warning!", $EC, $F0

Data_02F_44E2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 can't", $F1
    db "move!", $EC, $F0

Data_02F_4502:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_4522:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_4542:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

Data_02F_4568:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "asleep.", $EC, $F0

Data_02F_4578:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "confused!", $EC, $F0

Data_02F_458A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_45A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "frozen solid!", $EC, $F0

Data_02F_45B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "paralyzed!", $EC, $F0

Data_02F_45CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "dancing along!", $EC, $F0

Data_02F_45E2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shivering!", $EC, $F0

Data_02F_45F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "get back up!", $EC, $F0

Data_02F_460C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cowering in fear!", $EC, $F0

Data_02F_4626:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

Data_02F_4642:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No items allowed", $F1
    db "in this battle!", $F7
    db $F0

Data_02F_4665:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "This item can't be", $F1
    db "used in battle!", $F7
    db $F0

Data_02F_4689:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There are no", $F1
    db "usable items!", $F7
    db $F0

Data_02F_46A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No fleeing from", $F1
    db "this battle!", $F7
    db $F0

Data_02F_46C5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Can't use that", $F1
    db "skill now!", $F7
    db $F0

Data_02F_46E0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Selecting", $F1
    db $F9, "0's move", $A4, $F0

Data_02F_46F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No monsters to", $F1
    db "access PLAN.", $F7
    db $F0

Data_02F_4713:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There is no target", $F1
    db "in sight!", $F7
    db $F0

Data_02F_4732:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill can't", $F1
    db "be used in battle!", $F7
    db $F0

Data_02F_4757:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Not enough MP!", $F1
    db $F7
    db $F0

Data_02F_4769:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Retire now?", $F1
    db $F0

Data_02F_4777:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ignored", $F1
    db "orders!", $EC, $F0

Data_02F_478C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has no usable", $F1
    db "battle skills!", $EC, $F0

Data_02F_47AE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "not recruited!", $EC, $F0

Data_02F_47C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "already recruited.", $EC, $F0

Data_02F_47DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the escape", $F1
    db "route was cut off!", $EC, $F0

Data_02F_47FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there's no one", $F1
    db "to command!", $F7
    db $F0

Data_02F_481E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "at full power!", $EC, $F0

Data_02F_4839:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tucked", $F1
    db "tighter in fear!", $EC, $F0

Data_02F_4856:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

Data_02F_4869:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back, enraged.", $EC, $F0

Data_02F_4884:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Light fell softly", $F1
    db "on ", $F9, "0!", $EC, $F0

Data_02F_489F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ducked", $F1
    db "behind ", $F9, "G!", $EC, $F0

Data_02F_48B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 pumped", $F1
    db "itself up!", $EC, $F0

Data_02F_48CD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 rolled", $F1
    db "out of the way!", $EC, $F0

Data_02F_48E9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4915:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4941:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4973:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_49AA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_49E5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A20:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A5C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to cast a curse!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A96:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4ACE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4AFC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4B2E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4B6A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4BA4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4BDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C14:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C46:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C7A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4CAE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4CE6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But its spells", $F1
    db "are sealed!", $EC, $F0

Data_02F_4D11:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But its mouth is", $F1
    db "sealed tight!", $EC, $F0

Data_02F_4D49:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it can't do", $F1
    db "the dance!", $EC, $F0

Data_02F_4D79:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_4DA6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4DD4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E0A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E38:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E6F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4EAD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4EEB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to build power!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4F27:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4F66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4FA0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4FD5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5010:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5041:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5080:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_50BB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_50F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_512D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5169:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_519E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_51D6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You threw in", $F1
    db "the towel!", $EC, $F0

Data_02F_51F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turns left!", $F1
    db $EC, $F0

Data_02F_5202:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No turns left.", $F1
    db "This ends a draw.", $EC, $F0

Data_02F_5225:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You broke a battle", $F1
    db "rule!", $FA, $F7
    db $F2, "You lose.", $FA, $F7
    db $F0

Data_02F_524D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Your opponent", $F1
    db "broke a rule!", $FA, $F7
    db $F2, "You win.", $FA, $F7
    db $F0

Data_02F_5277:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill isn't", $F1
    db "for own use!", $EC, $F0

Data_02F_5296:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "But it failed!", $EC, $F0

Data_02F_52CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "But it failed!", $EC, $F0

Data_02F_52FC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "But it failed!", $EC, $F0

Data_02F_532D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_5361:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_5393:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_53C4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5408:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5453:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it was sealed!", $EC, $F0

Data_02F_54A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it shattered!", $EC, $F0

Data_02F_54F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5534:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_557F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_55CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5622:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_5671:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_56BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5709:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5758:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_57A4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_57F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_583D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while asleep!", $EC, $F0

Data_02F_5859:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

Data_02F_587A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_5892:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brushed", $F1
    db "off ", $F9, "W!", $EC, $F0

Data_02F_58A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "one to betray!", $F7
    db $F0

Data_02F_58C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the skill was", $F1
    db "sealed!", $EC, $F0

Data_02F_590E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5958:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_599F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_59EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5A35:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5A82:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Monster was", $F1
    db "defeated!"
    db $E4, $7E, $FA, $F7, $F0

Data_02F_5A9C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "was wiped out!"
    db $E5, $42, $F0

Data_02F_5AB8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turn left!", $F1
    db $EC, $F0

Data_02F_5AC9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "attacked!", $EC, $F0

Data_02F_5AD8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5AE6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5AF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5B04:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F0

Data_02F_5B18:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G shot", $F1
    db "from ", $F9, "0!", $EC, $F0

Data_02F_5B2B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "in on ", $F9, "G!", $EC, $F0

Data_02F_5B41:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_5B55:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "receklessly!", $EC, $F0

Data_02F_5B6F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dove at", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5B80:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 flailed", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_5B94:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 smashed", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5BA5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "high!", $EC, $F0

Data_02F_5BB6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

Data_02F_5BD0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "deeply!", $EC, $F0

Data_02F_5BE5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G prayed", $F1
    db "to the wind!", $EC, $F2, $ED, "Blades of air", $F1
    db "slash out!", $EC, $F0

Data_02F_5C19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 yelled", $F1
    db "for help!", $EC, $F0

Data_02F_5C2F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for help!", $EC, $F0

Data_02F_5C45:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

Data_02F_5C58:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "like the wind!", $EC, $F0

Data_02F_5C73:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "mightily!", $EC, $F0

Data_02F_5C89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up vicious winds!", $EC, $F0

Data_02F_5CA8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "lightning forth!", $EC, $F0

Data_02F_5CC6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 hurled", $F1
    db "huge boulders!", $EC, $F0

Data_02F_5CE1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "on an evil light!", $EC, $F2, $ED, "Thunderbolts", $F1
    db "hammered down!", $EC, $F0

Data_02F_5D1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a BigBang!", $EC, $F2, $ED, "Wild explosions", $F1
    db "echoed repeatedly!", $EC, $F0

Data_02F_5D5B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "all magic power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

Data_02F_5D99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 uttered", $F1
    db "a curse!", $EC, $F0

Data_02F_5DAF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db "up a sandstorm!", $EC, $F0

Data_02F_5DCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did an", $F1
    db "odd dance step!", $EC, $F0

Data_02F_5DE7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_5E10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 licked", $F1
    db $F9, "G's face!", $EC, $F0

Data_02F_5E26:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db $F9, "G low!", $EC, $F0

Data_02F_5E3A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G did a", $F1
    db "sweeping kick!", $EC, $F0

Data_02F_5E54:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "a savage roar!", $EC, $F0

Data_02F_5E6F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the earth!", $EC, $F0

Data_02F_5E89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up ", $F9, "G!", $EC, $F0

Data_02F_5E9D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quieted", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5EAE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "to meditate!", $EC, $F2, $ED, $F9, "0's", $F1
    db "wounds healed!", $EC, $F0

Data_02F_5EDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "singing!", $EC, $F0

Data_02F_5EEF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's song", $F1
    db "ended!", $EC, $F0

Data_02F_5F01:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 raised", $F1
    db "a water barrier!", $EC, $F0

Data_02F_5F1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

Data_02F_5F37:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shields", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5F48:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "braced for attack!", $EC, $F0

Data_02F_5F63:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "ready to parry!", $EC, $F0

Data_02F_5F7B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is in a", $F1
    db "defensive pose!", $EC, $F0

Data_02F_5F98:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "for payback!", $EC, $F0

Data_02F_5FB0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is set", $F1
    db "to inhale all!", $EC, $F0

Data_02F_5FCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F0

Data_02F_5FE7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "An invisible force", $F1
    db "pressed down!", $EC, $F0

Data_02F_6023:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shot", $F1
    db "water!", $EC, $F0

Data_02F_6034:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 created", $F1
    db "a huge tidal wave!", $EC, $F0

Data_02F_6054:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6069:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_607E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wound", $F1
    db "was healed!", $EC, $F0

Data_02F_6096:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "brutalized!", $EC, $F0

Data_02F_60AB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_60C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_60D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "use spells now!", $EC, $F0

Data_02F_60F1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's spells", $F1
    db "were sealed!", $EC, $F0

Data_02F_610B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

Data_02F_6126:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

Data_02F_6141:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 started", $F1
    db "glowing!", $EC, $F0

Data_02F_6157:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 stole", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_6168:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "befuddled!", $EC, $F0

Data_02F_617F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

Data_02F_6195:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ATK", $F1
    db "doubled!", $EC, $F0

Data_02F_61A8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into a dragon!", $EC, $F0

Data_02F_61C3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "rose by ", $F9, "G!", $EC, $F0

Data_02F_61D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "turned into iron!", $EC, $F0

Data_02F_61F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into iron!", $EC, $F0

Data_02F_620E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "was cut by ", $F9, "G!", $EC, $F0

Data_02F_6227:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "rose by ", $F9, "G!", $EC, $F0

Data_02F_623D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is lost", $F1
    db "in a daze!", $EC, $F0

Data_02F_6255:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

Data_02F_627C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

Data_02F_62A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A barrier of", $F1
    db "light appeared.", $EC, $F0

Data_02F_62C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cured of poison.", $EC, $F0

Data_02F_62DC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is no", $F1
    db "longer paralyzed.", $EC, $F0

Data_02F_62F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 came", $F1
    db "back to life!", $EC, $F0

Data_02F_6311:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "uncursed!", $EC, $F0

Data_02F_6324:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 assumed", $F1
    db $F9, "G's form!", $EC, $F0

Data_02F_633B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Help arrived from", $F1
    db "seemingly nowhere!", $EC, $F0

Data_02F_6362:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blinded by sand!", $EC, $F0

Data_02F_637C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's vision", $F1
    db "was harmed!", $EC, $F0

Data_02F_6395:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "weakened to magic!", $EC, $F0

Data_02F_63B1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_63C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the dancing!", $EC, $F0

Data_02F_63DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "content!", $EC, $F0

Data_02F_63EE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F0

Data_02F_6404:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F2, $ED, $F9, "0's DEF", $F1
    db "dropped to ", $95, "1", $95, "!", $EC, $F0

Data_02F_6434:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "shocked!", $EC, $F0

Data_02F_6446:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wiped", $F1
    db "out!", $EC, $F0

Data_02F_6456:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

Data_02F_6473:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "back to normal!", $EC, $F0

Data_02F_648F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "fully cured!", $EC, $F0

Data_02F_64A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the battle!", $EC, $F0

Data_02F_64BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_64D6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_64EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

Data_02F_6507:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

Data_02F_651F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_6537:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did not", $F1
    db "come back to life!", $EC, $F0

Data_02F_6557:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But it failed to", $F1
    db "reach ", $F9, "0!", $EC, $F0

Data_02F_6574:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the call went", $F1
    db "unheard!", $EC, $F0

Data_02F_6591:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dodged", $F1
    db "the breath!", $EC, $F0

Data_02F_65A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "covered its ears!", $EC, $F0

Data_02F_65C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off the sand!", $EC, $F0

Data_02F_65E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "its eyes in time!", $EC, $F0

Data_02F_65FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "dodged the attack!", $EC, $F0

Data_02F_661F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wasn't", $F1
    db "taken in!", $EC, $F0

Data_02F_6634:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 slid", $F1
    db "out of the way!", $EC, $F0

Data_02F_664E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "unharmed!", $EC, $F0

Data_02F_6661:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the prayer", $F1
    db "went unanswered!", $EC, $F0

Data_02F_6683:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was put", $F1
    db "to sleep!", $EC, $F0

Data_02F_669A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "asleep!", $EC, $F0

Data_02F_66AC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "poisoned!", $EC, $F0

Data_02F_66BF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

Data_02F_66D6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "terribly poisoned!", $EC, $F0

Data_02F_66F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 froze", $F1
    db "solid!", $EC, $F0

Data_02F_6704:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "frozen solid!", $EC, $F0

Data_02F_671E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back!", $EC, $F0

Data_02F_6730:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "strike back!", $EC, $F0

Data_02F_674A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "counterstrike!", $EC, $F0

Data_02F_675F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "retaliate!", $EC, $F0

Data_02F_6777:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db "back ", $F9, "G!", $EC, $F0

Data_02F_678A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 went", $F1
    db "away!", $EC, $F0

Data_02F_679A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

Data_02F_67B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The help went", $F1
    db "away!", $EC, $F0

Data_02F_67CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "woke up!", $EC, $F0

Data_02F_67D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 snapped", $F1
    db "out of confusion!", $EC, $F0

Data_02F_67F8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "Ironize wore off!", $EC, $F0

Data_02F_6810:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

Data_02F_682B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The giant went", $F1
    db "away laughing!", $EC, $F0

Data_02F_684B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "W", $F1
    db "shattered!", $EC, $F0

Data_02F_685F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 suffers", $F1
    db "from poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_6889:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "wracked by poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_68B4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died!", $F1
    db $EC, $F0

Data_02F_68C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "defeated!", $EC, $F0

Data_02F_68D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died", $F1
    db "from dancing!", $EC, $F0

Data_02F_68EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

Data_02F_68FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "instantly slain!", $EC, $F0

Data_02F_6918:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "0", $F1
    db "shattered!", $EC, $F0

Data_02F_692C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

Data_02F_693F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's prayer", $F1
    db "went unanswered!", $EC, $F0

Data_02F_695D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "SealPray was", $F1
    db "broken!", $EC, $F0

Data_02F_6974:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "flush with power!", $EC, $F0

Data_02F_6992:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db "the ", $F9, "W from", $EC, $F2, $ED, $F9, "G.", $F1
    db $EC, $F0

Data_02F_69AF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat happily!", $EC, $F2, $ED, $F9, "0 grew to", $F1
    db "like ", $F9, "G!", $EC, $F0

Data_02F_69E0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, $F9, "0 glared", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_6A10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held the", $F1
    db $F9, "W aloft!", $EC, $F0

Data_02F_6A28:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A warm light shone", $F1
    db "from the Orb!", $EC, $F0

Data_02F_6A4B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gripped", $F1
    db "the BeastTail!", $EC, $F0

Data_02F_6A67:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The BeastTail", $F1
    db "began pointing!", $EC, $F0

Data_02F_6A87:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held", $F1
    db $F9, "W aloft!", $EC, $F0

Data_02F_6A9B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

Data_02F_6AAC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

Data_02F_6ABD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "spells, dances", $EC, $F2, $ED, "and breaths are", $F1
    db "sealed!", $EC, $F0

Data_02F_6AEC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 used", $F1
    db "the ", $F9, "W!", $EC, $F0

Data_02F_6AFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tossed", $F1
    db "the ", $F9, "W", $EC, $F2, $ED, "at ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_6B1B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the SageRock!", $EC, $F0

Data_02F_6B39:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 scattered", $F1
    db "the WorldDew!", $EC, $F0

Data_02F_6B56:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Bolts of lightning", $F1
    db "lashed out!", $EC, $F0

Data_02F_6B8F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Tornadoes leapt", $F1
    db "from its tip!", $EC, $F0

Data_02F_6BC7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A sinister fog", $F1
    db "descended!", $EC, $F0

Data_02F_6BFB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A blizzard howls", $F1
    db "from its tip!", $EC, $F0

Data_02F_6C34:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Flames leapt from", $F1
    db "its tip!", $EC, $F0

Data_02F_6C69:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a towering geyser!", $EC, $F0

Data_02F_6C89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

Data_02F_6CA3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "looking for a", $F1
    db "chance!", $EC, $F0

Data_02F_6CCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F0

Data_02F_6CF8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The barrier popped", $F1
    db "and disappeared!", $EC, $F0

Data_02F_6D1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6D4A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6D76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "landed safely!", $EC, $F0

Data_02F_6D8A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was", $F1
    db "shattered!", $EC, $F0

Data_02F_6D9E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off ", $F9, "G!", $EC, $F0

Data_02F_6DB1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "shielding a", $F1
    db "partner!", $EC, $F0

Data_02F_6DD8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP was", $F1
    db "restored by ", $F9, "G!", $EC, $F0

Data_02F_6DF5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G began", $EC, $F2, $ED, "to concentrate!", $F1
    db $EC, $F0

Data_02F_6E1A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 was", $F1
    db "unaffected!", $EC, $F0

Data_02F_6E33:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took a", $F1
    db "wild swing!", $EC, $F2, $ED, "And managed to", $F1
    db "hurt only itself!", $EC, $F0

Data_02F_6E6E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shaking in fear!", $EC, $F0

Data_02F_6E87:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F2, $ED, "But tripped and", $F1
    db "wiped out!", $EC, $F0

Data_02F_6EB8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

Data_02F_6ECF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "attack!", $EC, $F2, $ED, "It appears unable", $F1
    db "to move properly.", $EC, $F0

Data_02F_6F03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "dancing!", $EC, $F0

Data_02F_6F17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A foul being was", $F1
    db "summoned!", $EC, $F0

Data_02F_6F34:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 let off", $F1
    db "a black cloud!", $EC, $F0

Data_02F_6F50:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "filled with power!", $EC, $F0

Data_02F_6F68:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all its MP!", $EC, $F0

Data_02F_6F7E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $AA, $0C, $2B, $24, $31, $26, $28, $AB, $90, $0C, $2B, $24, $31, $26, $28
    db $AB, $F1, $0C, $2B, $24, $31, $26, $28, $A4, $AA
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EC, $F2, $ED, "The call echoed", $F1
    db "over and over!", $EC, $F0

Data_02F_6FBB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A laughng giant", $F1
    db "appeared!", $EC, $F2, $ED, "The giant", $F1
    db "attacked!", $EC, $F0

Data_02F_6FED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A cold wind swept", $F1
    db $F9, "0's party!", $EC, $F0

Data_02F_700C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP", $F1
    db "was restored!", $EC, $F0

Data_02F_7023:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Meteors rained", $F1
    db "from the heavens!", $EC, $F0

Data_02F_7046:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

Data_02F_706D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

Data_02F_7094:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 bounced", $EC, $F2, $ED, "the attack!", $F1
    db $EC, $F0

Data_02F_70C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shunted", $F1
    db "the attack!", $EC, $F0

Data_02F_70D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 failed", $F1
    db "to avert attack!", $EC, $F0

Data_02F_70F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 guarded", $F1
    db $F9, "G!", $EC, $F0

Data_02F_7107:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "the attack!", $EC, $F0

Data_02F_7120:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But nothing", $F1
    db "happened!", $EC, $F0

Data_02F_7138:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_714E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 didn't", $F1
    db "fall asleep!", $EC, $F0

Data_02F_7166:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "more confused!", $EC, $F0

Data_02F_7181:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "was unharmed!", $EC, $F0

Data_02F_719A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "avoided damage!", $EC, $F0

Data_02F_71B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "out of the way!", $EC, $F0

Data_02F_71D0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0, "leapt "

Data_02F_71E9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "already asleep!", $EC, $F0

Data_02F_7201:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is now", $F1
    db "weak to spells!", $EC, $F0

Data_02F_721D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A gentle rain", $F1
    db "fell!", $EC, $F0

Data_02F_7233:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 has", $F1
    db "been immobilized!", $EC, $F0

Data_02F_724E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fled!", $F1
    db $EC, $F0

Data_02F_725A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cursed!", $EC, $F0

Data_02F_726B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "building power!", $EC, $F0

Data_02F_7283:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

Data_02F_72A0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_72C9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blown sky-high!", $EC, $F0

Data_02F_72E2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_72FB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "its MP!", $EC, $F0

Data_02F_730D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

Data_02F_7329:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

Data_02F_7342:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "dizzy and fell!", $EC, $F0

Data_02F_735B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "balance and fell!", $EC, $F0

Data_02F_7377:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "down, asleep!", $EC, $F0

Data_02F_7392:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "and woke up!", $EC, $F0

Data_02F_73A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

Data_02F_73CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

Data_02F_73E5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

Data_02F_7400:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

Data_02F_741D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

Data_02F_743A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F0

Data_02F_7466:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "BlazeMost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db $EC, $F0

Data_02F_74A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G blasted", $EC, $F2, $ED, "a Tidalwave with", $F1
    db "shockwaves to make", $EC, $F2, $ED, "WaveBlast!", $F1
    db $EC, $F0

Data_02F_74EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tore", $EC, $F2, $ED, "tornadoes with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageAir!", $F1
    db $EC, $F0

Data_02F_752D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G rocked", $EC, $F2, $ED, "the ground with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageQuake!", $F1
    db $EC, $F0

Data_02F_7574:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two GigaSlashes", $F1
    db "into GigaBreak!", $EC, $F0

Data_02F_75A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two Sacrifices", $F1
    db "into Martyr!", $EC, $F0

Data_02F_75DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G hurled", $EC, $F2, $ED, $F9, "W high", $F1
    db "and dropped it!", $EC, $F0

Data_02F_7607:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G made", $EC, $F2, $ED, "SquallHit faster", $F1
    db "using SpeedUp!", $EC, $F0

Data_02F_763A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

Data_02F_768F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F0

Data_02F_76C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F0

Data_02F_76F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "into a huge", $F1
    db "dragon!", $EC, $F0

Data_02F_7719:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "their skills into", $F1
    db "a wave of energy!", $EC, $F0

Data_02F_7752:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G loosed", $EC, $F2, $ED, "a white, obscuring", $F1
    db "cloud!", $EC, $F0

Data_02F_7781:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, "a vacuum for", $F1
    db "stealing MP!", $EC, $F0

Data_02F_77B0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

Data_02F_77C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

Data_02F_77D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $ED, "The monsters ate", $F1
    db "the meat happily!", $EC, $F2, $ED, "The monsters grew", $F1
    db "to like ", $F9, "G!", $EC, $F0

Data_02F_7818:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, "Monsters glared", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_7854:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters were", $F1
    db "filled with power!", $EC, $F0

Data_02F_7877:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

Data_02F_787D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

Data_02F_7882:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

Data_02F_7888:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

Data_02F_788D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined", $F0

Data_02F_7897:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $EE, $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "'s party got", $EF, $EE, $F9, "0 EX points!", $FA, $F7
    db $F0

Data_02F_78B7:: ; heuristic: target of a monotone pointer table; C0
    db $E5, $00
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "promoted to Lv", $F9, "G!"
    INCBIN "dwm2-cobi-us.gbc", $0BF8D2, $6B
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "q", $FA, $F7
    db $F0

Data_02F_7942:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "At Lv", $F9, "G, ", $F9, "0 ", $F1
    db "learned ", $F9, "W!", $FA, $F7
    db $F0

Data_02F_795E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ", $F9, "m", $F1
    db "became ", $F9, "W!", $FA, $F7
    db $F0

Data_02F_7973:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 devised", $F1
    db $F9, "W from the", $FA, $F7
    db $F2, $ED, "skills it knows!", $FA, $F7
    db $F0

Data_02F_79A1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 can't", $F1
    db "learn more skills!", $FA, $F7
    db $F2, $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

Data_02F_79E7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

Data_02F_7A0B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Forget ", $F9, "W?", $F1
    db "Are you sure?", $F0

Data_02F_7A25:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "W was", $F1
    db "forgottten.", $FA, $F7
    db $F0

Data_02F_7A3B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has reached the", $F1
    db "limit for growth.", $FA, $F7
    db $F0

Data_02F_7A63:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "Allow ", $F9, "0 ", $F1
    db "to join you?", $F0

Data_02F_7A9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "departed sadly", $A4, $FA, $F7
    db $F0

Data_02F_7AB0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "more room!", $FA, $F7
    db $F2, $ED, "Release a monster", $F1
    db "to make room?", $F0

Data_02F_7AEF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which will you", $F1
    db "choose?", $F0

Data_02F_7B07:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You have no eggs.", $FA, $F7
    db $F0

Data_02F_7B1C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Release a monster", $F1
    db "for the new one?", $F0

Data_02F_7B40:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose a monster", $F1
    db "to release.", $F0

Data_02F_7B5E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Do you want to", $F1
    db "release ", $F9, "G?", $F0

Data_02F_7B7A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was set", $F1
    db "free in the wild.", $FA, $F7
    db $F0

Data_02F_7B9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Please name", $F1
    db $F9, "0.", $FA, $F7
    db $F0

Data_02F_7BAD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You can't travel", $F1
    db "all alone.", $FA, $F7
    db $F0

Data_02F_7BCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose an egg to", $F1
    db "abandon.", $F0

Data_02F_7BE6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Abandon ", $F9, "G's", $F1
    db "egg?", $F0

Data_02F_7BF8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G's egg", $F1
    db "was abandoned.", $FA, $F7
    db $F0

Data_02F_7C12:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Will you take", $F1
    db $F9, "0 with you?", $F0

Data_02F_7C2E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent", $F1
    db "back to the farm."
    db $E5, $D6, $FA, $F7, $F0

Data_02F_7C51:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party."
    db $E5, $D6, $FA, $F7, $F0

Data_02F_7C6B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose the monster", $F1
    db "to send home.", $F0

Data_02F_7C8D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Send ", $F9, "0 back to", $F1
    db "the farm?", $F0

Data_02F_7CA8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "But it sadly went", $F1
    db "away", $A4, $FA, $F7
    db $F0

Data_02F_7CE2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 learned", $F1
    db $F9, "G!", $F7
    db $F0

Data_02F_7CF3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent to", $F1
    db "the farm."
    db $E5, $54, $FA, $F7, $F0

Data_02F_7D11:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party."
    db $E5, $54, $FA, $F7, $F0
    ds $2D5, $00
