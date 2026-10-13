; ROM bank $7C: messages
; The annotated listing of this bank is build/listing/bank7c.asm.

SECTION "Bank 7C", ROMX[$4000], BANK[$7C]
    db $7c

; message bank $7C: when wStringIndex < $87, BeginStringDisplay with this bank's table
; MessageStrings_Bank7C; otherwise far-calls BeginStringDisplay_Bank7C_Overflow (E-0080)
BeginStringDisplay_Bank7C::
    ld a, [wStringIndex]
    cp $87
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank7C_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank7C
    call BeginStringDisplay
    ret

; message bank $7C: when wStringIndex < $87, CopyStringToBuffer with this bank's table
; MessageStrings_Bank7C; otherwise far-calls CopyStringToBuffer_Bank7C_Overflow (E-0080)
CopyStringToBuffer_Bank7C::
    ld a, [wStringIndex]
    cp $87
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank7C_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank7C
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_7C_4032::
MessageStrings_Bank7C::
    dw StringList_7C_4034 ; id 0

; category list of StringCategories_7C_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_7C_4034::
    dw Message_08_00 ; id 0
    dw Message_08_01 ; id 1
    dw Message_08_02 ; id 2
    dw Message_08_03 ; id 3
    dw Message_08_04 ; id 4
    dw Message_08_05 ; id 5
    dw Message_08_06 ; id 6
    dw Message_08_07 ; id 7
    dw Message_08_08 ; id 8
    dw Message_08_09 ; id 9
    dw Message_08_0A ; id 10
    dw Message_08_0B ; id 11
    dw Message_08_0C ; id 12
    dw Message_08_0D ; id 13
    dw Message_08_0E ; id 14
    dw Message_08_0F ; id 15
    dw Message_08_10 ; id 16
    dw Message_08_11 ; id 17
    dw Message_08_12 ; id 18
    dw Message_08_13 ; id 19
    dw Message_08_14 ; id 20
    dw Message_08_15 ; id 21
    dw Message_08_16 ; id 22
    dw Message_08_17 ; id 23
    dw Message_08_18 ; id 24
    dw Message_08_19 ; id 25
    dw Message_08_1A ; id 26
    dw Message_08_1B ; id 27
    dw Message_08_1C ; id 28
    dw Message_08_1D ; id 29
    dw Message_08_1E ; id 30
    dw Message_08_1F ; id 31
    dw Message_08_20 ; id 32
    dw Message_08_21 ; id 33
    dw Message_08_22 ; id 34
    dw Message_08_23 ; id 35
    dw Message_08_24 ; id 36
    dw Message_08_25 ; id 37
    dw Message_08_26 ; id 38
    dw Message_08_27 ; id 39
    dw Message_08_28 ; id 40
    dw Message_08_28 ; id 41
    dw Message_08_2A ; id 42
    dw Message_08_2B ; id 43
    dw Message_08_2C ; id 44
    dw Message_08_2D ; id 45
    dw Message_08_2E ; id 46
    dw Message_08_2F ; id 47
    dw Message_08_30 ; id 48
    dw Message_08_31 ; id 49
    dw Message_08_32 ; id 50
    dw Message_08_33 ; id 51
    dw Message_08_34 ; id 52
    dw Message_08_35 ; id 53
    dw Message_08_36 ; id 54
    dw Message_08_37 ; id 55
    dw Message_08_38 ; id 56
    dw Message_08_39 ; id 57
    dw Message_08_3A ; id 58
    dw Message_08_3B ; id 59
    dw Message_08_3C ; id 60
    dw Message_08_3D ; id 61
    dw Message_08_3E ; id 62
    dw Message_08_3F ; id 63
    dw Message_08_40 ; id 64
    dw Message_08_41 ; id 65
    dw Message_08_42 ; id 66
    dw Message_08_43 ; id 67
    dw Message_08_44 ; id 68
    dw Message_08_45 ; id 69
    dw Message_08_46 ; id 70
    dw Message_08_47 ; id 71
    dw Message_08_48 ; id 72
    dw Message_08_49 ; id 73
    dw Message_08_4A ; id 74
    dw Message_08_4B ; id 75
    dw Message_08_4C ; id 76
    dw Message_08_4D ; id 77
    dw Message_08_4E ; id 78
    dw Message_08_4F ; id 79
    dw Message_08_50 ; id 80
    dw Message_08_51 ; id 81
    dw Message_08_52 ; id 82
    dw Message_08_53 ; id 83
    dw Message_08_54 ; id 84
    dw Message_08_55 ; id 85
    dw Message_08_56 ; id 86
    dw Message_08_57 ; id 87
    dw Message_08_58 ; id 88
    dw Message_08_59 ; id 89
    dw Message_08_5A ; id 90
    dw Message_08_5B ; id 91
    dw Message_08_5C ; id 92
    dw Message_08_5D ; id 93
    dw Message_08_5E ; id 94
    dw Message_08_5F ; id 95
    dw Message_08_60 ; id 96
    dw Message_08_61 ; id 97
    dw Message_08_62 ; id 98
    dw Message_08_63 ; id 99
    dw Message_08_64 ; id 100
    dw Message_08_65 ; id 101
    dw Message_08_66 ; id 102
    dw Message_08_67 ; id 103
    dw Message_08_68 ; id 104
    dw Message_08_69 ; id 105
    dw Message_08_6A ; id 106
    dw Message_08_6B ; id 107
    dw Message_08_6C ; id 108
    dw Message_08_6D ; id 109
    dw Message_08_6E ; id 110
    dw Message_08_6F ; id 111
    dw Message_08_70 ; id 112
    dw Message_08_71 ; id 113
    dw Message_08_72 ; id 114
    dw Message_08_73 ; id 115
    dw Message_08_74 ; id 116
    dw Message_08_75 ; id 117
    dw Message_08_76 ; id 118
    dw Message_08_77 ; id 119
    dw Message_08_78 ; id 120
    dw Message_08_79 ; id 121
    dw Message_08_7A ; id 122
    dw Message_08_7B ; id 123
    dw Message_08_7C ; id 124
    dw Message_08_7D ; id 125
    dw Message_08_7E ; id 126
    dw Message_08_7F ; id 127
    dw Message_08_80 ; id 128
    dw Message_08_81 ; id 129
    dw Message_08_82 ; id 130
    dw Message_08_83 ; id 131
    dw Message_08_84 ; id 132
    dw Message_08_85 ; id 133
    dw Message_08_86 ; id 134

Message_08_00::
    db "<VOICE1>*: This is the<LINE>"
    db "village of Yold.<PROMPT>"
    db "<NEXT>We're known for"
    db "<NEXT>our fresh fish.<WAIT>"
    db "@"

Message_08_01::
    db "<VOICE2>*: In the northwest<LINE>"
    db "is a village that<PROMPT>"
    db "<NEXT>is famous for"
    db "<NEXT>mermaids.<WAIT>"
    db "@"

