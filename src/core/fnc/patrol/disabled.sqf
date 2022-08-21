
/* ----------------------------------------------------------------------------
Function: btc_patrol_fnc_disabled

Description:
    Delete vehicle disabled due to a high impact.

Parameters:
    _veh - Vehicle. [Object]

Returns:

Examples:
    (begin example)
        [veh] call btc_patrol_fnc_disabled;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]],
    ["_selection", "wheel_1_1_steering", [""]],
    ["_damage", 0.2, [0]]
];

if (_veh getVariable ["btc_patrol_fnc_disabled_fired", false]) exitWith {};

if (_damage > 0.1) then {
    _veh setVariable ["btc_patrol_fnc_disabled_fired", true, true];
    if (isServer) then {
        [_veh] call btc_patrol_fnc_eh;
    } else {
        [_veh] remoteExecCall ["btc_patrol_fnc_eh", 2];
    };
};

_damage
