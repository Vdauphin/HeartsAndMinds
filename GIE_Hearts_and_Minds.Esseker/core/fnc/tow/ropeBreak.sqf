
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_ropeBreak

Description:
    Handle towing rope when they break.

Parameters:
    _thisBI - BI parameters. [Array]
    _thisArgsCBA - CBA parameters. [Array]

Returns:

Examples:

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_thisBI", "_thisArgsCBA"];
_thisBI params ["_tower"];
_thisArgsCBA params ["_vehicleSelected", "_ropes"];

_tower removeEventHandler ["RopeBreak", _thisId];

_ropes apply {deleteVehicle _x};
deTach _vehicleSelected;

[_vehicleSelected, [0, 0, 0.01]] remoteExecCall ["setVelocity", _vehicleSelected];
[_tower, getMass _tower - (getMass _vehicleSelected)/1.5] remoteExecCall ["setMass", _tower];

_vehicleSelected setVariable ["btc_towing", objNull, true];
_tower setVariable ["btc_towing", objNull, true];
