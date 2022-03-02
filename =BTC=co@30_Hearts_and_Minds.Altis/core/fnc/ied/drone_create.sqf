
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_drone_create

Description:
    Create a drone in a city under a random area.

Parameters:
    _city - City where the drone is created. [Object]
    _area - Area around the city where the drone is created randomly. [Number]
    _rpos - Create the drone at this position. [Array]

Returns:
    _leader - return the leader of the group. [Object]

Examples:
    (begin example)
        _leader = [allplayers select 0, 100] call btc_ied_fnc_drone_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_area", 300, [0]],
    ["_rpos", [], [[]]]
];

if (btc_debug_log) then {
    [format ["_name = %1 _area %2", _city getVariable ["name", "name"], _area], __FILE__, [false]] call btc_debug_fnc_message;
};

if (_rpos isEqualTo []) then {
    _rpos = [position _city, _area] call btc_fnc_randomize_pos;
};

private _group = createGroup [btc_enemy_side, true];
_group setVariable ["btc_city", _city];
_group setVariable ["acex_headless_blacklist", true];
private _drone = createVehicle ["C_IDAP_UAV_06_antimine_F", _rpos, [], 0, "FLY"];
[_drone, "Fuel", {
    params ["_drone", "_hasFuel"];
    [{_this setFuel 1;}, _drone, random 120] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addBISEventHandler;
createVehicleCrew _drone;
[driver _drone] joinSilent _group;
_group setVariable ["btc_ied_drone", true];

[[_group, _rpos, _area, 4], CBA_fnc_taskPatrol] call btc_delay_fnc_exec;
_drone flyInHeight 10;

[driver _drone, _rpos, _area, []] call btc_ied_fnc_droneLoop;

leader _group
