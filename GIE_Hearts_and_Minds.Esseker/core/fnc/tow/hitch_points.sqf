
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_hitch_points

Description:
    Get point to attach rope.

Parameters:
    _vehicle - Vehicle. [Object]

Returns:
    - _array - Front and rear hitch points. [Array]

Examples:
    (begin example)
        [cursorOject] call btc_tow_fnc_hitch_points;
    (end)

Author:
    sethduda

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

([_vehicle] call btc_log_fnc_get_corner_points) params [
    "_rearCorner",
    "_rearCorner2",
    "_frontCorner",
    "_frontCorner2"
];
private _rearHitchPoint = ((_rearCorner vectorDiff _rearCorner2) vectorMultiply 0.5) vectorAdd  _rearCorner2;
private _frontHitchPoint = ((_frontCorner vectorDiff _frontCorner2) vectorMultiply 0.5) vectorAdd  _frontCorner2;

[_frontHitchPoint, _rearHitchPoint];
