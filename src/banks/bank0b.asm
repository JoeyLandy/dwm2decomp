SECTION "Bank 0B", ROMX[$4000], BANK[$0B]
    db $0B

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank0B, DebugMessageTest_Update_Case20)
BeginStringDisplay_Bank0B::
Func_00B_4001:: ; address name
    ld de, Data_00B_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_00B_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 6 call sites from 5 routines (e.g. ScriptCommandF6_Run_Case10_Case04, ScriptCommandF6_Run_Case10_Case05, ScriptCommandF6_Run_Case10_Case07, ScriptCommandF6_Run_Case10_Case06_Sub01, ...)
ShowString_Bank0B::
Func_00B_400F:: ; address name
    call BeginStringDisplay_Bank0B
    call RunStringDisplayToEnd
    ret

Data_00B_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00B_401C
    dw Data_00B_421C
    dw Data_00B_4326

Data_00B_401C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_433C
    dw Data_00B_4340
    dw Data_00B_437A
    dw Data_00B_43BD
    dw Data_00B_43DE
    dw Data_00B_43FE
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4442
    dw Data_00B_4467
    dw Data_00B_4489
    dw Data_00B_44AD
    dw Data_00B_44CD
    dw Data_00B_44EB
    dw Data_00B_4509
    dw Data_00B_452A
    dw Data_00B_4550
    dw Data_00B_456F
    dw Data_00B_4590
    dw Data_00B_45B2
    dw Data_00B_45D1
    dw Data_00B_45F4
    dw Data_00B_4617
    dw Data_00B_4636
    dw Data_00B_4657
    dw Data_00B_467C
    dw Data_00B_469A
    dw Data_00B_46BC
    dw Data_00B_46DF
    dw Data_00B_4701
    dw Data_00B_471D
    dw Data_00B_473D
    dw Data_00B_4759
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_479D
    dw Data_00B_47BA
    dw Data_00B_47DC
    dw Data_00B_47FE
    dw Data_00B_481E
    dw Data_00B_483E
    dw Data_00B_485F
    dw Data_00B_487E
    dw Data_00B_48A3
    dw Data_00B_48C5
    dw Data_00B_48E9
    dw Data_00B_490A
    dw Data_00B_492A
    dw Data_00B_494E
    dw Data_00B_496B
    dw Data_00B_4990
    dw Data_00B_49B2
    dw Data_00B_49D2
    dw Data_00B_49F0
    dw Data_00B_4A13
    dw Data_00B_4A32
    dw Data_00B_4A55
    dw Data_00B_4A79
    dw Data_00B_4A9C
    dw Data_00B_4AC0
    dw Data_00B_4AE0
    dw Data_00B_4AFE
    dw Data_00B_4B21
    dw Data_00B_4B41
    dw Data_00B_4B65
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4BAF
    dw Data_00B_4BD3
    dw Data_00B_4BF6
    dw Data_00B_4C18
    dw Data_00B_4C3D
    dw Data_00B_4C57
    dw Data_00B_4C76
    dw Data_00B_4C9A
    dw Data_00B_4CBA
    dw Data_00B_4CDB
    dw Data_00B_4CFE
    dw Data_00B_4D21
    dw Data_00B_4D45
    dw Data_00B_4D65
    dw Data_00B_4D86
    dw Data_00B_4DA7
    dw Data_00B_4DC8
    dw Data_00B_4DE5
    dw Data_00B_4E03
    dw Data_00B_4E27
    dw Data_00B_4E46
    dw Data_00B_4E66
    dw Data_00B_4E85
    dw Data_00B_4EA6
    dw Data_00B_4EC7
    dw Data_00B_4EEA
    dw Data_00B_4F0B
    dw Data_00B_4F2E
    dw Data_00B_4F4C
    dw Data_00B_4F70
    dw Data_00B_4F95
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FDA
    dw Data_00B_4FF8
    dw Data_00B_501C
    dw Data_00B_503B
    dw Data_00B_505C
    dw Data_00B_507B
    dw Data_00B_509B
    dw Data_00B_50BF
    dw Data_00B_50E1
    dw Data_00B_5106
    dw Data_00B_5129
    dw Data_00B_514C
    dw Data_00B_5167
    dw Data_00B_518A
    dw Data_00B_51AB
    dw Data_00B_51CD
    dw Data_00B_51EC
    dw Data_00B_520D
    dw Data_00B_522A
    dw Data_00B_5249
    dw Data_00B_526F
    dw Data_00B_5290
    dw Data_00B_52B3
    dw Data_00B_52CF
    dw Data_00B_52F1
    dw Data_00B_5316
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5352
    dw Data_00B_5370
    dw Data_00B_5390
    dw Data_00B_53AD
    dw Data_00B_53CF
    dw Data_00B_53F1
    dw Data_00B_5413
    dw Data_00B_5431
    dw Data_00B_5456
    dw Data_00B_5478
    dw Data_00B_549B
    dw Data_00B_54B9
    dw Data_00B_54DB
    dw Data_00B_54FE
    dw Data_00B_5520
    dw Data_00B_553D
    dw Data_00B_5559
    dw Data_00B_557E
    dw Data_00B_559F
    dw Data_00B_55C2
    dw Data_00B_55E6
    dw Data_00B_560A
    dw Data_00B_562A
    dw Data_00B_5649
    dw Data_00B_566F
    dw Data_00B_568D
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56D4
    dw Data_00B_56F5
    dw Data_00B_5712
    dw Data_00B_5731
    dw Data_00B_5756
    dw Data_00B_5775
    dw Data_00B_5795
    dw Data_00B_57B3
    dw Data_00B_57D3
    dw Data_00B_57F5
    dw Data_00B_5816
    dw Data_00B_5837
    dw Data_00B_5858
    dw Data_00B_587A
    dw Data_00B_589D
    dw Data_00B_58C3
    dw Data_00B_58E2
    dw Data_00B_5904
    dw Data_00B_5924
    dw Data_00B_5946
    dw Data_00B_5969
    dw Data_00B_598F
    dw Data_00B_59AF
    dw Data_00B_59D1
    dw Data_00B_59F5
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A34
    dw Data_00B_5A57
    dw Data_00B_5A7A
    dw Data_00B_5A9A
    dw Data_00B_5ABE
    dw Data_00B_5AE2
    dw Data_00B_5B02
    dw Data_00B_5B26
    dw Data_00B_5B46
    dw Data_00B_5B65
    dw Data_00B_5B88
    dw Data_00B_5BAD
    dw Data_00B_5BCC
    dw Data_00B_5BEC
    dw Data_00B_5C0B
    dw Data_00B_5C31
    dw Data_00B_5C50
    dw Data_00B_5C73
    dw Data_00B_5C95
    dw Data_00B_5CB9
    dw Data_00B_5CD5
    dw Data_00B_5CF6
    dw Data_00B_5D17
    dw Data_00B_5D37
    dw Data_00B_5D5D
    dw Data_00B_5D7D
    dw Data_00B_5D9A
    dw Data_00B_5DBB

