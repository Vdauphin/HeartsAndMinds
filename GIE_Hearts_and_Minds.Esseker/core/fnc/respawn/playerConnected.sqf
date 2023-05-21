
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_playerConnected

Description:
    Send the number of respawn tickets to a player during connection.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_respawn_fnc_playerConnected;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_player", "_info"];
_info params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

private _tickets = btc_respawn_tickets getOrDefault [_uid, btc_p_respawn_ticketsAtStart];
if (_tickets isEqualTo 0) then {
    _tickets = -1;
};
private _respawnTickets = [_player, _tickets] call BIS_fnc_respawnTickets;

if (btc_debug_log) then {
    [format ["_respawnTickets %1 _tickets %2 _uid %3", _respawnTickets, _tickets, _uid], __FILE__, [false]] call btc_debug_fnc_message;
};

_respawnTickets
