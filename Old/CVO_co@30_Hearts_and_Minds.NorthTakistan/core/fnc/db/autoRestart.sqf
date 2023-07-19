
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_autoRestart

Description:
    Save or not and restart/shutdown server.

Parameters:
    _p_autoRestartType - 0: "Off", 1: "Restart", 2: "Shutdown", 3: "Save and restart", 4: "Save and shutdown". [Number]
    _serverCommandPassword - Password defined in server.cfg. [String]

Returns:

Examples:
    (begin example)
        [4] call btc_db_fnc_autoRestart;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_p_autoRestartType", btc_p_db_autoRestartType, [0]],
    ["_serverCommandPassword", btc_db_serverCommandPassword, ""]
];

private _serverCommand = if (_p_autoRestartType in [1, 3]) then {
    "#restartserver"
} else {
    "#shutdown"
};

if (_p_autoRestartType > 2) then {
    [] call btc_db_fnc_save;
};

if !(_serverCommandPassword serverCommand _serverCommand) then {
    ["Invalid password", __FILE__, [true, true, true]] call btc_debug_fnc_message;
};
