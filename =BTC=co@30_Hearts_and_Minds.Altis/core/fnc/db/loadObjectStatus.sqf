
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_loadObjectStatus

Description:
    Load object status like ACE cargo, inventory and position.

Parameters:
    _object_data - Object to create with position, direction, cargo, inventory ... [Array]

Returns:

Examples:
    (begin example)
        _result = [] call btc_db_fnc_loadObjectStatus;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_object_data", [], [[]]]
];
_object_data params [
    "_type",
    "_pos",
    "_dir",
    "_magClass",
    "_cargo",
    "_inventory",
    "_vectorPos",
    ["_isContaminated", false, [false]]
];

private _obj = createVehicle [_type, ASLToATL _pos, [], 0, "CAN_COLLIDE"];

_obj setDir _dir;
_obj setPosASL _pos;
_obj setVectorDirAndUp _vectorPos;

if (_isContaminated) then {
    if ((btc_chem_contaminated pushBackUnique _obj) > -1) then {
        publicVariable "btc_chem_contaminated";
    };
};
if (_magClass isNotEqualTo "") then {_obj setVariable ["ace_rearm_magazineClass", _magClass, true]};
if (unitIsUAV _obj) then {
    createVehicleCrew _obj;
};

[_obj] call btc_log_fnc_init;
[_obj, _cargo, _inventory] call btc_db_fnc_loadCargo;
