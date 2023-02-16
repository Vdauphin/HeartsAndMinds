
/* ----------------------------------------------------------------------------
Function: btc_mil_fnc_set_skill

Description:
    Set skills to a unit.

Parameters:
    _unit - Unit to set skill. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_mil_fnc_set_skill;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

_unit setskill ["general", btc_AI_skill select 0];
_unit setskill ["aimingAccuracy", btc_AI_skill select 1];
_unit setskill ["aimingShake", btc_AI_skill select 2];
_unit setskill ["aimingSpeed", btc_AI_skill select 3];
_unit setskill ["endurance", btc_AI_skill select 4];
_unit setskill ["spotDistance", btc_AI_skill select 5];
_unit setskill ["spotTime", btc_AI_skill select 6];
_unit setskill ["courage", btc_AI_skill select 7];
_unit setskill ["reloadSpeed", btc_AI_skill select 8];
_unit setskill ["commanding", btc_AI_skill select 9];
