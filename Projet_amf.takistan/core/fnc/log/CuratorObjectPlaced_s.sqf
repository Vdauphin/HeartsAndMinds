
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_CuratorObjectPlaced_s

Description:
    Fill me when you edit me !

Parameters:
    _obj_created - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_CuratorObjectPlaced_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_obj_created", objNull, [objNull]]
];

[_obj_created] call btc_fnc_log_init;

if (btc_debug_log) then {
    [format ["btc_log_obj_created UPDATED by curator %1", _obj_created], __FILE__, [false]] call btc_fnc_debug_message;
};
