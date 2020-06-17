
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_init

Description:
    Fill me when you edit me !

Parameters:
    _obj - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_log_init;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_obj", objNull, [objNull]]
];

if (btc_log_obj_created pushBackUnique _obj isEqualTo -1) exitWith {};
btc_curator addCuratorEditableObjects [[_obj], false];

if (
    _obj isKindOf "DeconShower_01_F" ||
    _obj isKindOf "DeconShower_02_F"
) then {
    btc_chem_decontaminate pushBackUnique _obj;
};

private _type = typeOf _obj;
if (_type in btc_log_def_loadable || {_type in btc_log_def_rc}) then {
    if (_type in btc_log_def_rc || {getNumber (configFile >> "CfgVehicles" >> _type >> "ace_cargo_canLoad") isEqualTo 0}) then {
        [_obj, [_obj] call btc_fnc_log_get_rc] call ace_cargo_fnc_setSize;

        if (btc_debug_log) then {
           [format ["ace_cargo_fnc_setSize to %1", _obj], __FILE__, [false]] call btc_fnc_debug_message;
        };
    };
};

if (_type in btc_log_def_can_load || {_type in btc_log_def_cc}) then {
    if (_type in btc_log_def_cc || {getNumber (configFile >> "CfgVehicles" >> _type >> "ace_cargo_hasCargo") isEqualTo 0}) then {
        [_obj, [_obj] call btc_fnc_log_get_cc] call ace_cargo_fnc_setSpace;

        if (btc_debug_log) then {
            [format ["ace_cargo_fnc_setSpace to %1", _obj], __FILE__, [false]] call btc_fnc_debug_message;
        };
    };
};
