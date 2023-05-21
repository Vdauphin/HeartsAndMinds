
/* ----------------------------------------------------------------------------
Function: btc_log_fnc_repair_wreck

Description:
    Fill me when you edit me !

Parameters:
    _object - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_log_fnc_repair_wreck;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];

private _array = (nearestObjects [_object, ["LandVehicle", "Air", "Ship"], 10]) select {!(
    _x isKindOf "ACE_friesBase" OR
    _x isKindOf "ace_fastroping_helper"
)};

if (_array isEqualTo []) exitWith {(localize "STR_BTC_HAM_LOG_RWRECK_NOWRECK") call CBA_fnc_notify;};

if (damage (_array select 0) != 1) exitWith {(localize "STR_BTC_HAM_LOG_RWRECK_NOTWRECK") call CBA_fnc_notify};

[_array select 0] remoteExecCall ["btc_log_fnc_server_repair_wreck", 2];
