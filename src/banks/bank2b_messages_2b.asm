; ROM bank $2B: messages
; The annotated listing of this bank is build/listing/bank2b.asm.

SECTION "Bank 2B", ROMX[$4000], BANK[$2B]
    db $2b

; message bank $2B: when wStringIndex < $8A, BeginStringDisplay with this bank's table
; MessageStrings_Bank2B; otherwise far-calls BeginStringDisplay_Bank2B_Overflow (E-0080)
BeginStringDisplay_Bank2B::
    ld a, [wStringIndex]
    cp $8a
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2B_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2B
    call BeginStringDisplay
    ret

; message bank $2B: when wStringIndex < $8A, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2B; otherwise far-calls CopyStringToBuffer_Bank2B_Overflow (E-0080)
CopyStringToBuffer_Bank2B::
    ld a, [wStringIndex]
    cp $8a
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2B_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2B
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2B_4032::
MessageStrings_Bank2B::
    dw StringList_2B_4034 ; id 0

; category list of StringCategories_2B_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2B_4034::
    dw Message_03_00 ; id 0
    dw Message_03_01 ; id 1
    dw Message_03_02 ; id 2
    dw Message_03_03 ; id 3
    dw Message_03_04 ; id 4
    dw Message_03_05 ; id 5
    dw Message_03_06 ; id 6
    dw Message_03_07 ; id 7
    dw Message_03_08 ; id 8
    dw Message_03_09 ; id 9
    dw Message_03_0A ; id 10
    dw Message_03_0B ; id 11
    dw Message_03_0C ; id 12
    dw Message_03_0D ; id 13
    dw Message_03_0E ; id 14
    dw Message_03_0F ; id 15
    dw Message_03_10 ; id 16
    dw Message_03_11 ; id 17
    dw Message_03_12 ; id 18
    dw Message_03_13 ; id 19
    dw Message_03_14 ; id 20
    dw Message_03_15 ; id 21
    dw Message_03_16 ; id 22
    dw Message_03_17 ; id 23
    dw Message_03_18 ; id 24
    dw Message_03_19 ; id 25
    dw Message_03_1A ; id 26
    dw Message_03_1B ; id 27
    dw Message_03_1C ; id 28
    dw Message_03_1D ; id 29
    dw Message_03_1E ; id 30
    dw Message_03_1F ; id 31
    dw Message_03_20 ; id 32
    dw Message_03_21 ; id 33
    dw Message_03_22 ; id 34
    dw Message_03_23 ; id 35
    dw Message_03_24 ; id 36
    dw Message_03_25 ; id 37
    dw Message_03_26 ; id 38
    dw Message_03_27 ; id 39
    dw Message_03_28 ; id 40
    dw Message_03_29 ; id 41
    dw Message_03_2A ; id 42
    dw Message_03_2B ; id 43
    dw Message_03_2C ; id 44
    dw Message_03_2D ; id 45
    dw Message_03_2E ; id 46
    dw Message_03_2F ; id 47
    dw Message_03_30 ; id 48
    dw Message_03_31 ; id 49
    dw Message_03_32 ; id 50
    dw Message_03_33 ; id 51
    dw Message_03_34 ; id 52
    dw Message_03_35 ; id 53
    dw Message_03_36 ; id 54
    dw Message_03_37 ; id 55
    dw Message_03_38 ; id 56
    dw Message_03_39 ; id 57
    dw Message_03_3A ; id 58
    dw Message_03_3B ; id 59
    dw Message_03_3C ; id 60
    dw Message_03_3D ; id 61
    dw Message_03_3E ; id 62
    dw Message_03_3F ; id 63
    dw Message_03_40 ; id 64
    dw Message_03_41 ; id 65
    dw Message_03_42 ; id 66
    dw Message_03_43 ; id 67
    dw Message_03_44 ; id 68
    dw Message_03_45 ; id 69
    dw Message_03_46 ; id 70
    dw Message_03_47 ; id 71
    dw Message_03_48 ; id 72
    dw Message_03_49 ; id 73
    dw Message_03_4A ; id 74
    dw Message_03_4B ; id 75
    dw Message_03_4C ; id 76
    dw Message_03_4D ; id 77
    dw Message_03_4E ; id 78
    dw Message_03_4F ; id 79
    dw Message_03_50 ; id 80
    dw Message_03_51 ; id 81
    dw Message_03_52 ; id 82
    dw Message_03_53 ; id 83
    dw Message_03_54 ; id 84
    dw Message_03_55 ; id 85
    dw Message_03_56 ; id 86
    dw Message_03_57 ; id 87
    dw Message_03_58 ; id 88
    dw Message_03_59 ; id 89
    dw Message_03_5A ; id 90
    dw Message_03_5B ; id 91
    dw Message_03_5C ; id 92
    dw Message_03_5D ; id 93
    dw Message_03_5E ; id 94
    dw Message_03_5F ; id 95
    dw Message_03_60 ; id 96
    dw Message_03_61 ; id 97
    dw Message_03_62 ; id 98
    dw Message_03_63 ; id 99
    dw Message_03_64 ; id 100
    dw Message_03_65 ; id 101
    dw Message_03_66 ; id 102
    dw Message_03_67 ; id 103
    dw Message_03_68 ; id 104
    dw Message_03_69 ; id 105
    dw Message_03_6A ; id 106
    dw Message_03_6B ; id 107
    dw Message_03_6C ; id 108
    dw Message_03_6D ; id 109
    dw Message_03_6E ; id 110
    dw Message_03_6F ; id 111
    dw Message_03_70 ; id 112
    dw Message_03_71 ; id 113
    dw Message_03_72 ; id 114
    dw Message_03_73 ; id 115
    dw Message_03_74 ; id 116
    dw Message_03_75 ; id 117
    dw Message_03_76 ; id 118
    dw Message_03_77 ; id 119
    dw Message_03_78 ; id 120
    dw Message_03_79 ; id 121
    dw Message_03_7A ; id 122
    dw Message_03_7B ; id 123
    dw Message_03_7C ; id 124
    dw Message_03_7D ; id 125
    dw Message_03_7E ; id 126
    dw Message_03_7F ; id 127
    dw Message_03_80 ; id 128
    dw Message_03_81 ; id 129
    dw Message_03_82 ; id 130
    dw Message_03_83 ; id 131
    dw Message_03_84 ; id 132
    dw Message_03_85 ; id 133
    dw Message_03_86 ; id 134
    dw Message_03_87 ; id 135
    dw Message_03_88 ; id 136
    dw Message_03_89 ; id 137

Message_03_00::
    db "<VOICE1>*: This is Norden,<LINE>"
    db "the kingdom of the<PROMPT>"
    db "<NEXT>north."
    db "<NEXT><WAIT>"
    db "@"

Message_03_01::
    db "<VOICE1>*: There are three<LINE>"
    db "kingdoms situated<PROMPT>"
    db "<NEXT>around a lake."
    db "<NEXT>They are to the<PROMPT>"
    db "<NEXT>north, east and"
    db "<NEXT>west.<WAIT>"
    db "@"

