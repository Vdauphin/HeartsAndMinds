
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_paste

Description:
    Fill me when you edit me !

Parameters:
    _copy_container - [Array]
    _create_object_point - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_paste;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_copy_container", [], [[]]],
    ["_create_object_point", objNull, [objNull]]
];

if ([_create_object_point] call btc_fnc_checkArea) exitWith {};

if (isNil "_copy_container") exitWith {(localize "STR_BTC_HAM_O_PASTE_NOCOPIED") call CBA_fnc_notify};

[_copy_container] remoteExecCall ["btc_db_fnc_loadObjectStatus", 2];
