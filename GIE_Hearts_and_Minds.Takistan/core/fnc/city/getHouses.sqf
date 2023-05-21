
/* ----------------------------------------------------------------------------
Function: btc_city_fnc_getHouses

Description:
    Get random open houses around a position.

Parameters:
    _city - City to search for houses. [Object]
    _radius - Radius of search. [Number]

Returns:
    _houses - Random useful open houses. [Array]

Examples:
    (begin example)
        [player] call btc_city_fnc_getHouses;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_radius", 100, [0]]
];

([_city, _radius] call btc_fnc_getHouses) params ["_housesEntrerable", "_housesNotEntrerable"];

_housesEntrerable = _housesEntrerable call BIS_fnc_arrayShuffle;
_housesNotEntrerable = _housesNotEntrerable call BIS_fnc_arrayShuffle;
_city setVariable ["btc_city_housesEntrerable", _housesEntrerable];
_city setVariable ["btc_city_housesNotEntrerable", _housesNotEntrerable];

[_housesEntrerable, _housesNotEntrerable]