Message_03_02::
    db "<VOICE1>*: Travel north<LINE>"
    db "along the mountain<PROMPT>"
    db "<NEXT>range, and you'll"
    db "<NEXT>find a spring.<PROMPT>"
    db "<NEXT>An elemental"
    db "<NEXT>spirit of great<PROMPT>"
    db "<NEXT>beauty is said to"
    db "<NEXT>live there.<PROMPT>"
    db "<NEXT>She is supposed to"
    db "<NEXT>be a kindly spirit<PROMPT>"
    db "<NEXT>who watches over"
    db "<NEXT>people.<PROMPT>"
    db "<NEXT>I", $44, " like to see"
    db "<NEXT>her before I die…<WAIT>"
    db "@"

Message_03_03::
    db "<VOICE1>*: The winter here<LINE>"
    db "is harsh.<PROMPT>"
    db "<NEXT>Stay outside and"
    db "<NEXT>your eyelashes'll<PROMPT>"
    db "<NEXT>freeze and clamp"
    db "<NEXT>your eyes shut!<WAIT>"
    db "@"

Message_03_04::
    db "<VOICE2>*: Listen, did you<LINE>"
    db "hear?<PROMPT>"
    db "<NEXT>They found gold on"
    db "<NEXT>the border with<PROMPT>"
    db "<NEXT>the kingdom in the"
    db "<NEXT>west.<PROMPT>"
    db "<NEXT>The northern"
    db "<NEXT>kingdom found it<PROMPT>"
    db "<NEXT>first, but the"
    db "<NEXT>western kingdom is<PROMPT>"
    db "<NEXT>trying to hoard"
    db "<NEXT>all the gold!<WAIT>"
    db "@"

Message_03_05::
    db "<VOICE1>*: Urrrrrgh! The<LINE>"
    db "western wretches!<PROMPT>"
    db "<NEXT>The mine on the"
    db "<NEXT>border is on a<PROMPT>"
    db "<NEXT>rich vein of pure"
    db "<NEXT>gold!<PROMPT>"
    db "<NEXT>We should dig up"
    db "<NEXT>the gold before<PROMPT>"
    db "<NEXT>the westerners"
    db "<NEXT>take it!<WAIT>"
    db "@"

Message_03_06::
    db "<VOICE1>*: Everyone's been<LINE>"
    db "acting strangely<PROMPT>"
    db "<NEXT>since they found"
    db "<NEXT>gold in the mine.<PROMPT>"
    db "<NEXT>Even the King has"
    db "<NEXT>changed…<WAIT>"
    db "@"

Message_03_07::
    db "<VOICE2>*: The spring in<LINE>"
    db "the north, where<PROMPT>"
    db "<NEXT>the elemental"
    db "<NEXT>lives, has frozen.<PROMPT>"
    db "<NEXT>It has never done"
    db "<NEXT>that before, even<PROMPT>"
    db "<NEXT>in the worst cold"
    db "<NEXT>spells.<PROMPT>"
    db "<NEXT>The spring froze"
    db "<NEXT>when the gold was<PROMPT>"
    db "<NEXT>found. Could it be"
    db "<NEXT>mere coincidence?<WAIT>"
    db "@"

Message_03_08::
    db "<VOICE1>*: Have you heard<LINE>"
    db "about the spirit<PROMPT>"
    db "<NEXT>in the spring?"
    db "<NEXT><CHOICE>"
    db "@"

Message_03_09::
    db "<VOICE1>*: A long time ago<LINE>"
    db "the spirit made a<PROMPT>"
    db "<NEXT>shield using her"
    db "<NEXT>mystical powers.<PROMPT>"
    db "<NEXT>The shield floated"
    db "<NEXT>into the sky where<PROMPT>"
    db "<NEXT>it grew to an"
    db "<NEXT>enormous size.<PROMPT>"
    db "<NEXT>The shield guarded"
    db "<NEXT>people for many<PROMPT>"
    db "<NEXT>years from awful"
    db "<NEXT>blizzards.<PROMPT>"
    db "<NEXT>Over time, the"
    db "<NEXT>shield shrank back<PROMPT>"
    db "<NEXT>in size and fell"
    db "<NEXT>from the sky.<PROMPT>"
    db "<NEXT>It was called the"
    db "<NEXT>SkyShield.<PROMPT>"
    db "<NEXT>It is now interred"
    db "<NEXT>in the spring.<WAIT>"
    db "@"

Message_03_0A::
    db "<VOICE1>*: Many years ago,<LINE>"
    db "our ancestors came<PROMPT>"
    db "<NEXT>to this land after"
    db "<NEXT>a long journey.<PROMPT>"
    db "<NEXT>They were in a"
    db "<NEXT>precarious state<PROMPT>"
    db "<NEXT>because of the"
    db "<NEXT>vicious cold.<PROMPT>"
    db "<NEXT>The spring's"
    db "<NEXT>spirit took pity<PROMPT>"
    db "<NEXT>on them and used"
    db "<NEXT>her power to melt<PROMPT>"
    db "<NEXT>the ice and"
    db "<NEXT>relieve the cold.<PROMPT>"
    db "<NEXT>Since then, the"
    db "<NEXT>spirit has never<PROMPT>"
    db "<NEXT>appeared before"
    db "<NEXT>us, but she still<PROMPT>"
    db "<NEXT>watches over us"
    db "<NEXT>with compassion.<WAIT>"
    db "@"

Message_03_0B::
    db "<VOICE2>*: Around these<LINE>"
    db "parts, we get a<PROMPT>"
    db "<NEXT>lot of star spuds"
    db "<NEXT>as our food.<PROMPT>"
    db "<NEXT>They're sort of"
    db "<NEXT>like potatoes, but<PROMPT>"
    db "<NEXT>they grow by the"
    db "<NEXT>light of stars.<PROMPT>"
    db "<NEXT>They're gifts from"
    db "<NEXT>the spirit.<PROMPT>"
    db "<NEXT>Huh? Log's Navel?"
    db "<NEXT>They're just spuds.<WAIT>"
    db "@"

Message_03_0C::
    db "<VOICE1>*: It's become much<LINE>"
    db "colder.<PROMPT>"
    db "<NEXT>We may need the"
    db "<NEXT>help of the spirit<PROMPT>"
    db "<NEXT>again to break the"
    db "<NEXT>cold spell.<WAIT>"
    db "@"

Message_03_0D::
    db "<VOICE1>*: Welcome to our<LINE>"
    db "church.<PROMPT>"
    db "<NEXT>How may I be of"
    db "<NEXT>service?<WAIT>"
    db "@"

