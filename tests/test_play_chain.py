"""A new game played to GreatLog's farm, then the debug menu's battle (E-0320; tools/recipes/e0320_farm_battle.txt),
then the Desert key world with random encounters, the field menu and a PLAN battle (E-0321; e0321_desert.txt), then
the field menu's ITEM, SKILLS and PLAN (E-0322; e0322_menus.txt), then saving on the farm and continuing after a fresh
power-on (E-0323; e0323_save.txt), then GreatLog's Vault, Egg Evaluator and Christener (E-0325; e0325_town.txt), then the
HP/MP pairs and the Herb (E-0326; e0326_hp.txt), then a shop and an inn (E-0327; e0327_shop_inn.txt), then breeding
(E-0328; e0328_breed.txt), then the monster library (E-0329; e0329_library.txt), then the priest (E-0330; e0330_priest.txt), then
hibernation and the TinyMedal prizes (E-0331; e0331_hibernate_medals.txt), then a Magic Key's appraisal (E-0334;
e0334_keys.txt, which includes the others), replayed in memory. Pins the routines each step ran, which the screen pictures showed together
with the text or screen their names describe, and the records the status pages showed. An observation of our own
emulator; everything after the farm is forced (debug menu, location bytes, one story flag)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))
CHAIN = ROOT / "tools/recipes/e0334_keys.txt"


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class FarmChain(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import play
        cls.kept, cls.ran = play.replay(str(CHAIN), {"d08!", "k02!", "k05!", "k08!", "m03!", "m04!", "m07!",
                                                             "m09!", "m11!", "m12!", "j02!", "j03!", "r04!",
                                                             "v05!", "v07!", "x07!", "c04!", "c05!",
                                                             "hp02!", "hp04!", "sh12!", "sh13!", "sh15!", "q06!",
                                                             "q07!", "br01!", "bb02!", "bb19!", "lb01!", "lb02!", "pr03!", "pr05!", "t02!", "hb02!", "hb07!",
                                                             "md11!", "ky01!", "ky06!"})
        cls.labels = {v: k for k, v in __import__("boot_trace").load_labels().items()}
        import re
        cls.ram = {n: int(a, 16) for n, a in re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})",
                                                         (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M)}

    def test_story_scenes_run_at_the_steps_that_showed_their_text(self):
        expect = {"s14": ["TalkMsg000A_WellSoonBeReachingGreatLog"],  # talking to the mother
                  "s22": ["SceneLandHo"],  # talking to Tara
                  "s24": ["SceneLandHo_ShowThisIsATale"],  # "This is a tale of children who came"
                  "s25": ["SceneHorsingAround", "TalkScript5111_ListenYouTwoQuitYourHorsing"]}
        for state, names in expect.items():
            for name in names:
                self.assertEqual(self.ran[state].get(name), {1}, (state, name))

    def test_party_records_in_state_2_and_kept_ones_in_state_1(self):
        sram = self.kept["d08!"].sram
        self.assertEqual([sram[i * 0xA5] for i in range(8)], [2, 2, 2, 1, 1, 1, 1, 1])

    def test_the_status_page_monster(self):
        """Patta: Dracky (species $73), level 4 of cap 50, female, 15 EXP (the page showed Lv 4, the female
        mark, Dracky, Ex 15 and 12 more for the next level)."""
        r = self.kept["d08!"].sram[0:0xA5]
        self.assertEqual(r[0x0B] | r[0x0C] << 8, 0x73)
        self.assertEqual((r[0x56], r[0x57], r[0x0E] & 1), (4, 50, 1))
        self.assertEqual(int.from_bytes(r[0x58:0x5B], "little"), 15)
        rom = ROM.read_bytes()
        row = 0x19 * 0x4000 + 0x4E60 - 0x4000 + 2 * 0x129  # ExpTable row 2, Dracky's EXP curve
        need5 = int.from_bytes(rom[row + 3 * 4:row + 3 * 5], "little")
        self.assertEqual(need5 - 15, 12)

    def test_a_random_encounter_in_the_desert_world(self):
        """Walking in the Desert key world counts down the encounter counter, runs the battle transition and enters
        battle mode 4 (the picture showed a CactiBall and the FIGHT/ITEM/PLAN/FLEE menu)."""
        ran = self.ran["k02!"]
        for name in ("TickRandomEncounterCounter", "RunBattleTransitionStep", "RunBattleIntroKindCase"):
            self.assertEqual(ran.get(name), {1}, name)
        self.assertEqual(self.kept["k02!"].rb(0xC5DB), 4)  # wGameMode

    def test_the_field_menu_and_the_gold(self):
        """With story flag 2 set, A opens the field menu, which shows G99999 and the party status window."""
        ran = self.ran["k05!"]
        for name in ("ShowIdlePartyStatusWindow", "BuildPartyStatusWindowRows", "DrawGoldDigitsAtHLWrapped"):
            self.assertEqual(ran.get(name), {1}, name)
        gb = self.kept["k05!"]
        self.assertEqual(gb.rb(0xC617) | gb.rb(0xC618) << 8 | gb.rb(0xC619) << 16, 99999)  # wGoldLo/Mid/Hi

    def test_the_pause_menu_is_game_mode_2_and_shows_the_skills(self):
        """INFO runs the pause menu in mode 2; its skill page showed 'Sleep' for Patta, whose first MON_SKILLS
        byte names String_08_04_2F; MON_SKILL_LIST holds Dracky's three natural skills."""
        for name in ("GameMode2_Update", "PauseMenu_Info"):
            self.assertEqual(self.ran["k06!"].get(name), {2}, name)
        self.assertEqual(self.ran["k08!"].get("ShowRecordSpeciesAndSkillNames"), {2})
        r = self.kept["k08!"].sram[0:0xA5]
        self.assertEqual(r[0x34], 0x2F)
        rom = ROM.read_bytes()
        b, a = self.labels["String_08_04_2F"]
        sleep = bytes([0x1C, 0x2F, 0x28, 0x28, 0x33, 0xF0])  # "Sleep", $F0
        self.assertEqual(rom[b * 0x4000 + a - 0x4000:b * 0x4000 + a - 0x4000 + 6], sleep)
        b, a = self.labels["SpeciesRecord_Dracky"]
        natural = rom[b * 0x4000 + a - 0x4000 + 8:b * 0x4000 + a - 0x4000 + 11]
        self.assertEqual(bytes(r[0x3C:0x3F]), natural)
        self.assertEqual(natural, bytes([0x21, 0x2F, 0x32]))

    def test_plan_command_and_the_skill_page_in_battle(self):
        self.assertEqual(self.ran["k14!"].get("RunBattleSetup_CommandMenu"), {4})
        self.assertEqual(self.ran["k15!"].get("SetSlotTacticAndSlotLastTacticForCommandMonster"), {4})
        self.assertEqual(self.ran["k16!"].get("ShowSkillPageNames"), {4})


    def test_the_field_menu_choice_is_the_pause_menu_state(self):
        """wMenuState is the field menu's cursor and becomes wModeState of game mode 2: 0 INFO, 1 ITEM, 2 SKILLS,
        3 PLAN (pictured: the ITEM list, the SKILLS list and the PLAN menu)."""
        self.assertEqual(self.kept["m03!"].rb(self.ram["wMenuState"]), 1)
        for state, mode_state, name in (("m04!", 1, "PauseMenu_Items"), ("m09!", 2, "PauseMenu_Skills"),
                                        ("m11!", 3, "PauseMenu_Plan")):
            self.assertEqual(self.ran[state].get(name), {2}, name)
            gb = self.kept[state]
            self.assertEqual((gb.rb(0xC5DB), gb.rb(self.ram["wModeState"])), (2, mode_state), state)

    def test_the_inventory_holds_item_ids(self):
        """The ITEM list's first page is Herb, LoveWater, WorldDew, Potion; wInventory starts 1, 2, 3, 4, and
        String_08_05_01-04 are those names."""
        import gb_text
        inv = [self.kept["m04!"].rb(0xC61D + i) for i in range(4)]
        self.assertEqual(inv, [1, 2, 3, 4])
        rom = ROM.read_bytes()
        names = []
        for i in inv:
            b, a = self.labels[f"String_08_05_{i:02X}"]
            o = b * 0x4000 + a - 0x4000
            names.append("".join(gb_text.BYTE_TO_TEXT[c] for c in rom[o:rom.index(0xF0, o)]))
        self.assertEqual(names, ["Herb", "LoveWater", "WorldDew", "Potion"])

    def test_a_herb_on_a_monster_at_full_hp_is_kept(self):
        for name in ("PauseMenu_Items_UseItem", "CheckItemUsable", "ItemUsable_Herb"):
            self.assertEqual(self.ran["m06!"].get(name, set()) | self.ran["m07!"].get(name, set()), {2}, name)
        gb = self.kept["m07!"]
        self.assertEqual(gb.rb(0xC61D), 1)  # still a Herb in slot 0
        self.assertEqual(gb.sram[0x5B] | gb.sram[0x5C] << 8, gb.sram[0x5D] | gb.sram[0x5E] << 8)

    def test_saving_is_refused_in_a_key_world(self):
        """PLAN's Journal showed 'You can't save here.' in the Desert world: SaveForbiddenHere ran with wMapType
        bit 7 clear, so the refusal is bit 4 of MapItemUseFlags for map $20, which is clear there and set for
        GreatLog's maps."""
        for name in ("TestSaveForbiddenHere", "SaveForbiddenHere"):
            self.assertEqual(self.ran["m12!"].get(name), {2}, name)
        gb = self.kept["m12!"]
        self.assertEqual((gb.rb(self.ram["wMapType"]) & 0x80, gb.rb(0xFF90)), (0, 0x20))  # hMapId
        b, a = self.labels["MapItemUseFlags"]
        flags = ROM.read_bytes()[b * 0x4000 + a - 0x4000:][:0x100]
        self.assertFalse(flags[0x20] & 0x10)
        self.assertTrue(all(f & 0x10 for f in flags[:0x20]))


    def test_the_save_checksums(self):
        """Recording the journey stores, little-endian, (~sum + $4321) of the $1A04 bytes from sA06F of SRAM bank 1
        at sBA73, and (~sum + $1234) of the first $1FFE bytes of SRAM bank 3 at sBFFE; both words were 0 before."""
        for name in ("ComputeSRAMBank1RecordChecksum", "CopySaveBlocksToSRAMWithSum", "BackupRecordsToSRAMBank1",
                     "PauseMenu_Plan_RecordJourney_ShowYourProgressHasBeen"):
            self.assertEqual(self.ran["j03!"].get(name), {2}, name)

        def words(gb):
            b1, b3 = bytes(gb.sram[0x2000:0x4000]), bytes(gb.sram[0x6000:0x8000])
            s1, s3 = sum(b1[0x6F:0x1A73]) & 0xFFFF, sum(b3[:0x1FFE]) & 0xFFFF
            return ((s1 ^ 0xFFFF) + 0x4321) & 0xFFFF, b1[0x1A73] | b1[0x1A74] << 8,                 ((s3 ^ 0xFFFF) + 0x1234) & 0xFFFF, b3[0x1FFE] | b3[0x1FFF] << 8

        c1, w1, c3, w3 = words(self.kept["j03!"])
        self.assertEqual((w1, w3), (c1, c3))
        self.assertEqual(words(self.kept["j02!"])[1::2], (0, 0))

    def test_continue_after_a_fresh_power_on_restores_the_records(self):
        """Powered on with the saved cartridge RAM, the title menu offers CONTINUE (its checks accept the save) and
        the game resumes on the farm; every record comes back, its name kept up to its $F0 and padded with $F0."""
        for name in ("VerifySaveBank1Checksum", "VerifySaveBank3Checksum"):
            self.assertIn(5, self.ran["r01!"].get(name, set()) | self.ran["r02!"].get(name, set()), name)
        self.assertEqual(self.ran["r04!"].get("RestoreRecordsFromSRAMBank1Backup"), {5})
        before, after = self.kept["j03!"], self.kept["r04!"]
        self.assertEqual((after.rb(0xC5DB), after.rb(0xFF90)), (1, 0))  # wGameMode, hMapId
        for i in range(8):
            a = bytes(before.sram[i * 0xA5:(i + 1) * 0xA5])
            b = bytes(after.sram[i * 0xA5:(i + 1) * 0xA5])
            end = a.index(0xF0, 1)
            self.assertEqual(b[:end + 1] + b[11:], a[:end + 1] + a[11:], i)
            self.assertEqual(set(b[end:11]), {0xF0}, i)


    def test_the_vault_stores_an_item_as_an_id_and_a_count(self):
        """Depositing the first listed item ($28) takes it out of the bag, which closes up with a 0 at the end, and
        writes ($28, 1) to the first two-byte entry of wItemStorage."""
        self.assertEqual(self.ran["v05!"].get("VaultMenu"), {1})
        self.assertEqual(self.ran["v07!"].get("RemoveItemCountFromInventory"), {1})
        before, after = self.kept["v05!"], self.kept["v07!"]
        bag0 = [before.rb(0xC61D + i) for i in range(24)]
        bag1 = [after.rb(0xC61D + i) for i in range(24)]
        i = bag0.index(0x28)
        self.assertEqual(bag1, bag0[:i] + bag0[i + 1:] + [0])
        self.assertEqual([before.rb(0xC635), before.rb(0xC636)], [0, 0])
        self.assertEqual([after.rb(0xC635), after.rb(0xC636)], [0x28, 1])

    def test_the_egg_evaluator_finds_no_egg(self):
        """'You don't have any eggs': EggServiceMenu lists the records in use whose MON_EGG byte is set, and none is."""
        self.assertEqual(self.ran["x07!"].get("ListRecordsInUseWithByte6ESet"), {1})
        sram = self.kept["x07!"].sram
        self.assertEqual([i for i in range(8) if sram[i * 0xA5] and sram[i * 0xA5 + 0x6E]], [])

    def test_the_christener_renames_a_monster(self):
        """RenameMenu's name entry, with BACK and 'A', turns record 0's MON_NAME from Patta into PattA."""
        self.assertEqual(self.ran["c04!"].get("RenameMenu"), {1})
        self.assertEqual(bytes(self.kept["c04!"].sram[1:7]), bytes([0x19, 0x24, 0x37, 0x37, 0x24, 0xF0]))
        self.assertEqual(bytes(self.kept["c05!"].sram[1:7]), bytes([0x19, 0x24, 0x37, 0x37, 0x0A, 0xF0]))


    def test_a_herb_raises_the_current_hp_word_up_to_the_maximum(self):
        """With MON_HP lowered (the stats page then showed 'HP: 5/21'), a Herb raises $5B by 30-40, capped at $5D, and
        leaves the bag: Patta 5 -> 21 (cap 21), Moahm 50 -> 80..90 (cap 138)."""
        for name in ("ItemApply_Herb", "AddHLToRecordHPCapped", "CompactInventory"):
            self.assertEqual(self.ran["hp02!"].get(name), {2}, name)
        w = lambda gb, o: gb.sram[o] | gb.sram[o + 1] << 8
        patta = self.kept["hp02!"]
        self.assertEqual((w(patta, 0x5B), w(patta, 0x5D)), (21, 21))
        self.assertEqual(patta.rb(0xC61D), 2)  # the Herb (1) in slot 0 is gone
        moahm = self.kept["hp04!"]
        self.assertTrue(80 <= w(moahm, 2 * 0xA5 + 0x5B) <= 90)
        self.assertEqual(w(moahm, 2 * 0xA5 + 0x5D), 138)


    def gold(self, state):
        gb = self.kept[state]
        return gb.rb(0xC617) | gb.rb(0xC618) << 8 | gb.rb(0xC619) << 16

    def test_the_shop_sells_at_three_quarters_and_buys_at_the_value(self):
        """The sell list showed Herb 7G, LoveWater 37G, WorldDew 375G, Potion 150G: ItemValueTable (10, 50, 500,
        200) times ShopPercentTable[0] (75) / 100. Selling a Herb at 99,999 gold leaves 99,999 (the cap); buying one
        at 10G takes 10 and puts it in the free slot."""
        rom = ROM.read_bytes()
        b, a = self.labels["ItemValueTable"]
        o = b * 0x4000 + a - 0x4000
        values = [rom[o + 2 * i] | rom[o + 2 * i + 1] << 8 for i in (1, 2, 3, 4)]
        b, a = self.labels["ShopPercentTable"]
        pct = rom[b * 0x4000 + a - 0x4000]
        self.assertEqual([v * pct // 100 for v in values], [7, 37, 375, 150])
        self.assertEqual(self.ran["sh11!"].get("ShopMenu"), {1})
        self.assertEqual(self.ran["sh13!"].get("AddArg1ToGoldCapped99999"), {1})
        self.assertEqual(self.ran["sh15!"].get("SubtractArg1AmountFromGold"), {1})
        bag12 = [self.kept["sh12!"].rb(0xC61D + i) for i in range(24)]
        bag13 = [self.kept["sh13!"].rb(0xC61D + i) for i in range(24)]
        bag15 = [self.kept["sh15!"].rb(0xC61D + i) for i in range(24)]
        self.assertEqual(bag13, bag12[1:] + [0])  # the Herb in slot 0 sold, the bag closed up
        self.assertEqual((self.gold("sh12!"), self.gold("sh13!"), self.gold("sh15!")), (99999, 99999, 99989))
        self.assertEqual(bag15, bag13[:23] + [1])

    def test_the_inn_restores_hp_and_mp_for_ten_gold(self):
        self.assertEqual(self.ran["q07!"].get("InnMenu_RestoreParty"), {1})
        hurt, rested = self.kept["q06!"], self.kept["q07!"]
        self.assertEqual((hurt.sram[0x5B], hurt.sram[0x5F], self.gold("q06!")), (5, 7, 99989))
        self.assertEqual((rested.sram[0x5B], rested.sram[0x5F]), (rested.sram[0x5D], rested.sram[0x61]))


    def test_breeding_follows_the_family_pair_table_and_makes_the_child(self):
        """Base Vanyl (Gulpple, family 4) with mate Moahm (family 5): the preview's child is
        FamilyPairResultTable[4][5] (CactiBall, $91); after the egg hatches the two parents' records are gone and a
        new record holds the child: level 1, the base's family, MON_PARENT1/2_SPECIES $92 and $C2, MON_PARENT1/2_NAME
        Vanyl and Moahm."""
        self.assertEqual(self.ran["br01!"].get("BreedMenu"), {1})
        self.assertIn(1, set().union(*(self.ran[s].get("ComputeBreedingChild", set()) for s in ("bb01!", "bb02!"))))
        rom = ROM.read_bytes()
        b, a = self.labels["FamilyPairResultTable"]
        o = b * 0x4000 + a - 0x4000
        row = rom[o + 8] | rom[o + 9] << 8  # family 4
        r = b * 0x4000 + row - 0x4000 + 2 * 5  # parent B's family 5
        expect = rom[r] | rom[r + 1] << 8
        gb = self.kept["bb02!"]
        self.assertEqual(gb.rb(0xCAD0 + 0x0B) | gb.rb(0xCAD0 + 0x0C) << 8, expect)  # wChildRecord + MON_SPECIES
        self.assertEqual(expect, 0x91)
        before, after = self.kept["br01!"].sram, self.kept["bb19!"].sram
        live = lambda sram: [bytes(sram[i * 0xA5:(i + 1) * 0xA5]) for i in range(0x2000 // 0xA5) if sram[i * 0xA5] in (1, 2)]
        species = lambda recs: sorted(r[0x0B] | r[0x0C] << 8 for r in recs)
        old, new = live(before), live(after)
        self.assertEqual(len(new), len(old) - 1)
        gone = species(old)
        for sp in species(new):
            gone.remove(sp) if sp in gone else None
        self.assertEqual(sorted(gone), [0x92, 0xC2])
        child = [r for r in new if r[0x0B] | r[0x0C] << 8 == 0x91 and r[0x1A] != 0xFF][0]
        self.assertEqual((child[0x56], child[0x0D] & 0x0F), (1, 4))
        self.assertEqual((child[0x1A] | child[0x1B] << 8, child[0x1C] | child[0x1D] << 8), (0x92, 0xC2))
        self.assertEqual(child[0x8E:0x93], bytes([0x1F, 0x24, 0x31, 0x3C, 0x2F]))  # Vanyl
        self.assertEqual(child[0x99:0x9E], bytes([0x16, 0x32, 0x24, 0x2B, 0x30]))  # Moahm


    def test_the_library_counts_seen_species_per_family(self):
        """The library's two pages draw one count per family (digit tiles $E0 + d in column 7, rows 1-11): the
        species ids 0-372 whose wSpeciesFlags bit is set, counted by the family byte of their SpeciesRecordPointers
        record, as CountSpeciesPerFamilyFlaggedOrListed is read (its second source, the list at wMonsterLibraryBuf,
        is empty here)."""
        self.assertEqual(self.ran["lb01!"].get("LibraryMenu"), {1})
        rom = ROM.read_bytes()
        b, a = self.labels["SpeciesRecordPointers"]
        o = b * 0x4000 + a - 0x4000
        gb = self.kept["lb01!"]
        model = [0] * 11
        for i in range(373):
            fam = rom[b * 0x4000 + (rom[o + 2 * i] | rom[o + 2 * i + 1] << 8) - 0x4000]
            if fam != 0xFF and gb.rb(0xC7CC + i // 8) >> (i & 7) & 1:
                model[fam] += 1
        self.assertEqual([gb.rb(0xC7FC + i) for i in range(4)], [0, 0, 0, 0])
        drawn = []
        for state, rows in (("lb01!", 6), ("lb02!", 5)):
            g = self.kept[state]
            drawn += [g.vram[0][0x1800 + (1 + 2 * r) * 32 + 7] - 0xE0 for r in range(rows)]
        self.assertEqual(drawn, model)


    def test_the_priest_revives_a_dead_monster_for_25_gold(self):
        """With MON_STATUS bit 7 set and MON_HP 0, Revive lists the monster, takes 25 gold, and leaves MON_STATUS 0 and
        MON_HP = MON_MAX_HP."""
        dead, alive = self.kept["pr03!"], self.kept["pr05!"]
        self.assertEqual((dead.sram[0x55], dead.sram[0x5B]), (0x80, 0))
        self.assertEqual((alive.sram[0x55], alive.sram[0x5B]), (0, alive.sram[0x5D]))
        self.assertEqual(self.gold("pr03!") - self.gold("pr05!"), 25)
        self.assertIn(1, self.ran["pr04!"].get("PriestMenu_PayForService_SubtractArg1AmountFromGold", set()))


    def test_hibernation_moves_a_record_into_the_compact_records(self):
        """Hibernating Stera takes her full record out of the list (the others close up) and writes a compact record
        at sCompactRecords ($B356) whose bytes 3-7 are her name."""
        self.assertEqual(self.ran["hb01!"].get("HibernateMenu"), {1})
        stera = bytes([0x1C, 0x37, 0x28, 0x35, 0x24])
        before, after = self.kept["hb02!"].sram, self.kept["hb07!"].sram
        names = lambda sram: [bytes(sram[i * 0xA5 + 1:i * 0xA5 + 6]) for i in range(30) if sram[i * 0xA5] in (1, 2)]
        self.assertIn(stera, names(before))
        self.assertNotIn(stera, names(after))
        self.assertEqual(len(names(after)), len(names(before)) - 1)
        self.assertEqual(bytes(after[0x1356 + 3:0x1356 + 8]), stera)

    def test_a_medal_prize_takes_its_price_in_tiny_medals(self):
        """The prize menu showed 'Medal: 80' for wTinyMedalsLo/Hi = 80; MeteOrb (3 medals) leaves 77 and goes into the
        free bag slot as item $1E (String_08_05_1E is MeteOrb)."""
        self.assertEqual(self.ran["md11!"].get("MedalPrizeMenu"), {1})
        medals = lambda gb: gb.rb(0xC838) | gb.rb(0xC839) << 8
        self.assertEqual((medals(self.kept["t02!"]), medals(self.kept["md11!"])), (80, 77))
        self.assertEqual(self.kept["md11!"].rb(0xC61D + 23), 0x1E)


    def test_appraising_a_magic_key_reveals_its_name(self):
        """A generated key enters wKeyList as $FE, then two name-word numbers; appraisal (140 gold here) sets the first
        byte to 0 and names the key 'WhiteMtn': word (byte 1 + 1) and word (byte 2 + $11) of the list at 09:$4078."""
        import gb_text
        new, done = self.kept["ky01!"], self.kept["ky06!"]
        entry = [new.rb(0xC707 + i) for i in range(4)]
        self.assertEqual(entry[0], 0xFE)
        self.assertEqual([done.rb(0xC707 + i) for i in range(4)], [0] + entry[1:])
        self.assertEqual(self.gold("ky01!") - self.gold("ky06!"), 140)
        rom = ROM.read_bytes()
        o = 9 * 0x4000 + 0x4078 - 0x4000

        def word(n):
            q = 9 * 0x4000 + (rom[o + 2 * n] | rom[o + 2 * n + 1] << 8) - 0x4000
            return "".join(gb_text.BYTE_TO_TEXT[c] for c in rom[q:rom.index(0xF0, q)])
        self.assertEqual(word(entry[1] + 1) + word(entry[2] + 0x11), "WhiteMtn")
        self.assertIn(1, self.ran["ky06!"].get("WriteKeyNameToDE", set()))


if __name__ == "__main__":
    unittest.main()
