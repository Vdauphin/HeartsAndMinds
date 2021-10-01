
/* ----------------------------------------------------------------------------
Function: btc_fnc_arsenal_ammoUsage

Description:
    Select weapons if:
        - is a type of item
        - and has a ammo usage allowed
        - and is not/is parent to a parent

Parameters:
    _weapons - Array of weapopns. [Array]
    _itemType_ammo_usageAllowed - Weapons allowed filter: array of item type ("AssaultRifle", "MissileLauncher"...), allowed ammo usage ("128 + 512": ammo against vehicles and armored vehicles) and array to check if weapons are parent to a parent. [Array]

Returns:
    Array of selected weapons

Examples:
    (begin example)
        _weapons_selected = [["launch_RPG7_F"], ["MissileLauncher", "256", []]] call btc_fnc_arsenal_ammoUsage;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_weapons", ["launch_RPG7_F"], [[]]],
    ["_itemType_ammo_usageAllowed", ["MissileLauncher", "256", []], [[]]]
];
_itemType_ammo_usageAllowed params [["_itemType", "MissileLauncher", [""]], ["_ammo_usageAllowed", "256", [""]], ["_parent_array", [], [[]]]];

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgAmmo = configFile >> "CfgAmmo";

_weapons select {
    private _weapon = _x;
    private _magazines = getArray (_cfgWeapons >> _weapon >> "magazines");

    private _isAllowed = if (_ammo_usageAllowed isEqualTo "") then {
        true
    } else {
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
                [format ["Weapons: %1 AiAmmoUsage Magazines: %2", _weapon, _aiAmmoUsage_magazines], __FILE__, [false]] call btc_fnc_debug_message;
            };
        };

        _ammo_usageAllowed in _aiAmmoUsage_magazines
    };

    private _isParent = if (_parent_array isEqualTo []) then {
        true
    } else {
        _parent_array params ["_not", "_parent_type"];
        if (_not) then {
            _weapon isKindOf [_parent_type, _cfgWeapons]
        } else {
            !(_weapon isKindOf [_parent_type, _cfgWeapons])
        };
    };

    (_itemType in (_weapon call BIS_fnc_itemType)) && {_isAllowed} && {_isParent}
};