Message_08_02::
    db "<VOICE1>*: Around these<LINE>"
    db "parts it's faster<PROMPT>"
    db "<NEXT>to travel by boat"
    db "<NEXT>than walking,<PROMPT>"
    db "<NEXT>so everyone has"
    db "<NEXT>their own boat.<PROMPT>"
    db "<NEXT>In the olden days"
    db "<NEXT>it was dangerous<PROMPT>"
    db "<NEXT>because there were"
    db "<NEXT>pirates.<WAIT>"
    db "@"

Message_08_03::
    db "<VOICE1>*: I saw a haunted<LINE>"
    db "ship in the north.<PROMPT>"
    db "<NEXT>It scared me so"
    db "<NEXT>much, I can't get<PROMPT>"
    db "<NEXT>out of bed."
    db "<NEXT>Oooh, scary!<WAIT>"
    db "@"

Message_08_04::
    db "<VOICE1>*: The volcanic<LINE>"
    db "island off the<PROMPT>"
    db "<NEXT>coast appears to"
    db "<NEXT>be in a bad mood.<PROMPT>"
    db "<NEXT>There have been"
    db "<NEXT>many quakes.<PROMPT>"
    db "<NEXT>The fish aren't"
    db "<NEXT>biting at all.<WAIT>"
    db "@"

Message_08_05::
    db "<VOICE2>*: Mermaids lived<LINE>"
    db "in the sea in the<PROMPT>"
    db "<NEXT>northwest. Among"
    db "<NEXT>their treasures<PROMPT>"
    db "<NEXT>was a round mirror"
    db "<NEXT>called HarMirror,<PROMPT>"
    db "<NEXT>but it was stolen"
    db "<NEXT>by pirates.<PROMPT>"
    db "<NEXT>Nobody knows where"
    db "<NEXT>it is now.<WAIT>"
    db "@"

Message_08_06::
    db "<VOICE1>*: …The birds are<LINE>"
    db "noisy…<PROMPT>"
    db "<NEXT>It's a sign that a"
    db "<NEXT>quake will hit.<WAIT>"
    db "@"

Message_08_07::
    db "<VOICE1>*: …See? What did I<LINE>"
    db "just say?<WAIT>"
    db "@"

Message_08_08::
    db "<VOICE1>*: I hope the<LINE>"
    db "volcanic island<PROMPT>"
    db "<NEXT>off the coast"
    db "<NEXT>won't erupt…<WAIT>"
    db "@"

Message_08_09::
    db "<VOICE1>*: I don't have<LINE>"
    db "much but…<PROMPT>"
    db "<NEXT>Would you care to"
    db "<NEXT>see my wares?<WAIT>"
    db "@"

Message_08_0A::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>A folded fishnet"
    db "<NEXT>was tucked inside.<WAIT>"
    db "@"

Message_08_0B::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>colorful fruits.<WAIT>"
    db "@"

Message_08_0C::
    db "<VOICE2>*: Welcome to<LINE>"
    db "Polona.<PROMPT>"
    db "<NEXT>It's a tourist"
    db "<NEXT>resort known for<PROMPT>"
    db "<NEXT>the mermaids in"
    db "<NEXT>the area.<WAIT>"
    db "@"

Message_08_0D::
    db "<VOICE1>*: You could meet<LINE>"
    db "mermaids here in<PROMPT>"
    db "<NEXT>the past, but not"
    db "<NEXT>anymore.<PROMPT>"
    db "<NEXT>Not since the"
    db "<NEXT>pirates raided<PROMPT>"
    db "<NEXT>them and took"
    db "<NEXT>their treasure.<PROMPT>"
    db "<NEXT>After that, the"
    db "<NEXT>mermaids have kept<PROMPT>"
    db "<NEXT>away from people"
    db "<NEXT>out of fear.<PROMPT>"
    db "<NEXT>It's a shame."
    db "<NEXT>They were decent<PROMPT>"
    db "<NEXT>sorts who liked to"
    db "<NEXT>dance and sing.<WAIT>"
    db "@"

Message_08_0E::
    db "<VOICE1>*: I'm from the port<LINE>"
    db "in the northeast.<PROMPT>"
    db "<NEXT>I", $44, " almost reached"
    db "<NEXT>here when ArmyAnts<PROMPT>"
    db "<NEXT>and MadGophers"
    db "<NEXT>jumped me.<PROMPT>"
    db "<NEXT>I managed to get"
    db "<NEXT>away though.<PROMPT>"
    db "<NEXT>I'm glad I made it"
    db "<NEXT>here safely.<PROMPT>"
    db "<NEXT>It's quiet and"
    db "<NEXT>restful.<WAIT>"
    db "@"

Message_08_0F::
    db "<VOICE2>*: You're not<LINE>"
    db "supposed to go<PROMPT>"
    db "<NEXT>near the cave in"
    db "<NEXT>the west.<PROMPT>"
    db "<NEXT>It's on the cape."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Water monsters"
    db "<NEXT>live there.<PROMPT>"
    db "<NEXT>Mama said it's"
    db "<NEXT>dangerous.<WAIT>"
    db "@"

Message_08_10::
    db "<VOICE1>*: In the past,<LINE>"
    db "mermaids are said<PROMPT>"
    db "<NEXT>to have sang and"
    db "<NEXT>danced with people<PROMPT>"
    db "<NEXT>where we stand"
    db "<NEXT>now.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>dance to remember<PROMPT>"
    db "<NEXT>and celebrate the"
    db "<NEXT>days gone by?<CHOICE>"
    db "@"

Message_08_11::
    db "<VOICE1>*: Then I'll sing!<LINE>"
    db "Lalala~ lala la~<WAIT>"
    db "@"

Message_08_12::
    db "<VOICE2>*: Bravo, bravo!<LINE>"
    db "You were fabulous!<PROMPT>"
    db "<NEXT>You have a certain"
    db "<NEXT>flair for genius!<PROMPT>"
    db "<NEXT>Please, take this"
    db "<NEXT>as my thanks!<WAIT>"
    db "@"

Message_08_13::
    db "<BUF0> received<LINE>"
    db "a TinyMedal.<WAIT>"
    db "@"

Message_08_14::
    db "<VOICE2>*: Bravo, bravo!<LINE>"
    db "You were fabulous!<PROMPT>"
    db "<NEXT>You have a certain"
    db "<NEXT>flair for genius!<PROMPT>"
    db "<NEXT>Please, take this"
    db "<NEXT>as my thanks!<PROMPT>"
    db "<NEXT>Oh? You have no"
    db "<NEXT>room… Next time!<WAIT>"
    db "@"

Message_08_15::
    db "<VOICE2>*: Bravo, bravo!<LINE>"
    db "You were fabulous!<PROMPT>"
    db "<NEXT>You have a certain"
    db "<NEXT>flair for genius!<PROMPT>"
    db "<NEXT>I", $44, " love to see"
    db "<NEXT>you dance again!<WAIT>"
    db "@"

