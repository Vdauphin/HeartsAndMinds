
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_notify

Description:
    Show reputation change with a picture and color nuance.

Parameters:
    _reputation - Reputation number. [Number]
    _players - List of players triggered the reputation change. [Array]

Returns:

Examples:
    (begin example)
        [-10] call btc_rep_fnc_notify;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_reputation", 0, [0]],
    ["_players", [], [[]]]
];

_players sort (_reputation <= 0);
private _player = _players select 0 select 1;

private _hint = [];
if (_reputation >= 0) then {
    private _minRep = _reputation min 80;

    _hint pushBack 20;
    _hint pushBack [[1 - _minRep / 80, 1, 1 - _minRep / 80], _player];
} else {
    private _minRep = _reputation max -25;

    _hint pushBack 21;
    _hint pushBack [[1, 1 + _minRep / 25, 1 + _minRep / 25], _player];
};

_hint remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];

btc_rep_delayed = [0, []];
