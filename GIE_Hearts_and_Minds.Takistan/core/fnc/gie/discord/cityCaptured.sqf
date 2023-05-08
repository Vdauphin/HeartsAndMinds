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

private _activityHashMap = createHashMap;
private _activityFieldHashMap = createHashMap;

_activityFieldHashMap set ["title", "Ville capturée"];
_activityFieldHashMap set ["content", format [
    "La ville de %1 a été capturée par %2", 
    _city getVariable "name",
    [getText(configFile >> "CfgFactionClasses" >> btc_enemy_faction >> "displayName"), "l'US Army"] select (_city getVariable "occupied")
]];
_activityFieldHashMap set ["inline", true];

_activityHashMap set ["contents", [_activityFieldHashMap]];

["gie_activity", _activityHashMap] call CBA_fnc_serverEvent;
