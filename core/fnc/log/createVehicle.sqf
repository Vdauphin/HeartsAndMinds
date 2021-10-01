
/* ----------------------------------------------------------------------------
Function: btc_fnc_log_createVehicle

Description:
    Creates an empty object of given classname type.

Parameters:
    _type - Vehicle className. [String]
    _pos -  Desired placement position. If the exact position is occupied, nearest empty position is used. [Array]
    _dir - Desired direction. [Number]
    _customization - Customized appearance [Array]
    _isMedicalVehicle - Set the ACE parameter is a medical vehicle. [Boolean]
    _isRepairVehicle - Set the ACE parameter is a repair vehicle. [Boolean]
    _fuelSource - Define the ACE cargo fuel source. [Array]
    _pylons - Set pylon loadout. [Array]
    _isContaminated - Set a vehicle contaminated. [Boolean]
    _supplyVehicle - Is supply vehicle and current supply count. [Boolean]
    _EDENinventory - Load EDEN inventory define in mission.sqm. [Array]
    _allHitPointsDamage - Apply hit point damage to the vehicle. [Array]

Returns:

Examples:
    (begin example)
        _veh = ["vehicle_class_name", getPos player] call btc_fnc_log_createVehicle;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_type", "", [""]],
    ["_pos", [0, 0, 0], [[]]],
    ["_dir", 0, [0]],
    ["_customization", [false, false], [[]]],
    ["_isMedicalVehicle", false, [true]],
    ["_isRepairVehicle", false, [true]],
    ["_fuelSource", [], [[]]],
    ["_pylons", [], [[]]],
    ["_isContaminated", false, [false]],
    ["_supplyVehicle", [], [[]]],
    ["_EDENinventory", [], [[]]],
    ["_allHitPointsDamage", [], [[]]]
];

private _veh  = createVehicle [_type, ASLToATL _pos, [], 0, "CAN_COLLIDE"];
_veh setDir _dir;
_veh setPosASL _pos;

[_veh, _customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle] call btc_fnc_setVehProperties;
if !(_EDENinventory isEqualTo []) then {
    _veh setVariable ["btc_EDENinventory", _EDENinventory];
    [_veh, _EDENinventory] call btc_fnc_log_setCargo;
};

_veh setVariable ["btc_dont_delete", true];

if (getNumber(configFile >> "CfgVehicles" >> typeOf _veh >> "isUav") isEqualTo 1) then {
    createVehicleCrew _veh;
};

if !(_allHitPointsDamage isEqualTo []) then {
    {//Disable explosion effect on vehicle creation
        [_veh, _forEachindex, _x, false] call ace_repair_fnc_setHitPointDamage;
    } forEach (_allHitPointsDamage select 2);
    if ((_allHitPointsDamage select 2) select {_x < 1} isEqualTo []) then {
        _veh setVariable ["ace_cookoff_enable", false, true];
        _veh setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
        _veh setDamage [1, false];
    };
};

_veh call btc_fnc_db_add_veh;

_veh
