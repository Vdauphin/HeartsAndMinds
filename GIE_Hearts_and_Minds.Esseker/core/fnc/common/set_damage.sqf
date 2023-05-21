
/* ----------------------------------------------------------------------------
Function: btc_fnc_set_damage

Description:
    Set ACE damage.

Parameters:
    _unit - Unit taking damage. [Object]

Returns:

Examples:
    (begin example)
        [player] call btc_fnc_set_damage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

private _selection = [
    "head",
    "body",
    "hand_l",
    "hand_r",
    "leg_l",
    "leg_r"
];
private _type = [
    "bullet",
    "grenade"/*,
    "explosive",
    "shell"*/
];

_unit setVariable ["ace_medical_ai_lastFired", 9999999]; //Disable AI to self healing

for "_i" from 0 to (1 + floor random 2) do {
    [_unit, 0.4, selectRandom _selection, selectRandom _type] call ace_medical_fnc_addDamageToUnit;
    sleep 1;
};

if (_unit call ace_medical_status_fnc_isInStableCondition) exitWith {[_unit] call btc_fnc_set_damage;};
