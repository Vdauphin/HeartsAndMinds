
/* ----------------------------------------------------------------------------
Function: btc_eh_fnc_playerConnected

Description:
    Fire the event playerConnected.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_eh_fnc_playerConnected;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

if (_name isEqualTo "__SERVER__") exitWith {};

if (btc_debug_log) then {
    [format ["_this %1", _this], __FILE__, [false]] call btc_debug_fnc_message;
};

[{
    !isNull ((_this select 1) call BIS_fnc_getUnitByUID)
}, {
    ["btc_playerConnected", [(_this select 1) call BIS_fnc_getUnitByUID, _this]] call CBA_fnc_localEvent;
}, _this, 20 * 60] call CBA_fnc_waitUntilAndExecute;
