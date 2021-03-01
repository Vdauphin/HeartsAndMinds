
/* ----------------------------------------------------------------------------
Function: btc_fnc_tow_ropeCreate

Description:
    Tow a vehicle.

Parameters:
    _tower - Vehicle towing. [Object]
    _vehicleSelected - Vehicle will be towed. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fnc_tow_ropeCreate;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_tower", objNull, [objNull]],
    ["_vehicleSelected", btc_tow_vehicleSelected, [objNull]]
];

if !([_tower, _vehicleSelected] call btc_fnc_tow_check) exitWith {};
private _allReadyLoaded = (getVehicleCargo _tower) findIf {isObjectHidden _x} isEqualTo -1;
if (
    _allReadyLoaded &&
    {_tower setVehicleCargo _vehicleSelected}
) exitWith {};

private _canViV_wreck = false;
if (_allReadyLoaded) then {
    private _fakeVehicle = "Land_WaterTank_F" createVehicleLocal [0, 0, 0];
    _canViV_wreck = _tower canVehicleCargo _fakeVehicle isEqualTo [true, true];
    deleteVehicle _fakeVehicle;
};
if (_canViV_wreck) exitWith {
    [_vehicleSelected, _tower] remoteExecCall ["btc_fnc_tow_ViV", 2];
    btc_tow_vehicleSelected = objNull;
};

(localize "STR_BTC_HAM_TOW_WAIT") call CBA_fnc_notify;

(_vehicleSelected call BIS_fnc_getPitchBank) params ["_pitch", "_bank"];
if !(
    _pitch < 45  &&
    _pitch > - 45 &&
    _bank < 45 &&
    _bank > - 45
) exitWith {
    [_vehicleSelected, {
        params ["_vehicleSelected"];

        private _pos = getPosWorld _vehicleSelected;
        _vehicleSelected setVectorUp [0, 0, 1];
        _pos set [2, 0.5 + (_pos select 2) + (_pos select 2) - ((getPosASL _vehicleSelected) select 2)];
        _vehicleSelected setPosWorld _pos;
    }] remoteExecCall ["call", _vehicleSelected];

    [{
        params ["_tower", "_vehicleSelected"];

        (_vehicleSelected call BIS_fnc_getPitchBank) params ["_pitch", "_bank"];

        _pitch < 45  &&
        _pitch > - 45 &&
        _bank < 45 &&
        _bank > - 45
    }, btc_fnc_tow_ropeCreate, [_tower, _vehicleSelected], 10] call CBA_fnc_waitUntilAndExecute;
};

// Find the position of the Flat object
private _dirSelected = getDir _vehicleSelected;
private _model_selected = (0 boundingBoxReal _vehicleSelected) select 1;
private _model_front_selected = ([_vehicleSelected] call btc_fnc_log_get_corner_points) select 2;
private _offset = if (_model_selected select 1 > 3.06) then {
    (_model_selected select 1) - 3.06
} else {
    (_model_front_selected select 1) - (_model_selected select 1)
};
private _posFlat = _vehicleSelected getPos [_offset, _dirSelected];
private _altitude = (getPosATL _vehicleSelected) select 2;
_posFlat set [2, 0.2 + _altitude];

private _vectorUp = vectorUp _vehicleSelected;
private _vectorDir = vectorDir _vehicleSelected;

private _flatType = ["Truck_01_Rack_F", "Truck_01_Rack_tropic_F"] select (worldName in ["Tanoa", "lingor3", "chernarus", "Enoch", "sara"]);
private _isShipOrAir = _tower isKindOf "Ship" || _tower isKindOf "Air";
private _flat = if (_isShipOrAir) then {
    _tower
} else {
    createVehicle [_flatType, _posFlat, [], 0, "CAN_COLLIDE"]
};
_flat setDir _dirSelected;
[_flat, [_vectorDir, _vectorUp]] remoteExecCall ["setVectorDirAndUp", _flat];

private _model_corners_tower = [_tower] call btc_fnc_log_get_corner_points;
private _model_corners_flat = [_flat] call btc_fnc_log_get_corner_points;
private _model_flat = (0 boundingBoxReal _flat) select 1;
private _attachTo = [
    0,
    [(_model_flat select 1) - (_model_selected select 1), -(_model_flat select 1) -(_model_selected select 1)] select (_flat isEqualTo _tower),
    0.1 - (_model_front_selected select 2)
];

_vehicleSelected attachTo [_flat, _attachTo];

private _ropeTowerRelPos1 = (_model_corners_tower select 0) vectorAdd [0, -1, 2];
private _ropeTowerRelPos2 = (_model_corners_tower select 1) vectorAdd [0, -1, 2];
private _ropeFlatRelPos1 = (_model_corners_flat select 2) vectorAdd [0, 0.05, 0.6];
private _ropeFlatRelPos2 = (_model_corners_flat select 3) vectorAdd [0, 0.05, 0.6];

private _rope1 = ropeCreate [_tower, _ropeTowerRelPos1,
    [_flat, _vehicleSelected] select _isShipOrAir,
    _ropeFlatRelPos1,
    (_tower modelToWorld _ropeTowerRelPos1) distance (_flat modelToWorld _ropeFlatRelPos1)
];
private _rope2 = ropeCreate [_tower, _ropeTowerRelPos2,
    [_flat, _vehicleSelected] select _isShipOrAir,
    _ropeFlatRelPos2,
    (_tower modelToWorld _ropeTowerRelPos2) distance (_flat modelToWorld _ropeFlatRelPos2)
];
private _shortRope = [_rope1, _rope2] select (ropeLength _rope1 > ropeLength _rope2);
ropeUnwind [_shortRope, 2, ropeLength _rope1 max ropeLength _rope2, false];

_tower setVariable ["btc_towing", _vehicleSelected, true];
_vehicleSelected setVariable ["btc_towing", _tower, true];
btc_tow_vehicleSelected = objNull;

[_tower, "RopeBreak", {[_this, _thisArgs] call btc_fnc_tow_ropeBreak}, [
    _vehicleSelected,
    2 + (_model_selected select 1) - (_model_corners_tower select 0 select 1),
    [_rope1, _rope2]
]] remoteExecCall ["CBA_fnc_addBISEventHandler", 2];

if (_isShipOrAir) exitWith {(localize "STR_BTC_HAM_TOW_DONE") call CBA_fnc_notify};

[{
    params ["_flat", "_rope1", "_rope2"];

    [_flat, _rope1, _rope2,
         (_flat call BIS_fnc_getPitchBank) select 0
    ] call btc_fnc_tow_unwind;
}, [_flat, _rope1, _rope2], 2] call CBA_fnc_waitAndExecute;
