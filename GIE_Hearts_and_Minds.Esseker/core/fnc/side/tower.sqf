
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_tower

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        ["btc_9999"] spawn btc_side_fnc_tower;
    (end)

Author:
    Vdauphin

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
private _pos = [getPos _city, 100] call btc_fnc_randomize_pos;
private _roads = _pos nearRoads 100;
_roads = _roads select {isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _road = selectRandom _roads;
_pos = getPos _road;

private _direction = [_road] call btc_fnc_road_direction;

_city setVariable ["spawn_more", true];

//// Randomise composition \\\\
private _tower_type = selectRandom btc_type_tower;
private _power_type = selectRandom btc_type_power;
private _cord_type = selectRandom btc_type_cord;
private _btc_composition_tower = [
    [_tower_type,0,[0,0,0]],
    [_cord_type,63,[-1.30664,0.939453,0]],
    [_power_type,24,[-4.56885,-0.231445,0]]
];

//// Create tower with static at _pos \\\\
private _statics = btc_type_gl + btc_type_mg;
[_pos getPos [5, _direction], _statics, _direction, [], _city] call btc_mil_fnc_create_static;
[_pos getPos [- 5, _direction], _statics, _direction + 180, [], _city] call btc_mil_fnc_create_static;

private _btc_composition = [_pos, _direction, _btc_composition_tower] call btc_fnc_create_composition;
private _tower = _btc_composition select ((_btc_composition apply {typeOf _x}) find _tower_type);

[_taskID, 7, _tower, [_city getVariable "name", _tower_type]] call btc_task_fnc_create;

waitUntil {sleep 5;
    !alive _tower ||
    _taskID call BIS_fnc_taskCompleted
};

[[], _btc_composition] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