Data_00B_421C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_5DDF
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E25
    dw Data_00B_5E48
    dw Data_00B_5E6A
    dw Data_00B_5E89
    dw Data_00B_5EAC
    dw Data_00B_5ECC
    dw Data_00B_5EEE
    dw Data_00B_5F0D
    dw Data_00B_5F32
    dw Data_00B_5F52
    dw Data_00B_5F76
    dw Data_00B_5F96
    dw Data_00B_5FB8
    dw Data_00B_5FD7
    dw Data_00B_5FF9
    dw Data_00B_601F
    dw Data_00B_6040
    dw Data_00B_6063
    dw Data_00B_6086
    dw Data_00B_60A4
    dw Data_00B_60CA
    dw Data_00B_60EC
    dw Data_00B_610F
    dw Data_00B_6130
    dw Data_00B_6151
    dw Data_00B_6170
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_61B8
    dw Data_00B_61D9
    dw Data_00B_61F9
    dw Data_00B_621B
    dw Data_00B_6240
    dw Data_00B_6263
    dw Data_00B_6285
    dw Data_00B_62A8
    dw Data_00B_62C6
    dw Data_00B_62E7
    dw Data_00B_630A
    dw Data_00B_6325
    dw Data_00B_634A
    dw Data_00B_636D
    dw Data_00B_6390
    dw Data_00B_63B6
    dw Data_00B_63D9
    dw Data_00B_63F9
    dw Data_00B_6415
    dw Data_00B_6439
    dw Data_00B_645F
    dw Data_00B_6483
    dw Data_00B_64A5
    dw Data_00B_64CA
    dw Data_00B_64EE
    dw Data_00B_6513
    dw Data_00B_6537
    dw Data_00B_655B
    dw Data_00B_657A
    dw Data_00B_6598
    dw Data_00B_65BA
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65F3
    dw Data_00B_6615
    dw Data_00B_6634
    dw Data_00B_6653
    dw Data_00B_6673
    dw Data_00B_6695
    dw Data_00B_66B8
    dw Data_00B_66DC
    dw Data_00B_66FC
    dw Data_00B_671D
    dw Data_00B_6743
    dw Data_00B_6768
    dw Data_00B_678D
    dw Data_00B_67AE
    dw Data_00B_67D1
    dw Data_00B_67F3
    dw Data_00B_6817
    dw Data_00B_6833
    dw Data_00B_6855
    dw Data_00B_6874
    dw Data_00B_6895
    dw Data_00B_68B6
    dw Data_00B_68D9
    dw Data_00B_68FE
    dw Data_00B_6923
    dw Data_00B_6945
    dw Data_00B_6967
    dw Data_00B_698A
    dw Data_00B_69AB
    dw Data_00B_69D0
    dw Data_00B_69F5
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A3A
    dw Data_00B_6A5E
    dw Data_00B_6A7C
    dw Data_00B_6AA2
    dw Data_00B_6AC4
    dw Data_00B_6AE9
    dw Data_00B_6B0B
    dw Data_00B_6B2F
    dw Data_00B_6B4D
    dw Data_00B_6B70
    dw Data_00B_6B8E
    dw Data_00B_6BB1
    dw Data_00B_6BD4
    dw Data_00B_6BF6
    dw Data_00B_6C18
    dw Data_00B_6C36
    dw Data_00B_6C5B
    dw Data_00B_6C77
    dw Data_00B_6C95
    dw Data_00B_6CB4
    dw Data_00B_6CD4