Message_08_16::
    db "<VOICE1>*: Erm… The sense<LINE>"
    db "of rhythm just<PROMPT>"
    db "<NEXT>doesn't quite come"
    db "<NEXT>through.<PROMPT>"
    db "<NEXT>If there were a"
    db "<NEXT>monster that could<PROMPT>"
    db "<NEXT>lead the dance"
    db "<NEXT>performance…<PROMPT>"
    db "<NEXT>Oh, pardon me!"
    db "<NEXT>You are a novice…<WAIT>"
    db "@"

Message_08_17::
    db "<VOICE1>*: Ah… Shame…<LINE>"
    db "Please come again.<WAIT>"
    db "@"

Message_08_18::
    db "<VOICE1>*: Have you heard<LINE>"
    db "the legend about<PROMPT>"
    db "<NEXT>the mermaids", $95
    db "<NEXT>treasure?<CHOICE>"
    db "@"

Message_08_19::
    db "<VOICE1>*: Ah, you've heard<LINE>"
    db "already.<PROMPT>"
    db "<NEXT>It's a tragic tale."
    db "<NEXT><WAIT>"
    db "@"

Message_08_1A::
    db "<VOICE1>*: Long ago, a deft<LINE>"
    db "craftsman made a<PROMPT>"
    db "<NEXT>mirror with the"
    db "<NEXT>power of darkness.<PROMPT>"
    db "<NEXT>It brought ruin to"
    db "<NEXT>whatever its cold<PROMPT>"
    db "<NEXT>face reflected."
    db "<NEXT>Learning of this<PROMPT>"
    db "<NEXT>mirror, the people"
    db "<NEXT>grew frightened.<PROMPT>"
    db "<NEXT>They took the"
    db "<NEXT>mirror from the<PROMPT>"
    db "<NEXT>craftsman."
    db "<NEXT>It was hurled<PROMPT>"
    db "<NEXT>into the sea."
    db "<NEXT>The craftsman, out<PROMPT>"
    db "<NEXT>of sorrow, leapt"
    db "<NEXT>after the mirror<PROMPT>"
    db "<NEXT>into the sea."
    db "<NEXT>The mirror drifted<PROMPT>"
    db "<NEXT>to the lair of"
    db "<NEXT>mermaids where it<PROMPT>"
    db "<NEXT>was kept under"
    db "<NEXT>secure seal as the<PROMPT>"
    db "<NEXT>HarMirror."
    db "<NEXT>And that's the<PROMPT>"
    db "<NEXT>tale."
    db "<NEXT><WAIT>"
    db "@"

Message_08_1B::
    db "<VOICE2>*: Ahh… This is<LINE>"
    db "heavenly!<PROMPT>"
    db "<NEXT>It makes me feel"
    db "<NEXT>alive again!<PROMPT>"
    db "<NEXT>Relaxing here, all"
    db "<NEXT>my troubles seem<PROMPT>"
    db "<NEXT>to melt away to"
    db "<NEXT>insignificance.<WAIT>"
    db "@"

Message_08_1C::
    db "<VOICE1>*: I came from far<LINE>"
    db "away to see some<PROMPT>"
    db "<NEXT>mermaids, but I"
    db "<NEXT>hear they've not<PROMPT>"
    db "<NEXT>been seen lately."
    db "<NEXT>That's a shame.<WAIT>"
    db "@"

Message_08_1D::
    db "<VOICE2>*: This is Port<LINE>"
    db "Ritz, where ships<PROMPT>"
    db "<NEXT>gather from all"
    db "<NEXT>over the world.<WAIT>"
    db "@"

Message_08_1E::
    db "<VOICE1>*: The pirates were<LINE>"
    db "swallowed by the<PROMPT>"
    db "<NEXT>sea after monsters"
    db "<NEXT>overwhelmed them.<PROMPT>"
    db "<NEXT>But before they"
    db "<NEXT>sank, they're said<PROMPT>"
    db "<NEXT>to have hidden"
    db "<NEXT>their treasures.<WAIT>"
    db "@"

Message_08_1F::
    db "<VOICE1>*: There's this old<LINE>"
    db "sailor man in the<PROMPT>"
    db "<NEXT>tavern who likes"
    db "<NEXT>his grog too much.<PROMPT>"
    db "<NEXT>Whenever he's had"
    db "<NEXT>a few, he'll regale<PROMPT>"
    db "<NEXT>you with tales of"
    db "<NEXT>the high seas.<PROMPT>"
    db "<NEXT>But his stories"
    db "<NEXT>tend to be a bit<PROMPT>"
    db "<NEXT>preposterous. I"
    db "<NEXT>don't trust him.<WAIT>"
    db "@"

Message_08_20::
    db "<VOICE1>*: How may our<LINE>"
    db "church serve you?<WAIT>"
    db "@"

Message_08_21::
    db "<VOICE1>*: All sorts of<LINE>"
    db "people come here<PROMPT>"
    db "<NEXT>from around the"
    db "<NEXT>world.<PROMPT>"
    db "<NEXT>But a little kid"
    db "<NEXT>with monsters…<PROMPT>"
    db "<NEXT>That's something"
    db "<NEXT>you don't get to<PROMPT>"
    db "<NEXT>see too often, not"
    db "<NEXT>even here.<WAIT>"
    db "@"

Message_08_22::
    db "<VOICE2>*: I went to Polona<LINE>"
    db "a while back…<PROMPT>"
    db "<NEXT>You know, it's"
    db "<NEXT>southwest of here.<PROMPT>"
    db "<NEXT>But I never got to"
    db "<NEXT>see any mermaids.<PROMPT>"
    db "<NEXT>I was looking"
    db "<NEXT>forward to it too…<WAIT>"
    db "@"

Message_08_23::
    db "<VOICE1>*: I offer quality<LINE>"
    db "merchandise.<PROMPT>"
    db "<NEXT>Would you care to"
    db "<NEXT>see my wares?<WAIT>"
    db "@"

Message_08_24::
    db "<VOICE1>*: There is a<LINE>"
    db "lighthouse to the<PROMPT>"
    db "<NEXT>east, but it's too"
    db "<NEXT>dangerous.<PROMPT>"
    db "<NEXT>It's been overrun"
    db "<NEXT>by monsters since<PROMPT>"
    db "<NEXT>the pirates stole"
    db "<NEXT>the MoonRock from<PROMPT>"
    db "<NEXT>the top of the"
    db "<NEXT>lighthouse.<WAIT>"
    db "@"

Message_08_25::
    db "<VOICE1>*: My ship sank in<LINE>"
    db "the eastern sea.<PROMPT>"
    db "<NEXT>We were sailing"
    db "<NEXT>near a whirlpool<PROMPT>"
    db "<NEXT>when huge suction-"
    db "<NEXT>cupped tentacles<PROMPT>"
    db "<NEXT>reached out and"
    db "<NEXT>grabbed the ship.<PROMPT>"
    db "<NEXT>It's terrifying to"
    db "<NEXT>even recall that!<WAIT>"
    db "@"

