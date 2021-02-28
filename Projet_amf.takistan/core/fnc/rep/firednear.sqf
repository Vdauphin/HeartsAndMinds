
/* ----------------------------------------------------------------------------
Function: btc_fnc_rep_firednear

Description:
    Detect if player is firing. Then add a random panic animation. If player fire in direction of a civilian without enemies around, punish him by applying reputation effect and reduce reputation.

Parameters:
    _civ - Unit. [Object]
    _vehicle - Not used. [Object]
    _distance - Distance of firing. [Number]
    _weapon - Not used. [String]
    _muzzle - Not used. [String]
    _mode - Not used. [String]
    _ammo - Type of ammo. [String]
    _gunner - Unit firing around. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, objNull, player distance cursorObject, "", "", "", "", player] call btc_fnc_rep_firednear;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_civ", objNull, [objNull]],
    ["_vehicle", objNull, [objNull]],
    ["_distance", 0, [0]],
    ["_weapon", "", [""]],
    ["_muzzle", "", [""]],
    ["_mode", "", [""]],
    ["_ammo", "", [""]],
    ["_gunner", objNull, [objNull]]
];

if (_ammo isKindOf "SmokeShell") exitWith {};

//Remove the eventHandler to prevent spamming
[_civ, "FiredNear", "btc_fnc_rep_firednear"] call btc_fnc_eh_removePersistOnLocalityChange;

if (!(side _civ isEqualTo civilian) || (random 3 < 1)) exitWith {};

[_civ, selectRandom ["ApanPknlMstpSnonWnonDnon_G01", "ApanPknlMstpSnonWnonDnon_G02", "ApanPknlMstpSnonWnonDnon_G03", "ApanPpneMstpSnonWnonDnon_G01", "ApanPpneMstpSnonWnonDnon_G02", "ApanPpneMstpSnonWnonDnon_G03"], 1] call ace_common_fnc_doAnimation;

if (side _gunner isEqualTo btc_player_side) then {
    if ((_gunner findNearestEnemy getPos _civ) distance _civ > 300)  then {
        if (abs((_gunner getDir _civ) - getDir _gunner) < 300/_distance) then {
            btc_rep_malus_civ_firenear call btc_fnc_rep_change;
            [getPos _civ] call btc_fnc_rep_eh_effects;

            if (btc_debug_log) then {
                [format ["GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call btc_fnc_debug_message;
            };
        };
    };
};
