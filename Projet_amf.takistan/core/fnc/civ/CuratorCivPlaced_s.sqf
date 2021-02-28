
/* ----------------------------------------------------------------------------
Function: btc_fnc_civ_CuratorCivPlaced_s

Description:
    Apply btc_fnc_civ_unit_create to a unit.

Parameters:
    _unit - Unit where the btc_fnc_civ_unit_create will be apply. [Object]

Returns:

Examples:
    (begin example)
        [_unit] call btc_fnc_civ_CuratorCivPlaced_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

[group _unit] call btc_fnc_civ_unit_create;

if (btc_debug_log) then {
    [format [": %1", _unit], __FILE__, [false]] call btc_fnc_debug_message;
};
