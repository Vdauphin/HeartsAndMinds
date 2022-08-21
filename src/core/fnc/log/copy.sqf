
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_copy

Description:
    Fill me when you edit me !

Parameters:
    _create_object_point - [Object]
    _containers_mat - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_copy;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_create_object_point", objNull, [objNull]],
    ["_containers_mat", btc_containers_mat, [objNull]]
];

private _objects = nearestObjects [_create_object_point, _containers_mat, 3];

if (_objects isEqualTo []) exitWith {(localize "STR_BTC_HAM_O_COPY_NOCONTAINER") call CBA_fnc_notify};

btc_int_ask_data = nil;
[9, _objects select 0] remoteExecCall ["btc_int_fnc_ask_var", 2];

[{!(isNil "btc_int_ask_data")}, {
    if ("ACE_bodyBagObject" in flatten btc_int_ask_data) exitWith {
        localize "STR_BTC_HAM_O_BODYBAG_COPY" call CBA_fnc_notify;
    };

    btc_copy_container = +btc_int_ask_data;

    (localize "STR_BTC_HAM_O_COPY_SUCCSESS") call CBA_fnc_notify;
}] call CBA_fnc_waitUntilAndExecute;
