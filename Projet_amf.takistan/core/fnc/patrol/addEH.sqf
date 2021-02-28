/* ----------------------------------------------------------------------------
Function: btc_fnc_patrol_addEH

Description:
    Add events link to the patrol system.

Parameters:
    _veh - Vehicle. [Object]
    _group - Group to store crews. [Group]

Returns:

Examples:

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]],
    ["_group", grpNull, [grpNull]]
];

if (
    !(_group in btc_civ_veh_active) &&
    {!(_group in btc_patrol_active)}
) exitWith {};

_veh setVariable ["btc_crews", _group];
[_veh, "Fuel", btc_fnc_patrol_eh] call CBA_fnc_addBISEventHandler;
if (side _group isEqualTo civilian) then {
    [_veh, "GetOut", btc_fnc_patrol_eh] call CBA_fnc_addBISEventHandler;
};
