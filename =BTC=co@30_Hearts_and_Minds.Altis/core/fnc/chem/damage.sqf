
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_damage

Description:
    Apply chemical damage.

Parameters:
    _unit - Unit to apply the damage. [Object]
    _bodyParts - List of body part. [Array]
    _cfgGlasses - Glasses config. [Config]

Returns:

Examples:
    (begin example)
        [cursorObject, ["head","body","hand_l","hand_r","leg_l","leg_r"], configFile >> "CfgGlasses"] call btc_fnc_chem_damage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_bodyParts", [], [[]]],
    ["_cfgGlasses", configNull, [configNull]]
];

private _protection = [_unit, _cfgGlasses] call btc_fnc_chem_getProtectionLevel;
private _contaminationLevel = _unit getVariable ["btc_chem_level", 0];

if (_protection >= _contaminationLevel) exitWith {_this};

if ((random 1 > 0)) then {  // TODO: Tweak the threshold
    [_unit, random [0.05, 0.05, 0.2], selectRandom _bodyParts, "stab"] call ace_medical_fnc_addDamageToUnit; // ropeburn
};

_this
