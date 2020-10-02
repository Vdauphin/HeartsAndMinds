
/* ----------------------------------------------------------------------------
Function: btc_fnc_city_create

Description:
    Create a city at the desired position with all necessary variable and the trigger to detect player presence.

Parameters:
    _position - The position where the city will be created. [Array]
    _type - Type of city. [String]
    _name - The name of the city. [String]
    _radius_x - The city radius along x. [Number]
    _radius_y - The city radius along y. [Number]
    _has_en - If the city is occupied by enemies. [Boolean]
    _id - ID of the city in the cfgworlds. [Number]

Returns:
    _city - City created [Object]

Examples:
    (begin example)
        _city = [[0, 0, 0], "NameCityCapital", "BTC Capital", 500, 500, true] call btc_fnc_city_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_position", [0, 0, 0], [[]]],
    ["_type", "", [""]],
    ["_name", "", [""]],
    ["_radius_x", 0, [0]],
    ["_radius_y", 0, [0]],
    ["_has_en", false, [false]],
    ["_id", count btc_city_all, [0]]
];

private _city = createSimpleObject ["CBA_NamespaceDummy", [_position select 0, _position select 1, getTerrainHeightASL _position], true];

_city setVariable ["activating", false];
_city setVariable ["initialized", false];
_city setVariable ["id", _id];
_city setVariable ["name", _name];
_city setVariable ["RadiusX", _radius_x];
_city setVariable ["RadiusY", _radius_y];
_city setVariable ["active", false];
_city setVariable ["type", _type];
_city setVariable ["spawn_more", false];
_city setVariable ["data_units", []];
_city setVariable ["occupied", _has_en];

if (btc_p_sea) then {
    _city setVariable ["hasbeach", ((selectBestPlaces [_position, 0.8 * (_radius_x + _radius_y), "sea", 10, 1]) select 0 select 1) isEqualTo 1];
};

btc_city_all set [_id, _city];
[_position, _radius_x, _radius_y, _city, _has_en, _name, _type, _id] call btc_fnc_city_trigger_player_side;

_city
