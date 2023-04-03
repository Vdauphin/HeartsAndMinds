
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_hd

Description:
    Handle damage.

Parameters:
    _unit - Object to destroy. [Object]
    _part - Not use. [String]
    _dam - Amount of damage get by the object. [Number]
    _injurer - Not use. [Object]
    _ammo - Type of ammo use to make damage. [String]
    _hitIndex - Hit part index of the hit point, -1 otherwise. [Number]
    _instigator - Person who pulled the trigger. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, "body", 0.1, player] call btc_rep_fnc_hd;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if ((_this select 1) isEqualType []) exitWith {}; // Some agents return an array when tacking damage 

params [
    ["_unit", objNull, [objNull]],
    ["_part", "", [""]],
    ["_dam", 0, [0]],
    ["_injurer", objNull, [objNull]],
    ["_ammo", "", [""]],
    ["_hitIndex", 0, [0]], 
    ["_instigator", objNull, [objNull]]
];

if (!isPlayer _instigator || {_dam <= 0.05}) exitWith {_dam};
private _isAgent = isAgent teamMember _unit;
if (
    !_isAgent && {
        _part isEqualTo "" ||
        {side group _unit isNotEqualTo civilian}
    }
) exitWith {_dam};

if !(isServer) exitWith {
    _this remoteExecCall ["btc_rep_fnc_hd", 2];
    _dam
};

[
    [btc_rep_malus_civ_hd, btc_rep_malus_animal_hd] select _isAgent,
    _instigator
] call btc_rep_fnc_change;
if (btc_global_reputation < btc_rep_level_normal + 100) then {[getPos _unit] call btc_rep_fnc_eh_effects;};

if (btc_debug_log) then {
    [format ["REP HD = GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call btc_debug_fnc_message;
};

_dam
