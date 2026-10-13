; Macros that name instruction idioms found in the ROM (E-0007). They expand to exactly
; the instructions the ROM contains, so the bytes do not change.

; A far call: `rst $10` calls the code at HL with ROM bank B mapped, then restores the caller's
; bank (Func_000_0010). The ROM loads the two registers in either order, hence two macros.
MACRO farcall
    ld hl, \1
    ld b, BANK(\1)
    rst $10
ENDM

MACRO farcall_b
    ld b, BANK(\1)
    ld hl, \1
    rst $10
ENDM

; A far pointer in data: the address, then its ROM bank (E-0141).
MACRO dfar
    dw \1
    db BANK(\1)
ENDM

; A jump through the word table that follows: `rst $00` (JumpTable) jumps to entry A of the
; `dw` list right after it, keeping DE (E-0007). src/ writes it this way; the listing keeps `rst $00`.
MACRO jumptable
    rst $00
ENDM

; Two bytes into a register pair, as pret writes it: `lb bc, 20, 8` is `ld bc, $1408` (B = 20, C = 8).
; src/ uses it before calls to the rectangle routines, which take B = width and C = rows (D-008).
MACRO lb
    ld \1, ((\2) & $FF) << 8 | ((\3) & $FF)
ENDM

; Event script commands (E-0152). FetchScriptCommand (bank $10) reads one opcode byte and
; the inline bytes of the dedicated opcodes; any other opcode is a command type with no
; inline bytes. Relative targets are forward offsets from the byte after the offset
; (in a db list, @ is the address of the byte being assembled).
MACRO script_end
    db $FF
ENDM

MACRO script_message
    db $00
    dw \1
ENDM

MACRO script_skip_if_no
    db $06, (\1) - @ - 1 ; in a db list, @ is the address of the byte being assembled
ENDM

MACRO script_jump
    db $07
    dw \1
ENDM

MACRO script_set_flag
    db $0A
    dw \1
ENDM

MACRO script_add_gold
    db $0E
    dw \1
ENDM

MACRO script_sound
    db $0F, \1
ENDM

MACRO script_choice_jump
    db $E4
    REPT _NARG
        db (\1) - @ - 1
        SHIFT
    ENDR
ENDM

MACRO script_jump_data_bank
    db $E7
    dw \1
ENDM

; E-0242: the dedicated opcodes with inline bytes, named from their fetch handlers and the
; command types they start (ScriptStepObject, ScriptWaitFrames, ScriptCommand05_Run,
; ScriptSetDirection, ScriptSlideObjectY, ScriptCommand0E_Run).
; script_walk object, direction (0 down, 1 right, 2 up, 3 left), tiles: 16 frames per tile
MACRO script_walk
    db $01, \1, \2, \3
ENDM

; the same at two pixels per frame (command type 03 runs ScriptStepObject twice)
MACRO script_walk_fast
    db $02, \1, \2, \3
ENDM

; script_wait frames (a 16-bit count)
MACRO script_wait
    db $03
    dw \1
ENDM

; script_hold_dpad direction (0 down, 1 right, 2 up, 3 left), frames: sets that D-pad bit in wJoypadHeld
MACRO script_hold_dpad
    db $04, \1, \2
ENDM

; script_face target (0 player, n follower record n, $80 + n object n), direction
MACRO script_face
    db $05, \1, \2
ENDM

; script_slide_y target (as script_face): 32 frames of Y steps from Data_05F_7959
MACRO script_slide_y
    db $0B, \1
ENDM

; script_hide_object n: byte $C of sprite slot n = $E0, at once
MACRO script_hide_object
    db $0C, \1
ENDM

; script_encounter n: StartScriptedEncounterTemp0 with ScriptedEncounterTable record n
MACRO script_encounter
    db $0D, \1
ENDM

; a message whose index gets + $20 unless story flag 0 is set
MACRO script_message_unless_flag0
    db $EA
    dw \1
ENDM

; a message whose index gets + 16 * wScreenTableIndex
MACRO script_message_by_screen
    db $F5
    dw \1
ENDM

MACRO script_op
    db \#
ENDM

MACRO script_command
    db \1
ENDM

; Map object selectors (E-0163): entries tried in order by LoadMapObjectsForScreen.
MACRO objsel_none
    dw $FFFF
ENDM

MACRO objsel_list
    dw $FFFE, \1
ENDM

MACRO objsel_unless_flag
    dw \1, \2
ENDM

MACRO objsel_unless_flags
    dw $FFFD, \1, \2, \3
ENDM

MACRO objsel_skip_if_clear
    dw $FFFC, \1
    db \2, \3
ENDM

MACRO objsel_skip_if_set
    dw $FFFB, \1
    db \2, \3
ENDM

; 24-bit little-endian values in data (E-0148).
MACRO d24
    REPT _NARG
        db LOW(\1), HIGH(\1), LOW((\1) >> 16)
        SHIFT
    ENDR
ENDM

; HL += A, the way the ROM spells it: add into L, carry into H.
MACRO add_a_to_hl
    add a, l
    ld l, a
    jr nc, .skip\@
    inc h
.skip\@:
ENDM

; HL = the word at [HL]: low byte first, then the high byte.
MACRO deref_hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
ENDM

