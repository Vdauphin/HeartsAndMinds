
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_create

Description:
    Fill me when you edit me !

Parameters:
    _create_obj - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_create_obj", objNull, [objNull]]
];

closeDialog 0;

btc_log_create_obj = _create_obj;
if ([btc_log_create_obj] call btc_fnc_checkArea) exitWith {};

disableSerialization;
closeDialog 0;
createDialog "btc_log_dlg_create";

waitUntil {dialog};

call btc_fnc_log_create_load;

private _class = lbData [72, lbCurSel 72];
private _selected = _class;
private _new = if (getText (configFile >> "cfgVehicles" >> _selected >> "displayName") isEqualTo "") then {
    "Box_NATO_Ammo_F" createVehicleLocal getPosASL btc_log_create_obj;
} else {
    _class createVehicleLocal getPosASL btc_log_create_obj;
};

while {dialog} do {
    if (_class != lbData [72, lbCurSel 72]) then {
        deleteVehicle _new;
        sleep 0.1;
        _class = lbData [72, lbCurSel 72];
        _selected = _class;
        if (getText (configFile >> "cfgVehicles" >> _selected >> "displayName") isEqualTo "") then {
            _new = "Box_NATO_Ammo_F" createVehicleLocal getPosASL btc_log_create_obj;
        } else {
            _new = _class createVehicleLocal getPosASL btc_log_create_obj;
        };
        _new setDir getDir btc_log_create_obj;
        _new setPosASL getPosASL btc_log_create_obj;
    };
    sleep 0.1;
};
deleteVehicle _new;
