
/* ----------------------------------------------------------------------------
Function: btc_tow_fnc_ViV

Description:
    Move selected vehicle in the tower cargo with a hidden vehicle.

Parameters:
    _vehicleSelected - Vehicle to store in the tower cargo. [Object]
    _tower - Tower vehicle with cargo space to handle the hiden vehicle. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, btc_tow_vehicleTowing] call btc_tow_fnc_ViV;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicleSelected", objNull, [objNull]],
    ["_tower", objNull, [objNull]]
];

if (_tower setVehicleCargo _vehicleSelected) exitWith {true};

private _hideVehicle = createVehicle ["B_LSV_01_unarmed_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_hideVehicle hideObjectGlobal true;

private _model_selected = (0 boundingBoxReal _vehicleSelected) select 1;
private _model_hide = (0 boundingBoxReal _hideVehicle) select 1;
private _model_selected_z = ((0 boundingBoxReal _vehicleSelected) select 0) select 2;
private _model_hide_z = ((0 boundingBoxReal _hideVehicle) select 0) select 2;
private _attachTo = [
    0,
    ((_model_hide select 1) - (_model_selected select 1)),
    -(abs _model_hide_z - abs _model_selected_z) + 0.1
];
_vehicleSelected attachTo [_hideVehicle, _attachTo];

if (_tower setVehicleCargo _hideVehicle) then {
    [_tower, "CargoUnloaded", {
        params ["_tower", "_hideVehicle"];
        private _vehicleSelected = _thisArgs select 0;

        private _pos = getPosWorld _vehicleSelected;
        _pos set [2, (_pos select 2) + 0.3];

        detach _vehicleSelected;
        deleteVehicle _hideVehicle;

        _vehicleSelected setPosWorld _pos;
        [_vehicleSelected, [0, 0, 0.01]] remoteExecCall ["setVelocity", _vehicleSelected]; // Activate physic
    }, [_vehicleSelected]] call CBA_fnc_addBISEventHandler;
    true
} else {
    deleteVehicle _hideVehicle;
    false
};
