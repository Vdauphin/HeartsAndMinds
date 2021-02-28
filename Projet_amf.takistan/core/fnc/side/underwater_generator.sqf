
/* ----------------------------------------------------------------------------
Function: btc_fnc_side_underwater_generator

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_fnc_side_underwater_generator;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose a Marine location occupied \\\\
private _useful = btc_city_all select {!(isNull _x) && (_x getVariable ["occupied", false]) && (_x getVariable ["type", ""] isEqualTo "NameMarine")};
if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};

private _city = selectRandom _useful;

//// Choose a random position \\\\
private _objects = nearestObjects [getPos _city, [], 200];

_objects = _objects select {!((str (_x) find "wreck") isEqualTo -1) || !((str (_x) find "broken") isEqualTo -1) || !((str (_x) find "rock") isEqualTo -1)};
_objects = _objects select {(getPos _x select 2 < -3) && (((str (_x) find "car") isEqualTo -1) || ((str (_x) find "uaz") isEqualTo -1))};
private _wrecks = _objects select {(str (_x) find "rock") isEqualTo -1};

private _pos = [];
if (_wrecks isEqualTo []) then {
    if (_objects isEqualTo []) then {
        ([getPos _city, 0, 100, 13, 2, 60 * (pi / 180), 0] call BIS_fnc_findSafePos) params ["_x", "_y"];
        _pos = [_x, _y, getTerrainHeightASL [_x, _y]];
    } else {
        _pos = getPos (selectRandom _objects);
    };
} else {
    _pos = getPos (selectRandom _wrecks);
};

_city setVariable ["spawn_more", true];

//// Create underwater generator \\\\
private _generator = (selectRandom btc_type_generator) createVehicle _pos;
_pos params ["_x", "_y", "_z"];
private _storagebladder = (selectRandom btc_type_storagebladder) createVehicle [_x + 5, _y, _z];

[_taskID, 11, _generator, [_city getVariable "name", typeOf _generator]] call btc_fnc_task_create;

private _group = [_pos, 8, 1 + round random 5,0.8] call btc_fnc_mil_create_group;
[_pos, 20, 2 + round random 4, 0.5] call btc_fnc_mil_create_group;

_pos = getPosASL _generator;
(leader (_group select 0)) setPosASL [_x, _y, _z + 1 + random 1];

waitUntil {sleep 5; (_taskID call BIS_fnc_taskCompleted || !alive _generator)};

[[], [_generator, _storagebladder]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

80 call btc_fnc_rep_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
