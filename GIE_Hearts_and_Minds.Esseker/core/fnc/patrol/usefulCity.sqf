
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_usefulCity

Description:
    Return useful city based on starting city and activated city by player. Prefer cities in the opposite side of the active city relatively to the starting city.

Parameters:
    _cities - Starting city and activated city by player. [Array]
    _area - Area of patroling. [Number]
    _isBoat - Does the vehicle is a boat. [Boolean]

Returns:
    _cities - End city of the patrol. [Array]

Examples:
    (begin example)
        [[selectRandom values btc_city_all, selectRandom values btc_city_all]] call btc_patrol_fnc_usefulCity;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cities", [], [[]]],
    ["_area", btc_patrol_area, [0]],
    ["_isBoat", false, [false]]
];
_cities params [
    ["_start_city", objNull, [objNull]],
    ["_active_city", objNull, [objNull]]
];

//Find a useful end city from the start city depending of vehicle type
private _useful = [];
if (_isBoat) then {
    _useful = values btc_city_all select {_x getVariable ["hasbeach", false]};
} else {
    _useful = values btc_city_all select {_x getVariable ["type", ""] != "NameMarine"};
};
private _cities = _useful inAreaArray [getPosWorld _active_city, _area, _area];
private _cities = _cities - (_start_city getVariable ["btc_cities_inaccessible", []]);

//Choose a city to have the _active_city (where the player is) between the _start_city and the _end_city: _start_city  ----> _active_city  ----> _end_city
private _dirTo = _start_city getDir _active_city;
_cities_dirTo = _cities select {
    private _ang = _active_city getDir _x;
    (abs(_ang - _dirTo) min (360 - abs(_ang - _dirTo)) < 45);
};
if (_cities_dirTo isNotEqualTo []) then {
    _cities = _cities_dirTo;
};

//Check if end city has been found, if not take the closer city
if (_cities isEqualTo []) then {
    _cities = [[_active_city, _useful, false] call btc_fnc_find_closecity];
};

_cities
