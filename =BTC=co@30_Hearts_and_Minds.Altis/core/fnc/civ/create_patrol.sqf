
/* ----------------------------------------------------------------------------
Function: btc_fnc_civ_create_patrol

Description:
    Create a civilian patrol around a city in a defined area.

Parameters:
    _active_city - City where the patrol will be done around. [Object]
    _area - Area to search a start and an end city for the patrol [Number]

Returns:
    _isCreated - return true if the patrol is created. [Boolean]

Examples:
    (begin example)
        _isCreated = [_active_city] call btc_fnc_civ_create_patrol;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_active_city", objNull, [objNull]],
    ["_area", btc_patrol_area, [0]],
    ["_p_chem", btc_p_chem, [false]]
];

if (isNil "btc_civilian_id") then {btc_civilian_id = -1;};

//Find a city
private _cities = btc_city_all inAreaArray [getPosWorld _active_city, _area, _area];
private _usefuls = _cities select {!(_x getVariable ["active", false])};
if (_usefuls isEqualTo []) exitWith {false};

private _start_city = selectRandom _usefuls;
private _pos = getPos _start_city;

private _pos_isWater = false;
private _veh_type = "";
private _safe_pos = [];
private _roads = _pos nearRoads 200;
_roads = _roads select {isOnRoad _x};
if (_roads isEqualTo []) then {
    _safe_pos = [_pos, 0, 500, 13, [0,1] select btc_p_sea, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
    _safe_pos = [_safe_pos select 0, _safe_pos select 1, 0];
    _pos_isWater = surfaceIsWater _safe_pos;
    if (_pos_isWater) then {
        _veh_type = selectRandom btc_civ_type_boats;
    } else {
        _veh_type = selectRandom btc_civ_type_veh;
    };
} else {
    _safe_pos = getPos (selectRandom _roads);
    _veh_type = selectRandom btc_civ_type_veh;
};

private _group = createGroup civilian;
btc_civ_veh_active pushBack _group;
_group setVariable ["no_cache", true];
_group setVariable ["btc_patrol_id", btc_civilian_id, btc_debug];
btc_civilian_id = btc_civilian_id - 1;

[_group, _veh_type, [selectRandom btc_civ_type_units], _safe_pos, {
    params ["_veh", "_group"];
    _veh setVariable ["btc_crews", _group];
    [_veh, "HandleDamage", "btc_fnc_patrol_disabled"] call btc_fnc_eh_persistOnLocalityChange;
    [_veh, "Fuel", "btc_fnc_patrol_eh"] call btc_fnc_eh_persistOnLocalityChange;
    [_veh, "GetOut", "btc_fnc_patrol_eh"] call btc_fnc_eh_persistOnLocalityChange;
    [_veh, "HandleDamage", "btc_fnc_rep_hd"] call btc_fnc_eh_persistOnLocalityChange;
}] call btc_fnc_delay_createVehicle;

[{
    _this call btc_fnc_patrol_init;
    [[_this select 0]] call btc_fnc_set_groupsOwner;
}, [_group, [_start_city, _active_city], _area, _pos_isWater], btc_delay_createUnit] call CBA_fnc_waitAndExecute;

true
