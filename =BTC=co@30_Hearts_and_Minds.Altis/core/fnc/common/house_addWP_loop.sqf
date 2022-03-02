
/* ----------------------------------------------------------------------------
Function: btc_fnc_house_addWP_loop

Description:
    Add waypoints to group to patrol inside an house.

Parameters:
    _group - Group to add waypoints. [Group]
    _house - House use to patrol. [Object]

Returns:
    _allpositions - All position available. [Array]

Examples:
    (begin example)
        _allpositions = [group player, (([getPos player] call btc_fnc_getHouses) select 0) select 0] call btc_fnc_house_addWP_loop;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_house", objNull, [objNull]]
];

private _allpositions = (_house buildingPos -1) call BIS_fnc_arrayShuffle;

if (btc_debug_log) then {
    [format ["count all pos %1 in %2 ", count _allpositions, _house], __FILE__, [false]] call btc_debug_fnc_message;
};
{
    private _wp = [_group, [_x, 0.2] call CBA_fnc_randPos, -1, "MOVE", "UNCHANGED", "NO CHANGE", "UNCHANGED", "NO CHANGE", "", [15, 20, 30]] call CBA_fnc_addWaypoint;
    _wp waypointAttachObject _house;
    _wp setWaypointHousePosition _forEachIndex;
} forEach _allpositions;

_allpositions
