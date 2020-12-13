
/* ----------------------------------------------------------------------------
Function: btc_fnc_rep_suppressed

Description:
    Detect if player is firing. Then add a random panic animation. If player fire in direction of a civilian without enemies around, punish him by applying reputation effect and reduce reputation.

Parameters:
    _unit - Unit to which the event is assigned [Object]
    _distance - Distance of the projectile pass-by [Number]
    _shooter - Who (or what) fired - vehicle or drone [Object]
    _instigator - Who pressed the trigger. [Object]
    _ammoObject - The ammunition itself [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, objNull, player distance cursorObject, "", "", "", "", player] call btc_fnc_rep_suppressed;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_civ", objNull, [objNull]],
    ["_distance", 0, [0]],
    ["_shooter", objNull, [objNull]],
    ["_instigator", objNull, [objNull]],
    ["_ammoObject", objNull, [objNull]]
];

if (_ammoObject isKindOf "SmokeShell") exitWith {};

_civ removeEventHandler ["Suppressed", _thisEventHandler];

if (!(side group _civ isEqualTo civilian) || (random 3 < 1)) exitWith {};

[_civ, selectRandom ["ApanPknlMstpSnonWnonDnon_G01", "ApanPknlMstpSnonWnonDnon_G02", "ApanPknlMstpSnonWnonDnon_G03", "ApanPpneMstpSnonWnonDnon_G01", "ApanPpneMstpSnonWnonDnon_G02", "ApanPpneMstpSnonWnonDnon_G03"], 1] call ace_common_fnc_doAnimation;

if (side group _instigator isEqualTo btc_player_side) then {
    if ((_shooter findNearestEnemy _civ) distance _civ > 300)  then {
        if (abs((_shooter getDir _civ) - getDir _shooter) < 300/_distance) then {
            [btc_rep_malus_civ_suppressed, _shooter] call btc_fnc_rep_change;
            [getPos _civ] call btc_fnc_rep_eh_effects;

            if (btc_debug_log) then {
                [format ["GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call btc_fnc_debug_message;
            };
        };
    };
};