Data_00B_4326:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_6CF1
    dw Data_00B_6CF7
    dw Data_00B_6CFE
    dw Data_00B_6D04
    dw Data_00B_6D09
    dw Data_00B_6D0F
    dw Data_00B_6D13
    dw Data_00B_6D19
    dw Data_00B_6D20
    dw Data_00B_6D29
    dw Data_00B_6D2F

Data_00B_433C:: ; heuristic: target of a monotone pointer table; C0
    db $98, $98, $98, $F0

Data_00B_4340:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "library.", $FA, $F7
    db $F2, "Which family will", $F1
    db "you check?", $F0

Data_00B_437A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come back if you", $F1
    db "need to check up", $FA, $F7
    db $EF, $EE, "on your monster", $EF, $EE, "Catalog.", $F7
    db $F0

Data_00B_43BD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which species", $F1
    db "will you check?", $F0

Data_00B_43DE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which family", $F1
    db "will you check?", $F0

Data_00B_43FE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That family is a", $F1
    db "mystery still", $A4, $F7
    db $F0

Data_00B_4422:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A slime that has", $F1
    db "dragon's blood.", $F0

Data_00B_4442:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Recognized by its", $F1
    db "distinctive spots.", $F0

Data_00B_4467:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies by flapping", $F1
    db "ear-like wings.", $F0

Data_00B_4489:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sunlight redoubles", $F1
    db "its usual power.", $F0

Data_00B_44AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its rugged shell", $F1
    db "makes it slow.", $F0

Data_00B_44CD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The slime shields", $F1
    db "the knight.", $F0

Data_00B_44EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Venom dissolved", $F1
    db "its own body.", $F0

Data_00B_4509:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Although cubical,", $F1
    db "it is squishy.", $F0

Data_00B_452A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The body grew hard", $F1
    db "in the hard shell.", $F0

Data_00B_4550:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No.1 in softness", $F1
    db "and weakness.", $F0

Data_00B_456F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heals others with", $F1
    db "its tentacles.", $F0

Data_00B_4590:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The mane attests", $F1
    db "to its ferocity.", $F0

Data_00B_45B2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Likes to drop on", $F1
    db "foes heavily.", $F0

Data_00B_45D1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enhanced for speed", $F1
    db "and durability.", $F0

Data_00B_45F4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its huge legs are", $F1
    db "its main assets.", $F0

Data_00B_4617:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lives up to its", $F1
    db "name in power.", $F0

Data_00B_4636:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hard and fast, it", $F1
    db "flees quickly.", $F0

Data_00B_4657:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Extremely hard and", $F1
    db "prone to fleeing.", $F0

Data_00B_467C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The largest of", $F1
    db "spotted slime.", $F0

Data_00B_469A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cheerful slime", $F1
    db "that loves heat.", $F0

Data_00B_46BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prefers to make", $F1
    db "its enemies laugh.", $F0

Data_00B_46DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The halo is used", $F1
    db "to bind enemies.", $F0

Data_00B_4701:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body is", $F1
    db "extremely hard.", $F0

Data_00B_471D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its golden body is", $F1
    db "unbreakable.", $F0

Data_00B_473D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The wise elder", $F1
    db "among slime.", $F0

Data_00B_4759:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What lurks inside", $F1
    db "is a mystery.", $F0

Data_00B_4779:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Despite its name,", $F1
    db "it never changes.", $F0

Data_00B_479D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slow, but heavily", $F1
    db "protected.", $F0

Data_00B_47BA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its beaks never", $F1
    db "miss flying prey.", $F0

Data_00B_47DC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gases in its body", $F1
    db "keep it afloat.", $F0

Data_00B_47FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Also known as", $F1
    db "butterfly dragon.", $F0

Data_00B_481E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An accomplished", $F1
    db "user of swords.", $F0

Data_00B_483E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lives quietly in", $F1
    db "poisonous bogs.", $F0

Data_00B_485F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs with sword-", $F1
    db "like spikes.", $F0

Data_00B_487E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Agile and equipped", $F1
    db "with sharp claws.", $F0

Data_00B_48A3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breathes fire of", $F1
    db "great intensity.", $F0