Message_03_0E::
    db "<VOICE1>*: His Majesty is<LINE>"
    db "in talks with the<PROMPT>"
    db "<NEXT>western kingdom's"
    db "<NEXT>representatives.<PROMPT>"
    db "<NEXT>He has no time to"
    db "<NEXT>deal with a child.<PROMPT>"
    db "<NEXT>Well, there was"
    db "<NEXT>another kid, but<PROMPT>"
    db "<NEXT>he claimed to be a"
    db "<NEXT>prince somewhere.<PROMPT>"
    db "<NEXT>We had to let him"
    db "<NEXT>through.<WAIT>"
    db "@"

Message_03_0F::
    db "<VOICE1>*: The mine on the<LINE>"
    db "western border is<PROMPT>"
    db "<NEXT>closed right now."
    db "<NEXT>It will reopen<PROMPT>"
    db "<NEXT>when the trouble"
    db "<NEXT>is solved.<WAIT>"
    db "@"

Message_03_10::
    db "<VOICE1>*: Welcome! How may<LINE>"
    db "I serve you today?<WAIT>"
    db "@"

Message_03_11::
    db "*: <BUF0> peered<LINE>"
    db "into the vase.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>lumpy potatoes.<WAIT>"
    db "@"

Message_03_12::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>black rocks.<WAIT>"
    db "@"

Message_03_13::
    db "<BUF0> peered into<LINE>"
    db "the oven.<PROMPT>"
    db "<NEXT>It felt just a"
    db "<NEXT>little warm.<WAIT>"
    db "@"

Message_03_14::
    db "<BUF0> tried to<LINE>"
    db "open the chest.<PROMPT>"
    db "<NEXT>But the treasure"
    db "<NEXT>chest was locked.<WAIT>"
    db "@"

Message_03_15::
    db "<VOICE1>*: The border is<LINE>"
    db "closed, so I can't<PROMPT>"
    db "<NEXT>get to the western"
    db "<NEXT>kingdom.<PROMPT>"
    db "<NEXT>That's the only"
    db "<NEXT>way to cross the<PROMPT>"
    db "<NEXT>mountains though."
    db "<NEXT>What a headache!<WAIT>"
    db "@"

Message_03_16::
    db "<BUF0> checked the<LINE>"
    db "shield.<PROMPT>"
    db "<NEXT>A beautiful voice"
    db "<NEXT>echoed.<WAIT>"
    db "@"

Message_03_17::
    db "<VOICE2>*: I am surprised<LINE>"
    db "that you hear me.<PROMPT>"
    db "<NEXT>You aren't from"
    db "<NEXT>this world.<PROMPT>"
    db "<NEXT>I am the elemental"
    db "<NEXT>spirit who guards<PROMPT>"
    db "<NEXT>over this world."
    db "<NEXT>At least I did.<PROMPT>"
    db "<NEXT>I had lost my"
    db "<NEXT>power, you see.<PROMPT>"
    db "<NEXT>I was rebuilding"
    db "<NEXT>my power to make<PROMPT>"
    db "<NEXT>my return to the"
    db "<NEXT>people, but some<PROMPT>"
    db "<NEXT>being cast a"
    db "<NEXT>shadow over the<PROMPT>"
    db "<NEXT>hearts of the"
    db "<NEXT>people.<PROMPT>"
    db "<NEXT>Even my spring"
    db "<NEXT>finally froze.<PROMPT>"
    db "<NEXT>If peace returns"
    db "<NEXT>to the souls of<PROMPT>"
    db "<NEXT>people, I too"
    db "<NEXT>will be saved.<PROMPT>"
    db "<NEXT>I sense a magical"
    db "<NEXT>power in you.<PROMPT>"
    db "<NEXT>Will you restore"
    db "<NEXT>peace to people?<CHOICE>"
    db "@"

Message_03_18::
    db "<VOICE2>*: You will?<LINE>"
    db "No words of thanks<PROMPT>"
    db "<NEXT>can ever be enough"
    db "<NEXT>for what I feel.<PROMPT>"
    db "<NEXT>If you restore"
    db "<NEXT>this world's peace,<PROMPT>"
    db "<NEXT>I will give you"
    db "<NEXT>this Sky Shield.<PROMPT>"
    db "<NEXT>Take this Crest,"
    db "<NEXT>child.<PROMPT>"
    db "<NEXT>It shows that you"
    db "<NEXT>act as my envoy.<PROMPT>"
    db "<NEXT>It will let you"
    db "<NEXT>into castles.<WAIT>"
    db "@"

Message_03_19::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<NEXT><BUF0> obtained the"
    db "<NEXT>Crest.<WAIT>"
    db "@"

Message_03_1A::
    db "<VOICE2>*: You may think<LINE>"
    db "terrible of me for<PROMPT>"
    db "<NEXT>asking you, a"
    db "<NEXT>total stranger, to<PROMPT>"
    db "<NEXT>bear such a heavy"
    db "<NEXT>burden…<PROMPT>"
    db "<NEXT>But only you seem"
    db "<NEXT>to hear my voice.<PROMPT>"
    db "<NEXT>Please. You are my"
    db "<NEXT>only hope.<WAIT>"
    db "@"

Message_03_1B::
    db "<VOICE2>*: If you restore<LINE>"
    db "this world's peace,<PROMPT>"
    db "<NEXT>I will give you"
    db "<NEXT>this Sky Shield.<PROMPT>"
    db "<NEXT>My Crest will"
    db "<NEXT>allow entry into<PROMPT>"
    db "<NEXT>castles as my"
    db "<NEXT>envoy.<WAIT>"
    db "@"

Message_03_1C::
    db "<VOICE1>*: What is that<LINE>"
    db "dirty medal?<PROMPT>"
    db "<NEXT>The spirit's Crest!"
    db "<NEXT>You're an envoy!<PROMPT>"
    db "<NEXT>I beg your pardon!"
    db "<NEXT><WAIT>"
    db "@"

Message_03_1D::
    db "<VOICE1>*: Please enter,<LINE>"
    db "your envoyship!<WAIT>"
    db "@"

Message_03_1E::
    db "<VOICE1>*: His Majesty has<LINE>"
    db "been cranky…<PROMPT>"
    db "<NEXT>Is the trouble at"
    db "<NEXT>the mine weighing<PROMPT>"
    db "<NEXT>heavily on his"
    db "<NEXT>mind?<WAIT>"
    db "@"

Message_03_1F::
    db "<VOICE1>*: After the gold<LINE>"
    db "discovery, our<PROMPT>"
    db "<NEXT>relationship with"
    db "<NEXT>the west soured.<PROMPT>"
    db "<NEXT>It might lead to"
    db "<NEXT>war… …Shudder…<WAIT>"
    db "@"

Message_03_20::
    db "<VOICE1>*: I remember the<LINE>"
    db "King to be placid,<PROMPT>"
    db "<NEXT>but he has been"
    db "<NEXT>working hard as if<PROMPT>"
    db "<NEXT>he were possessed"
    db "<NEXT>of late.<WAIT>"
    db "@"

Message_03_21::
    db "<VOICE1>*: Ah, you are the<LINE>"
    db "spirit's envoy.<PROMPT>"
    db "<NEXT>His Majesty is"
    db "<NEXT>beyond here.<PROMPT>"
    db "<NEXT>I ask that you be"
    db "<NEXT>on your best<PROMPT>"
    db "<NEXT>behavior."
    db "<NEXT><WAIT>"
    db "@"

