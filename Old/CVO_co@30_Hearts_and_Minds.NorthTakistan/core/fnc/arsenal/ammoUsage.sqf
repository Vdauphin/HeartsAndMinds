
/* ----------------------------------------------------------------------------
Function: btc_arsenal_fnc_ammoUsage

Description:
    Select weapons if:
        - is a type of item
        - and has a ammo usage allowed

Parameters:
    _weapons - Array of weapons. [Array]
    _itemType_ammo_usageAllowed - Weapons allowed filter: array of item type ("AssaultRifle", "MissileLauncher"...), allowed ammo usage ("128 + 512": ammo against vehicles and armored vehicles). [Array]

Returns:
    Array of selected weapons

Examples:
    (begin example)
        _weapons_selected = [["launch_RPG7_F"], ["MissileLauncher", "256"]] call btc_arsenal_fnc_ammoUsage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_weapons", ["launch_RPG7_F"], [[]]],
    ["_itemType_ammo_usageAllowed", ["MissileLauncher", "256"], [[]]]
];
_itemType_ammo_usageAllowed params [["_itemType", "MissileLauncher", [""]], ["_ammo_usageAllowed", "", [""]]];

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgAmmo = configFile >> "CfgAmmo";

_weapons select {
    private _weapon = _x;
    private _isAllowed = true;
    if (_ammo_usageAllowed isNotEqualTo "") then {
        private _magazines = getArray (_cfgWeapons >> _weapon >> "magazines");
        private _aiAmmoUsage_magazines = _magazines apply {
            private _ammo = getText (_cfgMagazines >> _x >> "ammo");

            private _aiAmmoUsage = getText (_cfgAmmo >> _ammo >> "aiAmmoUsageFlags");
            if (_aiAmmoUsage isEqualTo "") then {
                _aiAmmoUsage = str getNumber (_cfgAmmo >> _ammo >> "aiAmmoUsageFlags");
            };

            _aiAmmoUsage;
        };

        if (btc_debug_log) then {
            if ("" in _aiAmmoUsage_magazines) then {
                [format ["Weapons: %1 AiAmmoUsage Magazines: %2", _weapon, _aiAmmoUsage_magazines], __FILE__, [false]] call btc_debug_fnc_message;
            };
        };

        _isAllowed = _ammo_usageAllowed in _aiAmmoUsage_magazines;
    };

    (_itemType in (_weapon call BIS_fnc_itemType)) && {_isAllowed}
};
