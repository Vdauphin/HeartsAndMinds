
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_change

Description:
    Change reputation level.

Parameters:
    _reputation - Number to add or substrat to the reputation level. [Number]
    _player - Player triggered the reputation change. [Number]

Returns:

Examples:
    (begin example)
        [-10, player] call btc_rep_fnc_change;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_reputation", 0, [0]],
    ["_player", objNull, [objNull]]
];

if (btc_debug || btc_debug_log) then {
    [format ["GLOBAL %1 - CHANGE %2 - %3", btc_global_reputation, _reputation, name _player], __FILE__, [btc_debug, btc_debug_log, true]] call btc_debug_fnc_message;
};

btc_global_reputation = btc_global_reputation + _reputation;

if (btc_p_rep_notify >= 0) then {
    if ((btc_rep_delayed select 1) isEqualTo []) then {
        [{
            [{
                abs(btc_rep_delayed select 0) > btc_p_rep_notify
            }, {
                btc_rep_delayed call btc_rep_fnc_notify;
            }, [], 10 * 60, {
                btc_rep_delayed call btc_rep_fnc_notify;
            }] call CBA_fnc_waitUntilAndExecute;
        }, [], 0.5] call CBA_fnc_waitAndExecute;
    };
    btc_rep_delayed set [0, (btc_rep_delayed select 0) + _reputation];
    (btc_rep_delayed select 1) pushBack [_reputation, _player];
};

true
