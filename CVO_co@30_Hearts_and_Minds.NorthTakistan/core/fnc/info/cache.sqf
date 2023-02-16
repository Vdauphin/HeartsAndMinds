
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_cache

Description:
    Create cache intel with marker or picture.

Parameters:
    _isReal - Return a real information. [Boolean]
    _cache_obj - Cache object. [Object]
    _cache_n - Cache number. [Number]
    _cache_info - Last cache intel radius. [Number]
    _info_cache_ratio - Lower cache intel radius. [Number]

Returns:

Examples:
    (begin example)
        btc_cache_info = 100;
        [true] call btc_info_fnc_cache;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (isNull btc_cache_obj) exitWith {};

params [
    ["_isReal", true, [true]],
    ["_cache_obj", btc_cache_obj, [objNull]],
    ["_cache_n", btc_cache_n, [0]],
    ["_cache_info", btc_cache_info, [0]],
    ["_info_cache_ratio", btc_info_cache_ratio, [0]]
];

if !(_isReal) then {
    private _axis = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize") / 2;
    _cache_obj = [[_axis, _axis, 0], _axis] call CBA_fnc_randPos;
};

private _intelId = [1];
if (_cache_info < _info_cache_ratio) then {
    private _building_with_the_cache = typeOf nearestBuilding _cache_obj;
    private _classnames = [nearestTerrainObjects [_cache_obj, [], 10, false]] call btc_fnc_typeOf;
    _classnames = _classnames select {isText (configfile >> "CfgVehicles" >> _x >> "editorPreview")};
    _classnames pushBackUnique _building_with_the_cache;
    _classnames = _classnames - (btc_cache_pictures select 0);

    if (_classnames isEqualTo []) exitWith {
        [[_cache_obj, _info_cache_ratio] call CBA_fnc_randPos, _info_cache_ratio] call btc_info_fnc_cacheMarker;
    };
    private _classname_object = selectRandom _classnames;

    (btc_cache_pictures select 0) pushBack _classname_object;
    private _is_building_with_the_cache = _classname_object isEqualTo _building_with_the_cache;
    (btc_cache_pictures select 1) pushBack _is_building_with_the_cache;

    (btc_cache_pictures select 2) pushBack ([
        _classname_object,
        _cache_n,
        _is_building_with_the_cache
    ] remoteExecCall ["btc_info_fnc_cachePicture", [0, -2] select isDedicated, true]);

    _intelId = [
        [15, 14] select _is_building_with_the_cache,
        _classname_object
    ]
} else {
    btc_cache_info = [[_cache_obj, _cache_info] call CBA_fnc_randPos, _cache_info] call btc_info_fnc_cacheMarker;
};

_intelId remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];

_intelId
