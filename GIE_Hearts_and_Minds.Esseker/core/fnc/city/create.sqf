
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_create

Description:
    Create a city at the desired position with all necessary variable and the trigger to detect player presence.

Parameters:
    _position - The position where the city will be created. [Array]
    _type - Type of city. [String]
    _name - The name of the city. [String]
    _cachingRadius - The city radius. [Number]
    _has_en - If the city is occupied by enemies. [Boolean]
    _id - ID of the city in the cfgworlds. [Number]

Returns:
    _city - City created [Object]

Examples:
    (begin example)
        _city = [[0, 0, 0], "NameCityCapital", "BTC Capital", 500, true] call btc_city_fnc_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_position", [0, 0, 0], [[]]],
    ["_type", "", [""]],
    ["_name", "", [""]],
    ["_cachingRadius", 0, [0]],
    ["_has_en", false, [false]],
    ["_id", count btc_city_all, [0]]
];

private _city = createTrigger ["EmptyDetector", [_position select 0, _position select 1, getTerrainHeightASL _position], false];

btc_city_all set [_id, _city];
_city setVariable ["id", _id];

_city setVariable ["initialized", false];
_city setVariable ["name", _name];
_city setVariable ["cachingRadius", _cachingRadius];
_city setVariable ["active", false];
_city setVariable ["type", _type];
_city setVariable ["spawn_more", false];
_city setVariable ["data_units", []];
_city setVariable ["data_animals", []];
_city setVariable ["occupied", _has_en];

if (btc_p_sea) then {
    _city setVariable ["hasbeach", ((selectBestPlaces [_position, 0.8 * _cachingRadius, "sea", 10, 1]) select 0 select 1) isEqualTo 1];
};

[{
    (_this select 0) findEmptyPositionReady (_this select 1)
}, {}, [_position, [0, _cachingRadius]], 5 * 60] call CBA_fnc_waitUntilAndExecute;

[_city, _cachingRadius] call btc_city_fnc_setPlayerTrigger;

_city
