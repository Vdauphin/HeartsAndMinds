
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
private _UID = _bodyBag getVariable ["btc_UID", ""];
if (_UID isNotEqualTo "") then {
    _ticket = btc_body_bagTicketPlayer;
} else {
    if (alive _bodyBag && _bodyBag isKindOf "CAManBase") then {
        _ticket = btc_body_enemyTicket;
    };  
};

if (_ticket isEqualTo 0) exitWith {
    [23] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
};
[22] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];

if (btc_p_respawn_ticketsShare) then {
    [btc_player_side, _ticket] call btc_respawn_fnc_addTicket;
} else {
    if (_UID isNotEqualTo "") then {
        private _player = _UID call BIS_fnc_getUnitByUID;
        [_player, _ticket, _UID] call btc_respawn_fnc_addTicket;
    } else {
        private _players = (units btc_player_side) select {isPlayer _x};
        {
            [_x, _ticket, getPlayerUID _x] call btc_respawn_fnc_addTicket;
        } forEach _players;
    };
};

deleteMarker (_bodyBag getVariable ["btc_body_deadMarker", ""]);
_bodyBag call CBA_fnc_deleteEntity;
