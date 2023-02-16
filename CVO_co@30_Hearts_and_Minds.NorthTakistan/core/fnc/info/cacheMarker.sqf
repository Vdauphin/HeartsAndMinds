
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_cacheMarker

Description:
    Create intel marker.

Parameters:
    _position - Position of the marker. [Array]
    _radius - Radius of the indication. [Number]
    _marker_name - Marker name. [String]
    _info_cache_ratio - Offset intel distance. [Number]

Returns:
    _cache_info - Next intel distance. [Number]

Examples:
    (begin example)
        [[btc_cache_pos, btc_cache_info] call CBA_fnc_randPos,
         btc_cache_info] call btc_info_fnc_cacheMarker;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", btc_cache_pos, [[]]],
    ["_radius", btc_cache_info, [0]],
    ["_marker_name", "", [""]],
    ["_info_cache_ratio", btc_info_cache_ratio, [0]]
];

private _marker = createMarker [format ["%1", _pos], _pos];
_marker setMarkerType "hd_unknown";
_marker setMarkerText ([_marker_name, format ["%1m", _radius]] select (_marker_name isEqualTo ""));
_marker setMarkerSize [0.5, 0.5];
_marker setMarkerColor "ColorRed";

btc_cache_markers pushBack _marker;

_radius - _info_cache_ratio
