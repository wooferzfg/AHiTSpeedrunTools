class SpeedrunTools_CheatManager extends Hat_CheatManager;

function RemoveFlag(String id, String mapName) {
	local int k;
	local int i;
	local Array<GenericSaveBit> a;
	k = `SaveManager.GetCurrentSaveData().GetLevelSaveInfoIndex(mapName);
	a = `SaveManager.GetCurrentSaveData().LevelSaveInfo[k].LevelBits;
	for (i = 0; i < a.Length; i++) {
		if (InStr(a[i].Id, id) >= 0) {
			`SaveManager.GetCurrentSaveData().LevelSaveInfo[k].LevelBits.RemoveItem(a[i]);
		}
	}
}

function RemoveMultipleFlags(Array<string> ids, Array<string> maps) {
	local int i;
	local int j;
	for (i = 0; i < maps.Length; i++) {
		for (j = 0; j < ids.Length; j++) {
			RemoveFlag(ids[j], maps[i]);
		}
	}
}

function ResetContract(class<Hat_SnatcherContract_Act> contractClass) {
	local Hat_SaveGame save;
	save = `SaveManager.GetCurrentSaveData();
	save.SnatcherContracts.AddItem(contractClass);
	save.TurnedInSnatcherContracts.RemoveItem(contractClass);
}

function ClearAllContracts() {
	local Hat_SaveGame save;
	save = `SaveManager.GetCurrentSaveData();
	save.SnatcherContracts.Length = 0;
	save.TurnedInSnatcherContracts.Length = 0;
	save.CompletedSnatcherContracts.Length = 0;
}

function TurnInTwoContracts() {
	local Hat_SaveGame save;
	save = `SaveManager.GetCurrentSaveData();
	save.TurnedInSnatcherContracts.AddItem(class'Hat_SnatcherContract_IceWall');
	save.TurnedInSnatcherContracts.AddItem(class'Hat_SnatcherContract_MailDelivery');
}

function Array<string> GetMapsForChapterAndAct(string chapterName, int actNumber) {
	local Array<string> maps;
	maps.Length = 0;
	
	if (chapterName == "Chapter1_MafiaTown") {
		maps.AddItem("mafia_town");
		if (actNumber == 4)
			maps.AddItem("mafia_hq");
	}
	else if (chapterName == "Chapter2_Subcon") {
		maps.AddItem("subconforest");
		if (actNumber == 2)
			maps.AddItem("subcon_cave");
		else if (actNumber == 4)
			maps.AddItem("vanessa_manor");
	}
	else if (chapterName == "Chapter3_Trainwreck") {
		if (actNumber == 1)
			maps.AddItem("deadbirdstudio");
		else if (actNumber == 2)
			maps.AddItem("chapter3_murder");
		else if (actNumber == 3 || actNumber == 5)
			maps.AddItem("themoon");
		else if (actNumber == 4)
			maps.AddItem("trainwreck_selfdestruct");
		else if (actNumber == 6) {
			maps.AddItem("deadbirdstudio");
			maps.AddItem("deadbirdbasement");
			maps.AddItem("djgrooves_boss");
		}
	}
	else if (chapterName == "Chapter4_Sand") {
		maps.AddItem("alpsandsails");
	}
	else if (chapterName == "Chapter5_Finale") {
		maps.AddItem("castle_mu");
	}
	
	return maps;
}

function ResetCollectibles() {
	local string chapterName;
	local int actNumber;
	local Array<string> ids;
	local Array<string> maps;
	
	chapterName = Hat_GameManager(WorldInfo.Game).GetChapterInfo().ChapterName;
	actNumber = Hat_GameManager(WorldInfo.Game).GetCurrentAct();
	maps = GetMapsForChapterAndAct(chapterName, actNumber);
	
	ids.AddItem("hat_collectible_badgepart");
	ids.AddItem("hat_collectible_decoration_mostsuitable");
	ids.AddItem("hat_collectible_roulettetoken");
	ids.AddItem("hat_treasurechest");
	ids.AddItem("hat_impactinteract_breakable_chemical_crate");
	ids.AddItem("hat_goodie_vault");
	ids.AddItem("hat_eyeblockade");
		
	RemoveMultipleFlags(ids, maps);
}

function ResetLevelFlags() {
	local string chapterName;
	local int actNumber;
	local Array<string> ids;
	local Array<string> maps;
	
	chapterName = Hat_GameManager(WorldInfo.Game).GetChapterInfo().ChapterName;
	actNumber = Hat_GameManager(WorldInfo.Game).GetCurrentAct();
	maps = GetMapsForChapterAndAct(chapterName, actNumber);
	ids.Length = 0;
	
	if (chapterName == "Chapter1_MafiaTown") {
		if (actNumber == 4)
			ids.AddItem("mafia_hq_intro_cinematic");
	}
	else if (chapterName == "Chapter2_Subcon") {
		ids.AddItem("hat_subconpainting_green");
		ids.AddItem("hat_bonfire_green");
		ids.AddItem("hat_snatchercontractsummon");
		ids.AddItem("hat_snatchercontract_icewall");
		ids.AddItem("hat_snatchercontract_toilet");
		ids.AddItem("hat_snatchercontract_vanessa");
		ids.AddItem("hat_snatchercontract_maildelivery");

		ClearAllContracts();
		TurnInTwoContracts();

		if (actNumber == 1) {
			ResetContract(class'Hat_SnatcherContract_IceWall');
		}
		else if (actNumber == 2) {
			ResetContract(class'Hat_SnatcherContract_IceWall');
			ids.AddItem("hat_subconpainting_blue");
			ids.AddItem("hat_bonfire_blue");
		}
		else if (actNumber == 3) {
			ResetContract(class'Hat_SnatcherContract_Toilet');
		}
		else if (actNumber == 4) {
			ResetContract(class'Hat_SnatcherContract_Vanessa');
		}
		else if (actNumber == 5) {
			ResetContract(class'Hat_SnatcherContract_MailDelivery');
		}
	}
	else if (chapterName == "Chapter4_Sand") {
		if (actNumber == 1)
			ids.AddItem("hat_sandstationhorn");
	}
		
	RemoveMultipleFlags(ids, maps);
}

function ResetContractualObligations() {
	local string chapterName;
	local int actNumber;
	local Array<string> ids;
	local Array<string> maps;
	
	chapterName = Hat_GameManager(WorldInfo.Game).GetChapterInfo().ChapterName;
	actNumber = Hat_GameManager(WorldInfo.Game).GetCurrentAct();
	
	if (chapterName == "Chapter2_Subcon" && actNumber == 1) {
		maps = GetMapsForChapterAndAct(chapterName, actNumber);
		
		ClearAllContracts();

		ids.AddItem("contract_unlock_actid");
		ids.AddItem("hat_bonfire_yellow");
		ids.AddItem("hat_subconpainting_yellow");
			
		RemoveMultipleFlags(ids, maps);
	}
}

function ResetAlpineIntro() {
	local string chapterName;
	local int actNumber;
	local Array<string> ids;
	local Array<string> maps;
	
	chapterName = Hat_GameManager(WorldInfo.Game).GetChapterInfo().ChapterName;
	actNumber = Hat_GameManager(WorldInfo.Game).GetCurrentAct();
	
	if (chapterName == "Chapter4_Sand" && actNumber == 1) {
		maps = GetMapsForChapterAndAct(chapterName, actNumber);
		
		ids.AddItem("actless_freeroam_intro_complete");
			
		RemoveMultipleFlags(ids, maps);
	}
}

exec function RestartIL() {
	local string level;
	local Hat_ChapterInfo chapter;
	local int act;
	local string chapterOverride;
	local string actOverride;
	local Texture2D textureOverride;
	local int chapterIdOverride;

	if (class'GameMod'.static.GetConfigValue(class'SpeedrunTools_Mod', 'reset_level_collectibles') == 0)
		ResetCollectibles();
	if (class'GameMod'.static.GetConfigValue(class'SpeedrunTools_Mod', 'reset_level_flags') == 0)
		ResetLevelFlags();
	if (class'GameMod'.static.GetConfigValue(class'SpeedrunTools_Mod', 'reset_contractual_obligations') == 0)
		ResetContractualObligations();
	if (class'GameMod'.static.GetConfigValue(class'SpeedrunTools_Mod', 'reset_alpine_intro') == 0)
		ResetAlpineIntro();

	level = Hat_GameManager(WorldInfo.Game).GetCurrentMapFilename();
	chapter = Hat_GameManager(WorldInfo.Game).GetChapterInfo();
	act = Hat_GameManager(WorldInfo.Game).GetCurrentAct();
	chapterIdOverride = INDEX_NONE;

	// we don't want it to work in hub or titlescreen or when the game is paused
	if(level == "hub_spaceship" || level == "titlescreen_final" || Hat_PlayerController(GetALocalPlayerController()).IsPaused()) return;

	// Override the act names, as they default to the first act name when it's a rift
	// also fix acts that load other maps mid-act
	switch(level) {
		// rifts and alps - names basically
		case "timerift_water_spaceship": actOverride = "The Gallery"; break;
		case "timerift_water_spaceship_mail": actOverride = "The Mailroom"; break;
		case "timerift_water_mafia_easy": actOverride = "Sewers"; break;
		case "timerift_water_mafia_hard": actOverride = "Bazaar"; break;
		case "timerift_cave_mafia": actOverride = "Mafia of Cooks"; break;
		case "timerift_water_twreck_panels": actOverride = "The Owl Express"; break;
		case "timerift_water_twreck_parade": actOverride = "The Moon"; break;
		case "timerift_cave_deadbird": actOverride = "Dead Bird Studio"; break;
		case "timerift_water_subcon_hookshot": actOverride = "Pipe"; break;
		case "timerift_water_subcon_dwellers": actOverride = "Village"; break;
		case "timerift_cave_raccoon": actOverride = "Sleepy Subcon"; break;
		case "timerift_water_alp_goats": actOverride = "Twilight Bell"; break;
		case "timerift_water_alp_cats": actOverride = "Curly Tail Trail"; break;
		case "timerift_cave_alps": actOverride = "Alpine Skyline"; break;
		case "alps_dungeon_birdhouse": actOverride = "The Birdhouse"; break;
		case "alps_dungeon_twilight": actOverride = "The Twilight Bell"; break;
		case "alps_dungeon_windmill": actOverride = "The Windmill"; break;
		case "island_weddingcake": actOverride = "The Lava Cake"; break;
		// main acts that change map mid-act (and yes I could do this more efficient but it looks nicer like this)
		case "mafia_hq": level = "mafia_town_night"; break;
		case "djgrooves_boss": level = "deadbirdstudio"; break;
		case "deadbirdbasement": level = "deadbirdstudio"; break;
		case "subcon_cave": level = "subconforest"; break;
		case "vanessa_manor": level = "subconforest"; break;
		default: actOverride = ""; break;
	}

	if(actOverride != "") {
		act = 99;
		chapterOverride = "TIME RIFT";
		chapterIdOverride = -2;

		// if the level name starts with timerift_cave_ (0 because that's the index of the string)
		if(InStr(level, "timerift_cave_") == 0) {
			textureOverride = Texture2D'HatinTime_Titlecards_Misc.Textures.TimeRift_Cave';
		}
		// same as above, but timerift_water_
		else if(InStr(level, "timerift_water_") == 0) {
			textureOverride = Texture2D'HatinTime_Titlecards_Misc.Textures.TimeRift_Water';
		}
	}
		
	class'Hat_SeqAct_ChangeScene_Act'.static.DoTransitionStatic(level, chapter, act, textureOverride, chapterOverride, actOverride, chapterIdOverride);
	class'Hat_GlobalTimer'.static.RestartActTimer();
}