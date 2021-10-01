
/* ----------------------------------------------------------------------------
Function: btc_fnc_civ_add_weapons

Description:
    Add weapon to a unit.

Parameters:
    _unit - Unit where a weapon will be added. [Object]

Returns:

Examples:
    (begin example)
        [_unit] call btc_fnc_civ_add_weapons;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

private _playableUnits = playableUnits inAreaArray [getPosWorld _unit, 50, 50];
private _hgun = _playableUnits findIf {[_x, _unit] call btc_fnc_check_los} != -1;

private _weapon = selectRandom ([btc_w_civs select 0, btc_w_civs select 1] select _hgun);
private _magazine = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;

(uniformContainer _unit) addMagazineCargo [_magazine, 5];
_unit addWeapon _weapon;
_unit selectWeapon _weapon;
