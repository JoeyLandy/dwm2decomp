; ROM bank $2A: messages
; The annotated listing of this bank is build/listing/bank2a.asm.

SECTION "Bank 2A", ROMX[$4000], BANK[$2A]
    db $2a

; message bank $2A: when wStringIndex < $95, BeginStringDisplay with this bank's table
; MessageStrings_Bank2A; otherwise far-calls BeginStringDisplay_Bank2A_Overflow (E-0080)
BeginStringDisplay_Bank2A::
    ld a, [wStringIndex]
    cp $95
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2A_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2A
    call BeginStringDisplay
    ret

; message bank $2A: when wStringIndex < $95, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2A; otherwise far-calls CopyStringToBuffer_Bank2A_Overflow (E-0080)
CopyStringToBuffer_Bank2A::
    ld a, [wStringIndex]
    cp $95
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2A_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2A
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2A::
MessageStrings_Bank2A::
    dw StringList_Bank2A_0 ; id 0

; category list of StringCategories_2A; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2A_0::
    dw Message_02_00 ; id 0
    dw Message_02_01 ; id 1
    dw Message_02_02 ; id 2
    dw Message_02_03 ; id 3
    dw Message_02_04 ; id 4
    dw Message_02_05 ; id 5
    dw Message_02_06 ; id 6
    dw Message_02_07 ; id 7
    dw Message_02_08 ; id 8
    dw Message_02_09 ; id 9
    dw Message_02_0A ; id 10
    dw Message_02_0B ; id 11
    dw Message_02_0C ; id 12
    dw Message_02_0D ; id 13
    dw Message_02_0E ; id 14
    dw Message_02_0F ; id 15
    dw Message_02_10 ; id 16
    dw Message_02_11 ; id 17
    dw Message_02_12 ; id 18
    dw Message_02_13 ; id 19
    dw Message_02_14 ; id 20
    dw Message_02_15 ; id 21
    dw Message_02_16 ; id 22
    dw Message_02_17 ; id 23
    dw Message_02_17 ; id 24
    dw Message_02_17 ; id 25
    dw Message_02_17 ; id 26
    dw Message_02_17 ; id 27
    dw Message_02_1C ; id 28
    dw Message_02_1D ; id 29
    dw Message_02_1E ; id 30
    dw Message_02_1F ; id 31
    dw Message_02_20 ; id 32
    dw Message_02_21 ; id 33
    dw Message_02_22 ; id 34
    dw Message_02_23 ; id 35
    dw Message_02_24 ; id 36
    dw Message_02_25 ; id 37
    dw Message_02_26 ; id 38
    dw Message_02_27 ; id 39
    dw Message_02_28 ; id 40
    dw Message_02_29 ; id 41
    dw Message_02_2A ; id 42
    dw Message_02_2B ; id 43
    dw Message_02_2C ; id 44
    dw Message_02_2D ; id 45
    dw Message_02_2E ; id 46
    dw Message_02_2F ; id 47
    dw Message_02_30 ; id 48
    dw Message_02_31 ; id 49
    dw Message_02_32 ; id 50
    dw Message_02_33 ; id 51
    dw Message_02_34 ; id 52
    dw Message_02_35 ; id 53
    dw Message_02_36 ; id 54
    dw Message_02_37 ; id 55
    dw Message_02_38 ; id 56
    dw Message_02_39 ; id 57
    dw Message_02_3A ; id 58
    dw Message_02_3B ; id 59
    dw Message_02_3C ; id 60
    dw Message_02_3D ; id 61
    dw Message_02_3E ; id 62
    dw Message_02_3F ; id 63
    dw Message_02_40 ; id 64
    dw Message_02_41 ; id 65
    dw Message_02_42 ; id 66
    dw Message_02_43 ; id 67
    dw Message_02_44 ; id 68
    dw Message_02_45 ; id 69
    dw Message_02_46 ; id 70
    dw Message_02_47 ; id 71
    dw Message_02_48 ; id 72
    dw Message_02_49 ; id 73
    dw Message_02_4A ; id 74
    dw Message_02_4B ; id 75
    dw Message_02_4B ; id 76
    dw Message_02_4B ; id 77
    dw Message_02_4B ; id 78
    dw Message_02_4B ; id 79
    dw Message_02_4B ; id 80
    dw Message_02_4B ; id 81
    dw Message_02_4B ; id 82
    dw Message_02_4B ; id 83
    dw Message_02_4B ; id 84
    dw Message_02_4B ; id 85
    dw Message_02_56 ; id 86
    dw Message_02_57 ; id 87
    dw Message_02_58 ; id 88
    dw Message_02_59 ; id 89
    dw Message_02_5A ; id 90
    dw Message_02_5B ; id 91
    dw Message_02_5C ; id 92
    dw Message_02_5D ; id 93
    dw Message_02_5E ; id 94
    dw Message_02_5F ; id 95
    dw Message_02_60 ; id 96
    dw Message_02_61 ; id 97
    dw Message_02_62 ; id 98
    dw Message_02_63 ; id 99
    dw Message_02_64 ; id 100
    dw Message_02_65 ; id 101
    dw Message_02_66 ; id 102
    dw Message_02_67 ; id 103
    dw Message_02_68 ; id 104
    dw Message_02_69 ; id 105
    dw Message_02_6A ; id 106
    dw Message_02_6B ; id 107
    dw Message_02_6C ; id 108
    dw Message_02_6D ; id 109
    dw Message_02_6E ; id 110
    dw Message_02_6F ; id 111
    dw Message_02_70 ; id 112
    dw Message_02_71 ; id 113
    dw Message_02_72 ; id 114
    dw Message_02_73 ; id 115
    dw Message_02_74 ; id 116
    dw Message_02_75 ; id 117
    dw Message_02_76 ; id 118
    dw Message_02_77 ; id 119
    dw Message_02_78 ; id 120
    dw Message_02_79 ; id 121
    dw Message_02_7A ; id 122
    dw Message_02_7B ; id 123
    dw Message_02_7C ; id 124
    dw Message_02_7D ; id 125
    dw Message_02_7E ; id 126
    dw Message_02_7F ; id 127
    dw Message_02_80 ; id 128
    dw Message_02_81 ; id 129
    dw Message_02_82 ; id 130
    dw Message_02_83 ; id 131
    dw Message_02_84 ; id 132
    dw Message_02_85 ; id 133
    dw Message_02_86 ; id 134
    dw Message_02_87 ; id 135
    dw Message_02_88 ; id 136
    dw Message_02_89 ; id 137
    dw Message_02_8A ; id 138
    dw Message_02_8B ; id 139
    dw Message_02_8C ; id 140
    dw Message_02_8D ; id 141
    dw Message_02_8E ; id 142
    dw Message_02_8F ; id 143
    dw Message_02_90 ; id 144
    dw Message_02_91 ; id 145
    dw Message_02_92 ; id 146
    dw Message_02_93 ; id 147
    dw Message_02_94 ; id 148