Message_03_22::
    db "<VOICE1>*: You're the envoy?<LINE>"
    db "…Well, no matter!<PROMPT>"
    db "<NEXT>We had started"
    db "<NEXT>mining the<PROMPT>"
    db "<NEXT>mountains on the"
    db "<NEXT>border first.<PROMPT>"
    db "<NEXT>The west comes"
    db "<NEXT>along later and<PROMPT>"
    db "<NEXT>demands mining"
    db "<NEXT>rights?<PROMPT>"
    db "<NEXT>Pah! The brazen"
    db "<NEXT>nerve of them!<PROMPT>"
    db "<NEXT>This problem is"
    db "<NEXT>solved by the west<PROMPT>"
    db "<NEXT>abandoning their"
    db "<NEXT>frivolous claim.<PROMPT>"
    db "<NEXT>Until then, the"
    db "<NEXT>border is closed!<WAIT>"
    db "@"

Message_03_23::
    db "<VOICE1>*: His Majesty is<LINE>"
    db "furious over the<PROMPT>"
    db "<NEXT>western kingdom's"
    db "<NEXT>conduct.<PROMPT>"
    db "<NEXT>He isn't open to"
    db "<NEXT>reason anymore.<WAIT>"
    db "@"

Message_03_24::
    db "<VOICE1>*: This tunnel goes<LINE>"
    db "to a port.<PROMPT>"
    db "<NEXT>The lake is frozen"
    db "<NEXT>around it though,<PROMPT>"
    db "<NEXT>so now it can't"
    db "<NEXT>serve as a port.<WAIT>"
    db "@"

Message_03_25::
    db "<VOICE1>*: This is the port<LINE>"
    db "of Nofor.<WAIT>"
    db "@"

Message_03_26::
    db "<VOICE1>*: It's useless!<LINE>"
    db "Beyond useless!<PROMPT>"
    db "<NEXT>The ice has the"
    db "<NEXT>port clogged.<PROMPT>"
    db "<NEXT>No ships can sail."
    db "<NEXT>I'll go bankrupt!<WAIT>"
    db "@"

Message_03_27::
    db "<VOICE1>*: In all my years,<LINE>"
    db "I've never seen<PROMPT>"
    db "<NEXT>the port frozen in"
    db "<NEXT>like that.<WAIT>"
    db "@"

Message_03_28::
    db "<VOICE2>*: Three kingdoms<LINE>"
    db "ring this lake.<PROMPT>"
    db "<NEXT>They are in the"
    db "<NEXT>north, west and<PROMPT>"
    db "<NEXT>east of the"
    db "<NEXT>inland sea.<PROMPT>"
    db "<NEXT>The east is ruled"
    db "<NEXT>by Queen Helen.<PROMPT>"
    db "<NEXT>She foresees the"
    db "<NEXT>future in her<PROMPT>"
    db "<NEXT>dreams with"
    db "<NEXT>amazing accuracy.<WAIT>"
    db "@"

Message_03_29::
    db "<VOICE1>*: The border?<LINE>"
    db "It's not here.<PROMPT>"
    db "<NEXT>The border is at"
    db "<NEXT>the gold mine.<PROMPT>"
    db "<NEXT>Go back up through"
    db "<NEXT>the tunnel, and go<PROMPT>"
    db "<NEXT>southwest along"
    db "<NEXT>the mountains.<WAIT>"
    db "@"

Message_03_2A::
    db "<VOICE1>*: Mama said to<LINE>"
    db "stay off the ice.<PROMPT>"
    db "<NEXT>It can break if"
    db "<NEXT>it's too thin.<WAIT>"
    db "@"

Message_03_2B::
    db "<VOICE1>*: We were passing<LINE>"
    db "through from the<PROMPT>"
    db "<NEXT>east, but the ice"
    db "<NEXT>sealed us in.<PROMPT>"
    db "<NEXT>We've been stuck"
    db "<NEXT>here a month.<WAIT>"
    db "@"

Message_03_2C::
    db "<VOICE2>*: They discovered<LINE>"
    db "gold at the mine<PROMPT>"
    db "<NEXT>on the western"
    db "<NEXT>border!<PROMPT>"
    db "<NEXT>I wish someone", $44
    db "<NEXT>give me some.<WAIT>"
    db "@"

Message_03_2D::
    db "<VOICE1>*: I hear the west<LINE>"
    db "and the north are<PROMPT>"
    db "<NEXT>locking horns over"
    db "<NEXT>the gold mine.<PROMPT>"
    db "<NEXT>I can feel trouble"
    db "<NEXT>stirring…<WAIT>"
    db "@"

Message_03_2E::
    db "<VOICE1>*: Do you know Lady<LINE>"
    db "Yuna of the west?<PROMPT>"
    db "<NEXT>I heard that she's"
    db "<NEXT>really lively.<PROMPT>"
    db "<NEXT>I like cheerfully"
    db "<NEXT>loud girls.<WAIT>"
    db "@"

Message_03_2F::
    db "<VOICE1>*: The scholar in<LINE>"
    db "the tavern said he<PROMPT>"
    db "<NEXT>came from the"
    db "<NEXT>eastern kingdom.<PROMPT>"
    db "<NEXT>He knows of every"
    db "<NEXT>plant in the area.<WAIT>"
    db "@"

Message_03_30::
    db "<VOICE1>*: Don't you think<LINE>"
    db "it's too expensive?<PROMPT>"
    db "<NEXT>If I had a Gold"
    db "<NEXT>Pass, I", $44, " get a<PROMPT>"
    db "<NEXT>bit of a discount,"
    db "<NEXT>but even then…<WAIT>"
    db "@"

Message_03_31::
    db "<VOICE1>*: Welcome! What<LINE>"
    db "can I do for you?<WAIT>"
    db "@"

Message_03_32::
    db "<VOICE1>*: Greetings! How<LINE>"
    db "shall I serve you?<WAIT>"
    db "@"

Message_03_33::
    db "<VOICE1>*: Hello! Have a<LINE>"
    db "look at my wares!<WAIT>"
    db "@"

Message_03_34::
    db "<VOICE1>*: We've been full<LINE>"
    db "up with sailors<PROMPT>"
    db "<NEXT>who've been stuck"
    db "<NEXT>in port.<PROMPT>"
    db "<NEXT>We're doing brisk"
    db "<NEXT>business, but the<PROMPT>"
    db "<NEXT>atmosphere-it's"
    db "<NEXT>like a funeral.<PROMPT>"
    db "<NEXT>I can understand"
    db "<NEXT>why a landlocked<PROMPT>"
    db "<NEXT>sailor would be"
    db "<NEXT>down, but…<WAIT>"
    db "@"

