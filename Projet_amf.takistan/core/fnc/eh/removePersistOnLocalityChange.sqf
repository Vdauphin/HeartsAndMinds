
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_removePersistOnLocalityChange

Description:
    Remove persistant event handler from client owner and server.

Parameters:
    _object - Object where to add the event handler. [Object]
    _EH_name - Name of the event handler. [String]
    _EH_fnc - Name of the function executed when the EH is triggered. [Array]
    _removeServerSide - Also remove the EH on the server. [Boolean]

Returns:
    _EH_IDs - Local EH ID and ID of the EH. [Array]

Examples:
    (begin example)
        [cursorObject, "Killed", "btc_fnc_rep_killed"] call btc_fnc_eh_removePersistOnLocalityChange;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]],
    ["_EH_name", "", [""]],
    ["_EH_fnc", "", [""]],
    ["_removeServerSide", true, [true]]
];

private _EH_IDs = _object getVariable [_EH_fnc + _EH_name, []];

if (btc_debug_log) then {
    [format ["%1: EH = %2, fnc = %3, isR = %4, IDs %5", _object, _EH_name, _EH_fnc, isRemoteExecuted, _EH_IDs], __FILE__, [false]] call btc_fnc_debug_message;
};

if !(_EH_IDs isEqualTo []) then {
    _object removeEventHandler [_EH_name, _EH_IDs select 0];
    if (count _EH_IDs > 1) then {
        _object removeEventHandler ["Local", _EH_IDs select 1];
    };

    _object setVariable [
        _EH_fnc + _EH_name,
        nil
    ];
};

if (!isServer && _removeServerSide) then {
    [_object, _EH_name, _EH_fnc] remoteExecCall ["btc_fnc_eh_removePersistOnLocalityChange", 2];
};

_EH_IDs