Message_02_00::
    db "<VOICE2>*: You've been going<LINE>"
    db "out a lot lately.<PROMPT>"
    db "<NEXT>Where do you go"
    db "<NEXT>out to play?<PROMPT>"
    db "<NEXT>Oh? You're trying"
    db "<NEXT>to save GreatLog?<PROMPT>"
    db "<NEXT>Well, my hero, how"
    db "<NEXT>about an errand?<PROMPT>"
    db "<NEXT>Could you go buy"
    db "<NEXT>LoveWater?<PROMPT>"
    db "<NEXT>DrakSlime is badly"
    db "<NEXT>sunburned, so I<PROMPT>"
    db "<NEXT>need to treat its"
    db "<NEXT>condition.<PROMPT>"
    db "<NEXT>Here's some money."
    db "<NEXT>Keep the change!<WAIT>"
    db "@"

Message_02_01::
    db "Mom handed over<LINE>"
    db "200G.<WAIT>"
    db "@"

Message_02_02::
    db "<VOICE2>*: Buy LoveWater<LINE>"
    db "for me, OK?<WAIT>"
    db "@"

Message_02_03::
    db "<VOICE1>*: I was taking a<LINE>"
    db "nap in the sun…<PROMPT>"
    db "<NEXT>I'm all sunburned!"
    db "<NEXT>It hurts!<WAIT>"
    db "@"

Message_02_04::
    db "<VOICE1>*: A bridge to the<LINE>"
    db "island there will<PROMPT>"
    db "<NEXT>increase the farm's"
    db "<NEXT>space.<PROMPT>"
    db "<NEXT>Beavern's helping"
    db "<NEXT>with the bridge.<WAIT>"
    db "@"

Message_02_05::
    db "<VOICE2>*: I don't need any<LINE>"
    db "help today, dear.<WAIT>"
    db "@"

Message_02_06::
    db "<VOICE1>*: You're the child<LINE>"
    db "of the farmer?<PROMPT>"
    db "<NEXT>Under his Majesty's"
    db "<NEXT>decree, there will<PROMPT>"
    db "<NEXT>be a tournament"
    db "<NEXT>for child masters.<PROMPT>"
    db "<NEXT>He wishes you to"
    db "<NEXT>take part.<PROMPT>"
    db "<NEXT>Needless to say, a"
    db "<NEXT>prize awaits the<PROMPT>"
    db "<NEXT>champion-the"
    db "<NEXT>PirateKey.<PROMPT>"
    db "<NEXT>I'm not good with"
    db "<NEXT>this sort of work,<PROMPT>"
    db "<NEXT>so I'll just ask"
    db "<NEXT>that you come!<WAIT>"
    db "@"

Message_02_07::
    db "<VOICE1>Cobi: <BUF0>, what<LINE>"
    db "was it like in the<PROMPT>"
    db "<NEXT>other worlds?"
    db "<NEXT>I", $44, " like to know.<PROMPT>"
    db "<NEXT>…Oh… The TidalBell"
    db "<NEXT>wasn't the right<PROMPT>"
    db "<NEXT>size to fit the"
    db "<NEXT>Log's Navel?<PROMPT>"
    db "<NEXT>Are you sure you"
    db "<NEXT>can do it, <BUF0>?<PROMPT>"
    db "<NEXT>Well, yes, I guess"
    db "<NEXT>I did leave it up<PROMPT>"
    db "<NEXT>to you, <BUF0>."
    db "<NEXT>I believe in you.<PROMPT>"
    db "<NEXT>Papa expanded the"
    db "<NEXT>farm, so we can<PROMPT>"
    db "<NEXT>look after more of"
    db "<NEXT>your monsters.<PROMPT>"
    db "<NEXT>So, what can I do"
    db "<NEXT>for you, sis?<WAIT>"
    db "@"

Message_02_08::
    db "<VOICE2>Tara: Big brother,<LINE>"
    db "have you found a<PROMPT>"
    db "<NEXT>new plug for the"
    db "<NEXT>Log's Navel?<PROMPT>"
    db "<NEXT>…Oh… The TidalBell"
    db "<NEXT>didn't fit…<PROMPT>"
    db "<NEXT>But I'm sure that"
    db "<NEXT>you can do it.<PROMPT>"
    db "<NEXT>Don't give up, big"
    db "<NEXT>brother!<PROMPT>"
    db "<NEXT>Papa made the farm"
    db "<NEXT>a little bigger,<PROMPT>"
    db "<NEXT>so you can leave"
    db "<NEXT>more monsters.<PROMPT>"
    db "<NEXT>Do you need me for"
    db "<NEXT>anything?<WAIT>"
    db "@"

Message_02_09::
    db "<VOICE1>*: Did you know?<LINE>"
    db "You can record in<PROMPT>"
    db "<NEXT>your Journal only"
    db "<NEXT>in a castle, town<PROMPT>"
    db "<NEXT>or a village in"
    db "<NEXT>other worlds.<WAIT>"
    db "@"

Message_02_0A::
    db "<VOICE1>*: I'm chopping some<LINE>"
    db "trees down to make<PROMPT>"
    db "<NEXT>the farm larger."
    db "<NEXT>Stay well clear.<PROMPT>"
    db "<NEXT>Falling timber is"
    db "<NEXT>very hazardous!<WAIT>"
    db "@"

Message_02_0B::
    db "<VOICE1>*: Take the ladder<LINE>"
    db "up ahead to the<PROMPT>"
    db "<NEXT>Library on the"
    db "<NEXT>second level.<PROMPT>"
    db "<NEXT>They have many"
    db "<NEXT>reference books.<PROMPT>"
    db "<NEXT>You should go take"
    db "<NEXT>a look sometime.<WAIT>"
    db "@"

Message_02_0C::
    db "<VOICE2>*: The castle is in<LINE>"
    db "an uproar because<PROMPT>"
    db "<NEXT>Prince Kameha has"
    db "<NEXT>disappeared.<PROMPT>"
    db "<NEXT>I bet he's hiding"
    db "<NEXT>because one of his<PROMPT>"
    db "<NEXT>silly pranks was"
    db "<NEXT>discovered.<WAIT>"
    db "@"

