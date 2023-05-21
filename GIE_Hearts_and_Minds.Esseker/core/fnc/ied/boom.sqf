
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_boom

Description:
    Create the boom and the visual effect player side.

Parameters:
    _wreck - Simple object around the ied. [Object]
    _ied - ACE IED. [Object]

Returns:

Examples:
    (begin example)
        [wreck, ied] call btc_ied_fnc_boom;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_wreck", objNull, [objNull]],
    ["_ied", objNull, [objNull]]
];

if (btc_debug_log) then {
    [format ["%1 - POS %2", [_wreck, _ied], getPos _wreck], __FILE__, [false]] call btc_debug_fnc_message;
};

private _pos = getPos _ied;
deleteVehicle _ied;
btc_ied_power createVehicle _pos;
deleteVehicle _wreck;

[_pos] call btc_deaf_fnc_earringing;
[_pos] remoteExecCall ["btc_ied_fnc_effects", [0, -2] select isDedicated];
["btc_ied_boom", [_pos]] call CBA_fnc_localEvent;