Data_00B_48C5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Runs fast, but in", $F1
    db "a comical manner.", $F0

Data_00B_48E9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its power is best", $F1
    db "among dragons.", $F0

Data_00B_490A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It flies with a", $F1
    db "rocking motion.", $F0

Data_00B_492A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Changes its colors", $F1
    db "to confuse foes.", $F0

Data_00B_494E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Works and attacks", $F1
    db "in droves.", $F0

Data_00B_496B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The wings are used", $F1
    db "for intimidation.", $F0

Data_00B_4990:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes foes with", $F1
    db "venomous fangs.", $F0

Data_00B_49B2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Adept at making", $F1
    db "aerial attacks.", $F0

Data_00B_49D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks with its", $F1
    db "long tongue.", $F0

Data_00B_49F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breaks foes as if", $F1
    db "they were rocks.", $F0

Data_00B_4A13:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Great in both", $F1
    db "power and looks.", $F0

Data_00B_4A32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shakes its comb", $F1
    db "when facing a foe.", $F0

Data_00B_4A55:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spreads its wings", $F1
    db "for intimidation.", $F0

Data_00B_4A79:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes hard to KO", $F1
    db "foes instantly.", $F0

Data_00B_4A9C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thinks five times", $F1
    db "faster than foes.", $F0

Data_00B_4AC0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wildly swings its", $F1
    db "ax in battle.", $F0

Data_00B_4AE0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seeks prey with", $F1
    db "its whiskers.", $F0

Data_00B_4AFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The snakes it ate", $F1
    db "became its feet.", $F0

Data_00B_4B21:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons clouds and", $F1
    db "causes rain.", $F0

Data_00B_4B41:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body hardened", $F1
    db "from hibernation.", $F0

Data_00B_4B65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Proud of its power", $F1
    db "and enormous size.", $F0

Data_00B_4B8B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Captures and eats", $F1
    db "foes in one gulp.", $F0

Data_00B_4BAF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn glows to", $F1
    db "confound enemies.", $F0

Data_00B_4BD3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies in close and", $F1
    db "claws savagely.", $F0

Data_00B_4BF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fluffy fur", $F1
    db "offers protection.", $F0

Data_00B_4C18:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its armor is made", $F1
    db "of patched leaves.", $F0

Data_00B_4C3D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It acts before it", $F1
    db "thinks.", $F0

Data_00B_4C57:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It never lets go", $F1
    db "of the skull.", $F0

Data_00B_4C76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shapes wind into", $F1
    db "powerful barriers.", $F0

Data_00B_4C9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks prey in a", $F1
    db "biting swarm.", $F0

Data_00B_4CBA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snags prey with", $F1
    db "its ropy tongue.", $F0

Data_00B_4CDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances to cheer up", $F1
    db "the atmosphere.", $F0

Data_00B_4CFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horned shell", $F1
    db "is a good weapon.", $F0

Data_00B_4D21:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its humorous face", $F1
    db "makes it popular.", $F0

Data_00B_4D45:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has difficulty", $F1
    db "with the hammer.", $F0

Data_00B_4D65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its claws inflict", $F1
    db "wicked damage.", $F0

Data_00B_4D86:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It is difficult to", $F1
    db "spot in snow.", $F0

Data_00B_4DA7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It never misses", $F1
    db "with its arrows.", $F0

Data_00B_4DC8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Never loses in the", $F1
    db "darkness.", $F0

Data_00B_4DE5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leaps out of trees", $F1
    db "to attack.", $F0

Data_00B_4E03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Burrows using its", $F1
    db "oversized shovel.", $F0

Data_00B_4E27:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies using its", $F1
    db "ears as wings.", $F0

Data_00B_4E46:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its horn slays", $F1
    db "foes painlessly.", $F0

Data_00B_4E66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horns curled", $F1
    db "from butting.", $F0

Data_00B_4E85:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves fast in", $F1
    db "spite of its size.", $F0

Data_00B_4EA6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "with its trunk.", $F0

Data_00B_4EC7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slaughters foes", $F1
    db "with its forelegs.", $F0

Data_00B_4EEA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grips and hurls", $F1
    db "foes with horns.", $F0

Data_00B_4F0B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Friendly despite", $F1
    db "its savage looks.", $F0

Data_00B_4F2E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sits quietly to", $F1
    db "avoid hunger.", $F0

Data_00B_4F4C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses mean looks to", $F1
    db "intimidate foes.", $F0

Data_00B_4F70:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A 100-year old cat", $F1
    db "capable of magic.", $F0

Data_00B_4F95:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Polishes its sword", $F1
    db "shiny every day.", $F0

Data_00B_4FB9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts mates", $F1
    db "with its plumage.", $F0

Data_00B_4FDA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A bird with a bug-", $F1
    db "like body.", $F0

Data_00B_4FF8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lack of exercise", $F1
    db "stunted its wings.", $F0

