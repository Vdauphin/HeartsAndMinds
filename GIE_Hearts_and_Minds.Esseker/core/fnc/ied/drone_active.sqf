
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_drone_active

Description:
    Create a trigger to allow drone to fire on player side presence.

Parameters:
    _driver_drone - Driver of the drone. [Object]

Returns:
	_trigger - Trigger to allow drone to fire on player side presence. [Object]

Examples:
    (begin example)
        _trigger = [driver] call btc_ied_fnc_drone_active;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_driver_drone", objNull, [objNull]]
];

[group _driver_drone] call CBA_fnc_clearWaypoints;

private _trigger = createTrigger ["EmptyDetector", getPos _driver_drone, false];
_trigger setTriggerArea [10, 10, 0, false, -60];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", true];
_trigger setTriggerStatements ["this", "[thisTrigger] call btc_ied_fnc_drone_fire;", ""];
_trigger setVariable ["btc_ied_drone", _driver_drone];

_trigger attachTo [vehicle _driver_drone, [0, 0, 0]];

if (btc_debug_log) then {
    [format ["_driver_drone = %1 POS %2 START LOOP", _driver_drone, getPos _driver_drone], __FILE__, [false]] call btc_debug_fnc_message;
};

(group _driver_drone) setBehaviour "CARELESS";
(group _driver_drone) setSpeedMode "LIMITED";

_trigger