Message_08_26::
    db "<VOICE1>*: The old man in<LINE>"
    db "the tavern's neat!<PROMPT>"
    db "<NEXT>He tells me all"
    db "<NEXT>sorts of things.<PROMPT>"
    db "<NEXT>I wish I would get"
    db "<NEXT>kidnapped by some<PROMPT>"
    db "<NEXT>pirates one day."
    db "<NEXT>It", $44, " be neat!<WAIT>"
    db "@"

Message_08_27::
    db "<VOICE1>*: This port used<LINE>"
    db "to be lively in<PROMPT>"
    db "<NEXT>the past, but it's"
    db "<NEXT>become run down…<PROMPT>"
    db "<NEXT>The pirates have"
    db "<NEXT>all gone, but the<PROMPT>"
    db "<NEXT>port's still fading"
    db "<NEXT>away…<WAIT>"
    db "@"

Message_08_28::
    db "<VOICE1>*: The lighthouse<LINE>"
    db "had the MoonRock<PROMPT>"
    db "<NEXT>installed at its"
    db "<NEXT>pinnacle.<PROMPT>"
    db "<NEXT>It would glow at"
    db "<NEXT>night to light the<PROMPT>"
    db "<NEXT>way for mariners"
    db "<NEXT>at sea.<PROMPT>"
    db "<NEXT>It was a gift from"
    db "<NEXT>mermaids, you see.<WAIT>"
    db "@"

Message_08_2A::
    db "<VOICE2>*: The sea's level<LINE>"
    db "has gone down.<PROMPT>"
    db "<NEXT>Many shoals have"
    db "<NEXT>appeared.<PROMPT>"
    db "<NEXT>And that's resulted"
    db "<NEXT>in countless ships<PROMPT>"
    db "<NEXT>running aground in"
    db "<NEXT>these parts.<WAIT>"
    db "@"

Message_08_2B::
    db "<VOICE1>*: Listen, did you<LINE>"
    db "know?<PROMPT>"
    db "<NEXT>Mermaids appear to"
    db "<NEXT>love dancing.<PROMPT>"
    db "<NEXT>By the way, there's"
    db "<NEXT>a cave west of<PROMPT>"
    db "<NEXT>Polona. A giant"
    db "<NEXT>squid lives there.<PROMPT>"
    db "<NEXT>That squid is said"
    db "<NEXT>to love to dance.<PROMPT>"
    db "<NEXT>I don't know if I"
    db "<NEXT>want to see that…<WAIT>"
    db "@"

Message_08_2C::
    db "<BUF0> tried to<LINE>"
    db "check the chest.<WAIT>"
    db "@"

Message_08_2D::
    db "<VOICE1>*: Whoa! Hands off<LINE>"
    db "my merchandise!<WAIT>"
    db "@"

Message_08_2E::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>It was filled with"
    db "<NEXT>gigantic beans.<WAIT>"
    db "@"

Message_08_2F::
    db "<VOICE1>*: This area was a<LINE>"
    db "lot more lively in<PROMPT>"
    db "<NEXT>the old days, but"
    db "<NEXT>now it's just a<PROMPT>"
    db "<NEXT>deathtrap for any"
    db "<NEXT>kind of boat.<PROMPT>"
    db "<NEXT>We're ringed by"
    db "<NEXT>shoals!<PROMPT>"
    db "<NEXT>Not many captains"
    db "<NEXT>will risk their<PROMPT>"
    db "<NEXT>boat to bother"
    db "<NEXT>dealing with us.<WAIT>"
    db "@"

Message_08_30::
    db "<VOICE1>*: When you're out<LINE>"
    db "at sea, you get to<PROMPT>"
    db "<NEXT>see some peculiar"
    db "<NEXT>sights.<PROMPT>"
    db "<NEXT>But when I saw a"
    db "<NEXT>ghost ship loom<PROMPT>"
    db "<NEXT>out of thick fog…"
    db "<NEXT>Hair-raising!<WAIT>"
    db "@"

Message_08_31::
    db "<VOICE1>*: Heh, that old<LINE>"
    db "man, he was too<PROMPT>"
    db "<NEXT>grogged to make"
    db "<NEXT>any sense…<PROMPT>"
    db "<NEXT>Captain, sir,"
    db "<NEXT>what'll we do?<WAIT>"
    db "@"

Message_08_32::
    db "<VOICE1>*: Tch, made me<LINE>"
    db "waste my time…<PROMPT>"
    db "<NEXT>We'll come back"
    db "<NEXT>later for him.<WAIT>"
    db "@"

Message_08_33::
    db "<VOICE1>Kameha: Hey! You're<LINE>"
    db "<BUF0>, the farmer!<PROMPT>"
    db "<NEXT>Don't tell me"
    db "<NEXT>you're looking<PROMPT>"
    db "<NEXT>for something to"
    db "<NEXT>plug the Navel?<PROMPT>"
    db "<NEXT>So, Warubou asked"
    db "<NEXT>you too, huh?<PROMPT>"
    db "<NEXT>But those monsters"
    db "<NEXT>you're with…<PROMPT>"
    db "<NEXT>Don't they look"
    db "<NEXT>frail and wimpy?<PROMPT>"
    db "<NEXT>Look, I've already"
    db "<NEXT>got two sidekicks!<PROMPT>"
    db "<NEXT>I'll find the plug"
    db "<NEXT>before you!<PROMPT>"
    db "<NEXT>Come on, team,"
    db "<NEXT>let's go!<WAIT>"
    db "@"

Message_08_34::
    db "<VOICE1>*: When that old<LINE>"
    db "man gets grogged…<PROMPT>"
    db "<NEXT>You can't move him"
    db "<NEXT>with a crowbar.<PROMPT>"
    db "<NEXT>It's like he casts"
    db "<NEXT>Ironize on<PROMPT>"
    db "<NEXT>himself."
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>What can we do<LINE>"
    db "about it?<WAIT>"
    db "@"

Message_08_35::
    db "<VOICE1>*: The old fellow<LINE>"
    db "there, the instant<PROMPT>"
    db "<NEXT>he smells a sea"
    db "<NEXT>monster, he wakes<PROMPT>"
    db "<NEXT>up, even if he's"
    db "<NEXT>tanked on grog.<PROMPT>"
    db "<NEXT>That's a real sea"
    db "<NEXT>dog, I", $44, " say!<WAIT>"
    db "@"

Message_08_36::
    db "<VOICE1>*: The volcanic<LINE>"
    db "island off the<PROMPT>"
    db "<NEXT>coast is vicious"
    db "<NEXT>to ships.<PROMPT>"
    db "<NEXT>Its ring of shoals"
    db "<NEXT>keeps boats away.<WAIT>"
    db "@"

Message_08_37::
    db "<VOICE1>*: Hnnnr… Hic… Gnn…<LINE>"
    db "Zzz… Gfffff…<WAIT>"
    db "@"

Message_08_38::
    db "<VOICE1>*: Who are you?<LINE>"
    db "This is our surf!<PROMPT>"
    db "<NEXT>…I mean turf!"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>You show me some"
    db "<NEXT>respect on our su…<PROMPT>"
    db "<NEXT>Turf! That's it,"
    db "<NEXT>I'm mad!<WAIT>"
    db "@"