Message_02_0D::
    db "<VOICE1>*: You're too young<LINE>"
    db "to be shopping.<PROMPT>"
    db "<NEXT>Next time, bring"
    db "<NEXT>an adult, OK?<PROMPT>"
    db "<NEXT>…Oh? An errand for"
    db "<NEXT>your mother?<PROMPT>"
    db "<NEXT>For a youngster,"
    db "<NEXT>you're obviously<PROMPT>"
    db "<NEXT>quite responsible."
    db "<NEXT>Sorry about that!<PROMPT>"
    db "<NEXT>What can I do for"
    db "<NEXT>you today?<WAIT>"
    db "@"

Message_02_0E::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I serve you today?<WAIT>"
    db "@"

Message_02_0F::
    db "<VOICE2>*: There are some<LINE>"
    db "items that can be<PROMPT>"
    db "<NEXT>equipped by your"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>D-Scale, which is"
    db "<NEXT>sold here, is one.<PROMPT>"
    db "<NEXT>But it's just one"
    db "<NEXT>item per monster.<WAIT>"
    db "@"

Message_02_10::
    db "<VOICE2>*: Oh, my… Where<LINE>"
    db "did the shop go?<PROMPT>"
    db "<NEXT>Just when I needed"
    db "<NEXT>to shop too.<WAIT>"
    db "@"

Message_02_11::
    db "<VOICE2>*: I hear rumors<LINE>"
    db "that Prince Kameha<PROMPT>"
    db "<NEXT>was seen near the"
    db "<NEXT>Magic Door.<PROMPT>"
    db "<NEXT>Is that Prince"
    db "<NEXT>going to spread<PROMPT>"
    db "<NEXT>his mischief to"
    db "<NEXT>other worlds?<WAIT>"
    db "@"

Message_02_12::
    db "<VOICE2>*: Oh? You bought<LINE>"
    db "the LoveWater!<PROMPT>"
    db "<NEXT>This will heal"
    db "<NEXT>DrakSlime!<PROMPT>"
    db "<NEXT>Thank you, dear!"
    db "<NEXT><WAIT>"
    db "@"

Message_02_13::
    db "<BUF0> handed over<LINE>"
    db "the LoveWater.<WAIT>"
    db "@"

Message_02_14::
    db "<VOICE2>*: I'll get you to<LINE>"
    db "run more errands.<PROMPT>"
    db "<NEXT>Oh, don't look so"
    db "<NEXT>glum, dear!<WAIT>"
    db "@"

Message_02_15::
    db "<VOICE1>*: Aooh, LoveWater<LINE>"
    db "soothes sunburn…<WAIT>"
    db "@"

Message_02_16::
    db "<VOICE2>*: Play it safe<LINE>"
    db "against Skullroo.<PROMPT>"
    db "<NEXT>It's in the final"
    db "<NEXT>of the Kids Class.<PROMPT>"
    db "<NEXT>Your monsters had"
    db "<NEXT>better take cover<PROMPT>"
    db "<NEXT>if it starts"
    db "<NEXT>charging power.<PROMPT>"
    db "<NEXT>Change your Plan"
    db "<NEXT>to 'Defense' and<PROMPT>"
    db "<NEXT>your monsters may"
    db "<NEXT>defend themselves.<WAIT>"
    db "@"

Message_02_17::
    db "<VOICE1>*: This leads to<LINE>"
    db "GreatLog Castle!<PROMPT>"
    db "<NEXT>No one enters"
    db "<NEXT>without a permit!<WAIT>"
    db "@"

Message_02_1C::
    db "<VOICE2>*: Monsters hate<LINE>"
    db "being away from<PROMPT>"
    db "<NEXT>their master."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>They can turn"
    db "<NEXT>rebellious out of<PROMPT>"
    db "<NEXT>sadness. Try to"
    db "<NEXT>understand.<WAIT>"
    db "@"

Message_02_1D::
    db "<VOICE1>*: Take this slide<LINE>"
    db "as a shortcut!<WAIT>"
    db "@"

Message_02_1E::
    db "<VOICE1>*: It's easy to get<LINE>"
    db "down, but up? Ugh.<WAIT>"
    db "@"

Message_02_1F::
    db "<VOICE1>*: Do you know<LINE>"
    db "about LogTwig?<PROMPT>"
    db "<NEXT>It's an item that"
    db "<NEXT>lets you move a<PROMPT>"
    db "<NEXT>Magic Door Shrine"
    db "<NEXT>as you wish.<PROMPT>"
    db "<NEXT>It used to be sold"
    db "<NEXT>here, but…<WAIT>"
    db "@"

Message_02_20::
    db "<VOICE1>*: In other worlds,<LINE>"
    db "you'll meet other<PROMPT>"
    db "<NEXT>travelers like"
    db "<NEXT>yourself.<PROMPT>"
    db "<NEXT>They're not all"
    db "<NEXT>bad people, but<PROMPT>"
    db "<NEXT>there are some you"
    db "<NEXT>need to watch.<WAIT>"
    db "@"

Message_02_21::
    db "<VOICE1>*: Hello there,<LINE>"
    db "youngster!<PROMPT>"
    db "<NEXT>Take these stairs"
    db "<NEXT>to the Arena.<PROMPT>"
    db "<NEXT>Masters pit their"
    db "<NEXT>trained monsters<PROMPT>"
    db "<NEXT>against each other"
    db "<NEXT>down there.<PROMPT>"
    db "<NEXT>It's worth a look"
    db "<NEXT>if you're a master.<WAIT>"
    db "@"

Message_02_22::
    db "<VOICE1>*: Hey, a little<LINE>"
    db "bitty master! Hi!<PROMPT>"
    db "<NEXT>You'll see a good"
    db "<NEXT>crowd of skilled<PROMPT>"
    db "<NEXT>masters today in"
    db "<NEXT>the Arena.<PROMPT>"
    db "<NEXT>It's a good chance"
    db "<NEXT>to learn a few<PROMPT>"
    db "<NEXT>things about some"
    db "<NEXT>monsters.<WAIT>"
    db "@"

Message_02_23::
    db "<VOICE1>*: Well, you're a<LINE>"
    db "mighty lively kid.<PROMPT>"
    db "<NEXT>Let me tell you"
    db "<NEXT>something.<PROMPT>"
    db "<NEXT>Do you know about"
    db "<NEXT>TinyMedals?<PROMPT>"
    db "<NEXT>They can't be sold,"
    db "<NEXT>but they can be<PROMPT>"
    db "<NEXT>traded to a"
    db "<NEXT>collector.<PROMPT>"
    db "<NEXT>You should store"
    db "<NEXT>them in the Vault.<WAIT>"
    db "@"

Message_02_24::
    db "<VOICE2>*: Take care to<LINE>"
    db "find Tiny Medals.<PROMPT>"
    db "<NEXT>Look in vases and"
    db "<NEXT>barrels for them.<WAIT>"
    db "@"

