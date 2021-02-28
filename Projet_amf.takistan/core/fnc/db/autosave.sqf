
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_autosave

Description:
    Save game when all players disconnected.

Parameters:

Returns:
    _this - Passed arguments. [Array]

Examples:
    (begin example)
        [] call btc_fnc_db_autosave;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if ((allPlayers - entities "HeadlessClient_F") isEqualTo []) then {
    removeMissionEventHandler ["HandleDisconnect", _thisEventHandler];
    [] spawn {
        [] call btc_fnc_db_save;
        addMissionEventHandler ["HandleDisconnect", btc_fnc_db_autosave];
    };
};

_this
