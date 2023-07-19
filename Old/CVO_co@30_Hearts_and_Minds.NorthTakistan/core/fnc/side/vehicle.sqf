
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_vehicle

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_vehicle"] spawn btc_side_fnc_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

private _useful = values btc_city_all select {
    !((_x getVariable ["type", ""]) in ["NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _city = selectRandom _useful;

private _pos = [getPos _city, 100] call btc_fnc_randomize_pos;
private _roads = _pos nearRoads 300;
if (_roads isNotEqualTo []) then {_pos = getPos (selectRandom _roads);};

private _veh_type = selectRandom btc_civ_type_veh;
private _veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];
(_veh call ace_repair_fnc_getWheelHitPointsWithSelections) params ["_wheelHitPoints", "_wheelHitPointSelections"];
_veh setDir (random 360);
_veh setDamage 0.7;
private _damagedWheel = 1 + round random (count _wheelHitPointSelections - 1);
_wheelHitPointSelections = (_wheelHitPointSelections call BIS_fnc_arrayShuffle) select [0, _damagedWheel];
{
    _veh setHit [_x, 1];
} forEach _wheelHitPointSelections;

[_taskID, 5, _veh, [_city getVariable "name", _veh_type]] call btc_task_fnc_create;

waitUntil {sleep 5;
    _taskID call BIS_fnc_taskCompleted ||
    ({_x} count (_wheelHitPointSelections apply {_veh getHit _x < 1})) isEqualTo _damagedWheel ||
    !alive _veh
};

[[], [_veh]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};
if (!alive _veh) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
};

(- btc_rep_malus_wheelChange * _damagedWheel) call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
