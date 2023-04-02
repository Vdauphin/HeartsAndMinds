/* ----------------------------------------------------------------------------
Function: gie_presence_fnc_evaluatePresenceContent

Description:
    Update discord presence

Parameters:
    None

Returns:

Examples:
    (begin example)
        [] call gie_presence_fnc_evaluatePresenceContent;
    (end)

Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

private _evaluateDetails = {
	format ["%1%2", briefingName, if (!isMultiplayer) then {" - test"} else {""}]
};

private _evaluateState = {
	private _res = if (player inArea safeZone) then {
		"Dans la base";
	} else {
		private _nearestLocation = nearestLocations [ 
			(getPos player),  
			["NameVillage", "NameCity", "NameCityCapital", "NameLocal", "Hill", "Airport", "StrongpointArea", "BorderCrossing", "VegetationFir", "NameMarine"],  
			worldSize/2,
			(getPos player)
		]#0;
		format ["En patrouille près de %1", getText(configfile >> "cfgworlds" >> worldname >> "names" >> className _nearestLocation >> "name")];
	};
	_res;
};

private _getRandomAsset = {
	private _asset = selectRandom (getMissionConfigValue ["richAssets", []]);
	_asset;
};

private _getPartySize = {
	private _count = (count (switchableUnits + playableUnits) - count entities "HeadlessClient_F");
	_count;
};

private _result = [
	["UpdateDetails",call _evaluateDetails],
	["UpdateState",call _evaluateState],
	["UpdateLargeImageKey",call _getRandomAsset],
	["UpdateLargeImageText","Hearts and Mind"],
	["UpdateSmallImageKey",call _getRandomAsset],
	["UpdateSmallImageText","G.I.E"],
	["UpdateButtons",["Discord","https://discord.com/invite/E5fMr3z3kF"]]
] call (missionNameSpace getVariable ["DiscordRichPresence_fnc_update",{}]);
true