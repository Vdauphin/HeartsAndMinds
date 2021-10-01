
/* ----------------------------------------------------------------------------
Function: btc_fnc_side_get_city

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_fnc_side_get_city;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = btc_city_all select {!(isNull _x) && (_x getVariable ["occupied", false]) && !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine"])};
if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

private _city = selectRandom _useful;
private _pos = getPos _city;

[_taskID, 6, _pos, _city getVariable "name"] call btc_fnc_task_create;

_city setVariable ["spawn_more", true];

waitUntil {sleep 5; (_taskID call BIS_fnc_taskCompleted || !(_city getVariable ["occupied", false]))};

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_fnc_rep_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
