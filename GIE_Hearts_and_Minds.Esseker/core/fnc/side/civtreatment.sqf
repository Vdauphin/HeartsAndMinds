
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_civtreatment

Description:
    Heal a civilian.

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_civtreatment"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose a clear City \\\\
private _useful = values btc_city_all select {
    !(_x getVariable ["occupied", false]) &&
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _city = selectRandom _useful;
private _pos = getPos _city;

//// Choose spawn in house or on road \\\\
private _r = random 2;
private _objects = [];
if ( _r < 1) then {
    private _roads = _pos nearRoads 200;
    _objects = _roads select {isOnRoad _x};
} else {
    _objects = ([[_pos select 0, _pos select 1, 0], 200] call btc_fnc_getHouses) select 0;
};

if (_objects isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};

//// Create civ on _pos \\\\
private _veh = objNull;
private _fx = objNull;
if (_r < 1) then {
    _pos = getPos (selectRandom _objects);
    private _vehPos = [_pos, 10] call btc_fnc_randomize_pos;

    private _veh_type = selectRandom btc_civ_type_veh;
    _veh = createVehicle [_veh_type, _vehPos, [], 0, "NONE"];
    _veh setDir (random 360);
    _veh setDamage 0.7;
    //// Random wheel hit \\\\
    if (_r < 0.5) then {
        _veh setHit ["wheel_1_2_steering", 1];
    } else {
        _veh setHit ["wheel_2_1_steering", 1];
    };
    _veh setHit ["wheel_1_1_steering", 1];
    //// Add smoke effect on car \\\\
    _fx = "test_EmptyObjectForSmoke" createVehicle (getPosATL _veh);
    _fx attachTo [_veh, [0, 0, 0]];
};

private _unit_type = selectRandom btc_civ_type_units;
private _group = createGroup civilian;
_group setVariable ["no_cache", true];
_group setVariable ["acex_headless_blacklist", true];
private _unit =_group createUnit [_unit_type, _pos, [], 0, "CAN_COLLIDE"];
_unit setBehaviour "CARELESS";
_unit setDir (random 360);
_unit setUnitPos "DOWN";

[_taskID, 8, _unit, [_city getVariable "name", _unit_type]] call btc_task_fnc_create;

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

[[], [_veh, _fx, _group]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};
if !(alive _unit) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
};

10 call btc_rep_fnc_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

_unit setUnitPos "UP";
