/* ----------------------------------------------------------------------------
Function: gie_discord_activity_fnc_cityCaptured

Description:
    Event triggered when a city is cleared
	Used to send notification to Discord

Parameters:
    _city - City that was cleared. [Object]

Returns:

Examples:
    (begin example)
        [btc_city_all select 0] call gie_discord_activity_fnc_cityCaptured;
    (end)
Author:
    Gavin "Morbakos" Sertix

---------------------------------------------------------------------------- */

params ["_city", objNull, [objNull]];

if (time <= 20) exitWith {}; // prevent spam on mission load

[format ["%1: %2 %3", (_city getVariable "id"), (_city getVariable "name"), (_city getVariable "occupied")], __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;

private _activityHashMap = createHashMap;
private _activityFieldHashMap = createHashMap;

private _formatCityPos = {
    private _pos = mapGridPosition (getPos _city);
    format ["%1-%2", _pos select [0,3], _pos select [3, 6]];
};

_activityFieldHashMap set ["title", "Ville capturée"];
_activityFieldHashMap set ["content", format [
    "%1 a été capturée par %2", 
    [
        format ["La ville de %1 (%2)", _city getVariable "name", call _formatCityPos],
        format ["Le point %1", call _formatCityPos]
    ] select ((_city getVariable ["name", ""]) != ""),
    [
        "l'US Army",
        getText(configFile >> "CfgFactionClasses" >> btc_enemy_faction >> "displayName")
    ] select (_city getVariable "occupied")
]];
_activityFieldHashMap set ["inline", true];

_activityHashMap set ["contents", [_activityFieldHashMap]];

["gie_activity", _activityHashMap] call CBA_fnc_serverEvent;
