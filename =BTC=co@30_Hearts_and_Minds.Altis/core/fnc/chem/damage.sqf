
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_damage

Description:
    Apply chemical damage.

Parameters:
    _unit - Unit to apply the damage. [Object]
    _firstDamage - If no CBRN protection, true: Always apply damage, false: Damage are applied randomly. [Boolean]
    _bodyParts - List of body part. [Array]
    _cfgGlasses - Glasses config. [Config]

Returns:

Examples:
    (begin example)
        [cursorObject, true, ["head","body","hand_l","hand_r","leg_l","leg_r"], configFile >> "CfgGlasses"] call btc_fnc_chem_damage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_firstDamage", true, [true]],
    ["_bodyParts", [], [[]]],
    ["_cfgGlasses", configNull, [configNull]]
];

private _googles = goggles _unit;
private _backpack = backpack _unit;
private _uniform = toLower uniform _unit;
private _protection = 0;

if (
    [
        "G_Respirator_base_F"
    ] findIf {_googles isKindOf [_x, _cfgGlasses]} > -1
) then {
    _protection = _protection + selectRandom [0.15, 0.3]; // Less protection than respirator
} else {
    if (
        [
            "G_RegulatorMask_base_F",
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
        _protection = _protection + 0.3;
    };
};
if (
    [
        "B_SCBA_01_base_F",
        "B_CombinationUnitRespirator_01_Base_F"
    ] findIf {_backpack isKindOf _x} > -1
) then {
    _protection = _protection + 0.1;
};
if !(_uniform isEqualTo "") then {
    _protection = _protection + 0.5;
    if (
        [
            "cbrn"
        ] findIf {_x in _uniform} > -1
    ) then {
        _protection = _protection + 0.1;
    };
};

if (_protection >= 1) exitWith {_this};

if (_firstDamage || (random 1 > _protection)) then {
    _this set [1, false];
    [_unit, random [0.05, 0.05, 0.2], selectRandom _bodyParts, "stab"] call ace_medical_fnc_addDamageToUnit; // ropeburn
};

_this