Message_08_39::
    db "<VOICE1>*: You can keep<LINE>"
    db "trying, but you're<PROMPT>"
    db "<NEXT>never going to"
    db "<NEXT>win, punk!<WAIT>"
    db "@"

Message_08_3A::
    db "<VOICE1>*: Zzz… Zzz…<LINE>"
    db "Huh! Watch out!<WAIT>"
    db "@"

Message_08_3B::
    db "<VOICE1>*: What! Why are<LINE>"
    db "you with monsters?<PROMPT>"
    db "<NEXT>You're an odd"
    db "<NEXT>little child.<PROMPT>"
    db "<NEXT>Did you want to"
    db "<NEXT>hear my tales?<CHOICE>"
    db "@"

Message_08_3C::
    db "<VOICE1>*: It was in my<LINE>"
    db "callow youth…<PROMPT>"
    db "<NEXT>The ship I was on"
    db "<NEXT>was captured by<PROMPT>"
    db "<NEXT>pirates who kept"
    db "<NEXT>us as slaves.<PROMPT>"
    db "<NEXT>We toiled for"
    db "<NEXT>months that way.<PROMPT>"
    db "<NEXT>But one day, I"
    db "<NEXT>overheard them<PROMPT>"
    db "<NEXT>talking about the"
    db "<NEXT>MoonRock.<PROMPT>"
    db "<NEXT>If it were taken"
    db "<NEXT>from the top of<PROMPT>"
    db "<NEXT>the lighthouse,"
    db "<NEXT>the sea would ebb.<PROMPT>"
    db "<NEXT>And that would"
    db "<NEXT>make it impossible<PROMPT>"
    db "<NEXT>to approach the"
    db "<NEXT>volcanic island<PROMPT>"
    db "<NEXT>where they hid"
    db "<NEXT>their loot.<PROMPT>"
    db "<NEXT>Unfortunately,"
    db "<NEXT>they saw me.<PROMPT>"
    db "<NEXT>They would never"
    db "<NEXT>allow someone to<PROMPT>"
    db "<NEXT>live knowing their"
    db "<NEXT>secret.<PROMPT>"
    db "<NEXT>So I ran and leapt"
    db "<NEXT>into the sea.<PROMPT>"
    db "<NEXT>I was rescued by a"
    db "<NEXT>passing ship.<WAIT>"
    db "@"

Message_08_3D::
    db "<VOICE1>*: The pirates", $95, "<LINE>"
    db "loot is probably<PROMPT>"
    db "<NEXT>still on the"
    db "<NEXT>volcanic island.<PROMPT>"
    db "<NEXT>But, there is no"
    db "<NEXT>way of getting<PROMPT>"
    db "<NEXT>close to the"
    db "<NEXT>island.<PROMPT>"
    db "<NEXT>It should be"
    db "<NEXT>possible to go to<PROMPT>"
    db "<NEXT>the island if the"
    db "<NEXT>MoonRock were to<PROMPT>"
    db "<NEXT>be returned to the"
    db "<NEXT>lighthouse.<PROMPT>"
    db "<NEXT>But the MoonRock"
    db "<NEXT>sank with the<PROMPT>"
    db "<NEXT>pirates and their"
    db "<NEXT>ship.<PROMPT>"
    db "<NEXT>Maybe if mermaids"
    db "<NEXT>could help…<PROMPT>"
    db "<NEXT>Can mermaids still"
    db "<NEXT>be seen in Polona?<WAIT>"
    db "@"

Message_08_3E::
    db "<VOICE1>*: It's a tale of<LINE>"
    db "high adventure…<WAIT>"
    db "@"

Message_08_3F::
    db "<VOICE1>*: What? Are you<LINE>"
    db "here for my tales?<CHOICE>"
    db "@"

Message_08_40::
    db "<VOICE1>*: The pirates<LINE>"
    db "stole the MoonRock<PROMPT>"
    db "<NEXT>from its mount in"
    db "<NEXT>the lighthouse.<PROMPT>"
    db "<NEXT>That made it"
    db "<NEXT>impossible for<PROMPT>"
    db "<NEXT>ships to go near"
    db "<NEXT>the volcanic isle<PROMPT>"
    db "<NEXT>where they hid"
    db "<NEXT>their loot.<PROMPT>"
    db "<NEXT>If the MoonRock"
    db "<NEXT>was returned to<PROMPT>"
    db "<NEXT>lighthouse, the"
    db "<NEXT>island will become<PROMPT>"
    db "<NEXT>accessible by sea"
    db "<NEXT>again.<PROMPT>"
    db "<NEXT>Maybe if mermaids"
    db "<NEXT>could help…<PROMPT>"
    db "<NEXT>Can mermaids still"
    db "<NEXT>be seen in Polona?<WAIT>"
    db "@"

Message_08_41::
    db "<VOICE1>*: It's a chance to<LINE>"
    db "hear an intriguing<PROMPT>"
    db "<NEXT>tale of mystery…"
    db "<NEXT>Shame…<WAIT>"
    db "@"

Message_08_42::
    db "<VOICE1>*: I'm tired of the<LINE>"
    db "geezer's tales.<WAIT>"
    db "@"

Message_08_43::
    db "<VOICE1>*: I saw a child<LINE>"
    db "cross the sea on a<PROMPT>"
    db "<NEXT>giant clam. No, no"
    db "<NEXT>lie! I saw it!<WAIT>"
    db "@"

Message_08_44::
    db "<VOICE1>*: Watch me dance,<LINE>"
    db "and you'll want to<PROMPT>"
    db "<NEXT>dance too. I can"
    db "<NEXT>see that you do!<PROMPT>"
    db "<NEXT>I'm mimicking an"
    db "<NEXT>Octokid's moves.<WAIT>"
    db "@"

Message_08_45::
    db "<VOICE1>*: What… What are<LINE>"
    db "you doing? Stop!<WAIT>"
    db "@"

Message_08_46::
    db "<VOICE1>Kameha: Gahahah!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Looks like we made"
    db "<NEXT>it here first!<PROMPT>"
    db "<NEXT>All we have to do"
    db "<NEXT>now is get the<PROMPT>"
    db "<NEXT>MoonRock from the"
    db "<NEXT>mermaids, and the<PROMPT>"
    db "<NEXT>pirate's loot will"
    db "<NEXT>be all mine!<PROMPT>"
    db "<NEXT>Sit back and watch"
    db "<NEXT>our soaring dance!<WAIT>"
    db "@"

Message_08_47::
    db "<VOICE1>Kameha: …So where<LINE>"
    db "are the mermaids?<PROMPT>"
    db "<NEXT>That geezer was"
    db "<NEXT>pulling our legs!<WAIT>"
    db "@"

Message_08_48::
    db "<VOICE1>*: Oh, my… Who were<LINE>"
    db "those barbarians?<PROMPT>"
    db "<NEXT>How perfectly"
    db "<NEXT>shocking and rude!<WAIT>"
    db "@"

