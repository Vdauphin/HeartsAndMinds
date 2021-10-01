
/* ----------------------------------------------------------------------------
Function: btc_fnc_setVehProperties

Description:
    Set properties of a vehicle.

Parameters:
    _vehicle - Vehicle to get properties. [Object]
    _customization - Get skin. [Array]
    _isMedicalVehicle - Is medical vehicle. [Boolean]
    _isRepairVehicle - Is repair vehicle. [Boolean]
    _fuelSource - Fuel cargo and hook. [Array]
    _pylons - Array of pylon. [Array]
    _isContaminated - Set a vehicle contaminated. [Boolean]
    _supplyVehicle - Is supply vehicle and current supply count. [Boolean]

Returns:
	_vehicle - Vehicle. [Object]

Examples:
    (begin example)
        [vehicle player] call btc_fnc_setVehProperties;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_customization", [false, false], [[]]],
    ["_isMedicalVehicle", false, [true]],
    ["_isRepairVehicle", false, [true]],
    ["_fuelSource", [], [[]]],
    ["_pylons", [], [[]]],
    ["_isContaminated", false, [false]],
    ["_supplyVehicle", [], [[]]]
];

[_vehicle, _customization select 0, _customization select 1] call BIS_fnc_initVehicle;
if (_isMedicalVehicle && {!([_vehicle] call ace_medical_treatment_fnc_isMedicalVehicle)}) then {
    _vehicle setVariable ["ace_medical_isMedicalVehicle", _isMedicalVehicle, true];
};
if (_isRepairVehicle && {!([_vehicle] call ace_repair_fnc_isRepairVehicle)}) then {
    _vehicle setVariable ["ACE_isRepairVehicle", _isRepairVehicle, true];
};
if !(_fuelSource isEqualTo []) then {
    _fuelSource params [
        ["_fuelCargo", 0, [0]],
        ["_hooks", nil, [[]]]
    ];
    if ((!isNil "_hooks") && {!(_hooks isEqualTo (_vehicle getVariable ["ace_refuel_hooks", []]))}) then {
        [_vehicle, _fuelCargo, _hooks] call ace_refuel_fnc_makeSource;
    } else {
        if (_fuelCargo != [_vehicle] call ace_refuel_fnc_getFuel) then {
            [_vehicle, _fuelCargo] call ace_refuel_fnc_makeSource;
        };
    };
};
if !(_pylons isEqualTo []) then {
    private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
    {
        _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
    } forEach getPylonMagazines _vehicle;
    {
        _vehicle setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]
    } forEach _pylons;
};
if (_isContaminated) then {
    if ((btc_chem_contaminated pushBackUnique _vehicle) > -1) then {
        publicVariable "btc_chem_contaminated";
    };
};
if !(_supplyVehicle isEqualTo []) then {
    _supplyVehicle params [
        ["_isSupplyVehicle", false, [false]],
        ["_currentSupply", -1, [0]]
    ];

    if (_isSupplyVehicle && !([_vehicle] call ace_rearm_fnc_isSource)) then {
        [_vehicle, _currentSupply] call ace_rearm_fnc_makeSource;
    };
};

_vehicle
