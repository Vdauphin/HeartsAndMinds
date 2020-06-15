
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

private _protection = [_unit, _cfgGlasses call btc_fnc_chem_getProtectionLevel;

if (_protection >= 1) exitWith {_this};

if (_firstDamage || (random 1 > _protection)) then {
    _this set [1, false];
    [_unit, random [0.05, 0.05, 0.2], selectRandom _bodyParts, "stab"] call ace_medical_fnc_addDamageToUnit; // ropeburn
};

_this
