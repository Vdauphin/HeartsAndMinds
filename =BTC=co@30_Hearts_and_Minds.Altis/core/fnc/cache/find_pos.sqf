
/* ----------------------------------------------------------------------------
Function: btc_fnc_cache_find_pos

Description:
    Find a house in a city and spawn in it an ammo cache.

Parameters:
    _city_all - Array of cities where the ammo cache can be spawn. [Array]

Returns:
    - Position of the cache. [Array]

Examples:
    (begin example)
        [] call btc_fnc_cache_find_pos;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city_all", btc_city_all, [[]]]
];

private _useful = _city_all select {_x getVariable ["occupied", false] && {!(_x getVariable ["type", ""] in ["NameLocal", "Hill", "NameMarine"])}};

if (_useful isEqualTo []) then {_useful = _city_all;};

private _id = floor random count _useful;
private _city = _useful select _id;

if (_city getVariable ["type", ""] in ["NameLocal", "Hill", "NameMarine"]) exitWith {
    [] call btc_fnc_cache_find_pos;
};

private _radius = _city getVariable ["radius", 200];
private _pos = [getPos _city, _radius] call btc_fnc_randomize_pos;
private _houses = [_pos, 50] call btc_fnc_getHouses;

if (_houses isEqualTo []) then {
    [] call btc_fnc_cache_find_pos
} else {
    ASLToATL AGLToASL selectRandom (selectRandom _houses buildingPos -1)
}