Message_03_35::
    db "<VOICE1>*: Urrrp! Hoo,<LINE>"
    db "listen to this!<PROMPT>"
    db "<NEXT>My ship, she froze"
    db "<NEXT>solid in ice, hey?<PROMPT>"
    db "<NEXT>We left her and"
    db "<NEXT>managed to make it<PROMPT>"
    db "<NEXT>ashore barely."
    db "<NEXT>Our cursed luck!<WAIT>"
    db "@"

Message_03_36::
    db "<VOICE2>*: …Sigh… Isn't that<LINE>"
    db "scholar appealing?<PROMPT>"
    db "<NEXT>The intellect in"
    db "<NEXT>his eyes… Ooh…<WAIT>"
    db "@"

Message_03_37::
    db "<VOICE1>*: I came from the<LINE>"
    db "eastern kingdom.<PROMPT>"
    db "<NEXT>I'm a scholar of"
    db "<NEXT>plants.<PROMPT>"
    db "<NEXT>My studies have"
    db "<NEXT>taken me afar.<PROMPT>"
    db "<NEXT>I", $44, " like to go"
    db "<NEXT>back home though.<PROMPT>"
    db "<NEXT>I wonder when the"
    db "<NEXT>ships will sail?<WAIT>"
    db "@"

Message_03_38::
    db "<VOICE1>*: The King of the<LINE>"
    db "west is said to<PROMPT>"
    db "<NEXT>dote on his only"
    db "<NEXT>daughter.<PROMPT>"
    db "<NEXT>She's supposed to"
    db "<NEXT>be a lively kid.<WAIT>"
    db "@"

Message_03_39::
    db "<VOICE1>*: This is the<LINE>"
    db "border we share<PROMPT>"
    db "<NEXT>with the western"
    db "<NEXT>kingdom.<PROMPT>"
    db "<NEXT>The cave you see"
    db "<NEXT>there is the mine<PROMPT>"
    db "<NEXT>in which gold was"
    db "<NEXT>discovered.<WAIT>"
    db "@"

Message_03_3A::
    db "<VOICE1>*: The border has<LINE>"
    db "been sealed by the<PROMPT>"
    db "<NEXT>King's orders"
    db "<NEXT>until the west<PROMPT>"
    db "<NEXT>recognizes the"
    db "<NEXT>mine to be ours.<WAIT>"
    db "@"

Message_03_3B::
    db "<VOICE1>*: A traveler, are<LINE>"
    db "you?<PROMPT>"
    db "<NEXT>Sorry, but I can't"
    db "<NEXT>allow you to pass.<PROMPT>"
    db "<NEXT>The west is beyond"
    db "<NEXT>here, but they've<PROMPT>"
    db "<NEXT>also been digging"
    db "<NEXT>from their side.<PROMPT>"
    db "<NEXT>So our hole and"
    db "<NEXT>their hole ended<PROMPT>"
    db "<NEXT>up linking in the"
    db "<NEXT>mountain.<PROMPT>"
    db "<NEXT>It's a sticky"
    db "<NEXT>little mess.<WAIT>"
    db "@"

Message_03_3C::
    db "<VOICE1>*: Our tunneling<LINE>"
    db "found gold, but we<PROMPT>"
    db "<NEXT>also ran into the"
    db "<NEXT>tunnel the west<PROMPT>"
    db "<NEXT>was boring from"
    db "<NEXT>their side.<PROMPT>"
    db "<NEXT>Both sides have"
    db "<NEXT>laid claim to the<PROMPT>"
    db "<NEXT>gold and refuse"
    db "<NEXT>to concede.<PROMPT>"
    db "<NEXT>That's why we have"
    db "<NEXT>this standoff.<WAIT>"
    db "@"

Message_03_3D::
    db "<VOICE1>*: This side is the<LINE>"
    db "western kingdom!<PROMPT>"
    db "<NEXT>You've come from"
    db "<NEXT>the other side!<PROMPT>"
    db "<NEXT>You're from the"
    db "<NEXT>north! Be gone!<WAIT>"
    db "@"

Message_03_3E::
    db "<VOICE1>*: The northerners"
    db "<NEXT>want our gold!<PROMPT>"
    db "<NEXT>There's no trusting"
    db "<NEXT>the greedy scum!<PROMPT>"
    db "<NEXT>They must be"
    db "<NEXT>conspiring to take<PROMPT>"
    db "<NEXT>our land too, I"
    db "<NEXT>just know it!<WAIT>"
    db "@"

Message_03_3F::
    db "<VOICE1>*: The northerners<LINE>"
    db "muscled in on the<PROMPT>"
    db "<NEXT>gold mine that we"
    db "<NEXT>discovered.<PROMPT>"
    db "<NEXT>Can you understand"
    db "<NEXT>the arrogance?<WAIT>"
    db "@"

Message_03_40::
    db "<VOICE1>*: Heh, you've come<LINE>"
    db "way down deep.<PROMPT>"
    db "<NEXT>The monsters are"
    db "<NEXT>tough down here!<WAIT>"
    db "@"

Message_03_41::
    db "<VOICE1>*: There is a<LINE>"
    db "boulder blocking<PROMPT>"
    db "<NEXT>the way a little"
    db "<NEXT>further ahead.<PROMPT>"
    db "<NEXT>If there was a way"
    db "<NEXT>to break it…<WAIT>"
    db "@"

Message_03_42::
    db "<VOICE1>*: Hurry! We have<LINE>"
    db "to beat the swine<PROMPT>"
    db "<NEXT>of the west to the"
    db "<NEXT>mine!<WAIT>"
    db "@"

Message_03_43::
    db "<VOICE1>*: The vein of gold<LINE>"
    db "is just ahead!<PROMPT>"
    db "<NEXT>Hurry! It's winner"
    db "<NEXT>take all!<WAIT>"
    db "@"

Message_03_44::
    db "<VOICE1>*: The gold is<LINE>"
    db "ours! The west<PROMPT>"
    db "<NEXT>must not get their"
    db "<NEXT>hands on it!<PROMPT>"
    db "<NEXT>Hurry, we're almost"
    db "<NEXT>there!<WAIT>"
    db "@"

Message_03_45::
    db "<VOICE1>*: Kid, you have<LINE>"
    db "guts to be here.<WAIT>"
    db "@"

Message_03_46::
    db "<VOICE1>*: Don't you touch<LINE>"
    db "that.<PROMPT>"
    db "<NEXT>If you had only"
    db "<NEXT>dreamt of the gold<PROMPT>"
    db "<NEXT>like the fools"
    db "<NEXT>outside…<PROMPT>"
    db "<NEXT>Your sneaking"
    db "<NEXT>around isn't good<PROMPT>"
    db "<NEXT>for our plans."
    db "<NEXT>You'll have to go.<WAIT>"
    db "@"

Message_03_47::
    db "<VOICE1>*: You again? I'll<LINE>"
    db "have to get ugly.<WAIT>"
    db "@"

Message_03_48::
    db "<VOICE1>*: Darn! Take this!<LINE>"
    db "SACRIFICE!<WAIT>"
    db "@"