Message_08_49::
    db "<VOICE2>*: Bravo, bravo!<LINE>"
    db "You were fabulous!<PROMPT>"
    db "<NEXT>You have a certain"
    db "<NEXT>flair for genius!<PROMPT>"
    db "<NEXT>Oh? You say you"
    db "<NEXT>want the MoonRock?<PROMPT>"
    db "<NEXT>Well… All right."
    db "<NEXT>Your monsters say<PROMPT>"
    db "<NEXT>that you're a good"
    db "<NEXT>human.<PROMPT>"
    db "<NEXT>I'll take you to"
    db "<NEXT>our Queen.<PROMPT>"
    db "<NEXT>Close your eyes a"
    db "<NEXT>little while.<WAIT>"
    db "@"

Message_08_4A::
    db "<VOICE1>*: I'm astonished.<LINE>"
    db "Mermaids exist.<WAIT>"
    db "@"

Message_08_4B::
    db "<VOICE2>*: Do you want to<LINE>"
    db "go to the kingdom<PROMPT>"
    db "<NEXT>of mermaids?"
    db "<NEXT><CHOICE>"
    db "@"

Message_08_4C::
    db "<VOICE2>*: Close your eyes<LINE>"
    db "a little while.<WAIT>"
    db "@"

Message_08_4D::
    db "<VOICE2>*: Come back for a<LINE>"
    db "visit anytime!<PROMPT>"
    db "<NEXT>You'll always be"
    db "<NEXT>welcome here!<WAIT>"
    db "@"

Message_08_4E::
    db "<VOICE2>*: This is the<LINE>"
    db "mermaid kingdom.<PROMPT>"
    db "<NEXT>It is built on the"
    db "<NEXT>ocean floor.<PROMPT>"
    db "<NEXT>It's very rare to"
    db "<NEXT>see a human here.<PROMPT>"
    db "<NEXT>Tell me if you"
    db "<NEXT>want to go home.<WAIT>"
    db "@"

Message_08_4F::
    db "<VOICE2>*: I know not all<LINE>"
    db "humans are bad…<PROMPT>"
    db "<NEXT>But the pirates"
    db "<NEXT>who stole our<PROMPT>"
    db "<NEXT>treasure were"
    db "<NEXT>humans too.<PROMPT>"
    db "<NEXT>I hope HarMirror"
    db "<NEXT>is not being used<PROMPT>"
    db "<NEXT>for their wicked"
    db "<NEXT>misdeeds…<WAIT>"
    db "@"

Message_08_50::
    db "<VOICE2>*: The pirates<LINE>"
    db "caught us in nets<PROMPT>"
    db "<NEXT>and blackmailed"
    db "<NEXT>our Queen into<PROMPT>"
    db "<NEXT>handing over our"
    db "<NEXT>treasures…<WAIT>"
    db "@"

Message_08_51::
    db "<VOICE2>*: The HarMirror<LINE>"
    db "was exquisite.<PROMPT>"
    db "<NEXT>It was so flawless"
    db "<NEXT>that it made real<PROMPT>"
    db "<NEXT>its reflection"
    db "<NEXT>while the original<PROMPT>"
    db "<NEXT>ceased to exist in"
    db "<NEXT>this world.<WAIT>"
    db "@"

Message_08_52::
    db "<VOICE2>*: The MoonRock<LINE>"
    db "fell from the sky.<PROMPT>"
    db "<NEXT>It glows like the"
    db "<NEXT>Moon at night.<WAIT>"
    db "@"

Message_08_53::
    db "<VOICE2>*: The pirates sank<LINE>"
    db "with their ship.<PROMPT>"
    db "<NEXT>However, their"
    db "<NEXT>greed for treasure<PROMPT>"
    db "<NEXT>would not allow"
    db "<NEXT>them to rest easy.<PROMPT>"
    db "<NEXT>They now drift the"
    db "<NEXT>sea as the ghostly<PROMPT>"
    db "<NEXT>crew of a spectral"
    db "<NEXT>ship.<WAIT>"
    db "@"

Message_08_54::
    db "<VOICE2>*: We mermaids are<LINE>"
    db "peaceful beings.<PROMPT>"
    db "<NEXT>We shy away from"
    db "<NEXT>violence.<PROMPT>"
    db "<NEXT>The thought of a"
    db "<NEXT>haunted ship<PROMPT>"
    db "<NEXT>roaming the sea"
    db "<NEXT>makes us uneasy.<PROMPT>"
    db "<NEXT>It will make our"
    db "<NEXT>scales go coarse.<WAIT>"
    db "@"

Message_08_55::
    db "<VOICE2>*: Welcome, young<LINE>"
    db "human.<PROMPT>"
    db "<NEXT>I heard that you"
    db "<NEXT>seek the MoonRock<PROMPT>"
    db "<NEXT>to land on the"
    db "<NEXT>volcanic island.<PROMPT>"
    db "<NEXT>The MoonRock is no"
    db "<NEXT>longer here.<PROMPT>"
    db "<NEXT>But I can tell you"
    db "<NEXT>where it is.<PROMPT>"
    db "<NEXT>It remains on the"
    db "<NEXT>ghost ship.<PROMPT>"
    db "<NEXT>It is a spectral"
    db "<NEXT>ship manned by the<PROMPT>"
    db "<NEXT>spirits of pirates"
    db "<NEXT>who died at sea.<PROMPT>"
    db "<NEXT>Driven by greed"
    db "<NEXT>for treasures, the<PROMPT>"
    db "<NEXT>ship still wanders"
    db "<NEXT>upon the waves.<PROMPT>"
    db "<NEXT>Look north from"
    db "<NEXT>Yold for her.<WAIT>"
    db "@"

Message_08_56::
    db "<VOICE2>*: Ah, your will<LINE>"
    db "appears strong.<PROMPT>"
    db "<NEXT>You deserve to"
    db "<NEXT>hear the truth.<PROMPT>"
    db "<NEXT>The MoonRock is on"
    db "<NEXT>the ghost ship.<PROMPT>"
    db "<NEXT>It is a spectral"
    db "<NEXT>ship manned by the<PROMPT>"
    db "<NEXT>spirits of pirates"
    db "<NEXT>who died at sea.<PROMPT>"
    db "<NEXT>Driven by greed"
    db "<NEXT>for treasures, the<PROMPT>"
    db "<NEXT>ship still wanders"
    db "<NEXT>upon the waves.<PROMPT>"
    db "<NEXT>Look north from"
    db "<NEXT>Yold for her.<WAIT>"
    db "@"

Message_08_57::
    db "<VOICE2>*: I see… It can't<LINE>"
    db "be helped, then.<PROMPT>"
    db "<NEXT>However, if your"
    db "<NEXT>destination is the<PROMPT>"
    db "<NEXT>volcanic island,"
    db "<NEXT>you cannot help<PROMPT>"
    db "<NEXT>but come across"
    db "<NEXT>the ghost ship.<WAIT>"
    db "@"

