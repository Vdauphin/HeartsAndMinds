
/* ----------------------------------------------------------------------------
Function: btc_int_fnc_ordersLoop

Description:
    Execute in loop STOP order.

Parameters:
    _veh - Vehicle. [Object]

Returns:

Examples:
    (begin example)
        cursorObject call btc_int_fnc_ordersLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    "_veh"
];

if (
    _veh getVariable ["btc_int_sirenStart", false] ||
    _veh getVariable ["btc_int_beaconsStart", false]
) exitWith {};

[{
    params ["_arguments", "_idPFH"];
    _arguments params ["_veh"];

    private _sirenStart = _veh getVariable ["btc_int_sirenStart", false];
    private _beaconsStart = _veh getVariable ["btc_int_beaconsStart", false];
    if (
        !_sirenStart &&
        !_beaconsStart
    ) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    [
        1,
        objNull,
        ([0, btc_int_sirenRadius] select _sirenStart) + ([0, btc_int_beaconRadius] select _beaconsStart),
        _veh
    ] call btc_int_fnc_orders;
}, 0.5, _veh] call CBA_fnc_addPerFrameHandler;
