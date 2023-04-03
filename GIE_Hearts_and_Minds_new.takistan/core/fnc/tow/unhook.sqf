
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_unhook

Description:
    Unhook the current tower/towed vehicle.

Parameters:
    _veh - Vehicle, could be the tower or the towed vehicle. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_tow_fnc_unhook;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]]
];

private _towing = _veh getVariable ["btc_towing", objNull];

private _ropes = ropes _veh;
if (_ropes isEqualTo []) then {
    _ropes = ropes _towing;
};

_ropes apply {ropeDestroy _x};
