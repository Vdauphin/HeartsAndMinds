
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_create_s

Description:
    Fill me when you edit me !

Parameters:
    _objec_type - [String]
    _pos - [Array]
    _vector - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_create_s;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_objec_type", "", [""]],
    ["_pos", getPosASL btc_create_object_point, [[]]],
    ["_vector", vectorUp btc_create_object_point, [[]]]
];

private _obj = objNull;
if (getText (configFile >> "cfgVehicles" >> _objec_type >> "displayName") isEqualTo "") then {
    _obj = [btc_create_object_point, _objec_type] call ace_rearm_fnc_createDummy;
} else {
    _obj = _objec_type createVehicle [0, 0, 0];
};
_obj setVectorUp _vector;
_obj setPosASL _pos;

if (getNumber(configFile >> "CfgVehicles" >> _objec_type >> "isUav") isEqualTo 1) then {
    createVehicleCrew _obj;
};

[_obj] call btc_fnc_log_init;
