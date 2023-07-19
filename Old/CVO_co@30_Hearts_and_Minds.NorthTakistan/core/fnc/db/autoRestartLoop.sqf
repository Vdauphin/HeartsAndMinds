
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_autoRestartLoop

Description:
    Start loop until restart.

Parameters:

Returns:

Examples:
    (begin example)
        [] call btc_db_fnc_autoRestartLoop;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if (btc_p_db_autoRestartTime > 0) then {
    [{
        [19, btc_db_warningTimeAutoRestart] remoteExecCall ["btc_fnc_show_hint", [0, -2] select isDedicated];
        [btc_db_fnc_autoRestart, [], btc_db_warningTimeAutoRestart * 60] call CBA_fnc_waitAndExecute;
    }, [], btc_p_db_autoRestartTime * 60 * 60 - btc_db_warningTimeAutoRestart * 60] call CBA_fnc_waitAndExecute;
};

btc_p_db_autoRestartHour = btc_p_db_autoRestartHour - [-1];
if (btc_p_db_autoRestartHour isNotEqualTo []) then {
    [{
        [{systemTime select 3 in btc_p_db_autoRestartHour}, btc_db_fnc_autoRestart] call CBA_fnc_waitUntilAndExecute;
    }, [], 1 * (60 - (systemTime select 4)) * 60] call CBA_fnc_waitAndExecute;
};
