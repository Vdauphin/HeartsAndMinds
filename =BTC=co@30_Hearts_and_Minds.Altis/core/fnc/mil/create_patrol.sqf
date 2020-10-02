
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_create_patrol

Description:
    Fill me when you edit me !

Parameters:
    _random - [Number]
    _active_city - [Object]
    _area - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_mil_create_patrol;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_random", 0, [0]],
    ["_active_city", objNull, [objNull]],
    ["_area", btc_patrol_area, [0]]
];

if (isNil "btc_military_id") then {btc_military_id = 1;};

if (_random isEqualTo 0) then {
    _random = selectRandom [1, 2];
};

if (btc_debug_log) then {
    [format ["_random = %1 _active_city %2 _area %3 btc_patrol_active = %4", _random, _active_city, _area, count btc_patrol_active], __FILE__, [false]] call btc_fnc_debug_message;
};

sleep 5 + random 10;

//Remove if too far from player
if ([_active_city, grpNull, _area] call btc_fnc_patrol_playersInAreaCityGroup) exitWith {false};

//Find a city
private _cities = btc_city_all inAreaArray [getPosWorld _active_city, _area, _area];
private _usefuls = _cities select {!(_x getVariable ["active", false]) && _x getVariable ["occupied", false]};
if (_usefuls isEqualTo []) exitWith {false};

//Randomize position if city has a beach, so position could be in water
private _start_city = selectRandom _usefuls;
private _pos = [];
if (_start_city getVariable ["hasbeach", false]) then {
    _pos = [getPos _start_city, (_start_city getVariable ["RadiusX", 0]) + (_start_city getVariable ["RadiusY", 0]), btc_p_sea] call btc_fnc_randomize_pos;
} else {
    _pos = getPos _start_city;
};
private _pos_isWater = surfaceIsWater _pos;
if (_pos_isWater) then {
    _pos = [_pos select 0, _pos select 1, 0];
    _random = 2;
};

//Creating units
private _group = createGroup [btc_enemy_side, true];
btc_patrol_active pushBack _group;
_group setVariable ["no_cache", true];
_group setVariable ["btc_patrol_id", btc_military_id, btc_debug];
btc_military_id = btc_military_id + 1;

switch (_random) do {
    case 1 : {
        private _n_units = 5 + (round random 8);
        _pos = [_pos, 0, 50, 10, false] call btc_fnc_findsafepos;

        [_group, _pos, _n_units] call btc_fnc_mil_createUnits;
    };
    case 2 : {
        private _veh_type = "";
        if (_pos_isWater) then {
            _veh_type = selectRandom btc_type_boats;
        } else {
            _veh_type = selectRandom (btc_type_motorized + [selectRandom btc_type_motorized_armed]);
            //Tweak position of spawn
            private _roads = _pos nearRoads 150;
            _roads = _roads select {isOnRoad _x};
            if (_roads isEqualTo []) then {
                _pos = [_pos, 0, 500, 13, false] call btc_fnc_findsafepos;
            } else {
                _pos = getPos selectRandom _roads;
            };
        };
        private _veh = [_group, _pos, _veh_type] call btc_fnc_mil_createVehicle;
        _veh setVariable ["btc_crews", _group];

        [_veh, "Fuel", "btc_fnc_patrol_eh"] call btc_fnc_eh_persistOnLocalityChange;
    };
};

[_group, [_start_city, _active_city], _area, _pos_isWater] call btc_fnc_patrol_init;

[[_group]] call btc_fnc_set_groupsOwner;

true
