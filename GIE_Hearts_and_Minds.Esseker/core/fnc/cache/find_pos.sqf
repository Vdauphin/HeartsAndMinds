
/* ----------------------------------------------------------------------------
Function: btc_cache_fnc_find_pos

Description:
    Find a house in a city and spawn in it an ammo cache.

Parameters:
    _city_all - Array of cities where the ammo cache can be spawn. [Array]

Returns:
    - Position of the cache. [Array]

Examples:
    (begin example)
        [] call btc_cache_fnc_find_pos;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city_all", [], [[]]]
];

private _useful = _city_all select {_x getVariable ["occupied", false] && {!(_x getVariable ["type", ""] in ["NameLocal", "Hill", "NameMarine"])}};

if (_useful isEqualTo []) then {_useful = _city_all;};

private _city = selectRandom _useful;

if (_city getVariable ["type", ""] in ["NameLocal", "Hill", "NameMarine"]) exitWith {
    [] call btc_cache_fnc_find_pos;
};

private _cachingRadius = _city getVariable ["cachingRadius", 200];
private _houses = ([getPos _city, _cachingRadius/2] call btc_fnc_getHouses) select 0;

if (_houses isEqualTo []) then {
    [] call btc_cache_fnc_find_pos
} else {
    ASLToATL AGLToASL selectRandom (selectRandom _houses buildingPos -1)
}
