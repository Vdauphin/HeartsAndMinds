
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_registerDamageEH

Description:
    Register a event handler for chemical damage events.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_fnc_chem_registerDamageEH;
    (end)

Author:
    Zakant

---------------------------------------------------------------------------- */

private _bodyParts = ["head","body","hand_l","hand_r","leg_l","leg_r"];
["btc_chem_applyDamage", {
    _this params ["_unit", objNull, [objNull]];
    
    _thisArgs params [
        ["_bodyParts", [], [[]]],
        ["_cfgGlasses", configNull, [configNull]]
    ];

    [_unit, _bodyParts, _cfgGlasses] call btc_fnc_chem_damage;
}, [_bodyParts, configFile >> "CfgGlasses"]] call CBA_fnc_addEventHandlerArgs;
