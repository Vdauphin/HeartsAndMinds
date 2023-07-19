
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_bagRecover_s

Description:
    Add respawn tickets when a body bag or an alive enemy is provided.

Parameters:
    _bodyBag - Body bag or alive enemy. [Object]
    _player - Player interacting. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] remoteExecCall ["btc_body_fnc_bagRecover_s", 2];
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_bodyBag", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

private _ticket = 0;
private _UID = _bodyBag getVariable ["btc_UID", ""];
private _players = [];
if (_UID isEqualTo "") then {
    if (alive _bodyBag && _bodyBag isKindOf "CAManBase") then {
        _ticket = btc_body_prisonerTicket;

        switch (btc_p_respawn_ticketsFromPrisoners) do { 
            case 1 : {
                _players = allPlayers select {side group _x isEqualTo btc_player_side};
            }; 
            case 2 : {
                _players = [_player];
            }; 
            case 3 : {
                _players = allPlayers select {side group _x isEqualTo btc_player_side};
                private _index = _players findIf {[_x] call BIS_fnc_respawnTickets isEqualTo 0};
                if (_index isEqualTo -1) then {
                    _players = [];
                } else {
                    _players = [_players select _index];
                };
            }; 
            case 4 : {
                _players = allPlayers select {side group _x isEqualTo btc_player_side};
                private _tickets = _players apply {[[_x] call BIS_fnc_respawnTickets, _x]};
                _tickets sort true;
                _players = [_tickets select 0 select 1];
            }; 
            default {}; 
        };
    };
} else {
    _ticket = btc_body_bagTicketPlayer;
};

if (_ticket isEqualTo 0) exitWith {
    [23] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
};
if (_UID isEqualTo "" && _players isEqualTo []) exitWith {
    [25] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
};
[22] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];

if (btc_p_respawn_ticketsShare) then {
    [btc_player_side, _ticket, btc_player_side] call btc_respawn_fnc_addTicket;
} else {
    if (_UID isEqualTo "") then {
        {
            [_x, _ticket, getPlayerUID _x] call btc_respawn_fnc_addTicket;
        } forEach _players;
    } else {
        private _player = _UID call BIS_fnc_getUnitByUID;
        [_player, _ticket, _UID] call btc_respawn_fnc_addTicket;
    };
};

deleteMarker (_bodyBag getVariable ["btc_body_deadMarker", ""]);
_bodyBag call CBA_fnc_deleteEntity;
