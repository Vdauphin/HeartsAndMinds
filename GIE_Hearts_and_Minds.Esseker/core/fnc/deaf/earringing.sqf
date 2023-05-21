
/* ----------------------------------------------------------------------------
Function: btc_deaf_fnc_earringing

Description:
    Create earringing to all player in a radius of 100m.

Parameters:
    _pos - Sound position source. [Array]

Returns:

Examples:
    (begin example)
        [getPos (allPlayers select 0)] call btc_deaf_fnc_earringing;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]]
];

private _players_close = allPlayers inAreaArray [_pos, 100, 100];
[20] remoteExecCall ["ace_hearing_fnc_earRinging", _players_close];
