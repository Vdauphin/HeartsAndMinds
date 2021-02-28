
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_add_eh

Description:
    Add EH to military unit.

Parameters:
    _unit - Unit. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_mil_add_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

[_unit, "Killed", "btc_fnc_mil_unit_killed"] call btc_fnc_eh_persistOnLocalityChange;

true
