
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_propertiesGet

Description:
    Get properties of a vehicle.

Parameters:
    _veh - Vehicle to get properties. [Object]

Returns:
    _customization - Get skin. [Array]
    _isMedicalVehicle - Is medical vehicle. [Boolean]
    _isRepairVehicle - Is repair vehicle. [Boolean]
    _fuelSource - Fuel cargo and hook. [Array]
    _pylons - Array of pylon. [Array]
    _isContaminated - Is chemically contaminated. [Boolean]
    _supplyVehicle - Is supply vehicle and current supply count. [Boolean]
    _objectTexture - Texture. [Array]

Examples:
    (begin example)
        [vehicle player] call btc_veh_fnc_propertiesGet;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]]
];

private _customization = _vehicle call BIS_fnc_getVehicleCustomization;
private _isMedicalVehicle = _vehicle call ace_medical_treatment_fnc_isMedicalVehicle;
private _isRepairVehicle = _vehicle call ace_repair_fnc_isRepairVehicle;
private _fuelSource = [
    _vehicle call ace_refuel_fnc_getFuel,
    _vehicle getVariable ["ace_refuel_hooks", []],
    _vehicle getVariable ["btc_EDEN_defaultFuelCargo", _vehicle call ace_refuel_fnc_getFuel]
];
private _pylons = getPylonMagazines _vehicle;
private _isContaminated = _vehicle in btc_chem_contaminated;
private _supplyVehicle = [
    _vehicle call ace_rearm_fnc_isSource,
    _vehicle call ace_rearm_fnc_getSupplyCount,
    _vehicle getVariable ["btc_EDEN_defaultSupply", _vehicle call ace_rearm_fnc_getSupplyCount]
];

private _objectTexture = [];
if (_customization select 0 isEqualTo []) then {
    _objectTexture = getObjectTextures _vehicle;
};

[_customization, _isMedicalVehicle, _isRepairVehicle, _fuelSource, _pylons, _isContaminated, _supplyVehicle, _objectTexture]