Message_02_25::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>There was a plant"
    db "<NEXT>sprouting inside.<WAIT>"
    db "@"

Message_02_26::
    db "There was also a<LINE>"
    db "letter.<PROMPT>"
    db "<NEXT>'This is a gift."
    db "<NEXT>Fwohohoho!", $95, "<WAIT>"
    db "@"

Message_02_27::
    db "<BUF0> checked the<LINE>"
    db "pedestal.<PROMPT>"
    db "<NEXT>It's the Library"
    db "<NEXT>Guide. Read it?<CHOICE>"
    db "@"

Message_02_28::
    db "'You may check<LINE>"
    db "your Catalog of<PROMPT>"
    db "<NEXT>monsters in the"
    db "<NEXT>Library.<PROMPT>"
    db "<NEXT>The monsters you"
    db "<NEXT>befriend or breed<PROMPT>"
    db "<NEXT>are cataloged by"
    db "<NEXT>family, in which<PROMPT>"
    db "<NEXT>individual species"
    db "<NEXT>are listed.<PROMPT>"
    db "<NEXT>To examine your"
    db "<NEXT>Catalog, please<PROMPT>"
    db "<NEXT>speak to the"
    db "<NEXT>receptionist.", $95, "<PROMPT>"
    db "<NEXT><BUF0> put back the"
    db "<NEXT>Library Guide.<WAIT>"
    db "@"

Message_02_29::
    db "<BUF0> put back the<LINE>"
    db "Library Guide.<WAIT>"
    db "@"

Message_02_2A::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Library.<PROMPT>"
    db "<NEXT>You may check your"
    db "<NEXT>Catalog here.<PROMPT>"
    db "<NEXT>The Catalog is"
    db "<NEXT>personalized, so<PROMPT>"
    db "<NEXT>it won't contain"
    db "<NEXT>data on monsters<PROMPT>"
    db "<NEXT>that you don't"
    db "<NEXT>know. Anyway…<PROMPT>"
    db "<NEXT>Which family would"
    db "<NEXT>you like to check?<WAIT>"
    db "@"

Message_02_2B::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Library.<PROMPT>"
    db "<NEXT>Which family would"
    db "<NEXT>you like to check?<WAIT>"
    db "@"

Message_02_2C::
    db "<VOICE1>*: There are books<LINE>"
    db "that change your<PROMPT>"
    db "<NEXT>personality just"
    db "<NEXT>by reading them.<WAIT>"
    db "@"

Message_02_2D::
    db "<VOICE2>*: WarpWing returns<LINE>"
    db "you instantly to<PROMPT>"
    db "<NEXT>GreatLog, so I"
    db "<NEXT>take one with me<PROMPT>"
    db "<NEXT>when I visit other"
    db "<NEXT>worlds.<WAIT>"
    db "@"

Message_02_2E::
    db "<VOICE2>*: Snivel… This<LINE>"
    db "book is so sad…<WAIT>"
    db "@"

Message_02_2F::
    db "<VOICE1>*: Even I can cast<LINE>"
    db "spells if I have<PROMPT>"
    db "<NEXT>the right kind of"
    db "<NEXT>staff.<WAIT>"
    db "@"

Message_02_30::
    db "<VOICE2>*: Do you have any<LINE>"
    db "idea about this<PROMPT>"
    db "<NEXT>monster families"
    db "<NEXT>business?<CHOICE>"
    db "@"

Message_02_31::
    db "<VOICE2>*: Oh… You've read<LINE>"
    db "this book before.<WAIT>"
    db "@"

Message_02_32::
    db "<VOICE2>*: Monsters can be<LINE>"
    db "categorized in ten<PROMPT>"
    db "<NEXT>groups according"
    db "<NEXT>to their features.<PROMPT>"
    db "<NEXT>Slime, dragon,"
    db "<NEXT>beast, bird,<PROMPT>"
    db "<NEXT>plant, bug, devil,"
    db "<NEXT>material, water…<PROMPT>"
    db "<NEXT>and… Ah-choo!"
    db "<NEXT>Excuse me!<PROMPT>"
    db "<NEXT>Those ten groups"
    db "<NEXT>are families.<WAIT>"
    db "@"

Message_02_33::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Monster Skills…"
    db "<NEXT>Every species of<PROMPT>"
    db "<NEXT>monsters learns"
    db "<NEXT>three skills.", $95, "<WAIT>"
    db "@"

Message_02_34::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Monster Growth…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>By experiencing<LINE>"
    db "battle, monsters<PROMPT>"
    db "<NEXT>will gain power"
    db "<NEXT>and skills.", $95, "<WAIT>"
    db "@"

Message_02_35::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Personalities of"
    db "<NEXT>Monsters…<PROMPT>"
    db "<NEXT>Personalities are"
    db "<NEXT>changed by the<PROMPT>"
    db "<NEXT>master's battle"
    db "<NEXT>plan.<PROMPT>"
    db "<NEXT>Personality"
    db "<NEXT>affects behavior.", $95, "<WAIT>"
    db "@"

Message_02_36::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Nuts and Seeds…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>ATKseed and"
    db "<NEXT>MysticNut are rare<PROMPT>"
    db "<NEXT>items that enhance"
    db "<NEXT>stats slightly.", $95, "<WAIT>"
    db "@"

Message_02_37::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'WorldLeaf…"
    db "<NEXT>An indispensable<PROMPT>"
    db "<NEXT>and mystic item"
    db "<NEXT>that summons the<PROMPT>"
    db "<NEXT>soul of any dead"
    db "<NEXT>monster.", $95, "<WAIT>"
    db "@"

Message_02_38::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Magic Key Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Every Magic Key is"
    db "<NEXT>an original that<PROMPT>"
    db "<NEXT>opens the door to"
    db "<NEXT>another world that<PROMPT>"
    db "<NEXT>is unlike any"
    db "<NEXT>other.", $95, "<WAIT>"
    db "@"

Message_02_39::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Magic Key Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Unnamed Magic Keys"
    db "<NEXT>cannot be used<PROMPT>"
    db "<NEXT>until they are"
    db "<NEXT>appraised.<PROMPT>"
    db "<NEXT>Otherwise, it's"
    db "<NEXT>impossible to<PROMPT>"
    db "<NEXT>figure out its"
    db "<NEXT>destination.", $95, "<WAIT>"
    db "@"

