
/* ----------------------------------------------------------------------------
Function: btc_fnc_getHouses

Description:
    Get open houses around a position.

Parameters:
    _pos - Position to search for houses. [Array]
    _radius - Radius of search. [Number]

Returns:
	_useful - Useful open houses. [Array]

Examples:
    (begin example)
        _useful = [getPos player] call btc_fnc_getHouses;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[], objNull]],
    ["_radius", 100, [0]]
];

private _buildings = nearestObjects [_pos, ["Building"], _radius];
private _useful = _buildings select {!((_x buildingPos -1) isEqualTo []) && {damage _x isEqualTo 0}};

_useful
