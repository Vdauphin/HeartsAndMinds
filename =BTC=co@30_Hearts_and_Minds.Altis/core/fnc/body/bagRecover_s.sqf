
/* ----------------------------------------------------------------------------
Function: btc_body_fnc_bagRecover_s

Description:
    Add respawn tickets when a body bag or an alive enemy is provided.

Parameters:
    _bodyBag - Body bag or alive enemy. [Object]

Returns:

Examples:
    (begin example)
        cursorObject remoteExecCall ["btc_body_fnc_bagRecover_s", 2];
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_bodyBag", objNull, [objNull]]
];

private _ticket = 0;
if (_bodyBag getVariable ["btc_isDeadPlayer", false]) then {
    _ticket = btc_body_bagTicketPlayer;
};
if (_bodyBag isKindOf "CAManBase") then {
    _ticket = btc_body_enemyTicket;
};

if (_ticket isEqualTo 0) exitWith {
    [23] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
};
[22] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];

if (btc_p_respawn_ticketsShare) then {
    [btc_player_side, _ticket] call btc_respawn_fnc_addTicket;
} else {
    if (_bodyBag isKindOf "ACE_bodyBagObject") then {
        private _uid = _bodyBag getVariable ["btc_UID", ""];
        private _player = _uid call BIS_fnc_getUnitByUID;
        [_player, _ticket, _uid] call btc_respawn_fnc_addTicket;
    } else {
        private _players = (units btc_player_side) select {isPlayer _x};
        {
            [_x, _ticket, getPlayerUID _x] call btc_respawn_fnc_addTicket;
        } forEach _players;
    };
};

_bodyBag call CBA_fnc_deleteEntity;