; Script command types named from what they do (config/script_commands.json); `script_command` takes one of these.
DEF SCRIPT_SCENE_FARM_KIDS EQU $11 ; SceneFarmKids: a cutscene step named after the scene its only script shows: 'You must be the farm kids.' ... 'Warubou Wha? I smell something!' (E-0245)
DEF SCRIPT_SCENE_LEARN_QUICK EQU $12 ; SceneLearnQuick: a cutscene step named after the scene its only script shows: 'Wow, you kids sure learn quick!' ... 'Oh It's all spinning around' (E-0245)
DEF SCRIPT_SCENE_SPINNING EQU $13 ; SceneSpinning: a cutscene step named after the scene its only script shows: 'Oh It's all spinning around' ... 'You must be the farm kids.' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_SMELLS EQU $14 ; SceneWarubouSmells: a cutscene step named after the scene its only script shows: 'Warubou Wha? I smell something!' ... 'What is this? Food? Perfect!' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_FOOD EQU $15 ; SceneWarubouFood: a cutscene step named after the scene its only script shows: 'Warubou What is this? Food? Perfect!' ... 'Calm down and listen!' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_FOOD_2 EQU $16 ; SceneWarubouFood2: a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_WARUBOU_FOOD (E-0245)
DEF SCRIPT_SCENE_PACKAGE EQU $17 ; ScenePackage: a cutscene step named after the scene its only script shows: 'Did you get the package from...' ... 'Oh goodness, you're filthy!' (E-0245)
DEF SCRIPT_SCENE_GREATLOG_KEY EQU $18 ; SceneGreatlogKey: a cutscene step named after the scene its only script shows: before '0 received the GreatLog Key.' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_MAGIC_KEY EQU $19 ; SceneWarubouMagicKey: a cutscene step named after the scene its only script shows: 'Warubou Wa-hey! Good, good, good!' ... 'This here is a Magic...' (E-0245)
DEF SCRIPT_SCENE_OASIS_KEY EQU $1A ; SceneOasisKey: a cutscene step named after the scene its only script shows: 'This here is a Magic...' ... '0 received the Oasis Key.' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_LEAVES EQU $1B ; SceneWarubouLeaves: a cutscene step named after the scene its only script shows: 'C'mon, Warubou!' ... 'Have you heard about Magic Keys?' (E-0245)
DEF SCRIPT_SCENE_WARUBOU_WARNING EQU $1C ; SceneWarubouWarning: a cutscene step named after the scene its only script shows: 'Warubou Dangerous are other worlds!' ... 'Slash Hey, why the long faces?' (E-0245)
DEF SCRIPT_SCENE_LONG_FACES EQU $1D ; SceneLongFaces: a cutscene step named after the scene its only script shows: 'Slash Hey, why the long faces?' (E-0245)
DEF SCRIPT_CHECK_ITEM EQU $1E ; CheckItem: sets wGameFlags836 from whether item hTemp0 is in the inventory (FindTemp0InInventoryList) (E-0245)
DEF SCRIPT_SCENE_MONSTER_INSPECTION EQU $1F ; SceneMonsterInspection: a cutscene step named after the scene its only script shows: 'Ah, three healthy monsters! Very well' ... 'Very good show! That was splendid' (E-0245)
DEF SCRIPT_SCENE_KING_AUDIENCE EQU $21 ; SceneKingAudience: a cutscene step named after the scene its only script shows: 'King You wish to see our...' ... 'King I see. This is what...' (E-0245)
DEF SCRIPT_SCENE_CANAL_GATE EQU $22 ; SceneCanalGate: a cutscene step named after the scene its only script shows: 'What? Open the Canal Gate more?' (E-0245)
DEF SCRIPT_SCENE_WATER_SHORTAGE EQU $23 ; SceneWaterShortage: a cutscene step named after the scene its only script shows: 'King The town's water shortage seems...' ... 'King Wha-what? What happened?' (E-0245)
DEF SCRIPT_SCENE_TREASURE_THEFT EQU $24 ; SceneTreasureTheft: a cutscene step named after the scene its only script shows: 'King What? Arrrrgh! Round up all...' ... 'King I apologize, but my treasures...' (E-0245)
DEF SCRIPT_SCENE_WATER_SOLVED EQU $25 ; SceneWaterSolved: a cutscene step named after the scene its only script shows: 'You will? So we can go...' ... 'King This should solve the water...' (E-0245)
DEF SCRIPT_SCENE_MONSTERS_IN_TOW EQU $26 ; SceneMonstersInTow: a cutscene step named after the scene its only script shows: 'That will help you for certain.' ... 'Heh, you have monsters in tow?' (E-0245)
DEF SCRIPT_SCENE_RIVAL_DEFEATED EQU $27 ; SceneRivalDefeated: a cutscene step named after the scene its only script shows: 'You defeated my monster? Urggh' ... 'You again! You're determined!' (E-0245)
DEF SCRIPT_SHAKE_SCREEN EQU $28 ; ShakeScreen: shakes the screen (ScriptStepShakeScreen) with a sound effect (E-0245)
DEF SCRIPT_SCENE_WHO_ARE_YOU EQU $29 ; SceneWhoAreYou: a cutscene step named after the scene its only script shows: after a sound and a 140-frame wait, before 'Who are you? This is our...' and 'Zzz Zzz Huh! Watch out!' (E-0246)
DEF SCRIPT_SCENE_WATCH_OUT EQU $2A ; SceneWatchOut: a cutscene step named after the scene its only script shows: 'You can keep trying, but you're...' ... 'Zzz Zzz Huh! Watch out!' (E-0245)
DEF SCRIPT_SCENE_MERMAID_SONG EQU $2B ; SceneMermaidSong: a cutscene step named after the scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'In the past, mermaids are said...' (E-0245)
DEF SCRIPT_SCENE_DANCING EQU $2C ; SceneDancing: a cutscene step named after the scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'Erm The sense of rhythm just...' (E-0245)
DEF SCRIPT_SCENE_MERMAID_SONG_2 EQU $2D ; SceneMermaidSong2: a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_MERMAID_SONG (two objects moved by table) (E-0245)
DEF SCRIPT_WARP_MAP41 EQU $2E ; WarpMap41: warps to map $41 (WarpToMap41); used after 'Close your eyes a little while.' (E-0245)
DEF SCRIPT_SCENE_TENTACLES EQU $2F ; SceneTentacles: a cutscene step named after the scene its only script shows: 'Close your eyes for a little...' ... 'Thick, suction-cupped tentacles snaked out' (E-0245)
DEF SCRIPT_SCENE_SAILOR_RING EQU $30 ; SceneSailorRing: a cutscene step named after the scene its only script shows: after '0 received the Sailor Ring.' (E-0245)
DEF SCRIPT_SCENE_PIRATE_GHOSTS EQU $31 ; ScenePirateGhosts: a cutscene step named after the scene its only script shows: 'How could we die before enjoying...' ... 'The treasures are ours' (E-0245)
DEF SCRIPT_GIVE_ITEM_BLINK EQU $32 ; GiveItemBlink: adds item wC928 to the inventory (AppendItemWC928ToInventory) and blinks object hTemp0; '0 obtained YunaSoul.' (E-0245)
DEF SCRIPT_SCENE_CRATE EQU $33 ; SceneCrate: a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' ... '0 checked the crate.' (E-0245)
DEF SCRIPT_SET_TILES_FLAG_310 EQU $34 ; SetTilesFlag310: writes tiles $58-$5B into a 2 x 2 block of wScreenTileBuffer ($AA, $AB, $BE, $BF), redraws the screen and sets story flag $310 (E-0245)
DEF SCRIPT_SCENE_KAMEHA_ESCAPE EQU $35 ; SceneKamehaEscape: a cutscene step named after the scene its only script shows: '0 checked the crate.' ... 'Kameha Wahahahah! Thanks for guiding me' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_CAUGHT EQU $36 ; SceneKamehaCaught: a cutscene step named after the scene its only script shows: 'Kameha Wahahahah! Thanks for guiding me' ... 'Kameha Urk! How you catch up?' (E-0245)
DEF SCRIPT_SCENE_CREW_FOLLOWS EQU $37 ; SceneCrewFollows: a cutscene step named after the scene its only script shows: 'Aye, aye, sir! Right behind you!' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_FLEES EQU $38 ; SceneKamehaFlees: a cutscene step named after the scene its only script shows: 'Kameha Arrrrh, clear the way!' ... 'Kameha Aiyeeeeeh' (E-0245)
DEF SCRIPT_SCENE_MERMAID_KINGDOM EQU $39 ; SceneMermaidKingdom: a cutscene step named after the scene its only script shows: 'Kameha Aiyeeeeeh' ... 'This is the mermaid kingdom.' (E-0245)
DEF SCRIPT_SCENE_MASTER_THANKS EQU $3A ; SceneMasterThanks: a cutscene step named after the scene its only script shows: 'R Really? Wow! Thank you!' ... 'I became a master because I...' (E-0245)
DEF SCRIPT_REWARD_ITEM_OR_KEY EQU $3C ; RewardItemOrKey: gives an item or a key entry (AppendItemWC928ToInventory, WriteKeyEntryTemp0); 'Great, 0! Thanks a lot!' ... 'Here, 0! You hold onto it.' (E-0245)
DEF SCRIPT_REWARD_ITEM_OR_KEY_2 EQU $3D ; RewardItemOrKey2: the same rewards as SCRIPT_REWARD_ITEM_OR_KEY in another scene: 'Fantastic! I can open my shop' ... 'I like you to have this.' (E-0245)
DEF SCRIPT_SCENE_STRONGEST_MASTER EQU $3E ; SceneStrongestMaster: a cutscene step named after the scene its only script shows: 'The strongest master I've ever...' (E-0245)
DEF SCRIPT_BLINK_SPRITES EQU $3F ; BlinkSprites: shows the first sprite slot only on alternate groups of four frames (wSpriteSlotCount by wFrameCounterLo bit 2) (E-0245)
DEF SCRIPT_SCENE_SPIRIT_ENVOY EQU $40 ; SceneSpiritEnvoy: a cutscene step named after the scene its only script shows: 'Ah, you are the spirit's envoy.' ... 'We reported to the King that...' (E-0245)
DEF SCRIPT_SCENE_EXPLOSION EQU $41 ; SceneExplosion: a cutscene step named after the scene its only script shows: 'What? What was that explosion?' (screen shake and flash) (E-0245)
DEF SCRIPT_SCENE_REPORT_TO_KING EQU $42 ; SceneReportToKing: a cutscene step named after the scene its only script shows: 'We reported to the King that...' (E-0245)
DEF SCRIPT_SCENE_WALL_EXIT EQU $43 ; SceneWallExit: a cutscene step named after the scene its only script shows: '0 tapped on the wall.' ... 'Kameha That's it! That's the exit!' (E-0245)
DEF SCRIPT_SCENE_REAL_KING EQU $44 ; SceneRealKing: a cutscene step named after the scene its only script shows: before 'I'm the real King, you fake!' (E-0245)
DEF SCRIPT_SCENE_PLAN_RUINED EQU $45 ; ScenePlanRuined: a cutscene step named after the scene its only script shows: 'Arrgh, you've ruined my plan' ... 'Bravo! We're saved!' (starts a scripted encounter) (E-0245)
DEF SCRIPT_SCENE_CHEER_YUNA EQU $46 ; SceneCheerYuna: a cutscene step named after the scene its only script shows: 'You're here to cheer Lady Yuna.' ... 'King Magnificent!' (E-0245)
DEF SCRIPT_SCENE_SPIRIT_ENVOY_2 EQU $47 ; SceneSpiritEnvoy2: a cutscene step named after the scene its only script shows: 'Oh? An envoy from the spirit!' ... 'You startled me' (E-0245)
DEF SCRIPT_SCENE_PRINCESS_MEDICINE EQU $48 ; ScenePrincessMedicine: a cutscene step named after the scene its only script shows: 'STOP DON'T MEDDLE' ... 'Pardon me? You have medicine?' (encounter, removes an item) (E-0245)
DEF SCRIPT_SCENE_MEDICINE_GIVEN EQU $49 ; SceneMedicineGiven: a cutscene step named after the scene its only script shows: after 'Pardon me? You have medicine?' (E-0245)
DEF SCRIPT_SCENE_SHIELD EQU $4A ; SceneShield: a cutscene step named after the scene its only script shows: after '0 checked the shield.' (starts a scripted encounter) (E-0245)
DEF SCRIPT_SCENE_SHIELD_2 EQU $4B ; SceneShield2: a cutscene step named after the scene its only script shows: after '0 checked the shield.' (E-0245)
DEF SCRIPT_SCENE_WATER_REWARD EQU $4D ; SceneWaterReward: a cutscene step named after the scene its only script shows: 'King This should solve the water...' (creates a monster record) (E-0245)
DEF SCRIPT_SCENE_GRAVE EQU $4E ; SceneGrave: a cutscene step named after the scene its only script shows: '0 checked the grave.' ... 'Fine! You've done well...' (E-0245)
DEF SCRIPT_SET_TILES_D2 EQU $4F ; SetTilesD2: writes tiles $68-$6B into a 2 x 2 block of wScreenTileBuffer ($D2, $D3, $E6, $E7) and redraws the screen (E-0245)
DEF SCRIPT_SCENE_MADCONDOR EQU $50 ; SceneMadcondor: a cutscene step named after the scene its only script shows: 'Look! A MadCondor! It has something!' (E-0245)
DEF SCRIPT_SCENE_MADCONDOR_CRY EQU $51 ; SceneMadcondorCry: a cutscene step named after the scene its only script shows: 'Kweeeeeh!' (E-0245)
DEF SCRIPT_SCENE_SMALL_HOLE EQU $52 ; SceneSmallHole: a cutscene step named after the scene its only script shows: '0 checked the small hole.' ... 'You can take this treasure, but...' (E-0245)
DEF SCRIPT_SCENE_JUSTICE EQU $53 ; SceneJustice: a cutscene step named after the scene its only script shows: 'Let the power of justice smite...' ... '0 checked the gravestone.' (E-0245)
DEF SCRIPT_SCENE_GRAVESTONE EQU $54 ; SceneGravestone: a cutscene step named after the scene its only script shows: before '0 checked the gravestone.' (E-0245)
DEF SCRIPT_SET_FLAG_322 EQU $55 ; SetFlag322: sets story flag $322 (wStoryFlags + $64 bit 2); 'A door opened somewhere' (E-0245)
DEF SCRIPT_SCENE_BEATEN_FAIRLY EQU $56 ; SceneBeatenFairly: a cutscene step named after the scene its only script shows: 'You've beaten me fairly Take...' (E-0245)
DEF SCRIPT_SCENE_THREE_ITEMS_BATTLE EQU $57 ; SceneThreeItemsBattle: a cutscene step named after the scene its only script shows: 'Good. You have brought the three...' ... 'Don't you ever give up?' (encounter) (E-0245)
DEF SCRIPT_SCENE_THREE_ITEMS EQU $58 ; SceneThreeItems: a cutscene step named after the scene its only script shows: 'Kameha If the three items that...' (E-0245)
DEF SCRIPT_SCENE_SAW_KAMEHA EQU $59 ; SceneSawKameha: a cutscene step named after the scene its only script shows: 'What's that? You saw Prince Kameha' ... 'Sire, this child claims to know' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_BACK EQU $5A ; SceneKamehaBack: a cutscene step named after the scene its only script shows: runs SceneSawKameha's code: '... Prince Kameha came back!' (E-0245)
DEF SCRIPT_SCENE_LIMBO EQU $5B ; SceneLimbo: a cutscene step named after the scene its only script shows: 'Warubou Wa-hey! Take the treasures that...' ... 'Limbo is the King's domain!' (E-0245)
DEF SCRIPT_TAKE_ITEM EQU $5C ; TakeItem: removes item hTemp0 from the inventory (FindTemp0InInventoryList, RemoveInventorySlotShiftDown); '0 handed over the TidalBell.' (E-0245)
DEF SCRIPT_SCENE_DARCK_TAUNT EQU $5D ; SceneDarckTaunt: a cutscene step named after the scene its only script shows: 'N No How could my monsters' ... 'Darck Fawahahah!' (E-0245)
DEF SCRIPT_SCENE_DARCK_DEFEATED EQU $5E ; SceneDarckDefeated: a cutscene step named after the scene its only script shows: 'Darck Wha What? How could I' ... 'Darck Fwahahahah! Bravo! Splendid!' (E-0245)
DEF SCRIPT_SCENE_HOMECOMING EQU $5F ; SceneHomecoming: a cutscene step named after the scene its only script shows: 'Hehehe, no need to worry there!' ... 'Tara 0, congratulations! I was sad' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_STOLE EQU $61 ; SceneKamehaStole: a cutscene step named after the scene its only script shows: 'King Kameha made off with the...' (E-0245)
DEF SCRIPT_PERSONALITY_MESSAGE EQU $62 ; PersonalityMessage: shows a message chosen by a party monster's personality (PersonalityIndexOfRecord) (E-0245)
DEF SCRIPT_SCENE_RIVAL_FADE EQU $63 ; SceneRivalFade: a cutscene step named after the scene its only script shows: 'You defeated my monster? Urggh' (palette fade) (E-0245)
DEF SCRIPT_GATHER_FOLLOWERS EQU $64 ; GatherFollowers: moves the followers onto the leader (ScriptStepMoveFollowersToLeader) (E-0245)
DEF SCRIPT_GROWTH_LIMIT_INFO EQU $65 ; GrowthLimitInfo: shows a monster's name and a record byte as digits: 'Everyone has a growth limit. Whether...' (E-0245)
DEF SCRIPT_SCENE_SHIELD_GUARDIAN EQU $66 ; SceneShieldGuardian: a cutscene step named after the scene its only script shows: before '0 checked the shield.' (encounter) (E-0245)
DEF SCRIPT_SCENE_JUSTICE_2 EQU $67 ; SceneJustice2: a cutscene step named after the scene its only script shows: 'Let the power of justice smite...' (E-0245)
DEF SCRIPT_SCENE_FOUND_ME EQU $68 ; SceneFoundMe: a cutscene step named after the scene its only script shows: 'I'm surprised anyone managed to find...' (E-0245)
DEF SCRIPT_SCENE_FOUND_ME_BATTLE EQU $69 ; SceneFoundMeBattle: a cutscene step named after the scene its only script shows: 'I'm surprised anyone managed to find...' ... 'Ah, so good of you to...' (encounter) (E-0245)
DEF SCRIPT_SCENE_HORSING_AROUND EQU $6A ; SceneHorsingAround: a cutscene step named after the scene its only script shows: before 'Listen you two! Quit your horsing...' (E-0245)
DEF SCRIPT_SCENE_VAULT_SETTLED EQU $6B ; SceneVaultSettled: a cutscene step named after the scene its only script shows: 'You've come at the right...' ... 'Good, that's settled then. The Vault...' (E-0245)
DEF SCRIPT_GIVE_MONSTER EQU $6C ; GiveMonster: creates a monster record of kind hTemp1 (CreateMonsterRecordOfKindTemp1); 'You'll take it? Excellent! I'll send...' (E-0245)
DEF SCRIPT_SCENE_LIMBO_MONSTER EQU $6D ; SceneLimboMonster: a cutscene step named after the scene its only script shows: 'Limbo is the King's domain!' ... 'Prince Kameha has been missing' (creates a monster record) (E-0245)
DEF SCRIPT_SCENE_LIMBO_MONSTER_2 EQU $6E ; SceneLimboMonster2: a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_LIMBO_MONSTER (E-0245)
DEF SCRIPT_DESK_KEY EQU $6F ; DeskKey: the desk animation before '0 obtained the Brawn/Baffle/Soul/Magic Key.' (E-0245)
DEF SCRIPT_SCENE_TERRY EQU $70 ; SceneTerry: a cutscene step named after the scene its only script shows: '0 obtained the Magic Key.' ... 'Humph I'm Terry. I'm a master' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_KEY_BATTLE EQU $71 ; SceneKamehaKeyBattle: a cutscene step named after the scene its only script shows: 'Kameha So you're confident, huh?' (key entry and encounter) (E-0245)
DEF SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2 EQU $72 ; SceneKamehaKeyBattle2: a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_KAMEHA_KEY_BATTLE (E-0245)
DEF SCRIPT_FOLLOWER_FACE_PLAYER EQU $73 ; FollowerFacePlayer: copies hPlayerFacing to the first follower record (E-0245)
DEF SCRIPT_SET_FLAG_REDRAW EQU $74 ; SetFlagRedraw: sets a story flag, applies the map-screen flag events and redraws the screen (treasure chests) (E-0245)
DEF SCRIPT_SCENE_AT_SEA EQU $75 ; SceneAtSea: a cutscene step named after the scene its only script shows: after 'In the middle of the sea' (E-0245)
DEF SCRIPT_SCENE_LAND_HO EQU $77 ; SceneLandHo: a cutscene step named after the scene its only script shows: 'Land ho! There's GreatLog!' (E-0245)
DEF SCRIPT_SAVE_SCREEN EQU $78 ; SaveScreen: saves the screen buffer to BG map 1 (SaveScreenBufferToBGMap1) (E-0245)
DEF SCRIPT_SCENE_POOR_CHURCH EQU $79 ; ScenePoorChurch: a cutscene step named after the scene its only script shows: ... 'Our church is impoverished, so I...' (E-0245)
DEF SCRIPT_SCENE_KAMEHA_MISSING EQU $7A ; SceneKamehaMissing: a cutscene step named after the scene its only script shows: before 'Prince Kameha has been missing from...' (E-0245)
DEF SCRIPT_SCENE_ARENA_CHALLENGE EQU $7B ; SceneArenaChallenge: a cutscene step named after the scene its only script shows: 'Really? Let's go to the Arena!' (encounter) (E-0245)
DEF SCRIPT_SCENE_TERRY_BATTLE EQU $7C ; SceneTerryBattle: a cutscene step named after the scene its only script shows: 'Terry Humph Confident, huh?' (encounter) (E-0245)
DEF SCRIPT_SCENE_THIS_WAY EQU $7D ; SceneThisWay: a cutscene step named after the scene its only script shows: 'This way Here Here' ... 'I heard from Lord Darck, but...' (E-0245)
DEF SCRIPT_SCENE_GOT_TO EQU $7E ; SceneGotTo: a cutscene step named after the scene its only script shows: 'That's true I've got to...' (E-0245)
DEF SCRIPT_SCENE_CHEST_SERVANT EQU $7F ; SceneChestServant: a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' ... 'How may we serve your mortal...' (E-0245)
DEF SCRIPT_STEP_TRIGGER_REWARD EQU $80 ; StepTriggerReward: a key-world/field talk event (group $0F, dispatched by CheckStepTriggerAndDispatchTalk: gives gold (a byte * 10, AddGoldCapped), an item (AppendItemWC928ToInventory) or starts a battle with intro 5); named from its trigger and calls (E-0286)
DEF SCRIPT_AREA_ITEM EQU $81 ; AreaItemEvent: a key-world/field talk event (group $0E, dispatched from FieldModeStateDispatch: gives an item (AppendItemWC928ToInventory) after CheckTwoWCDB0EntriesForKeyWorldArea, redrawing the screen); named from its trigger and calls (E-0286)
DEF SCRIPT_GREATLOG_FIELD_EVENT EQU $82 ; GreatLogFieldEvents: talk category 8: jumps by wPendingFieldEvent & $0F to 13 scripted scenes on the Great Log island (Cobi, Tara, Warubou and Kameha dialogue); scene $0A gives gold or items, scene $0C takes a gold loss (DeductGoldPenaltyAndFormatLoss); corrects the E-0286 reading 'GreatLogFieldEvents' (E-0293)
DEF SCRIPT_FIELD_SCENE_01 EQU $83 ; FieldScene01: a key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: draws script meta-sprite 21, moves objects, changes the music); named from its trigger and calls (E-0286)
DEF SCRIPT_RANDOM_GOLD_OR_ITEM EQU $84 ; RandomGoldOrItem: a key-world/field talk event (group $02, dispatched from FieldModeStateDispatch: random gold (AddGoldCapped) or item (AppendItemWC928ToInventory)); named from its trigger and calls (E-0286)
DEF SCRIPT_KEY_WORLD_BOSS_BATTLE EQU $85 ; KeyWorldBossBattle: talk category 9, group 0: a random message ($00D0 + 0..F), a battle against wKeyWorldEncounter (one or three monsters), then after the 'Warubou' message sets wKeyWorldFlags bit 7, marks every floor entry of wKeyWorldEncounterTable done and sets bit 6 of the current key entry byte 7; a C1 name from its calls and writes (E-0286)
DEF SCRIPT_KEY_WORLD_DOOR_ITEM EQU $86 ; KeyWorldDoorItem: a key-world/field talk event (group $0B: random item or key entry (GenerateNewKeyEntry) and door tiles for the key-world floor (DrawDoorTilesForKeyWorldFloor)); named from its trigger and calls (E-0286)
DEF SCRIPT_PARTY_DEFEATED_RETURN EQU $87 ; PartyDefeatedReturn: a key-world/field talk event (group $04, dispatched from FieldModeStateDispatch_Case07: moves incapacitated members back (MoveIncapacitatedPartyMembersBack) and starts the return warp (StartReturnWarpByFlag25)); named from its trigger and calls (E-0286)
DEF SCRIPT_RETURN_MESSAGE EQU $88 ; ReturnMessage: a key-world/field talk event (group $05, dispatched by RunFieldReturnPhase_ResetLeadRecordFields55And5B and PartyDefeatedReturn: a message chosen by a story flag); named from its trigger and calls (E-0286)
DEF SCRIPT_RETURN_WARP EQU $89 ; ReturnWarp: a key-world/field talk event (group $06, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: StartReturnWarpByFlag25); named from its trigger and calls (E-0286)
DEF SCRIPT_MAP_EXIT_WARP EQU $8A ; MapExitWarp: a key-world/field talk event (group $07, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: fades, then sets the warp destination from the map exit records (E-0182), wMapType, the map size and the field transition); named from its trigger and calls (E-0286)
DEF SCRIPT_BREED_FADE EQU $8B ; BreedFade: a key-world/field talk event (group $15, dispatched by BreedMenu_TalkEvent15: a palette fade); named from its trigger and calls (E-0286)
DEF SCRIPT_BREED_CHILD_SPRITE EQU $8C ; BreedChildSprite: a key-world/field talk event (group $16, dispatched by BreedMenu_CopyToChildThenTalkEvent16: loads graphics (DecompressGraphicsTemp0ToTemp4) for a field object (RunFieldCommandTemp0)); named from its trigger and calls (E-0286)
DEF SCRIPT_BREED_CHILD_SCENE EQU $8D ; BreedChildScene: a key-world/field talk event (group $17, dispatched by BreedMenu_TalkEvent17ThenNameEntry: a field object with loaded graphics, a message with a name from the string database (CopyStringToBuffer_Bank08)); named from its trigger and calls (E-0286)
DEF SCRIPT_MAP_LINK_WARP EQU $8E ; MapLinkWarp: a key-world/field talk event (group $08, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: a timed palette fade, then the warp destination from the map link records (E-0238) or wKeyWorldGoal); named from its trigger and calls (E-0286)
DEF SCRIPT_NPC_BREED_WARP EQU $8F ; NpcBreedWarp: a key-world/field talk event (group $20, dispatched by NpcBreedMenu_Case04_DispatchTalkEvent: fades, sets the warp destination and wSavedPositionValid, and queues the next script and talk event); named from its trigger and calls (E-0286)
DEF SCRIPT_FOLLOWERS_STEP_10 EQU $90 ; FollowersStep10: a key-world/field talk event (group $10: steps the followers (UpdateFollowersOnStep)); named from its trigger and calls (E-0286)
DEF SCRIPT_FOLLOWERS_STEP_11 EQU $91 ; FollowersStep11: a key-world/field talk event (group $11: steps the followers (UpdateFollowersOnStep)); named from its trigger and calls (E-0286)
DEF SCRIPT_PLAYER_AND_FOLLOWERS_STEP EQU $92 ; PlayerAndFollowersStep: a key-world/field talk event (group $12: moves the player (UpdatePlayerMovement) and the followers); named from its trigger and calls (E-0286)
DEF SCRIPT_WARP_WITH_FOLLOWERS EQU $93 ; WarpWithFollowers: a key-world/field talk event (group $13: sets an object flag, fades, then sets the warp destination, wFollowerRecords and the field transition); named from its trigger and calls (E-0286)
DEF SCRIPT_FOLLOWERS_STEP_14 EQU $94 ; FollowersStep14: a key-world/field talk event (group $14: steps the followers, toggling object flag bit 1, with a sound); named from its trigger and calls (E-0286)
DEF SCRIPT_ARENA_GRID_BATTLE EQU $95 ; ArenaGridBattle: an arena battle: messages from ArenaRankMessageTable (StartArenaRankMessage) and foes from GridEncounterTable by wGridCursorX and wScreenCountPlusOne (battle intro 4, encounter kind 2; ScriptCommand95's Shared02) (E-0246)
DEF SCRIPT_ARENA_ROUNDS EQU $96 ; ArenaRounds: the arena's rounds: messages from ArenaRankMessageTable and foes from ArenaEncounterLists by wAreaGraphicsIndex, advancing the round (IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea) (E-0246)
DEF SCRIPT_OBJECT_PATH_1B EQU $98 ; ObjectPath1B: a key-world/field talk event (group $1B: moves an object by step deltas with the followers, then fades); named from its trigger and calls (E-0286)
DEF SCRIPT_OBJECT_PATH_1C EQU $99 ; ObjectPath1C: a key-world/field talk event (group $1C: moves an object by step deltas with the followers, then fades); named from its trigger and calls (E-0286)
DEF SCRIPT_RANDOM_BATTLE EQU $9A ; RandomBattleEvent: a key-world/field talk event (group $19, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: picks a battle intro (NextRandomSeed) and starts a battle (SetModeState3AndSaveScreen)); named from its trigger and calls (E-0286)
DEF SCRIPT_HEAL_PARTY EQU $9B ; HealPartyEvent: a key-world/field talk event (group $1A, dispatched by RunMenuStateMenuState: heals the party (FullyHealParty) after a flag-chosen message); named from its trigger and calls (E-0286)
DEF SCRIPT_ENCOUNTER_MESSAGE EQU $9C ; EncounterCounterMessage: a key-world/field talk event (group $1D, dispatched by TickRandomEncounterCounter: one message (StartMessageA)); named from its trigger and calls (E-0286)
DEF SCRIPT_COUNTDOWN_MESSAGE EQU $9D ; CountdownMessage: a key-world/field talk event (group $1E, dispatched by CountDownTalkCountdownThenDispatchTalkEvent: one message); named from its trigger and calls (E-0286)
DEF SCRIPT_KEY_WORLD_FLOOR_BATTLE EQU $9E ; KeyWorldFloorBattle: talk category 9, group 3: a random message ($00E0 + 0..F), a battle against the wKeyWorldEncounterTable entry of wKeyWorldFloor, then after the 'Warubou' message marks that floor entry done (byte 3 = 1); a C1 name from its calls and writes (E-0286)
DEF SCRIPT_LINK_MESSAGE EQU $9F ; LinkMessageEvent: a key-world/field talk event (group $21, dispatched from the link screens (GameMode5_Update, RunLinkSession4ScreenState): graphics and a message); named from its trigger and calls (E-0286)
DEF SCRIPT_PLAYER_SPRITE_FLASH EQU $A0 ; PlayerSpriteFlash: a key-world/field talk event (group $09, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: reloads the player sprite graphics with a negative screen flash); named from its trigger and calls (E-0286)
DEF SCRIPT_PLAYER_SPRITE_MESSAGE EQU $A1 ; PlayerSpriteMessage: a key-world/field talk event (group $0A, dispatched by UpdatePlayerMovement: reloads the player sprite graphics and shows a message); named from its trigger and calls (E-0286)
DEF SCRIPT_SCENE_ROLT_ELDER EQU $C0 ; SceneRoltElder: a cutscene step named after the scene its only script shows: 'I'm the village's elder.' ... 'Rolt That was fast, 0.' (E-0245)
DEF SCRIPT_SCENE_TOO_STRONG EQU $C1 ; SceneTooStrong: a cutscene step named after the scene its only script shows: 'Too strong Arroooh!' ... 'Rolt What? Cyal was abducted?' (E-0245)
DEF SCRIPT_SCENE_GIVE_BACK_CYAL EQU $C2 ; SceneGiveBackCyal: a cutscene step named after the scene its only script shows: 'Rolt Shut up! Give back Cyal!' (E-0245)
DEF SCRIPT_KEY_BOSS_BEATEN EQU $C3 ; KeyBossBeaten: marks key entry kind hTemp0 with bit 6 (MarkKeyEntryKindTemp0Bit6) and blinks an object: 'Wh-what? I Lost to a child?' (E-0245)
DEF SCRIPT_SCENE_BARREL EQU $C4 ; SceneBarrel: a cutscene step named after the scene its only script shows: '0 peered into the barrel.' ... 'Kiral Ah! Back!' (encounter) (E-0245)
DEF SCRIPT_SCENE_WIZSTONE EQU $C5 ; SceneWizstone: a cutscene step named after the scene its only script shows: 'Kiral This stone, the WizStone, it...' (E-0245)
DEF SCRIPT_SCENE_CYAL_ROLT EQU $C6 ; SceneCyalRolt: a cutscene step named after the scene its only script shows: 'Rolt 0, I'm sorry we put...' ... 'I'm glad that Cyal and Rolt...' (E-0245)
DEF SCRIPT_SCENE_PENDANT_SELLER EQU $C7 ; ScenePendantSeller: a cutscene step named after the scene its only script shows: 'This pendant is yours for 38,000G' ... 'You're going to regret seeing us.' (E-0245)
DEF SCRIPT_SCENE_MERCY EQU $C8 ; SceneMercy: a cutscene step named after the scene its only script shows: 'Please! Mercy! Spare us! Take back...' (E-0245)
DEF SCRIPT_SCENE_MILAYOU_FOREST EQU $C9 ; SceneMilayouForest: a cutscene step named after the scene its only script shows: 'Milayou I thought this forest looked...' (E-0245)
DEF SCRIPT_KEY_BOSS_BEATEN_2 EQU $CA ; KeyBossBeaten2: the same as SCRIPT_KEY_BOSS_BEATEN for another boss: 'But No! I lost to this' (E-0245)
DEF SCRIPT_SCENE_CHEST_BATTLE EQU $CB ; SceneChestBattle: a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' (key entry mark and encounter) (E-0245)
DEF SCRIPT_SCENE_CYAL_SHINE EQU $CC ; SceneCyalShine: a cutscene step named after the scene its only script shows: ... 'So Cyal took a shine to...' (E-0245)
DEF SCRIPT_SCENE_YOU_DID_IT EQU $CD ; SceneYouDidIt: a cutscene step named after the scene its only script shows: ... 'Warubou Wa-hey! You did it, 0!' (E-0245)
DEF SCRIPT_HIDE_SPRITES EQU $CE ; HideSprites: wSpriteSlotCount = 0 (E-0245)
DEF SCRIPT_SCENE_KEY_SHOP EQU $CF ; SceneKeyShop: a cutscene step named after the scene its only script shows: 'How good of you to overcome' ... 'Welcome to my Key Shop!' (E-0245)
DEF SCRIPT_INN EQU $E0 ; InnMenu: the inn: 'It's 0G a night. Will you...', 'Good morning and farewell!' (mode 1, bank $F0 strings) (E-0244)
DEF SCRIPT_INN_CLOSE EQU $E1 ; CloseInnMenu: ends the inn session and clears wMessageMode (E-0244)
DEF SCRIPT_SHOP EQU $E2 ; ShopMenu: the shop: 'What would you like to buy?', 'That comes to 0G. OK?'; reads ShopItemListTable and ItemValueTable (mode 2) (E-0244)
DEF SCRIPT_SHOP_CLOSE EQU $E3 ; CloseShopMenu: ends the shop session ('Thank you! Please come again.' between its two calls) and clears wMessageMode (E-0244)
DEF SCRIPT_VAULT EQU $E5 ; VaultMenu: the item Vault: 'What item should I store for...', 'What will you be taking out?' (mode 2) (E-0244)
DEF SCRIPT_VAULT_CLOSE EQU $E6 ; CloseVaultMenu: ends the Vault session (runs CloseShopMenu's code) (E-0244)
DEF SCRIPT_SWAP_MONSTERS EQU $E8 ; SwapMonstersMenu: Cobi's swap of party and farm monsters: 'What'll you switch it with?', 'I switched 0.' (mode 3, bank $1F strings) (E-0244)
DEF SCRIPT_MENU_CLOSE EQU $E9 ; CloseMenuE9: ends a menu session (runs CloseBreedMenu's code); follows the swap and NPC breeding menus (E-0244)
DEF SCRIPT_HIBERNATE EQU $EB ; HibernateMenu: monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode 4, bank $1D strings) (E-0244)
DEF SCRIPT_HIBERNATE_CLOSE EQU $EC ; CloseHibernateMenu: ends the hibernation session and clears wMessageMode (E-0244)
DEF SCRIPT_BREED EQU $ED ; BreedMenu: breeding: 'Which will be the base monster?', 'And what will its mate be?' (mode 5, bank $1B strings) (E-0244)
DEF SCRIPT_BREED_CLOSE EQU $EE ; CloseBreedMenu: ends the breeding (and medal prize) session and clears wMessageMode (E-0244)
DEF SCRIPT_EGG_SERVICE EQU $EF ; EggServiceMenu: egg appraisal and blessing: 'Which egg should I appraise?', 'Which egg should I bless?' (mode 6, bank $F2 strings) (E-0244)
DEF SCRIPT_RENAME EQU $F0 ; RenameMenu: the Christener's renaming: 'Pick the monster to rename.' (runs EggServiceMenu's first state, so mode 6) (E-0244)
DEF SCRIPT_RENAME_CLOSE EQU $F1 ; CloseRenameMenu: ends the renaming session (runs CloseBreedMenu's code) (E-0244)
DEF SCRIPT_KEY_APPRAISAL EQU $F2 ; KeyAppraisalMenu: Magic Key appraisal: 'Which Magic Key should I appraise?', 'Appraisal will cost 0G. OK?' (mode 7, bank $0D strings) (E-0244)
DEF SCRIPT_MEDAL_PRIZES EQU $F3 ; MedalPrizeMenu: the TinyMedal prize exchange: 'Which prize do you want?', 'I'll trade for 0 TinyMedals. OK?' (mode 7) (E-0244)
DEF SCRIPT_NPC_BREED EQU $F4 ; NpcBreedMenu: breeding with a townsperson's monster picked by wScreenTableIndex: 'Who will breed with my SpikyBoy?' (mode 8, message bank $0E, + 16 * wScreenTableIndex) (E-0244)
DEF SCRIPT_LIBRARY EQU $F6 ; LibraryMenu: the monster library: 'Welcome to the library. Which family will you check?' (mode 9, bank $0B strings) (E-0244)
DEF SCRIPT_ARENA EQU $F7 ; ArenaMenu: the arena: 'The E Class should do. Which...', 'Congratulations! You did it!' (mode 10, bank $33 strings) (E-0244)
DEF SCRIPT_PRIEST EQU $F8 ; PriestMenu: the priest: 'Which monster should be revived?', curse removal (mode 11, bank $24 strings) (E-0244)
