
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_screen

Description:
    If no tickets force the player to respawn and allow the use of spectator mode.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_screen;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (btc_p_respawn_ticketsAtStart isEqualTo -1) exitWith {};

if ([btc_player_side] call BIS_fnc_respawnTickets isEqualTo 0) then {
    [
        {scriptDone btc_intro_done},
        btc_respawn_fnc_force
    ] call CBA_fnc_waitUntilAndExecute;
};

if !(btc_p_respawn_ticketsShare) then {
    [
        {[player] call BIS_fnc_respawnTickets isNotEqualTo -1},
        {
            if (btc_debug_log) then {
                [format ["_respawnTickets %1", [player] call BIS_fnc_respawnTickets], __FILE__, [false]] call btc_debug_fnc_message;
            };

            if ([player] call BIS_fnc_respawnTickets > 0) exitWith {};
            [
                {scriptDone btc_intro_done},
                btc_respawn_fnc_force
            ] call CBA_fnc_waitUntilAndExecute;
        }
    ] call CBA_fnc_waitUntilAndExecute;
};
