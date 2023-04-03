
/* ----------------------------------------------------------------------------
Function: btc_arsenal_fnc_weaponsFilter

Description:
    Filter weapons allowed with the weapons allowed filter: array of item type ("AssaultRifle", "MissileLauncher"...), allowed ammo usage ("128 + 512": ammo against vehicles and armored vehicles).

Parameters:
    _itemType_ammo_usageAllowed - Array of weapons allowed filter. [Array]
    _custom_arsenal - Array of weapons, magazines and items. [Array]
    _arsenalRestrict - 1 to add allowed weapons to Arsenal _custom_arsenal, other to restrict. [Number]
    _type_units - Array of enemies type. Use to remove enemies weapons from the allowed weapons. [Array]

Returns:
    _allowedWeapons - Array of allowed weapons [Array]

Examples:
    (begin example)
        _allowedWeapons = [[["AssaultRifle", ""], ["RocketLauncher", ""]]] call btc_arsenal_fnc_weaponsFilter;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_itemType_ammo_usageAllowed", [["AssaultRifle", ""], ["RocketLauncher", ""]], [[]]],
    ["_custom_arsenal", btc_custom_arsenal, [[]]],
    ["_arsenalRestrict", btc_p_arsenal_Restrict, [0]],
    ["_type_units", btc_type_units, [[]]]
];

private _weapons = ("true" configClasses (configFile >> "CfgWeapons") select {
    getNumber (_x >> "scope") isEqualTo 2 &&
    {getNumber (_x >> "type") in [1, 4]}
}) apply {configName _x};

private _allowedWeapons = [];
{
    _allowedWeapons append ([_weapons, _x] call btc_arsenal_fnc_ammoUsage);
} forEach _itemType_ammo_usageAllowed;

private _cfgVehicles = configFile >> "CfgVehicles";
private _enemyWeapons = [];
{
    _enemyWeapons append getArray (_cfgVehicles >> _x >> "weapons");
} forEach _type_units;
_allowedWeapons = _allowedWeapons - _enemyWeapons;

if (_arsenalRestrict isEqualTo 1) then {
    (_custom_arsenal select 0) append _allowedWeapons;
} else {
    (_custom_arsenal select 0) append (_weapons - _allowedWeapons);
};

_allowedWeapons
