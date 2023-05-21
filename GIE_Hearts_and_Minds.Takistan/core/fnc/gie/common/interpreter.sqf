/* ----------------------------------------------------------------------------
Function: gie_fnc_interpreter
Description:
    Give training to player
Parameters:
    _unit - Unit for checking. [Object]
    _add - Should it be added or remove [Bool]
Returns:
    Nothing
Examples:
    (begin example)
        [player, true] call gie_fnc_interpreter;
    (end)
Author:
    Gavin "Morbakos" Sertix
---------------------------------------------------------------------------- */

params [["_unit", null, [objNull]], ["_add", true, [true]]];

if (isNull _unit) exitWith {};

if (_add isEqualTo true) then {
    _unit setVariable ["interpreter", true, true];
    hint "Vous êtes maintenant interprète";
} else {
    _unit setVariable ["interpreter", false, true];
    hint "Vous n'êtes plus interprète";
};