
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_droneLoop

Description:
    Search for soldier around the drone during a patrol. If soldier are in range, activate the drone.

Parameters:
    _driver_drone - Driver of the drone. [Object]
    _rpos - Position where the drone patrol. [Array]
    _area - Area of the patrol. [Array]
    _trigger - Trigger of the drone when is active. [Group]

Returns:

Examples:
    (begin example)
        [_driver_drone, _rpos, _area, _trigger] call btc_ied_fnc_droneLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params ["_driver_drone", "_rpos", "_area", "_trigger"];

    private _group = group _driver_drone;
    if (alive _driver_drone && !isNull _driver_drone) then {
        private _array = _driver_drone nearEntities [btc_player_type, 200];
        if (_array isEqualTo []) then {
            if (waypoints _group isEqualTo []) then {
                [_group, _rpos, _area, 4] call CBA_fnc_taskPatrol;
                (vehicle _driver_drone) flyInHeight 10;
                deleteVehicle (_trigger deleteAt 0);
            };
        } else {
            if (_trigger isEqualTo []) then {
                _trigger pushBack ([_driver_drone] call btc_ied_fnc_drone_active);
            };

            if (btc_debug) then {
                hint format ["Distance with UAV IED : %1", (_array select 0) distance (vehicle _driver_drone)];
            };
            (vehicle _driver_drone) doMove (ASLtoAGL getPosASL (_array select 0));
        };
        _this call btc_ied_fnc_droneLoop;
    } else {
        deleteVehicle (_trigger deleteAt 0);
        _group setVariable ["btc_ied_drone", false];

        if (btc_debug_log) then {
            [format ["_driver_drone = %1 POS %2 END LOOP", _driver_drone, getPos _driver_drone], __FILE__, [false]] call btc_debug_fnc_message;
        };
    };
}, _this, 5] call CBA_fnc_waitAndExecute;