Message_03_49::
    db "<VOICE1>*: What? What was<LINE>"
    db "that explosion?<WAIT>"
    db "@"

Message_03_4A::
    db "<VOICE1>*: That dust there…<LINE>"
    db "Is that the gold?<WAIT>"
    db "@"

Message_03_4B::
    db "<VOICE1>*: What? That's all<LINE>"
    db "that there was?<PROMPT>"
    db "<NEXT>You mean to tell"
    db "<NEXT>me that we've been<PROMPT>"
    db "<NEXT>acting like"
    db "<NEXT>loggerheads over<PROMPT>"
    db "<NEXT>just that?"
    db "<NEXT><WAIT>"
    db "@"

Message_03_4C::
    db "<VOICE1>*: We", $44, " better get<LINE>"
    db "word to the King!<WAIT>"
    db "@"

Message_03_4D::
    db "<VOICE1>*: That's true…<LINE>"
    db "I've got to…<PROMPT>"
    db "<NEXT>I have to tell my"
    db "<NEXT>King the news!<WAIT>"
    db "@"

Message_03_4E::
    db "<VOICE1>*: We almost went<LINE>"
    db "to war with the<PROMPT>"
    db "<NEXT>west over a tiny"
    db "<NEXT>amount of gold.<PROMPT>"
    db "<NEXT>We must have been"
    db "<NEXT>possessed.<WAIT>"
    db "@"

Message_03_4F::
    db "<VOICE1>*: The King has<LINE>"
    db "sealed the border.<PROMPT>"
    db "<NEXT>He suspects that"
    db "<NEXT>the whole incident<PROMPT>"
    db "<NEXT>was concocted by"
    db "<NEXT>the west.<WAIT>"
    db "@"

Message_03_50::
    db "<VOICE1>*: We're still under<LINE>"
    db "orders to keep the<PROMPT>"
    db "<NEXT>border with the"
    db "<NEXT>west sealed.<PROMPT>"
    db "<NEXT>This, despite the"
    db "<NEXT>absence of gold.<PROMPT>"
    db "<NEXT>What's gotten into"
    db "<NEXT>his Majesty?<WAIT>"
    db "@"

Message_03_51::
    db "<VOICE1>*: Was that really<LINE>"
    db "all the gold?<PROMPT>"
    db "<NEXT>To find out, we've"
    db "<NEXT>started excavating<PROMPT>"
    db "<NEXT>together with the"
    db "<NEXT>westerners.<PROMPT>"
    db "<NEXT>Once you get to"
    db "<NEXT>know them, they're<PROMPT>"
    db "<NEXT>not bad people at"
    db "<NEXT>all.<WAIT>"
    db "@"

Message_03_52::
    db "<VOICE1>*: I've heard…<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>There was almost"
    db "<NEXT>no gold at all.<PROMPT>"
    db "<NEXT>What purpose did"
    db "<NEXT>we serve?<WAIT>"
    db "@"

Message_03_53::
    db "<VOICE1>*: The north's King<LINE>"
    db "still suspects us.<PROMPT>"
    db "<NEXT>I'm sorry, but we"
    db "<NEXT>can't let you pass.<WAIT>"
    db "@"

Message_03_54::
    db "<VOICE1>*: We're not certain<LINE>"
    db "about what we'll<PROMPT>"
    db "<NEXT>find, but we'll"
    db "<NEXT>keep picking away.<WAIT>"
    db "@"

Message_03_55::
    db "<VOICE2>*: I've heard about<LINE>"
    db "the mine.<PROMPT>"
    db "<NEXT>Isn't it horrible?"
    db "<NEXT>Squabbling over<PROMPT>"
    db "<NEXT>gold that wasn't"
    db "<NEXT>even there…<WAIT>"
    db "@"

Message_03_56::
    db "<VOICE1>*: There's just no<LINE>"
    db "telling what greed<PROMPT>"
    db "<NEXT>will make people"
    db "<NEXT>do…<WAIT>"
    db "@"

Message_03_57::
    db "<VOICE1>*: Did you know?<LINE>"
    db "There is a tunnel<PROMPT>"
    db "<NEXT>on the way to the"
    db "<NEXT>border.<PROMPT>"
    db "<NEXT>It leads to a"
    db "<NEXT>little port.<PROMPT>"
    db "<NEXT>If you're going to"
    db "<NEXT>the west, it might<PROMPT>"
    db "<NEXT>be worth your time"
    db "<NEXT>to visit.<WAIT>"
    db "@"

Message_03_58::
    db "<VOICE1>*: I've heard from<LINE>"
    db "friends who came<PROMPT>"
    db "<NEXT>back from the mine"
    db "<NEXT>that there's no<PROMPT>"
    db "<NEXT>gold to be found"
    db "<NEXT>there at all.<PROMPT>"
    db "<NEXT>But the King still"
    db "<NEXT>suspects the west…<WAIT>"
    db "@"

Message_03_59::
    db "<VOICE1>*: We reported to<LINE>"
    db "the King that the<PROMPT>"
    db "<NEXT>mine had no gold"
    db "<NEXT>to start with,<PROMPT>"
    db "<NEXT>but he refuses to"
    db "<NEXT>believe us and<PROMPT>"
    db "<NEXT>blames the west"
    db "<NEXT>for stealing the<PROMPT>"
    db "<NEXT>gold."
    db "<NEXT>Perhaps you can<PROMPT>"
    db "<NEXT>speak to him?"
    db "<NEXT><WAIT>"
    db "@"

Message_03_5A::
    db "<VOICE1>*: What is it, you<LINE>"
    db "whelp!?<PROMPT>"
    db "<NEXT>You claim that the"
    db "<NEXT>mine has no gold?<PROMPT>"
    db "<NEXT>You dare question"
    db "<NEXT>my authority?<WAIT>"
    db "@"

Message_03_5B::
    db "<VOICE1>*: You're no envoy<LINE>"
    db "of the spirit!<PROMPT>"
    db "<NEXT>You must be a"
    db "<NEXT>western spy!<PROMPT>"
    db "<NEXT>You can rot in the"
    db "<NEXT>dungeon!<WAIT>"
    db "@"

Message_03_5C::
    db "<VOICE1>*: Ah, saved at<LINE>"
    db "last!<PROMPT>"
    db "<NEXT>The two of us were"
    db "<NEXT>trapped alone.<PROMPT>"
    db "<NEXT>I'm the real King."
    db "<NEXT>The one on my<PROMPT>"
    db "<NEXT>throne is a vile"
    db "<NEXT>impostor!<PROMPT>"
    db "<NEXT>I was abducted in"
    db "<NEXT>my sleep and held<PROMPT>"
    db "<NEXT>captive down here."
    db "<NEXT>I tried to escape<PROMPT>"
    db "<NEXT>but the exit has"
    db "<NEXT>been sealed.<PROMPT>"
    db "<NEXT>It was closed up"
    db "<NEXT>recently, but I<PROMPT>"
    db "<NEXT>have no idea where"
    db "<NEXT>to find it.<WAIT>"
    db "@"

