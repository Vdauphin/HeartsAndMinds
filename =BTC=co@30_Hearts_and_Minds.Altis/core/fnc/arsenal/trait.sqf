
/* ----------------------------------------------------------------------------
Function: btc_fnc_arsenal_trait

Description:
    Get trait from an object (e.g. Player) and return the corresponding trait and weapons allowed filter (https://community.bistudio.com/wiki/CfgAmmo_Config_Reference#aiAmmoUsageFlags).

Parameters:
    _player - Object use to determine the trait and the weapons allowed filter accordingly to the trait. [Object]

Returns:
    _type_ammoUsageAllowed = trait and array of weapons allowed filter: array of item type ("AssaultRifle", "MissileLauncher"...), allowed ammo usage ("128 + 512": ammo against vehicles and armored vehicles) and array to check if weapons are parent to a parent.

Examples:
    (begin example)
        _type_ammoUsageAllowed = [player] call btc_fnc_arsenal_trait;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

private _type_ammoUsageAllowed = [];
switch (true) do {
    case (_player getUnitTrait "medic"): {
        _type_ammoUsageAllowed = [1, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]]]];
    };
    case (_player getVariable ["ace_isEngineer", 0] in [1, 2]): {
        _type_ammoUsageAllowed = [2, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]]]];
    };
    case (_player getUnitTrait "explosiveSpecialist"): {
        _type_ammoUsageAllowed = [3, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]]]];
    };
    case ([typeOf _player, ["MissileLauncher", "128 + 512"]] call btc_fnc_mil_ammoUsage): {
        _type_ammoUsageAllowed = [4, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]], ["RocketLauncher", ""], ["MissileLauncher", "128 + 512"]]];
    };
    case ([typeOf _player, ["MissileLauncher", "256"]] call btc_fnc_mil_ammoUsage): {
        _type_ammoUsageAllowed = [5, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]], ["MissileLauncher", "256"]]];
    };
    case ([typeOf _player, ["SniperRifle", ""]] call btc_fnc_mil_ammoUsage): {
        _type_ammoUsageAllowed = [6, [["AssaultRifle", "64 + 128 + 256", [true, "Rifle_Long_Base_F"]], ["SniperRifle", ""]]];
    };
    case ([typeOf _player, ["MachineGun", ""]] call btc_fnc_mil_ammoUsage): {
        _type_ammoUsageAllowed = [7, [["MachineGun", ""]]];
    };
    case ("cbrn" in toLower uniform _player): {
        _type_ammoUsageAllowed = [8, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]]]];
    };
    case (_player getUnitTrait "UAVHacker"): {
        _type_ammoUsageAllowed = [9, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]]]];
    };
    default {
        _type_ammoUsageAllowed = [0, [["AssaultRifle", "", [false, "Rifle_Long_Base_F"]], ["RocketLauncher", ""]]];
    };
};

if (btc_debug || btc_debug_log) then {
    [
        format ["IsMedic: %1 IsAdvEngineer: %2 IsExplosiveSpecialist: %3 IsAT: %4 IsAA: %5",
            _player getUnitTrait "medic",
            _player getVariable ["ace_isEngineer", 0],
            _player getUnitTrait "explosiveSpecialist",
            [typeOf _player, ["MissileLauncher", "128 + 512"]] call btc_fnc_mil_ammoUsage,
            [typeOf _player, ["MissileLauncher", "256"]] call btc_fnc_mil_ammoUsage
        ], __FILE__, [btc_debug, btc_debug_log]
    ] call btc_fnc_debug_message;
};

_type_ammoUsageAllowed
