
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_killed

Description:
    Delete FOB from the btc_fobs array and remove the flag.

Parameters:
    _struc - Object the event handler is assigned to. [Object]
    _killer - Object that killed the unit. Contains the unit itself in case of collisions. [Object]
    _instigator - Person who pulled the trigger. [Object]
    _delete - Delete the FOB/Rallypoint. [Boolean]
    _useEffects - Same as useEffects in setDamage alt syntax. [Boolean]
    _fobs - Array containing FOB data. [Array]

Returns:
    _this - Arguments passed. [Array]

Examples:
    (begin example)
        _result = [btc_fobs select 1 select 0] call btc_fob_fnc_killed;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_struc", objNull, [objNull]],
    ["_killer", objNull, [objNull]],
    ["_instigator", objNull, [objNull]],
    ["_useEffects", true, [true]],
    ["_delete", false, [true]],
    ["_fobs", btc_fobs, [[]]]
];

private _fob_index = (_fobs select 1) find _struc;

if (btc_debug || btc_debug_log) then {
    [format ["named %1", (_fobs select 0) select _fob_index], __FILE__, [btc_debug, btc_debug_log]] call btc_debug_fnc_message;
};

deleteMarker ((_fobs select 0) deleteAt _fob_index);
private _fob = (_fobs select 1) deleteAt _fob_index;
deleteVehicle ((_fobs select 2) deleteAt _fob_index);

if (_delete) then {
    deleteVehicle _fob;
};

_this
