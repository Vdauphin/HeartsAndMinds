
/* ----------------------------------------------------------------------------
Function: btc_fnc_side_civtreatment

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [] spawn btc_fnc_side_civtreatment;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose a clear City \\\\
private _useful = btc_city_all select {!(isNull _x) && !(_x getVariable ["occupied", false]) && !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine"])};
if (_useful isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
private _city = selectRandom _useful;
private _pos = getPos _city;

//// Choose spawn in house or on road \\\\
private _r = random 2;
private _vehpos = [];
if ( _r < 1)    then {
    private _roads = _pos nearRoads 200;
    _roads = _roads select {isOnRoad _x};
    if (_roads isEqualTo []) exitWith {[] spawn btc_fnc_side_create;};
    _pos = getPos (selectRandom _roads);
    _vehpos = [_pos, 10] call btc_fnc_randomize_pos;
} else {
    _houses = [[_pos select 0, _pos select 1, 0], 200] call btc_fnc_getHouses;
    _pos = selectRandom ((selectRandom _houses) buildingPos -1);
    _vehpos = [_pos select 0, _pos select 1, (_pos select 2) + 0.1];
};

//// Create civ on _pos \\\\
private _veh = objNull;
private _fx = objNull;
if (_r < 1) then {
    private _veh_type = selectRandom btc_civ_type_veh;
    _veh = createVehicle [_veh_type, _vehpos, [], 0, "NONE"];
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
} else {
    _phone_type = selectRandom btc_type_phone;
    _veh = createVehicle [_phone_type, _vehpos, [], 0, "NONE"];
    _veh setDir (random 360);
    _fx = objNull;
};

private _unit_type = selectRandom btc_civ_type_units;
private _group = createGroup civilian;
_group setVariable ["no_cache", true];
private _unit =_group createUnit [_unit_type, _pos, [], 0, "CAN_COLLIDE"];
_unit setBehaviour "CARELESS";
_unit setDir (random 360);
_unit setUnitPos "DOWN";

[_taskID, 8, _unit, [_city getVariable "name", _unit_type]] call btc_fnc_task_create;

sleep 1;

waitUntil {sleep 5; (_taskID call BIS_fnc_taskCompleted || !(playableUnits inAreaArray [getPosWorld _unit, 5000, 5000] isEqualTo []))};

[_unit] call btc_fnc_set_damage;

waitUntil {sleep 5; (_taskID call BIS_fnc_taskCompleted || !alive _unit || {_unit call ace_medical_status_fnc_isInStableCondition && [_unit] call ace_common_fnc_isAwake})};

[[], [_veh, _fx, _group]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};
if !(alive _unit) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
};

10 call btc_fnc_rep_change;

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

_unit setUnitPos "UP";
