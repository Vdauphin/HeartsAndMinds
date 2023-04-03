
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_eh_effects

Description:
    Add effects when player do bad things (call militia, take weapons/grenade).

Parameters:
    _pos - Position where bad stuff happened. [Array]

Returns:

Examples:
    (begin example)
        [getPos player] call btc_rep_fnc_eh_effects;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if (btc_global_reputation >= btc_rep_level_normal + 100) exitWith {};

params [
    ["_pos", [0, 0, 0], [[]]]
];

private _rep = (btc_global_reputation / 100);
private _random = random (10 - _rep);

if (_random <= 3) exitWith {};

if (time > (btc_rep_militia_called + btc_rep_militia_call_time)) then {
    if (_random > 3) then { //CALL MILITIA
        [_pos] call btc_rep_fnc_call_militia;
    };
};
if (btc_global_reputation < (btc_rep_level_low + 100)) then {
    if (_random > 4) then { //GET WEAPONS
        [btc_civ_fnc_get_weapons, [_pos, 300], 5] call CBA_fnc_waitAndExecute;
    };
} else {
    if (_random > 1) then { //GET GRENADE
        [btc_civ_fnc_get_grenade, [_pos, 300], 5] call CBA_fnc_waitAndExecute;
    };
};

if (btc_debug_log) then {
    [format ["REP = %1 - RANDOM = %2 - RINF TIME = %3 - MILITIA/WEAPONS = %4/%5", _rep, _random, time > (btc_rep_militia_called + btc_rep_militia_call_time), _random > 3, _random > 4], __FILE__, [false]] call btc_debug_fnc_message;
};