Data_00B_501C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The facial flower", $F1
    db "is stuck on.", $F0

Data_00B_503B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It spreads its", $F1
    db "limbs and glides.", $F0

Data_00B_505C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Very cowardly.", $F1
    db "Likely to flee.", $F0

Data_00B_507B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Always carries its", $F1
    db "skull roost.", $F0

Data_00B_509B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Almost invisible", $F1
    db "except for a glow.", $F0

Data_00B_50BF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It slices through", $F1
    db "water speedily.", $F0

Data_00B_50E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides in darkness", $F1
    db "and sneak attacks.", $F0

Data_00B_5106:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hunts using the", $F1
    db "eyes on its wings.", $F0

Data_00B_5129:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Constant naps made", $F1
    db "this fowl huge.", $F0

Data_00B_514C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Delivers harsh", $F1
    db "head-butts.", $F0

Data_00B_5167:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hoots forlornly", $F1
    db "night after night.", $F0

Data_00B_518A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pecks foes by", $F1
    db "twisting its neck.", $F0

Data_00B_51AB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hooks and tears", $F1
    db "with sharp claws.", $F0

Data_00B_51CD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has eyes on its", $F1
    db "body and head.", $F0

Data_00B_51EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Adept at freezing", $F1
    db "foes immobile.", $F0

Data_00B_520D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Incinerates foes", $F1
    db "to nothing.", $F0

Data_00B_522A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wraps foes in", $F1
    db "white lightning.", $F0

Data_00B_5249:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dives from the sky", $F1
    db "and kicks foes up.", $F0

Data_00B_526F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smashes foes flat", $F1
    db "with its body.", $F0

Data_00B_5290:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances adroitly", $F1
    db "despite its girth.", $F0

Data_00B_52B3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has rainbow horns", $F1
    db "and tail.", $F0

Data_00B_52CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies and runs at", $F1
    db "the same speed.", $F0

Data_00B_52F1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thick-skinned and", $F1
    db "powerfully winged.", $F0

Data_00B_5316:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slides on its", $F1
    db "belly on ice.", $F0

Data_00B_5332:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thumps along on", $F1
    db "its thin vines.", $F0

Data_00B_5352:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spits fire-hot", $F1
    db "seeds at foes.", $F0

Data_00B_5370:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Frail, but sharply", $F1
    db "intelligent.", $F0

Data_00B_5390:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It floats rather", $F1
    db "than flies.", $F0

Data_00B_53AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spins to fire its", $F1
    db "needles wildly.", $F0

Data_00B_53CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Closes its eye and", $F1
    db "mouth to hide.", $F0

Data_00B_53F1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scatters toxic", $F1
    db "spores by dancing.", $F0

Data_00B_5413:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its face hardened", $F1
    db "into amber.", $F0

Data_00B_5431:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swallows prey with", $F1
    db "its giant tongue.", $F0

Data_00B_5456:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks the unwary", $F1
    db "who sit on it.", $F0

Data_00B_5478:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body fluids", $F1
    db "cause watery eyes.", $F0

Data_00B_549B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances to make", $F1
    db "foes careless.", $F0

Data_00B_54B9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Usually calm, but", $F1
    db "easily enraged.", $F0

Data_00B_54DB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Closes its mouth", $F1
    db "to wait for prey.", $F0

Data_00B_54FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It glares to lay a", $F1
    db "curse on foes.", $F0

Data_00B_5520:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It dies if it", $F1
    db "stops dancing.", $F0

Data_00B_553D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fires beans from", $F1
    db "its belly.", $F0

Data_00B_5559:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides underground", $F1
    db "until it gets hot.", $F0

Data_00B_557E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eats prey whole", $F1
    db "without chewing.", $F0

Data_00B_559F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eats rapidly with", $F1
    db "its three heads.", $F0

Data_00B_55C2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Embraces foes and", $F1
    db "drains nutrients.", $F0

Data_00B_55E6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "with thorny vines.", $F0

Data_00B_560A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Represents the", $F1
    db "anger of plants.", $F0

Data_00B_562A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A mischievous", $F1
    db "plant elemantal.", $F0

Data_00B_5649:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An intelligent but", $F1
    db "odd ball of fluff.", $F0

Data_00B_566F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Forces foes to", $F1
    db "dance with it.", $F0

Data_00B_568D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A universal hero", $F1
    db "among its kind.", $F0

Data_00B_56AE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks in a slow,", $F1
    db "deliberate manner.", $F0

Data_00B_56D4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its stumpy feet", $F1
    db "limit its speed.", $F0

Data_00B_56F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags prey under", $F1
    db "the ground.", $F0

Data_00B_5712:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scatters dust to", $F1
    db "confuse foes.", $F0

Data_00B_5731:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A flower grew onto", $F1
    db "it while in soil.", $F0

Data_00B_5756:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Constricts foes", $F1
    db "with its body.", $F0

