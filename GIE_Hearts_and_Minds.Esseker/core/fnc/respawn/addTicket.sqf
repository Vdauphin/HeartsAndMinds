
/* ----------------------------------------------------------------------------
Function: btc_respawn_fnc_addTicket

Description:
    Add respawn tickets to a player or a side.

Parameters:
    _player - Player or side. [Object, Side]
    _ticket - Value to add. [Number]
    _uid - Player UID or side use as key. [String, Side]

Returns:

Examples:
    (begin example)
        [cursorObject, 1, getPlayerUID cursorObject] remoteExecCall ["btc_respawn_fnc_addTicket", 2];
    (end)
    (begin example)
        [player, 1, getPlayerUID player] remoteExecCall ["btc_respawn_fnc_addTicket", 2];
    (end)
    (begin example)
        [btc_player_side, 1, btc_player_side] remoteExecCall ["btc_respawn_fnc_addTicket", 2];
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull, west]],
    ["_ticket", 0, [0]],
    ["_uid", "", ["", west]]
];

if (_player isNotEqualTo objNull) then {
    private _ticketValue = [_player, _ticket] call BIS_fnc_respawnTickets;
    [24, _ticketValue] remoteExecCall ["btc_fnc_show_hint", _player];

    if (btc_debug_log) then {
        [format ["_ticketValue %1 _ticket %2 _uid %3", _ticketValue, _ticket, _uid], __FILE__, [false]] call btc_debug_fnc_message;
    };
};

private _ticketValue = _ticket + (btc_respawn_tickets getOrDefault [_uid, btc_p_respawn_ticketsAtStart]);
btc_respawn_tickets set [_uid, _ticketValue];
