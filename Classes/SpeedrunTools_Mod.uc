class SpeedrunTools_Mod extends GameMod
	config(Mods);
	
var config int reset_level_collectibles;
var config int reset_level_flags;
var config int reset_time_rift_portals;
var config int reset_contractual_obligations;
var config int reset_alpine_intro;
var config int block_in_spaceship;

function ResetTimeRiftPortals() {
	if (Hat_GameManager(WorldInfo.Game).GetCurrentMapFilename() == "hub_spaceship")
		class'SpeedrunTools_CheatManager'.static.SetTimePieceCompletion(true, "TimeRift");
	else
		class'SpeedrunTools_CheatManager'.static.SetTimePieceCompletion(false, "TimeRift");
}

event OnModLoaded() {
	if (reset_time_rift_portals == 0)
		ResetTimeRiftPortals();

	HookActorSpawn(class'Hat_Player', 'Hat_Player');
	SetManager();
}

event OnModUnloaded() {
	Hat_PlayerController(GetALocalPlayerController()).CheatClass = class'Hat_CheatManager';
}

event OnHookedActorSpawn(Object NewActor, Name Identifier) {
  if(Identifier == 'Hat_Player') SetManager();
}

function SetManager() {
	Hat_PlayerController(GetALocalPlayerController()).CheatClass = class'SpeedrunTools_CheatManager';
}