
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_player

Description:
    Process dead body, save new respawn tickets player and show KIA marker.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_player;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_unit", "_player"];

_unit setVariable ["btc_dont_delete", true];
btc_body_deadPlayers pushBack _unit;
_unit setVariable ["btc_UID", getPlayerUID _player];

if (btc_p_respawn_ticketsShare) then {
    btc_respawn_tickets set [btc_player_side, [btc_player_side] call BIS_fnc_respawnTickets];
} else {
    btc_respawn_tickets set [getPlayerUID _player, [_player] call BIS_fnc_respawnTickets];
};

if (btc_p_body_timeBeforeShowMarker < 0) exitwith {};
[btc_body_fnc_createMarker, _unit, btc_p_body_timeBeforeShowMarker] call CBA_fnc_waitAndExecute;
