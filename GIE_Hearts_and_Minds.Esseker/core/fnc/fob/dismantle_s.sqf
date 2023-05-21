
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_dismantle_s

Description:
    Dismantle server side the FOB.

Parameters:
    _flag - Flag of the FOB. [Object]

Returns:

Examples:
    (begin example)
        [cursorTarget] call btc_fob_fnc_dismantle_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_flag", objNull, [objNull]]
];

[18] remoteExecCall ["btc_fnc_show_hint", (allPlayers - entities "HeadlessClient_F") inAreaArray [getPosASL _flag, 10, 10]];

[{
    params ["_flag"];

    private _pos = getPosASL _flag;
    private _element = (btc_fobs select 2) find _flag;

    [(btc_fobs select 1) select _element, objNull, objNull, true, true] call btc_fob_fnc_killed;

    [btc_fob_mat, _pos, surfaceNormal _pos] call btc_log_fnc_create_s;
}, [_flag], 10] call CBA_fnc_waitAndExecute;
