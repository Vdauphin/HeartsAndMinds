
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_server_repair_wreck

Description:
    Repair wreck.

Parameters:
    _veh - Vehicle to repair. [Object]

Returns:

Examples:
    (begin example)
        _veh = [my_vehicle] spawn btc_fnc_log_server_repair_wreck;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]],
    ["_blacklist", btc_helo, [[]]]
];

if (_veh in _blacklist) exitWith {
    [16] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
};

private _type = typeOf _veh;
(getPosASL _veh) params ["_x", "_y", "_z"];
private _dir = getDir _veh;
private _marker = _veh getVariable ["marker", ""];
private _vehProperties = [_veh] call btc_fnc_getVehProperties;
_vehProperties set [5, false];

btc_vehicles = btc_vehicles - [_veh];

if (_marker != "") then {
    deleteMarker _marker;
    remoteExecCall ["", _marker];
};
deleteVehicle _veh;
sleep 1;
_veh = ([_type, [_x, _y, 0.5 + _z], _dir] + _vehProperties) call btc_fnc_log_createVehicle;

_veh
