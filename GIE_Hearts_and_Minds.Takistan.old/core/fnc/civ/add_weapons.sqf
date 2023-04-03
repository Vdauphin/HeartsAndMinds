
/* ----------------------------------------------------------------------------
Function: btc_civ_fnc_add_weapons

Description:
    Add weapon to a unit.

Parameters:
    _unit - Unit where a weapon will be added. [Object]

Returns:

Examples:
    (begin example)
        [_unit] call btc_civ_fnc_add_weapons;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_weapon", "", [""]],
    ["_magazine", "", [""]]
];

(uniformContainer _unit) addMagazineCargo [_magazine, 5];
_unit addWeapon _weapon;
_unit selectWeapon _weapon;