Message_03_5D::
    db "<VOICE1>*: I want to get<LINE>"
    db "out, but the exit<PROMPT>"
    db "<NEXT>has been sealed."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>It was closed up"
    db "<NEXT>recently, but I<PROMPT>"
    db "<NEXT>have no idea where"
    db "<NEXT>to find it.<WAIT>"
    db "@"

Message_03_5E::
    db "<VOICE1>Kameha: Where's<LINE>"
    db "the exit?<PROMPT>"
    db "<NEXT>We'll starve down"
    db "<NEXT>here if we don't<PROMPT>"
    db "<NEXT>find the way out"
    db "<NEXT>soon!<WAIT>"
    db "@"

Message_03_5F::
    db "<VOICE1>Kameha: Where's<LINE>"
    db "the exit?<PROMPT>"
    db "<NEXT>We'll starve down"
    db "<NEXT>here if we don't<PROMPT>"
    db "<NEXT>find the way out"
    db "<NEXT>soon!<WAIT>"
    db "@"

Message_03_60::
    db "<BUF0> tapped on<LINE>"
    db "the wall.<PROMPT>"
    db "<NEXT>The wall sounded"
    db "<NEXT>heavy and solid.<WAIT>"
    db "@"

Message_03_61::
    db "<VOICE1>Kameha: So that's<LINE>"
    db "where the exit is!<PROMPT>"
    db "<NEXT><BUF0>, here, stand"
    db "<NEXT>aside!<WAIT>"
    db "@"

Message_03_62::
    db "<VOICE1>Kameha: …<BUF0>…<LINE>"
    db "That wasn't it…<WAIT>"
    db "@"

Message_03_63::
    db "<BUF0> tapped on<LINE>"
    db "the wall.<PROMPT>"
    db "<NEXT>Sound echoed as if"
    db "<NEXT>it were hollow.<WAIT>"
    db "@"

Message_03_64::
    db "<VOICE1>Kameha: That's it!<LINE>"
    db "That's the exit!<PROMPT>"
    db "<NEXT><BUF0>, I'll go on"
    db "<NEXT>ahead!<WAIT>"
    db "@"

Message_03_65::
    db "<VOICE1>*: I'm the real<LINE>"
    db "King, you fake!<WAIT>"
    db "@"

Message_03_66::
    db "<VOICE1>*: What? How dare<LINE>"
    db "you, impostor!<PROMPT>"
    db "<NEXT>I'm the real King!"
    db "<NEXT>Not you!<WAIT>"
    db "@"

Message_03_67::
    db "<VOICE1>*: I'm real! Don't<LINE>"
    db "you believe me?<WAIT>"
    db "@"

Message_03_68::
    db "<VOICE1>*: Look in my eyes!<LINE>"
    db "I'm not lying!<WAIT>"
    db "@"

Message_03_69::
    db "<VOICE1>*: If you can't see<LINE>"
    db "the truth, you'll<PROMPT>"
    db "<NEXT>never become a"
    db "<NEXT>great hero!<WAIT>"
    db "@"

Message_03_6A::
    db "<VOICE1>*: Didn't we work<LINE>"
    db "together to escape<PROMPT>"
    db "<NEXT>from the dungeon?"
    db "<NEXT>I'm the real King!<WAIT>"
    db "@"

Message_03_6B::
    db "The mirror shows<LINE>"
    db "the King.<WAIT>"
    db "@"

Message_03_6C::
    db "<VOICE1>*: I am real!<LINE>"
    db "Don't believe him!<WAIT>"
    db "@"

Message_03_6D::
    db "<VOICE1>*: My regal bearing<LINE>"
    db "should be evidence<PROMPT>"
    db "<NEXT>that I am the real"
    db "<NEXT>King!<WAIT>"
    db "@"

Message_03_6E::
    db "<VOICE1>*: Look at him!<LINE>"
    db "He's grimy!<PROMPT>"
    db "<NEXT>He's no comparison"
    db "<NEXT>to me!<WAIT>"
    db "@"

Message_03_6F::
    db "<VOICE1>*: You suspect me<LINE>"
    db "still? Kiki!<PROMPT>"
    db "<NEXT>Gaaah! A slip of"
    db "<NEXT>the tongue, kiki!<WAIT>"
    db "@"

Message_03_70::
    db "<VOICE1>*: Arrgh, you've<LINE>"
    db "ruined my plan to<PROMPT>"
    db "<NEXT>cause conflict by"
    db "<NEXT>impersonating the<PROMPT>"
    db "<NEXT>King, kikiki!"
    db "<NEXT>You will pay!<WAIT>"
    db "@"

Message_03_71::
    db "The mirror shows a<LINE>"
    db "monster.<WAIT>"
    db "@"

Message_03_72::
    db "<VOICE1>*: It almost worked<LINE>"
    db "to perfection!<PROMPT>"
    db "<NEXT>It's all your"
    db "<NEXT>fault, kikiki!<WAIT>"
    db "@"

Message_03_73::
    db "<VOICE1>*: Awaaargh!<LINE>"
    db "A m-m-monster!<PROMPT>"
    db "<NEXT>A monster was"
    db "<NEXT>impersonating me!<WAIT>"
    db "@"

Message_03_74::
    db "<VOICE1>*: Bravo!<LINE>"
    db "We're saved!<PROMPT>"
    db "<NEXT>Thank you for"
    db "<NEXT>seeing that I am<PROMPT>"
    db "<NEXT>the true King of"
    db "<NEXT>Norden!<PROMPT>"
    db "<NEXT>I will put a stop"
    db "<NEXT>to the squabbling<PROMPT>"
    db "<NEXT>with the western"
    db "<NEXT>kingdom.<PROMPT>"
    db "<NEXT>I'll have the"
    db "<NEXT>border reopened.<WAIT>"
    db "@"

Message_03_75::
    db "<VOICE1>King: I'll have<LINE>"
    db "the border opened.<PROMPT>"
    db "<NEXT>It is a long way"
    db "<NEXT>to the western<PROMPT>"
    db "<NEXT>kingdom, however."
    db "<NEXT>Do take care.<WAIT>"
    db "@"

Message_03_76::
    db "<VOICE1>*: Who would've<LINE>"
    db "thought that a<PROMPT>"
    db "<NEXT>monster would pose"
    db "<NEXT>as the King?<PROMPT>"
    db "<NEXT>Nobody realized"
    db "<NEXT>what happened.<PROMPT>"
    db "<NEXT>The King must be"
    db "<NEXT>furious…<WAIT>"
    db "@"

Message_03_77::
    db "<VOICE1>*: Well, we managed<LINE>"
    db "to avoid war with<PROMPT>"
    db "<NEXT>the west. That's a"
    db "<NEXT>good thing.<WAIT>"
    db "@"

