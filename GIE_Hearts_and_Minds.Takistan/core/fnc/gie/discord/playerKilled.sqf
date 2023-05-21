/* ----------------------------------------------------------------------------
Function: gie_discord_activity_fnc_playerKilled

Description:
    Event triggered when a player is killed
	Used to send notification to Discord

Parameters:
    _unit - Unit that was killed. [Object]
	_instigator - Who killed _unit [Object] 


Returns:

Examples:
    (begin example)
        [player, player] call gie_discord_activity_fnc_playerKilled; // Will show "suicide" message
    (end)
	
	(begin example)
		[player, objNull] call gie_discord_activity_fnc_playerKilled; // Will show "killed" message
	(end)
Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params ["_unit", "_instigator"];

private _tickets = [btc_player_side, 0] call BIS_fnc_respawnTickets;

private _activityHashMap = createHashMap;
private _activityFieldHashMap = createHashMap;
private _remainingSoldiersHashMap = createHashMap;
private _location = if ((getPos _unit) inArea safeZone) then {
	"dans la base";
} else {
	private _nearestLocation = nearestLocations [ 
		(getPos _unit),  
		["NameVillage", "NameCity", "NameCityCapital", "NameLocal", "Hill", "Airport", "StrongpointArea", "BorderCrossing", "VegetationFir", "NameMarine"],  
		worldSize/2,
		(getPos _unit)
	]#0;
	format ["près de %1", getText(configfile >> "cfgworlds" >> worldname >> "names" >> className _nearestLocation >> "name")];
};
_activityFieldHashMap set ["title", "Un soldat a été tué"];
_activityFieldHashMap set ["content", format [
	"Le soldat %1 %2 %3", 
	name _unit, 
	["a été tué", "s'est suicidé"] select (_unit == _instigator),
	_location
]];
_activityFieldHashMap set ["inline", true];

_remainingSoldiersHashMap set ["title", "Soldats restants"];
_remainingSoldiersHashMap set ["content", format [
	"Les forces alliées comptent %1 soldats restants", 
	_tickets
]];
_remainingSoldiersHashMap set ["inline", true];

_activityHashMap set ["contents", [_activityFieldHashMap, _remainingSoldiersHashMap]];

[{
	["gie_activity", _this] call CBA_fnc_serverEvent;
}, [_activityHashMap], (random 5) * 60] call CBA_fnc_waitAndExecute;
