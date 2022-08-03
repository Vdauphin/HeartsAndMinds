/* ----------------------------------------------------------------------------
Function: IsKnownToSide

Description: Finds out whether there are any members of a given side who know about the unit.

Parameters:
0: The unit to run the check on <OBJECT>
1: The side that may have knowledge of the unit <SIDE>
2: Force checks to foot unit only <BOOL>

Returns:

Whether there are units of the given side with knowledge of the unit

Examples:

[_unit,INC_regEnySide] call INCON_ucr_fnc_isKnownToSide;

Author: Incontinentia, with help from Tajin, Grumpy Old Man, sarogahtyp and davidoss
---------------------------------------------------------------------------- */

params [["_unit",player],["_side",sideEmpty],["_foot",false]];

if (_side == sideEmpty) exitWith {false};

if (!_foot) then {
	_unit = vehicle _unit;
};

private _result = false;

{if (((leader _x targetKnowledge _unit) select 0) && {alive leader _x}) exitWith {_result = true}; false} forEach (allGroups select {
	(side (leader _x) isEqualTo _side)
});

_result