Message_08_58::
    db "<VOICE2>*: The MoonRock is<LINE>"
    db "on the ghost ship.<PROMPT>"
    db "<NEXT>It is a spectral"
    db "<NEXT>ship manned by the<PROMPT>"
    db "<NEXT>spirits of pirates"
    db "<NEXT>who died at sea.<PROMPT>"
    db "<NEXT>Driven by greed"
    db "<NEXT>for treasures, the<PROMPT>"
    db "<NEXT>ship still wanders"
    db "<NEXT>upon the waves.<PROMPT>"
    db "<NEXT>Look north from"
    db "<NEXT>Yold for her.<WAIT>"
    db "@"

Message_08_59::
    db "<VOICE1>*: How could we die<LINE>"
    db "before enjoying<PROMPT>"
    db "<NEXT>all the loot we"
    db "<NEXT>amassed…<WAIT>"
    db "@"

Message_08_5A::
    db "<VOICE1>*: The treasures<LINE>"
    db "are ours…<PROMPT>"
    db "<NEXT>No one will take"
    db "<NEXT>them from us…<WAIT>"
    db "@"

Message_08_5B::
    db "<VOICE1>*: This is what<LINE>"
    db "became of us…<PROMPT>"
    db "<NEXT>The pirates who"
    db "<NEXT>savaged the seas…<WAIT>"
    db "@"

Message_08_5C::
    db "<VOICE1>*: It nags and nags<LINE>"
    db "that we left our<PROMPT>"
    db "<NEXT>treasures behind…"
    db "<NEXT><WAIT>"
    db "@"

Message_08_5D::
    db "<VOICE1>*: Check the wooden<LINE>"
    db "crate…<WAIT>"
    db "@"

Message_08_5E::
    db "<VOICE1>*: Who disturbs us<LINE>"
    db "in our sleep…<PROMPT>"
    db "<NEXT>Oh? There are"
    db "<NEXT>still fools<PROMPT>"
    db "<NEXT>chasing our"
    db "<NEXT>treasures after<PROMPT>"
    db "<NEXT>all this time?"
    db "<NEXT><WAIT>"
    db "@"

Message_08_5F::
    db "<VOICE1>*: …You seem to not<LINE>"
    db "understand…<PROMPT>"
    db "<NEXT>The treasures"
    db "<NEXT>belong to us.<PROMPT>"
    db "<NEXT>You shall see how"
    db "<NEXT>powerless you are…<WAIT>"
    db "@"

Message_08_60::
    db "<VOICE1>*: Child…<LINE>"
    db "We have lost…<PROMPT>"
    db "<NEXT>Finally, we can"
    db "<NEXT>sleep…<WAIT>"
    db "@"

Message_08_61::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>A mummified fish"
    db "<NEXT>lay inside.<WAIT>"
    db "@"

Message_08_62::
    db "<BUF0> peered into<LINE>"
    db "the barrel.<PROMPT>"
    db "<NEXT>There were dry,"
    db "<NEXT>shriveled fruits.<WAIT>"
    db "@"

Message_08_63::
    db "<BUF0> checked the<LINE>"
    db "crate.<PROMPT>"
    db "<NEXT>There was a hidden"
    db "<NEXT>staircase.<WAIT>"
    db "@"

Message_08_64::
    db "<BUF0> checked the<LINE>"
    db "ledger.<PROMPT>"
    db "<NEXT>'Voyage Log…"
    db "<NEXT><PROMPT>"
    db "<NEXT>"
    db "<HOME>Sunrise obscured"
    db "<NEXT>by deep fog…<PROMPT>"
    db "<NEXT>Lookout reports…"
    db "<NEXT>there is some…", $95, "<WAIT>"
    db "@"

Message_08_65::
    db "<BUF0> checked the<LINE>"
    db "pedestal.<PROMPT>"
    db "<NEXT>It has a hole to"
    db "<NEXT>accept an item.<WAIT>"
    db "@"

Message_08_66::
    db "The MoonRock fit<LINE>"
    db "snugly into place.<WAIT>"
    db "@"

Message_08_67::
    db "<BUF0> checked the<LINE>"
    db "pedestal.<PROMPT>"
    db "<NEXT>The MoonRock sat"
    db "<NEXT>on the pedestal.<WAIT>"
    db "@"

Message_08_68::
    db "<VOICE1>Kameha: Wahahahah!<LINE>"
    db "<PROMPT>"
    db "<NEXT>"
    db "<HOME>Thanks for guiding"
    db "<NEXT>me here!<PROMPT>"
    db "<NEXT>I figured that you"
    db "<NEXT>would figure out<PROMPT>"
    db "<NEXT>where the loot was"
    db "<NEXT>so I tailed you!<PROMPT>"
    db "<NEXT>I'll take the"
    db "<NEXT>treasures home!<WAIT>"
    db "@"

Message_08_69::
    db "<VOICE1>Kameha: Urk! How", $44, "<LINE>"
    db "you catch up?<PROMPT>"
    db "<NEXT>You're faster than"
    db "<NEXT>you look…<PROMPT>"
    db "<NEXT>Come on, mateys!"
    db "<NEXT>Follow me!<WAIT>"
    db "@"

Message_08_6A::
    db "<VOICE1>*: …Aye, aye, sir!<LINE>"
    db "Right behind you!<WAIT>"
    db "@"

Message_08_6B::
    db "<VOICE1>Kameha: Arrrrh,<LINE>"
    db "clear the way!<PROMPT>"
    db "<NEXT>I'm grabbing the"
    db "<NEXT>treasure first!<WAIT>"
    db "@"

Message_08_6C::
    db "<VOICE1>Kameha: …Gasp…<LINE>"
    db "…Hack… I did it…<PROMPT>"
    db "<NEXT>The treasures are"
    db "<NEXT>mine! All mine!<WAIT>"
    db "@"

Message_08_6D::
    db "<VOICE1>Kameha: What?!<LINE>"
    db "What is this?<WAIT>"
    db "@"

Message_08_6E::
    db "<VOICE1>*: Kahahaha…<LINE>"
    db "<WAIT>"
    db "@"

Message_08_6F::
    db "<VOICE1>*: This is what it<LINE>"
    db "means, nincompoop!<PROMPT>"
    db "<NEXT>You put us through"
    db "<NEXT>all this trouble…<PROMPT>"
    db "<NEXT>Saying how we"
    db "<NEXT>needed your help<PROMPT>"
    db "<NEXT>to find the"
    db "<NEXT>treasure…<PROMPT>"
    db "<NEXT>That you wouldn't"
    db "<NEXT>cooperate unless<PROMPT>"
    db "<NEXT>we became your"
    db "<NEXT>sidekicks, pah!<PROMPT>"
    db "<NEXT>For all that talk,"
    db "<NEXT>you were useless!<PROMPT>"
    db "<NEXT>We'll take the loot"
    db "<NEXT>for our King!<PROMPT>"
    db "<NEXT>You're not worthy"
    db "<NEXT>of it anyway!<WAIT>"
    db "@"

