
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_loadObjectStatus

Description:
    Load object status like ACE cargo, inventory and position.

Parameters:
    _object_data - Object to create with position, direction, cargo, inventory ... [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_db_loadObjectStatus;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_object_data", [], [[]]]
];
_object_data params ["_type",
    "_posWorld",
    "_dir",
    "_magClass",
    "_cargo",
    "_inventory",
    "_vectorPos",
    ["_isContaminated", false, [false]]
];

private _obj = _type createVehicle _posWorld;

_obj setDir _dir;
_obj setPosWorld _posWorld;
_obj setVectorDirAndUp _vectorPos;

if (_isContaminated) then {
    if ((btc_chem_contaminated pushBackUnique _obj) > -1) then {
        publicVariable "btc_chem_contaminated";
    };
};
if !(_magClass isEqualTo "") then {_obj setVariable ["ace_rearm_magazineClass", _magClass, true]};
if (getNumber(configFile >> "CfgVehicles" >> _type >> "isUav") isEqualTo 1) then {
    createVehicleCrew _obj;
};

[_obj] call btc_fnc_log_init;
[_obj, _cargo, _inventory] call btc_fnc_db_loadCargo;
