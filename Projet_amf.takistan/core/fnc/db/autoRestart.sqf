
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_autoRestart

Description:
    Save or not and restart/shutdown server.

Parameters:
    _p_autoRestart - 0: "Off", 1: "Restart", 2: "Shutdown", 3: "Save and restart", 4: "Save and shutdown". [Number]
    _serverCommandPassword - Password defined in server.cfg. [String]

Returns:

Examples:
    (begin example)
        [4] call btc_fnc_db_autoRestart;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_p_autoRestart", btc_p_db_autoRestart, [0]],
    ["_serverCommandPassword", btc_db_serverCommandPassword, ""]
];

if (_p_autoRestart isEqualTo 0) exitWith {};

private _serverCommand = if (_p_autoRestart in [1, 3]) then {
    "#restartserver"
} else {
    "#shutdown"
};

if (_p_autoRestart > 2) then {
    [] call btc_fnc_db_save;
};

if !(_serverCommandPassword serverCommand _serverCommand) then {
    ["Invalid password", __FILE__, [true, true, true]] call btc_fnc_debug_message;
};