Message_08_70::
    db "<VOICE1>Kameha: Urrrggh…<LINE>"
    db "You tricked me!<PROMPT>"
    db "<NEXT>You're not getting"
    db "<NEXT>away with this!<WAIT>"
    db "@"

Message_08_71::
    db "<VOICE1>Kameha: I was<LINE>"
    db "stupid to trust<PROMPT>"
    db "<NEXT>and believe in"
    db "<NEXT>those monsters…<PROMPT>"
    db "<NEXT>You take the loot"
    db "<NEXT>back… Later!<WAIT>"
    db "@"

Message_08_72::
    db "A voice echoed<LINE>"
    db "from nowhere…<WAIT>"
    db "@"

Message_08_73::
    db "<VOICE1>*: …Wa-hey!<LINE>"
    db "<BUF0>, hear me?<PROMPT>"
    db "<NEXT>I felt an odd"
    db "<NEXT>power stirring.<PROMPT>"
    db "<NEXT>You found a plug"
    db "<NEXT>for the Navel!<PROMPT>"
    db "<NEXT>I'll bring you"
    db "<NEXT>back! Don't move!<WAIT>"
    db "@"

Message_08_74::
    db "<VOICE1>*: I haven't seen<LINE>"
    db "the ghost ship in<PROMPT>"
    db "<NEXT>some time now, but"
    db "<NEXT>I'm still afraid<PROMPT>"
    db "<NEXT>to get out of bed"
    db "<NEXT>at night…<WAIT>"
    db "@"

Message_08_75::
    db "<VOICE1>*: The volcanic<LINE>"
    db "island appears to<PROMPT>"
    db "<NEXT>have calmed down"
    db "<NEXT>again.<PROMPT>"
    db "<NEXT>Perhaps it took a"
    db "<NEXT>sacrifice…<WAIT>"
    db "@"

Message_08_76::
    db "<VOICE2>*: Sigh… Will the<LINE>"
    db "HarMirror make me<PROMPT>"
    db "<NEXT>appear beautiful"
    db "<NEXT>on the other side…<WAIT>"
    db "@"

Message_08_77::
    db "<VOICE1>*: My grandson just<LINE>"
    db "shivers now…<PROMPT>"
    db "<NEXT>He's been wetting"
    db "<NEXT>the bed too…<WAIT>"
    db "@"

Message_08_78::
    db "<VOICE1>*: The mermaids<LINE>"
    db "came back.<WAIT>"
    db "@"

Message_08_79::
    db "<VOICE1>*: I've seen<LINE>"
    db "mermaids too.<PROMPT>"
    db "<NEXT>I think I'm in"
    db "<NEXT>love!<WAIT>"
    db "@"

Message_08_7A::
    db "<VOICE1>*: The pirates hid<LINE>"
    db "their loot on the<PROMPT>"
    db "<NEXT>volcanic island,"
    db "<NEXT>I heard!<PROMPT>"
    db "<NEXT>All these years"
    db "<NEXT>searching, and it<PROMPT>"
    db "<NEXT>was always right"
    db "<NEXT>before my eyes!<WAIT>"
    db "@"

Message_08_7B::
    db "<VOICE1>*: The sea around<LINE>"
    db "here is safe now.<PROMPT>"
    db "<NEXT>The town should be"
    db "<NEXT>revitalized.<WAIT>"
    db "@"

Message_08_7C::
    db "<VOICE1>*: The MoonRock<LINE>"
    db "glows at night<PROMPT>"
    db "<NEXT>from atop the"
    db "<NEXT>lighthouse again.<PROMPT>"
    db "<NEXT>Someone restored"
    db "<NEXT>it to its place.<WAIT>"
    db "@"

Message_08_7D::
    db "<VOICE2>*: The sea's level<LINE>"
    db "has risen.<PROMPT>"
    db "<NEXT>No ships have"
    db "<NEXT>foundered lately.<WAIT>"
    db "@"

Message_08_7E::
    db "<VOICE1>*: For some reason,<LINE>"
    db "the shoals sank<PROMPT>"
    db "<NEXT>almost instantly."
    db "<NEXT>It's a good thing.<PROMPT>"
    db "<NEXT>Ships should come"
    db "<NEXT>back to restore<PROMPT>"
    db "<NEXT>the town to its"
    db "<NEXT>former glory.<WAIT>"
    db "@"

Message_08_7F::
    db "<VOICE1>*: Did you hear?<LINE>"
    db "Pirates hid their<PROMPT>"
    db "<NEXT>treasure on the"
    db "<NEXT>volcanic island.<PROMPT>"
    db "<NEXT>I should have"
    db "<NEXT>listened to the<PROMPT>"
    db "<NEXT>geezer and gone to"
    db "<NEXT>see for myself…<WAIT>"
    db "@"

Message_08_80::
    db "<VOICE1>*: What?<LINE>"
    db "You again?<PROMPT>"
    db "<NEXT>Back to hear more"
    db "<NEXT>of my tales?<PROMPT>"
    db "<NEXT>Hah? No, no!"
    db "<NEXT>The treasure on<PROMPT>"
    db "<NEXT>the sunken ship is"
    db "<NEXT>a secret!<WAIT>"
    db "@"

Message_08_81::
    db "<VOICE2>*: Our words of<LINE>"
    db "thanks could never<PROMPT>"
    db "<NEXT>do justice to the"
    db "<NEXT>way we feel.<WAIT>"
    db "@"

Message_08_82::
    db "<VOICE2>*: Mermaids and<LINE>"
    db "humans can live<PROMPT>"
    db "<NEXT>side by side in"
    db "<NEXT>harmony again!<WAIT>"
    db "@"

Message_08_83::
    db "<VOICE2>*: Thanks to you,<LINE>"
    db "the spectral ship<PROMPT>"
    db "<NEXT>sank again, this"
    db "<NEXT>time for good.<PROMPT>"
    db "<NEXT>The cravings of"
    db "<NEXT>the ghostly crew<PROMPT>"
    db "<NEXT>for treasures must"
    db "<NEXT>have been quelled.<WAIT>"
    db "@"

Message_08_84::
    db "<VOICE2>*: That wandering<LINE>"
    db "ghost ship's gone!<PROMPT>"
    db "<NEXT>My scales will"
    db "<NEXT>be glossy once<PROMPT>"
    db "<NEXT>again!"
    db "<NEXT><WAIT>"
    db "@"

Message_08_85::
    db "<VOICE2>*: Welcome, young<LINE>"
    db "hero!<PROMPT>"
    db "<NEXT>No words could"
    db "<NEXT>ever adequately<PROMPT>"
    db "<NEXT>express our"
    db "<NEXT>gratitude!<WAIT>"
    db "@"

Message_08_86::
    db "<BUF>", $17, "'s<LINE>"
    db "dancing lured<PROMPT>"
    db "<NEXT>a mermaid to the"
    db "<NEXT>surface.<WAIT>"
    db "@"
    ds $124, $00
