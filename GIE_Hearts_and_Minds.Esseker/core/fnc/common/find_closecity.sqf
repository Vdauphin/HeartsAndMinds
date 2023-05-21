
/* ----------------------------------------------------------------------------
Function: btc_fnc_find_closecity

Description:
    Find closer city in an array of cities from an initial city.

Parameters:
    _obj - City used to find the closer city. [Object]
    _array - Array of city. [Array]
    _isOccupied - Activate not occupied city filter. [Boolean]

Returns:
    _closer_city - Closer city from the array of city. [Object]

Examples:
    (begin example)
        _closer_city = [player, values btc_city_all] call btc_fnc_find_closecity;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_obj", objNull, [objNull, []]],
    ["_array", [], [[]]],
    ["_isOccupied", true, [true]]
];

private _city_all_distance = [];
if (_isOccupied) then {
    _city_all_distance = _array select {!(_x getVariable ["occupied", false])};
} else {
    _city_all_distance = _array;
};
if (_city_all_distance isEqualTo []) exitWith {objNull};

_city_all_distance = _city_all_distance apply {[_x distance _obj, _x]};
_city_all_distance sort true;
_city_all_distance select 0 select 1;
