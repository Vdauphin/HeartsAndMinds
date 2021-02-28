
/* ----------------------------------------------------------------------------
Function: btc_fnc_tow_check

Description:
    _tower ----rope--- (hook)_towed, Show feedback message when trying to tow a vehicle.

Parameters:
    _tower - Tower vehicle. [Object]
    _towed - Towed vehicle. [Object]

Returns:
    _canTow - Can tow or not. [Boolean]

Examples:
    (begin example)
        _canTow = [cursorObject, btc_tow_vehicleSelected] call btc_fnc_tow_check;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_tower", objNull, [objNull]],
    ["_towed", objNull, [objNull]]
];

private _array = [_tower] call btc_fnc_log_get_nottowable;

if ((_array findIf {_towed isKindOf _x}) != -1) exitWith {
    private _string_array = "";
    {
        _string_array = _string_array + ", " + _x;
    } forEach (([_tower] call btc_fnc_log_get_nottowable) - ["Truck_F"]);

    (format [localize "STR_BTC_HAM_TOW_CANT", _string_array]) call CBA_fnc_notify;
    false
};

private _model_rear = ([_tower] call btc_fnc_tow_hitch_points) select 1;
private _dirSelected = getDir _towed;
private _model_selected = (0 boundingBoxReal _towed) select 1;
private _model_front_selected = ([_towed] call btc_fnc_log_get_corner_points) select 2;
private _offset = if (_model_selected select 1 > 3.06) then {
    (_model_selected select 1) - 3.06
} else {
    (_model_front_selected select 1) - (_model_selected select 1)
};
private _posFlat = _towed getPos [_offset + 3 /*size of Truck_01_Rack_F*/, _dirSelected];
_posFlat set [2, 0.2 + ((getPosATL _towed) select 2)];
private _distance = _posFlat distance (_tower modelToWorld _model_rear);
private _distanceTowed = _towed distance (_tower modelToWorld _model_rear);

private _safeDistance = [_distance > 1.3, _distance < [5, 24] select (_tower isKindOf "Ship")];
if (_safeDistance isEqualTo [true, false]) exitWith {
    (localize "STR_BTC_HAM_TOW_TFAR") call CBA_fnc_notify;
    false
};
if (_distanceTowed < _offset + 3 || _safeDistance isEqualTo [false, true]) exitWith {
    (localize "str_a3_showcase_vtol_x11_taruclose_xia_0") call CBA_fnc_notify;
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
