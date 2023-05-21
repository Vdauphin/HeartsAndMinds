
/* ----------------------------------------------------------------------------
Function: btc_data_fnc_get_group

Description:
    Get groups parameters (position, waypoints, behaviour ...), save them and delete.

Parameters:
    _group - Group of units. [Group]

Returns:

Examples:
    (begin example)
        _result = [] call btc_data_fnc_get_group;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]]
];

private _units = (units _group) select {alive _x};
if (_units isEqualTo []) exitWith {nil};
private _leader = leader _group;
private _vehicle = vehicle _leader;

private _type_db = 0;
private _array_pos = [];
private _array_type = [];
private _side = side _group;
private _array_dam = [];
private _array_in_veh = [];
private _array_veh = [];
private _index_wp = currentWaypoint _group;
private _array_wp = (waypoints _group) apply {[
    waypointPosition _x,
    waypointType _x,
    waypointSpeed _x,
    waypointFormation _x,
    waypointCombatMode _x,
    waypointBehaviour _x,
    waypointTimeout _x,
    waypointCompletionRadius _x
]};

{
    private _pos = getPosATL _x;
    if (surfaceIsWater _pos) then {
        _array_pos pushBack getPos _x;
    } else {
        _array_pos pushBack _pos;
    };

    _array_type pushBack typeOf _x;
    _array_dam pushBack getDammage _x;
} forEach _units;

if (_group getVariable ["btc_inHouse", ""] isNotEqualTo "") then {
    _type_db = 3;
    _array_veh = _group getVariable ["btc_inHouse", ""];
};
if (_group getVariable ["getWeapons", false]) then {_type_db = 4;};
if (_group getVariable ["suicider", false]) then {_type_db = 5;};
if (_group getVariable ["btc_data_inhouse", []] isNotEqualTo []) then {
    _type_db = 6;
    _array_veh = _group getVariable ["btc_data_inhouse", []];
};
if (_group getVariable ["btc_ied_drone", false]) then {_type_db = 7;};
if (
    _vehicle != _leader &&
    {_type_db isNotEqualTo 7}
) then {
    _type_db = 1;
    _array_veh = [typeOf _vehicle, getPosATL _vehicle, getDir _vehicle, fuel _vehicle, vectorUp _vehicle];
};

[_vehicle, _group] call CBA_fnc_deleteEntity;

[_type_db, _array_pos, _array_type, _side, _array_dam, [], [_index_wp, _array_wp], _array_veh]
