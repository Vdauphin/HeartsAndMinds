
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_create_patrol

Description:
    Fill me when you edit me !

Parameters:
    _group - Group of the patrol. [Group]
    _random - [Number]
    _active_city - [Object]
    _area - [Number]

Returns:

Examples:
    (begin example)
        [2, (allPlayers#0), btc_patrol_area] call btc_fnc_mil_create_patrol;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
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

//Remove if too far from player
if ([_active_city, grpNull, _area] call btc_fnc_patrol_playersInAreaCityGroup) exitWith {
    _group call CBA_fnc_deleteEntity;
    false
};

//Find a city
private _cities = btc_city_all inAreaArray [getPosWorld _active_city, _area, _area];
private _usefuls = _cities select {!(_x getVariable ["active", false]) && _x getVariable ["occupied", false]};
if (_usefuls isEqualTo []) exitWith {
    _group call CBA_fnc_deleteEntity;
    false
};

//Randomize position if city has a beach, so position could be in water
private _start_city = selectRandom _usefuls;
private _pos = [];
if (_start_city getVariable ["hasbeach", false]) then {
    _pos = [getPos _start_city, _start_city getVariable ["radius", 100], btc_p_sea] call btc_fnc_randomize_pos;
} else {
    _pos = getPos _start_city;
};
private _pos_isWater = surfaceIsWater _pos;
if (_pos_isWater) then {
    _pos = [_pos select 0, _pos select 1, 0];
    _random = 2;
};

//Creating units
_group setVariable ["btc_patrol_id", btc_military_id, btc_debug];
btc_military_id = btc_military_id + 1;

private _delay = switch (_random) do {
    case 1 : {
        _pos = [_pos, 0, 150, 10, false] call btc_fnc_findsafepos;

        [_group, _pos, 5 + (round random 8)] call btc_fnc_mil_createUnits;
        0
    };
    case 2 : {
        private _veh_type = "";
        if (_pos_isWater) then {
            _veh_type = selectRandom btc_type_boats;
        } else {
            _veh_type = selectRandom (btc_type_motorized + [selectRandom btc_civ_type_veh]);
            //Tweak position of spawn
            private _roads = _pos nearRoads 150;
            _roads = _roads select {isOnRoad _x};
            if (_roads isEqualTo []) then {
                _pos = [_pos, 0, 500, 13, false] call btc_fnc_findsafepos;
            } else {
                _pos = getPos selectRandom _roads;
            };
        };
        [_group, _pos, _veh_type] call btc_fnc_mil_createVehicle
    };
};

[{
    _this call btc_fnc_patrol_init;
    [[_this select 0]] call btc_fnc_set_groupsOwner;
}, [_group, [_start_city, _active_city], _area, _pos_isWater], btc_delay_createUnit + _delay] call CBA_fnc_waitAndExecute;

true
