
/* ----------------------------------------------------------------------------
Function: btc_fnc_mil_CuratorMilPlaced_s

Description:
    Fill me when you edit me !

Parameters:
    _unit - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_mil_CuratorMilPlaced_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

[group _unit] call btc_fnc_mil_unit_create;

if (btc_debug_log) then {
    [format ["%1", _unit], __FILE__, [false]] call btc_fnc_debug_message;
};
