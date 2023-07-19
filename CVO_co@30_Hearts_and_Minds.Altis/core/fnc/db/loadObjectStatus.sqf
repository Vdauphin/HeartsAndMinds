
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
    "",
    "_cargo",
    "_inventory",
    "_vectorPos",
    ["_isContaminated", false, [false]],
    ["_dogtagDataTaken", [], [[]]],
    ["_flagTexture", "", [""]],
    ["_turretMagazines", [], [[]]],
    ["_customName", "", [""]],
    ["_tagTexture", "", [""]],
    ["_properties", [], [[]]]
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
if (unitIsUAV _obj) then {
    createVehicleCrew _obj;
};
if (_flagTexture isNotEqualTo "") then {
    _obj forceFlagTexture _flagTexture;
};

if (_turretMagazines isNotEqualTo []) then {
    [_obj, _turretMagazines] call btc_db_fnc_setTurretMagazines;
};

[_obj, _dogtagDataTaken] call btc_body_fnc_dogtagSet;

if (_customName isNotEqualTo "") then {
    _obj setVariable ["ace_cargo_customName", _customName, true];
};

if (_tagTexture isNotEqualTo "") then {
    [objNull, [], _tagTexture, _obj, objNull, "", "", true] call ace_tagging_fnc_createTag;
};

if (_properties isNotEqualTo []) then {
    ([_obj] + _properties) call btc_veh_fnc_propertiesSet;
};

[_obj] call btc_log_fnc_init;
[_obj, _cargo, _inventory] call btc_db_fnc_loadCargo;
