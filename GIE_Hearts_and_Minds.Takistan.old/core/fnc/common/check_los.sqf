
/* ----------------------------------------------------------------------------
Function: btc_fnc_check_los

Description:
    Check the line of sight (LOS) between a unit and a target.

Parameters:
    _unit - Unit for checking. [Object]
    _target - Target to check. [Object]

Returns:
    _can_see - Tell if the unit can see or not the target. [Boolean]

Examples:
    (begin example)
        _can_see = [player, cursorObject] call btc_fnc_check_los;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_target", objNull, [objNull]]
];

(eyeDirection _unit) params ["_point1", "_point2"];
private _atan = _point1 atan2 _point2;
private _dirTo = _target getDir _unit;
private _ang = abs (_dirTo - _atan);
private _can_see = (_ang > 120) && (_ang < 240);

if (_can_see) then {
    private _eyeu = eyePos _unit;
    private _eyet = eyePos _target;
    private _terr = terrainIntersectASL [_eyeu, _eyet];
    private _int = lineIntersects [_eyeu, _eyet];
    private _can_see = !(_int || _terr);
};
_can_see
