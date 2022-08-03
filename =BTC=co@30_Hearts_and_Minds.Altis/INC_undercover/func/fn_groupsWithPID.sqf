/* ----------------------------------------------------------------------------
Function: IsKnownExact

Description: Finds out whether there are any members of a given side who know about the unit's location within a given precision radius. Effectively functions as a way to find out whether the unit has been seen by a given side.

Parameters:
0: The unit to run the check on <OBJECT>
1: The side that may have knowledge of the unit's location <SIDE>
2: Precision radius of enemy unit's target knowledge - higher = less precise <NUMBER>
3: Force checks to foot unit only <BOOL>

Returns:

Whether there are groups left alive with a PID of the unit.
---------------------------------------------------------------------------- */

private ["_groupsWithPID","_aliveGroupsWithPID"];

params [["_unit",player],["_side",sideEmpty],["_distSqr",2],["_foot",true]];

if (_side == sideEmpty) exitWith {false};

if (!_foot) then {
	_unit = vehicle _unit;
};

_groupsWithPID = _unit getVariable ["INC_seenByList",[]];

{
	if (((leader _x getHideFrom _unit) distanceSqr _unit < _distSqr) && {alive leader _x}) then {
		_groupsWithPID pushBackUnique _x;
	}; false
} forEach (allGroups select {
	(side (leader _x) isEqualTo _side)
});

_aliveGroupsWithPID = [];

{{if (alive _x) exitWith {_aliveGroupsWithPID pushBackUnique (group _x)}} forEach (units _x)} forEach _groupsWithPID;

_unit setVariable ["INC_seenByList",_aliveGroupsWithPID];

(count _aliveGroupsWithPID != 0)