Message_02_3A::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Starry Shrine…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>A sacred place"
    db "<NEXT>that draws the<PROMPT>"
    db "<NEXT>Tree's life force"
    db "<NEXT>from its roots to<PROMPT>"
    db "<NEXT>breed and hatch"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>From eggs come"
    db "<NEXT>offspring that<PROMPT>"
    db "<NEXT>inherit the"
    db "<NEXT>attributes and<PROMPT>"
    db "<NEXT>skills of its"
    db "<NEXT>parents.", $95, "<WAIT>"
    db "@"

Message_02_3B::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Egg Evaluators…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Those with the"
    db "<NEXT>special ability to<PROMPT>"
    db "<NEXT>determine what"
    db "<NEXT>hides in an Egg.<PROMPT>"
    db "<NEXT>They are also able"
    db "<NEXT>to alter the<PROMPT>"
    db "<NEXT>gender of the Egg"
    db "<NEXT>through singing.", $95, "<WAIT>"
    db "@"

Message_02_3C::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Accessory Guide…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>A monster can wear"
    db "<NEXT>one accessory.<PROMPT>"
    db "<NEXT>Accessories have"
    db "<NEXT>many effects.", $95, "<WAIT>"
    db "@"

Message_02_3D::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Hidden Abilities…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Monsters remain"
    db "<NEXT>mysterious in many<PROMPT>"
    db "<NEXT>ways.They may have"
    db "<NEXT>hidden abilities…", $95, "<WAIT>"
    db "@"

Message_02_3E::
    db "<BUF0> read the"
    db "<NEXT>notice.<PROMPT>"
    db "<NEXT>'Please return"
    db "<NEXT>books to their <PROMPT>"
    db "<NEXT>proper places!"
    db "<NEXT>-The Librarian.", $95, "<WAIT>"
    db "@"

Message_02_3F::
    db "<VOICE1>*: I was on my way<LINE>"
    db "to the Magic Door<PROMPT>"
    db "<NEXT>so I could go to"
    db "<NEXT>another world.<PROMPT>"
    db "<NEXT>Warubou stopped me"
    db "<NEXT>and demanded help.<PROMPT>"
    db "<NEXT>But, I've been"
    db "<NEXT>conned enough by<PROMPT>"
    db "<NEXT>that prankster."
    db "<NEXT>Not this time!<WAIT>"
    db "@"

Message_02_40::
    db "<VOICE2>*: Pack properly if<LINE>"
    db "you're going off<PROMPT>"
    db "<NEXT>to another world."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Some have never"
    db "<NEXT>returned…<WAIT>"
    db "@"

Message_02_41::
    db "<VOICE1>*: Try the slide!<LINE>"
    db "It's a shortcut!<WAIT>"
    db "@"

Message_02_42::
    db "<VOICE1>*: My dad's a famous<LINE>"
    db "monster master.<PROMPT>"
    db "<NEXT>I'm going to be"
    db "<NEXT>just like him!<WAIT>"
    db "@"

Message_02_43::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Bookmark…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Place inside the"
    db "<NEXT>Journal to record<PROMPT>"
    db "<NEXT>your quest in any"
    db "<NEXT>location.", $95, "<WAIT>"
    db "@"

Message_02_44::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Journal…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>A book that keeps"
    db "<NEXT>record of your<PROMPT>"
    db "<NEXT>adventure."
    db "<NEXT>Can only be used<PROMPT>"
    db "<NEXT>in safe locations"
    db "<NEXT>in other worlds.", $95, "<WAIT>"
    db "@"

Message_02_45::
    db "<BUF0> peered into<LINE>"
    db "the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>colorful fruits.<WAIT>"
    db "@"

Message_02_46::
    db "<VOICE1>*: Hey, let me ask<LINE>"
    db "you something.<PROMPT>"
    db "<NEXT>Did you see the"
    db "<NEXT>woman next door?<CHOICE>"
    db "@"

Message_02_47::
    db "<VOICE1>*: Did she say<LINE>"
    db "anything to you?<PROMPT>"
    db "<NEXT>She's a nasty"
    db "<NEXT>piece of work.<PROMPT>"
    db "<NEXT>How can she yap so"
    db "<NEXT>much?<WAIT>"
    db "@"

Message_02_48::
    db "<VOICE1>*: Good, you're<LINE>"
    db "lucky!<PROMPT>"
    db "<NEXT>Stay away, that's"
    db "<NEXT>the thing.<WAIT>"
    db "@"

Message_02_49::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'Diary…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>A girl with pretty"
    db "<NEXT>eyes moved in next<PROMPT>"
    db "<NEXT>door. I thought I"
    db "<NEXT>lucked out.<PROMPT>"
    db "<NEXT>But she had a"
    db "<NEXT>sharp tongue…", $95, "<WAIT>"
    db "@"

Message_02_4A::
    db "<BUF0> checked the<LINE>"
    db "plush doll.<PROMPT>"
    db "<NEXT>It was fluffy and"
    db "<NEXT>too big to hug.<WAIT>"
    db "@"

Message_02_4B::
    db "<VOICE1>*: The farm grew a<LINE>"
    db "lot bigger.<PROMPT>"
    db "<NEXT>Including the"
    db "<NEXT>monsters with you,<PROMPT>"
    db "<NEXT>the farm can hold"
    db "<NEXT>up to 20 now.<PROMPT>"
    db "<NEXT>Monsters in the"
    db "<NEXT>farm earn some<PROMPT>"
    db "<NEXT>EX points as you"
    db "<NEXT>battle.<PROMPT>"
    db "<NEXT>But if you leave"
    db "<NEXT>them in the farm,<PROMPT>"
    db "<NEXT>they will grow"
    db "<NEXT>without learning<PROMPT>"
    db "<NEXT>skills, and they"
    db "<NEXT>turn disobedient.<PROMPT>"
    db "<NEXT>So, you should"
    db "<NEXT>take different<PROMPT>"
    db "<NEXT>monsters out to"
    db "<NEXT>train them.<WAIT>"
    db "@"

Message_02_56::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>It was jammed with"
    db "<NEXT>fancy clothing.<WAIT>"
    db "@"

Message_02_57::
    db "<VOICE2>*: Did you know<LINE>"
    db "that there's a<PROMPT>"
    db "<NEXT>place for changing"
    db "<NEXT>monster names?<CHOICE>"
    db "@"

Message_02_58::
    db "<VOICE2>*: Monsters should<LINE>"
    db "have cute names.<WAIT>"
    db "@"

Message_02_59::
    db "<VOICE2>*: Go visit the<LINE>"
    db "Christener.<PROMPT>"
    db "<NEXT>She's a lovely"
    db "<NEXT>lady.<PROMPT>"
    db "<NEXT>She's not anything"
    db "<NEXT>like that creep<PROMPT>"
    db "<NEXT>who lives next"
    db "<NEXT>door!<WAIT>"
    db "@"