Data_00B_5775:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lips conceal a", $F1
    db "long tongue.", $F0

Data_00B_5795:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its hard shell", $F1
    db "make it tough.", $F0

Data_00B_57B3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs and sucks", $F1
    db "with its mouth.", $F0

Data_00B_57D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but moves", $F1
    db "in large groups.", $F0

Data_00B_57F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Always hops for", $F1
    db "unknown reasons.", $F0

Data_00B_5816:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bites using mouths", $F1
    db "on both ends.", $F0

Data_00B_5837:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings side to", $F1
    db "side as it moves.", $F0

Data_00B_5858:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Climbs walls using", $F1
    db "its tentacles.", $F0

Data_00B_587A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stifles foes with", $F1
    db "its large wings.", $F0

Data_00B_589D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its eyes extend to", $F1
    db "spot far-off foes.", $F0

Data_00B_58C3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its claws can't", $F1
    db "nick the shell.", $F0

Data_00B_58E2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tail stinger", $F1
    db "is the finisher.", $F0

Data_00B_5904:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its loud buzzing", $F1
    db "gives it away.", $F0

Data_00B_5924:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs and hacks", $F1
    db "with its scythes.", $F0

Data_00B_5946:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn is used", $F1
    db "to hit and parry.", $F0

Data_00B_5969:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The sickles are as", $F1
    db "large as its body.", $F0

Data_00B_598F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The stinger is a", $F1
    db "fierce weapon.", $F0

Data_00B_59AF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dislikes water and", $F1
    db "lives in soil.", $F0

Data_00B_59D1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capable of moving", $F1
    db "in any direction.", $F0

Data_00B_59F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its many eyes don't", $F1
    db "miss a thing.", $F0

Data_00B_5A16:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prefers mischief", $F1
    db "over eating.", $F0

Data_00B_5A34:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tentacles are", $F1
    db "actually snakes.", $F0

Data_00B_5A57:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hates getting its", $F1
    db "white fur dirty.", $F0

Data_00B_5A7A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Intelligent, but", $F1
    db "far too frail.", $F0

Data_00B_5A9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tentacles are", $F1
    db "tipped with eyes.", $F0

Data_00B_5ABE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its eye has a 360-", $F1
    db "degree coverage.", $F0

Data_00B_5AE2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Never dismounts", $F1
    db "from the skull.", $F0

Data_00B_5B02:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Intimidates with", $F1
    db "red, glaring eyes.", $F0

Data_00B_5B26:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its foam lets it", $F1
    db "dodge attacks.", $F0

Data_00B_5B46:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but deadly", $F1
    db "with spells.", $F0

Data_00B_5B65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies incredibly", $F1
    db "fast in mischief.", $F0

Data_00B_5B88:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs foes through", $F1
    db "with its trident.", $F0

Data_00B_5BAD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Loves to fight,", $F1
    db "defeating all.", $F0

Data_00B_5BCC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stays red-faced", $F1
    db "from straining.", $F0

Data_00B_5BEC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The spear is", $F1
    db "largely for show.", $F0

Data_00B_5C0B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings spiked orbs", $F1
    db "to keep foes away.", $F0

Data_00B_5C31:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides and strikes", $F1
    db "in darkness.", $F0

Data_00B_5C50:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses its agility", $F1
    db "to confound foes.", $F0

Data_00B_5C73:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Even its head is", $F1
    db "full of muscles.", $F0

Data_00B_5C95:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn and fangs", $F1
    db "are its weapons.", $F0

Data_00B_5CB9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strong. Just", $F1
    db "incredibly so.", $F0

Data_00B_5CD5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What the armor", $F1
    db "hides is unknown.", $F0

Data_00B_5CF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Waits in wells for", $F1
    db "prey to come.", $F0

Data_00B_5D17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings for the", $F1
    db "foe's weak spots.", $F0

Data_00B_5D37:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surprisingly agile", $F1
    db "for its heftiness.", $F0

Data_00B_5D5D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The armor gives it", $F1
    db "great power.", $F0

Data_00B_5D7D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tracks foes", $F1
    db "with three eyes.", $F0

Data_00B_5D9A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seeks out battles", $F1
    db "for enjoyment.", $F0

Data_00B_5DBB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "When enraged, the", $F1
    db "horns straighten.", $F0

Data_00B_5DDF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cruel demon that", $F1
    db "distorts wishes.", $F0

Data_00B_5E03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fades in and out", $F1
    db "to scare people.", $F0

Data_00B_5E25:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Created from the", $F1
    db "bones of dragons.", $F0

Data_00B_5E48:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It isn't bothered", $F1
    db "by new injuries.", $F0

Data_00B_5E6A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags stragglers", $F1
    db "off to death.", $F0

Data_00B_5E89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bandages obscure", $F1
    db "its vision badly.", $F0