Message_03_78::
    db "<VOICE1>*: This is just<LINE>"
    db "between you and<PROMPT>"
    db "<NEXT>me, but the fake"
    db "<NEXT>King was a harder<PROMPT>"
    db "<NEXT>worker than the"
    db "<NEXT>real King.<WAIT>"
    db "@"

Message_03_79::
    db "<VOICE1>*: Who was that boy<LINE>"
    db "who came out of<PROMPT>"
    db "<NEXT>the dungeon with"
    db "<NEXT>the King?<PROMPT>"
    db "<NEXT>He can't be the"
    db "<NEXT>King's son, but he<PROMPT>"
    db "<NEXT>was dressed in a"
    db "<NEXT>regal manner…<WAIT>"
    db "@"

Message_03_7A::
    db "<VOICE1>*: The border with<LINE>"
    db "the west is open!<PROMPT>"
    db "<NEXT>But the western"
    db "<NEXT>kingdom is far<PROMPT>"
    db "<NEXT>away, you should"
    db "<NEXT>be very cautious.<WAIT>"
    db "@"

Message_03_7B::
    db "<VOICE2>*: The discovery of<LINE>"
    db "gold was a bust…<PROMPT>"
    db "<NEXT>It's disappointing,"
    db "<NEXT>it really is…<PROMPT>"
    db "<NEXT>My rings…"
    db "<NEXT>My bangles…<WAIT>"
    db "@"

Message_03_7C::
    db "<VOICE1>*: The King gave<LINE>"
    db "word to lift the<PROMPT>"
    db "<NEXT>blockade of the"
    db "<NEXT>border.<PROMPT>"
    db "<NEXT>The trouble is"
    db "<NEXT>finally over.<WAIT>"
    db "@"

Message_03_7D::
    db "<VOICE1>*: A monster was<LINE>"
    db "playing the part<PROMPT>"
    db "<NEXT>of our King…"
    db "<NEXT>It's no wonder we<PROMPT>"
    db "<NEXT>were getting such"
    db "<NEXT>bizarre orders.<WAIT>"
    db "@"

Message_03_7E::
    db "<VOICE2>*: This is the town<LINE>"
    db "of Weston.<PROMPT>"
    db "<NEXT>It's the western"
    db "<NEXT>kingdom's port.<WAIT>"
    db "@"

Message_03_7F::
    db "<VOICE1>*: The west's castle<LINE>"
    db "has seen a steady<PROMPT>"
    db "<NEXT>stream of visitors"
    db "<NEXT>and gifts.<PROMPT>"
    db "<NEXT>They're offering a"
    db "<NEXT>reward if you can<PROMPT>"
    db "<NEXT>cheer Lady Yuna"
    db "<NEXT>up.<PROMPT>"
    db "<NEXT>I'm thinking of"
    db "<NEXT>going myself.<WAIT>"
    db "@"

Message_03_80::
    db "<VOICE1>*: Across from us<LINE>"
    db "on the lake is the<PROMPT>"
    db "<NEXT>eastern kingdom."
    db "<NEXT>It's ruled by<PROMPT>"
    db "<NEXT>Queen Helen, I"
    db "<NEXT>think.<PROMPT>"
    db "<NEXT>Will our Lady Yuna"
    db "<NEXT>become our queen?<WAIT>"
    db "@"

Message_03_81::
    db "<VOICE2>*: I saw Lady Yuna<LINE>"
    db "riding towards the<PROMPT>"
    db "<NEXT>forest in the"
    db "<NEXT>southeast.<PROMPT>"
    db "<NEXT>She looked dashing"
    db "<NEXT>on her steed.<WAIT>"
    db "@"

Message_03_82::
    db "<VOICE1>*: Lady Yuna has<LINE>"
    db "been a lively girl<PROMPT>"
    db "<NEXT>for as long as I"
    db "<NEXT>can remember.<PROMPT>"
    db "<NEXT>Her habit of"
    db "<NEXT>sneaking out of<PROMPT>"
    db "<NEXT>the Castle vexed"
    db "<NEXT>us to no end.<WAIT>"
    db "@"

Message_03_83::
    db "<VOICE1>*: I haven't been<LINE>"
    db "seeing too many<PROMPT>"
    db "<NEXT>ships coming into"
    db "<NEXT>our harbor.<PROMPT>"
    db "<NEXT>I wonder why that"
    db "<NEXT>could be.<PROMPT>"
    db "<NEXT>Ships make great"
    db "<NEXT>transportation.<WAIT>"
    db "@"

Message_03_84::
    db "<VOICE1>*: Lady Yuna is<LINE>"
    db "said to be quiet<PROMPT>"
    db "<NEXT>and withdrawn"
    db "<NEXT>these days.<PROMPT>"
    db "<NEXT>Perhaps she is"
    db "<NEXT>trying to cope<PROMPT>"
    db "<NEXT>with adolescent"
    db "<NEXT>concerns…<WAIT>"
    db "@"

Message_03_85::
    db "<VOICE1>*: I've heard rumors<LINE>"
    db "that something is<PROMPT>"
    db "<NEXT>wrong with Lady"
    db "<NEXT>Yuna.<PROMPT>"
    db "<NEXT>I wonder what it"
    db "<NEXT>could be?<WAIT>"
    db "@"

Message_03_86::
    db "<VOICE1>*: The King dotes<LINE>"
    db "over Lady Yuna.<PROMPT>"
    db "<NEXT>He", $44, " gladly give"
    db "<NEXT>up his own life<PROMPT>"
    db "<NEXT>for her sake, I'm"
    db "<NEXT>sure.<WAIT>"
    db "@"

Message_03_87::
    db "<VOICE1>*: The road to the<LINE>"
    db "eastern kingdom is<PROMPT>"
    db "<NEXT>teeming with tough"
    db "<NEXT>monsters.<PROMPT>"
    db "<NEXT>If you're thinking"
    db "<NEXT>of going, it may<PROMPT>"
    db "<NEXT>be less dangerous"
    db "<NEXT>to cross the lake.<WAIT>"
    db "@"

Message_03_88::
    db "<VOICE2>*: Lady Yuna locks<LINE>"
    db "herself in her<PROMPT>"
    db "<NEXT>room all day long"
    db "<NEXT>and won't come out.<PROMPT>"
    db "<NEXT>The King is at his"
    db "<NEXT>wit's end.<WAIT>"
    db "@"

Message_03_89::
    db "<VOICE1>*: If you can cheer<LINE>"
    db "up the princess,<PROMPT>"
    db "<NEXT>you can earn a"
    db "<NEXT>reward, I hear.<PROMPT>"
    db "<NEXT>A whole lot of"
    db "<NEXT>challengers have<PROMPT>"
    db "<NEXT>already gone to"
    db "<NEXT>the Castle.<PROMPT>"
    db "<NEXT>Maybe I ought to"
    db "<NEXT>try too…<PROMPT>"
    db "<NEXT>The Castle is to"
    db "<NEXT>the west. Just go<PROMPT>"
    db "<NEXT>along the river"
    db "<NEXT>and you're there!<WAIT>"
    db "@"
    ds $183, $00