Message_02_5A::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>It was tidily"
    db "<NEXT>organized.<WAIT>"
    db "@"

Message_02_5B::
    db "<BUF0> checked the<LINE>"
    db "bookshelf.<PROMPT>"
    db "<NEXT>'This is the first"
    db "<NEXT>day for me alone.<PROMPT>"
    db "<NEXT>While moving in,"
    db "<NEXT>I noticed a good<PROMPT>"
    db "<NEXT>looking man living"
    db "<NEXT>next door.<PROMPT>"
    db "<NEXT>But he stared and"
    db "<NEXT>whistled at me!<PROMPT>"
    db "<NEXT>How rude and so"
    db "<NEXT>ungallant!", $95, "<WAIT>"
    db "@"

Message_02_5C::
    db "<BUF0> peered into<LINE>"
    db "the mirror.<PROMPT>"
    db "<NEXT>A little girl"
    db "<NEXT>peered back.<WAIT>"
    db "@"

Message_02_5D::
    db "<BUF0> peered into<LINE>"
    db "the mirror.<PROMPT>"
    db "<NEXT>A little boy"
    db "<NEXT>stared back.<WAIT>"
    db "@"

Message_02_5E::
    db "<VOICE1>*: My granddaughter<LINE>"
    db "is painfully shy.<PROMPT>"
    db "<NEXT>She seems so sad"
    db "<NEXT>by herself…<WAIT>"
    db "@"

Message_02_5F::
    db "<VOICE1>*: I've never seen<LINE>"
    db "my granddaughter<PROMPT>"
    db "<NEXT>so happy and full"
    db "<NEXT>of life.<PROMPT>"
    db "<NEXT>Let me thank you"
    db "<NEXT>with a gift.<WAIT>"
    db "@"

Message_02_60::
    db "<BUF0> received<LINE>"
    db "a LifeAcorn.<WAIT>"
    db "@"

Message_02_61::
    db "<VOICE1>*: I've never seen<LINE>"
    db "my granddaughter<PROMPT>"
    db "<NEXT>so happy and full"
    db "<NEXT>of life.<PROMPT>"
    db "<NEXT>Let me thank you"
    db "<NEXT>with a gift.<PROMPT>"
    db "<NEXT>…Oh, but you have"
    db "<NEXT>no room for it.<WAIT>"
    db "@"

Message_02_62::
    db "<VOICE1>*: My granddaughter<LINE>"
    db "now insists that<PROMPT>"
    db "<NEXT>she will become a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>Well, whatever the"
    db "<NEXT>case, I'm delighted<PROMPT>"
    db "<NEXT>that she is happy"
    db "<NEXT>and lively.<WAIT>"
    db "@"

Message_02_63::
    db "<VOICE2>*: Oh… You're so<LINE>"
    db "lucky to have some<PROMPT>"
    db "<NEXT>friends like that."
    db "<NEXT>I wish I had one.<PROMPT>"
    db "<NEXT>A SpotSlime would"
    db "<NEXT>be so adorable…<WAIT>"
    db "@"

Message_02_64::
    db "<VOICE2>*: Oh… You're so<LINE>"
    db "lucky to have<PROMPT>"
    db "<NEXT>friends like that."
    db "<NEXT>I wish I had one.<PROMPT>"
    db "<NEXT>Your SpotSlime is"
    db "<NEXT>so adorable…<PROMPT>"
    db "<NEXT>Um… Can I have it?"
    db "<NEXT><CHOICE>"
    db "@"

Message_02_65::
    db "<VOICE2>*: R… Really?<LINE>"
    db "Wow! Thank you!<PROMPT>"
    db "<NEXT>I promise, I'll"
    db "<NEXT>take care of it!<WAIT>"
    db "@"

Message_02_66::
    db "<VOICE2>*: Oh… Sorry…<LINE>"
    db "It's your friend…<WAIT>"
    db "@"

Message_02_67::
    db "<VOICE2>*: What should I do"
    db "<NEXT>with Butch today…<PROMPT>"
    db "<NEXT>That's what I named"
    db "<NEXT>my SpotSlime.<WAIT>"
    db "@"

Message_02_68::
    db "<VOICE2>*: Yep, she's taking<LINE>"
    db "good care of me.<PROMPT>"
    db "<NEXT>But I need to get"
    db "<NEXT>more exercise.<PROMPT>"
    db "<NEXT>I might bloat up"
    db "<NEXT>to become a<PROMPT>"
    db "<NEXT>SpotKing!"
    db "<NEXT><WAIT>"
    db "@"

Message_02_69::
    db "<BUF0> checked the<LINE>"
    db "dresser.<PROMPT>"
    db "<NEXT>Girls' clothes"
    db "<NEXT>were inside.<WAIT>"
    db "@"

Message_02_6A::
    db "<BUF0> checked the<LINE>"
    db "plush doll.<PROMPT>"
    db "<NEXT>It had patches all"
    db "<NEXT>over it.<WAIT>"
    db "@"

Message_02_6B::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>Masters pit their"
    db "<NEXT>teams in battle<PROMPT>"
    db "<NEXT>to test their"
    db "<NEXT>power.<PROMPT>"
    db "<NEXT>Will you enter"
    db "<NEXT>your monsters?<CHOICE>"
    db "@"

Message_02_6C::
    db "<VOICE2>*: You're young, so<LINE>"
    db "you have to start<PROMPT>"
    db "<NEXT>in the Kids Class."
    db "<NEXT>But don't scoff!<PROMPT>"
    db "<NEXT>You'll lose if"
    db "<NEXT>you're complacent.<PROMPT>"
    db "<NEXT>Here are the"
    db "<NEXT>Arena rules.<PROMPT>"
    db "<NEXT>You can't use any"
    db "<NEXT>items in battle.<PROMPT>"
    db "<NEXT>And you forfeit if"
    db "<NEXT>you flee.<PROMPT>"
    db "<NEXT>Win three battles"
    db "<NEXT>to take the title.<PROMPT>"
    db "<NEXT>The PirateKey is"
    db "<NEXT>the prize.<WAIT>"
    db "@"

Message_02_6D::
    db "<VOICE2>*: Oh, then you<LINE>"
    db "must be here to<PROMPT>"
    db "<NEXT>see how other"
    db "<NEXT>masters battle.<PROMPT>"
    db "<NEXT>Take the corridor"
    db "<NEXT>on the right.<WAIT>"
    db "@"

Message_02_6E::
    db "<VOICE2>*: You lost?<LINE>"
    db "That's too bad.<PROMPT>"
    db "<NEXT>Train some more"
    db "<NEXT>and try again!<WAIT>"
    db "@"

