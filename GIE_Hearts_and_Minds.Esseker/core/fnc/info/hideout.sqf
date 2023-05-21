
/* ----------------------------------------------------------------------------
Function: btc_info_fnc_hideout

Description:
    Add an random intel marker for the current hideout.

Parameters:
    _ho - Current hideout. [Object]

Returns:

Examples:
    (begin example)
        [] call btc_info_fnc_hideout;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_ho", btc_hq, [objNull]]
];

if (btc_hideouts isEqualTo []) exitWith {};

if (isNull _ho) then {
    _ho = selectRandom btc_hideouts;
    btc_hq = _ho;
};

private _pos = [getPos _ho, btc_info_hideout_radius] call CBA_fnc_randPos;

private _marker = createMarker [format ["%1", _pos], _pos];
_marker setMarkerType "hd_warning";
_marker setMarkerText format ["%1m", btc_info_hideout_radius];
_marker setMarkerSize [0.5, 0.5];
_marker setMarkerColor "ColorRed";

private _array = _ho getVariable ["markers", []];

_array pushBack _marker;

_ho setVariable ["markers", _array];
