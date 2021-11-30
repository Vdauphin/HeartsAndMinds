/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_addEH

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
[_veh, "Fuel", btc_patrol_fnc_eh] call CBA_fnc_addBISEventHandler;
if (side _group isEqualTo civilian) then {
    [_veh, "GetOut", btc_patrol_fnc_eh] call CBA_fnc_addBISEventHandler;
};
