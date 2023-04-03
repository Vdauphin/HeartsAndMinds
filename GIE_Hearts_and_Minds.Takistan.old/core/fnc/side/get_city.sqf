
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_get_city

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_side_fnc_get_city;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = values btc_city_all select {
    _x getVariable ["occupied", false] &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _city = selectRandom _useful;

[_taskID, 6, _city, _city getVariable "name"] call btc_task_fnc_create;

_city setVariable ["spawn_more", true];

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    !(_city getVariable ["occupied", false])
};

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
