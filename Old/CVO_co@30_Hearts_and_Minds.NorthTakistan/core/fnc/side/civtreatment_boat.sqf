
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_civtreatment_boat

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_side_fnc_civtreatment_boat;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose a Marine location \\\\
private _useful = values btc_city_all select {
    _x getVariable ["type", ""] isEqualTo "NameMarine" ||
    _x getVariable ["hasbeach", false]
};

if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

private _city = selectRandom _useful;
private _pos = getPos _city;

//// Choose a random position \\\\
private _vehpos = [_pos, 0, 600, 20, 2, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
_vehpos = [_vehpos select 0, _vehpos select 1, 0];

//// Create civ on _vehpos \\\\
private _veh_type = selectRandom btc_civ_type_boats;
private _veh = createVehicle [_veh_type, _vehpos, [], 0, "NONE"];
_veh setDir (random 360);
_veh setPos _vehpos;

private _unit_type = selectRandom btc_civ_type_units;
private _group = createGroup civilian;
_group setVariable ["no_cache", true];
_group setVariable ["acex_headless_blacklist", true];
private _unit = _group createUnit [_unit_type, _pos, [], 0, "NONE"];
private _index = 1 + floor (random (_veh emptyPositions "cargo"));
_unit assignAsCargoIndex [_veh, _index];
_unit moveinCargo [_veh, _index];

[_taskID, 10, _unit, [_city getVariable "name", _veh_type]] call btc_task_fnc_create;

sleep 1;
waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    playableUnits inAreaArray [getPosWorld _unit, 5000, 5000] isNotEqualTo []
};

[_unit] call btc_fnc_set_damage;

waitUntil {sleep 5; 
    _taskID call BIS_fnc_taskCompleted ||
    !alive _unit ||
    {
        _unit call ace_medical_status_fnc_isInStableCondition &&
        [_unit] call ace_common_fnc_isAwake
    }
};

[[], [_veh, _group]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};
if !(alive _unit) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
};

10 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
