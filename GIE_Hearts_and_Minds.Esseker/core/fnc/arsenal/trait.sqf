
/* ----------------------------------------------------------------------------
Function: btc_arsenal_fnc_trait

Description:
    Get trait from an object (e.g. Player) and return the corresponding trait and weapons allowed filter (https://community.bistudio.com/wiki/CfgAmmo_Config_Reference#aiAmmoUsageFlags).

Parameters:
    _player - Object use to determine the trait and the weapons allowed filter accordingly to the trait. [Object]

Returns:
    _type_ammoUsageAllowed = trait and array of weapons allowed filter: array of item type ("AssaultRifle", "MissileLauncher"...), allowed ammo usage ("128 + 512": ammo against vehicles and armored vehicles).

Examples:
    (begin example)
        _type_ammoUsageAllowed = [player] call btc_arsenal_fnc_trait;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

switch (true) do {
    case (_player getUnitTrait "medic"): {
        [1, [["AssaultRifle"]]]
    };
    case (_player getVariable ["ace_isEngineer", 0] in [1, 2]): {
        [2, [["AssaultRifle"]]]
    };
    case (_player getUnitTrait "explosiveSpecialist"): {
        [3, [["AssaultRifle"]]]
    };
    case ([typeOf _player, ["MissileLauncher", "128 + 512"]] call btc_mil_fnc_ammoUsage): {
        [4, [["AssaultRifle"], ["RocketLauncher"], ["MissileLauncher", "128 + 512"]]]
    };
    case ([typeOf _player, ["MissileLauncher", "256"]] call btc_mil_fnc_ammoUsage): {
        [5, [["AssaultRifle"], ["MissileLauncher", "256"]]]
    };
    case ([typeOf _player, ["SniperRifle"]] call btc_mil_fnc_ammoUsage): {
        [6, [["SniperRifle"]]]
    };
    case ([typeOf _player, ["MachineGun"]] call btc_mil_fnc_ammoUsage): {
        [7, [["MachineGun"]]]
    };
    case ("cbrn" in toLower uniform _player): {
        [8, [["AssaultRifle"]]]
    };
    case (_player getUnitTrait "UAVHacker"): {
        [9, [["AssaultRifle"]]]
    };
    default {
        [0, [["AssaultRifle"], ["RocketLauncher"]]]
    };
};
