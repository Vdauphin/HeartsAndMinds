
/* ----------------------------------------------------------------------------
Function: btc_cache_fnc_init

Description:
    Initialise the ammo cache system with all necessary variable and start the search of a suitable position for it.

Parameters:
    _cache_n - Cache number. [Number]
    _cache_pictures - Array of building type. [Array]

Returns:

Examples:
    (begin example)
        [0, btc_cache_pictures] call btc_cache_fnc_init;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cache_n", 0, [0]],
    ["_cache_pictures", [[], [], []], [[]]]
];

btc_cache_n = _cache_n;
btc_cache_obj = objNull;
btc_cache_markers = [];
{
    remoteExecCall ["", _x];
} forEach (_cache_pictures select 2);
btc_cache_pictures = [[], [], []];
btc_cache_info = btc_info_cache_def;
btc_cache_pos = [values btc_city_all] call btc_cache_fnc_find_pos;
[btc_cache_pos] call btc_cache_fnc_create;
