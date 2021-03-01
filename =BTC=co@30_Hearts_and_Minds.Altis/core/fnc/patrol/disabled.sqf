
/* ----------------------------------------------------------------------------
Function: btc_fnc_patrol_disabled

Description:
    Delete vehicle disabled due to a high impact.

Parameters:
    _veh - Vehicle. [Object]

Returns:

Examples:
    (begin example)
        [veh] call btc_fnc_patrol_disabled;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]],
    ["_selection", "wheel_1_1_steering", [""]],
    ["_damage", 0.2, [0]]
];

if (_veh getVariable ["btc_fnc_patrol_disabled_fired", false]) exitWith {};

if (_damage > 0.1) then {
    _veh setVariable ["btc_fnc_patrol_disabled_fired", true, true];
    if (isServer) then {
        [_veh] call btc_fnc_patrol_eh;
    } else {
        [_veh] remoteExecCall ["btc_fnc_patrol_eh", 2];
    };
};

_damage
