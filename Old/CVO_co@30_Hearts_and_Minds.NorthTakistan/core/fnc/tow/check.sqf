
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_check

Description:
    _tower ----rope--- (hook)_towed, Show feedback message when trying to tow a vehicle.

Parameters:
    _tower - Tower vehicle. [Object]
    _towed - Towed vehicle. [Object]

Returns:
    _canTow - Can tow or not. [Boolean]

Examples:
    (begin example)
        _canTow = [btc_tow_vehicleTowing, cursorObject] call btc_tow_fnc_check;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_tower", objNull, [objNull]],
    ["_towed", objNull, [objNull]]
];

private _array = [_tower] call btc_log_fnc_get_nottowable;

if ((_array findIf {_towed isKindOf _x}) != -1) exitWith {
    private _string_array = "";
    {
        _string_array = _string_array + ", " + _x;
    } forEach (([_tower] call btc_log_fnc_get_nottowable) - ["Truck_F"]);

    (format [localize "STR_BTC_HAM_TOW_CANT", _string_array]) call CBA_fnc_notify;
    false
};

private _model_rear_tower = ([_tower] call btc_tow_fnc_hitch_points) select 1;
private _model_front_towed = ([_towed] call btc_tow_fnc_hitch_points) select 0;
private _pos_rearTower = _tower modelToWorld _model_rear_tower;
private _pos_frontTowed = _towed modelToWorld _model_front_towed;

if (_pos_rearTower distance _pos_frontTowed > 5) exitWith {
    (localize "STR_BTC_HAM_TOW_TFAR") call CBA_fnc_notify;
    false
};
if (
    !([position _tower, ((getDir _tower) + 180) mod 360, 90, _pos_frontTowed] call BIS_fnc_inAngleSector)
) exitWith {
    (localize "STR_BTC_HAM_TOW_NOTA") call CBA_fnc_notify;
    false
};

if (
    !(isNull isVehicleCargo attachedto _tower) ||
    !(isNull isVehicleCargo attachedto _towed) ||
    !(isNull isVehicleCargo _tower) ||
    !(isNull isVehicleCargo _towed) ||
    !isNull (_tower getVariable ["btc_towing", objNull])
) exitWith {
    (localize "STR_BTC_HAM_TOW_ALREADYTOWED") call CBA_fnc_notify;
    false
};

true