Data_00B_5EAC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its dark soul", $F1
    db "stained its body.", $F0

Data_00B_5ECC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unable to stop", $F1
    db "fighting in death.", $F0

Data_00B_5EEE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It lost its body", $F1
    db "due to magic.", $F0

Data_00B_5F0D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rocks side to side", $F1
    db "as it approaches.", $F0

Data_00B_5F32:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dead, rotten, and", $F1
    db "not at peace.", $F0

Data_00B_5F52:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shoots dirt from", $F1
    db "all over its body.", $F0

Data_00B_5F76:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capable of going", $F1
    db "through walls.", $F0

Data_00B_5F96:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A shy soul, it", $F1
    db "swaddles its body.", $F0

Data_00B_5FB8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sneaks up on foes", $F1
    db "from behind.", $F0

Data_00B_5FD7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The limbs were", $F1
    db "mixed up in death.", $F0

Data_00B_5FF9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The collar of fire", $F1
    db "is used to attack.", $F0

Data_00B_601F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its arms were made", $F1
    db "into weapons.", $F0

Data_00B_6040:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Retains its noble", $F1
    db "nature in death.", $F0

Data_00B_6063:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Became a zombie", $F1
    db "while still alive.", $F0

Data_00B_6086:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Will never be", $F1
    db "freed in death.", $F0

Data_00B_60A4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slashes repeatedly", $F1
    db "with its six arms.", $F0

Data_00B_60CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The four arms move", $F1
    db "independently.", $F0

Data_00B_60EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects its head", $F1
    db "with both hands.", $F0

Data_00B_610F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shows dedication", $F1
    db "to its mimicry.", $F0

Data_00B_6130:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wandering souls", $F1
    db "gathered as one.", $F0

Data_00B_6151:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its thoughts are", $F1
    db "unfathomable.", $F0

Data_00B_6170:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A proud and strong", $F1
    db "zombie swordsman.", $F0

Data_00B_6195:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances if it spots", $F1
    db "anything shiny.", $F0

Data_00B_61B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wand that split", $F1
    db "from its mage.", $F0

Data_00B_61D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Falls asleep if", $F1
    db "the flame dies.", $F0

Data_00B_61F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wind-up cuckoo", $F1
    db "that has a soul.", $F0

Data_00B_621B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Made of wood that", $F1
    db "is 1000 years old.", $F0

Data_00B_6240:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "One of its spikes", $F1
    db "sets off a bomb.", $F0

Data_00B_6263:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traps foes within", $F1
    db "its reflection.", $F0

Data_00B_6285:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doomed to wander", $F1
    db "and roam forever.", $F0

Data_00B_62A8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Controls itself", $F1
    db "with strings.", $F0

Data_00B_62C6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags foes into", $F1
    db "mud with others.", $F0

Data_00B_62E7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Emerged from 10000", $F1
    db "years of sleep.", $F0

Data_00B_630A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fully mechanical", $F1
    db "dragon.", $F0

Data_00B_6325:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slow, so it relies", $F1
    db "on power smashes.", $F0

Data_00B_634A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tears meat with", $F1
    db "its head and eats.", $F0

Data_00B_636D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blows confusing", $F1
    db "smoke when buffed.", $F0

Data_00B_6390:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushes foes until", $F1
    db "they turn all red.", $F0

Data_00B_63B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battles until it", $F1
    db "is fully wrecked.", $F0

Data_00B_63D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battles savagely", $F1
    db "without mercy.", $F0

Data_00B_63F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bites whoever", $F1
    db "peers inside.", $F0

Data_00B_6415:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Descends from the", $F1
    db "sky to seek prey.", $F0

Data_00B_6439:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A giant that caked", $F1
    db "itself with magma.", $F0

Data_00B_645F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A giant that caked", $F1
    db "itself with ice.", $F0

Data_00B_6483:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It bites unwary", $F1
    db "treasure hunters.", $F0

Data_00B_64A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Like-minded plates", $F1
    db "became a monster.", $F0

Data_00B_64CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body dries if", $F1
    db "it stops dancing.", $F0

Data_00B_64EE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body cracks if", $F1
    db "it tries to talk.", $F0

Data_00B_6513:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body breaks if", $F1
    db "it stops moving.", $F0

Data_00B_6537:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Explodes without", $F1
    db "warning on waking.", $F0

Data_00B_655B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Proud of its big,", $F1
    db "golden body.", $F0

Data_00B_657A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes foes dizzy", $F1
    db "by rotating.", $F0

Data_00B_6598:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster's proto-", $F1
    db "type, but tough.", $F0

Data_00B_65BA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A judge among", $F1
    db "monsters.", $F0

Data_00B_65D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, slippery", $F1
    db "and hard to hit.", $F0

Data_00B_65F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "then bites them.", $F0

Data_00B_6615:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sits on foes and", $F1
    db "pummels them.", $F0

Data_00B_6634:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Suffocates foes", $F1
    db "with its body.", $F0

