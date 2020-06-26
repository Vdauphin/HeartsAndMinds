
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_getProtectionLevel

Description:
    Get the cbrn protection level of the given unit.

Parameters:
    _unit - Unit to apply the damage. [Object]
    _cfgGlasses - Glasses config. [Config]

Returns:

Examples:
    (begin example)
        [cursorObject, configFile >> "CfgGlasses"] call btc_fnc_chem_getProtectionLevel;
    (end)

Author:
    Zakant

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_cfgGlasses", configNull, [configNull]]
];

private _protection = 0;

private _googles = goggles _unit;
private _backpack = backpack _unit;
private _uniform = toLower uniform _unit;

if !(_uniform isEqualTo "") then {
    _protection = _protection + 0.2;
    if (
        [
            "cbrn"
        ] findIf {_x in _uniform} > -1
    ) then {
        _protection = _protection + 0.2;
    };
};

if (
    [
        "G_Respirator_base_F"
    ] findIf {_googles isKindOf [_x, _cfgGlasses]} > -1
) then {
    _protection = _protection + 0.2; // Less protection than respirator
} else {
    if (
        [
            "G_AirPurifyingRespirator_01_base_F",
            "GP21_GasmaskPS",
            "GP5Filter_RaspiratorPS",
            "GP7_RaspiratorPS",
            "SE_M17",
            "Hamster_PS",
            "SE_S10",
            "MK502"
        ] findIf {_googles isKindOf [_x, _cfgGlasses]} > -1
    ) then {
        _protection = _protection + 0.4;
    } else if (
        ([
            "G_RegulatorMask_base_F"
        ] findIf {_googles isKindOf [_x, _cfgGlasses]} > -1) && {
        [
            "B_SCBA_01_base_F",
            "B_CombinationUnitRespirator_01_Base_F"
        ] findIf {_backpack isKindOf _x} > -1}
    ) {
        _protection = _protection + 0.6;
    };
};

_protection min 1.0
