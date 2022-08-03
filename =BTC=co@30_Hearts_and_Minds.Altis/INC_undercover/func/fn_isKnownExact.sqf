/* ----------------------------------------------------------------------------
Function: IsKnownExact

Description: Finds out whether there are any members of a given side who know about the unit's location within a given precision radius. Effectively functions as a way to find out whether the unit has been seen by a given side.

Parameters:
0: The unit to run the check on <OBJECT>
1: The side that may have knowledge of the unit's location <SIDE>
2: Precision radius of enemy unit's target knowledge - higher = less precise <NUMBER>
3: Force checks to foot unit only <BOOL>

Returns:

Whether there are enemies with knowledge of the unit's location within the given precision radius <BOOL>

Examples:

[_unit,INC_regEnySide,50] call INCON_ucr_fnc_isKnownExact;

Author: Incontinentia, with help from Tajin, Grumpy Old Man, sarogahtyp and davidoss
---------------------------------------------------------------------------- */

private ["_alertedUnits","_alertedGroups","_getHideFromUnit"];

params [["_unit",player],["_side",sideEmpty],["_distSqr",1400],["_foot",false]];

if (_side == sideEmpty) exitWith {false};

if (!_foot) then {
	_unit = vehicle _unit;
};

private _result = false;

{if (((leader _x getHideFrom _unit) distanceSqr _unit < _distSqr) && {alive leader _x}) exitWith {_result = true}; false} forEach (allGroups select {
	(side (leader _x) isEqualTo _side)
});

_result