Data_00B_6653:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snares foes with", $F1
    db "its tentacles.", $F0

Data_00B_6673:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Expands its body", $F1
    db "to startle foes.", $F0

Data_00B_6695:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fish that is as", $F1
    db "smart as people.", $F0

Data_00B_66B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A monster that got", $F1
    db "stuck in a trap.", $F0

Data_00B_66DC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swarms and eats", $F1
    db "foes instantly.", $F0

Data_00B_66FC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The short legs", $F1
    db "make it sluggish.", $F0

Data_00B_671D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts prey with", $F1
    db "a lighted antenna.", $F0

Data_00B_6743:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A demon that rides", $F1
    db "a fish in battle.", $F0

Data_00B_6768:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swims straight to", $F1
    db "ram at high speed.", $F0

Data_00B_678D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skips through", $F1
    db "water like a frog.", $F0

Data_00B_67AE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The pincers can", $F1
    db "cut its own shell.", $F0

Data_00B_67D1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The pincers are", $F1
    db "sharp, but heavy.", $F0

Data_00B_67F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drowns foes inside", $F1
    db "its turbid body.", $F0

Data_00B_6817:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its shell is", $F1
    db "tough to open.", $F0

Data_00B_6833:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Remains upright", $F1
    db "even when asleep.", $F0

Data_00B_6855:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides its ugly", $F1
    db "body in a hood.", $F0

Data_00B_6874:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rampages in the", $F1
    db "sea with swords.", $F0

Data_00B_6895:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cleaves foes in", $F1
    db "two with its ax.", $F0

Data_00B_68B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rarely seen as it", $F1
    db "hides in depths.", $F0

Data_00B_68D9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spits a huge cloud", $F1
    db "of obscuring ink.", $F0

Data_00B_68FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drifts along with", $F1
    db "deep-sea currents.", $F0

Data_00B_6923:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its wand indicates", $F1
    db "magical power.", $F0

Data_00B_6945:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rare. It lurks", $F1
    db "only in deep seas.", $F0

Data_00B_6967:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses tentacles to", $F1
    db "immobilize foes.", $F0

Data_00B_698A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fin on its", $F1
    db "back is a weapon.", $F0

Data_00B_69AB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its thrashing can", $F1
    db "cause earthquakes.", $F0

Data_00B_69D0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Floats vacantly in", $F1
    db "the sea at peace.", $F0

Data_00B_69F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but capable", $F1
    db "of stretching.", $F0

Data_00B_6A17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's first,", $F1
    db "unassuming form.", $F0

Data_00B_6A3A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's true,", $F1
    db "powerful identity.", $F0

Data_00B_6A5E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's form", $F1
    db "when enraged.", $F0

Data_00B_6A7C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An evil cleric who", $F1
    db "can use any spell.", $F0

Data_00B_6AA2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being dedicated", $F1
    db "to world chaos.", $F0

Data_00B_6AC4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sidoh reborn for ", $F1
    db "total destruction.", $F0

Data_00B_6AE9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lords over all", $F1
    db "demons with power.", $F0

Data_00B_6B0B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A Demon Lord that", $F1
    db "uses dark powers.", $F0

Data_00B_6B2F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, final", $F1
    db "form of Zoma.", $F0

Data_00B_6B4D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being that seeks", $F1
    db "ultimate power.", $F0

Data_00B_6B70:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pizzaro's pure and", $F1
    db "real guise.", $F0

Data_00B_6B8E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dedicated to chaos", $F1
    db "and domination.", $F0

Data_00B_6BB1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Purely evil and", $F1
    db "divinely powerful.", $F0

Data_00B_6BD4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, vile", $F1
    db "form of Mirudraas.", $F0

Data_00B_6BF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A Demon Lord that", $F1
    db "uses illusions.", $F0

Data_00B_6C18:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Demon Lord of", $F1
    db "all worlds.", $F0

Data_00B_6C36:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, enraged", $F1
    db "form of DeathMore.", $F0

Data_00B_6C5B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore's final", $F1
    db "evolution.", $F0

Data_00B_6C77:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being that", $F1
    db "dreams of death.", $F0

Data_00B_6C95:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its elegance", $F1
    db "belies its greed.", $F0

Data_00B_6CB4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its form strikes", $F1
    db "terror in all.", $F0

Data_00B_6CD4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The collector king", $F1
    db "of Limbo.", $F0

Data_00B_6CF1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

Data_00B_6CF7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

Data_00B_6CFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beast", $F0

Data_00B_6D04:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bird", $F0

Data_00B_6D09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Plant", $F0

Data_00B_6D0F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bug", $F0

Data_00B_6D13:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon", $F0

Data_00B_6D19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zombie", $F0

Data_00B_6D20:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Material", $F0

Data_00B_6D29:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

Data_00B_6D2F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "????", $F0
    ds $12CC, $00