Message_02_6F::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You're the champ!<PROMPT>"
    db "<NEXT>For winning the"
    db "<NEXT>Kids Class, you've<PROMPT>"
    db "<NEXT>earned the King's"
    db "<NEXT>recognition as an<PROMPT>"
    db "<NEXT>official monster"
    db "<NEXT>master.<PROMPT>"
    db "<NEXT>You can now use"
    db "<NEXT>the Starry Shrine<PROMPT>"
    db "<NEXT>and the Egg"
    db "<NEXT>Evaluator.<PROMPT>"
    db "<NEXT>From now on, you"
    db "<NEXT>will face adults<PROMPT>"
    db "<NEXT>in the Arena", $94
    db "<NEXT>so be sure to<PROMPT>"
    db "<NEXT>continue raising"
    db "<NEXT>stronger monsters.<PROMPT>"
    db "<NEXT>Here's your prize,"
    db "<NEXT>the PirateKey!<WAIT>"
    db "@"

Message_02_70::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>The rules are…"
    db "<NEXT>Well, you know.<PROMPT>"
    db "<NEXT>You'll be facing"
    db "<NEXT>grownups too now.<PROMPT>"
    db "<NEXT>There are four"
    db "<NEXT>classes in all.<PROMPT>"
    db "<NEXT>By becoming the"
    db "<NEXT>champ of a class,<PROMPT>"
    db "<NEXT>you will earn a"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>If you win the"
    db "<NEXT>S Class title,<PROMPT>"
    db "<NEXT>you will face even"
    db "<NEXT>tougher masters.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?<WAIT>"
    db "@"

Message_02_71::
    db "<VOICE2>*: Hello, which<LINE>"
    db "Class will it be?<WAIT>"
    db "@"

Message_02_72::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You're the champ!<PROMPT>"
    db "<NEXT>The D Class Champ"
    db "<NEXT>wins a Magic Key!<WAIT>"
    db "@"

Message_02_73::
    db "<BUF0> received<LINE>"
    db "a Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Message_02_74::
    db "<VOICE2>*: Oh? But your key<LINE>"
    db "ring is full.<PROMPT>"
    db "<NEXT>Make room, and"
    db "<NEXT>return for this!<WAIT>"
    db "@"

Message_02_75::
    db "<VOICE2>*: Here's the Magic<LINE>"
    db "Key you won!<WAIT>"
    db "@"

Message_02_76::
    db "<VOICE2>*: If you want to<LINE>"
    db "enter, please<PROMPT>"
    db "<NEXT>register with the"
    db "<NEXT>girl next to me.<WAIT>"
    db "@"

Message_02_77::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>hear the rules?<CHOICE>"
    db "@"

Message_02_78::
    db "<VOICE2>*: Your party may<LINE>"
    db "enter in battles<PROMPT>"
    db "<NEXT>ranging from the"
    db "<NEXT>C to S Class, but<PROMPT>"
    db "<NEXT>there is an entry"
    db "<NEXT>fee per Class.<PROMPT>"
    db "<NEXT>Win three battles"
    db "<NEXT>to take the title.<PROMPT>"
    db "<NEXT>A Magic Key is the"
    db "<NEXT>champ's prize.<PROMPT>"
    db "<NEXT>You can't use any"
    db "<NEXT>items in battle.<PROMPT>"
    db "<NEXT>And you forfeit if"
    db "<NEXT>you flee.<PROMPT>"
    db "<NEXT>Shoot for glory as"
    db "<NEXT>the S Class champ!<WAIT>"
    db "@"

Message_02_79::
    db "<VOICE2>*: Oops, it's not<LINE>"
    db "your first time!<PROMPT>"
    db "<NEXT>Please excuse my"
    db "<NEXT>rudeness, sweetie!<WAIT>"
    db "@"

Message_02_7A::
    db "<VOICE1>*: Listen, this is<LINE>"
    db "a secret.<PROMPT>"
    db "<NEXT>There's a man who"
    db "<NEXT>trades TinyMedals<PROMPT>"
    db "<NEXT>for impressive"
    db "<NEXT>gifts.<WAIT>"
    db "@"

Message_02_7B::
    db "<VOICE2>*: Which to take?<LINE>"
    db "Monsters you've<PROMPT>"
    db "<NEXT>raised, or those"
    db "<NEXT>you befriended?<WAIT>"
    db "@"

Message_02_7C::
    db "<VOICE1>*: You need luck on<LINE>"
    db "your side to win<PROMPT>"
    db "<NEXT>at the Arena."
    db "<NEXT>Put another way,<PROMPT>"
    db "<NEXT>you could win just"
    db "<NEXT>by getting lucky.<WAIT>"
    db "@"

Message_02_7D::
    db "<VOICE2>*: What do you<LINE>"
    db "suppose monsters<PROMPT>"
    db "<NEXT>are thinking?"
    db "<NEXT>I can never tell.<PROMPT>"
    db "<NEXT>It bothers me when"
    db "<NEXT>they stare.<PROMPT>"
    db "<NEXT>Do they consider"
    db "<NEXT>me to be food?<WAIT>"
    db "@"

Message_02_7E::
    db "<VOICE1>*: GRAH, HUNGRY.<LINE>"
    db "LOOK DELICIOUS…<WAIT>"
    db "@"

Message_02_7F::
    db "<VOICE2>*: It's not easy to<LINE>"
    db "win right away.<PROMPT>"
    db "<NEXT>Take note of your"
    db "<NEXT>opponents, and put<PROMPT>"
    db "<NEXT>together a winning"
    db "<NEXT>team and strategy!<WAIT>"
    db "@"

Message_02_80::
    db "<VOICE2>*: Mama is a big<LINE>"
    db "worrier…<PROMPT>"
    db "<NEXT>But she wants me"
    db "<NEXT>to be a master…<PROMPT>"
    db "<NEXT>How selfish can"
    db "<NEXT>she be?<WAIT>"
    db "@"

Message_02_81::
    db "<VOICE2>*: Oh, a cute<LINE>"
    db "little master!<PROMPT>"
    db "<NEXT>Are you going to"
    db "<NEXT>compete?<PROMPT>"
    db "<NEXT>…Want to hear"
    db "<NEXT>something useful?<CHOICE>"
    db "@"

Message_02_82::
    db "<VOICE2>*: In the Kids<LINE>"
    db "Class final, watch<PROMPT>"
    db "<NEXT>out for KiteHawk."
    db "<NEXT>Monsters need to<PROMPT>"
    db "<NEXT>take guard if it"
    db "<NEXT>charges power.<WAIT>"
    db "@"

