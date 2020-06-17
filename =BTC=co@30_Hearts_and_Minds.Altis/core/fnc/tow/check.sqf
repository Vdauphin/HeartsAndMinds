
/* ----------------------------------------------------------------------------
Function: btc_fnc_tow_check

Description:
    _tower ----rope--- (hook)_towed

Parameters:
    _tower - [Object]
    _towed - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_tow_check;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_tower", objNull, [objNull]],
    ["_towed", objNull, [objNull]]
];

private _array = [_tower] call btc_fnc_log_get_nottowable;

if ((_array findIf {_towed isKindOf _x}) != -1) exitWith {false};

private _model_rear = ([_tower] call btc_fnc_tow_hitch_points) select 1;
private _model_front = ([_towed] call btc_fnc_tow_hitch_points) select 0;
private _distance = (_towed modeltoworld _model_front) distance (_tower modeltoworld _model_rear);

if (btc_debug) then {
    if (isNil "btc_arrow_1") then {
        btc_arrow_1 = "Sign_Arrow_F" createVehicleLocal [0, 0, 0];
        btc_arrow_2 = "Sign_Arrow_F" createVehicleLocal [0, 0, 0];
    };
    btc_arrow_1 setPosASL AGLtoASL (_tower modelToWorldVisual _model_rear);
    btc_arrow_2 setPosASL AGLtoASL (_towed modelToWorldVisual _model_front);
};

private _can_tow = (_distance > 1.3) && (_distance < [5, 24] select (_tower isKindOf "Ship"));

_can_tow
