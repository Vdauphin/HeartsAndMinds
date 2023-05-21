
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_suppressed

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
        [cursorObject, objNull, player distance cursorObject, "", "", "", "", player] call btc_rep_fnc_suppressed;
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

if (_civ getVariable ["btc_rep_fnc_suppressed_fired", false] isEqualTo 2) exitWith {};
if (_ammoObject isKindOf "SmokeShell") exitWith {};
if (side group _civ isNotEqualTo civilian) exitWith {_civ setVariable ["btc_rep_fnc_suppressed_fired", 2]};

if (
    _civ getVariable ["btc_rep_fnc_suppressed_fired", 0] isEqualTo 0 &&
    {random 3 < 1}
) then {
    _civ setVariable ["btc_rep_fnc_suppressed_fired", 1];
    [_civ, selectRandom ["ApanPknlMstpSnonWnonDnon_G01", "ApanPknlMstpSnonWnonDnon_G02", "ApanPknlMstpSnonWnonDnon_G03", "ApanPpneMstpSnonWnonDnon_G01", "ApanPpneMstpSnonWnonDnon_G02", "ApanPpneMstpSnonWnonDnon_G03"], 1] call ace_common_fnc_doAnimation;
};

if (
    _distance < 2 &&
    {side group _instigator isEqualTo btc_player_side} &&
    {(_shooter findNearestEnemy _civ) distance _civ > 200} &&
    {abs((_shooter getDir _civ) - getDir _shooter) < 150/(_shooter distance _civ)}
) then {
    if (isServer)  then {
        [btc_rep_malus_civ_suppressed, _shooter] call btc_rep_fnc_change;
        [getPos _civ] call btc_rep_fnc_eh_effects;
    } else {
        [btc_rep_malus_civ_suppressed, _shooter] remoteExecCall ["btc_rep_fnc_change", 2];
        [getPos _civ] remoteExecCall ["btc_rep_fnc_eh_effects", 2];
    };

    if (btc_debug_log) then {
        [format ["GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call btc_debug_fnc_message;
    };
};