Message_02_83::
    db "<VOICE2>*: Oh. Well, I'll<LINE>"
    db "be here for you.<WAIT>"
    db "@"

Message_02_84::
    db "<VOICE1>*: I come to watch<LINE>"
    db "every day.<PROMPT>"
    db "<NEXT>The masters are"
    db "<NEXT>getting tougher!<WAIT>"
    db "@"

Message_02_85::
    db "<VOICE2>*: Monsters mirror<LINE>"
    db "their masters.<PROMPT>"
    db "<NEXT>The plans you give"
    db "<NEXT>in battle<PROMPT>"
    db "<NEXT>gradually change"
    db "<NEXT>personality.<WAIT>"
    db "@"

Message_02_86::
    db "<VOICE1>*: The Arena is<LINE>"
    db "where masters can<PROMPT>"
    db "<NEXT>test their mettle"
    db "<NEXT>against others.<PROMPT>"
    db "<NEXT>Battles between"
    db "<NEXT>tough masters are<PROMPT>"
    db "<NEXT>intense to see,"
    db "<NEXT>let me tell you.<PROMPT>"
    db "<NEXT>The S Class is"
    db "<NEXT>especially hot!<WAIT>"
    db "@"

Message_02_87::
    db "<VOICE1>*: Monsters can<LINE>"
    db "grow only so much.<PROMPT>"
    db "<NEXT>They won't level"
    db "<NEXT>up after that.<WAIT>"
    db "@"

Message_02_88::
    db "<VOICE2>*: My husband is a<LINE>"
    db "master still.<PROMPT>"
    db "<NEXT>He may be old, but"
    db "<NEXT>he has knowledge<PROMPT>"
    db "<NEXT>that the young"
    db "<NEXT>people don't.<WAIT>"
    db "@"

Message_02_89::
    db "<VOICE1>*: Hello there.<LINE>"
    db "Do you know about<PROMPT>"
    db "<NEXT>the Starry Night"
    db "<NEXT>Tournament?<CHOICE>"
    db "@"

Message_02_8A::
    db "<VOICE1>*: The strongest<LINE>"
    db "master I've ever<PROMPT>"
    db "<NEXT>seen, that had to"
    db "<NEXT>be GreatLog's rep<PROMPT>"
    db "<NEXT>in the last Starry"
    db "<NEXT>Night Tournament.<PROMPT>"
    db "<NEXT>Her name was"
    db "<NEXT>Milayou.<PROMPT>"
    db "<NEXT>She came so close"
    db "<NEXT>to winning!<WAIT>"
    db "@"

Message_02_8B::
    db "<VOICE1>*: You don't know?<LINE>"
    db "Sorry about that.<PROMPT>"
    db "<NEXT>The Starry Night"
    db "<NEXT>Tournament is held<PROMPT>"
    db "<NEXT>on the night of a"
    db "<NEXT>meteor shower that<PROMPT>"
    db "<NEXT>arrives on every"
    db "<NEXT>47th full moon.<PROMPT>"
    db "<NEXT>On that night,"
    db "<NEXT>masters gather<PROMPT>"
    db "<NEXT>from all over the"
    db "<NEXT>world to battle.<PROMPT>"
    db "<NEXT>The winner is said"
    db "<NEXT>to bring great<PROMPT>"
    db "<NEXT>happiness to their"
    db "<NEXT>home kingdom.<WAIT>"
    db "@"

Message_02_8C::
    db "<VOICE1>*: Listen, to win<LINE>"
    db "you need balance.<PROMPT>"
    db "<NEXT>Attack, support"
    db "<NEXT>and heal-these<PROMPT>"
    db "<NEXT>roles should be"
    db "<NEXT>assigned to your<PROMPT>"
    db "<NEXT>monsters in a"
    db "<NEXT>balanced manner.<PROMPT>"
    db "<NEXT>That's the recipe"
    db "<NEXT>for victory.<WAIT>"
    db "@"

Message_02_8D::
    db "<VOICE1>*: It's not all<LINE>"
    db "about winning.<PROMPT>"
    db "<NEXT>We should, like,"
    db "<NEXT>take it easier.<WAIT>"
    db "@"

Message_02_8E::
    db "<VOICE1>*: Arrrrroooh!<LINE>"
    db "My blood burns!<PROMPT>"
    db "<NEXT>I can taste the"
    db "<NEXT>glory of battle!<WAIT>"
    db "@"

Message_02_8F::
    db "<VOICE1>*: If you come<LINE>"
    db "across a monster<PROMPT>"
    db "<NEXT>that you want,"
    db "<NEXT>don't be stingy.<PROMPT>"
    db "<NEXT>Give it lots of"
    db "<NEXT>tasty meat.<PROMPT>"
    db "<NEXT>That will make it"
    db "<NEXT>want to join you.<WAIT>"
    db "@"

Message_02_90::
    db "<VOICE1>*: Sirloin is the<LINE>"
    db "tops, harrumph!<PROMPT>"
    db "<NEXT>It just seems to"
    db "<NEXT>melt in the mouth!<WAIT>"
    db "@"

Message_02_91::
    db "<VOICE1>*: I… I didn't fall<LINE>"
    db "for any meat.<PROMPT>"
    db "<NEXT>I was impressed by"
    db "<NEXT>my master…<PROMPT>"
    db "<NEXT>Hey! Don't look"
    db "<NEXT>skeptical at me!<WAIT>"
    db "@"

Message_02_92::
    db "<VOICE1>*: They take entry<LINE>"
    db "fees from masters<PROMPT>"
    db "<NEXT>for competing in"
    db "<NEXT>the Arena.<PROMPT>"
    db "<NEXT>The fee goes up"
    db "<NEXT>with the Class.<PROMPT>"
    db "<NEXT>The Kids Class is"
    db "<NEXT>free to enter.<WAIT>"
    db "@"

Message_02_93::
    db "<VOICE1>*: If you win in<LINE>"
    db "the S Class, you<PROMPT>"
    db "<NEXT>can enter in more"
    db "<NEXT>battles to earn<PROMPT>"
    db "<NEXT>Magic Keys and"
    db "<NEXT>special items.<PROMPT>"
    db "<NEXT>I should become a"
    db "<NEXT>master too.<WAIT>"
    db "@"

Message_02_94::
    db "<VOICE2>*: If you win an<LINE>"
    db "Arena tourney,<PROMPT>"
    db "<NEXT>your prize is a"
    db "<NEXT>Magic Key.<PROMPT>"
    db "<NEXT>But you have to"
    db "<NEXT>get it appraised<PROMPT>"
    db "<NEXT>at the Key Shop to"
    db "<NEXT>use it.<WAIT>"
    db "@"
    ds $10f, $00
